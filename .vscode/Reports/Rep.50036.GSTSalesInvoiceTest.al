report 50036 "GST-Sales Invoice Test"
{
    DefaultLayout = RDLC;
    RDLCLayout = './GSTSalesInvoiceTest.rdlc';
    Caption = 'GST-Sales Invoice';
    ApplicationArea = FixedAsset;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
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
            }
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
            column(PromoCode_SalesInvoiceHeader; "Sales Invoice Header"."Promo Code")
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
            column(AmounttoCustomer_SalesInvoiceHeader; "Sales Invoice Header"."Amount To Customer UPIT")
            {
            }
            column(NetPayableAmt; NetPayableAmt)
            {
            }
            column(PaymentTermsCode_SalesInvoiceHeader; PayTerm)
            {
            }
            column(AmountInWord; AmountInWord[1])
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
            column(ShiptoCode_SalesInvoiceHeader; "Sales Invoice Header"."Ship-to Code")
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
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
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
                    dataitem("Sales Invoice Line"; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("Document No.", "Line No.")
                                            WHERE(Type = FILTER(Item));
                        column(SrNo; "Sr.No")
                        {
                        }
                        column(SerialNo_SalesInvoiceLine; "Sales Invoice Line"."Serial No.")
                        {
                        }
                        column(IMEINo_SalesInvoiceLine; "Sales Invoice Line"."IMEI No.")
                        {
                        }
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
                        column(Line_Discount; "Sales Invoice Line"."Line Discount Amount")
                        {
                        }
                        column(GST_Base_Amount; '')
                        // column(GST_Base_Amount; "Sales Invoice Line"."GST Base Amount")
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
                        {
                        }
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
                        {
                        }
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
                        column(AmountToCustomer_SalesInvoiceLine; ROUND("Sales Invoice Line".Amount))
                        {
                        }
                        column(CntLines; CntLines)
                        {
                        }
                        column(LineAmount; "Sales Invoice Line"."Line Amount")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            linecount += 1;


                            LineAmt += "Sales Invoice Line"."Line Amount";
                            //MESSAGE(FORMAT(LineAmt));

                            CntLines := "Sales Invoice Line".COUNT;
                            //MESSAGE(FORMAT(CntLines));



                            // StructureLineDetails.RESET;
                            // StructureLineDetails.SETRANGE(Type, StructureLineDetails.Type::Sale);
                            // StructureLineDetails.SETRANGE("Document Type", StructureLineDetails."Document Type"::Invoice);
                            // StructureLineDetails.SETRANGE("Invoice No.", "Document No.");
                            // StructureLineDetails.SETRANGE("Item No.", "No.");
                            // StructureLineDetails.SETRANGE("Line No.", "Line No.");
                            // IF StructureLineDetails.FIND('-') THEN
                            //     REPEAT
                            //         IF NOT StructureLineDetails."Payable to Third Party" THEN BEGIN

                            //             IF StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::Charges THEN BEGIN

                            //                 ChargesAmount := ChargesAmount + ABS(StructureLineDetails.Amount);

                            //                 IF (StructureLineDetails."Tax/Charge Group" = 'FREIGHT') OR
                            //                    (StructureLineDetails."Tax/Charge Code" = 'FREIGHT') THEN
                            //                     GlbFrtCharge := GlbFrtCharge + ABS(StructureLineDetails.Amount)


                            //                 ELSE
                            //                     IF (StructureLineDetails."Tax/Charge Group" = 'INSURANCE') OR
                            //                   (StructureLineDetails."Tax/Charge Code" = 'INSURANCE') THEN
                            //                         // BEGIN
                            //                         GlbInsCharge := GlbInsCharge + ABS(StructureLineDetails.Amount)
                            //                     //  MESSAGE(FORMAT(GlbInsCharge));
                            //                     //  END
                            //                     ELSE
                            //                         IF (StructureLineDetails."Tax/Charge Group" = 'PACKING') OR
                            //                       (StructureLineDetails."Tax/Charge Code" = 'PACKING') THEN
                            //                             // BEGIN
                            //                             GlbPackCharge := GlbPackCharge + ABS(StructureLineDetails.Amount)
                            //                         // MESSAGE(FORMAT(GlbPackCharge));
                            //                         //  END
                            //                         ELSE
                            //                             GlbOtherCharge := GlbOtherCharge + ABS(StructureLineDetails.Amount);
                            //             END;
                            //         END;
                            //     UNTIL StructureLineDetails.NEXT = 0;
                            // //WIN275//tk




                            //win352++
                            "Sr.No" += 1;


                            GSTDetailLeger.RESET;
                            GSTDetailLeger.SETRANGE(GSTDetailLeger."Document No.", "Sales Invoice Line"."Document No.");
                            GSTDetailLeger.SETRANGE(GSTDetailLeger."No.", "Sales Invoice Line"."No.");
                            GSTDetailLeger.SETRANGE(GSTDetailLeger."Document Line No.", "Sales Invoice Line"."Line No.");
                            IF GSTDetailLeger.FINDSET THEN
                                REPEAT
                                    IF GSTDetailLeger."GST Component Code" = 'CGST' THEN BEGIN
                                        CLEAR(CGSTRate);
                                        CLEAR(CGSTAmt);
                                        CLEAR(GSTComponentCGST);
                                        GSTComponentCGST := 'CGST';
                                        CGSTRate := GSTDetailLeger."GST %";
                                        CGSTAmt := GSTDetailLeger."GST Amount";
                                    END ELSE
                                        IF GSTDetailLeger."GST Component Code" = 'SGST' THEN BEGIN
                                            CLEAR(SGSTRate);
                                            CLEAR(SGSTAmt);
                                            CLEAR(GSTComponentSGST);
                                            GSTComponentSGST := 'SGST';
                                            SGSTRate := GSTDetailLeger."GST %";
                                            SGSTAmt := GSTDetailLeger."GST Amount";
                                        END ELSE
                                            IF GSTDetailLeger."GST Component Code" = 'IGST' THEN BEGIN
                                                CLEAR(IGSTRate);
                                                CLEAR(IGSTAmt);
                                                CLEAR(GSTComponentIGST);
                                                GSTComponentIGST := 'IGST';
                                                IGSTRate := GSTDetailLeger."GST %";
                                                IGSTAmt := GSTDetailLeger."GST Amount";
                                            END;
                                UNTIL GSTDetailLeger.NEXT = 0;



                            /*FinalTotal:=FinalTotal+"Sales Invoice Line".Amount+GlbFrtCharge+GlbInsCharge+GlbPackCharge+IGSTAmt+CGSTAmt+SGSTAmt;
                            ReportCheck.InitTextVariable;
                            ReportCheck.FormatNoText(AmountInWord,FinalTotal,' ');
                            */

                        end;

                        trigger OnPreDataItem()
                        begin
                            linecount := 0;
                        end;
                    }
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

                            IF linecount > 5 THEN
                                spline := 5 - ROUND((linecount / 5 - ROUND(linecount / 5, 1, '<')) * 5, 1)
                            ELSE
                                spline := 5 - linecount;

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
                RecSalesPerson.SETRANGE(RecSalesPerson.Code, "Sales Invoice Header"."Salesperson Code");
                IF RecSalesPerson.FINDFIRST THEN;

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
                    BANKNAME := 'RBLCA621';
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
                END;

                StateRec.RESET;
                StateRec.SETRANGE(StateRec.Code, To_StateCode);
                IF StateRec.FINDFIRST THEN BEGIN
                    To_State := StateRec.Description;
                    To_GSTStateCode := StateRec.Code + ' (' + StateRec."State Code (GST Reg. No.)" + ')';
                END;


                /*
                IF ("Sales Invoice Header"."Ship-to Code" ='') THEN
                BEGIN
                Fromcust.RESET;
                Fromcust.SETRANGE(Fromcust."No.","Sales Invoice Header"."Bill-to Customer No.");
                IF Fromcust.FINDFIRST THEN
                 shiptoName := Fromcust.Name;

                 shiptoAddr1 := Fromcust.Address;
                 shiptoAddr2:=Fromcust."Address 2";
                 shiptoCity:=Fromcust.City  +'-' +  Fromcust."Post Code";
                 ShiptoState := Fromcust."State Code";
                 shiptoGSTN := Fromcust."GST Registration No.";
                 StateRec.RESET;
                 StateRec.SETRANGE(StateRec.Code,Fromcust."State Code");
                 IF StateRec.FINDFIRST THEN
                 ShiptoStateDesc := StateRec.Description;
                 shiptoStateCode:=StateRec.Code + ' (' + StateRec."State Code (GST Reg. No.)" + ')';
                 END
                ELSE
                  //IF ("Sales Invoice Header"."Ship-to Code" <>'') AND ("Sales Invoice Header"."Bill-to Customer No."='') THEN
                      BEGIN
                        RecShipToAddress.RESET;
                        RecShipToAddress.SETRANGE(RecShipToAddress.Code,"Sales Invoice Header"."Ship-to Code");
                        IF RecShipToAddress.FINDFIRST THEN
                        shiptoName:=RecShipToAddress.Name;
                        MESSAGE(shiptoName);
                        shiptoAddr1:=RecShipToAddress.Address;
                        shiptoAddr2:=RecShipToAddress."Address 2";
                        //MESSAGE(shiptoAddr2);
                        shiptoCity:=RecShipToAddress.City+'- ' + RecShipToAddress."Post Code";
                        shiptoGSTN:=RecShipToAddress."GST Registration No.";
                        StateRec.RESET;
                        StateRec.SETRANGE(StateRec.Code,RecShipToAddress.State);
                        IF StateRec.FINDFIRST THEN
                        ShiptoStateDesc:=StateRec.Description;
                        shiptoStateCode:= StateRec.Code + ' (' + StateRec."State Code (GST Reg. No.)" + ')';
                      END;

                */

                IF "Sales Invoice Header"."Ship-to Code" <> '' THEN BEGIN

                    RecShipToAddress.RESET;
                    RecShipToAddress.SETRANGE(RecShipToAddress.Code, "Sales Invoice Header"."Ship-to Code");
                    IF RecShipToAddress.FINDFIRST THEN BEGIN
                        shiptoName := RecShipToAddress.Name;
                        shiptoAddr1 := RecShipToAddress.Address;
                        shiptoAddr2 := RecShipToAddress."Address 2";
                        shiptoCity := RecShipToAddress.City + '- ' + RecShipToAddress."Post Code";
                        ShiptoState := RecShipToAddress.State;
                        shiptoGSTN := RecShipToAddress."GST Registration No.";
                        MESSAGE(ShiptoState);
                    END;




                    StateRec.RESET;
                    //MESSAGE(StateRec.Code);
                    StateRec.SETRANGE(StateRec.Code, ShiptoState);

                    IF StateRec.FINDFIRST THEN BEGIN
                        ShiptoStateDesc := StateRec.Description;
                        MESSAGE(ShiptoStateDesc);
                        shiptoStateCode := StateRec.Code + ' (' + StateRec."State Code (GST Reg. No.)" + ')';
                    END;
                END;



                RecItem.RESET;
                RecItem.SETRANGE(RecItem."No.", "Sales Invoice Line"."No.");
                IF RecItem.FINDFIRST THEN
                    VendorItemCode := RecItem."Vendor Item No.";
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
                StateRec.SETRANGE(StateRec.Code, companyInfo."State Code");
                IF StateRec.FINDFIRST THEN BEGIN
                    companystate := StateRec.Description;
                    CompStateCode := StateRec.Code + ' (' + StateRec."State Code (GST Reg. No.)" + ')';
                END;

                ReportCheck.InitTextVariable;
                ReportCheck.FormatNoText(AmountInWord, "Sales Invoice Header"."Amount", ' ');
                //ReportCheck.FormatNoText(AmountInWord,FinalTotal,' ');

                RecPayTerm.RESET;
                RecPayTerm.SETRANGE(RecPayTerm.Code, "Sales Invoice Header"."Payment Terms Code");
                IF RecPayTerm.FINDFIRST THEN
                    PayTerm := RecPayTerm.Description;


                RemAmt := 0;
                RecCLE.RESET;
                RecCLE.SETRANGE(RecCLE."Customer No.", "Sales Invoice Header"."Sell-to Customer No.");
                RecCLE.SETRANGE(RecCLE."Document No.", "Sales Invoice Header"."No.");
                IF RecCLE.FINDFIRST THEN BEGIN
                    RecCLE.CALCFIELDS("Remaining Amount");
                    RemAmt += RecCLE."Remaining Amount";
                END;

                ok := EVALUATE(decimalvar, "Sales Invoice Header"."External Document No.");
                //decimalvar := round(decimalvar, "0.01")


                NetPayableAmt := "Sales Invoice Header"."Amount" - decimalvar;


                ReportCheck.InitTextVariable;
                ReportCheck.FormatNoText(AmtInWordNetPayable, "Sales Invoice Header"."Amount" - decimalvar, ' ');
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

    trigger OnInitReport()
    begin
        ERROR('Kindly contact to Mr. Avinash Bhor for Report: 50036');
        EXIT;
    end;

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
        StateRec.SETRANGE(StateRec.Code, companyInfo."State Code");
        IF StateRec.FINDFIRST THEN BEGIN
            State := StateRec.Description;
        END;
    end;

    var
        GSTDetailLeger: Record "Detailed GST Ledger Entry";
        CGSTRate: Decimal;
        CGSTAmt: Decimal;
        SGSTAmt: Decimal;
        SGSTRate: Decimal;
        IGSTRate: Decimal;
        IGSTAmt: Decimal;
        "Sr.No": Integer;
        companyInfo: Record 79;
        cust: Record 18;
        From_Name: Text[50];
        From_Address: Text;
        From_StateCode: Code[20];
        From_State: Text;
        From_City: Text;
        From_GSTIN: Code[20];
        From_GSTStateCode: Code[10];
        To_Name: Text[50];
        To_Address: Text;
        To_StateCode: Code[20];
        To_State: Text;
        To_City: Text;
        To_GSTStateCode: Code[10];
        To_GSTIN: Code[20];
        Fromcust: Record 18;
        ToCust: Record 18;
        TotalInvoiceAmt: Decimal;
        ReportCheck: Report Check;
        AmountInWord: array[2] of Text[200];
        recSalesInvoiceLine: Record 113;
        recSalesInvoiceHeader: Record 112;
        TotalInvoiceAmt1: Decimal;
        ChargesAmount: Decimal;
        GlbInsCharge: Decimal;
        GlbOtherCharge: Decimal;
        GlbFrtCharge: Decimal;
        // StructureLineDetails: Record "13798";
        // ServTaxEntry_L: Record "16473";
        GlbPackCharge: Decimal;
        RecLoc: Record 14;
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
        SalesShipmentHdr: Record 110;
        RecItem: Record 27;
        VendorItemCode: Code[20];
        Freight: Decimal;
        Insurance: Decimal;
        Packing: Decimal;
        FinalTotal: Decimal;
        GSTComponent: Text;
        GSTRate: Decimal;
        GSTAmt: Decimal;
        RecPayTerm: Record 3;
        PayTerm: Text;
        GSTComponentCGST: Text;
        GSTComponentSGST: Text;
        GSTComponentIGST: Text;
        FromAddress2: Text;
        ToAddress2: Text;
        State: Text;
        RecCLE: Record 21;
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
        bankdetrec: Record 270;
        shiptoName: Text[100];
        shiptoAddr1: Text[100];
        shiptoAddr2: Text[100];
        shiptoCity: Text[50];
        RecShipToAddress: Record 222;
        shiptoGSTN: Code[20];
        shiptoStateCode: Code[10];
        ShiptoState: Code[20];
        ShiptoStateDesc: Text[50];
        maxline: Integer;
        linecount: Integer;
        spline: Integer;
        FromStateNmCode: Text;
        RecPayMeth: Record 289;
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
        RecSalesPerson: Record 13;
        LineAmt: Decimal;
        FinDet: Text[80];
        decimalvar: Decimal;
        ok: Boolean;
        NetPayableAmt: Decimal;
        StateRec1: Record State;
        StateRec: Record State;
}

