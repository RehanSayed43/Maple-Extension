// report 50074 "GST-Sales Shield Invoice_NSK"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './GSTSalesShieldInvoiceNSK.rdlc';

//     dataset
//     {
//         dataitem("Sales Invoice Header"; "Sales Invoice Header")
//         {
//             RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
//             column(Text; Text)
//             {
//             }
//             column(Text17; Text17)
//             {
//             }
//             column(qrcode; TempBlob.Blob)
//             {
//             }
//             column(IRNNo_SalesInvoiceHeader; "Sales Invoice Header"."IRN No.")
//             {
//             }
//             column(LUTNo; LUTNo)
//             {
//             }
//             column(LocStateDesc; LocStateDesc)
//             {
//             }
//             column(LocAddr; LocAddr)
//             {
//             }
//             column(LocAddr2; LocAddr2)
//             {
//             }
//             column(LocCity; LocCity)
//             {
//             }
//             column(LocGSTRegNo; LocGSTRegNo)
//             {
//             }
//             column(LocName; LocName)
//             {
//             }
//             column(LocStateCode; LocStateCode)
//             {
//             }
//             column(companyInfo_Name; companyInfo.Name)
//             {
//             }
//             column(companyInfo_Address; companyInfo.Address)
//             {
//             }
//             column(companyInfo_Address2; companyInfo."Address 2")
//             {
//             }
//             column(companyInfo_City; companyInfo.City + '-' + companyInfo."Post Code")
//             {
//             }
//             column(companyInfo_State; companyInfo."State Code")
//             {
//             }
//             column(CompanyPicture; companyInfo.Picture)
//             {
//             }
//             column(County; companyInfo.County)
//             {
//             }
//             column(CompanyHomePage; companyInfo."Home Page")
//             {
//             }
//             column(CompanyEmail; companyInfo."E-Mail")
//             {
//             }
//             column(CompanyPhone; companyInfo."Phone No.")
//             {
//             }
//             column(IFSC_CompanyInfo; companyInfo."SWIFT Code")
//             {
//             }
//             column(CompanyFax; companyInfo."Fax No.")
//             {
//             }
//             column(ComGStReg; companyInfo."GST Registration No.")
//             {
//             }
//             column(Com_PAN_No; companyInfo."P.A.N. No.")
//             {
//             }
//             column(Com_Bank_Name; companyInfo."Bank Name")
//             {
//             }
//             column(Com_Bank_Acc_No; companyInfo."Bank Account No.")
//             {
//             }
//             column(BankName_; companyInfo."Bank Name")
//             {
//             }
//             column(VendorItemCode; RecItem."Vendor Item No.")
//             {
//             }
//             column(CompStateCode; CompStateCode)
//             {
//             }
//             column(cust_Name; cust.Name)
//             {
//             }
//             column(cust_Address; cust.Address)
//             {
//             }
//             column(State_Code; cust."State Code")
//             {
//             }
//             column(cust_GST_Registration_No; cust."GST Registration No.")
//             {
//             }
//             column(cust_PAN_No; cust."P.A.N. No.")
//             {
//             }
//             column(SalesShipment_No; SalesShipmentHdr."No.")
//             {
//             }
//             column(SalesPerCode; "Sales Invoice Header"."Salesperson Code")
//             {
//             }
//             column(PromoCode_SalesInvoiceHeader; "Sales Invoice Header"."External Document No.")
//             {
//             }
//             column(DispatchDocNo_SalesInvoiceHeader; "Sales Invoice Header"."Dispatch Doc. No.")
//             {
//             }
//             column(DispatchThrough_SalesInvoiceHeader; "Sales Invoice Header"."Dispatch Through")
//             {
//             }
//             column(From_Name; From_Name)
//             {
//             }
//             column(From_Address; From_Address)
//             {
//             }
//             column(FromAddress2; FromAddress2)
//             {
//             }
//             column(From_StateCode; From_StateCode)
//             {
//             }
//             column(From_City; From_City)
//             {
//             }
//             column(From_State; From_State)
//             {
//             }
//             column(From_GSTIN; From_GSTIN)
//             {
//             }
//             column(To_Name; To_Name)
//             {
//             }
//             column(To_Address; To_Address)
//             {
//             }
//             column(ToAddress2; ToAddress2)
//             {
//             }
//             column(To_StateCode; To_StateCode)
//             {
//             }
//             column(To_City; To_City)
//             {
//             }
//             column(To_State; To_State)
//             {
//             }
//             column(To_GSTIN; To_GSTIN)
//             {
//             }
//             column(State; State)
//             {
//             }
//             column(PostingDate_SalesInvoiceHeader; "Sales Invoice Header"."Posting Date")
//             {
//             }
//             column(No_SalesInvoiceHeader; "Sales Invoice Header"."No.")
//             {
//             }
//             column(AmounttoCustomer_SalesInvoiceHeader; '')
//             {
//             }
//             column(PaymentTermsCode_SalesInvoiceHeader; PayTerm)
//             {
//             }
//             column(AmountInWord; AmountInWord[1])
//             {
//             }
//             column(RemAmt; RemAmt)
//             {
//             }
//             column(companystate; companystate)
//             {
//             }
//             column(To_GSTStateCode; To_GSTStateCode)
//             {
//             }
//             column(From_GSTStateCode; From_GSTStateCode)
//             {
//             }
//             column(PaymentMode; PaymentMode)
//             {
//             }
//             column(NetPayable; NetPayable)
//             {
//             }
//             column(AmountInWordNetPayable; AmountInWordNetPayable[1])
//             {
//             }
//             column(refno; refno)
//             {
//             }
//             column(terms; terms)
//             {
//             }
//             column(ShipToName; ShipToName)
//             {
//             }
//             column(ShiptoAddress; ShiptoAddress)
//             {
//             }
//             column(ShiptoAddress2; ShiptoAddress2)
//             {
//             }
//             column(ShiptoCity; ShiptoCity)
//             {
//             }
//             column(ShiptoGSTIN; ShiptoGSTIN)
//             {
//             }
//             column(ShiptoState; ShiptoState)
//             {
//             }
//             column(ShiptoStateCode; ShiptoStateCode)
//             {
//             }
//             column(BankNm; BankNm)
//             {
//             }
//             column(BankAccntNo; BankAccntNo)
//             {
//             }
//             column(BankIFSCCd; BankIFSC)
//             {
//             }
//             column(BankAddr; BankAdd)
//             {
//             }
//             column(BankAddr2; BankAdd2)
//             {
//             }
//             column(BankCty; BankCity)
//             {
//             }
//             column(BankPinCode; BankPinCode)
//             {
//             }
//             column(PaymentMode1; PaymentMode1)
//             {
//             }
//             column(PaymentMode2; PaymentMode2)
//             {
//             }
//             column(CardNo; RefNo_L)
//             {
//             }
//             column(GSTWithoutPaymentofDuty_SalesInvoiceHeader; "Sales Invoice Header"."GST Without Payment of Duty")
//             {
//             }
//             column(LocationStateCode_SalesInvoiceHeader; "Sales Invoice Header"."Location State Code")
//             {
//             }
//             column(IRNNO; IRNNO)
//             {
//             }
//             column(QRCodeImg; EInvoiceEntry."QR Code")
//             {
//             }
//             dataitem(CopyLoop; Integer)
//             {
//                 DataItemTableView = SORTING(Number);
//                 dataitem(PageLoop; Integer)
//                 {
//                     DataItemTableView = SORTING(Number)
//                                         WHERE(Number = CONST(1));
//                     column(Title; Title)
//                     {
//                     }
//                     column(BilltoCustNo_SalesInvHdr; "Sales Invoice Header"."Bill-to Customer No.")
//                     {
//                     }
//                     column(Ship_to_Name; "Sales Invoice Header"."Ship-to Name")
//                     {
//                     }
//                     column(Ship_to_Address; "Sales Invoice Header"."Ship-to Address")
//                     {
//                     }
//                     column(DueDate_SalesInvoiceHeader; "Sales Invoice Header"."Due Date")
//                     {
//                     }
//                     column(OrderNo_SalesInvoiceHeader; "Sales Invoice Header"."Order No.")
//                     {
//                     }
//                     column(OrderDate_SalesInvoiceHeader; "Sales Invoice Header"."Order Date")
//                     {
//                     }
//                     column(BuyersOrderNo; "Sales Invoice Header"."Buyer's Order No.")
//                     {
//                     }
//                     column(BuyersOrderDate; "Sales Invoice Header"."Buyer's Order Dt")
//                     {
//                     }
//                     column(Delivery_Note; "Sales Invoice Header"."Delivery Note")
//                     {
//                     }
//                     column(OutputNo; OutputNo)
//                     {
//                     }
//                     column(PayTerm; PayTerm)
//                     {
//                     }
//                     dataitem("Sales Invoice Line"; "Sales Invoice Line")
//                     {
//                         DataItemLink = "Document No." = FIELD("No.");
//                         DataItemLinkReference = "Sales Invoice Header";
//                         DataItemTableView = SORTING("Document No.", "Line No.");
//                         column(SrNo; "Sr.No")
//                         {
//                         }
//                         column(ShieldType_SalesInvoiceLine; "Sales Invoice Line"."Shield Type")
//                         {
//                         }
//                         column(SerialNo_SalesInvoiceLine; "Sales Invoice Line"."Serial No.")
//                         {
//                         }
//                         column(IMEINo_SalesInvoiceLine; "Sales Invoice Line"."IMEI No.")
//                         {
//                         }
//                         column(Description; "Sales Invoice Line".Description)
//                         {
//                         }
//                         column(Type_SalesInvoiceLine; "Sales Invoice Line".Type)
//                         {
//                         }
//                         column(HSN_SAC_Code; "Sales Invoice Line"."HSN/SAC Code")
//                         {
//                         }
//                         column(Quantity; "Sales Invoice Line".Quantity)
//                         {
//                         }
//                         column(UnitofMeasure; "Sales Invoice Line"."Unit of Measure Code")
//                         {
//                         }
//                         column(Unit_Price; "Sales Invoice Line"."Unit Price")
//                         {
//                         }
//                         column(Amount; "Sales Invoice Line".Amount)
//                         {
//                         }
//                         column(Line_Discount; "Sales Invoice Line"."Line Discount Amount")
//                         {
//                         }
//                         column(GST_Base_Amount; '')
//                         {
//                         }
//                         column(GSTAmt; ABS(GSTAmt))
//                         {
//                         }
//                         column(GSTRate; GSTRate)
//                         {
//                         }
//                         column(IGSTAmt; ABS(IGSTAmt))
//                         {
//                         }
//                         column(CGSTAmt; ABS(CGSTAmt))
//                         {
//                         }
//                         column(SGSTAmt; ABS(SGSTAmt))
//                         {
//                         }
//                         column(CGSTRate; CGSTRate)
//                         {
//                         }
//                         column(IGSTRate; IGSTRate)
//                         {
//                         }
//                         column(SGSTRate; SGSTRate)
//                         {
//                         }
//                         column(GSTComponent; GSTComponent)
//                         {
//                         }
//                         column(TotalGSTAmount_SalesInvoiceLine; '')
//                         {
//                         }
//                         column(TotalInvoiceAmt; TotalInvoiceAmt)
//                         {
//                         }
//                         column(GlbFrtCharge; GlbFrtCharge)
//                         {
//                         }
//                         column(GlbInsCharge; GlbInsCharge)
//                         {
//                         }
//                         column(GlbPackCharge; GlbPackCharge)
//                         {
//                         }
//                         column(CESSAmount_SalesInvoiceLine; '')
//                         {
//                         }
//                         column(ItemNo; "Sales Invoice Line"."No.")
//                         {
//                         }
//                         column(GSTComponentCGST; GSTComponentCGST)
//                         {
//                         }
//                         column(GSTComponentSGST; GSTComponentSGST)
//                         {
//                         }
//                         column(GSTComponentIGST; GSTComponentIGST)
//                         {
//                         }
//                         column(Total_Value; '')
//                         {
//                         }
//                         column(ItemDesc; ItemDesc)
//                         {
//                         }
//                         column(uom; uom)
//                         {
//                         }
//                         column(venditemcode; venditemcode)
//                         {
//                         }

//                         trigger OnAfterGetRecord()
//                         begin
//                             linecount += 1;
//                             // StructureLineDetails.RESET;
//                             // StructureLineDetails.SETRANGE(Type, StructureLineDetails.Type::Sale);
//                             // StructureLineDetails.SETRANGE("Document Type", StructureLineDetails."Document Type"::Invoice);
//                             // StructureLineDetails.SETRANGE("Invoice No.", "Document No.");
//                             // StructureLineDetails.SETRANGE("Item No.", "No.");
//                             // StructureLineDetails.SETRANGE("Line No.", "Line No.");
//                             // IF StructureLineDetails.FIND('-') THEN
//                             //     REPEAT
//                             //         IF NOT StructureLineDetails."Payable to Third Party" THEN BEGIN

//                             //             IF StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::Charges THEN BEGIN

//                             //                 ChargesAmount := ChargesAmount + ABS(StructureLineDetails.Amount);

//                             //                 IF (StructureLineDetails."Tax/Charge Group" = 'FREIGHT') OR
//                             //                    (StructureLineDetails."Tax/Charge Code" = 'FREIGHT') THEN
//                             //                     GlbFrtCharge := GlbFrtCharge + ABS(StructureLineDetails.Amount)


//                             //                 ELSE
//                             //                     IF (StructureLineDetails."Tax/Charge Group" = 'INSURANCE') OR
//                             //                   (StructureLineDetails."Tax/Charge Code" = 'INSURANCE') THEN
//                             //                         // BEGIN
//                             //                         GlbInsCharge := GlbInsCharge + ABS(StructureLineDetails.Amount)
//                             //                     //  MESSAGE(FORMAT(GlbInsCharge));
//                             //                     //  END
//                             //                     ELSE
//                             //                         IF (StructureLineDetails."Tax/Charge Group" = 'PACKING') OR
//                             //                       (StructureLineDetails."Tax/Charge Code" = 'PACKING') THEN
//                             //                             // BEGIN
//                             //                             GlbPackCharge := GlbPackCharge + ABS(StructureLineDetails.Amount)
//                             //                         // MESSAGE(FORMAT(GlbPackCharge));
//                             //                         //  END
//                             //                         ELSE
//                             //                             GlbOtherCharge := GlbOtherCharge + ABS(StructureLineDetails.Amount);
//                             //             END;
//                             //         END;
//                             //     UNTIL StructureLineDetails.NEXT = 0;
//                             // //WIN275//tk




//                             //win352++
//                             "Sr.No" += 1;

//                             /*
//                             GSTDetailLeger.RESET;
//                             GSTComponent:='';GSTRate:=0;GSTAmt:=0;
//                             GSTDetailLeger.SETRANGE(GSTDetailLeger."Document No.","Sales Invoice Line"."Document No.");
//                             GSTDetailLeger.SETRANGE(GSTDetailLeger."No.","Sales Invoice Line"."No.");
//                             IF GSTDetailLeger.FINDSET THEN REPEAT
//                                   IF GSTDetailLeger."GST Component Code"='CGST' THEN BEGIN
//                                     GSTComponent:='CGST';
//                                     GSTRate:=GSTDetailLeger."GST %";
//                                     GSTAmt:=GSTDetailLeger."GST Amount";
//                                     END ELSE

//                                  IF GSTDetailLeger."GST Component Code"='SGST' THEN BEGIN
//                                     GSTComponent:='SGST';
//                                     GSTRate:=GSTDetailLeger."GST %";
//                                     GSTAmt:=GSTDetailLeger."GST Amount";
//                                     END  ELSE

//                                   IF GSTDetailLeger."GST Component Code"='IGST' THEN BEGIN
//                                     GSTComponent:='IGST';
//                                     GSTRate:=GSTDetailLeger."GST %";
//                                     GSTAmt:=GSTDetailLeger."GST Amount";
//                                     END;
//                             UNTIL GSTDetailLeger.NEXT=0;
//                             */


//                             GSTDetailLeger.RESET;
//                             GSTDetailLeger.SETRANGE(GSTDetailLeger."Document No.", "Sales Invoice Line"."Document No.");
//                             GSTDetailLeger.SETRANGE(GSTDetailLeger."No.", "Sales Invoice Line"."No.");
//                             GSTDetailLeger.SETRANGE(GSTDetailLeger."Document Line No.", "Sales Invoice Line"."Line No.");
//                             IF GSTDetailLeger.FINDSET THEN
//                                 REPEAT
//                                     IF GSTDetailLeger."GST Component Code" = 'CGST' THEN BEGIN
//                                         CLEAR(CGSTRate);
//                                         CLEAR(CGSTAmt);
//                                         CLEAR(GSTComponentCGST);
//                                         GSTComponentCGST := 'CGST';
//                                         CGSTRate := GSTDetailLeger."GST %";
//                                         CGSTAmt := GSTDetailLeger."GST Amount";
//                                     END ELSE
//                                         IF GSTDetailLeger."GST Component Code" = 'SGST' THEN BEGIN
//                                             CLEAR(SGSTRate);
//                                             CLEAR(SGSTAmt);
//                                             CLEAR(GSTComponentSGST);
//                                             GSTComponentSGST := 'SGST';
//                                             SGSTRate := GSTDetailLeger."GST %";
//                                             SGSTAmt := GSTDetailLeger."GST Amount";
//                                         END ELSE
//                                             IF GSTDetailLeger."GST Component Code" = 'IGST' THEN BEGIN
//                                                 CLEAR(IGSTRate);
//                                                 CLEAR(IGSTAmt);
//                                                 CLEAR(GSTComponentIGST);
//                                                 GSTComponentIGST := 'IGST';
//                                                 IGSTRate := GSTDetailLeger."GST %";
//                                                 IGSTAmt := GSTDetailLeger."GST Amount";
//                                             END;
//                                 UNTIL GSTDetailLeger.NEXT = 0;



//                             /*FinalTotal:=FinalTotal+"Sales Invoice Line".Amount+GlbFrtCharge+GlbInsCharge+GlbPackCharge+IGSTAmt+CGSTAmt+SGSTAmt;
//                             ReportCheck.InitTextVariable;
//                             ReportCheck.FormatNoText(AmountInWord,FinalTotal,' ');
//                             */

//                             // Sheild Item Discription and code
//                             uom := '';
//                             venditemcode := '';
//                             itemrec.RESET;
//                             itemrec.SETFILTER(itemrec."No.", "Sales Invoice Line"."Description 2");
//                             IF itemrec.FINDFIRST THEN
//                                 venditemcode := itemrec."Vendor Item No.";

//                             ItemDesc := '';
//                             salesinvline.RESET;
//                             salesinvline.SETFILTER(salesinvline."Document No.", refno);
//                             salesinvline.SETFILTER(salesinvline."No.", "Sales Invoice Line"."Description 2");
//                             IF salesinvline.FINDFIRST THEN BEGIN
//                                 ItemDesc := salesinvline.Description;
//                                 uom := salesinvline."Unit of Measure";
//                             END;

//                         end;

//                         trigger OnPreDataItem()
//                         begin
//                             linecount := 0;

//                             salesinvHdr.RESET;
//                             salesinvHdr.SETFILTER(salesinvHdr."No.", "Sales Invoice Header"."No.");
//                             IF salesinvHdr.FINDFIRST THEN
//                                 IF salesinvHdr."Ref. Invoice No." <> '' THEN
//                                     "Sales Invoice Line".SETFILTER("Sales Invoice Line"."No.", '310008');

//                             LinesCount := "Sales Invoice Line".COUNT;
//                             lineno := 10000;
//                         end;
//                     }
//                     dataitem(Integer;Integer)
//                     {
//                         DataItemLinkReference = "Sales Invoice Header";
//                         column(Number_Integer; Integer.Number)
//                         {
//                         }

//                         trigger OnPreDataItem()
//                         begin
//                             /*IF(linecount MOD maxline>0) THEN
//                               spline:=maxline-(linecount MOD maxline)
//                             ELSE
//                               spline:=0;*/

//                             //Integer.SETRANGE(Integer.Number,1,spline);

//                             IF linecount > maxline THEN
//                                 spline := maxline - ROUND((linecount / maxline - ROUND(linecount / maxline, 1, '<')) * maxline, 1)
//                             ELSE
//                                 spline := maxline - linecount;

//                             Integer.SETRANGE(Number, 1, spline);

//                         end;
//                     }
//                 }

//                 trigger OnAfterGetRecord()
//                 begin
//                     IF Number > 1 THEN BEGIN
//                         CopyText := Text16502;
//                         OutputNo += 1;
//                     END;
//                     CurrReport.PAGENO := 1;


//                     //Win 275
//                     IF OutputNo = 1 THEN BEGIN
//                         Title := Text1;
//                         "Sr.No" := 0;
//                         TotAmt := 0;
//                     END;

//                     IF OutputNo = 2 THEN BEGIN
//                         Title := Text2;
//                         "Sr.No" := 0;
//                         TotAmt := 0;
//                     END;

//                     IF OutputNo = 3 THEN BEGIN
//                         Title := Text3;
//                         "Sr.No" := 0;
//                         TotAmt := 0;
//                     END;

//                     /*
//                     IF OutputNo=4 THEN  BEGIN
//                      Title:=Text4;
//                      "Sr.No":=0;
//                      TotAmt:=0;
//                     END;
//                     */

//                 end;

//                 trigger OnPostDataItem()
//                 begin
//                     /*IF NOT CurrReport.PREVIEW THEN
//                       SalesInvCountPrinted.RUN("Sales Invoice Header");
//                       */

//                 end;

//                 trigger OnPreDataItem()
//                 begin
//                     NoOfLoops := ABS(NoOfCopies) + cust."Invoice Copies";
//                     IF NoOfLoops <= 0 THEN
//                         NoOfLoops := 1;
//                     CopyText := '';
//                     SETRANGE(Number, 1, NoOfLoops);
//                     OutputNo := 1;
//                 end;
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 //BankDetails
//                 IF Location.GET("Sales Invoice Header"."Location Code") THEN BEGIN
//                     IF Location.Code = 'M1107' THEN
//                         Text := 'Online Purchase'
//                     ELSE
//                         Text := recSalesInvoiceHeader."Delivery Note"
//                 END;
//                 IF Location.GET("Sales Invoice Header"."Location Code") THEN BEGIN
//                     IF Location.Code = 'M1107' THEN
//                         Text17 := 'Maple Digital Technology International Pvt.Ltd-Ecom'
//                     ELSE
//                         Text17 := RecLoc.Name
//                 END;
//                 IF BANKNAME <> '' THEN BEGIN
//                     //bankdetrec.GET(CompInfo."Bank Code");
//                     bankdetrec.GET(BANKNAME);
//                     BankNm := bankdetrec.Name;
//                     BankAdd := bankdetrec.Address;
//                     BankAdd2 := bankdetrec."Address 2";
//                     BankCity := bankdetrec.City;
//                     BankPinCode := bankdetrec."Post Code";
//                     BankIFSC := bankdetrec."IFSC Code";
//                     BankAccntNo := bankdetrec."Bank Account No.";
//                 END
//                 ELSE BEGIN
//                     //BANKNAME:='RBLCA621';


//                     BANKNAME := 'INDUSIND970';
//                     bankdetrec.GET(BANKNAME);
//                     BankNm := bankdetrec.Name;
//                     BankAdd := bankdetrec.Address;
//                     BankAdd2 := bankdetrec."Address 2";
//                     BankCity := bankdetrec.City;
//                     BankPinCode := bankdetrec."Post Code";
//                     BankIFSC := bankdetrec."IFSC Code";
//                     BankAccntNo := bankdetrec."Bank Account No.";
//                 END;

//                 Fromcust.RESET;
//                 Fromcust.SETRANGE(Fromcust."No.", "Sales Invoice Header"."Sell-to Customer No.");
//                 IF Fromcust.FINDFIRST THEN BEGIN
//                     From_Name := Fromcust.Name;
//                     From_Address := Fromcust.Address;
//                     FromAddress2 := Fromcust."Address 2";
//                     From_City := Fromcust.City + ' ' + Fromcust."Post Code";
//                     From_StateCode := Fromcust."State Code";
//                     From_GSTIN := Fromcust."GST Registration No.";

//                 END;

//                 StateRec.RESET;
//                 StateRec.SETRANGE(StateRec.Code, From_StateCode);
//                 IF StateRec.FINDFIRST THEN BEGIN
//                     From_State := StateRec.Description;
//                     From_GSTStateCode := StateRec.Code + ' (' + StateRec."State Code (GST Reg. No.)" + ')';
//                 END;

//                 ToCust.RESET;
//                 ToCust.SETRANGE(ToCust."No.", "Sales Invoice Header"."Bill-to Customer No.");
//                 IF ToCust.FINDFIRST THEN BEGIN
//                     To_Name := ToCust.Name;
//                     To_Address := ToCust.Address;
//                     ToAddress2 := ToCust."Address 2";
//                     To_City := ToCust.City + '  ' + ToCust."Post Code";
//                     To_StateCode := ToCust."State Code";
//                     To_GSTIN := ToCust."GST Registration No.";
//                 END;

//                 StateRec.RESET;
//                 StateRec.SETRANGE(StateRec.Code, To_StateCode);
//                 IF StateRec.FINDFIRST THEN BEGIN
//                     To_State := StateRec.Description;
//                     To_GSTStateCode := StateRec.Code + ' (' + StateRec."State Code (GST Reg. No.)" + ')';
//                 END;

//                 RecItem.RESET;
//                 RecItem.SETRANGE(RecItem."No.", "Sales Invoice Line"."No.");
//                 IF RecItem.FINDFIRST THEN
//                     VendorItemCode := RecItem."Vendor Item No.";
//                 //WIn345 Start
//                 SalesShipmentHdr.RESET;
//                 SalesShipmentHdr.SETRANGE(SalesShipmentHdr."Order No.", "Sales Invoice Header"."Order No.");
//                 IF SalesShipmentHdr.FINDFIRST THEN;
//                 //WIN345 End

//                 RecLoc.RESET;
//                 RecLoc.SETRANGE(RecLoc.Code, "Sales Invoice Header"."Location Code");
//                 IF RecLoc.FINDFIRST THEN BEGIN
//                     LocName := RecLoc.Name;
//                     LocAddr := RecLoc.Address;
//                     LocAddr2 := RecLoc."Address 2";
//                     LocCity := RecLoc.City + ' ' + RecLoc."Post Code";
//                     LocState := RecLoc."State Code";
//                     LocGSTRegNo := RecLoc."GST Registration No.";
//                 END;

//                 StateRec.RESET;
//                 StateRec.SETRANGE(StateRec.Code, LocState);
//                 IF StateRec.FINDFIRST THEN BEGIN
//                     LocStateDesc := StateRec.Description;
//                     LocStateCode := StateRec.Code + ' (' + StateRec."State Code (GST Reg. No.)" + ')';
//                 END;

//                 StateRec.RESET;
//                 StateRec.SETRANGE(StateRec.Code, companyInfo."State Code");
//                 IF StateRec.FINDFIRST THEN BEGIN
//                     companystate := StateRec.Description;
//                     CompStateCode := StateRec.Code + ' (' + StateRec."State Code (GST Reg. No.)" + ')';
//                 END;

//                 ReportCheck.InitTextVariable;
//                 ReportCheck.FormatNoText(AmountInWord, "Sales Invoice Header"."Amount To Customer UPIT", ' ');
//                 //ReportCheck.FormatNoText(AmountInWord,FinalTotal,' ');

//                 RecPayTerm.RESET;
//                 RecPayTerm.SETRANGE(RecPayTerm.Code, "Sales Invoice Header"."Payment Terms Code");
//                 IF RecPayTerm.FINDFIRST THEN
//                     PayTerm := RecPayTerm.Description;


//                 RemAmt := 0;
//                 RecCLE.RESET;
//                 RecCLE.SETRANGE(RecCLE."Customer No.", "Sales Invoice Header"."Sell-to Customer No.");
//                 RecCLE.SETRANGE(RecCLE."Document No.", "Sales Invoice Header"."No.");
//                 IF RecCLE.FINDFIRST THEN BEGIN
//                     RecCLE.CALCFIELDS("Remaining Amount");
//                     RemAmt += RecCLE."Remaining Amount";
//                 END;


//                 //Net Payable
//                 IF RemAmt <> 0 THEN
//                     NetPayable := ("Sales Invoice Header"."Amount To Customer UPIT") - (RemAmt);
//                 ReportCheck.InitTextVariable;
//                 ReportCheck.FormatNoText(AmountInWordNetPayable, NetPayable, ' ');

//                 //WIN347
//                 /*
//                 IF ("Sales Invoice Header".DebitCardNo1 <>'') THEN
//                    DbC1:='DbNo: ' + "Sales Invoice Header".PayByDebitCdNo1 + ' Amt: ' + FORMAT("Sales Invoice Header".PayByDebitAmt2);

//                   IF  ("Sales Invoice Header".CreditCardNo1 <>'') THEN
//                    CrC1:='CrNo: '+ "Sales Invoice Header".PayByCreditNo1 +' Amt: '+ FORMAT("Sales Invoice Header".PayByCreditAmt1);


//                   IF  ("Sales Invoice Header".CreditCardNo2 <>'') THEN
//                    CrC2:='CrNo: '+ "Sales Invoice Header".PayByCreditNo2 +' Amt: '+ FORMAT("Sales Invoice Header".PayByCreditAmt2);

//                   IF  ("Sales Invoice Header".CreditCardNo3 <>'') THEN
//                     CrC3:='CrNo: '+ "Sales Invoice Header".PayByCreditNo3 +' Amt: '+ FORMAT("Sales Invoice Header".PayByCreditAmt3);

//                   IF  ("Sales Invoice Header".CreditCardNo4 <>'') THEN
//                     CrC4:='CrNo: '+ "Sales Invoice Header".PayByCreditNo4 +' Amt: '+ FORMAT("Sales Invoice Header".PayByCreditAmt4);

//                   PaymentMode +=FORMAT(DbC1)+FORMAT(CrC1)+FORMAT(CrC2)+FORMAT(CrC3)+FORMAT(CrC4);
//                 *///WIn347
//                   /*
//                   IF "DebitCdPay Method Code1"<>'' THEN
//                       PayMode1:="Sales Invoice Header"."DebitCdPay Method Code1";

//                   IF "ChqPay Method Code"<>'' THEN
//                      PayMode2:="Sales Invoice Header"."ChqPay Method Code";

//                   IF "GiftPay Method Code"<>'' THEN
//                      PayMode3:="Sales Invoice Header"."GiftPay Method Code";

//                   IF "RTGSPay Method Code"<>'' THEN
//                      PayMode4:="Sales Invoice Header"."RTGSPay Method Code";

//                   IF "FinPay Method Code"<>'' THEN
//                     PayMode5:="Sales Invoice Header"."FinPay Method Code";

//                   PaymentMode1:= FORMAT("Sales Invoice Header"."Finance Comapny new")+' ' + "Sales Invoice Header"."Bank Approval Code"+' '+FORMAT("Sales Invoice Header"."Finance Amount");
//                   PaymentMode2:=PayMode2+''+PayMode3+''+PayMode4+''+PayMode5;



//                     IF  ("Sales Invoice Header".DebitCardNo1 <>'') THEN
//                      CrC1_C:="Sales Invoice Header".DebitCardNo1;


//                     IF  ("Sales Invoice Header".DebitCardNo2<>'') THEN
//                      CrC2_C:="Sales Invoice Header".DebitCardNo2;


//                   RefNo_L :=FORMAT(CrC1_C)+''+FORMAT(CrC2_C);
//                   *//*
//                   IF "Sales Invoice Header".DebitCardNo1 <>'' THEN
//                      DbC1:= "Sales Invoice Header".PayByDebitCdNo1 + ' ' + FORMAT("Sales Invoice Header".PayByDebitAmt2) +''+"Sales Invoice Header".DebitCardNo1;

//                     IF  "Sales Invoice Header".CreditCardNo1 <>'' THEN
//                      CrC1:="Sales Invoice Header".PayByCreditNo1 +' '+ FORMAT("Sales Invoice Header".PayByCreditAmt1)+' '+"Sales Invoice Header".CreditCardNo1;


//                     IF  "Sales Invoice Header".CreditCardNo2 <>'' THEN
//                      CrC2:= "Sales Invoice Header".PayByCreditNo2 +' '+ FORMAT("Sales Invoice Header".PayByCreditAmt2)+' '+"Sales Invoice Header".CreditCardNo2;

//                     IF  "Sales Invoice Header".CreditCardNo3 <>'' THEN
//                       CrC3:="Sales Invoice Header".PayByCreditNo3 +' '+ FORMAT("Sales Invoice Header".PayByCreditAmt3)+' '+ "Sales Invoice Header".CreditCardNo3;

//                     IF  "Sales Invoice Header".CreditCardNo4 <>'' THEN
//                       CrC4:="Sales Invoice Header".PayByCreditNo4 +' '+ FORMAT("Sales Invoice Header".PayByCreditAmt4)+' '+"Sales Invoice Header".CreditCardNo4;


//                   IF "DebitCdPay Method Code1"<>'' THEN
//                       PayMode1:="Sales Invoice Header"."DebitCdPay Method Code1"+' '+ FORMAT("Sales Invoice Header".PayByDebitCdAmt1);

//                   IF ("ChqPay Method Code"<>'') OR ("Sales Invoice Header".PayByChqNo<>'') THEN
//                      PayMode2:="Sales Invoice Header"."ChqPay Method Code" +' '+"Sales Invoice Header".PayByChqNo+' '+FORMAT("Sales Invoice Header".PayByChqDt)+' '+
//                   FORMAT("Sales Invoice Header".PayByChqAmt);

//                   IF "GiftPay Method Code"<>'' THEN
//                      PayMode3:="Sales Invoice Header"."GiftPay Method Code"+' '+  FORMAT("Sales Invoice Header".GiftVoucherAmt) ;

//                   IF "RTGSPay Method Code"<>'' THEN
//                      PayMode4:="Sales Invoice Header"."RTGSPay Method Code"+' '+ FORMAT("Sales Invoice Header"."RTGS Amount");


//                   IF "FinPay Method Code"<>'' THEN
//                     PayMode5:="Sales Invoice Header"."FinPay Method Code"+' '+ FORMAT("Sales Invoice Header"."Finance Amount");


//                   //IF "FinPay Method Code"<>'' THEN
//                   PaymentMode1:= FORMAT("Sales Invoice Header"."Finance Comapny")+' ' + "Sales Invoice Header"."Bank Approval Code"+' '+FORMAT("Sales Invoice Header"."Finance Amount")+' '+ DbC1+' '+CrC1+' '+CrC2+' '+CrC3+' ' +CrC4;

//                   PaymentMode2:=PayMode2+' '+PayMode3+' '+PayMode4+' '+PayMode5;
//                   */
//                     //WIN347
//                     /*
//                     IF ("Sales Invoice Header".DebitCardNo1 <>'') AND ("Sales Invoice Header".PayByDebitAmt2<> 0) THEN
//                        DbC1:= "Sales Invoice Header".PayByDebitCdNo1 + ' ' + FORMAT("Sales Invoice Header".PayByDebitAmt2) +' '+"Sales Invoice Header".DebitCardNo1;

//                       IF  ("Sales Invoice Header".CreditCardNo1 <>'') AND ("Sales Invoice Header".PayByCreditAmt1<> 0)THEN
//                        CrC1:="Sales Invoice Header".PayByCreditNo1 +' '+ FORMAT("Sales Invoice Header".PayByCreditAmt1)+' '+"Sales Invoice Header".CreditCardNo1;


//                       IF  ("Sales Invoice Header".CreditCardNo2 <>'') AND ("Sales Invoice Header".PayByCreditAmt2<> 0) THEN
//                        CrC2:= "Sales Invoice Header".PayByCreditNo2 +' '+ FORMAT("Sales Invoice Header".PayByCreditAmt2)+' '+"Sales Invoice Header".CreditCardNo2;

//                       IF  ("Sales Invoice Header".CreditCardNo3 <>'') AND ("Sales Invoice Header".PayByCreditAmt3<> 0) THEN
//                         CrC3:="Sales Invoice Header".PayByCreditNo3 +' '+ FORMAT("Sales Invoice Header".PayByCreditAmt3)+' '+ "Sales Invoice Header".CreditCardNo3;

//                       IF  ("Sales Invoice Header".CreditCardNo4 <>'') AND ("Sales Invoice Header".PayByCreditAmt4<> 0) THEN
//                         CrC4:="Sales Invoice Header".PayByCreditNo4 +' '+ FORMAT("Sales Invoice Header".PayByCreditAmt4)+' '+"Sales Invoice Header".CreditCardNo4;


//                     IF "DebitCdPay Method Code1"<>'' THEN
//                         PayMode1:="Sales Invoice Header"."DebitCdPay Method Code1"+' '+ FORMAT("Sales Invoice Header".PayByDebitCdAmt1);

//                     IF ("ChqPay Method Code"<>'') OR ("Sales Invoice Header".PayByChqNo<>' ') THEN
//                       BEGIN
//                       IF "Sales Invoice Header".PayByChqAmt<>0 THEN
//                         PayMode2:="Sales Invoice Header"."ChqPay Method Code" +' '+"Sales Invoice Header".PayByChqNo+' '+FORMAT("Sales Invoice Header".PayByChqDt)+' '+
//                     FORMAT("Sales Invoice Header".PayByChqAmt);
//                     IF "Sales Invoice Header".PayByChqAmt=0 THEN
//                         PayMode2:="Sales Invoice Header"."ChqPay Method Code" +' '+"Sales Invoice Header".PayByChqNo+' '+FORMAT("Sales Invoice Header".PayByChqDt);
//                       END;

//                     IF "GiftPay Method Code"<>'' THEN
//                        PayMode3:="Sales Invoice Header"."GiftPay Method Code"+' '+  FORMAT("Sales Invoice Header".GiftVoucherAmt) ;

//                     IF "RTGSPay Method Code"<>'' THEN
//                        PayMode4:="Sales Invoice Header"."RTGSPay Method Code"+' '+ FORMAT("Sales Invoice Header"."RTGS Amount");


//                     IF "FinPay Method Code"<>'' THEN
//                       PayMode5:="Sales Invoice Header"."FinPay Method Code"+' '+ FORMAT("Sales Invoice Header"."Finance Amount");

//                     //IF "Sales Invoice Header"."Bank Approval Code"<>'' AND ("Sales Invoice Header"."Finance Comapny new" ="Sales Invoice Header"."Finance Comapny new"<>' ') AND ("Sales Invoice Header"."Finance Amount") THEN
//                       // + "Sales Invoice Header"."Bank Approval Code"
//                     //IF "FinPay Method Code"<>'' THEN
//                     IF "Sales Invoice Header"."Finance Amount"<>0 THEN

//                     PaymentMode1:= FORMAT("Sales Invoice Header"."Finance Comapny new")+' '+' '+FORMAT("Sales Invoice Header"."Finance Amount")+' '+ DbC1+''+' '+CrC1+' '+' '+CrC2+' '+CrC3+' ' +CrC4;
//                     //MESSAGE(FORMAT("Sales Invoice Header"."Finance Amount"));
//                     IF "Sales Invoice Header"."Finance Amount"=0 THEN
//                     PaymentMode1:= FORMAT("Sales Invoice Header"."Finance Comapny new")+' '+ DbC1+''+' '+CrC1+' '+' '+CrC2+' '+CrC3+' ' +CrC4;
//                     PaymentMode2:=PayMode2+''+PayMode3+''+PayMode4+''+PayMode5;
//                     //MESSAGE(PayMode5);
//                     *///WIN347

//                 //Code for Payment Mode 1 and Payment Mode 2 WIN275
//                 IF ("Sales Invoice Header".DebitCardNo1 <> '') AND ("Sales Invoice Header".PayByDebitAmt2 <> 0) THEN
//                     DbC1 := "Sales Invoice Header".PayByDebitCdNo1 + ' ' + FORMAT("Sales Invoice Header".PayByDebitAmt2) + ' ' + "Sales Invoice Header".DebitCardNo1;

//                 IF ("Sales Invoice Header".CreditCardNo1 <> '') AND ("Sales Invoice Header".PayByCreditAmt1 <> 0) THEN
//                     CrC1 := "Sales Invoice Header".PayByCreditNo1 + ' ' + FORMAT("Sales Invoice Header".PayByCreditAmt1) + ' ' + "Sales Invoice Header".CreditCardNo1;


//                 IF ("Sales Invoice Header".CreditCardNo2 <> '') AND ("Sales Invoice Header".PayByCreditAmt2 <> 0) THEN
//                     CrC2 := "Sales Invoice Header".PayByCreditNo2 + ' ' + FORMAT("Sales Invoice Header".PayByCreditAmt2) + ' ' + "Sales Invoice Header".CreditCardNo2;

//                 IF ("Sales Invoice Header".CreditCardNo3 <> '') AND ("Sales Invoice Header".PayByCreditAmt3 <> 0) THEN
//                     CrC3 := "Sales Invoice Header".PayByCreditNo3 + ' ' + FORMAT("Sales Invoice Header".PayByCreditAmt3) + ' ' + "Sales Invoice Header".CreditCardNo3;

//                 IF ("Sales Invoice Header".CreditCardNo4 <> '') AND ("Sales Invoice Header".PayByCreditAmt4 <> 0) THEN
//                     CrC4 := "Sales Invoice Header".PayByCreditNo4 + ' ' + FORMAT("Sales Invoice Header".PayByCreditAmt4) + ' ' + "Sales Invoice Header".CreditCardNo4;


//                 IF ("DebitCdPay Method Code1" <> '') AND ("Sales Invoice Header".PayByDebitCdAmt1 <> 0) THEN
//                     PayMode1 := "Sales Invoice Header"."DebitCdPay Method Code1" + ' ' + FORMAT("Sales Invoice Header".PayByDebitCdAmt1);

//                 IF ("ChqPay Method Code" <> '') AND ("Sales Invoice Header".PayByChqAmt <> 0) THEN
//                     PayMode2 := "Sales Invoice Header"."ChqPay Method Code" + ' ' + "Sales Invoice Header".PayByChqNo + ' ' + FORMAT("Sales Invoice Header".PayByChqDt) + ' ' +
//                  FORMAT("Sales Invoice Header".PayByChqAmt);

//                 IF ("GiftPay Method Code" <> '') AND ("Sales Invoice Header".GiftVoucherAmt <> 0) THEN
//                     PayMode3 := "Sales Invoice Header"."GiftPay Method Code" + ' ' + FORMAT("Sales Invoice Header".GiftVoucherAmt);

//                 IF ("RTGSPay Method Code" <> '') AND ("Sales Invoice Header"."RTGS Amount" <> 0) THEN
//                     PayMode4 := "Sales Invoice Header"."RTGSPay Method Code" + ' ' + FORMAT("Sales Invoice Header"."RTGS Amount");

//                 /*
//                 IF "FinPay Method Code"<>'' THEN
//                   PayMode5:="Sales Invoice Header"."FinPay Method Code"+' '+ FORMAT("Sales Invoice Header"."Finance Amount");
//                 */

//                 IF ("Sales Invoice Header"."CashPay Method Code" <> '') AND ("Sales Invoice Header".PayByCashAmt <> 0) THEN
//                     PayMode5 := "Sales Invoice Header"."CashPay Method Code" + ' ' + FORMAT("Sales Invoice Header".PayByCashAmt);


//                 IF ("Sales Invoice Header"."Bank Approval Code" <> ' ') AND ("Sales Invoice Header"."Finance Amount" <> 0) THEN
//                     FinDet := FORMAT("Sales Invoice Header"."Finance Comapny new") + ' ' + "Sales Invoice Header"."Bank Approval Code" + ' ' + FORMAT("Sales Invoice Header"."Finance Amount");
//                 //IF "FinPay Method Code"<>'' THEN

//                 PaymentMode1 := FinDet + ' ' + DbC1 + '' + ' ' + CrC1 + ' ' + ' ' + CrC2 + ' ' + CrC3 + ' ' + CrC4;
//                 PaymentMode2 := PayMode2 + ' ' + PayMode3 + ' ' + PayMode4 + ' ' + PayMode5;
//                 //Code for Payment Mode 1 and Payment Mode 2 WIN275

//                 //Shield Terms
//                 terms := '';
//                 refno := '';
//                 salesinvHdr.RESET;
//                 salesinvHdr.SETFILTER(salesinvHdr."No.", "Sales Invoice Header"."No.");
//                 IF salesinvHdr.FINDFIRST THEN
//                     IF salesinvHdr."Ref. Invoice No." <> '' THEN
//                         refno := salesinvHdr."Ref. Invoice No.";
//                 salesinvline.RESET;
//                 salesinvline.SETRANGE(salesinvline."Document No.", refno);
//                 salesinvline.SETFILTER(salesinvline."Shield Type", '<>%1', salesinvline."Shield Type"::" ");
//                 IF salesinvline.FINDFIRST THEN BEGIN
//                     ShieldRec.RESET;
//                     ShieldRec.SETRANGE(ShieldRec."Shield Type", salesinvline."Shield Type");
//                     IF ShieldRec.FINDFIRST THEN
//                         IF "Sales Invoice Header"."Posting Date" < 20200108D THEN
//                             terms := ShieldRec."Shield Insurance T&C4" + ' ' + ShieldRec."Shield Insurance T&C5" + ' ' + ShieldRec."Shield Insurance T&C6" + ' ' + ShieldRec."Shield Insurance T&C7"
//                         ELSE
//                             terms := ShieldRec."Shield Insurance T&C" + ' ' + ShieldRec."Shield Insurance T&C1" + ' ' + ShieldRec."Shield Insurance T&C2" + ' ' + ShieldRec."Shield Insurance T&C3";
//                 END;
//                 //MESSAGE('%1',terms);
//                 //WIN347
//                 IF "Sales Invoice Header"."Ship-to Code" = '' THEN BEGIN
//                     Fromcust.RESET;
//                     Fromcust.SETRANGE(Fromcust."No.", "Sales Invoice Header"."Sell-to Customer No.");
//                     IF Fromcust.FINDFIRST THEN
//                         ShipToName := Fromcust.Name;
//                     ShiptoAddress := Fromcust.Address;
//                     ShiptoAddress2 := Fromcust."Address 2";
//                     ShiptoCity := Fromcust.City + ' ' + Fromcust."Post Code";
//                     ShiptoGSTIN := Fromcust."GST Registration No.";
//                     StateRec.RESET;
//                     StateRec.SETRANGE(StateRec.Code, Fromcust."State Code");
//                     IF StateRec.FINDFIRST THEN
//                         ShiptoState := StateRec.Description;
//                     ShiptoStateCode := StateRec.Code + ' (' + StateRec."State Code (GST Reg. No.)" + ')';
//                 END
//                 ELSE BEGIN
//                     RecShipToAddress.RESET;
//                     RecShipToAddress.SETRANGE(Code, "Sales Invoice Header"."Ship-to Code");
//                     RecShipToAddress.SETRANGE("Customer No.", "Sales Invoice Header"."Sell-to Customer No.");
//                     IF RecShipToAddress.FINDFIRST THEN
//                         ShipToName := RecShipToAddress.Name;
//                     ShiptoAddress := RecShipToAddress.Address;
//                     ShiptoAddress2 := RecShipToAddress."Address 2";
//                     ShiptoCity := RecShipToAddress.City + ' ' + RecShipToAddress."Post Code";
//                     ShiptoGSTIN := RecShipToAddress."GST Registration No.";
//                     StateRec.RESET;
//                     StateRec.SETRANGE(StateRec.Code, RecShipToAddress.State);
//                     IF StateRec.FINDFIRST THEN
//                         ShiptoState := StateRec.Description;
//                     ShiptoStateCode := StateRec.Code + ' (' + StateRec."State Code (GST Reg. No.)" + ')';
//                 END;


//                 IF ("Sales Invoice Header"."GST Without Payment of Duty" = TRUE) AND ("Sales Invoice Header"."Location State Code" = 'MH') THEN BEGIN
//                     IF "Sales Invoice Header"."Posting Date" < 20200104D THEN
//                         LUTNo := 'ARN -D270618001954V'
//                     ELSE
//                         LUTNo := 'ARN -AD270320029174I'
//                 END;

//                 IF ("Sales Invoice Header"."GST Without Payment of Duty" = TRUE) AND ("Sales Invoice Header"."Location State Code" = 'MH') THEN BEGIN
//                     IF "Sales Invoice Header"."Posting Date" > 20210304D THEN
//                         LUTNo := 'ARN -AD2704210097944';
//                 END;
//                 IF ("Sales Invoice Header"."GST Without Payment of Duty" = TRUE) AND ("Sales Invoice Header"."Location State Code" = 'KA') THEN BEGIN
//                     IF "Sales Invoice Header"."Posting Date" > 20210304D THEN
//                         LUTNo := 'ARN -AD290421003626B';
//                 END;

//                 //QR++
//                 IF "Sales Invoice Header"."Acknowledgement No." <> '' THEN BEGIN
//                     RecEinvoice.RESET;
//                     RecEinvoice.SETRANGE("Document No.", "No.");

//                     //RecEinvoice.SETRANGE("Inv Transaction",RecEinvoice."Inv Transaction"::"Generate IRN");
//                     IF RecEinvoice.FINDLAST THEN BEGIN
//                         IF RecEinvoice."Inv Transaction" = RecEinvoice."Inv Transaction"::"Generate IRN" THEN BEGIN
//                             RecEinvoice.CALCFIELDS("Signed QR Code");
//                             IF RecEinvoice."Signed QR Code".HASVALUE THEN BEGIN
//                                 RecEinvoice."Signed QR Code".CREATEINSTREAM(Streamin);
//                                 Streamin.READTEXT(qrtest);
//                                 qrtest := DELCHR(qrtest, '=', '"');
//                                 QRCodeInput := qrtest;
//                                 QRCodeFileName := GetQRCode(QRCodeInput);
//                                 QRCodeFileName := MoveToMagicPath(QRCodeFileName);
//                                 CLEAR(TempBlob);

//                                 ThreeTierMgt.BLOBImport(TempBlob, QRCodeFileName);
//                                 IF RecEinvoice."Signed QR Code".HASVALUE THEN;

//                             END;
//                         END;
//                     END;
//                 END;

//                 //kppl-UC
//                 CLEAR(IRNNO);
//                 EInvoiceEntry.RESET;
//                 EInvoiceEntry.SETRANGE("Document No.", "Sales Invoice Header"."No.");
//                 IF EInvoiceEntry.FINDFIRST THEN BEGIN
//                     IRNNO := EInvoiceEntry.IRN;
//                     EInvoiceEntry.CALCFIELDS("QR Code");
//                 END

//             end;

//             trigger OnPreDataItem()
//             begin
//                 TotAmt := 0;
//             end;
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//             area(content)
//             {
//                 group(Options)
//                 {
//                     Caption = 'Options';
//                     field(NoOfCopies; NoOfCopies)
//                     {
//                         Caption = 'No. of Copies';
//                     }
//                 }
//             }
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     trigger OnPreReport()
//     begin
//         maxline := 5;
//         linecount := 0;
//         spline := 0;

//         BankNm := '';
//         BankAdd := '';
//         BankAdd2 := '';
//         BankCity := '';
//         BankPinCode := '';
//         BankIFSC := '';
//         BankAccntNo := '';

//         companyInfo.GET();
//         companyInfo.CALCFIELDS(Picture);
//         "Sr.No" := 0;

//         //StateRec.RESET;

//         StateRec.RESET;
//         StateRec.SETRANGE(StateRec.Code, companyInfo."State Code");
//         IF StateRec.FINDFIRST THEN BEGIN
//             State := StateRec.Description;
//         END;
//     end;

//     var
//         LUTNo: Text;
//         GSTDetailLeger: Record "Detailed GST Ledger Entry";
//         CGSTRate: Decimal;
//         CGSTAmt: Decimal;
//         SGSTAmt: Decimal;
//         SGSTRate: Decimal;
//         IGSTRate: Decimal;
//         IGSTAmt: Decimal;
//         "Sr.No": Integer;
//         companyInfo: Record 79;
//         cust: Record 18;
//         StateRec: Record State;
//         From_Name: Text[50];
//         From_Address: Text;
//         From_StateCode: Code[20];
//         From_State: Text;
//         From_City: Text;
//         From_GSTIN: Code[20];
//         From_GSTStateCode: Code[10];
//         To_Name: Text[50];
//         To_Address: Text;
//         To_StateCode: Code[20];
//         To_State: Text;
//         To_City: Text;
//         To_GSTStateCode: Code[10];
//         To_GSTIN: Code[20];
//         Fromcust: Record 18;
//         ToCust: Record 18;
//         TotalInvoiceAmt: Decimal;
//         ReportCheck: Report Check;
//         recSalesInvoiceLine: Record 113;
//         recSalesInvoiceHeader: Record 112;
//         TotalInvoiceAmt1: Decimal;
//         ChargesAmount: Decimal;
//         GlbInsCharge: Decimal;
//         GlbOtherCharge: Decimal;
//         GlbFrtCharge: Decimal;
//         // StructureLineDetails: Record "13798";
//         // ServTaxEntry_L: Record "16473";
//         GlbPackCharge: Decimal;
//         RecLoc: Record 14;
//         LocName: Text;
//         LocAddr: Text;
//         LocAddr2: Text;
//         LocState: Text;
//         LocCity: Text;
//         LocGSTRegNo: Text;
//         LocStateDesc: Text;
//         NoOfCopies: Integer;
//         NoOfLoops: Integer;
//         CopyText: Text[30];
//         OutputNo: Integer;
//         Text16502: Label 'COPY';
//         Text1: Label 'Original for Recipient';
//         Text2: Label 'Duplicate';
//         Text3: Label 'Triplicate';
//         Text4: Label 'Quadruplicate';
//         Title: Text[50];
//         TotAmt: Decimal;
//         SalesShipmentHdr: Record 110;
//         RecItem: Record 27;
//         VendorItemCode: Code[20];
//         Freight: Decimal;
//         Insurance: Decimal;
//         Packing: Decimal;
//         FinalTotal: Decimal;
//         GSTComponent: Text;
//         GSTRate: Decimal;
//         GSTAmt: Decimal;
//         RecPayTerm: Record 3;
//         PayTerm: Text;
//         GSTComponentCGST: Text;
//         GSTComponentSGST: Text;
//         GSTComponentIGST: Text;
//         FromAddress2: Text;
//         ToAddress2: Text;
//         State: Text;
//         RecCLE: Record 21;
//         LocStateCode: Code[10];
//         RemAmt: Decimal;
//         companystate: Text;
//         CompStateCode: Code[10];
//         DbC1: Code[50];
//         DbC2: Code[50];
//         DbC3: Code[50];
//         DbC4: Code[50];
//         CrC1: Code[50];
//         CrC2: Code[50];
//         CrC3: Code[50];
//         CrC4: Code[50];
//         PaymentMode: Text;
//         NetPayable: Decimal;
//         AmountInWord: array[2] of Text[200];
//         AmountInWordNetPayable: array[2] of Text[200];
//         salesinvHdr: Record 112;
//         refno: Code[30];
//         salesinvline: Record 113;
//         terms: Text[1024];
//         ShieldRec: Record 7;
//         itemrec: Record 27;
//         venditemcode: Code[30];
//         ItemDesc: Text[250];
//         uom: Text[250];
//         RecShipToAddress: Record 222;
//         ShipToName: Text;
//         ShiptoAddress: Text;
//         ShiptoAddress2: Text;
//         ShiptoCity: Text;
//         ShiptoGSTIN: Code[20];
//         ShiptoState: Text;
//         ShiptoStateCode: Code[20];
//         lineno: Integer;
//         LinesCount: Integer;
//         BANKNAME: Text[30];
//         BankNm: Text[250];
//         BankAdd: Text[250];
//         BankAdd2: Text[250];
//         BankCity: Text[250];
//         BankPinCode: Code[30];
//         BankIFSC: Code[30];
//         BankAccntNo: Code[30];
//         bankdetrec1: Record 270;
//         bankdetrec: Record 270;
//         maxline: Integer;
//         linecount: Integer;
//         spline: Integer;
//         PayMode1: Code[100];
//         PayMode2: Code[100];
//         PayMode3: Code[100];
//         PayMode4: Code[100];
//         PayMode5: Code[100];
//         PaymentMode1: Text[120];
//         PaymentMode2: Text[120];
//         CrC1_C: Code[80];
//         CrC2_C: Code[80];
//         RefNo_L: Text[80];
//         PayMode6: Code[80];
//         FinDet: Text[80];
//         RecEinvoice: Record 50015;
//         Streamin: InStream;
//         qrtest: Text;
//         QRBLOB: BigText;
//         ThreeTierMgt: Codeunit 419;
//         TempBlob: Record "99008535";
//         QRCodeInput: Text;
//         QRCodeFileName: Text;
//         EInvoiceEntry: Record 50004;
//         IRNNO: Text[255];
//         Text: Text[55];
//         Text17: Text[55];
//         Location: Record 14;

//     local procedure GetQRCode(QRCodeInput: Text) QRCodeFileName: Text
//     var
//         [RunOnClient]
//         IBarCodeProvider: DotNet IBarcodeProvider;
//     begin
//         GetBarCodeProvider(IBarCodeProvider);
//         QRCodeFileName := IBarCodeProvider.GetBarcode(QRCodeInput);
//     end;


//     procedure GetBarCodeProvider(var IBarCodeProvider: DotNet IBarcodeProvider)
//     var
//         [RunOnClient]
//         QRCodeProvider: DotNet QRCodeProvider;
//     begin
//         QRCodeProvider := QRCodeProvider.QRCodeProvider;
//         IBarCodeProvider := QRCodeProvider;
//     end;


//     procedure MoveToMagicPath(SourceFileName: Text) DestinationFileName: Text
//     var
//         FileSystemObject: Automation;
//     begin
//         // User Temp Path

//         DestinationFileName := ThreeTierMgt.ClientTempFileName('');
//         IF ISCLEAR(FileSystemObject) THEN
//             CREATE(FileSystemObject, TRUE, TRUE);
//         FileSystemObject.MoveFile(SourceFileName, DestinationFileName);
//     end;

//     local procedure CreateQRCodeInput1(Line: Code[10]; TMLPONo: Code[20]) QRCodeInput: Text
//     begin
//         QRCodeInput := TMLPONo + Line;
//     end;
// }

