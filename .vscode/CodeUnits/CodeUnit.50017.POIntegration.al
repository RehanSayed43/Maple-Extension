codeunit 50017 "PO  Integration"
{
    TableNo = "Purchase Header";

    trigger OnRun()
    begin
        DocumentNo := Rec."No.";
        InitializeValuePO(DocumentNo);
        InitializePO;
        InitializePOValuePO(DocumentNo);
        // Body := StringBuilder.ToString; //ccit_kj need to check
        MESSAGE(Body);
        //kppl ReadJSOnDataPO('http://erp.ibccube.in:4000/api/maple/updatepo',FALSE);
        /*
        Sales Orders
        DocumentNo:=Rec."No.";
        InitializeValueSO(DocumentNo);
        InitializeSO;
        InitializeSOValueSO(DocumentNo);
        Body:=StringBuilder.ToString;
        MESSAGE(Body);
        ReadJSOnDataSO('http://erp.ibccube.in:4000/api/maple/newretailsale',FALSE);
        */

    end;

    var
        //CCIT_kj++++
        /*  StringBuilder: DotNet StringBuilder;
         StringWriter: DotNet StringWriter;
         JsonTextWriter: DotNet JsonTextWriter;
         JsonFormatting: DotNet Formatting; */ //CCIT_kj+-----
        GlobalNULL: Variant;
        DocumentNo: Code[20];
        Body: Text;

    local procedure InitializePO()
    begin
        //kj++++
        /*   StringBuilder := StringBuilder.StringBuilder;
          StringWriter := StringWriter.StringWriter(StringBuilder);
          JsonTextWriter := JsonTextWriter.JsonTextWriter(StringWriter);
          JsonTextWriter.Formatting := JsonFormatting.Indented;
          CLEAR(GlobalNULL); */ //kj----
    end;

    local procedure InitializePOValuePO(DocNo: Code[20])
    var
        flag: Text;
        PORec: Record "Purchase Header";//"38";
        JsonTextWriter: JsonObject; //ccit_kj
    begin
        PORec.RESET;
        PORec.SETRANGE("No.", DocNo);
        IF PORec.FINDFIRST THEN BEGIN
            //CCIT_kj+++++
            // JsonTextWriter.WriteStartObject; //kj_ need to check
            JsonTextWriter.Add('No', PORec."No.");
            JsonTextWriter.Add('Buy-form Vendor No', PORec."Buy-from Vendor No.");
            JsonTextWriter.Add('Buy-form Contact No', PORec."Buy-from Contact No.");
            JsonTextWriter.Add('Buy-form Contact', PORec."Buy-from Contact");
            //JsonTextWriter.Add('Structure',PORec.Structure); //kj
            JsonTextWriter.Add('Posting Date', Format(PORec."Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'));
            JsonTextWriter.Add('Order Date', Format(PORec."Order Date", 0, '<Day,2>-<Month,2>-<Year4>'));
            JsonTextWriter.Add('Document Date', FORMAT(PORec."Document Date", 0, '<Day,2>-<Month,2>-<Year4>'));
            JsonTextWriter.Add('Vendor Shipment No', PORec."Vendor Shipment No.");
            JsonTextWriter.Add('Vendor Invoice No', PORec."Vendor Invoice No.");
            JsonTextWriter.Add('Vendor Invoice Date', FORMAT(PORec."Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'));
            JsonTextWriter.Add('Import Document No', 'hbdh');
            JsonTextWriter.Add('Order Address Code', PORec."Order Address Code");
            JsonTextWriter.Add('Purchase Code', PORec."Purchaser Code");
            JsonTextWriter.Add('Responsibility Center', PORec."Responsibility Center");
            JsonTextWriter.Add('Location Code', PORec."Location Code");
            JsonTextWriter.Add('Status', FORMAT(PORec.Status));
            JsonTextWriter.Add('Vendor Invoice Value', '');
            JsonTextWriter.Add('PO Validity Date', FORMAT(PORec."Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'));
            JsonTextWriter.Add('Closing Remark', '');
            JsonTextWriter.Add('Closed', '');
            JsonTextWriter.Add('Remarks Team', '');
            JsonTextWriter.Add('Remarks Vendor', '');
            JsonTextWriter.Add('CIN Number', '');
            JsonTextWriter.Add('Items', '');
            JsonTextWriter.Add('No', PORec."No.");
            // JsonTextWriter.WriteStartObject; //kj need to check
            InitializePOLineValuePO(DocumentNo);
            // JsonTextWriter.WriteEndObject; //kj need to check
            // JsonTextWriter.WriteEndObject; //kj need to check
        END;
    end;

    /*  JsonTextWriter.WriteStartObject; //kj_ need to check
     JsonTextWriter.WritePropertyName('No');
     JsonTextWriter.WriteValue(PORec."No.");
     JsonTextWriter.WritePropertyName('Buy-form Vendor No');
     JsonTextWriter.WriteValue(PORec."Buy-from Vendor No.");
     JsonTextWriter.WritePropertyName('Buy-form Contact No');
     JsonTextWriter.WriteValue(PORec."Buy-from Contact No.");
     JsonTextWriter.WritePropertyName('Buy-form Contact');
     JsonTextWriter.WriteValue(PORec."Buy-from Contact");
     JsonTextWriter.WritePropertyName('Structure');
     JsonTextWriter.WriteValue(PORec.Structure);
     JsonTextWriter.WritePropertyName('Posting Date');
     JsonTextWriter.WriteValue(FORMAT(PORec."Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'));
     JsonTextWriter.WritePropertyName('Order Date');
     JsonTextWriter.WriteValue(FORMAT(PORec."Order Date", 0, '<Day,2>-<Month,2>-<Year4>'));
     JsonTextWriter.WritePropertyName('Document Date');
     JsonTextWriter.WriteValue(FORMAT(PORec."Document Date", 0, '<Day,2>-<Month,2>-<Year4>'));
     JsonTextWriter.WritePropertyName('Vendor Shipment No');
     JsonTextWriter.WriteValue(PORec."Vendor Shipment No.");
     JsonTextWriter.WritePropertyName('Vendor Invoice No');
     JsonTextWriter.WriteValue(PORec."Vendor Invoice No.");
     JsonTextWriter.WritePropertyName('Vendor Invoice Date');
     JsonTextWriter.WriteValue(FORMAT(PORec."Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'));
     JsonTextWriter.WritePropertyName('Import Document No');
     JsonTextWriter.WriteValue('hbdh');
     JsonTextWriter.WritePropertyName('Order Address Code');
     JsonTextWriter.WriteValue(PORec."Order Address Code");
     JsonTextWriter.WritePropertyName('Purchase Code');
     JsonTextWriter.WriteValue(PORec."Purchaser Code");
     JsonTextWriter.WritePropertyName('Responsibility Center');
     JsonTextWriter.WriteValue(PORec."Responsibility Center");
     JsonTextWriter.WritePropertyName('Location Code');
     JsonTextWriter.WriteValue(PORec."Location Code");
     JsonTextWriter.WritePropertyName('Status');
     JsonTextWriter.WriteValue(FORMAT(PORec.Status));
     JsonTextWriter.WritePropertyName('Vendor Invoice Value');
     JsonTextWriter.WriteValue('');
     JsonTextWriter.WritePropertyName('PO Validity Date');
     JsonTextWriter.WriteValue(FORMAT(PORec."Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'));
     JsonTextWriter.WritePropertyName('Closing Remark');
     JsonTextWriter.WriteValue('');
     JsonTextWriter.WritePropertyName('Closed');
     JsonTextWriter.WriteValue('');
     JsonTextWriter.WritePropertyName('Remarks Team');
     JsonTextWriter.WriteValue('');
     JsonTextWriter.WritePropertyName('Remarks Vendor');
     JsonTextWriter.WriteValue('');
     JsonTextWriter.WritePropertyName('CIN Number');
     JsonTextWriter.WriteValue('');
     JsonTextWriter.WritePropertyName('Items');

   // JsonTextWriter.WriteStartObject; //kj need to check
    InitializePOLineValuePO(DocumentNo);
   // JsonTextWriter.WriteEndObject; //kj need to check
   // JsonTextWriter.WriteEndObject; //kj need to check
// END;*/


    //[Scope('Internal')] // CCIT_kj
    procedure InitializeValuePO(DocNo: Code[20])
    begin
        DocumentNo := DocNo;
    end;

    local procedure InitializePOLineValuePO(DocNo: Code[20])
    var
        PLRec: Record "Purchase Line";//"39";
        SnO: Integer;
        JsonTextWriter: JsonObject; //ccit_kj
    begin
        SnO := 0;
        PLRec.RESET;
        PLRec.SETRANGE("Document No.", DocNo);
        IF PLRec.FINDFIRST THEN
            REPEAT
                SnO += 1;
                //CCIT_kj+++++
                JsonTextWriter.Add('Type', PLRec.Type);
                JsonTextWriter.Add('No', PLRec."No.");
                JsonTextWriter.Add('UPN Code', '');
                JsonTextWriter.Add('Vendor Part Code', '');
                /* JsonTextWriter.Add('TDS Amount', PLRec."TDS Amount"); //kj+++
                JsonTextWriter.Add('TDS Nature of Deduction', PLRec."TDS Nature of Deduction");
                JsonTextWriter.Add('Assessee Code', PLRec."Assessee Code");
                JsonTextWriter.Add('TDS Base Amount', PLRec."TDS Base Amount"); */ //kj---
                JsonTextWriter.Add('Quantity', PLRec.Quantity);
                JsonTextWriter.Add('Qty to Receive', PLRec."Qty. to Receive");
                JsonTextWriter.Add('Description', PLRec.Description);
            //JsonTextWriter.WriteEndObject; //kj_need to check
            UNTIL PLRec.NEXT = 0;
    end;

    /* JsonTextWriter.WritePropertyName(FORMAT(SnO));
    JsonTextWriter.WriteStartObject;
    JsonTextWriter.WritePropertyName('Type');
    JsonTextWriter.WriteValue(PLRec.Type);
    JsonTextWriter.WritePropertyName('No');
    JsonTextWriter.WriteValue(PLRec."No.");
    JsonTextWriter.WritePropertyName('UPN Code');
    JsonTextWriter.WriteValue('');
    JsonTextWriter.WritePropertyName('Vendor Part Code');
    JsonTextWriter.WriteValue('');
    JsonTextWriter.WritePropertyName('TDS Amount');
    JsonTextWriter.WriteValue(PLRec."TDS Amount");
    JsonTextWriter.WritePropertyName('TDS Nature of Deduction');
    JsonTextWriter.WriteValue(PLRec."TDS Nature of Deduction");
    JsonTextWriter.WritePropertyName('Assessee Code');
    JsonTextWriter.WriteValue(PLRec."Assessee Code");
    JsonTextWriter.WritePropertyName('TDS Base Amount');
    JsonTextWriter.WriteValue(PLRec."TDS Base Amount");
    JsonTextWriter.WritePropertyName('Quantity');
    JsonTextWriter.WriteValue(PLRec.Quantity);
    JsonTextWriter.WritePropertyName('Qty to Receive');
    JsonTextWriter.WriteValue(PLRec."Qty. to Receive");
    JsonTextWriter.WritePropertyName('Description');
    JsonTextWriter.WriteValue(PLRec.Description);

    //CCIT_kj+++-----------
    JsonTextWriter.WriteEndObject;
UNTIL PLRec.NEXT = 0;
end;*/


    procedure ReadJSOnDataPO(URL: Text[1024]; AuthenAPI: Boolean)
    var
        "---": Integer;
        /*  HttpWebRequestMgt: Codeunit "1297"; //kj+++
         HttpStatusCode: DotNet HttpStatusCode;
         ResStreamReader: DotNet StreamReader;
         HttpWebRequest: DotNet HttpWebRequest;
         HttpWebResponse: DotNet HttpWebResponse;
         ResponseInStream: InStream;
         WebRequest: DotNet WebRequest;
         TextEncoding1: DotNet Encoding;
         StreamReader: DotNet StreamReader;
         String: DotNet String;
         Stream: DotNet Stream;
         check1: BigText; */

        HttpContent: HttpContent;
        HttpHeaders: HttpHeaders;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        HttpClient: HttpClient;

    //kj++-------
    begin
        // KJ ++
        HttpContent.WriteFrom(Body);
        HttpContent.GetHeaders(HttpHeaders);
        HttpClient.DefaultRequestHeaders.Add('Auth-Key', 'igvg31$@$GWVQA@$Gwvm@vm^aVAqr!@omg');
        HttpHeaders.Remove('Content-Type');
        HttpHeaders.Add('Content-Type', 'application/json');
        HttpRequestMessage.Method := 'POST';
        HttpRequestMessage.SetRequestUri(URL);
        HttpRequestMessage.Content(HttpContent);
        if HttpClient.Send(HttpRequestMessage, HttpResponseMessage) then
            if HttpResponseMessage.IsSuccessStatusCode() then begin
                //  if HttpResponseMessage.Content.ReadAs(String) then //kj_ need to check
                //  EVALUATE(check1, String); //kj_ need to check
            end
            ELSE BEGIN
                ERROR('No response from Authentication')
            END;
        // KJ ++--

        /*  HttpWebRequest := HttpWebRequest.HttpWebRequest;
         HttpWebRequest := WebRequest.Create(URL);
         HttpWebRequest.Method := 'POST';
         HttpWebRequest.ContentType := 'application/json';
         HttpWebRequest.Headers.Add('Auth-Key', 'igvg31$@$GWVQA@$Gwvm@vm^aVAqr!@omg');
         Stream := HttpWebRequest.GetRequestStream();
         Stream.Write(TextEncoding1.ASCII.GetBytes(Body), 0, TextEncoding1.ASCII.GetBytes(Body).Length);
         Stream.Close();
         HttpWebResponse := HttpWebResponse.HttpWebResponse;
         HttpWebResponse := HttpWebRequest.GetResponse();
         HttpStatusCode := HttpWebResponse.StatusCode();
         IF HttpStatusCode = 200 THEN BEGIN
             StreamReader := StreamReader.StreamReader(HttpWebResponse.GetResponseStream);
             String := StreamReader.ReadToEnd();
             EVALUATE(check1, String);
             MESSAGE(FORMAT(check1));
         END ELSE BEGIN
             ERROR('No response from Authentication')
         END; */
    end;

    local procedure InitializeSO()
    begin
        //ccit_kj- +++++
        /* StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JsonTextWriter := JsonTextWriter.JsonTextWriter(StringWriter);
        JsonTextWriter.Formatting := JsonFormatting.Indented;
        CLEAR(GlobalNULL); */ //ccit_kj----
    end;

    local procedure InitializeSOValueSO(DocNo: Code[20])
    var
        flag: Text;
        SORec: Record "Sales Header";//"36";
        JsonTextWriter: JsonObject; //ccit_kj

    begin
        SORec.RESET;
        SORec.SETRANGE("No.", DocNo);
        IF SORec.FINDFIRST THEN BEGIN
            //kj+++++
            JsonTextWriter.Add('User Type', '');
            JsonTextWriter.Add('No', SORec."No.");
            JsonTextWriter.Add('Sell-to Customer No', SORec."Sell-to Customer No.");
            JsonTextWriter.Add('Cust Mobile No', SORec."Sell-to Contact No.");
            JsonTextWriter.Add('Cust Email ID', '');
            JsonTextWriter.Add('Customer Name', SORec."Sell-to Customer Name");
            JsonTextWriter.Add('Ship-to Code', SORec."Ship-to Code");
            JsonTextWriter.Add('Posting Date', FORMAT(SORec."Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'));
            JsonTextWriter.Add('Shipment Date', FORMAT(SORec."Shipment Date", 0, '<Day,2>-<Month,2>-<Year4>'));
            JsonTextWriter.Add('External Document No', SORec."External Document No.");
            JsonTextWriter.Add('Salesperson Code', SORec."Salesperson Code");
            JsonTextWriter.Add('Location Code', SORec."Location Code");
            JsonTextWriter.Add('Total Customer Payment', '');
            //kj  //  SORec.CALCFIELDS("Amount to Customer");
            //kj  //  JsonTextWriter.Add('Invoice Value',SORec."Amount to Customer");
            //kj   //  JsonTextWriter.Add('Total Invoice Value with Shield',SORec."Amount to Customer");
            JsonTextWriter.Add('CreditSale', '');
            JsonTextWriter.Add('Vertical Code', '');
            JsonTextWriter.Add('Items', '');
            // InitializeSOLineValueSO(DocumentNo); //kj_ need to check
            // JsonTextWriter.WriteEndObject;  //kj_ need to check
            // JsonTextWriter.WriteEndObject; //kj_ need to check
        END;
    end;


    /* JsonTextWriter.WriteStartObject;
     JsonTextWriter.WritePropertyName('User Type');
     JsonTextWriter.WriteValue('');
     JsonTextWriter.WritePropertyName('No');
     JsonTextWriter.WriteValue(SORec."No.");
     JsonTextWriter.WritePropertyName('Sell-to Customer No');
     JsonTextWriter.WriteValue(SORec."Sell-to Customer No.");
     JsonTextWriter.WritePropertyName('Cust Mobile No');
     JsonTextWriter.WriteValue(SORec."Sell-to Contact No.");
     JsonTextWriter.WritePropertyName('Cust Email ID');
     JsonTextWriter.WriteValue('');
     JsonTextWriter.WritePropertyName('Customer Name');
     JsonTextWriter.WriteValue(SORec."Sell-to Customer Name");
     JsonTextWriter.WritePropertyName('Ship-to Code');
     JsonTextWriter.WriteValue(SORec."Ship-to Code");
     JsonTextWriter.WritePropertyName('Posting Date');
     JsonTextWriter.WriteValue(FORMAT(SORec."Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'));
     JsonTextWriter.WritePropertyName('Shipment Date');
     JsonTextWriter.WriteValue(FORMAT(SORec."Shipment Date", 0, '<Day,2>-<Month,2>-<Year4>'));
     JsonTextWriter.WritePropertyName('External Document No');
     JsonTextWriter.WriteValue(SORec."External Document No.");
     JsonTextWriter.WritePropertyName('Salesperson Code');
     JsonTextWriter.WriteValue(SORec."Salesperson Code");
     JsonTextWriter.WritePropertyName('Location Code');
     JsonTextWriter.WriteValue(SORec."Location Code");
     JsonTextWriter.WritePropertyName('Total Customer Payment');
     JsonTextWriter.WriteValue('');
     SORec.CALCFIELDS("Amount to Customer");
     JsonTextWriter.WritePropertyName('Invoice Value');
     JsonTextWriter.WriteValue(SORec."Amount to Customer");
     JsonTextWriter.WritePropertyName('Total Invoice Value with Shield');
     JsonTextWriter.WriteValue(SORec."Amount to Customer");
     JsonTextWriter.WritePropertyName('CreditSale');
     JsonTextWriter.WriteValue('');
     JsonTextWriter.WritePropertyName('Vertical Code');
     JsonTextWriter.WriteValue('');
     JsonTextWriter.WritePropertyName('Items');
     JsonTextWriter.WriteStartObject;
    InitializeSOLineValueSO(DocumentNo);
    JsonTextWriter.WriteEndObject;
    JsonTextWriter.WriteEndObject;
END;
end;*/ //ccit_kj---------

    // //kj
    procedure InitializeValueSO(DocNo: Code[20])
    begin
        DocumentNo := DocNo;
    end;

    local procedure InitializeSOLineValueSO(DocNo: Code[20])
    var
        SLRec: Record "Sales Line";//"37";
        SnO: Integer;
        JsonTextWriter: JsonObject; //ccit_kj
    begin
        SnO := 0;
        SLRec.RESET;
        SLRec.SETRANGE("Document No.", DocNo);
        IF SLRec.FINDFIRST THEN
            REPEAT
                SnO += 1;
                //CCIT_kj+++++
                // JsonTextWriter.WritePropertyName(FORMAT(SnO)); //CCIT_kjneed to check
                // JsonTextWriter.WriteStartObject; //CCIT_kjneed to check
                JsonTextWriter.Add('Type', SLRec.Type);
                JsonTextWriter.Add('UPN Code', SLRec."No.");
                JsonTextWriter.Add('No', SLRec."No.");
                JsonTextWriter.Add('Salesperson Code', '');
                JsonTextWriter.Add('Description', SLRec.Description);
                JsonTextWriter.Add('Unit Price Incl of Tax', SLRec."Unit Price Incl. of Tax");
                JsonTextWriter.Add('Quantity', SLRec.Quantity);
                JsonTextWriter.Add('Unit of Measure', SLRec."Unit of Measure Code");
                JsonTextWriter.Add('Unit Price Excl of Tax', SLRec."Unit Price Incl. of Tax");
                JsonTextWriter.Add('Line Amount Excl Tax', SLRec."Line Amount");
                JsonTextWriter.Add('Scheme Code', '');
                JsonTextWriter.Add('Deferral Code', SLRec."Deferral Code");
                JsonTextWriter.Add('Primary Category', '');
                JsonTextWriter.Add('Secondary Category', '');
                JsonTextWriter.Add('Third Category', '');
                JsonTextWriter.Add('Tax Group Code', SLRec."Tax Group Code");
                JsonTextWriter.Add('Tax Area Code', SLRec."Tax Area Code");
                // JsonTextWriter.Add('Amount To Customer UPIT', SLRec."Amount To Customer UPIT"); //CCIT_kj
                JsonTextWriter.Add('Shield Value', '');
                JsonTextWriter.Add('Shield Type', '');
                JsonTextWriter.Add('Shield', '');
                JsonTextWriter.Add('Shield Cost', '');
                JsonTextWriter.Add('Item Serial No', '');
                JsonTextWriter.Add('IMEI No', '');
                JsonTextWriter.Add('Capillary Line Discount Amount', '');
            //JsonTextWriter.WriteEndObject; //kj_ccit need to check
            UNTIL SLRec.NEXT = 0;
    end;


    /* JsonTextWriter.WritePropertyName(FORMAT(SnO));
     JsonTextWriter.WriteStartObject;
     //JsonTextWriter.WritePropertyName('Type');
     //JsonTextWriter.WriteValue(SLRec.Type);
     //JsonTextWriter.WritePropertyName('UPN Code');
     /// JsonTextWriter.WriteValue(SLRec."No.");
     //JsonTextWriter.WritePropertyName('No');
     // JsonTextWriter.WriteValue(SLRec."No.");
     JsonTextWriter.WritePropertyName('Salesperson Code');
     JsonTextWriter.WriteValue('');
     JsonTextWriter.WritePropertyName('Description');
     JsonTextWriter.WriteValue(SLRec.Description);
     JsonTextWriter.WritePropertyName('Unit Price Incl of Tax');
     JsonTextWriter.WriteValue(SLRec."Unit Price Incl. of Tax");
     JsonTextWriter.WritePropertyName('Quantity');
     JsonTextWriter.WriteValue(SLRec.Quantity);
     JsonTextWriter.WritePropertyName('Unit of Measure');
     JsonTextWriter.WriteValue(SLRec."Unit of Measure Code");
     JsonTextWriter.WritePropertyName('Unit Price Excl of Tax');
     JsonTextWriter.WriteValue(SLRec."Unit Price Incl. of Tax");
     JsonTextWriter.WritePropertyName('Line Amount Excl Tax');
     JsonTextWriter.WriteValue(SLRec."Line Amount");
     JsonTextWriter.WritePropertyName('Scheme Code');
     JsonTextWriter.WriteValue('');
     JsonTextWriter.WritePropertyName('Deferral Code');
     JsonTextWriter.WriteValue(SLRec."Deferral Code");
     JsonTextWriter.WritePropertyName('Primary Category');
     JsonTextWriter.WriteValue('');
     JsonTextWriter.WritePropertyName('Secondary Category');
     JsonTextWriter.WriteValue('');
     JsonTextWriter.WritePropertyName('Third Category');
     JsonTextWriter.WriteValue('');
     JsonTextWriter.WritePropertyName('Tax Group Code');
     JsonTextWriter.WriteValue(SLRec."Tax Group Code");
     JsonTextWriter.WritePropertyName('Tax Area Code');
     JsonTextWriter.WriteValue(SLRec."Tax Area Code");
     JsonTextWriter.WritePropertyName('Amount To Customer UPIT');
     JsonTextWriter.WriteValue(SLRec."Amount To Customer UPIT");
     JsonTextWriter.WritePropertyName('Shield Value');
     JsonTextWriter.WriteValue('');
     JsonTextWriter.WritePropertyName('Shield Type');
     JsonTextWriter.WriteValue('');
     JsonTextWriter.WritePropertyName('Shield');
     JsonTextWriter.WriteValue('');
     JsonTextWriter.WritePropertyName('Shield Cost');
     JsonTextWriter.WriteValue('');
     JsonTextWriter.WritePropertyName('Item Serial No');
     JsonTextWriter.WriteValue('');
     JsonTextWriter.WritePropertyName('IMEI No');
     JsonTextWriter.WriteValue('');
     JsonTextWriter.WritePropertyName('Capillary Line Discount Amount');
     JsonTextWriter.WriteValue('');  
    JsonTextWriter.WriteEndObject;
UNTIL SLRec.NEXT = 0;
end;*/ //CCIT_kj+-------


    procedure ReadJSOnDataSO(URL: Text[1024]; AuthenAPI: Boolean)
    var
        //KJ +++
        //  "---": Integer;
        /*  HttpWebRequestMgt: Codeunit "1297";
         HttpStatusCode: DotNet HttpStatusCode;
         ResStreamReader: DotNet StreamReader;
         HttpWebRequest: DotNet HttpWebRequest;
         HttpWebResponse: DotNet HttpWebResponse;
         ResponseInStream: InStream;
         WebRequest: DotNet WebRequest;
         TextEncoding1: DotNet Encoding;
         StreamReader: DotNet StreamReader;
         String: DotNet String;
         Stream: DotNet Stream;
         check1: BigText; */

        HttpContent: HttpContent;
        HttpHeaders: HttpHeaders;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        HttpClient: HttpClient;
    // KJ ---
    begin
        /*  HttpWebRequest := HttpWebRequest.HttpWebRequest;
         HttpWebRequest := WebRequest.Create(URL);
         HttpWebRequest.Method := 'POST';
         HttpWebRequest.ContentType := 'application/json';
         HttpWebRequest.Headers.Add('Auth-Key', 'igvg31$@$GWVQA@$Gwvm@vm^aVAqr!@omg');
         Stream := HttpWebRequest.GetRequestStream();
         Stream.Write(TextEncoding1.ASCII.GetBytes(Body), 0, TextEncoding1.ASCII.GetBytes(Body).Length);
         Stream.Close();
         HttpWebResponse := HttpWebResponse.HttpWebResponse;
         HttpWebResponse := HttpWebRequest.GetResponse();
         HttpStatusCode := HttpWebResponse.StatusCode();
         IF HttpStatusCode = 200 THEN BEGIN
             StreamReader := StreamReader.StreamReader(HttpWebResponse.GetResponseStream);
             String := StreamReader.ReadToEnd();
             EVALUATE(check1, String);
             //MESSAGE(FORMAT(check1));
         END ELSE BEGIN
             ERROR('No response from Authentication')
         END; */
        // KJ ++
        HttpContent.WriteFrom(Body);
        HttpContent.GetHeaders(HttpHeaders);
        HttpClient.DefaultRequestHeaders.Add('Auth-Key', 'igvg31$@$GWVQA@$Gwvm@vm^aVAqr!@omg');
        HttpHeaders.Remove('Content-Type');
        HttpHeaders.Add('Content-Type', 'application/json');
        HttpRequestMessage.Method := 'POST';
        HttpRequestMessage.SetRequestUri(URL);
        HttpRequestMessage.Content(HttpContent);
        if HttpClient.Send(HttpRequestMessage, HttpResponseMessage) then
            if HttpResponseMessage.IsSuccessStatusCode() then begin
                // if HttpResponseMessage.Content.ReadAs(String) then //kj_need to check
                //   EVALUATE(check1, String); //kj_need to check
            end
            ELSE BEGIN
                ERROR('No response from Authentication')
            END;
        // KJ ++--
    end;


    procedure SendSO(var SalesHeader: Record "Sales Header"; InvoiceNo: Code[20])
    begin

        DocumentNo := SalesHeader."No.";
        InitializeValueSO(DocumentNo);
        InitializeSO;
        InitializeSOValueSO(DocumentNo);
        // Body := StringBuilder.ToString; //kj
        //MESSAGE(Body);
        //kppl ReadJSOnDataSO('http://app.ibccube.com:4000/api/maple01/newretailsale',FALSE);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnAfterReleasePurchaseDoc', '', true, true)]
    local procedure SendPO(var PurchaseHeader: Record "Purchase Header")
    begin
        /*DocumentNo:=PurchaseHeader."No.";
        InitializeValuePO(DocumentNo);
        InitializePO;
        InitializePOValuePO(DocumentNo);
        Body:=StringBuilder.ToString;
        //MESSAGE(Body);
        ReadJSOnDataPO('http://app.ibccube.com:4000/api/maple/updatepo',FALSE);*/

    end;

    //[Scope('Internal')] //kj
    procedure Test(rec: Record "Sales Header")
    begin
        DocumentNo := rec."No.";
        InitializeValueSO(DocumentNo);
        InitializeSO;
        InitializeSOValueSO(DocumentNo);
        // Body := StringBuilder.ToString; //ccit_kj need to check
        MESSAGE(Body);
        // ReadJSOnDataSO('http://app.ibccube.com:4000/api/maple01/newretailsale', FALSE); //kj
    end;
}

