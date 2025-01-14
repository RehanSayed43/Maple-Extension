report 50018 "GST-B2B Sales Invoice"
{

    Caption = 'GST-B2B Sales Invoice';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './GSTB2BSalesInvoice.rdl';

    dataset
    {
        //dataitem(DataItem1000000022; Table112)
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            CalcFields = "QR Code";
            column(LUTNo; LUTNo)
            {
            }
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
            column(CurrentTime; System.Time)
            {
            }
            column(qrcode; "QR Code")
            //  column(qrcode; TempBlob.Blob)
            {
            } //ccit_kj
            column(IRNNo_SalesInvoiceHeader; "Sales Invoice Header"."IRN No.")
            {
            }
            //Rushab_CCIT++
            column(SystemCreatedAt; SystemCreatedAt)
            {

            }
            //Rushab_CCIT--
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
            }  //ccit_kj standard field
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
            column(Com_Bank_Name; companyInfo."Bank Name")
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
            column(SalesPerCode; SalesShipmentHdr."Salesperson Code")
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
            column(AmounttoCustomer_SalesInvoiceHeader; FinalTotal)
            //column(AmounttoCustomer_SalesInvoiceHeader; "Sales Invoice Header"."Amount to Customer")
            {
            }
            column(NetPayableAmt; '')
            // column(NetPayableAmt; "Sales Invoice Header"."Amount to Customer" - RemAmt)
            {
            }  //ccit_kj standard field
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
            column(ShiptoCity_SalesInvoiceHeader; "Sales Invoice Header"."Ship-to City")
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
            column(ShiptoGSTIN; shiptoGSTN)
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
            column(RefNo; RefNo)
            {
            }
            column(PaymentMode1; PaymentMode1)
            {
            }
            column(PaymentMode2; PaymentMode2)
            {
            }
            column(EmployeeName; RecSalesPerson.Name)
            {
            }
            // dataitem(CopyLoop; Table2000000026)
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
                        column(comments; comments)
                        {
                        }
                        column(SrNo; "Sr.No")
                        {
                        }
                        column(SerialNo_SalesInvoiceLine; SerialNo)
                        {
                        }
                        column(MRP_Value; "MRP Value") { }
                        // column(IMEINo_SalesInvoiceLine; "Sales Invoice Line"."IMEI No." + "Sales Invoice Line"."Eleva Product Serial No.")
                        // {
                        // }
                        column(IMEINo_SalesInvoiceLine; IMEINo + "Sales Invoice Line"."Eleva Product Serial No.")
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

                        column(GST_Base_Amount; "Sales Invoice Line".Amount)
                        // column(GST_Base_Amount; "Sales Invoice Line"."GST Base Amount")
                        {
                        }  //ccit_kj standard field
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
                        //column(TotalGSTAmount_SalesInvoiceLine; "Sales Invoice Line"."Total GST Amount")
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
                        // column(CESSAmount_SalesInvoiceLine; "Sales Invoice Line"."CESS Amount")
                        {
                        }  //ccit_kj
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
                        // column(AmountToCustomer_SalesInvoiceLine;"Sales Invoice Line"."Amount To Customer")
                        {
                        }  //kj
                        column(LineAmount; "Sales Invoice Line"."Line Amount")
                        {
                        }

                        column(VendorItemPartCode; VendorItemPartCode)
                        {
                        }
                        column(TrackingIMEI; TrackingIMEI) { }
                        column(TrackingSerial; TrackingSerial) { }
                        trigger OnAfterGetRecord()
                        var

                            DesStrCunt: Integer;
                        begin
                            linecount := linecount + 1;
                            DesStrCunt := StrLen("Sales Invoice Line".Description);
                            DesStrCunt := Round(DesStrCunt / 50, 1, '>');
                            IF DesStrCunt > 1 then
                                linecount += (DesStrCunt - 1);
                            //IF "Sales Invoice Line"."No."='512073|512040' THEN
                            //CurrReport.SKIP;
                            // IMEINo := '';
                            // SalesInvoiceLine.reset();
                            // if SalesInvoiceLine.get("Eleva Product Serial No.") then begin
                            //     IMEINo := SalesInvoiceLine."Eleva Product Serial No.";
                            // end else
                            //     IMEINo := SalesInvoiceLine."IMEI No.";

                            comments := '';
                            reccomment.RESET;
                            reccomment.SETFILTER(reccomment."No.", "Sales Invoice Line"."Document No.");
                            //reccomment.SETRANGE(reccomment."Line No.",lineno);
                            //reccomment.SETRANGE(reccomment."Line No.","Sales Invoice Line"."Line No.");
                            IF reccomment.FINDSET THEN
                                REPEAT
                                    comments += reccomment.Comment + ',';
                                UNTIL reccomment.NEXT = 0;

                            //IMEI and Tracking Serial No. >>>
                            Clear(RowID1Value);
                            Clear(TrackingSerial);
                            Clear(TrackingIMEI);
                            RowID1Value := ItemTrackingMgt.ComposeRowID(DATABASE::"Sales Invoice Line", 0, "Sales Invoice Line"."Document No.", '', 0, "Sales Invoice Line"."Line No.");
                            ValueEntryRelation.SetCurrentKey("Source RowId");
                            ValueEntryRelation.SetRange("Source RowId", RowID1Value);
                            if ValueEntryRelation.Find('-') then begin
                                repeat
                                    ValueEntry.Get(ValueEntryRelation."Value Entry No.");
                                    if ValueEntry."Item Ledger Entry Type" in
                                       [ValueEntry."Item Ledger Entry Type"::Purchase,
                                        ValueEntry."Item Ledger Entry Type"::Sale,
                                        ValueEntry."Item Ledger Entry Type"::"Positive Adjmt.",
                                        ValueEntry."Item Ledger Entry Type"::"Negative Adjmt."]
                                    then begin
                                        if ItemLedgEntry.Get(ValueEntry."Item Ledger Entry No.") then begin
                                            TempSalesInvTrackingLine.Reset();
                                            TempSalesInvTrackingLine.SetRange("Sales Invoice No.", "Sales Invoice Line"."Document No.");
                                            TempSalesInvTrackingLine.SetRange("Serial No.", ItemLedgEntry."Serial No.");
                                            TempSalesInvTrackingLine.SetRange("IMEI No", ItemLedgEntry."IMEI No.");
                                            if not TempSalesInvTrackingLine.FindFirst() then begin
                                                TempSalesInvTrackingLine.Init();
                                                TempSalesInvTrackingLine."Entry No." := 0;
                                                TempSalesInvTrackingLine."Sales Invoice No." := "Sales Invoice Line"."Document No.";
                                                TempSalesInvTrackingLine."Sales Line" := "Sales Invoice Line"."Line No.";
                                                TempSalesInvTrackingLine."IMEI No" := ItemLedgEntry."IMEI No.";
                                                TempSalesInvTrackingLine."Serial No." := ItemLedgEntry."Serial No.";
                                                TempSalesInvTrackingLine.Insert();
                                                if TrackingIMEI = '' then
                                                    TrackingIMEI := ItemLedgEntry."IMEI No."
                                                else
                                                    TrackingIMEI := TrackingIMEI + ',' + ItemLedgEntry."IMEI No.";

                                                if TrackingSerial = '' then
                                                    TrackingSerial := ItemLedgEntry."Serial No."
                                                else
                                                    TrackingSerial := TrackingSerial + ',' + ItemLedgEntry."Serial No.";
                                            end;
                                        end;

                                    end;
                                until ValueEntryRelation.Next() = 0;
                            end;
                            //IMEI and Tracking Serial No. >>>
                            // new
                            Clear(SerialNo);
                            clear(IMEINo);
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


                            "Sr.No" += 1;
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
                            GSTDetailLeger.SetRange("Document Line No.", "Sales Invoice Line"."Line No.");
                            IF GSTDetailLeger.FINDFIRST THEN
                                REPEAT
                                    IF GSTDetailLeger."GST Component Code" = 'CGST' THEN BEGIN
                                        GSTComponentCGST := 'CGST';
                                        CGSTRate := GSTDetailLeger."GST %";
                                        CGSTAmt += GSTDetailLeger."GST Amount";
                                    END ELSE
                                        IF GSTDetailLeger."GST Component Code" = 'SGST' THEN BEGIN

                                            GSTComponentSGST := 'SGST';
                                            SGSTRate := GSTDetailLeger."GST %";
                                            SGSTAmt += GSTDetailLeger."GST Amount";
                                        END ELSE
                                            IF GSTDetailLeger."GST Component Code" = 'IGST' THEN BEGIN

                                                GSTComponentIGST := 'IGST';
                                                IGSTRate := GSTDetailLeger."GST %";
                                                IGSTAmt += GSTDetailLeger."GST Amount";
                                            END;
                                UNTIL GSTDetailLeger.NEXT = 0;




                            /*FinalTotal:=FinalTotal+"Sales Invoice Line".Amount+GlbFrtCharge+GlbInsCharge+GlbPackCharge+IGSTAmt+CGSTAmt+SGSTAmt;
                            ReportCheck.InitTextVariable;
                            ReportCheck.FormatNoText(AmountInWord,FinalTotal,' ');
                            */

                            CLEAR(VendorItemPartCode);
                            RecItem.RESET;
                            RecItem.SETRANGE(RecItem."No.", "Sales Invoice Line"."No.");
                            IF RecItem.FINDFIRST THEN
                                VendorItemPartCode := RecItem."Vendor Part Code Long";

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

                            IF linecount > maxline THEN
                                spline := maxline - ROUND((linecount / maxline - ROUND(linecount / maxline, 1, '<')) * maxline, 1)
                            ELSE
                                spline := maxline - linecount;

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
                    //Rushab_CCIT Added
                    if StateRec.get("Ship-to County") then begin
                        ShiptoStateDesc := StateRec.Description;
                        shiptoStateCode := StateRec.Code + ' (' + StateRec."State Code (GST Reg. No.)" + ')';
                    end;
                    //Rushab_CCIT Removd
                    // StateRec.RESET;
                    // StateRec.SETRANGE(StateRec.Code, Fromcust."State Code");
                    // IF StateRec.FINDFIRST THEN
                    //     ShiptoStateDesc := StateRec.Description;
                    // shiptoStateCode := StateRec.Code + ' (' + StateRec."State Code (GST Reg. No.)" + ')';
                END
                ELSE BEGIN
                    RecShipToAddress.RESET;
                    RecShipToAddress.SETRANGE(Code, "Sales Invoice Header"."Ship-to Code");
                    RecShipToAddress.SETFILTER("Customer No.", '%1', "Sales Invoice Header"."Sell-to Customer No.");
                    IF RecShipToAddress.FINDFIRST THEN
                        shiptoName := RecShipToAddress.Name;
                    shiptoAddr1 := RecShipToAddress.Address;
                    shiptoAddr2 := RecShipToAddress."Address 2";
                    shiptoCity := RecShipToAddress.City + '- ' + RecShipToAddress."Post Code";
                    shiptoGSTN := RecShipToAddress."GST Registration No.";
                    //Rushab_CCIT++ Added
                    if StateRec.get("Ship-to County") then begin
                        ShiptoStateDesc := StateRec.Description;
                        shiptoStateCode := StateRec.Code + ' (' + StateRec."State Code (GST Reg. No.)" + ')';
                    end;
                    //Rushab_CCIT--
                    //Rushab_CCIT
                    // StateRec.RESET;
                    // StateRec.SETRANGE(StateRec.Code, RecShipToAddress.State);
                    // IF StateRec.FINDFIRST THEN
                    //     ShiptoStateDesc := StateRec.Description;
                    // shiptoStateCode := StateRec.Code + ' (' + StateRec."State Code (GST Reg. No.)" + ')';
                END;

                //KPPL-RJ
                /*IF "Sales Invoice Header"."Ship-to Code"<>'' THEN
                BEGIN
                
                RecShipToAddress.RESET;
                RecShipToAddress.SETRANGE(RecShipToAddress.Code,"Sales Invoice Header"."Ship-to Code");
                IF RecShipToAddress.FINDFIRST THEN
                  BEGIN
                 shiptoName := RecShipToAddress.Name;
                 shiptoAddr1 := RecShipToAddress.Address;
                 shiptoAddr2:=RecShipToAddress."Address 2";
                 shiptoCity:=RecShipToAddress.City  +'- ' +  RecShipToAddress."Post Code";
                 ShiptoState := RecShipToAddress.State;
                 shiptoGSTN:=RecShipToAddress."GST Registration No.";
                   //MESSAGE(ShiptoState);
                 END;
                  StateRec.RESET;
                  //MESSAGE(StateRec.Code);
                  StateRec.SETRANGE(StateRec.Code,ShiptoState);
                
                  IF StateRec.FINDFIRST THEN
                  BEGIN
                    ShiptoStateDesc:=StateRec.Description;
                    //MESSAGE(ShiptoStateDesc);
                    shiptoStateCode:=StateRec.Code+ ' (' + StateRec."State Code (GST Reg. No.)" +')';
                  END;
                END;*/

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
                    LocStateCode := StateRec.Code + '(' + StateRec."State Code (GST Reg. No.)" + ')';
                END;

                StateRec.RESET;
                StateRec.SETRANGE(StateRec.Code, companyInfo."State Code");
                IF StateRec.FINDFIRST THEN BEGIN
                    companystate := StateRec.Description;
                    CompStateCode := StateRec.Code + ' (' + StateRec."State Code (GST Reg. No.)" + ')';
                END;

                /* ReportCheck.InitTextVariable;
                ReportCheck.FormatNoText(AmountInWord, "Sales Invoice Header"."Amount to Customer", ' '); */ //kj
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
                    RecCLE.CALCFIELDS("Remaining Amt. (LCY)", "Amount (LCY)");
                    RemAmt := RecCLE."Remaining Amt. (LCY)";
                    FinalTotal := RecCLE."Amount (LCY)";
                END;


                ReportCheck.InitTextVariable;
                ReportCheck.FormatNoText(AmtInWordNetPayable, RemAmt, ' ');
                ReportCheck.InitTextVariable;
                ReportCheck.FormatNoText(AmountInWord, FinalTotal, ' ');



                IF "Sales Invoice Header".DebitCardNo1 <> '' THEN
                    DbC1 := "Sales Invoice Header".PayByDebitCdNo1 + ' ' + FORMAT("Sales Invoice Header".PayByDebitAmt2) + '' + "Sales Invoice Header".DebitCardNo1;

                IF "Sales Invoice Header".CreditCardNo1 <> '' THEN
                    CrC1 := "Sales Invoice Header".PayByCreditNo1 + ' ' + FORMAT("Sales Invoice Header".PayByCreditAmt1) + ' ' + "Sales Invoice Header".CreditCardNo1;


                IF "Sales Invoice Header".CreditCardNo2 <> '' THEN
                    CrC2 := "Sales Invoice Header".PayByCreditNo2 + ' ' + FORMAT("Sales Invoice Header".PayByCreditAmt2) + ' ' + "Sales Invoice Header".CreditCardNo2;

                IF "Sales Invoice Header".CreditCardNo3 <> '' THEN
                    CrC3 := "Sales Invoice Header".PayByCreditNo3 + ' ' + FORMAT("Sales Invoice Header".PayByCreditAmt3) + ' ' + "Sales Invoice Header".CreditCardNo3;

                IF "Sales Invoice Header".CreditCardNo4 <> '' THEN
                    CrC4 := "Sales Invoice Header".PayByCreditNo4 + ' ' + FORMAT("Sales Invoice Header".PayByCreditAmt4) + ' ' + "Sales Invoice Header".CreditCardNo4;


                IF "DebitCdPay Method Code1" <> '' THEN
                    PayMode1 := "Sales Invoice Header"."DebitCdPay Method Code1" + ' ' + FORMAT("Sales Invoice Header".PayByDebitCdAmt1);

                IF ("ChqPay Method Code" <> '') OR ("Sales Invoice Header".PayByChqNo <> '') THEN
                    PayMode2 := "Sales Invoice Header"."ChqPay Method Code" + ' ' + "Sales Invoice Header".PayByChqNo + ' ' + FORMAT("Sales Invoice Header".PayByChqDt) + ' ' +
                 FORMAT("Sales Invoice Header".PayByChqAmt);

                IF "GiftPay Method Code" <> '' THEN
                    PayMode3 := "Sales Invoice Header"."GiftPay Method Code" + ' ' + FORMAT("Sales Invoice Header".GiftVoucherAmt);

                IF "RTGSPay Method Code" <> '' THEN
                    PayMode4 := "Sales Invoice Header"."RTGSPay Method Code" + ' ' + FORMAT("Sales Invoice Header"."RTGS Amount");


                IF "FinPay Method Code" <> '' THEN
                    PayMode5 := "Sales Invoice Header"."FinPay Method Code" + ' ' + FORMAT("Sales Invoice Header"."Finance Amount");




                //IF "FinPay Method Code"<>'' THEN
                PaymentMode1 := FORMAT("Sales Invoice Header"."Finance Comapny new") + ' ' + "Sales Invoice Header"."Bank Approval Code" + ' ' + FORMAT("Sales Invoice Header"."Finance Amount") + ' ' + DbC1 + '' + ' ' + CrC1 + ' ' + ' ' + CrC2 + ' ' + CrC3 + ' ' + CrC4;
                PaymentMode2 := PayMode2 + '' + PayMode3 + '' + PayMode4 + '' + PayMode5;

                //QR++
                IF "Sales Invoice Header"."Acknowledgement No." <> '' THEN BEGIN
                    RecEinvoice.RESET;
                    // RecEinvoice.SETRANGE("Document No.", "No."); //ccit_kj setup required

                    //RecEinvoice.SETRANGE("Inv Transaction",RecEinvoice."Inv Transaction"::"Generate IRN");
                    IF RecEinvoice.FINDLAST THEN BEGIN
                        IF RecEinvoice."Inv Transaction" = RecEinvoice."Inv Transaction"::"Generate IRN" THEN BEGIN
                            // RecEinvoice.CALCFIELDS("Signed QR Code"); //ccit_kj
                            IF RecEinvoice."Signed QR Code".HASVALUE THEN BEGIN
                                RecEinvoice."Signed QR Code".CREATEINSTREAM(Streamin);
                                Streamin.READTEXT(qrtest);
                                qrtest := DELCHR(qrtest, '=', '"');
                                QRCodeInput := qrtest;
                                // QRCodeFileName := GetQRCode(QRCodeInput); //ccit_kj setup required for QR Code
                                //  UploadFile(TempBlob, QRCodeFileName); //ccit_kj file path needed
                                //QRCodeFileName := MoveToMagicPath(QRCodeFileName);
                                // CLEAR(TempBlob);

                                // ThreeTierMgt.BLOBImport(TempBlob, QRCodeFileName); //ccit_kj need to check tem blob
                                IF RecEinvoice."Signed QR Code".HASVALUE THEN;

                            END;
                        END;
                    END;
                END;

                IF ("Sales Invoice Header"."GST Without Payment of Duty" = TRUE) AND ("Sales Invoice Header"."Location State Code" = 'MH') THEN BEGIN
                    IF "Sales Invoice Header"."Posting Date" > 20210403D then //040321D THEN
                        LUTNo := 'ARN -AD2704210097944';
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

    trigger OnInitReport()
    begin
        //ERROR('Kindly contact to Mr. Avinash Bhor for Report: 50076' );
        //EXIT;
    end;

    trigger OnPreReport()
    begin
        maxline := 10;
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
        StateRec.SETRANGE(StateRec.Code, companyInfo."State Code"); //ccit_kj state field
        IF StateRec.FINDFIRST THEN BEGIN
            State := StateRec.Description;
        END;
    end;

    trigger OnPostReport()
    begin
        TempSalesInvTrackingLine.Reset();
        TempSalesInvTrackingLine.DeleteAll();
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
        FRom_ARN: code[20];
        To_ARN: code[20];
        From_GSTStateCode: Code[10];
        To_Name: Text[50];
        To_Address: Text;
        To_StateCode: Code[20];
        To_State: Text;
        To_City: Text;
        To_GSTStateCode: Code[10];
        To_GSTIN: Code[20];
        Fromcust: Record Customer;//"18";
        ToCust: Record Customer;//"18";
        TotalInvoiceAmt: Decimal;
        ReportCheck: Report "Posted Voucher";//"1401";
        AmountInWord: array[2] of Text[200];
        recSalesInvoiceLine: Record "Sales Invoice Line";//"113";
        recSalesInvoiceHeader: Record "Sales Invoice Header";//"112";
        TotalInvoiceAmt1: Decimal;
        ChargesAmount: Decimal;
        GlbInsCharge: Decimal;
        GlbOtherCharge: Decimal;
        GlbFrtCharge: Decimal;
        // StructureLineDetails: Record "13798";
        // ServTaxEntry_L: Record "16473"; //kj_not found in BC
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
        VendorItemCode: Code[20];
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
        RefNo: Text[120];
        PayMode1: Code[120];
        PayMode2: Code[120];
        PayMode3: Code[120];
        PayMode4: Code[120];
        PayMode5: Code[120];
        Card1: Integer;
        Card2: Integer;
        Card3: Integer;
        Card4: Integer;
        card5: Integer;
        RefNo1: Integer;
        RefNo2: Integer;
        RefNo3: Integer;
        RefNo4: Integer;
        PaymentMode1: Text[120];
        PaymentMode2: Text[120];
        RecSalesPerson: Record "Salesperson/Purchaser";//"13";
        RecEinvoice: Record 50015;
        Streamin: InStream;
        qrtest: Text;
        QRBLOB: BigText;
        VendorItemPartCode: Code[50];
        //  RecItem: Record Item;//"27";

        ThreeTierMgt: Codeunit "File Management";// "419";
        //TempBlob: Record TempBlob;//"99008535"; not in bc _kj
        QRCodeInput: Text;
        QRCodeFileName: Text;
        reccomment: Record "Sales Comment Line";//"44";
        comments: Text[1024];
        LUTNo: Text;
        IMEINo: Code[30];
        SerialNo: text[30];
        SalesShipLine: Record "Sales Shipment Line";
        itemLedEntry: Record "Item Ledger Entry";
        SalesInvoiceLine: record "Sales Invoice Line";
        FileMgm: Codeunit "File Management";//"419";
        RowID1Value: Text[250];
        TrackingSerial: Text;
        TrackingIMEI: Text;
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        ValueEntryRelation: Record "Value Entry Relation";
        ValueEntry: Record "Value Entry";
        ItemLedgEntry: Record "Item Ledger Entry";
        SignFactor: Integer;
        TempSalesInvTrackingLine: Record TempSalesInvTrackingLine;
    //kj++++++++++++++++
    /*   local procedure GetQRCode(QRCodeInput: Text) QRCodeFileName: Text
      var
          IBarCodeProvider: DotNet IBarcodeProvider;
      begin
          GetBarCodeProvider(IBarCodeProvider);
          QRCodeFileName := IBarCodeProvider.GetBarcode(QRCodeInput);
      end;


      procedure GetBarCodeProvider(var IBarCodeProvider: DotNet IBarcodeProvider)
      var
          QRCodeProvider: DotNet QRCodeProvider;
      begin
          QRCodeProvider := QRCodeProvider.QRCodeProvider;
          IBarCodeProvider := QRCodeProvider;
      end;
   */ //kj-----------------

    procedure MoveToMagicPath(SourceFileName: Text) DestinationFileName: Text
    var
    // FileSystemObject: Automation; //kj
    begin
        //kj_ commented function not in use
        /*       // User Temp Path

              DestinationFileName := ThreeTierMgt.ClientTempFileName('');
              IF ISCLEAR(FileSystemObject) THEN
                  CREATE(FileSystemObject, TRUE, TRUE);
              FileSystemObject.MoveFile(SourceFileName, DestinationFileName); */
    end;

    local procedure CreateQRCodeInput1(Line: Code[10]; TMLPONo: Code[20]) QRCodeInput: Text
    begin
        QRCodeInput := TMLPONo + Line;
    end;
    //kj tempblob is not in bc_+++++++++++
    //local procedure UploadFile(var TempBlob: Record TempBlob; FileName: Text)//"99008535"; FileName: Text)
    //begin
    /*  FileName := FileMgm.UploadFileSilent(FileName);
     FileMgm.BLOBImportFromServerFile(TempBlob, FileName);
     Deleteser(FileName); */ //kj tempblob is not in bc_----------
                             //end;

    local procedure Deleteser(ServerFileName: Text)
    begin
        //IF ERASE(ServerFileName) THEN; //kj_error
    end;

    /* 
    procedure GenerateBarCode()
     var
        Method: Text;
        HttpResponseMessage: DotNet HttpResponseMessage;
        WebUtility: DotNet WebUtility;
        null: DotNet Object;
        ImageStream: DotNet MemoryStream;
        OutStr: OutStream;
        Window: Dialog;
    begin
       
        IF Type = Type::" " THEN BEGIN
          CLEAR(Image);
          EXIT;
        END;
        */
    //Window.OPEN('Generating Bar Code');

    //IF Type = Type::qr THEN
    /* Method := STRSUBSTNO('barcode/qr/qr.%1?value=%2&size=%3&ecclevel=%4',
                           GetOptionStringValue("Image Type",FIELDNO("Image Type")),
                           WebUtility.UrlEncode(Value),
                           GetOptionStringValue(Size,FIELDNO(Size)),
                           GetOptionStringValue("ECC Level",FIELDNO("ECC Level")))

   {RESTWSManagement.CallRESTWebService('http://barcodes4.me/',
                                       Method,
                                       'GET',
                                       null,
                                       HttpResponseMessage);}


   ImageStream := HttpResponseMessage.Content.ReadAsStreamAsync.Result;

   CLEAR(Image);

   Image.CREATEOUTSTREAM(OutStr);
   ImageStream.WriteTo(OutStr);

   Window.CLOSE();


end;*/

    /* local procedure GetOptionStringValue(option: Integer; fieldno: Integer): Text
     var
         RecRef: RecordRef;
         FldRef: FieldRef;
         OptionString: DotNet String;
         options: DotNet Array;
         separator: DotNet String;
     begin

         RecRef.GETTABLE(Rec);
         FldRef := RecRef.FIELD(fieldno);
         OptionString := FldRef.OPTIONSTRING;

         separator := ',';
         options := OptionString.Split(separator.ToCharArray());
         EXIT(options.GetValue(option));


     end;*/
}

