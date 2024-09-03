codeunit 50018 "Voucher Integration"
{
    // UAT Get voucher Base URL http://xp-voucher-stg-sg-v1.sg-s1.cloudhub.io/api/vouchers/ETX_001-
    trigger OnRun()
    begin
        //GetVoucher('MAPLEV62V0L5');
        //MapleAuth(150,'MAPLEKYKHCJ6','hG6tSE');
        //1
        /*

            CLEAR(HeaderDetailsModel);
            CLEAR(MapleVoucherClass);
            CLEAR(MapleGetVoucherModel);
            CLEAR(Data);
            CLEAR(Meta);
            HeaderDetailsModel:= HeaderDetailsModel.HeaderDetailsModel();
            HeaderDetailsModel.BaseUrlLink:='http://xp-voucher-stg-sg-v1.sg-s1.cloudhub.io/api/vouchers/';///etx_001-'+VoucherNo
            HeaderDetailsModel.XClientId:='8b81ee70435b4996a411e3f309656941';
            HeaderDetailsModel.XClientSecret:='54d30764eaCf4E9f816ed0E4FF664250';
            MapleVoucherClass := MapleVoucherClass.MapleVoucher();

            MapleGetVoucherModel:=MapleGetVoucherModel.MapleGetVoucherModel();
            MapleGetVoucherModel:= MapleVoucherClass.Getvoucherdetails('ETX_001','MAPLEV62V0L5',HeaderDetailsModel);
            Data := Data.Data();
            Meta := Meta.Meta();
            Data:=MapleGetVoucherModel.Data;

            MESSAGE(FORMAT(Data.ExpirationDate-(5.5*60*60000)));
            MESSAGE(FORMAT(Data.RemainingValue/100));
            //MESSAGE(FORMAT(Data.AuthorizationId));
            Meta:= MapleGetVoucherModel.Meta;
            MESSAGE(FORMAT(Meta.Status));


            //2
            */
        //MapleSearchTransactionss('SAO1819000034381');
        //MapleCancelAuthorization1('SAO1819000034381');
        //MapleRefund1('SAO1819000034381');
        //MapleSearchTransactionss('SAO1819000034381');
        //GetVoucherTEST('XYZ123','M1001');
    end;

    var /*  
        // Comment NG No need
          HeaderDetailsModel: DotNet HeaderDetailsModel;
          MapleGetVoucherModel: DotNet MapleGetVoucherModel;
          MapleVoucherClass: DotNet MapleVoucher;
          Data: DotNet Data;
          Meta: DotNet Meta;
          Dt: DateTime;
          varArray4: DotNet Array; */
        Dtt: DateTime;
        "No.series": Codeunit NoSeriesManagement;
        RecEinv: Record "E-Invoice Log";
        /*      
            // Comment NG No need
            MapleCapture: DotNet MapleCaptureModelRequest;
                 MapleGetVoucherModelCapture: DotNet MapleGetVoucherModel;
                 HeaderDetailsModelCapture: DotNet HeaderDetailsModel;
                 MapleCaptureModelResponse: DotNet MapleCaptureModelResponse;
                 MapleGetVoucherModelCap: DotNet MapleGetVoucherModel;
                 MapleRefund: DotNet MapleRefundRequest;
                 MapleRefundResponse: DotNet MapleRefundResponse;
                 MapleCancelAuthorization: DotNet MapleCancelAuthorizationRequest;
                 MapleCancelAuthorizationResponse: DotNet MapleCancelAuthorizationResponse;
                 MapleSearchTransaction: DotNet MapleSearchTransactionRequest;
                 MapleSearchTransactionResponse: DotNet MapleMapleSearchTransactionResponse;
                 Datum: DotNet Datum;
                 MetaMessage: DotNet Message;
                 varArray5: DotNet Array; */
        RecResource: Record "Resources Setup";
        RecLocation: Record Location;
        RecVou: Record "Voucher Integration";
        /*    METTTA: DotNet Message; */
        i: Integer;
    /*
    // Comment NG No need
     JsonArray: DotNet JArray;
    JsonObject: DotNet JObject;
    IEnumerator: DotNet IEnumerator_Of_T; */
    /* 
        procedure Getvoucherdetails(ProductCode: Text; VoucherNo: Code[20]; HeaderDet: DotNet HeaderDetailsModel; LocationCode: Code[20])
    var
        HeaderDetailsModel: DotNet HeaderDetailsModel;
        MapleGetVoucherModel: DotNet MapleGetVoucherModel;
        Data: DotNet Data;
        Meta: DotNet Meta;
    begin
        IF RecLocation.GET(LocationCode) THEN;
        CLEAR(MapleGetVoucherModel);
        MapleGetVoucherModel := MapleGetVoucherModel.MapleGetVoucherModel();
        CLEAR(Data);
        Data := Data.Data();
        CLEAR(Meta);
        Meta := Meta.Meta();
        //MESSAGE(FORMAT(MapleGetVoucherModel.Data));
        //MapleGetVoucherModel.MapleGetVoucherModel:=MapleGetVoucherModel;
        MapleGetVoucherModel.Data := Data;
        //MapleGetVoucherModel:= MapleGetVoucherModel.Data;
        MESSAGE(FORMAT(MapleGetVoucherModel.Data));
        Data := MapleGetVoucherModel.Data;
        //Data:= Data.Data;

        MESSAGE(FORMAT(Data.ExpirationDate));
        MESSAGE(FORMAT(Data.RemainingValue));


        Meta := MapleGetVoucherModel.Meta;
        MESSAGE(FORMAT(Meta.Status));
    end; */
    // Mapple NG 28032023 START - Getvoucherdetails
    procedure Getvoucherdetails(ProductCode: Text; VoucherNo: Code[20]; LocationCode: Code[20])
    var
        HttpContent: HttpContent;
        HttpHeaders: HttpHeaders;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        HttpClient: HttpClient;
        Response: HttpResponseMessage;
        Url: Text;
        ResponseJsonObject: JsonObject;
        ResponseJsonToken: JsonToken;
        dataJsonObject: JsonObject;
        GetvoucherdetailsResponse: Text;
        remaining_value: Decimal;
        metaJsonObject: JsonObject;
        linksJsonArray: JsonArray;
        linksJsonObject: JsonObject;
    begin
        RecResource.GET();
        Clear(Url);
        Clear(remaining_value);
        Clear(GetvoucherdetailsResponse);
        if VoucherNo <> '' then
            Url := 'https://xp-voucher-stg-sg-v1.sg-s1.cloudhub.io/api/vouchers/ETX_001-' + VoucherNo
        else
            Error('Voucher No. should not be blank.');
        IF RecLocation.GET(LocationCode) THEN;
        Clear(GetvoucherdetailsResponse);
        HttpContent.GetHeaders(HttpHeaders);
        HttpHeaders.Remove('Content-Type');
        HttpHeaders.Add('Content-Type', 'application/json');
        HttpHeaders.Add('X-Client-Id', RecLocation."Voucher Client ID"); //'4cda56f0482c4e60a86e76f47668c350');
        HttpHeaders.Add('X-Client-Secret', RecLocation."Voucher Secret Code"); //'a71BD3854A12426EB706E4c5de31c793');
        HttpRequestMessage.Method := 'GET';
        HttpRequestMessage.SetRequestUri(Url);
        HttpRequestMessage.Content(HttpContent);
        if HttpClient.Send(HttpRequestMessage, HttpResponseMessage) then
            if HttpResponseMessage.IsSuccessStatusCode() then begin
                Response.Content.ReadAs(GetvoucherdetailsResponse);
                if RecResource."Show Json" then Message(GetvoucherdetailsResponse);
                ResponseJsonObject.ReadFrom(GetvoucherdetailsResponse);
                ResponseJsonObject.Get('data', ResponseJsonToken);
                dataJsonObject := ResponseJsonToken.AsObject();
                dataJsonObject.Get('remaining_value', ResponseJsonToken);
                remaining_value := ResponseJsonToken.AsValue().AsDecimal();
                Message('remaining_value %1', remaining_value);
                dataJsonObject.Get('expiration_date', ResponseJsonToken);
                Message(' expiration_date %1', ResponseJsonToken.AsValue().AsText());
                ResponseJsonObject.Get('meta', ResponseJsonToken);
                metaJsonObject := ResponseJsonToken.AsObject();
                metaJsonObject.Get('status', ResponseJsonToken);
                Message('status %1', ResponseJsonToken.AsValue().AsText());
                /*  
                    // For Future
                     ResponseJsonObject.Get('links', ResponseJsonToken);
                      linksJsonArray := ResponseJsonToken.AsArray();
                      foreach ResponseJsonToken in linksJsonArray do begin
                          linksJsonObject := ResponseJsonToken.AsObject();
                          linksJsonObject.Get('rel', ResponseJsonToken);
                          Message('%1', ResponseJsonToken.AsValue().AsText());
                      end; */
            end
            else
                Message('%1', Response.HttpStatusCode);
    end;
    // Mapple NG 28032023 END - Getvoucherdetails
    /*  procedure GetVoucher(VoucherNo: Code[20]; LocationCode: Code[20])
     begin
         CLEAR(HeaderDetailsModel);
         CLEAR(MapleVoucherClass);
         CLEAR(MapleGetVoucherModel);
         CLEAR(Data);
         CLEAR(Meta);
         IF RecLocation.GET(LocationCode) THEN;
         HeaderDetailsModel := HeaderDetailsModel.HeaderDetailsModel();
         RecResource.GET;
         HeaderDetailsModel.BaseUrlLink := RecResource."Voucher Base URL";//'http://xp-voucher-stg-sg-v1.sg-s1.cloudhub.io/api/vouchers/';///etx_001-'+VoucherNo
         HeaderDetailsModel.XClientId := RecLocation."Voucher Client ID";//'8b81ee70435b4996a411e3f309656941';
         HeaderDetailsModel.XClientSecret := RecLocation."Voucher Secret Code";//'54d30764eaCf4E9f816ed0E4FF664250';
         MapleVoucherClass := MapleVoucherClass.MapleVoucher();

         MapleGetVoucherModel := MapleGetVoucherModel.MapleGetVoucherModel();
         //MapleGetVoucherModel:= MapleVoucherClass.Getvoucherdetails('ETX_001','MAPLEV62V0L5',HeaderDetailsModel);
         MapleGetVoucherModel := MapleVoucherClass.Getvoucherdetails('ETX_001', VoucherNo, HeaderDetailsModel);
         Data := Data.Data();
         Meta := Meta.Meta();


         Meta := MapleGetVoucherModel.Meta;

         IF Meta.Status <> 'failed' THEN
             MESSAGE('Voucher Status is %1', FORMAT(Meta.Status))
         ELSE BEGIN
             // ERROR('Please check Input Voucher Code entered');
             //ERROR('Input Voucher code/PIN is invalid');
             FOR i := 0 TO Meta.Messages.Length - 1 DO BEGIN
                 CLEAR(METTTA);
                 METTTA := Meta.Messages.GetValue(i);
                 IF METTTA.Code = 'ERV0001' THEN
                     ERROR('Input voucher code/PIN invalid')
                 ELSE
                     IF METTTA.Code = 'ERV0009' THEN
                         ERROR('Invalid voucher code. Please contact Ticket Xpress Operator')
                     ELSE
                         ERROR(FORMAT(METTTA.Text));
             END;
         END;
         Data := MapleGetVoucherModel.Data;

         //MESSAGE(FORMAT(Data.ExpirationDate-(5.5*60*60000)));
         MESSAGE('Voucher Balance is %1', FORMAT(Data.RemainingValue / 100));
     end; */
    // Mapple NG 28032023 START - Getvoucherdetails
    procedure GetVoucher(VoucherNo: Code[20]; LocationCode: Code[20])
    var
        HttpContent: HttpContent;
        HttpHeaders: HttpHeaders;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        HttpClient: HttpClient;
        Url: Text;
        ResponseGetVoucherValue: Text;
        ResponseJsonObject: JsonObject;
        ResponseJsonToken: JsonToken;
        dataJsonObject: JsonObject;
        remaining_value: Decimal;
        metaJsonObject: JsonObject;
        linksJsonArray: JsonArray;
        VoucherStatus: Text;
    begin
        Clear(VoucherStatus);
        Clear(ResponseGetVoucherValue);
        Clear(remaining_value);
        IF RecLocation.GET(LocationCode) THEN;
        RecResource.GET();
        RecResource.TestField("Voucher Base URL"); //https://xp-voucher-stg-sg-v1.sg-s1.cloudhub.io/api/vouchers/ETX_001-MAPLEJB6XMJ2
        RecLocation.TestField("Voucher Client ID"); // 4cda56f0482c4e60a86e76f47668c350
        RecLocation.TestField("Voucher Secret Code"); // a71BD3854A12426EB706E4c5de31c793 
        //Url := 'https://xp-voucher-stg-sg-v1.sg-s1.cloudhub.io/api/vouchers/ETX_001-' + VoucherNo;
        Clear(Url);
        Url := RecResource."Voucher Base URL" + VoucherNo;
        //Url := 'https://xp-voucher-stg-sg-v1.sg-s1.cloudhub.io/api/vouchers/ETX_001-MAPLEJB6XMJ2';
        HttpContent.GetHeaders(HttpHeaders);
        HttpHeaders.Remove('Content-Type');
        HttpHeaders.Add('Content-Type', 'application/json');
        HttpHeaders.Add('X-Client-Id', RecLocation."Voucher Client ID"); //'4cda56f0482c4e60a86e76f47668c350');//RecLocation."Voucher Client ID");
        HttpHeaders.Add('X-Client-Secret', RecLocation."Voucher Secret Code"); //'a71BD3854A12426EB706E4c5de31c793');//RecLocation."Voucher Secret Code");
        HttpRequestMessage.Method := 'GET';
        HttpRequestMessage.SetRequestUri(Url);
        HttpRequestMessage.Content(HttpContent);
        if HttpClient.Send(HttpRequestMessage, HttpResponseMessage) then
            if HttpResponseMessage.IsSuccessStatusCode() then begin
                HttpResponseMessage.Content.ReadAs(ResponseGetVoucherValue);
                if RecResource."Show Json" then Message(ResponseGetVoucherValue);
                ResponseJsonObject.ReadFrom(ResponseGetVoucherValue);
                ResponseJsonObject.Get('data', ResponseJsonToken);
                dataJsonObject := ResponseJsonToken.AsObject();
                if dataJsonObject.Get('remaining_value', ResponseJsonToken) then remaining_value := ResponseJsonToken.AsValue().AsDecimal();
                //   Message('remaining_value %1', remaining_value);
                if dataJsonObject.Get('expiration_date', ResponseJsonToken) then //  Message(' expiration_date %1', ResponseJsonToken.AsValue().AsText());
                    ResponseJsonObject.Get('meta', ResponseJsonToken);
                metaJsonObject := ResponseJsonToken.AsObject();
                metaJsonObject.Get('status', ResponseJsonToken);
                VoucherStatus := ResponseJsonToken.AsValue().AsText();
                IF VoucherStatus <> 'failed' THEN
                    MESSAGE('Voucher Status is %1', VoucherStatus)
                else
                    ERROR('Input voucher code/PIN invalid');
                MESSAGE('Voucher Balance is %1', FORMAT(remaining_value / 100));
            end;
    end;
    // Mapple NG 28032023 END - Getvoucherdetails
    /*  procedure GetVoucherAmt(VoucherNo: Code[20]; LocationCode: Code[20]): Decimal
     var
         vochamt: Decimal;
     begin
         CLEAR(HeaderDetailsModel);
         CLEAR(MapleVoucherClass);
         CLEAR(MapleGetVoucherModel);
         CLEAR(Data);
         CLEAR(Meta);
         IF RecLocation.GET(LocationCode) THEN;
         HeaderDetailsModel := HeaderDetailsModel.HeaderDetailsModel();
         RecResource.GET;
         HeaderDetailsModel.BaseUrlLink := RecResource."Voucher Base URL";//'http://xp-voucher-stg-sg-v1.sg-s1.cloudhub.io/api/vouchers/';///etx_001-'+VoucherNo
         HeaderDetailsModel.XClientId := RecLocation."Voucher Client ID";//'8b81ee70435b4996a411e3f309656941';
         HeaderDetailsModel.XClientSecret := RecLocation."Voucher Secret Code";//'54d30764eaCf4E9f816ed0E4FF664250';
         MapleVoucherClass := MapleVoucherClass.MapleVoucher();

         MapleGetVoucherModel := MapleGetVoucherModel.MapleGetVoucherModel();
         //MapleGetVoucherModel:= MapleVoucherClass.Getvoucherdetails('ETX_001','MAPLEV62V0L5',HeaderDetailsModel);
         MapleGetVoucherModel := MapleVoucherClass.Getvoucherdetails('ETX_001', VoucherNo, HeaderDetailsModel);
         Data := Data.Data();
         Meta := Meta.Meta();
         Data := MapleGetVoucherModel.Data;

         //MESSAGE(FORMAT(Data.ExpirationDate-(5.5*60*60000)));
         //MESSAGE(FORMAT(Data.RemainingValue/100));
         //Meta:= MapleGetVoucherModel.Meta;
         //MESSAGE(FORMAT(Meta.Status));
         vochamt := Data.RemainingValue;
         EXIT(vochamt / 100);
     end; */
    // Mapple NG 28032023 START - Getvoucherdetails
    procedure GetVoucherAmt(VoucherNo: Code[20]; LocationCode: Code[20]): Decimal
    var
        HttpContent: HttpContent;
        HttpHeaders: HttpHeaders;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        HttpClient: HttpClient;
        Url: Text;
        ResponseGetVoucherValue: Text;
        ResponseJsonObject: JsonObject;
        ResponseJsonToken: JsonToken;
        dataJsonObject: JsonObject;
        remaining_value: Decimal;
        metaJsonObject: JsonObject;
        linksJsonArray: JsonArray;
        VoucherStatus: Text;
    begin
        Clear(VoucherStatus);
        Clear(ResponseGetVoucherValue);
        Clear(remaining_value);
        IF RecLocation.GET(LocationCode) THEN;
        RecResource.GET();
        RecResource.TestField("Voucher Base URL");
        RecLocation.TestField("Voucher Client ID");
        RecLocation.TestField("Voucher Secret Code");
        //Url := 'https://xp-voucher-stg-sg-v1.sg-s1.cloudhub.io/api/vouchers/ETX_001-' + VoucherNo;
        Clear(Url);
        Url := RecResource."Voucher Base URL" + VoucherNo;
        //Url := 'https://xp-voucher-stg-sg-v1.sg-s1.cloudhub.io/api/vouchers/ETX_001-MAPLEJB6XMJ2';
        HttpContent.GetHeaders(HttpHeaders);
        HttpHeaders.Remove('Content-Type');
        HttpHeaders.Add('Content-Type', 'application/json');
        HttpHeaders.Add('X-Client-Id', RecLocation."Voucher Client ID"); //'4cda56f0482c4e60a86e76f47668c350');//RecLocation."Voucher Client ID");
        HttpHeaders.Add('X-Client-Secret', RecLocation."Voucher Secret Code"); //'a71BD3854A12426EB706E4c5de31c793');//RecLocation."Voucher Secret Code"); 
        HttpRequestMessage.Method := 'GET';
        HttpRequestMessage.SetRequestUri(Url);
        HttpRequestMessage.Content(HttpContent);
        if HttpClient.Send(HttpRequestMessage, HttpResponseMessage) then
            if HttpResponseMessage.IsSuccessStatusCode() then begin
                HttpResponseMessage.Content.ReadAs(ResponseGetVoucherValue);
                if RecResource."Show Json" then Message(ResponseGetVoucherValue);
                ResponseJsonObject.ReadFrom(ResponseGetVoucherValue);
                ResponseJsonObject.Get('data', ResponseJsonToken);
                dataJsonObject := ResponseJsonToken.AsObject();
                if dataJsonObject.Get('remaining_value', ResponseJsonToken) then remaining_value := ResponseJsonToken.AsValue().AsDecimal();
                //   Message('remaining_value %1', remaining_value);
                if dataJsonObject.Get('expiration_date', ResponseJsonToken) then //  Message(' expiration_date %1', ResponseJsonToken.AsValue().AsText());
                    ResponseJsonObject.Get('meta', ResponseJsonToken);
                metaJsonObject := ResponseJsonToken.AsObject();
                metaJsonObject.Get('status', ResponseJsonToken);
                VoucherStatus := ResponseJsonToken.AsValue().AsText();
            end;
        EXIT(remaining_value / 100);
    end;
    // Mapple NG 28032023 END - Getvoucherdetails
    /* procedure MapleAuth(VoucherAmt: Decimal; VoucherNo: Code[20]; VoucherPin: Text[20]; SONo: Code[20]; LocationCode: Code[20])
    var
        MapleAuthorizationvoucherapprovedModel: DotNet MapleAuthorizationvoucherapprovedModel;
        aMapleAuthorizationvoucherapprovedModel: DotNet MapleAuthorizationvoucherapprovedModel;
        Voucher: DotNet Voucher;
    begin
        CLEAR(HeaderDetailsModel);
        CLEAR(MapleVoucherClass);
        CLEAR(MapleGetVoucherModel);
        CLEAR(Data);
        CLEAR(Meta);
        CLEAR(Voucher);
        CLEAR(varArray4);
        CLEAR(MapleAuthorizationvoucherapprovedModel);
        IF RecLocation.GET(LocationCode) THEN;
        HeaderDetailsModel := HeaderDetailsModel.HeaderDetailsModel();
        RecResource.GET;
        HeaderDetailsModel.BaseUrlLink := RecResource."Voucher Auth Base URL";//'http://xp-voucher-stg-sg-v1.sg-s1.cloudhub.io/api/transactions?return_vouchers_info=true';
        HeaderDetailsModel.XClientId := RecLocation."Voucher Client ID";//'8b81ee70435b4996a411e3f309656941';
        HeaderDetailsModel.XClientSecret := RecLocation."Voucher Secret Code";//'54d30764eaCf4E9f816ed0E4FF664250';

        MapleAuthorizationvoucherapprovedModel := MapleAuthorizationvoucherapprovedModel.MapleAuthorizationvoucherapprovedModel();
        MapleAuthorizationvoucherapprovedModel.CaptureMode := 'manual';

        MapleAuthorizationvoucherapprovedModel.AcceptancePointRef := DELCHR(CREATEGUID, '=', '{,-,}');//"No.series".GetNextNo('VOUCHEREXP',TODAY,TRUE);//'A9691WIN225892963WGH6Y1422256';
        MapleAuthorizationvoucherapprovedModel.Currency := 'INR';
        //MESSAGE(FORMAT(MapleAuthorizationvoucherapprovedModel.AcceptancePointRef));
        //MapleAuthorizationvoucherapprovedModel.Vouchers:= Voucher;
        //MapleGetVoucherModel:= MapleVoucherClass.MapleAuthorizationvoucherapprovedManual(MapleAuthorizationvoucherapprovedModel,HeaderDetailsModel);
        Voucher := Voucher.Voucher();
        //MapleAuthorizationvoucherapprovedModel.Vouchers:=Voucher;
        Voucher.Ref := VoucherNo;
        Voucher.Value := VoucherAmt * 100;
        Voucher.ProductClass := 'ETX_001';
        Voucher.PinCode := VoucherPin;

        varArray4 := varArray4.CreateInstance(Voucher.GetType, 1);
        varArray4.SetValue(Voucher, 0);
        MapleAuthorizationvoucherapprovedModel.Vouchers := varArray4;
        //MESSAGE(FORMAT(varArray4.GetType));

        MapleVoucherClass := MapleVoucherClass.MapleVoucher();
        MapleGetVoucherModel := MapleGetVoucherModel.MapleGetVoucherModel();
        MapleGetVoucherModel := MapleVoucherClass.MapleAuthorizationvoucherapprovedManual(MapleAuthorizationvoucherapprovedModel, HeaderDetailsModel);
        Data := Data.Data();
        Meta := Meta.Meta();
        Data := MapleGetVoucherModel.Data();
        Meta := MapleGetVoucherModel.Meta();
        IF Meta.Status = 'succeeded' THEN BEGIN
            RecEinv.INIT;
            RecEinv."Entry No." := 0;
            RecEinv."Document No." := SONo;
            RecEinv."Vouchr. Integration" := TRUE;
            RecEinv."Vouchr. Code" := VoucherNo;
            RecEinv."Vouchr. Pin" := VoucherPin;
            RecEinv."Vochr.Acceptance Ref." := MapleAuthorizationvoucherapprovedModel.AcceptancePointRef;
            RecEinv."User ID" := USERID;
            RecEinv."Vouchr. Authorization ID" := Data.AuthorizationId;
            RecEinv."Vouchr.Redeem Date" := CURRENTDATETIME;
            RecEinv."Transaction Time" := CURRENTDATETIME;
            RecEinv."Vochr.Authorization Amount" := Data.AuthorizedAmount;
            RecEinv.INSERT;
            MESSAGE('Voucher Authorization done Successfully !!!');
        END;


        //MetaMessage.Text
        IF Meta.Status <> 'succeeded' THEN BEGIN
            // ERROR('Please check voucher code/ pin entered');
            //ERROR('Input Voucher code/PIN is invalid');
            FOR i := 0 TO Meta.Messages.Length - 1 DO BEGIN
                CLEAR(METTTA);
                METTTA := Meta.Messages.GetValue(i);
                IF METTTA.Code = 'ERV0001' THEN
                    ERROR('Input voucher code/PIN invalid')
                ELSE
                    IF METTTA.Code = 'ERV0009' THEN
                        ERROR('Invalid voucher code. Please contact Ticket Xpress Operator')
                    ELSE
                        ERROR(FORMAT(METTTA.Text));
            END;
        END;
        //MESSAGE(FORMAT(Meta.Status));
    end; */
    // Mapple NG 28032023 START - Getvoucherdetails
    procedure MapleAuth(VoucherAmt: Decimal; VoucherNo: Code[20]; VoucherPin: Text[20]; SONo: Code[20]; LocationCode: Code[20])
    var
        HttpContent: HttpContent;
        HttpHeaders: HttpHeaders;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        HttpClient: HttpClient;
        JAccessToken: JsonObject;
        ResponseText: Text;
        MapleAuthJsonObject: JsonObject;
        vouchersJsonArray: JsonArray;
        vouchersInfoJsonObject: JsonObject;
        ResponseGetVoucherValue: Text;
        ResponseJsonObject: JsonObject;
        ResponseJsonToken: JsonToken;
        dataJsonObject: JsonObject;
        authorization_id: Text;
        metaJsonObject: JsonObject;
        linksJsonArray: JsonArray;
        authorized_amount: Decimal;
        VoucherStatus: Text;
        acceptance_point_ref: Text;
    begin
        IF RecLocation.GET(LocationCode) THEN;
        RecResource.GET();
        RecResource.TestField("Voucher Auth Base URL");
        RecLocation.TestField("Voucher Client ID");
        RecLocation.TestField("Voucher Secret Code");
        Clear(MapleAuthJsonObject);
        MapleAuthJsonObject.Add('capture_mode', 'manual');
        Clear(acceptance_point_ref);
        acceptance_point_ref := Format(DELCHR(CREATEGUID(), '=', '{,-,}'));
        MapleAuthJsonObject.Add('acceptance_point_ref', acceptance_point_ref);
        MapleAuthJsonObject.Add('currency', 'INR');
        vouchersInfoJsonObject.Add('ref', VoucherNo); // MAPLEJB6XMJ2
        vouchersInfoJsonObject.Add('value', VoucherAmt * 100); //DELCHR(FORMAT(VoucherAmt * 100, 0, '<Precision,0><Standard Format,0>'), '=', ','));//'<Precision,2:2><Standard Format,2>'));
        vouchersInfoJsonObject.Add('product_class', 'ETX_001');
        vouchersInfoJsonObject.Add('pin_code', VoucherPin);
        vouchersJsonArray.Add(vouchersInfoJsonObject);
        MapleAuthJsonObject.Add('vouchers', vouchersJsonArray);
        if RecResource."Show Json" then Message(Format(MapleAuthJsonObject));
        HttpContent.WriteFrom(Format(MapleAuthJsonObject));
        HttpContent.GetHeaders(HttpHeaders);
        HttpHeaders.Remove('Content-Type');
        HttpHeaders.Add('Content-Type', 'application/json');
        HttpHeaders.Add('X-Client-Id', RecLocation."Voucher Client ID");
        HttpHeaders.Add('X-Client-Secret', RecLocation."Voucher Secret Code");
        /*   HttpHeaders.Add('acceptance_point_ref', DELCHR(CREATEGUID(), '=', '{,-,}');*/
        HttpRequestMessage.Method := 'POST';
        //https://xp-voucher-stg-sg-v1.sg-s1.cloudhub.io/api/transactions?return_vouchers_info=true
        HttpRequestMessage.SetRequestUri(RecResource."Voucher Auth Base URL");
        HttpRequestMessage.Content(HttpContent);
        if HttpClient.Send(HttpRequestMessage, HttpResponseMessage) then
            if HttpResponseMessage.IsSuccessStatusCode() then begin
                if HttpResponseMessage.Content.ReadAs(ResponseText) then if RecResource."Show Json" then Message(ResponseText);
                ResponseJsonObject.ReadFrom(ResponseText);
                ResponseJsonObject.Get('data', ResponseJsonToken);
                dataJsonObject := ResponseJsonToken.AsObject();
                Clear(authorization_id);
                if dataJsonObject.Get('authorization_id', ResponseJsonToken) then authorization_id := ResponseJsonToken.AsValue().AsText();
                //   Message('remaining_value %1', remaining_value);
                Clear(authorized_amount);
                if dataJsonObject.Get('authorized_amount', ResponseJsonToken) then //  Message(' expiration_date %1', ResponseJsonToken.AsValue().AsText());
                    authorized_amount := ResponseJsonToken.AsValue().AsDecimal();
                ResponseJsonObject.Get('meta', ResponseJsonToken);
                metaJsonObject := ResponseJsonToken.AsObject();
                metaJsonObject.Get('status', ResponseJsonToken);
                VoucherStatus := ResponseJsonToken.AsValue().AsText();
                IF VoucherStatus = 'succeeded' THEN BEGIN
                    RecEinv.INIT();
                    RecEinv."Entry No." := 0;
                    RecEinv."Document No." := SONo;
                    RecEinv."Vouchr. Integration" := TRUE;
                    RecEinv."Vouchr. Code" := VoucherNo;
                    RecEinv."Vouchr. Pin" := VoucherPin;
                    RecEinv."Vochr.Acceptance Ref." := acceptance_point_ref;
                    RecEinv."User ID" := USERID;
                    RecEinv."Vouchr. Authorization ID" := authorization_id;
                    RecEinv."Vouchr.Redeem Date" := CURRENTDATETIME;
                    RecEinv."Transaction Time" := CURRENTDATETIME;
                    RecEinv."Vochr.Authorization Amount" := authorized_amount;
                    RecEinv.INSERT();
                    MESSAGE('Voucher Authorization done Successfully !!!');
                END
                else
                    MESSAGE('Input voucher code/PIN invalid')
            end
            else
                if HttpResponseMessage.Content.ReadAs(ResponseText) then begin
                    JAccessToken.ReadFrom(ResponseText);
                    Message(ResponseText);
                end;
    end;
    // Mapple NG 28032023 END - Getvoucherdetails
    procedure MapleCapture1(SONo: Code[20]; LocationCode: Code[20])
    var
    /*  
     Voucher: DotNet Voucher;
      MapleAuthorizationvoucherapprovedModel: DotNet MapleAuthorizationvoucherapprovedModel;
      aMapleAuthorizationvoucherapprovedModel: DotNet MapleAuthorizationvoucherapprovedModel;
      InvoiceDetails: DotNet InvoiceDetails;
      CustomerDetails: DotNet CustomerDetails; 
    RecSH: Record "36";
    RecSIIH: Record "112";
    RecCust: Record "18";
    */
    begin
        /*
            CLEAR(MapleGetVoucherModelCap);
            CLEAR(MapleCaptureModelResponse);
            CLEAR(MapleCapture);
            CLEAR(HeaderDetailsModel);
            CLEAR(HeaderDetailsModel);
            CLEAR(MapleVoucherClass);
            CLEAR(MapleGetVoucherModel);
            CLEAR(Data);
            CLEAR(Meta);
            CLEAR(Voucher);
            CLEAR(varArray4);
            CLEAR(varArray5);
            CLEAR(MapleAuthorizationvoucherapprovedModel);
            IF RecLocation.GET(LocationCode) THEN;
            HeaderDetailsModel:= HeaderDetailsModel.HeaderDetailsModel();
            HeaderDetailsModel:= HeaderDetailsModel.HeaderDetailsModel();
            RecEinv.RESET;
            RecEinv.SETRANGE("Vouchr. Integration",TRUE);
            RecEinv.SETRANGE("Document No.",SONo);
            RecEinv.SETFILTER("Vouchr. Authorization ID",'<>%1','');
            IF RecEinv.FINDLAST THEN;

            RecResource.GET;

            //HeaderDetailsModel.BaseUrlLink:='http://xp-voucher-stg-sg-v1.sg-s1.cloudhub.io/api/transactions/edr-'+RecEinv."Vouchr. Authorization ID"+'/actions/capture?return_vouchers_info=true';
              HeaderDetailsModel.BaseUrlLink:= RecResource."Capture Base URL"+RecEinv."Vouchr. Authorization ID"+'/actions/capture?return_vouchers_info=true';
            HeaderDetailsModel.XClientId:=RecLocation."Voucher Client ID";//'8b81ee70435b4996a411e3f309656941';
            HeaderDetailsModel.XClientSecret:=RecLocation."Voucher Secret Code";//'54d30764eaCf4E9f816ed0E4FF664250';


            MapleCapture:= MapleCapture.MapleCaptureModelRequest();
            MapleCapture.AcceptancePointRef:= DELCHR(CREATEGUID,'=','{,-,}');//RecEinv."Vochr.Acceptance Ref.";
            {
            MapleAuthorizationvoucherapprovedModel :=MapleAuthorizationvoucherapprovedModel.MapleAuthorizationvoucherapprovedModel();
            MapleAuthorizationvoucherapprovedModel.CaptureMode:='manual';

            MapleAuthorizationvoucherapprovedModel.AcceptancePointRef:= RecEinv."Vochr.Acceptance Ref.";
            MapleAuthorizationvoucherapprovedModel.Currency:='INR';
            }
            //MapleAuthorizationvoucherapprovedModel :=MapleAuthorizationvoucherapprovedModel.MapleAuthorizationvoucherapprovedModel();
            //MapleAuthorizationvoucherapprovedModel.Vouchers:= Voucher;
            //MapleGetVoucherModel:= MapleVoucherClass.MapleAuthorizationvoucherapprovedManual(MapleAuthorizationvoucherapprovedModel,HeaderDetailsModel);
            Voucher :=Voucher.Voucher();
            //MapleAuthorizationvoucherapprovedModel.Vouchers:=Voucher;

            Voucher.Ref:= UPPERCASE(RecEinv."Vouchr. Code");
            Voucher.Value:= RecEinv."Vochr.Authorization Amount";
            Voucher.ProductClass :='ETX_001';
            Voucher.PinCode:= (RecEinv."Vouchr. Pin");

            varArray4 := varArray4.CreateInstance(Voucher.GetType,1);
            varArray4.SetValue(Voucher,0);
            //MapleAuthorizationvoucherapprovedModel.Vouchers:=varArray4;
            MapleCapture.Vouchers:= varArray4;
            //MESSAGE(FORMAT(varArray4.GetType));
            InvoiceDetails:= InvoiceDetails.InvoiceDetails();
            MapleCapture.InvoiceDetails:=InvoiceDetails;
            CustomerDetails:=CustomerDetails.CustomerDetails();
            MapleCapture.CustomerDetails:=CustomerDetails;
            IF RecSIIH.GET(SONo) THEN BEGIN
              RecSIIH.CALCFIELDS("Amount To Customer UPIT");
            InvoiceDetails.Ref:=RecSIIH."No.";
            InvoiceDetails.Amount:=RecSIIH."Amount To Customer UPIT"*100;
            IF RecCust.GET(RecSIIH."Sell-to Customer No.") THEN;
            CustomerDetails.PhoneNumber:='+91'+RecCust."Phone No.";
            CustomerDetails.EmailAddress:=RecCust."E-Mail";
            END;
            RecSH.RESET;
            RecSH.SETRANGE("No.",SONo);
            IF RecSH.FINDFIRST THEN BEGIN

              RecSH.CALCFIELDS("Amount To Customer UPIT");
            InvoiceDetails.Ref:=RecSH."No.";
            InvoiceDetails.Amount:=RecSH."Amount To Customer UPIT"*100;
            IF RecCust.GET(RecSH."Sell-to Customer No.") THEN;
            CustomerDetails.PhoneNumber:='+91'+RecCust."Phone No.";
            CustomerDetails.EmailAddress:=RecCust."E-Mail";
            END;


            MapleVoucherClass := MapleVoucherClass.MapleVoucher();
            //MapleGetVoucherModel:=MapleGetVoucherModel.MapleGetVoucherModel();
            //MapleGetVoucherModel:= MapleVoucherClass.MapleAuthorizationvoucherapprovedManual(MapleAuthorizationvoucherapprovedModel,HeaderDetailsModel);
            //MapleGetVoucherModel := MapleVoucherClass.MapleCapture(MapleCapture,HeaderDetailsModel);
            //MapleGetVoucherModelCap := MapleGetVoucherModelCap.MapleGetVoucherModel();
            //MapleGetVoucherModelCap := MapleVoucherClass.MapleCapture(MapleCapture,HeaderDetailsModel);
            MapleCaptureModelResponse:= MapleCaptureModelResponse.MapleCaptureModelResponse();
            MapleCaptureModelResponse:= MapleVoucherClass.MapleCapture(MapleCapture,HeaderDetailsModel);
            //MESSAGE(FORMAT(MapleCaptureModelResponse.GetType));



            //mapl
            Data := Data.Data();
            Meta := Meta.Meta();
            Data:=MapleCaptureModelResponse.Data();
            Meta:= MapleCaptureModelResponse.Meta();
            //MESSAGE(FORMAT(Data.CaptureId));

            IF Meta.Status='succeeded' THEN BEGIN
              RecEinv.INIT;
              RecEinv."Entry No.":=0;
              RecEinv."Document No.":=SONo;
              RecEinv."Vouchr. Integration":=TRUE;
              RecEinv."User ID":= USERID;
              RecEinv."Vouchr. Capture id":= Data.CaptureId;
              RecEinv."Vouchr.Redeem Date":=CURRENTDATETIME;
              RecEinv."Transaction Time":= CURRENTDATETIME;
              RecEinv."Vouchr. Cap Amt":= Data.CapturedAmount;
              IF RecSIIH.GET(SONo) THEN BEGIN
              RecEinv."Vouchr. Code":= UPPERCASE(RecSIIH."Voucher Int. No.");
              RecEinv."Vouchr. Pin":= (RecSIIH."Voucher PIN");

              END ELSE BEGIN
              RecSH.RESET;
              RecSH.SETRANGE("No.",SONo);
              IF RecSH.FINDFIRST THEN;
              RecEinv."Vouchr. Code":= UPPERCASE(RecSH."Voucher Int. No.");
              RecEinv."Vouchr. Pin":= (RecSH."Voucher PIN");

              END;
              MESSAGE('Voucher Capture done Successfully !!!');
              RecEinv.INSERT;
             END;


            IF Meta.Status<>'succeeded' THEN BEGIN
            FOR i:=0 TO Meta.Messages.Length-1 DO BEGIN
              CLEAR(METTTA);
             METTTA:= Meta.Messages.GetValue(i);
             ERROR(FORMAT(METTTA.Text));
            END;
            END;
            */
    end;
    /*     procedure MapleRefund1(SONo: Code[20]; LocationCode: Code[20])
        var
            Voucher: DotNet Voucher;
            TextMsg: Text;
        begin

            CLEAR(MapleRefund);
            CLEAR(MapleRefundResponse);

            CLEAR(MapleGetVoucherModelCap);
            CLEAR(MapleCaptureModelResponse);
            CLEAR(MapleCapture);
            CLEAR(HeaderDetailsModel);
            CLEAR(MapleVoucherClass);
            CLEAR(MapleGetVoucherModel);
            CLEAR(Data);
            CLEAR(Meta);
            CLEAR(Voucher);
            CLEAR(varArray4);
            IF RecLocation.GET(LocationCode) THEN;
            HeaderDetailsModel := HeaderDetailsModel.HeaderDetailsModel();

            RecEinv.RESET;
            RecEinv.SETRANGE("Vouchr. Integration", TRUE);
            RecEinv.SETRANGE("Document No.", SONo);
            RecEinv.SETFILTER("Vouchr. Capture id", '<>%1', '');
            IF RecEinv.FINDLAST THEN;


            //MESSAGE(FORMAT(RecEinv."Vouchr. Capture id"));
            RecResource.GET;
            //HeaderDetailsModel.BaseUrlLink:='http://xp-voucher-stg-sg-v1.sg-s1.cloudhub.io/api/transactions/edr-'+RecEinv."Vouchr. Capture id"+'/actions/refund?return_vouchers_info=true';
            HeaderDetailsModel.BaseUrlLink := RecResource."Refund Base URL" + RecEinv."Vouchr. Capture id" + '/actions/refund?return_vouchers_info=true';
            HeaderDetailsModel.XClientId := RecLocation."Voucher Client ID";
            ;//'8b81ee70435b4996a411e3f309656941';
            HeaderDetailsModel.XClientSecret := RecLocation."Voucher Secret Code";//'54d30764eaCf4E9f816ed0E4FF664250';


            MapleRefund := MapleRefund.MapleRefundRequest;
            MapleRefund.AcceptancePointRef := DELCHR(CREATEGUID, '=', '{,-,}');//RecEinv."Vochr.Acceptance Ref.";

            Voucher := Voucher.Voucher();
            Voucher.Ref := UPPERCASE(RecEinv."Vouchr. Code");
            Voucher.PinCode := (RecEinv."Vouchr. Pin");
            Voucher.Value := RecEinv."Vouchr. Cap Amt";
            Voucher.ProductClass := 'ETX_001';
            varArray4 := varArray4.CreateInstance(Voucher.GetType, 1);
            varArray4.SetValue(Voucher, 0);
            MapleRefund.Vouchers := varArray4;

            MapleVoucherClass := MapleVoucherClass.MapleVoucher();
            MapleRefundResponse := MapleRefundResponse.MapleRefundResponse();
            MapleRefundResponse := MapleVoucherClass.MapleRefund(MapleRefund, HeaderDetailsModel);

            Data := Data.Data();
            Meta := Meta.Meta();
            Data := MapleRefundResponse.Data();
            Meta := MapleRefundResponse.Meta();
            //MESSAGE(FORMAT(Data.CaptureId));

            IF Meta.Status = 'succeeded' THEN BEGIN
                RecEinv.INIT;
                RecEinv."Entry No." := 0;
                RecEinv."Document No." := SONo;
                RecEinv."Vouchr. Integration" := TRUE;
                RecEinv."User ID" := USERID;
                RecEinv."Refund ID" := Data.RefundId;
                RecEinv."Transaction Time" := CURRENTDATETIME;
                RecEinv."Refund Amount" := Data.RefundedAmount;
                RecEinv."Transaction Time" := CURRENTDATETIME;
                RecEinv.INSERT;
                MESSAGE('Refund process successfully !!!');
            END;

            IF Meta.Status <> 'succeeded' THEN BEGIN
                FOR i := 0 TO Meta.Messages.Length - 1 DO BEGIN
                    CLEAR(METTTA);
                    METTTA := Meta.Messages.GetValue(i);
                    ERROR(FORMAT(METTTA.Text));
                END;
            END;
        end;
     */
    // Mapple NG 28032023 START - Getvoucherdetails
    procedure MapleRefund1(SONo: Code[20]; LocationCode: Code[20])
    var
        HttpContent: HttpContent;
        HttpHeaders: HttpHeaders;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        HttpClient: HttpClient;
        JAccessToken: JsonObject;
        ResponseText: Text;
        MapleAuthJsonObject: JsonObject;
        vouchersJsonArray: JsonArray;
        vouchersInfoJsonObject: JsonObject;
        ResponseGetVoucherValue: Text;
        ResponseJsonObject: JsonObject;
        ResponseJsonToken: JsonToken;
        dataJsonObject: JsonObject;
        authorization_id: Text;
        metaJsonObject: JsonObject;
        linksJsonArray: JsonArray;
        authorized_amount: Decimal;
        VoucherStatus: Text;
        acceptance_point_ref: Text;
    begin
        RecEinv.RESET();
        RecEinv.SETRANGE("Vouchr. Integration", TRUE);
        RecEinv.SETRANGE("Document No.", SONo);
        RecEinv.SETFILTER("Vouchr. Capture id", '<>%1', '');
        IF RecEinv.FINDLAST() THEN;
        IF RecLocation.GET(LocationCode) THEN;
        RecResource.GET();
        RecResource.TestField("Voucher Auth Base URL");
        RecLocation.TestField("Voucher Client ID");
        RecLocation.TestField("Voucher Secret Code");
        Clear(MapleAuthJsonObject);
        MapleAuthJsonObject.Add('capture_mode', 'manual');
        Clear(acceptance_point_ref);
        acceptance_point_ref := Format(DELCHR(CREATEGUID(), '=', '{,-,}'));
        MapleAuthJsonObject.Add('acceptance_point_ref', acceptance_point_ref);
        MapleAuthJsonObject.Add('currency', 'INR');
        vouchersInfoJsonObject.Add('ref', UPPERCASE(RecEinv."Vouchr. Code"));
        vouchersInfoJsonObject.Add('value', FORMAT(RecEinv."Vouchr. Cap Amt", 0, '<Precision,2:2><Standard Format,2>'));
        vouchersInfoJsonObject.Add('product_class', 'ETX_001');
        vouchersInfoJsonObject.Add('pin_code', (RecEinv."Vouchr. Pin"));
        vouchersJsonArray.Add(vouchersInfoJsonObject);
        MapleAuthJsonObject.Add('vouchers', vouchersJsonArray);
        if RecResource."Show Json" then message(Format(MapleAuthJsonObject));
        HttpContent.WriteFrom(Format(MapleAuthJsonObject));
        HttpContent.GetHeaders(HttpHeaders);
        HttpHeaders.Remove('Content-Type');
        HttpHeaders.Add('Content-Type', 'application/json');
        HttpHeaders.Add('X-Client-Id', RecLocation."Voucher Client ID");
        HttpHeaders.Add('X-Client-Secret', RecLocation."Voucher Secret Code");
        /*   HttpHeaders.Add('acceptance_point_ref', DELCHR(CREATEGUID(), '=', '{,-,}');
          HttpHeaders.Add('capture_mode', 'manual');
          HttpHeaders.Add('currency', 'INR');
          HttpHeaders.Add('vouchers', VoucherNo); */
        HttpRequestMessage.Method := 'POST';
        //https://xp-voucher-stg-sg-v1.sg-s1.cloudhub.io/api/transactions/edr-0000100000000000024920210309004977853/actions/refund?return_vouchers_info=true
        HttpRequestMessage.SetRequestUri(RecResource."Refund Base URL" + RecEinv."Vouchr. Capture id" + '/actions/refund?return_vouchers_info=true'); //https://xp-voucher-stg-sg-v1.sg-s1.cloudhub.io/api/transactions/edr-
        HttpRequestMessage.Content(HttpContent);
        if HttpClient.Send(HttpRequestMessage, HttpResponseMessage) then
            if HttpResponseMessage.IsSuccessStatusCode() then begin
                if HttpResponseMessage.Content.ReadAs(ResponseText) then if RecResource."Show Json" then Message(ResponseText);
                ResponseJsonObject.ReadFrom(ResponseText);
                ResponseJsonObject.Get('data', ResponseJsonToken);
                dataJsonObject := ResponseJsonToken.AsObject();
                Clear(authorization_id);
                if dataJsonObject.Get('refund_id', ResponseJsonToken) then authorization_id := ResponseJsonToken.AsValue().AsText();
                //   Message('remaining_value %1', remaining_value);
                Clear(authorized_amount);
                if dataJsonObject.Get('refunded_amount', ResponseJsonToken) then //  Message(' expiration_date %1', ResponseJsonToken.AsValue().AsText());
                    authorized_amount := ResponseJsonToken.AsValue().AsDecimal();
                ResponseJsonObject.Get('meta', ResponseJsonToken);
                metaJsonObject := ResponseJsonToken.AsObject();
                metaJsonObject.Get('status', ResponseJsonToken);
                VoucherStatus := ResponseJsonToken.AsValue().AsText();
                IF VoucherStatus = 'succeeded' THEN BEGIN
                    RecEinv.INIT();
                    RecEinv."Entry No." := 0;
                    RecEinv."Document No." := SONo;
                    RecEinv."Vouchr. Integration" := TRUE;
                    RecEinv."User ID" := USERID;
                    RecEinv."Refund ID" := authorization_id;
                    RecEinv."Transaction Time" := CURRENTDATETIME;
                    RecEinv."Refund Amount" := authorized_amount;
                    RecEinv."Transaction Time" := CURRENTDATETIME;
                    RecEinv.INSERT();
                    MESSAGE('Refund process successfully !!!');
                END
                else
                    MESSAGE(VoucherStatus)
            end
            else
                if HttpResponseMessage.Content.ReadAs(ResponseText) then begin
                    JAccessToken.ReadFrom(ResponseText);
                    Message(ResponseText);
                end;
    end;
    // Mapple NG 28032023 END - Getvoucherdetails
    /* procedure MapleCancelAuthorization1(SONo: Code[20]; LocationCode: Code[20])
    var
        Voucher: DotNet Voucher;
    begin

        CLEAR(MapleCancelAuthorization);
        CLEAR(MapleCancelAuthorizationResponse);

        CLEAR(MapleGetVoucherModelCap);
        CLEAR(MapleCaptureModelResponse);
        CLEAR(MapleCapture);
        CLEAR(HeaderDetailsModel);
        CLEAR(MapleVoucherClass);
        CLEAR(MapleGetVoucherModel);
        CLEAR(Data);
        CLEAR(Meta);
        CLEAR(Voucher);
        CLEAR(varArray4);
        IF RecLocation.GET(LocationCode) THEN;
        HeaderDetailsModel := HeaderDetailsModel.HeaderDetailsModel();

        RecEinv.RESET;
        RecEinv.SETRANGE("Vouchr. Integration", TRUE);
        RecEinv.SETRANGE("Document No.", SONo);
        RecEinv.SETFILTER("Vouchr. Authorization ID", '<>%1', '');
        IF RecEinv.FINDLAST THEN;


        RecResource.GET;
        //HeaderDetailsModel.BaseUrlLink:='http://xp-voucher-stg-sg-v1.sg-s1.cloudhub.io/api/transactions/edr-'+RecEinv."Vouchr. Authorization ID"+'/actions/cancel';
        HeaderDetailsModel.BaseUrlLink := RecResource."Cancel Base URL" + RecEinv."Vouchr. Authorization ID" + '/actions/cancel';
        HeaderDetailsModel.XClientId := RecLocation."Voucher Client ID";//'8b81ee70435b4996a411e3f309656941';
        HeaderDetailsModel.XClientSecret := RecLocation."Voucher Secret Code";//'54d30764eaCf4E9f816ed0E4FF664250';

        MapleCancelAuthorization := MapleCancelAuthorization.MapleCancelAuthorizationRequest();
        MapleCancelAuthorization.AcceptancePointRef := DELCHR(CREATEGUID, '=', '{,-,}');// RecEinv."Vochr.Acceptance Ref.";
        MapleCancelAuthorization.Currency := 'INR';

        Voucher := Voucher.Voucher();
        Voucher.Ref := UPPERCASE(RecEinv."Vouchr. Code");
        Voucher.PinCode := (RecEinv."Vouchr. Pin");
        Voucher.Value := RecEinv."Vochr.Authorization Amount";
        Voucher.ProductClass := 'ETX_001';
        varArray4 := varArray4.CreateInstance(Voucher.GetType, 1);
        varArray4.SetValue(Voucher, 0);
        MapleCancelAuthorization.Vouchers := varArray4;

        MapleVoucherClass := MapleVoucherClass.MapleVoucher();
        MapleCancelAuthorizationResponse := MapleCancelAuthorizationResponse.MapleCancelAuthorizationResponse();
        MapleCancelAuthorizationResponse := MapleVoucherClass.MapleCancelAuthorization(MapleCancelAuthorization, HeaderDetailsModel);

        Data := Data.Data();
        Meta := Meta.Meta();
        Data := MapleCancelAuthorizationResponse.Data();
        Meta := MapleCancelAuthorizationResponse.Meta();


        IF Meta.Status = 'succeeded' THEN BEGIN
            RecEinv.INIT;
            RecEinv."Entry No." := 0;
            RecEinv."Document No." := SONo;
            RecEinv."Vouchr. Integration" := TRUE;
            // RecEinv."Vouchr. Pin":='';
            // RecEinv."Vouchr. Code":='';
            RecEinv."User ID" := USERID;
            RecEinv."Cancellation ID" := Data.CancellationId;
            RecEinv."Transaction Time" := CURRENTDATETIME;
            RecEinv."Cancellation Amount" := Data.CancelledAmount;
            RecEinv.INSERT;
            MESSAGE('Authorize cancel done successfully !!!');
        END;

        IF Meta.Status <> 'succeeded' THEN BEGIN
            FOR i := 0 TO Meta.Messages.Length - 1 DO BEGIN
                CLEAR(METTTA);
                METTTA := Meta.Messages.GetValue(i);
                ERROR(FORMAT(METTTA.Text));
            END;
        END;
    end; */
    // Mapple NG 28032023 START - Getvoucherdetails
    procedure MapleCancelAuthorization1(SONo: Code[20]; LocationCode: Code[20])
    var
        HttpContent: HttpContent;
        HttpHeaders: HttpHeaders;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        HttpClient: HttpClient;
        JAccessToken: JsonObject;
        ResponseText: Text;
        MapleAuthJsonObject: JsonObject;
        vouchersJsonArray: JsonArray;
        vouchersInfoJsonObject: JsonObject;
        ResponseGetVoucherValue: Text;
        ResponseJsonObject: JsonObject;
        ResponseJsonToken: JsonToken;
        dataJsonObject: JsonObject;
        authorization_id: Text;
        metaJsonObject: JsonObject;
        linksJsonArray: JsonArray;
        authorized_amount: Decimal;
        VoucherStatus: Text;
        acceptance_point_ref: Text;
    begin
        RecEinv.RESET();
        RecEinv.SETRANGE("Vouchr. Integration", TRUE);
        RecEinv.SETRANGE("Document No.", SONo);
        RecEinv.SETFILTER("Vouchr. Authorization ID", '<>%1', '');
        IF RecEinv.FINDLAST() THEN;
        IF RecLocation.GET(LocationCode) THEN;
        RecResource.GET();
        RecResource.TestField("Voucher Auth Base URL");
        RecLocation.TestField("Voucher Client ID");
        RecLocation.TestField("Voucher Secret Code");
        Clear(MapleAuthJsonObject);
        MapleAuthJsonObject.Add('capture_mode', 'manual');
        Clear(acceptance_point_ref);
        acceptance_point_ref := Format(DELCHR(CREATEGUID(), '=', '{,-,}'));
        MapleAuthJsonObject.Add('acceptance_point_ref', acceptance_point_ref);
        MapleAuthJsonObject.Add('currency', 'INR');
        vouchersInfoJsonObject.Add('ref', UPPERCASE(RecEinv."Vouchr. Code"));
        vouchersInfoJsonObject.Add('value', FORMAT(RecEinv."Vochr.Authorization Amount", 0, '<Precision,2:2><Standard Format,2>'));
        vouchersInfoJsonObject.Add('product_class', 'ETX_001');
        vouchersInfoJsonObject.Add('pin_code', (RecEinv."Vouchr. Pin"));
        vouchersJsonArray.Add(vouchersInfoJsonObject);
        MapleAuthJsonObject.Add('vouchers', vouchersJsonArray);
        HttpContent.WriteFrom(Format(MapleAuthJsonObject));
        HttpContent.GetHeaders(HttpHeaders);
        HttpHeaders.Remove('Content-Type');
        HttpHeaders.Add('Content-Type', 'application/json');
        HttpHeaders.Add('X-Client-Id', RecLocation."Voucher Client ID");
        HttpHeaders.Add('X-Client-Secret', RecLocation."Voucher Secret Code");
        /*   HttpHeaders.Add('acceptance_point_ref', DELCHR(CREATEGUID(), '=', '{,-,}');
          HttpHeaders.Add('capture_mode', 'manual');
          HttpHeaders.Add('currency', 'INR');
          HttpHeaders.Add('vouchers', VoucherNo); */
        HttpRequestMessage.Method := 'POST';
        //https://xp-voucher-stg-sg-v1.sg-s1.cloudhub.io/api/transactions/edr-0000100000000000024920210309004977845/actions/cancel
        HttpRequestMessage.SetRequestUri(RecResource."Cancel Base URL" + RecEinv."Vouchr. Authorization ID" + '/actions/cancel'); // https://xp-voucher-stg-sg-v1.sg-s1.cloudhub.io/api/transactions/edr-
        HttpRequestMessage.Content(HttpContent);
        if HttpClient.Send(HttpRequestMessage, HttpResponseMessage) then
            if HttpResponseMessage.IsSuccessStatusCode() then begin
                if HttpResponseMessage.Content.ReadAs(ResponseText) then if RecResource."Show Json" then Message(ResponseText);
                ResponseJsonObject.ReadFrom(ResponseText);
                ResponseJsonObject.Get('data', ResponseJsonToken);
                dataJsonObject := ResponseJsonToken.AsObject();
                Clear(authorization_id);
                if dataJsonObject.Get('cancellation_id', ResponseJsonToken) then authorization_id := ResponseJsonToken.AsValue().AsText();
                //   Message('remaining_value %1', remaining_value);
                Clear(authorized_amount);
                if dataJsonObject.Get('cancelled_amount', ResponseJsonToken) then //  Message(' expiration_date %1', ResponseJsonToken.AsValue().AsText());
                    authorized_amount := ResponseJsonToken.AsValue().AsDecimal();
                ResponseJsonObject.Get('meta', ResponseJsonToken);
                metaJsonObject := ResponseJsonToken.AsObject();
                metaJsonObject.Get('status', ResponseJsonToken);
                VoucherStatus := ResponseJsonToken.AsValue().AsText();
                IF VoucherStatus = 'succeeded' THEN BEGIN
                    RecEinv.INIT();
                    RecEinv."Entry No." := 0;
                    RecEinv."Document No." := SONo;
                    RecEinv."Vouchr. Integration" := TRUE;
                    // RecEinv."Vouchr. Pin":='';
                    // RecEinv."Vouchr. Code":='';
                    RecEinv."User ID" := USERID;
                    RecEinv."Cancellation ID" := authorization_id;
                    RecEinv."Transaction Time" := CURRENTDATETIME;
                    RecEinv."Cancellation Amount" := authorized_amount;
                    RecEinv.INSERT();
                    MESSAGE('Authorize cancel done successfully !!!');
                END
                else
                    MESSAGE(VoucherStatus)
            end
            else
                if HttpResponseMessage.Content.ReadAs(ResponseText) then begin
                    JAccessToken.ReadFrom(ResponseText);
                    Message(ResponseText);
                end;
    end;
    // Mapple NG 28032023 END - Getvoucherdetails
    // procedure MapleSearchTransactionss(SONo: Code[20]; LocationCode: Code[20])
    // var
    //     i: Integer;
    // begin
    //     CLEAR(HeaderDetailsModel);
    //     CLEAR(MapleVoucherClass);
    //     CLEAR(MapleGetVoucherModel);
    //     CLEAR(Data);
    //     CLEAR(Meta);
    //     CLEAR(varArray5);
    //     IF RecLocation.GET(LocationCode) THEN;
    //     RecEinv.RESET;
    //     RecEinv.SETRANGE("Vouchr. Integration", TRUE);
    //     RecEinv.SETRANGE("Document No.", SONo);
    //     RecEinv.SETFILTER("Vouchr. Authorization ID", '<>%1', '');
    //     IF RecEinv.FINDLAST THEN;
    //     HeaderDetailsModel := HeaderDetailsModel.HeaderDetailsModel();
    //     RecResource.GET;
    //     //HeaderDetailsModel.BaseUrlLink:='http://xp-voucher-stg-sg-v1.sg-s1.cloudhub.io/api/transactions/actions/search?return_vouchers_info=true';
    //     HeaderDetailsModel.BaseUrlLink := RecResource."Transaction Base URL";
    //     HeaderDetailsModel.XClientId := RecLocation."Voucher Client ID";//'8b81ee70435b4996a411e3f309656941';
    //     HeaderDetailsModel.XClientSecret := RecLocation."Voucher Secret Code";//'54d30764eaCf4E9f816ed0E4FF664250';
    //     MapleVoucherClass := MapleVoucherClass.MapleVoucher();
    //     MapleSearchTransaction := MapleSearchTransaction.MapleSearchTransactionRequest();
    //     MapleSearchTransaction.AcceptancePointRef := RecEinv."Vochr.Acceptance Ref.";
    //     /*
    //     MapleSearchTransaction.From:= CURRENTDATETIME;
    //     MapleSearchTransaction.to:=CURRENTDATETIME;
    //     */
    //     //MapleSearchTransaction.Type:=;
    //     MapleSearchTransaction.Status := 'Successful';
    //     MapleSearchTransaction.PageSize := 10;
    //     MapleSearchTransaction.PageIndex := 0;
    //     MapleVoucherClass := MapleVoucherClass.MapleVoucher();
    //     MapleSearchTransactionResponse := MapleVoucherClass.MapleMapleSearchTransaction(MapleSearchTransaction, HeaderDetailsModel);
    //     Data := Data.Data();
    //     Meta := Meta.Meta();
    //     Data := MapleSearchTransactionResponse.Data;
    //     Meta := MapleSearchTransactionResponse.Meta;
    //     Datum := Datum.Datum();
    //     MESSAGE(FORMAT(Meta.Status));
    //     //MESSAGE(FORMAT(Data.AuthorizationId));
    //     Datum := MapleSearchTransactionResponse.Data;
    //     FOR i := 0 TO 8 DO BEGIN
    //         varArray5 := varArray5.CreateInstance(Datum.GetType, i);
    //     END;
    //     //MESSAGE(FORMAT(Datum.GetType));
    //     FOR i := 0 TO 8 DO BEGIN
    //         varArray5.SetValue(Datum, i);
    //         MetaMessage := varArray5;
    //         varArray5.GetValue(i);
    //     END;
    //     MESSAGE(FORMAT(Datum.LastUpdated));
    // end;
    // Mapple NG 28032023 START - Getvoucherdetails
    procedure MapleSearchTransactionss(SONo: Code[20]; LocationCode: Code[20])
    var
        HttpContent: HttpContent;
        HttpHeaders: HttpHeaders;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        HttpClient: HttpClient;
        JAccessToken: JsonObject;
        ResponseText: Text;
        MapleAuthJsonObject: JsonObject;
        ResponseJsonObject: JsonObject;
        ResponseJsonToken: JsonToken;
        dataJsonArray: JsonArray;
        dataJsonObject: JsonObject;
        metaJsonObject: JsonObject;
        VoucherStatus: Text;
    begin
        IF RecLocation.GET(LocationCode) THEN;
        RecEinv.RESET();
        RecEinv.SETRANGE("Vouchr. Integration", TRUE);
        RecEinv.SETRANGE("Document No.", SONo);
        RecEinv.SETFILTER("Vouchr. Authorization ID", '<>%1', '');
        IF RecEinv.FINDLAST() THEN;
        RecResource.GET();
        RecResource.TestField("Transaction Base URL");
        RecLocation.TestField("Voucher Client ID");
        RecLocation.TestField("Voucher Secret Code");
        Clear(MapleAuthJsonObject);
        Clear(VoucherStatus);
        MapleAuthJsonObject.Add('capture_mode', 'manual');
        MapleAuthJsonObject.Add('acceptance_point_ref', RecEinv."Vochr.Acceptance Ref.");
        MapleAuthJsonObject.Add('status', 'Successful');
        MapleAuthJsonObject.Add('page_size', 10);
        MapleAuthJsonObject.Add('page_index', 0);
        HttpContent.WriteFrom(Format(MapleAuthJsonObject));
        HttpContent.GetHeaders(HttpHeaders);
        HttpHeaders.Remove('Content-Type');
        HttpHeaders.Add('Content-Type', 'application/json');
        HttpHeaders.Add('X-Client-Id', RecLocation."Voucher Client ID");
        HttpHeaders.Add('X-Client-Secret', RecLocation."Voucher Secret Code");
        HttpRequestMessage.Method := 'POST';
        //https://xp-voucher-stg-sg-v1.sg-s1.cloudhub.io/api/transactions/actions/search?return_vouchers_info=true
        HttpRequestMessage.SetRequestUri(RecResource."Transaction Base URL"); //https://xp-voucher-stg-sg-v1.sg-s1.cloudhub.io/api/transactions/actions/search?return_vouchers_info=true
        HttpRequestMessage.Content(HttpContent);
        if HttpClient.Send(HttpRequestMessage, HttpResponseMessage) then
            if HttpResponseMessage.IsSuccessStatusCode() then begin
                if HttpResponseMessage.Content.ReadAs(ResponseText) then if RecResource."Show Json" then Message(ResponseText);
                ResponseJsonObject.ReadFrom(ResponseText);
                ResponseJsonObject.Get('data', ResponseJsonToken);
                dataJsonArray := ResponseJsonToken.AsArray();
                foreach ResponseJsonToken in dataJsonArray do begin
                    dataJsonObject := ResponseJsonToken.AsObject();
                    dataJsonObject.Get('last_updated', ResponseJsonToken);
                    Message('%1', ResponseJsonToken.AsValue().AsText());
                end;
                ResponseJsonObject.Get('meta', ResponseJsonToken);
                metaJsonObject := ResponseJsonToken.AsObject();
                metaJsonObject.Get('status', ResponseJsonToken);
                VoucherStatus := ResponseJsonToken.AsValue().AsText();
                Message(VoucherStatus);
            end
            else
                if HttpResponseMessage.Content.ReadAs(ResponseText) then begin
                    JAccessToken.ReadFrom(ResponseText);
                    Message(ResponseText);
                end;
    end;
    // Mapple NG 28032023 END - Getvoucherdetails
    /* procedure MapleCapture2(SONo: Code[20]; LocationCode: Code[20]; VoucherNo: Code[20]; VoucherPIN: Text[20])
    var
        Voucher: DotNet Voucher;
        MapleAuthorizationvoucherapprovedModel: DotNet MapleAuthorizationvoucherapprovedModel;
        aMapleAuthorizationvoucherapprovedModel: DotNet MapleAuthorizationvoucherapprovedModel;
        InvoiceDetails: DotNet InvoiceDetails;
        CustomerDetails: DotNet CustomerDetails;
        RecSH: Record "36";
        RecSIIH: Record "112";
        RecCust: Record "18";
    begin
        CLEAR(MapleGetVoucherModelCap);
        CLEAR(MapleCaptureModelResponse);
        CLEAR(MapleCapture);
        CLEAR(HeaderDetailsModel);
        CLEAR(HeaderDetailsModel);
        CLEAR(MapleVoucherClass);
        CLEAR(MapleGetVoucherModel);
        CLEAR(Data);
        CLEAR(Meta);
        CLEAR(Voucher);
        CLEAR(varArray4);
        CLEAR(varArray5);
        CLEAR(MapleAuthorizationvoucherapprovedModel);
        IF RecLocation.GET(LocationCode) THEN;
        HeaderDetailsModel := HeaderDetailsModel.HeaderDetailsModel();
        HeaderDetailsModel := HeaderDetailsModel.HeaderDetailsModel();
        RecEinv.RESET();
        RecEinv.SETRANGE("Vouchr. Integration", TRUE);
        RecEinv.SETRANGE("Document No.", SONo);
        RecEinv.SETFILTER("Vouchr. Authorization ID", '<>%1', '');
        RecEinv.SETFILTER("Vouchr. Code", VoucherNo);
        IF RecEinv.FINDLAST() THEN;

        RecResource.GET();

        //HeaderDetailsModel.BaseUrlLink:='http://xp-voucher-stg-sg-v1.sg-s1.cloudhub.io/api/transactions/edr-'+RecEinv."Vouchr. Authorization ID"+'/actions/capture?return_vouchers_info=true';
        HeaderDetailsModel.BaseUrlLink := RecResource."Capture Base URL" + RecEinv."Vouchr. Authorization ID" + '/actions/capture?return_vouchers_info=true';
        HeaderDetailsModel.XClientId := RecLocation."Voucher Client ID";//'8b81ee70435b4996a411e3f309656941';
        HeaderDetailsModel.XClientSecret := RecLocation."Voucher Secret Code";//'54d30764eaCf4E9f816ed0E4FF664250';


        MapleCapture := MapleCapture.MapleCaptureModelRequest();
        MapleCapture.AcceptancePointRef := DELCHR(CREATEGUID(), '=', '{,-,}');//RecEinv."Vochr.Acceptance Ref.";

        Voucher := Voucher.Voucher();


        Voucher.Ref := UPPERCASE(RecEinv."Vouchr. Code");
        Voucher.Value := RecEinv."Vochr.Authorization Amount";
        Voucher.ProductClass := 'ETX_001';
        Voucher.PinCode := (RecEinv."Vouchr. Pin");

        varArray4 := varArray4.CreateInstance(Voucher.GetType, 1);
        varArray4.SetValue(Voucher, 0);

        MapleCapture.Vouchers := varArray4;

        InvoiceDetails := InvoiceDetails.InvoiceDetails();
        MapleCapture.InvoiceDetails := InvoiceDetails;
        CustomerDetails := CustomerDetails.CustomerDetails();
        MapleCapture.CustomerDetails := CustomerDetails;
        IF RecSIIH.GET(SONo) THEN BEGIN
            RecSIIH.CALCFIELDS("Amount To Customer UPIT");
            InvoiceDetails.Ref := RecSIIH."No.";
            InvoiceDetails.Amount := RecSIIH."Amount To Customer UPIT" * 100;
            IF RecCust.GET(RecSIIH."Sell-to Customer No.") THEN;
            CustomerDetails.PhoneNumber := '+91' + RecCust."Phone No.";
            CustomerDetails.EmailAddress := RecCust."E-Mail";
        END;
        RecSH.RESET;
        RecSH.SETRANGE("No.", SONo);
        IF RecSH.FINDFIRST THEN BEGIN

            RecSH.CALCFIELDS("Amount To Customer UPIT");
            InvoiceDetails.Ref := RecSH."No.";
            InvoiceDetails.Amount := RecSH."Amount To Customer UPIT" * 100;
            IF RecCust.GET(RecSH."Sell-to Customer No.") THEN;
            CustomerDetails.PhoneNumber := '+91' + RecCust."Phone No.";
            CustomerDetails.EmailAddress := RecCust."E-Mail";
        END;


        MapleVoucherClass := MapleVoucherClass.MapleVoucher();
        MapleCaptureModelResponse := MapleCaptureModelResponse.MapleCaptureModelResponse();
        MapleCaptureModelResponse := MapleVoucherClass.MapleCapture(MapleCapture, HeaderDetailsModel);
        //MESSAGE(FORMAT(MapleCaptureModelResponse.GetType));



        //mapl
        Data := Data.Data();
        Meta := Meta.Meta();
        Data := MapleCaptureModelResponse.Data();
        Meta := MapleCaptureModelResponse.Meta();
        //MESSAGE(FORMAT(Data.CaptureId));

        IF Meta.Status = 'succeeded' THEN BEGIN
            RecEinv.INIT();
            RecEinv."Entry No." := 0;
            RecEinv."Document No." := SONo;
            RecEinv."Vouchr. Integration" := TRUE;
            RecEinv."User ID" := USERID;
            RecEinv."Vouchr. Capture id" := Data.CaptureId;
            RecEinv."Vouchr.Redeem Date" := CURRENTDATETIME;
            RecEinv."Transaction Time" := CURRENTDATETIME;
            RecEinv."Vouchr. Cap Amt" := Data.CapturedAmount;
            IF RecSIIH.GET(SONo) THEN BEGIN
                RecEinv."Vouchr. Code" := UPPERCASE(VoucherNo);
                RecEinv."Vouchr. Pin" := (VoucherPIN);

            END ELSE BEGIN
                RecSH.RESET;
                RecSH.SETRANGE("No.", SONo);
                IF RecSH.FINDFIRST THEN;
                RecEinv."Vouchr. Code" := UPPERCASE(VoucherNo);
                RecEinv."Vouchr. Pin" := (VoucherPIN);

            END;
            MESSAGE('Voucher Capture done Successfully !!!');
            RecEinv.INSERT();
        END;
    end; */
    // Mapple NG 28032023 START - Getvoucherdetails
    procedure MapleCapture2(SONo: Code[20]; LocationCode: Code[20]; VoucherNo: Code[20]; VoucherPIN: Text[20])
    var
        RecSH: Record "Sales Header";
        RecSIIH: Record "Sales Invoice Header";
        RecCust: Record Customer;
        HttpContent: HttpContent;
        HttpHeaders: HttpHeaders;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        HttpClient: HttpClient;
        JAccessToken: JsonObject;
        ResponseText: Text;
        MapleAuthJsonObject: JsonObject;
        ResponseJsonObject: JsonObject;
        ResponseJsonToken: JsonToken;
        dataJsonArray: JsonArray;
        dataJsonObject: JsonObject;
        metaJsonObject: JsonObject;
        vouchersJsonArray: JsonArray;
        vouchersInfoJsonObject: JsonObject;
        InvoiceDetailsJsonObject: JsonObject;
        customer_detailsJsonObject: JsonObject;
        VoucherStatus: Text;
        CaptureId: Text;
        captured_amount: Decimal;
        ValueAmt: Decimal;
    begin
        IF RecLocation.GET(LocationCode) THEN;
        RecEinv.RESET();
        RecEinv.SETRANGE("Vouchr. Integration", TRUE);
        RecEinv.SETRANGE("Document No.", SONo);
        RecEinv.SETFILTER("Vouchr. Authorization ID", '<>%1', '');
        RecEinv.SETFILTER("Vouchr. Code", VoucherNo);
        IF RecEinv.FINDLAST() THEN;
        RecResource.GET();
        RecResource.TestField("Capture Base URL");
        RecLocation.TestField("Voucher Client ID");
        RecLocation.TestField("Voucher Secret Code");
        Clear(MapleAuthJsonObject);
        Clear(VoucherStatus);
        MapleAuthJsonObject.Add('acceptance_point_ref', DELCHR(CREATEGUID(), '=', '{,-,}'));
        vouchersInfoJsonObject.Add('ref', UPPERCASE(RecEinv."Vouchr. Code"));
        vouchersInfoJsonObject.Add('pin_code', RecEinv."Vouchr. Pin");
        Clear(ValueAmt);
        Evaluate(ValueAmt, format(RecEinv."Vochr.Authorization Amount", 0, '<Integer><Filler Character,0>'));
        // vouchersInfoJsonObject.Add('value', format(RecEinv."Vochr.Authorization Amount", 0, '<Integer><Filler Character,0>'));//RecEinv."Vochr.Authorization Amount");
        vouchersInfoJsonObject.Add('value', ValueAmt);
        vouchersInfoJsonObject.Add('product_class', 'ETX_001');
        vouchersJsonArray.Add(vouchersInfoJsonObject);
        MapleAuthJsonObject.Add('vouchers', vouchersJsonArray);
        RecSH.RESET();
        RecSH.SETRANGE("No.", SONo);
        IF RecSH.FINDFIRST() THEN BEGIN
            RecSH.CALCFIELDS("Amount To Customer UPIT");
            InvoiceDetailsJsonObject.Add('ref', RecSH."No.");
            InvoiceDetailsJsonObject.Add('amount', RecSH."Amount To Customer UPIT" * 100);
            MapleAuthJsonObject.Add('invoice_details', InvoiceDetailsJsonObject);
        end;
        IF RecCust.GET(RecSH."Sell-to Customer No.") THEN begin
            customer_detailsJsonObject.Add('email_address', RecCust."E-Mail");
            customer_detailsJsonObject.Add('phone_number', '+91' + RecCust."Phone No.");
            MapleAuthJsonObject.Add('customer_details', InvoiceDetailsJsonObject);
        end;
        HttpContent.WriteFrom(Format(MapleAuthJsonObject));
        HttpContent.GetHeaders(HttpHeaders);
        HttpHeaders.Remove('Content-Type');
        HttpHeaders.Add('Content-Type', 'application/json');
        HttpHeaders.Add('X-Client-Id', RecLocation."Voucher Client ID");
        HttpHeaders.Add('X-Client-Secret', RecLocation."Voucher Secret Code");
        HttpRequestMessage.Method := 'POST';
        //https://xp-voucher-stg-sg-v1.sg-s1.cloudhub.io/api/transactions/edr-0000100000000000024920210309004977852/actions/capture?return_vouchers_info=true
        HttpRequestMessage.SetRequestUri(RecResource."Capture Base URL" + RecEinv."Vouchr. Authorization ID" + '/actions/capture?return_vouchers_info=true');
        HttpRequestMessage.Content(HttpContent);
        if HttpClient.Send(HttpRequestMessage, HttpResponseMessage) then
            if HttpResponseMessage.IsSuccessStatusCode() then begin
                if HttpResponseMessage.Content.ReadAs(ResponseText) then if RecResource."Show Json" then Message(ResponseText);
                ResponseJsonObject.ReadFrom(ResponseText);
                ResponseJsonObject.Get('data', ResponseJsonToken);
                dataJsonObject := ResponseJsonToken.AsObject();
                Clear(CaptureId);
                if dataJsonObject.Get('capture_id', ResponseJsonToken) then CaptureId := ResponseJsonToken.AsValue().AsText();
                Clear(captured_amount);
                if dataJsonObject.Get('captured_amount', ResponseJsonToken) then captured_amount := ResponseJsonToken.AsValue().AsDecimal();
                ResponseJsonObject.Get('meta', ResponseJsonToken);
                metaJsonObject := ResponseJsonToken.AsObject();
                metaJsonObject.Get('status', ResponseJsonToken);
                VoucherStatus := ResponseJsonToken.AsValue().AsText();
                //Message(VoucherStatus);
                IF VoucherStatus = 'succeeded' THEN BEGIN
                    RecEinv.INIT();
                    RecEinv."Entry No." := 0;
                    RecEinv."Document No." := SONo;
                    RecEinv."Vouchr. Integration" := TRUE;
                    RecEinv."User ID" := USERID;
                    RecEinv."Vouchr. Capture id" := CaptureId;
                    RecEinv."Vouchr.Redeem Date" := CURRENTDATETIME;
                    RecEinv."Transaction Time" := CURRENTDATETIME;
                    RecEinv."Vouchr. Cap Amt" := captured_amount;
                    IF RecSIIH.GET(SONo) THEN BEGIN
                        RecEinv."Vouchr. Code" := UPPERCASE(VoucherNo);
                        RecEinv."Vouchr. Pin" := (VoucherPIN);
                    END
                    ELSE BEGIN
                        RecSH.RESET;
                        RecSH.SETRANGE("No.", SONo);
                        IF RecSH.FINDFIRST THEN;
                        RecEinv."Vouchr. Code" := UPPERCASE(VoucherNo);
                        RecEinv."Vouchr. Pin" := (VoucherPIN);
                    END;
                    MESSAGE('Voucher Capture done Successfully !!!');
                    RecEinv.INSERT();
                END;
            end
            else
                if HttpResponseMessage.Content.ReadAs(ResponseText) then begin
                    JAccessToken.ReadFrom(ResponseText);
                    Message(ResponseText);
                end;
    end;
    // Mapple NG 28032023 END - Getvoucherdetails
    /* procedure MapleRefund2(SONo: Code[20]; LocationCode: Code[20]; VoucherNo: Code[20]; VoucherPIN: Text[20])
    var
        Voucher: DotNet Voucher;
        TextMsg: Text;
    begin

        CLEAR(MapleRefund);
        CLEAR(MapleRefundResponse);

        CLEAR(MapleGetVoucherModelCap);
        CLEAR(MapleCaptureModelResponse);
        CLEAR(MapleCapture);
        CLEAR(HeaderDetailsModel);
        CLEAR(MapleVoucherClass);
        CLEAR(MapleGetVoucherModel);
        CLEAR(Data);
        CLEAR(Meta);
        CLEAR(Voucher);
        CLEAR(varArray4);
        IF RecLocation.GET(LocationCode) THEN;
        HeaderDetailsModel := HeaderDetailsModel.HeaderDetailsModel();

        RecEinv.RESET();
        RecEinv.SETRANGE("Vouchr. Integration", TRUE);
        RecEinv.SETRANGE("Document No.", SONo);
        RecEinv.SETFILTER("Vouchr. Capture id", '<>%1', '');
        RecEinv.SETFILTER("Vouchr. Code", VoucherNo);
        IF RecEinv.FINDLAST() THEN;


        //MESSAGE(FORMAT(RecEinv."Vouchr. Capture id"));
        RecResource.GET();
        //HeaderDetailsModel.BaseUrlLink:='http://xp-voucher-stg-sg-v1.sg-s1.cloudhub.io/api/transactions/edr-'+RecEinv."Vouchr. Capture id"+'/actions/refund?return_vouchers_info=true';
        HeaderDetailsModel.BaseUrlLink := RecResource."Refund Base URL" + RecEinv."Vouchr. Capture id" + '/actions/refund?return_vouchers_info=true';
        HeaderDetailsModel.XClientId := RecLocation."Voucher Client ID";
        ;//'8b81ee70435b4996a411e3f309656941';
        HeaderDetailsModel.XClientSecret := RecLocation."Voucher Secret Code";//'54d30764eaCf4E9f816ed0E4FF664250';


        MapleRefund := MapleRefund.MapleRefundRequest;
        MapleRefund.AcceptancePointRef := DELCHR(CREATEGUID(), '=', '{,-,}');//RecEinv."Vochr.Acceptance Ref.";

        Voucher := Voucher.Voucher();
        Voucher.Ref := UPPERCASE(RecEinv."Vouchr. Code");
        Voucher.PinCode := (RecEinv."Vouchr. Pin");
        Voucher.Value := RecEinv."Vouchr. Cap Amt";
        Voucher.ProductClass := 'ETX_001';
        varArray4 := varArray4.CreateInstance(Voucher.GetType, 1);
        varArray4.SetValue(Voucher, 0);
        MapleRefund.Vouchers := varArray4;

        MapleVoucherClass := MapleVoucherClass.MapleVoucher();
        MapleRefundResponse := MapleRefundResponse.MapleRefundResponse();
        MapleRefundResponse := MapleVoucherClass.MapleRefund(MapleRefund, HeaderDetailsModel);

        Data := Data.Data();
        Meta := Meta.Meta();
        Data := MapleRefundResponse.Data();
        Meta := MapleRefundResponse.Meta();
        //MESSAGE(FORMAT(Data.CaptureId));

        IF Meta.Status = 'succeeded' THEN BEGIN
            RecEinv.INIT();
            RecEinv."Entry No." := 0;
            RecEinv."Document No." := SONo;
            RecEinv."Vouchr. Integration" := TRUE;
            RecEinv."User ID" := USERID;
            RecEinv."Refund ID" := Data.RefundId;
            RecEinv."Transaction Time" := CURRENTDATETIME;
            RecEinv."Refund Amount" := Data.RefundedAmount;
            RecEinv."Transaction Time" := CURRENTDATETIME;
            RecEinv."Vouchr. Code" := VoucherNo;
            RecEinv."Vouchr. Pin" := VoucherPIN;
            RecEinv.INSERT();
            MESSAGE('Refund process successfully for %1 !!!', VoucherNo);
            RecVou.RESET();
            RecVou.SETRANGE("SO No.", SONo);
            RecVou.SETRANGE("Voucher Int. No.1", VoucherNo);
            RecVou.SETRANGE(Refund1, TRUE);
            IF RecVou.FINDFIRST() THEN BEGIN
                RecVou."Voucher Int. No.1" := '';
                RecVou."Voucher Amount1" := 0;
                RecVou."Voucher PIN1" := '';
                RecVou.Cancel1 := FALSE;
                RecVou.Refund1 := FALSE;
                RecVou.MODIFY();
            END;
            RecVou.RESET();
            RecVou.SETRANGE("SO No.", SONo);
            RecVou.SETRANGE("Voucher Int. No.2", VoucherNo);
            RecVou.SETRANGE(Refund2, TRUE);
            IF RecVou.FINDFIRST() THEN BEGIN
                RecVou."Voucher Int. No.2" := '';
                RecVou."Voucher Amount2" := 0;
                RecVou."Voucher PIN2" := '';
                RecVou.Refund2 := FALSE;
                RecVou.Cancel2 := FALSE;
                RecVou.MODIFY();
            END;
            RecVou.RESET();
            RecVou.SETRANGE("SO No.", SONo);
            RecVou.SETRANGE("Voucher Int. No.3", VoucherNo);
            RecVou.SETRANGE(Refund3, TRUE);
            IF RecVou.FINDFIRST() THEN BEGIN
                RecVou."Voucher Int. No.3" := '';
                RecVou."Voucher Amount3" := 0;
                RecVou."Voucher PIN3" := '';
                RecVou.Refund3 := FALSE;
                RecVou.MODIFY();
            END;
            RecVou.RESET();
            RecVou.SETRANGE("SO No.", SONo);
            RecVou.SETRANGE("Voucher Int. No.4", VoucherNo);
            RecVou.SETRANGE(Refund4, TRUE);
            IF RecVou.FINDFIRST() THEN BEGIN
                RecVou."Voucher Int. No.4" := '';
                RecVou."Voucher Amount4" := 0;
                RecVou."Voucher PIN4" := '';
                RecVou.Refund4 := FALSE;
                RecVou.MODIFY();
            END;
            RecVou.RESET();
            RecVou.SETRANGE("SO No.", SONo);
            RecVou.SETRANGE("Voucher Int. No.5", VoucherNo);
            RecVou.SETRANGE(Refund5, TRUE);
            IF RecVou.FINDFIRST() THEN BEGIN
                RecVou."Voucher Int. No.5" := '';
                RecVou."Voucher Amount5" := 0;
                RecVou."Voucher PIN5" := '';
                RecVou.Refund5 := FALSE;
                RecVou.MODIFY();
            END;
            RecVou.RESET();
            RecVou.SETRANGE("SO No.", SONo);
            RecVou.SETRANGE("Voucher Int. No.6", VoucherNo);
            RecVou.SETRANGE(Refund6, TRUE);
            IF RecVou.FINDFIRST() THEN BEGIN
                RecVou."Voucher Int. No.6" := '';
                RecVou."Voucher Amount6" := 0;
                RecVou."Voucher PIN6" := '';
                RecVou.Refund6 := FALSE;
                RecVou.MODIFY();
            END;
            RecVou.RESET();
            RecVou.SETRANGE("SO No.", SONo);
            RecVou.SETRANGE("Voucher Int. No.7", VoucherNo);
            RecVou.SETRANGE(Refund7, TRUE);
            IF RecVou.FINDFIRST() THEN BEGIN
                RecVou."Voucher Int. No.7" := '';
                RecVou."Voucher Amount7" := 0;
                RecVou."Voucher PIN7" := '';
                RecVou.Refund7 := FALSE;
                RecVou.MODIFY();
            END;
            RecVou.RESET();
            RecVou.SETRANGE("SO No.", SONo);
            RecVou.SETRANGE("Voucher Int. No.8", VoucherNo);
            RecVou.SETRANGE(Refund8, TRUE);
            IF RecVou.FINDFIRST() THEN BEGIN
                RecVou."Voucher Int. No.8" := '';
                RecVou."Voucher Amount8" := 0;
                RecVou."Voucher PIN8" := '';
                RecVou.Refund8 := FALSE;
                RecVou.MODIFY();
            END;
            RecVou.RESET();
            RecVou.SETRANGE("SO No.", SONo);
            RecVou.SETRANGE("Voucher Int. No.9", VoucherNo);
            RecVou.SETRANGE(Refund9, TRUE);
            IF RecVou.FINDFIRST() THEN BEGIN
                RecVou."Voucher Int. No.9" := '';
                RecVou."Voucher Amount9" := 0;
                RecVou."Voucher PIN9" := '';
                RecVou.Refund9 := FALSE;
                RecVou.MODIFY();
            END;
            RecVou.RESET();
            RecVou.SETRANGE("SO No.", SONo);
            RecVou.SETRANGE("Voucher Int. No.10", VoucherNo);
            RecVou.SETRANGE(Refund10, TRUE);
            IF RecVou.FINDFIRST() THEN BEGIN
                RecVou."Voucher Int. No.10" := '';
                RecVou."Voucher Amount10" := 0;
                RecVou."Voucher PIN10" := '';
                RecVou.Refund10 := FALSE;
                RecVou.MODIFY();
            END;
        END;
    end; */
    // Mapple NG 28032023 START - Getvoucherdetails
    procedure MapleRefund2(SONo: Code[20]; LocationCode: Code[20]; VoucherNo: Code[20]; VoucherPIN: Text[20])
    var
        TextMsg: Text;
        HttpContent: HttpContent;
        HttpHeaders: HttpHeaders;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        HttpClient: HttpClient;
        JAccessToken: JsonObject;
        ResponseText: Text;
        MapleAuthJsonObject: JsonObject;
        ResponseJsonObject: JsonObject;
        ResponseJsonToken: JsonToken;
        dataJsonArray: JsonArray;
        dataJsonObject: JsonObject;
        metaJsonObject: JsonObject;
        vouchersJsonArray: JsonArray;
        vouchersInfoJsonObject: JsonObject;
        InvoiceDetailsJsonObject: JsonObject;
        customer_detailsJsonObject: JsonObject;
        VoucherStatus: Text;
        CaptureId: Text;
        captured_amount: Decimal;
    begin
        IF RecLocation.GET(LocationCode) THEN;
        RecEinv.RESET();
        RecEinv.SETRANGE("Vouchr. Integration", TRUE);
        RecEinv.SETRANGE("Document No.", SONo);
        RecEinv.SETFILTER("Vouchr. Capture id", '<>%1', '');
        RecEinv.SETFILTER("Vouchr. Code", VoucherNo);
        IF RecEinv.FINDLAST() THEN;
        RecResource.GET();
        RecResource.TestField("Refund Base URL");
        RecLocation.TestField("Voucher Client ID");
        RecLocation.TestField("Voucher Secret Code");
        Clear(MapleAuthJsonObject);
        Clear(VoucherStatus);
        MapleAuthJsonObject.Add('acceptance_point_ref', DELCHR(CREATEGUID(), '=', '{,-,}'));
        vouchersInfoJsonObject.Add('ref', UPPERCASE(RecEinv."Vouchr. Code"));
        vouchersInfoJsonObject.Add('pin_code', RecEinv."Vouchr. Pin");
        vouchersInfoJsonObject.Add('value', RecEinv."Vouchr. Cap Amt");
        vouchersInfoJsonObject.Add('product_class', 'ETX_001');
        vouchersJsonArray.Add(vouchersInfoJsonObject);
        MapleAuthJsonObject.Add('vouchers', vouchersJsonArray);
        HttpContent.WriteFrom(Format(MapleAuthJsonObject));
        HttpContent.GetHeaders(HttpHeaders);
        HttpHeaders.Remove('Content-Type');
        HttpHeaders.Add('Content-Type', 'application/json');
        HttpHeaders.Add('X-Client-Id', RecLocation."Voucher Client ID");
        HttpHeaders.Add('X-Client-Secret', RecLocation."Voucher Secret Code");
        HttpRequestMessage.Method := 'POST';
        HttpRequestMessage.SetRequestUri(RecResource."Refund Base URL" + RecEinv."Vouchr. Capture id" + '/actions/refund?return_vouchers_info=true');
        HttpRequestMessage.Content(HttpContent);
        if HttpClient.Send(HttpRequestMessage, HttpResponseMessage) then
            if HttpResponseMessage.IsSuccessStatusCode() then begin
                if HttpResponseMessage.Content.ReadAs(ResponseText) then if RecResource."Show Json" then Message(ResponseText);
                ResponseJsonObject.ReadFrom(ResponseText);
                ResponseJsonObject.Get('data', ResponseJsonToken);
                dataJsonObject := ResponseJsonToken.AsObject();
                Clear(CaptureId);
                if dataJsonObject.Get('refund_id', ResponseJsonToken) then CaptureId := ResponseJsonToken.AsValue().AsText();
                Clear(captured_amount);
                if dataJsonObject.Get('refunded_amount', ResponseJsonToken) then captured_amount := ResponseJsonToken.AsValue().AsDecimal();
                ResponseJsonObject.Get('meta', ResponseJsonToken);
                metaJsonObject := ResponseJsonToken.AsObject();
                metaJsonObject.Get('status', ResponseJsonToken);
                VoucherStatus := ResponseJsonToken.AsValue().AsText();
                //Message(VoucherStatus);
                IF VoucherStatus = 'succeeded' THEN BEGIN
                    RecEinv.INIT();
                    RecEinv."Entry No." := 0;
                    RecEinv."Document No." := SONo;
                    RecEinv."Vouchr. Integration" := TRUE;
                    RecEinv."User ID" := USERID;
                    RecEinv."Refund ID" := CaptureId;
                    RecEinv."Transaction Time" := CURRENTDATETIME;
                    RecEinv."Refund Amount" := captured_amount;
                    RecEinv."Transaction Time" := CURRENTDATETIME;
                    RecEinv."Vouchr. Code" := VoucherNo;
                    RecEinv."Vouchr. Pin" := VoucherPIN;
                    RecEinv.INSERT();
                    MESSAGE('Refund process successfully for %1 !!!', VoucherNo);
                    RecVou.RESET();
                    RecVou.SETRANGE("SO No.", SONo);
                    RecVou.SETRANGE("Voucher Int. No.1", VoucherNo);
                    RecVou.SETRANGE(Refund1, TRUE);
                    IF RecVou.FINDFIRST() THEN BEGIN
                        RecVou."Voucher Int. No.1" := '';
                        RecVou."Voucher Amount1" := 0;
                        RecVou."Voucher PIN1" := '';
                        RecVou.Cancel1 := FALSE;
                        RecVou.Refund1 := FALSE;
                        RecVou.MODIFY();
                    END;
                    RecVou.RESET();
                    RecVou.SETRANGE("SO No.", SONo);
                    RecVou.SETRANGE("Voucher Int. No.2", VoucherNo);
                    RecVou.SETRANGE(Refund2, TRUE);
                    IF RecVou.FINDFIRST() THEN BEGIN
                        RecVou."Voucher Int. No.2" := '';
                        RecVou."Voucher Amount2" := 0;
                        RecVou."Voucher PIN2" := '';
                        RecVou.Refund2 := FALSE;
                        RecVou.Cancel2 := FALSE;
                        RecVou.MODIFY();
                    END;
                    RecVou.RESET();
                    RecVou.SETRANGE("SO No.", SONo);
                    RecVou.SETRANGE("Voucher Int. No.3", VoucherNo);
                    RecVou.SETRANGE(Refund3, TRUE);
                    IF RecVou.FINDFIRST() THEN BEGIN
                        RecVou."Voucher Int. No.3" := '';
                        RecVou."Voucher Amount3" := 0;
                        RecVou."Voucher PIN3" := '';
                        RecVou.Refund3 := FALSE;
                        RecVou.MODIFY();
                    END;
                    RecVou.RESET();
                    RecVou.SETRANGE("SO No.", SONo);
                    RecVou.SETRANGE("Voucher Int. No.4", VoucherNo);
                    RecVou.SETRANGE(Refund4, TRUE);
                    IF RecVou.FINDFIRST() THEN BEGIN
                        RecVou."Voucher Int. No.4" := '';
                        RecVou."Voucher Amount4" := 0;
                        RecVou."Voucher PIN4" := '';
                        RecVou.Refund4 := FALSE;
                        RecVou.MODIFY();
                    END;
                    RecVou.RESET();
                    RecVou.SETRANGE("SO No.", SONo);
                    RecVou.SETRANGE("Voucher Int. No.5", VoucherNo);
                    RecVou.SETRANGE(Refund5, TRUE);
                    IF RecVou.FINDFIRST() THEN BEGIN
                        RecVou."Voucher Int. No.5" := '';
                        RecVou."Voucher Amount5" := 0;
                        RecVou."Voucher PIN5" := '';
                        RecVou.Refund5 := FALSE;
                        RecVou.MODIFY();
                    END;
                    RecVou.RESET();
                    RecVou.SETRANGE("SO No.", SONo);
                    RecVou.SETRANGE("Voucher Int. No.6", VoucherNo);
                    RecVou.SETRANGE(Refund6, TRUE);
                    IF RecVou.FINDFIRST() THEN BEGIN
                        RecVou."Voucher Int. No.6" := '';
                        RecVou."Voucher Amount6" := 0;
                        RecVou."Voucher PIN6" := '';
                        RecVou.Refund6 := FALSE;
                        RecVou.MODIFY();
                    END;
                    RecVou.RESET();
                    RecVou.SETRANGE("SO No.", SONo);
                    RecVou.SETRANGE("Voucher Int. No.7", VoucherNo);
                    RecVou.SETRANGE(Refund7, TRUE);
                    IF RecVou.FINDFIRST() THEN BEGIN
                        RecVou."Voucher Int. No.7" := '';
                        RecVou."Voucher Amount7" := 0;
                        RecVou."Voucher PIN7" := '';
                        RecVou.Refund7 := FALSE;
                        RecVou.MODIFY();
                    END;
                    RecVou.RESET();
                    RecVou.SETRANGE("SO No.", SONo);
                    RecVou.SETRANGE("Voucher Int. No.8", VoucherNo);
                    RecVou.SETRANGE(Refund8, TRUE);
                    IF RecVou.FINDFIRST() THEN BEGIN
                        RecVou."Voucher Int. No.8" := '';
                        RecVou."Voucher Amount8" := 0;
                        RecVou."Voucher PIN8" := '';
                        RecVou.Refund8 := FALSE;
                        RecVou.MODIFY();
                    END;
                    RecVou.RESET();
                    RecVou.SETRANGE("SO No.", SONo);
                    RecVou.SETRANGE("Voucher Int. No.9", VoucherNo);
                    RecVou.SETRANGE(Refund9, TRUE);
                    IF RecVou.FINDFIRST() THEN BEGIN
                        RecVou."Voucher Int. No.9" := '';
                        RecVou."Voucher Amount9" := 0;
                        RecVou."Voucher PIN9" := '';
                        RecVou.Refund9 := FALSE;
                        RecVou.MODIFY();
                    END;
                    RecVou.RESET();
                    RecVou.SETRANGE("SO No.", SONo);
                    RecVou.SETRANGE("Voucher Int. No.10", VoucherNo);
                    RecVou.SETRANGE(Refund10, TRUE);
                    IF RecVou.FINDFIRST() THEN BEGIN
                        RecVou."Voucher Int. No.10" := '';
                        RecVou."Voucher Amount10" := 0;
                        RecVou."Voucher PIN10" := '';
                        RecVou.Refund10 := FALSE;
                        RecVou.MODIFY();
                    END;
                END;
            end
            else
                if HttpResponseMessage.Content.ReadAs(ResponseText) then begin
                    JAccessToken.ReadFrom(ResponseText);
                    Message(ResponseText);
                end;
    end;
    // Mapple NG 28032023 END - Getvoucherdetails
    /* procedure MapleCancelAuthorization2(SONo: Code[20]; LocationCode: Code[20]; VoucherNo: Code[20]; VoucherPIN: Text[20])
    var
    // Voucher: DotNet Voucher;
    begin

        CLEAR(MapleCancelAuthorization);
        CLEAR(MapleCancelAuthorizationResponse);

        CLEAR(MapleGetVoucherModelCap);
        CLEAR(MapleCaptureModelResponse);
        CLEAR(MapleCapture);
        CLEAR(HeaderDetailsModel);
        CLEAR(MapleVoucherClass);
        CLEAR(MapleGetVoucherModel);
        CLEAR(Data);
        CLEAR(Meta);
        CLEAR(Voucher);
        CLEAR(varArray4);
        IF RecLocation.GET(LocationCode) THEN;
        HeaderDetailsModel := HeaderDetailsModel.HeaderDetailsModel();

        RecEinv.RESET();
        RecEinv.SETRANGE("Vouchr. Integration", TRUE);
        RecEinv.SETRANGE("Document No.", SONo);
        RecEinv.SETFILTER("Vouchr. Authorization ID", '<>%1', '');
        IF RecEinv.FINDLAST() THEN;


        RecResource.GET();
        //HeaderDetailsModel.BaseUrlLink:='http://xp-voucher-stg-sg-v1.sg-s1.cloudhub.io/api/transactions/edr-'+RecEinv."Vouchr. Authorization ID"+'/actions/cancel';
        HeaderDetailsModel.BaseUrlLink := RecResource."Cancel Base URL" + RecEinv."Vouchr. Authorization ID" + '/actions/cancel';
        HeaderDetailsModel.XClientId := RecLocation."Voucher Client ID";//'8b81ee70435b4996a411e3f309656941';
        HeaderDetailsModel.XClientSecret := RecLocation."Voucher Secret Code";//'54d30764eaCf4E9f816ed0E4FF664250';

        MapleCancelAuthorization := MapleCancelAuthorization.MapleCancelAuthorizationRequest();
        MapleCancelAuthorization.AcceptancePointRef := DELCHR(CREATEGUID(), '=', '{,-,}');// RecEinv."Vochr.Acceptance Ref.";
        MapleCancelAuthorization.Currency := 'INR';

        Voucher := Voucher.Voucher();
        Voucher.Ref := UPPERCASE(RecEinv."Vouchr. Code");
        Voucher.PinCode := (RecEinv."Vouchr. Pin");
        Voucher.Value := RecEinv."Vochr.Authorization Amount";
        Voucher.ProductClass := 'ETX_001';
        varArray4 := varArray4.CreateInstance(Voucher.GetType, 1);
        varArray4.SetValue(Voucher, 0);
        MapleCancelAuthorization.Vouchers := varArray4;

        MapleVoucherClass := MapleVoucherClass.MapleVoucher();
        MapleCancelAuthorizationResponse := MapleCancelAuthorizationResponse.MapleCancelAuthorizationResponse();
        MapleCancelAuthorizationResponse := MapleVoucherClass.MapleCancelAuthorization(MapleCancelAuthorization, HeaderDetailsModel);

        Data := Data.Data();
        Meta := Meta.Meta();
        Data := MapleCancelAuthorizationResponse.Data();
        Meta := MapleCancelAuthorizationResponse.Meta();


        IF Meta.Status = 'succeeded' THEN BEGIN
            RecEinv.INIT();
            RecEinv."Entry No." := 0;
            RecEinv."Document No." := SONo;
            RecEinv."Vouchr. Integration" := TRUE;
            // RecEinv."Vouchr. Pin":='';
            // RecEinv."Vouchr. Code":='';
            RecEinv."User ID" := USERID;
            RecEinv."Cancellation ID" := Data.CancellationId;
            RecEinv."Transaction Time" := CURRENTDATETIME;
            RecEinv."Cancellation Amount" := Data.CancelledAmount;
            RecEinv."Vouchr. Code" := VoucherNo;
            RecEinv."Vouchr. Pin" := VoucherPIN;
            RecEinv.INSERT();
            MESSAGE('Authorize cancel done successfully  for %1 !!!', VoucherNo);
            RecVou.RESET();
            RecVou.SETRANGE("SO No.", SONo);
            RecVou.SETRANGE("Voucher Int. No.1", VoucherNo);
            RecVou.SETRANGE(Cancel1, TRUE);
            IF RecVou.FINDFIRST() THEN BEGIN
                RecVou."Voucher Int. No.1" := '';
                RecVou."Voucher Amount1" := 0;
                RecVou."Voucher PIN1" := '';
                RecVou.Cancel1 := FALSE;
                RecVou.MODIFY();
            END;
            RecVou.RESET();
            RecVou.SETRANGE("SO No.", SONo);
            RecVou.SETRANGE("Voucher Int. No.2", VoucherNo);
            RecVou.SETRANGE(Cancel2, TRUE);
            IF RecVou.FINDFIRST() THEN BEGIN
                RecVou."Voucher Int. No.2" := '';
                RecVou."Voucher Amount2" := 0;
                RecVou."Voucher PIN2" := '';
                RecVou.Cancel2 := FALSE;
                RecVou.MODIFY();
            END;
            RecVou.RESET();
            RecVou.SETRANGE("SO No.", SONo);
            RecVou.SETRANGE("Voucher Int. No.3", VoucherNo);
            RecVou.SETRANGE(Cancel3, TRUE);
            IF RecVou.FINDFIRST() THEN BEGIN
                RecVou."Voucher Int. No.3" := '';
                RecVou."Voucher Amount3" := 0;
                RecVou."Voucher PIN3" := '';
                RecVou.Cancel3 := FALSE;
                RecVou.MODIFY();
            END;
            RecVou.RESET();
            RecVou.SETRANGE("SO No.", SONo);
            RecVou.SETRANGE("Voucher Int. No.4", VoucherNo);
            RecVou.SETRANGE(Cancel4, TRUE);
            IF RecVou.FINDFIRST() THEN BEGIN
                RecVou."Voucher Int. No.4" := '';
                RecVou."Voucher Amount4" := 0;
                RecVou."Voucher PIN4" := '';
                RecVou.Cancel4 := FALSE;
                RecVou.MODIFY();
            END;
            RecVou.RESET();
            RecVou.SETRANGE("SO No.", SONo);
            RecVou.SETRANGE("Voucher Int. No.5", VoucherNo);
            RecVou.SETRANGE(Cancel5, TRUE);
            IF RecVou.FINDFIRST() THEN BEGIN
                RecVou."Voucher Int. No.5" := '';
                RecVou."Voucher Amount5" := 0;
                RecVou."Voucher PIN5" := '';
                RecVou.Cancel5 := FALSE;
                RecVou.MODIFY();
            END;
            RecVou.RESET();
            RecVou.SETRANGE("SO No.", SONo);
            RecVou.SETRANGE("Voucher Int. No.6", VoucherNo);
            RecVou.SETRANGE(Cancel6, TRUE);
            IF RecVou.FINDFIRST() THEN BEGIN
                RecVou."Voucher Int. No.6" := '';
                RecVou."Voucher Amount6" := 0;
                RecVou."Voucher PIN6" := '';
                RecVou.Cancel6 := FALSE;
                RecVou.MODIFY();
            END;
            RecVou.RESET();
            RecVou.SETRANGE("SO No.", SONo);
            RecVou.SETRANGE("Voucher Int. No.7", VoucherNo);
            RecVou.SETRANGE(Cancel7, TRUE);
            IF RecVou.FINDFIRST() THEN BEGIN
                RecVou."Voucher Int. No.7" := '';
                RecVou."Voucher Amount7" := 0;
                RecVou."Voucher PIN7" := '';
                RecVou.Cancel7 := FALSE;
                RecVou.MODIFY();
            END;
            RecVou.RESET();
            RecVou.SETRANGE("SO No.", SONo);
            RecVou.SETRANGE("Voucher Int. No.8", VoucherNo);
            RecVou.SETRANGE(Cancel8, TRUE);
            IF RecVou.FINDFIRST() THEN BEGIN
                RecVou."Voucher Int. No.8" := '';
                RecVou."Voucher Amount8" := 0;
                RecVou."Voucher PIN8" := '';
                RecVou.Cancel8 := FALSE;
                RecVou.MODIFY();
            END;
            RecVou.RESET();
            RecVou.SETRANGE("SO No.", SONo);
            RecVou.SETRANGE("Voucher Int. No.9", VoucherNo);
            RecVou.SETRANGE(Cancel9, TRUE);
            IF RecVou.FINDFIRST() THEN BEGIN
                RecVou."Voucher Int. No.9" := '';
                RecVou."Voucher Amount9" := 0;
                RecVou."Voucher PIN9" := '';
                RecVou.Cancel9 := FALSE;
                RecVou.MODIFY();
            END;
            RecVou.RESET();
            RecVou.SETRANGE("SO No.", SONo);
            RecVou.SETRANGE("Voucher Int. No.10", VoucherNo);
            RecVou.SETRANGE(Cancel10, TRUE);
            IF RecVou.FINDFIRST() THEN BEGIN
                RecVou."Voucher Int. No.10" := '';
                RecVou."Voucher Amount10" := 0;
                RecVou."Voucher PIN10" := '';
                RecVou.Cancel10 := FALSE;
                RecVou.MODIFY();
            END;
        END;

        //MESSAGE(FORMAT(Meta.Status));
    end; */
    // Mapple NG 28032023 START - Getvoucherdetails
    procedure MapleCancelAuthorization2(SONo: Code[20]; LocationCode: Code[20]; VoucherNo: Code[20]; VoucherPIN: Text[20])
    var
        HttpContent: HttpContent;
        HttpHeaders: HttpHeaders;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        HttpClient: HttpClient;
        JAccessToken: JsonObject;
        ResponseText: Text;
        MapleAuthJsonObject: JsonObject;
        ResponseJsonObject: JsonObject;
        ResponseJsonToken: JsonToken;
        dataJsonArray: JsonArray;
        dataJsonObject: JsonObject;
        metaJsonObject: JsonObject;
        vouchersJsonArray: JsonArray;
        vouchersInfoJsonObject: JsonObject;
        InvoiceDetailsJsonObject: JsonObject;
        customer_detailsJsonObject: JsonObject;
        VoucherStatus: Text;
        CaptureId: Text;
        captured_amount: Decimal;
    begin
        IF RecLocation.GET(LocationCode) THEN;
        RecEinv.RESET();
        RecEinv.SETRANGE("Vouchr. Integration", TRUE);
        RecEinv.SETRANGE("Document No.", SONo);
        RecEinv.SETFILTER("Vouchr. Authorization ID", '<>%1', '');
        IF RecEinv.FINDLAST() THEN;
        RecResource.GET();
        RecResource.TestField("Cancel Base URL");
        RecLocation.TestField("Voucher Client ID");
        RecLocation.TestField("Voucher Secret Code");
        //HeaderDetailsModel.BaseUrlLink:='http://xp-voucher-stg-sg-v1.sg-s1.cloudhub.io/api/transactions/edr-'+RecEinv."Vouchr. Authorization ID"+'/actions/cancel';
        Clear(MapleAuthJsonObject);
        Clear(VoucherStatus);
        MapleAuthJsonObject.Add('acceptance_point_ref', DELCHR(CREATEGUID(), '=', '{,-,}'));
        MapleAuthJsonObject.Add('currency', 'INR');
        vouchersInfoJsonObject.Add('ref', UPPERCASE(RecEinv."Vouchr. Code"));
        vouchersInfoJsonObject.Add('pin_code', RecEinv."Vouchr. Pin");
        vouchersInfoJsonObject.Add('value', RecEinv."Vochr.Authorization Amount");
        vouchersInfoJsonObject.Add('product_class', 'ETX_001');
        vouchersJsonArray.Add(vouchersInfoJsonObject);
        MapleAuthJsonObject.Add('vouchers', vouchersJsonArray);
        HttpContent.WriteFrom(Format(MapleAuthJsonObject));
        HttpContent.GetHeaders(HttpHeaders);
        HttpHeaders.Remove('Content-Type');
        HttpHeaders.Add('Content-Type', 'application/json');
        HttpHeaders.Add('X-Client-Id', RecLocation."Voucher Client ID");
        HttpHeaders.Add('X-Client-Secret', RecLocation."Voucher Secret Code");
        HttpRequestMessage.Method := 'POST';
        HttpRequestMessage.SetRequestUri(RecResource."Cancel Base URL" + RecEinv."Vouchr. Authorization ID" + '/actions/cancel');
        HttpRequestMessage.Content(HttpContent);
        if HttpClient.Send(HttpRequestMessage, HttpResponseMessage) then
            if HttpResponseMessage.IsSuccessStatusCode() then begin
                if HttpResponseMessage.Content.ReadAs(ResponseText) then if RecResource."Show Json" then Message(ResponseText);
                ResponseJsonObject.ReadFrom(ResponseText);
                ResponseJsonObject.Get('data', ResponseJsonToken);
                dataJsonObject := ResponseJsonToken.AsObject();
                Clear(CaptureId);
                if dataJsonObject.Get('cancellation_id', ResponseJsonToken) then CaptureId := ResponseJsonToken.AsValue().AsText();
                Clear(captured_amount);
                if dataJsonObject.Get('cancelled_amount', ResponseJsonToken) then captured_amount := ResponseJsonToken.AsValue().AsDecimal();
                ResponseJsonObject.Get('meta', ResponseJsonToken);
                metaJsonObject := ResponseJsonToken.AsObject();
                metaJsonObject.Get('status', ResponseJsonToken);
                VoucherStatus := ResponseJsonToken.AsValue().AsText();
                //Message(VoucherStatus);
                IF VoucherStatus = 'succeeded' THEN BEGIN
                    RecEinv.INIT();
                    RecEinv."Entry No." := 0;
                    RecEinv."Document No." := SONo;
                    RecEinv."Vouchr. Integration" := TRUE;
                    RecEinv."User ID" := USERID;
                    RecEinv."Cancellation ID" := CaptureId;
                    RecEinv."Transaction Time" := CURRENTDATETIME;
                    RecEinv."Cancellation Amount" := captured_amount;
                    RecEinv."Vouchr. Code" := VoucherNo;
                    RecEinv."Vouchr. Pin" := VoucherPIN;
                    RecEinv.INSERT();
                    MESSAGE('Authorize cancel done successfully  for %1 !!!', VoucherNo);
                    RecVou.RESET();
                    RecVou.SETRANGE("SO No.", SONo);
                    RecVou.SETRANGE("Voucher Int. No.1", VoucherNo);
                    RecVou.SETRANGE(Cancel1, TRUE);
                    IF RecVou.FINDFIRST() THEN BEGIN
                        RecVou."Voucher Int. No.1" := '';
                        RecVou."Voucher Amount1" := 0;
                        RecVou."Voucher PIN1" := '';
                        RecVou.Cancel1 := FALSE;
                        RecVou.MODIFY();
                    END;
                    RecVou.RESET();
                    RecVou.SETRANGE("SO No.", SONo);
                    RecVou.SETRANGE("Voucher Int. No.2", VoucherNo);
                    RecVou.SETRANGE(Cancel2, TRUE);
                    IF RecVou.FINDFIRST() THEN BEGIN
                        RecVou."Voucher Int. No.2" := '';
                        RecVou."Voucher Amount2" := 0;
                        RecVou."Voucher PIN2" := '';
                        RecVou.Cancel2 := FALSE;
                        RecVou.MODIFY();
                    END;
                    RecVou.RESET();
                    RecVou.SETRANGE("SO No.", SONo);
                    RecVou.SETRANGE("Voucher Int. No.3", VoucherNo);
                    RecVou.SETRANGE(Cancel3, TRUE);
                    IF RecVou.FINDFIRST() THEN BEGIN
                        RecVou."Voucher Int. No.3" := '';
                        RecVou."Voucher Amount3" := 0;
                        RecVou."Voucher PIN3" := '';
                        RecVou.Cancel3 := FALSE;
                        RecVou.MODIFY();
                    END;
                    RecVou.RESET();
                    RecVou.SETRANGE("SO No.", SONo);
                    RecVou.SETRANGE("Voucher Int. No.4", VoucherNo);
                    RecVou.SETRANGE(Cancel4, TRUE);
                    IF RecVou.FINDFIRST() THEN BEGIN
                        RecVou."Voucher Int. No.4" := '';
                        RecVou."Voucher Amount4" := 0;
                        RecVou."Voucher PIN4" := '';
                        RecVou.Cancel4 := FALSE;
                        RecVou.MODIFY();
                    END;
                    RecVou.RESET();
                    RecVou.SETRANGE("SO No.", SONo);
                    RecVou.SETRANGE("Voucher Int. No.5", VoucherNo);
                    RecVou.SETRANGE(Cancel5, TRUE);
                    IF RecVou.FINDFIRST() THEN BEGIN
                        RecVou."Voucher Int. No.5" := '';
                        RecVou."Voucher Amount5" := 0;
                        RecVou."Voucher PIN5" := '';
                        RecVou.Cancel5 := FALSE;
                        RecVou.MODIFY();
                    END;
                    RecVou.RESET();
                    RecVou.SETRANGE("SO No.", SONo);
                    RecVou.SETRANGE("Voucher Int. No.6", VoucherNo);
                    RecVou.SETRANGE(Cancel6, TRUE);
                    IF RecVou.FINDFIRST() THEN BEGIN
                        RecVou."Voucher Int. No.6" := '';
                        RecVou."Voucher Amount6" := 0;
                        RecVou."Voucher PIN6" := '';
                        RecVou.Cancel6 := FALSE;
                        RecVou.MODIFY();
                    END;
                    RecVou.RESET();
                    RecVou.SETRANGE("SO No.", SONo);
                    RecVou.SETRANGE("Voucher Int. No.7", VoucherNo);
                    RecVou.SETRANGE(Cancel7, TRUE);
                    IF RecVou.FINDFIRST() THEN BEGIN
                        RecVou."Voucher Int. No.7" := '';
                        RecVou."Voucher Amount7" := 0;
                        RecVou."Voucher PIN7" := '';
                        RecVou.Cancel7 := FALSE;
                        RecVou.MODIFY();
                    END;
                    RecVou.RESET();
                    RecVou.SETRANGE("SO No.", SONo);
                    RecVou.SETRANGE("Voucher Int. No.8", VoucherNo);
                    RecVou.SETRANGE(Cancel8, TRUE);
                    IF RecVou.FINDFIRST() THEN BEGIN
                        RecVou."Voucher Int. No.8" := '';
                        RecVou."Voucher Amount8" := 0;
                        RecVou."Voucher PIN8" := '';
                        RecVou.Cancel8 := FALSE;
                        RecVou.MODIFY();
                    END;
                    RecVou.RESET();
                    RecVou.SETRANGE("SO No.", SONo);
                    RecVou.SETRANGE("Voucher Int. No.9", VoucherNo);
                    RecVou.SETRANGE(Cancel9, TRUE);
                    IF RecVou.FINDFIRST() THEN BEGIN
                        RecVou."Voucher Int. No.9" := '';
                        RecVou."Voucher Amount9" := 0;
                        RecVou."Voucher PIN9" := '';
                        RecVou.Cancel9 := FALSE;
                        RecVou.MODIFY();
                    END;
                    RecVou.RESET();
                    RecVou.SETRANGE("SO No.", SONo);
                    RecVou.SETRANGE("Voucher Int. No.10", VoucherNo);
                    RecVou.SETRANGE(Cancel10, TRUE);
                    IF RecVou.FINDFIRST() THEN BEGIN
                        RecVou."Voucher Int. No.10" := '';
                        RecVou."Voucher Amount10" := 0;
                        RecVou."Voucher PIN10" := '';
                        RecVou.Cancel10 := FALSE;
                        RecVou.MODIFY();
                    END;
                END;
            end
            else
                if HttpResponseMessage.Content.ReadAs(ResponseText) then begin
                    JAccessToken.ReadFrom(ResponseText);
                    Message(ResponseText);
                end;
    end;
    // Mapple NG 28032023 END - Getvoucherdetails
    // procedure GetVoucherTEST(VoucherNo: Code[20]; LocationCode: Code[20])
    // begin
    //     CLEAR(HeaderDetailsModel);
    //     CLEAR(MapleVoucherClass);
    //     CLEAR(MapleGetVoucherModel);
    //     CLEAR(Data);
    //     CLEAR(Meta);
    //     IF RecLocation.GET(LocationCode) THEN;
    //     HeaderDetailsModel := HeaderDetailsModel.HeaderDetailsModel();
    //     RecResource.GET();
    //     HeaderDetailsModel.BaseUrlLink := RecResource."Voucher Base URL";//'http://xp-voucher-stg-sg-v1.sg-s1.cloudhub.io/api/vouchers/';///etx_001-'+VoucherNo
    //     HeaderDetailsModel.XClientId := RecLocation."Voucher Client ID";//'8b81ee70435b4996a411e3f309656941';
    //     HeaderDetailsModel.XClientSecret := RecLocation."Voucher Secret Code";//'54d30764eaCf4E9f816ed0E4FF664250';
    //     MapleVoucherClass := MapleVoucherClass.MapleVoucher();
    //     MapleGetVoucherModel := MapleGetVoucherModel.MapleGetVoucherModel();
    //     //MapleGetVoucherModel:= MapleVoucherClass.Getvoucherdetails('ETX_001','MAPLEV62V0L5',HeaderDetailsModel);
    //     MapleGetVoucherModel := MapleVoucherClass.Getvoucherdetails('ETX_001', VoucherNo, HeaderDetailsModel);
    //     Data := Data.Data();
    //     Meta := Meta.Meta();
    //     Meta := MapleGetVoucherModel.Meta;
    //     //METTTA:= METTTA.Message;
    //     //METTTA:= Meta.Messages;
    //     //MESSAGE(FORMAT(METTTA.Level));
    //     //ERROR(FORMAT(METTTA.Text));
    //     //varArray4 := varArray4.CreateInstance(METTTA.GetType,1);
    //     //varArray4:=METTTA.Message;
    //     //MESSAGE(FORMAT(METTTA.GetType));
    //     //MESSAGE(FORMAT(varArray4.GetValue(0)));
    //     //varArray4 := varArray4.CreateInstance(meta.GetType,1);
    //     //varArray4.Initialize;
    //     //varArray4:= varArray4.CreateInstance(Meta.GetType,1);
    //     //MESSAGE(FORMAT(Meta.Messages.Length-1));
    //     FOR i := 0 TO Meta.Messages.Length - 1 DO BEGIN
    //         CLEAR(METTTA);
    //         METTTA := Meta.Messages.GetValue(i);
    //         ERROR(FORMAT(METTTA.Text));
    //     END;
    //     /*
    //     JsonArray.ReadFrom(MetaMessage.Message);
    //     FOR i:=0 TO JsonArray.Count-1 DO BEGIN
    //     varArray4.SetValue(Meta.Messages,i);
    //     JsonArray.SelectToken(
    //      MESSAGE(FORMAT(varArray4.GetValue(i)));
    //     END;
    //     */
    //     //ERROR(FORMAT(METTTA.Text));
    //     //MESSAGE(FORMAT(Meta.Messages));
    //     //ERROR(FORMAT(METTTA.Text));
    //     IF Meta.Status <> 'failed' THEN
    //         MESSAGE('Voucher Status is %1', FORMAT(Meta.Status))
    //     ELSE
    //         // ERROR('Please check Input Voucher Code entered');
    //         ERROR('Input Voucher code/PIN is invalid');
    //     Data := MapleGetVoucherModel.Data;
    //     //MESSAGE(FORMAT(Data.ExpirationDate-(5.5*60*60000)));
    //     MESSAGE('Voucher Balance is %1', FORMAT(Data.RemainingValue / 100));
    // end;
    // Mapple NG 28032023 START - Getvoucherdetails
    procedure GetVoucherTEST(VoucherNo: Code[20]; LocationCode: Code[20])
    var
        HttpContent: HttpContent;
        HttpHeaders: HttpHeaders;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        HttpClient: HttpClient;
        JAccessToken: JsonObject;
        ResponseJsonObject: JsonObject;
        ResponseJsonToken: JsonToken;
        metaJsonObject: JsonObject;
        dataJsonObject: JsonObject;
        ResponseText: Text;
        VoucherStatus: Text;
        remaining_value: Decimal;
    begin
        IF RecLocation.GET(LocationCode) THEN;
        RecResource.GET();
        RecResource.TestField("Voucher Base URL");
        RecLocation.TestField("Voucher Client ID");
        RecLocation.TestField("Voucher Secret Code");
        HttpContent.GetHeaders(HttpHeaders);
        HttpHeaders.Remove('Content-Type');
        HttpHeaders.Add('Content-Type', 'application/json');
        HttpHeaders.Add('X-Client-Id', RecLocation."Voucher Client ID");
        HttpHeaders.Add('X-Client-Secret', RecLocation."Voucher Secret Code");
        HttpRequestMessage.Method := 'POST';
        HttpRequestMessage.SetRequestUri(RecResource."Voucher Base URL");
        HttpRequestMessage.Content(HttpContent);
        if HttpClient.Send(HttpRequestMessage, HttpResponseMessage) then
            if HttpResponseMessage.IsSuccessStatusCode() then begin
                if HttpResponseMessage.Content.ReadAs(ResponseText) then if RecResource."Show Json" then Message(ResponseText);
                ResponseJsonObject.ReadFrom(ResponseText);
                ResponseJsonObject.Get('data', ResponseJsonToken);
                dataJsonObject := ResponseJsonToken.AsObject();
                Clear(remaining_value);
                if dataJsonObject.Get('remaining_value', ResponseJsonToken) then remaining_value := ResponseJsonToken.AsValue().AsDecimal();
                ResponseJsonObject.Get('meta', ResponseJsonToken);
                metaJsonObject := ResponseJsonToken.AsObject();
                metaJsonObject.Get('status', ResponseJsonToken);
                VoucherStatus := ResponseJsonToken.AsValue().AsText();
                metaJsonObject.Get('text', ResponseJsonToken);
                Message('%1', ResponseJsonToken.AsValue().AsText());
                IF VoucherStatus <> 'failed' THEN
                    MESSAGE('Voucher Status is %1', VoucherStatus)
                ELSE
                    ERROR('Input Voucher code/PIN is invalid');
                MESSAGE('Voucher Balance is %1', FORMAT(remaining_value / 100));
                //Message(VoucherStatus);
            end
            else
                if HttpResponseMessage.Content.ReadAs(ResponseText) then begin
                    JAccessToken.ReadFrom(ResponseText);
                    Message(ResponseText);
                end;
    end;
    // Mapple NG 28032023 END - Getvoucherdetails
    local procedure "***********"()
    begin
    end;
    /* 
        // Cpmment no need
        procedure InitializeFromString(JSONString: Text): Boolean
        begin
            CLEAR(JsonObject);
            IF JSONString <> '' THEN
                EXIT(TryParseJObjectFromString(JsonObject, JSONString));

            InitializeEmptyObject();
            EXIT(TRUE);
        end; */
    /* 
        / Comment no ndeed
         [TryFunction]

         procedure TryParseJObjectFromString(var JObject: DotNet JObject; StringToParse: Variant)
         begin
             JObject := JObject.Parse(FORMAT(StringToParse));
         end;
      */
    /* 
        // Comment no ndeed
           procedure InitializeEmptyObject()
           begin
               JsonObject := JsonObject.JObject;
           end; */
    /* 
         // Comment no ndeed
          trigger JsonObject::PropertyChanged(sender: Variant; e: DotNet PropertyChangedEventArgs)
          begin
          end;

          trigger JsonObject::PropertyChanging(sender: Variant; e: DotNet PropertyChangingEventArgs)
          begin
          end;

          trigger JsonObject::ListChanged(sender: Variant; e: DotNet ListChangedEventArgs)
          begin
          end;

          trigger JsonObject::AddingNew(sender: Variant; e: DotNet AddingNewEventArgs)
          begin
          end;

          trigger JsonObject::CollectionChanged(sender: Variant; e: DotNet NotifyCollectionChangedEventArgs)
          begin
          end;

          trigger JsonArray::ListChanged(sender: Variant; e: DotNet ListChangedEventArgs)
          begin
          end;

          trigger JsonArray::AddingNew(sender: Variant; e: DotNet AddingNewEventArgs)
          begin
          end;

          trigger JsonArray::CollectionChanged(sender: Variant; e: DotNet NotifyCollectionChangedEventArgs)
          begin
          end; */
}
