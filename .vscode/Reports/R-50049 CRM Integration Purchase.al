report 50049 "CRM Integration Purchase"
{
    ProcessingOnly = true;
    UseRequestPage = false;
    ApplicationArea = FixedAsset;

    dataset
    {
        dataitem("CRM Integration Purchase"; "CRM Integration Purchase")
        {
            DataItemTableView = SORTING("Vendor No.", "Vendor Invoice No", "Vendor Part Code", "No.")
                                ORDER(Ascending)
                                WHERE("Order Created" = CONST(False));

            trigger OnAfterGetRecord()
            begin
                CurrCRM := "CRM Integration Purchase"."Vendor Invoice No";
                IF PrevCRM <> CurrCRM THEN BEGIN

                    PrevCRM := "CRM Integration Purchase"."Vendor Invoice No";
                    /*    RecCRMInt1.RESET;
                        RecCRMInt1.SETRANGE(RecCRMInt1."Vendor Invoice No","CRM Integration Purchase"."Vendor Invoice No");
                        RecCRMInt1.SETRANGE(RecCRMInt1."Order Created", TRUE);
                        IF RecCRMInt1.FINDFIRST THEN BEGIN
                           IF RecCRMInt1."Order Posted"=TRUE THEN
                             "CRM Integration Purchase"."Order Posted":=TRUE;
                           "CRM Integration Purchase"."Order Created":=TRUE;
                           "CRM Integration Purchase".MODIFY;
                        END;  */

                    CreatePurchaseOrder;
                END ELSE BEGIN
                    "CRM Integration Purchase"."Order Posted" := TRUE;
                    "CRM Integration Purchase"."Order Created" := TRUE;
                    "CRM Integration Purchase".MODIFY;
                    CurrReport.SKIP;
                END;

            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        qty: Decimal;
        recPurchLine1: record 39;
        POfrom: page "Purchase Order Subform";

        RecPL1: RECORD 39;
        RecLoc: Record 14;
        PurchPost: Codeunit 90;
        RecCRMInt: Record 50017;
        RecGenJnlLine: Record 81;
        LineNo1: Integer;
        GenJnlPostLine: Codeunit 12;
        DoucNo: Code[20];
        NoSeriesMgt: Codeunit 396;
        SRsetup: Record 312;
        CurrCRM: Code[20];
        PrevCRM: Code[20];
        RecVend: Record 23;
        taxamt: Decimal;
        RecItem: Record 27;
        RecILE: Record 32;
        RecCRMInt1: Record 50017;
        PurchCommentLine: Record 43;
        recPurchLine: Record 39;
        CalculateTax: Codeunit "Calculate Tax";


    procedure CreatePurchaseOrder()
    var
        NodeName: Text;
        FilePath: Text;
        NoSeriesMgt: Codeunit 396;
        SRsetup: Record 312;
        RecPH: Record 38;
        SO_No: Code[20];
        line_no: Integer;
        RecLocation: Record 14;
        Output_File_Path: Text;
        RecPL: Record 39;
        cnt: Integer;
        i: Integer;
        RecItem: Record 27;
        LocationShipTo: Record Location;
        DimSetID: Integer;
    begin
        IF NOT "CRM Integration Purchase"."Order Created" THEN BEGIN

            CLEAR(taxamt);
            RecVend.RESET;
            RecVend.SETRANGE("Phone No.", "CRM Integration Purchase"."Mobile No.");
            IF RecVend.FINDFIRST THEN BEGIN
                //Sales Header Insert
                SRsetup.GET;
                RecPH.INIT;
                CLEAR(SO_No);
                IF "CRM Integration Purchase"."Document Type" = "CRM Integration Purchase"."Document Type"::Order THEN
                    SO_No := NoSeriesMgt.GetNextNo(SRsetup."Order Nos.", WORKDATE, TRUE);
                IF "CRM Integration Purchase"."Document Type" = "CRM Integration Purchase"."Document Type"::Invoice THEN
                    SO_No := NoSeriesMgt.GetNextNo(SRsetup."Invoice Nos.", WORKDATE, TRUE);
                IF "CRM Integration Purchase"."Document Type" = "CRM Integration Purchase"."Document Type"::"Credit Memo" THEN
                    SO_No := NoSeriesMgt.GetNextNo(SRsetup."Credit Memo Nos.", WORKDATE, TRUE);

                RecPH."No." := SO_No;
                //   RecPH.CRM := TRUE;
                // RecPH."Document Type":=RecPH."Document Type"::Order;
                RecPH."Document Type" := "CRM Integration Purchase"."Document Type";
                RecPH.VALIDATE(RecPH."Buy-from Vendor No.", RecVend."No.");
                RecPH.VALIDATE("Pay-to Vendor No.", RecVend."No.");
                // RecPH.VALIDATE("Salesperson Code",'AH');
                RecPH.INSERT(TRUE);
                RecPH.SetHideValidationDialog(true);
                RecPH.VALIDATE("Shortcut Dimension 1 Code", "CRM Integration Purchase"."Shortcut Dimension 1 Code");
                RecPH.VALIDATE("Shortcut Dimension 2 Code", "CRM Integration Purchase"."Shortcut Dimension 2 Code");
                DimSetID := RecPH."Dimension Set ID";
                RecPH.VALIDATE("Location Code", "CRM Integration Purchase"."Location Code");
                LocationShipTo.Get("CRM Integration Purchase"."Location Code");
                RecPH.Validate("Dimension Set ID", DimSetID);
                // RecPH."Ship-to Address" := LocationShipTo.Address;
                // RecPH."Ship-to Address 2" := LocationShipTo."Address 2";
                // RecPH."Ship-to City" := LocationShipTo.City;
                // RecPH."Ship-to Post Code" := LocationShipTo."Post Code";
                // RecPH.VALIDATE(Structure, "CRM Integration Purchase".Structure);
                RecPH."Vendor Invoice No." := "CRM Integration Purchase"."Vendor Invoice No";
                // RecPH."Nature of Supply":="CRM Integration Purchase"."Nature of Supply";
                RecPH."Posting Date" := "CRM Integration Purchase"."Posting Date";
                RecPH."Document Date" := "CRM Integration Purchase"."Posting Date";

                IF RecPH."Document Type" = RecPH."Document Type"::"Credit Memo" THEN BEGIN
                    RecPH.VALIDATE("Vendor Cr. Memo No.", "CRM Integration Purchase"."Vendor Cr. Memo No.");
                    RecPH.VALIDATE("Applies-to Doc. Type", "CRM Integration Purchase"."Apply to Document Type");
                    RecPH.VALIDATE("Applies-to Doc. No.", "CRM Integration Purchase"."Applies-to Doc. No.");
                END;

                RecPH."Due Date" := TODAY;



                RecPH.Modify();
                RecCRMInt.RESET;
                RecCRMInt.SETRANGE(RecCRMInt."Vendor Invoice No", PrevCRM);
                IF RecCRMInt.FINDSET THEN BEGIN
                    REPEAT
                        RecPL.INIT;
                        RecPL.VALIDATE("Document Type", RecCRMInt."Document Type");
                        RecPL.VALIDATE("Document No.", SO_No);
                        RecPL.VALIDATE("Buy-from Vendor No.", RecVend."No.");
                        RecPL.VALIDATE("Pay-to Vendor No.", RecVend."No.");

                        IF i = 0 THEN
                            line_no := 10000
                        ELSE
                            line_no := (i + 1) * 10000;
                        RecPL.VALIDATE("Line No.", line_no);
                        RecPL.VALIDATE(Type, RecCRMInt.Type);
                        RecPL.INSERT(TRUE);

                        // RecPL.RESET;
                        // RecPL.SETRANGE("Document No.", SO_No);
                        // RecPL.SETFILTER("Line No.", '%1', line_no);
                        // IF RecPL.FINDFIRST THEN BEGIN
                        RecPL1.RESET;
                        RecPL1.SETRANGE("Document No.", SO_No);
                        RecPL1.SETFILTER("Line No.", '%1', line_no);
                        IF RecPL1.FINDFIRST THEN BEGIN


                            CLEAR(RecItem."No.");
                            RecItem.RESET;
                            RecItem.SETRANGE(RecItem."Vendor Part Code Long", RecCRMInt."Vendor Part Code");
                            IF RecItem.FINDFIRST THEN BEGIN

                                IF RecPL1.Type = RecPL1.Type::Item THEN
                                    RecPL1.VALIDATE("No.", RecItem."No.");

                                //win316++
                                RecILE.RESET;
                                RecILE.SETRANGE("Document No.", "CRM Integration Purchase"."Applies-to Doc. No.");
                                RecILE.SETFILTER(Open, '%1', TRUE);
                                RecILE.SETFILTER(Positive, '%1', TRUE);
                                RecILE.SETFILTER("Location Code", '%1', "CRM Integration Purchase"."Location Code");
                                IF RecILE.FINDFIRST THEN
                                    RecPL1.VALIDATE("Appl.-to Item Entry", RecILE."Entry No.");
                                //win316--

                            END
                            ELSE
                                ERROR('item blank, vendor part code - %1', RecCRMInt."Vendor Part Code");


                            IF RecPL1.Type = RecPL.Type::"G/L Account" THEN
                                RecPL1.VALIDATE("No.", RecCRMInt."No.");

                            RecPL1.VALIDATE("Location Code", RecPH."Location Code");
                            RecPL1.VALIDATE(Quantity, RecCRMInt.Quantity);
                            RecPL1.VALIDATE("Direct Unit Cost", RecCRMInt."Unit Price With Tax");
                            RecPL1."GST Group Code" := RecCRMInt."GST Group Code";
                            //RecPL."Invoice Type":="CRM Integration Purchase"."Invoice Type";
                            RecPL1."HSN/SAC Code" := RecCRMInt."HSN/SAC Code";
                            IF RecPL1.Type = RecPL1.Type::"G/L Account" THEN

                                //NP3107
                            IF RecCRMInt."TDS Nature of Deduction" <> '' THEN begin
                                    RecPL1."TDS Section Code" := RecCRMInt."TDS Nature of Deduction";
                                    CalculateTax.CallTaxEngineOnPurchaseLine(RecPL1, RecPL1);
                                    RecPL1.Modify();
                                end;
                            if RecPL1."TDS Section Code" <> '' then
                                RecPL1.Validate("TDS Section Code");
                            // RecPL1.VALIDATE("TDS Section Code",'');


                            //NP3107

                            //  RecPL.VALIDATE("TDS Nature of Deduction",'CONT');
                            // RecPL.VALIDATE(Reserve,RecPL.Reserve::Always);
                            //RecPL.VALIDATE("Shortcut Dimension 1 Code", RecCRMInt."Shortcut Dimension 1 Code");
                            //RecPL.VALIDATE("Shortcut Dimension 2 Code", RecCRMInt."Shortcut Dimension 2 Code");kj
                            RecPL1.MODIFY;

                            //   taxamt += RecPL."Amount Including Tax";
                            // RecPL.AutoReserve;

                        END;

                        "CRM Integration Purchase"."Order Created" := TRUE;
                        "CRM Integration Purchase".MODIFY;
                        i += 1;
                        cnt := cnt - 1;

                        //>

                        // recPurchLine.Reset();
                        // recPurchLine.SetRange("Document Type", RECPH."Document Type");
                        // recPurchLine.SetRange("Document No.", RECPH."No.");
                        // recPurchLine.SetRange("Line No.", line_no);
                        // if recPurchLine.FindFirst() then begin
                        //     recPurchLine.Validate("TDS Section Code", RecCRMInt."TDS Nature of Deduction");


                        //     //recPurchLine.
                        //     Message('%1TK!2', recPurchLine."TDS Section Code");
                        //     // recPurchLine.MODIFY();
                        // end;
                        recPurchLine1.Reset();
                        recPurchLine1.SetRange("Document Type", RecPH."Document Type");
                        recPurchLine1.SetRange("Document No.", RecPH."No.");
                        recPurchLine1.SetRange("Line No.", RecPL1."Line No.");
                        if recPurchLine1.FindFirst() then begin
                            recPurchLine1.Validate("TDS Section Code", RecCRMInt."TDS Nature of Deduction");
                            //recPurchLine.
                            //Message('%1TK', recPurchLine1."TDS Section Code");
                            CalculateTax.CallTaxEngineOnPurchaseLine(recPurchLine1, recPurchLine1);
                            recPurchLine1.MODIFY();
                        end;
                    //<
                    UNTIL RecCRMInt.NEXT = 0;
                    //Comments ++
                    PurchCommentLine.INIT;
                    PurchCommentLine."Document Type" := PurchCommentLine."Document Type"::Invoice;
                    PurchCommentLine."No." := RecPH."No.";
                    PurchCommentLine."Line No." := 10000;
                    PurchCommentLine.Date := RecPH."Posting Date";
                    PurchCommentLine.Comment := "CRM Integration Purchase".Comment;
                    PurchCommentLine."Document Line No." := 0;
                    PurchCommentLine.INSERT(TRUE);
                    //comments--



                    //   RecPH."Vendor Invoice Value" := taxamt;

                    RecPH.MODIFY;


                    // IF RecPH.Structure <> '' THEN BEGIN
                    //     RecPL.CalculateStructures(RecPH);
                    // END;

                END;/////
                IF NOT "CRM Integration Purchase"."Order Posted" THEN BEGIN
                    PurchPost.RUN(RecPH);//Tk New
                    Message('Posting Process Completed-Please check Posted Purchase Invoices');
                    "CRM Integration Purchase"."Order Posted" := TRUE;
                    "CRM Integration Purchase".MODIFY;
                END;

            END;
        END;
    end;
}

