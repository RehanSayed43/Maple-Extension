codeunit 50057 "Subscriber Event Sales"
{
    Permissions = tabledata "G/L Entry" = rmdi, tabledata "Sales Invoice Header" = rmdi;
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Table, Database::"No. Series", 'OnBeforeDeleteEvent', '', false, false)]
    local procedure OnBeforeNoSeriesDeleteRecord(var Rec: Record "No. Series");
    BEGIN
        IF UserId <> 'ADMIN' THEN
            Error('You are not allowed to delete no series');
    END;

    [EventSubscriber(ObjectType::Table, Database::"No. Series Relationship", 'OnBeforeDeleteEvent', '', false, false)]
    local procedure OnBeforeNoSeriesRelationDeleteRecord(var Rec: Record "No. Series Relationship");
    BEGIN
        IF UserId <> 'ADMIN' THEN
            Error('You are not allowed to delete no series');
    END;

    [EventSubscriber(ObjectType::Table, Database::"No. Series Line", 'OnBeforeDeleteEvent', '', false, false)]
    local procedure OnBeforeNoSeriesLineDeleteRecord(var Rec: Record "No. Series Line");
    BEGIN
        IF UserId <> 'ADMIN' THEN
            Error('You are not allowed to delete no series');
    END;




    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifyEventCustomer(Rec: Record Customer; var xRec: Record Customer)
    var
        Cust: Record Customer;
        SalesInv: Record "Sales Invoice Header";
    BEGIN
        IF (Rec.Name = '') AND (xRec.Name <> '') THEN BEGIN
            Cust.Reset();
            Cust.SetRange(Cust."No.", Rec."No.");
            IF Cust.FindFirst() THEN BEGIN
                Cust.Name := xRec.Name;
                Cust."Name 2" := xRec."Name 2";
                Cust."Customer Type" := xRec."Customer Type";
                Cust."State Code" := xRec."State Code";
                Cust.Address := xRec.Address;
                Cust."Address 2" := xRec."Address 2";
                Cust.City := xRec.City;
                Cust."Post Code" := xRec."Post Code";
                Cust."Phone No." := xRec."Phone No.";
                Cust."E-Mail" := xRec."E-Mail";
                Cust."Gen. Bus. Posting Group" := xRec."Gen. Bus. Posting Group";
                Cust."Customer Posting Group" := xRec."Customer Posting Group";
                Cust."Location Code" := xRec."Location Code";
                Cust."P.A.N. No." := xRec."P.A.N. No.";
                Cust."GST Customer Type" := xRec."GST Customer Type";
                Cust."GST Registration No." := xRec."GST Registration No.";
                Cust.Modify(false);
            END;
        END
        ELSE
            IF (Rec.Name = '') THEN BEGIN
                Cust.Reset();
                Cust.SetRange(Cust."No.", Rec."No.");
                IF Cust.FindFirst() THEN BEGIN
                    SalesInv.Reset();
                    SalesInv.SetRange(SalesInv."Sell-to Customer No.", Cust."No.");
                    IF SalesInv.FindFirst() THEN BEGIN
                        Cust.Name := SalesInv."Sell-to Customer Name";
                        Cust."Name 2" := SalesInv."Sell-to Customer Name 2";
                        IF SalesInv."Sales Order Type" = SalesInv."Sales Order Type"::Retail THEN
                            Cust."Customer Type" := SalesInv."Sales Order Type";
                        Cust."State Code" := SalesInv.State;
                        Cust.Address := SalesInv."Sell-to Address";
                        Cust."Address 2" := SalesInv."Sell-to Address 2";
                        Cust.City := SalesInv."Sell-to City";
                        Cust."Post Code" := SalesInv."Sell-to Post Code";
                        Cust."Phone No." := SalesInv."Sell-to Phone No.";
                        Cust."E-Mail" := SalesInv."Sell-to E-Mail";
                        Cust."Gen. Bus. Posting Group" := SalesInv."Gen. Bus. Posting Group";
                        Cust."Customer Posting Group" := SalesInv."Customer Posting Group";
                        Cust."Location Code" := SalesInv."Location Code";
                        IF SalesInv."Customer GST Reg. No." <> '' THEN
                            Cust."P.A.N. No." := CopyStr(SalesInv."Customer GST Reg. No.", 3, 10);
                        Cust."GST Customer Type" := SalesInv."GST Customer Type";
                        Cust."GST Registration No." := SalesInv."Customer GST Reg. No.";
                        Cust.Modify(false);
                    END;
                END;
            END;
    END;




    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitGLEntry', '', false, false)]
    local procedure OnAfterInitGLEntry(var GLEntry: Record "G/L Entry"; GenJournalLine: Record "Gen. Journal Line"; Amount: Decimal; AddCurrAmount: Decimal; UseAddCurrAmount: Boolean; var CurrencyFactor: Decimal; var GLRegister: Record "G/L Register");
    var
        GLAcc: Record "G/L Account";
        Cust: Record Customer;
        Vend: Record Vendor;
        BankAcc: Record "Bank Account";
        FixedAsset: Record "Fixed Asset";
    begin
        GLEntry.Narration := GenJournalLine.Narration;//*** WIN241//win352
                                                      //Message('%1', GLEntry."Bal. Account No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post", 'OnCodeOnAfterGenJnlPostBatchRun', '', false, false)]
    local procedure OnCodeOnAfterGenJnlPostBatchRun(var GenJnlLine: Record "Gen. Journal Line");
    begin
        UpdateGLEntry();
    end;


    procedure UpdateGLEntry()
    var
        gj: page "Sales Order";
        GLAcc: Record "G/L Account";
        Cust: Record Customer;
        Vend: Record Vendor;
        BankAcc: Record "Bank Account";
        FixedAsset: Record "Fixed Asset";
        GLEntry: Record "G/L Entry";
    BEGIN
        GLEntry.Reset();
        GLEntry.SetFilter(GLEntry."Bal. Account No.", '<>%1', '');
        GLEntry.SetFilter(GLEntry."Bal Account Name", '%1', '');
        IF GLEntry.FindSet() THEN BEGIN
            REPEAT
                IF (GLEntry."Bal. Account Type" = GLEntry."Bal. Account Type"::"G/L Account") THEN BEGIN
                    IF GLAcc.GET(GLEntry."Bal. Account No.") THEN BEGIN
                        GLEntry."Bal Account Name" := GLAcc.Name;
                        GLEntry.Modify(false);
                    END;
                END
                ELSE
                    IF (GLEntry."Bal. Account Type" = GLEntry."Bal. Account Type"::Customer) THEN BEGIN
                        IF Cust.GET(GLEntry."Bal. Account No.") THEN BEGIN
                            GLEntry."Bal Account Name" := Cust.Name;
                            GLEntry.Modify(false);
                        END;
                    END
                    ELSE
                        IF (GLEntry."Bal. Account Type" = GLEntry."Bal. Account Type"::Vendor) THEN BEGIN
                            IF Vend.GET(GLEntry."Bal. Account No.") THEN BEGIN
                                GLEntry."Bal Account Name" := Vend.Name;
                                GLEntry.Modify(false);
                            END;
                        END
                        ELSE
                            IF (GLEntry."Bal. Account Type" = GLEntry."Bal. Account Type"::"Bank Account") THEN BEGIN
                                IF BankAcc.GET(GLEntry."Bal. Account No.") THEN BEGIN
                                    GLEntry."Bal Account Name" := BankAcc.Name;
                                    GLEntry.Modify(false);
                                END;
                            END
                            ELSE
                                IF (GLEntry."Bal. Account Type" = GLEntry."Bal. Account Type"::"Fixed Asset") THEN BEGIN
                                    IF FixedAsset.Get(GLEntry."Bal. Account No.") THEN BEGIN
                                        GLEntry."Bal Account Name" := FixedAsset.Description;
                                        GLEntry.Modify(false);
                                    END;
                                END;

            UNTIL GLEntry.Next() = 0;

        END;
    END;



    procedure ClockmeAPI(SalesInvHeader: Record "Sales Invoice Header");
    var
        HttpClient: HttpClient;
        SecurityHttpClient: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        SecurityHttpResponse: HttpResponseMessage;
        URL: Text;
        HttpRequest: HttpRequestMessage;
        SubFolder: Text[100];
        OrderNo: Code[20];
        HttpsContent: HttpContent;
        SecurityHttpsContent: HttpContent;
        HttpsHeader: HttpHeaders;
        ReturnValue: ARRAY[20] OF Text[1000];
        jObj: JsonObject;
        json: Text;
        SalesnRec: Record "Sales & Receivables Setup";
        RequestHeader: HttpHeaders;
        SecurityRequestHeader: HttpHeaders;
        AuthString: Text;
        SecurityResponseText: Text;
        DateFolderName: Text;
        SalesInvoiceHeaderObject: JsonObject;
        SalesInvoiceLineObject: JsonObject;
        SalesInvoiceLineObjectArray: JsonArray;
        SalesInvoiceLineObjectProductArray: JsonArray;
        SalesInvLine: Record "Sales Invoice Line";
        TaxTransaction: Record "Tax Transaction Value";
        RecItem: Record item;
        ProductJson: Text;
    begin
        clear(ProductJson);
        SalesnRec.Get();
        Clear(AuthString);
        clear(URL);
        clear(json);
        SalesInvoiceHeaderObject.Add('vendorid', SalesnRec."Clock-me Vendor ID");//Check
        SalesInvoiceHeaderObject.Add('password', SalesnRec."Clock-me Password");

        SalesInvoiceLineObject.Add('order_receive_on_web_date', FORMAT(SalesInvHeader."Order Date", 0, 9));
        SalesInvoiceLineObject.Add('order_receive_on_web_time', SalesInvHeader."Order Time");//Check
        SalesInvoiceLineObject.Add('remark', SalesInvHeader.Comment);
        SalesInvoiceLineObject.Add('order_id', SalesInvHeader."Order ID");
        SalesInvoiceLineObject.Add('name', SalesInvHeader."Sell-to Customer Name");
        SalesInvoiceLineObject.Add('contact', SalesInvHeader."Sell-to Phone No.");
        SalesInvoiceLineObject.Add('email', SalesInvHeader."Sell-to E-Mail");
        SalesInvoiceLineObject.Add('address', SalesInvHeader."Sell-to Address" + ' ' + SalesInvHeader."Sell-to Address 2" + ' ' + SalesInvHeader."Sell-to City" + ' ' + SalesInvHeader."Sell-to Post Code");
        SalesInvoiceLineObject.Add('location', SalesInvHeader."Sell-to City");
        SalesInvoiceLineObject.Add('pin_code', SalesInvHeader."Sell-to Post Code");
        SalesInvoiceLineObject.Add('store_code', SalesInvHeader."Location Code");

        Clear(SalesInvoiceLineObjectProductArray);
        SalesInvLine.Reset();
        SalesInvLine.SetRange("Document No.", SalesInvHeader."No.");
        SalesInvLine.SetRange(Type, SalesInvLine.Type::Item);
        IF SalesInvLine.FindSet() THEN BEGIN
            REPEAT
                IF RecItem.GET(SalesInvLine."No.") THEN BEGIN
                    IF ProductJson = '' THEN
                        ProductJson += RecItem.Description
                    ELSE
                        ProductJson += ', ' + RecItem.Description;
                END;
            // SalesInvoiceLineObjectProductArray.Add(RecItem.Description);
            UNTIL SalesInvLine.Next() = 0;
        END;
        SalesInvoiceLineObject.Add('product', ProductJson);

        SalesInvoiceLineObject.Add('logistics_events', 'eComm');


        SalesInvoiceLineObjectArray.Add(SalesInvoiceLineObject);
        SalesInvoiceHeaderObject.Add('data', SalesInvoiceLineObjectArray);

        json := Format(SalesInvoiceHeaderObject);
        HttpsContent.WriteFrom(json);
        HttpsContent.GetHeaders(RequestHeader);
        RequestHeader.Remove('Content-Type');
        RequestHeader.Add('Content-Type', 'application/json');
        URL := SalesnRec."Clock-me URL";// 'https://stagingapp.edgistify.com/api_c/clients/order/create';
        HttpClient.SetBaseAddress(URL);
        Clear(ResponseText);
        IF SalesnRec."Clock-me Show Json" THEN BEGIN
            Message(json);
            Message(URL);
        END;
        IF HttpClient.Post(URL, HttpsContent, HttpResponse) THEN BEGIN
            HttpResponse.Content.ReadAs(ResponseText);
            IF SalesnRec."Clock-me Show Json" THEN
                Message(ResponseText);
        END;
    end;

    //<<Clockme
    //>>TK Creadit case

    [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", 'OnAfterCopyTrackingFromItemLedgEntry', '', false, false)]
    local procedure OnAfterCopyTrackingFromItemLedgEntry(var TrackingSpecification: Record "Tracking Specification"; ItemLedgerEntry: Record "Item Ledger Entry");
    begin
        TrackingSpecification."MRP Value" := ItemLedgerEntry."MRP Value";
        TrackingSpecification."IMEI No." := ItemLedgerEntry."IMEI No.";

    end;

    [EventSubscriber(ObjectType::Table, Database::"Reservation Entry", 'OnAfterCopyTrackingFromItemLedgEntry', '', false, false)]
    local procedure OnAfterCopyTrackingFromItemLedgEntry1(var ReservationEntry: Record "Reservation Entry"; ItemLedgerEntry: Record "Item Ledger Entry");
    begin
        ReservationEntry."MRP Value" := ItemLedgerEntry."MRP Value";
        ReservationEntry."IMEI No." := ItemLedgerEntry."IMEI No.";
        //Message('%1 TK', ReservationEntry."MRP Value");

    end;



    //>>TK

    //>>RY




    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post (Yes/No)", 'OnAfterPost', '', false, false)]
    local procedure OnAfterPost(var TransHeader: Record "Transfer Header"; Selection: Option);
    var
        ILE: Record "Item Ledger Entry";
        TransferLine: Record "Transfer Line";
        ReservationEntry: Record "Reservation Entry";
        P: PAGE "Posting No. Series Setup";
    begin
        //CCIT_TK Transfer Item Tracking
        // MESSAGE(FORMAT(Selection));
        IF Selection = 1 THEN BEGIN
            TransferLine.Reset();
            TransferLine.SetRange(TransferLine."Document No.", TransHeader."No.");
            IF TransferLine.FindSet() THEN
                REPEAT
                    ReservationEntry.Reset();
                    ReservationEntry.SetRange(ReservationEntry."Item No.", TransferLine."Item No.");
                    ReservationEntry.SetRange(ReservationEntry."Source Type", 5741);
                    ReservationEntry.SetRange(ReservationEntry."Source ID", TransferLine."Document No.");
                    ReservationEntry.SetRange(ReservationEntry."Source Prod. Order Line", TransferLine."Line No.");
                    ReservationEntry.SetRange(ReservationEntry."Location Code", TransHeader."Transfer-to Code");
                    IF ReservationEntry.FindSet() THEN
                        REPEAT
                            //>>
                            ILE.Reset();
                            ILE.SetRange(ILE."Entry Type", ILE."Entry Type"::Transfer);
                            ILE.SetRange(ILE."Item No.", TransferLine."Item No.");
                            ILE.SetRange(ILE."Location Code", TransHeader."Transfer-from Code");
                            ILE.SetRange(ILE."Order Type", ILE."Order Type"::Transfer);
                            ILE.SetRange(ILE."Order No.", TransferLine."Document No.");
                            ILE.SetRange(ILE."Order Line No.", TransferLine."Line No.");
                            ILE.SetRange(ILE."Serial No.", ReservationEntry."Serial No.");
                            ILE.SetRange(ILE."Item Tracking", ILE."Item Tracking"::"Serial No.");
                            IF ILE.FindFirst() THEN BEGIN
                                ReservationEntry."IMEI No." := ILE."IMEI No.";
                                ReservationEntry."MRP Value" := ILE."MRP Value";
                                ReservationEntry.Modify(false);
                            END;
                        //<<
                        //TK

                        //TK
                        UNTIL ReservationEntry.Next() = 0;
                UNTIL TransferLine.Next() = 0;
        END;

    end;


    //CCIT-TK Item Tacking
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesDoc', '', false, false)]
    local procedure OnAfterPostSalesDoc(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20]; CommitIsSuppressed: Boolean; InvtPickPutaway: Boolean; var CustLedgerEntry: Record "Cust. Ledger Entry"; WhseShip: Boolean; WhseReceiv: Boolean; PreviewMode: Boolean);
    var
        SalesInvHeader: Record "Sales Invoice Header";
        yu: page 18559;
        JSONContent: Text;
        ResponseJsonObject: JsonObject;
        ResponseJsonToken: JsonToken;
        OrderJsonObject: JsonObject;
        SalesnRec: Record "Sales & Receivables Setup";
        BuyBackLedger: Record "Buy Back Ledger";
        SRno: Integer;
        Cust: Record Customer;
    begin

        //>>>>>Buy Back
        Clear(SRno);
        SalesInvHeader.Reset();
        SalesInvHeader.SetRange("No.", SalesInvHdrNo);
        //SalesInvHeader.SetFilter("Servify Approval Code", '<>%1', '');
        IF SalesInvHeader.FindFirst() THEN BEGIN
            IF (SalesInvHeader."Servify Approval Code" <> '') OR (SalesInvHeader."Maple Buyback Amt" <> 0) THEN BEGIN
                BuyBackLedger.Reset();
                IF BuyBackLedger.FindLast() THEN
                    SRno := BuyBackLedger."Sr. no." + 1
                ELSE
                    SRno := 1;

                BuyBackLedger.Reset();
                BuyBackLedger.Init();
                BuyBackLedger."Sr. no." := SRno;
                BuyBackLedger."Posting Date" := SalesInvHeader."Posting Date";
                BuyBackLedger."Cr. no." := SalesInvHeader."Sell-to Customer No.";
                IF Cust.GET(SalesInvHeader."Sell-to Customer No.") THEN;
                BuyBackLedger."Customer Sub Type" := Cust."Customer Sub Type";
                BuyBackLedger."Invoice no." := SalesInvHdrNo;
                BuyBackLedger."Trade-in Device model no." := SalesInvHeader."Trade-in Device Model no.";
                BuyBackLedger."Trade-in device IMEI no." := SalesInvHeader."Trade-in device IMEI no.";
                BuyBackLedger."Transfer Amount" := SalesInvHeader."Servify Transfer Amount";
                BuyBackLedger."Sweetner Amount" := SalesInvHeader."Servify Bonus Amount";
                BuyBackLedger."Maple Contribution" := SalesInvHeader."Maple Contribution";
                BuyBackLedger."Apple Contribution" := SalesInvHeader."Apple Contribution";
                BuyBackLedger."Servify Approval Code" := SalesInvHeader."Servify Approval Code";
                BuyBackLedger."Total BB Value" := SalesInvHeader."Servify Transfer Amount" + SalesInvHeader."Maple Contribution";
                BuyBackLedger."Normal Buyback Amt" := SalesInvHeader."Maple Buyback Amt";
                BuyBackLedger."Servify Purchase Amount" := SalesInvHeader."Servify Purchase Amount";
                BuyBackLedger."EasyOzy Bonus Amount" := SalesInvHeader."EasyOzy Bonus Amount";
                BuyBackLedger."Location Code" := SalesInvHeader."Location Code";
                BuyBackLedger."Bonus Amount" := SalesInvHeader."Bonus Amount";
                BuyBackLedger."Device Retailer Amount" := SalesInvHeader."Device Retailer Amount";
                BuyBackLedger.Insert();
            END;
        END;

        //<<<<<Buy Back

        SalesnRec.Get;
        Clear(JSONContent);
        UpdateGLEntry();
        SalesInvHeader.Reset();
        SalesInvHeader.SetRange("No.", SalesInvHdrNo);
        SalesInvHeader.setrange("Sales Order Type", SalesInvHeader."Sales Order Type"::B2B);
        IF SalesInvHeader.FindFirst() THEN BEGIN
            ClockmeAPI(SalesInvHeader);
            //ClockmeInvoiceAPI(SalesInvHeader);
            JSONContent := LogisiticAPI(SalesInvHeader);
            LogisiticInvoiceAPI(SalesInvHeader);


            ResponseJsonObject.ReadFrom(JSONContent);
            IF ResponseJsonObject.Get('data', ResponseJsonToken) THEN BEGIN
                OrderJsonObject := ResponseJsonToken.AsObject();
                IF OrderJsonObject.Get('shippingLabelUrl', ResponseJsonToken) THEN
                    SalesInvHeader."Shipping Label" := ResponseJsonToken.AsValue().AsText();
                SalesInvHeader.modify(false);
            END;
            IF SalesnRec."Logistic Show Json" THEN BEGIN
                Message(JSONContent);
                Message('URL: %1', ResponseJsonToken.AsValue().AsText());
            END;
        END;
    end;

    procedure LogisiticAPI(SalesInvHeader: Record "Sales Invoice Header"): Text
    var
        HttpClient: HttpClient;
        SecurityHttpClient: HttpClient;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        SecurityHttpResponse: HttpResponseMessage;
        URL: Text;
        HttpRequest: HttpRequestMessage;
        SubFolder: Text[100];
        OrderNo: Code[20];
        HttpsContent: HttpContent;
        SecurityHttpsContent: HttpContent;
        HttpsHeader: HttpHeaders;
        ReturnValue: ARRAY[20] OF Text[1000];
        jObj: JsonObject;
        json: Text;
        SalesnRec: Record "Sales & Receivables Setup";
        RequestHeader: HttpHeaders;
        SecurityRequestHeader: HttpHeaders;
        AuthString: Text;
        SecurityResponseText: Text;
        DateFolderName: Text;
        SalesInvoiceHeaderObject: JsonObject;
        SalesInvoiceLineObject: JsonObject;
        SalesInvoiceLineObjectArray: JsonArray;
        SalesInvLine: Record "Sales Invoice Line";
        TaxTransaction: Record "Tax Transaction Value";
        RecItem: Record item;
        ILE: Record "Item Ledger Entry";
        SIL: Record "Sales Invoice Line";
        TotalGST: Decimal;
        IntegrationLogs: Record "Integration Logs";
        IntegrationLogsInit: Record "Integration Logs";
        EntryNo: Integer;
    begin
        SalesnRec.Get();
        Clear(AuthString);
        clear(URL);
        clear(json);
        SalesInvoiceHeaderObject.Add('orderId', SalesInvHeader."Order ID");//Check
        SalesInvoiceHeaderObject.Add('warehouseName', SalesInvHeader."Location Code");
        SalesInvoiceHeaderObject.Add('slaInHr', 24);//SalesInvHeader."No.");
        SalesInvoiceHeaderObject.Add('paymentStatus', SalesInvHeader."Payment Status");//check
        SalesInvoiceHeaderObject.Add('paymentMode', SalesInvHeader."Payment Mode");// SalesInvHeader."Payment Terms Code");
        SalesInvoiceHeaderObject.Add('customerName', SalesInvHeader."Sell-to Customer Name");
        SalesInvoiceHeaderObject.Add('customerMobile', SalesInvHeader."Cust. Mobile No.");//check
        SalesInvoiceHeaderObject.Add('customerEmail', SalesInvHeader."Sell-to E-Mail");
        SalesInvoiceHeaderObject.Add('shippingCountry', SalesInvHeader."Ship-to Country/Region Code");
        SalesInvoiceHeaderObject.Add('shippingAddressLine1', SalesInvHeader.ERPShipToAdd1);
        SalesInvoiceHeaderObject.Add('shippingAddressLine2', SalesInvHeader.ERPShipToAdd2);
        SalesInvoiceHeaderObject.Add('shippingAddressCity', SalesInvHeader.ERPShipToCity);
        SalesInvoiceHeaderObject.Add('shippingAddressState', SalesInvHeader.ERPShipToState);
        SalesInvoiceHeaderObject.Add('shippingAddressZipCode', SalesInvHeader.ERPShipToPostCode);
        SalesInvoiceHeaderObject.Add('billingCountry', SalesInvHeader."Bill-to Country/Region Code");
        SalesInvoiceHeaderObject.Add('billingAddressLine1', SalesInvHeader.ERPBillToAdd1);
        SalesInvoiceHeaderObject.Add('billingAddressLine2', SalesInvHeader.ERPBillToAdd2);
        SalesInvoiceHeaderObject.Add('billingAddressCity', SalesInvHeader.ERPBillToCity);
        SalesInvoiceHeaderObject.Add('billingAddressState', SalesInvHeader."Bill-to County");
        SalesInvoiceHeaderObject.Add('billingAddressZipCode', SalesInvHeader.ERPBillToPostCode);
        SalesInvoiceHeaderObject.Add('marketplace', 'Maple');//Check
        SalesInvoiceHeaderObject.Add('orderDate', SalesInvHeader.orderDateTime); // FORMAT(SalesInvHeader."Order Date", 0, 9));

        SalesInvLine.Reset();
        SalesInvLine.SetRange("Document No.", SalesInvHeader."No.");
        SalesInvLine.SetRange(Type, SalesInvLine.Type::Item);
        IF SalesInvLine.FindSet() THEN
            REPEAT
                IF RecItem.GET(SalesInvLine."No.") THEN;
                SalesInvoiceLineObject.Add('productSku', RecItem."Vendor Part Code Long");
                SalesInvoiceLineObject.Add('quantity', SalesInvLine.Quantity);
                SalesInvoiceLineObject.Add('basePrice', SalesInvLine."Unit Price");
                SalesInvoiceLineObject.Add('discount', SalesInvLine."Discount Amount");
                SalesInvoiceLineObject.Add('taxRate', GetGSTPercentage(SalesInvLine.RecordId));
                SalesInvoiceLineObject.Add('taxAmount', GetGSTAmount(SalesInvLine.RecordId));
                SalesInvoiceLineObject.Add('totalAmount', SalesInvLine."Line Amount" + GetGSTAmount(SalesInvLine.RecordId));
                SalesInvoiceLineObject.Add('cgst', 0);
                SalesInvoiceLineObject.Add('HSNCode', SalesInvLine."HSN/SAC Code");
                SalesInvoiceLineObject.Add('sgst', 0);
                /*
                 ILE.Reset();
                 ILE.SetRange(ILE."Document No.", SalesInvLine."No.");
                 ILE.SetRange(ILE."Document Line No.", SalesInvLine."Line No.");
                 ILE.SetRange(ILE."Item No.", SalesInvLine."No.");
                 ILE.SetRange(ILE."Location Code", SalesInvLine."Location Code");
                 ILE.SetRange(ILE."Entry Type", ILE."Entry Type"::Sale);
                 IF ILE.FindFirst() THEN;
                 SalesInvoiceLineObject.Add('mrp', ILE."MRP Value");
 */
                SalesInvoiceLineObjectArray.Add(SalesInvoiceLineObject);
            UNTIL SalesInvLine.Next() = 0;

        Clear(TotalGST);
        SIL.Reset();
        SIL.SetRange(SIL."Document No.", SalesInvHeader."No.");
        IF SIL.FindSet() THEN
            REPEAT
                TotalGST += GetGSTAmount(SIL.RecordId)
            UNTIL SIL.Next() = 0;


        SalesInvoiceHeaderObject.Add('orderSkus', SalesInvoiceLineObjectArray);
        SalesInvoiceHeaderObject.Add('length', 0); //check
        SalesInvoiceHeaderObject.Add('breadth', 0);//check
        SalesInvoiceHeaderObject.Add('height', 0);//check
        SalesInvoiceHeaderObject.Add('weight', 0);//check
        SalesInvoiceHeaderObject.Add('totalDiscountAmount', SalesInvHeader."Invoice Discount Amount");
        SalesInvoiceHeaderObject.Add('purchaseTax', 0);//check
        SalesInvHeader.CalcFields("Amount Including VAT");
        SalesInvoiceHeaderObject.Add('invoiceAmount', SalesInvHeader."Amount Including VAT" + TotalGST);
        SalesInvoiceHeaderObject.Add('shippingAmount', 0);//check
        SalesInvoiceHeaderObject.Add('codAmount', 0);//check
        SalesInvoiceHeaderObject.Add('invoiceNumber', SalesInvHeader."No.");//check
        SalesInvoiceHeaderObject.Add('remark', SalesInvHeader.Comment);
        SalesInvoiceHeaderObject.Add('erpSoTimestamp', SalesInvHeader.erpSoTimestamp);
        SalesInvoiceHeaderObject.Add('erpBillingTimestamp', SalesInvHeader.SystemCreatedAt);

        json := Format(SalesInvoiceHeaderObject);

        //>>>>>
        Clear(EntryNo);
        IntegrationLogs.Reset();
        if IntegrationLogs.FindLast() THEN
            EntryNo := IntegrationLogs."Entry No." + 1
        else
            EntryNo := 1;

        IntegrationLogsInit.Init();
        IntegrationLogsInit."Entry No." := EntryNo;
        IntegrationLogsInit."Document Type" := IntegrationLogsInit."Document Type"::Logistic;
        IntegrationLogsInit."Creation Date" := Today;
        IntegrationLogsInit.Time := Time;
        IntegrationLogsInit."Invoice No." := SalesInvHeader."No.";
        IntegrationLogsInit."Order ID" := SalesInvHeader."Order ID";
        IntegrationLogsInit.Request := CopyStr(json, 1, 2048);
        //IntegrationLogsInit.Response := ResponseText;
        IntegrationLogsInit.Insert();
        //<<<<<


        HttpsContent.WriteFrom(json);
        HttpsContent.GetHeaders(RequestHeader);
        RequestHeader.Remove('Content-Type');
        RequestHeader.Add('Content-Type', 'application/json');
        AuthString := STRSUBSTNO('Bearer %1', Token(EntryNo));
        HttpClient.DefaultRequestHeaders().Add('Authorization', AuthString);
        URL := SalesnRec."Logistic URL";// 'https://stagingapp.edgistify.com/api_c/clients/order/create';
        HttpClient.SetBaseAddress(URL);


        Clear(ResponseText);
        IF SalesnRec."Logistic Show Json" THEN BEGIN
            Message(json);
            Message(URL);
        END;
        IF HttpClient.Post(URL, HttpsContent, HttpResponse) THEN BEGIN
            HttpResponse.Content.ReadAs(ResponseText);

            //>>>>>
            IntegrationLogs.Reset();
            IntegrationLogs.SetRange(IntegrationLogs."Entry No.", EntryNo);
            IF IntegrationLogs.FindFirst() THEN BEGIN
                IntegrationLogs.Response := CopyStr(ResponseText, 1, 2048);
                IntegrationLogs.Modify(false);
            END;
            //<<<<<

            IF SalesnRec."Logistic Show Json" THEN
                Message(ResponseText);
            exit(ResponseText);
        END;
    end;

    /* procedure LogisiticInvoiceAPI(SalesInvHeader: Record "Sales Invoice Header");
    var
        HttpClient1: HttpClient;
        SecurityHttpClient1: HttpClient;
        HttpResponse1: HttpResponseMessage;
        ResponseText1: Text;
        SecurityHttpResponse1: HttpResponseMessage;
        URL: Text;
        HttpRequest1: HttpRequestMessage;
        SubFolder: Text[100];
        OrderNo: Code[20];
        HttpsContent1: HttpContent;
        SecurityHttpsContent1: HttpContent;
        HttpsHeader1: HttpHeaders;
        ReturnValue1: ARRAY[20] OF Text[1000];
        jObj1: JsonObject;
        json: Text;
        SalesnRec: Record "Sales & Receivables Setup";
        RequestHeader1: HttpHeaders;
        SecurityRequestHeader1: HttpHeaders;
        AuthString1: Text;
        SecurityResponseText1: Text;
        DateFolderName1: Text;
        SalesInvoiceHeaderObject1: JsonObject;
        SalesInvoiceLineObject1: JsonObject;
        SalesInvoiceLineObjectArray1: JsonArray;
        SalesInvLine1: Record "Sales Invoice Line";
        TaxTransaction1: Record "Tax Transaction Value";
        RecItem1: Record item;
        RecSIH1: Record "Sales Invoice Header";
        Base64Convert1: Codeunit "Base64 Convert";
        OStream1: OutStream;
        IStream1: InStream;
        RecRef1: RecordRef;
        TempBlob1: Codeunit "Temp Blob";
        TempBlob: Codeunit "Temp Blob";
    begin
        SalesnRec.Get();
        Clear(AuthString1);
        clear(URL);
        clear(json);
        Clear(IStream1);
        Clear(OStream1);
        Clear(SalesInvoiceHeaderObject1);
        HttpClient1.Clear();

        SalesInvoiceHeaderObject1.Add('fileName', 'Invoice.pdf');//Check
        SalesInvoiceHeaderObject1.Add('orderID', SalesInvHeader."Order ID");

        RecSIH1.Reset();
        RecSIH1.SetRange("No.", SalesInvHeader."No.");
        RecRef1.GetTable(RecSIH1);
        IF RecRef1.FINDSET(FALSE, FALSE) THEN BEGIN
            TempBlob1.CreateOutStream(OStream1, TEXTENCODING::UTF8);
            REPORT.SAVEAS(50007, SalesInvHeader."No.", REPORTFORMAT::Pdf, OStream1, RecRef1);
            TempBlob1.CreateInStream(IStream1, TextEncoding::UTF8);
        end;

        SalesInvoiceHeaderObject1.Add('fileContent', Base64Convert1.ToBase64(IStream1));


        json := Format(SalesInvoiceHeaderObject1);

        HttpsContent1.WriteFrom(json);
        HttpsContent1.GetHeaders(RequestHeader1);
        RequestHeader1.Remove('Content-Type');
        RequestHeader1.Add('Content-Type', 'application/json');
        RequestHeader1.Add('Content-Length', format(TempBlob1.Length()));
        AuthString1 := STRSUBSTNO('Bearer %1', Token());
        HttpClient1.DefaultRequestHeaders().Add('Authorization', AuthString1);
        URL := SalesnRec."Logistic Invoice URL";// 'https://stagingapp.edgistify.com/api_c/clients/order/create';
        HttpClient1.SetBaseAddress(URL);
        Clear(ResponseText1);
        IF SalesnRec."Logistic Show Json" THEN BEGIN
            Message(AuthString1);
            Message(json);
            Message(URL);
        END;
        IF HttpClient1.Post(URL, HttpsContent1, HttpResponse1) THEN BEGIN
            HttpResponse1.Content.ReadAs(ResponseText1);
            IF SalesnRec."Logistic Show Json" THEN
                Message(ResponseText1);
        END;
    end; */


    /* procedure Token(): Text
    var
        HttpClient: HttpClient;
        URL: Text;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        HttpsContent: HttpContent;
        HttpRequest: HttpRequestMessage;
        json: Text;
        RequestHeader: HttpHeaders;
        RequestJsonObject: JsonObject;
        JsonToken: JsonToken;
        NewJsonToken: JsonToken;
        TokenJsonObject: JsonObject;
        Token: Text;
        FinalTokenObject: JsonObject;
        FinalJsonToken: JsonToken;
        SalesnRec: Record "Sales & Receivables Setup";
    BEGIN
        SalesnRec.Get();
        RequestJsonObject.Add('username', SalesnRec."Logistic User Name");//'jay.r@mapletechnologies.org');
        RequestJsonObject.Add('password', SalesnRec."Logistic Password");//'Maple@123456');
        //json := '{"username":"jay.r@mapletechnologies.org","password":"Maple@123456"}';
        json := Format(RequestJsonObject);
        Message(json);
        HttpsContent.WriteFrom(json);
        HttpsContent.GetHeaders(RequestHeader);
        RequestHeader.Remove('Content-Type');
        RequestHeader.Add('Content-Type', 'application/json');
        URL := SalesnRec."Logistic Token URL";//'https://stagingapp.edgistify.com/api_c/users/login';

        HttpClient.SetBaseAddress(URL);

        IF HttpClient.Post(URL, HttpsContent, HttpResponse) THEN BEGIN
            HttpResponse.Content.ReadAs(ResponseText);
            //  Message(ResponseText);
            if JsonToken.ReadFrom(ResponseText) then
                if JsonToken.IsObject then begin
                    TokenJsonObject := JsonToken.AsObject();
                    if TokenJsonObject.Get('data', NewJsonToken) then
                        TokenJsonObject.SelectToken('data', NewJsonToken);
                    // Message(Format(NewJsonToken));

                    if FinalJsonToken.ReadFrom(Format(NewJsonToken)) THEN
                        if FinalJsonToken.IsObject then begin
                            FinalTokenObject := FinalJsonToken.AsObject();
                            IF FinalTokenObject.Get('token', FinalJsonToken) THEN BEGIN
                                Token := FinalJsonToken.AsValue().AsText();
                                Message(Token);
                                exit(Token);
                            END;
                        end;
                END;
        END;
    END; */
    procedure Token(EntryNo: Integer): Text
    var
        HttpClient: HttpClient;
        URL: Text;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        HttpsContent: HttpContent;
        HttpRequest: HttpRequestMessage;
        json: Text;
        RequestHeader: HttpHeaders;
        RequestJsonObject: JsonObject;
        JsonToken: JsonToken;
        NewJsonToken: JsonToken;
        TokenJsonObject: JsonObject;
        Token: Text;
        FinalTokenObject: JsonObject;
        FinalJsonToken: JsonToken;
        SalesnRec: Record "Sales & Receivables Setup";
        //HttpClient: HttpClient;
        HttpContent: HttpContent;
        HttpHeaders: HttpHeaders;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        JAccessToken: JsonObject;
        IntegrationLogs: Record "Integration Logs";
    //JsonToken: JsonToken;
    //ResponseText: Text;
    BEGIN
        SalesnRec.Get();
        json := 'username=' + EscapeDataString(SalesnRec."Logistic User Name") + //'jay.r@mapletechnologies.org');
                          '&password=' + EscapeDataString(SalesnRec."Logistic Password"); //'Maple@123456');
        Message(json);
        URL := SalesnRec."Logistic Token URL";//'https://stagingapp.edgistify.com/api_c/users/login';
        HttpContent.WriteFrom(json);
        HttpContent.GetHeaders(HttpHeaders);
        HttpHeaders.Remove('Content-Type');
        HttpHeaders.Add('Content-Type', 'application/x-www-form-urlencoded');
        HttpRequestMessage.Method := 'POST';
        HttpRequestMessage.SetRequestUri(URL);
        HttpRequestMessage.Content(HttpContent);
        if HttpClient.Send(HttpRequestMessage, HttpResponseMessage) then begin
            //>>>>>
            HttpResponseMessage.Content.ReadAs(ResponseText);
            IntegrationLogs.Reset();
            IntegrationLogs.SetRange(IntegrationLogs."Entry No.", EntryNo);
            IF IntegrationLogs.FindFirst() THEN BEGIN
                IntegrationLogs.Token := CopyStr(ResponseText, 1, 2048);
                IntegrationLogs.Modify(false);
            END;
            //<<<<<
            if HttpResponseMessage.IsSuccessStatusCode() then begin
                if HttpResponseMessage.Content.ReadAs(ResponseText) then
                    if JsonToken.ReadFrom(ResponseText) then
                        if JsonToken.IsObject then begin
                            TokenJsonObject := JsonToken.AsObject();
                            if TokenJsonObject.Get('data', NewJsonToken) then
                                TokenJsonObject.SelectToken('data', NewJsonToken);
                        end;
                if FinalJsonToken.ReadFrom(Format(NewJsonToken)) THEN
                    if FinalJsonToken.IsObject then begin
                        FinalTokenObject := FinalJsonToken.AsObject();
                        IF FinalTokenObject.Get('token', FinalJsonToken) THEN BEGIN
                            Token := FinalJsonToken.AsValue().AsText();
                            Message(Token);
                            exit(Token);
                        END;
                    end;
            end;
        end;

    END;

    procedure InvoiceToken(): Text
    var
        HttpClient: HttpClient;
        URL: Text;
        HttpResponse: HttpResponseMessage;
        ResponseText: Text;
        HttpsContent: HttpContent;
        HttpRequest: HttpRequestMessage;
        json: Text;
        RequestHeader: HttpHeaders;
        RequestJsonObject: JsonObject;
        JsonToken: JsonToken;
        NewJsonToken: JsonToken;
        TokenJsonObject: JsonObject;
        Token: Text;
        FinalTokenObject: JsonObject;
        FinalJsonToken: JsonToken;
        SalesnRec: Record "Sales & Receivables Setup";
        //HttpClient: HttpClient;
        HttpContent: HttpContent;
        HttpHeaders: HttpHeaders;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        JAccessToken: JsonObject;
        IntegrationLogs: Record "Integration Logs";
    //JsonToken: JsonToken;
    //ResponseText: Text;
    BEGIN
        SalesnRec.Get();
        json := 'username=' + EscapeDataString(SalesnRec."Logistic User Name") + //'jay.r@mapletechnologies.org');
                          '&password=' + EscapeDataString(SalesnRec."Logistic Password"); //'Maple@123456');
        Message(json);
        URL := SalesnRec."Logistic Token URL";//'https://stagingapp.edgistify.com/api_c/users/login';
        HttpContent.WriteFrom(json);
        HttpContent.GetHeaders(HttpHeaders);
        HttpHeaders.Remove('Content-Type');
        HttpHeaders.Add('Content-Type', 'application/x-www-form-urlencoded');
        HttpRequestMessage.Method := 'POST';
        HttpRequestMessage.SetRequestUri(URL);
        HttpRequestMessage.Content(HttpContent);
        if HttpClient.Send(HttpRequestMessage, HttpResponseMessage) then
            if HttpResponseMessage.IsSuccessStatusCode() then begin
                if HttpResponseMessage.Content.ReadAs(ResponseText) then
                    if JsonToken.ReadFrom(ResponseText) then
                        if JsonToken.IsObject then begin
                            TokenJsonObject := JsonToken.AsObject();
                            if TokenJsonObject.Get('data', NewJsonToken) then
                                TokenJsonObject.SelectToken('data', NewJsonToken);
                        end;
                if FinalJsonToken.ReadFrom(Format(NewJsonToken)) THEN
                    if FinalJsonToken.IsObject then begin
                        FinalTokenObject := FinalJsonToken.AsObject();
                        IF FinalTokenObject.Get('token', FinalJsonToken) THEN BEGIN
                            Token := FinalJsonToken.AsValue().AsText();
                            Message(Token);
                            exit(Token);
                        END;
                    end;
            end;
    END;


    procedure LogisiticInvoiceAPI(SalesInvHeader: Record "Sales Invoice Header");
    var
        HttpClient1: HttpClient;
        SecurityHttpClient1: HttpClient;
        HttpResponse1: HttpResponseMessage;
        ResponseText1: Text;
        SecurityHttpResponse1: HttpResponseMessage;
        URL: Text;
        HttpRequest1: HttpRequestMessage;
        SubFolder: Text[100];
        OrderNo: Code[20];
        HttpsContent1: HttpContent;
        SecurityHttpsContent1: HttpContent;
        HttpsHeader1: HttpHeaders;
        ReturnValue1: ARRAY[20] OF Text[1000];
        jObj1: JsonObject;
        json: Text;
        SalesnRec: Record "Sales & Receivables Setup";
        RequestHeader1: HttpHeaders;
        SecurityRequestHeader1: HttpHeaders;
        AuthString1: Text;
        SecurityResponseText1: Text;
        DateFolderName1: Text;
        SalesInvoiceHeaderObject1: JsonObject;
        SalesInvoiceLineObject1: JsonObject;
        SalesInvoiceLineObjectArray1: JsonArray;
        SalesInvLine1: Record "Sales Invoice Line";
        TaxTransaction1: Record "Tax Transaction Value";
        RecItem1: Record item;
        RecSIH1: Record "Sales Invoice Header";
        Base64Convert1: Codeunit "Base64 Convert";
        OStream1: OutStream;
        IStream1: InStream;
        RecRef1: RecordRef;
        TempBlob1: Codeunit "Temp Blob";
        TempBlob: Codeunit "Temp Blob";
        ResponseTxtJsonObject: JsonObject;
        Base64Convert: Codeunit "Base64 Convert";
        APIResponse: Text;
        HttpContent: HttpContent;
        HttpHeaders: HttpHeaders;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        HttpClient: HttpClient;
        JAccessToken: JsonObject;
        ResponseText: Text;
    begin
        RecSIH1.Reset();
        RecSIH1.SetRange("No.", SalesInvHeader."No.");
        RecRef1.GetTable(RecSIH1);
        IF RecRef1.FINDSET(FALSE, FALSE) THEN BEGIN
            TempBlob1.CreateOutStream(OStream1, TEXTENCODING::UTF8);
            REPORT.SAVEAS(50007, SalesInvHeader."No.", REPORTFORMAT::Pdf, OStream1, RecRef1);
            TempBlob1.CreateInStream(IStream1, TextEncoding::UTF8);
        end;
        SalesnRec.Get();
        ResponseTxtJsonObject.Add('FileName', 'invoice.pdf');
        ResponseTxtJsonObject.Add('OrderID', SalesInvHeader."Order ID");
        ResponseTxtJsonObject.Add('FileContent', Base64Convert.ToBase64(IStream1));
        ResponseTxtJsonObject.WriteTo(APIResponse);


        Clear(AuthString1);
        clear(URL);
        clear(json);
        Clear(IStream1);
        Clear(OStream1);
        Clear(SalesInvoiceHeaderObject1);
        HttpContent.WriteFrom(APIResponse);
        HttpContent.GetHeaders(HttpHeaders);
        AuthString1 := GetAuthenticationHeaderValue(InvoiceToken());
        HttpClient.DefaultRequestHeaders.Add('Authorization', AuthString1);
        HttpHeaders.Remove('Content-Type');
        HttpHeaders.Add('Content-Type', 'application/json');
        HttpRequestMessage.Method := 'POST';
        URL := SalesnRec."Logistic Invoice URL";// 'https://stagingapp.edgistify.com/api_c/clients/order/create';
        HttpRequestMessage.SetRequestUri(URL);
        IF SalesnRec."Logistic Show Json" THEN BEGIN
            Message(AuthString1);
            Message(APIResponse);
            Message(URL);
        END;
        HttpRequestMessage.Content(HttpContent);
        if HttpClient.Send(HttpRequestMessage, HttpResponseMessage) then
            if HttpResponseMessage.IsSuccessStatusCode() then
                if HttpResponseMessage.Content.ReadAs(ResponseText) then
                    IF SalesnRec."Logistic Show Json" THEN
                        Message(ResponseText);
    end;




    local procedure GetAuthenticationHeaderValue(AccessToken: Text) Value: Text;
    begin
        Value := StrSubstNo('Bearer %1', AccessToken);
    end;

    procedure EscapeDataString(Text: Text): Text
    var
        Uri: Codeunit Uri;
    begin
        exit(Uri.EscapeDataString(Text));
    end;

    /*
        procedure Token(): Text

        var
            HttpClient: HttpClient;
            URL: Text;
            HttpResponse: HttpResponseMessage;
            ResponseText: Text;
            HttpsContent: HttpContent;
            HttpRequest: HttpRequestMessage;
            json: Text;
            RequestHeader: HttpHeaders;
            RequestJsonObject: JsonObject;
            JsonToken: JsonToken;
            NewJsonToken: JsonToken;
            TokenJsonObject: JsonObject;
            Token: Text;
            FinalTokenObject: JsonObject;
            FinalJsonToken: JsonToken;
            SalesnRec: Record "Sales & Receivables Setup";
        BEGIN
            SalesnRec.Get();
            RequestJsonObject.Add('username', SalesnRec."Logistic User Name");//'jay.r@mapletechnologies.org');
            RequestJsonObject.Add('password', SalesnRec."Logistic Password");//'Maple@123456');
            //json := '{"username":"jay.r@mapletechnologies.org","password":"Maple@123456"}';
            json := Format(RequestJsonObject);
            HttpsContent.WriteFrom(json);
            HttpsContent.GetHeaders(RequestHeader);
            RequestHeader.Remove('Content-Type');
            RequestHeader.Add('Content-Type', 'application/json');
            URL := SalesnRec."Logistic Token URL";//'https://stagingapp.edgistify.com/api_c/users/login';

            HttpClient.SetBaseAddress(URL);
            IF SalesnRec."Logistic Show Json" THEN BEGIN
                Message(json);
                MESSAGE(URL);
            END;

            IF HttpClient.Post(URL, HttpsContent, HttpResponse) THEN BEGIN
                HttpResponse.Content.ReadAs(ResponseText);
                IF SalesnRec."Logistic Show Json" THEN
                    Message(ResponseText);
                // if JsonToken.ReadFrom(ResponseText) then
                if JsonToken.IsObject then begin
                    TokenJsonObject := JsonToken.AsObject();
                    if TokenJsonObject.Get('data', NewJsonToken) then
                        TokenJsonObject.SelectToken('data', NewJsonToken);
                    IF SalesnRec."Logistic Show Json" THEN
                        Message(Format(NewJsonToken));

                    if FinalJsonToken.ReadFrom(Format(NewJsonToken)) THEN
                        if FinalJsonToken.IsObject then begin
                            FinalTokenObject := FinalJsonToken.AsObject();
                            IF FinalTokenObject.Get('token', FinalJsonToken) THEN BEGIN
                                Token := FinalJsonToken.AsValue().AsText();
                                IF SalesnRec."Logistic Show Json" THEN
                                    Message(Token);
                                exit(Token);
                            END;
                        end;
                END;
            END;
        END;
    */
    procedure GetGSTAmount(RecID: RecordID): Decimal
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
    begin
        if not GSTSetup.Get() then
            exit;

        TaxTransactionValue.SetRange("Tax Record ID", RecID);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        if GSTSetup."Cess Tax Type" <> '' then
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type", GSTSetup."Cess Tax Type")
        else
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if not TaxTransactionValue.IsEmpty() then
            TaxTransactionValue.CalcSums(Amount);

        exit(TaxTransactionValue.Amount);
    end;

    procedure GetGSTPercentage(RecID: RecordID): Decimal
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
    begin
        if not GSTSetup.Get() then
            exit;

        TaxTransactionValue.SetRange("Tax Record ID", RecID);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        if GSTSetup."Cess Tax Type" <> '' then
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type", GSTSetup."Cess Tax Type")
        else
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if not TaxTransactionValue.IsEmpty() then
            TaxTransactionValue.CalcSums(Percent);

        exit(TaxTransactionValue.Percent);
    end;

    //<<RY
    //CodeUnit80++
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', false, false)]
    local procedure OnBeforePostSalesDoc(var Sender: Codeunit "Sales-Post"; var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; var HideProgressWindow: Boolean; var IsHandled: Boolean);
    begin
        //WIN316++
        //Check_GST_Amount_Before_Posting(Rec);
        //WIN316--

        //+++++++++=Voucher
        if (SalesHeader."Document Type" = SalesHeader."document type"::Order) then
            if RecSHHH.Get(SalesHeader."No.") then begin
                if (RecSHHH."Voucher Int. No.1" <> '') and (RecSHHH."Voucher Amount1" = 0) then
                    Error('Please remove Voucher Code and Pin if not getting redeem  %1!!', RecSHHH."Voucher Int. No.1");
                if (RecSHHH."Voucher Int. No.2" <> '') and (RecSHHH."Voucher Amount2" = 0) then
                    Error('Please remove Voucher Code and Pin if not getting redeem  %1!!', RecSHHH."Voucher Int. No.2");
                if (RecSHHH."Voucher Int. No.3" <> '') and (RecSHHH."Voucher Amount3" = 0) then
                    Error('Please remove Voucher Code and Pin if not getting redeem  %1!!', RecSHHH."Voucher Int. No.3");
                if (RecSHHH."Voucher Int. No.4" <> '') and (RecSHHH."Voucher Amount4" = 0) then
                    Error('Please remove Voucher Code and Pin if not getting redeem  %1!!', RecSHHH."Voucher Int. No.4");
                if (RecSHHH."Voucher Int. No.5" <> '') and (RecSHHH."Voucher Amount5" = 0) then
                    Error('Please remove Voucher Code and Pin if not getting redeem  %1!!', RecSHHH."Voucher Int. No.5");
                if (RecSHHH."Voucher Int. No.6" <> '') and (RecSHHH."Voucher Amount6" = 0) then
                    Error('Please remove Voucher Code and Pin if not getting redeem  %1!!', RecSHHH."Voucher Int. No.6");
                if (RecSHHH."Voucher Int. No.7" <> '') and (RecSHHH."Voucher Amount7" = 0) then
                    Error('Please remove Voucher Code and Pin if not getting redeem  %1!!', RecSHHH."Voucher Int. No.7");
                if (RecSHHH."Voucher Int. No.8" <> '') and (RecSHHH."Voucher Amount8" = 0) then
                    Error('Please remove Voucher Code and Pin if not getting redeem  %1!!', RecSHHH."Voucher Int. No.8");
                if (RecSHHH."Voucher Int. No.9" <> '') and (RecSHHH."Voucher Amount9" = 0) then
                    Error('Please remove Voucher Code and Pin if not getting redeem  %1!!', RecSHHH."Voucher Int. No.9");
                if (RecSHHH."Voucher Int. No.10" <> '') and (RecSHHH."Voucher Amount10" = 0) then
                    Error('Please remove Voucher Code and Pin if not getting redeem  %1!!', RecSHHH."Voucher Int. No.10");


                if (RecSHHH."Voucher Amount1" <> 0) then begin
                    RecEINV.Reset;
                    RecEINV.SetRange("Vouchr. Code", UpperCase(RecSHHH."Voucher Int. No.1"));
                    RecEINV.SetRange("Vouchr. Integration", true);
                    RecEINV.SetFilter("Vouchr. Capture id", '<>%1', '');
                    if not RecEINV.FindFirst then
                        Error('Please check if Voucher has been captured successfully %1', RecSHHH."Voucher Int. No.1");
                end;//WIN234 29042021 voucher integration
                if (RecSHHH."Voucher Amount1" <> 0) then begin
                    RecEINV.Reset;
                    RecEINV.SetRange("Vouchr. Code", UpperCase(RecSHHH."Voucher Int. No.1"));
                    RecEINV.SetRange("Vouchr. Integration", true);
                    if not RecEINV.FindFirst then
                        Error('Please check if Voucher has been captured/authorized successfully or not %1', RecSHHH."Voucher Int. No.1");
                    RecEINV.Reset;
                    RecEINV.SetRange("Vouchr. Code", UpperCase(RecSHHH."Voucher Int. No.1"));
                    RecEINV.SetRange("Vouchr. Integration", true);

                    if RecEINV.FindLast then begin
                        if RecEINV."Vouchr. Capture id" <> '' then
                            bbc := ''
                        else
                            Error('Please check if Voucher has been captured/authorized successfully or not %1', RecSHHH."Voucher Int. No.1");
                    end;
                end;
                //2
                if (RecSHHH."Voucher Amount2" <> 0) then begin
                    RecEINV.Reset;
                    RecEINV.SetRange("Vouchr. Code", UpperCase(RecSHHH."Voucher Int. No.2"));
                    RecEINV.SetRange("Vouchr. Integration", true);
                    RecEINV.SetFilter("Vouchr. Capture id", '<>%1', '');
                    if not RecEINV.FindFirst then
                        Error('Please check if Voucher has been captured successfully %1', RecSHHH."Voucher Int. No.2");
                end;//WIN234 29042021 voucher integration
                if (RecSHHH."Voucher Amount2" <> 0) then begin
                    RecEINV.Reset;
                    RecEINV.SetRange("Vouchr. Code", UpperCase(RecSHHH."Voucher Int. No.2"));
                    RecEINV.SetRange("Vouchr. Integration", true);
                    if not RecEINV.FindFirst then
                        Error('Please check if Voucher has been captured/authorized successfully or not %1', RecSHHH."Voucher Int. No.2");
                    RecEINV.Reset;
                    RecEINV.SetRange("Vouchr. Code", UpperCase(RecSHHH."Voucher Int. No.2"));
                    RecEINV.SetRange("Vouchr. Integration", true);

                    if RecEINV.FindLast then begin
                        if RecEINV."Vouchr. Capture id" <> '' then
                            bbc := ''
                        else
                            Error('Please check if Voucher has been captured/authorized successfully or not %1', RecSHHH."Voucher Int. No.3");
                    end;
                end;

                //3
                if (RecSHHH."Voucher Amount3" <> 0) then begin
                    RecEINV.Reset;
                    RecEINV.SetRange("Vouchr. Code", UpperCase(RecSHHH."Voucher Int. No.3"));
                    RecEINV.SetRange("Vouchr. Integration", true);
                    RecEINV.SetFilter("Vouchr. Capture id", '<>%1', '');
                    if not RecEINV.FindFirst then
                        Error('Please check if Voucher has been captured successfully %1', RecSHHH."Voucher Int. No.3");
                end;//WIN234 29042021 voucher integration
                if (RecSHHH."Voucher Amount3" <> 0) then begin
                    RecEINV.Reset;
                    RecEINV.SetRange("Vouchr. Code", UpperCase(RecSHHH."Voucher Int. No.3"));
                    RecEINV.SetRange("Vouchr. Integration", true);
                    if not RecEINV.FindFirst then
                        Error('Please check if Voucher has been captured/authorized successfully or not %1', RecSHHH."Voucher Int. No.3");
                    RecEINV.Reset;
                    RecEINV.SetRange("Vouchr. Code", UpperCase(RecSHHH."Voucher Int. No.3"));
                    RecEINV.SetRange("Vouchr. Integration", true);

                    if RecEINV.FindLast then begin
                        if RecEINV."Vouchr. Capture id" <> '' then
                            bbc := ''
                        else
                            Error('Please check if Voucher has been captured/authorized successfully or not %1', RecSHHH."Voucher Int. No.4");
                    end;
                end;
                //4
                if (RecSHHH."Voucher Amount4" <> 0) then begin
                    RecEINV.Reset;
                    RecEINV.SetRange("Vouchr. Code", UpperCase(RecSHHH."Voucher Int. No.4"));
                    RecEINV.SetRange("Vouchr. Integration", true);
                    RecEINV.SetFilter("Vouchr. Capture id", '<>%1', '');
                    if not RecEINV.FindFirst then
                        Error('Please check if Voucher has been captured successfully %1', RecSHHH."Voucher Int. No.4");
                end;//WIN234 29042021 voucher integration
                if (RecSHHH."Voucher Amount4" <> 0) then begin
                    RecEINV.Reset;
                    RecEINV.SetRange("Vouchr. Code", UpperCase(RecSHHH."Voucher Int. No.4"));
                    RecEINV.SetRange("Vouchr. Integration", true);
                    if not RecEINV.FindFirst then
                        Error('Please check if Voucher has been captured/authorized successfully or not %1', RecSHHH."Voucher Int. No.4");
                    RecEINV.Reset;
                    RecEINV.SetRange("Vouchr. Code", UpperCase(RecSHHH."Voucher Int. No.4"));
                    RecEINV.SetRange("Vouchr. Integration", true);

                    if RecEINV.FindLast then begin
                        if RecEINV."Vouchr. Capture id" <> '' then
                            bbc := ''
                        else
                            Error('Please check if Voucher has been captured/authorized successfully or not %1', RecSHHH."Voucher Int. No.4");
                    end;
                end;

                //5
                if (RecSHHH."Voucher Amount5" <> 0) then begin
                    RecEINV.Reset;
                    RecEINV.SetRange("Vouchr. Code", UpperCase(RecSHHH."Voucher Int. No.5"));
                    RecEINV.SetRange("Vouchr. Integration", true);
                    RecEINV.SetFilter("Vouchr. Capture id", '<>%1', '');
                    if not RecEINV.FindFirst then
                        Error('Please check if Voucher has been captured successfully %1', RecSHHH."Voucher Int. No.5");
                end;//WIN234 29042021 voucher integration
                if (RecSHHH."Voucher Amount5" <> 0) then begin
                    RecEINV.Reset;
                    RecEINV.SetRange("Vouchr. Code", UpperCase(RecSHHH."Voucher Int. No.5"));
                    RecEINV.SetRange("Vouchr. Integration", true);
                    if not RecEINV.FindFirst then
                        Error('Please check if Voucher has been captured/authorized successfully or not %1', RecSHHH."Voucher Int. No.5");
                    RecEINV.Reset;
                    RecEINV.SetRange("Vouchr. Code", UpperCase(RecSHHH."Voucher Int. No.5"));
                    RecEINV.SetRange("Vouchr. Integration", true);

                    if RecEINV.FindLast then begin
                        if RecEINV."Vouchr. Capture id" <> '' then
                            bbc := ''
                        else
                            Error('Please check if Voucher has been captured/authorized successfully or not %1', RecSHHH."Voucher Int. No.5");
                    end;
                end;

                //6
                if (RecSHHH."Voucher Amount6" <> 0) then begin
                    RecEINV.Reset;
                    RecEINV.SetRange("Vouchr. Code", UpperCase(RecSHHH."Voucher Int. No.6"));
                    RecEINV.SetRange("Vouchr. Integration", true);
                    RecEINV.SetFilter("Vouchr. Capture id", '<>%1', '');
                    if not RecEINV.FindFirst then
                        Error('Please check if Voucher has been captured successfully %1', RecSHHH."Voucher Int. No.6");
                end;//WIN234 29042021 voucher integration
                if (RecSHHH."Voucher Amount6" <> 0) then begin
                    RecEINV.Reset;
                    RecEINV.SetRange("Vouchr. Code", UpperCase(RecSHHH."Voucher Int. No.6"));
                    RecEINV.SetRange("Vouchr. Integration", true);
                    if not RecEINV.FindFirst then
                        Error('Please check if Voucher has been captured/authorized successfully or not %1', RecSHHH."Voucher Int. No.6");
                    RecEINV.Reset;
                    RecEINV.SetRange("Vouchr. Code", UpperCase(RecSHHH."Voucher Int. No.6"));
                    RecEINV.SetRange("Vouchr. Integration", true);

                    if RecEINV.FindLast then begin
                        if RecEINV."Vouchr. Capture id" <> '' then
                            bbc := ''
                        else
                            Error('Please check if Voucher has been captured/authorized successfully or not %1', RecSHHH."Voucher Int. No.6");
                    end;
                end;

                //7
                if (RecSHHH."Voucher Amount7" <> 0) then begin
                    RecEINV.Reset;
                    RecEINV.SetRange("Vouchr. Code", UpperCase(RecSHHH."Voucher Int. No.7"));
                    RecEINV.SetRange("Vouchr. Integration", true);
                    RecEINV.SetFilter("Vouchr. Capture id", '<>%1', '');
                    if not RecEINV.FindFirst then
                        Error('Please check if Voucher has been captured successfully %1', RecSHHH."Voucher Int. No.7");
                end;//WIN234 29042021 voucher integration
                if (RecSHHH."Voucher Amount7" <> 0) then begin
                    RecEINV.Reset;
                    RecEINV.SetRange("Vouchr. Code", UpperCase(RecSHHH."Voucher Int. No.7"));
                    RecEINV.SetRange("Vouchr. Integration", true);
                    if not RecEINV.FindFirst then
                        Error('Please check if Voucher has been captured/authorized successfully or not %1', RecSHHH."Voucher Int. No.7");
                    RecEINV.Reset;
                    RecEINV.SetRange("Vouchr. Code", UpperCase(RecSHHH."Voucher Int. No.7"));
                    RecEINV.SetRange("Vouchr. Integration", true);

                    if RecEINV.FindLast then begin
                        if RecEINV."Vouchr. Capture id" <> '' then
                            bbc := ''
                        else
                            Error('Please check if Voucher has been captured/authorized successfully or not %1', RecSHHH."Voucher Int. No.7");
                    end;
                end;

                //8
                if (RecSHHH."Voucher Amount8" <> 0) then begin
                    RecEINV.Reset;
                    RecEINV.SetRange("Vouchr. Code", UpperCase(RecSHHH."Voucher Int. No.8"));
                    RecEINV.SetRange("Vouchr. Integration", true);
                    RecEINV.SetFilter("Vouchr. Capture id", '<>%1', '');
                    if not RecEINV.FindFirst then
                        Error('Please check if Voucher has been captured successfully %1', RecSHHH."Voucher Int. No.8");
                end;//WIN234 29042021 voucher integration
                if (RecSHHH."Voucher Amount8" <> 0) then begin
                    RecEINV.Reset;
                    RecEINV.SetRange("Vouchr. Code", UpperCase(RecSHHH."Voucher Int. No.8"));
                    RecEINV.SetRange("Vouchr. Integration", true);
                    if not RecEINV.FindFirst then
                        Error('Please check if Voucher has been captured/authorized successfully or not %1', RecSHHH."Voucher Int. No.8");
                    RecEINV.Reset;
                    RecEINV.SetRange("Vouchr. Code", UpperCase(RecSHHH."Voucher Int. No.8"));
                    RecEINV.SetRange("Vouchr. Integration", true);

                    if RecEINV.FindLast then begin
                        if RecEINV."Vouchr. Capture id" <> '' then
                            bbc := ''
                        else
                            Error('Please check if Voucher has been captured/authorized successfully or not %1', RecSHHH."Voucher Int. No.8");
                    end;
                end;

                //9
                if (RecSHHH."Voucher Amount9" <> 0) then begin
                    RecEINV.Reset;
                    RecEINV.SetRange("Vouchr. Code", UpperCase(RecSHHH."Voucher Int. No.9"));
                    RecEINV.SetRange("Vouchr. Integration", true);
                    RecEINV.SetFilter("Vouchr. Capture id", '<>%1', '');
                    if not RecEINV.FindFirst then
                        Error('Please check if Voucher has been captured successfully %1', RecSHHH."Voucher Int. No.9");
                end;//WIN234 29042021 voucher integration
                if (RecSHHH."Voucher Amount9" <> 0) then begin
                    RecEINV.Reset;
                    RecEINV.SetRange("Vouchr. Code", UpperCase(RecSHHH."Voucher Int. No.9"));
                    RecEINV.SetRange("Vouchr. Integration", true);
                    if not RecEINV.FindFirst then
                        Error('Please check if Voucher has been captured/authorized successfully or not %1', RecSHHH."Voucher Int. No.9");
                    RecEINV.Reset;
                    RecEINV.SetRange("Vouchr. Code", UpperCase(RecSHHH."Voucher Int. No.9"));
                    RecEINV.SetRange("Vouchr. Integration", true);

                    if RecEINV.FindLast then begin
                        if RecEINV."Vouchr. Capture id" <> '' then
                            bbc := ''
                        else
                            Error('Please check if Voucher has been captured/authorized successfully or not %1', RecSHHH."Voucher Int. No.9");
                    end;
                end;

                //10
                if (RecSHHH."Voucher Amount10" <> 0) then begin
                    RecEINV.Reset;
                    RecEINV.SetRange("Vouchr. Code", UpperCase(RecSHHH."Voucher Int. No.10"));
                    RecEINV.SetRange("Vouchr. Integration", true);
                    RecEINV.SetFilter("Vouchr. Capture id", '<>%1', '');
                    if not RecEINV.FindFirst then
                        Error('Please check if Voucher has been captured successfully %1', RecSHHH."Voucher Int. No.10");
                end;//WIN234 29042021 voucher integration
                if (RecSHHH."Voucher Amount10" <> 0) then begin
                    RecEINV.Reset;
                    RecEINV.SetRange("Vouchr. Code", UpperCase(RecSHHH."Voucher Int. No.10"));
                    RecEINV.SetRange("Vouchr. Integration", true);
                    if not RecEINV.FindFirst then
                        Error('Please check if Voucher has been captured/authorized successfully or not %1', RecSHHH."Voucher Int. No.10");
                    RecEINV.Reset;
                    RecEINV.SetRange("Vouchr. Code", UpperCase(RecSHHH."Voucher Int. No.10"));
                    RecEINV.SetRange("Vouchr. Integration", true);

                    if RecEINV.FindLast then begin
                        if RecEINV."Vouchr. Capture id" <> '' then
                            bbc := ''
                        else
                            Error('Please check if Voucher has been captured/authorized successfully or not %1', RecSHHH."Voucher Int. No.10");
                    end;
                end;

            end;

        //----------Voucher
        if SalesHeader."Document Type" = SalesHeader."document type"::Order then
            if SalesHeader."Mobile Type" = SalesHeader."mobile type"::" " then
                Error('User Type can not be blank');//WIN234 17-03-2020
        RecSalL.Reset;
        RecSalL.SetRange("Document No.", SalesHeader."No.");
        RecSalL.SetFilter("Shield Type", '%1|%2|%3', RecSalL."shield type"::"Shield Ex", RecSalL."shield type"::Shield, RecSalL."shield type"::"Shield Extended");
        if RecSalL.FindFirst then
            Error('Kindly check the Shield Type,blocked shield type not allowed for posting');//Win-234 04-05-2019

        if SalesHeader."Document Type" = SalesHeader."document type"::Order then begin
            if Reccustt.Get(SalesHeader."Sell-to Customer No.") then
                if (Reccustt."GST Customer Type" = Reccustt."gst customer type"::" ") then
                    Error('Please check State Code/GST Customer Type in Customer master it can not be blank');

            if (Reccustt."GST Customer Type" = Reccustt."gst customer type"::Registered) or (Reccustt."GST Customer Type" = Reccustt."gst customer type"::Unregistered) then begin
                RecGSTPos.Reset;
                if SalesHeader."GST Ship-to State Code" = '' then
                    RecGSTPos.SetRange("State Code", Reccustt."State Code")
                else
                    if SalesHeader."GST Ship-to State Code" <> '' then
                        RecGSTPos.SetRange("State Code", SalesHeader."GST Ship-to State Code");
                if not RecGSTPos.FindFirst then
                    Error('Please check GST related setup');
            end;
        end;//WIN234 22092020
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterValidatePostingAndDocumentDate', '', false, false)]
    local procedure OnAfterValidatePostingAndDocumentDate(var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; ReplacePostingDate: Boolean; ReplaceDocumentDate: Boolean);
    begin
        //KPPLDG00040
        if not PreviewMode then begin
            if StrPos(SalesHeader."External Document No.", '_') > 0 then
                LocExternalDoc := CopyStr(SalesHeader."External Document No.", 1, StrPos(SalesHeader."External Document No.", '_') - 1)
            else
                LocExternalDoc := SalesHeader."External Document No.";
            LocWooCom.Reset;
            LocWooCom.SetRange(LocWooCom.number, LocExternalDoc);
            if LocWooCom.FindFirst then begin
                LocWooCom.status := 'completed';
                LocWooCom.Modify;
            end;
        end;
        //KPPLDG00040
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnRunOnBeforeCheckTotalInvoiceAmount', '', false, false)]
    local procedure OnRunOnBeforeCheckTotalInvoiceAmount(var SalesHeader: Record "Sales Header");
    begin
        ShieldInvoice := false; //WIN127//win352
        ShieldLineNo := 0; //Win127
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnDeleteAfterPostingOnBeforeDeleteSalesHeader', '', false, false)]
    local procedure OnDeleteAfterPostingOnBeforeDeleteSalesHeader(var SalesHeader: Record "Sales Header");
    begin
        //KPPLDG00023
        SalesOrderExtension.Reset;
        if SalesOrderExtension.Get(SalesHeader."Document Type", SalesHeader."No.") then
            SalesOrderExtension.Delete;
    end;
    //win
    //RY
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesInvLineInsert', '', false, false)]
    // local procedure OnAfterSalesInvLineInsert(var SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: Record "Sales Invoice Header"; SalesLine: Record "Sales Line"; ItemLedgShptEntryNo: Integer; WhseShip: Boolean; WhseReceive: Boolean; CommitIsSuppressed: Boolean; var SalesHeader: Record "Sales Header"; var TempItemChargeAssgntSales: Record "Item Charge Assignment (Sales)" temporary; var TempWhseShptHeader: Record "Warehouse Shipment Header" temporary; var TempWhseRcptHeader: Record "Warehouse Receipt Header" temporary; PreviewMode: Boolean);
    // var
    //     TempSalesLine: Record 37;
    //     SalesSetup: Record "Sales & Receivables Setup";
    // begin
    //     //win352++
    //     // win127 10.06.14 Insert Shield Invoice line\\
    //     if (SalesHeader."Document Type" = SalesHeader."document type"::Order) and TempSalesLine.Shield then begin
    //         ShieldLineNo := ShieldLineNo + 10000;
    //         ShieldLine.Init;
    //         ShieldLine.TransferFields(SalesLine);
    //         ShieldLine."Document Type" := ShieldHeader."Document Type";
    //         ShieldLine."Document No." := ShieldHeader."No.";
    //         ShieldLine."Posting Date" := SalesHeader."Posting Date";
    //         ShieldLine."Salesperson Code" := TempSalesLine."Salesperson Code";//win-234 //24-10-2019
    //                                                                           //ShieldLine."Document No." := ShieldHeader."No.";
    //         ShieldLine."Line No." := ShieldLineNo;
    //         ShieldLine.Type := ShieldLine.Type::"G/L Account";
    //         SalesSetup.Get;
    //         SalesSetup.TestField(SalesSetup."Shield Sales Account");
    //         ShieldLine.Validate("No.", SalesSetup."Shield Sales Account");
    //         ShieldLine.Validate(Quantity, 1);
    //         //ShieldLine.VALIDATE(ShieldLine."Unit Price Incl. of Tax",TempSalesLine."Shield Value");
    //         if SalesHeader."Posting Date" <= 20170630D then begin           //Win120
    //                                                                         // ServiceTaxSetup.Reset;
    //                                                                         // ServiceTaxSetup.SetCurrentkey(Code,"From Date");  //WIN270
    //                                                                         // ServiceTaxSetup.SetFilter(Code,'%1',ShieldLine."Service Tax Group");
    //                                                                         // ServiceTaxSetup.SetFilter(ServiceTaxSetup."From Date",'<=%1',"Posting Date");  //WIN270
    //                                                                         // if ServiceTaxSetup.FindLast then begin
    //                                                                         //   ServiceTaxPer :=  ServiceTaxSetup."Service Tax %"  + (ServiceTaxSetup."Service Tax %" * ServiceTaxSetup."eCess %")/100 + (ServiceTaxSetup."Service Tax %" * ServiceTaxSetup."SHE Cess %")/100;
    //                                                                         //   ShieldAmt := (TempSalesLine."Shield Value" * 100)/(100+ServiceTaxPer);
    //                                                                         //   ShieldLine.Validate("Unit Price",ShieldAmt);
    //                                                                         // end;
    //                                                                         // end else
    //                                                                         // if SalesHeader."Posting Date" >= 20170107D then begin           //Win120
    //                                                                         // RecGLAccount.Reset;
    //                                                                         // RecGLAccount.Get(SalesSetup."Shield Sales Account");
    //                                                                         // RecGSTSetup.Reset;
    //                                                                         // RecGSTSetup.SetRange(R"GST Group Code",RecGLAccount."GST Group Code");
    //                                                                         // RecGSTSetup.SetFilter("GST Component",'%1','IGST');
    //                                                                         // RecGSTSetup.SetRange("GST State Code",SalesHeader."GST Bill-to State Code");
    //                                                                         // if RecGSTSetup.FindFirst then begin
    //                                                                         //  RecGSTSetup.TestField(SalesHeader."GST Component %");

    //             if RecSIIH.Get(ShieldHeader."Ref. Invoice No.") then
    //                 if (RecSIIH."GST Without Payment of Duty") and (RecSIIH."Location State Code" = 'MH') then
    //                     ShieldAmt := (TempSalesLine."Shield Value") //win-234 05-03-2019
    //                 else
    //                     ShieldAmt := (TempSalesLine."Shield Value" * 100);///(100+RecGSTSetup."GST Component %");
    //             // MESSAGE(FORMAT(ShieldAmt));
    //             ShieldLine.Validate("Unit Price", ShieldAmt);
    //         end
    //         else
    //             Error('GST setup not available');
    //     end
    //     else
    //         ShieldLine.Validate("Unit Price", TempSalesLine."Shield Value");
    //     ShieldLine.Shield := true;
    //     ShieldLine."Shield Value" := TempSalesLine."Shield Value";
    //     // ShieldLine."PIT Structure" :='';
    //     ShieldLine."Price Inclusive of Tax" := false;
    //     ShieldLine."Description 2" := SalesLine."No.";
    //     ShieldLine."Salesperson Code" := TempSalesLine."Salesperson Code";//win-234 24-10-19
    //     ShieldLine.Insert;
    //     //Cost Of Goods Sold   ++
    //     ShieldLineNo := ShieldLineNo + 10000;
    //     ShieldLine.Init;
    //     ShieldLine.TransferFields(SalesLine);
    //     ShieldLine."Document Type" := ShieldHeader."Document Type";
    //     ShieldLine."Posting Date" := SalesHeader."Posting Date";
    //     ShieldLine."Document No." := ShieldHeader."No.";
    //     ShieldLine."Line No." := ShieldLineNo;
    //     ShieldLine.Type := ShieldLine.Type::"G/L Account";
    //     SalesSetup.Get;
    //     SalesSetup.TestField(SalesSetup."Cost of Goods Sold- Shield");
    //     ShieldLine.Validate("No.", SalesSetup."Cost of Goods Sold- Shield");
    //     ShieldLine.Validate(Quantity, 1);
    //     ShieldLine.Validate("Unit Price", TempSalesLine."Shield Cost" * -1);
    //     //ShieldLine.VALIDATE("Unit Price",TempSalesLine."Shield Cost");
    //     ShieldLine.Shield := true;
    //     ShieldLine."Shield Type" := TempSalesLine."Shield Type"; //Added 02.02.15
    //                                                              // ShieldLine."PIT Structure" :='';
    //     ShieldLine."Price Inclusive of Tax" := false;
    //     ShieldLine."Shield Value" := 0;
    //     ShieldLine."Description 2" := SalesLine."No.";
    //     ShieldLine.Insert;
    //     //  Purchase Shield ---
    //     ShieldLineNo := ShieldLineNo + 10000;
    //     ShieldLine.Init;
    //     ShieldLine.TransferFields(SalesLine);
    //     ShieldLine."Document Type" := ShieldHeader."Document Type";
    //     ShieldLine."Posting Date" := SalesHeader."Posting Date";
    //     ShieldLine."Document No." := ShieldHeader."No.";
    //     ShieldLine."Line No." := ShieldLineNo;
    //     ShieldLine.Type := ShieldLine.Type::"G/L Account";
    //     SalesSetup.Get;
    //     SalesSetup.TestField(SalesSetup."Purchase Shield");
    //     ShieldLine.Validate("No.", SalesSetup."Purchase Shield");
    //     //ShieldLine.VALIDATE("Unit Price",(TempSalesLine."Shield Cost") * -1);
    //     ShieldLine.Validate("Unit Price", (TempSalesLine."Shield Cost") * 1);
    //     ShieldLine.Shield := true;
    //     // ShieldLine."PIT Structure" :='';
    //     ShieldLine."Price Inclusive of Tax" := false;
    //     ShieldLine."Shield Value" := 0;
    //     ShieldLine.Validate(Quantity, 1);
    //     ShieldLine."Description 2" := SalesLine."No.";
    //     ShieldLine.Insert;
    //     // end;
    //     //  Insert Shield Invoice line

    //     //   Win127 //win352++
    //     //Insert Third party Sales Line
    //     IF (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) AND (SalesHeader."Party No" <> '') AND (SalesHeader."Vendor Name" <> '') AND (SalesHeader."Party Item Price" <> 0) THEN BEGIN
    //         PartyLine.INIT;
    //         PartyLine."Document Type" := PartyHeader."Document Type";
    //         PartyLine."Document No." := PartyHeader."No.";
    //         PartyLine.Type := PartyLine.Type::Item;
    //         PartyLine."Line No." := 10000;
    //         PartyLine.VALIDATE("No.", SalesHeader."Vendor Name");
    //         PartyLine.VALIDATE(Quantity, 1);
    //         PartyLine."Unit Price" := SalesHeader."Party Item Price";
    //         PartyLine."Location Code" := SalesHeader."Location Code";
    //         PartyLine.INSERT;
    //     END;
    // end;
    // // */
    // // //TK//tk
    procedure Check_GST_Amount_Before_Posting(RECSH11: Record 36)
    var
        RECSH10: Record 36;
        RECSL10: Record 37;
        RECCUST10: Record 18;
        RECITEM10: Record 27;
        RECLOC10: Record 14;
        RECCOMPINFO10: Record 79;
    begin
        RECSH10 := RECSH11;
        //IF RECSH10."Sales Order Type"=RECSH10."Sales Order Type"::Retail THEN

        BEGIN
            //STRUCTURE++
            IF RECSH10."Ref. Invoice No." <> '' THEN  //WIN234 25062021
                                                      // RECSH10.TESTFIELD(Structure, 'GST PIT');
                                                      //STRUCTURE--

                //COMP INFO GST NO CHECK++
                RECCOMPINFO10.GET;
            RECCOMPINFO10.TESTFIELD("GST Registration No.");
            //COMP INFO GST NO CHECK--

            //LOCATION GST NO CHECK++
            IF RECLOC10.GET(RECSH10."Location Code") THEN
                RECLOC10.TESTFIELD("GST Registration No.");
            //LOCATION GST NO CHECK++

            //CUSTOMER MASTER CHECK++
            RECCUST10.GET(RECSH10."Sell-to Customer No.");
            RECCUST10.TESTFIELD("GST Customer Type");
            RECCUST10.TESTFIELD("State Code");
            //CUSTOMER MASTER CHECK--
            //++
            RECSL10.RESET;
            RECSL10.SETRANGE("Document Type", RECSH10."Document Type");
            RECSL10.SETRANGE(RECSL10."Document No.", RECSH10."No.");
            // RECSL10.SETFILTER("Total GST Amount", '%1', 0);
            RECSL10.SETFILTER("MRP Discount %", '<>%1', 100);
            //  RECSL10.SETRANGE(Type,RECSL10.Type::Item);
            RECSL10.SETFILTER("No.", '<>%1', '');
            IF RECSL10.FINDSET THEN BEGIN
                REPEAT
                    IF (RECSL10.Type <> RECSL10.Type::"G/L Account") AND (RECSL10."No." <> '310014') THEN BEGIN
                        RECITEM10.GET(RECSL10."No.");
                        RECITEM10.TESTFIELD("GST Group Code");
                        RECITEM10.TESTFIELD("GST Credit");
                        RECITEM10.TESTFIELD("HSN/SAC Code");
                        ERROR('GST is zero');
                    END;
                UNTIL RECSL10.NEXT = 0;
            END;
            //--
        END;
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterInsertInvoiceHeader', '', false, false)]
    // local procedure OnAfterInsertInvoiceHeader(var SalesHeader: Record "Sales Header"; var SalesInvHeader: Record "Sales Invoice Header");
    // var
    //     Location: record Location;
    //     SalesSetup: record "Sales & Receivables Setup";
    // begin
    //     //win352++
    //     //Win127  Generate Shield Invoice ++
    //     IF (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) THEN
    //         SalesHeader.PostSchemeJVBatch(SalesHeader, SalesInvHeader."No.");
    //     SalesHeader.CALCFIELDS(SalesHeader.Shield);
    //     //ERROR('SHIELD %1',Shield);
    //     IF (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) AND SalesHeader.Shield THEN BEGIN
    //         IF SalesHeader."Shield Posting No." = '' THEN BEGIN
    //             Location.GET(SalesHeader."Location Code");
    //             IF Location."Shield Invoice Nos." <> '' THEN
    //                 SalesHeader."Shield Posting No." := NoSeriesMgt.GetNextNo(Location."Shield Invoice Nos.", SalesHeader."Posting Date", TRUE)
    //             ELSE
    //                 ERROR(Text061, 'Shield Posting No.');
    //             IF Location."Posted Shield Invoice Nos." = '' THEN
    //                 ERROR(Text061, 'Posted Shield Posting No.');

    //         END;

    //         //WIN316++
    //         IF SalesHeader."Posting Date" >= 20170107D THEN BEGIN
    //             ShieldHeader.INIT;
    //             ShieldHeader.TRANSFERFIELDS(SalesHeader);
    //             ShieldHeader."Document Type" := ShieldHeader."Document Type"::Invoice;
    //             ShieldHeader."No." := SalesHeader."Shield Posting No.";
    //             ShieldHeader."Ref. Invoice No." := SalesInvHeader."No.";  //Used to store ref no.
    //             ShieldHeader.Status := ShieldHeader.Status::Open;
    //             ShieldHeader."Posting Description" := 'Invoice ' + ShieldHeader."No.";
    //             ShieldHeader.Ship := FALSE;
    //             ShieldHeader.Invoice := FALSE;
    //             ShieldHeader."Shipping No." := '';
    //             ShieldHeader."Posting No." := '';
    //             //ShieldHeader."Combine Shipments" := TRUE;
    //             Location.GET(SalesHeader."Location Code");
    //             ShieldHeader."No. Series" := Location."Shield Invoice Nos.";
    //             SalesSetup.GET;
    //             ShieldHeader."Posting No. Series" := Location."Posted Shield Invoice Nos.";
    //             ShieldHeader."Tax Area Code" := '';
    //             ShieldHeader."Prepayment No. Series" := '';
    //             ShieldHeader."Prepmt. Cr. Memo No. Series" := '';
    //             //    StruHeader.GET('GST');//
    //             //    ShieldHeader.VALIDATE(Structure,'GST');
    //             ShieldHeader.INSERT;
    //             ShieldInvoice := TRUE;
    //         END
    //         ELSE BEGIN
    //             //WI316--
    //             ShieldHeader.INIT;
    //             ShieldHeader.TRANSFERFIELDS(SalesHeader);
    //             ShieldHeader."Document Type" := ShieldHeader."Document Type"::Invoice;
    //             ShieldHeader."No." := SalesHeader."Shield Posting No.";
    //             ShieldHeader."Ref. Invoice No." := SalesInvHeader."No.";  //Used to store ref no.
    //             ShieldHeader.Status := ShieldHeader.Status::Open;
    //             ShieldHeader."Posting Description" := 'Invoice ' + ShieldHeader."No.";
    //             ShieldHeader.Ship := FALSE;
    //             ShieldHeader.Invoice := FALSE;
    //             ShieldHeader."Shipping No." := '';
    //             ShieldHeader."Posting No." := '';
    //             //ShieldHeader."Combine Shipments" := TRUE;
    //             Location.GET(SalesHeader."Location Code");
    //             ShieldHeader."No. Series" := Location."Shield Invoice Nos.";
    //             SalesSetup.GET;
    //             ShieldHeader."Posting No. Series" := Location."Posted Shield Invoice Nos.";
    //             ShieldHeader."Tax Area Code" := '';
    //             ShieldHeader."Prepayment No. Series" := '';
    //             ShieldHeader."Prepmt. Cr. Memo No. Series" := '';
    //             //  StruHeader.GET('SERV.TAX');//SERV.TAX
    //             //  ShieldHeader.VALIDATE(Structure,'SERV.TAX');
    //             ShieldHeader.INSERT;
    //             ShieldInvoice := TRUE;
    //         END;
    //     END;
    //     //  Generate Shield Invoice --

    // end;

    //TK
    // //win352--[EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeInsertInvoiceHeader', '', false, false)]
    // local procedure OnBeforeInsertInvoiceHeader(SalesHeader: Record "Sales Header"; var SalesInvHeader: Record "Sales Invoice Header"; var IsHandled: Boolean);
    // var
    //     SalesCommentLine: Record "Sales Comment Line";
    //     RecordLinkManagement: Codeunit "Record Link Management";
    //     SegManagement: Codeunit SegManagement;

    // begin
    //     // IsHandled := true;
    //     //  with SalesHeader do begin
    //     //   SalesInvHeader.Init;
    //     //   SalesInvHeader.TransferFields(SalesHeader);

    //     //   if "Document Type" = "document type"::Order then begin
    //     //     if PreviewMode then
    //     //       SalesInvHeader."No." := FakeDocNoTxt
    //     //     else
    //     //       SalesInvHeader."No." := "Posting No.";
    //     //     if SalesSetup."Ext. Doc. No. Mandatory" then
    //     //       TestField("External Document No.");
    //     //     SalesInvHeader."Pre-Assigned No. Series" := '';
    //     //     SalesInvHeader."Order No. Series" := "No. Series";
    //     //     SalesInvHeader."Order No." := "No.";
    //     //     if GuiAllowed then
    //     //     Window.Update(1,StrSubstNo(Text007,"Document Type","No.",SalesInvHeader."No."));
    //     //   end else begin
    //     //     SalesInvHeader."Pre-Assigned No. Series" := "No. Series";
    //     //     SalesInvHeader."Pre-Assigned No." := "No.";
    //     //     if "Posting No." <> '' then begin
    //     //       SalesInvHeader."No." := "Posting No.";
    //     //       if GuiAllowed then
    //     //       Window.Update(1,StrSubstNo(Text007,"Document Type","No.",SalesInvHeader."No."));
    //     //     end;
    //     //   end;
    //     //   SalesInvHeader."Source Code" := SrcCode;
    //     //   SalesInvHeader."User ID" := UserId;
    //     //   SalesInvHeader."No. Printed" := 0;
    //     //   SalesInvHeader."Transfer Shipment No." := "Transfer Shipment  No.";
    //     //       if "Document Type" = "document type"::Invoice then
    //     //         SalesInvHeader."Ref. Invoice No." := "Ref. Invoice No."; //Win127//win352
    //     //       SalesInvHeader."Sales Invoice Time" := CurrentDatetime ;
    //     //   SalesInvHeader.Insert;
    //     //   //win352++
    //     //       //Win127  Generate Shield Invoice ++
    //     //       if ("Document Type" = "document type"::Order) then
    //     //           PostSchemeJVBatch(SalesHeader,SalesInvHeader."No.");
    //     //       CalcFields(Shield);
    //     //       //ERROR('SHIELD %1',Shield);
    //     //       if ("Document Type" = "document type"::Order) and  Shield then begin
    //     //         if SalesHeader."Shield Posting No." = '' then begin
    //     //           Location.Get("Location Code");
    //     //           if Location."Shield Invoice Nos."<>'' then
    //     //             SalesHeader."Shield Posting No." :=  NoSeriesMgt.GetNextNo(Location."Shield Invoice Nos.","Posting Date",true)
    //     //           else
    //     //             Error(Text061,'Shield Posting No.');
    //     //           if Location."Posted Shield Invoice Nos."='' then
    //     //             Error(Text061,'Posted Shield Posting No.');

    //     //        end;

    //     // //WIN316++
    //     //             if SalesHeader."Posting Date" >= 20170107D then begin
    //     //                ShieldHeader.Init;
    //     //                ShieldHeader.TransferFields(SalesHeader);
    //     //                ShieldHeader."Document Type" :=ShieldHeader."document type"::Invoice;
    //     //                ShieldHeader."No." := SalesHeader."Shield Posting No.";
    //     //                ShieldHeader."Ref. Invoice No." := SalesInvHeader."No.";  //Used to store ref no.
    //     //                ShieldHeader.Status := ShieldHeader.Status::Open;
    //     //                ShieldHeader."Posting Description" :='Invoice '+ShieldHeader."No.";
    //     //                ShieldHeader.Ship := false;
    //     //                ShieldHeader.Invoice := false;
    //     //                ShieldHeader."Shipping No." := '';
    //     //                ShieldHeader."Posting No." :='';
    //     //                //ShieldHeader."Combine Shipments" := TRUE;
    //     //                Location.Get("Location Code");
    //     //                ShieldHeader."No. Series" := Location."Shield Invoice Nos.";
    //     //                SalesSetup.Get;
    //     //                ShieldHeader."Posting No. Series" := Location."Posted Shield Invoice Nos.";
    //     //                ShieldHeader."Tax Area Code" := '';
    //     //                ShieldHeader."Prepayment No. Series" :='';
    //     //                ShieldHeader."Prepmt. Cr. Memo No. Series" :='';
    //     //                StruHeader.Get('GST');//
    //     //                ShieldHeader.Validate(Structure,'GST');
    //     //                ShieldHeader.Insert;
    //     //                ShieldInvoice := true;
    //     //             end
    //     //             else begin
    //     // //WI316--
    //     //              ShieldHeader.Init;
    //     //              ShieldHeader.TransferFields(SalesHeader);
    //     //              ShieldHeader."Document Type" :=ShieldHeader."document type"::Invoice;
    //     //              ShieldHeader."No." := SalesHeader."Shield Posting No.";
    //     //              ShieldHeader."Ref. Invoice No." := SalesInvHeader."No.";  //Used to store ref no.
    //     //              ShieldHeader.Status := ShieldHeader.Status::Open;
    //     //              ShieldHeader."Posting Description" :='Invoice '+ShieldHeader."No.";
    //     //              ShieldHeader.Ship := false;
    //     //              ShieldHeader.Invoice := false;
    //     //              ShieldHeader."Shipping No." := '';
    //     //              ShieldHeader."Posting No." :='';
    //     //              //ShieldHeader."Combine Shipments" := TRUE;
    //     //              Location.Get("Location Code");
    //     //              ShieldHeader."No. Series" := Location."Shield Invoice Nos.";
    //     //              SalesSetup.Get;
    //     //              ShieldHeader."Posting No. Series" := Location."Posted Shield Invoice Nos.";
    //     //              ShieldHeader."Tax Area Code" := '';
    //     //              ShieldHeader."Prepayment No. Series" :='';
    //     //              ShieldHeader."Prepmt. Cr. Memo No. Series" :='';
    //     //              StruHeader.Get('SERV.TAX');//SERV.TAX
    //     //              ShieldHeader.Validate(Structure,'SERV.TAX');
    //     //              ShieldHeader.Insert;
    //     //              ShieldInvoice := true;
    //     //            end;
    //     //        end;
    //     //       //  Generate Shield Invoice --

    //     //       //Win127 04.06.14 commented on 31.07.14
    //     //       /*
    //     //       IF ("Document Type" = "Document Type"::Order) AND ("Sales Order Type"="Sales Order Type"::Rental) THEN BEGIN
    //     //            //     SalesToTransferOrder(Rec,SalesInvHeader."No.");
    //     //         TransferShipHeader.RESET;
    //     //         TransferShipHeader.SETFILTER("Transfer Order No.",'%1',"Transfer Shipment  No.");
    //     //         IF TransferShipHeader.FINDFIRST THEN BEGIN
    //     //           TransferShipHeader."Rental Sales Invoice No." := SalesInvHeader."No.";
    //     //           TransferShipHeader.MODIFY;
    //     //         END;
    //     //       END;
    //     //       */
    //     //       //
    //     //       //Win127 29.06.14 Generate Purchase Invoice

    //     //       GLSetup.Get;
    //     //       if GLSetup."Purchase Invoice IIIrd Party" then begin
    //     //         CalcFields(PurchaseLineExist);
    //     //        // CALCFIELDS("Maple Buyback Amt");
    //     //         if  ("Document Type" = "document type"::Order) and (PurchaseLineExist > 0) and ("Maple Buyback Amt" <> 0) then
    //     //               MakePurchaseInvoice(SalesHeader,SalesInvHeader."No.");
    //     //       end;
    //     //       /*
    //     //       IF  ("Document Type" = "Document Type"::Order) AND ("Party No" <> '') AND  ("Vendor Name" <> '') AND ("Party Item Price" <> 0) THEN
    //     //       BEGIN
    //     //         //MakeThirdPartySalesInvoice(Rec,SalesInvHeader."No.");
    //     //         SalesSetup.GET;
    //     //         "Posting No." := NoSeriesMgt.GetNextNo(SalesSetup."Invoice Nos.","Posting Date",TRUE);
    //     //         PartyHeader.INIT;
    //     //         PartyHeader."Document Type" :=  PartyHeader."Document Type"::Invoice;
    //     //         PartyHeader."No." := "Posting No.";
    //     //         PartyHeader.VALIDATE("Sell-to Customer No.","Party No");
    //     //         //PartyHeader.VALIDATE("Location Code","Location Code");
    //     //         PartyHeader."Ref. Invoice No." := SalesInvHeader."No.";
    //     //         PartyHeader."No. Printed" := 0;
    //     //         PartyHeader.INSERT;
    //     //       END;
    //     //       //
    //     //       */
    //     //       //win352--

    //     //   UpdateWonOpportunities(SalesHeader);
    //     //   SegManagement.CreateCampaignEntryOnSalesInvoicePosting(SalesInvHeader);

    //     //   ApprovalsMgmt.PostApprovalEntries(RecordId,SalesInvHeader.RecordId,SalesInvHeader."No.");

    //     //   if SalesSetup."Copy Comments Order to Invoice" then begin
    //     //     CopyCommentLines(
    //     //       "Document Type",SalesCommentLine."document type"::"Posted Invoice",
    //     //       "No.",SalesInvHeader."No.");
    //     //     RecordLinkManagement.CopyLinks(SalesHeader,SalesInvHeader);
    //     //   end;
    //     //   InsertSOExtendedPostedData('INVOICE',"Document Type",SalesInvHeader."No.","No.");//KPPLDG00023
    //     // end;
    //     //end;




    // end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostItemJnlLineBeforePost', '', false, false)]
    local procedure OnAfterPostItemJnlLineBeforePost(var ItemJournalLine: Record "Item Journal Line"; SalesLine: Record "Sales Line"; QtyToBeShippedBase: Decimal; var ItemJnlPostLine: Codeunit "Item Jnl.-Post Line"; var CheckApplFromItemEntry: Boolean; var TrackingSpecification: Record "Tracking Specification");
    begin
        ItemJournalLine."Primary category" := SalesLine."Primary category";
        ItemJournalLine."Secondary category" := SalesLine."Secondary category";
        ItemJournalLine."Third category" := SalesLine."Third category";
        ItemJournalLine."UPN Code" := SalesLine."UPN Code";
        ItemJournalLine."IMEI No." := TrackingSpecification."IMEI No."; //Win127//win352

    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnPostItemChargePerOrderOnBeforeLastRunWithCheck', '', false, false)]
    local procedure OnPostItemChargePerOrderOnBeforeLastRunWithCheck(NonDistrItemJnlLine: Record "Item Journal Line"; SalesLine: Record "Sales Line"; var IsHandled: Boolean);
    begin
        // NonDistrItemJnlLine."IMEI No."  := "IMEI No."; //Win127//win352
    end;
    //win
    // //RY


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterFinalizePostingOnBeforeCommit', '', false, false)]
    local procedure OnAfterFinalizePostingOnBeforeCommit(var SalesHeader: Record "Sales Header"; var SalesShipmentHeader: Record "Sales Shipment Header"; var SalesInvoiceHeader: Record "Sales Invoice Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var ReturnReceiptHeader: Record "Return Receipt Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; WhseShip: Boolean; WhseReceive: Boolean; var EverythingInvoiced: Boolean);
    var
        Currency: record Currency;
        PaymentType: Option " ",Cash,Cheque,"Credit Card","Debit Card","Gift Voucher",RTGS,Finance,Advance,"Maple BuyBack","Apple BuyBack","Apple Refund";
        PaymentMethod: Record "Payment Method";
        GenJnlLine1: Record "Gen. Journal Line";
    begin
        /*
        Message('%1', SalesInvoiceHeader."No.");
        Message('%1', SalesHeader."No.");
        GenJnlLine1.INIT;
        GenJnlLine1."Journal Template Name" := 'PAYMENTS';
        GenJnlLine1."Journal Batch Name" := 'DEFAULT';
        GenJnlLine1."Line No." := 10000;
        GenJnlLine1."Posting Date" := SalesHeader."Posting Date";
        GenJnlLine1."Document Date" := SalesHeader."Document Date";
        GenJnlLine1.Description := SalesHeader."Posting Description";
        GenJnlLine1."Shortcut Dimension 1 Code" := SalesHeader."Shortcut Dimension 1 Code";
        GenJnlLine1."Shortcut Dimension 2 Code" := SalesHeader."Shortcut Dimension 2 Code";
        GenJnlLine1."Dimension Set ID" := SalesHeader."Dimension Set ID";
        GenJnlLine1."Reason Code" := SalesHeader."Reason Code";
        GenJnlLine1."Account Type" := GenJnlLine1."Account Type"::Customer;
        GenJnlLine1."Account No." := SalesHeader."Bill-to Customer No.";
        GenJnlLine1."Document Type" := GenJnlLine1."Document Type"::Payment;
        GenJnlLine1."Bal. Account Type" := GenJnlLine1."Bal. Account Type"::"G/L Account";
        GenJnlLine1."Document No." := SalesHeader."No." + '-P';//GenJnlLineDocNo + '-P';
        GenJnlLine1."External Document No." := SalesHeader."External Document No."; //GenJnlLineExtDocNo;
        GenJnlLine1."Bal. Account No." := '225502';
        GenJnlLine1."Currency Code" := SalesHeader."Currency Code";
        GenJnlLine1.Validate(Amount, SalesHeader.PayByCashAmt * -1);
        //GenJnlLine1.Amount := ROUND(GenJnlLine1.Amount, Currency."Amount Rounding Precision") * -1;//Temp
        GenJnlLine1."Source Currency Code" := SalesHeader."Currency Code";
        //GenJnlLine."Source Currency Amount" := GenJnlLine.Amount;//Temp
        GenJnlLine1.Correction := SalesHeader.Correction;
        //CustLedgEntry.CALCFIELDS(Amount);
        //IF CustLedgEntry.Amount = 0 THEN
        //GenJnlLine1."Amount (LCY)" := SalesHeader.PayByCashAmt * -1; Temp
        // ELSE BEGIN
        //     GenJnlLine."Amount (LCY)" := (
        //        AmountToCustomer
        //        +
        //        ROUND(
        //          CustLedgEntry."Remaining Pmt. Disc. Possible" /
        //          CustLedgEntry."Adjusted Currency Factor"));
        //     //  MESSAGE(FORMAT(GenJnlLine."Amount (LCY)" ));
        // END;
        IF SalesHeader."Currency Code" = '' THEN
            GenJnlLine1."Currency Factor" := 1
        ELSE
            GenJnlLine1."Currency Factor" := SalesHeader."Currency Factor";
        // GenJnlLine1."Applies-to Doc. Type" := GenJnlLine1."Applies-to Doc. Type"::Invoice; //Temp
        // GenJnlLine1."Applies-to Doc. No." := SalesInvoiceHeader."No."; //Temp
        GenJnlLine1."Source Type" := GenJnlLine1."Source Type"::Customer;
        GenJnlLine1."Source No." := SalesHeader."Bill-to Customer No.";
        GenJnlLine1."Source Code" := 'PAYMENTJNL';
        //SrcCode;//Check
        GenJnlLine1."Posting No. Series" := SalesHeader."Posting No. Series";
        GenJnlLine1."IC Partner Code" := SalesHeader."Sell-to IC Partner Code";
        GenJnlLine1.Insert();
        // IF ArPayTypes[i, 7] = FORMAT(PaymentType::Cheque) THEN BEGIN
        //     // GenJnlLine."Cheque Date" := SalesHeader.PayByChqDt;
        //     // GenJnlLine."Cheque No." :=  SalesHeader.PayByChqNo;
        // END;//tk
        GenJnlPostLine.RunWithCheck(GenJnlLine1);
        */
    END;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostCustomerEntry', '', false, false)]
    local procedure OnAfterPostCustomerEntry(var GenJnlLine: Record "Gen. Journal Line"; var SalesHeader: Record "Sales Header"; var TotalSalesLine: Record "Sales Line"; var TotalSalesLineLCY: Record "Sales Line"; CommitIsSuppressed: Boolean; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line");

    // // //tk dialouge box error
    var
        Currency: record Currency;

        PaymentType: Option " ",Cash,Cheque,"Credit Card","Debit Card","Gift Voucher",RTGS,Finance,Advance,"Maple BuyBack","Apple BuyBack","Apple Refund";
        //PaymentAmount: Decimal;

        PaymentMethod: Record "Payment Method";
        GenJnlLine1: Record "Gen. Journal Line";
    begin
        IF (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) OR (SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice) THEN BEGIN
            GenJnlLine1.Reset();
            GenJnlLine1.Setrange("Journal Template Name", 'PAYMENTS');
            GenJnlLine1.Setrange("Journal Batch Name", 'DEFAULT');
            IF GenJnlLine1.FindSet() THEN
                GenJnlLine1.DeleteAll();
            //>>Cash
            IF SalesHeader.PayByCashAmt <> 0 THEN BEGIN
                PaymentMethod.Reset();
                PaymentMethod.SetRange(PaymentMethod."Pay Type", PaymentMethod."Pay Type"::Cash);
                IF PaymentMethod.FindFirst() THEN
                    CreatePaymentEntry(SalesHeader, SalesHeader.PayByCashAmt, PaymentMethod."Bal. Account No.")
                ELSE
                    Error('Payment method CASH does not exist');
            END;
            //<<Cash

            //>>Credit Card
            IF SalesHeader.PayByCreditAmt1 <> 0 THEN BEGIN
                PaymentMethod.Reset();
                PaymentMethod.SetRange(PaymentMethod."Pay Type", PaymentMethod."Pay Type"::"Credit Card");
                PaymentMethod.SetRange(PaymentMethod.Code, SalesHeader.PayByCreditNo1);
                IF PaymentMethod.FindFirst() THEN
                    CreatePaymentEntry(SalesHeader, SalesHeader.PayByCreditAmt1, PaymentMethod."Bal. Account No.")
                ELSE
                    Error('Payment code Credit Card 1 does not exist');
            END;
            IF SalesHeader.PayByCreditAmt2 <> 0 THEN BEGIN
                PaymentMethod.Reset();
                PaymentMethod.SetRange(PaymentMethod."Pay Type", PaymentMethod."Pay Type"::"Credit Card");
                PaymentMethod.SetRange(PaymentMethod.Code, SalesHeader.PayByCreditNo2);
                IF PaymentMethod.FindFirst() THEN
                    CreatePaymentEntry(SalesHeader, SalesHeader.PayByCreditAmt2, PaymentMethod."Bal. Account No.")
                ELSE
                    Error('Payment code Credit Card 2 does not exist');
            END;
            IF SalesHeader.PayByCreditAmt3 <> 0 THEN BEGIN
                PaymentMethod.Reset();
                PaymentMethod.SetRange(PaymentMethod."Pay Type", PaymentMethod."Pay Type"::"Credit Card");
                PaymentMethod.SetRange(PaymentMethod.Code, SalesHeader.PayByCreditNo3);
                IF PaymentMethod.FindFirst() THEN
                    CreatePaymentEntry(SalesHeader, SalesHeader.PayByCreditAmt3, PaymentMethod."Bal. Account No.")
                ELSE
                    Error('Payment code Credit Card 3 does not exist');
            END;
            IF SalesHeader.PayByCreditAmt4 <> 0 THEN BEGIN
                PaymentMethod.Reset();
                PaymentMethod.SetRange(PaymentMethod."Pay Type", PaymentMethod."Pay Type"::"Credit Card");
                PaymentMethod.SetRange(PaymentMethod.Code, SalesHeader.PayByCreditNo4);
                IF PaymentMethod.FindFirst() THEN
                    CreatePaymentEntry(SalesHeader, SalesHeader.PayByCreditAmt4, PaymentMethod."Bal. Account No.")
                ELSE
                    Error('Payment code Credit Card 4 does not exist');
            END;
            //<<Credit Card

            //>>Debit Card
            IF SalesHeader.PayByDebitCdAmt1 <> 0 THEN BEGIN
                PaymentMethod.Reset();
                PaymentMethod.SetRange(PaymentMethod."Pay Type", PaymentMethod."Pay Type"::"Debit Card");
                PaymentMethod.SetRange(PaymentMethod.Code, SalesHeader.PayByDebitCdNo1);
                IF PaymentMethod.FindFirst() THEN BEGIN
                    //Message('pA');
                    CreatePaymentEntry(SalesHeader, SalesHeader.PayByDebitCdAmt1, PaymentMethod."Bal. Account No.");
                END
                ELSE
                    Error('Payment code Debit Card 1 does not exist');
            END;
            IF SalesHeader.PayByDebitAmt2 <> 0 THEN BEGIN
                PaymentMethod.Reset();
                PaymentMethod.SetRange(PaymentMethod."Pay Type", PaymentMethod."Pay Type"::"Debit Card");
                PaymentMethod.SetRange(PaymentMethod.Code, SalesHeader.PayByDebitNo2);
                IF PaymentMethod.FindFirst() THEN
                    CreatePaymentEntry(SalesHeader, SalesHeader.PayByDebitAmt2, PaymentMethod."Bal. Account No.")
                ELSE
                    Error('Payment code Debit Card 2 does not exist');
            END;
            //<<Debit Card

            //>>Buy Back
            IF SalesHeader."Maple Buyback Amt" <> 0 THEN BEGIN
                PaymentMethod.Reset();
                PaymentMethod.SetRange(PaymentMethod."Pay Type", PaymentMethod."Pay Type"::"Maple BuyBack");
                IF PaymentMethod.FindFirst() THEN
                    CreatePaymentEntry(SalesHeader, SalesHeader."Maple Buyback Amt", PaymentMethod."Bal. Account No.")
                ELSE
                    Error('Payment Method Buy Back does not exist');
            END;
            //<<Buy Back

            //>>Cheque
            IF SalesHeader.PayByChqAmt <> 0 THEN BEGIN
                PaymentMethod.Reset();
                PaymentMethod.SetRange(PaymentMethod."Pay Type", PaymentMethod."Pay Type"::Cheque);
                IF PaymentMethod.FindFirst() THEN
                    CreatePaymentEntry(SalesHeader, SalesHeader.PayByChqAmt, PaymentMethod."Bal. Account No.")
                ELSE
                    Error('Payment Method cheque does not exist');
            END;
            //<<Cheque

            //>>Gift Voucher
            IF SalesHeader.GiftVoucherAmt <> 0 THEN BEGIN
                PaymentMethod.Reset();
                PaymentMethod.SetRange(PaymentMethod."Pay Type", PaymentMethod."Pay Type"::"Gift Voucher");
                IF PaymentMethod.FindFirst() THEN
                    CreatePaymentEntry(SalesHeader, SalesHeader.GiftVoucherAmt, PaymentMethod."Bal. Account No.")
                ELSE
                    Error('Payment Method Gift Voucher does not exist');
            END;
            //<<Gift Voucher

            //>>RTGS
            IF SalesHeader."RTGS Amount" <> 0 THEN BEGIN
                PaymentMethod.Reset();
                PaymentMethod.SetRange(PaymentMethod."Pay Type", PaymentMethod."Pay Type"::RTGS);
                IF PaymentMethod.FindFirst() THEN
                    CreatePaymentEntry(SalesHeader, SalesHeader."RTGS Amount", PaymentMethod."Bal. Account No.")
                ELSE
                    Error('Payment Method RTGS does not exist');
            END;
            //<<RTGS


            //>>Finance
            IF SalesHeader."Finance Amount" <> 0 THEN BEGIN
                PaymentMethod.Reset();
                PaymentMethod.SetRange(PaymentMethod."Pay Type", PaymentMethod."Pay Type"::Finance);
                PaymentMethod.SetRange(PaymentMethod.Code, SalesHeader."FinPay Method Code");
                IF PaymentMethod.FindFirst() THEN
                    CreatePaymentEntry(SalesHeader, SalesHeader."Finance Amount", PaymentMethod."Bal. Account No.")
                ELSE
                    Error('Payment code Finance does not exist');
            END;
            //<<Finance

            //>>RazorPay
            IF SalesHeader."Paytm Transfer Amount" <> 0 THEN BEGIN
                PaymentMethod.Reset();
                PaymentMethod.SetRange(PaymentMethod."Pay Type", PaymentMethod."Pay Type"::RazorPay);
                IF PaymentMethod.FindFirst() THEN
                    CreatePaymentEntry(SalesHeader, SalesHeader."Paytm Transfer Amount", PaymentMethod."Bal. Account No.")
                ELSE
                    Error('Payment Method Razor Pay does not exist');
            END;
            //<<RazorPay


            //>>PAYTM DCEMI
            IF SalesHeader."Amazon Transfer Amount" <> 0 THEN BEGIN
                PaymentMethod.Reset();
                PaymentMethod.SetRange(PaymentMethod."Pay Type", PaymentMethod."Pay Type"::"PAYTM DCEMI");
                IF PaymentMethod.FindFirst() THEN
                    CreatePaymentEntry(SalesHeader, SalesHeader."Amazon Transfer Amount", PaymentMethod."Bal. Account No.")
                ELSE
                    Error('Payment Method PAYTM DCEMI does not exist');
            END;
            //<<PAYTM DCEMI

            //>>Insurance
            IF SalesHeader."Insurance Transfer Amount" <> 0 THEN BEGIN
                PaymentMethod.Reset();
                PaymentMethod.SetRange(PaymentMethod.Code, SalesHeader.InsuranceMethodCode);
                IF PaymentMethod.FindFirst() THEN
                    CreatePaymentEntry(SalesHeader, SalesHeader."Insurance Transfer Amount", PaymentMethod."Bal. Account No.")
                ELSE
                    Error('Payment Insurance code does not exist');
            END;
            //<<Insurance

            //>>Cashify
            IF SalesHeader."Cashify Transfer Amount" <> 0 THEN BEGIN
                PaymentMethod.Reset();
                PaymentMethod.SetRange(PaymentMethod."Pay Type", PaymentMethod."Pay Type"::Cashify);
                IF PaymentMethod.FindFirst() THEN
                    CreatePaymentEntry(SalesHeader, SalesHeader."Cashify Transfer Amount", PaymentMethod."Bal. Account No.")
                ELSE
                    Error('Payment Method Cashify does not exist');
            END;
            //<<Cashify


            //>>Cashify Bonus Amount
            IF SalesHeader."Cashify Bonus Amount" <> 0 THEN BEGIN
                PaymentMethod.Reset();
                PaymentMethod.SetRange(PaymentMethod.Code, SalesHeader.CashifyBonusMethodCode);
                IF PaymentMethod.FindFirst() THEN
                    CreatePaymentEntry(SalesHeader, SalesHeader."Cashify Bonus Amount", PaymentMethod."Bal. Account No.")
                ELSE
                    Error('Payment code Cashify Bonus does not exist');
            END;
            //<<Cashify Bonus Amount



            //>>Pine Lab
            IF SalesHeader."Pinelab Transfer Amount" <> 0 THEN BEGIN
                PaymentMethod.Reset();
                PaymentMethod.SetRange(PaymentMethod.Code, SalesHeader.PinelabMethodCode);
                IF PaymentMethod.FindFirst() THEN
                    CreatePaymentEntry(SalesHeader, SalesHeader."Pinelab Transfer Amount", PaymentMethod."Bal. Account No.")
                ELSE
                    Error('Payment code Pine Lab does not exist');
            END;
            //<<Pine Lab

            //>>Loyalty Riwardz
            IF SalesHeader."Loyalty Riwardz Tr.Amount" <> 0 THEN BEGIN
                PaymentMethod.Reset();
                PaymentMethod.SetRange(PaymentMethod.Code, SalesHeader."Loyalty Riwardz Method Code");
                IF PaymentMethod.FindFirst() THEN
                    CreatePaymentEntry(SalesHeader, SalesHeader."Loyalty Riwardz Tr.Amount", PaymentMethod."Bal. Account No.")
                ELSE
                    Error('Payment code loyality does not exist');
            END;
            //<<Loyalty Riwardz

            //>>Servify Transfer
            IF SalesHeader."Servify Transfer Amount" <> 0 THEN BEGIN
                PaymentMethod.Reset();
                PaymentMethod.SetRange(PaymentMethod."Pay Type", PaymentMethod."Pay Type"::"Servify Transfer");
                IF PaymentMethod.FindFirst() THEN
                    CreatePaymentEntry(SalesHeader, SalesHeader."Servify Transfer Amount", PaymentMethod."Bal. Account No.")
                ELSE
                    Error('Payment Method Servify Transfer does not exist');
            END;
            //<<Servify Transfer


            //>>Servify Bonus
            IF SalesHeader."Servify Bonus Amount" <> 0 THEN BEGIN
                PaymentMethod.Reset();
                PaymentMethod.SetRange(PaymentMethod."Pay Type", PaymentMethod."Pay Type"::"Servify Bonus");
                IF PaymentMethod.FindFirst() THEN
                    CreatePaymentEntry(SalesHeader, SalesHeader."Servify Bonus Amount", PaymentMethod."Bal. Account No.")
                ELSE
                    Error('Payment Method Servify Bonus does not exist');
            END;
            //<<Servify Bonus

            //>>Paytm Transfer
            IF SalesHeader."Paytm Transfer Amount Last" <> 0 THEN BEGIN
                PaymentMethod.Reset();
                PaymentMethod.SetRange(PaymentMethod."Pay Type", PaymentMethod."Pay Type"::"Paytm Transfer");
                IF PaymentMethod.FindFirst() THEN
                    CreatePaymentEntry(SalesHeader, SalesHeader."Paytm Transfer Amount Last", PaymentMethod."Bal. Account No.")
                ELSE
                    Error('Payment Method Paytm Transfer does not exist');
            END;
            //<<Paytm Transfer

            GenJnlLine1.Reset();
            GenJnlLine1.Setrange("Journal Template Name", 'PAYMENTS');
            GenJnlLine1.Setrange("Journal Batch Name", 'DEFAULT');
            IF GenJnlLine1.FindSet() THEN
                REPEAT
                    GenJnlPostLine.RunWithCheck(GenJnlLine1);
                UNTIL GenJnlLine1.Next() = 0;
        END;
    END;

    //GenJnlLine."Document Type"::Invoice:
    //  BEGIN
    //         //GenJnlLineDocNo + '-P';
    //         CustLedgEntry.SetRange("Document Type", CustLedgEntry."Document Type"::Invoice);
    //         // CustLedgEntry.SETRANGE("Document Type", CustLedgEntry."Document Type::Invoice);
    //         //  CustLedgEntry.SETRANGE("Document No.", GenJnlLineDocNo);
    //         CustLedgEntry.SETRANGE("Document No.", GenJnlLine."Document No.");
    //         CustLedgEntry.FINDLAST;
    //         // FindCustLedgEntry(GenJnlLineDocType,GenJnlLineDocNo,CustLedgerEntry);
    //         //  SalesInvHeader."Cust. Ledger Entry No." := CustLedgerEntry."Entry No.";
    //         //   SalesInvHeader.MODIFY;
    //     END;
    //win352++
    //     ///Shield Invoice Payment
    //     SalesHeader.CALCFIELDS(Shield);//tk
    //     SalesHeader.CALCFIELDS("Total Shield Value");
    //     IF (SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice) AND (SalesHeader.Shield) AND (SalesHeader."Sales Order Type" = SalesHeader."Sales Order Type"::Retail) AND (SalesHeader."Total Shield Value" <> 0) THEN BEGIN
    //         CLEAR(ArPayTypes);
    //         i := 0;
    //         j := 0;
    //         FOR i := 1 TO 20 DO BEGIN //changed from 18 to 19 win-234 11-02-2019 -->//KPPLDG00033 changed from 19 to 20
    //             FOR j := 1 TO 11 DO BEGIN //changed from 9 to 10 win-234 11-02-2019 -->//KPPLDG00033 changed from 10 to 11
    //                 ArPayTypes[i, j] := '';
    //                 CLEAR(ArPayTypes[i, j]);
    //             END;
    //         END;
    //         GetShieldPaymentDetails(SalesHeader);
    //         FOR i := 1 TO 20 DO BEGIN //changed from 18 to 19 win-234 11-02-2019 -->//KPPLDG00033 changed from 19 to 20
    //             IF ArPayTypes[i, 1] <> '' THEN BEGIN
    //                 IF GUIALLOWED THEN
    //                     Window.UPDATE(5, 1);//tk
    //                 CustLedgEntry.FIND('+');
    //Message('%1', GenJnlLine);

    //                 //Service Charges
    //                 IF (ArPayTypes[i, 7] = FORMAT(PaymentType::"Credit Card")) OR (ArPayTypes[i, 7] = FORMAT(PaymentType::Finance)) OR (ArPayTypes[i, 7] = FORMAT(PaymentType::"Debit Card")) THEN BEGIN
    //                     CustLedgEntry.FIND('+');
    //                     GenJnlLine1.INIT;
    //                     GenJnlLine1."Posting Date" := SalesHeader."Posting Date";
    //                     GenJnlLine1."Document Date" := SalesHeader."Document Date";
    //                     GenJnlLine1.Description := SalesHeader."Posting Description";
    //                     GenJnlLine1."Shortcut Dimension 1 Code" := SalesHeader."Shortcut Dimension 1 Code";
    //                     GenJnlLine1."Shortcut Dimension 2 Code" := SalesHeader."Shortcut Dimension 2 Code";
    //                     GenJnlLine1."Dimension Set ID" := SalesHeader."Dimension Set ID";
    //                     GenJnlLine1."Reason Code" := SalesHeader."Reason Code";
    //                     GenJnlLine1."Account Type" := GenJnlLine1."Account Type"::Customer;
    //                     GenJnlLine1."Account No." := SalesHeader."Bill-to Customer No.";
    //                     IF SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo" THEN
    //                         GenJnlLine1."Document Type" := GenJnlLine1."Document Type"::Refund
    //                     ELSE
    //                         GenJnlLine1."Document Type" := GenJnlLine1."Document Type"::Payment;
    //                     EVALUATE(GenJnlLine1."Bal. Account Type", ArPayTypes[i, 2]);
    //                     GenJnlLine1."Document No." := GenJnlLineDocNo + '-P';
    //                     GenJnlLine1."External Document No." := GenJnlLineExtDocNo;
    //                     GenJnlLine1."Bal. Account No." := ArPayTypes[i, 5];
    //                     GenJnlLine1."Currency Code" := SalesHeader."Currency Code";
    //                     EVALUATE(GenJnlLine1.Amount, ArPayTypes[i, 6]);
    //                     GenJnlLine1.Amount := ROUND(GenJnlLine1.Amount, Currency."Amount Rounding Precision") * -1;
    //                     GenJnlLine1."Source Currency Code" := SalesHeader."Currency Code";
    //                     GenJnlLine1."Source Currency Amount" := GenJnlLine1.Amount;
    //                     GenJnlLine1.Correction := SalesHeader.Correction;
    //                     CustLedgEntry.CALCFIELDS(Amount);
    //                     IF CustLedgEntry.Amount = 0 THEN
    //                         GenJnlLine1."Amount (LCY)" := AmountToCustomerLCY
    //                     ELSE BEGIN
    //                         GenJnlLine1."Amount (LCY)" := (
    //                            AmountToCustomer
    //                            +
    //                            ROUND(
    //                              CustLedgEntry."Remaining Pmt. Disc. Possible" /
    //                              CustLedgEntry."Adjusted Currency Factor"));
    //                         //  MESSAGE(FORMAT(GenJnlLine."Amount (LCY)" ));
    //                     END;
    //                     IF SalesHeader."Currency Code" = '' THEN
    //                         GenJnlLine1."Currency Factor" := 1
    //                     ELSE
    //                         GenJnlLine1."Currency Factor" := SalesHeader."Currency Factor";
    //                     GenJnlLine1."Applies-to Doc. Type" := GenJnlLineDocType;
    //                     GenJnlLine1."Applies-to Doc. No." := GenJnlLineDocNo;
    //                     GenJnlLine1."Source Type" := GenJnlLine1."Source Type"::Customer;
    //                     GenJnlLine1."Source No." := SalesHeader."Bill-to Customer No.";
    //                     GenJnlLine1."Source Code" := SrcCode;
    //                     GenJnlLine1."Posting No. Series" := SalesHeader."Posting No. Series";
    //                     GenJnlLine1."IC Partner Code" := SalesHeader."Sell-to IC Partner Code";
    //                     IF GenJnlLine1.Amount <> 0 THEN    //Added 16.01.15
    //                         GenJnlPostLine.RunWithCheck(GenJnlLine1);//,TempJnlLineDim);
    //                 END;
    //             END;
    //         END;
    //     END;
    //     //Shield Invoice Payment
    //     //...............................................Nav Upgradation
    //     //Win127 for Cash & Credit Card Payment in Single Invoice 21.06.14
    //     IF (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) AND (SalesHeader."Sales Order Type" = SalesHeader."Sales Order Type"::Retail) THEN BEGIN
    //         CLEAR(ArPayTypes);
    //         i := 0;
    //         j := 0;
    //         FOR i := 1 TO 20 DO BEGIN  //changed from 18 to 19 win-234 11-02-2019 -->//KPPLDG00033 changed from 19 to 20
    //             FOR j := 1 TO 11 DO BEGIN  //changed from 9 to 10 win-234 11-02-2019 -->//KPPLDG00033 changed from 10 to 12
    //                 ArPayTypes[i, j] := '';
    //                 CLEAR(ArPayTypes[i, j]);
    //             END;
    //         END;
    //         GetPaymentDetails(SalesHeader);
    //         FOR i := 1 TO 20 DO BEGIN   //changed from 18 to 19 win-234 11-02-2019 -->//KPPLDG00033 changed from 19 to 20
    //             IF ArPayTypes[i, 1] <> '' THEN BEGIN
    //                 PaymentAmount := 0;
    //                 EVALUATE(PaymentAmount, ArPayTypes[i, 4]);
    //                 IF PaymentAmount <> 0 THEN BEGIN
    //                     IF GUIALLOWED THEN
    //                         //Window.UPDATE(5, 1);
    //                     CustLedgEntry.FIND('+');//tk
    //                     GenJnlLine.INIT;
    //                     GenJnlLine."Posting Date" := SalesHeader."Posting Date";
    //                     GenJnlLine."Document Date" := SalesHeader."Document Date";
    //                     GenJnlLine.Description := SalesHeader."Posting Description";
    //                     GenJnlLine."Shortcut Dimension 1 Code" := SalesHeader."Shortcut Dimension 1 Code";
    //                     GenJnlLine."Shortcut Dimension 2 Code" := SalesHeader."Shortcut Dimension 2 Code";
    //                     GenJnlLine."Dimension Set ID" := SalesHeader."Dimension Set ID";
    //                     GenJnlLine."Reason Code" := SalesHeader."Reason Code";
    //                     GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
    //                     GenJnlLine."Account No." := SalesHeader."Bill-to Customer No.";
    //                     IF SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo" THEN
    //                         GenJnlLine."Document Type" := GenJnlLine."Document Type"::Refund
    //                     ELSE
    //                         GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
    //                     EVALUATE(GenJnlLine."Bal. Account Type", ArPayTypes[i, 2]);
    //                     GenJnlLine."Document No." := GenJnlLineDocNo + '-P';
    //                     GenJnlLine."External Document No." := GenJnlLineExtDocNo;
    //                     GenJnlLine."Bal. Account No." := ArPayTypes[i, 3];
    //                     GenJnlLine."Currency Code" := SalesHeader."Currency Code";
    //                     EVALUATE(GenJnlLine.Amount, ArPayTypes[i, 4]);
    //                     GenJnlLine.Amount := ROUND(GenJnlLine.Amount, Currency."Amount Rounding Precision") * -1;
    //                     GenJnlLine."Source Currency Code" := SalesHeader."Currency Code";
    //                     GenJnlLine."Source Currency Amount" := GenJnlLine.Amount;
    //                     GenJnlLine.Correction := SalesHeader.Correction;
    //                     CustLedgEntry.CALCFIELDS(Amount);
    //                     IF CustLedgEntry.Amount = 0 THEN
    //                         GenJnlLine."Amount (LCY)" := AmountToCustomerLCY
    //                     ELSE BEGIN
    //                         GenJnlLine."Amount (LCY)" := (
    //                            AmountToCustomer
    //                            +
    //                            ROUND(
    //                              CustLedgEntry."Remaining Pmt. Disc. Possible" /
    //                              CustLedgEntry."Adjusted Currency Factor"));
    //                         //  MESSAGE(FORMAT(GenJnlLine."Amount (LCY)" ));
    //                     END;
    //                     IF SalesHeader."Currency Code" = '' THEN
    //                         GenJnlLine."Currency Factor" := 1
    //                     ELSE
    //                         GenJnlLine."Currency Factor" := SalesHeader."Currency Factor";
    //                     GenJnlLine."Applies-to Doc. Type" := GenJnlLineDocType;
    //                     GenJnlLine."Applies-to Doc. No." := GenJnlLineDocNo;
    //                     GenJnlLine."Source Type" := GenJnlLine."Source Type"::Customer;
    //                     GenJnlLine."Source No." := SalesHeader."Bill-to Customer No.";
    //                     GenJnlLine."Source Code" := SrcCode;
    //                     GenJnlLine."Posting No. Series" := SalesHeader."Posting No. Series";
    //                     GenJnlLine."IC Partner Code" := SalesHeader."Sell-to IC Partner Code";
    //                     IF ArPayTypes[i, 7] = FORMAT(PaymentType::Cheque) THEN BEGIN
    //                         // GenJnlLine."Cheque Date" := SalesHeader.PayByChqDt;
    //                         // GenJnlLine."Cheque No." :=  SalesHeader.PayByChqNo;
    //                     END;//tk
    //                     // IF NOT  ((ArPayTypes[i,7] = FORMAT(PaymentType::"Maple BuyBack")) OR  (ArPayTypes[i,7] = FORMAT(PaymentType::"Apple BuyBack")) OR  (ArPayTypes[i,7] = FORMAT(PaymentType::"Apple Refund"))) THEN
    //                     GenJnlPostLine.RunWithCheck(GenJnlLine);
    //                     // IF (ArPayTypes[i,7] = FORMAT(PaymentType::"Apple Refund")) THEN BEGIN
    //                     //    IF GenJnlLine.Amount <> 0 THEN
    //                     //      CreateAppleBuybackCrMemo(Rec,GenJnlLineDocNo);
    //                     // END;

    //                 END;//PaymentAmount

    //                 //Service Charges
    //                 IF (ArPayTypes[i, 7] = FORMAT(PaymentType::"Credit Card")) OR (ArPayTypes[i, 7] = FORMAT(PaymentType::Finance)) OR (ArPayTypes[i, 7] = FORMAT(PaymentType::"Debit Card")) THEN BEGIN
    //                     PaymentAmount := 0;
    //                     EVALUATE(PaymentAmount, ArPayTypes[i, 6]);
    //                     IF PaymentAmount <> 0 THEN BEGIN
    //                         CustLedgEntry.FIND('+');
    //                         GenJnlLine1.INIT;
    //                         GenJnlLine1."Posting Date" := SalesHeader."Posting Date";
    //                         GenJnlLine1."Document Date" := SalesHeader."Document Date";
    //                         GenJnlLine1.Description := SalesHeader."Posting Description";
    //                         GenJnlLine1."Shortcut Dimension 1 Code" := SalesHeader."Shortcut Dimension 1 Code";
    //                         GenJnlLine1."Shortcut Dimension 2 Code" := SalesHeader."Shortcut Dimension 2 Code";
    //                         GenJnlLine1."Dimension Set ID" := SalesHeader."Dimension Set ID";
    //                         GenJnlLine1."Reason Code" := SalesHeader."Reason Code";
    //                         GenJnlLine1."Account Type" := GenJnlLine1."Account Type"::Customer;
    //                         GenJnlLine1."Account No." := SalesHeader."Bill-to Customer No.";
    //                         IF SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo" THEN
    //                             GenJnlLine1."Document Type" := GenJnlLine1."Document Type"::Refund
    //                         ELSE
    //                             GenJnlLine1."Document Type" := GenJnlLine1."Document Type"::Payment;
    //                         EVALUATE(GenJnlLine1."Bal. Account Type", ArPayTypes[i, 2]);
    //                         GenJnlLine1."Document No." := GenJnlLineDocNo + '-P';
    //                         GenJnlLine1."External Document No." := GenJnlLineExtDocNo;
    //                         GenJnlLine1."Bal. Account No." := ArPayTypes[i, 5];
    //                         GenJnlLine1."Currency Code" := SalesHeader."Currency Code";
    //                         EVALUATE(GenJnlLine1.Amount, ArPayTypes[i, 6]);
    //                         GenJnlLine1.Amount := ROUND(GenJnlLine1.Amount, Currency."Amount Rounding Precision") * -1;
    //                         GenJnlLine1."Source Currency Code" := SalesHeader."Currency Code";
    //                         GenJnlLine1."Source Currency Amount" := GenJnlLine1.Amount;
    //                         GenJnlLine1.Correction := SalesHeader.Correction;
    //                         CustLedgEntry.CALCFIELDS(Amount);
    //                         IF CustLedgEntry.Amount = 0 THEN
    //                             GenJnlLine1."Amount (LCY)" := AmountToCustomerLCY
    //                         ELSE BEGIN
    //                             GenJnlLine1."Amount (LCY)" := (
    //                                AmountToCustomer
    //                                +
    //                                ROUND(
    //                                  CustLedgEntry."Remaining Pmt. Disc. Possible" /
    //                                  CustLedgEntry."Adjusted Currency Factor"));
    //                             //  MESSAGE(FORMAT(GenJnlLine."Amount (LCY)" ));
    //                         END;
    //                         IF SalesHeader."Currency Code" = '' THEN
    //                             GenJnlLine1."Currency Factor" := 1
    //                         ELSE
    //                             GenJnlLine1."Currency Factor" := SalesHeader."Currency Factor";
    //                         GenJnlLine1."Applies-to Doc. Type" := GenJnlLineDocType;
    //                         GenJnlLine1."Applies-to Doc. No." := GenJnlLineDocNo;
    //                         GenJnlLine1."Source Type" := GenJnlLine1."Source Type"::Customer;
    //                         GenJnlLine1."Source No." := SalesHeader."Bill-to Customer No.";
    //                         GenJnlLine1."Source Code" := SrcCode;
    //                         GenJnlLine1."Posting No. Series" := SalesHeader."Posting No. Series";
    //                         GenJnlLine1."IC Partner Code" := SalesHeader."Sell-to IC Partner Code";
    //                         IF GenJnlLine1.Amount <> 0 THEN        //Win127 added 16.01.15
    //                             GenJnlPostLine.RunWithCheck(GenJnlLine1);//,TempJnlLineDim);
    //                     END;
    //                 END;
    //             END;
    //         END;
    //     END;
    //     //     //GLSetup.GET;
    //     //     //     //IF ( "Document Type" = "Document Type"::Order ) AND ("Sales Order Type" = "Sales Order Type"::Retail ) AND ("Apple Refund Amt" <> 0 ) AND (GLSetup."Purchase Invoice IIIrd Party") THEN
    //     //     //     //  CreateAppleBuybackCrMemo(Rec,GenJnlLineDocNo);


    //     //     //     //     // end of Cash & Card Payment in Single Invoice
    //     //     //     //     //...............................................Nav Upgradation
    //     //     //     //     //win352--
    //     //     //     //     //tk
    // end;//tk dialouge box error // poitn 5

    procedure GetPaymentDetails(salesHeader: Record "Sales Header")
    var
        TotalAfterShield: Decimal;
        PendingShieldAmt: Decimal;
        ServiceCharges: Decimal;
    begin
        TotalAfterShield := 0;
        salesHeader.CalcFields(Shield);
        salesHeader.CalcFields("Total Shield Value");

        i := 0;
        j := 0;
        for i := 1 to 20 do begin //KPPLDG00033 changed from 19 to 20
            for j := 1 to 11 do begin //KPPLDG00033 changed from 10 to 11
                ArPayTypes[i, j] := '';
            end;
        end;

        i := 1;
        j := 1;
        PendingShieldAmt := salesHeader."Total Shield Value";
        // 1) cash
        if (salesHeader."CashPay Method Code" <> '') and (salesHeader.PayByCashAmt <> 0) then begin
            PaymentMethod.Get(salesHeader."CashPay Method Code");
            //  MESSAGE('Cash');
            ArPayTypes[i, j] := PaymentMethod.Code;
            j += 1;
            ArPayTypes[i, j] := Format(PaymentMethod."Bal. Account Type");
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Bal. Account No.";
            j += 1;

            if salesHeader.Shield and (salesHeader."Total Shield Value" <> 0) and (PendingShieldAmt <> 0) then begin
                if PendingShieldAmt <> 0 then begin
                    if salesHeader.PayByCashAmt > PendingShieldAmt then begin
                        ArPayTypes[i, j] := Format(salesHeader.PayByCashAmt - PendingShieldAmt);
                        PendingShieldAmt := 0;
                    end
                    else begin
                        ArPayTypes[i, j] := Format(0);
                        PendingShieldAmt := PendingShieldAmt - salesHeader.PayByCashAmt;
                    end;
                end;
            end
            else
                ArPayTypes[i, j] := Format(salesHeader.PayByCashAmt);
            j += 1;
            ArPayTypes[i, j] := '';
            j += 1;//Service Charge A/c;
            ArPayTypes[i, j] := '0';
            j += 1;//Service Charge Amount
            ArPayTypes[i, j] := Format(PaymentMethod."Pay Type");
            i += 1;
        end;
        j := 1;
        // 2) cheque
        if (salesHeader."ChqPay Method Code" <> '') and (salesHeader.PayByChqAmt <> 0) then begin
            PaymentMethod.Get(salesHeader."ChqPay Method Code");
            //MESSAGE('Chq');
            ArPayTypes[i, j] := PaymentMethod.Code;
            j += 1;
            ArPayTypes[i, j] := Format(PaymentMethod."Bal. Account Type");
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Bal. Account No.";
            j += 1;
            if salesHeader.Shield and (salesHeader."Total Shield Value" <> 0) and (PendingShieldAmt <> 0) then begin
                //IF PendingShieldAmt <> 0 THEN BEGIN
                if salesHeader.PayByChqAmt > PendingShieldAmt then begin
                    ArPayTypes[i, j] := Format(salesHeader.PayByChqAmt - PendingShieldAmt);
                    PendingShieldAmt := 0;
                end
                else begin
                    ArPayTypes[i, j] := Format(0);
                    PendingShieldAmt := PendingShieldAmt - salesHeader.PayByChqAmt;
                end;
                //END;
            end
            else
                ArPayTypes[i, j] := Format(salesHeader.PayByChqAmt);
            j += 1;
            ArPayTypes[i, j] := '';
            j += 1;//Service Charge A/c;
            ArPayTypes[i, j] := '0';
            j += 1;//Service Charge Amount
            ArPayTypes[i, j] := Format(PaymentMethod."Pay Type");
            i += 1;
        end;

        j := 1;
        // 3) CC1
        if (salesHeader."CreditCdPay Method Code1" <> '') and (salesHeader.PayByCreditAmt1 <> 0) then begin
            //MESSAGE('Credit1');
            PaymentMethod.Get(salesHeader."CreditCdPay Method Code1");
            ArPayTypes[i, j] := PaymentMethod.Code;
            j += 1;
            ArPayTypes[i, j] := Format(PaymentMethod."Bal. Account Type");
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Bal. Account No.";
            j += 1;

            ServiceCharges := (salesHeader.PayByCreditAmt1 * PaymentMethod."Service Charge Perc") / 100;
            if salesHeader.Shield and (salesHeader."Total Shield Value" <> 0) and (PendingShieldAmt <> 0) then begin
                //IF PendingShieldAmt <> 0 THEN BEGIN
                if salesHeader.PayByCreditAmt1 > PendingShieldAmt then begin
                    ServiceCharges := ((salesHeader.PayByCreditAmt1 - PendingShieldAmt) * PaymentMethod."Service Charge Perc") / 100;
                    ArPayTypes[i, j] := Format(salesHeader.PayByCreditAmt1 - PendingShieldAmt - ServiceCharges);
                    PendingShieldAmt := 0;
                end
                else begin
                    ArPayTypes[i, j] := Format(0);
                    ServiceCharges := 0;
                    PendingShieldAmt := PendingShieldAmt - salesHeader.PayByCreditAmt1;
                end;
                // END;
            end
            else
                ArPayTypes[i, j] := Format(salesHeader.PayByCreditAmt1 - ((salesHeader.PayByCreditAmt1 * PaymentMethod."Service Charge Perc") / 100));
            j += 1;

            ArPayTypes[i, j] := PaymentMethod."Service Charge Account No.";
            j += 1;//Service Charge A/c
            ArPayTypes[i, j] := Format(ServiceCharges);
            j += 1;//Service Charge Amount
            ArPayTypes[i, j] := Format(PaymentMethod."Pay Type");
            i += 1;
        end;
        j := 1;
        // 4) CC2
        if (salesHeader."CreditCdPay Method Code2" <> '') and (salesHeader.PayByCreditAmt2 <> 0) then begin
            PaymentMethod.Get(salesHeader."CreditCdPay Method Code2");
            //MESSAGE('Credit2');
            ArPayTypes[i, j] := PaymentMethod.Code;
            j += 1;
            ArPayTypes[i, j] := Format(PaymentMethod."Bal. Account Type");
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Bal. Account No.";
            j += 1;
            ServiceCharges := (salesHeader.PayByCreditAmt2 * PaymentMethod."Service Charge Perc") / 100;
            if salesHeader.Shield and (salesHeader."Total Shield Value" <> 0) and (PendingShieldAmt <> 0) then begin
                //IF PendingShieldAmt <> 0 THEN BEGIN
                if salesHeader.PayByCreditAmt2 > PendingShieldAmt then begin
                    ServiceCharges := ((salesHeader.PayByCreditAmt2 - PendingShieldAmt) * PaymentMethod."Service Charge Perc") / 100;
                    ArPayTypes[i, j] := Format(salesHeader.PayByCreditAmt2 - PendingShieldAmt - ServiceCharges);
                    PendingShieldAmt := 0;
                end
                else begin
                    ArPayTypes[i, j] := Format(0);
                    ServiceCharges := 0;
                    PendingShieldAmt := PendingShieldAmt - salesHeader.PayByCreditAmt2;
                end;
                /// END;
            end
            else
                ArPayTypes[i, j] := Format(salesHeader.PayByCreditAmt2 - ((salesHeader.PayByCreditAmt2 * PaymentMethod."Service Charge Perc") / 100));
            j += 1;

            ArPayTypes[i, j] := PaymentMethod."Service Charge Account No.";
            j += 1;//Service Charge A/c
            ArPayTypes[i, j] := Format(ServiceCharges);
            j += 1;//Service Charge Amount
            ArPayTypes[i, j] := Format(PaymentMethod."Pay Type");
            i += 1;
        end;
        j := 1;
        // 5) CC3
        if (salesHeader."CreditCdPay Method Code3" <> '') and (salesHeader.PayByCreditAmt3 <> 0) then begin
            PaymentMethod.Get(salesHeader."CreditCdPay Method Code3");
            //MESSAGE('Credit3');
            ArPayTypes[i, j] := PaymentMethod.Code;
            j += 1;
            ArPayTypes[i, j] := Format(PaymentMethod."Bal. Account Type");
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Bal. Account No.";
            j += 1;

            ServiceCharges := (salesHeader.PayByCreditAmt3 * PaymentMethod."Service Charge Perc") / 100;
            if salesHeader.Shield and (salesHeader."Total Shield Value" <> 0) and (PendingShieldAmt <> 0) then begin
                //IF PendingShieldAmt <> 0 THEN BEGIN
                if salesHeader.PayByCreditAmt3 > PendingShieldAmt then begin
                    ServiceCharges := ((salesHeader.PayByCreditAmt3 - PendingShieldAmt) * PaymentMethod."Service Charge Perc") / 100;
                    ArPayTypes[i, j] := Format(salesHeader.PayByCreditAmt3 - PendingShieldAmt - ServiceCharges);
                    PendingShieldAmt := 0;
                end
                else begin
                    ArPayTypes[i, j] := Format(0);
                    ServiceCharges := 0;
                    PendingShieldAmt := PendingShieldAmt - (salesHeader.PayByCreditAmt3);
                end;
                // END;
            end
            else
                ArPayTypes[i, j] := Format(salesHeader.PayByCreditAmt3 - ((salesHeader.PayByCreditAmt3 * PaymentMethod."Service Charge Perc") / 100));
            j += 1;

            ArPayTypes[i, j] := PaymentMethod."Service Charge Account No.";
            j += 1;//Service Charge A/c
            ArPayTypes[i, j] := Format(ServiceCharges);
            j += 1;//Service Charge Amount
            ArPayTypes[i, j] := Format(PaymentMethod."Pay Type");
            i += 1;
        end;
        j := 1;
        // 6) CC4
        if (salesHeader."CreditCdPay Method Code4" <> '') and (salesHeader.PayByCreditAmt4 <> 0) then begin
            //MESSAGE('Credit4');
            PaymentMethod.Get(salesHeader."CreditCdPay Method Code4");
            ArPayTypes[i, j] := PaymentMethod.Code;
            j += 1;
            ArPayTypes[i, j] := Format(PaymentMethod."Bal. Account Type");
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Bal. Account No.";
            j += 1;

            ServiceCharges := (salesHeader.PayByCreditAmt4 * PaymentMethod."Service Charge Perc") / 100;
            if salesHeader.Shield and (salesHeader."Total Shield Value" <> 0) and (PendingShieldAmt <> 0) then begin
                //IF PendingShieldAmt <> 0 THEN BEGIN
                if (salesHeader.PayByCreditAmt4 - ServiceCharges) > PendingShieldAmt then begin
                    ServiceCharges := ((salesHeader.PayByCreditAmt4 - PendingShieldAmt) * PaymentMethod."Service Charge Perc") / 100;
                    ArPayTypes[i, j] := Format(salesHeader.PayByCreditAmt4 - PendingShieldAmt - ServiceCharges);
                    PendingShieldAmt := 0;
                end
                else begin
                    ArPayTypes[i, j] := Format(0);
                    ServiceCharges := 0;
                    PendingShieldAmt := PendingShieldAmt - salesHeader.PayByCreditAmt4;
                end;
                // END;
            end
            else
                ArPayTypes[i, j] := Format(salesHeader.PayByCreditAmt4 - ((salesHeader.PayByCreditAmt4 * PaymentMethod."Service Charge Perc") / 100));
            j += 1;

            ArPayTypes[i, j] := PaymentMethod."Service Charge Account No.";
            j += 1;//Service Charge A/c
            ArPayTypes[i, j] := Format(ServiceCharges);
            j += 1;//Service Charge Amount
            ArPayTypes[i, j] := Format(PaymentMethod."Pay Type");
            i += 1;
        end;

        j := 1;
        // 7) DC1
        if (salesHeader."DebitCdPay Method Code2" <> '') and (salesHeader.PayByDebitAmt2 <> 0) then begin
            //MESSAGE('Credit4');
            PaymentMethod.Get(salesHeader."DebitCdPay Method Code2");
            ArPayTypes[i, j] := PaymentMethod.Code;
            j += 1;
            ArPayTypes[i, j] := Format(PaymentMethod."Bal. Account Type");
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Bal. Account No.";
            j += 1;

            ServiceCharges := (salesHeader.PayByDebitAmt2 * PaymentMethod."Service Charge Perc") / 100;
            if salesHeader.Shield and (salesHeader."Total Shield Value" <> 0) and (PendingShieldAmt <> 0) then begin
                //IF PendingShieldAmt <> 0 THEN BEGIN
                if salesHeader.PayByDebitAmt2 > PendingShieldAmt then begin
                    ServiceCharges := ((salesHeader.PayByDebitAmt2 - PendingShieldAmt) * PaymentMethod."Service Charge Perc") / 100;
                    ArPayTypes[i, j] := Format(salesHeader.PayByDebitAmt2 - PendingShieldAmt - ServiceCharges);
                    PendingShieldAmt := 0;
                end
                else begin
                    ArPayTypes[i, j] := Format(0);
                    ServiceCharges := 0;
                    PendingShieldAmt := PendingShieldAmt - salesHeader.PayByDebitAmt2;
                end;
                // END;
            end
            else
                ArPayTypes[i, j] := Format(salesHeader.PayByDebitAmt2 - ((salesHeader.PayByDebitAmt2 * PaymentMethod."Service Charge Perc") / 100));
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Service Charge Account No.";
            j += 1;//Service Charge A/c
            ArPayTypes[i, j] := Format(ServiceCharges);
            j += 1;//Service Charge Amount
            ArPayTypes[i, j] := Format(PaymentMethod."Pay Type");
            i += 1;
        end;

        j := 1;
        // 8) DC2
        if (salesHeader."DebitCdPay Method Code1" <> '') and (salesHeader.PayByDebitCdAmt1 <> 0) then begin
            ///MESSAGE('Debit');
            PaymentMethod.Get(salesHeader."DebitCdPay Method Code1");
            ArPayTypes[i, j] := PaymentMethod.Code;
            j += 1;
            ArPayTypes[i, j] := Format(PaymentMethod."Bal. Account Type");
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Bal. Account No.";
            j += 1;
            ServiceCharges := (salesHeader.PayByDebitCdAmt1 * PaymentMethod."Service Charge Perc") / 100;
            if salesHeader.Shield and (salesHeader."Total Shield Value" <> 0) and (PendingShieldAmt <> 0) then begin
                //IF PendingShieldAmt <> 0 THEN BEGIN
                if salesHeader.PayByDebitCdAmt1 > PendingShieldAmt then begin
                    ServiceCharges := ((salesHeader.PayByDebitCdAmt1 - PendingShieldAmt) * PaymentMethod."Service Charge Perc") / 100;
                    ArPayTypes[i, j] := Format(salesHeader.PayByDebitCdAmt1 - PendingShieldAmt - ServiceCharges);
                    PendingShieldAmt := 0;
                end
                else begin
                    ArPayTypes[i, j] := Format(0);
                    ServiceCharges := 0;
                    PendingShieldAmt := PendingShieldAmt - salesHeader.PayByDebitCdAmt1;
                end;
                //END;
            end
            else
                ArPayTypes[i, j] := Format(salesHeader.PayByDebitCdAmt1 - ((salesHeader.PayByDebitCdAmt1 * PaymentMethod."Service Charge Perc") / 100));
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Service Charge Account No.";
            j += 1;//Service Charge A/c;
            ArPayTypes[i, j] := Format(ServiceCharges);
            j += 1;//Service Charge Amount
            ArPayTypes[i, j] := Format(PaymentMethod."Pay Type");
            i += 1;
        end;

        j := 1;
        // 9) gift
        if (salesHeader."GiftPay Method Code" <> '') and (salesHeader.GiftVoucherAmt <> 0) then begin
            PaymentMethod.Get(salesHeader."GiftPay Method Code");
            //MESSAGE('Gift');
            ArPayTypes[i, j] := PaymentMethod.Code;
            j += 1;
            ArPayTypes[i, j] := Format(PaymentMethod."Bal. Account Type");
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Bal. Account No.";
            j += 1;
            if salesHeader.Shield and (salesHeader."Total Shield Value" <> 0) and (PendingShieldAmt <> 0) then begin
                //IF PendingShieldAmt <> 0 THEN BEGIN
                if salesHeader.GiftVoucherAmt > PendingShieldAmt then begin
                    ArPayTypes[i, j] := Format(salesHeader.GiftVoucherAmt - PendingShieldAmt);
                    PendingShieldAmt := 0;
                end
                else begin
                    ArPayTypes[i, j] := Format(0);
                    PendingShieldAmt := PendingShieldAmt - salesHeader.GiftVoucherAmt;
                end;
                //END;
            end
            else
                ArPayTypes[i, j] := Format(salesHeader.GiftVoucherAmt);
            j += 1;
            ArPayTypes[i, j] := '';
            j += 1;//Service Charge A/c;
            ArPayTypes[i, j] := '0';
            j += 1;//Service Charge Amount
            ArPayTypes[i, j] := Format(PaymentMethod."Pay Type");
            i += 1;
        end;
        j := 1;
        // 10) RTGS
        if (salesHeader."RTGSPay Method Code" <> '') and (salesHeader."RTGS Amount" <> 0) then begin
            PaymentMethod.Get(salesHeader."RTGSPay Method Code");
            //MESSAGE('RTGS');
            ArPayTypes[i, j] := PaymentMethod.Code;
            j += 1;
            ArPayTypes[i, j] := Format(PaymentMethod."Bal. Account Type");
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Bal. Account No.";
            j += 1;
            if salesHeader.Shield and (salesHeader."Total Shield Value" <> 0) and (PendingShieldAmt <> 0) then begin
                //IF PendingShieldAmt <> 0 THEN BEGIN
                if salesHeader."RTGS Amount" > PendingShieldAmt then begin
                    ArPayTypes[i, j] := Format(salesHeader."RTGS Amount" - PendingShieldAmt);
                    PendingShieldAmt := 0;
                end
                else begin
                    ArPayTypes[i, j] := Format(0);
                    PendingShieldAmt := PendingShieldAmt - salesHeader."RTGS Amount";
                end;
                //END;
            end
            else
                ArPayTypes[i, j] := Format(salesHeader."RTGS Amount");
            j += 1;
            ArPayTypes[i, j] := '';
            j += 1;//Service Charge A/c;
            ArPayTypes[i, j] := '0';
            j += 1;//Service Charge Amount
            ArPayTypes[i, j] := Format(PaymentMethod."Pay Type");
            i += 1;
        end;
        j := 1;
        // 11) FIN
        if (salesHeader."FinPay Method Code" <> '') and (salesHeader."Finance Amount" <> 0) then begin
            PaymentMethod.Get(salesHeader."FinPay Method Code");
            //MESSAGE('Finance');
            ArPayTypes[i, j] := PaymentMethod.Code;
            j += 1;
            ArPayTypes[i, j] := Format(PaymentMethod."Bal. Account Type");
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Bal. Account No.";
            j += 1;

            ServiceCharges := (salesHeader."Finance Amount" * PaymentMethod."Service Charge Perc") / 100;
            if salesHeader.Shield and (salesHeader."Total Shield Value" <> 0) and (PendingShieldAmt <> 0) then begin
                //IF PendingShieldAmt <> 0 THEN BEGIN
                if salesHeader."Finance Amount" > PendingShieldAmt then begin
                    ServiceCharges := ((salesHeader."Finance Amount" - PendingShieldAmt) * PaymentMethod."Service Charge Perc") / 100;
                    ArPayTypes[i, j] := Format(salesHeader."Finance Amount" - PendingShieldAmt - ServiceCharges);
                    PendingShieldAmt := 0;
                end
                else begin
                    ArPayTypes[i, j] := Format(0);
                    ServiceCharges := 0;
                    PendingShieldAmt := PendingShieldAmt - salesHeader."Finance Amount";
                end;
                //END;
            end
            else
                ArPayTypes[i, j] := Format(salesHeader."Finance Amount" - ((salesHeader."Finance Amount" * PaymentMethod."Service Charge Perc") / 100));
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Service Charge Account No.";
            j += 1;//Service Charge A/c
            ArPayTypes[i, j] := Format(ServiceCharges);
            j += 1;//Service Charge Amount
            ArPayTypes[i, j] := Format(PaymentMethod."Pay Type");
            i += 1;
        end;
        j := 1;
        // 12) MAPLE
        if (salesHeader."Maple Buyback Method Code" <> '') and (salesHeader."Maple Buyback Amt" <> 0) then begin
            PaymentMethod.Get(salesHeader."Maple Buyback Method Code");
            //MESSAGE('Finance');
            ArPayTypes[i, j] := PaymentMethod.Code;
            j += 1;
            ArPayTypes[i, j] := Format(PaymentMethod."Bal. Account Type");
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Bal. Account No.";
            j += 1;
            ArPayTypes[i, j] := Format(salesHeader."Maple Buyback Amt");
            j += 1;
            ArPayTypes[i, j] := '';
            j += 1;//Service Charge A/c;
            ArPayTypes[i, j] := '0';
            j += 1;//Service Charge Amount
            ArPayTypes[i, j] := Format(PaymentMethod."Pay Type");
            i += 1;
        end;
        j := 1;
        // 13) APPLE
        if (salesHeader."Apple Buyback method  Code" <> '') and (salesHeader."Apple Buyback Amt" <> 0) then begin
            PaymentMethod.Get(salesHeader."Apple Buyback method  Code");
            //MESSAGE('Finance');
            ArPayTypes[i, j] := PaymentMethod.Code;
            j += 1;
            ArPayTypes[i, j] := Format(PaymentMethod."Bal. Account Type");
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Bal. Account No.";
            j += 1;
            ArPayTypes[i, j] := Format(salesHeader."Apple Buyback Amt");
            j += 1;
            ArPayTypes[i, j] := '';
            j += 1;//Service Charge A/c;
            ArPayTypes[i, j] := '0';
            j += 1;//Service Charge Amount
            ArPayTypes[i, j] := Format(PaymentMethod."Pay Type");
            i += 1;
        end;

        /*  //Refund
        j := 1;
        IF ("Apple Buyback method  Code" <> '') AND ("Apple Buyback Amt"<>0) THEN BEGIN
          PaymentMethod.GET("Apple Buyback method  Code");
      //MESSAGE('Finance');
          ArPayTypes[i,j] := PaymentMethod.Code; j+=1;
          ArPayTypes[i,j] := FORMAT(PaymentMethod."Bal. Account Type"); j+=1;
          ArPayTypes[i,j] := PaymentMethod."Bal. Account No."; j+=1;
          ArPayTypes[i,j] := FORMAT("Apple Buyback Amt");  j+=1;
          ArPayTypes[i,j] := '';j+=1;//Service Charge A/c;
          ArPayTypes[i,j] := '0'; j+=1;//Service Charge Amount
          ArPayTypes[i,j] := FORMAT(PaymentMethod."Pay Type");i+=1;
        END;
        */

        // 14) PAYTM
        j := 1;
        if (salesHeader.paytmMethodCode <> '') and (salesHeader."Paytm Transfer Amount" <> 0) then begin
            PaymentMethod.Get(salesHeader.paytmMethodCode);
            //MESSAGE('Finance');
            ArPayTypes[i, j] := PaymentMethod.Code;
            j += 1;
            ArPayTypes[i, j] := Format(PaymentMethod."Bal. Account Type");
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Bal. Account No.";
            j += 1;

            ServiceCharges := (salesHeader."Paytm Transfer Amount" * PaymentMethod."Service Charge Perc") / 100;
            if salesHeader.Shield and (salesHeader."Total Shield Value" <> 0) and (PendingShieldAmt <> 0) then begin
                //IF PendingShieldAmt <> 0 THEN BEGIN
                if salesHeader."Paytm Transfer Amount" > PendingShieldAmt then begin
                    ServiceCharges := ((salesHeader."Paytm Transfer Amount" - PendingShieldAmt) * PaymentMethod."Service Charge Perc") / 100;
                    ArPayTypes[i, j] := Format(salesHeader."Paytm Transfer Amount" - ServiceCharges); //- PendingShieldAmt KPPL LM
                    PendingShieldAmt := 0;
                end
                else begin
                    ArPayTypes[i, j] := Format(0);
                    ServiceCharges := 0;
                    PendingShieldAmt := PendingShieldAmt - salesHeader."Paytm Transfer Amount";
                end;
                //END;
            end
            else
                ArPayTypes[i, j] := Format(salesHeader."Paytm Transfer Amount" - ((salesHeader."Paytm Transfer Amount" * PaymentMethod."Service Charge Perc") / 100));
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Service Charge Account No.";
            j += 1;//Service Charge A/c
            ArPayTypes[i, j] := Format(ServiceCharges);
            j += 1;//Service Charge Amount
            ArPayTypes[i, j] := Format(PaymentMethod."Pay Type");
            i += 1;
        end;
        //15) EX
        j := 1;
        if (salesHeader.ExMethodCode <> '') and (salesHeader."Amazon Transfer Amount" <> 0) then begin
            PaymentMethod.Get(salesHeader.ExMethodCode);
            //MESSAGE('Finance');
            ArPayTypes[i, j] := PaymentMethod.Code;
            j += 1;
            ArPayTypes[i, j] := Format(PaymentMethod."Bal. Account Type");
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Bal. Account No.";
            j += 1;

            ServiceCharges := (salesHeader."Amazon Transfer Amount" * PaymentMethod."Service Charge Perc") / 100;
            if salesHeader.Shield and (salesHeader."Total Shield Value" <> 0) and (PendingShieldAmt <> 0) then begin
                //IF PendingShieldAmt <> 0 THEN BEGIN
                if salesHeader."Amazon Transfer Amount" > PendingShieldAmt then begin
                    ServiceCharges := ((salesHeader."Amazon Transfer Amount" - PendingShieldAmt) * PaymentMethod."Service Charge Perc") / 100;
                    ArPayTypes[i, j] := Format(salesHeader."Amazon Transfer Amount" - PendingShieldAmt - ServiceCharges);
                    PendingShieldAmt := 0;
                end
                else begin
                    ArPayTypes[i, j] := Format(0);
                    ServiceCharges := 0;
                    PendingShieldAmt := PendingShieldAmt - salesHeader."Amazon Transfer Amount";
                end;
                //END;
            end
            else
                ArPayTypes[i, j] := Format(salesHeader."Amazon Transfer Amount" - ((salesHeader."Amazon Transfer Amount" * PaymentMethod."Service Charge Perc") / 100));
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Service Charge Account No.";
            j += 1;//Service Charge A/c
            ArPayTypes[i, j] := Format(ServiceCharges);
            j += 1;//Service Charge Amount
            ArPayTypes[i, j] := Format(PaymentMethod."Pay Type");
            i += 1;
        end;
        //16) INSURANCE
        j := 1;
        if (salesHeader.InsuranceMethodCode <> '') and (salesHeader."Insurance Transfer Amount" <> 0) then begin
            PaymentMethod.Get(salesHeader.InsuranceMethodCode);
            //MESSAGE('Finance');
            ArPayTypes[i, j] := PaymentMethod.Code;
            j += 1;
            ArPayTypes[i, j] := Format(PaymentMethod."Bal. Account Type");
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Bal. Account No.";
            j += 1;

            ServiceCharges := (salesHeader."Insurance Transfer Amount" * PaymentMethod."Service Charge Perc") / 100;
            if salesHeader.Shield and (salesHeader."Total Shield Value" <> 0) and (PendingShieldAmt <> 0) then begin
                //IF PendingShieldAmt <> 0 THEN BEGIN
                if salesHeader."Insurance Transfer Amount" > PendingShieldAmt then begin
                    ServiceCharges := ((salesHeader."Insurance Transfer Amount" - PendingShieldAmt) * PaymentMethod."Service Charge Perc") / 100;
                    ArPayTypes[i, j] := Format(salesHeader."Insurance Transfer Amount" - PendingShieldAmt - ServiceCharges);
                    PendingShieldAmt := 0;
                end
                else begin
                    ArPayTypes[i, j] := Format(0);
                    ServiceCharges := 0;
                    PendingShieldAmt := PendingShieldAmt - salesHeader."Insurance Transfer Amount";
                end;
                //END;
            end
            else
                ArPayTypes[i, j] := Format(salesHeader."Insurance Transfer Amount" - ((salesHeader."Insurance Transfer Amount" * PaymentMethod."Service Charge Perc") / 100));
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Service Charge Account No.";
            j += 1;//Service Charge A/c
            ArPayTypes[i, j] := Format(ServiceCharges);
            j += 1;//Service Charge Amount
            ArPayTypes[i, j] := Format(PaymentMethod."Pay Type");
            i += 1;
        end;
        //17) CASHIFY
        j := 1;
        if (salesHeader.CashifyMethodCode <> '') and (salesHeader."Cashify Transfer Amount" <> 0) then begin
            PaymentMethod.Get(salesHeader.CashifyMethodCode);
            //MESSAGE('Finance');
            ArPayTypes[i, j] := PaymentMethod.Code;
            j += 1;
            ArPayTypes[i, j] := Format(PaymentMethod."Bal. Account Type");
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Bal. Account No.";
            j += 1;

            ServiceCharges := (salesHeader."Cashify Transfer Amount" * PaymentMethod."Service Charge Perc") / 100;
            if salesHeader.Shield and (salesHeader."Total Shield Value" <> 0) and (PendingShieldAmt <> 0) then begin
                //IF PendingShieldAmt <> 0 THEN BEGIN
                if salesHeader."Cashify Transfer Amount" > PendingShieldAmt then begin
                    ServiceCharges := ((salesHeader."Cashify Transfer Amount" - PendingShieldAmt) * PaymentMethod."Service Charge Perc") / 100;
                    ArPayTypes[i, j] := Format(salesHeader."Cashify Transfer Amount" - PendingShieldAmt - ServiceCharges);
                    PendingShieldAmt := 0;
                end
                else begin
                    ArPayTypes[i, j] := Format(0);
                    ServiceCharges := 0;
                    PendingShieldAmt := PendingShieldAmt - salesHeader."Cashify Transfer Amount";
                end;
                //END;
            end
            else
                ArPayTypes[i, j] := Format(salesHeader."Cashify Transfer Amount" - ((salesHeader."Cashify Transfer Amount" * PaymentMethod."Service Charge Perc") / 100));
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Service Charge Account No.";
            j += 1;//Service Charge A/c
            ArPayTypes[i, j] := Format(ServiceCharges);
            j += 1;//Service Charge Amount
            ArPayTypes[i, j] := Format(PaymentMethod."Pay Type");
            i += 1;
        end;
        //TK
        //CashifyBonus

        j := 1;
        if (salesHeader.CashifyBonusMethodCode <> '') and (salesHeader."Cashify Bonus Amount" <> 0) then begin
            PaymentMethod.Get(salesHeader.CashifyBonusMethodCode);
            //MESSAGE('Finance');
            ArPayTypes[i, j] := PaymentMethod.Code;
            j += 1;
            ArPayTypes[i, j] := Format(PaymentMethod."Bal. Account Type");
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Bal. Account No.";
            j += 1;

            ServiceCharges := (salesHeader."Cashify Bonus Amount" * PaymentMethod."Service Charge Perc") / 100;
            if salesHeader.Shield and (salesHeader."Total Shield Value" <> 0) and (PendingShieldAmt <> 0) then begin
                //IF PendingShieldAmt <> 0 THEN BEGIN
                if salesHeader."Cashify Bonus Amount" > PendingShieldAmt then begin
                    ServiceCharges := ((salesHeader."Cashify Bonus Amount" - PendingShieldAmt) * PaymentMethod."Service Charge Perc") / 100;
                    ArPayTypes[i, j] := Format(salesHeader."Cashify Bonus Amount" - PendingShieldAmt - ServiceCharges);
                    PendingShieldAmt := 0;
                end
                else begin
                    ArPayTypes[i, j] := Format(0);
                    ServiceCharges := 0;
                    PendingShieldAmt := PendingShieldAmt - salesHeader."Cashify Bonus Amount";
                end;
                //END;
            end
            else
                ArPayTypes[i, j] := Format(salesHeader."Cashify Bonus Amount" - ((salesHeader."Cashify Bonus Amount" * PaymentMethod."Service Charge Perc") / 100));
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Service Charge Account No.";
            j += 1;//Service Charge A/c
            ArPayTypes[i, j] := Format(ServiceCharges);
            j += 1;//Service Charge Amount
            ArPayTypes[i, j] := Format(PaymentMethod."Pay Type");
            i += 1;
        end;

        //TK

        //18) PINELAB
        j := 1;
        if (salesHeader.PinelabMethodCode <> '') and (salesHeader."Pinelab Transfer Amount" <> 0) then begin
            PaymentMethod.Get(salesHeader.PinelabMethodCode);
            //MESSAGE('Finance');
            ArPayTypes[i, j] := PaymentMethod.Code;
            j += 1;
            ArPayTypes[i, j] := Format(PaymentMethod."Bal. Account Type");
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Bal. Account No.";
            j += 1;

            ServiceCharges := (salesHeader."Pinelab Transfer Amount" * PaymentMethod."Service Charge Perc") / 100;
            if salesHeader.Shield and (salesHeader."Total Shield Value" <> 0) and (PendingShieldAmt <> 0) then begin
                //IF PendingShieldAmt <> 0 THEN BEGIN
                if salesHeader."Pinelab Transfer Amount" > PendingShieldAmt then begin
                    ServiceCharges := ((salesHeader."Pinelab Transfer Amount" - PendingShieldAmt) * PaymentMethod."Service Charge Perc") / 100;
                    ArPayTypes[i, j] := Format(salesHeader."Pinelab Transfer Amount" - PendingShieldAmt - ServiceCharges);
                    PendingShieldAmt := 0;
                end
                else begin
                    ArPayTypes[i, j] := Format(0);
                    ServiceCharges := 0;
                    PendingShieldAmt := PendingShieldAmt - salesHeader."Pinelab Transfer Amount";
                end;
                //END;
            end
            else
                ArPayTypes[i, j] := Format(salesHeader."Pinelab Transfer Amount" - ((salesHeader."Pinelab Transfer Amount" * PaymentMethod."Service Charge Perc") / 100));
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Service Charge Account No.";
            j += 1;//Service Charge A/c
            ArPayTypes[i, j] := Format(ServiceCharges);
            j += 1;//Service Charge Amount
            ArPayTypes[i, j] := Format(PaymentMethod."Pay Type");
            i += 1;
        end;

        //19) Servify -> //KPPLDG00023
        j := 1;
        SalesOrderExtension.Reset;
        if SalesOrderExtension.Get(salesHeader."Document Type", salesHeader."No.") then begin
            if (SalesOrderExtension.ServifyMethodCode <> '') and (SalesOrderExtension."Servify Transfer Amount" <> 0) then begin
                PaymentMethod.Get(SalesOrderExtension.ServifyMethodCode);

                ArPayTypes[i, j] := PaymentMethod.Code;
                j += 1;
                ArPayTypes[i, j] := Format(PaymentMethod."Bal. Account Type");
                j += 1;
                ArPayTypes[i, j] := PaymentMethod."Bal. Account No.";
                j += 1;

                ServiceCharges := (SalesOrderExtension."Servify Transfer Amount" * PaymentMethod."Service Charge Perc") / 100;
                if salesHeader.Shield and (salesHeader."Total Shield Value" <> 0) and (PendingShieldAmt <> 0) then begin
                    if SalesOrderExtension."Servify Transfer Amount" > PendingShieldAmt then begin
                        ServiceCharges := ((SalesOrderExtension."Servify Transfer Amount" - PendingShieldAmt) * PaymentMethod."Service Charge Perc") / 100;
                        ArPayTypes[i, j] := Format(SalesOrderExtension."Servify Transfer Amount" - PendingShieldAmt - ServiceCharges);
                        PendingShieldAmt := 0;
                    end
                    else begin
                        ArPayTypes[i, j] := Format(0);
                        ServiceCharges := 0;
                        PendingShieldAmt := PendingShieldAmt - SalesOrderExtension."Servify Transfer Amount";
                    end;
                end
                else
                    ArPayTypes[i, j] := Format(SalesOrderExtension."Servify Transfer Amount" - ((SalesOrderExtension."Servify Transfer Amount" * PaymentMethod."Service Charge Perc") / 100));
                j += 1;
                ArPayTypes[i, j] := PaymentMethod."Service Charge Account No."; //Service Charge A/c
                j += 1;
                ArPayTypes[i, j] := Format(ServiceCharges);//Service Charge Amount
                j += 1;
                ArPayTypes[i, j] := Format(PaymentMethod."Pay Type");
                i += 1;
            end;
        end;
        //Servify <- //KPPLDG00023
        //TK
        //19) Servify -> //KPPLDG00023
        j := 1;
        SalesOrderExtension.Reset;
        if SalesOrderExtension.Get(salesHeader."Document Type", salesHeader."No.") then begin
            if (SalesOrderExtension.ServifyBonusMethodCode <> '') and (SalesOrderExtension."Servify Bonus Amount" <> 0) then begin
                PaymentMethod.Get(SalesOrderExtension.ServifyBonusMethodCode);

                ArPayTypes[i, j] := PaymentMethod.Code;
                j += 1;
                ArPayTypes[i, j] := Format(PaymentMethod."Bal. Account Type");
                j += 1;
                ArPayTypes[i, j] := PaymentMethod."Bal. Account No.";
                j += 1;

                ServiceCharges := (SalesOrderExtension."Servify Bonus Amount" * PaymentMethod."Service Charge Perc") / 100;
                if salesHeader.Shield and (salesHeader."Total Shield Value" <> 0) and (PendingShieldAmt <> 0) then begin
                    if SalesOrderExtension."Servify Bonus Amount" > PendingShieldAmt then begin
                        ServiceCharges := ((SalesOrderExtension."Servify Bonus Amount" - PendingShieldAmt) * PaymentMethod."Service Charge Perc") / 100;
                        ArPayTypes[i, j] := Format(SalesOrderExtension."Servify Bonus Amount" - PendingShieldAmt - ServiceCharges);
                        PendingShieldAmt := 0;
                    end
                    else begin
                        ArPayTypes[i, j] := Format(0);
                        ServiceCharges := 0;
                        PendingShieldAmt := PendingShieldAmt - SalesOrderExtension."Servify Bonus Amount";
                    end;
                end
                else
                    ArPayTypes[i, j] := Format(SalesOrderExtension."Servify Bonus Amount" - ((SalesOrderExtension."Servify Bonus Amount" * PaymentMethod."Service Charge Perc") / 100));
                j += 1;
                ArPayTypes[i, j] := PaymentMethod."Service Charge Account No."; //Service Charge A/c
                j += 1;
                ArPayTypes[i, j] := Format(ServiceCharges);//Service Charge Amount
                j += 1;
                ArPayTypes[i, j] := Format(PaymentMethod."Pay Type");
                i += 1;
            end;
        end;
        //Servify <- //KPPLDG00023

        //TK

        //20) Paytm -> //KPPLDG00033
        j := 1;
        SalesOrderExtension.Reset;
        if SalesOrderExtension.Get(salesHeader."Document Type", salesHeader."No.") then begin
            if (SalesOrderExtension.PaytmMethodCode <> '') and (SalesOrderExtension."Paytm Transfer Amount" <> 0) then begin
                PaymentMethod.Get(SalesOrderExtension.PaytmMethodCode);

                ArPayTypes[i, j] := PaymentMethod.Code;
                j += 1;
                ArPayTypes[i, j] := Format(PaymentMethod."Bal. Account Type");
                j += 1;
                ArPayTypes[i, j] := PaymentMethod."Bal. Account No.";
                j += 1;

                ServiceCharges := (SalesOrderExtension."Paytm Transfer Amount" * PaymentMethod."Service Charge Perc") / 100;
                if salesHeader.Shield and (salesHeader."Total Shield Value" <> 0) and (PendingShieldAmt <> 0) then begin
                    if SalesOrderExtension."Paytm Transfer Amount" > PendingShieldAmt then begin
                        ServiceCharges := ((SalesOrderExtension."Paytm Transfer Amount" - PendingShieldAmt) * PaymentMethod."Service Charge Perc") / 100;
                        ArPayTypes[i, j] := Format(SalesOrderExtension."Paytm Transfer Amount" - ServiceCharges); //- PendingShieldAmt KPPL LM
                        PendingShieldAmt := 0;
                    end
                    else begin
                        ArPayTypes[i, j] := Format(0);
                        ServiceCharges := 0;
                        PendingShieldAmt := PendingShieldAmt - SalesOrderExtension."Paytm Transfer Amount";
                    end;
                end
                else
                    ArPayTypes[i, j] := Format(SalesOrderExtension."Paytm Transfer Amount" - ((SalesOrderExtension."Paytm Transfer Amount" * PaymentMethod."Service Charge Perc") / 100));
                j += 1;
                ArPayTypes[i, j] := PaymentMethod."Service Charge Account No."; //Service Charge A/c
                j += 1;
                ArPayTypes[i, j] := Format(ServiceCharges);//Service Charge Amount
                j += 1;
                ArPayTypes[i, j] := Format(PaymentMethod."Pay Type");
                i += 1;
            end;
        end;
        //Paytm <- //KPPLDG00033

        //Loyalty Riwardz++++++++++++++++++++++++++++++++++Win-234 +++++++
        j := 1;
        if (salesHeader."Loyalty Riwardz Method Code" <> '') and (salesHeader."Loyalty Riwardz Tr.Amount" <> 0) then begin
            PaymentMethod.Get(salesHeader."Loyalty Riwardz Method Code");
            //MESSAGE('Finance');
            ArPayTypes[i, j] := PaymentMethod.Code;
            j += 1;
            ArPayTypes[i, j] := Format(PaymentMethod."Bal. Account Type");
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Bal. Account No.";
            j += 1;

            ServiceCharges := (salesHeader."Loyalty Riwardz Tr.Amount" * PaymentMethod."Service Charge Perc") / 100;
            if salesHeader.Shield and (salesHeader."Total Shield Value" <> 0) and (PendingShieldAmt <> 0) then begin
                if salesHeader."Loyalty Riwardz Tr.Amount" > PendingShieldAmt then begin
                    ServiceCharges := ((salesHeader."Loyalty Riwardz Tr.Amount" - PendingShieldAmt) * PaymentMethod."Service Charge Perc") / 100;
                    ArPayTypes[i, j] := Format(salesHeader."Loyalty Riwardz Tr.Amount" - PendingShieldAmt - ServiceCharges);
                    PendingShieldAmt := 0;
                end
                else begin
                    ArPayTypes[i, j] := Format(0);
                    ServiceCharges := 0;
                    PendingShieldAmt := PendingShieldAmt - salesHeader."Loyalty Riwardz Tr.Amount";
                end;

            end
            else
                ArPayTypes[i, j] := Format(salesHeader."Loyalty Riwardz Tr.Amount" - ((salesHeader."Loyalty Riwardz Tr.Amount" * PaymentMethod."Service Charge Perc") / 100));
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Service Charge Account No.";
            j += 1;//Service Charge A/c
            ArPayTypes[i, j] := Format(ServiceCharges);
            j += 1;//Service Charge Amount
            ArPayTypes[i, j] := Format(PaymentMethod."Pay Type");
            i += 1;
        end;
        //----------------------------------Win-234 -------
        //WIN316--

    end;

    procedure MakePurchaseInvoice(SalesHeader: Record 36; RefInvoiceNo: Code[20])
    var
        PurchSetup: Record 312;
        PurchHeader: Record 38;
        PurchLine: Record 39;
        BuybackVendor: Code[20];
        PurchOrderheader: Record 38;
        PurchOrderLine: Record 39;
    begin
        /*
PurchHeader.RESET;
PurchHeader.SETFILTER("Retail Buyback Ref. No.",SalesHeader."No.");
IF PurchHeader.FINDFIRST THEN BEGIN
  PurchHeader.VALIDATE("Posting Date",SalesHeader."Posting Date");
  PurchHeader.VALIDATE("Order Date",SalesHeader."Order Date");
  PurchHeader."Retail Sale Invoice Ref. No." := RefInvoiceNo;
  PurchHeader.VALIDATE("Location Code","Inward Location" );
  PurchHeader.MODIFY;
END;
*/
        PurchSetup.GET;
        IF PurchSetup."Invoice Nos." = '' THEN
            ERROR('Purchase Invoice No. series not defined on Purchase & Payable setup');
        IF PurchSetup."Posted Invoice Nos." = '' THEN
            ERROR('Purchase Posted Invoice No. series not defined on Purchase & Payable setup');

        SalesHeader."Posting No." := NoSeriesMgt.GetNextNo(PurchSetup."Invoice Nos.", SalesHeader."Posting Date", TRUE);
        BuybackVendor := PurchSetup."Buyback Vendor";
        IF BuybackVendor = '' THEN
            ERROR('Define Buyback Vendor on Purchase & Payable Setup');
        PurchHeader.INIT;
        PurchHeader."Document Type" := PurchHeader."Document Type"::Invoice;
        PurchHeader.VALIDATE("Buy-from Vendor No.", BuybackVendor);
        PurchHeader.VALIDATE("Pay-to Vendor No.", BuybackVendor);
        PurchHeader."Buy-from Vendor Name" := SalesHeader."Sell-to Customer Name";
        PurchHeader."No." := SalesHeader."Posting No.";
        PurchHeader.VALIDATE("Posting Date", SalesHeader."Posting Date");
        PurchHeader.VALIDATE("Order Date", SalesHeader."Order Date");
        PurchHeader."Retail Sale Invoice Ref. No." := RefInvoiceNo;
        PurchHeader."Posting No. Series" := PurchSetup."Posted Invoice Nos.";
        // StruHeader.GET('VT+ST(PIT)');//tk
        // PurchHeader.VALIDATE(Structure, 'VT+ST(PIT)');//tk
        PurchHeader.VALIDATE("Location Code", SalesHeader."Inward Location");
        // PurchHeader."Applies-to Doc. Type":="Applies-to Doc. Type"::Invoice;
        // PurchHeader."Applies-to Doc. No." := RefInvoiceNo;
        IF PurchHeader."No." <> '' THEN BEGIN
            PurchHeader.INSERT;
            PurchOrderLine.RESET;
            PurchOrderLine.SETRANGE(PurchOrderLine."Document Type", PurchOrderLine."Document Type"::Order);
            PurchOrderLine.SETFILTER("Retail Buyback Ref. No.", '%1', SalesHeader."No.");
            IF PurchOrderLine.FINDFIRST THEN BEGIN
                REPEAT
                    IF PurchOrderLine."No." <> '' THEN BEGIN
                        PurchLine.INIT;
                        PurchLine."Document Type" := PurchHeader."Document Type";
                        PurchLine."Document No." := PurchHeader."No.";
                        PurchLine."Line No." := PurchOrderLine."Line No.";
                        PurchLine.Type := PurchLine.Type::Item;
                        PurchLine.VALIDATE("No.", PurchOrderLine."No.");
                        PurchLine.VALIDATE("IMEI No.", PurchOrderLine."IMEI No.");
                        PurchLine.VALIDATE(Quantity, PurchOrderLine.Quantity);
                        //PurchLine.VALIDATE("Direct Unit Cost","Maple Buyback Amt");
                        IF PurchLine."VAT %" <> 0 THEN
                            PurchLine.VALIDATE("Direct Unit Cost", (PurchOrderLine."Direct Unit Cost" * 100) / (100 + PurchLine."VAT %"))
                        ELSE
                            PurchLine.VALIDATE("Direct Unit Cost", PurchOrderLine."Direct Unit Cost");
                        PurchLine."Location Code" := SalesHeader."Inward Location";
                        PurchLine.DeletePurchSpecification(PurchLine);
                        PurchLine.VALIDATE("Item Serial No", PurchOrderLine."Item Serial No");
                        PurchLine.VALIDATE("IMEI No.", PurchOrderLine."IMEI No.");
                        PurchLine.INSERT;
                    END;
                UNTIL PurchOrderLine.NEXT = 0;
            END;
            // StruHeader.GET('VT+ST(PIT)');//tk
            // PurchHeader.VALIDATE(Structure, 'VT+ST(PIT)');//tk
            PurchHeader.MODIFY;
        END;

    end;


    procedure GetShieldPaymentDetails(salesHeader: Record "Sales Header")
    var
        TotalAfterShield: Decimal;
        PendingShieldAmt: Decimal;
        ServiceCharges: Decimal;
    begin
        TotalAfterShield := 0;
        salesHeader.CalcFields(Shield);
        salesHeader.CalcFields("Total Shield Value");

        i := 0;
        j := 0;
        for i := 1 to 20 do begin //KPPLDG00033 changed from 19 to 20
            for j := 1 to 11 do begin //KPPLDG00033 changed from 10 to 11
                ArPayTypes[i, j] := '';
            end;
        end;

        i := 1;
        j := 1;
        PendingShieldAmt := salesHeader."Total Shield Value";
        if (salesHeader."CashPay Method Code" <> '') and (salesHeader.PayByCashAmt <> 0) and (PendingShieldAmt <> 0) then begin
            //MESSAGE('Cash');
            PaymentMethod.Get(salesHeader."CashPay Method Code");
            ArPayTypes[i, j] := PaymentMethod.Code;
            j += 1;
            ArPayTypes[i, j] := Format(PaymentMethod."Bal. Account Type");
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Bal. Account No.";
            j += 1;
            if PendingShieldAmt <> 0 then begin
                if salesHeader.PayByCashAmt > PendingShieldAmt then begin
                    ArPayTypes[i, j] := Format(PendingShieldAmt);
                    PendingShieldAmt := 0;
                end
                else begin
                    ArPayTypes[i, j] := Format(salesHeader.PayByCashAmt);
                    PendingShieldAmt := PendingShieldAmt - salesHeader.PayByCashAmt;
                end;
            end;
            j += 1;
            ArPayTypes[i, j] := '';
            j += 1;//Service Charge A/c;
            ArPayTypes[i, j] := '0';
            j += 1;//Service Charge Amount
            ArPayTypes[i, j] := Format(PaymentMethod."Pay Type");
            i += 1;
        end;
        j := 1;
        if (salesHeader."ChqPay Method Code" <> '') and (salesHeader.PayByChqAmt <> 0) and (PendingShieldAmt <> 0) then begin
            PaymentMethod.Get(salesHeader."ChqPay Method Code");
            //MESSAGE('Chq');
            ArPayTypes[i, j] := PaymentMethod.Code;
            j += 1;
            ArPayTypes[i, j] := Format(PaymentMethod."Bal. Account Type");
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Bal. Account No.";
            j += 1;
            if PendingShieldAmt <> 0 then begin
                if salesHeader.PayByChqAmt > PendingShieldAmt then begin
                    ArPayTypes[i, j] := Format(PendingShieldAmt);
                    PendingShieldAmt := 0;
                end
                else begin
                    ArPayTypes[i, j] := Format(salesHeader.PayByChqAmt);
                    PendingShieldAmt := PendingShieldAmt - salesHeader.PayByChqAmt;
                end;
            end;
            j += 1;
            ArPayTypes[i, j] := '';
            j += 1;//Service Charge A/c;
            ArPayTypes[i, j] := '0';
            j += 1;//Service Charge Amount
            ArPayTypes[i, j] := Format(PaymentMethod."Pay Type");
            i += 1;
        end;

        j := 1;
        if (salesHeader."CreditCdPay Method Code1" <> '') and (salesHeader.PayByCreditAmt1 <> 0) and (PendingShieldAmt <> 0) then begin
            //MESSAGE('Credit1');
            PaymentMethod.Get(salesHeader."CreditCdPay Method Code1");
            ArPayTypes[i, j] := PaymentMethod.Code;
            j += 1;
            ArPayTypes[i, j] := Format(PaymentMethod."Bal. Account Type");
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Bal. Account No.";
            j += 1;
            ServiceCharges := 0;
            if PendingShieldAmt <> 0 then begin
                if salesHeader.PayByCreditAmt1 > PendingShieldAmt then begin
                    ServiceCharges := (PendingShieldAmt * PaymentMethod."Service Charge Perc") / 100;
                    ArPayTypes[i, j] := Format(PendingShieldAmt - ServiceCharges);
                    PendingShieldAmt := 0;
                end
                else begin
                    ServiceCharges := (salesHeader.PayByCreditAmt1 * PaymentMethod."Service Charge Perc") / 100;
                    ArPayTypes[i, j] := Format(salesHeader.PayByCreditAmt1 - ServiceCharges);
                    PendingShieldAmt := PendingShieldAmt - salesHeader.PayByCreditAmt1;
                end;
            end;
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Service Charge Account No.";
            j += 1;//Service Charge A/c
            ArPayTypes[i, j] := Format(ServiceCharges);
            j += 1;//Service Charge Amount
            ArPayTypes[i, j] := Format(PaymentMethod."Pay Type");
            i += 1;
        end;
        j := 1;
        if (salesHeader."CreditCdPay Method Code2" <> '') and (salesHeader.PayByCreditAmt2 <> 0) and (PendingShieldAmt <> 0) then begin
            PaymentMethod.Get(salesHeader."CreditCdPay Method Code2");
            //MESSAGE('Credit2');
            ArPayTypes[i, j] := PaymentMethod.Code;
            j += 1;
            ArPayTypes[i, j] := Format(PaymentMethod."Bal. Account Type");
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Bal. Account No.";
            j += 1;
            ServiceCharges := 0;
            if PendingShieldAmt <> 0 then begin
                if salesHeader.PayByCreditAmt2 > PendingShieldAmt then begin
                    ServiceCharges := (PendingShieldAmt * PaymentMethod."Service Charge Perc") / 100;
                    ArPayTypes[i, j] := Format(PendingShieldAmt - ServiceCharges);
                    PendingShieldAmt := 0;
                end
                else begin
                    ServiceCharges := (salesHeader.PayByCreditAmt2 * PaymentMethod."Service Charge Perc") / 100;
                    ArPayTypes[i, j] := Format(salesHeader.PayByCreditAmt2 - ServiceCharges);
                    PendingShieldAmt := PendingShieldAmt - salesHeader.PayByCreditAmt2;
                end;
                /// END;
            end;
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Service Charge Account No.";
            j += 1;//Service Charge A/c
            ArPayTypes[i, j] := Format(ServiceCharges);
            j += 1;//Service Charge Amount
            ArPayTypes[i, j] := Format(PaymentMethod."Pay Type");
            i += 1;
        end;
        j := 1;
        if (salesHeader."CreditCdPay Method Code3" <> '') and (salesHeader.PayByCreditAmt3 <> 0) and (PendingShieldAmt <> 0) then begin
            PaymentMethod.Get(salesHeader."CreditCdPay Method Code3");
            //MESSAGE('Credit3');
            ArPayTypes[i, j] := PaymentMethod.Code;
            j += 1;
            ArPayTypes[i, j] := Format(PaymentMethod."Bal. Account Type");
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Bal. Account No.";
            j += 1;
            ServiceCharges := 0;
            ServiceCharges := 0;
            if PendingShieldAmt <> 0 then begin
                if salesHeader.PayByCreditAmt3 > PendingShieldAmt then begin
                    ServiceCharges := (PendingShieldAmt * PaymentMethod."Service Charge Perc") / 100;
                    ArPayTypes[i, j] := Format(PendingShieldAmt - ServiceCharges);
                    PendingShieldAmt := 0;
                end
                else begin
                    ServiceCharges := (salesHeader.PayByCreditAmt3 * PaymentMethod."Service Charge Perc") / 100;
                    ArPayTypes[i, j] := Format(salesHeader.PayByCreditAmt3 - ServiceCharges);
                    PendingShieldAmt := PendingShieldAmt - (salesHeader.PayByCreditAmt3);
                end;
            end;
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Service Charge Account No.";
            j += 1;//Service Charge A/c
            ArPayTypes[i, j] := Format(ServiceCharges);
            j += 1;//Service Charge Amount
            ArPayTypes[i, j] := Format(PaymentMethod."Pay Type");
            i += 1;
        end;
        j := 1;
        if (salesHeader."CreditCdPay Method Code4" <> '') and (salesHeader.PayByCreditAmt4 <> 0) and (PendingShieldAmt <> 0) then begin
            //MESSAGE('Credit4');
            PaymentMethod.Get(salesHeader."CreditCdPay Method Code4");
            ArPayTypes[i, j] := PaymentMethod.Code;
            j += 1;
            ArPayTypes[i, j] := Format(PaymentMethod."Bal. Account Type");
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Bal. Account No.";
            j += 1;
            ServiceCharges := 0;
            if PendingShieldAmt <> 0 then begin
                if salesHeader.PayByCreditAmt4 > PendingShieldAmt then begin
                    ServiceCharges := (PendingShieldAmt * PaymentMethod."Service Charge Perc") / 100;
                    ArPayTypes[i, j] := Format(PendingShieldAmt - ServiceCharges);
                    PendingShieldAmt := 0;
                end
                else begin
                    ServiceCharges := (salesHeader.PayByCreditAmt4 * PaymentMethod."Service Charge Perc") / 100;
                    ArPayTypes[i, j] := Format(salesHeader.PayByCreditAmt4 - ServiceCharges);
                    PendingShieldAmt := PendingShieldAmt - salesHeader.PayByCreditAmt4;
                end;
            end;
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Service Charge Account No.";
            j += 1;//Service Charge A/c
            ArPayTypes[i, j] := Format(ServiceCharges);
            j += 1;//Service Charge Amount
            ArPayTypes[i, j] := Format(PaymentMethod."Pay Type");
            i += 1;
        end;

        j := 1;
        if (salesHeader."DebitCdPay Method Code1" <> '') and (salesHeader.PayByDebitCdAmt1 <> 0) and (PendingShieldAmt <> 0) then begin
            ///MESSAGE('Debit');
            PaymentMethod.Get(salesHeader."DebitCdPay Method Code1");
            ArPayTypes[i, j] := PaymentMethod.Code;
            j += 1;
            ArPayTypes[i, j] := Format(PaymentMethod."Bal. Account Type");
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Bal. Account No.";
            j += 1;
            ServiceCharges := 0;
            if PendingShieldAmt <> 0 then begin
                if salesHeader.PayByDebitCdAmt1 > PendingShieldAmt then begin
                    ServiceCharges := (PendingShieldAmt * PaymentMethod."Service Charge Perc") / 100;
                    ArPayTypes[i, j] := Format(PendingShieldAmt - ServiceCharges);
                    PendingShieldAmt := 0;
                end
                else begin
                    ServiceCharges := (salesHeader.PayByDebitCdAmt1 * PaymentMethod."Service Charge Perc") / 100;
                    ArPayTypes[i, j] := Format(salesHeader.PayByDebitCdAmt1 - ServiceCharges);
                    PendingShieldAmt := PendingShieldAmt - salesHeader.PayByDebitCdAmt1;
                end;
            end;
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Service Charge Account No.";
            j += 1;//Service Charge A/c;
            ArPayTypes[i, j] := Format(ServiceCharges);
            j += 1;//Service Charge Amount
            ArPayTypes[i, j] := Format(PaymentMethod."Pay Type");
            i += 1;
        end;

        j := 1;
        if (salesHeader."DebitCdPay Method Code2" <> '') and (salesHeader.PayByDebitAmt2 <> 0) and (PendingShieldAmt <> 0) then begin
            //MESSAGE('Credit4');
            PaymentMethod.Get(salesHeader."DebitCdPay Method Code2");
            ArPayTypes[i, j] := PaymentMethod.Code;
            j += 1;
            ArPayTypes[i, j] := Format(PaymentMethod."Bal. Account Type");
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Bal. Account No.";
            j += 1;
            ServiceCharges := 0;
            if PendingShieldAmt <> 0 then begin
                if salesHeader.PayByDebitAmt2 > PendingShieldAmt then begin
                    ServiceCharges := (PendingShieldAmt * PaymentMethod."Service Charge Perc") / 100;
                    ArPayTypes[i, j] := Format(PendingShieldAmt - ServiceCharges);
                    PendingShieldAmt := 0;
                end
                else begin
                    ServiceCharges := (salesHeader.PayByDebitAmt2 * PaymentMethod."Service Charge Perc") / 100;
                    ArPayTypes[i, j] := Format(salesHeader.PayByDebitAmt2 - ServiceCharges);
                    PendingShieldAmt := PendingShieldAmt - salesHeader.PayByDebitAmt2;
                end;
            end;
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Service Charge Account No.";
            j += 1;//Service Charge A/c
            ArPayTypes[i, j] := Format(ServiceCharges);
            j += 1;//Service Charge Amount
            ArPayTypes[i, j] := Format(PaymentMethod."Pay Type");
            i += 1;
        end;


        j := 1;
        if (salesHeader."GiftPay Method Code" <> '') and (salesHeader.GiftVoucherAmt <> 0) and (PendingShieldAmt <> 0) then begin
            PaymentMethod.Get(salesHeader."GiftPay Method Code");
            //MESSAGE('Gift');
            ArPayTypes[i, j] := PaymentMethod.Code;
            j += 1;
            ArPayTypes[i, j] := Format(PaymentMethod."Bal. Account Type");
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Bal. Account No.";
            j += 1;
            if PendingShieldAmt <> 0 then begin
                if salesHeader.GiftVoucherAmt > PendingShieldAmt then begin
                    ArPayTypes[i, j] := Format(PendingShieldAmt);
                    PendingShieldAmt := 0;
                end
                else begin
                    ArPayTypes[i, j] := Format(salesHeader.GiftVoucherAmt);
                    PendingShieldAmt := PendingShieldAmt - salesHeader.GiftVoucherAmt;
                end;
            end;
            j += 1;
            ArPayTypes[i, j] := '';
            j += 1;//Service Charge A/c;
            ArPayTypes[i, j] := '0';
            j += 1;//Service Charge Amount
            ArPayTypes[i, j] := Format(PaymentMethod."Pay Type");
            i += 1;
        end;
        j := 1;
        if (salesHeader."RTGSPay Method Code" <> '') and (salesHeader."RTGS Amount" <> 0) and (PendingShieldAmt <> 0) then begin
            PaymentMethod.Get(salesHeader."RTGSPay Method Code");
            //MESSAGE('RTGS');
            ArPayTypes[i, j] := PaymentMethod.Code;
            j += 1;
            ArPayTypes[i, j] := Format(PaymentMethod."Bal. Account Type");
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Bal. Account No.";
            j += 1;
            if PendingShieldAmt <> 0 then begin
                if salesHeader."RTGS Amount" > PendingShieldAmt then begin
                    ArPayTypes[i, j] := Format(PendingShieldAmt);
                    PendingShieldAmt := 0;
                end
                else begin
                    ArPayTypes[i, j] := Format(salesHeader."RTGS Amount");
                    PendingShieldAmt := PendingShieldAmt - salesHeader."RTGS Amount";
                end;
            end;
            j += 1;
            ArPayTypes[i, j] := '';
            j += 1;//Service Charge A/c;
            ArPayTypes[i, j] := '0';
            j += 1;//Service Charge Amount
            ArPayTypes[i, j] := Format(PaymentMethod."Pay Type");
            i += 1;
        end;
        j := 1;
        if (salesHeader."FinPay Method Code" <> '') and (salesHeader."Finance Amount" <> 0) and (PendingShieldAmt <> 0) then begin
            PaymentMethod.Get(salesHeader."FinPay Method Code");
            //MESSAGE('Finance');
            ArPayTypes[i, j] := PaymentMethod.Code;
            j += 1;
            ArPayTypes[i, j] := Format(PaymentMethod."Bal. Account Type");
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Bal. Account No.";
            j += 1;
            ServiceCharges := 0;
            if PendingShieldAmt <> 0 then begin
                if salesHeader."Finance Amount" > PendingShieldAmt then begin
                    ServiceCharges := (PendingShieldAmt * PaymentMethod."Service Charge Perc") / 100;
                    ArPayTypes[i, j] := Format(PendingShieldAmt - ServiceCharges);
                    PendingShieldAmt := 0;
                end
                else begin
                    ServiceCharges := (salesHeader."Finance Amount" * PaymentMethod."Service Charge Perc") / 100;
                    ArPayTypes[i, j] := Format(salesHeader."Finance Amount" - ServiceCharges);
                    PendingShieldAmt := PendingShieldAmt - salesHeader."Finance Amount";
                end;
            end;
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Service Charge Account No.";
            j += 1;//Service Charge A/c
            ArPayTypes[i, j] := Format(ServiceCharges);
            j += 1;//Service Charge Amount
            ArPayTypes[i, j] := Format(PaymentMethod."Pay Type");
            i += 1;
        end;
        /*
        j := 1;
        IF ("Apple Refund Method Code" <> '') AND ("Apple Refund Amt"<>0) AND (PendingShieldAmt <> 0) THEN BEGIN
          PaymentMethod.GET("Apple Refund Method Code");
          ArPayTypes[i,j] := PaymentMethod.Code;  j+=1;
          ArPayTypes[i,j] := FORMAT(PaymentMethod."Bal. Account Type"); j+=1;
          ArPayTypes[i,j] := PaymentMethod."Bal. Account No."; j+=1;
             IF PendingShieldAmt <> 0 THEN BEGIN
              IF "Apple Refund Amt" > PendingShieldAmt THEN BEGIN
                ArPayTypes[i,j] := FORMAT(PendingShieldAmt);
                PendingShieldAmt := 0;
              END
              ELSE BEGIN
                ArPayTypes[i,j] := FORMAT("Apple Refund Amt");
                PendingShieldAmt := PendingShieldAmt - "Apple Refund Amt";
              END;
            END;
          j+=1;
          ArPayTypes[i,j] := '';j+=1;//Service Charge A/c;
          ArPayTypes[i,j] := '0'; j+=1;//Service Charge Amount
          ArPayTypes[i,j] := FORMAT(PaymentMethod."Pay Type");i+=1;
      //MESSAGE('Refund');
         END;
          */
        //paytm
        j := 1;
        if (salesHeader.paytmMethodCode <> '') and (salesHeader."Paytm Transfer Amount" <> 0) and (PendingShieldAmt <> 0) then begin
            PaymentMethod.Get(salesHeader.paytmMethodCode);
            //MESSAGE('Finance');
            ArPayTypes[i, j] := PaymentMethod.Code;
            j += 1;
            ArPayTypes[i, j] := Format(PaymentMethod."Bal. Account Type");
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Bal. Account No.";
            j += 1;
            ServiceCharges := 0;
            if PendingShieldAmt <> 0 then begin
                if salesHeader."Paytm Transfer Amount" > PendingShieldAmt then begin
                    ServiceCharges := (PendingShieldAmt * PaymentMethod."Service Charge Perc") / 100;
                    ArPayTypes[i, j] := Format(PendingShieldAmt - ServiceCharges);
                    PendingShieldAmt := 0;
                end
                else begin
                    ServiceCharges := (salesHeader."Paytm Transfer Amount" * PaymentMethod."Service Charge Perc") / 100;
                    ArPayTypes[i, j] := Format(salesHeader."Paytm Transfer Amount" - ServiceCharges);
                    PendingShieldAmt := PendingShieldAmt - salesHeader."Paytm Transfer Amount";
                end;
            end;
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Service Charge Account No.";
            j += 1;//Service Charge A/c
            ArPayTypes[i, j] := Format(ServiceCharges);
            j += 1;//Service Charge Amount
            ArPayTypes[i, j] := Format(PaymentMethod."Pay Type");
            i += 1;
        end;
        //ex
        j := 1;
        if (salesHeader.ExMethodCode <> '') and (salesHeader."Amazon Transfer Amount" <> 0) and (PendingShieldAmt <> 0) then begin
            PaymentMethod.Get(salesHeader.ExMethodCode);
            //MESSAGE('Finance');
            ArPayTypes[i, j] := PaymentMethod.Code;
            j += 1;
            ArPayTypes[i, j] := Format(PaymentMethod."Bal. Account Type");
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Bal. Account No.";
            j += 1;
            ServiceCharges := 0;
            if PendingShieldAmt <> 0 then begin
                if salesHeader."Amazon Transfer Amount" > PendingShieldAmt then begin
                    ServiceCharges := (PendingShieldAmt * PaymentMethod."Service Charge Perc") / 100;
                    ArPayTypes[i, j] := Format(PendingShieldAmt - ServiceCharges);
                    PendingShieldAmt := 0;
                end
                else begin
                    ServiceCharges := (salesHeader."Amazon Transfer Amount" * PaymentMethod."Service Charge Perc") / 100;
                    ArPayTypes[i, j] := Format(salesHeader."Amazon Transfer Amount" - ServiceCharges);
                    PendingShieldAmt := PendingShieldAmt - salesHeader."Amazon Transfer Amount";
                end;
            end;
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Service Charge Account No.";
            j += 1;//Service Charge A/c
            ArPayTypes[i, j] := Format(ServiceCharges);
            j += 1;//Service Charge Amount
            ArPayTypes[i, j] := Format(PaymentMethod."Pay Type");
            i += 1;
        end;

        //INSURANCE
        j := 1;
        if (salesHeader.InsuranceMethodCode <> '') and (salesHeader."Insurance Transfer Amount" <> 0) and (PendingShieldAmt <> 0) then begin
            PaymentMethod.Get(salesHeader.InsuranceMethodCode);
            //MESSAGE('Finance');
            ArPayTypes[i, j] := PaymentMethod.Code;
            j += 1;
            ArPayTypes[i, j] := Format(PaymentMethod."Bal. Account Type");
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Bal. Account No.";
            j += 1;
            ServiceCharges := 0;
            if PendingShieldAmt <> 0 then begin
                if salesHeader."Insurance Transfer Amount" > PendingShieldAmt then begin
                    ServiceCharges := (PendingShieldAmt * PaymentMethod."Service Charge Perc") / 100;
                    ArPayTypes[i, j] := Format(PendingShieldAmt - ServiceCharges);
                    PendingShieldAmt := 0;
                end
                else begin
                    ServiceCharges := (salesHeader."Insurance Transfer Amount" * PaymentMethod."Service Charge Perc") / 100;
                    ArPayTypes[i, j] := Format(salesHeader."Insurance Transfer Amount" - ServiceCharges);
                    PendingShieldAmt := PendingShieldAmt - salesHeader."Insurance Transfer Amount";
                end;
            end;
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Service Charge Account No.";
            j += 1;//Service Charge A/c
            ArPayTypes[i, j] := Format(ServiceCharges);
            j += 1;//Service Charge Amount
            ArPayTypes[i, j] := Format(PaymentMethod."Pay Type");
            i += 1;
        end;
        //Cashify
        j := 1;
        if (salesHeader.CashifyMethodCode <> '') and (salesHeader."Cashify Transfer Amount" <> 0) and (PendingShieldAmt <> 0) then begin
            PaymentMethod.Get(salesHeader.CashifyMethodCode);
            //MESSAGE('Finance');
            ArPayTypes[i, j] := PaymentMethod.Code;
            j += 1;
            ArPayTypes[i, j] := Format(PaymentMethod."Bal. Account Type");
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Bal. Account No.";
            j += 1;
            ServiceCharges := 0;
            if PendingShieldAmt <> 0 then begin
                if salesHeader."Cashify Transfer Amount" > PendingShieldAmt then begin
                    ServiceCharges := (PendingShieldAmt * PaymentMethod."Service Charge Perc") / 100;
                    ArPayTypes[i, j] := Format(PendingShieldAmt - ServiceCharges);
                    PendingShieldAmt := 0;
                end
                else begin
                    ServiceCharges := (salesHeader."Cashify Transfer Amount" * PaymentMethod."Service Charge Perc") / 100;
                    ArPayTypes[i, j] := Format(salesHeader."Cashify Transfer Amount" - ServiceCharges);
                    PendingShieldAmt := PendingShieldAmt - salesHeader."Cashify Transfer Amount";
                end;
            end;
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Service Charge Account No.";
            j += 1;//Service Charge A/c
            ArPayTypes[i, j] := Format(ServiceCharges);
            j += 1;//Service Charge Amount
            ArPayTypes[i, j] := Format(PaymentMethod."Pay Type");
            i += 1;
        end;

        //++++++++++++++++++++++++++++++++++++++++++++++++++++
        //Loyality Riwardz Win-234++
        j := 1;
        if (salesHeader."Loyalty Riwardz Method Code" <> '') and (salesHeader."Loyalty Riwardz Tr.Amount" <> 0) and (PendingShieldAmt <> 0) then begin
            PaymentMethod.Get(salesHeader."Loyalty Riwardz Method Code");
            //MESSAGE('Finance');
            ArPayTypes[i, j] := PaymentMethod.Code;
            j += 1;
            ArPayTypes[i, j] := Format(PaymentMethod."Bal. Account Type");
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Bal. Account No.";
            j += 1;
            ServiceCharges := 0;
            if PendingShieldAmt <> 0 then begin
                if salesHeader."Loyalty Riwardz Tr.Amount" > PendingShieldAmt then begin
                    ServiceCharges := (PendingShieldAmt * PaymentMethod."Service Charge Perc") / 100;
                    ArPayTypes[i, j] := Format(PendingShieldAmt - ServiceCharges);
                    PendingShieldAmt := 0;
                end
                else begin
                    ServiceCharges := (salesHeader."Loyalty Riwardz Tr.Amount" * PaymentMethod."Service Charge Perc") / 100;
                    ArPayTypes[i, j] := Format(salesHeader."Loyalty Riwardz Tr.Amount" - ServiceCharges);
                    PendingShieldAmt := PendingShieldAmt - salesHeader."Loyalty Riwardz Tr.Amount";
                end;
            end;
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Service Charge Account No.";
            j += 1;//Service Charge A/c
            ArPayTypes[i, j] := Format(ServiceCharges);
            j += 1;//Service Charge Amount
            ArPayTypes[i, j] := Format(PaymentMethod."Pay Type");
            i += 1;
        end;
        //Loyality Riwardz Win-234--

        //----------------------------------------------------

        //Servify -> KPPLDG00023
        j := 1;
        SalesOrderExtension.Reset;
        if SalesOrderExtension.Get(salesHeader."Document Type", salesHeader."No.") then begin
            if (SalesOrderExtension.ServifyMethodCode <> '') and (SalesOrderExtension."Servify Transfer Amount" <> 0) and (PendingShieldAmt <> 0) then begin
                PaymentMethod.Get(SalesOrderExtension.ServifyMethodCode);

                ArPayTypes[i, j] := PaymentMethod.Code;
                j += 1;
                ArPayTypes[i, j] := Format(PaymentMethod."Bal. Account Type");
                j += 1;
                ArPayTypes[i, j] := PaymentMethod."Bal. Account No.";
                j += 1;

                ServiceCharges := 0;
                if PendingShieldAmt <> 0 then begin
                    if SalesOrderExtension."Servify Transfer Amount" > PendingShieldAmt then begin
                        ServiceCharges := (PendingShieldAmt * PaymentMethod."Service Charge Perc") / 100;
                        ArPayTypes[i, j] := Format(PendingShieldAmt - ServiceCharges);
                        PendingShieldAmt := 0;
                    end
                    else begin
                        ServiceCharges := (SalesOrderExtension."Servify Transfer Amount" * PaymentMethod."Service Charge Perc") / 100;
                        ArPayTypes[i, j] := Format(SalesOrderExtension."Servify Transfer Amount" - ServiceCharges);
                        PendingShieldAmt := PendingShieldAmt - SalesOrderExtension."Servify Transfer Amount";
                    end;
                end;
                j += 1;
                ArPayTypes[i, j] := PaymentMethod."Service Charge Account No."; //Service Charge A/c
                j += 1;
                ArPayTypes[i, j] := Format(ServiceCharges);//Service Charge Amount
                j += 1;
                ArPayTypes[i, j] := Format(PaymentMethod."Pay Type");
                i += 1;
            end;
        end;
        //Servify <- KPPLDG00023

        //Paytm -> KPPLDG00033
        j := 1;
        SalesOrderExtension.Reset;
        if SalesOrderExtension.Get(salesHeader."Document Type", salesHeader."No.") then begin
            if (SalesOrderExtension.PaytmMethodCode <> '') and (SalesOrderExtension."Paytm Transfer Amount" <> 0) and (PendingShieldAmt <> 0) then begin
                PaymentMethod.Get(SalesOrderExtension.PaytmMethodCode);

                ArPayTypes[i, j] := PaymentMethod.Code;
                j += 1;
                ArPayTypes[i, j] := Format(PaymentMethod."Bal. Account Type");
                j += 1;
                ArPayTypes[i, j] := PaymentMethod."Bal. Account No.";
                j += 1;

                ServiceCharges := 0;
                if PendingShieldAmt <> 0 then begin
                    if SalesOrderExtension."Paytm Transfer Amount" > PendingShieldAmt then begin
                        ServiceCharges := (PendingShieldAmt * PaymentMethod."Service Charge Perc") / 100;
                        ArPayTypes[i, j] := Format(PendingShieldAmt - ServiceCharges);
                        PendingShieldAmt := 0;
                    end
                    else begin
                        ServiceCharges := (SalesOrderExtension."Paytm Transfer Amount" * PaymentMethod."Service Charge Perc") / 100;
                        ArPayTypes[i, j] := Format(SalesOrderExtension."Paytm Transfer Amount" - ServiceCharges);
                        PendingShieldAmt := PendingShieldAmt - SalesOrderExtension."Paytm Transfer Amount";
                    end;
                end;
                j += 1;
                ArPayTypes[i, j] := PaymentMethod."Service Charge Account No."; //Service Charge A/c
                j += 1;
                ArPayTypes[i, j] := Format(ServiceCharges);//Service Charge Amount
                j += 1;
                ArPayTypes[i, j] := Format(PaymentMethod."Pay Type");
                i += 1;
            end;
        end;
        //Paytm <- KPPLDG00033

        //Pinelab
        j := 1;
        if (salesHeader.PinelabMethodCode <> '') and (salesHeader."Pinelab Transfer Amount" <> 0) and (PendingShieldAmt <> 0) then begin
            PaymentMethod.Get(salesHeader.PinelabMethodCode);
            //MESSAGE('Finance');
            ArPayTypes[i, j] := PaymentMethod.Code;
            j += 1;
            ArPayTypes[i, j] := Format(PaymentMethod."Bal. Account Type");
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Bal. Account No.";
            j += 1;
            ServiceCharges := 0;
            if PendingShieldAmt <> 0 then begin
                if salesHeader."Pinelab Transfer Amount" > PendingShieldAmt then begin
                    ServiceCharges := (PendingShieldAmt * PaymentMethod."Service Charge Perc") / 100;
                    ArPayTypes[i, j] := Format(PendingShieldAmt - ServiceCharges);
                    PendingShieldAmt := 0;
                end
                else begin
                    ServiceCharges := (salesHeader."Pinelab Transfer Amount" * PaymentMethod."Service Charge Perc") / 100;
                    ArPayTypes[i, j] := Format(salesHeader."Cashify Transfer Amount" - ServiceCharges);
                    PendingShieldAmt := PendingShieldAmt - salesHeader."Pinelab Transfer Amount";
                end;
            end;
            j += 1;
            ArPayTypes[i, j] := PaymentMethod."Service Charge Account No.";
            j += 1;//Service Charge A/c
            ArPayTypes[i, j] := Format(ServiceCharges);
            j += 1;//Service Charge Amount
            ArPayTypes[i, j] := Format(PaymentMethod."Pay Type");
            i += 1;
        end;

    end;
    //CodeUnit80--
    //12 CodeUnit ++


    [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", 'OnAfterCopyCustLedgerEntryFromGenJnlLine', '', false, false)]
    local procedure OnAfterCopyCustLedgerEntryFromGenJnlLine(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line");
    begin
        CustLedgerEntry.Narration := GenJournalLine.Narration; //***Win 241
        //Message('%1|%2',CustLedgerEntry.Narration,GenJournalLine.Narration);
    end;
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeCustLedgEntryInsert', '', false, false)]
    // local procedure OnBeforeCustLedgEntryInsert(var CustLedgerEntry: Record "Cust. Ledger Entry"; var GenJournalLine: Record "Gen. Journal Line"; GLRegister: Record "G/L Register"; var TempDtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer"; var NextEntryNo: Integer);
    // begin
    //     CustLedgEntry.Narration := GenJnlLine.Narration; //***Win 241
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeVendLedgEntryInsert', '', false, false)]
    // local procedure OnBeforeVendLedgEntryInsert(var VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line"; GLRegister: Record "G/L Register");
    // begin
    //     VendorLedgerEntry.Narration := GenJnlLine.Narration;  //***win241
    // end;

    [EventSubscriber(ObjectType::Table, Database::"Vendor Ledger Entry", 'OnAfterCopyVendLedgerEntryFromGenJnlLine', '', True, false)]
    local procedure CopyFromGenJnlLine(var VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")

    var
    begin
        VendorLedgerEntry.Narration := GenJournalLine.Narration;  //***win241

    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnPostGLAccOnBeforeInsertGLEntry', '', false, false)]
    local procedure OnPostGLAccOnBeforeInsertGLEntry(var Sender: Codeunit "Gen. Jnl.-Post Line"; var GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry"; var IsHandled: Boolean; Balancing: Boolean);
    begin
        GLEntry.Narration := GenJournalLine.Narration;//*** WIN241//win352
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterPostGLAcc', '', false, false)]
    local procedure OnAfterPostGLAcc(var Sender: Codeunit "Gen. Jnl.-Post Line"; var GenJnlLine: Record "Gen. Journal Line"; var TempGLEntryBuf: Record "G/L Entry" temporary; var NextEntryNo: Integer; var NextTransactionNo: Integer; Balancing: Boolean; var GLEntry: Record "G/L Entry"; VATPostingSetup: Record "VAT Posting Setup");
    begin
        GLEntry.Narration := GenJnlLine.Narration;//*** WIN241//win352
    end;







    //12 CodeUnit ++

    //CodeUnit 414++

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnAfterReleaseSalesDoc', '', false, false)]
    local procedure OnAfterReleaseSalesDoc(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var LinesWereModified: Boolean);
    begin
        //updated Win349++
        IF (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) OR (SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice) THEN BEGIN
            IF SalesHeader."Credit Hold" THEN
                ERROR('Order is Hold for Credit Hold');
            IF SalesHeader."Discount Hold" THEN
                ERROR('Order is Hold for Discount Hold');
            IF SalesHeader."Credit Days Hold" THEN
                ERROR('Order is Hold for Credit Days Hold');
            IF SalesHeader."Overdue Hold" THEN
                ERROR('Order is Hold for Overdue Hold');
            IF SalesHeader."Price Hold" THEN
                ERROR('Order is Hold for Price Hold');
            IF SalesHeader."PDC Hold" THEN
                ERROR('Order is Hold for PDC Hold');
            IF SalesHeader."Group Credit Limit Hold" THEN
                ERROR('Order is Hold for Group Credit Limit Hold');
        END
        ELSE BEGIN
            SalesHeader."Credit Hold" := FALSE;
            SalesHeader."Discount Hold" := FALSE;
            SalesHeader."Credit Days Hold" := FALSE;
            SalesHeader."Overdue Hold" := FALSE;
            SalesHeader."Price Hold" := FALSE;
            SalesHeader."PDC Hold" := FALSE;
            SalesHeader."Group Credit Limit Hold" := FALSE;
        END;

        /*
        //Win127 Check for Holds if Approval is not set.
        IF "Credit Hold" THEN
          ERROR('Order is Hold for Credit Hold');
        IF "Discount Hold" THEN
          ERROR('Order is Hold for Discount Hold');
        IF "Credit Days Hold" THEN
          ERROR('Order is Hold for Credit Days Hold');
        IF "Overdue Hold" THEN
          ERROR('Order is Hold for Overdue Hold');
        IF "Price Hold" THEN
          ERROR('Order is Hold for Price Hold');
        IF "PDC Hold" THEN
          ERROR('Order is Hold for PDC Hold');
        */

        //updated Win349--

    end;

    //CodeUNit 5704++

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnBeforeInsertTransShptHeader', '', false, false)]
    local procedure OnBeforeInsertTransShptHeader(var TransShptHeader: Record "Transfer Shipment Header"; TransHeader: Record "Transfer Header"; CommitIsSuppressed: Boolean);

    begin
        TransShptHeader."ECom Order ID" := TransHeader."ECom Order ID";//win316
        TransShptHeader."Shipped By User ID" := TransHeader."Shipped By User ID";//WIN316
        TransShptHeader."Received By User ID" := TransHeader."Received By User ID";//WIN316
    end;


    //CodeUnit 5704--

    //CodeUnit 5705 ++


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforeInsertTransRcptHeader', '', false, false)]
    local procedure OnBeforeInsertTransRcptHeader(var TransRcptHeader: Record "Transfer Receipt Header"; TransHeader: Record "Transfer Header"; CommitIsSuppressed: Boolean; var Handled: Boolean);
    begin


        TransRcptHeader.VALIDATE("Shortcut Dimension 1 Code", TransHeader."Shortcut Dimension 1 Code");       //WIN362
        TransRcptHeader.VALIDATE("Shortcut Dimension 2 Code", TransHeader."Shortcut Dimension 2 Code");       //WIN362
        TransRcptHeader."ECom Order ID" := TransHeader."ECom Order ID";//win316
        TransRcptHeader."Shipped By User ID" := TransHeader."Shipped By User ID";//WIN316
        TransRcptHeader."Received By User ID" := TransHeader."Received By User ID";//WIN316
                                                                                   //TransRcptHeader."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
                                                                                   //TransRcptHeader."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforeInsertTransRcptLine', '', false, false)]
    local procedure OnBeforeInsertTransRcptLine(var TransRcptLine: Record "Transfer Receipt Line"; TransLine: Record "Transfer Line"; CommitIsSuppressed: Boolean; var IsHandled: Boolean; TransferReceiptHeader: Record "Transfer Receipt Header");
    begin
        //WIN362++
        //updated Win349++
        TransRcptLine.VALIDATE("Shortcut Dimension 1 Code", TransLine."Shortcut Dimension 1 Code");
        TransRcptLine.VALIDATE("Shortcut Dimension 2 Code", TransLine."Shortcut Dimension 2 Code");
        //updated Win349--
        //WIN362--
        //TransRcptLine."Shortcut Dimension 1 Code" := TransLine."Shortcut Dimension 1 Code";
        //TransRcptLine."Shortcut Dimension 2 Code" := TransLine."Shortcut Dimension 2 Code";
        //WIN362++
        //updated Win349++

        //Win127
        TransRcptLine."Primary category" := TransLine."Primary category";
        TransRcptLine."Secondary category" := TransLine."Secondary category";
        TransRcptLine."Third category" := TransLine."Third category";
        TransRcptLine."UPN Code" := TransLine."UPN Code";
        //
        //updated Win349--
        //WIN362--



    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforePostItemJournalLine', '', false, false)]
    local procedure OnBeforePostItemJournalLine1(var ItemJournalLine: Record "Item Journal Line"; TransferLine: Record "Transfer Line"; TransferReceiptHeader: Record "Transfer Receipt Header"; TransferReceiptLine: Record "Transfer Receipt Line"; CommitIsSuppressed: Boolean; TransLine: Record "Transfer Line"; PostedWhseRcptHeader: Record "Posted Whse. Receipt Header");
    begin
        ItemJournalLine."UPN Code" := TransferReceiptLine."UPN Code";//updated Win349       //WIN362
        ItemJournalLine.VALIDATE("Shortcut Dimension 1 Code", TransferReceiptLine."Shortcut Dimension 1 Code");//updated Win349  //WIN362
                                                                                                               //ItemJnlLine."Shortcut Dimension 1 Code" := TransRcptLine2."Shortcut Dimension 1 Code";
        ItemJournalLine.VALIDATE("Shortcut Dimension 2 Code", TransferReceiptLine."Shortcut Dimension 2 Code");//updated Win349  //WIN362
                                                                                                               //ItemJnlLine."Shortcut Dimension 2 Code" := TransRcptLine2."Shortcut Dimension 2 Code";
    end;
















    //CodeUnit5705 --
    //Tk++
    procedure UpdReservEntryIMEI(FromType: Option; FromSubtype: Integer; FromID: Code[20]; FromBatchName: Code[10]; FromProdOrderLine: Integer; FromRefNo: Integer; FromQtyPerUOM: Decimal; FromSerialNo: Code[20]; FromLotNo: Code[20]; FromMRPVal: Decimal)
    var
        ReservEntry: Record 337;
        ReservEntryFrom: Record 337;
        SurplusReservEntry: Record 337;
        ReservEntryTo: Record 337;
        ReservMgt: Codeunit 99000845;
        LastEntryNo: Integer;
        TrackingSpecificationExists: Boolean;
        FirstSplit: Boolean;
    begin
        ReservEntryFrom.RESET;
        ReservEntryFrom.SETRANGE("Source Type", FromType);
        ReservEntryFrom.SETRANGE("Source ID", FromID);
        ReservEntryFrom.SETRANGE("Source Batch Name", FromBatchName);
        ReservEntryFrom.SETRANGE("Source Prod. Order Line", FromProdOrderLine);
        ReservEntryFrom.SETRANGE("Source Subtype", FromSubtype);
        ReservEntryFrom.SETRANGE("Lot No.", FromLotNo);
        ReservEntryFrom.SETRANGE("Serial No.", FromSerialNo);
        IF ReservEntryFrom.FINDFIRST THEN BEGIN
            ReservEntryFrom."MRP Value" := FromMRPVal;
            ReservEntryFrom.MODIFY;
        END;
    end;
    //Tk--

    //Rahul++
    // [EventSubscriber(ObjectType::Table, Database::"Purch. Inv. Header", 'OnAfterInsertEvent', '', false, false)]
    // local procedure OnAfterInitPurchInvRecord(var Rec: Record "Purch. Inv. Header");
    // BEGIN
    //     IF (Rec."Order No." <> '') THEN
    //         OrderStatus('Completed', Rec."Order No.");
    // END;



    // procedure OrderStatus(OrderStatusValue: Text[50]; OrderNo: Code[20]);
    // var
    //     json: Text;
    //     SalesnRecSetup: Record "Sales & Receivables Setup";
    //     URL: Text;
    //     HttpResponse: HttpResponseMessage;
    //     ResponseText: Text;
    //     HttpsContent: HttpContent;
    //     HttpRequest: HttpRequestMessage;
    //     HttpClient: HttpClient;
    //     RequestHeader: HttpHeaders;
    //     AuthString: Text;
    //     SecurityResponseText: Text;
    //     SuccessResponseText: Text;
    //     OrderStatusJson: JsonObject;
    //     TempBlob: Codeunit "Temp Blob";
    //     OutStreamObject: OutStream;
    //     Base64Converter: Codeunit "Base64 Convert";
    // begin

    //     Clear(SecurityResponseText);
    //     Clear(AuthString);
    //     SalesnRecSetup.Get();
    //     OrderStatusJson.Add('status', OrderStatusValue);
    //     HttpsContent.WriteFrom(Format(OrderStatusJson));
    //     Message('%1', Format(OrderStatusJson));//Request
    //     HttpsContent.GetHeaders(RequestHeader);
    //     RequestHeader.Remove('Content-Type');
    //     RequestHeader.Add('Content-Type', 'application/json');

    //     AuthString := STRSUBSTNO('%1:%2', SalesnRecSetup.UserName, SalesnRecSetup.Password);
    //     TempBlob.CreateOutStream(OutStreamObject);
    //     OutStreamObject.WriteText(AuthString);
    //     AuthString := Base64Converter.ToBase64(AuthString);

    //     AuthString := STRSUBSTNO('Basic %1', AuthString);
    //     //AuthString := STRSUBSTNO('Bearer %1', AuthString);
    //     HttpClient.DefaultRequestHeaders().Add('Authorization', AuthString);
    //     SalesnRecSetup.TestField("Order Status API URL");
    //     URL := SalesnRecSetup."Order Status API URL" + Format(OrderNo);
    //     HttpClient.SetBaseAddress(URL);
    //     Clear(SuccessResponseText);
    //     IF HttpClient.Post(URL, HttpsContent, HttpResponse) THEN BEGIN
    //         HttpResponse.Content.ReadAs(ResponseText);
    //         IF HttpResponse.IsSuccessStatusCode THEN
    //             Message(ResponseText);
    //     END;
    // END;

    // //Rahul--

    //kajal++
    //////////////////////////////////////////////////////SOR///////////
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterOnInsert', '', false, false)]
    local procedure OnAfterOnInsert(var SalesHeader: Record "Sales Header")
    begin
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then begin
            SalesHeader."Mobile Type" := SalesHeader."Mobile Type"::Apple;
            SalesHeader."Shortcut Dimension 2 Code" := 'RETAIL';

        end;
    end;

    //OnAfterCopySellToCustomerAddressFieldsFromCustomer
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterCopySellToCustomerAddressFieldsFromCustomer', '', false, false)]
    local procedure OnAfterCopySellToCustomerAddressFieldsFromCustomer(SellToCustomer: Record Customer; var SalesHeader: Record "Sales Header")
    begin
        SalesHeader."Cust. Mobile No." := SellToCustomer."Phone No.";
        SalesHeader."Cust. email ID" := SellToCustomer."E-Mail";
    end;
    //////////////////////////////////////////////////////SOR///////////
    //kajal--














    procedure CreatePaymentEntry(SalesHeader: Record "Sales Header"; Amt: Decimal; Account: Code[20])
    var
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        GenJnlLine1: Record "Gen. Journal Line";
        GenJnlLine2: Record "Gen. Journal Line";
        LineNo: Integer;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        CLE: Record "Cust. Ledger Entry";
    BEGIN
        IF Account = '' THEN
            Error('Bal. Account Number must have a value');
        SalesInvoiceHeader.Reset();
        SalesInvoiceHeader.SetRange(SalesInvoiceHeader."Order No.", SalesHeader."No.");
        IF SalesInvoiceHeader.FindFirst() THEN;
        /*
         BEGIN
            //Message('Sales Invoice %1', SalesInvoiceHeader."No.");
            CLE.Reset();
            CLE.SetRange(CLE."Document No.", SalesInvoiceHeader."No.");
            CLE.SetRange(CLE."Document Type", CLE."Document Type"::Invoice);
            IF CLE.FindFirst() THEN;
            //Message('CLE %1', CLE."Document No.");
        END;
        */
        Clear(LineNo);
        GenJnlLine2.Reset();
        GenJnlLine2.Setrange(GenJnlLine2."Journal Template Name", 'PAYMENTS');
        GenJnlLine2.Setrange(GenJnlLine2."Journal Batch Name", 'DEFAULT');
        IF GenJnlLine2.FindLast() THEN
            LineNo := GenJnlLine2."Line No." + 10000
        ELSE
            LineNo := 10000;
        //Message('%1', LineNo);
        GenJnlLine1.INIT;
        GenJnlLine1."Journal Template Name" := 'PAYMENTS';
        GenJnlLine1."Journal Batch Name" := 'DEFAULT';
        GenJnlLine1."Line No." := LineNo;
        GenJnlLine1."Posting Date" := SalesHeader."Posting Date";
        GenJnlLine1."Document Date" := SalesHeader."Document Date";
        GenJnlLine1.Description := SalesHeader."Posting Description";
        GenJnlLine1."Shortcut Dimension 1 Code" := SalesHeader."Shortcut Dimension 1 Code";
        GenJnlLine1."Shortcut Dimension 2 Code" := SalesHeader."Shortcut Dimension 2 Code";
        GenJnlLine1."Dimension Set ID" := SalesHeader."Dimension Set ID";
        GenJnlLine1."Reason Code" := SalesHeader."Reason Code";
        GenJnlLine1."Account Type" := GenJnlLine1."Account Type"::Customer;
        GenJnlLine1."Account No." := SalesHeader."Bill-to Customer No.";
        GenJnlLine1."Document Type" := GenJnlLine1."Document Type"::Payment;
        GenJnlLine1."Bal. Account Type" := GenJnlLine1."Bal. Account Type"::"G/L Account";
        IF SalesInvoiceHeader."No." <> '' THEN
            GenJnlLine1."Document No." := SalesInvoiceHeader."No." + '-P'
        ELSE
            GenJnlLine1."Document No." := SalesHeader."No." + '-P';//SalesInvoiceHeader."No." + '-P';//GenJnlLineDocNo + '-P';
        GenJnlLine1."External Document No." := SalesHeader."External Document No."; //GenJnlLineExtDocNo;
        GenJnlLine1."Bal. Account No." := Account;
        GenJnlLine1."Currency Code" := SalesHeader."Currency Code";
        GenJnlLine1.Validate(Amount, Amt * -1);
        //GenJnlLine1.Amount := ROUND(GenJnlLine1.Amount, Currency."Amount Rounding Precision") * -1;//Temp
        GenJnlLine1."Source Currency Code" := SalesHeader."Currency Code";
        //GenJnlLine."Source Currency Amount" := GenJnlLine.Amount;//Temp
        GenJnlLine1.Correction := SalesHeader.Correction;
        //CustLedgEntry.CALCFIELDS(Amount);
        //IF CustLedgEntry.Amount = 0 THEN
        //GenJnlLine1."Amount (LCY)" := SalesHeader.PayByCashAmt * -1; Temp
        // ELSE BEGIN
        //     GenJnlLine."Amount (LCY)" := (
        //        AmountToCustomer
        //        +
        //        ROUND(
        //          CustLedgEntry."Remaining Pmt. Disc. Possible" /
        //          CustLedgEntry."Adjusted Currency Factor"));
        //     //  MESSAGE(FORMAT(GenJnlLine."Amount (LCY)" ));
        // END;
        IF SalesHeader."Currency Code" = '' THEN
            GenJnlLine1."Currency Factor" := 1
        ELSE
            GenJnlLine1."Currency Factor" := SalesHeader."Currency Factor";
        GenJnlLine1."Applies-to Doc. Type" := GenJnlLine1."Applies-to Doc. Type"::Invoice; //Temp
        GenJnlLine1."Applies-to Doc. No." := SalesInvoiceHeader."No."; //Temp
        GenJnlLine1."Source Type" := GenJnlLine1."Source Type"::Customer;
        GenJnlLine1."Source No." := SalesHeader."Bill-to Customer No.";
        GenJnlLine1."Source Code" := 'PAYMENTJNL';
        //SrcCode;//Check
        GenJnlLine1."Posting No. Series" := SalesHeader."Posting No. Series";
        GenJnlLine1."IC Partner Code" := SalesHeader."Sell-to IC Partner Code";
        GenJnlLine1.Insert();
        // IF ArPayTypes[i, 7] = FORMAT(PaymentType::Cheque) THEN BEGIN
        //     // GenJnlLine."Cheque Date" := SalesHeader.PayByChqDt;
        //     // GenJnlLine."Cheque No." :=  SalesHeader.PayByChqNo;
        // END;//tk
        //GenJnlPostLine.RunWithCheck(GenJnlLine1);

    END;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Inv. Header - Edit", 'OnRunOnBeforeAssignValues', '', true, true)]
    local procedure OnRunOnBeforeAssignValues(var SalesInvoiceHeader: Record "Sales Invoice Header"; SalesInvoiceHeaderRec: Record "Sales Invoice Header")
    begin
        SalesInvoiceHeader."Vehicle No." := SalesInvoiceHeaderRec."Vehicle No.";
        SalesInvoiceHeader."Mode of Transport" := SalesInvoiceHeaderRec."Mode of Transport";
        SalesInvoiceHeader."Vehicle Type" := SalesInvoiceHeaderRec."Vehicle Type";
        SalesInvoiceHeader."Cancel Reason" := SalesInvoiceHeaderRec."Cancel Reason";
        SalesInvoiceHeader."Cancel Reason Code" := SalesInvoiceHeaderRec."Cancel Reason Code";
        SalesInvoiceHeader."Cancel Remark" := SalesInvoiceHeaderRec."Cancel Remark";
        SalesInvoiceHeader."E-Invoice Cancel Remark" := SalesInvoiceHeaderRec."E-Invoice Cancel Remark";
        ///CCIT AN 12092023++
        SalesInvoiceHeader."Nature of Supply" := SalesInvoiceHeaderRec."Nature of Supply";
        SalesInvoiceHeader."GST Customer Type" := SalesInvoiceHeaderRec."GST Customer Type";
        SalesInvoiceHeader."GST Bill-to State Code" := SalesInvoiceHeaderRec."GST Bill-to State Code";
        //CCIT AN 12092023--
    end;

    [EventSubscriber(ObjectType::Page, Page::"Posted Sales Inv. - Update", 'OnAfterRecordChanged', '', true, true)]
    local procedure OnAfterRecordChanged(var SalesInvoiceHeader: Record "Sales Invoice Header"; xSalesInvoiceHeader: Record "Sales Invoice Header"; var IsChanged: Boolean)
    begin
        IsChanged := IsChanged or (SalesInvoiceHeader."Vehicle No." <> xSalesInvoiceHeader."Vehicle No.") or (SalesInvoiceHeader."Mode of Transport" <> xSalesInvoiceHeader."Mode of Transport")
        or (SalesInvoiceHeader."Vehicle Type" <> xSalesInvoiceHeader."Vehicle Type") or (SalesInvoiceHeader."Cancel Reason" <> xSalesInvoiceHeader."Cancel Reason")
        or (SalesInvoiceHeader."Cancel Reason Code" <> xSalesInvoiceHeader."Cancel Reason Code")
        or (SalesInvoiceHeader."Cancel Remark" <> xSalesInvoiceHeader."Cancel Remark")
        or (SalesInvoiceHeader."E-Invoice Cancel Remark" <> xSalesInvoiceHeader."E-Invoice Cancel Remark") or (SalesInvoiceHeader."Nature of Supply" <> xSalesInvoiceHeader."Nature of Supply")
        or (SalesInvoiceHeader."GST Customer Type" <> xSalesInvoiceHeader."GST Customer Type") or (SalesInvoiceHeader."GST Bill-to State Code" <> xSalesInvoiceHeader."GST Bill-to State Code");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Credit Memo Hdr. - Edit", 'OnBeforeSalesCrMemoHeaderModify', '', true, true)]
    procedure OnBeforeSalesCrMemoHeaderModify(var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; FromSalesCrMemoHeader: Record "Sales Cr.Memo Header")
    begin
        //SalesCrMemoHeader."Vehicle No." := FromSalesCrMemoHeader."Vehicle No.";
        //SalesCrMemoHeader."Mode of Transport" := SalesInvoiceHeaderRec."Mode of Transport";
        //SalesCrMemoHeader."Vehicle Type" := FromSalesCrMemoHeader."Vehicle Type";
        SalesCrMemoHeader."E-Invoice Reason Code" := FromSalesCrMemoHeader."E-Invoice Reason Code";
        //SalesCrMemoHeader."Cancel Reason Code" := FromSalesCrMemoHeader."Cancel Reason Code";
        //SalesCrMemoHeader."Cancel Remark" := FromSalesCrMemoHeader."Cancel Remark";
        SalesCrMemoHeader."E-Invoice Cancel Remark" := FromSalesCrMemoHeader."E-Invoice Cancel Remark";
    end;

    [EventSubscriber(ObjectType::Page, Page::"Pstd. Sales Cr. Memo - Update", 'OnAfterRecordChanged', '', true, true)]
    local procedure OnAfterRecordChangedSalesCr(var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; xSalesCrMemoHeader: Record "Sales Cr.Memo Header"; var IsChanged: Boolean)
    begin
        IsChanged := IsChanged or (SalesCrMemoHeader."E-Invoice Reason Code" <> xSalesCrMemoHeader."E-Invoice Reason Code")
        or (SalesCrMemoHeader."E-Invoice Cancel Remark" <> xSalesCrMemoHeader."E-Invoice Cancel Remark");
    end;


    //TK++

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Reserv. Entry", 'OnAfterCreateReservEntryFor', '', false, false)]
    local procedure OnAfterCreateReservEntryFor(var ReservationEntry: Record "Reservation Entry"; Sign: Integer; ForType: Option; ForSubtype: Integer; ForID: Code[20]; ForBatchName: Code[10]; ForProdOrderLine: Integer; ForRefNo: Integer; ForQtyPerUOM: Decimal; Quantity: Decimal; QuantityBase: Decimal; ForReservEntry: Record "Reservation Entry");
    begin

    end;
    // //CCIT_TK ++
    // [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAssistEditOnBeforeExit', '', false, false)]
    // local procedure OnAssistEditOnBeforeExit(var Customer: Record Customer);
    // var
    // Cust : Record Customer;

    // begin
    //     WITH Cust DO BEGIN
    //   Cust := Customer;
    //   IF "No." <> '' THEN BEGIN
    //    IF CONFIRM('Do you want to Change Item Code') THEN
    //      CLEAR(CustomerTypePage)
    //    ELSE ERROR('');
    //   END
    //   ELSE CLEAR(CustomerTypePage);

    //   CustomerTypePage.LOOKUPMODE(TRUE);
    //   IF CustomerTypePage.RUNMODAL=ACTION::LookupOK THEN BEGIN
    //     CustomerTypePage.GETRECORD(CutomerTypeRec);
    //     SalesSetup.GET;
    //     IF CutomerTypeRec."Customer Type" =  CutomerTypeRec."Customer Type"::Retail THEN BEGIN
    //       SalesSetup.TESTFIELD("Retail Customer Nos.");
    //       IF NoSeriesMgt.SelectSeries(SalesSetup."Retail Customer Nos.",Customer."No. Series","No. Series") THEN
    //         NoSeriesMgt.SetSeries("No.");
    //      END
    //     ELSE IF CutomerTypeRec."Customer Type" =  CutomerTypeRec."Customer Type"::Corporate THEN  BEGIN
    //       SalesSetup.TESTFIELD("Corporate Customer Nos.");
    //       IF NoSeriesMgt.SelectSeries(SalesSetup."Corporate Customer Nos.",Customer."No. Series","No. Series") THEN
    //         NoSeriesMgt.SetSeries("No.");
    //     END;
    //    //KPPL Start
    //     IF CutomerTypeRec."Customer Type" =  CutomerTypeRec."Customer Type"::B2C THEN BEGIN
    //      SalesSetup.TESTFIELD("B2C Customer No.");
    //       IF NoSeriesMgt.SelectSeries(SalesSetup."B2C Customer No.",Customer."No. Series","No. Series") THEN
    //         NoSeriesMgt.SetSeries("No.");
    //       END 
    //       ELSE BEGIN
    //         SalesSetup.TESTFIELD("Corporate Customer Nos.");
    //        IF NoSeriesMgt.SelectSeries(SalesSetup."Corporate Customer Nos.",Customer."No. Series","No. Series") THEN
    //         NoSeriesMgt.SetSeries("No.");
    //       END
    //   // Kppl End
    //   END;

    //   Customer := Cust;
    //   EXIT;
    // END;

    // end;



    //CCIT-TK-- 



    var

        myInt: Integer;
        ShieldAmt: Decimal;
        SlaesPost: Codeunit 80;

        //80++
        //TK
        SalesSetup: record "Sales & Receivables Setup";
        CutomerTypeRec: Record "Customer";
        CustomerTypePage: page "Customer Type Selection";
        RecGSTSetup: Record "GST Setup";
        RecSIIH: Record "Sales Invoice Header";
        RecSalL: Record "Sales Line";
        Reccustt: Record Customer;
        RecGSTPos: Record "GST Posting Setup";
        RecEINV: Record 50015;
        bbc: Text;
        RecSHHH: Record 50021;
        PartyLine: Record 37;
        SalesOrderExtension: Record 50026;
        POIntegration: Codeunit 50017;
        PostingNoSeriesErr: label 'Posting No. Series is blank in Sales Header for Invoice Type %1.Related No. Series Code is not set in the fields of Sales & Receivable Setup and in Location Card';
        ShieldLine: Record "Sales Line";
        ShieldHeader: Record "Sales Header";
        ShieldInvoice: Boolean;
        ShieldLineNo: Integer;
        ArPayTypes: array[20, 11] of Text[50];
        PaymentMethod: Record "Payment Method";
        i: Integer;
        j: Integer;
        TransferShipHeader: Record "Transfer Shipment Header";
        Vendor: Record Vendor;
        RecGLAccount: Record "G/L Account";
        LocWooCom: Record 50006;
        LocExternalDoc: Code[35];
        ArShield: array[12, 4] of Decimal;
        PartyHeader: Record 36;
        GenJnlLine: record 81;
        GenJnlLine1: record 81;
        GenJnlLine2: Record 81;
        Window: Dialog;
        PostingDate: Date;
        UseDate: Date;
        GenJnlLineDocNo: Code[20];
        GenJnlLineExtDocNo: Code[35];
        SrcCode: Code[10];
        GenJnlLineDocType: Integer;
        ItemLedgShptEntryNo: Integer;
        FALineNo: Integer;
        RoundingLineNo: Integer;
        DeferralLineNo: Integer;
        InvDefLineNo: Integer;
        RemQtyToBeInvoiced: Decimal;
        RemQtyToBeInvoicedBase: Decimal;
        QtyToBeInvoiced: Decimal;
        QtyToBeInvoicedBase: Decimal;
        RemAmt: Decimal;
        RemDiscAmt: Decimal;
        LastLineRetrieved: Boolean;
        RoundingLineInserted: Boolean;
        DropShipOrder: Boolean;
        PostingDateExists: Boolean;
        ReplacePostingDate: Boolean;
        ReplaceDocumentDate: Boolean;
        Text034: label 'You cannot assign item charges to the %1 %2 = %3,%4 = %5, %6 = %7, because it has been invoiced.';
        Text036: label 'You cannot invoice more than you have received for return order %1.';
        Text037: label 'The return receipt lines have been deleted.';
        Text038: label 'The quantity you are attempting to invoice is greater than the quantity in return receipt %1.';
        ItemChargeAssgntOnly: Boolean;
        ItemJnlRollRndg: Boolean;
        Text040: label 'Related item ledger entries cannot be found.';
        Text043: label 'Item Tracking is signed wrongly.';
        Text044: label 'Item Tracking does not match.';
        WhseShip: Boolean;
        WhseReceive: Boolean;
        InvtPickPutaway: Boolean;
        Text045: label 'is not within your range of allowed posting dates.';
        Text046: label 'The %1 does not match the quantity defined in item tracking.';
        Text047: label 'cannot be more than %1.';
        Text048: label 'must be at least %1.';
        JobContractLine: Boolean;
        GLSetupRead: Boolean;
        ItemTrkgAlreadyOverruled: Boolean;
        Text050: label 'The total %1 cannot be more than %2.';
        Text051: label 'The total %1 must be at least %2.';
        Text052: label 'You must assign item charge %1 if you want to invoice it.';
        Text053: label 'You can not invoice item charge %1 because there is no item ledger entry to assign it to.';
        SalesLinesProcessed: Boolean;
        Text055: label '#1#################################\\Checking Assembly #2###########';
        Text056: label '#1#################################\\Posting Assembly #2###########';
        Text057: label '#1#################################\\Finalizing Assembly #2###########';
        Text059: label '%1 %2 %3 %4', Comment = '%1 = SalesLine."Document Type". %2 = SalesLine."Document No.". %3 = SalesLine.FIELDCAPTION("Line No."). %4 = SalesLine."Line No.". This is used in a progress window.';
        Text060: label '%1 %2', Comment = '%1 = "Document Type". %2 = AsmHeader."No.". Used in a progress window.';


        Text13700: label 'The LC which you have attached is expired.';
        Text13701: label 'The order value %1 cannot be greater than the LC remaining value %2.';
        AmountToCustomer: Decimal;
        AmountToCustomerLCY: Decimal;
        ChargestoCustomer: Decimal;
        SrcCurrChargestoCustomer: Decimal;
        Text13702: label 'Deferred Excise cannot be claimed for Fixed Asset %1.';
        CustNatureofDeduction: Code[10];
        CustTDSGroup: Option " ",Contractor,Commission,Professional,Interest,Rent,Dividend,"Interest on Securities",Lotteries,"Insurance Commission",NSS,"Mutual fund",Brokerage,"Income from Units","Capital Assets","Horse Races","Sports Association","Payable to Non Residents","Income of Mutual Funds",Units,"Foreign Currency Bonds","FII from Securities",Others;
        LineNo: Integer;
        TotalBED: Decimal;
        TotalAEDGSI: Decimal;
        TotalSED: Decimal;
        TotalSAED: Decimal;
        TotalCESS: Decimal;
        TotalNCCD: Decimal;
        TotalECess: Decimal;
        TotalADET: Decimal;
        TotalADE: Decimal;
        TotalAEDTTA: Decimal;

        Text13703: label 'Direct Debit to PLA/RG is checked. Please fill Excise Cenvat Claim form.';
        Text13704: label 'Please check the total amount of PLA , RG 23 A and RG 23 C with Excise Amount.';

        CustNatureofCollection: Code[10];
        CustTCSType: Option " ",A,B,C,D,E,F,G,H,I;
        TotalStandardDeduction: Decimal;
        TotalStandardDeductionLCY: Decimal;
        CompanyInfoRead: Boolean;
        CompanyInfo: Record "Company Information";

        TotalADCVAT: Decimal;
        CVDEntry: Boolean;
        Text16502: label 'Sum of CIF Amount and BCD Amount should not be 0 for CVD Calculation.';

        TotalSHECess: Decimal;

        Text16503: label 'Type should not be Charge Item or G/L Account in trading transaction.';
        Text16504: label 'Please unchek the Input Service Distributor field in the %1 Location. ';
        Text16505: label 'Please unchek the Input Service Distributor field in the Company Information.';
        UPITInserted: Boolean;
        QuantityType: Option General,Invoicing,Shipping;
        ExciseExistInStructure: Boolean;
        TaxAreaLine: Record "Tax Area Line";
        TaxJurisdiction: Record "Tax Jurisdiction";
        SalesLine2: Record "Sales Line";
        Text16506: label 'Fixed asset or capital item must not be used in trading transaction in Document Type=%1,Document No.=%2,Line No.=%3.';
        Text16507: label 'VAT has been settled for this period. Do you want to post ?';
        Text16508: label 'The transaction cannot be posted as Sale Return Type is not equal to posted Return Receipt.';
        SalesLine6: Record "Sales Line";
        ItemChargeAssgntSales2: Record "Item Charge Assignment (Sales)";
        ItemCharge: Record "Item Charge";
        StartingEntryNo: Integer;
        ChargeItemPerOrder: Boolean;
        ChargeItemAssgnt: Boolean;
        ExecuteForLookup: Boolean;
        AppliedDocIsSTPayment: Boolean;
        TempSalesLineInst: Record "Sales Line" temporary;
        Text16519: label 'Service Tax Advance Payment Document/s cannot be applied with non Service Tax Invoice/s.';
        Text16520: label 'Invoice/s and Payment/s documents cannot be applied as both have different Service Tax Group Codes.';
        Text16521: label 'Invoice/s and Payment/s documents cannot be applied as both have different Service Tax Registration Nos.';
        CFactor: Decimal;
        TempSalesLine2: Record "Sales Line" temporary;
        CalledFrmPosting: Boolean;
        AppliedServiceTaxAmountPmt: Decimal;
        AppliedServiceTaxAmountInv: Decimal;
        Text16522: label 'The PoT Value in the %1 and the %2 is not the same.';
        ServiceTaxRoundingAmount: Decimal;
        Text061Err: label 'The order line that the item charge was originally assigned to has been fully posted. You must reassign the item charge to the posted receipt or shipment.';
        SalesLineTaxAmount: Decimal;
        Text062Qst: label 'One or more reservation entries exist for the item with %1 = %2, %3 = %4, %5 = %6 which may be disrupted if you post this negative adjustment. Do you want to continue?', Comment = 'One or more reservation entries exist for the item with No. = 1000, Location Code = SILVER, Variant Code = NEW which may be disrupted if you post this negative adjustment. Do you want to continue?';
        NotSupportedDocumentTypeErr: label 'Document type %1 is not supported.';
        PreviewMode: Boolean;
        NoDeferralScheduleErr: label 'You must create a deferral schedule because you have specified the deferral code %2 in line %1.', Comment = '%1=The item number of the sales transaction line, %2=The Deferral Template Code';
        ZeroDeferralAmtErr: label 'Deferral amounts cannot be 0. Line: %1, Deferral Template: %2.', Comment = '%1=The item number of the sales transaction line, %2=The Deferral Template Code';
        FakeDocNoTxt: label '***';
        CannotChargeErr: label 'You cannot charge line no. %1 because it is of type %2.', Comment = '%1 = SalesLine."Line No". %2 = SalesLine.Type.';
        CannotPostDiscountDeferralErr: label 'You cannot post line %1 because it contains a deferral code and a %2.', Comment = '@1 - Line No., %2 - Line/Inv. Discount Amount field name.';

        GSTPostingAccountErr: label 'GST Posting Setup has to be defined for %1 and %2', Comment = '@1 - Line No., %2 - Line/Inv. Discount Amount field name.';
        RefundAcc: Boolean;
        TotalGSTAmount: Decimal;
        TotalGSTAmountLCY: Decimal;
        CodeUnit12: CodeUnit 12;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Text061: label '%1 Series is not defined on Location Card.', Comment = '%1 = "Document Type". %2 = AsmHeader."No.". Used in a progress window.';
        TempVATAmountLineRemainder: Record "VAT Amount Line" temporary;
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        CustLedgEntry: Record "Cust. Ledger Entry";
        PaymentAmount: decimal;
        // ServiceTaxSetup: Record 16472;

        //80--
        //12 CodeUnit ++
        CrCardTransactionEntryNo: Integer;
        ResidualRoundingErr: Label 'Residual caused by rounding of %1';
        DimensionUsedErr: Label 'A dimension used in %1 %2, %3, %4 has caused an error. %5.', Comment = 'Comment';
        NeedsRoundingErr: Label '%1 needs to be rounded';
        PurchaseAlreadyExistsErr: Label 'Purchase %1 %2 already exists for this vendor.', Comment = '%1 = Document Type; %2 = Document No.';
        BankPaymentTypeMustNotBeFilledErr: Label 'Bank Payment Type must not be filled if Currency Code is different in Gen. Journal Line and Bank Account.';
        DocNoMustBeEnteredErr: Label 'Document No. must be entered when Bank Payment Type is %1.';
        CheckAlreadyExistsErr: Label 'Check %1 already exists for this Bank Account.';
        IncorrectDocTypeErr: Label '%1 is incorrect document type for Dynamics Online payment.';
        //12 CodeUnit --
        // CodeUnit 414++
        CodeUNit330: codeunit 5705;
    //CodeUnit 414--
}