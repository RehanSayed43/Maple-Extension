// report 50107 "Daily Cash Flow Tr"
// {
//     DefaultLayout = RDLC;
//     ApplicationArea = All;
//     UsageCategory = ReportsAndAnalysis;
//     RDLCLayout = './Daily Cash Flow Tr.rdl';

//     dataset
//     {
//         dataitem("Company Information"; "Company Information")
//         {
//             DataItemTableView = SORTING("Primary Key");
//             column(docno; docno)
//             {
//             }
//             column(InvCr; InvCr)
//             {
//             }
//             column(compinfoName; "Company Information".Name)
//             {
//                 IncludeCaption = true;
//             }
//             column(compinfoPicture; "Company Information".Picture)
//             {
//             }
//             column(No; No)
//             {
//             }
//             column(datefilter; datefilter)
//             {
//             }
//             column(startdt; startdt)
//             {
//             }
//             column(enddt; enddt)
//             {
//             }
//             column(Location; usersetup."Location Code" + loc."Name 2")
//             {
//             }
//         }
//         dataitem("Sales Invoice Header"; "Sales Invoice Header")
//         {
//             DataItemTableView = SORTING("No.");
//             PrintOnlyIfDetail = false;
//             RequestFilterFields = "Location Code";
//             column(PostingDate_SalesInvoiceHeader; "Sales Invoice Header"."Posting Date")
//             {
//             }
//             column(ExternalDocumentNo_SalesInvoiceHeader; "Sales Invoice Header"."External Document No.")
//             {
//             }
//             column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
//             {
//             }
//             column(comp_Name; comp.Name)
//             {
//             }
//             column(CurrReport_PAGENO; CurrReport.PAGENO)
//             {
//             }
//             column(Srno; Srno)
//             {
//             }
//             column(S_DocNo; "Sales Invoice Header"."No.")
//             {
//             }
//             column(selltocust; "Sales Invoice Header"."Sell-to Customer Name")
//             {
//             }
//             column(amt_to_cust; '')//"Sales Invoice Header"."Amount to Customer"
//             {
//             }
//             column(Cash; "Sales Invoice Header".PayByCashAmt)
//             {
//             }
//             column(Chq_Amt; "Sales Invoice Header".PayByChqAmt)
//             {
//             }
//             column(cardno_1; "Sales Invoice Header".PayByCreditNo1)
//             {
//             }
//             column(cardno_2; "Sales Invoice Header".PayByCreditNo2)
//             {
//             }
//             column(cardno_3; "Sales Invoice Header".PayByCreditNo3)
//             {
//             }
//             column(cardno_4s; "Sales Invoice Header".PayByCreditNo4)
//             {
//             }
//             column(cardno_5; "Sales Invoice Header".PayByDebitNo2)
//             {
//             }
//             column(Cr_Amt1; "Sales Invoice Header".PayByCreditAmt1)
//             {
//             }
//             column(Cr_Amt2; "Sales Invoice Header".PayByCreditAmt2)
//             {
//             }
//             column(Cr_Amt3; "Sales Invoice Header".PayByCreditAmt3)
//             {
//             }
//             column(Cr_Amt4; "Sales Invoice Header".PayByCreditAmt4)
//             {
//             }
//             column(Cr_Amt5; "Sales Invoice Header".PayByDebitAmt2)
//             {
//             }
//             column(RTGS_Amt; RtgsAmt)
//             {
//             }
//             column(RefNo; "Sales Invoice Header"."Ref. Invoice No.")
//             {
//             }
//             column(AppQty; AppQty)
//             {
//             }
//             column(NonAppQty; NonAppQty)
//             {
//             }
//             column(HDFCCardNo; HDFCCardNo)
//             {
//             }
//             column(HSBCCardNo; HSBCCardNo)
//             {
//             }
//             column(AMXCardNo; AMXCardNo)
//             {
//             }
//             column(CITICardNo; CITICardNo)
//             {
//             }
//             column(InnovitiCardNo; InnovitiCardNo)
//             {
//             }
//             column(PineLABSCardNo; PineLABSCardNo)
//             {
//             }
//             column(SaleCashAmt; SaleCashAmt)
//             {
//             }
//             column(SaleChqAmt; SaleChqAmt)
//             {
//             }
//             column(HDFCAMT; HDFCAMT)
//             {
//             }
//             column(HSBCAMT; HSBCAMT)
//             {
//             }
//             column(AMXAMT; AMXAMT)
//             {
//             }
//             column(CITIAMT; CITIAMT)
//             {
//             }
//             column(InnovitiAMT; InnovitiAMT)
//             {
//             }
//             column(PineLABSAMT; PineLABSAMT)
//             {
//             }
//             column(GiftVouchAmt; GiftAmt)
//             {
//             }
//             column(FinAmt; FinAmt)
//             {
//             }
//             column(FinAmt1; FinAmt1)
//             {
//             }
//             column(MapBBAmt; "Sales Invoice Header"."Maple Buyback Amt")
//             {
//             }
//             column(AppBBAmt; "Sales Invoice Header"."Apple Buyback Amt")
//             {
//             }
//             column(BBAmt; BBAmt)
//             {
//             }
//             column(BBAMtTot; BBAMtTot)
//             {
//             }
//             column(Comment; Cmnt)
//             {
//             }
//             column(RTGSRefNo_SalesInvoiceHeader; "Sales Invoice Header"."RTGS Ref. No.")
//             {
//             }
//             column(FinanceComapny_SalesInvoiceHeader; "Sales Invoice Header"."Finance Comapny")
//             {
//             }
//             column(FinanceCompanyName; FinanceCompanyName)
//             {
//             }
//             column(FinanceCompanyName1; FinanceCompanyName1)
//             {
//             }
//             column(RtgNo; RtgNo)
//             {
//             }
//             column(BANKAppCode; BANKAppCode)
//             {
//             }
//             column(BANKAppCode1; BANKAppCode1)
//             {
//             }
//             column(ChequeNo_CustLedgerEntry; "Sales Invoice Header".PayByChqNo)
//             {
//             }
//             column(chquamt; "Sales Invoice Header".PayByChqAmt)
//             {
//             }
//             dataitem("Salesperson/Purchaser"; "Salesperson/Purchaser")
//             {
//                 DataItemLink = Code = FIELD("Salesperson Code");
//                 column(SP_Code; "Salesperson/Purchaser".Code)
//                 {
//                 }
//                 column(SP_Name; "Salesperson/Purchaser".Name)
//                 {
//                 }
//             }

//             trigger OnAfterGetRecord()
//             begin

//                 AppQty := 0;
//                 NonAppQty := 0;
//                 TotShieldvalue := 0;
//                 InitVarSales;
//                 Srno += 1;

//                 salesinvline.RESET;
//                 salesinvline.SETFILTER(salesinvline."Document No.", "Sales Invoice Header"."No.");
//                 IF salesinvline.FINDFIRST THEN BEGIN
//                     REPEAT
//                         TotShieldvalue += salesinvline."Shield Value";
//                         IF salesinvline."Item Category Code" = 'APPLE' THEN
//                             AppQty += salesinvline.Quantity
//                         ELSE
//                             IF (salesinvline.Type = salesinvline.Type::"G/L Account") THEN BEGIN
//                                 IF (salesinvline."No." = SalesSetup."Shield Sales Account") THEN
//                                     NonAppQty += salesinvline.Quantity;
//                             END
//                             ELSE
//                                 NonAppQty += salesinvline.Quantity;
//                     UNTIL salesinvline.NEXT = 0;
//                 END;
//                 Tmpvalue := 0;
//                 PendShieldValue := TotShieldvalue;
//                 SaleCashAmt := "Sales Invoice Header".PayByCashAmt;
//                 IF ("Sales Invoice Header".PayByCashAmt <> 0) AND (PendShieldValue > 0) THEN BEGIN
//                     IF "Sales Invoice Header".PayByCashAmt > PendShieldValue THEN BEGIN
//                         IF "Sales Invoice Header"."Ref. Invoice No." <> '' THEN BEGIN
//                             Tmpvalue := PendShieldValue;
//                             PendShieldValue := 0;
//                             SaleCashAmt := Tmpvalue;
//                         END
//                         ELSE BEGIN
//                             Tmpvalue := PendShieldValue;
//                             PendShieldValue := 0;
//                             SaleCashAmt := "Sales Invoice Header".PayByCashAmt - Tmpvalue;
//                         END;
//                     END
//                     ELSE BEGIN
//                         IF "Sales Invoice Header"."Ref. Invoice No." <> '' THEN BEGIN
//                             Tmpvalue := PendShieldValue;
//                             SaleCashAmt := "Sales Invoice Header".PayByCashAmt;
//                             PendShieldValue := PendShieldValue - "Sales Invoice Header".PayByCashAmt;
//                         END
//                         ELSE BEGIN
//                             SaleCashAmt := 0;
//                             PendShieldValue := PendShieldValue - "Sales Invoice Header".PayByCashAmt;
//                         END;
//                     END;
//                 END;
//                 Tmpvalue := 0;
//                 SaleChqAmt := "Sales Invoice Header".PayByChqAmt;

//                 IF ("Sales Invoice Header"."Ref. Invoice No." <> '') AND (PendShieldValue = 0) THEN
//                     SaleChqAmt := 0
//                 ELSE BEGIN
//                     IF ("Sales Invoice Header".PayByChqAmt <> 0) AND (PendShieldValue > 0) THEN BEGIN
//                         IF "Sales Invoice Header".PayByChqAmt > PendShieldValue THEN BEGIN
//                             IF "Sales Invoice Header"."Ref. Invoice No." <> '' THEN BEGIN
//                                 Tmpvalue := PendShieldValue;
//                                 PendShieldValue := 0;
//                                 SaleChqAmt := PendShieldValue;
//                             END
//                             ELSE BEGIN
//                                 Tmpvalue := PendShieldValue;
//                                 PendShieldValue := 0;
//                                 SaleChqAmt := "Sales Invoice Header".PayByChqAmt - Tmpvalue;
//                             END;
//                         END
//                         ELSE BEGIN
//                             IF "Sales Invoice Header"."Ref. Invoice No." <> '' THEN BEGIN
//                                 Tmpvalue := PendShieldValue;
//                                 SaleChqAmt := "Sales Invoice Header".PayByChqAmt;
//                                 PendShieldValue := PendShieldValue - "Sales Invoice Header".PayByChqAmt;
//                             END
//                             ELSE BEGIN
//                                 Tmpvalue := PendShieldValue;
//                                 SaleChqAmt := 0;
//                                 PendShieldValue := PendShieldValue - "Sales Invoice Header".PayByChqAmt;
//                             END;
//                         END;
//                     END;
//                 END;
//                 IF "Sales Invoice Header".PayByCreditNo1 = 'HDFC' THEN BEGIN
//                     IF HDFCCardNo <> '' THEN
//                         HDFCCardNo += ',';

//                     HDFCCardNo += "Sales Invoice Header".CreditCardNo1;
//                     HDFCAMT += "Sales Invoice Header".PayByCreditAmt1;
//                 END;

//                 IF "Sales Invoice Header".PayByCreditNo2 = 'HDFC' THEN BEGIN
//                     IF HDFCCardNo <> '' THEN
//                         HDFCCardNo += ',';

//                     HDFCCardNo += "Sales Invoice Header".CreditCardNo2;
//                     HDFCAMT += "Sales Invoice Header".PayByCreditAmt2;
//                 END;

//                 IF "Sales Invoice Header".PayByCreditNo3 = 'HDFC' THEN BEGIN
//                     IF HDFCCardNo <> '' THEN
//                         HDFCCardNo += ',';

//                     HDFCCardNo += "Sales Invoice Header".CreditCardNo3;
//                     HDFCAMT += "Sales Invoice Header".PayByCreditAmt3;
//                 END;

//                 IF "Sales Invoice Header".PayByCreditNo4 = 'HDFC' THEN BEGIN
//                     IF HDFCCardNo <> '' THEN
//                         HDFCCardNo += ',';

//                     HDFCCardNo += "Sales Invoice Header".CreditCardNo4;
//                     HDFCAMT += "Sales Invoice Header".PayByCreditAmt4;
//                 END;

//                 IF "Sales Invoice Header".PayByDebitCdNo1 = 'HDFC' THEN BEGIN
//                     IF HDFCCardNo <> '' THEN
//                         HDFCCardNo += ',';

//                     HDFCCardNo += "Sales Invoice Header".DebitCardNo1;
//                     HDFCAMT += "Sales Invoice Header".PayByDebitCdAmt1;
//                 END;


//                 IF "Sales Invoice Header".PayByDebitNo2 = 'HDFC' THEN BEGIN
//                     IF HDFCCardNo <> '' THEN
//                         HDFCCardNo += ',';

//                     HDFCCardNo += "Sales Invoice Header".DebitCardNo2;
//                     HDFCAMT += "Sales Invoice Header".PayByDebitAmt2;
//                 END;
//                 Tmpvalue := 0;
//                 IF ("Sales Invoice Header"."Ref. Invoice No." <> '') AND (PendShieldValue = 0) THEN
//                     HDFCAMT := 0
//                 ELSE BEGIN
//                     IF (HDFCAMT <> 0) AND (PendShieldValue > 0) THEN BEGIN
//                         IF HDFCAMT > PendShieldValue THEN BEGIN
//                             IF "Sales Invoice Header"."Ref. Invoice No." <> '' THEN BEGIN
//                                 Tmpvalue := PendShieldValue;
//                                 HDFCAMT := PendShieldValue;
//                                 PendShieldValue := 0;
//                             END
//                             ELSE BEGIN
//                                 Tmpvalue := PendShieldValue;
//                                 PendShieldValue := 0;
//                                 HDFCAMT := HDFCAMT - Tmpvalue;
//                             END;
//                         END
//                         ELSE BEGIN
//                             IF "Sales Invoice Header"."Ref. Invoice No." <> '' THEN BEGIN
//                                 PendShieldValue := PendShieldValue - HDFCAMT;
//                             END
//                             ELSE BEGIN
//                                 Tmpvalue := PendShieldValue;
//                                 PendShieldValue := PendShieldValue - HDFCAMT;
//                                 HDFCAMT := 0;
//                             END;
//                         END;
//                     END;
//                 END;


//                 IF "Sales Invoice Header".PayByCreditNo1 = 'ICICI' THEN BEGIN
//                     IF HSBCCardNo <> '' THEN
//                         HSBCCardNo += ',';

//                     HSBCCardNo += "Sales Invoice Header".CreditCardNo1;
//                     HSBCAMT += "Sales Invoice Header".PayByCreditAmt1;
//                 END;

//                 IF "Sales Invoice Header".PayByCreditNo2 = 'ICICI' THEN BEGIN
//                     IF HSBCCardNo <> '' THEN
//                         HSBCCardNo += ',';

//                     HSBCCardNo += "Sales Invoice Header".CreditCardNo2;
//                     HSBCAMT += "Sales Invoice Header".PayByCreditAmt2;
//                 END;

//                 IF "Sales Invoice Header".PayByCreditNo3 = 'ICICI' THEN BEGIN
//                     IF HSBCCardNo <> '' THEN
//                         HSBCCardNo += ',';

//                     HSBCCardNo += "Sales Invoice Header".CreditCardNo3;
//                     HSBCAMT += "Sales Invoice Header".PayByCreditAmt3;
//                 END;

//                 IF "Sales Invoice Header".PayByCreditNo4 = 'ICICI' THEN BEGIN
//                     IF HSBCCardNo <> '' THEN
//                         HSBCCardNo += ',';

//                     HSBCCardNo += "Sales Invoice Header".CreditCardNo4;
//                     HSBCAMT += "Sales Invoice Header".PayByCreditAmt4;
//                 END;

//                 IF "Sales Invoice Header".PayByDebitCdNo1 = 'ICICI' THEN BEGIN
//                     IF HSBCCardNo <> '' THEN
//                         HSBCCardNo += ',';

//                     HSBCCardNo += "Sales Invoice Header".DebitCardNo1;
//                     HSBCAMT += "Sales Invoice Header".PayByDebitCdAmt1;
//                 END;

//                 IF "Sales Invoice Header".PayByDebitNo2 = 'ICICI' THEN BEGIN
//                     IF HSBCCardNo <> '' THEN
//                         HSBCCardNo += ',';

//                     HSBCCardNo += "Sales Invoice Header".DebitCardNo2;
//                     HSBCAMT += "Sales Invoice Header".PayByDebitAmt2;
//                 END;
//                 Tmpvalue := 0;
//                 IF ("Sales Invoice Header"."Ref. Invoice No." <> '') AND (PendShieldValue = 0) THEN
//                     HSBCAMT := 0
//                 ELSE BEGIN
//                     IF (HSBCAMT <> 0) AND (PendShieldValue > 0) THEN BEGIN
//                         IF HSBCAMT > PendShieldValue THEN BEGIN
//                             IF "Sales Invoice Header"."Ref. Invoice No." <> '' THEN BEGIN
//                                 HSBCAMT := PendShieldValue;
//                                 PendShieldValue := 0;
//                             END
//                             ELSE BEGIN
//                                 Tmpvalue := PendShieldValue;
//                                 PendShieldValue := 0;
//                                 HSBCAMT := HSBCAMT - Tmpvalue;
//                             END;
//                         END
//                         ELSE BEGIN
//                             IF "Sales Invoice Header"."Ref. Invoice No." <> '' THEN BEGIN
//                                 PendShieldValue := PendShieldValue - HSBCAMT;
//                             END
//                             ELSE BEGIN
//                                 PendShieldValue := PendShieldValue - HSBCAMT;
//                                 HSBCAMT := 0;
//                             END;
//                         END;
//                     END;
//                 END;

//                 IF "Sales Invoice Header".PayByCreditNo1 = 'AMEX' THEN BEGIN
//                     IF AMXCardNo <> '' THEN
//                         AMXCardNo += ',';

//                     AMXCardNo += "Sales Invoice Header".CreditCardNo1;
//                     AMXAMT += "Sales Invoice Header".PayByCreditAmt1;
//                 END;

//                 IF "Sales Invoice Header".PayByCreditNo2 = 'AMEX' THEN BEGIN
//                     IF AMXCardNo <> '' THEN
//                         AMXCardNo += ',';

//                     AMXCardNo += "Sales Invoice Header".CreditCardNo2;
//                     AMXAMT += "Sales Invoice Header".PayByCreditAmt2;
//                 END;

//                 IF "Sales Invoice Header".PayByCreditNo3 = 'AMEX' THEN BEGIN
//                     IF AMXCardNo <> '' THEN
//                         AMXCardNo += ',';

//                     AMXCardNo += "Sales Invoice Header".CreditCardNo3;
//                     AMXAMT += "Sales Invoice Header".PayByCreditAmt3;
//                 END;

//                 IF "Sales Invoice Header".PayByCreditNo4 = 'AMEX' THEN BEGIN
//                     IF AMXCardNo <> '' THEN
//                         AMXCardNo += ',';

//                     AMXCardNo += "Sales Invoice Header".CreditCardNo4;
//                     AMXAMT += "Sales Invoice Header".PayByCreditAmt4;
//                 END;

//                 IF "Sales Invoice Header".PayByDebitCdNo1 = 'AMEX' THEN BEGIN
//                     IF AMXCardNo <> '' THEN
//                         AMXCardNo += ',';

//                     AMXCardNo += "Sales Invoice Header".DebitCardNo1;
//                     AMXAMT += "Sales Invoice Header".PayByDebitCdAmt1;
//                 END;

//                 IF "Sales Invoice Header".PayByDebitNo2 = 'AMEX' THEN BEGIN
//                     IF AMXCardNo <> '' THEN
//                         AMXCardNo += ',';

//                     AMXCardNo += "Sales Invoice Header".DebitCardNo2;
//                     AMXAMT += "Sales Invoice Header".PayByDebitAmt2;
//                 END;
//                 Tmpvalue := 0;
//                 IF ("Sales Invoice Header"."Ref. Invoice No." <> '') AND (PendShieldValue = 0) THEN
//                     AMXAMT := 0
//                 ELSE BEGIN
//                     IF (AMXAMT <> 0) AND (PendShieldValue > 0) THEN BEGIN
//                         IF AMXAMT > PendShieldValue THEN BEGIN
//                             IF "Sales Invoice Header"."Ref. Invoice No." <> '' THEN BEGIN
//                                 AMXAMT := PendShieldValue;
//                                 PendShieldValue := 0;
//                             END
//                             ELSE BEGIN
//                                 Tmpvalue := PendShieldValue;
//                                 PendShieldValue := 0;
//                                 AMXAMT := AMXAMT - Tmpvalue;
//                             END;
//                         END
//                         ELSE BEGIN
//                             IF "Sales Invoice Header"."Ref. Invoice No." <> '' THEN BEGIN
//                                 PendShieldValue := PendShieldValue - AMXAMT;
//                             END
//                             ELSE BEGIN
//                                 PendShieldValue := PendShieldValue - AMXAMT;
//                                 AMXAMT := 0;
//                             END;
//                         END;
//                     END;
//                 END;

//                 IF "Sales Invoice Header".PayByCreditNo1 = 'CITI' THEN BEGIN
//                     IF CITICardNo <> '' THEN
//                         CITICardNo += ',';

//                     CITICardNo += "Sales Invoice Header".CreditCardNo1;
//                     CITIAMT += "Sales Invoice Header".PayByCreditAmt1;
//                 END;

//                 IF "Sales Invoice Header".PayByCreditNo2 = 'CITI' THEN BEGIN
//                     IF CITICardNo <> '' THEN
//                         CITICardNo += ',';

//                     CITICardNo += "Sales Invoice Header".CreditCardNo2;
//                     CITIAMT += "Sales Invoice Header".PayByCreditAmt2;
//                 END;

//                 IF "Sales Invoice Header".PayByCreditNo3 = 'CITI' THEN BEGIN
//                     IF CITICardNo <> '' THEN
//                         CITICardNo += ',';

//                     CITICardNo += "Sales Invoice Header".CreditCardNo3;
//                     CITIAMT += "Sales Invoice Header".PayByCreditAmt3;
//                 END;

//                 IF "Sales Invoice Header".PayByCreditNo4 = 'CITI' THEN BEGIN
//                     IF CITICardNo <> '' THEN
//                         CITICardNo += ',';

//                     CITICardNo += "Sales Invoice Header".CreditCardNo4;
//                     CITIAMT += "Sales Invoice Header".PayByCreditAmt4;
//                 END;

//                 IF "Sales Invoice Header".PayByDebitCdNo1 = 'CITI' THEN BEGIN
//                     IF CITICardNo <> '' THEN
//                         CITICardNo += ',';

//                     CITICardNo += "Sales Invoice Header".DebitCardNo1;
//                     CITIAMT += "Sales Invoice Header".PayByDebitCdAmt1;
//                 END;

//                 IF "Sales Invoice Header".PayByDebitNo2 = 'CITI' THEN BEGIN
//                     IF CITICardNo <> '' THEN
//                         CITICardNo += ',';

//                     CITICardNo += "Sales Invoice Header".DebitCardNo2;
//                     CITIAMT += "Sales Invoice Header".PayByDebitAmt2;
//                 END;
//                 Tmpvalue := 0;
//                 IF ("Sales Invoice Header"."Ref. Invoice No." <> '') AND (PendShieldValue = 0) THEN
//                     CITIAMT := 0
//                 ELSE BEGIN
//                     IF (CITIAMT <> 0) AND (PendShieldValue > 0) THEN BEGIN
//                         IF CITIAMT > PendShieldValue THEN BEGIN
//                             IF "Sales Invoice Header"."Ref. Invoice No." <> '' THEN BEGIN
//                                 CITIAMT := PendShieldValue;
//                                 PendShieldValue := 0;
//                             END
//                             ELSE BEGIN
//                                 Tmpvalue := PendShieldValue;
//                                 PendShieldValue := 0;
//                                 CITIAMT := CITIAMT - Tmpvalue;
//                             END;
//                         END
//                         ELSE BEGIN
//                             IF "Sales Invoice Header"."Ref. Invoice No." <> '' THEN BEGIN
//                                 PendShieldValue := PendShieldValue - CITIAMT;
//                             END
//                             ELSE BEGIN
//                                 PendShieldValue := PendShieldValue - CITIAMT;
//                                 CITIAMT := 0;
//                             END;
//                         END;
//                     END;
//                 END;

//                 IF "Sales Invoice Header".PayByCreditNo1 = 'Innoviti' THEN BEGIN
//                     IF InnovitiCardNo <> '' THEN
//                         InnovitiCardNo += ',';
//                     InnovitiCardNo += "Sales Invoice Header".CreditCardNo1;
//                     InnovitiAMT += "Sales Invoice Header".PayByCreditAmt1;
//                 END;

//                 IF "Sales Invoice Header".PayByCreditNo2 = 'Innoviti' THEN BEGIN
//                     IF InnovitiCardNo <> '' THEN
//                         InnovitiCardNo += ',';

//                     InnovitiCardNo += "Sales Invoice Header".CreditCardNo2;
//                     InnovitiAMT += "Sales Invoice Header".PayByCreditAmt2;
//                 END;

//                 IF "Sales Invoice Header".PayByCreditNo3 = 'Innoviti' THEN BEGIN
//                     InnovitiCardNo += "Sales Invoice Header".CreditCardNo3;
//                     InnovitiAMT += "Sales Invoice Header".PayByCreditAmt3;
//                 END;

//                 IF "Sales Invoice Header".PayByCreditNo4 = 'Innoviti' THEN BEGIN
//                     IF InnovitiCardNo <> '' THEN
//                         InnovitiCardNo += ',';

//                     InnovitiCardNo += "Sales Invoice Header".CreditCardNo4;
//                     InnovitiAMT += "Sales Invoice Header".PayByCreditAmt4;
//                 END;

//                 IF "Sales Invoice Header".PayByDebitCdNo1 = 'Innoviti' THEN BEGIN
//                     IF InnovitiCardNo <> '' THEN
//                         InnovitiCardNo += ',';

//                     InnovitiCardNo += "Sales Invoice Header".DebitCardNo1;
//                     InnovitiAMT += "Sales Invoice Header".PayByDebitCdAmt1;
//                 END;

//                 IF "Sales Invoice Header".PayByDebitNo2 = 'Innoviti' THEN BEGIN
//                     IF InnovitiCardNo <> '' THEN
//                         InnovitiCardNo += ',';

//                     InnovitiCardNo += "Sales Invoice Header".DebitCardNo2;
//                     InnovitiAMT += "Sales Invoice Header".PayByDebitAmt2;
//                 END;
//                 Tmpvalue := 0;
//                 IF ("Sales Invoice Header"."Ref. Invoice No." <> '') AND (PendShieldValue = 0) THEN
//                     InnovitiAMT := 0
//                 ELSE BEGIN
//                     IF (InnovitiAMT <> 0) AND (PendShieldValue > 0) THEN BEGIN
//                         IF InnovitiAMT > PendShieldValue THEN BEGIN
//                             IF "Sales Invoice Header"."Ref. Invoice No." <> '' THEN BEGIN
//                                 InnovitiAMT := PendShieldValue;
//                                 PendShieldValue := 0;
//                             END
//                             ELSE BEGIN
//                                 Tmpvalue := PendShieldValue;
//                                 PendShieldValue := 0;
//                                 InnovitiAMT := InnovitiAMT - Tmpvalue;
//                             END;
//                         END
//                         ELSE BEGIN
//                             IF "Sales Invoice Header"."Ref. Invoice No." <> '' THEN BEGIN
//                                 PendShieldValue := PendShieldValue - InnovitiAMT;
//                             END
//                             ELSE BEGIN
//                                 PendShieldValue := PendShieldValue - InnovitiAMT;
//                                 InnovitiAMT := 0;
//                             END;
//                         END;
//                     END;
//                 END;

//                 IF "Sales Invoice Header".PayByCreditNo1 = 'Pine Labs' THEN BEGIN
//                     IF PineLABSCardNo <> '' THEN
//                         PineLABSCardNo += ',';

//                     PineLABSCardNo += "Sales Invoice Header".CreditCardNo1;
//                     PineLABSAMT += "Sales Invoice Header".PayByCreditAmt1;
//                 END;

//                 IF "Sales Invoice Header".PayByCreditNo2 = 'Pine Labs' THEN BEGIN
//                     IF PineLABSCardNo <> '' THEN
//                         PineLABSCardNo += ',';

//                     PineLABSCardNo += "Sales Invoice Header".CreditCardNo2;
//                     PineLABSAMT += "Sales Invoice Header".PayByCreditAmt2;
//                 END;

//                 IF "Sales Invoice Header".PayByCreditNo3 = 'Pine Labs' THEN BEGIN
//                     IF PineLABSCardNo <> '' THEN
//                         PineLABSCardNo += ',';
//                     PineLABSCardNo += "Sales Invoice Header".CreditCardNo3;
//                     PineLABSAMT += "Sales Invoice Header".PayByCreditAmt3;
//                 END;

//                 IF "Sales Invoice Header".PayByCreditNo4 = 'Pine Labs ' THEN BEGIN
//                     IF PineLABSCardNo <> '' THEN
//                         PineLABSCardNo += ',';

//                     PineLABSCardNo += "Sales Invoice Header".CreditCardNo4;
//                     PineLABSAMT += "Sales Invoice Header".PayByCreditAmt4;
//                 END;

//                 IF "Sales Invoice Header".PayByDebitCdNo1 = 'Pine Labs' THEN BEGIN
//                     IF PineLABSCardNo <> '' THEN
//                         PineLABSCardNo += ',';

//                     PineLABSCardNo += "Sales Invoice Header".DebitCardNo1;
//                     PineLABSAMT += "Sales Invoice Header".PayByDebitCdAmt1;
//                 END;

//                 IF "Sales Invoice Header".PayByDebitNo2 = 'Pine Labs' THEN BEGIN
//                     IF PineLABSCardNo <> '' THEN
//                         PineLABSCardNo += ',';

//                     PineLABSCardNo := "Sales Invoice Header".DebitCardNo2;
//                     PineLABSAMT += "Sales Invoice Header".PayByDebitAmt2;
//                 END;
//                 Tmpvalue := 0;
//                 IF ("Sales Invoice Header"."Ref. Invoice No." <> '') AND (PendShieldValue = 0) THEN
//                     PineLABSAMT := 0
//                 ELSE BEGIN
//                     IF (PineLABSAMT <> 0) AND (PendShieldValue > 0) THEN BEGIN
//                         IF PineLABSAMT > PendShieldValue THEN BEGIN
//                             IF "Sales Invoice Header"."Ref. Invoice No." <> '' THEN BEGIN
//                                 PineLABSAMT := PendShieldValue;
//                                 PendShieldValue := 0;
//                             END
//                             ELSE BEGIN
//                                 Tmpvalue := PendShieldValue;
//                                 PendShieldValue := 0;
//                                 PineLABSAMT := PineLABSAMT - Tmpvalue;
//                             END;
//                         END
//                         ELSE BEGIN
//                             IF "Sales Invoice Header"."Ref. Invoice No." <> '' THEN BEGIN
//                                 PendShieldValue := PendShieldValue - PineLABSAMT;
//                             END
//                             ELSE BEGIN
//                                 PendShieldValue := PendShieldValue - PineLABSAMT;
//                                 PineLABSAMT := 0;
//                             END;
//                         END;
//                     END;
//                 END;

//                 GiftAmt := "Sales Invoice Header".GiftVoucherAmt;
//                 IF ("Sales Invoice Header"."Ref. Invoice No." <> '') AND (PendShieldValue = 0) THEN
//                     GiftAmt := 0
//                 ELSE BEGIN
//                     IF (GiftAmt <> 0) AND (PendShieldValue > 0) THEN BEGIN
//                         IF GiftAmt > PendShieldValue THEN BEGIN
//                             IF "Sales Invoice Header"."Ref. Invoice No." <> '' THEN BEGIN
//                                 GiftAmt := PendShieldValue;
//                                 PendShieldValue := 0;
//                             END
//                             ELSE BEGIN
//                                 Tmpvalue := PendShieldValue;
//                                 PendShieldValue := 0;
//                                 GiftAmt := GiftAmt - Tmpvalue;
//                             END;
//                         END
//                         ELSE BEGIN
//                             IF "Sales Invoice Header"."Ref. Invoice No." <> '' THEN BEGIN
//                                 PendShieldValue := PendShieldValue - GiftAmt;
//                             END
//                             ELSE BEGIN
//                                 PendShieldValue := PendShieldValue - GiftAmt;
//                                 GiftAmt := 0;
//                             END;
//                         END;
//                     END;
//                 END;


//                 //FinAmt := "Sales Invoice Header"."Finance Amount";
//                 IF ("Sales Invoice Header"."Ref. Invoice No." <> '') AND (PendShieldValue = 0) THEN
//                     FinAmt := 0
//                 ELSE BEGIN
//                     IF (FinAmt <> 0) AND (PendShieldValue > 0) THEN BEGIN
//                         IF FinAmt > PendShieldValue THEN BEGIN
//                             IF "Sales Invoice Header"."Ref. Invoice No." <> '' THEN BEGIN
//                                 FinAmt := PendShieldValue;
//                                 PendShieldValue := 0;
//                             END
//                             ELSE BEGIN
//                                 Tmpvalue := PendShieldValue;
//                                 PendShieldValue := 0;
//                                 FinAmt := FinAmt - Tmpvalue;
//                             END;
//                         END
//                         ELSE BEGIN
//                             IF "Sales Invoice Header"."Ref. Invoice No." <> '' THEN BEGIN
//                                 PendShieldValue := PendShieldValue - FinAmt;
//                             END
//                             ELSE BEGIN
//                                 PendShieldValue := PendShieldValue - FinAmt;
//                                 FinAmt := 0;
//                             END;
//                         END;
//                     END;
//                 END;



//                 RtgsAmt := "Sales Invoice Header"."RTGS Amount";
//                 IF ("Sales Invoice Header"."Ref. Invoice No." <> '') AND (PendShieldValue = 0) THEN
//                     RtgsAmt := 0
//                 ELSE BEGIN
//                     IF (RtgsAmt <> 0) AND (PendShieldValue > 0) THEN BEGIN
//                         IF RtgsAmt > PendShieldValue THEN BEGIN
//                             IF "Sales Invoice Header"."Ref. Invoice No." <> '' THEN BEGIN
//                                 RtgsAmt := PendShieldValue;
//                                 PendShieldValue := 0;
//                             END
//                             ELSE BEGIN
//                                 Tmpvalue := PendShieldValue;
//                                 PendShieldValue := 0;
//                                 RtgsAmt := RtgsAmt - Tmpvalue;
//                             END;
//                         END
//                         ELSE BEGIN
//                             IF "Sales Invoice Header"."Ref. Invoice No." <> '' THEN BEGIN
//                                 PendShieldValue := PendShieldValue - RtgsAmt;
//                             END
//                             ELSE BEGIN
//                                 PendShieldValue := PendShieldValue - RtgsAmt;
//                                 RtgsAmt := 0;
//                             END;
//                         END;
//                     END;
//                 END;



//                 BBAmt := 0;
//                 //IF "Sales Invoice Header"."Apple Buyback Amt">0 THEN
//                 //BBAmt:="Sales Invoice Header"."Apple Buyback Amt";
//                 IF "Sales Invoice Header"."Ref. Invoice No." = '' THEN BEGIN
//                     IF "Sales Invoice Header"."Maple Buyback Amt" > 0 THEN
//                         BBAmt := "Sales Invoice Header"."Maple Buyback Amt";

//                     BBAMtTot += BBAmt;
//                 END;

//                 Cmnt := '';
//                 RecComment.SETFILTER(RecComment."No.", "Sales Invoice Header"."No.");
//                 IF RecComment.FINDFIRST THEN
//                     Cmnt := RecComment.Comment;
//                 //WIN316++
//                 CLEAR(POS);
//                 CLEAR(FinanceCompanyName);
//                 CLEAR(FinAmt);
//                 CLEAR(BANKAppCode);
//                 CLEAR(POS1);
//                 CLEAR(FinanceCompanyName1);
//                 CLEAR(FinAmt1);
//                 CLEAR(BANKAppCode1);
//                 IF "Sales Invoice Header"."Ref. Invoice No." = '' THEN BEGIN
//                     IF "Sales Invoice Header"."RTGS Ref. No." <> '' THEN
//                         RtgNo := "Sales Invoice Header"."RTGS Ref. No.";

//                     IF "Sales Invoice Header"."Finance Comapny" <> '' THEN BEGIN
//                         POS := STRPOS("Sales Invoice Header"."Finance Comapny", 'BAJAJ');
//                         IF POS > 0 THEN BEGIN
//                             FinanceCompanyName := "Sales Invoice Header"."Finance Comapny";
//                             FinAmt := "Sales Invoice Header"."Finance Amount";
//                             IF "Sales Invoice Header"."Bank Approval Code" <> '' THEN
//                                 BANKAppCode := "Sales Invoice Header"."Bank Approval Code";
//                         END
//                         ELSE BEGIN
//                             FinanceCompanyName1 := "Sales Invoice Header"."Finance Comapny";
//                             FinAmt1 := "Sales Invoice Header"."Finance Amount";
//                             IF "Sales Invoice Header"."Bank Approval Code" <> '' THEN
//                                 BANKAppCode1 := "Sales Invoice Header"."Bank Approval Code";
//                         END;
//                     END;
//                     POS1 := 0;
//                     IF "Sales Invoice Header"."Finance Comapny new" <> "Sales Invoice Header"."Finance Comapny new"::" " THEN BEGIN
//                         POS1 := STRPOS(FORMAT("Sales Invoice Header"."Finance Comapny new"), 'BAJAJ FINANCE');
//                         IF POS1 > 0 THEN BEGIN
//                             FinanceCompanyName := FORMAT("Sales Invoice Header"."Finance Comapny new");
//                             FinAmt := "Sales Invoice Header"."Finance Amount";
//                             IF "Sales Invoice Header"."Bank Approval Code" <> '' THEN
//                                 BANKAppCode := "Sales Invoice Header"."Bank Approval Code";
//                         END
//                         ELSE BEGIN
//                             FinanceCompanyName1 := FORMAT("Sales Invoice Header"."Finance Comapny new");
//                             FinAmt1 := "Sales Invoice Header"."Finance Amount";
//                             IF "Sales Invoice Header"."Bank Approval Code" <> '' THEN
//                                 BANKAppCode1 := "Sales Invoice Header"."Bank Approval Code";
//                         END;
//                     END;
//                 END;
//                 //Win316--
//             end;

//             trigger OnPreDataItem()
//             begin


//                 Srno := 0;
//                 IF usersetup."Location Code" <> '' THEN
//                     "Sales Invoice Header".SETFILTER("Sales Invoice Header"."Location Code", '%1', usersetup."Location Code");
//                 BBAMtTot := 0;
//                 IF "Sales Invoice Header".FINDFIRST THEN
//                     Branchcode1 := "Sales Invoice Header"."Shortcut Dimension 1 Code";
//                 "Sales Invoice Header".SETRANGE("Sales Invoice Header"."Posting Date", startdt, enddt);
//                 IF "Sales Invoice Header".FINDSET THEN;
//             end;
//         }
//         dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
//         {
//             DataItemTableView = SORTING("No.");
//             PrintOnlyIfDetail = false;
//             RequestFilterFields = "Location Code";
//             column(PostingDate_SalesCrMemoHeader; "Sales Cr.Memo Header"."Posting Date")
//             {
//             }
//             column(ExternalDocumentNo_SalesCrMemoHeader; "Sales Cr.Memo Header"."External Document No.")
//             {
//             }
//             column(SCR_DocNo; "Sales Cr.Memo Header"."No.")
//             {
//             }
//             column(Srno1; Srno1)
//             {
//             }
//             column(custnm; "Sales Cr.Memo Header"."Sell-to Customer Name")
//             {
//             }
//             column(amt_2_cust; '')//"Sales Cr.Memo Header"."Amount to Customer"
//             {
//             }
//             column(Cash1; "Sales Cr.Memo Header".PayByCashAmt)
//             {
//             }
//             column(chqamt; "Sales Cr.Memo Header".PayByChqAmt)
//             {
//             }
//             column(RTGSAmt; "Sales Cr.Memo Header"."RTGS Amount")
//             {
//             }
//             column(cr_no1; "Sales Cr.Memo Header".PayByCreditNo1)
//             {
//             }
//             column(cr_no2; "Sales Cr.Memo Header".PayByCreditNo2)
//             {
//             }
//             column(cr_no3; "Sales Cr.Memo Header".PayByCreditNo3)
//             {
//             }
//             column(cr_no4; "Sales Cr.Memo Header".PayByCreditNo4)
//             {
//             }
//             column(crmt1; "Sales Cr.Memo Header".PayByCreditAmt1)
//             {
//             }
//             column(crmt2; "Sales Cr.Memo Header".PayByCreditAmt2)
//             {
//             }
//             column(crmt3; "Sales Cr.Memo Header".PayByCreditAmt3)
//             {
//             }
//             column(crmt4; "Sales Cr.Memo Header".PayByCreditAmt4)
//             {
//             }
//             column(GiftVouchCrAmt; "Sales Cr.Memo Header".GiftVoucherAmt)
//             {
//             }
//             column(FinanceCrAmt; "Sales Cr.Memo Header"."Finance Amount")
//             {
//             }
//             column(AppQty1; AppQty1)
//             {
//             }
//             column(NonAppQty1; NonAppQty1)
//             {
//             }
//             column(HDFCCardNo1; HDFCCardNo1)
//             {
//             }
//             column(HSBCCardNo1; HSBCCardNo1)
//             {
//             }
//             column(AMXCardNo1; AMXCardNo1)
//             {
//             }
//             column(CITICardNo1; CITICardNo1)
//             {
//             }
//             column(InnovitiCardNo1; InnovitiCardNo1)
//             {
//             }
//             column(PineLABSCardNo1; PineLABSCardNo1)
//             {
//             }
//             column(HDFCAMT1; HDFCAMT1)
//             {
//             }
//             column(HSBCAMT1; HSBCAMT1)
//             {
//             }
//             column(AMXAMT1; AMXAMT1)
//             {
//             }
//             column(CITIAMT1; CITIAMT1)
//             {
//             }
//             column(InnovitiAMT1; InnovitiAMT1)
//             {
//             }
//             column(PineLABSAMT1; PineLABSAMT1)
//             {
//             }
//             column(AppBBCrAmt; "Sales Cr.Memo Header"."Apple Buyback Amt")
//             {
//             }
//             column(MapBBCrAmt; "Sales Cr.Memo Header"."Maple Buyback Amt")
//             {
//             }
//             column(BBCrAmt; BBCrAmt)
//             {
//             }
//             column(BBCrAMtTot; BBCrAMtTot)
//             {
//             }
//             column(CommentCr; CmntCr)
//             {
//             }
//             column(Cr_SalesName; SalesName)
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 Srno1 += 1;
//                 AppQty1 := 0;
//                 NonAppQty1 := 0;
//                 InitVarCrMemo;
//                 salesCrMemoLn.RESET;
//                 salesCrMemoLn.SETFILTER(salesCrMemoLn."Document No.", "Sales Cr.Memo Header"."No.");
//                 IF salesCrMemoLn.FINDFIRST THEN BEGIN
//                     REPEAT
//                         IF salesCrMemoLn."Item Category Code" = 'APPLE' THEN
//                             AppQty1 += salesCrMemoLn.Quantity
//                         ELSE
//                             NonAppQty1 += salesCrMemoLn.Quantity;
//                     UNTIL salesCrMemoLn.NEXT = 0;
//                 END;


//                 IF "Sales Cr.Memo Header".PayByCreditNo1 = 'HDFC' THEN BEGIN
//                     HDFCCardNo1 := "Sales Cr.Memo Header".CreditCardNo1;
//                     HDFCAMT1 := "Sales Cr.Memo Header".PayByCreditAmt1;
//                 END;

//                 IF "Sales Cr.Memo Header".PayByCreditNo2 = 'HDFC' THEN BEGIN
//                     HDFCCardNo1 := "Sales Cr.Memo Header".CreditCardNo2;
//                     HDFCAMT1 := "Sales Cr.Memo Header".PayByCreditAmt2;
//                 END;

//                 IF "Sales Cr.Memo Header".PayByCreditNo3 = 'HDFC' THEN BEGIN
//                     HDFCCardNo1 := "Sales Cr.Memo Header".CreditCardNo3;
//                     HDFCAMT1 := "Sales Cr.Memo Header".PayByCreditAmt3;
//                 END;

//                 IF "Sales Cr.Memo Header".PayByCreditNo4 = 'HDFC' THEN BEGIN
//                     HDFCCardNo1 := "Sales Cr.Memo Header".CreditCardNo4;
//                     HDFCAMT1 := "Sales Cr.Memo Header".PayByCreditAmt4;
//                 END;

//                 IF "Sales Cr.Memo Header".PayByCreditNo5 = 'HDFC' THEN BEGIN
//                     HDFCCardNo1 := "Sales Cr.Memo Header".CreditCardNo5;
//                     HDFCAMT1 := "Sales Cr.Memo Header".PayByCreditAmt5;
//                 END;

//                 /*
//                 if "Sales Cr.Memo Header".PayByCreditNo1='HSBC' then
//                 begin
//                 HSBCCardNo1:="Sales Cr.Memo Header".CreditCardNo1;
//                 HSBCAMT1:="Sales Cr.Memo Header".PayByCreditAmt1;
//                 end;

//                 if "Sales Cr.Memo Header".PayByCreditNo2='HSBC' then
//                 begin
//                 HSBCCardNo1:="Sales Cr.Memo Header".CreditCardNo2;
//                 HSBCAMT1:="Sales Cr.Memo Header".PayByCreditAmt2;
//                 end;

//                 if "Sales Cr.Memo Header".PayByCreditNo3='HSBC' then
//                 begin
//                 HSBCCardNo1:="Sales Cr.Memo Header".CreditCardNo3;
//                 HSBCAMT1:="Sales Cr.Memo Header".PayByCreditAmt3;
//                 end;

//                 if "Sales Cr.Memo Header".PayByCreditNo4='HSBC' then
//                 begin
//                 HSBCCardNo1:="Sales Cr.Memo Header".CreditCardNo4;
//                 HSBCAMT1:="Sales Cr.Memo Header".PayByCreditAmt4;
//                 end;

//                 if "Sales Cr.Memo Header".PayByCreditNo5='HSBC' then
//                 begin
//                 HSBCCardNo1:="Sales Cr.Memo Header".CreditCardNo5;
//                 HSBCAMT1:="Sales Cr.Memo Header".PayByCreditAmt5;
//                 end;
//                 */

//                 IF "Sales Cr.Memo Header".PayByCreditNo1 = 'ICICI' THEN BEGIN
//                     HSBCCardNo1 := "Sales Cr.Memo Header".CreditCardNo1;
//                     HSBCAMT1 := "Sales Cr.Memo Header".PayByCreditAmt1;
//                 END;

//                 IF "Sales Cr.Memo Header".PayByCreditNo2 = 'ICICI' THEN BEGIN
//                     HSBCCardNo1 := "Sales Cr.Memo Header".CreditCardNo2;
//                     HSBCAMT1 := "Sales Cr.Memo Header".PayByCreditAmt2;
//                 END;

//                 IF "Sales Cr.Memo Header".PayByCreditNo3 = 'ICICI' THEN BEGIN
//                     HSBCCardNo1 := "Sales Cr.Memo Header".CreditCardNo3;
//                     HSBCAMT1 := "Sales Cr.Memo Header".PayByCreditAmt3;
//                 END;

//                 IF "Sales Cr.Memo Header".PayByCreditNo4 = 'ICICI' THEN BEGIN
//                     HSBCCardNo1 := "Sales Cr.Memo Header".CreditCardNo4;
//                     HSBCAMT1 := "Sales Cr.Memo Header".PayByCreditAmt4;
//                 END;

//                 IF "Sales Cr.Memo Header".PayByCreditNo5 = 'ICICI' THEN BEGIN
//                     HSBCCardNo1 := "Sales Cr.Memo Header".CreditCardNo5;
//                     HSBCAMT1 := "Sales Cr.Memo Header".PayByCreditAmt5;
//                 END;


//                 IF "Sales Cr.Memo Header".PayByCreditNo1 = 'AMEX' THEN BEGIN
//                     AMXCardNo1 := "Sales Cr.Memo Header".CreditCardNo1;
//                     AMXAMT1 := "Sales Cr.Memo Header".PayByCreditAmt1;
//                 END;

//                 IF "Sales Cr.Memo Header".PayByCreditNo2 = 'AMEX' THEN BEGIN
//                     AMXCardNo1 := "Sales Cr.Memo Header".CreditCardNo2;
//                     AMXAMT1 := "Sales Cr.Memo Header".PayByCreditAmt2;
//                 END;

//                 IF "Sales Cr.Memo Header".PayByCreditNo3 = 'AMEX' THEN BEGIN
//                     AMXCardNo1 := "Sales Cr.Memo Header".CreditCardNo3;
//                     AMXAMT1 := "Sales Cr.Memo Header".PayByCreditAmt3;
//                 END;

//                 IF "Sales Cr.Memo Header".PayByCreditNo4 = 'AMEX' THEN BEGIN
//                     AMXCardNo1 := "Sales Cr.Memo Header".CreditCardNo4;
//                     AMXAMT1 := "Sales Cr.Memo Header".PayByCreditAmt4;
//                 END;

//                 IF "Sales Cr.Memo Header".PayByCreditNo5 = 'AMEX' THEN BEGIN
//                     AMXCardNo1 := "Sales Cr.Memo Header".CreditCardNo5;
//                     AMXAMT1 := "Sales Cr.Memo Header".PayByCreditAmt5;
//                 END;

//                 IF "Sales Cr.Memo Header".PayByCreditNo1 = 'CITI' THEN BEGIN
//                     CITICardNo1 := "Sales Cr.Memo Header".CreditCardNo1;
//                     CITIAMT1 := "Sales Cr.Memo Header".PayByCreditAmt1;
//                 END;

//                 IF "Sales Cr.Memo Header".PayByCreditNo2 = 'CITI' THEN BEGIN
//                     CITICardNo1 := "Sales Cr.Memo Header".CreditCardNo2;
//                     CITIAMT1 := "Sales Cr.Memo Header".PayByCreditAmt2;
//                 END;

//                 IF "Sales Cr.Memo Header".PayByCreditNo3 = 'CITI' THEN BEGIN
//                     CITICardNo1 := "Sales Cr.Memo Header".CreditCardNo3;
//                     CITIAMT1 := "Sales Cr.Memo Header".PayByCreditAmt3;
//                 END;

//                 IF "Sales Cr.Memo Header".PayByCreditNo4 = 'CITI' THEN BEGIN
//                     CITICardNo1 := "Sales Cr.Memo Header".CreditCardNo4;
//                     CITIAMT1 := "Sales Cr.Memo Header".PayByCreditAmt4;
//                 END;

//                 IF "Sales Cr.Memo Header".PayByCreditNo5 = 'CITI' THEN BEGIN
//                     CITICardNo1 := "Sales Cr.Memo Header".CreditCardNo5;
//                     CITIAMT1 := "Sales Cr.Memo Header".PayByCreditAmt5;
//                 END;

//                 IF "Sales Cr.Memo Header".PayByCreditNo1 = 'Innoviti' THEN BEGIN
//                     InnovitiCardNo1 := "Sales Cr.Memo Header".CreditCardNo1;
//                     InnovitiAMT1 := "Sales Cr.Memo Header".PayByCreditAmt1;
//                 END;

//                 IF "Sales Cr.Memo Header".PayByCreditNo2 = 'Innoviti' THEN BEGIN
//                     InnovitiCardNo1 := "Sales Cr.Memo Header".CreditCardNo2;
//                     InnovitiAMT1 := "Sales Cr.Memo Header".PayByCreditAmt2;
//                 END;

//                 IF "Sales Cr.Memo Header".PayByCreditNo3 = 'Innoviti' THEN BEGIN
//                     InnovitiCardNo1 := "Sales Cr.Memo Header".CreditCardNo3;
//                     InnovitiAMT1 := "Sales Cr.Memo Header".PayByCreditAmt3;
//                 END;

//                 IF "Sales Cr.Memo Header".PayByCreditNo4 = 'Innoviti' THEN BEGIN
//                     InnovitiCardNo1 := "Sales Cr.Memo Header".CreditCardNo4;
//                     InnovitiAMT1 := "Sales Cr.Memo Header".PayByCreditAmt4;
//                 END;

//                 IF "Sales Cr.Memo Header".PayByCreditNo5 = 'Innoviti' THEN BEGIN
//                     InnovitiCardNo1 := "Sales Cr.Memo Header".CreditCardNo5;
//                     InnovitiAMT1 := "Sales Cr.Memo Header".PayByCreditAmt5;
//                 END;

//                 IF "Sales Cr.Memo Header".PayByCreditNo1 = 'Pine Labs' THEN BEGIN
//                     PineLABSCardNo1 := "Sales Cr.Memo Header".CreditCardNo1;
//                     PineLABSAMT1 := "Sales Cr.Memo Header".PayByCreditAmt1;
//                 END;

//                 IF "Sales Cr.Memo Header".PayByCreditNo2 = 'Pine Labs' THEN BEGIN
//                     PineLABSCardNo1 := "Sales Cr.Memo Header".CreditCardNo2;
//                     PineLABSAMT1 := "Sales Cr.Memo Header".PayByCreditAmt2;
//                 END;

//                 IF "Sales Cr.Memo Header".PayByCreditNo3 = 'Pine Labs' THEN BEGIN
//                     PineLABSCardNo1 := "Sales Cr.Memo Header".CreditCardNo3;
//                     PineLABSAMT1 := "Sales Cr.Memo Header".PayByCreditAmt3;
//                 END;

//                 IF "Sales Cr.Memo Header".PayByCreditNo4 = 'Pine Labs ' THEN BEGIN
//                     PineLABSCardNo1 := "Sales Cr.Memo Header".CreditCardNo4;
//                     PineLABSAMT1 := "Sales Cr.Memo Header".PayByCreditAmt4;
//                 END;

//                 IF "Sales Cr.Memo Header".PayByCreditNo5 = 'Pine Labs' THEN BEGIN
//                     PineLABSCardNo1 := "Sales Cr.Memo Header".CreditCardNo5;
//                     PineLABSAMT1 := "Sales Cr.Memo Header".PayByCreditAmt5;
//                 END;



//                 BBCrAmt := 0;
//                 IF "Sales Cr.Memo Header"."Maple Buyback Amt" > 0 THEN
//                     BBCrAmt := "Sales Cr.Memo Header"."Maple Buyback Amt";
//                 //IF "Sales Cr.Memo Header"."Apple Buyback Amt">0 THEN
//                 //BBCrAmt:="Sales Cr.Memo Header"."Apple Buyback Amt";

//                 BBCrAMtTot += BBCrAmt;

//                 CmntCr := '';
//                 RecCommentCr.SETFILTER(RecCommentCr."No.", "Sales Cr.Memo Header"."No.");
//                 IF RecCommentCr.FINDFIRST THEN
//                     CmntCr := RecCommentCr.Comment;

//                 RecSalesPerson.RESET;
//                 RecSalesPerson.SETRANGE(RecSalesPerson.Code, "Sales Cr.Memo Header"."Salesperson Code");
//                 IF RecSalesPerson.FINDFIRST THEN
//                     SalesName := RecSalesPerson.Name;

//             end;

//             trigger OnPreDataItem()
//             begin
//                 Srno1 := 0;
//                 BBCrAMtTot := 0;

//                 //IF usersetup.GET("Sales Cr.Memo Header"."User ID") THEN
//                 //IF "Sales Cr.Memo Header".GETFILTER("Sales Cr.Memo Header"."Location Code")='' THEN
//                 IF usersetup."Location Code" <> '' THEN
//                     "Sales Cr.Memo Header".SETFILTER("Sales Cr.Memo Header"."Location Code", usersetup."Location Code");


//                 "Sales Cr.Memo Header".SETRANGE("Sales Cr.Memo Header"."Posting Date", startdt, enddt);
//                 IF "Sales Cr.Memo Header".FINDFIRST THEN;
//             end;
//         }
//         dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
//         {
//             DataItemTableView = SORTING("Customer No.", "Posting Date")
//                                 ORDER(Ascending)
//                                 WHERE("Document Type" = FILTER(Payment | Refund));
//             column(CustDocNo; "Cust. Ledger Entry"."Document No.")
//             {
//             }
//             column(cust_cramt; "Cust. Ledger Entry".Amount)
//             {
//             }
//             column(cust_custnm; custnm)
//             {
//             }
//             column(cust_amt; cust_amt)
//             {
//             }
//             column(cashamt; cashamt)
//             {
//             }
//             column(Srno2; Srno2)
//             {
//             }
//             column(HDFCAMT2; HDFCAMT2)
//             {
//             }
//             column(HSBCAMT2; HSBCAMT2)
//             {
//             }
//             column(AMXAMT2; AMXAMT2)
//             {
//             }
//             column(CITIAMT2; CITIAMT2)
//             {
//             }
//             column(InnovitiAMT2; InnovitiAMT2)
//             {
//             }
//             column(PineLABSAMT2; PineLABSAMT2)
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 custnm := '';
//                 cust_amt := 0;
//                 cashamt := 0;
//                 chquamt := 0;
//                 HDFCAMT2 := 0;
//                 HSBCAMT2 := 0;
//                 AMXAMT2 := 0;
//                 CITIAMT2 := 0;
//                 InnovitiAMT2 := 0;
//                 PineLABSAMT2 := 0;
//                 "Cust. Ledger Entry".CALCFIELDS("Cust. Ledger Entry"."Credit Amount");

//                 Srno2 += 1;
//                 cust.RESET;
//                 cust.SETFILTER(cust."No.", "Cust. Ledger Entry"."Customer No.");
//                 IF cust.FINDFIRST THEN
//                     custnm := cust.Name;

//                 cust_amt := "Cust. Ledger Entry".Amount;
//                 IF ("Cust. Ledger Entry"."Reason Code" = 'CASH') THEN
//                     cashamt := "Cust. Ledger Entry"."Credit Amount";


//                 IF ("Cust. Ledger Entry"."Reason Code" = 'HDFC') THEN
//                     HDFCAMT2 := "Cust. Ledger Entry"."Credit Amount";

//                 IF ("Cust. Ledger Entry"."Reason Code" = 'HSBC') THEN
//                     HSBCAMT2 := "Cust. Ledger Entry"."Credit Amount";

//                 IF ("Cust. Ledger Entry"."Reason Code" = 'AMEX') THEN
//                     AMXAMT2 := "Cust. Ledger Entry"."Credit Amount";

//                 IF ("Cust. Ledger Entry"."Reason Code" = 'CITI') THEN
//                     CITIAMT2 := "Cust. Ledger Entry"."Credit Amount";

//                 IF ("Cust. Ledger Entry"."Reason Code" = 'Innoviti') THEN
//                     InnovitiAMT2 := "Cust. Ledger Entry"."Credit Amount";

//                 IF ("Cust. Ledger Entry"."Reason Code" = 'PineLABS') THEN
//                     PineLABSAMT2 := "Cust. Ledger Entry"."Credit Amount";
//             end;

//             trigger OnPreDataItem()
//             begin
//                 Srno2 := 0;
//                 "Cust. Ledger Entry".SETRANGE("Cust. Ledger Entry"."Posting Date", startdt, enddt);
//                 //"Cust. Ledger Entry".SETFILTER( "Location Code",'%1',usersetup."Location Code");

//                 "Cust. Ledger Entry".SETFILTER("Cust. Ledger Entry"."Global Dimension 1 Code", '%1', Branchcode1);
//                 "Cust. Ledger Entry".SETFILTER("Cust. Ledger Entry"."Reason Code", '<>%1', '');
//                 IF "Cust. Ledger Entry".FINDSET THEN;
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
//                     field("Start Date"; startdt)
//                     {
//                         ApplicationArea = All;
//                     }
//                     field("End Date"; enddt)
//                     {
//                         ApplicationArea = All;
//                     }
//                     field(Location; loc.Code)
//                     {
//                         Visible = false;
//                         ApplicationArea = All;
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
//         IF usersetup.GET(USERID) THEN
//             IF loc.GET(usersetup."Location Code") THEN
//                 SalesSetup.GET;
//     end;

//     var
//         LastFieldNo: Integer;
//         FooterPrinted: Boolean;
//         GLAcc: Record "G/L Account";
//         Srno: Integer;
//         PurchRctHeader: Record "Purch. Rcpt. Header";
//         Vend: Record Vendor;
//         Item: Record Item;
//         InvepostingSetup: Record "Inventory Posting Setup";
//         Gl: Record "G/L Account";
//         Desc: Text[250];
//         PurchInvHeader: Record "Purch. Inv. Header";
//         cstgroup: Code[10];
//         TaxName: Text[30];
//         PurchINVLine: Record "Purch. Inv. Line";
//         cstcheck: Boolean;
//         comp: Record "Company Information";
//         datefilter: Text[50];
//         locfilter55: Text[50];
//         loc: Record Location;
//         taxgrp: Record "Tax Group";
//         taxdesc: Text[30];
//         txt1: Label 'give location';
//         loc_txt: Code[10];
//         k: Text[30];
//         l: Text[30];
//         xl: Boolean;
//         TD: Record "Tax Detail";
//         TJ: Record "Tax Jurisdiction";
//         taxperc: Decimal;
//         typ: Text[30];
//         cform: Code[30];
//         statecode: Code[10];
//         recstate: Record State;
//         locat: Record Location;
//         site: Text[30];
//         RecPurHead: Record "Purchase Header";
//         i: Text[30];
//         RecGPPG: Record "General Posting Setup";
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
//         InvCr: Integer;
//         sbucode: Text[30];
//         sbu: Record "Dimension Value";
//         sbufiltername: Text[30];
//         sbuname: Text[30];
//         sbuname1: Text[30];
//         taxdesc1: Text[30];
//         datefilter1: Text[50];
//         locfilter551: Text[50];
//         loc_txt1: Code[10];
//         docno: Code[30];
//         No: Boolean;
//         "SBU String": Text[100];
//         AppQty: Integer;
//         NonAppQty: Integer;
//         HDFCCardNo: Code[30];
//         HSBCCardNo: Code[30];
//         AMXCardNo: Code[30];
//         CITICardNo: Code[30];
//         InnovitiCardNo: Code[30];
//         PineLABSCardNo: Code[30];
//         HDFCAMT: Decimal;
//         HSBCAMT: Decimal;
//         AMXAMT: Decimal;
//         CITIAMT: Decimal;
//         InnovitiAMT: Decimal;
//         PineLABSAMT: Decimal;
//         salesinvline: Record "Sales Invoice Line";
//         salesCrMemoLn: Record "Sales Cr.Memo Line";
//         AppQty1: Integer;
//         NonAppQty1: Integer;
//         HDFCCardNo1: Code[30];
//         HSBCCardNo1: Code[30];
//         AMXCardNo1: Code[30];
//         CITICardNo1: Code[30];
//         InnovitiCardNo1: Code[30];
//         PineLABSCardNo1: Code[30];
//         HDFCAMT1: Decimal;
//         HSBCAMT1: Decimal;
//         AMXAMT1: Decimal;
//         CITIAMT1: Decimal;
//         InnovitiAMT1: Decimal;
//         PineLABSAMT1: Decimal;
//         startdt: Date;
//         enddt: Date;
//         cust: Record Customer;
//         custnm: Text[250];
//         cust_amt: Decimal;
//         cashamt: Decimal;
//         chquamt: Decimal;
//         Srno2: Integer;
//         Srno1: Integer;
//         HDFCAMT2: Decimal;
//         HSBCAMT2: Decimal;
//         AMXAMT2: Decimal;
//         CITIAMT2: Decimal;
//         InnovitiAMT2: Decimal;
//         PineLABSAMT2: Decimal;
//         usersetup: Record "User Setup";
//         BBAmt: Decimal;
//         BBAMtTot: Decimal;
//         BBCrAmt: Decimal;
//         BBCrAMtTot: Decimal;
//         PendShieldValue: Decimal;
//         SaleCashAmt: Decimal;
//         SaleChqAmt: Decimal;
//         TotShieldvalue: Decimal;
//         Tmpvalue: Decimal;
//         Rtgsamt1: Decimal;
//         RtgsAmt: Decimal;
//         FinAmt: Decimal;
//         FinAmt1: Decimal;
//         GiftAmt: Decimal;
//         SalesSetup: Record "Sales & Receivables Setup";
//         RecComment: Record "Sales Comment Line";
//         Cmnt: Text[80];
//         CmntCr: Text[80];
//         RecCommentCr: Record "Sales Comment Line";
//         RecSalesPerson: Record "Salesperson/Purchaser";
//         SalesName: Text[50];
//         ResCenter: Record "Responsibility Center New 1";
//         Branchcode1: Code[100];
//         RtgNo: Code[20];
//         FinanceCompanyName: Text[30];
//         FinanceCompanyName1: Text[30];
//         POS: Integer;
//         BANKAppCode: Code[20];
//         BANKAppCode1: Code[20];
//         POS1: Integer;

//     procedure InitVarSales()
//     begin
//         HDFCCardNo := '';
//         HDFCAMT := 0;
//         HDFCCardNo := '';
//         HDFCAMT := 0;
//         HDFCCardNo := '';
//         HDFCAMT := 0;
//         HDFCCardNo := '';
//         HDFCAMT := 0;
//         HDFCCardNo := '';
//         HDFCAMT := 0;
//         HSBCCardNo := '';
//         HSBCAMT := 0;
//         HSBCCardNo := '';
//         HSBCAMT := 0;
//         HSBCCardNo := '';
//         HSBCAMT := 0;
//         HSBCCardNo := '';
//         HSBCAMT := 0;
//         HSBCCardNo := '';
//         HSBCAMT := 0;
//         AMXCardNo := '';
//         AMXAMT := 0;
//         AMXCardNo := '';
//         AMXAMT := 0;
//         AMXCardNo := '';
//         AMXAMT := 0;
//         AMXCardNo := '';
//         AMXAMT := 0;
//         AMXCardNo := '';
//         AMXAMT := 0;
//         CITICardNo := '';
//         CITIAMT := 0;
//         CITICardNo := '';
//         CITIAMT := 0;
//         CITICardNo := '';
//         CITIAMT := 0;
//         CITICardNo := '';
//         CITIAMT := 0;
//         CITICardNo := '';
//         CITIAMT := 0;
//         InnovitiCardNo := '';
//         InnovitiAMT := 0;
//         InnovitiCardNo := '';
//         InnovitiAMT := 0;
//         InnovitiCardNo := '';
//         InnovitiAMT := 0;
//         InnovitiCardNo := '';
//         InnovitiAMT := 0;
//         InnovitiCardNo := '';
//         InnovitiAMT := 0;
//         PineLABSCardNo := '';
//         PineLABSAMT := 0;
//         PineLABSCardNo := '';
//         PineLABSAMT := 0;
//         PineLABSCardNo := '';
//         PineLABSAMT := 0;
//         PineLABSCardNo := '';
//         PineLABSAMT := 0;
//         PineLABSCardNo := '';
//         PineLABSAMT := 0;
//         BBAmt := 0;
//     end;

//     procedure InitVarCrMemo()
//     begin
//         HDFCCardNo1 := '';
//         HDFCAMT1 := 0;
//         HDFCCardNo1 := '';
//         HDFCAMT1 := 0;
//         HDFCCardNo1 := '';
//         HDFCAMT1 := 0;
//         HDFCCardNo1 := '';
//         HDFCAMT1 := 0;
//         HDFCCardNo1 := '';
//         HDFCAMT1 := 0;
//         HSBCCardNo1 := '';
//         HSBCAMT1 := 0;
//         HSBCCardNo1 := '';
//         HSBCAMT1 := 0;
//         HSBCCardNo1 := '';
//         HSBCAMT1 := 0;
//         HSBCCardNo1 := '';
//         HSBCAMT1 := 0;
//         HSBCCardNo1 := '';
//         HSBCAMT1 := 0;
//         AMXCardNo1 := '';
//         AMXAMT1 := 0;
//         AMXCardNo1 := '';
//         AMXAMT1 := 0;
//         AMXCardNo1 := '';
//         AMXAMT1 := 0;
//         AMXCardNo1 := '';
//         AMXAMT1 := 0;
//         AMXCardNo1 := '';
//         AMXAMT1 := 0;
//         CITICardNo1 := '';
//         CITIAMT1 := 0;
//         CITICardNo1 := '';
//         CITIAMT1 := 0;
//         CITICardNo1 := '';
//         CITIAMT1 := 0;
//         CITICardNo1 := '';
//         CITIAMT1 := 0;
//         CITICardNo1 := '';
//         CITIAMT1 := 0;
//         InnovitiCardNo1 := '';
//         InnovitiAMT1 := 0;
//         InnovitiCardNo1 := '';
//         InnovitiAMT1 := 0;
//         InnovitiCardNo1 := '';
//         InnovitiAMT1 := 0;
//         InnovitiCardNo1 := '';
//         InnovitiAMT1 := 0;
//         InnovitiCardNo1 := '';
//         InnovitiAMT1 := 0;
//         PineLABSCardNo1 := '';
//         PineLABSAMT1 := 0;
//         PineLABSCardNo1 := '';
//         PineLABSAMT1 := 0;
//         PineLABSCardNo1 := '';
//         PineLABSAMT1 := 0;
//         PineLABSCardNo1 := '';
//         PineLABSAMT1 := 0;
//         PineLABSCardNo1 := '';
//         PineLABSAMT1 := 0;
//     end;

//     procedure InitVarCustLedg()
//     begin
//     end;
// }

