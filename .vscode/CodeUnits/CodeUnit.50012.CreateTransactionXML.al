codeunit 50012 "Create Transaction XML"
{
    EventSubscriberInstance = Manual;
    Permissions = TableData 112 = rim,
                  TableData 113 = rim,
                  TableData 114 = rim,
                  TableData 115 = rim,
                  TableData 50011 = rim;

    trigger OnRun()
    begin
        /*
        //FOR ERROR++
            //for sales
            RecSIH.RESET;
            RecSIH.SETFILTER("Posting Date",'%1..',221117D);
            RecSIH.SETRANGE("Capillary Posted",FALSE);
            RecSIH.SETFILTER("Sell-to Customer No.",'<>%1','');
            RecSIH.SETFILTER("Capillary Error",'%1','');
            IF RecSIH.FINDSET THEN BEGIN
              REPEAT
                RecCust.GET(RecSIH."Sell-to Customer No.");
                Send_Transaction_Information_Sales(RecCust."Phone No.",RecSIH."Order No.");
              UNTIL RecSIH.NEXT=0;
            END;
        
            //for credit memo
            SalesCrMemoHeader1.RESET;
            SalesCrMemoHeader1.SETFILTER("Posting Date",'%1..',221117D);
            SalesCrMemoHeader1.SETRANGE("Capillary Posted",FALSE);
            SalesCrMemoHeader1.SETFILTER("Capillary Error",'%1','');
            IF SalesCrMemoHeader1.FINDSET THEN BEGIN
              REPEAT
               // RecCust.GET(RecSIH."Sell-to Customer No.");
                Send_Transaction_Information_Return(SalesCrMemoHeader1);
              UNTIL SalesCrMemoHeader1.NEXT=0;
            END;
        //FOR ERROR--
        
        //for sales
        RecSIH.RESET;
        RecSIH.SETFILTER("Posting Date",'%1..',221117D);
        RecSIH.SETRANGE("Capillary Posted",FALSE);
        RecSIH.SETFILTER("Sales Order Type",'%1',RecSIH."Sales Order Type"::Retail);
        RecSIH.SETFILTER("Order No.",'<>%1','');
        IF RecSIH.FINDSET THEN BEGIN
          REPEAT
            RecCust.GET(RecSIH."Sell-to Customer No.");
            IF (RecCust."Phone No."='') AND (STRLEN(RecCust."Phone No.")<10) THEN BEGIN
             // RecCust.VALIDATE("Phone No.",'');
             // RecCust.MODIFY;
              END;
            Send_Transaction_Information_Sales(RecCust."Phone No.",RecSIH."Order No.");
            MESSAGE('sales');
          UNTIL RecSIH.NEXT=0;
        END;
        
        
        //for credit memo
        SalesCrMemoHeader1.RESET;
        SalesCrMemoHeader1.SETFILTER("Posting Date",'%1..',221117D);
        SalesCrMemoHeader1.SETRANGE("Capillary Posted",FALSE);
        SalesCrMemoHeader1.SETFILTER("Sales Order Type",'%1',SalesCrMemoHeader1."Sales Order Type"::Retail);
        IF SalesCrMemoHeader1.FINDSET THEN BEGIN
          REPEAT
            RecCust.GET(SalesCrMemoHeader1."Sell-to Customer No.");
            IF (RecCust."Phone No."='') AND (STRLEN(RecCust."Phone No.")<10) THEN BEGIN
             // RecCust.VALIDATE("Phone No.",'');
             // RecCust.MODIFY;
              END;
            Send_Transaction_Information_Return(SalesCrMemoHeader1);
            MESSAGE('return');
          UNTIL SalesCrMemoHeader1.NEXT=0;
        END;
        
        MESSAGE('Done');
        *///WIN234 05082020

    end;

    var
        RecSIH: Record 112;
        RecCust: Record 18;
        SalesCrMemoHeader1: Record 114;
        RecUserSetup: Record 91;
        RecLocation: Record 14;
        Pos_1: Integer;
        RecCustSal: Record 18;
        RecCustSalCr: Record 18;


    procedure Send_Transaction_Information_Sales(Mobile_no: Text[30]; Sales_Order_No: Code[20])
    var
        FileName: Text;
        // xmlWriter: DotNet XmlTextWriter;
        // EncodingText: DotNet Encoding;//tk
        SalesInvoiceHeader: Record 112;
        SalesInvoiceLine: Record 113;
        StateGST: Decimal;
        CentralGST: Decimal;
        IntegratedGST: Decimal;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        Total_Amount: Decimal;
        Gross_amount: Decimal;
        IGST_Base_Amount: Decimal;
        CGST_Base_Amount: Decimal;
        SGST_Base_Amount: Decimal;
        RecSSH: Record 110;
        RecILE: Record 32;
        IMEI_no: Text;
        Serial_no: Text;
        POS: Integer;
        POS1: Integer;
        // DLL: DotNet Class1;//tk
        Debit_card_amount: Decimal;
        Credit_card_amount: Decimal;
        Credit_card_no: Text;
        Debit_card_no: Text;
        SalesInvoiceHeader1: Record 112;
        SalesInvoiceLine1: Record 113;
        Line_no: Integer;
    begin
        //for capillary ++
        /*
        IF GUIALLOWED THEN BEGIN
        DLL:=DLL.Class1;
        IF NOT DLL.CheckInterNet('http://www.google.com') THEN BEGIN
          MESSAGE('Internet is Not Working');
          EXIT;
          END;
        END;
        */
        /*
        SalesInvoiceHeader.RESET;
        SalesInvoiceHeader.SETRANGE("Order No.",Sales_Order_No);
        SalesInvoiceHeader.SETFILTER("Sales Order Type",'%1',SalesInvoiceHeader."Sales Order Type"::Retail);
        IF SalesInvoiceHeader.FINDFIRST THEN
        BEGIN
        RecCust.RESET;
        RecCust.SETRANGE("No.",SalesInvoiceHeader."Bill-to Customer No.");
        IF RecCust.FINDFIRST THEN;
          FileName := '\\mapleNAV\Navision\Dont Delete (Capilery Integration)\Transaction Responce\' + SalesInvoiceHeader."Location Code" + RecCust."Phone No."+'-' +FORMAT(TODAY,0,'<Day,2>-<Month,2>-<Year4>') +'.xml';
        
                   IF EXISTS(FileName) THEN
                    FILE.ERASE(FileName);
        
                 CLEAR(Total_Amount);
                 CLEAR(Gross_amount);
                 SalesInvoiceLine.RESET;
                 SalesInvoiceLine.SETRANGE("Document No.",SalesInvoiceHeader."No.");
                 IF SalesInvoiceLine.FINDSET THEN BEGIN
                   REPEAT
                     Total_Amount+=SalesInvoiceLine."Amount To Customer"+SalesInvoiceLine."Shield Value";
                     Gross_amount+=(SalesInvoiceLine.Quantity * SalesInvoiceLine."Unit Price Incl. of Tax")+SalesInvoiceLine."Shield Value";
                   UNTIL SalesInvoiceLine.NEXT=0;
                 END;
        
          IF ISNULL(xmlWriter) THEN
          xmlWriter := xmlWriter.XmlTextWriter(FileName, EncodingText.UTF8);
          xmlWriter.WriteStartDocument();//begin
            //Create Parent element
            xmlWriter.WriteStartElement('root');
            xmlWriter.WriteStartElement('transaction');
              //Create Child elements
              IF (RecCust."Not Interested Customer") OR (RecCust."Phone No."='')THEN
                xmlWriter.WriteElementString('type','Not_Interested')
              ELSE
                xmlWriter.WriteElementString('type','regular');
              xmlWriter.WriteElementString('amount',FORMAT(Total_Amount,0,1));
              xmlWriter.WriteElementString('discount','');
              xmlWriter.WriteElementString('number',FORMAT(Sales_Order_No));
              xmlWriter.WriteElementString('billing_time',(FORMAT(SalesInvoiceHeader."Posting Date",0,'<Year4>-<Month,2>-<Day,2>')+' '+FORMAT(SalesInvoiceHeader."Time of Removal",0,'<hours24>:<minutes,2>:<seconds,2>')));
              xmlWriter.WriteElementString('gross_amount',FORMAT(Gross_amount,0,1));
                 xmlWriter.WriteStartElement('customer');
                  IF RecCust."Not Interested Customer" THEN
                    xmlWriter.WriteElementString('mobile','')
                  ELSE
                    xmlWriter.WriteElementString('mobile',FORMAT(RecCust."Phone No."));
        
                    xmlWriter.WriteElementString('email',FORMAT(RecCust."E-Mail"));
                    xmlWriter.WriteElementString('firstname',RecCust.Name);
                    xmlWriter.WriteElementString('lastname','');
        
                       xmlWriter.WriteStartElement('custom_fields');
                          xmlWriter.WriteStartElement('field');
                            xmlWriter.WriteElementString('name','birthday');
                            xmlWriter.WriteElementString('value',FORMAT(RecCust."Customer Birth Date",0,'<Year4>/<Month,2>/<Day,2>'));
        
                          xmlWriter.WriteEndElement();
                          xmlWriter.WriteStartElement('field');
                            xmlWriter.WriteElementString('name','anniversary');
                            xmlWriter.WriteElementString('value',FORMAT(RecCust."Aniversary Date",0,'<Year4>/<Month,2>/<Day,2>'));
                          xmlWriter.WriteEndElement();
                          xmlWriter.WriteStartElement('field');
                            xmlWriter.WriteElementString('name','gender');
                            xmlWriter.WriteElementString('value',FORMAT(RecCust.Gender));
                          xmlWriter.WriteEndElement();
                       xmlWriter.WriteEndElement();//custom_fields
                 xmlWriter.WriteEndElement();//customer
        
                 xmlWriter.WriteStartElement('payment_details');
        
                 IF SalesInvoiceHeader.PayByCashAmt<>0 THEN BEGIN
                   xmlWriter.WriteStartElement('payment');
                     xmlWriter.WriteElementString('mode','Cash');
                     xmlWriter.WriteElementString('value',FORMAT(SalesInvoiceHeader.PayByCashAmt,0,1));
                   xmlWriter.WriteEndElement();
                 END;
        
                  CLEAR(Debit_card_amount);
                  Debit_card_amount:=SalesInvoiceHeader.PayByDebitCdAmt1+SalesInvoiceHeader.PayByDebitAmt2;
                  IF Debit_card_amount<>0 THEN BEGIN
                   xmlWriter.WriteStartElement('payment');
                     xmlWriter.WriteElementString('mode','Debit Card');
                     xmlWriter.WriteElementString('value',FORMAT(Debit_card_amount,0,1));
                   xmlWriter.WriteEndElement();
                 END;
        
                  IF SalesInvoiceHeader.PayByChqAmt<>0 THEN BEGIN
                   xmlWriter.WriteStartElement('payment');
                     xmlWriter.WriteElementString('mode','Cheque');
                     xmlWriter.WriteElementString('value',FORMAT(SalesInvoiceHeader.PayByChqAmt,0,1));
                   xmlWriter.WriteEndElement();
                 END;
        
                  CLEAR(Credit_card_amount);
                  Credit_card_amount:=SalesInvoiceHeader.PayByCreditAmt1+SalesInvoiceHeader.PayByCreditAmt2+SalesInvoiceHeader.PayByCreditAmt3+SalesInvoiceHeader.PayByCreditAmt4;
                  IF Credit_card_amount<>0 THEN BEGIN
                   xmlWriter.WriteStartElement('payment');
                     xmlWriter.WriteElementString('mode','Credit Card');
                     xmlWriter.WriteElementString('value',FORMAT(Credit_card_amount,0,1));
                   xmlWriter.WriteEndElement();
                 END;
        
                  IF SalesInvoiceHeader."RTGS Amount"<>0 THEN BEGIN
                   xmlWriter.WriteStartElement('payment');
                     xmlWriter.WriteElementString('mode','RTGS');
                     xmlWriter.WriteElementString('value',FORMAT(SalesInvoiceHeader."RTGS Amount",0,1));
                   xmlWriter.WriteEndElement();
                 END;
        
                  IF SalesInvoiceHeader."Paytm Transfer Amount"<>0 THEN BEGIN
                   xmlWriter.WriteStartElement('payment');
                     xmlWriter.WriteElementString('mode','Paytm');
                     xmlWriter.WriteElementString('value',FORMAT(SalesInvoiceHeader."Paytm Transfer Amount",0,1));
                   xmlWriter.WriteEndElement();
                 END;
        
                  IF SalesInvoiceHeader."Finance Amount"<>0 THEN BEGIN
                   xmlWriter.WriteStartElement('payment');
                     xmlWriter.WriteElementString('mode','Finance');
                     xmlWriter.WriteElementString('value',FORMAT(SalesInvoiceHeader."Finance Amount",0,1));
                   xmlWriter.WriteEndElement();
                 END;
        
                  IF SalesInvoiceHeader."Amazon Transfer Amount"<>0 THEN BEGIN
                   xmlWriter.WriteStartElement('payment');
                     xmlWriter.WriteElementString('mode','Ex');
                     xmlWriter.WriteElementString('value',FORMAT(SalesInvoiceHeader."Amazon Transfer Amount",0,1));
                   xmlWriter.WriteEndElement();
                 END;
        
                  IF SalesInvoiceHeader."Insurance Transfer Amount"<>0 THEN BEGIN
                   xmlWriter.WriteStartElement('payment');
                     xmlWriter.WriteElementString('mode','Insurance');
                     xmlWriter.WriteElementString('value',FORMAT(SalesInvoiceHeader."Insurance Transfer Amount",0,1));
                   xmlWriter.WriteEndElement();
                 END;
        
                 xmlWriter.WriteEndElement();//payment_details
        
                 xmlWriter.WriteStartElement('custom_fields');
                 CLEAR(CGST_Base_Amount);
                 CLEAR(SGST_Base_Amount);
                 CLEAR(IGST_Base_Amount);
                 SalesInvoiceHeader.RESET;
                 SalesInvoiceHeader.SETRANGE("Order No.",Sales_Order_No);
                 IF SalesInvoiceHeader.FINDFIRST THEN;
                 DetailedGSTLedgerEntry.RESET;
                 DetailedGSTLedgerEntry.SETRANGE("Document No.",SalesInvoiceHeader."No.");
                 IF DetailedGSTLedgerEntry.FINDSET THEN BEGIN
                   REPEAT
                     IF DetailedGSTLedgerEntry."GST Component Code"='CGST' THEN
                         CGST_Base_Amount+=(DetailedGSTLedgerEntry."GST Amount"*-1);
        
                     IF DetailedGSTLedgerEntry."GST Component Code"='SGST' THEN
                         SGST_Base_Amount+=(DetailedGSTLedgerEntry."GST Amount"*-1);
        
                     IF DetailedGSTLedgerEntry."GST Component Code"='IGST' THEN
                         IGST_Base_Amount+=(DetailedGSTLedgerEntry."GST Amount"*-1);
                   UNTIL DetailedGSTLedgerEntry.NEXT=0;
                   END;
                   //SHIELD GST++
                   SalesInvoiceHeader1.RESET;
                   SalesInvoiceHeader1.SETRANGE("Ref. Invoice No.",SalesInvoiceHeader."No.");
                   SalesInvoiceHeader1.SETFILTER(Shield,'%1',TRUE);
                   IF SalesInvoiceHeader1.FINDFIRST THEN BEGIN
                      DetailedGSTLedgerEntry.RESET;
                      DetailedGSTLedgerEntry.SETRANGE("Document No.",SalesInvoiceHeader1."No.");
                      DetailedGSTLedgerEntry.SETFILTER("No.",'%1','310008');
                      IF DetailedGSTLedgerEntry.FINDSET THEN BEGIN
                         REPEAT
                           IF DetailedGSTLedgerEntry."GST Component Code"='CGST' THEN
                               CGST_Base_Amount+=(DetailedGSTLedgerEntry."GST Amount"*-1);
        
                           IF DetailedGSTLedgerEntry."GST Component Code"='SGST' THEN
                               SGST_Base_Amount+=(DetailedGSTLedgerEntry."GST Amount"*-1);
        
                           IF DetailedGSTLedgerEntry."GST Component Code"='IGST' THEN
                               IGST_Base_Amount+=(DetailedGSTLedgerEntry."GST Amount"*-1);
                         UNTIL DetailedGSTLedgerEntry.NEXT=0;
                      END;
                   END;
                   //SHIELS GST--
        
                   IF CGST_Base_Amount<>0 THEN BEGIN
                   xmlWriter.WriteStartElement('field');
                     xmlWriter.WriteElementString('name','cgst');
                     xmlWriter.WriteElementString('value',FORMAT(CGST_Base_Amount,0,1));
                   xmlWriter.WriteEndElement();
                   END;
                   IF SGST_Base_Amount<>0 THEN BEGIN
                   xmlWriter.WriteStartElement('field');
                     xmlWriter.WriteElementString('name','sgst');
                     xmlWriter.WriteElementString('value',FORMAT(SGST_Base_Amount,0,1));
                   xmlWriter.WriteEndElement();
                   END;
                   IF IGST_Base_Amount<>0 THEN BEGIN
                   xmlWriter.WriteStartElement('field');
                     xmlWriter.WriteElementString('name','igst');
                     xmlWriter.WriteElementString('value',FORMAT(IGST_Base_Amount,0,1));
                   xmlWriter.WriteEndElement();
                   END;
        
                   xmlWriter.WriteStartElement('field');
                     xmlWriter.WriteElementString('name','associate_name');
                     xmlWriter.WriteElementString('value','');
                   xmlWriter.WriteEndElement();
        
                   xmlWriter.WriteStartElement('field');
                     xmlWriter.WriteElementString('name','associate_code');
                     xmlWriter.WriteElementString('value',FORMAT(USERID));
                   xmlWriter.WriteEndElement();
        
        
                   CLEAR(Credit_card_no);
                   IF SalesInvoiceHeader.PayByCreditNo1<>'' THEN BEGIN
                     POS:=STRPOS(Credit_card_no,SalesInvoiceHeader.PayByCreditNo1);
                     IF POS=0 THEN
                     Credit_card_no:=SalesInvoiceHeader.PayByCreditNo1;
                     END;
                   IF SalesInvoiceHeader.PayByCreditNo2<>'' THEN BEGIN
                     POS:=STRPOS(Credit_card_no,SalesInvoiceHeader.PayByCreditNo2);
                     IF POS=0 THEN
                     Credit_card_no+=','+SalesInvoiceHeader.PayByCreditNo2;
                     END;
                   IF SalesInvoiceHeader.PayByCreditNo3<>'' THEN BEGIN
                     POS:=STRPOS(Credit_card_no,SalesInvoiceHeader.PayByCreditNo3);
                     IF POS=0 THEN
                     Credit_card_no+=','+SalesInvoiceHeader.PayByCreditNo3;
                     END;
                   IF SalesInvoiceHeader.PayByCreditNo4<>'' THEN BEGIN
                     POS:=STRPOS(Credit_card_no,SalesInvoiceHeader.PayByCreditNo4);
                     IF POS=0 THEN
                     Credit_card_no+=','+SalesInvoiceHeader.PayByCreditNo4;
                     END;
        
                   xmlWriter.WriteStartElement('field');
                     xmlWriter.WriteElementString('name','tender_card_name');
                     xmlWriter.WriteElementString('value',FORMAT(Credit_card_no));
                   xmlWriter.WriteEndElement();
        
                   CLEAR(Debit_card_no);
                   IF SalesInvoiceHeader.PayByDebitCdNo1<>'' THEN BEGIN
                     POS:=STRPOS(Debit_card_no,SalesInvoiceHeader.PayByDebitCdNo1);
                     IF POS=0 THEN
                     Debit_card_no:=SalesInvoiceHeader.PayByDebitCdNo1;
                     END;
                   IF SalesInvoiceHeader.PayByDebitNo2<>'' THEN BEGIN
                     POS:=STRPOS(Debit_card_no,SalesInvoiceHeader.PayByDebitNo2);
                     IF POS=0 THEN
                     Debit_card_no+=','+SalesInvoiceHeader.PayByDebitNo2;
                     END;
        
                   xmlWriter.WriteStartElement('field');
                     xmlWriter.WriteElementString('name','tender_card_type');
                     xmlWriter.WriteElementString('value',FORMAT(Debit_card_no));
                   xmlWriter.WriteEndElement();
        
        //Win-234 02-07-2019 Capillary Changes
                  xmlWriter.WriteStartElement('field');
                     xmlWriter.WriteElementString('name','loyalty_points_eligi');
                     IF RecCustSal.GET(SalesInvoiceHeader."Sell-to Customer No.") THEN;
                    // IF SalesInvoiceHeader."GST Customer Type"=SalesInvoiceHeader."GST Customer Type"::Unregistered THEN
                    IF RecCustSal."GST Customer Type"=RecCustSal."GST Customer Type"::Unregistered THEN
                     xmlWriter.WriteElementString('value',FORMAT(1))
                     ELSE
                     xmlWriter.WriteElementString('value',FORMAT(0));
                     {
                     IF SalesInvoiceHeader."GST Customer Type"=SalesInvoiceHeader."GST Customer Type"::Registered THEN
                     xmlWriter.WriteElementString('value',FORMAT(0));
                     }
                   xmlWriter.WriteEndElement();
                 //Win-234 02-07-2019 Capillary Changes
        
        
                 xmlWriter.WriteEndElement();//custom_fields
        
                 xmlWriter.WriteStartElement('line_items');
                   SalesInvoiceLine.RESET;
        
                   SalesInvoiceLine.SETRANGE("Document No.",SalesInvoiceHeader."No.");
                   SalesInvoiceLine.SETFILTER("No.",'<>%1&<>%2','512040','512073');
                   IF SalesInvoiceLine.FINDSET THEN BEGIN
                   REPEAT
        
                     //
                     CLEAR(IMEI_no);
                     CLEAR(Serial_no);
                     RecSSH.RESET;
                     RecSSH.SETRANGE("Order No.",Sales_Order_No);
                     IF RecSSH.FINDFIRST THEN
                       RecILE.RESET;
                       RecILE.SETFILTER("Document No.",'%1',RecSSH."No.");
                       RecILE.SETRANGE("Item No.",SalesInvoiceLine."No.");
                       IF RecILE.FINDSET THEN BEGIN
                         POS:=STRPOS(Serial_no,RecILE."Serial No.");
                         IF (POS=0) AND (RecILE."Serial No."<>'') THEN
                            IF Serial_no='' THEN
                            Serial_no+=RecILE."Serial No."
                            ELSE
                            Serial_no:=Serial_no +','+RecILE."Serial No.";
                         POS1:=STRPOS(IMEI_no,RecILE."IMEI No.");
                         IF (POS1=0) AND (RecILE."IMEI No."<>'') THEN
                            IF IMEI_no='' THEN
                            IMEI_no+=RecILE."IMEI No."
                            ELSE
                            IMEI_no:=IMEI_no +','+RecILE."IMEI No.";
                       END;
                     //
                   xmlWriter.WriteStartElement('line_item');
                       xmlWriter.WriteElementString('serial',FORMAT(SalesInvoiceLine."Line No."));
                       xmlWriter.WriteElementString('type','regular');
                       xmlWriter.WriteElementString('amount',FORMAT(ROUND(SalesInvoiceLine."Amount To Customer",0.1,'='),0,1));
                       xmlWriter.WriteElementString('description',SalesInvoiceLine.Description);
                       xmlWriter.WriteElementString('item_code',FORMAT(SalesInvoiceLine."Vendor Part Code"));
                       xmlWriter.WriteElementString('qty',FORMAT(SalesInvoiceLine.Quantity));
                       xmlWriter.WriteElementString('rate',FORMAT(SalesInvoiceLine."Unit Price Incl. of Tax",0,1));
                       xmlWriter.WriteElementString('value',FORMAT((SalesInvoiceLine."Unit Price Incl. of Tax" * SalesInvoiceLine.Quantity),0,1));
                      // xmlWriter.WriteElementString('discount',FORMAT(SalesInvoiceLine."Line Discount Amount",0,1));
                       xmlWriter.WriteElementString('discount',FORMAT(ROUND(SalesInvoiceLine."MRP Discount Amount",0.1,'='),0,1));
                         xmlWriter.WriteStartElement('extended_fields');
                           xmlWriter.WriteStartElement('field');
                             xmlWriter.WriteElementString('name','imei_number');
                             xmlWriter.WriteElementString('value',IMEI_no);
                           xmlWriter.WriteEndElement();
                           xmlWriter.WriteStartElement('field');
                             xmlWriter.WriteElementString('name','Serial_number');
                             xmlWriter.WriteElementString('value',Serial_no);
                           xmlWriter.WriteEndElement();
        
                          CLEAR(StateGST);
                          CLEAR(CentralGST);
                          CLEAR(IntegratedGST);
                          DetailedGSTLedgerEntry.RESET;
                          DetailedGSTLedgerEntry.SETRANGE("Document No.",SalesInvoiceHeader."No.");
                          DetailedGSTLedgerEntry.SETFILTER(DetailedGSTLedgerEntry."No.",'%1',SalesInvoiceLine."No.");
                          DetailedGSTLedgerEntry.SETFILTER("Document Line No.",'%1',SalesInvoiceLine."Line No.");
                          IF DetailedGSTLedgerEntry.FINDSET THEN BEGIN
                            REPEAT
                              IF DetailedGSTLedgerEntry."GST Component Code"='CGST' THEN
                                  CentralGST:=(DetailedGSTLedgerEntry."GST Amount"*-1);
        
                              IF DetailedGSTLedgerEntry."GST Component Code"='SGST' THEN
                                  StateGST:=(DetailedGSTLedgerEntry."GST Amount"*-1);
        
                              IF DetailedGSTLedgerEntry."GST Component Code"='IGST' THEN
                                  IntegratedGST:=(DetailedGSTLedgerEntry."GST Amount"*-1);
                            UNTIL DetailedGSTLedgerEntry.NEXT=0;
                            END;
        
                           xmlWriter.WriteStartElement('field');
                             xmlWriter.WriteElementString('name','StateGST');
                             xmlWriter.WriteElementString('value',FORMAT(StateGST,0,1));
                           xmlWriter.WriteEndElement();
                           xmlWriter.WriteStartElement('field');
                             xmlWriter.WriteElementString('name','CentralGST');
                             xmlWriter.WriteElementString('value',FORMAT(CentralGST,0,1));
                           xmlWriter.WriteEndElement();
                           xmlWriter.WriteStartElement('field');
                             xmlWriter.WriteElementString('name','IntegratedGST');
                             xmlWriter.WriteElementString('value',FORMAT(IntegratedGST,0,1));
                           xmlWriter.WriteEndElement();
                         xmlWriter.WriteEndElement();//extended_fields
                   xmlWriter.WriteEndElement();//line_item
                  UNTIL SalesInvoiceLine.NEXT=0;
                  END;
                  //SHIELD LINE++
                  Line_no:=SalesInvoiceLine."Line No.";
                  SalesInvoiceHeader1.RESET;
                  SalesInvoiceHeader1.SETRANGE("Ref. Invoice No.",SalesInvoiceLine."Document No.");
                  SalesInvoiceHeader1.SETFILTER(Shield,'%1',TRUE);
                  IF SalesInvoiceHeader1.FINDFIRST THEN BEGIN
                     SalesInvoiceLine1.RESET;
                     SalesInvoiceLine1.SETRANGE("Document No.",SalesInvoiceHeader1."No.");
                     SalesInvoiceLine1.SETFILTER("No.",'%1','310008');
                     IF SalesInvoiceLine1.FINDSET THEN BEGIN
                     REPEAT
                         Line_no+=10000;
                         xmlWriter.WriteStartElement('line_item');
                             xmlWriter.WriteElementString('serial',FORMAT(Line_no));
                             xmlWriter.WriteElementString('type','regular');
                             xmlWriter.WriteElementString('amount',FORMAT(ROUND(SalesInvoiceLine1."Shield Value",0.1,'='),0,1));
                             xmlWriter.WriteElementString('description',SalesInvoiceLine1.Description);
                             xmlWriter.WriteElementString('item_code',FORMAT(SalesInvoiceLine1."No."));
                             xmlWriter.WriteElementString('qty',FORMAT(SalesInvoiceLine1.Quantity));
                             xmlWriter.WriteElementString('rate',FORMAT(SalesInvoiceLine1."Shield Value",0,1));
                             xmlWriter.WriteElementString('value',FORMAT((SalesInvoiceLine1."Shield Value" * SalesInvoiceLine1.Quantity),0,1));
                            // xmlWriter.WriteElementString('discount',FORMAT(SalesInvoiceLine."Line Discount Amount",0,1));
                             xmlWriter.WriteElementString('discount','0');
                               xmlWriter.WriteStartElement('extended_fields');
                                 xmlWriter.WriteStartElement('field');
                                   xmlWriter.WriteElementString('name','imei_number');
                                   xmlWriter.WriteElementString('value','');
                                 xmlWriter.WriteEndElement();
                                 xmlWriter.WriteStartElement('field');
                                   xmlWriter.WriteElementString('name','Serial_number');
                                   xmlWriter.WriteElementString('value','');
                                 xmlWriter.WriteEndElement();
        
                                CLEAR(StateGST);
                                CLEAR(CentralGST);
                                CLEAR(IntegratedGST);
                                DetailedGSTLedgerEntry.RESET;
                                DetailedGSTLedgerEntry.SETRANGE("Document No.",SalesInvoiceHeader1."No.");
                                DetailedGSTLedgerEntry.SETFILTER(DetailedGSTLedgerEntry."No.",'%1',SalesInvoiceLine1."No.");
                                DetailedGSTLedgerEntry.SETFILTER("Document Line No.",'%1',SalesInvoiceLine1."Line No.");
                                IF DetailedGSTLedgerEntry.FINDSET THEN BEGIN
                                  REPEAT
                                    IF DetailedGSTLedgerEntry."GST Component Code"='CGST' THEN
                                        CentralGST:=(DetailedGSTLedgerEntry."GST Amount"*-1);
        
                                    IF DetailedGSTLedgerEntry."GST Component Code"='SGST' THEN
                                        StateGST:=(DetailedGSTLedgerEntry."GST Amount"*-1);
        
                                    IF DetailedGSTLedgerEntry."GST Component Code"='IGST' THEN
                                        IntegratedGST:=(DetailedGSTLedgerEntry."GST Amount"*-1);
                                  UNTIL DetailedGSTLedgerEntry.NEXT=0;
                                  END;
        
                                 xmlWriter.WriteStartElement('field');
                                   xmlWriter.WriteElementString('name','StateGST');
                                   xmlWriter.WriteElementString('value',FORMAT(StateGST,0,1));
                                 xmlWriter.WriteEndElement();
                                 xmlWriter.WriteStartElement('field');
                                   xmlWriter.WriteElementString('name','CentralGST');
                                   xmlWriter.WriteElementString('value',FORMAT(CentralGST,0,1));
                                 xmlWriter.WriteEndElement();
                                 xmlWriter.WriteStartElement('field');
                                   xmlWriter.WriteElementString('name','IntegratedGST');
                                   xmlWriter.WriteElementString('value',FORMAT(IntegratedGST,0,1));
                                 xmlWriter.WriteEndElement();
                               xmlWriter.WriteEndElement();//extended_fields
                         xmlWriter.WriteEndElement();//line_item
        
                     UNTIL SalesInvoiceLine1.NEXT=0;
                     END;
                  END;
                  //SHIELD LINE--
                 xmlWriter.WriteEndElement();//line_items
        
            xmlWriter.WriteEndElement();//transaction
            xmlWriter.WriteEndElement();//root
          xmlWriter.WriteEndDocument();//end
          xmlWriter.Close();
        Post_sales_Transaction_XML(FileName,SalesInvoiceHeader);
        END;
        //for capillary --
        //MESSAGE('Done');
             //           IF EXISTS(FileName) THEN
               //         FILE.ERASE(FileName);
               *///WIN234 05082020

    end;


    procedure Post_Point_Redumption(FirstName: Text; Mobile_no: Text[30]; Sales_Order_No: Code[20])
    var
        FileName: Text;
        // xmlWriter: DotNet XmlTextWriter;
        // EncodingText: DotNet Encoding;//tk
        RecCustCap: Record 50011;
    begin
        /*
        //for capillary ++
        RecCustCap.RESET;
        RecCustCap.SETFILTER("Mobile No",'%1',('*'+Mobile_no));
        RecCustCap.SETRANGE("Sales Order No",Sales_Order_No);
        IF RecCustCap.FINDFIRST THEN BEGIN
          FileName := '\\mapleNAV\Navision\Dont Delete (Capilery Integration)\Post Point redumption\' + FirstName + Mobile_no + '.xml';
        
          IF ISNULL(xmlWriter) THEN
          xmlWriter := xmlWriter.XmlTextWriter(FileName, EncodingText.UTF8);
          xmlWriter.WriteStartDocument();//begin
            //Create Parent element
            xmlWriter.WriteStartElement('root');
              xmlWriter.WriteStartElement('redeem');
                xmlWriter.WriteElementString('points_redeemed',FORMAT(RecCustCap."Points To Be Redeem"));
                xmlWriter.WriteElementString('transaction_number',FORMAT(RecCustCap."Sales Order No"));
                xmlWriter.WriteStartElement('customer');
                  xmlWriter.WriteElementString('mobile',FORMAT(RecCustCap."Mobile No"));
                  xmlWriter.WriteElementString('external_id','');
                  xmlWriter.WriteElementString('email',FORMAT(RecCustCap.Email));
                xmlWriter.WriteEndElement();//customer
                xmlWriter.WriteElementString('notes','');
                xmlWriter.WriteElementString('validation_code',FORMAT(RecCustCap."Validation Code For Points"));
                xmlWriter.WriteElementString('redemption_time',(FORMAT(TODAY,0,'<Year4>-<Month,2>-<Day,2>')+' '+FORMAT(TIME,0,'<hours24>:<minutes,2>:<seconds,2>')));
        
              xmlWriter.WriteEndElement();//redeem
            xmlWriter.WriteEndElement();//root
          xmlWriter.WriteEndDocument();//end
          xmlWriter.Close();
        END;
        //for capillary --
        //MESSAGE('Done');
        *///WIN234 05082020

    end;


    procedure Post_Coupon_Redumption(FirstName: Text; Mobile_no: Text[30]; Sales_Order_No: Code[20])
    var
        FileName: Text;
        // xmlWriter: DotNet XmlTextWriter;
        // EncodingText: DotNet Encoding;//tk
        RecCustCap: Record 50011;
        SalesLine: Record 37;
        Total_Amount: Decimal;
    begin
        /*
        //for capillary ++
        RecCustCap.RESET;
        RecCustCap.SETFILTER("Mobile No",'%1',('*'+Mobile_no));
        RecCustCap.SETRANGE("Sales Order No",Sales_Order_No);
        IF RecCustCap.FINDFIRST THEN BEGIN
          FileName := '\\mapleNAV\Navision\Dont Delete (Capilery Integration)\Post Coupon redumption\' + FirstName + Mobile_no +'.xml';
        
                   IF EXISTS(FileName) THEN
                    FILE.ERASE(FileName);
        
                 CLEAR(Total_Amount);
                   SalesLine.RESET;
                   SalesLine.SETRANGE("Document No.",Sales_Order_No);
                   IF SalesLine.FINDSET THEN BEGIN
                   REPEAT
                     Total_Amount+=SalesLine."Amount To Customer";
        
                   UNTIL SalesLine.NEXT=0;
                   END;
        
          IF ISNULL(xmlWriter) THEN
          xmlWriter := xmlWriter.XmlTextWriter(FileName, EncodingText.UTF8);
          xmlWriter.WriteStartDocument();//begin
            //Create Parent element
            xmlWriter.WriteStartElement('root');
              xmlWriter.WriteStartElement('coupon');
                xmlWriter.WriteElementString('code',FORMAT(RecCustCap."Coupon Code"));
                xmlWriter.WriteElementString('validation_code','ABCD1234');
                xmlWriter.WriteStartElement('customer');
                  xmlWriter.WriteElementString('mobile',FORMAT(RecCustCap."Mobile No"));
                xmlWriter.WriteEndElement();//customer
        
                xmlWriter.WriteElementString('redemption_time',(FORMAT(TODAY,0,'<Year4>/<Month,2>/<Day,2>')+' '+FORMAT(TIME,0,'<hours24>:<minutes,2>:<seconds,2>')));
                xmlWriter.WriteStartElement('transaction');
                  xmlWriter.WriteElementString('number',FORMAT(Sales_Order_No));
                  xmlWriter.WriteElementString('amount',FORMAT(RecCustCap."Amount Payable",0,1));
        
                xmlWriter.WriteEndElement();//transaction
              xmlWriter.WriteEndElement();//coupon
            xmlWriter.WriteEndElement();//root
          xmlWriter.WriteEndDocument();//end
          xmlWriter.Close();
        END;
        //for capillary --
        //MESSAGE('Done');
        *///WIN234 05082020

    end;

    local procedure Post_sales_Transaction_XML(FilePath: Text; SalesInvHead: Record 112)
    var
        Output_File_Path: Text;
    // DLL: DotNet Class1;//tk
    begin
        /*
        //RecUserSetup.RESET;
        //RecUserSetup.SETRANGE("User ID",USERID);
        //IF  RecUserSetup.FINDFIRST THEN BEGIN
          RecCust.GET(SalesInvHead."Sell-to Customer No.");
          RecLocation.RESET;
          RecLocation.SETRANGE(Code,SalesInvHead."Location Code");
          IF RecLocation.FINDFIRST THEN BEGIN
             RecLocation.TESTFIELD("Capillary ID");
             RecLocation.TESTFIELD("Capillary Password");
          END;
        //END;
        Output_File_Path:='\\mapleNAV\Navision\Dont Delete (Capilery Integration)\Transaction Responce\Response\' + SalesInvHead."Location Code" +RecCust."Phone No."+'-'+FORMAT(TODAY,0,'<Day,2>-<Month,2>-<Year4>')+ '.xml';
        Create_Blank_XML(Output_File_Path);
        {
        IF GUIALLOWED THEN BEGIN
        DLL:=DLL.Class1;
        IF NOT DLL.CheckInterNet('http://www.google.com') THEN BEGIN
          MESSAGE('Internet is Not Working');
          EXIT;
          END;
        END;
        }
        
        //IF GUIALLOWED THEN BEGIN
        DLL:=DLL.Class1;
        DLL.PostXMLData('https://apac2.api.capillarytech.com/v1.1/transaction/add?format=xml','POST','',RecLocation."Capillary ID",RecLocation."Capillary Password",FilePath,Output_File_Path);
        Transaction_Responce_Sales(Output_File_Path,SalesInvHead);
        //END;
        *///WIN234 05082020

    end;

    local procedure Transaction_Responce_Sales(FilePath: Text; SalesInvHead: Record 112)
    var
        NodeName: Text;
        // xml: DotNet XmlDocument;
        // XMLNode: DotNet XmlNode;
        // RecXML: Codeunit 50008;//tk
        RecCustCapill: Record 50011;
    begin
        /*
        xml:=xml.XmlDocument;
        xml.Load(FilePath);
        NodeName:='//status/success';
        IF RecXML.FindNode(xml,NodeName,XMLNode) THEN
           IF XMLNode.InnerText='true' THEN BEGIN
        
                        NodeName:='//response/transactions/transaction/item_status/message';
                        IF RecXML.FindNode(xml,NodeName,XMLNode) THEN
                            MESSAGE(XMLNode.InnerText);
                            Pos_1:=STRPOS(XMLNode.InnerText,',');
                           IF Pos_1<>0 THEN
                              SalesInvHead."Capillary Error":=COPYSTR(XMLNode.InnerText,1,Pos_1-1);
                         SalesInvHead."Capillary Posted":=TRUE;
                         NodeName:='//response/transactions/transaction/id';
                         IF RecXML.FindNode(xml,NodeName,XMLNode) THEN
                            SalesInvHead."Capillary Transaction Id":=XMLNode.InnerText;
                         SalesInvHead.MODIFY(TRUE);
                         RecCust.GET(SalesInvHead."Sell-to Customer No.");
                         RecCustCapill.SETRANGE("Sales Order No",SalesInvHead."Order No.");
                         RecCustCapill.SETFILTER("Mobile No",'%1',('*'+RecCust."Phone No."));
                         IF RecCustCapill.FINDFIRST THEN
                           BEGIN
                              NodeName:='//response/transactions/transaction/id';
                              IF RecXML.FindNode(xml,NodeName,XMLNode) THEN
                                 EVALUATE(RecCustCapill."Transaction ID",XMLNode.InnerText);
                                 RecCustCapill."Posting Date":=SalesInvHead."Posting Date";
                                 NodeName:='//response/transactions/transaction/side_effects/effect/awarded_points';
                                 IF RecXML.FindNode(xml,NodeName,XMLNode) THEN
                                    RecCustCapill."Awarded Points":=TextToDecimal(XMLNode.InnerText);
                                 RecCustCapill.MODIFY(TRUE);
                           END;
        
        
            END
            ELSE BEGIN
                            NodeName:='//response/transactions/transaction/item_status/message';
                            IF RecXML.FindNode(xml,NodeName,XMLNode) THEN
                            MESSAGE(XMLNode.InnerText);
                            Pos_1:=STRPOS(XMLNode.InnerText,',');
                            IF Pos_1=0 THEN
                            Pos_1:=STRPOS(XMLNode.InnerText,'.');
                           IF Pos_1<>0 THEN
                              SalesInvHead."Capillary Error":=COPYSTR(XMLNode.InnerText,1,Pos_1-1);
                           IF (SalesInvHead."Capillary Error"='') AND(STRLEN(XMLNode.InnerText)<90) THEN
                              SalesInvHead."Capillary Error":=XMLNode.InnerText;
                            SalesInvHead."Capillary Posted":=FALSE;
                            SalesInvHead.MODIFY(TRUE);
                           // MESSAGE('%1',SalesInvHead."Capillary Error");
            END;
                 //       IF EXISTS(FilePath) THEN
                   //     FILE.ERASE(FilePath);
                   *///WIN234 05082020

    end;


    procedure Create_Blank_XML(FilePath: Text)
    var
    // xmlWriter: DotNet XmlTextWriter;
    // EncodingText: DotNet Encoding;//tk
    begin
        /*
        IF EXISTS(FilePath) THEN
        FILE.ERASE(FilePath);

        IF ISNULL(xmlWriter) THEN
        xmlWriter := xmlWriter.XmlTextWriter(FilePath, EncodingText.UTF8);
        xmlWriter.WriteStartDocument();//begin
         xmlWriter.WriteStartElement('root');
         xmlWriter.WriteEndElement;
        xmlWriter.WriteEndDocument();//end
        xmlWriter.Close();
        *///WIN234 05082020

    end;


    procedure Send_Transaction_Information_Return(SalesCrMemoHeader: Record 114)
    var
        FileName: Text;
        // xmlWriter: DotNet XmlTextWriter;
        // EncodingText: DotNet Encoding;//tk
        SalesCrMemoLine: Record 115;
        StateGST: Decimal;
        CentralGST: Decimal;
        IntegratedGST: Decimal;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        Total_Amount: Decimal;
        Gross_amount: Decimal;
        IGST_Base_Amount: Decimal;
        CGST_Base_Amount: Decimal;
        SGST_Base_Amount: Decimal;
        RecILE: Record 32;
        IMEI_no: Text;
        Serial_no: Text;
        POS: Integer;
        POS1: Integer;
        // DLL: DotNet Class1;//tk
        RecSIH: Record 112;
        RecSIH1: Record 112;
    begin

        /*IF GUIALLOWED THEN BEGIN
        DLL:=DLL.Class1;
        IF NOT DLL.CheckInterNet('http://www.google.com') THEN BEGIN
          MESSAGE('Internet is Not Working');
          EXIT;
          END;
        END;
        */
        /*
        RecCust.GET(SalesCrMemoHeader."Sell-to Customer No.");
        IF SalesCrMemoHeader."Sales Order Type"=SalesCrMemoHeader."Sales Order Type"::Retail THEN
        BEGIN
          FileName := '\\mapleNAV\Navision\Dont Delete (Capilery Integration)\Transaction Responce\' + SalesCrMemoHeader."Location Code" + RecCust."Phone No."+'-'+FORMAT(TODAY,0,'<Day,2>-<Month,2>-<Year4>') +'.xml';
        
                   IF EXISTS(FileName) THEN
                    FILE.ERASE(FileName);
        
                   CLEAR(Total_Amount);
                   SalesCrMemoLine.RESET;
                   SalesCrMemoLine.SETRANGE("Document No.",SalesCrMemoHeader."No.");
                   SalesCrMemoLine.SETFILTER("No.",'<>%1','');
                   IF SalesCrMemoLine.FINDSET THEN BEGIN
                   REPEAT
                     Total_Amount+=SalesCrMemoLine."Amount To Customer";
                     Gross_amount+=(SalesCrMemoLine.Quantity * SalesCrMemoLine."Unit Price Incl. of Tax");
                   UNTIL SalesCrMemoLine.NEXT=0;
                   END;
                   IF Gross_amount=0 THEN
                     Gross_amount:=Total_Amount;
                  // MESSAGE(FORMAT(Gross_amount));
                  // MESSAGE(FORMAT(Total_Amount));
        
          IF ISNULL(xmlWriter) THEN
          xmlWriter := xmlWriter.XmlTextWriter(FileName,EncodingText.UTF8);
          xmlWriter.WriteStartDocument();//begin
            //Create Parent element
            xmlWriter.WriteStartElement('root');
            xmlWriter.WriteStartElement('transaction');
              //Create Child elements
              xmlWriter.WriteElementString('type','return');
              xmlWriter.WriteElementString('amount',FORMAT(Total_Amount,0,1));
             // xmlWriter.WriteElementString('discount',FORMAT(RecCustCap."Point Redeem Value In Rs."+RecCustCap."Coupon Value In Rs."));
              RecSIH.RESET;
              RecSIH.SETRANGE("No.",SalesCrMemoHeader."Applies-to Doc. No.");
              IF RecSIH.FINDFIRST THEN
                IF RecSIH."Order No."<>'' THEN
              xmlWriter.WriteElementString('number',FORMAT(RecSIH."Order No."))
                ELSE BEGIN
                RecSIH1.RESET;
                RecSIH1.SETRANGE("No.",RecSIH."Ref. Invoice No.");
                IF RecSIH1.FINDFIRST THEN
              xmlWriter.WriteElementString('number',FORMAT(RecSIH1."Order No."))
                END;
        
              xmlWriter.WriteElementString('return_type','LINE_ITEM');//FULL/AMOUNT/LINE
              xmlWriter.WriteElementString('billing_time',(FORMAT(RecSIH."Posting Date",0,'<Year4>-<Month,2>-<Day,2>')+' '+FORMAT(RecSIH."Time of Removal",0,'<hours24>:<minutes,2>:<seconds,2>')));
              xmlWriter.WriteElementString('gross_amount',FORMAT(Gross_amount,0,1));
        
                 xmlWriter.WriteStartElement('customer');
                    xmlWriter.WriteElementString('mobile',FORMAT(RecCust."Phone No."));
                    xmlWriter.WriteElementString('email',FORMAT(RecCust."E-Mail"));
                    xmlWriter.WriteElementString('firstname',RecCust.Name);
                    xmlWriter.WriteElementString('lastname','');
        
                       xmlWriter.WriteStartElement('custom_fields');
                          xmlWriter.WriteStartElement('field');
                            xmlWriter.WriteElementString('name','birthday');
                            xmlWriter.WriteElementString('value',FORMAT(RecCust."Customer Birth Date",0,'<Year4>/<Month,2>/<Day,2>'));
        
                          xmlWriter.WriteEndElement();
                          xmlWriter.WriteStartElement('field');
                            xmlWriter.WriteElementString('name','anniversary');
                            xmlWriter.WriteElementString('value',FORMAT(RecCust."Aniversary Date",0,'<Year4>/<Month,2>/<Day,2>'));
                          xmlWriter.WriteEndElement();
                          xmlWriter.WriteStartElement('field');
                            xmlWriter.WriteElementString('name','gender');
                            xmlWriter.WriteElementString('value',FORMAT(RecCust.Gender));
                          xmlWriter.WriteEndElement();
                       xmlWriter.WriteEndElement();//custom_fields
                 xmlWriter.WriteEndElement();//customer
        
                 xmlWriter.WriteStartElement('payment_details');
                   xmlWriter.WriteStartElement('payment');
        
                     xmlWriter.WriteElementString('mode','cash');
                     xmlWriter.WriteElementString('value',FORMAT(Total_Amount,0,1));
                   xmlWriter.WriteEndElement();
                 xmlWriter.WriteEndElement();//payment_details
        
                 xmlWriter.WriteStartElement('custom_fields');
                 CLEAR(CGST_Base_Amount);
                 CLEAR(SGST_Base_Amount);
                 CLEAR(IGST_Base_Amount);
                 DetailedGSTLedgerEntry.RESET;
                 DetailedGSTLedgerEntry.SETRANGE("Document No.",SalesCrMemoHeader."No.");
                 IF DetailedGSTLedgerEntry.FINDSET THEN BEGIN
                   REPEAT
                     IF DetailedGSTLedgerEntry."GST Component Code"='CGST' THEN
                         CGST_Base_Amount+=(DetailedGSTLedgerEntry."GST Amount");
        
                     IF DetailedGSTLedgerEntry."GST Component Code"='SGST' THEN
                         SGST_Base_Amount+=(DetailedGSTLedgerEntry."GST Amount");
        
                     IF DetailedGSTLedgerEntry."GST Component Code"='IGST' THEN
                         IGST_Base_Amount+=(DetailedGSTLedgerEntry."GST Amount");
                   UNTIL DetailedGSTLedgerEntry.NEXT=0;
                   END;
        
                   IF CGST_Base_Amount<>0 THEN BEGIN
                   xmlWriter.WriteStartElement('field');
                     xmlWriter.WriteElementString('name','cgst');
                     xmlWriter.WriteElementString('value',FORMAT(CGST_Base_Amount,0,1));
                   xmlWriter.WriteEndElement();
                   END;
                   IF SGST_Base_Amount<>0 THEN BEGIN
                   xmlWriter.WriteStartElement('field');
                     xmlWriter.WriteElementString('name','sgst');
                     xmlWriter.WriteElementString('value',FORMAT(SGST_Base_Amount,0,1));
                   xmlWriter.WriteEndElement();
                   END;
                   IF IGST_Base_Amount<>0 THEN BEGIN
                   xmlWriter.WriteStartElement('field');
                     xmlWriter.WriteElementString('name','igst');
                     xmlWriter.WriteElementString('value',FORMAT(IGST_Base_Amount,0,1));
                   xmlWriter.WriteEndElement();
                   END;
        
                   xmlWriter.WriteStartElement('field');
                     xmlWriter.WriteElementString('name','associate_name');
                     xmlWriter.WriteElementString('value','');
                   xmlWriter.WriteEndElement();
        
                   xmlWriter.WriteStartElement('field');
                     xmlWriter.WriteElementString('name','associate_code');
                     xmlWriter.WriteElementString('value',FORMAT(USERID));
                   xmlWriter.WriteEndElement();
        
                   xmlWriter.WriteStartElement('field');
                     xmlWriter.WriteElementString('name','tender_card_name');
                     xmlWriter.WriteElementString('value','');
                   xmlWriter.WriteEndElement();
        
                   xmlWriter.WriteStartElement('field');
                     xmlWriter.WriteElementString('name','tender_card_type');
                     xmlWriter.WriteElementString('value','');
                   xmlWriter.WriteEndElement();
                   //Win-234 02-07-2019 Capillary Changes
                  xmlWriter.WriteStartElement('field');
                     xmlWriter.WriteElementString('name','loyalty_points_eligi');
                     IF RecCustSalCr.GET(SalesCrMemoHeader."Sell-to Customer No.") THEN;
        
                    // IF SalesCrMemoHeader."GST Customer Type"=SalesCrMemoHeader."GST Customer Type"::Unregistered THEN
                    IF RecCustSalCr."GST Customer Type"=RecCustSalCr."GST Customer Type"::Unregistered THEN
                     xmlWriter.WriteElementString('value',FORMAT(1))
                     ELSE
                     xmlWriter.WriteElementString('value',FORMAT(0));
                     {
                     IF SalesCrMemoHeader."GST Customer Type"=SalesCrMemoHeader."GST Customer Type"::Registered THEN
                     xmlWriter.WriteElementString('value',FORMAT(0));
                     }
                   xmlWriter.WriteEndElement();
                 //Win-234 02-07-2019 Capillary Changes
        
        
                 xmlWriter.WriteEndElement();//custom_fields
        
                 xmlWriter.WriteStartElement('line_items');
        
                   SalesCrMemoLine.RESET;
                   SalesCrMemoLine.SETRANGE("Document No.",SalesCrMemoHeader."No.");
                   SalesCrMemoLine.SETFILTER(Quantity,'<>%1',0);
                   SalesCrMemoLine.SETFILTER("No.",'<>%1&<>%2','512040','512073');
                   IF SalesCrMemoLine.FINDSET THEN BEGIN
                   REPEAT
                     CLEAR(IMEI_no);
                     CLEAR(Serial_no);
                       RecILE.RESET;
                       RecILE.SETFILTER("Document No.",'%1',SalesCrMemoLine."Document No.");
                       RecILE.SETRANGE("Item No.",SalesCrMemoLine."No.");
                       RecILE.SETFILTER("Document Line No.",'%1',SalesCrMemoLine."Line No.");
                       IF RecILE.FINDSET THEN BEGIN
                         POS:=STRPOS(Serial_no,RecILE."Serial No.");
                            IF Serial_no='' THEN
                            Serial_no+=RecILE."Serial No."
                            ELSE
                            Serial_no:=Serial_no +','+RecILE."Serial No.";
                         POS1:=STRPOS(IMEI_no,RecILE."IMEI No.");
                         IF (POS1=0) AND (RecILE."IMEI No."<>'') THEN
                            IF IMEI_no='' THEN
                            IMEI_no+=RecILE."IMEI No."
                            ELSE
                            IMEI_no:=IMEI_no +','+RecILE."IMEI No.";
                       END;
                     //
                   xmlWriter.WriteStartElement('line_item');
                       xmlWriter.WriteElementString('serial',FORMAT(SalesCrMemoLine."Line No."));
                       xmlWriter.WriteElementString('type','regular');
                       xmlWriter.WriteElementString('amount',FORMAT(ROUND(SalesCrMemoLine."Amount To Customer",0.1,'='),0,1));
                       xmlWriter.WriteElementString('description',SalesCrMemoLine.Description);
        
                       IF SalesCrMemoLine."Vendor Part Code"<>'' THEN
                       xmlWriter.WriteElementString('item_code',FORMAT(SalesCrMemoLine."Vendor Part Code"))
                       ELSE
                       xmlWriter.WriteElementString('item_code',FORMAT(SalesCrMemoLine."No."));
        
                       xmlWriter.WriteElementString('qty',FORMAT(SalesCrMemoLine.Quantity));
        
                       IF SalesCrMemoLine."Price Inclusive of Tax"=TRUE THEN
                       xmlWriter.WriteElementString('rate',FORMAT(SalesCrMemoLine."Unit Price Incl. of Tax",0,1))
                       ELSE
                       xmlWriter.WriteElementString('rate',FORMAT(ROUND(SalesCrMemoLine."Amount To Customer",0.1,'='),0,1));
        
                       IF SalesCrMemoLine."Price Inclusive of Tax"=TRUE THEN
                       xmlWriter.WriteElementString('value',FORMAT((SalesCrMemoLine."Unit Price Incl. of Tax" * SalesCrMemoLine.Quantity),0,1))
                       ELSE
                       xmlWriter.WriteElementString('value',FORMAT((ROUND(SalesCrMemoLine."Amount To Customer",0.1,'=')),0,1));
        
                       xmlWriter.WriteElementString('discount',FORMAT((ROUND(SalesCrMemoLine."MRP Discount Amount",0.1,'=')),0,1));
        
                         xmlWriter.WriteStartElement('extended_fields');
                           xmlWriter.WriteStartElement('field');
                             xmlWriter.WriteElementString('name','imei_number');
                             xmlWriter.WriteElementString('value',IMEI_no);
                           xmlWriter.WriteEndElement();
                           xmlWriter.WriteStartElement('field');
                             xmlWriter.WriteElementString('name','Serial_number');
                             xmlWriter.WriteElementString('value',Serial_no);
                           xmlWriter.WriteEndElement();
        
                          CLEAR(StateGST);
                          CLEAR(CentralGST);
                          CLEAR(IntegratedGST);
                          DetailedGSTLedgerEntry.RESET;
                          DetailedGSTLedgerEntry.SETRANGE("Document No.",SalesCrMemoLine."Document No.");
                          DetailedGSTLedgerEntry.SETFILTER(DetailedGSTLedgerEntry."No.",'%1',SalesCrMemoLine."No.");
                          DetailedGSTLedgerEntry.SETFILTER("Document Line No.",'%1',SalesCrMemoLine."Line No.");
                          IF DetailedGSTLedgerEntry.FINDSET THEN BEGIN
                            REPEAT
                              IF DetailedGSTLedgerEntry."GST Component Code"='CGST' THEN
                                  CentralGST:=(DetailedGSTLedgerEntry."GST Amount");
        
                              IF DetailedGSTLedgerEntry."GST Component Code"='SGST' THEN
                                  StateGST:=(DetailedGSTLedgerEntry."GST Amount");
        
                              IF DetailedGSTLedgerEntry."GST Component Code"='IGST' THEN
                                  IntegratedGST:=(DetailedGSTLedgerEntry."GST Amount");
                            UNTIL DetailedGSTLedgerEntry.NEXT=0;
                            END;
        
                           xmlWriter.WriteStartElement('field');
                             xmlWriter.WriteElementString('name','StateGST');
                             xmlWriter.WriteElementString('value',FORMAT(StateGST,0,1));
                           xmlWriter.WriteEndElement();
                           xmlWriter.WriteStartElement('field');
                             xmlWriter.WriteElementString('name','CentralGST');
                             xmlWriter.WriteElementString('value',FORMAT(CentralGST,0,1));
                           xmlWriter.WriteEndElement();
                           xmlWriter.WriteStartElement('field');
                             xmlWriter.WriteElementString('name','IntegratedGST');
                             xmlWriter.WriteElementString('value',FORMAT(IntegratedGST,0,1));
                           xmlWriter.WriteEndElement();
                         xmlWriter.WriteEndElement();//extended_fields
                   xmlWriter.WriteEndElement();//line_item
                  UNTIL SalesCrMemoLine.NEXT=0;
                  END;
                 xmlWriter.WriteEndElement();//line_items
        
            xmlWriter.WriteEndElement();//transaction
            xmlWriter.WriteEndElement();//root
          xmlWriter.WriteEndDocument();//end
          xmlWriter.Close();
        Post_return_Transaction_XML(FileName,SalesCrMemoHeader);
        END;
        //for capillary --
        //MESSAGE('Done');
        
                     //   IF EXISTS(FileName) THEN
                       // FILE.ERASE(FileName);
                       *///WIN234 05082020

    end;

    local procedure Post_return_Transaction_XML(FilePath: Text; SalesCrMemoHeader: Record 114)
    var
    // Output_File_Path: Text;
    // DLL: DotNet Class1;//tk
    begin
        //RecUserSetup.RESET;
        //RecUserSetup.SETRANGE("User ID",USERID);
        //IF  RecUserSetup.FINDFIRST THEN BEGIN
        /*
        RecCust.GET(SalesCrMemoHeader."Sell-to Customer No.");
          RecLocation.RESET;
          RecLocation.SETRANGE(Code,SalesCrMemoHeader."Location Code");
          IF RecLocation.FINDFIRST THEN BEGIN
            RecLocation.TESTFIELD("Capillary ID");
            RecLocation.TESTFIELD("Capillary Password");
          END;
        //END;
        Output_File_Path:='\\mapleNAV\Navision\Dont Delete (Capilery Integration)\Transaction Responce\Response\' + SalesCrMemoHeader."Location Code" +RecCust."Phone No."+'-'+FORMAT(TODAY,0,'<Day,2>-<Month,2>-<Year4>')+'.xml';
        Create_Blank_XML(Output_File_Path);
        //IF GUIALLOWED THEN BEGIN
        
        DLL:=DLL.Class1;
        DLL.PostXMLData('https://apac2.api.capillarytech.com/v1.1/transaction/add?format=xml','POST','',RecLocation."Capillary ID",RecLocation."Capillary Password",FilePath,Output_File_Path);
        //END;
        Transaction_Responce_Return(Output_File_Path,SalesCrMemoHeader);
        *///WIN234 05082020

    end;

    local procedure Transaction_Responce_Return(FilePath: Text; SalesCrMemoHeader: Record 114)
    var
        NodeName: Text;
        // xml: DotNet XmlDocument;//tk
        // XMLNode: DotNet XmlNode;
        // RecXML: Codeunit "50008";
        RecCustCapill: Record 50011;
    begin
        /*
        xml:=xml.XmlDocument;
        xml.Load(FilePath);
        NodeName:='//status/success';
        IF RecXML.FindNode(xml,NodeName,XMLNode) THEN
           IF XMLNode.InnerText='true' THEN BEGIN
        
                        NodeName:='//response/transactions/transaction/item_status/message';
                        IF RecXML.FindNode(xml,NodeName,XMLNode) THEN
                            MESSAGE(XMLNode.InnerText);
                            Pos_1:=STRPOS(XMLNode.InnerText,',');
                           IF Pos_1<>0 THEN
                              SalesCrMemoHeader."Capillary Error":=COPYSTR(XMLNode.InnerText,1,Pos_1-1);
                         SalesCrMemoHeader."Capillary Posted":=TRUE;
                         NodeName:='//response/transactions/transaction/id';
                         IF RecXML.FindNode(xml,NodeName,XMLNode) THEN
                            SalesCrMemoHeader."Capillary Transaction Id":=XMLNode.InnerText;
                         SalesCrMemoHeader.MODIFY(TRUE);
                         RecCust.GET(SalesCrMemoHeader."Sell-to Customer No.");
                         RecCustCapill.SETRANGE("Sales Order No",SalesCrMemoHeader."Pre-Assigned No.");
                         RecCustCapill.SETFILTER("Mobile No",'%1',('*'+RecCust."Phone No."));
                         IF RecCustCapill.FINDFIRST THEN
                           BEGIN
                              NodeName:='//response/transactions/transaction/id';
                              IF RecXML.FindNode(xml,NodeName,XMLNode) THEN
                                 EVALUATE(RecCustCapill."Transaction ID",XMLNode.InnerText);
                                 RecCustCapill."Posting Date":=SalesCrMemoHeader."Posting Date";
                                 NodeName:='//response/transactions/transaction/side_effects/effect/awarded_points';
                                 IF RecXML.FindNode(xml,NodeName,XMLNode) THEN
                                     RecCustCapill."Awarded Points":=TextToDecimal(XMLNode.InnerText);
                                 RecCustCapill.MODIFY(TRUE);
                           END;
                        IF EXISTS(FilePath) THEN
                        FILE.ERASE(FilePath);
        
            END
            ELSE BEGIN
                            NodeName:='//response/transactions/transaction/item_status/message';
                            IF RecXML.FindNode(xml,NodeName,XMLNode) THEN
                            MESSAGE(XMLNode.InnerText);
                            Pos_1:=STRPOS(XMLNode.InnerText,',');
                            IF Pos_1=0 THEN
                            Pos_1:=STRPOS(XMLNode.InnerText,'.');
                           IF Pos_1<>0 THEN
                              SalesCrMemoHeader."Capillary Error":=COPYSTR(XMLNode.InnerText,1,Pos_1-1);
                           IF (SalesCrMemoHeader."Capillary Error"='') AND(STRLEN(XMLNode.InnerText)<90) THEN
                              SalesCrMemoHeader."Capillary Error":=XMLNode.InnerText;
        
                            SalesCrMemoHeader."Capillary Posted":=FALSE;
                            SalesCrMemoHeader.MODIFY(TRUE);
                            IF EXISTS(FilePath) THEN
                            FILE.ERASE(FilePath);
            END;
            *///WIN234 05082020

    end;


    procedure Create_customer(Customer_no: Code[20])
    var
        FileName: Text;
    // xmlWriter: DotNet XmlTextWriter;
    // EncodingText: DotNet Encoding;
    // Output_File_Path: Text;
    // DLL: DotNet Class1;
    begin
        /*
        //for capillary ++
        RecUserSetup.RESET;
        RecUserSetup.SETRANGE(RecUserSetup."User ID",USERID);
        IF RecUserSetup.FINDFIRST THEN BEGIN
          RecUserSetup.TESTFIELD("Location Code");
          RecLocation.RESET;
          RecLocation.SETRANGE(Code,RecUserSetup."Location Code");
          IF RecLocation.FINDFIRST THEN BEGIN
            RecLocation.TESTFIELD("Capillary ID");
            RecLocation.TESTFIELD("Capillary Password");
          END;
        END;
        {
        DLL:=DLL.Class1;
        IF NOT DLL.CheckInterNet('http://www.google.com') THEN BEGIN
          MESSAGE('Internet is Not Working');
          EXIT;
          END;
          }
        RecCust.RESET;
        RecCust.SETRANGE("No.",Customer_no);
        IF RecCust.FINDFIRST THEN BEGIN
        IF RecCust."Phone No."='' THEN
          EXIT;
          IF RecCust."No."='CR/1718/00000382' THEN
          FileName := '\\mapleNAV\Navision\Dont Delete (Capilery Integration)\New_Customer\' + 'Gaur Foods Pvt Ltd-Sachin Bahl' + RecCust."Phone No." +'.xml'
          ELSE
          FileName := '\\mapleNAV\Navision\Dont Delete (Capilery Integration)\New_Customer\' + RecCust.Name + RecCust."Phone No." +'.xml';
          Create_Blank_XML(FileName);
        
          IF ISNULL(xmlWriter) THEN
          xmlWriter := xmlWriter.XmlTextWriter(FileName, EncodingText.UTF8);
          xmlWriter.WriteStartDocument();//begin
            //Create Parent element
            xmlWriter.WriteStartElement('root');
              xmlWriter.WriteStartElement('customer');
                xmlWriter.WriteElementString('mobile',FORMAT(RecCust."Phone No."));
                xmlWriter.WriteElementString('email',FORMAT(RecCust."E-Mail"));
                xmlWriter.WriteElementString('external_id','');
                xmlWriter.WriteElementString('first_name',FORMAT(RecCust.Name));
                xmlWriter.WriteElementString('last_name','');
                xmlWriter.WriteElementString('gender',FORMAT(RecCust.Gender));
                xmlWriter.WriteElementString('joined_on',(FORMAT(TODAY,0,'<Year4>/<Month,2>/<Day,2>')+' '+FORMAT(TIME,0,'<hours24>:<minutes,2>:<seconds,2>')));
                xmlWriter.WriteElementString('joined_store','');
                xmlWriter.WriteStartElement('custom_fields');
                  xmlWriter.WriteStartElement('field');
                    xmlWriter.WriteElementString('name','Customer_code');
                    xmlWriter.WriteElementString('value',FORMAT(RecCust."No."));
                  xmlWriter.WriteEndElement();//field
                  xmlWriter.WriteStartElement('field');
                    xmlWriter.WriteElementString('name','address');
                    xmlWriter.WriteElementString('value',FORMAT(RecCust.Address));
                  xmlWriter.WriteEndElement();//field
                  xmlWriter.WriteStartElement('field');
                    xmlWriter.WriteElementString('name','age_group');
                    xmlWriter.WriteElementString('value',FORMAT(RecCust."Age Group"));
                  xmlWriter.WriteEndElement();//field
                  xmlWriter.WriteStartElement('field');
                    xmlWriter.WriteElementString('name','birthday');
                    xmlWriter.WriteElementString('value',FORMAT(RecCust."Customer Birth Date"));
                  xmlWriter.WriteEndElement();//field
                  xmlWriter.WriteStartElement('field');
                    xmlWriter.WriteElementString('name','anniversary');
                    xmlWriter.WriteElementString('value',FORMAT(RecCust."Aniversary Date"));
                  xmlWriter.WriteEndElement();//field
                  xmlWriter.WriteStartElement('field');
                    xmlWriter.WriteElementString('name','income_group');
                    xmlWriter.WriteElementString('value',FORMAT(RecCust."Income Group"));
                  xmlWriter.WriteEndElement();//field
                  xmlWriter.WriteStartElement('field');
                    xmlWriter.WriteElementString('name','work_address');
                    xmlWriter.WriteElementString('value',RecCust.Address);
                  xmlWriter.WriteEndElement();//field
                  xmlWriter.WriteStartElement('field');
                    xmlWriter.WriteElementString('name','pincode');
                    xmlWriter.WriteElementString('value',FORMAT(RecCust."Post Code"));
                  xmlWriter.WriteEndElement();//field
                  xmlWriter.WriteStartElement('field');
                    xmlWriter.WriteElementString('name','mobile_two');
                    xmlWriter.WriteElementString('value','');
                  xmlWriter.WriteEndElement();//field
                  xmlWriter.WriteStartElement('field');
                    xmlWriter.WriteElementString('name','email_two');
                    xmlWriter.WriteElementString('value','');
                  xmlWriter.WriteEndElement();//field
        
                xmlWriter.WriteEndElement();//custom_fields
              xmlWriter.WriteEndElement();//customer
            xmlWriter.WriteEndElement();//root
          xmlWriter.WriteEndDocument();//end
          xmlWriter.Close();
        END;
        Output_File_Path:='\\mapleNAV\Navision\Dont Delete (Capilery Integration)\New_Customer\Response\' + RecCust.Name + RecCust."Phone No." + '.xml';
        Create_Blank_XML(Output_File_Path);
        DLL:=DLL.Class1;
        DLL.PostXMLData('https://apac2.api.capillarytech.com/v1.1/customer/add?format=xml','POST','',RecLocation."Capillary ID",RecLocation."Capillary Password",FileName,Output_File_Path);
        Customer_create_Response(Output_File_Path);
        //for capillary --
        //MESSAGE('Done');
                     //   IF EXISTS(FileName) THEN
                     //   FILE.ERASE(FileName);
                     *///WIN234 05082020

    end;

    local procedure Customer_create_Response(FilePath: Text)
    var
        NodeName: Text;
    // xml: DotNet XmlDocument;
    // XMLNode: DotNet XmlNode;
    // RecXML: Codeunit "50008";//tk
    begin
        /*
        xml:=xml.XmlDocument;
        xml.Load(FilePath);
        NodeName:='//status/success';
        IF RecXML.FindNode(xml,NodeName,XMLNode) THEN
           IF XMLNode.InnerText='true' THEN BEGIN
        
        
                            NodeName:='//response/customers/customer/item_status/message';
                            IF RecXML.FindNode(xml,NodeName,XMLNode) THEN
                             MESSAGE(XMLNode.InnerText);
                      //  IF EXISTS(FilePath) THEN
                      //  FILE.ERASE(FilePath);
        
            END
            ELSE BEGIN
                            NodeName:='//response/customers/customer/item_status/message';
                            IF RecXML.FindNode(xml,NodeName,XMLNode) THEN
                            MESSAGE(XMLNode.InnerText);
                         //   IF EXISTS(FilePath) THEN
                          //  FILE.ERASE(FilePath);
        
            END;
            *///WIN234 05082020

    end;


    procedure GetCustomerDataFromCapillary(FilePath: Text; Sales_order_no: Code[20])
    var
        NodeName: Text;
        Mobile_no: Text;
        RecCustCap: Record 50011;
        // xml: DotNet XmlDocument;
        // XMLNode: DotNet XmlNode;
        RecSH: Record 36;
        RecCustCap1: Record 50011;
        // Customers: DotNet XmlNodeList;
        cnt: Integer;
        I: Integer;
    begin
        /*
        RecCustCap.SETRANGE("Sales Order No",Sales_order_no);
        IF RecCustCap.FINDFIRST THEN
          EXIT;
        
        xml:=xml.XmlDocument;
        xml.Load(FilePath);
        NodeName:='//status/success';
        IF FindNode(xml,NodeName,XMLNode) THEN
           IF XMLNode.InnerText='true' THEN BEGIN
        
                        RecCustCap.INIT;
                        RecSH.SETRANGE("No.",Sales_order_no);
                        IF RecSH.FINDFIRST THEN;
                        RecCust.SETRANGE("No.",RecSH."Sell-to Customer No.");
                        IF RecCust.FINDFIRST THEN;
                        RecCustCap."Mobile No":=RecCust."Phone No.";
                        RecCustCap."Sales Order No":=Sales_order_no;
                        RecCustCap.Address:=RecSH."Bill-to Address";
                        RecCustCap."Customer Code":=RecSH."Sell-to Customer No.";
                        RecCustCap."First Name":=RecCust.Name;
                        RecCustCap."Age Group":=RecCust."Age Group";
                        RecCustCap."Income Group":=RecCust."Income Group";
                        RecCustCap.Anniversary:=RecCust."Aniversary Date";
                        RecCustCap.Birthdate:=RecCust."Customer Birth Date";
                        RecCustCap.Pincode:=RecCust."Post Code";
                        RecCustCap.Gender:=RecCust.Gender;
        
                       // NodeName:='//customers/customer/email';
                      //  IF FindNode(xml,NodeName,XMLNode) THEN BEGIN
                        RecCustCap.Email:=RecCust."E-Mail";
                      //  END;
        
                        IF RecCustCap1.FINDLAST THEN
                          RecCustCap."Transaction ID":=RecCustCap1."Transaction ID"+100
                        ELSE RecCustCap."Transaction ID":=100;
        
                              NodeName:='//customers/customer/loyalty_points';
                              IF FindNode(xml,NodeName,XMLNode) THEN BEGIN
                              RecCustCap."Customer Points":=TextToDecimal(XMLNode.InnerText);
                              END;
                               {
                              //FOR MULTIPLE COUPON ++
                              NodeName:='//customers/customer/coupons/coupon/code';
                              Customers:=xml.SelectNodes(NodeName);
                              cnt:=Customers.Count;
                              I:=0;
                              IF cnt>0 THEN BEGIN
                                  REPEAT
                                    RecCustCoupCap.INIT;
                                    XMLNode := Customers.Item(I);
                                    RecCustCoupCap."Coupon Code":=XMLNode.InnerText;
                                    RecCustCoupCap."Sales Order No":=Sales_order_no;
                                    RecCustCoupCap."Mobile No":=RecCust."Phone No.";
                                    RecCustCoupCap.INSERT(TRUE);
                                    I+=1;
                                    cnt:=cnt-1;
                                  UNTIL cnt=0;
                              END;
                              //FOR MULTIPLE COUPON --
                              }
                        RecCustCap.INSERT(TRUE);
                        MESSAGE('Done');
                       // IF EXISTS(FilePath) THEN
                        //FILE.ERASE(FilePath);
           END
           ELSE BEGIN
           MESSAGE('Customer Data is not available in Capillary');
                        RecCustCap.INIT;
                        RecSH.SETRANGE("No.",Sales_order_no);
                        IF RecSH.FINDFIRST THEN;
                        RecCust.SETRANGE("No.",RecSH."Sell-to Customer No.");
                        IF RecCust.FINDFIRST THEN;
                        RecCustCap."Mobile No":=RecCust."Phone No.";
                        RecCustCap."Sales Order No":=Sales_order_no;
                        RecCustCap.Address:=RecSH."Bill-to Address";
                        RecCustCap."Customer Code":=RecSH."Sell-to Customer No.";
                        RecCustCap."First Name":=RecCust.Name;
                        RecCustCap.Email:=RecCust."E-Mail";
                        RecCustCap."Age Group":=RecCust."Age Group";
                        RecCustCap."Income Group":=RecCust."Income Group";
                        RecCustCap.Anniversary:=RecCust."Aniversary Date";
                        RecCustCap.Birthdate:=RecCust."Customer Birth Date";
                        RecCustCap.Pincode:=RecCust."Post Code";
                        RecCustCap.Gender:=RecCust.Gender;
        
                        IF RecCustCap1.FINDLAST THEN
                          RecCustCap."Transaction ID":=RecCustCap1."Transaction ID"+100
                        ELSE RecCustCap."Transaction ID":=100;
        
                        RecCustCap."Customer Points":=0;
                        RecCustCap."Customer Points Value in Rs":=0;
        
                        RecCustCap.INSERT(TRUE);
                        MESSAGE('Done');
        
           END;
           *///WIN234 05082020

    end;


    //procedure FindNode(XMLRootNode: DotNet XmlNode; NodePath: Text[250]; var FoundXMLNode: DotNet XmlNode): Boolean
    //begin
    /*
    FoundXMLNode := XMLRootNode.SelectSingleNode(NodePath);
    IF ISNULL(FoundXMLNode) THEN
      EXIT(FALSE)
    ELSE
      EXIT(TRUE);
     */ //WIN234 05082020

    //end;


    procedure TextToDecimal(stream: Text): Decimal
    var
        DecimalValue: Decimal;
    begin
        EVALUATE(DecimalValue, stream);
        EXIT(DecimalValue);
    end;
}

