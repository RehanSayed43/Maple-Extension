codeunit 50000 "Wins Business unit"
{

    trigger OnRun()
    begin
        //SendMail_CustomerLedgerReport();
    end;

    var

        // WshShell: Automation; //CCIT_kj
        //SMTP: Codeunit "400"; //CCIT_kj //EMAIL codeunit  
        Email: Codeunit Email; //CCIT_kj added new

        FilePath: Label 'C:\inetpub\wwwroot\testpdf.pdf';
        tofile: Text[100];
        FileName: Text[250];
        //AppMgmt: Codeunit 1; not needed //CCIT_kj 
        //PurchaseDocument: Report "50014"; //CCIT_kj 
        // FileSystemObject: Automation; //CCIT_kj 
        Text001: Label 'LinnhOff India Pvt Ltd';
        Text002: Label 'schoudhari@winspiresolutions.com';
        PurchaseSetup: Record "Purchases & Payables Setup"; //"312";
        SalesSetup: Record "Sales & Receivables Setup"; //"311";
        ReportSelection: Record "Report Selections"; //"77";
                                                     //  SalesInvoiceReport: Report "50007"; //CCIT_kj
                                                     // ShieldInvoiceReport: Report "50074"; //CCIT_kj
        FileName1: Text[250];


    procedure RefreshPage()
    begin
        /*CLEAR(WshShell);
        IF ISCLEAR(WshShell) THEN
          CREATE(WshShell,FALSE,TRUE);
        //WshShell.SendKeys('^+R');
        WshShell.SendKeys('{F5}');
        */

    end;


    procedure SendMailtoVendorwithAttachment(PurchHeader: Record "Purchase Header")
    var
        Vendor: Record Vendor;//"23";
        VendorMailID: Text[100];
        localPurchHeader: Record "Purchase Header";//"38";
    begin
        IF NOT CONFIRM('Do you want to mail Purchase Order') THEN
            EXIT;

        Vendor.GET(PurchHeader."Buy-from Vendor No.");
        IF Vendor."E-Mail" <> '' THEN BEGIN
            tofile := '\PO_' + PurchHeader."Buy-from Vendor No." + '_' + PurchHeader."No." + '.pdf';
            PurchaseSetup.GET;

            /* IF PurchaseSetup."Sender Mail ID( Maple)" = '' THEN //CCIT_kj+++
                 ERROR('Sender Mail ID is not defined on Purchase & Payable setup');
            // FileName := TEMPORARYPATH + PurchHeader."Buy-from Vendor Name" + '.pdf';// PurchaseSetup."PDF Path" +tofile;
            // IF EXISTS(FileName) THEN
             //    FILE.ERASE(FileName);*/ //CCIT_kj---

            VendorMailID := Vendor."E-Mail";
            localPurchHeader := PurchHeader;
            localPurchHeader.SETRECFILTER;
            /* CLEAR(PurchaseDocument);  //CCIT_kj+++
             PurchaseDocument.USEREQUESTPAGE := TRUE;
             PurchaseDocument.SETTABLEVIEW(localPurchHeader);
             PurchaseDocument.SAVEASPDF(FileName);

             SendMailVendor(PurchHeader."No.", 'Maple', PurchaseSetup."Sender Mail ID( Maple)", VendorMailID);

             // MESSAGE('File Write Error');*/ //CCIT_kj----

        END
        ELSE
            MESSAGE('Vendor E-mail ID is not defined on Vendor Card');
    end;


    procedure SendMailtoCustomerwithAttachment(SalesInvHeader: Record "Sales Invoice Header")
    var
        Customer: Record Customer;//"18";
        CustomerMailID: Text[100];
        localSInvHeader: Record "Sales Invoice Header"; //"112";
        ShieldInvoiceHeader: Record "Sales Invoice Header"; //"112";
    begin
        IF NOT CONFIRM('Do you want to mail Sales Invoice') THEN
            EXIT;

        Customer.GET(SalesInvHeader."Sell-to Customer No.");
        IF Customer."E-Mail" <> '' THEN BEGIN
            //tofile := '\SI_'+SalesInvHeader."Sell-to Customer No."+'_'+ SalesInvHeader."No."+'.pdf';
            tofile := '\XX.pdf';
            PurchaseSetup.GET;
            IF PurchaseSetup."PDF Path" = '' THEN
                ERROR('PDF path is not defined on Purchase & Payable setup');
            IF PurchaseSetup."Sender Mail ID( Maple)" = '' THEN
                ERROR('Sender Mail ID is not defined on Purchase & Payable setup');

            //CCIT_kj   // FileName := TEMPORARYPATH + SalesInvHeader."Sell-to Customer Name" + '.pdf';// PurchaseSetup."PDF Path" +tofile;
            //ERROR('%1',FileName);

            //  IF EXISTS(FileName) THEN   //CCIT_kj
            //     FILE.ERASE(FileName); //CCIT_kj

            CustomerMailID := Customer."E-Mail";
            // CustomerMailID:='kaushalt@winspiresolutions.com';
            localSInvHeader := SalesInvHeader;
            localSInvHeader.SETRECFILTER;

            //ReportSelection.SETFILTER((ReportSelection.Usage,'%1',ReportSelection.Usage::"S.Invoice");
            //IF NOT ReportSelection.FINDFIRST THEN BEGIN
            //  MESSAGE('Sales Invoice Report is not Defined');
            //  EXIT;
            //END;
            /* CLEAR(SalesInvoiceReport);   //CCIT_kj++
               SalesInvoiceReport.USEREQUESTPAGE := TRUE;
               SalesInvoiceReport.SETTABLEVIEW(localSInvHeader);
               SalesInvoiceReport.SAVEASPDF(FileName);*/   //CCIT_kj----
                                                           //win316++
            CLEAR(FileName1);
            ShieldInvoiceHeader.RESET;
            ShieldInvoiceHeader.SETRANGE("Reference Invoice No.", localSInvHeader."No.");
            //ShieldInvoiceHeader.SETRANGE(Shield, TRUE); //CCIT_kj
            IF ShieldInvoiceHeader.FINDFIRST THEN BEGIN
                /*CCIT_kj++      // FileName1 := TEMPORARYPATH + SalesInvHeader."Sell-to Customer Name" + '-Shield.pdf';
                       IF EXISTS(FileName1) THEN
                           FILE.ERASE(FileName1); *///CCIT_kj---

                /*CLEAR(ShieldInvoiceReport);  //CCIT_kj++
                ShieldInvoiceReport.USEREQUESTPAGE := TRUE;
                ShieldInvoiceReport.SETTABLEVIEW(ShieldInvoiceHeader);
                ShieldInvoiceReport.SAVEASPDF(FileName1);*///CCIT_kj---
            END;
            //win316--

            //CCIT_kj // SendMailCustomer(SalesInvHeader."No.", 'Maple', PurchaseSetup."Sender Mail ID( Maple)", CustomerMailID);
            //  SendMailCustomer(SalesInvHeader."No.",'Maple',PurchaseSetup."Sender Mail ID( Maple)",'ypatil@winspiresolutions.com');
            //FILE.ERASE(FileName);
            //  END
            // ELSE
            // MESSAGE('File Write Error');
        END
        ELSE
            MESSAGE('Customer E-mail ID is not defined on Customer Card');
    end;


    procedure ExecEnter()
    begin
        //CLEAR(WshShell);
        // IF ISCLEAR(WshShell) THEN
        //    CREATE(WshShell, FALSE, TRUE);
        //WshShell.SendKeys('^+R');
        // WshShell.SendKeys('{enter}');
    end;


    procedure SendMailVendor(PurchOrderNo: Code[20]; SenderName: Text[50]; SenderAddress: Text[100]; Recipient: Text[100])
    var
        Subject: Text[100];
        Body: Text[1024];
        PDFFile: File;
        LFChar: Char;
        CRChar: Char;
        CRLF: Text[30];
    begin
        //Name := STRSUBSTNO('CustLedger%1.pdf',CustomerLocal."No.");
        //FName := 'C:\inetpub\wwwroot\CustLedgReports\'+Name;
        //Recipient := 'schoudhari@winspiresolutions.com';
        LFChar := 10;
        CRChar := 13;
        CRLF := FORMAT(CRChar) + FORMAT(LFChar);

        /*  Subject := 'Purchase Order - ' + PurchOrderNo; //CCIT_kj++
          CLEAR(SMTP);
          SMTP.CreateMessage(SenderName, SenderAddress, Recipient, Subject, Body, FALSE);
          Body := 'Dear Sir/Madam,' + CRLF;
          SMTP.AppendBody(Body);
          Body := CRLF + 'We are pleased to confirm our Purchase Order as per attachment.';
          SMTP.AppendBody(Body);
          Body := CRLF + 'Please ensure the supply as per the schedule date mentioned in purchase order.' + CRLF;
          SMTP.AppendBody(Body);
          Body := CRLF + 'Thanking You';
          SMTP.AppendBody(Body);
          Body := CRLF + 'Regards,' + CRLF + CRLF;
          SMTP.AppendBody(Body);
          Body := CRLF + 'for Maple Digital Technology International Pvt Ltd.';
          SMTP.AppendBody(Body);
          //IF EXISTS(FName) THEN
          //  BEGIN
          SMTP.AddAttachment(FileName, '');
          SMTP.Send;
          MESSAGE('Mail Sent');
          //   END
          //  ELSE
          //    MESSAGE('File Not found'); */ //CCIT_kj---
    end;


    procedure SendMail_CustomerLedgerReport()
    var
        Customer: Record Customer;//"18";
        CustLedgerReport: Report "Customer - Summary Aging";//"105";
        Subject: Text[250];
        CustomerLocal: Record Customer;//"18";
    begin
        Customer.RESET;
        Customer.SETRANGE("No.", 'C001', 'C005');
        Customer.FINDFIRST;
        REPEAT
            IF Customer."E-Mail" <> '' THEN BEGIN
                //MESSAGE('CUSTOMER %1',Customer."No.");
                tofile := 'CustLedger_' + Customer."No." + '.pdf';
                FileName := 'C:\temp\Customerledgers\' + tofile;
                CustomerLocal.RESET;
                CustomerLocal.SETFILTER("No.", '%1', Customer."No.");
                IF CustomerLocal.FINDFIRST THEN BEGIN
                    SLEEP(30000);
                    CustomerLocal.SETRECFILTER;
                    CustLedgerReport.USEREQUESTPAGE := TRUE;
                    CustLedgerReport.SETTABLEVIEW(CustomerLocal);
                    //CCIT_kj     // IF CustLedgerReport.SAVEASPDF(FileName) THEN BEGIN
                    //SLEEP(30000);
                    MESSAGE('CUSTOMER %1', Customer."No.");
                    Subject := 'Customer Ledger Report - ' + Customer."No.";
                    //CCIT_kj    //  SendMailCustomer(Subject, Text001, Text002, Customer."E-Mail");
                    //FILE.ERASE(FileName);
                    CLEAR(CustLedgerReport);
                END;
            END;
        // END; //CCIT_kj
        UNTIL Customer.NEXT = 0;

    end;


    procedure SendMailCustomer(InvoiceNo: Code[20]; SenderName: Text[50]; SenderAddress: Text[100]; Recipient: Text[100])
    var
        Body: Text[1024];
        PDFFile: File;
        LFChar: Char;
        CRChar: Char;
        CRLF: Text[30];
        Subject: Text[100];
    begin
        LFChar := 10;
        CRChar := 13;
        CRLF := FORMAT(CRChar) + FORMAT(LFChar);

        Subject := 'Sales Invoice - ' + InvoiceNo;
        /* CLEAR(SMTP);
         SMTP.CreateMessage(SenderName, SenderAddress, Recipient, Subject, Body, FALSE);
         Body := 'Dear Sir/Madam,' + CRLF;
         SMTP.AppendBody(Body);
         Body := CRLF + 'Pleased find attached Sales Invoice.' + CRLF + CRLF;
         SMTP.AppendBody(Body);
         //Body :=CRLF+'Please ensure the supply as per the schedule date mentioned in purchase order.'+CRLF;
         //SMTP.AppendBody(Body);
         Body := CRLF + 'Thanking You' + CRLF;
         SMTP.AppendBody(Body);
         Body := CRLF + 'Regards,' + CRLF + CRLF;
         SMTP.AppendBody(Body);
         Body := CRLF + 'for Maple Digital Technology International Pvt Ltd.';
         SMTP.AppendBody(Body);
         SMTP.AddAttachment(FileName, '');
         //WIN316++
         IF EXISTS(FileName1) THEN BEGIN
             SMTP.AppendBody(Body);
             SMTP.AddAttachment(FileName1, '');
         END;
         //WIN316--
         SMTP.Send;
         IF SMTP.GetLastSendMailErrorText() = '' THEN
             MESSAGE('Mail Sent')
         ELSE
             MESSAGE('Error while sending Mail %1', SMTP.GetLastSendMailErrorText()); */
    end;


    procedure CheckCreditDaysHold(SaleHeader: Record "Sales Header"): Boolean
    var
        SalesAndReceivableSetup: Record "Sales & Receivables Setup"; //"311";
        Customer: Record Customer; //"18";
        DueDateLocal: Date;
        PaymentTerms: Record "Payment Terms"; //"3";
    begin
        SalesAndReceivableSetup.GET;
        IF SalesAndReceivableSetup."Credit Days Hold Active" THEN BEGIN
            Customer.GET(SaleHeader."Sell-to Customer No.");
            IF (Customer."Payment Terms Code" <> '') AND (SaleHeader."Document Date" <> 0D) THEN BEGIN
                PaymentTerms.GET(SaleHeader."Payment Terms Code");
                DueDateLocal := CALCDATE(PaymentTerms."Due Date Calculation", SaleHeader."Document Date");
                IF SaleHeader."Due Date" <> DueDateLocal THEN
                    SaleHeader."Credit Days Hold" := TRUE;
                // SaleHeader.MODIFY;
                // COMMIT;
                EXIT(TRUE);
            END;
        END;
        EXIT(FALSE);
    end;


    procedure CheckPriceHold(SalesLine: Record "Sales Line"): Boolean
    var
        SalesAndReceivableSetup: Record "Sales & Receivables Setup"; //"311";
        PriceHoldLocal: Boolean;
        SalesPrice: Record "Sales Price";//"7002";
        SalesHeader: Record "Sales Header"; //"36";
    begin
        SalesAndReceivableSetup.GET;
        IF SalesAndReceivableSetup."Price Hold Active" THEN BEGIN
            SalesHeader.GET(SalesLine."Document Type", SalesLine."Document No.");
            SalesPrice.RESET;
            SalesPrice.SETFILTER("Item No.", '%1', SalesLine."No.");
            SalesPrice.SETFILTER("Starting Date", '<=%1', SalesHeader."Document Date");
            IF SalesPrice.FINDLAST THEN BEGIN
                IF SalesPrice."Unit Price" <> SalesLine."Unit Price" THEN BEGIN
                    SalesLine."Price Hold" := TRUE;
                    EXIT(TRUE)
                END;
            END;
        END;
        EXIT(FALSE);
    end;


    procedure CheckDiscountHold(SalesLine: Record "Sales Line"): Boolean
    var
        SalesAndReceivableSetup: Record "Sales & Receivables Setup"; //"311";
        PriceHoldLocal: Boolean;
        SalesPrice: Record "Sales Price";//"7002";
        SalesHeader: Record "Sales Header"; //"36";
    begin
        SalesAndReceivableSetup.GET;
        IF SalesLine."Free Item" THEN BEGIN
            SalesLine."Discount Hold" := FALSE;
            EXIT;
        END;

        IF (SalesLine."Line Discount %" <> 0) OR (SalesLine."Line Discount Amount" <> 0) THEN BEGIN
            SalesAndReceivableSetup.TESTFIELD("Max. Retail Line Discount %");
        END;
        IF SalesAndReceivableSetup."Discount Hold Active" AND (SalesLine."Line Discount %" > SalesAndReceivableSetup."Max. Retail Line Discount %") THEN BEGIN
            IF (SalesLine."Line Discount %" <> 0) OR (SalesLine."Line Discount Amount" <> 0) THEN BEGIN
                SalesLine."Discount Hold" := TRUE;
                EXIT(TRUE)
            END;
        END;
        EXIT(FALSE);
    end;


    procedure RefreshStatistics()
    begin

        /*CLEAR(WshShell);
        IF ISCLEAR(WshShell) THEN
          CREATE(WshShell,FALSE,TRUE);
        WshShell.SendKeys('{F7}');
        //SLEEP(30000);
        //WshShell.SendKeys('^+ENTER');
        WshShell.SendKeys('^{Enter}');
        */

    end;


    procedure NextLine()
    begin
        /*
        CLEAR(WshShell);
        IF ISCLEAR(WshShell) THEN
          CREATE(WshShell,FALSE,TRUE);
        WshShell.SendKeys('{DOWN}');
        WshShell.SendKeys('{LEFT}');
        */

    end;


    procedure RefreshLine()
    begin
        /*
        CLEAR(WshShell);
        IF ISCLEAR(WshShell) THEN
          CREATE(WshShell,FALSE,TRUE);
        WshShell.SendKeys('{DOWN}');
        WshShell.SendKeys('{UP}');
        */

    end;


    procedure CalculateStructure(SalesHeader: Record "Sales Header")
    var
        SalesLineLocal: Record "Sales Line"; //"37";
    begin
        //WBU.ExecEnter();
        //SalesHeader.GET("Document Type","Document No.");
        SalesSetup.GET;

        //CCIT_kj+++
        /* SalesHeader.CALCFIELDS("Price Inclusive of Taxes"); 
          IF SalesSetup."Calc. Inv. Discount" AND (NOT SalesHeader."Price Inclusive of Taxes") THEN BEGIN
              SalesHeader.CalcInvDiscForHeader;
              COMMIT
          END;*/
        /*  IF SalesHeader."Price Inclusive of Taxes" THEN BEGIN
           SalesLineLocal.InitStrOrdDetail(SalesHeader); 
              SalesLineLocal.GetSalesPriceExclusiveTaxes(SalesHeader);
             SalesLineLocal.UpdateSalesLinesPIT(SalesHeader);
              COMMIT;
         END;

        IF SalesHeader.Structure <> '' THEN BEGIN
            SalesLineLocal.CalculateStructures(SalesHeader);
            SalesLineLocal.AdjustStructureAmounts(SalesHeader);
            SalesLineLocal.UpdateSalesLines(SalesHeader);
            SalesLineLocal.CalculateTCS(SalesHeader);
        END ELSE
            SalesLineLocal.CalculateTCS(SalesHeader);
        COMMIT; *///CCIT_kj--
    end;


    procedure CheckGroupCreditLimitHold(SaleHeader: Record "Sales Header"): Boolean
    var
        SalesAndReceivableSetup: Record "Sales & Receivables Setup";//"311";
        Customer: Record Customer;//"18";
        DueDateLocal: Date;
        PaymentTerms: Record "Payment Terms";//"3";
        Parent: Record Customer;//"18";
        CreditLimit: Decimal;
        TotalOutstanding: Decimal;
    begin
        SalesAndReceivableSetup.GET;
        IF SalesAndReceivableSetup."Group Credit Limit Hold Active" THEN BEGIN
            Customer.GET(SaleHeader."Sell-to Customer No.");
            Customer.CALCFIELDS(Customer.RelCustomerCnt);
            IF Customer."Parent Code" <> '' THEN
                Parent.GET(Customer."Parent Code")
            ELSE
                IF Customer.RelCustomerCnt > 0 THEN
                    Parent.GET(Customer."No.")
                ELSE
                    EXIT(FALSE);
            IF Parent."Credit Limit (LCY)" > 0 THEN BEGIN
                CreditLimit := Parent."Credit Limit (LCY)";
                Parent.CALCFIELDS(Balance);
                TotalOutstanding := Parent.Balance;
                Customer.RESET;
                Customer.SETFILTER("Parent Code", Parent."No.");
                IF Customer.FINDFIRST THEN BEGIN
                    REPEAT
                        Customer.CALCFIELDS(Balance);
                        TotalOutstanding := TotalOutstanding + Customer.Balance;
                    UNTIL Customer.NEXT = 0;
                END;
                //ccit_kj  // SaleHeader.CALCFIELDS("Amount to Customer");
                //ccit_kj   // EXIT((SaleHeader."Amount to Customer" + TotalOutstanding) > CreditLimit);
            END;
        END;
        EXIT(FALSE);
    end;


    procedure CheckVendorInvoiceAmt(var recPurchHeader: Record "Purchase Header")
    var
        BillAmtCalc: Decimal;
        recPurchaseLine: Record "Purchase Line";//"39";
        BillAmtCalc1: Decimal;
        DiffAmt: Decimal;
        Text060: Label 'Vendor Invoice Value %1 it must be equal to %2 & Difference is %3';
    begin
        // CCIT_kj  recPurchHeader.TESTFIELD("Vendor Invoice Value");
        BillAmtCalc := 0;
        recPurchaseLine.RESET;
        recPurchaseLine.SETRANGE(recPurchaseLine."Document Type", recPurchHeader."Document Type");
        recPurchaseLine.SETRANGE(recPurchaseLine."Document No.", recPurchHeader."No.");
        IF recPurchaseLine.FINDFIRST THEN
            // CCIT_kj REPEAT
                IF recPurchaseLine."No." <> '' THEN
                // CCIT_kj       BillAmtCalc1 += (recPurchaseLine."Amount To Vendor" / recPurchaseLine.Quantity) * recPurchaseLine."Qty. to Invoice";
                // CCIT_kj   UNTIL recPurchaseLine.NEXT = 0;

                BillAmtCalc := ROUND(BillAmtCalc1, 1, '=');

        // CCIT_kj   DiffAmt := ROUND(ABS(BillAmtCalc - recPurchHeader."Vendor Invoice Value"), 1, '=');
        IF DiffAmt <> 0 THEN BEGIN
            // CCIT_kj    ERROR(Text060, recPurchHeader."Vendor Invoice Value", ROUND(BillAmtCalc, 1, '='), ROUND(DiffAmt, 1, '='));
        END;
    end;
}

