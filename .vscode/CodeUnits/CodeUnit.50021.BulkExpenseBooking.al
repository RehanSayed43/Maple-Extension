codeunit 50021 "Bulk Expense Booking"
{

    trigger OnRun()
    begin
        CreatePurchaseInvoice;
    end;

    var
        PurchaseUploadBuffer: Record 50009;
        LocationShipTo: Record Location;//tk
        DimSetID: Integer;
        recPurchLine1: Record "Purchase Line";
        RecPL1: Record "Purchase Line";
        CalculateTax: Codeunit "Calculate Tax";
        CurrCRM: Code[20];
        PrevCRM: Code[20];
        RecVend: Record 23;
        taxamt: Decimal;
        RecItem: Record 27;
        RecILE: Record 32;
        RecCRMInt1: Record 50017;
        PurchCommentLine: Record 43;
        SRsetup: Record 312;
        RecCRMInt: Record 50009;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";


    procedure CreatePurchaseInvoice()
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
        PurchaseUploadBuffer1: Record 50009;
        recPHH: Record 38;
        Currrr: Code[30];
        Prevvv: Code[30];
    begin
        CLEAR(CurrCRM);
        CLEAR(PrevCRM);
        PurchaseUploadBuffer.SETCURRENTKEY("Vendor Invoice No");
        PurchaseUploadBuffer.SETRANGE("Invoice Uploaded", FALSE);
        IF PurchaseUploadBuffer.FINDSET THEN
            REPEAT
                CurrCRM := PurchaseUploadBuffer."Vendor Invoice No";
                IF PrevCRM <> CurrCRM THEN BEGIN
                    // PrevCRM:=PurchaseUploadBuffer."Vendor Invoice No";
                    CLEAR(taxamt);
                    RecVend.RESET;
                    RecVend.SETRANGE("No.", PurchaseUploadBuffer."Vendor No.");
                    IF RecVend.FINDFIRST THEN;

                    SRsetup.GET;
                    RecPH.INIT;
                    CLEAR(SO_No);

                    IF PurchaseUploadBuffer."Document Type" = PurchaseUploadBuffer."Document Type"::Invoice THEN
                        SO_No := NoSeriesMgt.GetNextNo(SRsetup."Invoice Nos.", WORKDATE, TRUE);


                    RecPH."No." := SO_No;

                    RecPH."Document Type" := PurchaseUploadBuffer."Document Type";
                    RecPH.VALIDATE(RecPH."Buy-from Vendor No.", RecVend."No.");
                    RecPH.VALIDATE("Pay-to Vendor No.", RecVend."No.");
                    // RecPH.VALIDATE(Structure, PurchaseUploadBuffer.Structure);//tk
                    RecPH.VALIDATE("Vendor Invoice No.", PurchaseUploadBuffer."Vendor Invoice No");
                    RecPH.VALIDATE("Vendor Invoice Date", PurchaseUploadBuffer."Vendor Invoice Date");
                    RecPH.VALIDATE("Document Date", PurchaseUploadBuffer."Posting Date");
                    RecPH.VALIDATE("Posting Date", PurchaseUploadBuffer."Posting Date");

                    RecPH."Expense Invoice" := TRUE;
                    RecPH.INSERT(TRUE);
                    RecPH.SetHideValidationDialog(true);//CCIT_TK
                    RecPH.VALIDATE("Shortcut Dimension 1 Code", PurchaseUploadBuffer."Shortcut Dimension 1 Code");
                    RecPH.VALIDATE("Shortcut Dimension 2 Code", PurchaseUploadBuffer."Shortcut Dimension 2 Code");
                    //CCIT_TK
                    DimSetID := RecPH."Dimension Set ID";
                    RecPH.VALIDATE("Location Code", PurchaseUploadBuffer."Location Code");
                    LocationShipTo.Get(PurchaseUploadBuffer."Location Code");
                    RecPH.Validate("Dimension Set ID", DimSetID);
                    RecPH.MODIFY;

                END;//Header insert ends
                RecPL.INIT;
                RecPL.VALIDATE("Document Type", RecPL."Document Type"::Invoice);
                RecPL."Document No." := SO_No;


                IF i = 0 THEN
                    line_no := 10000
                ELSE
                    line_no := (i + 1) * 10000;
                RecPL.VALIDATE("Line No.", line_no);
                RecPL.INSERT(TRUE);
                RecPL.GetCurrentPurchHeader(RecPH);
                RecPL.VALIDATE("Buy-from Vendor No.", RecVend."No.");
                RecPL.VALIDATE("Pay-to Vendor No.", RecVend."No.");

                RecPL.VALIDATE(Type, RecPL.Type::"G/L Account");
                // RecPL.VALIDATE("Location Code",RecPH."Location Code");


                IF RecPL.Type = RecPL.Type::"G/L Account" THEN
                    RecPL.VALIDATE("No.", PurchaseUploadBuffer."No.");

                RecPL.VALIDATE("Location Code", RecPH."Location Code");//ccit-tk
                RecPL.VALIDATE(Quantity, PurchaseUploadBuffer.Quantity);
                RecPL.VALIDATE("Direct Unit Cost", PurchaseUploadBuffer."Unit Price With Tax");
                RecPL.VALIDATE("GST Group Code", PurchaseUploadBuffer."GST Group Code");
                RecPL.Validate("GST Credit", PurchaseUploadBuffer."GST Credit");

                RecPL."HSN/SAC Code" := PurchaseUploadBuffer."HSN/SAC Code";
                IF RecPL.Type = RecPL.Type::"G/L Account" THEN
                    //TK TDS Calculation
                    IF PurchaseUploadBuffer."TDS Nature of Deduction" <> '' THEN begin
                        RecPL."TDS Section Code" := PurchaseUploadBuffer."TDS Nature of Deduction";
                        CalculateTax.CallTaxEngineOnPurchaseLine(RecPL, RecPL);
                        RecPL.Modify();
                    end;
                if RecPL."TDS Section Code" <> '' then
                    RecPL.Validate("TDS Section Code");
                // RecPL1.VALIDATE("TDS Section Code",'');


                //TK TDS Calculation
                //IF PurchaseUploadBuffer."TDS Nature of Deduction" <> '' THEN
                // RecPL.VALIDATE("TDS Nature of Deduction", PurchaseUploadBuffer."TDS Nature of Deduction");
                RecPL.VALIDATE("Shortcut Dimension 1 Code", PurchaseUploadBuffer."Shortcut Dimension 1 Code");
                RecPL.VALIDATE("Shortcut Dimension 2 Code", PurchaseUploadBuffer."Shortcut Dimension 2 Code");
                RecPL.MODIFY;

                // taxamt += RecPL."Amount To Vendor";
                taxamt += RecPL.Amount;
                // RecPL.AutoReserve;






                //Comments ++
                IF PurchaseUploadBuffer.Comments <> '' THEN BEGIN
                    PurchCommentLine.INIT;
                    PurchCommentLine."Document Type" := PurchCommentLine."Document Type"::Invoice;
                    PurchCommentLine."No." := RecPH."No.";
                    // PurchCommentLine."Line No.":=10000;
                    PurchCommentLine."Line No." := RecPL."Line No.";//10000;
                    PurchCommentLine.Date := RecPH."Posting Date";
                    PurchCommentLine.Comment := PurchaseUploadBuffer.Comments;
                    PurchCommentLine."Document Line No." := 0;
                    PurchCommentLine.INSERT(TRUE);
                END;
                //comments--
                //CCIT_TK
                recPurchLine1.Reset();
                recPurchLine1.SetRange("Document Type", RecPH."Document Type");
                recPurchLine1.SetRange("Document No.", RecPH."No.");
                recPurchLine1.SetRange("Line No.", RecPL."Line No.");
                if recPurchLine1.FindFirst() then begin
                    recPurchLine1.Validate("TDS Section Code", PurchaseUploadBuffer."TDS Nature of Deduction");
                    //recPurchLine.
                    //Message('%1TK', recPurchLine1."TDS Section Code");
                    CalculateTax.CallTaxEngineOnPurchaseLine(recPurchLine1, recPurchLine1);
                    recPurchLine1.MODIFY();
                end;
                //CCIT_TK





                // IF RecPH.Structure <> '' THEN BEGIN
                //     RecPL.CalculateStructures(RecPH);
                // END;//tk

                RecPH."Vendor Invoice Value" := PurchaseUploadBuffer."Vendor Invoice Value";
                RecPH.MODIFY;

                PurchaseUploadBuffer.Expense := TRUE;
                PurchaseUploadBuffer."Invoice Uploaded" := TRUE;
                PurchaseUploadBuffer.MODIFY;
                i += 1;


                /*IF ApprovalsMgmt.CheckPurchaseApprovalsWorkflowEnabled(RecPH) THEN BEGIN
                  //IF NOT GUIALLOWED THEN
                  ApprovalsMgmt.OnSendPurchaseDocForApproval(RecPH);


                  END;
                  */
                PrevCRM := PurchaseUploadBuffer."Vendor Invoice No";
            UNTIL PurchaseUploadBuffer.NEXT = 0;

        PurchaseUploadBuffer1.RESET;//tk++
        PurchaseUploadBuffer1.SETRANGE("Vendor Invoice No");
        IF PurchaseUploadBuffer1.FINDSET THEN
            REPEAT
                Currrr := PurchaseUploadBuffer1."Vendor Invoice No";
                IF Currrr <> Prevvv THEN BEGIN
                    Prevvv := PurchaseUploadBuffer1."Vendor Invoice No";
                    recPHH.RESET;
                    recPHH.SETRANGE("Vendor Invoice No.", PurchaseUploadBuffer1."Vendor Invoice No");
                    IF recPHH.FINDFIRST THEN
                        IF ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(recPHH) THEN BEGIN
                            ApprovalsMgmt.OnSendPurchaseDocForApproval(recPHH);
                        END;
                END;
            UNTIL PurchaseUploadBuffer1.NEXT = 0;//tk--



        MESSAGE('Process Completed-Please check Purchase Invoices');



        PurchaseUploadBuffer.RESET;
        PurchaseUploadBuffer.SETRANGE(PurchaseUploadBuffer."Invoice Uploaded", TRUE);
        IF PurchaseUploadBuffer.FINDSET THEN
            PurchaseUploadBuffer.DELETEALL;

    end;
}

