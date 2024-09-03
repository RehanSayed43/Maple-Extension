codeunit 50002 GetAutonumber
{

    trigger OnRun()
    begin
        //test:=getCustNo;
        //itemno:=getItemNo;
        //TRNo:=getTranferOrferNo;
        //MESSAGE(GetTransferOrderNoByLocation('PNE'));
        //MESSAGE(GetSalesOrderNo);
        //test:=GetSalesQuoteNo;
        //  MESSAGE(test);
        // CODEUNIT.RUN(CODEUNIT::LeadTOQoute,Rec);
        //MakeLeadToQuote(6,'LEAD-0156');
        //MakeQuoteToOrder(1,'SQ/2011-12/0002')
        //MESSAGE(GetOnLineSalesOrderByLocation('PNL'));

        //MESSAGE(GetPurchaseOrderNo());
        COMMIT;
        CLEAR(SalesPost);
        SalesHeaderLOB.RESET;
        SalesHeaderLOB.SETRANGE("Document Type", SalesHeaderLOB."Document Type"::Order);
        SalesHeaderLOB.SETRANGE("Sales Order Type", SalesHeaderLOB."Sales Order Type"::B2B);
        SalesHeaderLOB.SETRANGE("IS LOB Order", FALSE);
        SalesHeaderLOB.SETRANGE(Status, SalesHeaderLOB.Status::Released);
        IF SalesHeaderLOB.FINDSET THEN
            REPEAT
                SalesPost.RUN(SalesHeaderLOB);
                COMMIT;
            UNTIL SalesHeaderLOB.NEXT = 0;
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";//"311";
        NoSeriesMgt: Codeunit NoSeriesManagement;//"396";
        cust: Record Customer;//"18";
        test: Code[30];
        itemno: Code[30];
        InvtSetup: Record "Inventory Setup";//"313";
        TansOrdNo: Code[30];
        TansOrderSetup: Record "Inventory Setup";//"313";
        TRNo: Code[30];
        SalesOrdNo: Code[30];
        PurchaseOrdNo: Code[30];
        PurchaseSetup: Record "Purchases & Payables Setup";//"312";
        GenJnBatch: Record "Gen. Journal Batch";//"232";
        TransferHeader: Record "Transfer Header";//"5740";
        GenJnLine: Record "Gen. Journal Line";//"81";
        Location: Record Location;//"14";
        RsNoSeries: Record "No. Series Line";//"309";
        CashInvoiceNoSeries: Code[30];
        SalesHeaderLOB: Record "Sales Header";//"36";
        SalesPost: Codeunit "Sales-Post";//"80";

    //[Scope('Internal')]
    procedure getCustNo() NEW_NO: Code[30]
    var
        RsNoSeries: Record "No. Series Line";//"309";
    begin

        //IF "No." = '' THEN BEGIN
        SalesSetup.GET;
        SalesSetup.TESTFIELD("Customer Nos.");
        //NoSeriesMgt.InitSeries(SalesSetup."Customer Nos.",'',0D,cust."No.",cust."No. Series");
        NEW_NO := NoSeriesMgt.GetNextNo(SalesSetup."Customer Nos.", 0D, FALSE);
        RsNoSeries.RESET;
        RsNoSeries.SETFILTER(RsNoSeries."Series Code", SalesSetup."Customer Nos.");
        IF RsNoSeries.FIND('-') THEN BEGIN
            RsNoSeries."Last No. Used" := NEW_NO;
            RsNoSeries.MODIFY;
        END;
        //MESSAGE(NEW_NO);
        EXIT(NEW_NO);
        //END;
    end;

    //[Scope('Internal')]
    procedure getItemNo() ret_item_no: Code[30]
    begin
        InvtSetup.GET;
        InvtSetup.TESTFIELD("Item Nos.");
        ret_item_no := NoSeriesMgt.GetNextNo(InvtSetup."Item Nos.", 0D, FALSE);
        //  NoSeriesMgt.InitSeries(InvtSetup."Item Nos.",xRec."No. Series",0D,"No.","No. Series");
        EXIT(ret_item_no);
    end;

    //[Scope('Internal')]
    procedure getTransferOrderNo() TransOrdNo: Code[30]
    var
        RsNoSeries: Record "No. Series Line";//"309";
    begin
        InvtSetup.GET;
        InvtSetup.TESTFIELD(InvtSetup."Transfer Order Nos.");
        // NoSeriesMgt.InitSeries(GetNoSeriesCode,xRec."No. Series","Posting Date","No.","No. Series");
        TransOrdNo := NoSeriesMgt.GetNextNo(InvtSetup."Transfer Order Nos.", 0D, TRUE);

        RsNoSeries.SETFILTER(RsNoSeries."Series Code", InvtSetup."Transfer Order Nos.");
        IF RsNoSeries.FIND('-') THEN BEGIN
            RsNoSeries."Last No. Used" := TransOrdNo;
            RsNoSeries.MODIFY;
        END;


        EXIT(TransOrdNo)
        //TransferHeader.INSERT(TRUE);
    end;

    //[Scope('Internal')]
    procedure GetSalesOrderNo() SalesOrdNo: Code[30]
    var
        RsNoSeries: Record "No. Series Line";//"309";
    begin
        SalesSetup.GET;
        SalesSetup.TESTFIELD(SalesSetup."Order Nos.");
        // NoSeriesMgt.InitSeries(GetNoSeriesCode,xRec."No. Series","Posting Date","No.","No. Series");
        SalesOrdNo := NoSeriesMgt.GetNextNo(SalesSetup."Order Nos.", 0D, TRUE);

        RsNoSeries.SETFILTER(RsNoSeries."Series Code", SalesSetup."Order Nos.");
        IF RsNoSeries.FIND('-') THEN BEGIN
            RsNoSeries."Last No. Used" := SalesOrdNo;
            RsNoSeries.MODIFY;
        END;


        EXIT(SalesOrdNo)
    end;

    //[Scope('Internal')]
    procedure GetPurchaseOrderNo() PurchaseOrdNo: Code[30]
    var
        RsNoSeries: Record "No. Series Line";//"309";
    begin
        PurchaseSetup.GET;
        PurchaseSetup.TESTFIELD(PurchaseSetup."Order Nos.");
        // NoSeriesMgt.InitSeries(GetNoSeriesCode,xRec."No. Series","Posting Date","No.","No. Series");
        PurchaseOrdNo := NoSeriesMgt.GetNextNo(PurchaseSetup."Order Nos.", WORKDATE, TRUE);

        // RsNoSeries.SETFILTER(RsNoSeries."Series Code",PurchaseSetup."Order Nos.");
        //  IF RsNoSeries.FIND('-') THEN
        //  BEGIN
        //   RsNoSeries."Last No. Used":= PurchaseOrdNo;
        //   RsNoSeries.MODIFY;
        //  END;


        EXIT(PurchaseOrdNo)
    end;

    ////[Scope('Internal')]
    procedure GetCashRecNo(BatchNo: Code[10]; JournalTemplateName: Code[20]) CashRecNo: Code[30]
    var
        RsNoSeries: Record "No. Series Line";//"309";
    begin

        //GenJnBatch.SETFILTER(GenJnBatch.Name,BatchNo);
        //IF GenJnBatch.FINDFIRST THEN BEGIN
        //  GenJnBatch.TESTFIELD(GenJnBatch."No. Series");
        //  CashRecNo:=NoSeriesMgt.GetNextNo(GenJnBatch."No. Series",0D,FALSE);
        //     RsNoSeries.SETFILTER(RsNoSeries."Series Code",GenJnBatch."No. Series");
        //       IF RsNoSeries.FIND('-') THEN
        //        BEGIN
        //           RsNoSeries."Last No. Used":=CashRecNo;
        //           RsNoSeries.MODIFY;
        //       END;
        //        EXIT(CashRecNo)
        //END;

        GenJnLine.SETFILTER(GenJnLine."Journal Template Name", JournalTemplateName);
        GenJnLine.SETFILTER(GenJnLine."Journal Batch Name", BatchNo);
        IF GenJnLine.FINDLAST THEN BEGIN
            IF GenJnLine."Document No." <> ' ' THEN BEGIN
                CashRecNo := INCSTR(GenJnLine."Document No.");
            END;
        END
        ELSE BEGIN
            GenJnBatch.SETFILTER(GenJnBatch.Name, BatchNo);
            IF GenJnBatch.FINDFIRST THEN BEGIN
                GenJnBatch.TESTFIELD(GenJnBatch."No. Series");
                CashRecNo := NoSeriesMgt.GetNextNo(GenJnBatch."No. Series", 0D, FALSE);
            END;
        END;
        EXIT(CashRecNo)
    end;

    ////[Scope('Internal')]
    procedure GetSalesOrderNoByLocation(LocationCode: Code[20]) SalesOrdNo: Code[30]
    var
        RsNoSeries: Record "No. Series Line";//"309";
    begin

        Location.RESET;
        Location.GET(LocationCode);
        //Location.TESTFIELD(Location."Branch Code");

        // NoSeriesMgt.InitSeries(GetNoSeriesCode,xRec."No. Series","Posting Date","No.","No. Series");
        SalesOrdNo := NoSeriesMgt.GetNextNo(Location.Code, 0D, TRUE);

        RsNoSeries.SETFILTER(RsNoSeries."Series Code", Location.Code);
        IF RsNoSeries.FIND('-') THEN BEGIN
            RsNoSeries."Last No. Used" := SalesOrdNo;
            RsNoSeries.MODIFY;
        END;
        EXIT(SalesOrdNo)
    end;

    ////[Scope('Internal')]
    procedure GetPurchaseOrderNoByLocation(LocationCode: Code[20]) PurchaseOrdNo: Code[30]
    var
        RsNoSeries: Record "No. Series Line";//"309";
    begin
        /*
        Location.RESET;
        Location.GET(LocationCode);
        Location.TESTFIELD(Location."PO No. Series");
        
             // NoSeriesMgt.InitSeries(GetNoSeriesCode,xRec."No. Series","Posting Date","No.","No. Series");
             PurchaseOrdNo:=NoSeriesMgt.GetNextNo(Location."PO No. Series",0D,FALSE);
        
               RsNoSeries.SETFILTER(RsNoSeries."Series Code",Location."PO No. Series");
               IF RsNoSeries.FIND('-') THEN
                BEGIN
                   RsNoSeries."Last No. Used":= PurchaseOrdNo;
                   RsNoSeries.MODIFY;
                END;
             EXIT(PurchaseOrdNo)
        */

    end;

    ////[Scope('Internal')]
    procedure GetTransferOrderNoByLocation(LocationCode: Code[20]) TransferOrdNo: Code[30]
    var
        RsNoSeries: Record "No. Series Line";//"309";
    begin
        /*
        Location.RESET;
        Location.GET(LocationCode);
        Location.TESTFIELD(Location."TO No. Series");
        
             // NoSeriesMgt.InitSeries(GetNoSeriesCode,xRec."No. Series","Posting Date","No.","No. Series");
             TransferOrdNo:=NoSeriesMgt.GetNextNo(Location."TO No. Series",0D,TRUE);
        
               RsNoSeries.SETFILTER(RsNoSeries."Series Code",Location."TO No. Series");
               IF RsNoSeries.FIND('-') THEN
                BEGIN
                   RsNoSeries."Last No. Used":= TransferOrdNo;
                   RsNoSeries.MODIFY;
                END;
             EXIT(TransferOrdNo)
        */

    end;

    ////[Scope('Internal')]
    procedure GetOnLineSalesOrderByLocation(LocationCode: Code[20]) SalesOrdNo: Code[30]
    var
        RsNoSeries: Record "No. Series Line";//"309";
    begin
        /*
        Location.RESET;
        Location.GET(LocationCode);
        Location.TESTFIELD(Location.CashInvoiceNoSeries);
        
             // NoSeriesMgt.InitSeries(GetNoSeriesCode,xRec."No. Series","Posting Date","No.","No. Series");
             CashInvoiceNoSeries:=NoSeriesMgt.GetNextNo(Location.CashInvoiceNoSeries,0D,TRUE);
        
              // RsNoSeries.SETFILTER(RsNoSeries."Series Code",Location.CashInvoiceNoSeries);
              // IF RsNoSeries.FIND('-') THEN
              //  BEGIN
                //   RsNoSeries."Last No. Used":= CashInvoiceNoSeries;
                //   RsNoSeries.MODIFY;
              //  END;
             EXIT(CashInvoiceNoSeries)
         */

    end;

    ////[Scope('Internal')]
    procedure PostSalesOrder(PostingType: Integer; OrderNumber: Code[30]) IsOrderPost: Boolean
    var
        SalesHeader: Record "Sales Header";//"36";
    begin
        SalesHeader.RESET;
        SalesHeader.SETFILTER("No.", '%1', OrderNumber);
        IsOrderPost := FALSE;

        IF SalesHeader.FINDFIRST THEN BEGIN
            IF (PostingType = 1) THEN BEGIN
                SalesHeader.Ship := TRUE;
                CODEUNIT.RUN(CODEUNIT::"Sales-Post", SalesHeader);
                IsOrderPost := TRUE;
            END;

            IF (PostingType = 2) THEN BEGIN
                SalesHeader.Invoice := TRUE;
                CODEUNIT.RUN(CODEUNIT::"Sales-Post", SalesHeader);
                IsOrderPost := TRUE;
            END;

            IF (PostingType = 3) THEN BEGIN
                SalesHeader.Ship := TRUE;
                SalesHeader.Invoice := TRUE;
                CODEUNIT.RUN(CODEUNIT::"Sales-Post", SalesHeader);
                IsOrderPost := TRUE;
            END;
        END;
    end;

    ////[Scope('Internal')]
    procedure CalculateTax(OrderNo: Code[30]) IsOrderPost: Boolean
    var
        VarSalesHdr: Record "Sales Header";//"36";
        VarSalesLine: Record "Sales Line";//"37";
        SalesSetup: Record "Sales & Receivables Setup";//"311";
    begin
        IsOrderPost := FALSE;
        VarSalesHdr.SETRANGE(VarSalesHdr."No.", OrderNo);

        IF VarSalesHdr.FINDFIRST THEN BEGIN
            SalesSetup.GET;
            //CCIT_kj    // VarSalesHdr.CALCFIELDS("Price Inclusive of Taxes");
            //CCIT_kj    // IF SalesSetup."Calc. Inv. Discount" AND (NOT VarSalesHdr."Price Inclusive of Taxes") THEN BEGIN
            VarSalesHdr.CalcInvDiscForHeader;
            COMMIT
        END;
        //CCIT_kj   // IF VarSalesHdr."Price Inclusive of Taxes" THEN BEGIN
        //CCIT_kj      //  VarSalesLine.InitStrOrdDetail(VarSalesHdr);
        //CCIT_kj     //   VarSalesLine.GetSalesPriceExclusiveTaxes(VarSalesHdr);
        //CCIT_kj     //   VarSalesLine.UpdateSalesLinesPIT(VarSalesHdr);
        COMMIT;
    END;
    //CCIT_kj+++++
    /* IF VarSalesHdr.Structure <> '' THEN BEGIN
         VarSalesLine.CalculateStructures(VarSalesHdr);
         VarSalesLine.AdjustStructureAmounts(VarSalesHdr);
         VarSalesLine.UpdateSalesLines(VarSalesHdr);
         VarSalesLine.CalculateTCS(VarSalesHdr);
     END ELSE BEGIN
         VarSalesLine.CalculateTCS(VarSalesHdr);
     END;

   //  COMMIT;
  //   IsOrderPost := TRUE;
// END;
// end;*/ //CCIT_kj-----

    //[Scope('Internal')]
    procedure SendSalesApprovalRequest(SalesOrderNo: Code[20])
    var
        SalesHeader: Record "Sales Header";//"36";
        ApprovalMgnt: Codeunit "Approvals Mgmt.";//"439";
    begin
        SalesHeader.RESET;
        SalesHeader.SETFILTER("No.", '%1', SalesOrderNo);
        IF SalesHeader.FINDFIRST THEN BEGIN
            // ApprovalMgnt.SendSalesApprovalRequest(SalesHeader); //CCIT_kj
        END;
    end;

    //[Scope('Internal')]
    procedure CancelSalesApprovalRequest(SalesOrderNo: Code[20])
    var
        SalesHeader: Record "Sales Header";//"36";
        ApprovalMgnt: Codeunit "Approvals Mgmt.";//"439";
    begin
        SalesHeader.RESET;
        SalesHeader.SETFILTER("No.", '%1', SalesOrderNo);
        IF SalesHeader.FINDFIRST THEN BEGIN
            // ApprovalMgnt.CancelSalesApprovalRequest(SalesHeader, FALSE, TRUE); //CCIT_kj
        END;
    end;
}

