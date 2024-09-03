codeunit 50005 PostingOrder
{
    // //MESSAGE('Posting Order');
    // //IF PostSalesOrder(3,'SO141500241')  THEN
    //  // MESSAGE('Order Posted')
    // //ELSE
    // //  MESSAGE('Order NOT Posted');


    trigger OnRun()
    begin
    end;

    var
        Text000: Label '%1 needs to be rounded';
        Text001: Label 'Sales %1 %2 already exists.';
        Text002: Label 'Purchase %1 %2 already exists.';
        Text003: Label 'Purchase %1 %2 already exists for this vendor.';
        Text004: Label 'must not be filled when %1 is different in %2 and %3.';
        Text005: Label ' must be entered when %1 is %2';
        Text006: Label 'Check %1 already exists for this Bank Account.';
        Text010: Label 'Residual caused by rounding of %1';
        Text013: Label 'A dimension used in %1 %2, %3, %4 has caused an error. %5';
        Text014: Label 'Reversal found a %1 without a matching %2.';
        Text015: Label 'You cannot reverse the transaction, because it has already been reversed.';
        Text011: Label 'The combination of dimensions used in %1 %2 is blocked. %3';
        Text020: Label 'Document type must be Invoice, Credit memo, Payment or Refund.';
        Text16501: Label 'Invalid Deductee P.A.N.';
        Text16502: Label 'P.A.N. No. can''t be blank for Non-Govt. Organisations.';
        Text16503: Label 'Posting date does not lie in %1.';
        Text16504: Label 'Invalid Party P.A.N.';
        Text16506: Label 'Please unchek the Input Service Distributor field in the %1 Location. ';
        Text16507: Label 'Please unchek the Input Service Distributor field in the Company Information.';
        Text16508: Label 'Input service Distribution should not be Yes in GTA transactions.';
        Text16509: Label 'Please Select the Location Code %1 in Batch %2.';
        Text16510: Label 'You cannot reverse the transaction, because it has already been reversed.';
        Text16511: Label 'Service Tax Advance Payment Document/s cannot be applied with non Service Tax Invoice/s.';
        Text16512: Label 'Application Amount for Payment Document No. %1 and Invoice Document No. %2 should not be greater than %3.';
        Text16513: Label 'Invoice/s and Payment/s documents cannot be applied as both have different Service Tax Rounding Precision/Type.';
        Text16514: Label 'Refund should be applied against service tax on advance payment.';
        Text16515: Label 'The Payment %1 is not an Input Service Distribution Payment. Hence cannot be applied with the Invoice %2.';
        Text16516: Label 'Document Type %1 should not be applied against a Refund document %2 having service tax on advance payment.';
        Text16517: Label 'Document %1 is having service tax on advance payment. Hence cannot be applied against document %2.';
        Text16518: Label 'Documents cannot be un-applied as Service tax liability has been already paid.';
        Text16519: Label 'Invoice/s and Payment/s documents cannot be applied as both have different Service Tax Group Codes.';
        Text16520: Label 'Invoice/s and Payment/s documents cannot be applied as both have different Service Tax Registration Nos.';
        Text16521: Label 'Payment Document with ST Pure Agent and Service Tax on Advance Payment should be applied with invoice having check mark on ST Pure Agent.';
        Text16522: Label 'Void the check as tds amount has to be recalculated';
        Text16523: Label 'The PoT Value in the %1 and the %2 is not the same.';

    //[Scope('Internal')]
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

    //[Scope('Internal')]
    procedure PostTransferOrder(PostingType: Integer; OrderNo: Code[20]) IsPost: Boolean
    var
        recTransHeader: Record "Transfer Header";//"5740";
    begin
        recTransHeader.SETFILTER(recTransHeader."No.", OrderNo);
        IF recTransHeader.FINDFIRST THEN BEGIN

            IF PostingType = 0 THEN BEGIN
                CODEUNIT.RUN(CODEUNIT::"TransferOrder-Post Shipment", recTransHeader);
                IsPost := TRUE
            END ELSE
                IsPost := FALSE;


            IF PostingType = 1 THEN BEGIN
                CODEUNIT.RUN(CODEUNIT::"TransferOrder-Post Receipt", recTransHeader);
                IsPost := TRUE
            END ELSE
                IsPost := FALSE;

        END
    end;

    //[Scope('Internal')]
    procedure PostPurchaseOrder(PostingType: Integer; OrderNumber: Code[30]) IsOrderPost: Boolean
    var
        "Order": Record "Purchase Header";//"38";
    begin
        Order.SETFILTER(Order."No.", OrderNumber);
        IsOrderPost := FALSE;
        //MESSAGE('Posting Type is' , '%1',PostingType);

        IF Order.FINDFIRST THEN BEGIN
            IF (PostingType = 1) THEN BEGIN
                Order.Receive := TRUE;
                CODEUNIT.RUN(CODEUNIT::"Purch.-Post", Order);
                IsOrderPost := TRUE;
            END;


            IF (PostingType = 2) THEN BEGIN
                Order.Invoice := TRUE;
                CODEUNIT.RUN(CODEUNIT::"Purch.-Post", Order);
                IsOrderPost := TRUE;
            END;

            IF (PostingType = 3) THEN BEGIN
                Order.Receive := TRUE;
                Order.Invoice := TRUE;
                CODEUNIT.RUN(CODEUNIT::"Purch.-Post", Order);
                IsOrderPost := TRUE;
            END;


        END;
    end;

    //[Scope('Internal')]
    procedure PostVoucher(BatchName: Text[30]; TempName: Text[30]) IsVoucherPost: Boolean
    var
        GenjnLine: Record "Gen. Journal Line";//"81";
    begin
        GenjnLine.SETFILTER(GenjnLine."Journal Batch Name", BatchName);
        GenjnLine.SETFILTER(GenjnLine."Journal Template Name", TempName);
        //GenjnLine.SETFILTER(GenjnLine."PostingY/N",'YES');

        IF GenjnLine.FINDFIRST THEN BEGIN
            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", GenjnLine);
            IsVoucherPost := TRUE;
        END
        ELSE BEGIN
            IsVoucherPost := FALSE;
        END
    end;

    //[Scope('Internal')]
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
            //ccit_kj  //  VarSalesHdr.CALCFIELDS("Price Inclusive of Taxes");
            //ccit_kj  //  IF SalesSetup."Calc. Inv. Discount" AND (NOT VarSalesHdr."Price Inclusive of Taxes") THEN BEGIN
            VarSalesHdr.CalcInvDiscForHeader;
            COMMIT
        END;

        //ccit_kj+++
        /* IF VarSalesHdr."Price Inclusive of Taxes" THEN BEGIN
             VarSalesLine.InitStrOrdDetail(VarSalesHdr);
             VarSalesLine.GetSalesPriceExclusiveTaxes(VarSalesHdr);
             VarSalesLine.UpdateSalesLinesPIT(VarSalesHdr);
             COMMIT;
         END;

         IF VarSalesHdr.Structure <> '' THEN BEGIN
             VarSalesLine.CalculateStructures(VarSalesHdr);
             VarSalesLine.AdjustStructureAmounts(VarSalesHdr);
             VarSalesLine.UpdateSalesLines(VarSalesHdr);
             VarSalesLine.CalculateTCS(VarSalesHdr);
         END ELSE BEGIN
             VarSalesLine.CalculateTCS(VarSalesHdr);
         END;

         COMMIT;
         IsOrderPost := TRUE;
     END;*/ //ccit_kj-----
    end;

    //[Scope('Internal')]
    procedure CalculatePurchaseTax(OrderNo: Code[30]) IsOrderPost: Boolean
    var
        VarPurchaseHeader: Record "Purchase Header";//"38";
        VarPurchaseLine: Record "Purchase Line";//"39";
        VarPurchaseSetup: Record "Purchases & Payables Setup";//"312";
    begin

        IsOrderPost := FALSE;
        VarPurchaseHeader.SETRANGE(VarPurchaseHeader."No.", OrderNo);

        IF VarPurchaseHeader.FINDFIRST THEN BEGIN
            VarPurchaseSetup.GET;
            //    VarPurchaseHeader.CALCFIELDS("Price Inclusive of Taxes");
            IF VarPurchaseSetup."Calc. Inv. Discount" THEN BEGIN   // AND (NOT  VarSalesHdr."Price Inclusive of Taxes") THEN BEGIN
                VarPurchaseHeader.CalcInvDiscForHeader;
                COMMIT
            END;
            // IF  VarSalesHdr."Price Inclusive of Taxes" THEN BEGIN
            //   VarSalesLine.InitStrOrdDetail(VarSalesHdr);
            //   VarSalesLine.GetSalesPriceExclusiveTaxes(VarSalesHdr);
            //   VarSalesLine.UpdateSalesLinesPIT(VarSalesHdr);
            //   COMMIT;
            //END;

            //ccit_kj+++++
            /*  IF VarPurchaseHeader.Structure <> '' THEN BEGIN
                  VarPurchaseLine.CalculateStructures(VarPurchaseHeader);
                  VarPurchaseLine.AdjustStructureAmounts(VarPurchaseHeader);
                  VarPurchaseLine.UpdatePurchLines(VarPurchaseHeader);
                  VarPurchaseLine.CalculateTDS(VarPurchaseHeader);
              END ELSE BEGIN
                  VarPurchaseLine.CalculateTDS(VarPurchaseHeader);
              END;*/
            //ccit_kj----
            COMMIT;
            IsOrderPost := TRUE;
        END;
    end;

    //[Scope('Internal')]
    procedure SendSalesApprovalRequest(SalesOrderNo: Code[20])
    var
        SalesHeader: Record "Sales Header";//"36";
        ApprovalMgnt: Codeunit "Approvals Mgmt.";//"439";
    begin
        SalesHeader.RESET;
        SalesHeader.SETFILTER("No.", '%1', SalesOrderNo);
        IF SalesHeader.FINDFIRST THEN BEGIN
            //  ApprovalMgnt.SendSalesApprovalRequest(SalesHeader); //CCIT_kj
        END;
    end;

    //[Scope('Internal')]
    procedure CreateReservationEntry(SalesLine: Record "Sales Line")
    var
        CreateReservEntry: Codeunit "Create Reserv. Entry";//"99000830";
        ReservEntry: Record "Reservation Entry";//"337";
    begin
        // DeleteSalesTrackingSpecification(SalesLine); //ccit_kj
        // IF ChkDuplicateSerialNo("Item Serial No.") THEN //ccit_kj
        //ccit_kj   //  MESSAGE('Duplicate Item Serial No. %1 ON Line No. %2', "Item Serial No.", "Line No.");
        //ccit_kj  //  CreateReservEntry.CreateReservEntryFor(
        //ccit_kj   //   DATABASE::"Sales Line", "Document Type", "Document No.", '', 0, "Line No.", "Qty. per Unit of Measure", 0, Quantity, "Item Serial No.", "IMEI No.");
        CreateReservEntry.CreateEntry(SalesLine."No.", SalesLine."Variant Code", SalesLine."Location Code", SalesLine.Description, 0D, SalesLine."Shipment Date", 0, ReservEntry."Reservation Status"::Surplus);
    end;
}

