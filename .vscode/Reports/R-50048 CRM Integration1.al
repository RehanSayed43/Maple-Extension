report 50048 "CRM Integration1"
{
    ProcessingOnly = true;
    UseRequestPage = false;
    ApplicationArea = FixedAsset;

    dataset
    {
        dataitem("CRM Integration"; "CRM Integration")
        {
            DataItemTableView = SORTING("Customer No.", "CRM invoice No", "No.")
                                ORDER(Ascending)
                                WHERE("Order Created" = CONST(False));

            trigger OnPreDataItem()
            begin
                RecGenJnlLine.INIT;
                RecGenJnlLine.CRM := TRUE;
                RecGenJnlLine."Journal Template Name" := 'GENERAL1';
                RecGenJnlLine."Journal Batch Name" := 'SERVICE';
                RecGenJnlLine."Line No." := 10000;
                RecGenJnlLine."Posting Date" := TODAY;
                RecGenJnlLine."Document Date" := TODAY;
                RecGenJnlLine."Account Type" := RecGenJnlLine."Account Type"::Customer;

                RecGenJnlLine.VALIDATE("Account No.", 'CR/1617/000024060');
                RecGenJnlLine.VALIDATE("Document Type", RecGenJnlLine."Document Type"::Payment);
                SRsetup.GET;
                DoucNo := NoSeriesMgt.GetNextNo(SRsetup."CRM Payment No.", TODAY, TRUE);
                RecGenJnlLine."Document No." := DoucNo;
                //RecGenJnlLine."Bal. Account Type" := RecGenJnlLine."Bal. Account Type"::"Bank Account";//Win292
                RecGenJnlLine."Bal. Account Type" := RecGenJnlLine."Bal. Account Type"::"G/L Account";//Win292
                                                                                                      //RecGenJnlLine."Bal. Account No." := 'IOB0513';//WIN292
                RecGenJnlLine."Bal. Account No." := '107002';//Win292
                RecGenJnlLine."Location Code" := RecSalesInv."Location Code";
                RecGenJnlLine.Narration := 'Test';

                // RecGenJnlLine.Amount:=RecSalesInv."Amount to Customer"*-1;
                // RecGenJnlLine."Amount (LCY)" :=RecSalesInv."Amount to Customer"*-1;

                amt := ("CRM Integration"."Cash Amount" + "CRM Integration"."Credit Card Amount" + "CRM Integration"."Debit Card Amount" +
                "CRM Integration"."Cheque Amount" + "CRM Integration"."NEFT/RTGS/EFT Amount") * -1;

                RecGenJnlLine.VALIDATE(Amount, -1500);
                RecGenJnlLine.VALIDATE("Shortcut Dimension 1 Code", RecSalesInv."Shortcut Dimension 1 Code");
                RecGenJnlLine.VALIDATE("Shortcut Dimension 2 Code", RecSalesInv."Shortcut Dimension 2 Code");
                /*
                //For Application++
                RecGenJnlLine.VALIDATE("Applies-to Doc. Type","CRM Integration"."Apply to doc. Type"::Invoice);
                RecGenJnlLine.VALIDATE("Applies-to Doc. No.",RecSalesInv."No.");
                //For Application--
                */
                RecGenJnlLine.INSERT(TRUE);
                CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", RecGenJnlLine);

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
        RecLoc: Record "Location";
        SalesPost: Codeunit 81;
        RecCRMInt: Record "CRM Integration";
        RecGenJnlLine: Record "Gen. Journal Line";
        LineNo1: Integer;
        GenJnlPostLine: Codeunit 12;
        DoucNo: Code[20];
        NoSeriesMgt: Codeunit 396;
        SRsetup: Record "Sales & Receivables Setup";
        CurrCRM: Code[20];
        PrevCRM: Code[20];
        RecCust: Record "Customer";
        RecSalesInv: Record "Sales Invoice Header";
        SO_No: Code[20];
        RecSL1: Record "Sales Line";
        Rec_TransferHead: Record "Transfer Header";
        Rec_TransferLine: Record "Transfer Line";
        Gen_Batch: Record "Gen. Journal Batch";
        Tline_no: Integer;
        j: Integer;
        InvSetup: Record "Inventory Setup";
        RecCrmIn: Record "CRM Integration";
        GenJnlPostLine1: Codeunit 12;
        amt: Decimal;


    procedure CreateSalesOrder()
    var
        NoSeriesMgt: Codeunit 396;
        SRsetup: Record 311;
        RecSH: Record 36;
        line_no: Integer;
        RecLocation: Record 14;
        Output_File_Path: Text;
        RecSL: Record 37;
        cnt: Integer;
        i: Integer;
        RecItem: Record 27;
    begin
        IF NOT "CRM Integration"."Order Created" THEN BEGIN
            RecCust.RESET;
            RecCust.SETRANGE("CRM Mobile No.", "CRM Integration"."Mobile No.");
            IF RecCust.FINDFIRST THEN BEGIN
                //Sales Header Insert

                RecSH.INIT;
                CLEAR(SO_No);
                SRsetup.GET;
                IF "CRM Integration"."Document Type" = "CRM Integration"."Document Type"::Invoice THEN
                    SO_No := NoSeriesMgt.GetNextNo(SRsetup."Order Nos.", WORKDATE, TRUE);
                IF "CRM Integration"."Document Type" = "CRM Integration"."Document Type"::"Credit Memo" THEN
                    SO_No := NoSeriesMgt.GetNextNo(SRsetup."Credit Memo Nos.", WORKDATE, TRUE);
                RecSH."No." := SO_No;
                RecSH."Sales Order Type" := RecSH."Sales Order Type"::Service;
                RecSH."Document Type" := "CRM Integration"."Document Type";
                RecSH.CRM := TRUE;
                RecSH.VALIDATE("Sell-to Customer No.", RecCust."No.");
                RecSH.VALIDATE("Bill-to Customer No.", RecCust."No.");
                RecSH.VALIDATE("Sales Order Type", RecSH."Sales Order Type"::Service);
                RecSH.VALIDATE("Location Code", "CRM Integration"."Location Code");
                //   RecSH.VALIDATE(Structure, "CRM Integration".Structure);
                RecSH."Nature of Supply" := "CRM Integration"."Nature of Supply";
                RecSH."External Document No." := "CRM Integration"."CRM invoice No";
                RecSH.VALIDATE("Posting Date", "CRM Integration"."Posting Date");
                RecSH.VALIDATE("Document Date", "CRM Integration"."Document Date");//WIN292
                                                                                   //RecSH.VALIDATE("Document Date","CRM Integration"."Posting Date");//WIN292
                IF RecSH."Document Type" = RecSH."Document Type"::"Credit Memo" THEN BEGIN
                    RecSH."Applies-to Doc. Type" := "CRM Integration"."Apply to doc. Type";
                    RecSH."Applies-to Doc. No." := "CRM Integration"."Apply to Doc. No.";
                    //RecSH.VALIDATE("Applies-to Doc. No.","CRM Integration"."Apply to Doc. No.");
                END;
                RecSH.INSERT(TRUE);
                RecCRMInt.RESET;
                RecCRMInt.SETRANGE(RecCRMInt."CRM invoice No", PrevCRM);
                IF RecCRMInt.FINDSET THEN BEGIN
                    REPEAT
                        RecSL.INIT;
                        RecSL.VALIDATE("Document Type", "CRM Integration"."Document Type");
                        RecSL.VALIDATE("Document No.", SO_No);
                        RecSL.VALIDATE("Sell-to Customer No.", RecCust."No.");
                        RecSL.VALIDATE("Bill-to Customer No.", RecCust."No.");

                        IF i = 0 THEN
                            line_no := 10000
                        ELSE
                            line_no := (i + 1) * 10000;
                        RecSL.VALIDATE("Line No.", line_no);
                        RecSL.VALIDATE(Type, RecCRMInt.Type);
                        RecSL.INSERT(TRUE);
                        RecSL.RESET;
                        RecSL.SETRANGE("Document No.", SO_No);
                        RecSL.SETFILTER("Line No.", '%1', line_no);
                        IF RecSL.FINDFIRST THEN BEGIN
                            RecItem.RESET;
                            RecItem.SETRANGE(RecItem."Vendor Part Code Long", RecCRMInt."No.");
                            IF RecItem.FINDFIRST THEN BEGIN
                                IF RecSL.Type = RecSL.Type::Item THEN
                                    RecSL.VALIDATE("No.", RecItem."No.");
                            END;
                            IF RecSL.Type = RecSL.Type::"G/L Account" THEN //WIn292
                                RecSL.VALIDATE("No.", RecCRMInt."No.");
                            RecSL.VALIDATE("Location Code", RecSH."Location Code");
                            //RecSL.VALIDATE("No.",RecCRMInt."No.");
                            RecSL.VALIDATE(Quantity, RecCRMInt.Quantity);
                            //  IF RecSL.Type=RecSL.Type::Item THEN BEGIN
                            //   RecSL.VALIDATE(RecSL."Unit Price Incl. of Tax",RecCRMInt."Unit Price With Tax");
                            // RecSL.VALIDATE("PIT Structure",RecSH.Structure);
                            // RecSL.VALIDATE("Price Inclusive of Tax",TRUE);
                            //  END;
                            // IF RecSL.Type=RecSL.Type::"G/L Account" THEN
                            RecSL.VALIDATE("Unit Price", RecCRMInt."Unit Price With Tax");

                            RecSL.VALIDATE("GST Group Code", RecCRMInt."GST Group Code");
                            //RecSL.VALIDATE("HSN/SAC Code",RecCRMInt."HSN/SAC Code");
                            RecSL."HSN/SAC Code" := RecCRMInt."HSN/SAC Code";
                            //RecSL.VALIDATE("HSN/SAC Code","CRM Integration"."HSN/SAC Code");
                            // RecSL."Invoice Type":="CRM Integration"."Invoice Type";
                            // RecSL.VALIDATE(Reserve,RecSL.Reserve::Always);
                            RecSL.MODIFY;

                            // RecSL.AutoReserve;
                        END;
                        /*RecCRMInt."Order Created":=TRUE;
                        RecCRMInt.MODIFY; */
                        "CRM Integration"."Order Created" := TRUE;
                        "CRM Integration".MODIFY;
                        i += 1;
                        cnt := cnt - 1;



                    UNTIL RecCRMInt.NEXT = 0;

                    RecSH.VALIDATE("Shortcut Dimension 1 Code", "CRM Integration"."Shortcut Dimension 1 Code");
                    RecSH.VALIDATE("Shortcut Dimension 2 Code", "CRM Integration"."Shortcut Dimension 2 Code");
                END;

                // MESSAGE('Order Created %1',SO_No);
            END;
            // IF RecSH.Structure <> '' THEN BEGIN
            //     RecSL.CalculateStructures(RecSH);
            // END;

            IF NOT RecCRMInt."Order Posted" THEN BEGIN

                SalesPost.RUN(RecSH);
                /*RecCRMInt."Order Posted":=TRUE;
                RecCRMInt.MODIFY;*/
                "CRM Integration"."Order Posted" := TRUE;
                "CRM Integration".MODIFY;
            END;
            IF "CRM Integration"."Bal. Account No." <> '' THEN
                PostPayment(SO_No);
            //MESSAGE('%1 Order Posted',SO_No);

        END;

    end;


    procedure PostPayment(OrderNo: Code[20])
    begin
        IF NOT "CRM Integration"."Payment Created" THEN BEGIN
            RecCust.RESET;
            RecCust.SETRANGE("CRM Mobile No.", "CRM Integration"."Mobile No.");
            IF RecCust.FINDFIRST THEN BEGIN
                RecSalesInv.RESET;
                RecSalesInv.SETRANGE(RecSalesInv."Pre-Assigned No.", OrderNo);
                IF RecSalesInv.FINDFIRST THEN BEGIN
                    //  RecSalesInv.CALCFIELDS(RecSalesInv."Amount to Customer");
                    RecGenJnlLine.RESET;
                    RecGenJnlLine.SETRANGE(RecGenJnlLine."Journal Template Name", 'GENERAL1');
                    RecGenJnlLine.SETRANGE(RecGenJnlLine."Journal Batch Name", 'SERVICE');
                    IF RecGenJnlLine.FINDLAST THEN
                        LineNo1 := RecGenJnlLine."Line No." + 10000
                    ELSE
                        LineNo1 := 10000;

                    //IF "CRM Integration"."Bal. Account No." <> '' THEN
                    //BEGIN
                    RecGenJnlLine.INIT;
                    RecGenJnlLine.CRM := TRUE;
                    RecGenJnlLine."Journal Template Name" := 'GENERAL1';
                    RecGenJnlLine."Journal Batch Name" := 'SERVICE';
                    RecGenJnlLine."Line No." := LineNo1;
                    RecGenJnlLine."Posting Date" := "CRM Integration"."Posting Date";
                    RecGenJnlLine."Document Date" := "CRM Integration"."Document Date";
                    RecGenJnlLine."Account Type" := RecGenJnlLine."Account Type"::Customer;

                    RecGenJnlLine.VALIDATE("Account No.", RecCust."No.");
                    RecGenJnlLine.VALIDATE("Document Type", RecGenJnlLine."Document Type"::Payment);
                    SRsetup.GET;
                    DoucNo := NoSeriesMgt.GetNextNo(SRsetup."CRM Payment No.", "CRM Integration"."Posting Date", TRUE);
                    RecGenJnlLine."Document No." := DoucNo;
                    //RecGenJnlLine."Bal. Account Type" := RecGenJnlLine."Bal. Account Type"::"Bank Account";//Win292
                    RecGenJnlLine."Bal. Account Type" := "CRM Integration"."Bal. Account Type";//Win292
                                                                                               //RecGenJnlLine."Bal. Account No." := 'IOB0513';//WIN292
                    RecGenJnlLine."Bal. Account No." := "CRM Integration"."Bal. Account No.";//Win292
                    RecGenJnlLine."Location Code" := RecSalesInv."Location Code";
                    RecGenJnlLine.Narration := "CRM Integration".Narration;

                    // RecGenJnlLine.Amount:=RecSalesInv."Amount to Customer"*-1;
                    // RecGenJnlLine."Amount (LCY)" :=RecSalesInv."Amount to Customer"*-1;

                    amt := ("CRM Integration"."Cash Amount" + "CRM Integration"."Credit Card Amount" + "CRM Integration"."Debit Card Amount" +
                    "CRM Integration"."Cheque Amount" + "CRM Integration"."NEFT/RTGS/EFT Amount") * -1;

                    RecGenJnlLine.VALIDATE(Amount, amt);
                    RecGenJnlLine.VALIDATE("Shortcut Dimension 1 Code", RecSalesInv."Shortcut Dimension 1 Code");
                    RecGenJnlLine.VALIDATE("Shortcut Dimension 2 Code", RecSalesInv."Shortcut Dimension 2 Code");
                    /*
                    //For Application++
                    RecGenJnlLine.VALIDATE("Applies-to Doc. Type","CRM Integration"."Apply to doc. Type"::Invoice);
                    RecGenJnlLine.VALIDATE("Applies-to Doc. No.",RecSalesInv."No.");
                    //For Application--
                    */
                    RecGenJnlLine.INSERT(TRUE);

                    COMMIT;
                    "CRM Integration"."Payment Created" := TRUE;
                    "CRM Integration"."Payment Posted" := TRUE;
                    "CRM Integration".MODIFY;
                END;
            END;
        END;

        //END;

    end;
}

