// codeunit 50025 "E-Invoice_ASP"
// {
//     Permissions = TableData 112 = rimd,
//                   TableData 114 = rimd;

//     trigger OnRun()
//     var
//         body: Label '{"Username":"admin@agri.com","Password":"agri@123","schema": "govt_schema_v1","govtRequestDTO": {"TaxSch": "GST","Version": "1.00"}}';
//         Loc: Record 14;
//         ToLoc: Record 14;
//     begin
//         Initialize;
//         IF IsInvoice THEN
//             WITH SalesInvoiceHeader DO BEGIN
//                 IF "GST Customer Type" IN ["GST Customer Type"::Unregistered, "GST Customer Type"::" "]
//                 THEN
//                     ERROR(UnRegCusrErr);
//                 DocumentNo := "No.";
//                 WriteFileHeader;
//                 ReadTransDtls("GST Customer Type", "Ship-to Code");
//                 ReadDocDtls;
//                 ReadSellerDtls;
//                 ReadBuyerDtls;
//                 ReadShipDtls;
//                 ReadValDtls; //KPPL
//                 ReadItemList;
//                 JsonTextWriter.WriteEndObject;
//                 JsonTextWriter.Flush;
//                 /*
//                 IF DocumentNo <> '' THEN
//                  ExportAsJson(DocumentNo)
//                 ELSE
//                  ERROR(RecIsEmptyErr);
//                  */
//                 ReadGenerateIRN(docType::Invoice, DocumentNo);
//             END
//         ELSE
//             WITH SalesCrMemoHeader DO BEGIN
//                 IF "GST Customer Type" IN ["GST Customer Type"::Unregistered, "GST Customer Type"::" "]
//                  THEN
//                     ERROR(UnRegCusrErr);
//                 DocumentNo := "No.";
//                 WriteFileHeader;
//                 ReadTransDtls("GST Customer Type", "Ship-to Code");
//                 ReadDocDtls;
//                 ReadSellerDtls;
//                 ReadBuyerDtls;
//                 ReadShipDtls;
//                 ReadItemList;
//                 ReadValDtls;
//                 // JsonTextWriter.WriteEndObject;//tk
//                 // JsonTextWriter.Flush;//tk
//                 /*
//                     IF DocumentNo <> '' THEN
//                      ExportAsJson(DocumentNo)
//                     ELSE
//                      ERROR(RecIsEmptyErr);
//                   */
//                 // ReadGenerateIRN(docType::"Credit Memo", DocumentNo);//tk
//             END;

//     end;

//     var
//         SalesInvoiceHeader: Record 112;
//         SalesCrMemoHeader: Record 114;
//         // StringBuilder: DotNet StringBuilder;//tk+
//         // StringWriter: DotNet StringWriter;
//         // JsonTextWriter: DotNet JsonTextWriter;
//         // JsonFormatting: DotNet Formatting;//tk--
//         GlobalNULL: Variant;
//         UnRegCusrErr: Label 'E-Invoicing is not applicable for Unregistered Customer.';
//         RecIsEmptyErr: Label 'Record variable uninitialized.';
//         IsInvoice: Boolean;
//         SalesLinesErr: Label 'E-Invoice allowes only 100 lines per Invoice. Curent transaction is having %1 lines.', Comment = '%1 = Sales Lines count';
//         DocumentNo: Text[20];
//         // TempBlob: Record 99008535;//tk
//         Instr: InStream;
//         // TempJObject: DotNet JObject;//tk
//         // HttpResponseMessage: DotNet HttpResponseMessage;//tk
//         JSONManagement: Codeunit 5459;
//         // JsonConvert: DotNet JsonConvert;//tk
//         Json: Text;
//         ArrayString: Text;
//         JsonString: Text;
//         // JProperty: DotNet JProperty;//tk
//         docType: Option Invoice,"Credit Memo",Transfer;
//         // [RunOnClient]//tk
//         // IBarCodeProvider: DotNet IBarcodeProvider;//tk
//         FileMagmet: Codeunit 419;
//         GSTRN: Code[20];
//         Token_No: Text;
//         Token_ExpDateTime: DateTime;
//         decRndOffAmt: Decimal;
//         Supplytype: Option " ",B2B,SEZWP,SEZWOP,EXPWP,EXPWOP,DEXP;
//         IsTransShip: Boolean;
//         TransferShipHdr: Record 5744;
//         ISEwayRequired: Boolean;
//         IsGetEntry: Boolean;
//         GetEntryGST: Code[20];
//         GetEntryIRN: Text;
//         txtErrorcode: Text;
//         // GstReg: Record 16400;//tk
//         SalesSetu: Record 311;
//         FileManagement: Codeunit 419;
//         StcdPOS: Text;
//         recLogEnrty: Record 50005;

//     local procedure Initialize()
//     begin
//         // // StringBuilder := StringBuilder.StringBuilder;//tk+
//         // StringWriter := StringWriter.StringWriter(StringBuilder);
//         // JsonTextWriter := JsonTextWriter.JsonTextWriter(StringWriter);
//         // JsonTextWriter.Formatting := JsonFormatting.Indented;//TK--

//         CLEAR(GlobalNULL);
//     end;

//     local procedure WriteFileHeader()
//     begin
//         // JsonTextWriter.WriteStartObject;//tk+
//         // JsonTextWriter.WritePropertyName('Version');
//         // JsonTextWriter.WriteValue('1.1');//tk--
//     end;

//     local procedure ReadTransDtls(GSTCustType: Option " ",Registered,Unregistered,Export,"Deemed Export",Exempted,"SEZ Development","SEZ Unit"; ShipToCode: Code[12])
//     var
//         SalesInvoiceLine: Record 113;
//         SalesCrMemoLine: Record 115;
//         Typ: Text[3];
//         Cust: Record 18;
//         catg: Text[6];
//     begin
//         IF IsInvoice THEN BEGIN
//             IF Cust.GET(SalesInvoiceHeader."Bill-to Customer No.") THEN BEGIN
//                 //Cust.TESTFIELD("Type Of Supply");
//                 catg := FORMAT(SalesInvoiceHeader."Nature of Supply");
//                 Supplytype := SalesInvoiceHeader."Nature of Supply";
//             END

//         END ELSE BEGIN
//             IF Cust.GET(SalesCrMemoHeader."Bill-to Customer No.") THEN BEGIN
//                 // Cust.TESTFIELD("Type Of Supply");
//                 catg := FORMAT(SalesCrMemoHeader."Nature of Supply");
//                 Supplytype := SalesCrMemoHeader."Nature of Supply";
//             END;
//         END;

//         WriteTransDtls(catg, 'N', Typ, 'false', 'Y', '');
//     end;

//     local procedure WriteTransDtls(catg: Text[6]; RegRev: Text[2]; Typ: Text[3]; EcmTrnSel: Text[5]; EcmTrn: Text[1]; EcmGstin: Text[15])
//     begin
//         // JsonTextWriter.WritePropertyName('TranDtls');//tk+
//         // JsonTextWriter.WriteStartObject;

//         // JsonTextWriter.WritePropertyName('TaxSch');
//         // JsonTextWriter.WriteValue('GST');

//         // JsonTextWriter.WritePropertyName('SupTyp');
//         // JsonTextWriter.WriteValue(catg);

//         // JsonTextWriter.WritePropertyName('RegRev');
//         // JsonTextWriter.WriteValue(RegRev);
//         // JsonTextWriter.WriteEndObject;//tk--
//     end;

//     local procedure ReadDocDtls()
//     var
//         Typ: Text[3];
//         Dt: Text[10];
//         OrgInvNo: Text[16];
//     begin
//         IF IsInvoice THEN BEGIN
//             IF SalesInvoiceHeader."Invoice Type" = SalesInvoiceHeader."Invoice Type"::Taxable THEN
//                 Typ := 'INV'
//             ELSE
//                 IF (SalesInvoiceHeader."Invoice Type" = SalesInvoiceHeader."Invoice Type"::"Debit Note") OR
//                    (SalesInvoiceHeader."Invoice Type" = SalesInvoiceHeader."Invoice Type"::Supplementary)
//                 THEN
//                     Typ := 'DBN'
//                 ELSE
//                     Typ := 'INV';

//             Dt := FORMAT(SalesInvoiceHeader."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>');
//         END ELSE BEGIN
//             Typ := 'CRN';
//             Dt := FORMAT(SalesCrMemoHeader."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>');
//         END;


//         WriteDocDtls(Typ, COPYSTR(DocumentNo, 1, 16), Dt, OrgInvNo);
//     end;

//     local procedure WriteDocDtls(Typ: Text[3]; No: Text[16]; Dt: Text[10]; OrgInvNo: Text[16])
//     begin
//         // JsonTextWriter.WritePropertyName('DocDtls');//tk
//         // JsonTextWriter.WriteStartObject;

//         // JsonTextWriter.WritePropertyName('Typ');
//         // JsonTextWriter.WriteValue(Typ);
//         // JsonTextWriter.WritePropertyName('No');
//         // JsonTextWriter.WriteValue(No);
//         // //JsonTextWriter.WriteValue('ASP/TRAP/IB0387');
//         // JsonTextWriter.WritePropertyName('Dt');
//         // JsonTextWriter.WriteValue(Dt);
//         // JsonTextWriter.WriteEndObject;//TK--
//     end;

//     local procedure ReadExpDtls()
//     var
//         SalesInvoiceLine: Record 113;
//         SalesCrMemoLine: Record 115;
//         // GSTManagement: Codeunit 16401;//tk
//         ExpCat: Text[3];
//         WithPay: Text[1];
//         ShipBNo: Text[16];
//         ShipBDt: Text[10];
//         Port: Text[10];
//         InvForCur: Decimal;
//         ForCur: Text[3];
//         CntCode: Text[2];
//     begin
//         IF IsInvoice THEN
//             WITH SalesInvoiceHeader DO BEGIN
//                 IF "GST Customer Type" IN
//                    ["GST Customer Type"::Export,
//                     "GST Customer Type"::"Deemed Export"]
//                 THEN BEGIN
//                     CASE "GST Customer Type" OF
//                         "GST Customer Type"::Export:
//                             ExpCat := 'DIR';
//                         "GST Customer Type"::"Deemed Export":
//                             ExpCat := 'DEM';
//                     END;
//                     IF "GST Without Payment of Duty" THEN
//                         WithPay := 'N'
//                     ELSE
//                         WithPay := 'Y';
//                     ShipBNo := COPYSTR("Bill Of Export No.", 1, 16);
//                     ShipBDt := FORMAT("Bill Of Export Date", 0, '<Year4>-<Month,2>-<Day,2>');
//                     Port := "Exit Point";
//                     SalesInvoiceLine.SETRANGE("Document No.", "No.");
//                     IF SalesInvoiceLine.FINDSET THEN
//                         REPEAT
//                             // IF GSTManagement.IsGSTApplicable(Structure) THEN//tk+
//                             //     InvForCur := ROUND(InvForCur + SalesInvoiceLine.Amount)
//                             // ELSE
//                             //     InvForCur := InvForCur + SalesInvoiceLine.Amount;//tk--
//                         UNTIL SalesInvoiceLine.NEXT = 0;
//                     ForCur := COPYSTR("Currency Code", 1, 3);
//                     CntCode := COPYSTR("Bill-to Country/Region Code", 1, 2);
//                 END ELSE
//                     EXIT;
//             END
//         ELSE
//             WITH SalesCrMemoHeader DO BEGIN
//                 IF "GST Customer Type" IN
//                    ["GST Customer Type"::Export,
//                     "GST Customer Type"::"Deemed Export"]
//                 THEN BEGIN
//                     CASE "GST Customer Type" OF
//                         "GST Customer Type"::Export:
//                             ExpCat := 'DIR';
//                         "GST Customer Type"::"Deemed Export":
//                             ExpCat := 'DEM';
//                     END;
//                     IF "GST Without Payment of Duty" THEN
//                         WithPay := 'N'
//                     ELSE
//                         WithPay := 'Y';
//                     ShipBNo := COPYSTR("Bill Of Export No.", 1, 16);
//                     ShipBDt := FORMAT("Bill Of Export Date", 0, '<Year4>-<Month,2>-<Day,2>');
//                     Port := "Exit Point";
//                     SalesCrMemoLine.SETRANGE("Document No.", "No.");
//                     SalesCrMemoLine.SETFILTER(Type, '<>%1', SalesCrMemoLine.Type::" ");//KPPL 050920
//                     IF SalesCrMemoLine.FINDSET THEN
//                         REPEAT
//                             // IF GSTManagement.IsGSTApplicable(Structure) THEN//tk+
//                             //     InvForCur := InvForCur + SalesCrMemoLine.Amount
//                             // ELSE
//                             //     InvForCur := InvForCur + SalesCrMemoLine.Amount;//TK--
//                         UNTIL SalesCrMemoLine.NEXT = 0;
//                     ForCur := COPYSTR("Currency Code", 1, 3);
//                     CntCode := COPYSTR("Bill-to Country/Region Code", 1, 2);
//                 END ELSE
//                     EXIT;
//             END;

//         WriteExpDtls(ExpCat, WithPay, ShipBNo, ShipBDt, Port, InvForCur, ForCur, CntCode);
//     end;

//     local procedure WriteExpDtls(ExpCat: Text[3]; WithPay: Text[1]; ShipBNo: Text[16]; ShipBDt: Text[10]; Port: Text[10]; InvForCur: Decimal; ForCur: Text[3]; CntCode: Text[2])
//     begin
//         // JsonTextWriter.WritePropertyName('ExpDtls');//tk++
//         // JsonTextWriter.WriteStartObject;

//         // JsonTextWriter.WritePropertyName('ExpCat');
//         // IF ExpCat <> '' THEN
//         //     JsonTextWriter.WriteValue(ExpCat)
//         // ELSE
//         //     JsonTextWriter.WriteValue(GlobalNULL);
//         // JsonTextWriter.WritePropertyName('WithPay');
//         // IF WithPay <> '' THEN
//         //     JsonTextWriter.WriteValue(WithPay)
//         // ELSE
//         //     JsonTextWriter.WriteValue(GlobalNULL);
//         // JsonTextWriter.WritePropertyName('ShipBNo');
//         // IF ShipBNo <> '' THEN
//         //     JsonTextWriter.WriteValue(ShipBNo)
//         // ELSE
//         //     JsonTextWriter.WriteValue(GlobalNULL);
//         // JsonTextWriter.WritePropertyName('ShipBDt');
//         // IF ShipBDt <> '' THEN
//         //     JsonTextWriter.WriteValue(ShipBDt)
//         // ELSE
//         //     JsonTextWriter.WriteValue(GlobalNULL);
//         // JsonTextWriter.WritePropertyName('Port');
//         // IF Port <> '' THEN
//         //     JsonTextWriter.WriteValue(Port)
//         // ELSE
//         //     JsonTextWriter.WriteValue(GlobalNULL);
//         // JsonTextWriter.WritePropertyName('InvForCur');
//         // JsonTextWriter.WriteValue(InvForCur);
//         // JsonTextWriter.WritePropertyName('ForCur');
//         // IF ForCur <> '' THEN
//         //     JsonTextWriter.WriteValue(ForCur)
//         // ELSE
//         //     JsonTextWriter.WriteValue(GlobalNULL);
//         // JsonTextWriter.WritePropertyName('CntCode');
//         // IF CntCode <> '' THEN
//         //     JsonTextWriter.WriteValue(CntCode)
//         // ELSE
//         //     JsonTextWriter.WriteValue(GlobalNULL);

//         // JsonTextWriter.WriteEndObject;//tk--
//     end;

//     local procedure ReadSellerDtls()
//     var
//         CompanyInformationBuff: Record 79;
//         LocationBuff: Record 14;
//          StateBuff: Record State;
//         Gstin: Text[15];
//         TrdNm: Text[100];
//         Bno: Text[60];
//         Bnm: Text[60];
//         Flno: Text[60];
//         Loc: Text[60];
//         Dst: Text[60];
//         Pin: Text[6];
//         Stcd: Text[2];
//         Ph: Text;
//         Em: Text[50];
//         flag: Boolean;
//     begin
//         IF IsTransShip = FALSE THEN BEGIN
//             IF IsInvoice THEN
//                 WITH SalesInvoiceHeader DO BEGIN
//                     LocationBuff.GET("Location Code");
//                     Gstin := LocationBuff."GST Registration No.";
//                     CompanyInformationBuff.GET;
//                     TrdNm := CompanyInformationBuff.Name;

//                     GSTRN := LocationBuff."GST Registration No.";
//                     Bno := LocationBuff.Address; //Modified 301220
//                     Bnm := LocationBuff."Address 2";//Modified 301220
//                     Flno := '';
//                     Loc := LocationBuff.City;//Modified 301220
//                     Dst := LocationBuff.City;
//                     Pin := COPYSTR(LocationBuff."Post Code", 1, 6);
//                     StateBuff.GET(LocationBuff."State Code");
//                     Stcd := StateBuff."State Code (GST Reg. No.)";
//                     Ph := COPYSTR(LocationBuff."Phone No.", 1, 10);
//                     Em := COPYSTR(LocationBuff."E-Mail", 1, 50);
//                 END
//             ELSE
//                 WITH SalesCrMemoHeader DO BEGIN
//                     LocationBuff.GET("Location Code");
//                     Gstin := LocationBuff."GST Registration No.";
//                     GSTRN := LocationBuff."GST Registration No.";
//                     CompanyInformationBuff.GET;
//                     TrdNm := CompanyInformationBuff.Name;
//                     Bno := LocationBuff.Address; //Modified 301220
//                     Bnm := LocationBuff."Address 2";//Modified 301220
//                     Flno := '';
//                     Loc := LocationBuff.City;//Modified 301220
//                     Dst := LocationBuff.City;
//                     Pin := COPYSTR(LocationBuff."Post Code", 1, 6);
//                     StateBuff.GET(LocationBuff."State Code");
//                     Stcd := StateBuff."State Code (GST Reg. No.)";
//                     Ph := COPYSTR(LocationBuff."Phone No.", 1, 10);
//                     Em := COPYSTR(LocationBuff."E-Mail", 1, 50);
//                 END;
//         END;
//         IF IsTransShip = TRUE THEN
//             WITH TransferShipHdr DO BEGIN
//                 CompanyInformationBuff.GET;
//                 LocationBuff.GET(TransferShipHdr."Transfer-from Code");
//                 TrdNm := CompanyInformationBuff.Name;
//                 Gstin := LocationBuff."GST Registration No.";
//                 GSTRN := LocationBuff."GST Registration No.";
//                 Bno := LocationBuff.Code;
//                 Bnm := LocationBuff.Address;
//                 Loc := TransferShipHdr."Transfer-from Code";
//                 Dst := LocationBuff.City;
//                 Pin := COPYSTR(LocationBuff."Post Code", 1, 6);
//                 StateBuff.GET(LocationBuff."State Code");
//                 Stcd := StateBuff."State Code (GST Reg. No.)";
//                 Ph := COPYSTR(LocationBuff."Phone No.", 1, 10);
//                 Em := COPYSTR(LocationBuff."E-Mail", 1, 50);
//             END;


//         WriteSellerDtls(Gstin, TrdNm, Bno, Bnm, Flno, Loc, Dst, Pin, Stcd, Ph, Em);
//     end;

//     local procedure WriteSellerDtls(Gstin: Text[15]; TrdNm: Text[100]; Bno: Text[60]; Bnm: Text[60]; Flno: Text[60]; Loc: Text[60]; Dst: Text[60]; Pin: Text[6]; Stcd: Text[2]; Ph: Text; Em: Text[50])
//     var
//         intPh: BigInteger;
//         intStcd: Integer;
//         intPin: Integer;
//         recState: Record State;
//     begin
//         // JsonTextWriter.WritePropertyName('SellerDtls');
//         // JsonTextWriter.WriteStartObject;

//         // JsonTextWriter.WritePropertyName('Gstin');
//         // IF Gstin <> '' THEN
//         //     JsonTextWriter.WriteValue(Gstin)
//         // ELSE
//         //     JsonTextWriter.WriteValue(GlobalNULL);
//         // JsonTextWriter.WritePropertyName('LglNm');
//         // IF TrdNm <> '' THEN
//         //     JsonTextWriter.WriteValue(TrdNm)
//         // ELSE
//         //     JsonTextWriter.WriteValue(GlobalNULL);
//         // JsonTextWriter.WritePropertyName('Addr1');
//         // IF Bno <> '' THEN
//         //     JsonTextWriter.WriteValue(Bno)
//         // ELSE
//         //     JsonTextWriter.WriteValue(GlobalNULL);
//         // JsonTextWriter.WritePropertyName('Addr2');
//         // IF Bnm <> '' THEN
//         //     JsonTextWriter.WriteValue(Bnm)
//         // ELSE
//         //     JsonTextWriter.WriteValue(GlobalNULL);

//         // JsonTextWriter.WritePropertyName('Loc');
//         // IF Loc <> '' THEN
//         //     JsonTextWriter.WriteValue(Loc)
//         // ELSE
//         //     JsonTextWriter.WriteValue(GlobalNULL);
//         // JsonTextWriter.WritePropertyName('Pin');
//         // IF Pin <> '' THEN BEGIN
//         //     EVALUATE(intPin, Pin);
//         //     JsonTextWriter.WriteValue(intPin)
//         // END ELSE
//         //     JsonTextWriter.WriteValue(GlobalNULL);


//         // JsonTextWriter.WritePropertyName('Stcd');
//         // IF Stcd <> '' THEN
//         //     JsonTextWriter.WriteValue(Stcd)
//         // ELSE
//         //     JsonTextWriter.WriteValue(GlobalNULL);

//         // JsonTextWriter.WritePropertyName('Ph');
//         // IF Ph <> '' THEN BEGIN
//         //     JsonTextWriter.WriteValue(Ph)
//         // END ELSE
//         //     JsonTextWriter.WriteValue(GlobalNULL);

//         // JsonTextWriter.WritePropertyName('Em');
//         // IF Em <> '' THEN
//         //     JsonTextWriter.WriteValue(Em)
//         // ELSE
//         //     JsonTextWriter.WriteValue(GlobalNULL);

//         // JsonTextWriter.WriteEndObject;//tk--
//     end;

//     local procedure ReadBuyerDtls()
//     var
//         Contact: Record 5050;
//         SalesInvoiceLine: Record 113;
//         SalesCrMemoLine: Record 115;
//         ShipToAddr: Record 222;
//         StateBuff: Record State;
//         Gstin: Text[15];
//         TrdNm: Text[100];
//         Bno: Text[60];
//         Bnm: Text[60];
//         Flno: Text[60];
//         Loc: Text[60];
//         Dst: Text[60];
//         Pin: Text[6];
//         Stcd: Text[2];
//         Ph: Text[10];
//         Em: Text[50];
//         recCust: Record 18;
//         LocationBuff: Record 14;
//         recloc: Record 14;
//     begin
//         IF IsTransShip = FALSE THEN BEGIN
//             IF IsInvoice THEN
//                 WITH SalesInvoiceHeader DO BEGIN
//                     IF recCust.GET("Bill-to Customer No.") THEN
//                         Gstin := recCust."GST Registration No.";
//                     TrdNm := "Bill-to Name";
//                     Bno := "Bill-to Address";
//                     Bnm := "Bill-to Address 2";
//                     Flno := '';
//                     //recCust.GET("Bill-to Customer No.");
//                     Loc := "Bill-to City"; //Modified 301220
//                     Dst := "Bill-to City";
//                     Pin := COPYSTR("Bill-to Post Code", 1, 6);
//                     SalesInvoiceLine.SETRANGE("Document No.", "No.");
//                     SalesInvoiceLine.SETFILTER(SalesInvoiceLine."No.", '<>%1', '');
//                     SalesInvoiceLine.SETFILTER(SalesInvoiceLine.Quantity, '<>%1', 0);
//                     IF SalesInvoiceLine.FINDFIRST THEN
//                         IF (SalesInvoiceLine."GST Place of Supply" = SalesInvoiceLine."GST Place of Supply"::"Bill-to Address")
//                          OR (SalesInvoiceLine."GST Place of Supply" = SalesInvoiceLine."GST Place of Supply"::"Location Address ") THEN BEGIN
//                             IF NOT ("GST Customer Type" = "GST Customer Type"::Export) THEN BEGIN
//                                 //KPPL AMIT 1103
//                                 IF StateBuff.GET("GST Bill-to State Code") THEN
//                                     StcdPOS := StateBuff."State Code (GST Reg. No.)";
//                                 //KPPL AMIT 1103
//                                 StateBuff.GET("GST Bill-to State Code");
//                                 Stcd := StateBuff."State Code (GST Reg. No.)"
//                             END ELSE
//                                 Stcd := '';
//                             IF Contact.GET("Bill-to Contact No.") THEN BEGIN
//                                 Ph := COPYSTR(Contact."Phone No.", 1, 10);
//                                 Em := COPYSTR(Contact."E-Mail", 1, 50);
//                             END ELSE BEGIN
//                                 Ph := '';
//                                 Em := '';
//                             END;
//                         END ELSE
//                             IF SalesInvoiceLine."GST Place of Supply" = SalesInvoiceLine."GST Place of Supply"::"Ship-to Address" THEN BEGIN
//                                 IF NOT ("GST Customer Type" = "GST Customer Type"::Export) THEN BEGIN
//                                     //IF "GST Ship-to State Code" <> '' THEN
//                                     //KPPL AMIT 1103
//                                     IF StateBuff.GET("GST Ship-to State Code") THEN
//                                         StcdPOS := StateBuff."State Code (GST Reg. No.)";
//                                     //KPPL AMIT 1103
//                                     //ELSE

//                                     StateBuff.GET("GST Bill-to State Code");  // KPPL AMIT 080322
//                                     Stcd := StateBuff."State Code (GST Reg. No.)";
//                                 END ELSE
//                                     Stcd := '';
//                                 IF ShipToAddr.GET("Sell-to Customer No.", "Ship-to Code") THEN BEGIN
//                                     Ph := COPYSTR(ShipToAddr."Phone No.", 1, 10);
//                                     Em := COPYSTR(ShipToAddr."E-Mail", 1, 50);
//                                 END ELSE BEGIN
//                                     Ph := '';
//                                     Em := '';
//                                 END;
//                             END ELSE BEGIN
//                                 Stcd := '';
//                                 Ph := '';
//                                 Em := '';
//                             END;
//                     IF Supplytype IN [Supplytype::EXPWOP, Supplytype::EXPWP] THEN BEGIN
//                         Gstin := 'URP';
//                         Stcd := '96';
//                         Pin := '999999';
//                         StcdPOS := '96';
//                     END;
//                 END
//             ELSE
//                 WITH SalesCrMemoHeader DO BEGIN
//                     IF recCust.GET("Bill-to Customer No.") THEN
//                         Gstin := recCust."GST Registration No.";
//                     TrdNm := "Bill-to Name";
//                     Bno := "Bill-to Address";
//                     Bnm := "Bill-to Address 2";
//                     Flno := '';
//                     Loc := "Bill-to City";
//                     Dst := "Bill-to City";
//                     Pin := COPYSTR("Bill-to Post Code", 1, 6);
//                     SalesCrMemoLine.SETRANGE("Document No.", "No.");
//                     SalesCrMemoLine.SETFILTER(Type, '<>%1', SalesCrMemoLine.Type::" ");
//                     IF SalesCrMemoLine.FINDFIRST THEN
//                         IF SalesCrMemoLine."GST Place of Supply" = SalesCrMemoLine."GST Place of Supply"::"Bill-to Address" THEN BEGIN
//                             IF NOT ("GST Customer Type" = "GST Customer Type"::Export) THEN BEGIN
//                                 //KPPL AMIT 1103
//                                 IF StateBuff.GET("GST Bill-to State Code") THEN
//                                     StcdPOS := StateBuff."State Code (GST Reg. No.)";
//                                 //KPPL AMIT 1103
//                                 StateBuff.GET("GST Bill-to State Code");
//                                 Stcd := StateBuff."State Code (GST Reg. No.)";
//                             END ELSE
//                                 Stcd := '';
//                             IF Contact.GET("Bill-to Contact No.") THEN BEGIN
//                                 Ph := COPYSTR(Contact."Phone No.", 1, 10);
//                                 Em := COPYSTR(Contact."E-Mail", 1, 50);
//                             END ELSE BEGIN
//                                 Ph := '';
//                                 Em := '';
//                             END;
//                         END ELSE
//                             IF SalesCrMemoLine."GST Place of Supply" = SalesCrMemoLine."GST Place of Supply"::"Ship-to Address" THEN BEGIN
//                                 IF NOT (SalesInvoiceHeader."GST Customer Type" = SalesInvoiceHeader."GST Customer Type"::Export) THEN BEGIN
//                                     //KPPL AMIT 1103
//                                     IF StateBuff.GET("GST Ship-to State Code") THEN
//                                         StcdPOS := StateBuff."State Code (GST Reg. No.)";
//                                     //KPPL AMIT 1103
//                                     StateBuff.GET("GST Ship-to State Code");
//                                     Stcd := StateBuff."State Code (GST Reg. No.)"
//                                 END ELSE
//                                     Stcd := '';
//                                 IF ShipToAddr.GET("Sell-to Customer No.", "Ship-to Code") THEN BEGIN
//                                     Ph := COPYSTR(ShipToAddr."Phone No.", 1, 10);
//                                     Em := COPYSTR(ShipToAddr."E-Mail", 1, 50);
//                                 END ELSE BEGIN
//                                     Ph := '';
//                                     Em := '';
//                                 END;
//                             END ELSE BEGIN
//                                 Stcd := '';
//                                 Ph := '';
//                                 Em := '';
//                             END;

//                 END;
//             IF Supplytype IN [Supplytype::EXPWOP, Supplytype::EXPWP] THEN BEGIN
//                 Gstin := 'URP';
//                 Stcd := '96';
//                 Pin := '999999';
//                 StcdPOS := '96';
//             END;
//         END;
//         IF IsTransShip = TRUE THEN
//             WITH TransferShipHdr DO BEGIN
//                 LocationBuff.GET(TransferShipHdr."Transfer-to Code");
//                 TrdNm := LocationBuff.Name;
//                 Bno := LocationBuff.Code;
//                 Bnm := LocationBuff.Address;
//                 Flno := '';
//                 Loc := TransferShipHdr."Transfer-to Code";
//                 Dst := LocationBuff.City;
//                 Gstin := LocationBuff."GST Registration No.";
//                 Pin := COPYSTR(LocationBuff."Post Code", 1, 6);
//                 StateBuff.GET(LocationBuff."State Code");
//                 Stcd := StateBuff."State Code (GST Reg. No.)";
//                 Ph := COPYSTR(LocationBuff."Phone No.", 1, 10);
//                 Em := COPYSTR(LocationBuff."E-Mail", 1, 50);
//             END;
//         IF StcdPOS = '' THEN
//             StcdPOS := Stcd;
//         WriteBuyerDtls(Gstin, TrdNm, Bno, Bnm, Flno, Loc, Dst, Pin, Stcd, Ph, Em);
//     end;

//     local procedure WriteBuyerDtls(Gstin: Text[15]; TrdNm: Text[100]; Bno: Text[60]; Bnm: Text[60]; Flno: Text[60]; Loc: Text[60]; Dst: Text[60]; Pin: Text[6]; Stcd: Text[2]; Ph: Text[10]; Em: Text[50])
//     var
//         intPh: BigInteger;
//         intStcd: Integer;
//         intPin: Integer;
//         recState: Record State;
//     begin
//         //tk++
//         // JsonTextWriter.WritePropertyName('BuyerDtls');
//         // JsonTextWriter.WriteStartObject;

//         // JsonTextWriter.WritePropertyName('Gstin');
//         // IF Gstin <> '' THEN
//         //     JsonTextWriter.WriteValue(Gstin)
//         // ELSE
//         //     JsonTextWriter.WriteValue(GlobalNULL);
//         // JsonTextWriter.WritePropertyName('LglNm');
//         // IF TrdNm <> '' THEN
//         //     JsonTextWriter.WriteValue(TrdNm)
//         // ELSE
//         //     JsonTextWriter.WriteValue(GlobalNULL);

//         // JsonTextWriter.WritePropertyName('Pos');
//         // IF Stcd <> '' THEN BEGIN
//         //     JsonTextWriter.WriteValue(StcdPOS);//KPPL
//         // END ELSE
//         //     JsonTextWriter.WriteValue(GlobalNULL);


//         // JsonTextWriter.WritePropertyName('Addr1');
//         // IF Bno <> '' THEN
//         //     JsonTextWriter.WriteValue(Bno)
//         // ELSE
//         //     JsonTextWriter.WriteValue(GlobalNULL);
//         // JsonTextWriter.WritePropertyName('Addr2');
//         // IF Bnm <> '' THEN
//         //     JsonTextWriter.WriteValue(Bnm)
//         // ELSE
//         //     JsonTextWriter.WriteValue(GlobalNULL);

//         // JsonTextWriter.WritePropertyName('Loc');
//         // IF Loc <> '' THEN
//         //     JsonTextWriter.WriteValue(Loc)
//         // ELSE
//         //     JsonTextWriter.WriteValue(GlobalNULL);

//         // JsonTextWriter.WritePropertyName('Pin');
//         // IF Pin <> '' THEN BEGIN
//         //     EVALUATE(intPin, Pin);
//         //     JsonTextWriter.WriteValue(intPin);
//         // END ELSE
//         //     JsonTextWriter.WriteValue(GlobalNULL);

//         // JsonTextWriter.WritePropertyName('Stcd');
//         // IF Stcd <> '' THEN
//         //     JsonTextWriter.WriteValue(Stcd)
//         // ELSE
//         //     JsonTextWriter.WriteValue(GlobalNULL);

//         // JsonTextWriter.WritePropertyName('Ph');
//         // IF Ph <> '' THEN
//         //     JsonTextWriter.WriteValue(Ph)
//         // ELSE
//         //     JsonTextWriter.WriteValue(GlobalNULL);

//         // JsonTextWriter.WritePropertyName('Em');
//         // IF Em <> '' THEN
//         //     JsonTextWriter.WriteValue(Em)
//         // ELSE
//         //     JsonTextWriter.WriteValue(GlobalNULL);

//         // JsonTextWriter.WriteEndObject;//tk--
//     end;

//     local procedure ReadShipDtls()
//     var
//         ShipToAddr: Record 222;
//         StateBuff: Record  state;
//         Gstin: Text[15];
//         TrdNm: Text[100];
//         Bno: Text[60];
//         Bnm: Text[60];
//         Flno: Text[60];
//         Loc: Text[60];
//         Dst: Text[60];
//         Pin: Text[6];
//         Stcd: Text[2];
//         Ph: Text[10];
//         Em: Text[50];
//         LocationBuff: Record 14;
//     begin
//         IF IsInvoice AND (SalesInvoiceHeader."Ship-to Code" <> '') THEN BEGIN
//             WITH SalesInvoiceHeader DO BEGIN
//                 ShipToAddr.GET("Sell-to Customer No.", "Ship-to Code");
//                 TrdNm := "Ship-to Name";
//                 Bno := "Ship-to Address";
//                 Bnm := "Ship-to Address 2";
//                 Flno := '';
//                 Loc := "Ship-to City";
//                 Dst := "Ship-to City";
//                 Ph := COPYSTR(ShipToAddr."Phone No.", 1, 10);
//                 Em := COPYSTR(ShipToAddr."E-Mail", 1, 50);
//                 IF Supplytype IN [Supplytype::EXPWOP, Supplytype::EXPWP] THEN BEGIN
//                     Gstin := 'URP';
//                     Stcd := '96';
//                     Pin := '999999'
//                 END ELSE BEGIN
//                     Gstin := ShipToAddr."GST Registration No.";
//                     StateBuff.GET("GST Ship-to State Code");
//                     Stcd := StateBuff."State Code (GST Reg. No.)";
//                     Pin := COPYSTR("Ship-to Post Code", 1, 6);
//                 END;
//             END;
//             WriteShipDtls(Gstin, TrdNm, Bno, Bnm, Flno, Loc, Dst, Pin, Stcd, Ph, Em);
//         END ELSE
//             IF SalesCrMemoHeader."Ship-to Code" <> '' THEN BEGIN
//                 WITH SalesCrMemoHeader DO BEGIN
//                     ShipToAddr.GET("Sell-to Customer No.", "Ship-to Code");
//                     TrdNm := "Ship-to Name";
//                     Bno := "Ship-to Address";
//                     Bnm := "Ship-to Address 2";
//                     Flno := '';
//                     Loc := "Ship-to City";
//                     Dst := "Ship-to City";
//                     Ph := COPYSTR(ShipToAddr."Phone No.", 1, 10);
//                     Em := COPYSTR(ShipToAddr."E-Mail", 1, 50);
//                     IF Supplytype IN [Supplytype::EXPWOP, Supplytype::EXPWP] THEN BEGIN
//                         Gstin := 'URP';
//                         Stcd := '96';
//                         Pin := '999999'
//                     END ELSE BEGIN
//                         LocationBuff.GET(SalesCrMemoHeader."Location Code");
//                         Gstin := LocationBuff."GST Registration No.";
//                         StateBuff.GET(SalesCrMemoHeader."Location State Code");
//                         Stcd := StateBuff."State Code (GST Reg. No.)";
//                         Pin := COPYSTR("Ship-to Post Code", 1, 6);
//                     END;
//                 END;
//                 WriteShipDtls(Gstin, TrdNm, Bno, Bnm, Flno, Loc, Dst, Pin, Stcd, Ph, Em);
//             END;
//     end;

//     local procedure WriteShipDtls(Gstin: Text[15]; TrdNm: Text[100]; Bno: Text[60]; Bnm: Text[60]; Flno: Text[60]; Loc: Text[60]; Dst: Text[60]; Pin: Text[6]; Stcd: Text[2]; Ph: Text[10]; Em: Text[50])
//     var
//         intPin: Integer;
//     begin
//         // JsonTextWriter.WritePropertyName('ShipDtls');
//         // JsonTextWriter.WriteStartObject;

//         // JsonTextWriter.WritePropertyName('Gstin');
//         // IF Gstin <> '' THEN
//         //     JsonTextWriter.WriteValue(Gstin)
//         // ELSE
//         //     JsonTextWriter.WriteValue(GlobalNULL);
//         // JsonTextWriter.WritePropertyName('LglNm');
//         // IF TrdNm <> '' THEN
//         //     JsonTextWriter.WriteValue(TrdNm)
//         // ELSE
//         //     JsonTextWriter.WriteValue(GlobalNULL);
//         // JsonTextWriter.WritePropertyName('Addr1');
//         // IF Bno <> '' THEN
//         //     JsonTextWriter.WriteValue(Bno)
//         // ELSE
//         //     JsonTextWriter.WriteValue(GlobalNULL);
//         // JsonTextWriter.WritePropertyName('Addr2');
//         // IF Bnm <> '' THEN
//         //     JsonTextWriter.WriteValue(Bnm)
//         // ELSE
//         //     JsonTextWriter.WriteValue(GlobalNULL);

//         // JsonTextWriter.WritePropertyName('Loc');
//         // IF Loc <> '' THEN
//         //     JsonTextWriter.WriteValue(Loc)
//         // ELSE
//         //     JsonTextWriter.WriteValue(GlobalNULL);

//         // JsonTextWriter.WritePropertyName('Pin');

//         // IF Pin <> '' THEN BEGIN
//         //     EVALUATE(intPin, Pin);
//         //     JsonTextWriter.WriteValue(intPin)
//         // END ELSE
//         //     JsonTextWriter.WriteValue(GlobalNULL);

//         // JsonTextWriter.WritePropertyName('Stcd');
//         // IF Stcd <> '' THEN
//         //     JsonTextWriter.WriteValue(Stcd)
//         // ELSE
//         //     JsonTextWriter.WriteValue(GlobalNULL);

//         // JsonTextWriter.WriteEndObject;//tk--
//     end;

//     local procedure ReadValDtls()
//     var
//         AssVal: Decimal;
//         CgstVal: Decimal;
//         SgstVal: Decimal;
//         IgstVal: Decimal;
//         CesVal: Decimal;
//         StCesVal: Decimal;
//         CesNonAdval: Decimal;
//         Disc: Decimal;
//         OthChrg: Decimal;
//         TotInvVal: Decimal;
//     begin
//         GetGSTVal(AssVal, CgstVal, SgstVal, IgstVal, CesVal, StCesVal, CesNonAdval, Disc, OthChrg, TotInvVal);
//         WriteValDtls(AssVal, CgstVal, SgstVal, IgstVal, CesVal, StCesVal, CesNonAdval, Disc, OthChrg, TotInvVal);
//     end;

//     local procedure WriteValDtls(Assval: Decimal; CgstVal: Decimal; SgstVAl: Decimal; IgstVal: Decimal; CesVal: Decimal; StCesVal: Decimal; CesNonAdVal: Decimal; Disc: Decimal; OthChrg: Decimal; TotInvVal: Decimal)
//     begin
//         // JsonTextWriter.WritePropertyName('ValDtls');//tk++
//         // JsonTextWriter.WriteStartObject;

//         // JsonTextWriter.WritePropertyName('AssVal'); //  KPPL changed Assval to AssVal
//         // JsonTextWriter.WriteValue(Assval);
//         // JsonTextWriter.WritePropertyName('CgstVal');
//         // JsonTextWriter.WriteValue(CgstVal);
//         // JsonTextWriter.WritePropertyName('SgstVal');//KPPL changed SgstVAl to SgstVal
//         // JsonTextWriter.WriteValue(SgstVAl);
//         // JsonTextWriter.WritePropertyName('IgstVal');
//         // JsonTextWriter.WriteValue(IgstVal);
//         // JsonTextWriter.WritePropertyName('CesVal');
//         // JsonTextWriter.WriteValue(CesVal);
//         // JsonTextWriter.WritePropertyName('StCesVal');
//         // JsonTextWriter.WriteValue(StCesVal);
//         // JsonTextWriter.WritePropertyName('CesNonAdVal');//tk--
//         // JsonTextWriter.WriteValue(CesNonAdVal);
//         /*JsonTextWriter.WritePropertyName('Disc');
//         JsonTextWriter.WriteValue(Disc);
//         JsonTextWriter.WritePropertyName('OthChrg');
//         JsonTextWriter.WriteValue(OthChrg);
//         */

//         //JsonTextWriter.WritePropertyName('OthChrg'); //added 031220
//         //JsonTextWriter.WriteValue(OthChrg); //added 031220

//         JsonTextWriter.WritePropertyName('RndOffAmt'); //Ver1.03 added
//         JsonTextWriter.WriteValue(decRndOffAmt);//Ver1.03 added

//         JsonTextWriter.WritePropertyName('TotInvVal');
//         JsonTextWriter.WriteValue(TotInvVal);

//         JsonTextWriter.WriteEndObject;

//     end;

//     local procedure ReadItemList()
//     var
//         SalesInvoiceLine: Record 113;
//         SalesCrMemoLine: Record 115;
//         AssAmt: Decimal;
//         CgstRt: Decimal;
//         SgstRt: Decimal;
//         IgstRt: Decimal;
//         CesRt: Decimal;
//         CesNonAdval: Decimal;
//         StateCes: Decimal;
//         FreeQty: Decimal;
//         SNo: Integer;
//         recHsnSac: Record 16411;
//         IsServc: Text;
//         recSIH: Record 112;
//         recCustPostGrp: Record 92;
//         recSCL: Record 115;
//         recSCH: Record 114;
//         TransferShipLine: Record 5745;
//         CurrExchRate: Record 330;
//         LAmt: Decimal;
//         LDiscount: Decimal;
//         amtInclTax: Decimal;
//         TotalGstAmt: Decimal;
//         UPrice: Decimal;
//         recUOM: Record 204;
//         Charges: Decimal;
//     begin
//         //IF IsTransShip = FALSE THEN BEGIN //Added for transfer
//         IF IsInvoice THEN BEGIN
//             SalesInvoiceLine.SETRANGE("Document No.", DocumentNo);
//             //SalesInvoiceLine.SETRANGE(Type,SalesInvoiceLine.Type::Item);
//             SalesInvoiceLine.SETFILTER(SalesInvoiceLine."No.", '<>%1', '');
//             SalesInvoiceLine.SETFILTER(SalesInvoiceLine.Quantity, '<>%1', 0);
//             SalesInvoiceLine.SETFILTER("No.", '<>%1&<>%2&<>%3&<>%4', '512040', '401004', '403012', '512073');

//             IF SalesInvoiceLine.FINDSET THEN BEGIN
//                 IF SalesInvoiceLine.COUNT > 100 THEN
//                     ERROR(SalesLinesErr, SalesInvoiceLine.COUNT);
//                 // JsonTextWriter.WritePropertyName('ItemList');//tk
//                 // JsonTextWriter.WriteStartArray;//tk
//                 REPEAT
//                     IF recSIH.GET(SalesInvoiceLine."Document No.") THEN  //added v1.03
//                         IF recCustPostGrp.GET(recSIH."Customer Posting Group") THEN //added v1.03
//                             IF recCustPostGrp."Invoice Rounding Account" <> SalesInvoiceLine."No." THEN BEGIN//added v1.03
//                                                                                                              //171220
//                                 AssAmt := SalesInvoiceLine."Line Amount";
//                                 AssAmt := ROUND(
//                                   CurrExchRate.ExchangeAmtFCYToLCY(
//                                   WORKDATE, SalesInvoiceHeader."Currency Code", AssAmt, SalesInvoiceHeader."Currency Factor"), 0.01, '='); //added 011020
//                                                                                                                                            //171220
//                                 IF SalesInvoiceLine."Free Supply" THEN
//                                     FreeQty := SalesInvoiceLine.Quantity
//                                 ELSE
//                                     FreeQty := 0;

//                                 GetGSTCompRate(SalesInvoiceLine."Document No.", SalesInvoiceLine."Line No.",
//                                   CgstRt, SgstRt, IgstRt, CesRt, CesNonAdval, StateCes);
//                                 SNo += 1;
//                                 IF recHsnSac.GET(SalesInvoiceLine."GST Group Code", SalesInvoiceLine."HSN/SAC Code") THEN
//                                     IF recHsnSac.Type = recHsnSac.Type::SAC THEN
//                                         IsServc := 'Y'
//                                     ELSE
//                                         IsServc := 'N';
//                                 LAmt := SalesInvoiceLine."Line Amount"; //added 011020
//                                 LAmt := ROUND(
//                                  CurrExchRate.ExchangeAmtFCYToLCY(
//                                  WORKDATE, SalesInvoiceHeader."Currency Code", LAmt, SalesInvoiceHeader."Currency Factor"), 0.01, '='); //added 011020
//                                 LDiscount := ROUND(
//                                  CurrExchRate.ExchangeAmtFCYToLCY(
//                                  WORKDATE, SalesInvoiceHeader."Currency Code", SalesInvoiceLine."Line Discount Amount", SalesInvoiceHeader."Currency Factor"), 0.01, '='); //added 011020
//                                 amtInclTax := ROUND(
//                                  CurrExchRate.ExchangeAmtFCYToLCY(
//                                  WORKDATE, SalesInvoiceHeader."Currency Code", SalesInvoiceLine."Amount Including Tax", SalesInvoiceHeader."Currency Factor"), 0.01, '='); //added 011020
//                                 TotalGstAmt := ROUND(
//                                  CurrExchRate.ExchangeAmtFCYToLCY(
//                                  WORKDATE, SalesInvoiceHeader."Currency Code", SalesInvoiceLine."Total GST Amount", SalesInvoiceHeader."Currency Factor"), 0.01, '='); //added 011020
//                                 Charges := ROUND(
//                                   CurrExchRate.ExchangeAmtFCYToLCY(
//                                   WORKDATE, SalesInvoiceHeader."Currency Code", SalesInvoiceLine."Charges To Customer" + SalesInvoiceLine."TDS/TCS Amount", SalesInvoiceHeader."Currency Factor"), 0.01, '=');
//                                 UPrice := ROUND(
//                                   CurrExchRate.ExchangeAmtFCYToLCY(
//                                   WORKDATE, SalesInvoiceHeader."Currency Code", SalesInvoiceLine."Unit Price", SalesInvoiceHeader."Currency Factor"), 0.01, '='); //added 011020
//                                 IF NOT recUOM.GET(SalesInvoiceLine."Unit of Measure Code")
//                                   THEN
//                                     recUOM.GET('NOS');
//                                 WriteItem(SNo, IsServc,
//                                   SalesInvoiceLine."No.", SalesInvoiceLine.Description + SalesInvoiceLine."Description 2",
//                                   SalesInvoiceLine."HSN/SAC Code", '',
//                                   SalesInvoiceLine.Quantity, FreeQty,
//                                   COPYSTR(SalesInvoiceLine."Unit of Measure Code", 1, 3),
//                                   UPrice,
//                                   LAmt + LDiscount,//added 011020
//                                   LDiscount, Charges,//added 011020
//                                   AssAmt, CgstRt, SgstRt, IgstRt, CesRt, CesNonAdval, StateCes,
//                                   AssAmt + TotalGstAmt + Charges,//added 011020
//                                   SalesInvoiceLine."Line No.");
//                             END ELSE//added v1.03
//                                 decRndOffAmt := ROUND(
//                                 CurrExchRate.ExchangeAmtFCYToLCY(
//                                 WORKDATE, SalesInvoiceHeader."Currency Code", SalesInvoiceLine."Line Amount", SalesInvoiceHeader."Currency Factor"), 0.01, '='); //added 011020
//                 UNTIL SalesInvoiceLine.NEXT = 0;
//                 JsonTextWriter.WriteEndArray;
//             END;
//         END ELSE BEGIN
//             SalesCrMemoLine.SETRANGE("Document No.", DocumentNo);
//             SalesCrMemoLine.SETFILTER(Type, '<>%1', SalesCrMemoLine.Type::" ");//KPPL 050920
//             SalesCrMemoLine.SETFILTER("No.", '<>%1&<>%2&<>%3&<>%4', '512040', '401004', '403012', '512073'); // Rohit Kppl
//             IF SalesCrMemoLine.FIND('-') THEN BEGIN
//                 IF SalesCrMemoLine.COUNT > 100 THEN
//                     ERROR(SalesLinesErr, SalesCrMemoLine.COUNT);
//                 JsonTextWriter.WritePropertyName('ItemList');
//                 JsonTextWriter.WriteStartArray;
//                 REPEAT
//                     IF recSCH.GET(SalesCrMemoLine."Document No.") THEN  //Credit memo amendments
//                         IF recCustPostGrp.GET(recSCH."Customer Posting Group") THEN //Credit memo amendments
//                             IF recCustPostGrp."Invoice Rounding Account" <> SalesCrMemoLine."No." THEN BEGIN//Credit memo amendments
//                                                                                                             //171220
//                                 AssAmt := SalesCrMemoLine."Line Amount";
//                                 AssAmt := ROUND(
//                                   CurrExchRate.ExchangeAmtFCYToLCY(
//                                   WORKDATE, SalesCrMemoHeader."Currency Code", AssAmt, SalesCrMemoHeader."Currency Factor"), 0.01, '=');
//                                 //171220
//                                 IF SalesCrMemoLine."Free Supply" THEN
//                                     FreeQty := SalesCrMemoLine.Quantity
//                                 ELSE
//                                     FreeQty := 0;
//                                 SNo += 1;
//                                 IF recHsnSac.GET(SalesCrMemoLine."GST Group Code", SalesCrMemoLine."HSN/SAC Code") THEN
//                                     IF recHsnSac.Type = recHsnSac.Type::SAC THEN
//                                         IsServc := 'Y'
//                                     ELSE
//                                         IsServc := 'N';
//                                 GetGSTCompRate(SalesCrMemoLine."Document No.", SalesCrMemoLine."Line No.",
//                                 CgstRt, SgstRt, IgstRt, CesRt, CesNonAdval, StateCes);
//                                 LAmt := SalesCrMemoLine."Line Amount"; //added 011020
//                                 LAmt := ROUND(
//                                  CurrExchRate.ExchangeAmtFCYToLCY(
//                                  WORKDATE, SalesCrMemoHeader."Currency Code", LAmt, SalesCrMemoHeader."Currency Factor"), 0.01, '='); //added 011020
//                                 LDiscount := ROUND(
//                                  CurrExchRate.ExchangeAmtFCYToLCY(
//                                  WORKDATE, SalesCrMemoHeader."Currency Code", SalesCrMemoLine."Line Discount Amount", SalesCrMemoHeader."Currency Factor"), 0.01, '='); //added 011020
//                                 amtInclTax := ROUND(
//                                  CurrExchRate.ExchangeAmtFCYToLCY(
//                                  WORKDATE, SalesCrMemoHeader."Currency Code", SalesCrMemoLine."Amount Including Tax", SalesCrMemoHeader."Currency Factor"), 0.01, '='); //added 011020
//                                 TotalGstAmt := ROUND(
//                                  CurrExchRate.ExchangeAmtFCYToLCY(
//                                  WORKDATE, SalesCrMemoHeader."Currency Code", SalesCrMemoLine."Total GST Amount", SalesCrMemoHeader."Currency Factor"), 0.01, '='); //added 011020
//                                 UPrice := ROUND(
//                                  CurrExchRate.ExchangeAmtFCYToLCY(
//                                  WORKDATE, SalesCrMemoHeader."Currency Code", SalesCrMemoLine."Unit Price", SalesCrMemoHeader."Currency Factor"), 0.01, '='); //added 011020
//                                 IF NOT recUOM.GET(SalesCrMemoLine."Unit of Measure Code")
//                                   THEN
//                                     recUOM.GET('NOS');
//                                 WriteItem(SNo, IsServc, SalesCrMemoLine."No.",
//                                  SalesCrMemoLine.Description + SalesCrMemoLine."Description 2",
//                                  SalesCrMemoLine."HSN/SAC Code", '',
//                                  SalesCrMemoLine.Quantity, FreeQty,
//                                  COPYSTR(SalesCrMemoLine."Unit of Measure Code", 1, 3),
//                                  UPrice,
//                                  LAmt + LDiscount,
//                                  LDiscount, 0,
//                                  AssAmt, CgstRt, SgstRt, IgstRt, CesRt, CesNonAdval, StateCes,
//                                  AssAmt + TotalGstAmt,
//                                  SalesCrMemoLine."Line No.");
//                             END ELSE
//                                 decRndOffAmt := ROUND(
//                                   CurrExchRate.ExchangeAmtFCYToLCY(
//                                   WORKDATE, SalesCrMemoHeader."Currency Code", SalesCrMemoLine."Line Amount", SalesCrMemoHeader."Currency Factor"), 0.01, '='); //added 011020
//                 UNTIL SalesCrMemoLine.NEXT = 0;
//                 JsonTextWriter.WriteEndArray;
//             END;
//         END;
//         //END; //Added for transfer

//         /*
//         IF IsTransShip = TRUE THEN BEGIN //Added for transfer
//           TransferShipLine.SETRANGE("Document No.",DocumentNo);
//           IF TransferShipLine.FINDSET THEN BEGIN
//             IF TransferShipLine.COUNT > 100 THEN
//               ERROR(SalesLinesErr,TransferShipLine.COUNT);
//             JsonTextWriter.WritePropertyName('ItemList');
//             JsonTextWriter.WriteStartArray;
//             REPEAT
//             // IF recSIH.GET(SalesInvoiceLine."Document No.") THEN  //added v1.03
//              //IF recCustPostGrp.GET(."Customer Posting Group") THEN //added v1.03
//             // IF recCustPostGrp."Invoice Rounding Account" <> SalesInvoiceLine."No." THEN BEGIN//added v1.03
//               IF TransferShipLine."GST Assessable Value"<> 0 THEN
//                 AssAmt := TransferShipLine."GST Assessable Value"
//               ELSE
//                 AssAmt := TransferShipLine."GST Base Amount";
//                FreeQty := 0;
//                GetGSTCompRate(TransferShipLine."Document No.",TransferShipLine."Line No.",
//                CgstRt,SgstRt,IgstRt,CesRt,CesNonAdval,StateCes);
//                SNo += 1;
//                IF recHsnSac.GET(TransferShipLine."GST Group Code",TransferShipLine."HSN/SAC Code") THEN
//                 IF recHsnSac.Type = recHsnSac.Type :: SAC THEN
//                  IsServc :='Y'
//                 ELSE
//                  IsServc := 'N';
//                WriteItem(SNo,IsServc,
//                 TransferShipLine.Description + TransferShipLine."Description 2",'',
//                 TransferShipLine."HSN/SAC Code",'',
//                 TransferShipLine.Quantity,FreeQty,
//                 COPYSTR(TransferShipLine."Unit of Measure Code",1,3),
//                 TransferShipLine."Unit Price",
//                 TransferShipLine.Amount,
//                 0,0,
//                 AssAmt,CgstRt,SgstRt,IgstRt,CesRt,CesNonAdval,StateCes,
//                 TransferShipLine.Amount+TransferShipLine."Total GST Amount",
//                 TransferShipLine."Line No.");
//            //END ELSE//added v1.03
//              // decRndOffAmt :=TransferShipLine.Amount; //added v1.03
//             UNTIL TransferShipLine.NEXT = 0;
//             JsonTextWriter.WriteEndArray;
//             //JsonTextWriter.WriteEndObject;
//           END;
//         END
//         */

//     end;

//     local procedure WriteItem(SNo: Integer; IsServ: Text; PrdNm: Text[100]; PrdDesc: Text[100]; HsnCd: Text[8]; Barcde: Text[30]; Qty: Decimal; FreeQty: Decimal; Unit: Text[3]; UnitPrice: Decimal; TotAmt: Decimal; Discount: Decimal; OthChrg: Decimal; AssAmt: Decimal; CgstRt: Decimal; SgstRt: Decimal; IgstRt: Decimal; CesRt: Decimal; CesNonAdval: Decimal; StateCes: Decimal; TotItemVal: Decimal; SILineNo: Integer)
//     var
//         ValueEntry: Record "5802";
//         ItemLedgerEntry: Record "32";
//         ValueEntryRelation: Record "6508";
//         ItemTrackingManagement: Codeunit "6500";
//         InvoiceRowID: Text[250];
//         recHsnSac: Record "16411";
//         "//180820 added": Integer;
//         AssVal: Decimal;
//         CgstVal: Decimal;
//         SgstVal: Decimal;
//         IgstVal: Decimal;
//         CesVal: Decimal;
//         StCesVal: Decimal;
//         CesNonAdval1: Decimal;
//         Disc: Decimal;
//         OthChrg1: Decimal;
//         TotInvVal: Decimal;
//     begin
//         // JsonTextWriter.WriteStartObject;//tk++
//         // JsonTextWriter.WritePropertyName('SlNo');
//         // JsonTextWriter.WriteValue(FORMAT(SNo));
//         // JsonTextWriter.WritePropertyName('IsServc');
//         // IF IsServ <> '' THEN
//         //     JsonTextWriter.WriteValue(IsServ)
//         // ELSE
//         //     JsonTextWriter.WriteValue(GlobalNULL);
//         // JsonTextWriter.WritePropertyName('PrdNm');
//         // IF PrdNm <> '' THEN
//         //     JsonTextWriter.WriteValue(PrdNm)
//         // ELSE
//         //     JsonTextWriter.WriteValue(GlobalNULL);
//         // JsonTextWriter.WritePropertyName('PrdDesc');
//         // IF PrdDesc <> '' THEN
//         //     JsonTextWriter.WriteValue(PrdDesc)
//         // ELSE
//         //     JsonTextWriter.WriteValue(GlobalNULL);
//         // JsonTextWriter.WritePropertyName('HsnCd');
//         // IF HsnCd <> '' THEN
//         //     JsonTextWriter.WriteValue(HsnCd)
//         // ELSE
//         //     JsonTextWriter.WriteValue(GlobalNULL);
//         // JsonTextWriter.WritePropertyName('Barcde');
//         // IF Barcde <> '' THEN
//         //     JsonTextWriter.WriteValue(Barcde)
//         // ELSE
//         //     JsonTextWriter.WriteValue(GlobalNULL);
//         // JsonTextWriter.WritePropertyName('Qty');
//         // JsonTextWriter.WriteValue(Qty);
//         // JsonTextWriter.WritePropertyName('FreeQty');
//         // JsonTextWriter.WriteValue(FreeQty);

//         // JsonTextWriter.WritePropertyName('Unit');
//         // IF Unit <> '' THEN
//         //     JsonTextWriter.WriteValue(Unit)
//         // ELSE
//         //     JsonTextWriter.WriteValue('NOS');
//         // //JsonTextWriter.WriteValue(GlobalNULL);
//         // JsonTextWriter.WritePropertyName('UnitPrice');
//         // JsonTextWriter.WriteValue(UnitPrice);
//         // JsonTextWriter.WritePropertyName('TotAmt');
//         // JsonTextWriter.WriteValue(TotAmt);
//         // JsonTextWriter.WritePropertyName('Discount');
//         // JsonTextWriter.WriteValue(Discount);

//         // JsonTextWriter.WritePropertyName('GstRt');
//         // IF IgstRt <> 0 THEN
//         //     JsonTextWriter.WriteValue(IgstRt)
//         // ELSE
//         //     JsonTextWriter.WriteValue(CgstRt + SgstRt);

//         // JsonTextWriter.WritePropertyName('CgstRt');
//         // JsonTextWriter.WriteValue(CgstRt);
//         // JsonTextWriter.WritePropertyName('SgstRt');
//         // JsonTextWriter.WriteValue(SgstRt);
//         // JsonTextWriter.WritePropertyName('IgstRt');
//         // JsonTextWriter.WriteValue(IgstRt);
//         // JsonTextWriter.WritePropertyName('CesRt');
//         // JsonTextWriter.WriteValue(CesRt);
//         // JsonTextWriter.WritePropertyName('CesNonAdval');
//         // JsonTextWriter.WriteValue(CesNonAdval);
//         // JsonTextWriter.WritePropertyName('StateCes');
//         // JsonTextWriter.WriteValue(StateCes);
//         // ///OthChrg := 0;//added
//         // JsonTextWriter.WritePropertyName('OthChrg');
//         // JsonTextWriter.WriteValue(OthChrg);
//         // GetGSTValItem(AssVal, CgstVal, SgstVal, IgstVal, SILineNo);

//         // IF AssVal <> 0 THEN
//         //     AssAmt := ABS(AssVal);

//         // JsonTextWriter.WritePropertyName('AssAmt');
//         // JsonTextWriter.WriteValue(ABS(AssAmt));
//         // JsonTextWriter.WritePropertyName('IgstAmt');
//         // JsonTextWriter.WriteValue(IgstVal);
//         // JsonTextWriter.WritePropertyName('CgstAmt');
//         // JsonTextWriter.WriteValue(CgstVal);
//         // JsonTextWriter.WritePropertyName('SgstAmt');
//         // JsonTextWriter.WriteValue(SgstVal);
//         // JsonTextWriter.WritePropertyName('TotItemVal');
//         // JsonTextWriter.WriteValue(ABS(AssAmt) + IgstVal + CgstVal + SgstVal + OthChrg);//tk--
//         //Added 171220
//         IF IsInvoice THEN
//             InvoiceRowID := ItemTrackingManagement.ComposeRowID(DATABASE::"Sales Invoice Line", 0, DocumentNo, '', 0, SILineNo)
//         ELSE
//             InvoiceRowID := ItemTrackingManagement.ComposeRowID(DATABASE::"Sales Cr.Memo Line", 0, DocumentNo, '', 0, SILineNo);

//         // JsonTextWriter.WriteEndObject;//tk
//     end;

//     local procedure WriteBchDtls(Nm: Text[20]; ExpDt: Text[10]; WrDt: Text[10])
//     begin
//         // JsonTextWriter.WritePropertyName('Nm');//tk
//         // IF Nm <> '' THEN
//         //     JsonTextWriter.WriteValue(Nm)
//         // ELSE
//         //     JsonTextWriter.WriteValue(GlobalNULL);
//         // JsonTextWriter.WritePropertyName('ExpDt');
//         // IF ExpDt <> '' THEN
//         //     JsonTextWriter.WriteValue(ExpDt)
//         // ELSE
//         //     JsonTextWriter.WriteValue(GlobalNULL);
//         // JsonTextWriter.WritePropertyName('WrDt');
//         // IF WrDt <> '' THEN
//         //     JsonTextWriter.WriteValue(WrDt)
//         // ELSE
//         //     JsonTextWriter.WriteValue(GlobalNULL);//tk
//     end;

//     local procedure ExportAsJson(FileName: Text[20])
//     var
//         TempFile: File;
//         ToFile: Variant;
//         NewStream: InStream;
//     begin
//         TempFile.CREATETEMPFILE;
//         TempFile.WRITE(StringBuilder.ToString);
//         TempFile.CREATEINSTREAM(NewStream);
//         ToFile := FileName + '.json';
//         DOWNLOADFROMSTREAM(NewStream, 'e-Invoice', '', 'JSON files|*.json|All files (*.*)|*.*', ToFile);
//         TempFile.CLOSE;
//     end;


//     procedure SetSalesInvHeader(SalesInvoiceHeaderBuff: Record "112")
//     begin
//         SalesInvoiceHeader := SalesInvoiceHeaderBuff;
//         IsInvoice := TRUE;
//     end;


//     procedure SetCrMemoHeader(SalesCrMemoHeaderBuff: Record "114")
//     begin
//         SalesCrMemoHeader := SalesCrMemoHeaderBuff;
//         IsInvoice := FALSE;
//     end;

//     local procedure GetGSTCompRate(DocNo: Code[20]; LineNo: Integer; var CgstRt: Decimal; var SgstRt: Decimal; var IgstRt: Decimal; var CesRt: Decimal; var CesNonAdval: Decimal; var StateCes: Decimal)
//     var
//         DetailedGSTLedgerEntry: Record "16419";
//         GSTComponent: Record "16405";
//     begin
//         DetailedGSTLedgerEntry.SETRANGE("Document No.", DocNo);
//         DetailedGSTLedgerEntry.SETRANGE("Document Line No.", LineNo);

//         DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'CGST');
//         IF DetailedGSTLedgerEntry.FINDFIRST THEN
//             CgstRt := DetailedGSTLedgerEntry."GST %"
//         ELSE
//             CgstRt := 0;

//         DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'SGST');
//         IF DetailedGSTLedgerEntry.FINDFIRST THEN
//             SgstRt := DetailedGSTLedgerEntry."GST %"
//         ELSE
//             SgstRt := 0;

//         DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'IGST');
//         IF DetailedGSTLedgerEntry.FINDFIRST THEN
//             IgstRt := DetailedGSTLedgerEntry."GST %"
//         ELSE
//             IgstRt := 0;

//         CesRt := 0;
//         CesNonAdval := 0;
//         DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'CESS');
//         IF DetailedGSTLedgerEntry.FINDFIRST THEN
//             IF DetailedGSTLedgerEntry."GST %" > 0 THEN
//                 CesRt := DetailedGSTLedgerEntry."GST %"
//             ELSE
//                 CesNonAdval := ABS(DetailedGSTLedgerEntry."GST Amount");

//         DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'INTERCESS');
//         IF DetailedGSTLedgerEntry.FINDFIRST THEN
//             CesRt := DetailedGSTLedgerEntry."GST %";

//         StateCes := 0;
//         DetailedGSTLedgerEntry.SETRANGE("GST Component Code");
//         IF DetailedGSTLedgerEntry.FINDSET THEN
//             REPEAT
//                 IF NOT (DetailedGSTLedgerEntry."GST Component Code" IN ['CGST', 'SGST', 'IGST', 'CESS', 'INTERCESS'])
//                 THEN
//                     IF GSTComponent.GET(DetailedGSTLedgerEntry."GST Component Code") THEN
//                         // IF GSTComponent."Exclude from Reports" THEN
//                         StateCes := DetailedGSTLedgerEntry."GST %";
//             UNTIL DetailedGSTLedgerEntry.NEXT = 0;
//     end;

//     local procedure GetGSTVal(var AssVal: Decimal; var CgstVal: Decimal; var SgstVal: Decimal; var IgstVal: Decimal; var CesVal: Decimal; var StCesVal: Decimal; var CesNonAdval: Decimal; var Disc: Decimal; var OthChrg: Decimal; var TotInvVal: Decimal)
//     var
//         SalesInvoiceLine: Record "113";
//         SalesCrMemoLine: Record "115";
//         GSTLedgerEntry: Record "16418";
//         DetailedGSTLedgerEntry: Record "16419";
//         CurrExchRate: Record "330";
//         CustLedgerEntry: Record "21";
//         GSTComponent: Record "16405";
//         TotGSTAmt: Decimal;
//         TranShipLine: Record "5745";
//     begin
//         GSTLedgerEntry.SETRANGE("Document No.", DocumentNo);

//         GSTLedgerEntry.SETRANGE("GST Component Code", 'CGST');
//         IF GSTLedgerEntry.FINDSET THEN BEGIN
//             REPEAT
//                 CgstVal += ABS(GSTLedgerEntry."GST Amount");
//             UNTIL GSTLedgerEntry.NEXT = 0;
//         END ELSE
//             CgstVal := 0;

//         GSTLedgerEntry.SETRANGE("GST Component Code", 'SGST');
//         IF GSTLedgerEntry.FINDSET THEN BEGIN
//             REPEAT
//                 SgstVal += ABS(GSTLedgerEntry."GST Amount")
//             UNTIL GSTLedgerEntry.NEXT = 0;
//         END ELSE
//             SgstVal := 0;

//         GSTLedgerEntry.SETRANGE("GST Component Code", 'IGST');
//         IF GSTLedgerEntry.FINDSET THEN BEGIN
//             REPEAT
//                 IgstVal += ABS(GSTLedgerEntry."GST Amount")
//             UNTIL GSTLedgerEntry.NEXT = 0;
//         END ELSE
//             IgstVal := 0;

//         CesVal := 0;
//         CesNonAdval := 0;
//         OthChrg := 0; //added TCS 011020

//         GSTLedgerEntry.SETRANGE("GST Component Code", 'INTERCESS');
//         IF GSTLedgerEntry.FINDSET THEN
//             REPEAT
//                 CesVal += ABS(GSTLedgerEntry."GST Amount")
//             UNTIL GSTLedgerEntry.NEXT = 0;

//         DetailedGSTLedgerEntry.SETRANGE("Document No.", DocumentNo);
//         DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'CESS');
//         IF DetailedGSTLedgerEntry.FINDFIRST THEN
//             REPEAT
//                 IF DetailedGSTLedgerEntry."GST %" > 0 THEN
//                     CesVal += ABS(DetailedGSTLedgerEntry."GST Amount")
//                 ELSE
//                     CesNonAdval += ABS(DetailedGSTLedgerEntry."GST Amount");
//             UNTIL GSTLedgerEntry.NEXT = 0;

//         GSTLedgerEntry.SETFILTER("GST Component Code", '<>CGST|<>SGST|<>IGST|<>CESS|<>INTERCESS');
//         IF GSTLedgerEntry.FINDSET THEN BEGIN
//             REPEAT
//                 IF GSTComponent.GET(GSTLedgerEntry."GST Component Code") THEN
//                     //IF GSTComponent."Exclude from Reports" THEN
//                     StCesVal += ABS(GSTLedgerEntry."GST Amount");
//             UNTIL GSTLedgerEntry.NEXT = 0;
//         END;
//         StCesVal := 0;
//         //IF IsTransShip =FALSE THEN BEGIN //Added for transfer
//         IF IsInvoice THEN BEGIN
//             SalesInvoiceLine.SETRANGE("Document No.", DocumentNo);
//             IF SalesInvoiceLine.FINDSET THEN BEGIN
//                 REPEAT
//                     AssVal += SalesInvoiceLine.Amount;
//                     TotGSTAmt += SalesInvoiceLine."Total GST Amount";
//                     OthChrg += SalesInvoiceLine."TDS/TCS Amount" + SalesInvoiceLine."Charges To Customer"; //added TCS 011020
//                     Disc += SalesInvoiceLine."Inv. Discount Amount";
//                 UNTIL SalesInvoiceLine.NEXT = 0;
//             END;

//             AssVal := ROUND(
//                 CurrExchRate.ExchangeAmtFCYToLCY(
//                   WORKDATE, SalesInvoiceHeader."Currency Code", AssVal, SalesInvoiceHeader."Currency Factor"), 0.01, '=');
//             TotGSTAmt := ROUND(
//                 CurrExchRate.ExchangeAmtFCYToLCY(
//                   WORKDATE, SalesInvoiceHeader."Currency Code", TotGSTAmt, SalesInvoiceHeader."Currency Factor"), 0.01, '=');
//             Disc := ROUND(
//                 CurrExchRate.ExchangeAmtFCYToLCY(
//                   WORKDATE, SalesInvoiceHeader."Currency Code", Disc, SalesInvoiceHeader."Currency Factor"), 0.01, '=');
//             OthChrg := ROUND(
//           CurrExchRate.ExchangeAmtFCYToLCY(
//             WORKDATE, SalesInvoiceHeader."Currency Code", OthChrg, SalesInvoiceHeader."Currency Factor"), 0.01, '=');
//             //Added 011020
//             /*
//              CgstVal := ROUND(
//                    CurrExchRate.ExchangeAmtFCYToLCY(
//                      WORKDATE,SalesInvoiceHeader."Currency Code",CgstVal,SalesInvoiceHeader."Currency Factor"),0.01,'=');

//              SgstVal :=ROUND(
//                    CurrExchRate.ExchangeAmtFCYToLCY(
//                      WORKDATE,SalesInvoiceHeader."Currency Code",SgstVal,SalesInvoiceHeader."Currency Factor"),0.01,'=');

//              IgstVal :=ROUND(
//                    CurrExchRate.ExchangeAmtFCYToLCY(
//                      WORKDATE,SalesInvoiceHeader."Currency Code",IgstVal,SalesInvoiceHeader."Currency Factor"),0.01,'=');
//                      */
//             //Added 011020
//         END ELSE BEGIN
//             SalesCrMemoLine.SETRANGE("Document No.", DocumentNo);
//             SalesCrMemoLine.SETFILTER(Type, '<>%1', SalesCrMemoLine.Type::" ");//KPPL 050920
//             IF SalesCrMemoLine.FINDSET THEN BEGIN
//                 REPEAT
//                     AssVal += SalesCrMemoLine.Amount;
//                     TotGSTAmt += SalesCrMemoLine."Total GST Amount";
//                     OthChrg += SalesCrMemoLine."TDS/TCS Amount" + SalesCrMemoLine."Charges To Customer"; //added TCS 011020
//                     Disc += SalesCrMemoLine."Inv. Discount Amount";
//                 UNTIL SalesCrMemoLine.NEXT = 0;
//             END;

//             AssVal := ROUND(
//                 CurrExchRate.ExchangeAmtFCYToLCY(
//                   WORKDATE, SalesCrMemoHeader."Currency Code", AssVal, SalesCrMemoHeader."Currency Factor"), 0.01, '=');
//             TotGSTAmt := ROUND(
//                 CurrExchRate.ExchangeAmtFCYToLCY(
//                   WORKDATE, SalesCrMemoHeader."Currency Code", TotGSTAmt, SalesCrMemoHeader."Currency Factor"), 0.01, '=');
//             Disc := ROUND(
//                 CurrExchRate.ExchangeAmtFCYToLCY(
//                   WORKDATE, SalesCrMemoHeader."Currency Code", Disc, SalesCrMemoHeader."Currency Factor"), 0.01, '=');
//             OthChrg := ROUND(
//           CurrExchRate.ExchangeAmtFCYToLCY(
//             WORKDATE, SalesCrMemoHeader."Currency Code", OthChrg, SalesCrMemoHeader."Currency Factor"), 0.01, '=');
//             //Added 011020
//             /*
//              CgstVal := ROUND(
//                    CurrExchRate.ExchangeAmtFCYToLCY(
//                      WORKDATE,SalesCrMemoHeader."Currency Code",CgstVal,SalesCrMemoHeader."Currency Factor"),0.01,'=');

//              SgstVal :=ROUND(
//                    CurrExchRate.ExchangeAmtFCYToLCY(
//                      WORKDATE,SalesCrMemoHeader."Currency Code",SgstVal,SalesCrMemoHeader."Currency Factor"),0.01,'=');

//              IgstVal :=ROUND(
//                    CurrExchRate.ExchangeAmtFCYToLCY(
//                      WORKDATE,SalesCrMemoHeader."Currency Code",IgstVal,SalesCrMemoHeader."Currency Factor"),0.01,'=');
//                      */
//             //Added 011020
//         END;

//         CustLedgerEntry.SETCURRENTKEY("Document No.");
//         CustLedgerEntry.SETRANGE("Document No.", DocumentNo);
//         IF IsInvoice THEN BEGIN
//             CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
//             CustLedgerEntry.SETRANGE("Customer No.", SalesInvoiceHeader."Bill-to Customer No.");
//         END ELSE BEGIN
//             CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::"Credit Memo");
//             CustLedgerEntry.SETRANGE("Customer No.", SalesCrMemoHeader."Bill-to Customer No.");
//         END;
//         IF CustLedgerEntry.FINDFIRST THEN BEGIN
//             CustLedgerEntry.CALCFIELDS("Amount (LCY)", Amount); //added 011020 amout
//             IF (CustLedgerEntry."Currency Code" <> '') AND (CustLedgerEntry.Amount <> CustLedgerEntry."Amount (LCY)") THEN //added 011020
//                 TotInvVal := ABS(CustLedgerEntry."Amount (LCY)") //+ ABS(TotGSTAmt)//added 011020
//             ELSE//added 011020
//                 TotInvVal := ABS(CustLedgerEntry."Amount (LCY)");
//         END;
//         //END; //Added for transfer

//         OthChrg := ROUND(OthChrg, 0.01, '=');
//         TotInvVal := ROUND(TotInvVal, 0.01, '=');

//     end;


//     procedure ReadGenerateIRN(DocType: Option Invoice,"Credit Memo",Transfer; "DocNo.": Code[20])
//     var
//         ApiResultGenerateIRN: Text;
//         JObject: DotNet JObject;
//         IRNNode: Text;
//         Result: Code[1];
//         recGSRegNos: Record "16400";
//         TokenResult: Text;
//         JObjectToken: DotNet JObject;
//         Token_ExpDateTime: DateTime;
//         EInvoice_asp: DotNet EInvoice_asp;
//         recEinvoice: Record "50004";
//     begin
//         IF recGSRegNos.GET(GSTRN) THEN;

//         IF (CURRENTDATETIME > recGSRegNos."Token Exp Date Time") OR (recGSRegNos."Token Exp Date Time" = 0DT) THEN BEGIN
//             GenerateToken(GSTRN);
//             ASPGenerateIRN(Token_No, "DocNo.", DocType);
//             COMMIT;
//             //AddedEway By IRN
//             UpdateEWayDtl(DocType, "DocNo.");
//             GenerateEwbDtl(Token_No, "DocNo.", DocType, GSTRN); //Added KPPL_EINV 1.1

//         END ELSE BEGIN
//             ASPGenerateIRN(recGSRegNos."Token No", "DocNo.", DocType);
//             COMMIT;
//             UpdateEWayDtl(DocType, "DocNo.");
//             GenerateEwbDtl(recGSRegNos."Token No", "DocNo.", DocType, GSTRN);//Added KPPL_EINV 1.1

//         END;
//     end;


//     procedure GenerateEntry(DocType: Option Invoice,"Credit Memo",Transfer; "DocNo.": Code[20]; txtIRNDtl: Text; txtSignedQRCode: Text; txtSignedinvoice: Text; Acknowledgment_No: Text; Acknowledgment_Date: Text)
//     var
//         recEInv: Record "50004";
//         [RunOnClient]
//         IBarCodeProvider: DotNet IBarcodeProvider;
//         QRCodeFileName: Text;
//         recEInv1: Record "50004";
//         inv: Record "112";
//         Crmemo: Record "114";
//     begin
//         IF DocType = 0 THEN BEGIN
//             IF inv.GET("DocNo.") THEN BEGIN
//                 // inv."IRN No.":= txtIRNDtl;
//                 inv."Acknowledgement No." := Acknowledgment_No;
//                 inv.MODIFY;
//             END;

//         END ELSE
//             IF DocType = 1 THEN BEGIN
//                 IF Crmemo.GET("DocNo.") THEN BEGIN
//                     // Crmemo."IRN Hash":= txtIRNDtl;
//                     Crmemo."Acknowledgement No." := Acknowledgment_No;
//                     Crmemo.MODIFY;
//                 END;

//             END;


//         IF NOT recEInv.GET(DocType, "DocNo.") THEN BEGIN
//             recEInv.INIT;
//             recEInv."Document Type" := DocType;
//             recEInv."Document No." := "DocNo.";
//             recEInv.IRN := txtIRNDtl;
//             recEInv.Acknowledgment_number := Acknowledgment_No;
//             recEInv."Acknowledgment Date" := Acknowledgment_Date;
//             recEInv."Creation DateTime" := CURRENTDATETIME;
//             //Added QR Signed Code
//             recEInv."QR Code Part1" := COPYSTR(txtSignedQRCode, 1, 250);
//             IF STRLEN(txtSignedQRCode) > 250 THEN
//                 recEInv."QR Code Part2" := COPYSTR(txtSignedQRCode, 251, 250)
//             ELSE
//                 recEInv."QR Code Part2" := '';
//             IF STRLEN(txtSignedQRCode) > 500 THEN
//                 recEInv."QR Code Part3" := COPYSTR(txtSignedQRCode, 501, 250)
//             ELSE
//                 recEInv."QR Code Part3" := '';

//             IF STRLEN(txtSignedQRCode) > 750 THEN
//                 recEInv."QR Code Part4" := COPYSTR(txtSignedQRCode, 751, 250)
//             ELSE
//                 recEInv."QR Code Part4" := '';

//             recEInv.INSERT;
//             COMMIT;
//         END ELSE BEGIN
//             //recEInv.INIT;
//             recEInv.RESET;
//             recEInv.SETRANGE("Document Type", DocType);
//             recEInv.SETRANGE("Document No.", "DocNo.");
//             IF recEInv.FIND('-') THEN BEGIN
//                 recEInv."Document Type" := DocType;
//                 recEInv."Document No." := "DocNo.";
//                 recEInv.IRN := txtIRNDtl;
//                 recEInv.Acknowledgment_number := Acknowledgment_No;
//                 recEInv."Acknowledgment Date" := Acknowledgment_Date;
//                 recEInv."Creation DateTime" := CURRENTDATETIME;
//                 //Added QR Signed Code
//                 recEInv."QR Code Part1" := COPYSTR(txtSignedQRCode, 1, 250);
//                 IF STRLEN(txtSignedQRCode) > 250 THEN
//                     recEInv."QR Code Part2" := COPYSTR(txtSignedQRCode, 251, 250)
//                 ELSE
//                     recEInv."QR Code Part2" := '';
//                 IF STRLEN(txtSignedQRCode) > 500 THEN
//                     recEInv."QR Code Part3" := COPYSTR(txtSignedQRCode, 501, 250)
//                 ELSE
//                     recEInv."QR Code Part3" := '';

//                 IF STRLEN(txtSignedQRCode) > 750 THEN
//                     recEInv."QR Code Part4" := COPYSTR(txtSignedQRCode, 751, 250)
//                 ELSE
//                     recEInv."QR Code Part4" := '';

//                 recEInv.MODIFY;
//                 COMMIT;
//             END;
//         END;
//         //Added QR Signed Code
//         IF recEInv1.GET(recEInv."Document Type", recEInv."Document No.") THEN BEGIN
//             QRCodeFileName := GetQRCode(txtSignedQRCode);//GetQRCode(CodeForImage);//GetQRCode('123AVC');
//             QRCodeFileName := MoveToPath(QRCodeFileName);

//             CLEAR(TempBlob);
//             FileMagmet.BLOBImport(TempBlob, QRCodeFileName);
//             IF TempBlob.Blob.HASVALUE THEN BEGIN
//                 recEInv1."QR Code" := TempBlob.Blob;
//             END;
//             IF NOT ISSERVICETIER THEN
//                 IF EXISTS(QRCodeFileName) THEN
//                     ERASE(QRCodeFileName);

//             recEInv1.MODIFY;
//         END;
//     end;


//     procedure GerateQR(CodeForImage: Text)
//     begin
//     end;


//     procedure CreatQRCodeIput()
//     begin
//     end;


//     procedure GetQRCode(QRCode: Text) QRCodeFileName: Text[1024]
//     begin

//         GetBarCodeProvider(IBarCodeProvider);
//         QRCodeFileName := IBarCodeProvider.GetBarcode(QRCode);
//     end;


//     procedure GetBarCodeProvider(var IBarCodeProvider: DotNet IBarcodeProvider)
//     var
//         [RunOnClient]
//         QRCodeProvider: DotNet QRCodeProvider;
//     begin

//         QRCodeProvider := QRCodeProvider.QRCodeProvider;
//         IBarCodeProvider := QRCodeProvider;
//     end;


//     procedure MoveToPath(SourceFile: Text) DestFile: Text[1024]
//     var
//         FileSysObj: Automation;
//     begin
//         DestFile := FileMagmet.ClientTempFileName('');
//         IF ISCLEAR(FileSysObj) THEN
//             CREATE(FileSysObj, TRUE, TRUE);
//         FileSysObj.MoveFile(SourceFile, DestFile);
//     end;


//     procedure GenerateResponseEntry(DocType: Option Invoice,"Credit Memo"; "DocNo.": Code[20]; txtResponse: Text)
//     var
//         recReponseEntry: Record "50005";
//         EntryNo: Integer;
//     begin
//         //update on client
//         //recReponseEntry.INIT;

//         recReponseEntry.RESET;
//         IF recReponseEntry.FINDLAST THEN
//             EntryNo := recReponseEntry."Entry No." + 1
//         ELSE
//             EntryNo := 1;

//         recReponseEntry.INIT;
//         recReponseEntry."Entry No." := EntryNo;
//         recReponseEntry."Document Type" := DocType;
//         recReponseEntry."Document No." := "DocNo.";
//         recReponseEntry."Creation DateTime" := CURRENTDATETIME;

//         recReponseEntry.Message := COPYSTR(txtResponse, 1, 250);
//         IF STRLEN(txtResponse) > 250 THEN
//             recReponseEntry.Message1 := COPYSTR(txtResponse, 251, 250)
//         ELSE
//             recReponseEntry.Message1 := '';
//         IF STRLEN(txtResponse) > 500 THEN
//             recReponseEntry.Message2 := COPYSTR(txtResponse, 501, 250)
//         ELSE
//             recReponseEntry.Message2 := '';

//         IF STRLEN(txtResponse) > 750 THEN
//             recReponseEntry.Message3 := COPYSTR(txtResponse, 751, 250)
//         ELSE
//             recReponseEntry.Message3 := '';

//         //recReponseEntry."Entry Type" := recReponseEntry."Entry Type"::Einvoice;

//         recReponseEntry.INSERT;
//         COMMIT;
//     end;


//     procedure CancelIRN(OrignalInv: Text; DocumentNo: Code[20]; CancelReson: Option " ",Duplicate,"Data Entry Mistake"; CancelRemarks: Text; GST: Code[20]; OptDocType: Option Invoice,"Credit Memo",Transfer,"Transfer Cancel")
//     var
//         CancelResult: Text;
//         JObject: DotNet JObject;
//         IrnJSON: Text;
//         Result: Code[1];
//         txtIRN: Text;
//         Canceldt: DateTime;
//         recGSRegNos: Record "16400";
//         txtCancelDT: Text;
//         EInvoice_asp: DotNet EInvoice_asp;
//         recEInvoice: Record "50004";
//         OptCanceDocType: Option Invoice,"Credit Memo",Transfer,"Transfer Cancel";
//     begin

//         IF recGSRegNos.GET(GST) THEN;

//         IF recEInvoice.GET(OptDocType, OrignalInv) THEN BEGIN
//             IF OptDocType = OptDocType::Invoice THEN
//                 OptCanceDocType := OptCanceDocType::"Credit Memo";
//             IF OptDocType = OptDocType::Transfer THEN
//                 OptCanceDocType := OptCanceDocType::"Transfer Cancel";



//             WriteCancelIRN(OrignalInv, DocumentNo, CancelReson, CancelRemarks, recEInvoice.IRN);
//             EInvoice_asp := EInvoice_asp.EInvoice_asp();
//             CancelResult := EInvoice_asp.Cancel_eInvoice(StringBuilder.ToString, GST, recGSRegNos."Token No", recGSRegNos."User Name");

//             JObject := JObject.Parse(CancelResult);

//             IF JObject.HasValues THEN BEGIN
//                 Result := (JObject.SelectToken('Status').ToString);
//                 // IF NOT ISNULL(JObject.SelectToken('irn_generation_response')) THEN BEGIN
//                 IF Result = '1' THEN BEGIN
//                     JObject := JObject.Parse(JObject.SelectToken('Data').ToString);
//                     txtIRN := JObject.SelectToken('Irn').ToString;
//                     txtCancelDT := JObject.SelectToken('CancelDate').ToString;
//                     GenerateCancelEntry(DocumentNo, txtIRN, CURRENTDATETIME, CancelReson, CancelRemarks, OptCanceDocType);
//                     MESSAGE('E-Invoice cancel Sucessfully for Doc No. %1', DocumentNo);
//                 END ELSE BEGIN
//                     GenerateResponseEntry(docType::"Credit Memo", DocumentNo, CancelResult);
//                     MESSAGE('E-Invoice Generartion returned Error!!!');
//                 END;
//             END;
//         END;
//     end;


//     procedure WriteCancelIRN(OrignalInv: Text; DocumentNo: Code[20]; CancelReson: Option " ",Duplicate,"Data Entry Mistake"; CancelRemarks: Text; IRN: Text)
//     var
//         txtCancelReson: Text;
//     begin
//         //IF ISNULL(StringBuilder) THEN
//         Initialize;

//         JsonTextWriter.WriteStartObject;
//         JsonTextWriter.WritePropertyName('Irn');
//         JsonTextWriter.WriteValue(IRN);
//         JsonTextWriter.WritePropertyName('CnlRsn');
//         IF CancelReson = CancelReson::Duplicate THEN
//             txtCancelReson := '1';
//         IF CancelReson = CancelReson::"Data Entry Mistake" THEN
//             txtCancelReson := '2';
//         JsonTextWriter.WriteValue(txtCancelReson);
//         JsonTextWriter.WritePropertyName('CnlRem');
//         JsonTextWriter.WriteValue(CancelRemarks);
//         JsonTextWriter.WriteEndObject;
//         JsonTextWriter.Flush;
//         /*
//       IF DocumentNo <> '' THEN
//         ExportAsJson(DocumentNo)
//       ELSE
//         ERROR(RecIsEmptyErr);
//       */

//     end;


//     procedure GenerateCancelEntry("DocNo.": Code[20]; txtIRNDtl: Text; CancelDtTime: DateTime; CancelReson: Option " ",Duplicate,"Data Entry Mistake"; CancelRemarks: Text; OptCanceDocTypeVlu: Option Invoice,"Credit Memo",Transfer,"Transfer Cancel")
//     var
//         recEInv: Record "50004";
//         [RunOnClient]
//         IBarCodeProvider: DotNet IBarcodeProvider;
//         QRCodeFileName: Text;
//         recEInv1: Record "50004";
//     begin
//         //recEInv.INIT;
//         recEInv."Document Type" := OptCanceDocTypeVlu;
//         ;
//         recEInv."Document No." := "DocNo.";
//         recEInv.IRN := txtIRNDtl;
//         recEInv."Cancel DateTime" := CancelDtTime;
//         recEInv."Cancel Reason" := CancelReson;
//         recEInv."Cancel Remarks" := CancelRemarks;
//         recEInv.INSERT;

//         //Added 221220
//         recEInv1.RESET;
//         recEInv1.SETRANGE(recEInv1.IRN, txtIRNDtl);
//         IF recEInv1.FIND('-') THEN BEGIN
//             recEInv1."Cancel DateTime" := CancelDtTime;
//             recEInv1."Cancel Reason" := CancelReson;
//             recEInv1."Cancel Remarks" := CancelRemarks;
//             recEInv1.MODIFY;
//         END;
//         //Added 221220
//     end;


//     procedure UpdateToken(Token: Text; TokenExpDtTime: DateTime; GST: Text)
//     var
//         recGSTReg: Record "16400";
//     begin
//         IF recGSTReg.GET(GST) THEN BEGIN
//             recGSTReg."Token No" := Token;
//             recGSTReg."Token Exp Date Time" := TokenExpDtTime;
//             recGSTReg."Generated DateTime" := CURRENTDATETIME;
//             recGSTReg.MODIFY;
//         END;
//     end;


//     procedure ASPGenerateIRN(Token: Text; DocNo: Code[20]; DocType: Option Invoice,"Credit Memo",Transfer)
//     var
//         EInvoice_asp: DotNet EInvoice_asp;
//         Asp_ResultGenerateIRN: Text;
//         JObjectIRN: DotNet JObject;
//         Result: Text;
//         txtIRN: Text;
//         txtSigned_QRCode: Text;
//         txtSigned_invoice: Text;
//         Acknowledgment_number: Text;
//         Acknowledgment_Date: Text;
//         RecRef: RecordRef;
//         FieldRef: FieldRef;
//     begin

//         EInvoice_asp := EInvoice_asp.EInvoice_asp();

//         //  Asp_ResultGenerateIRN := EInvoice_asp.GenerateIRN(StringBuilder.ToString,GSTRN,Token);
//         IF IsGetEntry = TRUE THEN BEGIN
//             GstReg.GET(GetEntryGST);
//             Asp_ResultGenerateIRN := EInvoice_asp.Get_eInvoice(GetEntryIRN, GetEntryGST, Token, GstReg."User Name")//Added GetEinvoice 120121

//         END ELSE BEGIN
//             GstReg.GET(GSTRN);
//             Asp_ResultGenerateIRN := EInvoice_asp.GenerateIRN(StringBuilder.ToString, GSTRN, Token, GstReg."User Name");
//         END;
//         // MESSAGE(StringBuilder.ToString);
//         JObjectIRN := JObjectIRN.Parse(Asp_ResultGenerateIRN);
//         IF JObjectIRN.HasValues THEN BEGIN
//             Result := (JObjectIRN.SelectToken('Status').ToString);
//             IF Result = '1' THEN BEGIN
//                 JObjectIRN := JObjectIRN.Parse(JObjectIRN.SelectToken('Data').ToString);
//                 txtIRN := JObjectIRN.SelectToken('Irn').ToString;
//                 txtSigned_QRCode := JObjectIRN.SelectToken('SignedQRCode').ToString;
//                 txtSigned_invoice := JObjectIRN.SelectToken('SignedInvoice').ToString;
//                 Acknowledgment_number := JObjectIRN.SelectToken('AckNo').ToString;
//                 Acknowledgment_Date := JObjectIRN.SelectToken('AckDt').ToString;
//                 GenerateEntry(DocType, DocNo, txtIRN, txtSigned_QRCode, txtSigned_invoice, Acknowledgment_number, Acknowledgment_Date);
//                 CLEAR(RecRef);
//                 CLEAR(FieldRef);
//                 IF DocType = DocType::Invoice THEN BEGIN
//                     IF ValidateIRNandImportDetails(
//                          DATABASE::"Sales Invoice Header", txtIRN,
//                                Acknowledgment_number,
//                          txtSigned_QRCode,
//                          Acknowledgment_Date) THEN
//                         ;
//                 END ELSE
//                     IF DocType = DocType::"Credit Memo" THEN BEGIN
//                         IF ValidateIRNandImportDetails(
//                              DATABASE::"Sales Cr.Memo Header", txtIRN,
//                                    Acknowledgment_number,
//                              txtSigned_QRCode,
//                              Acknowledgment_Date) THEN
//                             ;
//                     END;
//                 // ExportAsJson(Asp_ResultGenerateIRN);
//                 MESSAGE('E-Invoice Generated Sucessfully for Doc No. %1', DocNo);

//             END
//             ELSE BEGIN
//                 JObjectIRN := JObjectIRN.Parse(Asp_ResultGenerateIRN);
//                 GenerateResponseEntry(DocType, DocNo, Asp_ResultGenerateIRN);
//                 SalesSetu.GET;
//                 ERROR(Asp_ResultGenerateIRN);
//                 // ExportAsJson(Asp_ResultGenerateIRN);
//             END;
//         END;
//     end;


//     procedure GenerateToken(GSTIN: Text)
//     var
//         TokenResult: Text;
//         JObjectToken: DotNet JObject;
//         EInvoice_asp: DotNet EInvoice_asp;
//     begin
//         EInvoice_asp := EInvoice_asp.EInvoice_asp();
//         GstReg.GET(GSTIN);
//         TokenResult := EInvoice_asp.Authtoken(GSTIN, GstReg."User Name", GstReg.Password);
//         JObjectToken := JObjectToken.Parse(TokenResult);
//         Token_No := JObjectToken.SelectToken('Data.AuthToken').ToString;
//         IF Token_No <> '' THEN
//             Token_ExpDateTime := CURRENTDATETIME + ((1000 * 60) * 360);
//         // EVALUATE(Token_ExpDateTime,JObjectToken.SelectToken('Data.TokenExpiry').ToString);

//         UpdateToken(Token_No, Token_ExpDateTime, GSTIN);
//     end;


//     procedure CancelatioinIRN(OrignalInv: Text; DocumentNo: Code[20]; CancelReson: Option " ",Duplicate,"Data Entry Mistake"; CancelRemarks: Text; GST: Code[20]; OptDocTyp: Option Invoice,"Credit Memo",Transfer,"Transfer Cancel")
//     var
//         recGSRegNos: Record "16400";
//     begin

//         IF recGSRegNos.GET(GST) THEN;
//         IF (CURRENTDATETIME > recGSRegNos."Token Exp Date Time") THEN BEGIN
//             GenerateToken(GST);
//             CancelIRN(OrignalInv, DocumentNo, CancelReson, CancelRemarks, GST, OptDocTyp); ////added OptDocType::Invoice
//         END ELSE BEGIN
//             CancelIRN(OrignalInv, DocumentNo, CancelReson, CancelRemarks, GST, OptDocTyp); //added OptDocType::Invoice
//         END;
//     end;

//     local procedure GetGSTValItem(var AssVal: Decimal; var CgstVal: Decimal; var SgstVal: Decimal; var IgstVal: Decimal; var Lineno: Integer)
//     var
//         SalesInvoiceLine: Record "113";
//         SalesCrMemoLine: Record "115";
//         GSTLedgerEntry: Record "16418";
//         DetailedGSTLedgerEntry: Record "16419";
//         CurrExchRate: Record "330";
//         CustLedgerEntry: Record "21";
//         GSTComponent: Record "16405";
//         TotGSTAmt: Decimal;
//     begin
//         CLEAR(CgstVal);
//         CLEAR(SgstVal);
//         CLEAR(IgstVal);
//         CLEAR(AssVal);//Added 161220

//         DetailedGSTLedgerEntry.SETRANGE("Document No.", DocumentNo);
//         DetailedGSTLedgerEntry.SETRANGE("Document Line No.", Lineno);
//         IF DetailedGSTLedgerEntry.FIND('-') THEN BEGIN
//             REPEAT
//                 IF DetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN
//                     CgstVal += ABS(DetailedGSTLedgerEntry."GST Amount");
//                 IF DetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN
//                     SgstVal += ABS(DetailedGSTLedgerEntry."GST Amount");
//                 IF DetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN
//                     IgstVal += ABS(DetailedGSTLedgerEntry."GST Amount");
//                 IF DetailedGSTLedgerEntry."GST Component Code" IN ['IGST', 'CGST'] THEN //Added 161220
//                     AssVal += DetailedGSTLedgerEntry."GST Base Amount";//Added 161220
//             UNTIL DetailedGSTLedgerEntry.NEXT = 0;
//         END;
//     end;


//     procedure SetTransHeader(SalesTraHeaderBuff: Record "5744")
//     begin
//         TransferShipHdr := SalesTraHeaderBuff;
//         IsInvoice := FALSE;
//         IsTransShip := TRUE;
//     end;


//     procedure SetEwayRequirement(EwayRequired: Boolean)
//     begin
//         //Added KPPL_EINV 1.0
//         ISEwayRequired := EwayRequired;
//     end;


//     procedure GenerateEwbDtl(Token: Text; DocNo: Code[20]; DocType: Option Invoice,"Credit Memo",Transfer; cdGST: Code[20])
//     var
//         IRN: Code[50];
//         recSIH: Record "112";
//         recEinvoice: Record "50004";
//         JObject: DotNet JObject;
//         EInvoice_asp: DotNet EInvoice_asp;
//         Asp_EwayByIRN: Text;
//         JObjectEway: DotNet JObject;
//         Result: Text;
//         txtEwbNo: Text;
//         txtEwbDate: Text;
//         txtEwbValid: Text;
//     begin
//         //Added  KPPL_EINV 1.1
//         IF recEinvoice.GET(DocType, DocNo) THEN
//             IF (recEinvoice.IRN <> '') AND (ISEwayRequired = TRUE) THEN BEGIN
//                 ReadEwayDtl(recEinvoice); //generate JSon
//                 GstReg.GET(cdGST);
//                 EInvoice_asp := EInvoice_asp.EInvoice_asp();
//                 Asp_EwayByIRN := EInvoice_asp.Generate_eInvoice_eWAY(StringBuilder.ToString, cdGST, Token, GstReg."User Name");
//                 JObjectEway := JObjectEway.Parse(Asp_EwayByIRN);
//                 IF JObjectEway.HasValues THEN BEGIN
//                     Result := (JObjectEway.SelectToken('Status').ToString);
//                     IF Result = '1' THEN BEGIN
//                         JObjectEway := JObjectEway.SelectToken('Data');
//                         JObjectEway := JObjectEway.Parse(JObjectEway.ToString);
//                         JObjectEway := JObjectEway.Parse(JObjectEway.SelectToken('').ToString);
//                         txtEwbNo := JObjectEway.SelectToken('EwbNo').ToString;
//                         txtEwbDate := JObjectEway.SelectToken('EwbDt').ToString;
//                         txtEwbValid := JObjectEway.SelectToken('EwbValidTill').ToString;
//                         GenerateEntryEway(DocType, DocNo, txtEwbNo, txtEwbDate, txtEwbValid);
//                         MESSAGE('EWay Generated Sucessfully for Doc No. %1', DocNo);
//                     END ELSE BEGIN
//                         JObjectEway := JObjectEway.Parse(Asp_EwayByIRN);
//                         GenerateResponseEntry(DocType, DocNo, Asp_EwayByIRN);
//                         MESSAGE('EWay Generartion returned Error!!!');
//                     END;
//                 END;
//             END;
//     end;

//     local procedure ReadEwayDtlByIRN(IRN: Text)
//     var
//         IntDis: Integer;
//     begin
//         /*
//         Initialize;
//         JsonTextWriter.WriteStartObject;
//         IF (IsTransShip =FALSE) AND (IsInvoice= TRUE) THEN BEGIN
//           WITH SalesInvoiceHeader DO BEGIN
//             JsonTextWriter.WritePropertyName('Irn');
//             JsonTextWriter.WriteValue(IRN);
//             JsonTextWriter.WritePropertyName('TransId');
//             JsonTextWriter.WriteValue(SalesInvoiceHeader."Transporter No.");
//             JsonTextWriter.WritePropertyName('TransName');
//             JsonTextWriter.WriteValue(SalesInvoiceHeader."Shipping Agent Code");
//             JsonTextWriter.WritePropertyName('Distance');
//             IF SalesInvoiceHeader."Distance (Km)" > 0 THEN
//              IntDis := ROUND(SalesInvoiceHeader."Distance (Km)",1,'=');
//             JsonTextWriter.WriteValue(IntDis);

//             JsonTextWriter.WritePropertyName('TrnDocNo');
//             JsonTextWriter.WriteValue(SalesInvoiceHeader."LR/RR No.");
//             JsonTextWriter.WritePropertyName('TrnDocDt');
//             JsonTextWriter.WriteValue(FORMAT(SalesInvoiceHeader."LR/RR Date",0,'<Day,2>/<Month,2>/<Year4>'));
//             JsonTextWriter.WritePropertyName('VehNo');
//             JsonTextWriter.WriteValue(SalesInvoiceHeader."Vehicle No.");
//             JsonTextWriter.WritePropertyName('VehType');
//             IF SalesInvoiceHeader."Vehicle Type"=SalesInvoiceHeader."Vehicle Type"::ODC THEN
//              JsonTextWriter.WriteValue('O');
//             IF SalesInvoiceHeader."Vehicle Type"=SalesInvoiceHeader."Vehicle Type"::Regular THEN
//              JsonTextWriter.WriteValue('R');
//             IF SalesInvoiceHeader."Vehicle Type"=SalesInvoiceHeader."Vehicle Type"::" " THEN
//              JsonTextWriter.WriteValue('');
//             JsonTextWriter.WritePropertyName('TransMode');
//             JsonTextWriter.WriteValue(SalesInvoiceHeader."Transport Method");
//           END;
//         END;
//         IF (IsTransShip =TRUE) THEN BEGIN
//           WITH TransferShipHdr DO BEGIN
//            JsonTextWriter.WritePropertyName('Irn');
//             JsonTextWriter.WriteValue(IRN);
//             JsonTextWriter.WritePropertyName('TransId');
//             JsonTextWriter.WriteValue(SalesInvoiceHeader."Transporter No.");
//             JsonTextWriter.WritePropertyName('TransName');
//             JsonTextWriter.WriteValue(TransferShipHdr."Shipping Agent Code");
//             JsonTextWriter.WritePropertyName('Distance');
//             IF TransferShipHdr."Distance (Km)" > 0 THEN
//              IntDis := ROUND(TransferShipHdr."Distance (Km)",1,'=');
//             JsonTextWriter.WriteValue(IntDis);
//             JsonTextWriter.WritePropertyName('TrnDocNo');
//             JsonTextWriter.WriteValue(TransferShipHdr."LR/RR No.");
//             JsonTextWriter.WritePropertyName('TrnDocDt');
//             JsonTextWriter.WriteValue(FORMAT(TransferShipHdr."LR/RR Date",0,'<Day,2>/<Month,2>/<Year4>'));
//             JsonTextWriter.WritePropertyName('VehNo');
//             JsonTextWriter.WriteValue(TransferShipHdr."Vehicle No.");
//             JsonTextWriter.WritePropertyName('VehType');
//             IF TransferShipHdr."Vehicle Type"=TransferShipHdr."Vehicle Type"::ODC THEN
//              JsonTextWriter.WriteValue('O');
//             IF TransferShipHdr."Vehicle Type"=TransferShipHdr."Vehicle Type"::Regular THEN
//              JsonTextWriter.WriteValue('R');
//             JsonTextWriter.WritePropertyName('TransMode');
//             JsonTextWriter.WriteValue(TransferShipHdr."Transport Method");
//           END;
//         END;
//         JsonTextWriter.WriteEndObject;
//         JsonTextWriter.Flush;

//         IF DocumentNo <> '' THEN
//           ExportAsJson(DocumentNo)
//         ELSE
//           ERROR(RecIsEmptyErr);

//         */

//     end;


//     procedure ReadEwayDtl(recEInvoice: Record "50004")
//     var
//         IntDis: Integer;
//         recShipAgent: Record "291";
//     begin
//         /*
//         //Added  KPPL_EINV 1.1
//             Initialize;
//             JsonTextWriter.WriteStartObject;
//             JsonTextWriter.WritePropertyName('Irn');
//             JsonTextWriter.WriteValue(recEInvoice.IRN);
//             //KPPL231020 Added in case when user does't know trans id/ TransName
//             IF recShipAgent.GET(recEInvoice."Shipping Agent Code") THEN;
//             JsonTextWriter.WritePropertyName('TransId');
//            // IF recEInvoice."Shipping Agent Code" <>'' THEN
//              //JsonTextWriter.WriteValue(recShipAgent."GST Registration No.")
//             //ELSE BEGIN
//               //IF recEInvoice."Self Collection" THEN
//                 JsonTextWriter.WriteValue(SalesInvoiceHeader."Ship-to GST Reg. No.")
//             //ELSE
//              //JsonTextWriter.WriteValue('');
//             //END;
//             JsonTextWriter.WritePropertyName('TransName');
//             IF recEInvoice."Shipping Agent Code" <>'' THEN BEGIN
//              IF recShipAgent.GET(recEInvoice."Shipping Agent Code") THEN
//               JsonTextWriter.WriteValue(recShipAgent.Name)
//              END ELSE
//               JsonTextWriter.WriteValue(GlobalNULL);

//             JsonTextWriter.WritePropertyName('Distance');
//             IF recEInvoice."Distance (Km)" > 0 THEN
//               IntDis := ROUND(recEInvoice."Distance (Km)",1,'=');
//               JsonTextWriter.WriteValue(IntDis);

//             JsonTextWriter.WritePropertyName('transDocNo');
//             IF recEInvoice."LR/RR No." <> '' THEN
//             JsonTextWriter.WriteValue(recEInvoice."LR/RR No.")
//             ELSE
//               JsonTextWriter.WriteValue(GlobalNULL);
//             //JsonTextWriter.WritePropertyName('transDocDate');//('TrnDocDt');
//             JsonTextWriter.WritePropertyName('TransDocDt');//('TrnDocDt');//301220
//             JsonTextWriter.WriteValue(FORMAT(recEInvoice."LR/RR Date",0,'<Day,2>/<Month,2>/<Year4>'));

//             JsonTextWriter.WritePropertyName('VehNo');
//             IF recEInvoice."Vehicle No."<>'' THEN
//             JsonTextWriter.WriteValue(recEInvoice."Vehicle No.")
//             ELSE
//               JsonTextWriter.WriteValue(GlobalNULL);
//             JsonTextWriter.WritePropertyName('VehType');
//             IF recEInvoice."Vehicle Type"=recEInvoice."Vehicle Type"::" " THEN
//              JsonTextWriter.WriteValue(GlobalNULL);
//             IF recEInvoice."Vehicle Type"=recEInvoice."Vehicle Type"::ODC THEN
//              JsonTextWriter.WriteValue('O');
//             IF recEInvoice."Vehicle Type"=recEInvoice."Vehicle Type"::Regular THEN
//              JsonTextWriter.WriteValue('R');
//             JsonTextWriter.WritePropertyName('TransMode');
//             IF recEInvoice."Transport Method"<>'' THEN
//             JsonTextWriter.WriteValue(recEInvoice."Transport Method");

//             JsonTextWriter.WriteEndObject;
//             JsonTextWriter.Flush;
//         // 110121
//         {
//         IF recEInvoice."Document No." <> '' THEN
//           ExportAsJson(recEInvoice."Document No.")
//         ELSE
//           ERROR(RecIsEmptyErr);
//           }
//           */

//     end;


//     procedure GenerateEntryEway(DocType: Option Invoice,"Credit Memo",Transfer; "DocNo.": Code[20]; txtEway: Text; txtEwayDt: Text; txtEwayValid: Text)
//     var
//         recEInv: Record "50004";
//         [RunOnClient]
//         IBarCodeProvider: DotNet IBarcodeProvider;
//         QRCodeFileName: Text;
//         inv: Record "112";
//         Crmemo: Record "114";
//     begin
//         /*
//         IF DocType=0 THEN BEGIN
//            IF inv.GET("DocNo.") THEN BEGIN
//              inv."E-Way Bill No":= txtEway;
//              inv."E-Way Bill No.":= txtEway;
//              inv.MODIFY;
//              END;

//           END ELSE IF DocType=1 THEN BEGIN
//            IF Crmemo.GET("DocNo.") THEN BEGIN
//              Crmemo."E-Way Bill No.":= txtEway;
//              Crmemo.MODIFY;
//              END;

//         END;

//         IF recEInv.GET(DocType,"DocNo.") THEN BEGIN
//           recEInv.EwbNo := txtEway;
//           recEInv.EwbDt := txtEwayDt;
//           recEInv.EwbValidTill := txtEwayValid;
//           recEInv.MODIFY;
//         END;
//         */

//     end;


//     procedure UpdateEWayDtl(DocType: Option Invoice,"Credit Memo",Transfer; "DocNo.": Code[20])
//     var
//         recEInvoice1: Record "50004";
//     begin
//         /*
//         //Added KPPL_EINV 1.1
//         //IF (IsTransShip =FALSE) AND(IsInvoice=TRUE) THEN BEGIN
//          WITH SalesInvoiceHeader DO BEGIN
//           recEInvoice1.RESET;
//           recEInvoice1.SETRANGE(recEInvoice1."Document Type",DocType);
//           recEInvoice1.SETRANGE("Document No.",SalesInvoiceHeader."No.");
//           IF recEInvoice1.FIND('-') THEN BEGIN
//             //recEInvoice1.VALIDATE("Transporter No.","Transporter No.");
//            // recEInvoice1.VALIDATE("Transporter No.","Transporter No.");//User Specific241220
//             recEInvoice1.VALIDATE("Shipping Agent Code","Transporter Code");
//             recEInvoice1.VALIDATE("Distance (Km)","Distance (Km)");
//            // recEInvoice1.VALIDATE("Distance (Km)","Transportation Distance");//User Specific241220
//             recEInvoice1.VALIDATE("LR/RR No.","LR/RR No.");
//             recEInvoice1.VALIDATE("LR/RR Date","LR/RR Date");
//             recEInvoice1.VALIDATE("Vehicle No.","Vehicle No.");
//             recEInvoice1.VALIDATE(recEInvoice1."Vehicle Type",recEInvoice1."Vehicle Type"::Regular);
//             recEInvoice1.VALIDATE("Transport Method","Transport Method");
//             recEInvoice1.VALIDATE("Self Collection","Self Collection");
//             //recEInvoice1.VALIDATE("Transport Method",FORMAT("Mode of Transport")); //User Specific241220
//             recEInvoice1.MODIFY;
//            END;
//          END;
//         //END;
//         COMMIT;
//         */

//     end;


//     procedure ReadGenerateEwayByIRN(DocType: Option Invoice,"Credit Memo",Transfer; "DocNo.": Code[20]; GST: Code[20])
//     var
//         ApiResultGenerateIRN: Text;
//         JObject: DotNet JObject;
//         IRNNode: Text;
//         Result: Code[1];
//         recGSRegNos: Record "16400";
//         TokenResult: Text;
//         JObjectToken: DotNet JObject;
//         Token_ExpDateTime: DateTime;
//         EInvoice_asp: DotNet EInvoice_asp;
//         recEinvoice: Record "50004";
//     begin
//         ISEwayRequired := TRUE;
//         IF recGSRegNos.GET(GST) THEN;
//         IF (CURRENTDATETIME > recGSRegNos."Token Exp Date Time") OR (recGSRegNos."Token Exp Date Time" = 0DT) THEN BEGIN
//             GenerateToken(GST);
//             GenerateEwbDtl(Token_No, "DocNo.", DocType, GST);
//         END ELSE BEGIN
//             GenerateEwbDtl(recGSRegNos."Token No", "DocNo.", DocType, GST);
//         END;
//     end;


//     procedure ReGenerateQR(DocType: Option Invoice,"Credit Memo",Transfer; "DocNo.": Code[20])
//     var
//         recEinv1: Record "50004";
//         QRCodeFileName: Text;
//     begin
//         IF recEinv1.GET(DocType, "DocNo.") THEN BEGIN
//             QRCodeFileName := GetQRCode(recEinv1."QR Code Part1" + recEinv1."QR Code Part2" + recEinv1."QR Code Part3" + recEinv1."QR Code Part4");
//             QRCodeFileName := MoveToPath(QRCodeFileName);
//             CLEAR(TempBlob);
//             FileMagmet.BLOBImport(TempBlob, QRCodeFileName);
//             IF TempBlob.Blob.HASVALUE THEN BEGIN
//                 recEinv1."QR Code" := TempBlob.Blob;
//             END;
//             IF NOT ISSERVICETIER THEN
//                 IF EXISTS(QRCodeFileName) THEN
//                     ERASE(QRCodeFileName);

//             recEinv1.MODIFY;
//         END;
//     end;


//     procedure GetEInvoice(DocType: Option Invoice,"Credit Memo",Transfer; "DocNo.": Code[20]; GetEntryGSTIN: Code[20])
//     var
//         EInvoice_asp: DotNet EInvoice_asp;
//         GetEntryResult: Text;
//         JObjectGetEntry: DotNet JObject;
//         recGSRegNos: Record "16400";
//         Result: Text;
//         ErrorLogSting: Text;
//     begin

//         ErrorLogSting := CheckLog(DocType, "DocNo.");
//         IF txtErrorcode = '2150' THEN BEGIN
//             JObjectGetEntry := JObjectGetEntry.Parse(ErrorLogSting);
//             JObjectGetEntry := ((JObjectGetEntry.SelectToken('InfoDtls')));
//             JObjectGetEntry := JObjectGetEntry.Item(0);
//             JObjectGetEntry := JObjectGetEntry.SelectToken('Desc');
//             GetEntryIRN := JObjectGetEntry.SelectToken('Irn').ToString;

//             IsGetEntry := TRUE;
//             GetEntryGST := GetEntryGSTIN;
//             EInvoice_asp := EInvoice_asp.EInvoice_asp();
//             recGSRegNos.GET(GetEntryGSTIN);
//             IF (CURRENTDATETIME > recGSRegNos."Token Exp Date Time") OR (recGSRegNos."Token Exp Date Time" = 0DT) THEN BEGIN
//                 GenerateToken(GetEntryGSTIN);
//                 ASPGenerateIRN(Token_No, "DocNo.", DocType);
//             END ELSE
//                 ASPGenerateIRN(recGSRegNos."Token No", "DocNo.", DocType);
//         END;
//     end;

//     local procedure CheckLog(DocType: Option Invoice,"Credit Memo",Transfer; "DocNo.": Code[20]) ErrorSting: Text
//     var
//         JObjectGetErrorCode: DotNet JObject;
//     begin

//         recLogEnrty.RESET;
//         recLogEnrty.SETRANGE(recLogEnrty."Document No.", "DocNo.");
//         recLogEnrty.SETRANGE(recLogEnrty."Document Type", DocType);
//         IF recLogEnrty.FIND('+') THEN
//             REPEAT

//                 JObjectGetErrorCode := JObjectGetErrorCode.Parse(recLogEnrty.Message + recLogEnrty.Message1 + recLogEnrty.Message2 + recLogEnrty.Message3);

//                 JObjectGetErrorCode := ((JObjectGetErrorCode.SelectToken('ErrorDetails')));
//                 JObjectGetErrorCode := JObjectGetErrorCode.Item(0);
//                 txtErrorcode := JObjectGetErrorCode.SelectToken('ErrorCode').ToString;
//                 IF txtErrorcode = '2150' THEN
//                     EXIT(recLogEnrty.Message + recLogEnrty.Message1 + recLogEnrty.Message2 + recLogEnrty.Message3);
//             UNTIL recLogEnrty.NEXT = 0;
//     end;

//     local procedure ValidateIRNandImportDetails(CallByTableId: Integer; IRNValue2: Text; AckValue2: Text; SignedQRCodeValue2: Text; AckDt2: Text): Boolean
//     var
//         RecRef: RecordRef;
//         FieldRef: FieldRef;
//         TempDateTime: DateTime;
//     begin
//         RecRef.OPEN(CallByTableId);
//         FieldRef := RecRef.FIELD(50202);
//         FieldRef.SETRANGE(IRNValue2);
//         IF RecRef.FINDFIRST THEN BEGIN
//             FieldRef := RecRef.FIELD(50203);
//             FieldRef.VALUE := AckValue2;
//             FieldRef := RecRef.FIELD(50204);
//             CLEAR(TempDateTime);
//             EVALUATE(TempDateTime, ConvertAckDt(AckDt2));
//             FieldRef.VALUE := TempDateTime;
//             // FieldRef := RecRef.FIELD(16633);
//             //FieldRef.VALUE := TRUE;
//             //GenrateQRCode(SignedQRCodeValue2,RecRef);
//             EXIT(TRUE);
//         END;

//         EXIT(FALSE);
//     end;

//     local procedure GenrateQRCode(QRCodeTxt: Text; var RecRef: RecordRef)
//     var
//         TempBlob: Record "99008535";
//         FieldRef: FieldRef;
//         QRCodeInput: Text;
//         QRCodeFileName: Text;
//     begin
//         // Save a QR code image into a file in a temporary folder.
//         QRCodeInput := QRCodeTxt;
//         QRCodeFileName := GetQRCode(QRCodeInput);
//         QRCodeFileName := MoveToMagicPath(QRCodeFileName); // To avoid confirmation dialogue on RTC.

//         // Load the image from file into the BLOB field.
//         CLEAR(TempBlob);
//         TempBlob.CALCFIELDS(Blob);
//         FileManagement.BLOBImport(TempBlob, QRCodeFileName);

//         FieldRef := RecRef.FIELD(16629);
//         FieldRef.VALUE := TempBlob.Blob;
//         RecRef.MODIFY;

//         // Erase the temporary file.
//         IF NOT ISSERVICETIER THEN
//             IF EXISTS(QRCodeFileName) THEN
//                 ERASE(QRCodeFileName);
//     end;

//     local procedure ConvertAckDt(AckDt2: Text) DateTime: Text
//     var
//         YYYY: Text[4];
//         MM: Text[2];
//         DD: Text[2];
//     begin
//         YYYY := COPYSTR(AckDt2, 1, 4);
//         MM := COPYSTR(AckDt2, 6, 2);
//         DD := COPYSTR(AckDt2, 9, 2);

//         // TIME := COPYSTR(AckDt2,12,8);

//         DateTime := DD + '-' + MM + '-' + YYYY + ' ' + COPYSTR(AckDt2, 12, 8);
//     end;


//     procedure MoveToMagicPath(SourceFileName: Text) DestinationFileName: Text[1024]
//     var
//         FileSystemObject: Automation;
//     begin
//         // User Temp Path
//         DestinationFileName := COPYSTR(FileManagement.ClientTempFileName(''), 1, 1024);
//         IF ISCLEAR(FileSystemObject) THEN
//             CREATE(FileSystemObject, TRUE, TRUE);
//         FileSystemObject.MoveFile(SourceFileName, DestinationFileName);
//     end;

//     trigger TempJObject::PropertyChanged(sender: Variant; e: DotNet PropertyChangedEventArgs)
//     begin
//     end;

//     trigger TempJObject::PropertyChanging(sender: Variant; e: DotNet PropertyChangingEventArgs)
//     begin
//     end;

//     trigger TempJObject::ListChanged(sender: Variant; e: DotNet ListChangedEventArgs)
//     begin
//     end;

//     trigger TempJObject::AddingNew(sender: Variant; e: DotNet AddingNewEventArgs)
//     begin
//     end;

//     trigger TempJObject::CollectionChanged(sender: Variant; e: DotNet NotifyCollectionChangedEventArgs)
//     begin
//     end;

//     trigger JProperty::ListChanged(sender: Variant; e: DotNet ListChangedEventArgs)
//     begin
//     end;

//     trigger JProperty::AddingNew(sender: Variant; e: DotNet AddingNewEventArgs)
//     begin
//     end;

//     trigger JProperty::CollectionChanged(sender: Variant; e: DotNet NotifyCollectionChangedEventArgs)
//     begin
//     end;
// }

