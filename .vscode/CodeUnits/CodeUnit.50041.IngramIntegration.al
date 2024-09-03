codeunit 50041 "Ingram Integration"
{
    trigger OnRun()
    begin
    end;

    var
        ProcessingWindowMsg: Label 'Please wait while the server is processing your request.\This may take several minutes.';
        ProcessingWindow: Dialog;
        IngramIntegrationSetup: Record "Ingram Integration Setup";

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnAfterReleasePurchaseDoc', '', false, false)]
    local procedure OnAfterReleasePurchaseDocCreateIngramOrder(var PurchaseHeader: Record "Purchase Header")
    var
        Location: Record Location;
    begin
        IF PurchaseHeader.Status <> PurchaseHeader.Status::Released THEN EXIT;
        Location.GET(PurchaseHeader."Location Code");
        IF NOT Location."Ingram Location" THEN EXIT;
        IF PurchaseHeader."Ingram Order No." <> '' THEN EXIT;
        CreateIngramOrder(PurchaseHeader."No.");
    end;

    local procedure CreateIngramOrder(PurchaseOrderNo: Code[20])
    var
        PurchaseHeader: Record "Purchase Header";
        AccessToken: Text;
    begin
        IF PurchaseHeader.GET(PurchaseHeader."Document Type"::Order, PurchaseOrderNo) THEN BEGIN //RY
            PurchaseHeader.TESTFIELD(Status, PurchaseHeader.Status::Released);
            PurchaseHeader.TESTFIELD("Ingram Order No.", '');
            GetIngramIntegrationSetup();
            GetAccessToken(AccessToken);
            OrderCreateAPI(AccessToken, PurchaseHeader);
            IF GUIALLOWED THEN MESSAGE('Done');
        END;
    end;

    local procedure GetIngramIntegrationSetup()
    begin
        IngramIntegrationSetup.GET();
        IngramIntegrationSetup.TESTFIELD(client_id);
        IngramIntegrationSetup.TESTFIELD(client_secret);
        IngramIntegrationSetup.TESTFIELD("IM-CustomerNumber");
        IngramIntegrationSetup.TESTFIELD("IM-CorrelationID");
        IngramIntegrationSetup.TESTFIELD("IM-CountryCode");
        IngramIntegrationSetup.TESTFIELD("IM-SenderID");
        IngramIntegrationSetup.TESTFIELD(billToAddressId);
        IngramIntegrationSetup.TESTFIELD(shipToAddressId);
        IngramIntegrationSetup.TESTFIELD(shipFromWarehouseId);
        IngramIntegrationSetup.TESTFIELD(shipmentDetailsCarrierCode);
        IngramIntegrationSetup.TESTFIELD("Auth Token Url");
        IngramIntegrationSetup.TESTFIELD("Order API Url");
    end;
    /* local procedure GetAccessToken(var AccessToken: Text)
    var
        APIType: Option AuthToken,OrderCreate,OrderDetails;
        URL: Text;
        granttype: Label 'client_credentials';
        JSONContent: Text;
        JSONObject: DotNet JObject;
        OK: Boolean;
    begin
        URL := STRSUBSTNO(GetAPIURL(APIType::AuthToken) + '?grant_type=%1&client_id=%2&client_secret=%3', granttype, IngramIntegrationSetup.client_id, IngramIntegrationSetup.client_secret);
        OK := InvokeAccessTokenAPI(URL, JSONContent);

        IF NOT OK THEN
            EXIT;

        InitializeObjectFromString(JSONContent, JSONObject);
        AccessToken := JSONObject.SelectToken('access_token').ToString;
    end; */
    // Mapple NG 1.0 02072023 START - Ingram Integration
    local procedure GetAccessToken(var AccessToken: Text)
    var
        APIType: Option AuthToken,OrderCreate,OrderDetails;
        URL: Text;
        granttype: Label 'client_credentials';
        JSONContent: Text;
        OK: Boolean;
        JsonToken: JsonToken;
        JsonObject: JsonObject;
        JsonTokenValue: JsonToken;
    begin
        URL := STRSUBSTNO(GetAPIURL(APIType::AuthToken) + '?grant_type=%1&client_id=%2&client_secret=%3', granttype, IngramIntegrationSetup.client_id, IngramIntegrationSetup.client_secret);
        OK := InvokeAccessTokenAPI(URL, JSONContent);
        IF NOT OK THEN EXIT;
        Clear(AccessToken);
        if JsonToken.ReadFrom(JSONContent) then
            if JsonToken.IsObject then begin
                JsonObject := JsonToken.AsObject();
                JsonTokenValue := SelectJsonToken(JsonObject, 'access_token');
                AccessToken := JsonTokenValue.AsValue().AsText();
            end;
    end;

    procedure SelectJsonToken(JsonObjectValue: JsonObject; path: Text) json_Token: JsonToken;
    begin
        if not JsonObjectValue.SelectToken(path, json_Token) then Error('Token not found with path %1', path);
    end;
    // Mapple NG 1.0 02072023 END - Ingram Integration
    local procedure GetAPIURL(APIType: Option AuthToken,OrderCreate): Text
    begin
        IF IngramIntegrationSetup."API Environment Activated" = IngramIntegrationSetup."API Environment Activated"::Sandbox THEN BEGIN
            CASE APIType OF
                APIType::AuthToken:
                    exit(IngramIntegrationSetup."Auth Token Url");
                /* EXIT('https://api.ingrammicro.com/oauth/oauth20/token'); */
                APIType::OrderCreate:
                    exit(IngramIntegrationSetup."Order API Url");
            /* EXIT('https://api.ingrammicro.com:443/sandbox/resellers/v6/orders'); */
            END;
        END
        ELSE BEGIN
            CASE APIType OF
                APIType::AuthToken:
                    exit(IngramIntegrationSetup."Auth Token Url");
                /* EXIT('https://api.ingrammicro.com/oauth/oauth20/token'); */
                APIType::OrderCreate:
                    exit(IngramIntegrationSetup."Order API Url");
            /* EXIT('https://api.ingrammicro.com:443/resellers/v6/orders'); */
            END;
        END;
    end;
    /* local procedure InvokeAccessTokenAPI(URL: Text; var JSONContent: Text): Boolean
    var
        ResponseTempBlob: Record TempBlob;
        ResponseInStream: InStream;
        HttpWebRequest: DotNet HttpWebRequest;
        CookieContainer: DotNet CookieContainer;
        ServicePointManager: DotNet ServicePointManager;
        SecurityProtocol: DotNet SecurityProtocolType;
        HttpWebResponse: DotNet HttpWebResponse;
        HttpStatusCode: DotNet HttpStatusCode;
        ResponseHeaders: DotNet NameValueCollection;
        OK: Boolean;
    begin
        CLEAR(ResponseTempBlob);
        ResponseTempBlob.INIT();
        ResponseTempBlob.Blob.CREATEINSTREAM(ResponseInStream);

        HttpWebRequest := HttpWebRequest.Create(URL);
        HttpWebRequest.Method := 'GET';
        HttpWebRequest.KeepAlive := TRUE;
        HttpWebRequest.AllowAutoRedirect := TRUE;
        HttpWebRequest.UseDefaultCredentials := TRUE;
        HttpWebRequest.Timeout := 60000;
        HttpWebRequest.Accept('application/json');
        HttpWebRequest.ContentType('application/json');
        CookieContainer := CookieContainer.CookieContainer;
        HttpWebRequest.CookieContainer := CookieContainer;
        HttpWebRequest.Headers.Add('Accept-Encoding', 'utf-8');
        ServicePointManager.SecurityProtocol(SecurityProtocol.Tls12);

        OK := GetWebResponse(HttpWebRequest, HttpWebResponse, ResponseInStream, HttpStatusCode, ResponseHeaders);

        IF OK THEN
            ConvertInStreamToJSONContent(ResponseInStream, JSONContent)
        ELSE
            ERROR(GETLASTERRORTEXT);

        EXIT(OK);
    end; */
    // Mapple NG 1.0 02072023 START - Ingram Integration
    local procedure InvokeAccessTokenAPI(URL: Text; var JSONContent: Text): Boolean
    var
        HttpContent: HttpContent;
        HttpHeaders: HttpHeaders;
        Client: HttpClient;
        Response: HttpResponseMessage;
        OK: Boolean;
    begin
        HttpContent.GetHeaders(HttpHeaders);
        HttpHeaders.Remove('Content-Type');
        HttpHeaders.Add('Content-Type', 'application/json');
        if Client.Get(URL, Response) then OK := Response.IsSuccessStatusCode();
        IF OK THEN
            Response.Content.ReadAs(JSONContent)
        ELSE
            ERROR(GETLASTERRORTEXT);
        EXIT(OK);
    end;
    // Mapple NG 1.0 02072023 END - Ingram Integration
    /*  [TryFunction]
     // Mapple NG 1.0 02072023 - No need
     procedure GetWebResponse(var HttpWebRequest: DotNet HttpWebRequest; var HttpWebResponse: DotNet HttpWebResponse; var ResponseInStream: InStream; var HttpStatusCode: DotNet HttpStatusCode; var ResponseHeaders: DotNet NameValueCollection)
     begin
         IF GUIALLOWED THEN
             ProcessingWindow.OPEN(ProcessingWindowMsg);

         CLEARLASTERROR();
         HttpWebResponse := HttpWebRequest.GetResponse;
         HttpWebResponse.GetResponseStream.CopyTo(ResponseInStream);
         HttpStatusCode := HttpWebResponse.StatusCode;
         ResponseHeaders := HttpWebResponse.Headers;

         IF GUIALLOWED THEN
             ProcessingWindow.CLOSE();
     end; */
    local procedure OrderCreateAPI(var AccessToken: Text; PurchaseHeader: Record "Purchase Header")
    var
        APIType: Option AuthToken,OrderCreate,OrderDetails;
        URL: Text;
        RequestBody: Text;
        OK: Boolean;
        JSONContent: Text;
        PP: Record "Purchases & Payables Setup";
    begin
        IF AccessToken = '' THEN EXIT;
        //>>
        IF PP.Get() THEN IF PP."In-Gram Show Json" THEN Message('%1', Format(AccessToken));
        //<<
        URL := GetAPIURL(APIType::OrderCreate);
        RequestBody := OrderCreateAPIRequestBody(PurchaseHeader);
        OK := InvokeOrderCreateAPI(URL, AccessToken, RequestBody, JSONContent);
        IF NOT OK THEN EXIT;
        ReadResponseOrderCreateAPI(JSONContent, PurchaseHeader."No.");
    end;
    /* local procedure OrderCreateAPIRequestBody(PurchaseHeader: Record "Purchase Header"): Text
    var
        PurchaseLine: Record "Purchase Line";
        LineCount: Integer;
        Counter: Integer;
        JSONString: DotNet String;
        JSONObject: DotNet JObject;
        www: Label '001';
    begin
        PurchaseLine.RESET();
        PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
        PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
        PurchaseLine.SETFILTER("No.", '<>%1', '');

        LineCount := PurchaseLine.COUNT;

        IF LineCount = 0 THEN
            EXIT('');

        JSONString := '';
        JSONString := JSONString.ToString() + '{';
        JSONString := JSONString.ToString() + '"customerOrderNumber":' + '"' + PurchaseHeader."No." + '"' + ',';
        JSONString := JSONString.ToString() + '"billToAddressId":' + '"' + IngramIntegrationSetup.billToAddressId + '"' + ',';
        JSONString := JSONString.ToString() + '"shipToInfo":' + '{';
        JSONString := JSONString.ToString() + '"addressId":' + '"' + IngramIntegrationSetup.shipToAddressId + '"';
        JSONString := JSONString.ToString() + '}' + ',';
        JSONString := JSONString.ToString() + '"lines":' + '[';

        PurchaseLine.FINDSET(FALSE);
        REPEAT
            Counter := Counter + 1;

            PurchaseLine.TESTFIELD("Ingram Part Code");

            JSONString := JSONString.ToString() + '{';
            JSONString := JSONString.ToString() + '"customerLineNumber":' + '"' + FORMAT(PurchaseLine."Line No.") + '"' + ',';
            JSONString := JSONString.ToString() + '"ingramPartNumber":' + '"' + PurchaseLine."Ingram Part Code" + '"' + ',';
            JSONString := JSONString.ToString() + '"quantity":' + FORMAT(PurchaseLine.Quantity);
            IF Counter = LineCount THEN
                JSONString := JSONString.ToString() + '}'
            ELSE
                JSONString := JSONString.ToString() + '}' + ',';
        UNTIL PurchaseLine.NEXT() = 0;

        JSONString := JSONString.ToString() + ']' + ',';

        JSONString := JSONString.ToString() + '"additionalAttributes":' + '[';
        JSONString := JSONString.ToString() + '{';
        JSONString := JSONString.ToString() + '"attributeName":' + '"allowDuplicateCustomerOrderNumber"' + ',';
        JSONString := JSONString.ToString() + '"attributeValue":' + '"true"';
        JSONString := JSONString.ToString() + '}' + ',';
        JSONString := JSONString.ToString() + '{';
        JSONString := JSONString.ToString() + '"attributeName":' + '"shipFromWarehouseId"' + ',';
        JSONString := JSONString.ToString() + '"attributeValue":' + '"' + IngramIntegrationSetup.shipFromWarehouseId + '"';
        JSONString := JSONString.ToString() + '}';
        JSONString := JSONString.ToString() + ']' + ',';
        JSONString := JSONString.ToString() + '"shipmentDetails":' + '{';
        JSONString := JSONString.ToString() + '"carrierCode":' + '"' + IngramIntegrationSetup.shipmentDetailsCarrierCode + '"';
        JSONString := JSONString.ToString() + '}';
        JSONString := JSONString.ToString() + '}';

        JSONString := JSONObject.Parse(JSONString);

        EXIT(JSONString.ToString);
    end; */
    // Mapple NG 1.0 02072023 START - Ingram Integration
    local procedure OrderCreateAPIRequestBody(PurchaseHeader: Record "Purchase Header"): Text
    var
        PurchaseLine: Record "Purchase Line";
        LineCount: Integer;
        Counter: Integer;
        OrderCreateAPIRequesJsonObject: JsonObject;
        shipToInfoJsonObject: JsonObject;
        linesJsonArray: JsonArray;
        PurchLineJsonObject: JsonObject;
        additionalAttributesJsonArray: JsonArray;
        additionalAttributesJsonObject: JsonObject;
        shipmentDetailsJsonObject: JsonObject;
        www: Label '001';
        PP: Record "Purchases & Payables Setup";
    begin
        PurchaseLine.RESET();
        PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
        PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
        PurchaseLine.SETFILTER("No.", '<>%1', '');
        LineCount := PurchaseLine.COUNT;
        IF LineCount = 0 THEN EXIT('');
        Clear(OrderCreateAPIRequesJsonObject);
        Clear(shipToInfoJsonObject);
        OrderCreateAPIRequesJsonObject.Add('customerOrderNumber', PurchaseHeader."No.");
        OrderCreateAPIRequesJsonObject.Add('billToAddressId', IngramIntegrationSetup.billToAddressId);
        OrderCreateAPIRequesJsonObject.Add('shipToInfo', shipToInfoJsonObject);
        shipToInfoJsonObject.Add('addressId', IngramIntegrationSetup.shipToAddressId);
        Clear(linesJsonArray);
        PurchaseLine.FINDSET(FALSE);
        REPEAT
            Counter := Counter + 1;
            PurchaseLine."Ingram Line No." := Counter;
            PurchaseLine.TESTFIELD("Ingram Part Code");
            Clear(PurchLineJsonObject);
            PurchLineJsonObject.Add('customerLineNumber', Format(Counter)); //FORMAT(PurchaseLine."Line No."));
            PurchLineJsonObject.Add('ingramPartNumber', PurchaseLine."Ingram Part Code");
            PurchLineJsonObject.Add('quantity', Format(PurchaseLine.Quantity, 0, 1));
            linesJsonArray.Add(PurchLineJsonObject);
            PurchaseLine.Modify(false);
        UNTIL PurchaseLine.NEXT() = 0;
        OrderCreateAPIRequesJsonObject.Add('lines', linesJsonArray);
        Clear(additionalAttributesJsonObject);
        Clear(additionalAttributesJsonArray);
        additionalAttributesJsonObject.Add('attributeName', 'allowDuplicateCustomerOrderNumber');
        additionalAttributesJsonObject.Add('attributeValue', 'true');
        additionalAttributesJsonArray.Add(additionalAttributesJsonObject);
        Clear(additionalAttributesJsonObject);
        additionalAttributesJsonObject.Add('attributeName', 'shipFromWarehouseId');
        additionalAttributesJsonObject.Add('attributeValue', IngramIntegrationSetup.shipFromWarehouseId);
        additionalAttributesJsonArray.Add(additionalAttributesJsonObject);
        OrderCreateAPIRequesJsonObject.Add('additionalAttributes', additionalAttributesJsonArray);
        Clear(shipmentDetailsJsonObject);
        OrderCreateAPIRequesJsonObject.Add('shipmentDetails', shipmentDetailsJsonObject);
        shipmentDetailsJsonObject.Add('carrierCode', IngramIntegrationSetup.shipmentDetailsCarrierCode);
        //>>
        IF PP.Get() THEN IF PP."In-Gram Show Json" THEN Message('%1', Format(OrderCreateAPIRequesJsonObject));
        //<<
        EXIT(Format(OrderCreateAPIRequesJsonObject));
    end;
    // Mapple NG 1.0 02072023 END - Ingram Integration
    /* local procedure InvokeOrderCreateAPI(URL: Text; AccessToken: Text; RequestBody: Text; var JSONContent: Text): Boolean
    var
        ResponseTempBlob: Record TempBlob;
        ResponseInStream: InStream;
        HttpWebRequest: DotNet HttpWebRequest;
        CookieContainer: DotNet CookieContainer;
        ServicePointManager: DotNet ServicePointManager;
        SecurityProtocol: DotNet SecurityProtocolType;
        AuthToken: Text;
        Encoding: DotNet Encoding;
        HttpWebResponse: DotNet HttpWebResponse;
        HttpStatusCode: DotNet HttpStatusCode;
        ResponseHeaders: DotNet NameValueCollection;
        OK: Boolean;
    begin
        CLEAR(ResponseTempBlob);
        ResponseTempBlob.INIT();
        ResponseTempBlob.Blob.CREATEINSTREAM(ResponseInStream);

        HttpWebRequest := HttpWebRequest.Create(URL);
        HttpWebRequest.Method := 'POST';
        HttpWebRequest.KeepAlive := TRUE;
        HttpWebRequest.AllowAutoRedirect := TRUE;
        HttpWebRequest.UseDefaultCredentials := TRUE;
        HttpWebRequest.Timeout := 60000;
        HttpWebRequest.Accept('application/json');
        HttpWebRequest.ContentType('application/json');
        CookieContainer := CookieContainer.CookieContainer;
        HttpWebRequest.CookieContainer := CookieContainer;
        HttpWebRequest.Headers.Add('Accept-Encoding', 'utf-8');
        AuthToken := 'Bearer ' + AccessToken;
        HttpWebRequest.Headers.Add('Authorization', AuthToken);
        HttpWebRequest.Headers.Add('IM-CustomerNumber', IngramIntegrationSetup."IM-CustomerNumber");
        HttpWebRequest.Headers.Add('IM-CorrelationID', IngramIntegrationSetup."IM-CorrelationID");
        HttpWebRequest.Headers.Add('IM-CountryCode', IngramIntegrationSetup."IM-CountryCode");
        HttpWebRequest.Headers.Add('IM-SenderID', IngramIntegrationSetup."IM-SenderID");
        AddBodyAsTextWithEncoding(HttpWebRequest, RequestBody, Encoding.Default);

        ServicePointManager.SecurityProtocol(SecurityProtocol.Tls12);

        OK := GetWebResponse(HttpWebRequest, HttpWebResponse, ResponseInStream, HttpStatusCode, ResponseHeaders);

        IF OK THEN
            ConvertInStreamToJSONContent(ResponseInStream, JSONContent)
        ELSE
            ERROR(GETLASTERRORTEXT);

        EXIT(OK);
    end; */
    // Mapple NG 1.0 02072023 START - Ingram Integration
    local procedure InvokeOrderCreateAPI(URL: Text; AccessToken: Text; RequestBody: Text; var JSONContent: Text): Boolean
    var
        OK: Boolean;
        HttpContent: HttpContent;
        HttpHeaders: HttpHeaders;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        HttpClient: HttpClient;
        JAccessToken: JsonObject;
        ResponseText: Text;
        PP: Record "Purchases & Payables Setup";
    begin
        Clear(ResponseText);
        HttpContent.WriteFrom(RequestBody);
        HttpContent.GetHeaders(HttpHeaders);
        HttpClient.DefaultRequestHeaders.Add('Authorization', GetAuthenticationHeaderValue(AccessToken));
        HttpHeaders.Remove('Content-Type');
        HttpHeaders.Add('Content-Type', 'application/json');
        HttpHeaders.Add('IM-CustomerNumber', IngramIntegrationSetup."IM-CustomerNumber");
        HttpHeaders.Add('IM-CorrelationID', IngramIntegrationSetup."IM-CorrelationID");
        HttpHeaders.Add('IM-CountryCode', IngramIntegrationSetup."IM-CountryCode");
        HttpHeaders.Add('IM-SenderID', IngramIntegrationSetup."IM-SenderID");
        HttpRequestMessage.Method := 'POST';
        HttpRequestMessage.SetRequestUri(URL);
        HttpRequestMessage.Content(HttpContent);
        if HttpClient.Send(HttpRequestMessage, HttpResponseMessage) then
            if HttpResponseMessage.IsSuccessStatusCode() then begin
                if HttpResponseMessage.Content.ReadAs(ResponseText) then OK := JAccessToken.ReadFrom(ResponseText);
                IF OK THEN BEGIN
                    //>>
                    IF PP.Get() THEN IF PP."In-Gram Show Json" THEN Message('%1', Format(ResponseText));
                    //<<
                    JSONContent := ResponseText;
                END
                ELSE
                    ERROR(GETLASTERRORTEXT);
            end
            else
                if HttpResponseMessage.Content.ReadAs(ResponseText) then begin
                    JAccessToken.ReadFrom(ResponseText);
                    Message(ResponseText);
                end;
        EXIT(OK);
    end;

    local procedure GetAuthenticationHeaderValue(AccessToken: Text) Value: Text;
    begin
        Value := StrSubstNo('Bearer %1', AccessToken);
    end;
    // Mapple NG 1.0 02072023 END - Ingram Integration
    /*     local procedure ReadResponseOrderCreateAPI(JSONContent: Text; PurchaseOrderNo: Code[20])
        var
            PurchaseHeader: Record "Purchase Header";
            PurchaseLine: Record "Purchase Line";
            JSONArrayString: Text;
            JSONArray: DotNet JArray;
            JSONObject: DotNet JObject;
            JSONArrayString2: Text;
            JSONArray2: DotNet JArray;
            JSONObject2: DotNet JObject;
            Type: Label 'orders';
            Type2: Label 'lines';
            JSONValue: DotNet JValue;
            IngramOrderNo: Code[20];
            PurchaseOrderLineNo: Integer;
            IngramSubOrderNo: Code[20];
            numberOfLinesWithSuccess: Integer;
        begin
            InitializeObjectFromString(JSONContent, JSONObject);

            JSONArrayString := JSONObject.SelectToken(Type).ToString;

            CLEAR(JSONObject);
            InitializeCollectionFromString(JSONArrayString, JSONArray);

            FOREACH JSONObject IN JSONArray DO BEGIN
                numberOfLinesWithSuccess := 0;
                IF JSONObject.TryGetValue('numberOfLinesWithSuccess', JSONValue) THEN
                    numberOfLinesWithSuccess := JSONValue.Value;

                IF numberOfLinesWithSuccess = 0 THEN
                    ERROR('Zero success line');

                IngramOrderNo := '';
                IF JSONObject.TryGetValue('ingramOrderNumber', JSONValue) THEN
                    IngramOrderNo := JSONValue.Value;

                JSONArrayString2 := JSONObject.SelectToken(Type2).ToString;
                CLEAR(JSONObject2);
                InitializeCollectionFromString(JSONArrayString2, JSONArray2);

                FOREACH JSONObject2 IN JSONArray2 DO BEGIN
                    PurchaseOrderLineNo := 0;
                    IngramSubOrderNo := '';

                    IF JSONObject2.TryGetValue('customerLineNumber', JSONValue) THEN
                        EVALUATE(PurchaseOrderLineNo, JSONValue.Value);

                    IF JSONObject2.TryGetValue('subOrderNumber', JSONValue) THEN
                        IngramSubOrderNo := JSONValue.Value;

                    PurchaseLine.GET(PurchaseLine."Document Type"::Order, PurchaseOrderNo, PurchaseOrderLineNo);
                    PurchaseLine."Ingram Order No." := IngramOrderNo;
                    PurchaseLine."Ingram Sub Order No." := IngramSubOrderNo;
                    PurchaseLine.MODIFY();
                END;

                PurchaseHeader.GET(PurchaseHeader."Document Type"::Order, PurchaseOrderNo);
                PurchaseHeader."Ingram Order No." := IngramOrderNo;
                PurchaseHeader.MODIFY();
            END;
        end; */
    // Mapple NG 1.0 02072023 START - Ingram Integration
    local procedure ReadResponseOrderCreateAPI(JSONContent: Text; PurchaseOrderNo: Code[20])
    var
        PurchaseHeader: Record "Purchase Header";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        PurchaseLine: Record "Purchase Line";
        IngramOrderNo: Code[20];
        PurchaseOrderLineNo: Integer;
        IngramSubOrderNo: Code[20];
        numberOfLinesWithSuccess: Integer;
        ResponseJsonObject: JsonObject;
        ResponseJsonToken: JsonToken;
        ordersJsonArray: JsonArray;
        OrderJsonObject: JsonObject;
        linesJsonObject: JsonObject;
        linesJsonArray: JsonArray;
    begin
        SalesReceivablesSetup.Get();
        ResponseJsonObject.ReadFrom(JSONContent);
        ResponseJsonObject.Get('orders', ResponseJsonToken);
        ordersJsonArray := ResponseJsonToken.AsArray();
        foreach ResponseJsonToken in ordersJsonArray do begin
            OrderJsonObject := ResponseJsonToken.AsObject();
            OrderJsonObject.Get('numberOfLinesWithSuccess', ResponseJsonToken);
            //Message('%1', ResponseJsonToken.AsValue().AsInteger());
            numberOfLinesWithSuccess := ResponseJsonToken.AsValue().AsInteger();
            IF numberOfLinesWithSuccess = 0 THEN ERROR('Zero success line');
            IngramOrderNo := '';
            OrderJsonObject.Get('ingramOrderNumber', ResponseJsonToken);
            IngramOrderNo := ResponseJsonToken.AsValue().AsText();
            OrderJsonObject.Get('lines', ResponseJsonToken);
            linesJsonArray := ResponseJsonToken.AsArray();
            foreach ResponseJsonToken in linesJsonArray do begin
                linesJsonObject := ResponseJsonToken.AsObject();
                PurchaseOrderLineNo := 0;
                IngramSubOrderNo := '';
                linesJsonObject.Get('customerLineNumber', ResponseJsonToken);
                EVALUATE(PurchaseOrderLineNo, ResponseJsonToken.AsValue().AsText());
                IF linesJsonObject.Get('subOrderNumber', ResponseJsonToken) THEN IngramSubOrderNo := ResponseJsonToken.AsValue().AsText();
                //PurchaseLine.GET(PurchaseLine."Document Type"::Order, PurchaseOrderNo, PurchaseOrderLineNo);
                PurchaseLine.Reset();
                PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
                PurchaseLine.SetRange("Document No.", PurchaseOrderNo);
                PurchaseLine.SetRange("Ingram Line No.", PurchaseOrderLineNo);
                if PurchaseLine.FindFirst() then begin
                    PurchaseLine."Ingram Order No." := IngramOrderNo;
                    PurchaseLine."Ingram Sub Order No." := IngramSubOrderNo;
                    PurchaseLine.MODIFY();
                end;
                if SalesReceivablesSetup."Display Ingram JSON" then Message('%1', PurchaseOrderLineNo);
            end;
            PurchaseHeader.GET(PurchaseHeader."Document Type"::Order, PurchaseOrderNo);
            PurchaseHeader."Ingram Order No." := IngramOrderNo;
            PurchaseHeader.MODIFY();
        end;
    end;
    // Mapple NG 1.0 02072023 END - Ingram Integration
    /* 
            // Mapple NG 1.0 02072023 Comment No need
        local procedure AddBodyAsTextWithEncoding(HttpWebRequest: DotNet HttpWebRequest; BodyText: Text; Encoding: DotNet Encoding)
        var
            RequestStr: DotNet Stream;
            StreamWriter: DotNet StreamWriter;
        begin
            RequestStr := HttpWebRequest.GetRequestStream;
            StreamWriter := StreamWriter.StreamWriter(RequestStr, Encoding);
            StreamWriter.Write(BodyText);
            StreamWriter.Flush;
            StreamWriter.Close;
            StreamWriter.Dispose;
        end; */
    /* 
        // Mapple NG 1.0 02072023 - No need
        local procedure ConvertInStreamToJSONContent(JsonInStream: InStream; var JSONContent: Text)
        var
            NewContent: Text;
        begin
            WHILE JsonInStream.READ(NewContent) > 0 DO
                JSONContent += NewContent;
        end;

        local procedure InitializeObjectFromString(JSONString: Text; var JSONObject: DotNet JObject)
        begin
            CLEAR(JSONObject);
            IF JSONString <> '' THEN
                JSONObject := JSONObject.Parse(JSONString)
            ELSE
                InitializeEmptyObject(JSONObject);
        end;

        local procedure InitializeCollectionFromString(JSONString: Text; var JSONArray: DotNet JArray)
        begin
            CLEAR(JSONArray);
            IF JSONString <> '' THEN
                JSONArray := JSONArray.Parse(JSONString)
            ELSE
                InitializeEmptyCollection(JSONArray);
        end;

        local procedure InitializeEmptyObject(var JSONObject: DotNet JObject)
        begin
            JSONObject := JSONObject.JObject;
        end;

        local procedure InitializeEmptyCollection(var JSONArray: DotNet JArray)
        begin
            JSONArray := JSONArray.JArray;
        end; */
}
