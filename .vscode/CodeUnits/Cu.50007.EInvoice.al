codeunit 50007 "E-Invoice"
{
    Permissions = TableData 112 = rim,
                  TableData 114 = rim,
                  TableData 5744 = rim;

    trigger OnRun()
    begin
    end;

    var
        ResultObject: JsonObject;
        enText: Label 'Do You Want to Generate E-Way Bill No.';
        EinvCancelTaxProMdl: JsonObject;
        PostUrl: text;
        RecLocation: Record 14;
        RecState: Record State;
        RecCustomer: Record 18;
        Result: Text;
        ArraySize: Integer;
        varArray: JsonArray;
        i: Integer;
        EInvDtlEntry: Record 50015;
        Result1: Text[1024];
        Char1: Char;
        Char2: Char;
        Char3: Char;
        RecSalessetup: Record 311;
        RecGSTLedEntry: Record "GST Ledger Entry";
        SGSTPer: Decimal;
        IGSTPer: Decimal;
        CGSTPer: Decimal;
        SGSTAmount: Decimal;
        CGSTAmount: Decimal;
        IGSTAmount: Decimal;
        TotalGstAmount: Decimal;
        NewValue: Text;
        LineNo: Integer;
        RecEinvDtl: Record 50015;
        RecState1: Record State;
        //GenerateIRN: DotNet Requests;
        //EInvoiceSession: DotNet EInvoiceSession;
        EInvoiceAPISetting: JsonObject;
        ApiLoginDetail: JsonObject;
        GstRt: Decimal;
        Location: Record 14;
        Customer: Record 18;
        pincode: Integer;
        State: Record State;
        State1: Record State;
        ShiptoAddress: Record 222;
        TIGSTAmt: Decimal;
        TCGSTAmt: Decimal;
        TSGSTAmt: Decimal;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        TotalAssAmt: Decimal;
        OtherCharges: Decimal;
        TCSAmt: Decimal;
        //TCSEntry: Record "16514";//tk
        RoundOff: Decimal;
        TotalInvoiceAmt: Decimal;
        CustLedgerEntry: Record 21;
        SNo: Integer;
        IsServ: Text;
        ReqGenerateIRN: JsonObject;
        TranDtls: JsonObject;
        EInvDocdtl: JsonObject;
        ExpDtls: JsonObject;
        SellerDtls: JsonObject;
        StdCode: Integer;
        Postcode: Integer;
        ShipDtls: JsonObject;
        BuyerDtls: JsonObject;
        pincd: Integer;
        Stcd: Integer;
        DispDtls: JsonObject;
        ValDtls: JsonObject;
        othchrg: Decimal;
        Dics: Decimal;
        PayDtls: JsonObject;
        RefDtls: JsonObject;
        docprdDtls: JsonObject;
        RefNo: text;
        PrcdocDtls: JsonObject;
        PrcdocArray: JsonArray;
        EInvItemList: JsonObject;
        TotAmt: Decimal;
        TotItemVal: Decimal;
        State11: Record State;
        RecSalInv: Record 112;
        salesInvHeader2: Record 112;
        // QRCodeImg: DotNet Requests0;//tk check
        abpBigPDFText: BigText;
        // abpAutConvertBase64: DotNet Convert;//tk
        // abpAutBytes: DotNet Array;
        // abpAutMemoryStream: DotNet MemoryStream;
        abpOutStream: OutStream;
        // abpRecTempBlob: Record 99008535;//tk
        BigText1: BigText;
        Httpclint: HttpClient;
        HttpContnt: HttpContent;
        HttpResponseMsg: HttpResponseMessage;
        HttpHdr: HttpHeaders;
        SearchType: Text;
        jtoken: JsonToken;

    local procedure GetAccessToken() token: text
    var
        genLedSetup: Record "General Ledger Setup";
        aHttpclint: HttpClient;
        aHttpContnt: HttpContent;
        aHttpResponseMsg: HttpResponseMessage;
        aHttpHdr: HttpHeaders;
        resulttokenobject: JsonObject;
        aPostUrl: text;
    begin
        genLedSetup.get;

        //aPostUrl := 'https://gsp.adaequare.com/gsp/authenticate?action=GSP&grant_type=token';
        aPostUrl := 'https://gsp.adaequare.com/gsp/authenticate?action=GSP&grant_type=token';

        aHttpContnt.GetHeaders(aHttpHdr);
        aHttpHdr.Add('gspappid', genLedSetup.gspappid);
        aHttpHdr.add('gspappsecret', genLedSetup.gspappsecret);
        aHttpHdr.Remove('Content-Type');//tk
        aHttpHdr.Add('Content-Type', 'application/json');//tk

        //HttpContnt.WriteFrom(format(ReqGenerateIRN));
        // aHttpContnt.GetHeaders(aHttpHdr);
        if aHttpclint.Post(aPostUrl, aHttpContnt, aHttpResponseMsg) then begin

            aHttpResponseMsg.Content.ReadAs(Result);
            resulttokenobject.ReadFrom(Result);
        end;
        if resulttokenobject.get('access_token', jtoken) then begin
            token := jtoken.AsValue().AsText();
            exit(Token);
        end;

    end;

    local procedure ReuestId() id: Text
    var
        myInt: Integer;
    begin
        id := CreateGuid();
        id := DELCHR(id, '=', '{}-0');
        id := CopyStr(id, 1, 10);
        exit(id);
    end;

    local procedure "---------------E- Invoice Sales-------------------------"()
    begin
    end;


    procedure EInvoicingGeneration(RecSIH: Record 112)
    var
        SalesInvoiceLine1: Record 113;
        RecSIL: Record 113;
        SalesInvoiceLine: Record 113;
    begin
        IF Location.GET(RecSIH."Location Code") THEN;
        IF Customer.GET(RecSIH."Sell-to Customer No.") THEN;
        //Location
        Location.TESTFIELD("Phone No.");
        Location.TESTFIELD("GST Registration No.");
        Location.TESTFIELD(City);
        Location.TESTFIELD("State Code");
        Location.TESTFIELD("E-Mail");
        Location.TESTFIELD("Post Code");
        Location.TESTFIELD(Code);
        Location.TESTFIELD("E-Invoice Password");
        Location.TESTFIELD("E-Invoice User ID");

        //Customer
        // Customer.TESTFIELD("Phone No.");
        // Customer.TESTFIELD("E-Mail");
        Customer.TESTFIELD("State Code");
        IF Customer."GST Customer Type" = Customer."GST Customer Type"::Registered THEN
            Customer.TESTFIELD("GST Registration No.");

        //Header
        RecSIH.TESTFIELD("Sell-to City");
        RecSIH.TESTFIELD("Sell-to Post Code");
        RecSIH.TESTFIELD("No.");
        RecSIH.TESTFIELD("Nature of Supply", RecSIH."Nature of Supply"::B2B);
        RecSIH.TESTFIELD("Posting Date");
        RecSIH.TESTFIELD("Sell-to Customer Name");

        //"TranDtls"
        // TranDtls := TranDtls.TranDtls;//tk
        TranDtls.add('SupTyp', FORMAT(RecSIH."Nature of Supply"));
        TranDtls.add('TaxSch', 'GST');
        TranDtls.add('RegRev', 'N');
        //TranDtls.add('EcmGstin', '');//N
        //TranDtls.add('EcmGstin', '01AMBPG7773M002');//N
        //transDtl.IgstOnIntra:='';

        //DocDtls
        //EInvDocdtl := EInvDocdtl.DocDtls;
        EInvDocdtl.add('Typ', 'INV');//"INV", "CRN", "DBN"
        EInvDocdtl.add('No', RecSIH."No.");
        EInvDocdtl.add('Dt', FORMAT(RecSIH."Posting Date", 10, '<Day,2>/<Month,2>/<Year4>'));

        //SellerDtls

        // SellerDtls := SellerDtls.SellerDtls;
        SellerDtls.add('Gstin', Location."GST Registration No.");//tk
        // SellerDtls.add('Gstin', '04AMBPG7773M002');//tkgst
        // SellerDtls.add('Gstin', '01AMBPG7773M002');
        //SellerDtls.add('Gstin', '27AMBPG7773M016');
        SellerDtls.add('LglNm', Location.Name);
        SellerDtls.add('TrdNm', Location.Name);
        SellerDtls.add('Addr1', Location.Address);//*
        IF Location."Address 2" <> '' THEN
            SellerDtls.add('Addr2', Location."Address 2");

        SellerDtls.add('Loc', Location.City);
        EVALUATE(pincode, Location."Post Code");
        //SellerDtls.add('Pin', 400020);//NT
        SellerDtls.add('Pin', pincode);//*
        IF State.GET(Location."State Code") THEN;
        // SellerDtls.add('Stcd', '27');//RecState.Description;//*//tk
        SellerDtls.add('Stcd', State."State Code (GST Reg. No.)");//RecState.Description;//*
        IF Location."Phone No." <> '' THEN
            SellerDtls.add('Ph', Location."Phone No.");
        IF Location."E-Mail" <> '' THEN
            SellerDtls.add('Em', Location."E-Mail");



        //BuyerDtls
        //IF RecSIH."Ship-to Code" = '' THEN BEGIN
        IF State1.GET(Customer."State Code") THEN;
        //BuyerDtls := BuyerDtls.BuyerDtls;
        BuyerDtls.add('Gstin', Customer."GST Registration No.");//*
        BuyerDtls.add('LglNm', RecSIH."Sell-to Customer Name");//*
        BuyerDtls.add('TrdNm', RecSIH."Sell-to Customer Name");
        BuyerDtls.add('Pos', State1."State Code (GST Reg. No.)");//*//tkPOS
        BuyerDtls.add('Addr1', RecSIH."Sell-to Address");//*
        IF RecSIH."Sell-to Address 2" <> '' THEN
            BuyerDtls.add('Addr2 ', RecSIH."Sell-to Address 2");
        BuyerDtls.add('Loc', RecSIH."Sell-to City");//*
        EVALUATE(pincode, RecSIH."Sell-to Post Code");
        BuyerDtls.add('Pin', pincode);
        //BuyerDtls.add('Pin', 560002);//n
        //BuyerDtls.add('Pin', 560004);
        IF State.GET(Customer."State Code") THEN;
        //BuyerDtls.add('Stcd', '04');
        BuyerDtls.add('Stcd', State."State Code (GST Reg. No.)");//tk
        IF Customer."Phone No." <> '' THEN
            BuyerDtls.add('Ph', Customer."Phone No.");
        IF Customer."E-Mail" <> '' THEN
            BuyerDtls.add('Em', Customer."E-Mail");
        //  END;

        /*
            // Based on Muliple Ship to Address.
            IF RecSIH."Ship-to Code" <> '' THEN BEGIN
                   BuyerDtls := BuyerDtls.BuyerDtls;

                   ShiptoAddress.RESET;
                   ShiptoAddress.SETRANGE("Customer No.", RecSIH."Sell-to Customer No.");
                   ShiptoAddress.SETRANGE(Code,RecSIH."Ship-to Code");
                   IF ShiptoAddress.FINDFIRST THEN BEGIN
                   //   ShiptoAddress.TESTFIELD("GST Registration No.");

                      BuyerDtls.Gstin := ShiptoAddress."GST Registration No.";
                   END;

                   IF State1.GET(ShiptoAddress.State) THEN;
                   BuyerDtls.LglNm := RecSIH."Ship-to Name";//*
                   BuyerDtls.TrdNm := RecSIH."Ship-to Name";
                   BuyerDtls.Pos   := State1."State Code (GST Reg. No.)";//*

                   BuyerDtls.Addr1 := RecSIH."Ship-to Address";//*

                   IF RecSIH."Ship-to Address 2" <> '' THEN
                     BuyerDtls.Addr2 := RecSIH."Ship-to Address 2";

                   BuyerDtls.Loc := RecSIH."Ship-to City";//*
                   EVALUATE(pincode,RecSIH."Ship-to Post Code");
                   BuyerDtls.Pin  := pincode;
                   BuyerDtls.Stcd := State1."State Code (GST Reg. No.)";
                   IF ShiptoAddress."Phone No." <> '' THEN
                      BuyerDtls.Ph :=ShiptoAddress."Phone No.";
                    IF ShiptoAddress."E-Mail" <> '' THEN
                      BuyerDtls.Em :=ShiptoAddress."E-Mail";
            END;
            *///WIN234 16062021


        //DispDtls
        // DispDtls := DispDtls.DispDtls;//tk
        DispDtls.add('Nm', Location.Name);//*
        DispDtls.add('Addr1', Location.Address);//*

        IF Location."Address 2" <> '' THEN
            DispDtls.add('Addr2', Location."Address 2");

        DispDtls.add('Loc', Location.City);//*

        EVALUATE(pincode, Location."Post Code");
        DispDtls.add('Pin', pincode);//*

        IF State.GET(Location."State Code") THEN
            DispDtls.add('Stcd', State."State Code (GST Reg. No.)");//*

        //ShipDtls
        //  ShipDtls := ShipDtls.ShipDtls;//tk

        IF RecSIH."Ship-to Code" <> '' THEN BEGIN
            ShiptoAddress.RESET;
            ShiptoAddress.SETRANGE("Customer No.", RecSIH."Sell-to Customer No.");
            ShiptoAddress.SETRANGE(Code, RecSIH."Ship-to Code");
            IF ShiptoAddress.FINDFIRST THEN BEGIN
                //  ShiptoAddress.TESTFIELD("GST Registration No.");
                IF ShiptoAddress."GST Registration No." = '' THEN
                    ShipDtls.add('Gstin', 'URP')
                ELSE
                    ShipDtls.add('Gstin', ShiptoAddress."GST Registration No.");
            END;
        END;

        IF RecSIH."Ship-to Code" = '' THEN
            ShipDtls.add('Gstin', Customer."GST Registration No.");//*

        ShipDtls.add('LglNm', RecSIH."Ship-to Name");//*
        ShipDtls.add('TrdNm', RecSIH."Ship-to Name");
        ShipDtls.add('Addr1', RecSIH."Ship-to Address");//*
        ShipDtls.add('Addr2', RecSIH."Ship-to Address");
        ShipDtls.add('Loc', RecSIH."Ship-to City");//*
        EVALUATE(pincode, RecSIH."Ship-to Post Code");
        //tk45
        //ShipDtls.add('Pin', 560002);//n
        //ShipDtls.add('Pin', 180001);//n
        ShipDtls.add('Pin', pincode);
        IF RecSIH."Ship-to Code" <> '' THEN BEGIN
            IF State11.GET(RecSIH."GST Ship-to State Code") THEN
                //    ShipDtls.add('Stcd', '01')
                ShipDtls.add('Stcd', State11."State Code (GST Reg. No.)")
        END ELSE
            //    ShipDtls.add('Stcd', '01');
            ShipDtls.add('Stcd', State1."State Code (GST Reg. No.)");

        //ValDtls

        CLEAR(TIGSTAmt);
        CLEAR(TCGSTAmt);
        CLEAR(TSGSTAmt);
        DetailedGSTLedgerEntry.RESET;
        DetailedGSTLedgerEntry.SETRANGE("Document Type", DetailedGSTLedgerEntry."Document Type"::Invoice);
        DetailedGSTLedgerEntry.SETRANGE("Document No.", RecSIH."No.");
        IF DetailedGSTLedgerEntry.FINDFIRST THEN
            REPEAT
                IF DetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN BEGIN
                    TIGSTAmt += ABS(DetailedGSTLedgerEntry."GST Amount");
                END;
                IF DetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN BEGIN
                    TCGSTAmt += ABS(DetailedGSTLedgerEntry."GST Amount");
                END;
                IF DetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN BEGIN
                    TSGSTAmt += ABS(DetailedGSTLedgerEntry."GST Amount");
                END;
            UNTIL DetailedGSTLedgerEntry.NEXT = 0;

        CLEAR(TotalAssAmt);
        CLEAR(Dics);
        //CLEAR(TotalInvoiceAmt);//tk123
        CLEAR(OtherCharges);
        SalesInvoiceLine1.RESET;
        SalesInvoiceLine1.SETRANGE("Document No.", RecSIH."No.");
        SalesInvoiceLine1.SETFILTER("No.", '<>%1', '502340');//Round Of GL //NP
        IF SalesInvoiceLine1.FINDFIRST THEN BEGIN
            REPEAT
                //TotalAssAmt += SalesInvoiceLine1."Amount Including Tax";
                TotalAssAmt += SalesInvoiceLine1."Amount Including VAT"; //tk - SalesInvoiceLine1."Line Discount Amount";
                Dics += SalesInvoiceLine1."Line Discount Amount";//tk new
                OtherCharges += 0;//tk new//tk1
                                  //      TotalInvoiceAmt := TotalAssAmt + IGSTAmount + CGSTAmount + SGSTAmount;//tknew1
                                  //OtherCharges += SalesInvoiceLine1.Amount;//tk
            UNTIL SalesInvoiceLine1.NEXT = 0;
        END;

        // CLEAR(TCSAmt);//tk++
        // TCSEntry.RESET;
        // TCSEntry.SETRANGE("Document No.", RecSIH."No.");
        // TCSEntry.SETFILTER("TCS Amount", '<>%1', 0);
        // IF TCSEntry.FINDFIRST THEN
        //     TCSAmt := TCSEntry."TCS Amount";//TK--

        CLEAR(RoundOff);
        SalesInvoiceLine1.RESET;
        SalesInvoiceLine1.SETRANGE("Document No.", RecSIH."No.");
        SalesInvoiceLine1.SETRANGE(Type, SalesInvoiceLine1.Type::"G/L Account");
        SalesInvoiceLine1.SETRANGE("No.", '502340');//ROUND OF GL
        IF SalesInvoiceLine1.FINDFIRST THEN
            RoundOff := SalesInvoiceLine1.Amount;

        //CLEAR(TotalInvoiceAmt);
        // CustLedgerEntry.RESET;
        // CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
        // CustLedgerEntry.SETRANGE("Document No.", RecSIH."No.");
        // IF CustLedgerEntry.FINDFIRST THEN BEGIN
        //     CustLedgerEntry.CALCFIELDS("Amount (LCY)");
        //    TotalInvoiceAmt := CustLedgerEntry."Amount (LCY)";
        // END;
        TotalInvoiceAmt := TotalAssAmt + TSGSTAmt + TCGSTAmt + TIGSTAmt;
        // ValDtls := ValDtls.ValDtls;


        ValDtls.add('Discount', 0); //Dics;
        ValDtls.add('AssVal', ABS(TotalAssAmt)); //totinvamt1-RoundOff;//Total Assessable value of all items
        ValDtls.add('SgstVal', ROUND(TSGSTAmt, 0.01, '='));//tk
        ValDtls.add('CgstVal', ROUND(TCGSTAmt, 0.01, '='));
        ValDtls.add('IgstVal', ROUND(TIGSTAmt, 0.01, '='));
        ValDtls.add('CesVal', 0);
        ValDtls.add('StCesVal', 0);
        //ValDtls.add('OthChrg', ABS(TCSAmt));
        ValDtls.add('OthChrg', ABS(othchrg));
        ValDtls.add('RndOffAmt', RoundOff);
        ValDtls.add('TotInvVal', ABS(TotalInvoiceAmt));
        //ItemList

        SalesInvoiceLine1.RESET;
        SalesInvoiceLine1.SETRANGE("Document No.", RecSIH."No.");
        SalesInvoiceLine1.SETFILTER(Quantity, '<>%1', 0);
        SalesInvoiceLine1.SETFILTER("No.", '<>%1', '502340');//ROUNF OF GL
        IF SalesInvoiceLine1.FINDFIRST THEN
            ArraySize := SalesInvoiceLine1.COUNT;

        //ItemList

        //EInvItemList := EInvItemList.ItemList;
        // varArray := varArray.CreateInstance(EInvItemList.GetType, ArraySize);//tk1

        i := 0;
        SNo := 1;

        SalesInvoiceLine.RESET;
        SalesInvoiceLine.SETRANGE("Document No.", RecSIH."No.");
        SalesInvoiceLine.SETFILTER(Quantity, '<>%1', 0);
        SalesInvoiceLine.SETFILTER("No.", '<>%1', '502340');//ROUND OFF
        IF SalesInvoiceLine.FINDFIRST THEN BEGIN
            REPEAT
                CLEAR(IGSTAmount);
                CLEAR(CGSTAmount);
                CLEAR(SGSTAmount);
                CLEAR(IGSTPer);
                CLEAR(CGSTPer);
                CLEAR(SGSTPer);
                DetailedGSTLedgerEntry.RESET;
                DetailedGSTLedgerEntry.SETRANGE("Transaction Type", DetailedGSTLedgerEntry."Transaction Type"::Sales);
                DetailedGSTLedgerEntry.SETRANGE("Document Type", DetailedGSTLedgerEntry."Document Type"::Invoice);
                DetailedGSTLedgerEntry.SETRANGE("Document No.", SalesInvoiceLine."Document No.");
                DetailedGSTLedgerEntry.SETRANGE("No.", SalesInvoiceLine."No.");
                DetailedGSTLedgerEntry.SETRANGE("Document Line No.", SalesInvoiceLine."Line No.");
                IF DetailedGSTLedgerEntry.FINDFIRST THEN
                    REPEAT
                        IF DetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN BEGIN
                            IGSTPer := DetailedGSTLedgerEntry."GST %";
                            IGSTAmount := ABS(DetailedGSTLedgerEntry."GST Amount");
                        END;
                        IF DetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN BEGIN
                            CGSTPer := DetailedGSTLedgerEntry."GST %";
                            CGSTAmount := ABS(DetailedGSTLedgerEntry."GST Amount");
                        END;
                        IF DetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN BEGIN
                            SGSTPer := DetailedGSTLedgerEntry."GST %";
                            SGSTAmount := ABS(DetailedGSTLedgerEntry."GST Amount");
                        END;
                    UNTIL DetailedGSTLedgerEntry.NEXT = 0;

                SalesInvoiceLine.TESTFIELD("HSN/SAC Code");
                SalesInvoiceLine.TESTFIELD(Quantity);

                IF SalesInvoiceLine."GST Group Type" = SalesInvoiceLine."GST Group Type"::Service THEN
                    IsServ := 'Y'
                ELSE
                    IsServ := 'N';

                // EInvItemList := EInvItemList.ItemList;//TK
                EInvItemList.add('SlNo', FORMAT(SNo));
                EInvItemList.add('IsServc', IsServ);//*
                EInvItemList.add('PrdDesc', SalesInvoiceLine.Description);
                IF SalesInvoiceLine."HSN/SAC Code" <> '' THEN
                    EInvItemList.add('HsnCd', SalesInvoiceLine."HSN/SAC Code");//*
                                                                               //EInvItemList.BchDtls := 'NULL';
                EInvItemList.add('Qty', SalesInvoiceLine.Quantity);

                // IF SalesInvoiceLine."Unit of Measure Code" <> '' THEN
                //  IF SalesInvoiceLine."Unit of Measure Code" = 'KG' THEN
                //   SalesInvoiceLine."Unit of Measure Code" := 'KGS';

                // IF SalesInvoiceLine."Unit of Measure Code" <> '' THEN
                EInvItemList.add('Unit', 'NOS');//FORMAT(SalesInvoiceLine."Unit of Measure Code");

                EInvItemList.add('UnitPrice', ABS(ROUND(SalesInvoiceLine."Unit Price", 0.01, '=')));//*
                EInvItemList.add('TotAmt', ABS(ROUND((SalesInvoiceLine."Unit Price" * SalesInvoiceLine.Quantity), 0.01, '=')));//totinvamt;
                EInvItemList.add('Discount', SalesInvoiceLine."Line Discount Amount");
                EInvItemList.add('AssAmt', ROUND(ABS((SalesInvoiceLine."Unit Price" * SalesInvoiceLine.Quantity) - SalesInvoiceLine."Line Discount Amount"), 0.01, '='));
                EInvItemList.add('GstRt', IGSTPer + CGSTPer + SGSTPer);//*
                EInvItemList.add('CgstAmt', ROUND(ABS(CGSTAmount), 0.01, '='));
                EInvItemList.add('SgstAmt', ROUND(ABS(SGSTAmount), 0.01, '='));
                EInvItemList.add('IgstAmt', ROUND(ABS(IGSTAmount), 0.01, '='));

                EInvItemList.add('CesRt', 0);
                EInvItemList.add('CesAmt', 0);
                EInvItemList.add('CesNonAdvlAmt', 0);
                EInvItemList.add('StateCesRt', 0);
                EInvItemList.add('StateCesAmt', 0);
                EInvItemList.add('StateCesNonAdvlAmt', 0);
                //EInvItemList.add('OthChrg',SalesInvoiceLine."Charges To Customer";
                EInvItemList.add('OthChrg', 0);
                EInvItemList.add('TotItemVal', SalesInvoiceLine."Amount Including VAT" + (ABS(CGSTAmount)) + (ABS(SGSTAmount)) + (ABS(IGSTAmount)));//ABS(SalesInvoiceLine."Amount To Customer" - SalesInvoiceLine."Total TDS/TCS Incl. SHE CESS");

                //   EInvItemList.OthChrg := SalesInvoiceLine."Total TDS/TCS Incl. SHE CESS";
                //   EInvItemList.TotItemVal := SalesInvoiceLine."Amount To Customer";// - SalesInvoiceLine."Total TDS/TCS Incl. SHE CESS";

                //varArray.SetValue(EInvItemList, i);//tk 
                i := i + 1;
                SNo += 1;
                varArray.add(EInvItemList);//tk new
                Clear(EInvItemList);
            UNTIL SalesInvoiceLine.NEXT = 0;
        END;

        //For Login Details
        //ApiLoginDetail := ApiLoginDetail.EInvApiLoginDetails;
        ApiLoginDetail.add('UserName', Location."E-Invoice User ID");
        ApiLoginDetail.add('Password', Location."E-Invoice Password");
        ApiLoginDetail.add('Gstin', Location."GST Registration No.");

        //API Setting
        //EInvoiceAPISetting := EInvoiceAPISetting.EInvApiSetting;//tk
        EInvoiceAPISetting.Add('ClientSecret', '');
        //New version of api's in e-invoice++
        // EInvoiceAPISetting.Add('AuthUrl', 'https://einvapi.charteredinfo.com/eivital/v1.04');
        // EInvoiceAPISetting.Add('BaseUrl', 'https://einvapi.charteredinfo.com/eicore/v1.03');
        // EInvoiceAPISetting.Add('EwbByIRN', 'https://einvapi.charteredinfo.com/eiewb/v1.03');
        // EInvoiceAPISetting.Add('CancelEwbUrl', 'https://einvapi.charteredinfo.com/ewaybillapi/v1.03');
        //New version of api's in e-invoice--




        //E-Invoice Session
        // EInvoiceSession := EInvoiceSession.EInvoiceSession;
        // EInvoiceSession.EInvApiSetting := EInvoiceAPISetting;
        // EInvoiceSession.EInvApiLoginDetails := ApiLoginDetail;

        //Generate IRN
        // ReqGenerateIRN := ReqGenerateIRN.ReqPlGenerateIRN;//tk
        ReqGenerateIRN.add('Version', '1.1');//tk
        ReqGenerateIRN.add('TranDtls', TranDtls);
        ReqGenerateIRN.add('ExpDtls', ExpDtls);
        ReqGenerateIRN.Add('DocDtls', EInvDocdtl);
        ReqGenerateIRN.Add('SellerDtls', SellerDtls);
        ReqGenerateIRN.Add('BuyerDtls', BuyerDtls);
        ReqGenerateIRN.Add('DispDtls', DispDtls);
        ReqGenerateIRN.Add('ShipDtls', ShipDtls);
        ReqGenerateIRN.Add('ValDtls', ValDtls);
        //ReqGenerateIRN.PayDtls:=PayDtls;
        //ReqGenerateIRN.RefDtls:=RefDtls;
        ReqGenerateIRN.Add('ItemList', varArray);

        //Main Method
        Message(format(ReqGenerateIRN));
        //GenerateIRN := GenerateIRN.Requests;
        //Result := GenerateIRN.GenrateInvoice(EInvoiceSession, ReqGenerateIRN);
        // PostUrl := 'https://gsp.adaequare.com/test/enriched/ei/api/invoice';

        PostUrl := 'https://gsp.adaequare.com/enriched/ei/api/invoice';
        HttpContnt.WriteFrom(format(ReqGenerateIRN));
        HttpContnt.GetHeaders(HttpHdr);
        HttpHdr.Add('user_name', Location."E-Invoice User ID");
        HttpHdr.Add('password', Location."E-Invoice Password");
        HttpHdr.Add('gstin', Location."GST Registration No.");
        // HttpHdr.Add('gstin', '04AMBPG7773M002');
        // HttpHdr.Add('gstin', '01AMBPG7773M002');//tkgst
        //HttpHdr.Add('gstin', '27AMBPG7773M016');//tkgst
        HttpHdr.Add('requestid', ReuestId);
        //HttpHdr.Add('Authorization', 'Bearer ' + GetAccessToken());
        HttpHdr.Remove('Content-Type');//tk
        HttpHdr.Add('Content-Type', 'application/json');
        Httpclint.Timeout(180000);
        Httpclint.DefaultRequestHeaders.Add('Authorization', 'Bearer ' + GetAccessToken());
        // Httpclint.DefaultRequestHeaders.Add('user_name', 'adqgspchusr1');
        // Httpclint.DefaultRequestHeaders.Add('password', 'Gsp@1234');
        // Httpclint.DefaultRequestHeaders.Add('gstin', '04AMBPG7773M002');
        // Httpclint.DefaultRequestHeaders.Add('requestid', ReuestId);
        if Httpclint.Post(PostUrl, HttpContnt, HttpResponseMsg) then begin

            HttpResponseMsg.Content.ReadAs(Result);
            ResultObject.ReadFrom(Result);
        end
        else begin
            HttpResponseMsg.Content.ReadAs(Result);
            ResultObject.ReadFrom(Result);
            Message(Result);
        end;

        //MESSAGE(Result);
        ParseResponse(Result, RecSIH."No.");

    end;

    local procedure ParseResponse(TextResponse: Text; DocNo: Code[20]) messagetype: Text
    var
        dennomination: Decimal;
        p: Integer;
        x: Integer;
        ValuePair: Text;
        CurrentElement: Text;
        FormatChar: Label '{}';
        l: Integer;
        CurrentValue: Text;
        CurrentObject: Text;
        Irn: Text;
        token: Text;
        AckNo: Text;
        AckDt: Text;
        SignedInvoice: Text;
        SignedQRCode: Text;
        Instream: InStream;
        OutStream: OutStream;
        RecSIH1: Record 112;
        SignedQRCode1: Text;
        ResultJson: JsonObject;
        Jtoken: JsonToken;
        messageObject: JsonObject;
        //recref: RecordRef;
        QRGenerator: Codeunit "QR Generator";
        recRef: RecordRef;
        FieldRef: FieldRef;
        TempBlob: codeunit "Temp Blob";
    begin
        CLEAR(Irn);
        CLEAR(AckNo);
        CLEAR(AckDt);
        CLEAR(SignedInvoice);
        CLEAR(SignedQRCode);
        CLEAR(Irn);
        CLEAR(CurrentObject);
        p := 0;
        x := 1;

        ResultJson.ReadFrom(TextResponse);
        ResultJson.Get('success', jtoken);
        if Jtoken.AsValue().AsBoolean() then begin

            if ResultJson.Get('result', jtoken) then begin
                messageObject := jtoken.AsObject();
                if messageObject.Get('AckNo', Jtoken) then
                    AckNo := Jtoken.AsValue().AsText();
                if messageObject.Get('AckDt', Jtoken) then
                    AckDt := Jtoken.AsValue().AsText();
                if messageObject.Get('Irn', Jtoken) then
                    Irn := Jtoken.AsValue().AsText();
                if messageObject.Get('SignedQRCode', Jtoken) then
                    SignedQRCode := Jtoken.AsValue().AsText();


            end;
        end else
            Message(TextResponse);

        //Insert data into Table
        EInvDtlEntry.INIT;
        EInvDtlEntry."Entry No." := 0;
        EInvDtlEntry."Document No." := DocNo;
        EInvDtlEntry."Ack No" := AckNo;
        EInvDtlEntry.AckDate := COPYSTR(AckDt, 1, 10);
        EInvDtlEntry."Inv Transaction" := EInvDtlEntry."Inv Transaction"::"Generate IRN";
        EInvDtlEntry."IRN No." := Irn;
        EInvDtlEntry."User ID" := USERID;
        EInvDtlEntry."Document Type" := EInvDtlEntry."Document Type"::Invoice;

        EInvDtlEntry."Signed Invoice".CREATEOUTSTREAM(OutStream);
        OutStream.WRITE(SignedInvoice);
        EInvDtlEntry.INSERT;
        //EInvDtlEntry."Signed QR Code".CREATEOUTSTREAM(OutStream);
        // OutStream.WRITE(SignedQRCode);

        recRef.Get(EInvDtlEntry.RecordId);
        QRGenerator.GenerateQRCodeImage(SignedQRCode, TempBlob);
        FieldRef := recRef.Field(EInvDtlEntry.FieldNo("Signed QR Code"));
        TempBlob.ToRecordRef(RecRef, EInvDtlEntry.FieldNo("Signed QR Code"));
        recRef.Modify();
        //+++++++++++++++++++++++++

        //QRCodeImg := QRCodeImg.Requests;

        //BigText1.ADDTEXT(QRCodeImg.BaseSignedQRCode(SignedQRCode));

        // abpAutBytes := abpAutConvertBase64.FromBase64String(BigText1);
        // abpAutMemoryStream := abpAutMemoryStream.MemoryStream(abpAutBytes);
        // EInvDtlEntry.BitmapIma.CREATEOUTSTREAM(abpOutStream);
        // abpAutMemoryStream.WriteTo(abpOutStream); np 200623

        //----------------------
        if Irn <> '' then begin
            RecSIH1.RESET;
            RecSIH1.SETRANGE(RecSIH1."No.", DocNo);
            IF RecSIH1.FINDFIRST THEN BEGIN
                ;
                RecSIH1."IRN No." := Irn;
                RecSIH1."Acknowledgement No." := AckNo;
                EVALUATE(RecSIH1."Acknowledgement Date", AckDt);
                //RecSIH1."Acknowledgement Date" := COPYSTR(AckDt, 1, 10);
                //QRMgmt.InitializeSignedQRCode(RecSIH1, SignedQRCode);
                RecSIH1."E-Invocie Cancel Date" := '';
                RecSIH1."E-Invoice Cancel Remark" := '';
                RecSIH1."E-Invoice Reason Code" := RecSIH1."E-Invoice Reason Code"::"0";
                RecSIH1.MODIFY;
                recRef.Get(RecSIH1.RecordId);
                QRGenerator.GenerateQRCodeImage(SignedQRCode, TempBlob);
                FieldRef := recRef.Field(RecSIH1.FieldNo("QR Code"));
                TempBlob.ToRecordRef(RecRef, RecSIH1.FieldNo("QR Code"));
                recRef.Modify();
            END;
        end;
    end;


    procedure CancelEInvTaxPro(RecSIH: Record 112)
    var
        //EinvCancelTaxProMdl: DotNet ReqCancelIRN;
        reason: Integer;
        RecLocation: Record 14;
    begin
        RecSIH.TESTFIELD("E-Invoice Cancel Remark");
        RecSIH.TESTFIELD("Cancel Reason Code");
        RecEinvDtl.RESET;
        RecEinvDtl.SETRANGE("Document No.", RecSIH."No.");
        IF RecEinvDtl.FINDLAST THEN BEGIN
            IF RecLocation.GET(RecSIH."Location Code") THEN;
            //For Login Details
            // ApiLoginDetail := ApiLoginDetail.EInvApiLoginDetails;//tk
            ApiLoginDetail.Add('Gstin', RecLocation."GST Registration No.");
            ApiLoginDetail.Add('UserName', RecLocation."E-Invoice User ID");
            ApiLoginDetail.Add('Password', RecLocation."E-Invoice Password");

            //Cancel Model
            reason := RecSIH."Cancel Reason Code";
            // EinvCancelTaxProMdl := EinvCancelTaxProMdl.ReqCancelIRN;//tk
            EinvCancelTaxProMdl.Add('cnlrem', RecSIH."E-Invoice Cancel Remark");
            EinvCancelTaxProMdl.Add('cnlrsn', Format(reason));
            EinvCancelTaxProMdl.Add('Irn', RecSIH."IRN No.");

            //API Setting

            //EInvoiceAPISetting:= EInvoiceAPISetting.EInvApiSetting;
            EInvoiceAPISetting.Add('ClientSecret', '');
            //New version of api's in e-invoice++
            EInvoiceAPISetting.Add('AuthUrl', 'https://einvapi.charteredinfo.com/eivital/v1.04');
            EInvoiceAPISetting.Add('BaseUrl', 'https://einvapi.charteredinfo.com/eicore/v1.03');
            EInvoiceAPISetting.Add('EwbByIRN', 'https://einvapi.charteredinfo.com/eiewb/v1.03');
            EInvoiceAPISetting.Add('CancelEwbUrl', 'https://einvapi.charteredinfo.com/ewaybillapi/v1.03');
            //New version of api's in e-invoice--
            //PostUrl := 'https://gsp.adaequare.com/test/enriched/ei/api/invoice/cancel';
            PostUrl := 'https://gsp.adaequare.com/enriched/ei/api/invoice/cancel';
            HttpContnt.WriteFrom(Format(EinvCancelTaxProMdl));
            HttpContnt.GetHeaders(HttpHdr);
            HttpHdr.Add('user_name', RecLocation."E-Invoice User ID");
            HttpHdr.Add('password', RecLocation."E-Invoice Password");
            // HttpHdr.Add('gstin', '01AMBPG7773M002');//tkgst
            HttpHdr.Add('gstin', RecLocation."GST Registration No.");
            // HttpHdr.Add('gstin', '27AMBPG7773M016');//tkgst
            HttpHdr.Add('requestid', ReuestId);

            // HttpHdr.Add('app-name', 'Navision');
            // HttpHdr.Add('x-token', '241a4d366da38e2d53361dbe65a36d023065f399');
            HttpHdr.Remove('Content-Type');
            HttpHdr.Add('Content-Type', 'application/json');
            Httpclint.Timeout(180000);
            Httpclint.DefaultRequestHeaders.Add('Authorization', 'Bearer ' + GetAccessToken());

            if Httpclint.Post(PostUrl, HttpContnt, HttpResponseMsg) then begin
                HttpResponseMsg.Content.ReadAs(Result);
                ResultObject.ReadFrom(Result);
            end
            else begin
                HttpResponseMsg.Content.ReadAs(Result);
                ResultObject.ReadFrom(Result);
                MESSAGE(Result);

            END;
            //Result := '{"success":true,"message":"E-Invoice is cancelled successfully","result":{"Irn":"f1a681094bfb789998773fdc0011f684a9fba312e72dbad3cc4ee077baa08df2","CancelDate":"2023-07-26 22:29:00"}}';
            ParseResponseCan(Result, RecSIH."No.");

        end;
    end;

    local procedure ParseResponseCan(TextResponse: Text; DocNo: Code[20]) messagetype: Text
    var
        dennomination: Decimal;
        p: Integer;
        x: Integer;
        ValuePair: Text;
        CurrentElement: Text;
        FormatChar: Label '{}';
        l: Integer;
        CurrentValue: Text;
        CurrentObject: Text;
        Irn: Text;
        token: Text;
        AckNo: Text;
        AckDt: Text;
        SignedInvoice: Text;
        SignedQRCode: Text;
        Instream: InStream;
        OutStream: OutStream;
        RecSIH1: Record 112;
        CancelDate: Text;
    begin
        CLEAR(Irn);
        CLEAR(AckNo);
        CLEAR(AckDt);
        CLEAR(SignedInvoice);

        CLEAR(CurrentObject);
        p := 0;
        x := 1;

        IF STRPOS(TextResponse, '{}') > 0 THEN
            EXIT;

        TextResponse := DELCHR(TextResponse, '=', FormatChar);
        l := STRLEN(TextResponse);
        Char1 := 9;
        Char2 := 10;
        Char3 := 13;
        WHILE p < l DO BEGIN
            ValuePair := SELECTSTR(x, TextResponse);  // get comma separated pairs of values and element names

            IF STRPOS(ValuePair, ':') > 0 THEN BEGIN
                p := STRPOS(TextResponse, ValuePair) + STRLEN(ValuePair); // move pointer to the end of the current pair in Value

                CurrentElement := COPYSTR(ValuePair, 1, STRPOS(ValuePair, ':'));

                CurrentValue := DELCHR(CurrentValue, '=', ':');
                CurrentElement := DELCHR(CurrentElement, '=', '"');
                CurrentElement := DELCHR(CurrentElement, '=', ',');
                CurrentElement := DELCHR(CurrentElement, '=', '/');

                CurrentValue := COPYSTR(ValuePair, STRPOS(ValuePair, ':'));
                CurrentValue := DELCHR(CurrentValue, '=', ' ');
                CurrentValue := DELCHR(CurrentValue, '=', ':');
                CurrentValue := DELCHR(CurrentValue, '=', '/');
                CurrentValue := DELCHR(CurrentValue, '=', '"');

                CASE CurrentElement OF
                    'Irn:':
                        BEGIN
                            Irn := CurrentValue;

                        END;
                    'CancelDate:':
                        BEGIN
                            CancelDate := CurrentValue;

                        END;

                END;
            END;
            x := x + 1;
        END;
        //Get value from Json Response <<

        //Insert data into Table
        //Insert data into Table
        EInvDtlEntry.INIT;
        EInvDtlEntry."Entry No." := 0;
        EInvDtlEntry."Document No." := DocNo;
        EInvDtlEntry."Ack No" := '';
        EInvDtlEntry.AckDate := '';
        EInvDtlEntry."E-Invoice Cancel Date" := COPYSTR(CancelDate, 1, 10);
        EInvDtlEntry."Inv Transaction" := EInvDtlEntry."Inv Transaction"::Cancelled;
        EInvDtlEntry."IRN No." := Irn;
        EInvDtlEntry."Document Type" := EInvDtlEntry."Document Type"::Invoice;
        EInvDtlEntry."User ID" := USERID;
        EInvDtlEntry.INSERT;
        if CancelDate <> '' then begin
            RecSalInv.RESET;
            RecSalInv.RESET;
            RecSalInv.SETRANGE(RecSalInv."No.", DocNo);
            IF RecSalInv.FINDFIRST THEN BEGIN
                ;
                //RecSIH1."IRN No." := '';
                //EVALUATE(RecSIH1."E-Invocie Cancel Date", CancelDate);
                RecSalInv."E-Invocie Cancel Date" := COPYSTR(CancelDate, 1, 10);
                RecSalInv."Acknowledgement No." := '';
                RecSalInv."E-inv Cancelled" := true;
                RecSalInv.Modify();
                // RecSIH1."Acknowledgement Date" := '0D';//tk

            END;
        end;
    end;

    local procedure "--------------E-Invoice Credit Memo"()
    begin
    end;


    procedure EInvoicingGenerationCRMemo(RecSIH: Record 114)
    var
        SalesInvoiceLine1: Record 115;
        RecSIL: Record 115;
        SalesInvoiceLine: Record 115;
    begin
        IF Location.GET(RecSIH."Location Code") THEN;
        IF Customer.GET(RecSIH."Sell-to Customer No.") THEN;
        //Location
        Location.TESTFIELD("Phone No.");
        Location.TESTFIELD("GST Registration No.");
        Location.TESTFIELD(City);
        Location.TESTFIELD("State Code");
        Location.TESTFIELD("E-Mail");
        Location.TESTFIELD("Post Code");
        Location.TESTFIELD(Code);
        //Customer
        //Customer.TESTFIELD("Phone No.");
        Customer.TESTFIELD("E-Mail");
        Customer.TESTFIELD("State Code");
        IF Customer."GST Customer Type" = Customer."GST Customer Type"::Registered THEN
            Customer.TESTFIELD("GST Registration No.");

        //Header
        RecSIH.TESTFIELD("Sell-to City");
        RecSIH.TESTFIELD("Sell-to Post Code");
        RecSIH.TESTFIELD("No.");
        RecSIH.TESTFIELD("Nature of Supply", RecSIH."Nature of Supply"::B2B);
        RecSIH.TESTFIELD("Posting Date");
        RecSIH.TESTFIELD("Sell-to Customer Name");

        //"TranDtls"
        // TranDtls := TranDtls.TranDtls;//tk
        TranDtls.add('SupTyp', FORMAT(RecSIH."Nature of Supply"));
        TranDtls.add('TaxSch', 'GST');
        TranDtls.add('RegRev', 'N');
        // transDtl.EcmGstin:='';
        //transDtl.IgstOnIntra:='';

        //DocDtls
        // EInvDocdtl := EInvDocdtl.DocDtls;//tk
        EInvDocdtl.add('Typ', 'CRN');//"INV", "CRN", "DBN"
        EInvDocdtl.add('No', RecSIH."No.");
        EInvDocdtl.add('Dt', FORMAT(RecSIH."Posting Date", 10, '<Day,2>/<Month,2>/<Year4>'));

        //SellerDtls

        // SellerDtls := SellerDtls.SellerDtls;//tk
        SellerDtls.add('Gstin', Location."GST Registration No.");
        //SellerDtls.add('Gstin', '27AMBPG7773M016');
        SellerDtls.add('LglNm', Location.Name);
        SellerDtls.add('TrdNm', Location.Name);
        SellerDtls.add('Addr1', Location.Address);//*

        IF Location."Address 2" <> '' THEN
            SellerDtls.add('Addr2', Location."Address 2");

        SellerDtls.add('Loc', Location.City);
        EVALUATE(pincode, Location."Post Code");
        SellerDtls.add('Pin', pincode);//NT
                                       // SellerDtls.add('Pin', 400020);//NT
        IF State.GET(Location."State Code") THEN;
        //SellerDtls.add('Stcd', '27');
        SellerDtls.add('Stcd', State."State Code (GST Reg. No.)");//RecState.Description;//*
        IF Location."Phone No." <> '' THEN
            SellerDtls.add('Ph', Location."Phone No.");
        IF Location."E-Mail" <> '' THEN
            SellerDtls.add('Em', Location."E-Mail");

        //BuyerDtls

        // WINAR01 ++
        IF RecSIH."Ship-to Code" = '' THEN BEGIN
            IF State1.GET(Customer."State Code") THEN;
            //BuyerDtls := BuyerDtls.BuyerDtls;//tk

            BuyerDtls.add('Gstin', Customer."GST Registration No.");


            BuyerDtls.add('LglNm', RecSIH."Sell-to Customer Name");//*
            BuyerDtls.add('TrdNm', RecSIH."Sell-to Customer Name");
            BuyerDtls.add('Pos', State1."State Code (GST Reg. No.)");//*
            BuyerDtls.add('Addr1', RecSIH."Sell-to Address");//*

            IF RecSIH."Sell-to Address 2" <> '' THEN
                BuyerDtls.add('Addr2', RecSIH."Sell-to Address 2");

            BuyerDtls.add('Loc', RecSIH."Sell-to City");//*
            EVALUATE(pincode, RecSIH."Sell-to Post Code");
            BuyerDtls.add('Pin', pincode);
            IF State.GET(Customer."State Code") THEN;
            BuyerDtls.add('Stcd', State."State Code (GST Reg. No.)");
            IF Customer."Phone No." <> '' THEN
                BuyerDtls.add('Ph', Customer."Phone No.");
            IF Customer."E-Mail" <> '' THEN
                BuyerDtls.add('Em', Customer."E-Mail");
        END;
        // WINAR01 --
        // WINAR01 ++
        // Based on Muliple Ship to Address.
        IF RecSIH."Ship-to Code" <> '' THEN BEGIN
            //BuyerDtls := BuyerDtls.BuyerDtls;//tk old

            ShiptoAddress.RESET;
            ShiptoAddress.SETRANGE("Customer No.", RecSIH."Sell-to Customer No.");
            ShiptoAddress.SETRANGE(Code, RecSIH."Ship-to Code");
            IF ShiptoAddress.FINDFIRST THEN BEGIN
                ShiptoAddress.TESTFIELD("GST Registration No.");
                BuyerDtls.add('Gstin', ShiptoAddress."GST Registration No.");
            END;

            IF State1.GET(ShiptoAddress.State) THEN;
            BuyerDtls.add('LglNm', RecSIH."Ship-to Name");//*
            BuyerDtls.add('TrdNm', RecSIH."Ship-to Name");
            BuyerDtls.add('Pos', State1."State Code (GST Reg. No.)");//*

            BuyerDtls.add('Addr1', RecSIH."Ship-to Address");//*

            IF RecSIH."Ship-to Address 2" <> '' THEN
                BuyerDtls.add('Addr2', RecSIH."Ship-to Address 2");

            BuyerDtls.add('Loc', RecSIH."Ship-to City");//*
            EVALUATE(pincode, RecSIH."Ship-to Post Code");
            BuyerDtls.add('Pin', pincode);
            BuyerDtls.add('Stcd', State1."State Code (GST Reg. No.)");
            IF ShiptoAddress."Phone No." <> '' THEN
                BuyerDtls.add('Ph', ShiptoAddress."Phone No.");
            IF ShiptoAddress."E-Mail" <> '' THEN
                BuyerDtls.add('Em', ShiptoAddress."E-Mail");
        END;
        // WINAR01 ++

        //DispDtls
        // DispDtls := DispDtls.DispDtls;//tk
        DispDtls.add('Nm', Location.Name);//*
        DispDtls.add('Addr1', Location.Address);//*

        IF Location."Address 2" <> '' THEN
            DispDtls.add('Addr2', Location."Address 2");

        DispDtls.add('Loc', Location.City);//*

        EVALUATE(pincode, Location."Post Code");
        DispDtls.add('Pin', pincode);//*

        IF State.GET(Location."State Code") THEN
            DispDtls.add('Stcd', State."State Code (GST Reg. No.)");//*

        //ShipDtls
        //ShipDtls := ShipDtls.ShipDtls;

        IF RecSIH."Ship-to Code" <> '' THEN BEGIN
            ShiptoAddress.RESET;
            ShiptoAddress.SETRANGE("Customer No.", RecSIH."Sell-to Customer No.");
            ShiptoAddress.SETRANGE(Code, RecSIH."Ship-to Code");
            IF ShiptoAddress.FINDFIRST THEN BEGIN
                ShiptoAddress.TESTFIELD("GST Registration No.");
                ShipDtls.add('Gstin', ShiptoAddress."GST Registration No.");
            END;
        END;

        IF RecSIH."Ship-to Code" = '' THEN
            ShipDtls.add('Gstin', Customer."GST Registration No.");//*

        ShipDtls.add('LglNm', RecSIH."Ship-to Name");//*
        ShipDtls.add('TrdNm', RecSIH."Ship-to Name");
        ShipDtls.add('Addr1', RecSIH."Ship-to Address");//*
        ShipDtls.add('Addr2', RecSIH."Ship-to Address");
        ShipDtls.add('Loc', RecSIH."Ship-to City");//*
        EVALUATE(pincode, RecSIH."Ship-to Post Code");
        ShipDtls.add('Pin', pincode);
        if State11.Get(RecSIH."GST Ship-to State Code") then
            ShipDtls.add('Stcd', State11."State Code (GST Reg. No.)")
        else
            ShipDtls.add('Stcd', State1."State Code (GST Reg. No.)");

        //ValDtls
        // WINAR01 ++
        //Value Details Total GST Calculation

        CLEAR(TIGSTAmt);
        CLEAR(TCGSTAmt);
        CLEAR(TSGSTAmt);
        DetailedGSTLedgerEntry.RESET;
        DetailedGSTLedgerEntry.SETRANGE("Document Type", DetailedGSTLedgerEntry."Document Type"::"Credit Memo");
        DetailedGSTLedgerEntry.SETRANGE("Document No.", RecSIH."No.");
        IF DetailedGSTLedgerEntry.FINDFIRST THEN
            REPEAT
                IF DetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN BEGIN
                    TIGSTAmt += ABS(DetailedGSTLedgerEntry."GST Amount");
                END;
                IF DetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN BEGIN
                    TCGSTAmt += ABS(DetailedGSTLedgerEntry."GST Amount");
                END;
                IF DetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN BEGIN
                    TSGSTAmt += ABS(DetailedGSTLedgerEntry."GST Amount");
                END;
            UNTIL DetailedGSTLedgerEntry.NEXT = 0;

        CLEAR(TotalAssAmt);
        CLEAR(Dics);
        CLEAR(OtherCharges);
        SalesInvoiceLine1.RESET;
        SalesInvoiceLine1.SETRANGE("Document No.", RecSIH."No.");
        SalesInvoiceLine1.SETFILTER("No.", '<>%1', '502340');
        IF SalesInvoiceLine1.FINDFIRST THEN BEGIN
            REPEAT
                TotalAssAmt += SalesInvoiceLine1."Amount Including VAT";//tk new
                //tk old//TotalAssAmt += SalesInvoiceLine1."Amount Including Tax"; // - SalesInvoiceLine1."Line Discount Amount";
                Dics += SalesInvoiceLine1."Line Discount Amount";
                OtherCharges += 0;//tk new
                                  //OtherCharges += SalesInvoiceLine1."Charges To Customer";
            UNTIL SalesInvoiceLine1.NEXT = 0;
        END;

        // CLEAR(TCSAmt);//tk++
        // TCSEntry.RESET;
        // TCSEntry.SETRANGE("Document No.", RecSIH."No.");
        // TCSEntry.SETFILTER("TCS Amount", '<>%1', 0);
        // IF TCSEntry.FINDFIRST THEN
        //     TCSAmt := TCSEntry."TCS Amount";//TK--  need to check how to come tcs

        CLEAR(RoundOff);
        SalesInvoiceLine1.RESET;
        SalesInvoiceLine1.SETRANGE("Document No.", RecSIH."No.");
        SalesInvoiceLine1.SETRANGE(Type, SalesInvoiceLine1.Type::"G/L Account");
        SalesInvoiceLine1.SETRANGE("No.", '502340');
        IF SalesInvoiceLine1.FINDFIRST THEN
            RoundOff := SalesInvoiceLine1.Amount;

        CLEAR(TotalInvoiceAmt);
        CustLedgerEntry.RESET;
        CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::"Credit Memo");
        CustLedgerEntry.SETRANGE("Document No.", RecSIH."No.");
        IF CustLedgerEntry.FINDFIRST THEN BEGIN
            CustLedgerEntry.CALCFIELDS("Amount (LCY)");
            TotalInvoiceAmt := CustLedgerEntry."Amount (LCY)";
        END;

        //ValDtls := ValDtls.ValDtls;//tk


        ValDtls.Add('Discount', 0); //Dics;
        ValDtls.Add('AssVal', ABS(TotalAssAmt)); //totinvamt1-RoundOff;//Total Assessable value of all items
        ValDtls.Add('SgstVal', ROUND(TSGSTAmt, 0.01, '='));
        ValDtls.Add('CgstVal', ROUND(TCGSTAmt, 0.01, '='));
        ValDtls.Add('IgstVal', ROUND(TIGSTAmt, 0.01, '='));
        ValDtls.Add('CesVal', 0);
        ValDtls.Add('StCesVal', 0);
        ValDtls.Add('OthChrg', (TCSAmt));
        ValDtls.Add('RndOffAmt', RoundOff);
        ValDtls.Add('TotInvVal', abs(TotalInvoiceAmt));
        //ItemList

        SalesInvoiceLine1.RESET;
        SalesInvoiceLine1.SETRANGE("Document No.", RecSIH."No.");
        SalesInvoiceLine1.SETFILTER(Quantity, '<>%1', 0);
        SalesInvoiceLine1.SETFILTER("No.", '<>%1', '502340');
        IF SalesInvoiceLine1.FINDFIRST THEN
            ArraySize := SalesInvoiceLine1.COUNT;

        //ItemList

        // EInvItemList := EInvItemList.ItemList;//tk
        // varArray := varArray.CreateInstance(EInvItemList.GetType, ArraySize);//tk

        i := 0;
        SNo := 1;

        SalesInvoiceLine.RESET;
        SalesInvoiceLine.SETRANGE("Document No.", RecSIH."No.");
        SalesInvoiceLine.SetFilter(Type, '<>%1', SalesInvoiceLine.Type::" ");
        SalesInvoiceLine.SETFILTER(Quantity, '<>%1', 0);
        SalesInvoiceLine.SETFILTER("No.", '<>%1', '502340');
        IF SalesInvoiceLine.FINDFIRST THEN BEGIN
            REPEAT
                CLEAR(IGSTAmount);
                CLEAR(CGSTAmount);
                CLEAR(SGSTAmount);
                CLEAR(IGSTPer);
                CLEAR(CGSTPer);
                CLEAR(SGSTPer);
                DetailedGSTLedgerEntry.RESET;
                DetailedGSTLedgerEntry.SETRANGE("Transaction Type", DetailedGSTLedgerEntry."Transaction Type"::Sales);
                DetailedGSTLedgerEntry.SETRANGE("Document Type", DetailedGSTLedgerEntry."Document Type"::"Credit Memo");
                DetailedGSTLedgerEntry.SETRANGE("Document No.", SalesInvoiceLine."Document No.");
                DetailedGSTLedgerEntry.SETRANGE("No.", SalesInvoiceLine."No.");
                DetailedGSTLedgerEntry.SETRANGE("Document Line No.", SalesInvoiceLine."Line No.");
                IF DetailedGSTLedgerEntry.FINDFIRST THEN
                    REPEAT
                        IF DetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN BEGIN
                            IGSTPer := DetailedGSTLedgerEntry."GST %";
                            IGSTAmount := ABS(DetailedGSTLedgerEntry."GST Amount");
                        END;
                        IF DetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN BEGIN
                            CGSTPer := DetailedGSTLedgerEntry."GST %";
                            CGSTAmount := ABS(DetailedGSTLedgerEntry."GST Amount");
                        END;
                        IF DetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN BEGIN
                            SGSTPer := DetailedGSTLedgerEntry."GST %";
                            SGSTAmount := ABS(DetailedGSTLedgerEntry."GST Amount");
                        END;
                    UNTIL DetailedGSTLedgerEntry.NEXT = 0;

                SalesInvoiceLine.TESTFIELD("HSN/SAC Code");
                SalesInvoiceLine.TESTFIELD(Quantity);

                IF SalesInvoiceLine."GST Group Type" = SalesInvoiceLine."GST Group Type"::Service THEN
                    IsServ := 'Y'
                ELSE
                    IsServ := 'N';

                // EInvItemList := EInvItemList.ItemList;//tk
                EInvItemList.Add('SlNo', FORMAT(SNo));
                EInvItemList.Add('IsServc', IsServ);//*
                EInvItemList.Add('PrdDesc', SalesInvoiceLine.Description);
                IF SalesInvoiceLine."HSN/SAC Code" <> '' THEN
                    EInvItemList.Add('HsnCd', SalesInvoiceLine."HSN/SAC Code");//*
                                                                               //EInvItemList.BchDtls := 'NULL';
                EInvItemList.Add('Qty', SalesInvoiceLine.Quantity);

                // IF SalesInvoiceLine."Unit of Measure Code" <> '' THEN
                //  IF SalesInvoiceLine."Unit of Measure Code" = 'KG' THEN
                //   SalesInvoiceLine."Unit of Measure Code" := 'KGS';

                //  IF SalesInvoiceLine."Unit of Measure Code" <> '' THEN
                EInvItemList.Add('Unit', FORMAT(SalesInvoiceLine."Unit of Measure Code"));

                EInvItemList.Add('UnitPrice', ROUND(SalesInvoiceLine."Unit Price", 0.01, '='));//*
                EInvItemList.Add('TotAmt', ROUND((SalesInvoiceLine."Unit Price" * SalesInvoiceLine.Quantity), 0.01, '='));//totinvamt;
                EInvItemList.Add('Discount', SalesInvoiceLine."Line Discount Amount");
                EInvItemList.Add('AssAmt', ROUND(ABS((SalesInvoiceLine."Unit Price" * SalesInvoiceLine.Quantity) - SalesInvoiceLine."Line Discount Amount"), 0.01, '='));
                EInvItemList.Add('GstRt', IGSTPer + CGSTPer + SGSTPer);//*
                EInvItemList.Add('CgstAmt', ROUND(ABS(CGSTAmount), 0.01, '='));
                EInvItemList.Add('SgstAmt', ROUND(ABS(SGSTAmount), 0.01, '='));
                EInvItemList.Add('IgstAmt', ROUND(ABS(IGSTAmount), 0.01, '='));

                EInvItemList.Add('CesRt', 0);
                EInvItemList.Add('CesAmt', 0);
                EInvItemList.Add('CesNonAdvlAmt', 0);
                EInvItemList.Add('StateCesRt', 0);
                EInvItemList.Add('StateCesAmt', 0);
                EInvItemList.Add('StateCesNonAdvlAmt', 0);
                EInvItemList.Add('OthChrg', 0);
                //EInvItemList.Add('OthChrg',SalesInvoiceLine."Charges To Customer");
                EInvItemList.Add('TotItemVal', SalesInvoiceLine."Amount Including VAT" + (ABS(CGSTAmount)) + (ABS(SGSTAmount)) + (ABS(IGSTAmount)));

                //   EInvItemList.OthChrg := SalesInvoiceLine."Total TDS/TCS Incl. SHE CESS";
                //   EInvItemList.TotItemVal := SalesInvoiceLine."Amount To Customer";// - SalesInvoiceLine."Total TDS/TCS Incl. SHE CESS";

                //varArray.SetValue(EInvItemList, i);//tk 
                i := i + 1;
                SNo += 1;//123
                varArray.add(EInvItemList);//tk new
                Clear(EInvItemList);//tknew
            UNTIL SalesInvoiceLine.NEXT = 0;
        END;
        RefNo := RecSIH."Reference Invoice No.";
        if salesInvHeader2.get(RefNo) then begin


            RefDtls.Add('invoice_remarks', 'Sales Invoice');
            docprdDtls.Add('invoice_period_start_date', Format(salesInvHeader2."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'));
            docprdDtls.Add('invoice_period_end_date', Format(salesInvHeader2."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'));
            RefDtls.Add('document_period_details', docprdDtls);

            PrcdocDtls.Add('reference_of_original_invoice', RefNo);
            PrcdocDtls.Add('preceding_invoice_date', Format(salesInvHeader2."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'));

            PrcdocArray.Add(PrcdocDtls);
            RefDtls.Add('preceding_document_details', PrcdocArray);
        end;



        //For Login Details
        // ApiLoginDetail := ApiLoginDetail.EInvApiLoginDetails;
        ApiLoginDetail.Add('UserName', Location."E-Invoice User ID");
        ApiLoginDetail.Add('Password', Location."E-Invoice Password");
        ApiLoginDetail.Add('Gstin', Location."GST Registration No.");

        //API Setting
        // EInvoiceAPISetting := EInvoiceAPISetting.EInvApiSetting;
        EInvoiceAPISetting.Add('ClientSecret', '');
        //New version of api's in e-invoice++
        // EInvoiceAPISetting.Add('AuthUrl', 'https://einvapi.charteredinfo.com/eivital/v1.04');
        // EInvoiceAPISetting.Add('BaseUrl', 'https://einvapi.charteredinfo.com/eicore/v1.03');
        // EInvoiceAPISetting.Add('EwbByIRN', 'https://einvapi.charteredinfo.com/eiewb/v1.03');
        // EInvoiceAPISetting.Add('CancelEwbUrl', 'https://einvapi.charteredinfo.com/ewaybillapi/v1.03');
        //New version of api's in e-invoice--




        //E-Invoice Session
        // EInvoiceSession := EInvoiceSession.EInvoiceSession;//tk
        // EInvoiceSession.EInvApiSetting := EInvoiceAPISetting;//tk
        // EInvoiceSession.EInvApiLoginDetails := ApiLoginDetail;//tk

        //Generate IRN
        // ReqGenerateIRN := ReqGenerateIRN.ReqPlGenerateIRN;//tk
        ReqGenerateIRN.Add('Version', '1.1');//tk
        ReqGenerateIRN.Add('TranDtls', TranDtls);
        //  ReqGenerateIRN.ExpDtls:=ExpDtls;
        ReqGenerateIRN.add('DocDtls', EInvDocdtl);
        ReqGenerateIRN.add('SellerDtls', SellerDtls);
        ReqGenerateIRN.add('BuyerDtls', BuyerDtls);
        //ReqGenerateIRN.add('DispDtls', DispDtls);
        //ReqGenerateIRN.add('ShipDtls', ShipDtls);
        ReqGenerateIRN.add('ValDtls', ValDtls);
        //ReqGenerateIRN.PayDtls:=PayDtls;
        //ReqGenerateIRN.RefDtls:=RefDtls;
        ReqGenerateIRN.add('ItemList', varArray);
        ReqGenerateIRN.add('reference_details', RefDtls);

        Message(format(ReqGenerateIRN));
        //GenerateIRN := GenerateIRN.Requests;
        //Result := GenerateIRN.GenrateInvoice(EInvoiceSession, ReqGenerateIRN);
        //PostUrl := 'https://gsp.adaequare.com/test/enriched/ei/api/invoice';//LIVE URL
        PostUrl := 'https://gsp.adaequare.com/enriched/ei/api/invoice';//LIVE URL
        HttpContnt.WriteFrom(format(ReqGenerateIRN));
        HttpContnt.GetHeaders(HttpHdr);
        HttpHdr.Add('user_name', Location."E-Invoice User ID");
        HttpHdr.Add('password', Location."E-Invoice Password");
        HttpHdr.Add('gstin', Location."GST Registration No.");
        // HttpHdr.Add('gstin', '04AMBPG7773M002');
        //HttpHdr.Add('gstin', '01AMBPG7773M002');//tkgst
        //HttpHdr.Add('gstin', '27AMBPG7773M016');//tkgst
        HttpHdr.Add('requestid', ReuestId);
        //HttpHdr.Add('Authorization', 'Bearer ' + GetAccessToken());
        HttpHdr.Remove('Content-Type');//tk
        HttpHdr.Add('Content-Type', 'application/json');
        Httpclint.Timeout(180000);
        Httpclint.DefaultRequestHeaders.Add('Authorization', 'Bearer ' + GetAccessToken());
        // Httpclint.DefaultRequestHeaders.Add('user_name', 'adqgspchusr1');
        // Httpclint.DefaultRequestHeaders.Add('password', 'Gsp@1234');
        // Httpclint.DefaultRequestHeaders.Add('gstin', '04AMBPG7773M002');
        // Httpclint.DefaultRequestHeaders.Add('requestid', ReuestId);
        if Httpclint.Post(PostUrl, HttpContnt, HttpResponseMsg) then begin

            HttpResponseMsg.Content.ReadAs(Result);
            ResultObject.ReadFrom(Result);
        end
        else begin
            HttpResponseMsg.Content.ReadAs(Result);
            ResultObject.ReadFrom(Result);
            Message(Result);
        end;

        ParseResponseCN(Result, RecSIH."No.");
    end;

    local procedure ParseResponseCN(TextResponse: Text; DocNo: Code[20]) messagetype: Text
    var
        dennomination: Decimal;
        p: Integer;
        x: Integer;
        ValuePair: Text;
        CurrentElement: Text;
        FormatChar: Label '{}';
        l: Integer;
        CurrentValue: Text;
        CurrentObject: Text;
        Irn: Text;
        token: Text;
        AckNo: Text;
        AckDt: Text;
        SignedInvoice: Text;
        SignedQRCode: Text;
        Instream: InStream;
        OutStream: OutStream;
        RecSIH1: Record 114;
        SignedQRCode1: Text;
        ResultJson: JsonObject;
        Jtoken: JsonToken;
        messageObject: JsonObject;
        //recref: RecordRef;
        QRGenerator: Codeunit "QR Generator";
        recRef: RecordRef;
        FieldRef: FieldRef;
        TempBlob: codeunit "Temp Blob";
    begin
        CLEAR(Irn);
        CLEAR(AckNo);
        CLEAR(AckDt);
        CLEAR(SignedInvoice);
        CLEAR(SignedQRCode);
        CLEAR(Irn);
        CLEAR(CurrentObject);
        p := 0;
        x := 1;

        ResultJson.ReadFrom(TextResponse);
        ResultJson.Get('success', jtoken);
        if Jtoken.AsValue().AsBoolean() then begin

            if ResultJson.Get('result', jtoken) then begin
                messageObject := jtoken.AsObject();
                if messageObject.Get('AckNo', Jtoken) then
                    AckNo := Jtoken.AsValue().AsText();
                if messageObject.Get('AckDt', Jtoken) then
                    AckDt := Jtoken.AsValue().AsText();
                if messageObject.Get('Irn', Jtoken) then
                    Irn := Jtoken.AsValue().AsText();
                if messageObject.Get('SignedQRCode', Jtoken) then
                    SignedQRCode := Jtoken.AsValue().AsText();


            end;
        end else
            Message(TextResponse);

        //Insert data into Table
        EInvDtlEntry.INIT;
        EInvDtlEntry."Entry No." := 0;
        EInvDtlEntry."Document No." := DocNo;
        EInvDtlEntry."Ack No" := AckNo;
        EInvDtlEntry.AckDate := COPYSTR(AckDt, 1, 10);
        EInvDtlEntry."Inv Transaction" := EInvDtlEntry."Inv Transaction"::"Generate IRN";
        EInvDtlEntry."IRN No." := Irn;
        EInvDtlEntry."User ID" := USERID;
        EInvDtlEntry."Document Type" := EInvDtlEntry."Document Type"::"Credit Memo";
        EInvDtlEntry."Signed Invoice".CREATEOUTSTREAM(OutStream);
        OutStream.WRITE(SignedInvoice);
        EInvDtlEntry.INSERT;
        //EInvDtlEntry."Signed QR Code".CREATEOUTSTREAM(OutStream);
        // OutStream.WRITE(SignedQRCode);

        recRef.Get(EInvDtlEntry.RecordId);
        QRGenerator.GenerateQRCodeImage(SignedQRCode, TempBlob);
        FieldRef := recRef.Field(EInvDtlEntry.FieldNo("Signed QR Code"));
        TempBlob.ToRecordRef(RecRef, EInvDtlEntry.FieldNo("Signed QR Code"));
        recRef.Modify();
        //+++++++++++++++++++++++++

        //QRCodeImg := QRCodeImg.Requests;

        //BigText1.ADDTEXT(QRCodeImg.BaseSignedQRCode(SignedQRCode));

        // abpAutBytes := abpAutConvertBase64.FromBase64String(BigText1);
        // abpAutMemoryStream := abpAutMemoryStream.MemoryStream(abpAutBytes);
        // EInvDtlEntry.BitmapIma.CREATEOUTSTREAM(abpOutStream);
        // abpAutMemoryStream.WriteTo(abpOutStream); np 200623

        //----------------------
        if Irn <> '' then begin
            RecSIH1.RESET;
            RecSIH1.SETRANGE(RecSIH1."No.", DocNo);
            IF RecSIH1.FINDFIRST THEN BEGIN
                ;
                RecSIH1."IRN No." := Irn;
                RecSIH1."Acknowledgement No." := AckNo;
                EVALUATE(RecSIH1."Acknowledgement Date", AckDt);
                //RecSIH1."Acknowledgement Date" := COPYSTR(AckDt, 1, 10);
                //QRMgmt.InitializeSignedQRCode(RecSIH1, SignedQRCode);
                RecSIH1."E-Invocie Cancel Date" := '';
                RecSIH1."E-Invoice Cancel Remark" := '';
                RecSIH1."E-Invoice Reason Code" := RecSIH1."E-Invoice Reason Code"::"0";
                RecSIH1.MODIFY;
                recRef.Get(RecSIH1.RecordId);
                QRGenerator.GenerateQRCodeImage(SignedQRCode, TempBlob);
                FieldRef := recRef.Field(RecSIH1.FieldNo("QR Code"));
                TempBlob.ToRecordRef(RecRef, RecSIH1.FieldNo("QR Code"));
                recRef.Modify();
            END;

        end;
    end;


    procedure CancelEInvTaxProCN(RecSIH: Record 114)
    var
        EinvCancelTaxProMdl: JsonObject;
        reason: Integer;
        RecLocation: Record 14;
    begin



        RecSIH.TESTFIELD(RecSIH."E-Invoice Cancel Remark");
        RecSIH.TESTFIELD(RecSIH."E-Invoice Reason Code");
        RecEinvDtl.RESET;
        RecEinvDtl.SETRANGE("Document No.", RecSIH."No.");
        IF RecEinvDtl.FINDLAST THEN BEGIN
            IF RecLocation.GET(RecSIH."Location Code") THEN;
            //For Login Details
            // ApiLoginDetail := ApiLoginDetail.EInvApiLoginDetails;//tk


            ApiLoginDetail.Add('Gstin', RecLocation."GST Registration No.");
            ApiLoginDetail.Add('UserName', RecLocation."E-Invoice User ID");
            ApiLoginDetail.Add('Password', RecLocation."E-Invoice Password");
            //Cancel Model
            reason := RecSIH."E-Invoice Reason Code";
            // EinvCancelTaxProMdl := EinvCancelTaxProMdl.ReqCancelIRN;//tk
            EinvCancelTaxProMdl.Add('CnlRem', RecSIH."E-Invoice Cancel Remark");
            EinvCancelTaxProMdl.Add('CnlRsn', FORMAT(reason));
            EinvCancelTaxProMdl.Add('Irn', RecEinvDtl."IRN No.");

            //API Setting
            // EInvoiceAPISetting := EInvoiceAPISetting.EInvApiSetting;//tk
            EInvoiceAPISetting.Add('ClientSecret', '');
            //New version of api's in e-invoice++
            // EInvoiceAPISetting.Add('AuthUrl', 'https://einvapi.charteredinfo.com/eivital/v1.04');
            // EInvoiceAPISetting.Add('BaseUrl', 'https://einvapi.charteredinfo.com/eicore/v1.03');
            // EInvoiceAPISetting.Add('EwbByIRN', 'https://einvapi.charteredinfo.com/eiewb/v1.03');
            // EInvoiceAPISetting.Add('CancelEwbUrl', 'https://einvapi.charteredinfo.com/ewaybillapi/v1.03');
            //New version of api's in e-invoice--
            //PostUrl := 'https://gsp.adaequare.com/test/enriched/ei/api/invoice/cancel';
            PostUrl := 'https://gsp.adaequare.com/enriched/ei/api/invoice/cancel';//LIVE URL
            HttpContnt.WriteFrom(Format(EinvCancelTaxProMdl));
            HttpContnt.GetHeaders(HttpHdr);
            HttpHdr.Add('user_name', RecLocation."E-Invoice User ID");
            HttpHdr.Add('password', RecLocation."E-Invoice Password");
            // HttpHdr.Add('gstin', '01AMBPG7773M002');//tkgst
            HttpHdr.Add('gstin', RecLocation."GST Registration No.");
            // HttpHdr.Add('gstin', '27AMBPG7773M016');//tkgst
            HttpHdr.Add('requestid', ReuestId);

            // HttpHdr.Add('app-name', 'Navision');
            // HttpHdr.Add('x-token', '241a4d366da38e2d53361dbe65a36d023065f399');
            HttpHdr.Remove('Content-Type');
            HttpHdr.Add('Content-Type', 'application/json');
            Httpclint.Timeout(180000);
            Httpclint.DefaultRequestHeaders.Add('Authorization', 'Bearer ' + GetAccessToken());

            if Httpclint.Post(PostUrl, HttpContnt, HttpResponseMsg) then begin
                HttpResponseMsg.Content.ReadAs(Result);
                ResultObject.ReadFrom(Result);
            end
            else begin
                HttpResponseMsg.Content.ReadAs(Result);
                ResultObject.ReadFrom(Result);
                MESSAGE(Result);

            END;
            MESSAGE(Result);
            ParseResponseCanCN(Result, RecSIH."No.");

        END;
    end;

    local procedure ParseResponseCanCN(TextResponse: Text; DocNo: Code[20]) messagetype: Text
    var
        dennomination: Decimal;
        p: Integer;
        x: Integer;
        ValuePair: Text;
        CurrentElement: Text;
        FormatChar: Label '{}';
        l: Integer;
        CurrentValue: Text;
        CurrentObject: Text;
        Irn: Text;
        token: Text;
        AckNo: Text;
        AckDt: Text;
        SignedInvoice: Text;
        SignedQRCode: Text;
        Instream: InStream;
        OutStream: OutStream;
        RecSIH1: Record 114;
        CancelDate: Text;
    begin
        CLEAR(Irn);
        CLEAR(AckNo);
        CLEAR(AckDt);
        CLEAR(SignedInvoice);

        CLEAR(CurrentObject);
        p := 0;
        x := 1;

        IF STRPOS(TextResponse, '{}') > 0 THEN
            EXIT;

        TextResponse := DELCHR(TextResponse, '=', FormatChar);
        l := STRLEN(TextResponse);
        Char1 := 9;
        Char2 := 10;
        Char3 := 13;
        WHILE p < l DO BEGIN
            ValuePair := SELECTSTR(x, TextResponse);  // get comma separated pairs of values and element names

            IF STRPOS(ValuePair, ':') > 0 THEN BEGIN
                p := STRPOS(TextResponse, ValuePair) + STRLEN(ValuePair); // move pointer to the end of the current pair in Value

                CurrentElement := COPYSTR(ValuePair, 1, STRPOS(ValuePair, ':'));

                CurrentValue := DELCHR(CurrentValue, '=', ':');
                CurrentElement := DELCHR(CurrentElement, '=', '"');
                CurrentElement := DELCHR(CurrentElement, '=', ',');
                CurrentElement := DELCHR(CurrentElement, '=', '/');

                CurrentValue := COPYSTR(ValuePair, STRPOS(ValuePair, ':'));
                CurrentValue := DELCHR(CurrentValue, '=', ' ');
                CurrentValue := DELCHR(CurrentValue, '=', ':');
                CurrentValue := DELCHR(CurrentValue, '=', '/');
                CurrentValue := DELCHR(CurrentValue, '=', '"');

                CASE CurrentElement OF
                    'Irn:':
                        BEGIN
                            Irn := CurrentValue;

                        END;
                    'CancelDate:':
                        BEGIN
                            CancelDate := CurrentValue;

                        END;

                END;
            END;
            x := x + 1;
        END;
        //Get value from Json Response <<

        //Insert data into Table

        //Insert data into Table
        EInvDtlEntry.INIT;
        EInvDtlEntry."Entry No." := 0;
        EInvDtlEntry."Document No." := DocNo;
        EInvDtlEntry."Ack No" := '';
        EInvDtlEntry.AckDate := '';
        EInvDtlEntry."E-Invoice Cancel Date" := COPYSTR(CancelDate, 1, 10);
        EInvDtlEntry."Inv Transaction" := EInvDtlEntry."Inv Transaction"::Cancelled;
        EInvDtlEntry."IRN No." := Irn;
        EInvDtlEntry."Document Type" := EInvDtlEntry."Document Type"::"Credit Memo";
        EInvDtlEntry."User ID" := USERID;
        EInvDtlEntry.INSERT;
        if CancelDate <> '' then begin
            RecSIH1.RESET;
            RecSIH1.RESET;
            RecSIH1.SETRANGE(RecSIH1."No.", DocNo);
            IF RecSIH1.FINDFIRST THEN BEGIN
                ;
                RecSIH1."IRN No." := '';
                //EVALUATE(RecSIH1."E-Invocie Cancel Date",CancelDate);
                RecSIH1."E-Invocie Cancel Date" := COPYSTR(CancelDate, 1, 10);
                RecSIH1."Acknowledgement No." := '';
                //RecSIH1."E-Invoice Cancel Remark" := 'wrong entry';
                RecSIH1."E-invoice Cancelled" := true;
                //RecSIH1."E-Invoice Reason Code" := 0;
                RecSIH1.MODIFY;
            END;
        end;
    end;

    local procedure "----------------------"()
    begin
    end;


    procedure EInvoicingGenerationTransfer(RecSIH: Record 5744)
    var
        ReqGenerateIRN: JsonObject;
        TranDtls: JsonObject;
        EInvDocdtl: JsonObject;
        ExpDtls: JsonObject;
        SellerDtls: JsonObject;
        StdCode: Integer;
        Postcode: Integer;
        ShipDtls: JsonObject;
        BuyerDtls: JsonObject;
        pincd: Integer;
        Stcd: Integer;
        DispDtls: JsonObject;
        ValDtls: JsonObject;
        othchrg: Decimal;
        Dics: Decimal;
        RecSalesInvLine: Record 5745;
        PayDtls: JsonObject;
        RefDtls: JsonObject;
        EInvItemList: JsonObject;
        RecSIL: Record 5745;
        RecSalesInvLine1: Record 5745;
        ToLocation: Record 14;
        FromLocation: Record 14;
        SalesInvoiceLine: Record 5745;
        SalesInvoiceLine1: Record 5745;
        RecLocation1: Record 14;
        SignedQRCode1: Text;
        ResultJson: JsonObject;
        Jtoken: JsonToken;
        messageObject: JsonObject;
        //recref: RecordRef;
        QRGenerator: Codeunit "QR Generator";
        recRef: RecordRef;
        FieldRef: FieldRef;
        TempBlob: codeunit "Temp Blob";
    begin
        IF FromLocation.GET(RecSIH."Transfer-from Code") THEN;//007
        IF ToLocation.GET(RecSIH."Transfer-to Code") THEN;

        FromLocation.TESTFIELD("E-Invoice User ID");
        FromLocation.TESTFIELD("E-Invoice Password");
        // From Location
        FromLocation.TESTFIELD("Phone No.");
        FromLocation.TESTFIELD("GST Registration No.");
        FromLocation.TESTFIELD(City);
        FromLocation.TESTFIELD("State Code");
        FromLocation.TESTFIELD("E-Mail");
        FromLocation.TESTFIELD("Post Code");
        FromLocation.TESTFIELD(Code);
        //To Location
        ToLocation.TESTFIELD("Phone No.");
        ToLocation.TESTFIELD("GST Registration No.");
        ToLocation.TESTFIELD(City);
        ToLocation.TESTFIELD("State Code");
        ToLocation.TESTFIELD("E-Mail");
        ToLocation.TESTFIELD("Post Code");
        ToLocation.TESTFIELD(Code);


        //Header


        //"TranDtls"
        // TranDtls := TranDtls.TranDtls;//tk
        TranDtls.add('SupTyp', 'B2B');
        TranDtls.add('TaxSch', 'GST');
        TranDtls.add('RegRev', 'N');
        // transDtl.EcmGstin:='';
        //transDtl.IgstOnIntra:='';

        //DocDtls
        // EInvDocdtl := EInvDocdtl.DocDtls;//tk
        EInvDocdtl.add('Typ', 'INV');//"INV", "CRN", "DBN"
        EInvDocdtl.add('No', RecSIH."No.");
        EInvDocdtl.add('Dt', FORMAT(RecSIH."Posting Date", 10, '<Day,2>/<Month,2>/<Year4>'));

        //SellerDtls

        //SellerDtls := SellerDtls.SellerDtls;//tk
        //SellerDtls.add('Gstin', '01AMBPG7773M002');
        //SellerDtls.add('Gstin', '27AMBPG7773M016');
        SellerDtls.add('Gstin', FromLocation."GST Registration No.");
        SellerDtls.add('LglNm', FromLocation.Name);
        SellerDtls.add('TrdNm', FromLocation.Name);
        SellerDtls.add('Addr1', FromLocation.Address);//*

        IF Location."Address 2" <> '' THEN
            SellerDtls.add('Addr2', FromLocation."Address 2");

        SellerDtls.add('Loc', FromLocation.City);
        EVALUATE(pincode, FromLocation."Post Code");
        SellerDtls.add('Pin', 400020);//NT
        //SellerDtls.add('Pin', pincode);//*
        IF State.GET(FromLocation."State Code") THEN;
        //SellerDtls.add('Stcd', '27');//RecState.Description;//*//tk
        SellerDtls.add('Stcd', State."State Code (GST Reg. No.)");//RecState.Description;//*
        IF Location."Phone No." <> '' THEN
            SellerDtls.add('Ph', FromLocation."Phone No.");
        IF Location."E-Mail" <> '' THEN
            SellerDtls.add('Em', FromLocation."E-Mail");

        //BuyerDtls

        IF State1.GET(ToLocation."State Code") THEN;

        // BuyerDtls := BuyerDtls.BuyerDtls;//tk
        BuyerDtls.add('Gstin', ToLocation."GST Registration No.");//*
        BuyerDtls.add('LglNm', ToLocation.Name);//*
        BuyerDtls.add('TrdNm', ToLocation.Name);
        BuyerDtls.add('Pos', State1."State Code (GST Reg. No.)");//*
        BuyerDtls.add('Addr1', ToLocation.Address);//*
        IF ToLocation."Address 2" <> '' THEN
            BuyerDtls.add('Addr2', ToLocation."Address 2");
        BuyerDtls.add('Loc', ToLocation.City);//*
        EVALUATE(pincode, ToLocation."Post Code");
        BuyerDtls.add('Pin', pincode);
        IF State.GET(ToLocation."State Code") THEN;
        BuyerDtls.add('Stcd', State1."State Code (GST Reg. No.)");
        IF Customer."Phone No." <> '' THEN
            BuyerDtls.add('Ph', ToLocation."Phone No.");
        IF Customer."E-Mail" <> '' THEN
            BuyerDtls.add('Em', ToLocation."E-Mail");//pankaj




        //DispDtls
        //DispDtls := DispDtls.DispDtls;
        DispDtls.Add('Nm', FromLocation.Name);//*
        DispDtls.Add('Addr1', FromLocation.Address);//*

        IF Location."Address 2" <> '' THEN
            DispDtls.Add('Addr2', FromLocation."Address 2");

        DispDtls.Add('Loc', FromLocation.City);//*

        EVALUATE(pincode, FromLocation."Post Code");
        DispDtls.Add('Pin', pincode);//*

        IF State.GET(FromLocation."State Code") THEN
            DispDtls.Add('Stcd', State."State Code (GST Reg. No.)");//*

        //ShipDtls
        //ShipDtls := ShipDtls.ShipDtls;//tk

        ShipDtls.Add('Gstin', ToLocation."GST Registration No.");//*

        ShipDtls.Add('LglNm', ToLocation.Name);//*
        ShipDtls.Add('TrdNm', ToLocation.Name);
        ShipDtls.Add('Addr1', ToLocation.Address);//*
                                                  // ShipDtls.Addr2 := RecSIH."Ship-to Address";
        ShipDtls.Add('Loc', ToLocation.City);//*
        EVALUATE(pincode, ToLocation."Post Code");//checking pankaj
        ShipDtls.Add('Pin', pincode);
        ShipDtls.Add('Stcd', State1."State Code (GST Reg. No.)");


        CLEAR(TIGSTAmt);
        CLEAR(TCGSTAmt);
        CLEAR(TSGSTAmt);
        DetailedGSTLedgerEntry.RESET;
        DetailedGSTLedgerEntry.SETRANGE("Document Type", DetailedGSTLedgerEntry."Document Type"::Invoice);
        DetailedGSTLedgerEntry.SETRANGE("Document No.", RecSIH."No.");
        IF DetailedGSTLedgerEntry.FINDFIRST THEN
            REPEAT
                IF DetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN BEGIN
                    TIGSTAmt += ABS(DetailedGSTLedgerEntry."GST Amount");
                END;
                IF DetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN BEGIN
                    TCGSTAmt += ABS(DetailedGSTLedgerEntry."GST Amount");
                END;
                IF DetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN BEGIN
                    TSGSTAmt += ABS(DetailedGSTLedgerEntry."GST Amount");
                END;
            UNTIL DetailedGSTLedgerEntry.NEXT = 0;

        CLEAR(TotalAssAmt);
        CLEAR(Dics);
        CLEAR(OtherCharges);
        SalesInvoiceLine1.RESET;
        SalesInvoiceLine1.SETRANGE("Document No.", RecSIH."No.");
        // SalesInvoiceLine1.SETFILTER("No.",'<>%1','3010304');
        IF SalesInvoiceLine1.FINDFIRST THEN BEGIN
            REPEAT
                TotalAssAmt += 0; //tk
                TotalAssAmt += SalesInvoiceLine1.Amount; // - SalesInvoiceLine1."Line Discount Amount";
                                                         // Dics += SalesInvoiceLine1."Line Discount Amount";
                                                         // OtherCharges += SalesInvoiceLine1."Charges To Customer";
            UNTIL SalesInvoiceLine1.NEXT = 0;
        END;

        // CLEAR(TCSAmt);//tk++
        // TCSEntry.RESET;
        // TCSEntry.SETRANGE("Document No.", RecSIH."No.");
        // TCSEntry.SETFILTER("TCS Amount", '<>%1', 0);
        // IF TCSEntry.FINDFIRST THEN
        //     TCSAmt := TCSEntry."TCS Amount";//TK--

        CLEAR(RoundOff);
        SalesInvoiceLine1.RESET;
        SalesInvoiceLine1.SETRANGE("Document No.", RecSIH."No.");
        // SalesInvoiceLine1.SETRANGE(Type, SalesInvoiceLine1.Type::"G/L Account");
        // SalesInvoiceLine1.SETRANGE("No.",'3010304');
        IF SalesInvoiceLine1.FINDFIRST THEN
            RoundOff := 0;//SalesInvoiceLine1.Amount;

        CLEAR(TotalInvoiceAmt);
        CustLedgerEntry.RESET;
        CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
        CustLedgerEntry.SETRANGE("Document No.", RecSIH."No.");
        IF CustLedgerEntry.FINDFIRST THEN BEGIN
            CustLedgerEntry.CALCFIELDS("Amount (LCY)");
            TotalInvoiceAmt := CustLedgerEntry."Amount (LCY)";
        END;

        //ValDtls := ValDtls.ValDtls;//tk

        ValDtls.Add('Discount', 0); //Dics;
        ValDtls.Add('AssVal', TotalAssAmt); //totinvamt1-RoundOff;//Total Assessable value of all items
        ValDtls.Add('SgstVal', ROUND(TSGSTAmt, 0.01, '='));
        ValDtls.Add('CgstVal', ROUND(TCGSTAmt, 0.01, '='));
        ValDtls.Add('IgstVal', ROUND(TIGSTAmt, 0.01, '='));
        ValDtls.Add('CesVal', 0);
        ValDtls.Add('StCesVal', 0);
        ValDtls.Add('OthChrg', ABS(TCSAmt));
        ValDtls.Add('RndOffAmt', RoundOff);
        ValDtls.Add('TotInvVal', TotalAssAmt + ROUND(TSGSTAmt + TCGSTAmt + TIGSTAmt, 0.01, '='));
        //ItemList

        SalesInvoiceLine1.RESET;
        SalesInvoiceLine1.SETRANGE("Document No.", RecSIH."No.");
        SalesInvoiceLine1.SETFILTER(Quantity, '<>%1', 0);
        // SalesInvoiceLine1.SETFILTER("No.",'<>%1','3010304');
        IF SalesInvoiceLine1.FINDFIRST THEN
            ArraySize := SalesInvoiceLine1.COUNT;

        //ItemList

        // EInvItemList := EInvItemList.ItemList;//tk
        // varArray := varArray.CreateInstance(EInvItemList.GetType, ArraySize);//tk

        i := 0;
        SNo := 1;

        SalesInvoiceLine.RESET;
        SalesInvoiceLine.SETRANGE("Document No.", RecSIH."No.");
        SalesInvoiceLine.SETFILTER(Quantity, '<>%1', 0);

        IF SalesInvoiceLine.FINDFIRST THEN BEGIN
            REPEAT
                CLEAR(IGSTAmount);
                CLEAR(CGSTAmount);
                CLEAR(SGSTAmount);
                CLEAR(IGSTPer);
                CLEAR(CGSTPer);
                CLEAR(SGSTPer);
                DetailedGSTLedgerEntry.RESET;
                DetailedGSTLedgerEntry.SETRANGE("Transaction Type", DetailedGSTLedgerEntry."Transaction Type"::Sales);
                //  DetailedGSTLedgerEntry.SETRANGE("Document Type",DetailedGSTLedgerEntry."Document Type"::"Credit Memo");
                DetailedGSTLedgerEntry.SETRANGE("Document No.", SalesInvoiceLine."Document No.");
                // DetailedGSTLedgerEntry.SETRANGE("No.", SalesInvoiceLine."No.");
                DetailedGSTLedgerEntry.SETRANGE("Document Line No.", SalesInvoiceLine."Line No.");
                IF DetailedGSTLedgerEntry.FINDFIRST THEN
                    REPEAT
                        IF DetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN BEGIN
                            IGSTPer := DetailedGSTLedgerEntry."GST %";
                            IGSTAmount := ABS(DetailedGSTLedgerEntry."GST Amount");
                        END;
                        IF DetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN BEGIN
                            CGSTPer := DetailedGSTLedgerEntry."GST %";
                            CGSTAmount := ABS(DetailedGSTLedgerEntry."GST Amount");
                        END;
                        IF DetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN BEGIN
                            SGSTPer := DetailedGSTLedgerEntry."GST %";
                            SGSTAmount := ABS(DetailedGSTLedgerEntry."GST Amount");
                        END;
                    UNTIL DetailedGSTLedgerEntry.NEXT = 0;

                SalesInvoiceLine.TESTFIELD("HSN/SAC Code");
                SalesInvoiceLine.TESTFIELD(Quantity);



                //EInvItemList := EInvItemList.ItemList;
                EInvItemList.Add('SlNo', FORMAT(SNo));
                EInvItemList.Add('IsServc', 'N');//*
                EInvItemList.Add('PrdDesc', SalesInvoiceLine.Description);
                IF SalesInvoiceLine."HSN/SAC Code" <> '' THEN
                    EInvItemList.Add('HsnCd', SalesInvoiceLine."HSN/SAC Code");//*
                                                                               //EInvItemList.BchDtls := 'NULL';
                EInvItemList.Add('Qty', SalesInvoiceLine.Quantity);

                IF SalesInvoiceLine."Unit of Measure Code" <> '' THEN
                    IF SalesInvoiceLine."Unit of Measure Code" = 'KG' THEN
                        SalesInvoiceLine."Unit of Measure Code" := 'KGS';
                //pankaj
                IF SalesInvoiceLine."Unit of Measure Code" = 'NO' THEN
                    SalesInvoiceLine."Unit of Measure Code" := 'NOS';
                //pankaj

                IF SalesInvoiceLine."Unit of Measure Code" <> '' THEN
                    EInvItemList.Add('Unit', FORMAT(SalesInvoiceLine."Unit of Measure Code"));
                CLEAR(TotAmt);
                TotAmt := SalesInvoiceLine."Unit Price" * SalesInvoiceLine.Quantity;
                EInvItemList.Add('UnitPrice', ROUND(SalesInvoiceLine."Unit Price", 0.01, '='));//*
                EInvItemList.Add('TotAmt', ROUND((TotAmt), 0.01, '='));//totinvamt;
                EInvItemList.Add('Discount', 0);// SalesInvoiceLine."Line Discount Amount";
                EInvItemList.Add('AssAmt', ROUND(ABS((TotAmt)), 0.01, '='));
                EInvItemList.Add('GstRt', IGSTPer + CGSTPer + SGSTPer);//*
                EInvItemList.Add('CgstAmt', ROUND(ABS(CGSTAmount), 0.01, '='));
                EInvItemList.Add('SgstAmt', ROUND(ABS(SGSTAmount), 0.01, '='));
                EInvItemList.Add('IgstAmt', ROUND(ABS(IGSTAmount), 0.01, '='));

                EInvItemList.Add('CesRt', 0);
                EInvItemList.Add('CesAmt', 0);
                EInvItemList.Add('CesNonAdvlAmt', 0);
                EInvItemList.Add('StateCesRt', 0);
                EInvItemList.Add('StateCesAmt', 0);
                EInvItemList.Add('StateCesNonAdvlAmt', 0);
                EInvItemList.Add('OthChrg', 0);//SalesInvoiceLine."Charges To Customer";
                EInvItemList.Add('TotItemVal', ROUND(TotAmt + ABS(CGSTAmount + SGSTAmount + IGSTAmount), 0.01, '='));

                //   EInvItemList.OthChrg := SalesInvoiceLine."Total TDS/TCS Incl. SHE CESS";
                //   EInvItemList.TotItemVal := SalesInvoiceLine."Amount To Customer";// - SalesInvoiceLine."Total TDS/TCS Incl. SHE CESS";

                //varArray.SetValue(EInvItemList, i);//tk
                i := i + 1;
                SNo += 1;//tk12
                varArray.add(EInvItemList);//tk new
                Clear(EInvItemList);//tknew
            UNTIL SalesInvoiceLine.NEXT = 0;
        END;

        //For Login Details
        IF RecLocation1.GET(RecSIH."Transfer-from Code") THEN;
        RecLocation1.TESTFIELD("E-Invoice User ID");
        RecLocation1.TESTFIELD("E-Invoice Password");
        // ApiLoginDetail := ApiLoginDetail.EInvApiLoginDetails;
        ApiLoginDetail.Add('UserName', RecLocation1."E-Invoice User ID");
        ApiLoginDetail.Add('Password', RecLocation1."E-Invoice Password");
        ApiLoginDetail.Add('Gstin', RecLocation1."GST Registration No.");

        //API Setting
        //EInvoiceAPISetting := EInvoiceAPISetting.EInvApiSetting;//tk
        EInvoiceAPISetting.Add('ClientSecret', '');
        //New version of api's in e-invoice++
        // EInvoiceAPISetting.Add('AuthUrl', 'https://einvapi.charteredinfo.com/eivital/v1.04');
        // EInvoiceAPISetting.Add('BaseUrl', 'https://einvapi.charteredinfo.com/eicore/v1.03');
        // EInvoiceAPISetting.Add('EwbByIRN', 'https://einvapi.charteredinfo.com/eiewb/v1.03');
        // EInvoiceAPISetting.Add('CancelEwbUrl', 'https://einvapi.charteredinfo.com/ewaybillapi/v1.03');
        //New version of api's in e-invoice--




        //E-Invoice Session
        // EInvoiceSession := EInvoiceSession.EInvoiceSession;//TK++
        // EInvoiceSession.EInvApiSetting := EInvoiceAPISetting;
        // EInvoiceSession.EInvApiLoginDetails := ApiLoginDetail;//Tk--

        //Generate IRN
        // ReqGenerateIRN := ReqGenerateIRN.ReqPlGenerateIRN;
        ReqGenerateIRN.Add('Version', '1.1');
        ReqGenerateIRN.Add('TranDtls', TranDtls);
        //  ReqGenerateIRN.ExpDtls:=ExpDtls;
        ReqGenerateIRN.Add('DocDtls', EInvDocdtl);
        ReqGenerateIRN.Add('SellerDtls', SellerDtls);
        ReqGenerateIRN.Add('BuyerDtls', BuyerDtls);
        ReqGenerateIRN.Add('DispDtls', DispDtls);
        //  ReqGenerateIRN.ShipDtls:=ShipDtls;//pankaj
        ReqGenerateIRN.Add('ValDtls', ValDtls);
        //ReqGenerateIRN.PayDtls:=PayDtls;
        //ReqGenerateIRN.RefDtls:=RefDtls;
        ReqGenerateIRN.Add('ItemList', varArray);

        Message(format(ReqGenerateIRN));
        //GenerateIRN := GenerateIRN.Requests;
        //Result := GenerateIRN.GenrateInvoice(EInvoiceSession, ReqGenerateIRN);
        PostUrl := 'https://gsp.adaequare.com/enriched/ei/api/invoice';//LIVE URL
        HttpContnt.WriteFrom(format(ReqGenerateIRN));
        HttpContnt.GetHeaders(HttpHdr);
        HttpHdr.Add('user_name', FromLocation."E-Invoice User ID");
        HttpHdr.Add('password', FromLocation."E-Invoice Password");
        // HttpHdr.Add('gstin', Location."GST Registration No.");
        // HttpHdr.Add('gstin', '04AMBPG7773M002');
        // HttpHdr.Add('gstin', '01AMBPG7773M002');//tkgst
        HttpHdr.Add('gstin', FromLocation."GST Registration No.");
        // HttpHdr.Add('gstin', '27AMBPG7773M016');//tkgst
        HttpHdr.Add('requestid', ReuestId);
        //HttpHdr.Add('Authorization', 'Bearer ' + GetAccessToken());
        HttpHdr.Remove('Content-Type');//tk
        HttpHdr.Add('Content-Type', 'application/json');
        Httpclint.Timeout(180000);
        Httpclint.DefaultRequestHeaders.Add('Authorization', 'Bearer ' + GetAccessToken());
        // Httpclint.DefaultRequestHeaders.Add('user_name', 'adqgspchusr1');
        // Httpclint.DefaultRequestHeaders.Add('password', 'Gsp@1234');
        // Httpclint.DefaultRequestHeaders.Add('gstin', '04AMBPG7773M002');
        // Httpclint.DefaultRequestHeaders.Add('requestid', ReuestId);
        if Httpclint.Post(PostUrl, HttpContnt, HttpResponseMsg) then begin

            HttpResponseMsg.Content.ReadAs(Result);
            ResultObject.ReadFrom(Result);
        end
        else begin
            HttpResponseMsg.Content.ReadAs(Result);
            ResultObject.ReadFrom(Result);
            Message(Result);
        end;

        ParseResponseTrans(Result, RecSIH."No.");
    end;


    local procedure ParseResponseTrans(TextResponse: Text; DocNo: Code[20]) messagetype: Text
    var
        dennomination: Decimal;
        p: Integer;
        x: Integer;
        ValuePair: Text;
        CurrentElement: Text;
        FormatChar: Label '{}';
        l: Integer;
        CurrentValue: Text;
        CurrentObject: Text;
        Irn1: Text;
        token: Text;
        AckNo1: Text;
        AckDt1: Text;
        SignedInvoice1: Text;
        SignedQRCode1: Text;
        Instream: InStream;
        OutStream: OutStream;
        RecTSH1: Record 5744;
        //SignedQRCode1: Text;

        ResultJson: JsonObject;
        Jtoken: JsonToken;
        messageObject: JsonObject;
        //recref: RecordRef;
        QRGenerator: Codeunit "QR Generator";
        recRef: RecordRef;
        FieldRef: FieldRef;
        TempBlob: codeunit "Temp Blob";
    begin
        CLEAR(Irn1);
        CLEAR(AckNo1);
        CLEAR(AckDt1);
        CLEAR(SignedInvoice1);
        CLEAR(SignedQRCode1);
        // CLEAR(Irn1);
        CLEAR(CurrentObject);
        p := 0;
        x := 1;

        ResultJson.ReadFrom(TextResponse);
        ResultJson.Get('success', jtoken);
        if Jtoken.AsValue().AsBoolean() then begin

            if ResultJson.Get('result', jtoken) then begin
                messageObject := jtoken.AsObject();
                if messageObject.Get('AckNo', Jtoken) then
                    AckNo1 := Jtoken.AsValue().AsText();
                if messageObject.Get('AckDt', Jtoken) then
                    AckDt1 := Jtoken.AsValue().AsText();
                if messageObject.Get('Irn', Jtoken) then
                    Irn1 := Jtoken.AsValue().AsText();
                if messageObject.Get('SignedQRCode', Jtoken) then
                    SignedQRCode1 := Jtoken.AsValue().AsText();


            end;
        end else
            Message(TextResponse);

        //Insert data into Table
        EInvDtlEntry.INIT;
        EInvDtlEntry."Entry No." := 0;
        EInvDtlEntry."Document No." := DocNo;
        EInvDtlEntry."Ack No" := AckNo1;

        EInvDtlEntry.AckDate := COPYSTR(AckDt1, 1, 10);
        EInvDtlEntry."Inv Transaction" := EInvDtlEntry."Inv Transaction"::"Generate IRN";
        EInvDtlEntry."IRN No." := Irn1;
        EInvDtlEntry."User ID" := USERID;
        EInvDtlEntry."Document Type" := EInvDtlEntry."Document Type"::Invoice;
        EInvDtlEntry."Signed Invoice".CREATEOUTSTREAM(OutStream);
        OutStream.WRITE(SignedInvoice1);
        EInvDtlEntry.INSERT;
        //EInvDtlEntry."Signed QR Code".CREATEOUTSTREAM(OutStream);
        // OutStream.WRITE(SignedQRCode);

        recRef.Get(EInvDtlEntry.RecordId);
        QRGenerator.GenerateQRCodeImage(SignedQRCode1, TempBlob);
        FieldRef := recRef.Field(EInvDtlEntry.FieldNo("Signed QR Code"));
        TempBlob.ToRecordRef(RecRef, EInvDtlEntry.FieldNo("Signed QR Code"));
        recRef.Modify();
        //+++++++++++++++++++++++++

        //QRCodeImg := QRCodeImg.Requests;

        //BigText1.ADDTEXT(QRCodeImg.BaseSignedQRCode(SignedQRCode));

        // abpAutBytes := abpAutConvertBase64.FromBase64String(BigText1);
        // abpAutMemoryStream := abpAutMemoryStream.MemoryStream(abpAutBytes);
        // EInvDtlEntry.BitmapIma.CREATEOUTSTREAM(abpOutStream);
        // abpAutMemoryStream.WriteTo(abpOutStream); np 200623

        //----------------------
        if Irn1 <> '' then begin
            RecTSH1.RESET;
            RecTSH1.SETRANGE(RecTSH1."No.", DocNo);
            IF RecTSH1.FINDFIRST THEN BEGIN
                ;
                RecTSH1."IRN No." := Irn1;
                RecTSH1."MAcknowledgement No." := AckNo1;
                EVALUATE(RecTSH1."MAcknowledgement Date", CopyStr(AckDt1, 1, 10));
                //RecSIH1."Acknowledgement Date" := COPYSTR(AckDt, 1, 10);
                //QRMgmt.InitializeSignedQRCode(RecSIH1, SignedQRCode);
                RecTSH1."E-Invocie Cancel Date" := '';
                RecTSH1."E-Invoice Cancel Remark" := '';
                RecTSH1."E-Invoice Reason Code" := RecTSH1."E-Invoice Reason Code"::"0";
                RecTSH1.MODIFY;
                recRef.Get(RecTSH1.RecordId);
                QRGenerator.GenerateQRCodeImage(SignedQRCode1, TempBlob);
                FieldRef := recRef.Field(RecTSH1.FieldNo("MQR Code"));//tk
                TempBlob.ToRecordRef(RecRef, RecTSH1.FieldNo("MQR Code"));//tk
                recRef.Modify();
            END;
        end;
    end;


    procedure CancelEInvTaxProTra(RecSIH: Record 5744)
    var
        EinvCancelTaxProMdl: JsonObject;
        reason: Integer;
        RecLocation: Record 14;
    begin
        // RecEinvDtl.RESET;
        //RecEinvDtl.SETRANGE("Document No.",RecSIH."No.");
        //IF RecEinvDtl.FINDLAST THEN BEGIN
        IF RecLocation.GET(RecSIH."Transfer-from Code") THEN;
        //For Login Details

        // ApiLoginDetail := ApiLoginDetail.EInvApiLoginDetails;
        ApiLoginDetail.Add('UserName', RecLocation."E-Invoice User ID");
        ApiLoginDetail.Add('Password', RecLocation."E-Invoice Password");
        ApiLoginDetail.Add('Gstin', RecLocation."GST Registration No.");

        //Cancel Model
        reason := RecSIH."E-Invoice Reason Code";
        // EinvCancelTaxProMdl := EinvCancelTaxProMdl.ReqCancelIRN;//tk
        EinvCancelTaxProMdl.Add('CnlRem', RecSIH."E-Invoice Cancel Remark");
        EinvCancelTaxProMdl.Add('CnlRsn', FORMAT(reason));
        EinvCancelTaxProMdl.Add('Irn', RecSIH."IRN No.");

        //API Setting
        // EInvoiceAPISetting := EInvoiceAPISetting.EInvApiSetting;
        EInvoiceAPISetting.Add('ClientSecret', '');
        //New version of api's in e-invoice++
        // EInvoiceAPISetting.Add('AuthUrl', 'https://einvapi.charteredinfo.com/eivital/v1.04');
        // EInvoiceAPISetting.Add('BaseUrl', 'https://einvapi.charteredinfo.com/eicore/v1.03');
        // EInvoiceAPISetting.Add('EwbByIRN', 'https://einvapi.charteredinfo.com/eiewb/v1.03');
        // EInvoiceAPISetting.Add('CancelEwbUrl', 'https://einvapi.charteredinfo.com/ewaybillapi/v1.03');
        //New version of api's in e-invoice--
        PostUrl := 'https://gsp.adaequare.com/enriched/ei/api/invoice/cancel';
        //PostUrl := 'https://gsp.adaequare.com/test/enriched/ei/api/invoice/cancel';//LIVE URL
        HttpContnt.WriteFrom(Format(EinvCancelTaxProMdl));
        HttpContnt.GetHeaders(HttpHdr);
        HttpHdr.Add('user_name', RecLocation."E-Invoice User ID");
        HttpHdr.Add('password', RecLocation."E-Invoice Password");
        // HttpHdr.Add('gstin', '01AMBPG7773M002');//tkgst
        HttpHdr.Add('gstin', RecLocation."gst registration no.");
        HttpHdr.Add('gstin', '27AMBPG7773M016');//tkgst
        HttpHdr.Add('requestid', ReuestId);

        // HttpHdr.Add('app-name', 'Navision');
        // HttpHdr.Add('x-token', '241a4d366da38e2d53361dbe65a36d023065f399');
        HttpHdr.Remove('Content-Type');
        HttpHdr.Add('Content-Type', 'application/json');
        Httpclint.Timeout(180000);
        Httpclint.DefaultRequestHeaders.Add('Authorization', 'Bearer ' + GetAccessToken());

        if Httpclint.Post(PostUrl, HttpContnt, HttpResponseMsg) then begin
            HttpResponseMsg.Content.ReadAs(Result);
            ResultObject.ReadFrom(Result);
        end
        else begin
            HttpResponseMsg.Content.ReadAs(Result);
            ResultObject.ReadFrom(Result);
            MESSAGE(Result);

        END;

        MESSAGE(Result);
        ParseResponseCanTra(Result, RecSIH."No.");

        //END;
    end;

    local procedure ParseResponseCanTra(TextResponse: Text; DocNo: Code[20]) messagetype: Text
    var
        dennomination: Decimal;
        p: Integer;
        x: Integer;
        ValuePair: Text;
        CurrentElement: Text;
        FormatChar: Label '{}';
        l: Integer;
        CurrentValue: Text;
        CurrentObject: Text;
        Irn: Text;
        token: Text;
        AckNo: Text;
        AckDt: Text;
        SignedInvoice: Text;
        SignedQRCode: Text;
        Instream: InStream;
        OutStream: OutStream;
        RecSIH1: Record 5744;
        CancelDate: Text;
    begin
        CLEAR(Irn);
        CLEAR(AckNo);
        CLEAR(AckDt);
        CLEAR(SignedInvoice);

        CLEAR(CurrentObject);
        p := 0;
        x := 1;

        IF STRPOS(TextResponse, '{}') > 0 THEN
            EXIT;

        TextResponse := DELCHR(TextResponse, '=', FormatChar);
        l := STRLEN(TextResponse);
        Char1 := 9;
        Char2 := 10;
        Char3 := 13;
        WHILE p < l DO BEGIN
            ValuePair := SELECTSTR(x, TextResponse);  // get comma separated pairs of values and element names

            IF STRPOS(ValuePair, ':') > 0 THEN BEGIN
                p := STRPOS(TextResponse, ValuePair) + STRLEN(ValuePair); // move pointer to the end of the current pair in Value

                CurrentElement := COPYSTR(ValuePair, 1, STRPOS(ValuePair, ':'));

                CurrentValue := DELCHR(CurrentValue, '=', ':');
                CurrentElement := DELCHR(CurrentElement, '=', '"');
                CurrentElement := DELCHR(CurrentElement, '=', ',');
                CurrentElement := DELCHR(CurrentElement, '=', '/');

                CurrentValue := COPYSTR(ValuePair, STRPOS(ValuePair, ':'));
                CurrentValue := DELCHR(CurrentValue, '=', ' ');
                CurrentValue := DELCHR(CurrentValue, '=', ':');
                CurrentValue := DELCHR(CurrentValue, '=', '/');
                CurrentValue := DELCHR(CurrentValue, '=', '"');

                CASE CurrentElement OF
                    'Irn:':
                        BEGIN
                            Irn := CurrentValue;

                        END;
                    'CancelDate:':
                        BEGIN
                            CancelDate := CurrentValue;

                        END;

                END;
            END;
            x := x + 1;
        END;
        //Get value from Json Response <<

        //Insert data into Table
        EInvDtlEntry.INIT;
        EInvDtlEntry."Entry No." := 0;
        EInvDtlEntry."Document No." := DocNo;
        EInvDtlEntry."Ack No" := '';
        EInvDtlEntry.AckDate := '';
        EInvDtlEntry."E-Invoice Cancel Date" := COPYSTR(CancelDate, 1, 10);
        EInvDtlEntry."Inv Transaction" := EInvDtlEntry."Inv Transaction"::Cancelled;
        EInvDtlEntry."IRN No." := Irn;
        EInvDtlEntry."Document Type" := EInvDtlEntry."Document Type"::Invoice;
        EInvDtlEntry."User ID" := USERID;
        EInvDtlEntry.INSERT;
        if CancelDate <> '' then begin
            RecSIH1.RESET;
            RecSIH1.SETRANGE(RecSIH1."No.", DocNo);
            IF RecSIH1.FINDFIRST THEN BEGIN
                ;
                RecSIH1."IRN No." := '';
                //EVALUATE(RecSIH1."E-Invocie Cancel Date",CancelDate);
                RecSIH1."E-Invocie Cancel Date" := COPYSTR(CancelDate, 1, 10);
                RecSIH1."MAcknowledgement No." := '';
                // RecSIH1."Acknowledgement Date" := 0DT;// '';
                RecSIH1."MAcknowledgement Date" := '';
                RecSIH1."Envoice Cancelled" := true;

                // RecSIH1."E-Invoice Cancel Remark":='';
                // RecSIH1."E-Invoice Reason Code":='';
                RecSIH1.MODIFY;
            END;
        end;
    end;

    local procedure "----------------Eway Bill By IRN-------------"()
    begin
    end;


    procedure "E-WayBillByIRN"(RecSIH: Record 112)
    var
        GenerateEwayBillByIRN: JsonObject;
        RecSipAgent: Record 291;
        RecSIH2: Record 112;
        GenText: Label 'Do You Want to Generate E-Way Bill No.';

        VARVehicleType: Option ,R,O;
        ExpShipDtls: JsonObject;
        recstcd: Record State;
        GenerateEwayBill: JsonObject;
        pincode: Integer;
        DispDtls: JsonObject;
        dispstate: Record State;
        shipstate: Record State;
        shippin: Integer;
        disppin: Integer;
    begin
        // GenerateEwayBillByIRN := GenerateEwayBillByIRN.ReqGenrateEWayBillModel;//tk
        RecSIH.TESTFIELD("IRN No.");

        //Body++
        IF Location.GET(RecSIH."Location Code") THEN;
        IF RecLocation.GET(RecSIH."Location Code") THEN;
        VARVehicleType := RecSIH."Vehicle Type";

        GenerateEwayBillByIRN.Add('Irn', RecSIH."IRN No.");
        IF RecSipAgent.GET(RecSIH."Shipping Agent Code") THEN BEGIN

            GenerateEwayBillByIRN.Add('TransId', RecSipAgent."GST Registration No");
            GenerateEwayBillByIRN.Add('TransName', RecSipAgent.Name);
        END;
        IF RecSipAgent."GST Registration No" = '' THEN BEGIN
            GenerateEwayBillByIRN.Add('TransDocNo', RecSIH."No.");//Needs to confirm
            GenerateEwayBillByIRN.Add('TransDocDt', FORMAT(RecSIH."Posting Date", 10, '<Day,2>/<Month,2>/<Year4>'));
            GenerateEwayBillByIRN.Add('TransMode', RecSIH."Mode of Transport");
            GenerateEwayBillByIRN.Add('VehNo', RecSIH."Vehicle No.");
            //    GenerateEwayBillByIRN.Add('Distance', RecSIH.Distance);
            VARVehicleType := RecSIH."Vehicle Type";
            GenerateEwayBillByIRN.Add('VehType', FORMAT(VARVehicleType));

        END;

        IF RecSipAgent.GET(RecSIH."Shipping Agent Code") THEN;
        //RecSipAgent.TESTFIELD("Transportar GSTIN");



        // IF RecSipAgent."GST Registration No" = '' THEN BEGIN
        //     GenerateEwayBillByIRN.Add('TransMode', RecSIH."Transport Method");
        //     GenerateEwayBillByIRN.Add('VehNo', RecSIH."Vehicle No.");
        //     VARVehicleType := RecSIH."Vehicle Type";
        //     GenerateEwayBillByIRN.Add('VehType', FORMAT(VARVehicleType));
        //     GenerateEwayBillByIRN.Add('TransDocNo', RecSIH."No.");//Needs to confirm
        // END;

        GenerateEwayBillByIRN.Add('Distance', 0);//tk
        //BoDy--

        // //ExpDetails
        // // ExpShipDtls := ExpShipDtls.ExpShipDetails;
        // IF shipstate.GET(RecSIH.State) THEN;
        // ExpShipDtls.Add('Addr1', RecSIH."Ship-to Address");
        // ExpShipDtls.Add('Addr2', RecSIH."Ship-to Address 2");
        // ExpShipDtls.Add('Loc', RecSIH."Ship-to City");
        // EVALUATE(shippin, RecSIH."Sell-to Post Code");
        // ExpShipDtls.Add('Pin', RecSIH."Sell-to Post Code");
        // ExpShipDtls.Add('Stcd', shipstate."State Code (GST Reg. No.)");
        // GenerateEwayBillByIRN.Add('ExpShipDtls', ExpShipDtls);

        // //DispDetails
        // // DispDtls := DispDtls.DispDetails;
        // DispDtls.Add('Nm', RecLocation.Name);
        // DispDtls.Add('Addr1', RecLocation.Address);
        // DispDtls.Add('Addr2', RecLocation."Address 2");
        // DispDtls.Add('Loc', RecLocation.City);
        // EVALUATE(disppin, RecLocation."Post Code");
        // DispDtls.Add('Pin', disppin);
        // IF dispstate.GET(RecLocation."State Code") THEN;
        // DispDtls.Add('Stcd', dispstate."State Code (GST Reg. No.)");
        // GenerateEwayBillByIRN.Add('DispDtls', DispDtls);

        //For Login Details
        // ApiLoginDetail := ApiLoginDetail.EInvApiLoginDetails;
        ApiLoginDetail.Add('Gstin', RecLocation."GST Registration No.");
        ApiLoginDetail.Add('UserName', RecLocation."E-Invoice User ID");
        ApiLoginDetail.Add('Password', RecLocation."E-Invoice Password");

        //API Setting
        // EInvoiceAPISetting := EInvoiceAPISetting.EInvApiSetting;//tk
        EInvoiceAPISetting.Add('ClientSecret', '');
        //New version of api's in e-invoice++
        EInvoiceAPISetting.Add('AuthUrl', 'https://einvapi.charteredinfo.com/eivital/v1.04');
        EInvoiceAPISetting.Add('BaseUrl', 'https://einvapi.charteredinfo.com/eicore/v1.03');
        EInvoiceAPISetting.Add('EwbByIRN', 'https://einvapi.charteredinfo.com/eiewb/v1.03');
        EInvoiceAPISetting.Add('CancelEwbUrl', 'https://einvapi.charteredinfo.com/ewaybillapi/v1.03');
        //New version of api's in e-invoice--
        Message((format(GenerateEwayBillByIRN)));
        //tk
        IF CONFIRM(GenText, TRUE) THEN BEGIN
            PostUrl := 'https://gsp.adaequare.com/test/enriched/ei/api/ewaybill';//'PAste URL here';
            HttpContnt.WriteFrom(format(GenerateEwayBillByIRN));
            HttpContnt.GetHeaders(HttpHdr);
            HttpHdr.Add('user_name', RecLocation."E-Invoice User ID");
            HttpHdr.Add('password', RecLocation."E-Invoice Password");
            // HttpHdr.Add('gstin', Location."GST Registration No.");
            // HttpHdr.Add('gstin', '04AMBPG7773M002');
            // HttpHdr.Add('gstin', '01AMBPG7773M002');//tkgst
            HttpHdr.Add('gstin', '27AMBPG7773M016');//tkgst
            //tkgst
            HttpHdr.Add('requestid', ReuestId);
            //HttpHdr.Add('Authorization', 'Bearer ' + GetAccessToken());
            // HttpHdr.Add('app-name', 'Navision');
            // HttpHdr.Add('x-token', '241a4d366da38e2d53361dbe65a36d023065f399');
            HttpHdr.Remove('Content-Type');
            HttpHdr.Add('Content-Type', 'application/json');
            Httpclint.Timeout(180000);
            // HttpHdr.Add('user_name', 'ew.user');
            // HttpHdr.Add('password', 'ab@123@@');
            // HttpHdr.Add('gstin', '36GSPOHM281G2ZP');
            // HttpHdr.Add('requestid', '');
            Httpclint.DefaultRequestHeaders.Add('Authorization', 'Bearer ' + GetAccessToken());
            //HttpHdr.Add('Authorization', '"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzY29wZSI6WyJnc3');


            if Httpclint.Post(PostUrl, HttpContnt, HttpResponseMsg) then begin

                HttpResponseMsg.Content.ReadAs(Result);
                ResultObject.ReadFrom(Result);
            end
            else begin
                HttpResponseMsg.Content.ReadAs(Result);
                ResultObject.ReadFrom(Result);
                Message(Result);
            end;
        End;

        MESSAGE(Result);

        IF COPYSTR(Result, 1, 1) = '{' THEN
            ParseResponseEwayBill(Result, RecSIH."No.");//tk

    end;

    local procedure ParseResponseEwayBill(TextResponse: Text; DocNo: Code[20]) messagetype: Text
    var
        dennomination: Decimal;
        p: Integer;
        x: Integer;
        ValuePair: Text;
        CurrentElement: Text;
        FormatChar: Label '{}';
        l: Integer;
        CurrentValue: Text;
        CurrentObject: Text;
        Irn: Text;
        token: Text;
        AckNo: Text;
        AckDt: Text;
        SignedInvoice: Text;
        SignedQRCode: Text;
        ResultJson: JsonObject;
        Jtoken: JsonToken;
        messageObject: JsonObject;
        Instream: InStream;
        OutStream: OutStream;
        RecSIH1: Record 112;
        SignedQRCode1: Text;
        EwbDt: Text;
        EwbNo: Text;
        VehNo: Text;
        EwbValidTill: Text;
        TransMode: text;
        EwbDt1: DateTime;
        EwbValidTill1: DateTime;
        EInvDtlEntry: Record "EWay Bill Entry";
    begin

        CLEAR(EwbNo);
        CLEAR(EwbDt);
        Clear(VehNo);
        Clear(TransMode);

        CLEAR(Irn);
        CLEAR(CurrentObject);
        p := 0;
        x := 1;

        ResultJson.ReadFrom(TextResponse);
        ResultJson.Get('success', jtoken);
        if Jtoken.AsValue().AsBoolean() then begin

            if ResultJson.Get('result', jtoken) then begin
                messageObject := jtoken.AsObject();
                if messageObject.Get('EwbNo', Jtoken) then
                    EwbNo := Jtoken.AsValue().AsText();
                if messageObject.Get('EwbDt', Jtoken) then
                    EwbDt := Jtoken.AsValue().AsText();



            end;
        end else
            Message(TextResponse);

        //Insert data into Table
        EInvDtlEntry.INIT;
        EInvDtlEntry."Entry No" := 0;
        EInvDtlEntry."Document No" := DocNo;
        EInvDtlEntry."E-Way Bill No" := AckNo;
        // EInvDtlEntry. := COPYSTR(AckDt, 1, 10);
        EInvDtlEntry."E-Way Bill Operation" := EInvDtlEntry."E-Way Bill Operation"::"Generate EWB";
        EInvDtlEntry."Vehicle No." := Irn;
        EInvDtlEntry."User ID" := USERID;
        EInvDtlEntry."Transaction Type" := EInvDtlEntry."Transaction Type"::"Sales Invoice";

        EInvDtlEntry.INSERT;
        if EwbNo <> '' then begin
            RecSIH1.RESET;
            RecSIH1.SETRANGE(RecSIH1."No.", DocNo);
            IF RecSIH1.FINDFIRST THEN BEGIN
                //;
                EVALUATE(EwbDt1, EwbDt);
                RecSIH1."E-Way Bill Date" := EwbDt1;//COPYSTR(EwbDt,1,10);
                RecSIH1."E-Way Bill No." := EwbNo;
                RecSIH1."E-Way Bill Date" := EwbValidTill1;

                //RecSIH1.Eway Vali Till:=needs to create SIH one more field
                RecSIH1.MODIFY;
            END;
        end;

        /*
        CLEAR(CurrentObject);
        p := 0;
        x := 1;

        IF STRPOS(TextResponse, '{}') > 0 THEN
            EXIT;

        TextResponse := DELCHR(TextResponse, '=', FormatChar);
        l := STRLEN(TextResponse);
        Char1 := 9;
        Char2 := 10;
        Char3 := 13;
        WHILE p < l DO BEGIN
            ValuePair := SELECTSTR(x, TextResponse);  // get comma separated pairs of values and element names

            IF STRPOS(ValuePair, ':') > 0 THEN BEGIN
                p := STRPOS(TextResponse, ValuePair) + STRLEN(ValuePair); // move pointer to the end of the current pair in Value

                CurrentElement := COPYSTR(ValuePair, 1, STRPOS(ValuePair, ':'));

                CurrentValue := DELCHR(CurrentValue, '=', ':');
                CurrentElement := DELCHR(CurrentElement, '=', '"');
                CurrentElement := DELCHR(CurrentElement, '=', ',');
                CurrentElement := DELCHR(CurrentElement, '=', ' ');
                CurrentElement := DELCHR(CurrentElement, '=', '/');
                CurrentElement := DELCHR(CurrentElement, '=', FORMAT(Char1));
                CurrentElement := DELCHR(CurrentElement, '=', FORMAT(Char2));
                CurrentElement := DELCHR(CurrentElement, '=', FORMAT(Char3));

                CurrentValue := COPYSTR(ValuePair, STRPOS(ValuePair, ':'));

                CurrentValue := DELCHR(CurrentValue, '=', ' ');
                CurrentValue := DELCHR(CurrentValue, '=', ':');
                CurrentValue := DELCHR(CurrentValue, '=', '/');
                CurrentValue := DELCHR(CurrentValue, '=', '"');
                //MESSAGE(CurrentElement);
                CASE CurrentElement OF
                    'EwbNo:':
                        BEGIN
                            EwbNo := CurrentValue;
                            MESSAGE('For Invoice No %1 E-Way Bill is generated %2', DocNo, EwbNo);
                        END;
                    'EwbDt:':
                        BEGIN

                            EwbDt := CurrentValue;

                        END;
                    'EwbValidTill:':
                        BEGIN
                            EwbValidTill := CurrentValue;

                        END;


                END;
            END;
            x := x + 1;
        END;
        //Get value from Json Response <<



        RecSIH1.RESET;
        RecSIH1.SETRANGE(RecSIH1."No.", DocNo);
        IF RecSIH1.FINDFIRST THEN BEGIN
            //;
            EVALUATE(EwbDt1, EwbDt);
            RecSIH1."E-Way Bill Date" := EwbDt1;//COPYSTR(EwbDt,1,10);
            RecSIH1."E-Way Bill No." := EwbNo;
            RecSIH1."E-Way Bill Date" := EwbValidTill1;
            //RecSIH1."Vehicle No.":=
            //RecSIH1.Eway Vali Till:=needs to create SIH one more field
            RecSIH1.MODIFY;
        END;
        //END;*/
    end;


    procedure CancelEwayBill(RecSIH: Record 112)
    var
        RequestCancelEWB: JsonObject;
        RecSipAgent: Record 291;
        VARVehicleType: Option ,R,O;
        ExpShipDtls: JsonObject;
        recstcd: Record State;
        GenerateEwayBill: JsonObject;
        pincode: Integer;
        DispDtls: JsonObject;
        dispstate: Record State;
        shipstate: Record State;
        RecSIH1: Record 112;
        GenText: Label 'Do You Want to Generate E-Way Bill No.';
    begin
        IF RecLocation.GET(RecSIH."Location Code") THEN;
        RecSIH.TESTFIELD("E-Way Bill No.");
        RecSIH.TESTFIELD("Cancel Remark");
        RecSIH.TESTFIELD("Cancel Reason Code");

        // RequestCancelEWB := RequestCancelEWB.ReqCancelIRN;
        RequestCancelEWB.Add('ewbNo"', RecSIH."E-Way Bill No.");
        RequestCancelEWB.Add('cancelRsnCode', RecSIH."Cancel Reason Code");
        RequestCancelEWB.Add('cancelRmrk', RecSIH."Cancel Remark");


        //For Login Details
        // ApiLoginDetail := ApiLoginDetail.EInvApiLoginDetails;
        ApiLoginDetail.Add('Gstin', RecLocation."GST Registration No.");
        ApiLoginDetail.Add('UserName', RecLocation."E-Invoice User ID");
        ApiLoginDetail.Add('Password', RecLocation."E-Invoice Password");

        //API Setting
        // EInvoiceAPISetting := EInvoiceAPISetting.EInvApiSetting;
        //EInvoiceAPISetting.Add('ClientSecret', '');
        //New version of api's in e-invoice++
        EInvoiceAPISetting.Add('AuthUrl', 'https://einvapi.charteredinfo.com/eivital/v1.04');
        EInvoiceAPISetting.Add('BaseUrl', 'https://einvapi.charteredinfo.com/eicore/v1.03');
        EInvoiceAPISetting.Add('EwbByIRN', 'https://einvapi.charteredinfo.com/eiewb/v1.03');
        EInvoiceAPISetting.Add('CancelEwbUrl', 'https://einvapi.charteredinfo.com/ewaybillapi/v1.03');
        //New version of api's in e-invoice--

        //tk
        IF CONFIRM(GenText, TRUE) THEN BEGIN
            PostUrl := 'https://gsp.adaequare.com/test/enriched/ewb/ewayapi?action=CANEWB';//'PAste URL here';
            HttpContnt.WriteFrom(format(RequestCancelEWB));
            HttpContnt.GetHeaders(HttpHdr);
            //HttpHdr.Add('app-name', 'Navision');
            //HttpHdr.Add('x-token', '241a4d366da38e2d53361dbe65a36d023065f399');
            HttpHdr.Remove('Content-Type');
            HttpHdr.Add('Content-Type', 'application/json');
            HttpHdr.Add('user_name', RecLocation."E-Invoice User ID");
            HttpHdr.Add('password', RecLocation."E-Invoice Password");
            // HttpHdr.Add('gstin', Location."GST Registration No.");
            // HttpHdr.Add('gstin', '04AMBPG7773M002');
            // HttpHdr.Add('gstin', '01AMBPG7773M002');//tkgst
            HttpHdr.Add('gstin', '27AMBPG7773M016');//tkgst
            //tkgst
            HttpHdr.Add('requestid', ReuestId);
            Httpclint.DefaultRequestHeaders.Add('Authorization', 'Bearer ' + GetAccessToken());


            if Httpclint.Post(PostUrl, HttpContnt, HttpResponseMsg) then begin

                HttpResponseMsg.Content.ReadAs(Result);
                ResultObject.ReadFrom(Result);
            end;
        End;

        //E-Invoice Session
        // EInvoiceSession := EInvoiceSession.EInvoiceSession;//tk++
        // EInvoiceSession.EInvApiSetting := EInvoiceAPISetting;
        // EInvoiceSession.EInvApiLoginDetails := ApiLoginDetail;//Tk--

        // GenerateEwayBill := GenerateEwayBill.Requests;//np

        // Result := GenerateEwayBill.GenerateEwbByIRN(EInvoiceSession, RequestCancelEWB);//tk
        MESSAGE(Result);


        IF COPYSTR(Result, 1, 1) = '{' THEN BEGIN
            parseCancelEwaybill(Result, RecSIH."No.");
            // RecSIH1.RESET;
            // RecSIH1.SETRANGE(RecSIH1."No.", RecSIH."No.");
            // IF RecSIH1.FINDFIRST THEN BEGIN
            //     RecSIH1."E-Way Bill Date" := 0DT;
            //     RecSIH1."E-Way Bill No." := '';

            //     RecSIH1.MODIFY;
            // END;
        END;
    end;

    procedure parseCancelEwaybill(TextResponse: Text; DocNo: Code[20]) messagetype: Text
    var
        responseJson: JsonObject;
        resultJson: JsonObject;
        messageObject: JsonObject;
        EwbNo: Text;
        canceldate: text;
        RecSIH1: Record 112;
        EInvDtlEntry: Record "EWay Bill Entry";
        canceldate1: DateTime;
    begin
        // TextResponse := '{
        //"success":true,
        //"message":"E-Way Bill is cancelled successfully",
        //"result":{"ewayBillNo":111000609282,"cancelDate":"15/12/2017 11:35:00 AM"}}';
        responseJson.ReadFrom(TextResponse);
        responseJson.Get('success', jtoken);
        if Jtoken.AsValue().AsBoolean() then begin
            if responseJson.Get('result', jtoken) then begin
                resultJson := jtoken.AsObject();
                if resultJson.Get('cancelDate', Jtoken) then
                    canceldate := Jtoken.AsValue().AsText();
                if resultJson.Get('ewayBillNo', Jtoken) then
                    EwbNo := Jtoken.AsValue().AsText();



            end;
        end else
            Message(TextResponse);

        EInvDtlEntry.INIT;
        EInvDtlEntry."Entry No" := 0;
        EInvDtlEntry."Document No" := DocNo;
        EInvDtlEntry."E-Way Bill No" := EwbNo;
        // EInvDtlEntry. := COPYSTR(AckDt, 1, 10);
        EInvDtlEntry."E-Way Bill Operation" := EInvDtlEntry."E-Way Bill Operation"::"Generate EWB";
        EInvDtlEntry."Vehicle No." := '';
        EInvDtlEntry."User ID" := USERID;
        EInvDtlEntry."Transaction Type" := EInvDtlEntry."Transaction Type"::"Sales Invoice";

        EInvDtlEntry.INSERT;
        if EwbNo <> '' then begin
            RecSIH1.RESET;
            RecSIH1.SETRANGE(RecSIH1."No.", DocNo);
            IF RecSIH1.FINDFIRST THEN BEGIN
                //;
                EVALUATE(canceldate1, COPYSTR(canceldate, 1, 19));
                RecSIH1."E-Way Bill Date" := canceldate1;//COPYSTR(EwbDt,1,10);
                RecSIH1."E-Way Bill No." := EwbNo;
                RecSIH1."Eway Cancelled" := true;

                //RecSIH1.Eway Vali Till:=needs to create SIH one more field
                RecSIH1.MODIFY;
            END;
        end;

    end;

    procedure "E-WayBillByIRNTransfer"(RecSIH: Record 5744)
    var
        GenerateEwayBillByIRN: JsonObject;
        RecSipAgent: Record 291;
        RTSH: Record "Transfer Shipment Header";
        VARVehicleType: Option ,R,O;
        ExpShipDtls: JsonObject;
        recstcd: Record state;
        GenerateEwayBill: JsonObject;
        pincode: Integer;
        DispDtls: JsonObject;
        dispstate: Record state;
        shipstate: Record state;
        EInvoiceLog: Record 50015;
        IrnNo: Text;
        Dist: Integer;
        transDocNo: Text;
        GenText: Label 'Do You Want to Generate E-Way Bill No.';
    begin


        // GenerateEwayBillByIRN := GenerateEwayBillByIRN.ReqGenrateEWayBillModel;

        //GenerateEwayBillByIRN.Add('Distance', RecSIH.Distance);

        CLEAR(IrnNo);
        EInvoiceLog.RESET;
        EInvoiceLog.SETRANGE(EInvoiceLog."Document No.", RecSIH."No.");
        EInvoiceLog.SETRANGE("Inv Transaction", EInvoiceLog."Inv Transaction"::"Generate IRN");
        EInvoiceLog.SETFILTER("E-Invoice Cancel Date", '%1', '');
        IF EInvoiceLog.FINDLAST THEN BEGIN
            IrnNo := EInvoiceLog."IRN No.";
        END;


        GenerateEwayBillByIRN.Add('Irn', IrnNo);//RecSIH."IRN No.";
        GenerateEwayBillByIRN.Add('TransDocDt', FORMAT(RecSIH."Posting Date", 10, '<Day,2>/<Month,2>/<Year4>'));
        IF RecSipAgent.GET(RecSIH."Shipping Agent Code") THEN;
        //RecSipAgent.TESTFIELD(RecSipAgent."GST Registration No");
        transDocNo := RecSIH."No.";
        GenerateEwayBillByIRN.Add('TransDocNo', DelChr(transDocNo, '=', '/'));
        GenerateEwayBillByIRN.Add('TransId', RecSipAgent."GST Registration No.");//'12AWGPV7107B1Z1';//
        GenerateEwayBillByIRN.Add('TransMode', RecSIH."Transport Method");
        GenerateEwayBillByIRN.Add('TransName', RecSipAgent.Name);
        GenerateEwayBillByIRN.Add('VehNo', RecSIH."Vehicle No.");
        Evaluate(Dist, Format(Round(RecSIH.Distance, 1, '=')));
        GenerateEwayBillByIRN.Add('Distance', Dist);
        VARVehicleType := RecSIH."Vehicle Type";
        GenerateEwayBillByIRN.Add('VehType', FORMAT(VARVehicleType));

        /*
        ExpShipDtls:=ExpShipDtls.ExpShipDetails;
        IF dispstate.GET (RecSIH.State)THEN;
        ExpShipDtls.Addr1 := '7th block, kuvempu layout';
                    ExpShipDtls.Addr2 := 'kuvempu layout';
                    ExpShipDtls.Loc := 'Banagalore';
                    ExpShipDtls.Pin :=560001;//RecSIH."Sell-to Post Code";;
                    ExpShipDtls.Stcd :=dispstate."State Code (GST Reg. No.)";
        GenerateEwayBillByIRN.ExpShipDtls:=ExpShipDtls;
        
        DispDtls :=DispDtls.DispDetails;
                    DispDtls.Nm := 'ABC company pvt ltd';
                    DispDtls.Addr1 := '7th block, kuvempu layout';
                    DispDtls.Addr2 := 'kuvempu layout';
                    DispDtls.Loc := 'Banagalore';
                    DispDtls.Pin := 411005;
                    DispDtls.Stcd := '33';
                    GenerateEwayBillByIRN.DispDtls:=DispDtls;
        */
        //For Login Details
        IF RecLocation.GET(RecSIH."Transfer-from Code") THEN;
        // ApiLoginDetail := ApiLoginDetail.EInvApiLoginDetails;
        ApiLoginDetail.Add('Gstin', RecLocation."GST Registration No.");
        ApiLoginDetail.Add('UserName', RecLocation."E-Invoice User ID");
        ApiLoginDetail.Add('Password', RecLocation."E-Invoice Password");

        //API Setting
        // EInvoiceAPISetting := EInvoiceAPISetting.EInvApiSetting;
        EInvoiceAPISetting.Add('ClientSecret', '');
        //New version of api's in e-invoice++
        EInvoiceAPISetting.Add('AuthUrl', 'https://einvapi.charteredinfo.com/eivital/v1.04');
        EInvoiceAPISetting.Add('BaseUrl', 'https://einvapi.charteredinfo.com/eicore/v1.03');
        EInvoiceAPISetting.Add('EwbByIRN', 'https://einvapi.charteredinfo.com/eiewb/v1.03');
        EInvoiceAPISetting.Add('CancelEwbUrl', 'https://einvapi.charteredinfo.com/ewaybillapi/v1.03');
        //New version of api's in e-invoice--

        Message((format(GenerateEwayBillByIRN)));
        //tk
        IF CONFIRM(GenText, TRUE) THEN BEGIN
            PostUrl := 'https://gsp.adaequare.com/test/enriched/ei/api/ewaybill';//'PAste URL here';
            HttpContnt.WriteFrom(format(GenerateEwayBillByIRN));
            HttpContnt.GetHeaders(HttpHdr);
            HttpHdr.Add('user_name', RecLocation."E-Invoice User ID");
            HttpHdr.Add('password', RecLocation."E-Invoice Password");
            // HttpHdr.Add('gstin', RecLocation."GST Registration No.");
            // HttpHdr.Add('gstin', '04AMBPG7773M002');
            // HttpHdr.Add('gstin', '01AMBPG7773M002');//tkgst
            HttpHdr.Add('gstin', '27AMBPG7773M016');//tkgst

            HttpHdr.Add('requestid', ReuestId);
            //HttpHdr.Add('Authorization', 'Bearer ' + GetAccessToken());
            // HttpHdr.Add('app-name', 'Navision');
            // HttpHdr.Add('x-token', '241a4d366da38e2d53361dbe65a36d023065f399');
            HttpHdr.Remove('Content-Type');
            HttpHdr.Add('Content-Type', 'application/json');
            Httpclint.Timeout(180000);
            // HttpHdr.Add('user_name', 'ew.user');
            // HttpHdr.Add('password', 'ab@123@@');
            // HttpHdr.Add('gstin', '36GSPOHM281G2ZP');
            // HttpHdr.Add('requestid', '');
            Httpclint.DefaultRequestHeaders.Add('Authorization', 'Bearer ' + GetAccessToken());
            //HttpHdr.Add('Authorization', '"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzY29wZSI6WyJnc3');


            if Httpclint.Post(PostUrl, HttpContnt, HttpResponseMsg) then begin

                HttpResponseMsg.Content.ReadAs(Result);
                ResultObject.ReadFrom(Result);
            end
            else begin
                HttpResponseMsg.Content.ReadAs(Result);
                ResultObject.ReadFrom(Result);
                Message(Result);
            end;
        End;

        MESSAGE(Result);

        IF COPYSTR(Result, 1, 1) = '{' THEN
            ParseResponseEwayBillTrans(Result, RecSIH."No.");

    end;

    local procedure ParseResponseEwayBillTrans(TextResponse: Text; DocNo: Code[20]) messagetype: Text
    var
        dennomination: Decimal;
        p: Integer;
        x: Integer;
        ValuePair: Text;
        CurrentElement: Text;
        FormatChar: Label '{}';
        l: Integer;
        CurrentValue: Text;
        CurrentObject: Text;
        Irn: Text;
        token: Text;
        AckNo: Text;
        AckDt: Text;
        SignedInvoice: Text;
        SignedQRCode: Text;
        ResultJson: JsonObject;
        Jtoken: JsonToken;
        messageObject: JsonObject;
        Instream: InStream;
        OutStream: OutStream;
        RecSIH1: Record "Transfer Shipment Header";
        SignedQRCode1: Text;
        EwbDt: Text;
        EwbNo: Text;
        VehNo: Text;
        EwbValidTill: Text;
        TransMode: text;
        EwbDt1: DateTime;
        EwbValidTill1: DateTime;
        EInvDtlEntry: Record "EWay Bill Entry";
    begin

        CLEAR(EwbNo);
        CLEAR(EwbDt);
        Clear(VehNo);
        Clear(TransMode);

        CLEAR(Irn);
        CLEAR(CurrentObject);
        p := 0;
        x := 1;

        ResultJson.ReadFrom(TextResponse);
        ResultJson.Get('success', jtoken);
        if Jtoken.AsValue().AsBoolean() then begin

            if ResultJson.Get('result', jtoken) then begin
                messageObject := jtoken.AsObject();
                if messageObject.Get('EwbNo', Jtoken) then
                    EwbNo := Jtoken.AsValue().AsText();
                if messageObject.Get('EwbDt', Jtoken) then
                    EwbDt := Jtoken.AsValue().AsText();



            end;
        end else
            Message(TextResponse);

        //Insert data into Table
        EInvDtlEntry.INIT;
        EInvDtlEntry."Entry No" := 0;
        EInvDtlEntry."Document No" := DocNo;
        EInvDtlEntry."E-Way Bill No" := AckNo;
        // EInvDtlEntry. := COPYSTR(AckDt, 1, 10);
        EInvDtlEntry."E-Way Bill Operation" := EInvDtlEntry."E-Way Bill Operation"::"Generate EWB";
        EInvDtlEntry."Vehicle No." := Irn;
        EInvDtlEntry."User ID" := USERID;
        EInvDtlEntry."Transaction Type" := EInvDtlEntry."Transaction Type"::"Sales Invoice";

        EInvDtlEntry.INSERT;
        if EwbNo <> '' then begin
            RecSIH1.RESET;
            RecSIH1.SETRANGE(RecSIH1."No.", DocNo);
            IF RecSIH1.FINDFIRST THEN BEGIN
                //;
                EVALUATE(EwbDt1, EwbDt);
                RecSIH1."E-Way Bill Date" := EwbDt1;//COPYSTR(EwbDt,1,10);
                RecSIH1."ME-Way Bill No." := EwbNo;
                RecSIH1."E-Way Bill Date" := EwbValidTill1;


                //RecSIH1.Eway Vali Till:=needs to create SIH one more field
                RecSIH1.MODIFY;
            END;
        end;

    end;



    procedure CancelEwayBillTRansfer(RecSIH: Record 5744)
    var
        RequestCancelEWB: JsonObject;
        RecSipAgent: Record 291;
        VARVehicleType: Option ,R,O;
        ExpShipDtls: JsonObject;
        recstcd: Record State;
        GenerateEwayBill: JsonObject;
        pincode: Integer;
        DispDtls: JsonObject;
        dispstate: Record State;
        shipstate: Record State;
        RecSIH1: Record "Transfer Shipment Header";
        GenText: Label 'Do You Want to Generate E-Way Bill No.';
    begin

        // RequestCancelEWB := RequestCancelEWB.ReqCancelIRN;

        RequestCancelEWB.Add('ewbNo', RecSIH."ME-Way Bill No.");
        RequestCancelEWB.Add('cancelRsnCode', RecSIH."Cancel Reason Code");
        RequestCancelEWB.Add('cancelRmrk', RecSIH."Cancel Remark");
        //For Login Details
        IF RecLocation.GET(RecSIH."Transfer-from Code") THEN;
        // ApiLoginDetail := ApiLoginDetail.EInvApiLoginDetails;
        ApiLoginDetail.Add('Gstin', RecLocation."GST Registration No.");
        ApiLoginDetail.Add('UserName', RecLocation."E-Invoice User ID");
        ApiLoginDetail.Add('Password', RecLocation."E-Invoice Password");

        //API Setting
        // EInvoiceAPISetting := EInvoiceAPISetting.EInvApiSetting;
        EInvoiceAPISetting.Add('ClientSecret', '');
        //New version of api's in e-invoice++
        EInvoiceAPISetting.Add('AuthUrl', 'https://einvapi.charteredinfo.com/eivital/v1.04');
        EInvoiceAPISetting.Add('BaseUrl', 'https://einvapi.charteredinfo.com/eicore/v1.03');
        EInvoiceAPISetting.Add('EwbByIRN', 'https://einvapi.charteredinfo.com/eiewb/v1.03');
        EInvoiceAPISetting.Add('CancelEwbUrl', 'https://einvapi.charteredinfo.com/ewaybillapi/v1.03');
        //New version of api's in e-invoice--

        //tk
        IF CONFIRM(GenText, TRUE) THEN BEGIN


            PostUrl := 'https://gsp.adaequare.com/test/enriched/ewb/ewayapi?action=CANEWB';//'PAste URL here';
            HttpContnt.WriteFrom(format(RequestCancelEWB));
            HttpContnt.GetHeaders(HttpHdr);
            HttpHdr.Remove('Content-Type');
            HttpHdr.Add('Content-Type', 'application/json');
            HttpHdr.Add('user_name', RecLocation."E-Invoice User ID");
            HttpHdr.Add('password', RecLocation."E-Invoice Password");
            HttpHdr.Add('gstin', '27AMBPG7773M016');
            HttpHdr.Add('requestid', ReuestId);
            Httpclint.DefaultRequestHeaders.Add('Authorization', 'Bearer ' + GetAccessToken());

            if Httpclint.Post(PostUrl, HttpContnt, HttpResponseMsg) then begin

                HttpResponseMsg.Content.ReadAs(Result);
                ResultObject.ReadFrom(Result);
            end;
        End;

        MESSAGE(Result);
        //End;
        IF COPYSTR(Result, 1, 1) = '{' THEN BEGIN
            parseCanceltranEwaybill(Result, RecSIH."No.");
            // RecSIH1.RESET;
            // RecSIH1.SETRANGE(RecSIH1."No.", RecSIH."No.");
            // IF RecSIH1.FINDFIRST THEN BEGIN
            //     RecSIH1."E-Way Bill Date" := 0DT;
            //     RecSIH1."E-Way Bill No." := '';

            //     RecSIH1.MODIFY;
            // END;
        END;

    end;

    procedure parseCanceltranEwaybill(TextResponse: Text; DocNo: Code[20]) messagetype: Text
    var
        responseJson: JsonObject;
        resultJson: JsonObject;
        messageObject: JsonObject;
        EwbNo: Text;
        canceldate: text;
        RecSIH1: Record "Transfer Shipment Header";
        EInvDtlEntry: Record "EWay Bill Entry";
        canceldate1: DateTime;
    begin
        // TextResponse := '{
        //"success":true,
        //"message":"E-Way Bill is cancelled successfully",
        //"result":{"ewayBillNo":111000609282,"cancelDate":"15/12/2017 11:35:00 AM"}}';
        responseJson.ReadFrom(TextResponse);
        responseJson.Get('success', jtoken);
        if Jtoken.AsValue().AsBoolean() then begin
            if responseJson.Get('result', jtoken) then begin
                resultJson := jtoken.AsObject();
                if resultJson.Get('cancelDate', Jtoken) then
                    canceldate := Jtoken.AsValue().AsText();
                if resultJson.Get('ewayBillNo', Jtoken) then
                    EwbNo := Jtoken.AsValue().AsText();



            end;
        end else
            Message(TextResponse);

        EInvDtlEntry.INIT;
        EInvDtlEntry."Entry No" := 0;
        EInvDtlEntry."Document No" := DocNo;
        EInvDtlEntry."E-Way Bill No" := EwbNo;
        // EInvDtlEntry. := COPYSTR(AckDt, 1, 10);
        EInvDtlEntry."E-Way Bill Operation" := EInvDtlEntry."E-Way Bill Operation"::"Generate EWB";
        EInvDtlEntry."Vehicle No." := '';
        EInvDtlEntry."User ID" := USERID;
        EInvDtlEntry."Transaction Type" := EInvDtlEntry."Transaction Type"::"Sales Invoice";

        EInvDtlEntry.INSERT;
        if EwbNo <> '' then begin
            RecSIH1.RESET;
            RecSIH1.SETRANGE(RecSIH1."No.", DocNo);
            IF RecSIH1.FINDFIRST THEN BEGIN
                //;
                EVALUATE(canceldate1, COPYSTR(canceldate, 1, 19));
                RecSIH1."E-Way Bill Date" := canceldate1;//COPYSTR(EwbDt,1,10);
                RecSIH1."ME-Way Bill No." := EwbNo;
                RecSIH1."EWay Bill Cnacelled" := true;

                //RecSIH1.Eway Vali Till:=needs to create SIH one more field
                RecSIH1.MODIFY;
            END;
        end;

    end;

    procedure IntraStateEwayBill(RecSIH: Record 5744)
    var
        //EinvoiceSetup: Record EinvoiceSetup;
        TempBlob: Codeunit "Temp Blob";
        ResponseInStream_L: InStream;
        OutStrm: OutStream;
        //HttpStatusCode_L: DotNet HttpStatusCode;
        //ResponseHeaders_L: DotNet ResponseHeader;
        JString: Text;
        FL: File;
        filepath: text;
        TransShipHeader: Record "Transfer Shipment Header";
        EWayJson: JsonObject;
        ItemDtls: JsonObject;
        Itemarray: JsonArray;
        tkno: Text;
        ShipDtls: JsonObject;
        DispatchDtls: JsonObject;
        pin: Integer;
        State: Record State;
        RefNo: Code[20];
        //salesInvHeader2: Record "Sales Invoice Header";
        //ResponseText: text;
        resposeJson: JsonObject;
        resultJson: JsonObject;
        jtoken: JsonToken;
        messagejson: JsonObject;
        errorjson: JsonObject;
        IStream: InStream;
        FileName: Text;
        //IBarCodeProvider: DotNet "IBarcode Provider";
        QrCodeInput: Text;
        QrCodeFileName: Text;
        //Webclient: DotNet WebClient;
        //dotnetString: DotNet String;
        //uri: DotNet Uri;
        downloadfilename: text;
        doctype: Text;
        ResponseText: Text;
        FromLocation: Record Location;
        ToLocation: Record Location;
        TransferShipmentLine: Record "Transfer Shipment Line";
        TotalBaseGst: Decimal;
        cgst: Decimal;
        sgst: Decimal;
        igst: Decimal;
        tcgst: Decimal;
        tsgst: Decimal;
        tigst: Decimal;
        cess: Decimal;
        tcess: Decimal;
        gstRate: Decimal;
        RecSipAgent: Record "Shipping Agent";
    begin
        //Eway bill
        //tkno := GetAccessToken();
        //EinvoiceSetup.Get();
        Clear(EWayJson);
        Clear(ResponseText);
        //EWayJson.Add('access_token', tkno);
        //EWayJson.Add('userGstin', RecSIH."Location GST Reg No"); //GSTIN
        EWayJson.Add('supplyType', 'O');
        //EWayJson.Add('data_source', 'erp');
        EWayJson.Add('subSupplyType', '1');
        EWayJson.Add('subSupplyDesc', 'Intra State Shipment');
        doctype := 'INV';
        //doctype := doctype.Replace('"', '');

        EWayJson.Add('docType', doctype);
        EWayJson.Add('docNo', RecSIH."No.");
        EWayJson.Add('docDate', RecSIH."Posting Date");
        FromLocation.get(RecSIH."Transfer-from Code");
        EWayJson.Add('fromGstin', FromLocation."GST Registration No.");
        EWayJson.Add('fromTrdName', FromLocation."Name");
        EWayJson.Add('fromAddr1', FromLocation."Address");
        EWayJson.Add('fromAddr2', FromLocation."Address 2");
        EWayJson.Add('fromPlace', FromLocation.City);
        EWayJson.Add('fromPincode', FromLocation."Post Code");
        State.Get(FromLocation."State Code");
        EWayJson.Add('actFromStateCode', UpperCase(State.Description));
        EWayJson.Add('fromStateCode', UpperCase(State.Description));
        //EWayJson.Add('actual_from_state_name', UpperCase(State.Description));
        ToLocation.get(RecSIH."Transfer-to Code");
        EWayJson.Add('toGstin', ToLocation."GST Registration No.");
        EWayJson.Add('toTrdName', ToLocation."Name");
        EWayJson.Add('toAddr1', ToLocation."Address");
        EWayJson.Add('toAddr2', ToLocation."Address 2");
        EWayJson.Add('toPlace', ToLocation."City");
        EWayJson.Add('toPincode', ToLocation."Post Code");
        State.Get(ToLocation."State Code");
        EWayJson.Add('toStateCode', State.Description);
        EWayJson.Add('actToStateCode', State.Description);
        //if RecSIH.InvTransactionType = RecSIH.InvTransactionType::Regular then
        EWayJson.Add('transactionType', RecSIH."Transaction Type");
        //else
        //if RecSIH.InvTransactionType = RecSIH.InvTransactionType::"Combination of 2 and 3" then
        //EWayJson.Add('transactionType', '2')
        //else
        //if RecSIH.InvTransactionType = RecSIH.InvTransactionType::"Combination of 3 and 4" then 
        //EWayJson.Add('transactionType', '3');
        IF RecSipAgent.GET(RecSIH."Shipping Agent Code") THEN;

        EWayJson.Add('transporterId', RecSipAgent."GST Registration No.");
        EWayJson.Add('transporterName', RecSIH."Transporter Name");
        EWayJson.Add('transDocNo', RecSIH."No.");
        EWayJson.Add('transDocDate', RecSIH."Posting Date");
        EWayJson.Add('transMode', '1');
        EWayJson.Add('transDistance', RecSIH.Distance);
        EWayJson.Add('vehicleNo', RecSIH."Vehicle No.");
        EWayJson.Add('vehicleType', format(RecSIH."Vehicle Type"));
        TransferShipmentLine.Reset();
        TransferShipmentLine.SetRange("Document No.", RecSIH."No.");
        //TransferShipmentLine.SetRange("Document Type", RecSIH."Document Type");
        if TransferShipmentLine.FindFirst() then
            repeat
                Clear(ItemDtls);
                ItemDtls.Add('productName', TransferShipmentLine.Description);
                ItemDtls.Add('hsnCode', TransferShipmentLine."HSN/SAC Code");
                ItemDtls.Add('quantity', TransferShipmentLine.Quantity);
                ItemDtls.Add('qtyUnit', TransferShipmentLine."Unit of Measure Code");
                ItemDtls.Add('taxableAmount', TransferShipmentLine.Amount);
                DetailedGSTLedgerEntry.SETRANGE("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
                DetailedGSTLedgerEntry.SETRANGE("Posting Date", RecSIH."Posting Date");
                DetailedGSTLedgerEntry.SETRANGE("Transaction Type", DetailedGSTLedgerEntry."Transaction Type"::Sales);
                DetailedGSTLedgerEntry.SETRANGE("Document No.", TransferShipmentLine."Document No.");
                DetailedGSTLedgerEntry.SETRANGE("Document Line No.", TransferShipmentLine."Line No.");
                IF DetailedGSTLedgerEntry.FINDFIRST THEN
                    REPEAT
                        TotalBaseGst := TotalBaseGst - DetailedGSTLedgerEntry."GST Amount";
                        gstRate := gstRate + DetailedGSTLedgerEntry."GST %";
                        IF DetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN
                            igst := igst - DetailedGSTLedgerEntry."GST Amount";
                        IF DetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN
                            cgst := cgst - DetailedGSTLedgerEntry."GST Amount";
                        IF (DetailedGSTLedgerEntry."GST Component Code" = 'SGST') OR (DetailedGSTLedgerEntry."GST Component Code" = 'UTGST') THEN
                            sgst := sgst - DetailedGSTLedgerEntry."GST Amount";
                        IF DetailedGSTLedgerEntry."GST Component Code" = 'Cess' THEN
                            cess := cess - DetailedGSTLedgerEntry."GST Amount";
                    UNTIL DetailedGSTLedgerEntry.NEXT = 0;

                ItemDtls.Add('taxableAmount', TotalBaseGst);

                ItemDtls.Add('cgstRate', gstRate / 2);
                ItemDtls.Add('sgstRate', gstRate / 2);

                //ItemDtls.Add('igstRate', TransferShipmentLine.GST);
                ItemDtls.Add('cessRate', cess);
                ItemDtls.Add('cessNonAdvol', 0);
                Itemarray.Add(ItemDtls);
            until TransferShipmentLine.Next() = 0;
        EWayJson.Add('itemList', Itemarray);
        EWayJson.Add('otherValue', 0);
        EWayJson.Add('totalValue', Abs(TotalBaseGst));
        EWayJson.Add('taxable_amount', Abs(TotalBaseGst));
        EWayJson.Add('cgstValue', Abs(tcgst));
        EWayJson.Add('sgstValue', Abs(tsgst));
        EWayJson.Add('igstValue', Abs(tigst));
        EWayJson.Add('cessValue', Abs(tcess));
        EWayJson.Add('cessNonAdvolValue', 0);
        EWayJson.Add('totInvValue', Abs(TotalBaseGst) + Abs(tcgst) + Abs(tsgst) + Abs(tigst) + Abs(tcess));
        //GenerateB2CEwayBill(EWayJson);

        //GenerateB2CEwayBill(EWayJson);
        PostUrl := 'https://gsp.adaequare.com/test/enriched/ewb/ewayapi?action=GENEWAYBILL';//'PAste URL here';
        HttpContnt.WriteFrom(format(EWayJson));
        HttpContnt.GetHeaders(HttpHdr);
        HttpHdr.Remove('Content-Type');
        HttpHdr.Add('Content-Type', 'application/json');
        HttpHdr.Add('user_name', RecLocation."E-Invoice User ID");
        HttpHdr.Add('password', RecLocation."E-Invoice Password");
        HttpHdr.Add('gstin', '27AMBPG7773M016');
        HttpHdr.Add('requestid', ReuestId);
        Httpclint.DefaultRequestHeaders.Add('Authorization', 'Bearer ' + GetAccessToken());

        if Httpclint.Post(PostUrl, HttpContnt, HttpResponseMsg) then begin

            HttpResponseMsg.Content.ReadAs(Result);
            ResultObject.ReadFrom(Result);
        end;


    end;

    local procedure parseB2CEwayBill(ResponseText: text; Docno: code[20]) messagetype: Text
    var
        transShipHeader: Record "Transfer Shipment Header";
        resposeJson: JsonObject;
        resultJson: JsonObject;
        jtoken: JsonToken;
        messagejson: JsonObject;
        errorjson: JsonObject;
    begin
        /*
        {
"success": true,
"result": {
"ewayBillDate": "17/10/2018 11:21:00 AM",
"ewayBillNo": 361001541142,
"alert": "",
"validUpto": "24/10/2018 11:59:00 PM"
},
"message": "E-Way Bill is generated successfully"
}
        */
        if ResponseText = '' then Message('No Response Error');
        ResponseText := ResponseText.Replace('\', '');
        resposeJson.ReadFrom(ResponseText);
        // resposeJson.Get('results', jtoken);
        // resposeJson := jtoken.AsObject();
        resposeJson.Get('status', jtoken);
        if jtoken.AsValue().AsText() = 'Success' then begin
            resultJson.Get('result', jtoken);
            messagejson := jtoken.AsObject();
            messagejson.Get('ewayBillNo', jtoken);
            transShipHeader."ME-Way Bill No." := jtoken.AsValue().AsText();
            messagejson.Get('ewayBillDate', jtoken);
            transShipHeader."E-Way Bill Date" := jtoken.AsValue().AsDateTime();
            messagejson.Get('validUpto', jtoken);
            //transShipHeader.E := jtoken.AsValue().AsDateTime()
            //messagejson.Get('url', jtoken);
            //QrCodeInput := jtoken.AsValue().AsText();
            //GetBarCodeProvider(IBarCodeProvider);
            //QrCodeFileName := IBarCodeProvider.GetBarcode(QrCodeInput);
            //downloadfile('https://' + jtoken.AsValue().AsText(), 'D:\EinvoiceQrCode\EwayPdf\' + EinvHeader."Eway Bill No." + '.pdf');
            // downloadfilename := EinvHeader."Eway Bill No." + '.pdf';
            //File.Download('D:\EinvoiceQrCode\EwayPdf\' + EinvHeader."Eway Bill No." + '.pdf', '', '', '', downloadfilename);
            transShipHeader.Modify();
            messagejson.Get('alert', jtoken);
            Message('Eway Bill Generated with No %1' + jtoken.AsValue().AsText(), transShipHeader."ME-Way Bill No.");
        end
        else
            message(ResponseText);
    end;

    local procedure "----------------"()
    begin
    end;


    procedure Automail()
    var
        Allowmail: Boolean;
        RecEINV: Record 50015;
    begin
        RecSalInv.RESET;
        //RecSalInv.SETRANGE("Posting Date",011120D,TODAY);
        RecSalInv.SETRANGE("No.", '5260521220100960');
        //RecSalInv.SETFILTER("Order No.",'<>%1','');
        IF RecSalInv.FINDSET THEN
            REPEAT


                IF (RecSalInv."Nature of Supply" = RecSalInv."Nature of Supply"::B2B) THEN BEGIN
                    Allowmail := TRUE;
                    RecEINV.RESET;
                    RecEINV.SETRANGE("Document No.", RecSalInv."No.");
                    RecEINV.SETRANGE("Inv Transaction", RecEINV."Inv Transaction"::"Generate IRN");
                    IF NOT RecEINV.FINDFIRST THEN
                        // CurrReport.SKIP;
                        Allowmail := FALSE;
                END;
                MailtoCust(RecSalInv."No.", Allowmail);

            UNTIL RecSalInv.NEXT = 0;
    end;


    procedure MailtoCust(var OrderNo: Code[20]; var Boo: Boolean)
    var
        recSIH: Record 112;
        FilePath: Text[200];
        FileName1: Text[200];
        SIH: Record 112;
        Subject: Text[200];
        SMTPMail: Codeunit Email;
        Body: Text[1024];
        CommDialog: Codeunit 419;
        Cust: Record 18;
        RecSP: Record 13;
        SalesPerson: Record 13;
        IGST_Mail: Text[500];
        responsibilityCentre: Record 50011;
    begin

        recSIH.RESET;

        recSIH.SETRANGE("No.", OrderNo);

        IF (recSIH.FINDFIRST) AND (Boo = TRUE) THEN BEGIN
            // REPORT.RUN(REPORT::"Mail Report1",FALSE,FALSE,recSIH);
            FilePath := 'E:\EwayBillPrint\';
            FileName1 := 'Invoice ' + FORMAT(recSIH."No.") + '.pdf';
            FileName1 := CONVERTSTR(FileName1, '/', '_');
            FileName1 := CONVERTSTR(FileName1, ':', '_');

            //REPORT.SAVEASPDF(50076, FilePath + FileName1, recSIH);//NP

            Subject := 'Invoice- ' + FORMAT(recSIH."No.");
            IF Cust.GET(recSIH."Bill-to Customer No.") THEN;

            // IF Cust."E-Mail" <> '' THEN//tk
            //     //SMTPMail.CreateMessage('Maple Administrator', 'ypatil@winspiresolutions.com', 'ypatil@winspiresolutions.com', Subject, '', TRUE)//Cust."E-Mail"

            // ELSE
            //     //SMTPMail.CreateMessage('Maple Administrator', 'ypatil@winspiresolutions.com', 'ypatil@winspiresolutions.com', Subject, '', TRUE);

            Body := '<html>' + '<body>' + 'Dear Sir/Madam' + '<br>' + '<br>' + 'Thanks for your order. Enclosed please find details of invoices as on ' + FORMAT(recSIH."Posting Date", 0, '<DAY,2>/<MONTH,2>/<YEAR4>') + '.' + '<br>' + '<br>'
            + 'Regards' + '<br>' + 'Maple' +
            '<br>' + '<br>' + '<br>' + '<br>' + '<center>' + '<font size="2" color="red">' + 'This is a system generated message. We request you not to reply to this message' + '</font>' + '</center>'
            + '</body>' + '</html>';
            //SMTPMail.AppendBody(Body);//tk


            // SMTPMail.AddCC(RecSP."E-Mail");


            //  SMTPMail.AddBCC('ypatil@winspiresolutions.com');

            // SMTPMail.AddAttachment(FilePath + FileName1, FileName1);


            // SMTPMail.Send;//tk
            SLEEP(6000);
            // CommDialog.DeleteServerFile(FilePath + FileName1);//tk



        END;
    end;
}

