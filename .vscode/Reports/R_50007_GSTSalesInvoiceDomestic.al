report 50007 "GST-Sales Invoice Domestic"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './GSTSalesInvoiceDomestic.rdl';
    Caption = 'Print GST-Sales Invoice Ecom';

    dataset
    {
        //dataitem(DataItem1000000022; Table112)
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            column(Text; Text)
            {
            }
            column(TradeinDeviceModelno_SalesInvoiceHeader; "Trade-in Device Model no.")
            {
            }
            column(ServifyTransferAmount_SalesInvoiceHeader; "Servify Transfer Amount" + "Servify Bonus Amount" + "Maple Buyback Amt")
            {
            }
            column(ServifyBonusAmount_SalesInvoiceHeader; "Servify Bonus Amount")
            {
            }
            column(Text17; Text17)
            {
            }
            column(LUTNo; LUTNo)
            {
            }
            column(Total_Amount; Total_Amount)
            {
            }
            column(AmountInWord; AmountInWord[1])
            {
            }
            column(Orderid; "Sales Invoice Header"."Order ID")
            {

            }
            //Rushab_CCIT++
            column(SystemCreatedAt; SystemCreatedAt)
            {

            }
            //Rushab_CCIT--
            column(LocStateDesc; LocStateDesc)
            {
            }
            column(LocAddr1; LocAddr1)
            {
            }
            column(LocAddr2; LocAddr2)
            {
            }
            column(LocCity; LocCity)
            {
            }
            column(LocGSTRegNo; LocGSTRegNo)
            {
            }
            column(LocName; LocName)
            {
            }
            column(LocStateCode; LocStateCode)
            {
            }
            column(CurrentTime; System.Time)
            {
            }
            column(companyInfo_Name; companyInfo.Name)
            {
            }
            column(companyInfo_Address; companyInfo.Address)
            {
            }
            column(companyInfo_Address2; companyInfo."Address 2")
            {
            }
            column(companyInfo_City; companyInfo.City + '-' + companyInfo."Post Code")
            {
            }
            column(companyInfo_State; companyInfo."State Code")
            {
            } //ccot_kj standard field
            column(CompanyPicture; companyInfo.Picture)
            {
            }
            column(County; companyInfo.County)
            {
            }
            column(CompanyHomePage; companyInfo."Home Page")
            {
            }
            column(CompanyEmail; companyInfo."E-Mail")
            {
            }
            column(CompanyPhone; companyInfo."Phone No.")
            {
            }
            column(IFSC_CompanyInfo; companyInfo."SWIFT Code")
            {
            }
            column(CompanyFax; companyInfo."Fax No.")
            {
            }
            column(ComGStReg; companyInfo."GST Registration No.")
            {
            }
            column(Com_PAN_No; companyInfo."P.A.N. No.")
            {
            }
            column(CompanyBankName; companyInfo."Bank Name")
            {
            }
            column(Com_Bank_Acc_No; companyInfo."Bank Account No.")
            {
            }
            column(BankName_; companyInfo."Bank Name")
            {
            }
            column(VendorItemCode; RecItem."Vendor Item No.")
            {
            }
            column(CompStateCode; CompStateCode)
            {
            }
            column(cust_Name; cust.Name)
            {
            }
            column(cust_Address; cust.Address)
            {
            }
            column(State_Code; cust."State Code")
            {
            }
            column(cust_GST_Registration_No; cust."GST Registration No.")
            {
            }
            column(cust_PAN_No; cust."P.A.N. No.")
            {
            }
            column(SalesShipment_No; SalesShipmentHdr."No.")
            {
            }
            column(SalesPerCode; SalesShipmentHdr."Salesperson Code" + '-' + RecSalesPerson.Name)
            {
            }
            column(PromoCode_SalesInvoiceHeader; "Sales Invoice Header"."External Document No.")
            {
            }
            column(DispatchDocNo_SalesInvoiceHeader; "Sales Invoice Header"."Dispatch Doc. No.")
            {
            }
            column(DispatchThrough_SalesInvoiceHeader; "Sales Invoice Header"."Dispatch Through")
            {
            }
            column(From_Name; From_Name)
            {
            }

            column(From_Address; From_Address)
            {
            }
            column(FromAddress2; FromAddress2)
            {
            }
            column(From_StateCode; From_StateCode)
            {
            }
            column(From_City; From_City)
            {
            }
            column(From_State; From_State)
            {
            }
            column(From_GSTIN; From_GSTIN)
            {
            }
            column(From_ARN; From_ARN)
            {

            }
            column(FromStateNmCode; FromStateNmCode)
            {
            }
            column(To_Name; To_Name)
            {
            }
            column(To_Address; To_Address)
            {
            }
            column(ToAddress2; ToAddress2)
            {
            }
            column(To_StateCode; To_StateCode)
            {
            }
            column(To_City; To_City)
            {
            }
            column(To_State; To_State)
            {
            }
            column(To_GSTIN; To_GSTIN)
            {
            }
            column(State; State)
            {
            }
            column(PostingDate_SalesInvoiceHeader; "Sales Invoice Header"."Posting Date")
            {
            }
            column(No_SalesInvoiceHeader; "Sales Invoice Header"."No.")
            {
            }
            column(DeliveryNote_SalesInvoiceHeader; "Sales Invoice Header"."Delivery Note")
            {
            }
            column(AmounttoCustomer_SalesInvoiceHeader; Total_Amount)
            {
            } //kj
            column(NetPayableAmt; NetPayableAmt)
            {
            }
            column(PaymentTermsCode_SalesInvoiceHeader; PayTerm)
            {
            }
            column(RemAmt; RemAmt)
            {
            }
            column(ExternalDocumentNo_SalesInvoiceHeader; "Sales Invoice Header"."External Document No.")
            {
            }
            column(DocumentDate_SalesInvoiceHeader; "Sales Invoice Header"."Document Date")
            {
            }
            column(companystate; companystate)
            {
            }
            column(To_GSTStateCode; To_GSTStateCode)
            {
            }
            column(From_GSTStateCode; From_GSTStateCode)
            {
            }
            column(PaymentMode; PaymentMode)
            {
            }
            column(AmtInWordNetPayable; AmtInWordNetPayable[1])
            {
            }
            column(BuyersOrderNo_SalesInvoiceHeader; "Sales Invoice Header"."Buyer's Order No.")
            {
            }
            column(BuyersOrderDt_SalesInvoiceHeader; "Sales Invoice Header"."Buyer's Order Dt")
            {
            }
            column(BankNm; BankNm)
            {
            }
            column(BankAddr; BankAdd)
            {
            }
            column(BankAddr2; BankAdd2)
            {
            }
            column(BankCty; BankCity)
            {
            }
            column(BankPinCode; BankPinCode)
            {
            }
            column(BankIFSCCd; BankIFSC)
            {
            }
            column(BankAccntNo; BankAccntNo)
            {
            }
            column(ShiptoName_SalesInvoiceHeader; "Sales Invoice Header"."Ship-to Name")
            {
            }
            column(ShiptoName2_SalesInvoiceHeader; "Sales Invoice Header"."Ship-to Name 2")
            {
            }
            column(ShiptoAddress_SalesInvoiceHeader; "Sales Invoice Header"."Ship-to Address")
            {
            }
            column(ShiptoAddress2_SalesInvoiceHeader; "Sales Invoice Header"."Ship-to Address 2")
            {
            }
            column(ShiptoCity_SalesInvoiceHeader; "Sales Invoice Header"."Ship-to City" + ' ' + "Sales Invoice Header"."Ship-to Post Code")
            {
            }
            column(ShiptoPostCode_SalesInvoiceHeader; "Sales Invoice Header"."Ship-to Post Code")
            {
            }
            column(ShiptoCode_SalesInvoiceHeader; "Sales Invoice Header"."Ship-to Code")
            {
            }
            column(ShipToName; shiptoName)
            {
            }
            column(ShiptoAddress; shiptoAddr1)
            {
            }
            column(ShiptoAddress2; shiptoAddr2)
            {
            }
            column(ShiptoCity; shiptoCity)
            {
            }
            column(ShiptoState; ShiptoState)
            {
            }
            column(ShiptoStateDesc; ShiptoStateDesc)
            {
            }
            column(shiptoStateCode; shiptoStateCode)
            {
            }
            column(ShiptoGSTIN; shiptoGSTN)
            {
            }
            column(RefNo; RefNo)
            {
            }
            column(PaymentMode1; PaymentMode1)
            {
            }
            column(PaymentMode2; PaymentMode2)
            {
            }
            column(GSTWithoutPaymentofDuty_SalesInvoiceHeader; "Sales Invoice Header"."GST Without Payment of Duty")
            {
            }
            column(LocationStateCode_SalesInvoiceHeader; "Sales Invoice Header"."Location State Code")
            {
            }
            column(OrderIDVAR; "Sales Invoice Header"."Order ID") //kj
            {
            }
            //dataitem(CopyLoop; Table2000000026)
            dataitem(CopyLoop; Integer)

            {
                DataItemTableView = SORTING(Number);
                //dataitem(PageLoop; Table2000000026)
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(Title; Title)
                    {
                    }
                    column(BilltoCustNo_SalesInvHdr; "Sales Invoice Header"."Bill-to Customer No.")
                    {
                    }
                    column(Ship_to_Name; "Sales Invoice Header"."Ship-to Name")
                    {
                    }
                    column(Ship_to_Address; "Sales Invoice Header"."Ship-to Address")
                    {
                    }
                    column(DueDate_SalesInvoiceHeader; "Sales Invoice Header"."Due Date")
                    {
                    }
                    column(OrderNo_SalesInvoiceHeader; "Sales Invoice Header"."Order No.")
                    {
                    }
                    column(OrderDate_SalesInvoiceHeader; "Sales Invoice Header"."Order Date")
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(PayTerm; PayTerm)
                    {
                    }
                    //dataitem(DataItem1000000001; Table113)
                    dataitem("Sales Invoice Line"; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("Document No.", "Line No.")
                                            WHERE(Type = FILTER(Item | "G/L Account"),
                                                  "No." = FILTER(<> 512073));
                        column(SrNo; "Sr.No")
                        {
                        }
                        column(SerialNo_SalesInvoiceLine; SerialNo) //cckj SerialNo: text[30]; //cckj  IMEINo: Code[20]; //cckj

                        {
                        }
                        column(IMEINo_SalesInvoiceLine; IMEINo) //cckj
                        {
                        }
                        column(MRP_Value; "MRP Value") { }
                        column(Description; "Sales Invoice Line".Description)
                        {
                        }
                        column(Type_SalesInvoiceLine; "Sales Invoice Line".Type)
                        {
                        }
                        column(HSN_SAC_Code; "Sales Invoice Line"."HSN/SAC Code")
                        {
                        }
                        column(Quantity; "Sales Invoice Line".Quantity)
                        {
                        }
                        column(UnitofMeasure; "Sales Invoice Line"."Unit of Measure Code")
                        {
                        }
                        column(Unit_Price; "Sales Invoice Line"."Unit Price")
                        {
                        }
                        column(Amount; "Sales Invoice Line".Amount)
                        {
                        }
                        column(LineDiscountAmt_SalesInvoiceLine; "Sales Invoice Line"."Line Discount Amount")
                        {
                        }
                        column(LineDiscountPer_SalesInvoiceLine; "Sales Invoice Line"."Line Discount %")
                        {
                        }
                        column(GST_Base_Amount; "Sales Invoice Line".Amount)
                        {
                        }
                        column(GSTAmt; ABS(GSTAmt))
                        {
                        }
                        column(GSTRate; GSTRate)
                        {
                        }
                        column(IGSTAmt; ABS(IGSTAmt))
                        {
                        }
                        column(CGSTAmt; ABS(CGSTAmt))
                        {
                        }
                        column(SGSTAmt; ABS(SGSTAmt))
                        {
                        }
                        column(CGSTRate; CGSTRate)
                        {
                        }
                        column(IGSTRate; IGSTRate)
                        {
                        }
                        column(SGSTRate; SGSTRate)
                        {
                        }
                        column(GSTComponent; GSTComponent)
                        {
                        }
                        column(TotalGSTAmount_SalesInvoiceLine; '')
                        //  column(TotalGSTAmount_SalesInvoiceLine; "Sales Invoice Line"."Total GST Amount")
                        {
                        }  //ccit_kj standard field
                        column(TotalInvoiceAmt; TotalInvoiceAmt)
                        {
                        }
                        column(GlbFrtCharge; GlbFrtCharge)
                        {
                        }
                        column(GlbInsCharge; GlbInsCharge)
                        {
                        }
                        column(GlbPackCharge; GlbPackCharge)
                        {
                        }
                        column(CESSAmount_SalesInvoiceLine; '')
                        //column(CESSAmount_SalesInvoiceLine; "Sales Invoice Line"."CESS Amount")
                        {
                        }  //ccit_kj standard field
                        column(ItemNo; "Sales Invoice Line"."No.")
                        {
                        }
                        column(GSTComponentCGST; GSTComponentCGST)
                        {
                        }
                        column(GSTComponentSGST; GSTComponentSGST)
                        {
                        }
                        column(GSTComponentIGST; GSTComponentIGST)
                        {
                        }
                        column(AmountToCustomer_SalesInvoiceLine; "Sales Invoice Line".Amount + ABS(CGSTAmt) + ABS(SGSTAmt) + ABS(IGSTAmt))
                        // column(AmountToCustomer_SalesInvoiceLine; ROUND("Sales Invoice Line"."Amount To Customer"))
                        {
                        }  //ccit_kj standard field
                        column(CntLines; CntLines)
                        {
                        }
                        column(LineAmount; "Sales Invoice Line"."Line Amount")
                        {
                        }
                        column(VendorItemPartCode; VendorItemPartCode)
                        {
                        }
                        column(comments; comments)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            //win316++
                            IF (("Sales Invoice Line"."No." = '512040') OR ("Sales Invoice Line"."No." = '512073')) AND ("Sales Invoice Line".Type = "Sales Invoice Line".Type::"G/L Account") THEN
                                CurrReport.SKIP;
                            //win316--
                            linecount += 1;

                            //ReportCheck.InitTextVariable;
                            //ReportCheck.FormatNoText(AmountInWord,Total_Amount,' ');

                            LineAmt += "Sales Invoice Line"."Line Amount";
                            //MESSAGE(FORMAT(LineAmt));

                            CntLines := "Sales Invoice Line".COUNT;
                            //MESSAGE(FORMAT(CntLines));


                            //kj_ record not in BC +++++++++++++++++++++++
                            /*  StructureLineDetails.RESET;
                             StructureLineDetails.SETRANGE(Type, StructureLineDetails.Type::Sale);
                             StructureLineDetails.SETRANGE("Document Type", StructureLineDetails."Document Type"::Invoice);
                             StructureLineDetails.SETRANGE("Invoice No.", "Document No.");
                             StructureLineDetails.SETRANGE("Item No.", "No.");
                             StructureLineDetails.SETRANGE("Line No.", "Line No.");
                             IF StructureLineDetails.FIND('-') THEN
                                 REPEAT
                                     IF NOT StructureLineDetails."Payable to Third Party" THEN BEGIN

                                         IF StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::Charges THEN BEGIN

                                             ChargesAmount := ChargesAmount + ABS(StructureLineDetails.Amount);

                                             IF (StructureLineDetails."Tax/Charge Group" = 'FREIGHT') OR
                                                (StructureLineDetails."Tax/Charge Code" = 'FREIGHT') THEN
                                                 GlbFrtCharge := GlbFrtCharge + ABS(StructureLineDetails.Amount)


                                             ELSE
                                                 IF (StructureLineDetails."Tax/Charge Group" = 'INSURANCE') OR
                                               (StructureLineDetails."Tax/Charge Code" = 'INSURANCE') THEN
                                                     // BEGIN
                                                     GlbInsCharge := GlbInsCharge + ABS(StructureLineDetails.Amount)
                                                 //  MESSAGE(FORMAT(GlbInsCharge));
                                                 //  END
                                                 ELSE
                                                     IF (StructureLineDetails."Tax/Charge Group" = 'PACKING') OR
                                                   (StructureLineDetails."Tax/Charge Code" = 'PACKING') THEN
                                                         // BEGIN
                                                         GlbPackCharge := GlbPackCharge + ABS(StructureLineDetails.Amount)
                                                     // MESSAGE(FORMAT(GlbPackCharge));
                                                     //  END
                                                     ELSE
                                                         GlbOtherCharge := GlbOtherCharge + ABS(StructureLineDetails.Amount);
                                         END;
                                     END;
                                 UNTIL StructureLineDetails.NEXT = 0; */ //kj_ record not in BC ------------------
                                                                         //WIN275




                            //win352++
                            "Sr.No" += 1;
                            Clear(SerialNo);
                            clear(IMEINo);
                            CLEAR(CGSTRate);
                            CLEAR(CGSTAmt);
                            CLEAR(GSTComponentCGST);
                            CLEAR(SGSTRate);
                            CLEAR(SGSTAmt);
                            CLEAR(GSTComponentSGST);
                            CLEAR(IGSTRate);
                            CLEAR(IGSTAmt);
                            CLEAR(GSTComponentIGST);
                            GSTDetailLeger.RESET;
                            GSTDetailLeger.SETRANGE(GSTDetailLeger."Document No.", "Sales Invoice Line"."Document No.");
                            GSTDetailLeger.SETRANGE(GSTDetailLeger."No.", "Sales Invoice Line"."No.");
                            GSTDetailLeger.SETRANGE(GSTDetailLeger."Document Line No.", "Sales Invoice Line"."Line No.");
                            IF GSTDetailLeger.FINDSET THEN
                                REPEAT
                                    IF GSTDetailLeger."GST Component Code" = 'CGST' THEN BEGIN
                                        GSTComponentCGST := 'CGST';
                                        CGSTRate := GSTDetailLeger."GST %";
                                        CGSTAmt := GSTDetailLeger."GST Amount";
                                    END ELSE
                                        IF GSTDetailLeger."GST Component Code" = 'SGST' THEN BEGIN
                                            GSTComponentSGST := 'SGST';
                                            SGSTRate := GSTDetailLeger."GST %";
                                            SGSTAmt := GSTDetailLeger."GST Amount";
                                        END ELSE
                                            IF GSTDetailLeger."GST Component Code" = 'IGST' THEN BEGIN
                                                GSTComponentIGST := 'IGST';
                                                IGSTRate := GSTDetailLeger."GST %";
                                                IGSTAmt := GSTDetailLeger."GST Amount";
                                            END;
                                UNTIL GSTDetailLeger.NEXT = 0;

                            //WIN347++
                            CLEAR(VendorItemPartCode);
                            RecItem.RESET;
                            RecItem.SETRANGE(RecItem."No.", "Sales Invoice Line"."No.");
                            IF RecItem.FINDFIRST THEN
                                VendorItemPartCode := RecItem."Vendor Part Code Long";
                            //WIN347--

                            //win347++ FOR COMMENTS
                            comments := '';
                            reccomment.RESET;
                            reccomment.SETFILTER(reccomment."No.", "Sales Invoice Line"."Document No.");
                            //reccomment.SETRANGE(reccomment."Line No.",lineno);
                            //reccomment.SETRANGE(reccomment."Line No.","Sales Invoice Line"."Line No.");
                            IF reccomment.FINDSET THEN
                                REPEAT
                                    comments += reccomment.Comment + ',';
                                UNTIL reccomment.NEXT = 0;
                            //win347--

                            /*FinalTotal:=FinalTotal+"Sales Invoice Line".Amount+GlbFrtCharge+GlbInsCharge+GlbPackCharge+IGSTAmt+CGSTAmt+SGSTAmt;
                            ReportCheck.InitTextVariable;
                            ReportCheck.FormatNoText(AmountInWord,FinalTotal,' ');
                            */

                            //cckj+++++++++++180823
                            if "Sales Invoice Line".Type = "Sales Invoice Line".Type::Item then begin
                                SalesShipLine.Reset();
                                SalesShipLine.SetRange("Order No.", "Sales Invoice Line"."Order No.");
                                SalesShipLine.SetRange("Line No.", "Sales Invoice Line"."Line No.");
                                // SalesShipLine.SetRange(Type, SalesShipLine.Type::Item);
                                if SalesShipLine.FindFirst() then begin
                                    repeat
                                        itemLedEntry.Reset();
                                        itemLedEntry.SetRange("Document No.", SalesShipLine."Document No.");
                                        itemLedEntry.SetRange("Item No.", SalesShipLine."No.");
                                        itemLedEntry.SetRange("Document Line No.", SalesShipLine."Line No.");
                                        if itemLedEntry.FindSet() then
                                            // repeat
                                            SerialNo := itemLedEntry."Serial No.";
                                        IMEINo := itemLedEntry."IMEI No.";
                                    until SalesShipLine.Next() = 0;
                                end;



                            end;

                            //cckj-----------180823


                        end;

                        trigger OnPreDataItem()
                        begin
                            linecount := 0;
                        end;
                    }
                    //dataitem(DataItem1000000132;Table2000000026)
                    dataitem(Integer; Integer)
                    {
                        DataItemLinkReference = "Sales Invoice Header";
                        column(Number_Integer; Integer.Number)
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            /*IF(linecount MOD maxline>0) THEN
                              spline:=maxline-(linecount MOD maxline)
                            ELSE
                              spline:=0;*/

                            //Integer.SETRANGE(Integer.Number,1,spline);

                            /*IF linecount > maxline THEN
                                spline := maxline - ROUND((linecount/maxline - ROUND(linecount/maxline,1,'<')) * maxline,1)
                            ELSE
                               spline := maxline - linecount;
                            
                            Integer.SETRANGE(Number,1,spline);
                            */
                            /*
                            IF linecount > 5 THEN
                                spline := 5 - ROUND((linecount/5 - ROUND(linecount/5,1,'<')) * 5,1)
                            ELSE
                               spline := 5 - linecount;
                            */
                            IF linecount > 4 THEN
                                spline := 4 - ROUND((linecount / 4 - ROUND(linecount / 4, 1, '<')) * 4, 1)
                            ELSE
                                spline := 4 - linecount;
                            //  MESSAGE(FORMAT(linecount));
                            //  MESSAGE(FORMAT(spline));
                            Integer.SETRANGE(Number, 1, spline);

                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    IF Number > 1 THEN BEGIN
                        CopyText := Text16502;
                        OutputNo += 1;
                    END;
                    CurrReport.PAGENO := 1;


                    //Win 275
                    IF OutputNo = 1 THEN BEGIN
                        Title := Text1;
                        "Sr.No" := 0;
                        TotAmt := 0;
                    END;

                    IF OutputNo = 2 THEN BEGIN
                        Title := Text2;
                        "Sr.No" := 0;
                        TotAmt := 0;
                    END;

                    IF OutputNo = 3 THEN BEGIN
                        Title := Text3;
                        "Sr.No" := 0;
                        TotAmt := 0;

                    END;
                end;

                trigger OnPostDataItem()
                begin
                    /*IF NOT CurrReport.PREVIEW THEN
                      SalesInvCountPrinted.RUN("Sales Invoice Header");
                      */

                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies) + cust."Invoice Copies";
                    IF NoOfLoops <= 0 THEN
                        NoOfLoops := 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF Location.GET("Sales Invoice Header"."Location Code") THEN BEGIN
                    IF Location.Code = 'M1107' THEN
                        Text := 'Online Purchase'
                    ELSE
                        Text := recSalesInvoiceHeader."Delivery Note"
                END;
                IF Location.GET("Sales Invoice Header"."Location Code") THEN BEGIN
                    IF Location.Code = 'M1107' THEN
                        Text17 := 'Maple Digital Technology International Pvt.Ltd-Ecom'
                    ELSE
                        Text17 := Location.Name
                END;
                RecSalesPerson.SETRANGE(RecSalesPerson.Code, "Sales Invoice Header"."Salesperson Code");
                IF RecSalesPerson.FINDFIRST THEN;
                RemAmt := 0;
                RecCLE.RESET;
                RecCLE.SETRANGE(RecCLE."Customer No.", "Sales Invoice Header"."Sell-to Customer No.");
                RecCLE.SETRANGE(RecCLE."Document No.", "Sales Invoice Header"."No.");
                IF RecCLE.FINDFIRST THEN BEGIN
                    RecCLE.CALCFIELDS("Remaining Amt. (LCY)", "Amount (LCY)");
                    RemAmt := RecCLE."Remaining Amt. (LCY)";
                    Total_Amount := RecCLE."Amount (LCY)";
                END;

                ReportCheck.InitTextVariable;
                ReportCheck.FormatNoText(AmountInWord, Total_Amount, ' ');


                IF BANKNAME <> '' THEN BEGIN
                    //bankdetrec.GET(CompInfo."Bank Code");
                    bankdetrec.GET(BANKNAME);
                    BankNm := bankdetrec.Name;
                    BankAdd := bankdetrec.Address;
                    BankAdd2 := bankdetrec."Address 2";
                    BankCity := bankdetrec.City;
                    BankPinCode := bankdetrec."Post Code";
                    BankIFSC := bankdetrec."IFSC Code";
                    BankAccntNo := bankdetrec."Bank Account No.";
                END
                ELSE BEGIN
                    //BANKNAME:='RBLCA621';
                    //BANKNAME := 'INDUSIND970';
                    BANKNAME := 'HDFCBK-571';
                    bankdetrec.GET(BANKNAME);
                    BankNm := bankdetrec.Name;
                    BankAdd := bankdetrec.Address;
                    BankAdd2 := bankdetrec."Address 2";
                    BankCity := bankdetrec.City;
                    BankPinCode := bankdetrec."Post Code";
                    BankIFSC := bankdetrec."IFSC Code";
                    BankAccntNo := bankdetrec."Bank Account No.";
                END;


                Fromcust.RESET;
                Fromcust.SETRANGE(Fromcust."No.", "Sales Invoice Header"."Sell-to Customer No.");
                IF Fromcust.FINDFIRST THEN BEGIN
                    From_Name := Fromcust.Name;
                    From_Address := Fromcust.Address;
                    FromAddress2 := Fromcust."Address 2";
                    From_City := Fromcust.City + '- ' + Fromcust."Post Code";
                    From_StateCode := Fromcust."State Code";
                    From_GSTIN := Fromcust."GST Registration No.";
                    FRom_ARN := Fromcust."ARN No.";

                END;

                StateRec.RESET;
                StateRec.SETRANGE(StateRec.Code, From_StateCode);
                IF StateRec.FINDFIRST THEN BEGIN
                    From_State := StateRec.Description;
                    From_GSTStateCode := StateRec.Code + ' (' + StateRec."State Code (GST Reg. No.)" + ')';
                    FromStateNmCode := StateRec.Description + ' (' + StateRec."State Code (GST Reg. No.)" + ')';
                END;



                ToCust.RESET;
                ToCust.SETRANGE(ToCust."No.", "Sales Invoice Header"."Bill-to Customer No.");
                IF ToCust.FINDFIRST THEN BEGIN
                    To_Name := ToCust.Name;
                    To_Address := ToCust.Address;
                    ToAddress2 := ToCust."Address 2";
                    To_City := ToCust.City + '-' + ToCust."Post Code";
                    To_StateCode := ToCust."State Code";
                    To_GSTIN := ToCust."GST Registration No.";
                    To_ARN := ToCust."ARN No.";
                END;

                StateRec.RESET;
                StateRec.SETRANGE(StateRec.Code, To_StateCode);
                IF StateRec.FINDFIRST THEN BEGIN
                    To_State := StateRec.Description;
                    To_GSTStateCode := StateRec.Code + ' (' + StateRec."State Code (GST Reg. No.)" + ')';
                END;





                IF ("Sales Invoice Header"."Ship-to Code" = '') THEN BEGIN
                    Fromcust.RESET;
                    Fromcust.SETRANGE(Fromcust."No.", "Sales Invoice Header"."Bill-to Customer No.");
                    IF Fromcust.FINDFIRST THEN
                        shiptoName := Fromcust.Name;

                    shiptoAddr1 := Fromcust.Address;
                    shiptoAddr2 := Fromcust."Address 2";
                    shiptoCity := Fromcust.City + '-' + Fromcust."Post Code";
                    ShiptoState := Fromcust."State Code";
                    shiptoGSTN := Fromcust."GST Registration No.";
                    //Rushab_CCIT+++
                    if StateRec.get("Ship-to County") then begin
                        ShiptoStateDesc := StateRec.Description;
                        shiptoStateCode := StateRec.Code + ' (' + StateRec."State Code (GST Reg. No.)" + ')';
                    end;
                    //Rushab_CCIT--
                    //Rushab_CCIT
                    // StateRec.RESET;
                    // StateRec.SETRANGE(StateRec.Code, Fromcust."State Code");
                    // IF StateRec.FINDFIRST THEN
                    //     ShiptoStateDesc := StateRec.Description;
                    // shiptoStateCode := StateRec.Code + ' (' + StateRec."State Code (GST Reg. No.)" + ')';
                END
                ELSE
                      //IF ("Sales Invoice Header"."Ship-to Code" <>'') AND ("Sales Invoice Header"."Bill-to Customer No."='') THEN
                      BEGIN
                    RecShipToAddress.RESET;
                    RecShipToAddress.SETRANGE(RecShipToAddress.Code, "Sales Invoice Header"."Ship-to Code");
                    IF RecShipToAddress.FINDFIRST THEN
                        shiptoName := RecShipToAddress.Name;
                    MESSAGE(shiptoName);
                    shiptoAddr1 := RecShipToAddress.Address;
                    shiptoAddr2 := RecShipToAddress."Address 2";
                    //MESSAGE(shiptoAddr2);
                    shiptoCity := RecShipToAddress.City + '- ' + RecShipToAddress."Post Code";
                    shiptoGSTN := RecShipToAddress."GST Registration No.";
                    //Rushab_CCIT+++
                    if StateRec.get("GST Ship-to State Code") then begin
                        ShiptoStateDesc := StateRec.Description;
                        shiptoStateCode := StateRec.Code + ' (' + StateRec."State Code (GST Reg. No.)" + ')';
                    end;
                    //Rushab_CCIT---
                    //Rushab
                    // StateRec.RESET;
                    // StateRec.SETRANGE(StateRec.Code, RecShipToAddress.State);
                    // IF StateRec.FINDFIRST THEN
                    //     ShiptoStateDesc := StateRec.Description;
                    // shiptoStateCode := StateRec.Code + ' (' + StateRec."State Code (GST Reg. No.)" + ')';
                END;


                /*
                                IF "Sales Invoice Header"."Ship-to Code" <> '' THEN BEGIN

                                    RecShipToAddress.RESET;
                                    RecShipToAddress.SETRANGE(RecShipToAddress.Code, "Sales Invoice Header"."Ship-to Code");
                                    //win316
                                    RecShipToAddress.SETFILTER("Customer No.", '%1', "Sales Invoice Header"."Sell-to Customer No.");
                                    IF RecShipToAddress.FINDFIRST THEN BEGIN

                                        shiptoCity := RecShipToAddress.City + '- ' + RecShipToAddress."Post Code";
                                        ShiptoState := RecShipToAddress.State;
                                        shiptoGSTN := RecShipToAddress."GST Registration No.";
                                        //MESSAGE(shiptoGSTN);
                                    END;

                                    StateRec.RESET;
                                    StateRec.SETRANGE(StateRec.Code, ShiptoState);
                                    IF StateRec.FINDFIRST THEN BEGIN
                                        ShiptoStateDesc := StateRec.Description;
                                        //MESSAGE(ShiptoStateDesc);
                                        shiptoStateCode := StateRec.Code + ' (' + StateRec."State Code (GST Reg. No.)" + ')';
                                    END;

                                END;
                */


                //WIn345 Start
                SalesShipmentHdr.RESET;
                SalesShipmentHdr.SETRANGE(SalesShipmentHdr."Order No.", "Sales Invoice Header"."Order No.");
                IF SalesShipmentHdr.FINDFIRST THEN;
                //WIN345 End

                RecLoc.RESET;
                RecLoc.SETRANGE(RecLoc.Code, "Sales Invoice Header"."Location Code");
                IF RecLoc.FINDFIRST THEN BEGIN
                    LocName := RecLoc.Name;
                    LocAddr1 := RecLoc.Address;
                    LocAddr2 := RecLoc."Address 2";
                    LocCity := RecLoc.City + '- ' + RecLoc."Post Code";
                    LocState := RecLoc."State Code";
                    LocGSTRegNo := RecLoc."GST Registration No.";
                END;

                StateRec.RESET;
                StateRec.SETRANGE(StateRec.Code, LocState);
                IF StateRec.FINDFIRST THEN BEGIN
                    LocStateDesc := StateRec.Description;
                    LocStateCode := StateRec.Code + ' (' + StateRec."State Code (GST Reg. No.)" + ')';
                END;

                StateRec.RESET;
                // StateRec.SETRANGE(StateRec.Code, companyInfo.State);
                IF StateRec.FINDFIRST THEN BEGIN
                    companystate := StateRec.Description;
                    CompStateCode := StateRec.Code + ' (' + StateRec."State Code (GST Reg. No.)" + ')';
                END;

                //ReportCheck.InitTextVariable;
                //ReportCheck.FormatNoText(AmountInWord,"Sales Invoice Header"."Amount to Customer",' ');
                //ReportCheck.FormatNoText(AmountInWord,FinalTotal,' ');

                RecPayTerm.RESET;
                RecPayTerm.SETRANGE(RecPayTerm.Code, "Sales Invoice Header"."Payment Terms Code");
                IF RecPayTerm.FINDFIRST THEN
                    PayTerm := RecPayTerm.Description;



                ok := EVALUATE(decimalvar, "Sales Invoice Header"."External Document No.");
                //decimalvar := round(decimalvar, "0.01")


                // NetPayableAmt := "Sales Invoice Header"."Amount to Customer" - decimalvar; //kj


                //ReportCheck.InitTextVariable; //kj
                // ReportCheck.FormatNoText(AmtInWordNetPayable, "Sales Invoice Header"."Amount to Customer" - decimalvar, ' '); //kj
                //ReportCheck.FormatNoText(AmountInWord,FinalTotal,' ');


                //Code for Payment Mode 1 and Payment Mode 2 WIN275
                IF ("Sales Invoice Header".DebitCardNo1 <> '') AND ("Sales Invoice Header".PayByDebitAmt2 <> 0) THEN
                    DbC1 := "Sales Invoice Header".PayByDebitCdNo1 + ' ' + FORMAT("Sales Invoice Header".PayByDebitAmt2) + ' ' + "Sales Invoice Header".DebitCardNo1;

                IF ("Sales Invoice Header".CreditCardNo1 <> '') AND ("Sales Invoice Header".PayByCreditAmt1 <> 0) THEN
                    CrC1 := "Sales Invoice Header".PayByCreditNo1 + ' ' + FORMAT("Sales Invoice Header".PayByCreditAmt1) + ' ' + "Sales Invoice Header".CreditCardNo1;


                IF ("Sales Invoice Header".CreditCardNo2 <> '') AND ("Sales Invoice Header".PayByCreditAmt2 <> 0) THEN
                    CrC2 := "Sales Invoice Header".PayByCreditNo2 + ' ' + FORMAT("Sales Invoice Header".PayByCreditAmt2) + ' ' + "Sales Invoice Header".CreditCardNo2;

                IF ("Sales Invoice Header".CreditCardNo3 <> '') AND ("Sales Invoice Header".PayByCreditAmt3 <> 0) THEN
                    CrC3 := "Sales Invoice Header".PayByCreditNo3 + ' ' + FORMAT("Sales Invoice Header".PayByCreditAmt3) + ' ' + "Sales Invoice Header".CreditCardNo3;

                IF ("Sales Invoice Header".CreditCardNo4 <> '') AND ("Sales Invoice Header".PayByCreditAmt4 <> 0) THEN
                    CrC4 := "Sales Invoice Header".PayByCreditNo4 + ' ' + FORMAT("Sales Invoice Header".PayByCreditAmt4) + ' ' + "Sales Invoice Header".CreditCardNo4;


                IF ("DebitCdPay Method Code1" <> '') AND ("Sales Invoice Header".PayByDebitCdAmt1 <> 0) THEN
                    PayMode1 := "Sales Invoice Header"."DebitCdPay Method Code1" + ' ' + FORMAT("Sales Invoice Header".PayByDebitCdAmt1);

                IF ("ChqPay Method Code" <> '') AND ("Sales Invoice Header".PayByChqAmt <> 0) THEN
                    PayMode2 := "Sales Invoice Header"."ChqPay Method Code" + ' ' + "Sales Invoice Header".PayByChqNo + ' ' + FORMAT("Sales Invoice Header".PayByChqDt) + ' ' +
                 FORMAT("Sales Invoice Header".PayByChqAmt);

                IF ("GiftPay Method Code" <> '') AND ("Sales Invoice Header".GiftVoucherAmt <> 0) THEN
                    PayMode3 := "Sales Invoice Header"."GiftPay Method Code" + ' ' + FORMAT("Sales Invoice Header".GiftVoucherAmt);

                IF ("RTGSPay Method Code" <> '') AND ("Sales Invoice Header"."RTGS Amount" <> 0) THEN
                    PayMode4 := "Sales Invoice Header"."RTGSPay Method Code" + ' ' + FORMAT("Sales Invoice Header"."RTGS Amount");

                /*
                IF "FinPay Method Code"<>'' THEN
                  PayMode5:="Sales Invoice Header"."FinPay Method Code"+' '+ FORMAT("Sales Invoice Header"."Finance Amount");
                */

                IF ("Sales Invoice Header"."CashPay Method Code" <> '') AND ("Sales Invoice Header".PayByCashAmt <> 0) THEN
                    PayMode5 := "Sales Invoice Header"."CashPay Method Code" + ' ' + FORMAT("Sales Invoice Header".PayByCashAmt);


                IF ("Sales Invoice Header"."Bank Approval Code" <> ' ') AND ("Sales Invoice Header"."Finance Amount" <> 0) THEN
                    FinDet := FORMAT("Sales Invoice Header"."Finance Comapny new") + ' ' + "Sales Invoice Header"."Bank Approval Code" + ' ' + FORMAT("Sales Invoice Header"."Finance Amount");
                //IF "FinPay Method Code"<>'' THEN

                PaymentMode1 := FinDet;//+' '+ DbC1+''+' '+CrC1+' '+' '+CrC2+' '+CrC3+' ' +CrC4;
                PaymentMode2 := PayMode2 + ' ' + PayMode3 + ' ' + PayMode4 + ' ' + PayMode5;
                //Code for Payment Mode 1 and Payment Mode 2 WIN275

                IF ("Sales Invoice Header"."GST Without Payment of Duty" = TRUE) AND ("Sales Invoice Header"."Location State Code" = 'MH') THEN BEGIN
                    IF "Sales Invoice Header"."Posting Date" < 20200401D then //040120D THEN
                        LUTNo := 'ARN -D270618001954V'
                    ELSE
                        LUTNo := 'ARN -AD270320029174I'
                END;

                IF ("Sales Invoice Header"."GST Without Payment of Duty" = TRUE) AND ("Sales Invoice Header"."Location State Code" = 'MH') THEN BEGIN
                    IF "Sales Invoice Header"."Posting Date" > 20210403D then  //040321D THEN
                        LUTNo := 'ARN -AD2704210097944';
                END;

                IF ("Sales Invoice Header"."GST Without Payment of Duty" = TRUE) AND ("Sales Invoice Header"."Location State Code" = 'KA') THEN BEGIN
                    IF "Sales Invoice Header"."Posting Date" < 20200401D then //040120D THEN
                        LUTNo := 'ARN -D270618001954V'
                    ELSE
                        LUTNo := 'ARN -AD290920001768V'
                END;

                IF ("Sales Invoice Header"."GST Without Payment of Duty" = TRUE) AND ("Sales Invoice Header"."Location State Code" = 'KA') THEN BEGIN
                    IF "Sales Invoice Header"."Posting Date" > 20210403D then //040321D THEN
                        LUTNo := 'ARN -AD290421003626B';
                END;

            end;

            trigger OnPreDataItem()
            begin
                TotAmt := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NoOfCopies; NoOfCopies)
                    {
                        Caption = 'No. of Copies';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        maxline := 0;
        linecount := 0;
        spline := 0;

        BankNm := '';
        BankAdd := '';
        BankAdd2 := '';
        BankCity := '';
        BankPinCode := '';
        BankIFSC := '';
        BankAccntNo := '';

        companyInfo.GET();
        companyInfo.CALCFIELDS(Picture);
        "Sr.No" := 0;

        //StateRec.RESET;

        StateRec.RESET;
        // StateRec.SETRANGE(StateRec.Code, companyInfo.State);
        IF StateRec.FINDFIRST THEN BEGIN
            State := StateRec.Description;
        END;
    end;

    var
        GSTDetailLeger: Record "Detailed GST Ledger Entry";//"16419";
        CGSTRate: Decimal;
        CGSTAmt: Decimal;
        SGSTAmt: Decimal;
        SGSTRate: Decimal;
        IGSTRate: Decimal;
        IGSTAmt: Decimal;
        "Sr.No": Integer;
        companyInfo: Record "Company Information";//"79";
        cust: Record Customer;//"18";
        StateRec: Record State;//"13762";
        From_Name: Text[50];
        From_Address: Text;
        From_StateCode: Code[20];
        From_State: Text;
        From_City: Text;
        From_GSTIN: Code[20];
        From_ARN: Code[20];
        From_GSTStateCode: Code[10];
        To_Name: Text[50];
        To_Address: Text;
        To_StateCode: Code[20];
        Orderid: code[20];
        To_State: Text;
        To_City: Text;
        To_GSTStateCode: Code[10];
        To_GSTIN: Code[20];
        To_ARN: code[20];

        Fromcust: Record Customer;//"18";
        ToCust: Record Customer; //"18";
        TotalInvoiceAmt: Decimal;
        ReportCheck: Report "Posted Voucher"; // 1401;
        AmountInWord: array[2] of Text[200];
        recSalesInvoiceLine: Record "Sales Invoice Line";//"113";
        recSalesInvoiceHeader: Record "Sales Invoice Header";//"112";
        TotalInvoiceAmt1: Decimal;
        ChargesAmount: Decimal;
        GlbInsCharge: Decimal;
        GlbOtherCharge: Decimal;
        GlbFrtCharge: Decimal;
        //StructureLineDetails: Record  "13798"; //not found _kj
        // ServTaxEntry_L: Record "16473"; //kj_not in bC and .. not in use in the report
        GlbPackCharge: Decimal;
        RecLoc: Record Location;//"14";
        LocName: Text;
        LocAddr1: Text;
        LocAddr2: Text;
        LocState: Text;
        LocCity: Text;
        LocGSTRegNo: Text;
        LocStateDesc: Text;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        OutputNo: Integer;
        Text16502: Label 'COPY';
        Text1: Label 'Original for Recipient';
        Text2: Label 'Duplicate for Transporter';
        Text3: Label 'Triplicate Copy';
        Title: Text[50];
        TotAmt: Decimal;
        SalesShipmentHdr: Record "Sales Shipment Header";//"110";
        RecItem: Record Item;//"27";
        VendorItemPartCode: Code[50];
        Freight: Decimal;
        Insurance: Decimal;
        Packing: Decimal;
        FinalTotal: Decimal;
        GSTComponent: Text;
        GSTRate: Decimal;
        GSTAmt: Decimal;
        RecPayTerm: Record "Payment Terms";//"3";
        PayTerm: Text;
        GSTComponentCGST: Text;
        GSTComponentSGST: Text;
        GSTComponentIGST: Text;
        FromAddress2: Text;
        ToAddress2: Text;
        State: Text;
        RecCLE: Record "Cust. Ledger Entry";//"21";
        LocStateCode: Code[10];
        RemAmt: Decimal;
        companystate: Text;
        CompStateCode: Code[10];
        DbC1: Code[50];
        DbC2: Code[50];
        DbC3: Code[50];
        DbC4: Code[50];
        CrC1: Code[50];
        CrC2: Code[50];
        CrC3: Code[50];
        CrC4: Code[50];
        PaymentMode: Text;
        AmtInWordNetPayable: array[2] of Text;
        BANKNAME: Text[70];
        BankNm: Text[250];
        BankAdd: Text[250];
        BankAdd2: Text[250];
        BankCity: Text[250];
        BankPinCode: Code[70];
        BankIFSC: Code[70];
        BankAccntNo: Code[70];
        bankdetrec: Record "Bank Account";//"270";
        shiptoName: Text[100];
        shiptoAddr1: Text[100];
        shiptoAddr2: Text[100];
        shiptoCity: Text[50];
        RecShipToAddress: Record "Ship-to Address";//"222";
        shiptoGSTN: Code[20];
        shiptoStateCode: Code[10];
        ShiptoState: Code[20];
        ShiptoStateDesc: Text[50];
        maxline: Integer;
        linecount: Integer;
        spline: Integer;
        FromStateNmCode: Text;
        RecPayMeth: Record "Payment Method";//"289";
        RefNo: Text[100];
        PayMode1: Code[80];
        PayMode2: Code[80];
        PayMode3: Code[80];
        PayMode4: Code[80];
        PayMode5: Code[80];
        Card1: Integer;
        Card2: Integer;
        Card3: Integer;
        Card4: Integer;
        card5: Integer;
        RefNo1: Integer;
        RefNo2: Integer;
        RefNo3: Integer;
        RefNo4: Integer;
        PaymentMode1: Text[140];
        PaymentMode2: Text[140];
        CntLines: Integer;
        RecSalesPerson: Record "Salesperson/Purchaser";//"13";
        LineAmt: Decimal;
        FinDet: Text[80];
        decimalvar: Decimal;
        ok: Boolean;
        NetPayableAmt: Decimal;
        reccomment: Record "Sales Comment Line";//"44";
        comments: Text[1024];
        lineno: Integer;
        Total_Amount: Decimal;
        RecSIL: Record "Sales Invoice Line";//"113";
        LUTNo: Text;
        Text: Text[55];
        Text17: Text[55];
        Location: Record Location;//"14";
        OrderIDVAR: code[20]; //kj
        itemLedEntry: Record "Item Ledger Entry"; //cckj
        SerialNo: text[30]; //cckj
        IMEINo: Code[20]; //cckj
        SalesShipLine: Record "Sales Shipment Line"; //cckj
}

