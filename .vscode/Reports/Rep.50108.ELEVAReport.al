// report 50108 "ELEVA Report"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './ELEVAReport.rdlc';

//     dataset
//     {
//         dataitem("Company Information";"Company Information"
//         {
//             DataItemTableView = SORTING ("Primary Key");
//             column(compinfoName; "Company Information".Name)
//             {
//             }
//             column(startdt; startdt)
//             {
//             }
//             column(enddt; enddt)
//             {
//             }
//         }
//         dataitem(DataItem4577; Table112)
//         {
//             DataItemTableView = SORTING (No.);
//             PrintOnlyIfDetail = false;
//             RequestFilterFields = "No.", "Sell-to Customer No.";
//             dataitem(DataItem1000000006; Table113)
//             {
//                 DataItemLink = Document No.=FIELD(No.);
//                 DataItemTableView = WHERE (Item Category Code=FILTER(<>ELEVA));
//                 column(FORMAT_TODAY_0_4_;FORMAT(TODAY,0,4))
//                 {
//                 }
//                 column(CurrReport_PAGENO;CurrReport.PAGENO)
//                 {
//                 }
//                 column(Srno;Srno)
//                 {
//                 }
//                 column(selltocust;"Sales Invoice Header"."Sell-to Customer Name")
//                 {
//                 }
//                 column(Location;"Sales Invoice Header"."Location Code")
//                 {
//                 }
//                 column(so_dt;"Sales Invoice Header"."Order Date")
//                 {
//                 }
//                 column(Vertical;"Sales Invoice Header"."Shortcut Dimension 2 Code")
//                 {
//                 }
//                 column(invno;"Sales Invoice Header"."No.")
//                 {
//                 }
//                 column(Inv_dt;"Sales Invoice Header"."Posting Date")
//                 {
//                 }
//                 column(custnm;"Sales Invoice Header"."Sell-to Customer Name")
//                 {
//                 }
//                 column(custno;"Sales Invoice Header"."Sell-to Customer No.")
//                 {
//                 }
//                 column(selltocty;"Sales Invoice Header"."Sell-to City")
//                 {
//                 }
//                 column(salep;"Sales Invoice Header"."Salesperson Code")
//                 {
//                 }
//                 column(delnote;"Sales Invoice Header"."Delivery Note")
//                 {
//                 }
//                 column(dispdocno;"Sales Invoice Header"."Dispatch Doc. No.")
//                 {
//                 }
//                 column(dispthru;"Sales Invoice Header"."Dispatch Through")
//                 {
//                 }
//                 column(payterms;"Sales Invoice Header"."Payment Terms Code")
//                 {
//                 }
//                 column(CustomerMobNo;"Sales Invoice Header"."Cust. Mobile No.")
//                 {
//                 }
//                 column(CustEmailId;"Sales Invoice Header"."Cust. email ID")
//                 {
//                 }
//                 column(salespnm;salesp.Name)
//                 {
//                 }
//                 column(paytermsdesc;payterms.Description)
//                 {
//                 }
//                 column(sono;"Sales Invoice Header"."Order No.")
//                 {
//                 }
//                 column(PoNo;purchhdr."No.")
//                 {
//                 }
//                 column(PoDt;purchhdr."Posting Date")
//                 {
//                 }
//                 column(GSTTIN_No;GSTTIN_No)
//                 {
//                 }
//                 column(PlaceOfSupply;PlaceOfSupply)
//                 {
//                 }
//                 column(ShieldAmtWOTax;"Sales Invoice Line"."Unit Price")
//                 {
//                 }
//                 column(ShieldTaxAmt;"Sales Invoice Line"."Tax Amount")
//                 {
//                 }
//                 column(ItemNoShield;"Sales Invoice Line"."Description 2")
//                 {
//                 }
//                 column(ShieldType;"Sales Invoice Line"."Shield Type")
//                 {
//                 }
//                 column(ShieldAmountWithTax;"Sales Invoice Line"."Amount Including Tax")
//                 {
//                 }
//                 column(zone;staterec.Zone)
//                 {
//                 }
//                 column(statenm;staterec.Description)
//                 {
//                 }
//                 column(venditemcd;item."Vendor Part Code Long")
//                 {
//                 }
//                 column(schemecode;"Sales Invoice Line"."Scheme Code")
//                 {
//                 }
//                 column(srlno;"Sales Invoice Line"."Serial No.")
//                 {
//                 }
//                 column(imeino;"Sales Invoice Line"."IMEI No.")
//                 {
//                 }
//                 column(schmamt;"Sales Invoice Line"."Scheme Amount")
//                 {
//                 }
//                 column(schmperc;"Sales Invoice Line"."Scheme %")
//                 {
//                 }
//                 column(maplecode;"Sales Invoice Line"."No.")
//                 {
//                 }
//                 column(partdesc;"Sales Invoice Line".Description)
//                 {
//                 }
//                 column(qty;"Sales Invoice Line".Quantity)
//                 {
//                 }
//                 column(unitp;"Sales Invoice Line"."Unit Price")
//                 {
//                 }
//                 column(taxamt;"Sales Invoice Line"."Tax Amount")
//                 {
//                 }
//                 column(taxp;"Sales Invoice Line"."Tax %")
//                 {
//                 }
//                 column(servtaxamt;"Sales Invoice Line"."Service Tax Amount")
//                 {
//                 }
//                 column(schmdesc;schem.Descritpion)
//                 {
//                 }
//                 column(netsaleswotax;netsaleswotax)
//                 {
//                 }
//                 column(totsalesamt;totsalesamt)
//                 {
//                 }
//                 column(salesprice;salesprice)
//                 {
//                 }
//                 column(maplediscamt;"Sales Invoice Line"."Line Discount Amount")
//                 {
//                 }
//                 column(maplelinedisc;"Sales Invoice Line"."Line Discount %")
//                 {
//                 }
//                 column(Charges;"Sales Invoice Line"."Charges To Customer")
//                 {
//                 }
//                 column(servtaxperc;servtaxperc)
//                 {
//                 }
//                 column(uom;"Sales Invoice Line"."Unit of Measure")
//                 {
//                 }
//                 column(Brand;"Sales Invoice Line"."Item Category Code")
//                 {
//                 }
//                 column(Catgry;"Sales Invoice Line"."Product Group Code")
//                 {
//                 }
//                 column(SalesPoints_SalesInvoiceLine;"Sales Invoice Line"."Sales Points")
//                 {
//                 }
//                 column(GSTGroupCode;"Sales Invoice Line"."GST Group Code")
//                 {
//                 }
//                 column(HSN_SAC_Code;"Sales Invoice Line"."HSN/SAC Code")
//                 {
//                 }
//                 column(CGSTAmt;ABS(CGSTAmt))
//                 {
//                 }
//                 column(SGSTAmt;ABS(SGSTAmt))
//                 {
//                 }
//                 column(IGSTAmt;ABS(IGSTAmt))
//                 {
//                 }
//                 column(TotalGSTAmount;"Sales Invoice Line"."Total GST Amount")
//                 {
//                 }
//                 column(AmountToCustomer_SalesInvoiceLine;"Sales Invoice Line"."Amount To Customer")
//                 {
//                 }
//                 column(ELEVADes;ELEVADes)
//                 {
//                 }
//                 column(ELEVAIMEINo;ELEVAIMEINo)
//                 {
//                 }
//                 column(ELEVASerialNo;ELEVASerialNo)
//                 {
//                 }
//                 column(ELEVAPrice;ELEVAPrice)
//                 {
//                 }
//                 column(CRItemNo;SalesCrMemoLine1."No.")
//                 {
//                 }
//                 column(CRAmount;SalesCrMemoLine1."Amount Including VAT")
//                 {
//                 }
//                 column(CRSerialNo;SalesCrMemoLine1."Item Serial No.")
//                 {
//                 }
//                 column(CRIMEINo;SalesCrMemoLine1."IMEI No.")
//                 {
//                 }
//                 column(CRDOcNo;SalesCrMemoLine1."Document No.")
//                 {
//                 }
//                 column(CRCustNo;SalesCrMemoLine1."Sell-to Customer No.")
//                 {
//                 }
//                 column(CRLoc;SalesCrMemoLine1."Location Code")
//                 {
//                 }
//                 column(CRPost;SalesCrMemoLine1."Posting Date")
//                 {
//                 }
//                 column(CRSelltoCustName;"Sales Invoice Header"."Sell-to Customer Name")
//                 {
//                 }
//                 column(CGSTRateCR;CGSTRateCR)
//                 {
//                 }
//                 column(CGSTAmtCR;CGSTAmtCR)
//                 {
//                 }
//                 column(SGSTAmtCR;SGSTAmtCR)
//                 {
//                 }
//                 column(SGSTRateCR;SGSTRateCR)
//                 {
//                 }
//                 column(IGSTRateCR;IGSTRateCR)
//                 {
//                 }
//                 column(IGSTAmtCR;IGSTAmtCR)
//                 {
//                 }
//                 column(GSTComponentCGSTCR;GSTComponentCGSTCR)
//                 {
//                 }
//                 column(GSTComponentSGSTCR;GSTComponentSGSTCR)
//                 {
//                 }
//                 column(GSTComponentIGSTCR;GSTComponentIGSTCR)
//                 {
//                 }
//                 column(CRDesc;SalesCrMemoLine1.Description)
//                 {
//                 }
//                 column(CRMobile;SalesCrMemoLine1."Cust. Mobile No.")
//                 {
//                 }
//                 column(CREmailId;SalesCrMemoLine1."Cust. email ID")
//                 {
//                 }
//                 column(CustInvNo;CustInvNo)
//                 {
//                 }
//                 column(TCGSTAmtCR;TCGSTAmtCR)
//                 {
//                 }
//                 column(TSGSTAmtCR;TSGSTAmtCR)
//                 {
//                 }
//                 column(TIGSTAmtCR;TIGSTAmtCR)
//                 {
//                 }

//                 trigger OnAfterGetRecord()
//                 var
//                     SalesInvoiceLine1: Record 113;
//                     CustomerMobNo: Decimal;
//                     CustomerEmailID: Text[100];
//                 begin
//                     //SCM Check++
//                     //MESSAGE("Sales Invoice Line"."Document No.");
//                     // SalesCrMemoHeader.RESET;
//                     // SalesCrMemoHeader.SETRANGE("Applies-to Doc. No.","Sales Invoice Line"."Document No.");
//                     // IF SalesCrMemoHeader.FINDFIRST THEN BEGIN
//                     //   ItemLedgerEntry.RESET;
//                     //   ItemLedgerEntry.SETRANGE("Document No.",SalesCrMemoHeader."No.");
//                     //   ItemLedgerEntry.SETRANGE("Item No.","Sales Invoice Line"."No.");
//                     //   ItemLedgerEntry.SETRANGE("Document Type",ItemLedgerEntry."Document Type"::"Sales Credit Memo");
//                     //   ItemLedgerEntry.SETRANGE("Serial No.","Sales Invoice Line"."Serial No.");
//                     //   IF ItemLedgerEntry.FINDFIRST THEN
//                     //     CurrReport.SKIP;
//                     // END;
//                     // //for shield return++
//                     // SalesCrMemoHeader.RESET;
//                     // SalesCrMemoHeader.SETRANGE("Applies-to Doc. No.","Sales Invoice Line"."Document No.");
//                     // IF SalesCrMemoHeader.FINDFIRST THEN BEGIN
//                     //   IF "Sales Invoice Line".Type="Sales Invoice Line".Type::"G/L Account" THEN BEGIN
//                     //      SalesCrMemoLine.RESET;
//                     //      SalesCrMemoLine.SETRANGE("Document No.",SalesCrMemoHeader."No.");
//                     //      SalesCrMemoLine.SETRANGE(Type,"Sales Invoice Line".Type::"G/L Account");
//                     //      SalesCrMemoLine.SETRANGE("No.","Sales Invoice Line"."No.");
//                     //      SalesCrMemoLine.SETRANGE("IMEI No.","Sales Invoice Line"."IMEI No.");
//                     //      IF SalesCrMemoLine.FINDFIRST THEN
//                     //        CurrReport.SKIP;
//                     //   END;
//                     //END;
//                     //SCM Check--
//                     //MESSAGE('2'+"Sales Invoice Line"."Document No.");
//                     IF staterec.GET("Sales Invoice Line".State) THEN;
//                     IF item.GET("Sales Invoice Line"."No.") THEN;
//                     IF schem.GET("Sales Invoice Line"."Scheme Code") THEN;
//                     salesprice:=0;
//                     salesprice:="Sales Invoice Line".Quantity*"Sales Invoice Line"."Unit Price";
//                     totsalesamt:=0;
//                     totsalesamt:=(("Sales Invoice Line".Quantity*"Sales Invoice Line"."Unit Price Incl. of Tax")-("Sales Invoice Line"."Scheme Amount"+"Sales Invoice Line"."Line Discount Amount"));
//                     netsaleswotax:=0;
//                     netsaleswotax:=(("Sales Invoice Line".Quantity*"Sales Invoice Line"."Unit Price")-("Sales Invoice Line"."Scheme Amount"+"Sales Invoice Line"."Line Discount Amount"));
//                     servtaxperc:=0;
//                     IF("Sales Invoice Line"."Service Tax Amount"<>0) AND ("Sales Invoice Line"."Service Tax Base"<>0) THEN
//                     servtaxperc:=("Sales Invoice Line"."Service Tax Amount"+"Sales Invoice Line"."Service Tax eCess Amount"+"Sales Invoice Line"."Service Tax SHE Cess Amount")/"Sales Invoice Line"."Service Tax Base";

//                     /*
//                     IF "Sales Invoice Line".Shield=TRUE THEN
//                     IF "Sales Invoice Line".Type="Sales Invoice Line".Type::"G/L Account" THEN
//                     IF "Sales Invoice Line"."No."<>'310008' THEN
//                     CurrReport.SKIP;


//                     Brand:='';
//                     Catgry:='';
//                     PrimCat:='';
//                     SecCat:='';
//                     ThirdCat:='';
//                     ItemCode:='';

//                     uom:='';
//                     venditemcode:='';
//                     itemrec.RESET;
//                     itemrec.SETFILTER(itemrec."No.","Sales Invoice Line"."No.");
//                     IF itemrec.FINDFIRST THEN
//                     //venditemcode:=itemrec."Vendor Item No.";
//                     venditemcode:=itemrec."Vendor Part Code Long";

//                     ItemDesc:='';
//                     salesinvline.RESET;
//                     salesinvline.SETFILTER(salesinvline."Document No.",refno);
//                     salesinvline.SETFILTER(salesinvline."No.","Sales Invoice Line"."Description 2");
//                     IF salesinvline.FINDFIRST THEN
//                     BEGIN
//                     ItemDesc:=salesinvline.Description;
//                     uom:=salesinvline."Unit of Measure";
//                     Brand:=salesinvline."Item Category Code";
//                     Catgry:=salesinvline."Product Group Code";
//                     PrimCat:=salesinvline."Primary category";
//                     SecCat:=salesinvline."Secondary category";
//                     ThirdCat:=salesinvline."Third category";
//                     ItemCode:=salesinvline."No.";
//                     END;
//                     */

//                     //For GST Fields WIN347++
//                     CLEAR(CGSTAmt);
//                     CLEAR(CGSTRate);
//                     CLEAR(GSTComponentCGST);
//                     CLEAR(SGSTAmt);
//                     CLEAR(SGSTRate);
//                     CLEAR(GSTComponentSGST);
//                     CLEAR(IGSTAmt);
//                     CLEAR(IGSTRate);
//                     CLEAR(GSTComponentIGST);
//                     GSTDetailLeger.RESET;
//                     GSTDetailLeger.SETRANGE(GSTDetailLeger."Document No.","Sales Invoice Line"."Document No.");
//                     GSTDetailLeger.SETRANGE(GSTDetailLeger."No.","Sales Invoice Line"."No.");
//                     GSTDetailLeger.SETRANGE(GSTDetailLeger."Document Line No.","Sales Invoice Line"."Line No.");
//                     IF GSTDetailLeger.FINDSET THEN REPEAT
//                     IF GSTDetailLeger."GST Component Code"='CGST' THEN BEGIN
//                       GSTComponentCGST:='CGST';
//                       CGSTRate:=GSTDetailLeger."GST %";
//                       CGSTAmt:=GSTDetailLeger."GST Amount";
//                       END ELSE
//                     IF GSTDetailLeger."GST Component Code"='SGST' THEN BEGIN
//                       GSTComponentSGST:='SGST';
//                       SGSTRate:=GSTDetailLeger."GST %";
//                       SGSTAmt:=GSTDetailLeger."GST Amount";
//                       END  ELSE
//                     IF GSTDetailLeger."GST Component Code"='IGST' THEN BEGIN
//                       GSTComponentIGST:='IGST';
//                       IGSTRate:=GSTDetailLeger."GST %";
//                       IGSTAmt:=GSTDetailLeger."GST Amount";
//                       END;
//                     UNTIL GSTDetailLeger.NEXT=0;
//                     //For GST Fields WIN347--

//                      //HR+
//                     ELEVADes := '';
//                     ELEVAIMEINo := '';
//                     ELEVASerialNo := '';
//                     ELEVAPrice := 0;
//                     CustInvNo := '';

//                     SalesInvoiceLine1.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
//                     SalesInvoiceLine1.SETRANGE("Primary category", "Sales Invoice Line"."Primary category");
//                     SalesInvoiceLine1.SETRANGE("Item Category Code", 'ELEVA');
//                     IF SalesInvoiceLine1.FINDFIRST THEN
//                     BEGIN
//                       ELEVADes := SalesInvoiceLine1.Description;
//                       ELEVAIMEINo := SalesInvoiceLine1."IMEI No.";
//                       ELEVASerialNo := SalesInvoiceLine1."Serial No.";
//                       ELEVAPrice := SalesInvoiceLine1."Unit Price Incl. of Tax";
//                       CustInvNo:= SalesInvoiceLine1."Document No.";
//                       CLEAR(SalesCrMemoLine1);
//                       SalesCrMemoLine1.RESET;
//                       SalesCrMemoLine1.SETRANGE("No.", SalesInvoiceLine1."No.");
//                       SalesCrMemoLine1.SETRANGE("IMEI No.", SalesInvoiceLine1."IMEI No.");
//                       SalesCrMemoLine1.SETRANGE("Item Serial No.", SalesInvoiceLine1."Serial No.");
//                       SalesCrMemoLine1.SETRANGE("Item Category Code", 'ELEVA');
//                       SalesCrMemoLine1.SETRANGE("Sell-to Customer No.", SalesInvoiceLine1."Sell-to Customer No.");
//                       IF SalesCrMemoLine1.FINDFIRST THEN BEGIN
//                         CLEAR(CGSTAmtCR);
//                         CLEAR(CGSTRateCR);
//                         CLEAR(GSTComponentCGSTCR);
//                         CLEAR(SGSTAmtCR);
//                         CLEAR(SGSTRateCR);
//                         CLEAR(GSTComponentSGSTCR);
//                         CLEAR(IGSTAmtCR);
//                         CLEAR(IGSTRateCR);
//                         CLEAR(GSTComponentIGSTCR);
//                         GSTDetailLeger.RESET;
//                         GSTDetailLeger.SETRANGE(GSTDetailLeger."Document No.", SalesCrMemoLine1."Document No.");
//                         GSTDetailLeger.SETRANGE(GSTDetailLeger."No.", SalesCrMemoLine1."No.");
//                         GSTDetailLeger.SETRANGE(GSTDetailLeger."Document Line No.", SalesCrMemoLine1."Line No.");
//                         IF GSTDetailLeger.FINDSET THEN REPEAT
//                           IF GSTDetailLeger."GST Component Code"='CGST' THEN BEGIN
//                             GSTComponentCGSTCR:='CGST';
//                             CGSTRateCR:=GSTDetailLeger."GST %";
//                             CGSTAmtCR:=GSTDetailLeger."GST Amount";
//                             TCGSTAmtCR+=GSTDetailLeger."GST Amount";
//                            END ELSE
//                           IF GSTDetailLeger."GST Component Code"='SGST' THEN BEGIN
//                             GSTComponentSGSTCR:='SGST';
//                             SGSTRateCR:=GSTDetailLeger."GST %";
//                             SGSTAmtCR:=GSTDetailLeger."GST Amount";
//                             TSGSTAmtCR+=GSTDetailLeger."GST Amount";
//                           END  ELSE
//                           IF GSTDetailLeger."GST Component Code"='IGST' THEN BEGIN
//                             GSTComponentIGSTCR:='IGST';
//                             IGSTRateCR:=GSTDetailLeger."GST %";
//                             IGSTAmtCR:=GSTDetailLeger."GST Amount";
//                             TIGSTAmtCR+=GSTDetailLeger."GST Amount";
//                           END;
//                         UNTIL GSTDetailLeger.NEXT=0;
//                       END;


//                     END;

//                     IF ELEVADes = '' THEN
//                       CurrReport.SKIP;


//                     //HR-

//                 end;
//             }
//             dataitem(SalesInvoiceLine;Table113)
//             {
//                 DataItemLink = Document No.=FIELD(No.);
//                 DataItemTableView = WHERE(Item Category Code=FILTER(ELEVA));
//                 column(FORMAT_TODAY_0_4_1;FORMAT(TODAY,0,4))
//                 {
//                 }
//                 column(CurrReport_PAGENO1;CurrReport.PAGENO)
//                 {
//                 }
//                 column(Srno1;Srno)
//                 {
//                 }
//                 column(selltocust1;"Sales Invoice Header"."Sell-to Customer Name")
//                 {
//                 }
//                 column(Location1;"Sales Invoice Header"."Location Code")
//                 {
//                 }
//                 column(so_dt1;"Sales Invoice Header"."Order Date")
//                 {
//                 }
//                 column(Vertical1;"Sales Invoice Header"."Shortcut Dimension 2 Code")
//                 {
//                 }
//                 column(invno1;"Sales Invoice Header"."No.")
//                 {
//                 }
//                 column(Inv_dt1;"Sales Invoice Header"."Posting Date")
//                 {
//                 }
//                 column(custnm1;"Sales Invoice Header"."Sell-to Customer Name")
//                 {
//                 }
//                 column(custno1;"Sales Invoice Header"."Sell-to Customer No.")
//                 {
//                 }
//                 column(selltocty1;"Sales Invoice Header"."Sell-to City")
//                 {
//                 }
//                 column(salep1;"Sales Invoice Header"."Salesperson Code")
//                 {
//                 }
//                 column(delnote1;"Sales Invoice Header"."Delivery Note")
//                 {
//                 }
//                 column(dispdocno1;"Sales Invoice Header"."Dispatch Doc. No.")
//                 {
//                 }
//                 column(dispthru1;"Sales Invoice Header"."Dispatch Through")
//                 {
//                 }
//                 column(payterms1;"Sales Invoice Header"."Payment Terms Code")
//                 {
//                 }
//                 column(CustomerMobNo1;"Sales Invoice Header"."Cust. Mobile No.")
//                 {
//                 }
//                 column(CustEmailId1;"Sales Invoice Header"."Cust. email ID")
//                 {
//                 }
//                 column(salespnm1;salesp.Name)
//                 {
//                 }
//                 column(paytermsdesc1;payterms.Description)
//                 {
//                 }
//                 column(sono1;"Sales Invoice Header"."Order No.")
//                 {
//                 }
//                 column(PoNo1;purchhdr."No.")
//                 {
//                 }
//                 column(PoDt1;purchhdr."Posting Date")
//                 {
//                 }
//                 column(GSTTIN_No1;GSTTIN_No)
//                 {
//                 }
//                 column(PlaceOfSupply1;PlaceOfSupply)
//                 {
//                 }
//                 column(ShieldAmtWOTax1;SalesInvoiceLine."Unit Price")
//                 {
//                 }
//                 column(ShieldTaxAmt1;SalesInvoiceLine."Tax Amount")
//                 {
//                 }
//                 column(ItemNoShield1;SalesInvoiceLine."Description 2")
//                 {
//                 }
//                 column(ShieldType1;SalesInvoiceLine."Shield Type")
//                 {
//                 }
//                 column(ShieldAmountWithTax1;SalesInvoiceLine."Amount Including Tax")
//                 {
//                 }
//                 column(zone1;staterec.Zone)
//                 {
//                 }
//                 column(statenm1;staterec.Description)
//                 {
//                 }
//                 column(venditemcd1;item."Vendor Part Code Long")
//                 {
//                 }
//                 column(schemecode1;SalesInvoiceLine."Scheme Code")
//                 {
//                 }
//                 column(srlno1;SalesInvoiceLine."Serial No.")
//                 {
//                 }
//                 column(imeino1;SalesInvoiceLine."IMEI No.")
//                 {
//                 }
//                 column(schmamt1;SalesInvoiceLine."Scheme Amount")
//                 {
//                 }
//                 column(schmperc1;SalesInvoiceLine."Scheme %")
//                 {
//                 }
//                 column(maplecode1;SalesInvoiceLine."No.")
//                 {
//                 }
//                 column(partdesc1;SalesInvoiceLine.Description)
//                 {
//                 }
//                 column(qty1;SalesInvoiceLine.Quantity)
//                 {
//                 }
//                 column(unitp1;SalesInvoiceLine."Unit Price")
//                 {
//                 }
//                 column(taxamt1;SalesInvoiceLine."Tax Amount")
//                 {
//                 }
//                 column(taxp1;SalesInvoiceLine."Tax %")
//                 {
//                 }
//                 column(servtaxamt1;SalesInvoiceLine."Service Tax Amount")
//                 {
//                 }
//                 column(schmdesc1;schem.Descritpion)
//                 {
//                 }
//                 column(netsaleswotax1;netsaleswotax)
//                 {
//                 }
//                 column(totsalesamt1;totsalesamt)
//                 {
//                 }
//                 column(salesprice1;salesprice)
//                 {
//                 }
//                 column(maplediscamt1;SalesInvoiceLine."Line Discount Amount")
//                 {
//                 }
//                 column(maplelinedisc1;SalesInvoiceLine."Line Discount %")
//                 {
//                 }
//                 column(Charges1;SalesInvoiceLine."Charges To Customer")
//                 {
//                 }
//                 column(servtaxperc1;servtaxperc)
//                 {
//                 }
//                 column(uom1;SalesInvoiceLine."Unit of Measure")
//                 {
//                 }
//                 column(Brand1;SalesInvoiceLine."Item Category Code")
//                 {
//                 }
//                 column(Catgry1;SalesInvoiceLine."Product Group Code")
//                 {
//                 }
//                 column(SalesPoints_SalesInvoiceLine1;SalesInvoiceLine."Sales Points")
//                 {
//                 }
//                 column(GSTGroupCode1;SalesInvoiceLine."GST Group Code")
//                 {
//                 }
//                 column(HSN_SAC_Code1;SalesInvoiceLine."HSN/SAC Code")
//                 {
//                 }
//                 column(CGSTAmt1;ABS(CGSTAmt))
//                 {
//                 }
//                 column(SGSTAmt1;ABS(SGSTAmt))
//                 {
//                 }
//                 column(IGSTAmt1;ABS(IGSTAmt))
//                 {
//                 }
//                 column(TotalGSTAmount1;SalesInvoiceLine."Total GST Amount")
//                 {
//                 }
//                 column(AmountToCustomer_SalesInvoiceLine1;SalesInvoiceLine."Amount To Customer")
//                 {
//                 }
//                 column(ELEVADes1;ELEVADes)
//                 {
//                 }
//                 column(ELEVAIMEINo1;ELEVAIMEINo)
//                 {
//                 }
//                 column(ELEVASerialNo1;ELEVASerialNo)
//                 {
//                 }
//                 column(ELEVAPrice1;ELEVAPrice)
//                 {
//                 }
//                 column(CRItemNo1;SalesCrMemoLine1."No.")
//                 {
//                 }
//                 column(CRAmount1;SalesCrMemoLine1."Amount Including VAT")
//                 {
//                 }
//                 column(CRSerialNo1;SalesCrMemoLine1."Item Serial No.")
//                 {
//                 }
//                 column(CRIMEINo1;SalesCrMemoLine1."IMEI No.")
//                 {
//                 }
//                 column(CRDOcNo1;SalesCrMemoLine1."Document No.")
//                 {
//                 }
//                 column(CRCustNo1;SalesCrMemoLine1."Sell-to Customer No.")
//                 {
//                 }
//                 column(CRLoc1;SalesCrMemoLine1."Location Code")
//                 {
//                 }
//                 column(CRPost1;SalesCrMemoLine1."Posting Date")
//                 {
//                 }
//                 column(CRSelltoCustName1;"Sales Invoice Header"."Sell-to Customer Name")
//                 {
//                 }
//                 column(CGSTRateCR1;CGSTRateCR)
//                 {
//                 }
//                 column(CGSTAmtCR1;CGSTAmtCR)
//                 {
//                 }
//                 column(SGSTAmtCR1;SGSTAmtCR)
//                 {
//                 }
//                 column(SGSTRateCR1;SGSTRateCR)
//                 {
//                 }
//                 column(IGSTRateCR1;IGSTRateCR)
//                 {
//                 }
//                 column(IGSTAmtCR1;IGSTAmtCR)
//                 {
//                 }
//                 column(GSTComponentCGSTCR1;GSTComponentCGSTCR)
//                 {
//                 }
//                 column(GSTComponentSGSTCR1;GSTComponentSGSTCR)
//                 {
//                 }
//                 column(GSTComponentIGSTCR1;GSTComponentIGSTCR)
//                 {
//                 }
//                 column(CRDesc1;SalesCrMemoLine1.Description)
//                 {
//                 }
//                 column(CRMobile1;SalesCrMemoLine1."Cust. Mobile No.")
//                 {
//                 }
//                 column(CREmailId1;SalesCrMemoLine1."Cust. email ID")
//                 {
//                 }
//                 column(CustInvNo1;CustInvNo)
//                 {
//                 }
//                 column(TCGSTAmtCR1;TCGSTAmtCR)
//                 {
//                 }
//                 column(TSGSTAmtCR1;TSGSTAmtCR)
//                 {
//                 }
//                 column(TIGSTAmtCR1;TIGSTAmtCR)
//                 {
//                 }

//                 trigger OnAfterGetRecord()
//                 var
//                     SalesInvoiceLine2: Record "113";
//                     CustomerMobNo: Decimal;
//                     CustomerEmailID: Text[100];
//                 begin
//                     //SCM Check++
//                     //MESSAGE("Sales Invoice Line"."Document No.");
//                     // SalesCrMemoHeader.RESET;
//                     // SalesCrMemoHeader.SETRANGE("Applies-to Doc. No.","Sales Invoice Line"."Document No.");
//                     // IF SalesCrMemoHeader.FINDFIRST THEN BEGIN
//                     //   ItemLedgerEntry.RESET;
//                     //   ItemLedgerEntry.SETRANGE("Document No.",SalesCrMemoHeader."No.");
//                     //   ItemLedgerEntry.SETRANGE("Item No.","Sales Invoice Line"."No.");
//                     //   ItemLedgerEntry.SETRANGE("Document Type",ItemLedgerEntry."Document Type"::"Sales Credit Memo");
//                     //   ItemLedgerEntry.SETRANGE("Serial No.","Sales Invoice Line"."Serial No.");
//                     //   IF ItemLedgerEntry.FINDFIRST THEN
//                     //     CurrReport.SKIP;
//                     // END;
//                     // //for shield return++
//                     // SalesCrMemoHeader.RESET;
//                     // SalesCrMemoHeader.SETRANGE("Applies-to Doc. No.","Sales Invoice Line"."Document No.");
//                     // IF SalesCrMemoHeader.FINDFIRST THEN BEGIN
//                     //   IF "Sales Invoice Line".Type="Sales Invoice Line".Type::"G/L Account" THEN BEGIN
//                     //      SalesCrMemoLine.RESET;
//                     //      SalesCrMemoLine.SETRANGE("Document No.",SalesCrMemoHeader."No.");
//                     //      SalesCrMemoLine.SETRANGE(Type,"Sales Invoice Line".Type::"G/L Account");
//                     //      SalesCrMemoLine.SETRANGE("No.","Sales Invoice Line"."No.");
//                     //      SalesCrMemoLine.SETRANGE("IMEI No.","Sales Invoice Line"."IMEI No.");
//                     //      IF SalesCrMemoLine.FINDFIRST THEN
//                     //        CurrReport.SKIP;
//                     //   END;
//                     //END;
//                     //SCM Check--
//                     //MESSAGE('2'+"Sales Invoice Line"."Document No.");

//                     IF staterec.GET(SalesInvoiceLine.State) THEN;
//                     IF item.GET(SalesInvoiceLine."No.") THEN;
//                     IF schem.GET(SalesInvoiceLine."Scheme Code") THEN;
//                     salesprice:=0;
//                     salesprice:=SalesInvoiceLine.Quantity*SalesInvoiceLine."Unit Price";
//                     totsalesamt:=0;
//                     totsalesamt:=((SalesInvoiceLine.Quantity*SalesInvoiceLine."Unit Price Incl. of Tax")-(SalesInvoiceLine."Scheme Amount"+SalesInvoiceLine."Line Discount Amount"));
//                     netsaleswotax:=0;
//                     netsaleswotax:=((SalesInvoiceLine.Quantity*SalesInvoiceLine."Unit Price")-(SalesInvoiceLine."Scheme Amount"+SalesInvoiceLine."Line Discount Amount"));
//                     servtaxperc:=0;
//                     IF(SalesInvoiceLine."Service Tax Amount"<>0) AND (SalesInvoiceLine."Service Tax Base"<>0) THEN
//                     servtaxperc:=(SalesInvoiceLine."Service Tax Amount"+SalesInvoiceLine."Service Tax eCess Amount"+SalesInvoiceLine."Service Tax SHE Cess Amount")/SalesInvoiceLine."Service Tax Base";

//                     /*
//                     IF "Sales Invoice Line".Shield=TRUE THEN
//                     IF "Sales Invoice Line".Type="Sales Invoice Line".Type::"G/L Account" THEN
//                     IF "Sales Invoice Line"."No."<>'310008' THEN
//                     CurrReport.SKIP;


//                     Brand:='';
//                     Catgry:='';
//                     PrimCat:='';
//                     SecCat:='';
//                     ThirdCat:='';
//                     ItemCode:='';

//                     uom:='';
//                     venditemcode:='';
//                     itemrec.RESET;
//                     itemrec.SETFILTER(itemrec."No.","Sales Invoice Line"."No.");
//                     IF itemrec.FINDFIRST THEN
//                     //venditemcode:=itemrec."Vendor Item No.";
//                     venditemcode:=itemrec."Vendor Part Code Long";

//                     ItemDesc:='';
//                     salesinvline.RESET;
//                     salesinvline.SETFILTER(salesinvline."Document No.",refno);
//                     salesinvline.SETFILTER(salesinvline."No.","Sales Invoice Line"."Description 2");
//                     IF salesinvline.FINDFIRST THEN
//                     BEGIN
//                     ItemDesc:=salesinvline.Description;
//                     uom:=salesinvline."Unit of Measure";
//                     Brand:=salesinvline."Item Category Code";
//                     Catgry:=salesinvline."Product Group Code";
//                     PrimCat:=salesinvline."Primary category";
//                     SecCat:=salesinvline."Secondary category";
//                     ThirdCat:=salesinvline."Third category";
//                     ItemCode:=salesinvline."No.";
//                     END;
//                     */

//                     //For GST Fields WIN347++
//                     CLEAR(CGSTAmt);
//                     CLEAR(CGSTRate);
//                     CLEAR(GSTComponentCGST);
//                     CLEAR(SGSTAmt);
//                     CLEAR(SGSTRate);
//                     CLEAR(GSTComponentSGST);
//                     CLEAR(IGSTAmt);
//                     CLEAR(IGSTRate);
//                     CLEAR(GSTComponentIGST);
//                     GSTDetailLeger.RESET;
//                     GSTDetailLeger.SETRANGE(GSTDetailLeger."Document No.",SalesInvoiceLine."Document No.");
//                     GSTDetailLeger.SETRANGE(GSTDetailLeger."No.",SalesInvoiceLine."No.");
//                     GSTDetailLeger.SETRANGE(GSTDetailLeger."Document Line No.",SalesInvoiceLine."Line No.");
//                     IF GSTDetailLeger.FINDSET THEN REPEAT
//                     IF GSTDetailLeger."GST Component Code"='CGST' THEN BEGIN
//                       GSTComponentCGST:='CGST';
//                       CGSTRate:=GSTDetailLeger."GST %";
//                       CGSTAmt:=GSTDetailLeger."GST Amount";
//                       END ELSE
//                     IF GSTDetailLeger."GST Component Code"='SGST' THEN BEGIN
//                       GSTComponentSGST:='SGST';
//                       SGSTRate:=GSTDetailLeger."GST %";
//                       SGSTAmt:=GSTDetailLeger."GST Amount";
//                       END  ELSE
//                     IF GSTDetailLeger."GST Component Code"='IGST' THEN BEGIN
//                       GSTComponentIGST:='IGST';
//                       IGSTRate:=GSTDetailLeger."GST %";
//                       IGSTAmt:=GSTDetailLeger."GST Amount";
//                       END;
//                     UNTIL GSTDetailLeger.NEXT=0;
//                     //For GST Fields WIN347--

//                      //HR+
//                     ELEVADes := '';
//                     ELEVAIMEINo := '';
//                     ELEVASerialNo := '';
//                     ELEVAPrice := 0;
//                     CustInvNo := '';

//                     SalesInvoiceLine2.SETRANGE("Document No.", SalesInvoiceLine."Document No.");
//                     SalesInvoiceLine2.SETRANGE("Primary category", SalesInvoiceLine."Primary category");
//                     SalesInvoiceLine2.SETFILTER("Item Category Code",'<>%1' ,'ELEVA');
//                     IF SalesInvoiceLine2.FINDFIRST THEN
//                     BEGIN
//                       ELEVADes := SalesInvoiceLine2.Description;
//                       ELEVAIMEINo := SalesInvoiceLine2."IMEI No.";
//                       ELEVASerialNo := SalesInvoiceLine2."Serial No.";
//                       ELEVAPrice := SalesInvoiceLine2."Unit Price Incl. of Tax";
//                       CustInvNo:= SalesInvoiceLine2."Document No.";
//                       CLEAR(SalesCrMemoLine1);
//                       SalesCrMemoLine1.RESET;
//                       SalesCrMemoLine1.SETRANGE("No.", SalesInvoiceLine2."No.");
//                       SalesCrMemoLine1.SETRANGE("IMEI No.", SalesInvoiceLine2."IMEI No.");
//                       SalesCrMemoLine1.SETRANGE("Item Serial No.", SalesInvoiceLine2."Serial No.");
//                       SalesCrMemoLine1.SETRANGE("Item Category Code", 'ELEVA');
//                       SalesCrMemoLine1.SETRANGE("Sell-to Customer No.", SalesInvoiceLine2."Sell-to Customer No.");
//                       IF SalesCrMemoLine1.FINDFIRST THEN BEGIN
//                         CLEAR(CGSTAmtCR);
//                         CLEAR(CGSTRateCR);
//                         CLEAR(GSTComponentCGSTCR);
//                         CLEAR(SGSTAmtCR);
//                         CLEAR(SGSTRateCR);
//                         CLEAR(GSTComponentSGSTCR);
//                         CLEAR(IGSTAmtCR);
//                         CLEAR(IGSTRateCR);
//                         CLEAR(GSTComponentIGSTCR);
//                         GSTDetailLeger.RESET;
//                         GSTDetailLeger.SETRANGE(GSTDetailLeger."Document No.", SalesCrMemoLine1."Document No.");
//                         GSTDetailLeger.SETRANGE(GSTDetailLeger."No.", SalesCrMemoLine1."No.");
//                         GSTDetailLeger.SETRANGE(GSTDetailLeger."Document Line No.", SalesCrMemoLine1."Line No.");
//                         IF GSTDetailLeger.FINDSET THEN REPEAT
//                           IF GSTDetailLeger."GST Component Code"='CGST' THEN BEGIN
//                             GSTComponentCGSTCR:='CGST';
//                             CGSTRateCR:=GSTDetailLeger."GST %";
//                             CGSTAmtCR:=GSTDetailLeger."GST Amount";
//                             TCGSTAmtCR+=GSTDetailLeger."GST Amount";
//                            END ELSE
//                           IF GSTDetailLeger."GST Component Code"='SGST' THEN BEGIN
//                             GSTComponentSGSTCR:='SGST';
//                             SGSTRateCR:=GSTDetailLeger."GST %";
//                             SGSTAmtCR:=GSTDetailLeger."GST Amount";
//                             TSGSTAmtCR+=GSTDetailLeger."GST Amount";
//                           END  ELSE
//                           IF GSTDetailLeger."GST Component Code"='IGST' THEN BEGIN
//                             GSTComponentIGSTCR:='IGST';
//                             IGSTRateCR:=GSTDetailLeger."GST %";
//                             IGSTAmtCR:=GSTDetailLeger."GST Amount";
//                             TIGSTAmtCR+=GSTDetailLeger."GST Amount";
//                           END;
//                         UNTIL GSTDetailLeger.NEXT=0;
//                       END;


//                     END;

//                     IF ELEVADes <> '' THEN
//                       CurrReport.SKIP;


//                     //HR-

//                 end;
//             }

//             trigger OnAfterGetRecord()
//             var
//                 SalesInvoiceLine: Record "113";
//             begin

//                 Srno+=1;

//                 IF salesp.GET("Sales Invoice Header"."Salesperson Code") THEN;


//                 IF payterms.GET("Sales Invoice Header"."Payment Terms Code") THEN;


//                 IF saleshdr.GET(saleshdr."Document Type"::Order,"Sales Invoice Header"."Order No.") THEN;


//                 IF purchhdr.GET(purchhdr."Document Type"::Order,saleshdr."PurchaseOrderNo.") THEN;


//                 terms:='';
//                 refno:='';
//                 salesinvHdr.RESET;
//                 salesinvHdr.SETFILTER(salesinvHdr."No.","Sales Invoice Header"."No.");
//                 IF salesinvHdr.FINDFIRST THEN
//                 IF salesinvHdr."Ref. Invoice No."<>'' THEN
//                 refno:=salesinvHdr."Ref. Invoice No.";
//                 //MESSAGE('%1',refno);
//                 /*
//                 salesinvline.RESET;
//                 salesinvline.SETFILTER(salesinvline."Document No.",refno);
//                 IF salesinvline.FINDFIRST THEN
//                 BEGIN
//                 ShieldRec.RESET;
//                 ShieldRec.SETRANGE(ShieldRec."Scheme Code",salesinvline."Shield Type");
//                 IF ShieldRec.FINDFIRST THEN
//                 terms:=ShieldRec."Shield Insurance T&C" + ' ' + ShieldRec."Document Date" + ' ' + ShieldRec."Product Group Code" + ' ' + ShieldRec."Starting Date";
//                 END;
//                 */

//                 CLEAR(GSTTIN_No);
//                 CLEAR(Cust_State);
//                 CLEAR(PlaceOfSupply);
//                 RecCustomer.RESET;
//                 RecCustomer.SETRANGE("No.","Sales Invoice Header"."Sell-to Customer No.");
//                 IF RecCustomer.FINDFIRST THEN
//                   GSTTIN_No:=RecCustomer."GST Registration No.";
//                   Cust_State:=RecCustomer."State Code";

//                 staterec.RESET;
//                 staterec.SETRANGE(staterec.Code,Cust_State);
//                 IF staterec.FINDFIRST THEN
//                   BEGIN
//                   PlaceOfSupply:=staterec.Description + ' (' + staterec."State Code (GST Reg. No.)" + ')' ;
//                   END;

//             end;

//             trigger OnPreDataItem()
//             begin
//                 Srno:=0;
//                 "Sales Invoice Header".SETRANGE("Sales Invoice Header"."Posting Date",startdt,enddt);
//                 //IF "Sales Invoice Header".FINDSET THEN;
//             end;
//         }
//     }

//     requestpage
//     {
//         SaveValues = true;

//         layout
//         {
//             area(content)
//             {
//                 group(Options)
//                 {
//                     field("Start Date";startdt)
//                     {
//                     }
//                     field("End Date";enddt)
//                     {
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

//     trigger OnInitReport()
//     begin
//         IMEI_SERIAL_SHOW:=FALSE;
//     end;

//     trigger OnPreReport()
//     begin
//         IF USERID IN ['ADMIN','ACCAM'] THEN
//         IMEI_SERIAL_SHOW:= TRUE
//         ELSE
//         IMEI_SERIAL_SHOW:= FALSE; //Win-234 20-03-2019
//         //MESSAGE(FORMAT(IMEI_SERIAL_SHOW));
//     end;

//     var
//         LastFieldNo: Integer;
//         Srno: Integer;
//         txt1: Label 'give location';
//         CurrReport_PAGENOCaptionLbl: Label 'Page';
//         PURCHASE_REGISTER_FOR_THE_PERIOD_CaptionLbl: Label 'PURCHASE REGISTER FOR THE PERIOD ';
//         Voucher_No_CaptionLbl: Label 'Voucher No.';
//         Vendor_CodeCaptionLbl: Label 'Vendor Code';
//         Vendor_NameCaptionLbl: Label 'Vendor Name';
//         Bill_No_CaptionLbl: Label 'Bill No.';
//         Bill_DateCaptionLbl: Label 'Bill Date';
//         GRN_No_CaptionLbl: Label 'GRN No.';
//         GRN_DateCaptionLbl: Label 'GRN Date';
//         State_T_I_N_No_CaptionLbl: Label 'State T.I.N No.';
//         CST_T_I_N_No_CaptionLbl: Label 'CST T.I.N No.';
//         Voucher_DateCaptionLbl: Label 'Voucher Date';
//         Item___G_L_DescriptionCaptionLbl: Label 'Item / G/L Description';
//         Total_Bill__Invoice_Amt_CaptionLbl: Label 'Total Bill/ Invoice Amt.';
//         Discount__Amt_CaptionLbl: Label 'Discount  Amt.';
//         Item_CodeCaptionLbl: Label 'Item Code';
//         Net_Amt_CaptionLbl: Label 'Net Amt.';
//         Cenvat_Amt_CaptionLbl: Label 'Cenvat Amt.';
//         G_L_CodeCaptionLbl: Label 'G/L Code';
//         G_L_DescriptionCaptionLbl: Label 'G/L Description';
//         Other_AmtCaptionLbl: Label 'Other Amt';
//         Tax_CaptionLbl: Label ' Tax%';
//         Tax_DescriptionCaptionLbl: Label 'Tax Description';
//         Tax__Amt_CaptionLbl: Label 'Tax  Amt.';
//         RecPurHead__Order_Date_CaptionLbl: Label 'Label1102159009';
//         Grand_TotalCaptionLbl: Label 'Grand Total';
//         Group_TotalCaptionLbl: Label 'Group Total';
//         startdt: Date;
//         enddt: Date;
//         salesprice: Decimal;
//         salesp: Record 13;
//         salespnm: Text[250];
//         staterec: Record 13762;
//         statnm: Text[250];
//         payterms: Record 3;
//         paytermsdesc: Text[250];
//         item: Record 27;
//         schem: Record 50001;
//         netsaleswotax: Decimal;
//         totsalesamt: Decimal;
//         saleshdr: Record 36;
//         purchhdr: Record 38;
//         servtaxperc: Decimal;
//         itemrec: Record 27;
//         salesinvline: Record 113;
//         ItemDesc: Text[250];
//         uom: Text[250];
//         salesinvHdr: Record 112;
//         ShieldRec: Record 50001;
//         refno: Code[30];
//         terms: Text[1024];
//         Brand: Code[30];
//         Catgry: Code[30];
//         CreditMemoEntry: Boolean;
//         GSTDetailLeger: Record  "Detailed Gst Ledger Entry";
//         CGSTRate: Decimal;
//         CGSTAmt: Decimal;
//         SGSTAmt: Decimal;
//         SGSTRate: Decimal;
//         IGSTRate: Decimal;
//         IGSTAmt: Decimal;
//         GSTComponentCGST: Text;
//         GSTComponentSGST: Text;
//         GSTComponentIGST: Text;
//         GSTTIN_No: Code[20];
//         Cust_State: Code[20];
//         PlaceOfSupply: Text;
//         RecCustomer: Record 18;
//         SalesCrMemoHeader: Record 114;
//         ItemLedgerEntry: Record 32;
//         SalesCrMemoLine: Record 115;
//         IMEI_SERIAL_SHOW: Boolean;
//         ELEVADes: Text;
//         ELEVASerialNo: Code[20];
//         ELEVAIMEINo: Code[20];
//         ELEVAPrice: Decimal;
//         SalesCrMemoLine1: Record 115;
//         CGSTRateCR: Decimal;
//         CGSTAmtCR: Decimal;
//         SGSTAmtCR: Decimal;
//         SGSTRateCR: Decimal;
//         IGSTRateCR: Decimal;
//         IGSTAmtCR: Decimal;
//         GSTComponentCGSTCR: Text;
//         GSTComponentSGSTCR: Text;
//         GSTComponentIGSTCR: Text;
//         CustInvNo: Code[20];
//         TCGSTAmtCR: Decimal;
//         TSGSTAmtCR: Decimal;
//         TIGSTAmtCR: Decimal;
// }

