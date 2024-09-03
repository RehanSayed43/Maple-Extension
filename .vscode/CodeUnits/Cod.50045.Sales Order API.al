codeunit 50045 "Sales Order API"
{
    trigger OnRun()
    begin

    end;

    Procedure XMLOrderImport(RecImportOrder: XmlPort "Create Sales Order"): text
    VAR
        SH: Record "Sales Header";
        SingleInstanceCodeunit: Codeunit "Single Instance Codeunit";
    BEGIN
        IF RecImportOrder.Import() THEN BEGIN
            exit(SingleInstanceCodeunit.GetPONumber());
        END
        ELSE
            Error(GetLastErrorText);
        //exit();
    END;

    Procedure XMLOrderUpdate(RecImportOrder: XmlPort "Update Sales Order"): text
    VAR
        SH: Record "Sales Header";
        SingleInstanceCodeunit: Codeunit "Single Instance Codeunit";
    BEGIN
        IF RecImportOrder.Import() THEN BEGIN
            exit(SingleInstanceCodeunit.GetPONumber());
        END
        ELSE
            Error(GetLastErrorText);
    END;
    // Mapple NG 28032023 START - Added for Sales Order API

    procedure XMLOrderImportW(webxml: Text): Text
    var
        SingleInstanceCodeunit: Codeunit "Single Instance Codeunit";
        TempBlob: Codeunit "Temp Blob";
        CreateSalesOrder: XmlPort "Create Sales Order";
        XMLOutStream: OutStream;
        XMLInStream: InStream;
        SH: Record "Sales Header";
    begin


        TempBlob.CreateOutStream(XMLOutStream);
        XMLOutStream.WriteText(webxml);
        TempBlob.CreateInStream(XMLInStream);
        CreateSalesOrder.SetSource(XMLInStream);
        if CreateSalesOrder.Import() then
            exit(SingleInstanceCodeunit.GetPONumber())
        else
            Error(GetLastErrorText);
    end;
    /*
procedure XMLOrderImportW(webxml: Text; OrderID: Code[20]): Text
var
    SingleInstanceCodeunit: Codeunit "Single Instance Codeunit";
    TempBlob: Codeunit "Temp Blob";
    CreateSalesOrder: XmlPort "Create Sales Order";
    XMLOutStream: OutStream;
    XMLInStream: InStream;
    SH: Record "Sales Header";
begin
    SH.Reset();
    SH.SetRange(SH."Order ID", OrderID);
    IF SH.FindFirst() THEN
        Error('Order already exist');

    TempBlob.CreateOutStream(XMLOutStream);
    XMLOutStream.WriteText(webxml);
    TempBlob.CreateInStream(XMLInStream);
    CreateSalesOrder.SetSource(XMLInStream);
    if CreateSalesOrder.Import() then
        exit(SingleInstanceCodeunit.GetPONumber())
    else
        Error(GetLastErrorText);
end;
*/
    /*  procedure XMLOrderUpdateW(webxml: Text): Text
     var
         SingleInstanceCodeunit: Codeunit "Single Instance Codeunit";
         TempBlob: Codeunit "Temp Blob";
         UpdateSalesOrder: XmlPort "Update Sales Order";
         XMLOutStream: OutStream;
         XMLInStream: InStream;
     begin
         TempBlob.CreateOutStream(XMLOutStream);
         XMLOutStream.WriteText(webxml);
         TempBlob.CreateInStream(XMLInStream);
         UpdateSalesOrder.SetSource(XMLInStream);
         if UpdateSalesOrder.Import() then
             exit(SingleInstanceCodeunit.GetPONumber())
         else
             Error(GetLastErrorText);
     end; */

    procedure XMLOrderUpdateW(webxml: Text): Text
    var
        CopySalesHeader: Record "Sales Header";
        CopySalesLine: Record "Sales Line";
        ReservEntry: Record "Reservation Entry";
        SingleInstanceCodeunit: Codeunit "Single Instance Codeunit";
        TempBlob: Codeunit "Temp Blob";
        UpdateSalesOrder: XmlPort "Update Sales Order";
        XMLOutStream: OutStream;
        XMLInStream: InStream;
        XmlDoc: XmlDocument;
        RootElement: XmlElement;
        Node: XmlNode;
        Node2: XmlNode;
        Attribute: XmlAttribute;
        NodeList: XmlNodeList;
        Start: Integer;
        OrderKey: Code[100];
        transaction_id: Code[50];
        payment_methody: Code[20];
        payment_method_title: code[80];
        SaleslineType: Text;
        SalesLineItemNo: Code[20];
        SerialNo: Text[30];
        BillingLocationCode: Code[10];
        OrderNo: Code[20];
        IsSucess: Boolean;
        paymentstatus: Text[30];
        orderstatus: Text[100];
        paymentMode: Text[100];
    begin
        /* {"webxml": "<NodeName1><SalesHeader OrderKey=\"254589\" transaction_id=\"\" payment_methody=\"COD\" payment_method_title=\"Cash on delivery\"><SalesLine Type=\"Item\" No=\"APPLACP1001\" SerialNo=\"27766\" BillingLocationCode=\"CW102\"/><SalesLine Type=\"Item\" No=\"YELAUD1001\" SerialNo=\"29988\" BillingLocationCode=\"CW102\"/></SalesHeader></NodeName1>"} */
        IsSucess := false;
        if not XmlDocument.ReadFrom(webxml, XmlDoc) then
            Error('Invalid xml');
        if not XmlDoc.GetRoot(RootElement) then
            Error('Xml is empty');
        foreach Node in RootElement.GetChildNodes() do begin
            Clear(OrderKey);
            Clear(transaction_id);
            Clear(payment_methody);
            Clear(payment_method_title);
            Clear(OrderNo);
            Clear(paymentMode);

            if Node.AsXmlElement().Attributes().Get('OrderKey', Attribute) then
                OrderKey := Attribute.Value;
            if OrderKey = '' then
                exit('Order Key must have value');
            if Node.AsXmlElement().Attributes().Get('transaction_id', Attribute) then
                transaction_id := Attribute.Value;
            if Node.AsXmlElement().Attributes().Get('payment_methody', Attribute) then
                payment_methody := Attribute.Value;
            if Node.AsXmlElement().Attributes().Get('payment_method_title', Attribute) then
                payment_method_title := Attribute.Value;
            if Node.AsXmlElement().Attributes().Get('paymentstatus', Attribute) then
                paymentstatus := Attribute.Value;
            if Node.AsXmlElement().Attributes().Get('orderstatus', Attribute) then
                orderstatus := Attribute.Value;
            if Node.AsXmlElement().Attributes().Get('paymentMode', Attribute) then
                paymentMode := Attribute.Value;

            CopySalesHeader.Reset();
            CopySalesHeader.SetRange(orderKey, OrderKey);
            CopySalesHeader.SetRange("Document Type", CopySalesHeader."Document Type"::Order);
            if CopySalesHeader.FindFirst() then begin
                OrderNo := CopySalesHeader."No.";
                CopySalesHeader.transaction_id := transaction_id;
                CopySalesHeader.payment_method := payment_methody;
                CopySalesHeader.payment_method_title := payment_method_title;
                CopySalesHeader."Payment Status" := paymentstatus;
                CopySalesHeader.orderStatus := orderstatus;
                CopySalesHeader."Payment Mode" := paymentMode;
                if CopySalesHeader.Modify(false) then
                    IsSucess := true;
            end;
            if Node.SelectNodes('SalesLine', NodeList) then
                for Start := 1 to NodeList.Count do
                    if NodeList.Get(Start, Node2) then begin
                        Clear(SaleslineType);
                        Clear(SalesLineItemNo);
                        Clear(SerialNo);
                        Clear(BillingLocationCode);
                        if Node2.AsXmlElement().Attributes().Get('Type', Attribute) then
                            SaleslineType := Attribute.Value;
                        if Node2.AsXmlElement().Attributes().Get('No', Attribute) then
                            SalesLineItemNo := Attribute.Value;
                        if Node2.AsXmlElement().Attributes().Get('SerialNo', Attribute) then
                            SerialNo := Attribute.Value;
                        if Node2.AsXmlElement().Attributes().Get('BillingLocationCode', Attribute) then
                            BillingLocationCode := Attribute.Value;
                        CopySalesLine.Reset();
                        CopySalesLine.SetRange("Document Type", CopySalesLine."Document Type"::Order);
                        CopySalesLine.SetRange("Document No.", OrderNo);
                        CopySalesLine.SetRange("API Serial No.", SerialNo);
                        if CopySalesLine.FindFirst() then
                            if orderstatus <> 'cancelled' then
                                if (CopySalesLine."Quantity Shipped" = 0) and (BillingLocationCode <> '') then begin
                                    CopySalesLine."Location Code" := BillingLocationCode;
                                    CopySalesLine.Modify(false);
                                    if orderstatus = 'cancelled' then begin
                                        ReservEntry.Reset();
                                        ReservEntry.SetRange("Source Type", Database::"Sales Line");
                                        ReservEntry.SetRange("Source ID", CopySalesLine."Document No.");
                                        ReservEntry.SetRange("Source Ref. No.", CopySalesLine."Line No.");
                                        ReservEntry.SetRange("Item No.", CopySalesLine."No.");
                                        if ReservEntry.FindSet() then
                                            repeat
                                                ReservEntry.Delete(false);
                                            until
                                            ReservEntry.Next() = 0;
                                    end else begin
                                        ReservEntry.Reset();
                                        ReservEntry.SetRange("Source Type", Database::"Sales Line");
                                        ReservEntry.SetRange("Source ID", CopySalesLine."Document No.");
                                        ReservEntry.SetRange("Source Ref. No.", CopySalesLine."Line No.");
                                        ReservEntry.SetRange("Item No.", CopySalesLine."No.");
                                        if ReservEntry.FindFirst() then begin
                                            ReservEntry."Location Code" := BillingLocationCode;
                                            if ReservEntry.Modify(false) then
                                                IsSucess := true;
                                        end;
                                        CopySalesHeader.Reset();
                                        CopySalesHeader.SetRange(orderKey, OrderKey);
                                        CopySalesHeader.SetRange("Document Type", CopySalesHeader."Document Type"::Order);
                                        if CopySalesHeader.FindFirst() then begin
                                            CopySalesHeader."Location Code" := BillingLocationCode;
                                            if CopySalesHeader.Modify(false) then
                                                IsSucess := true;
                                        end;
                                    end;
                                end;
                    end;

        end;
        if IsSucess then
            exit('success ' + OrderNo)
        else
            exit('failed ' + OrderNo);
    end;

    procedure SerialnoUpdateOnSales(serialNoJson: Text): Text
    var
        SerialJsonObject: JsonObject;
    begin
        if not SerialJsonObject.ReadFrom(serialNoJson) then
            exit('invalid input expected a JSON array Object');
        CreateUpdateReservEntryweb(SerialJsonObject);
        if ResponseSerial then
            exit('update successfully')
        else
            exit(GetLastErrorText());
    end;

    local procedure CreateUpdateReservEntryweb(SerailReservationJsonObject: JsonObject): Boolean
    var

        SerailReservationJsonToken: JsonToken;
        ReservationJsonArray: JsonArray;
        UpdateReservationJsonObject: JsonObject;
        SalesOrderVal: Code[20];
        LineNoVal: Integer;
        LocationCodeVal: Code[10];
        ItemNoVal: Code[20];
        SerailNoVal: Code[50];
        PreSerailNoVal: Code[50];
    begin
        if SerailReservationJsonObject.Get('SerialNosArray', SerailReservationJsonToken) then begin
            ReservationJsonArray := SerailReservationJsonToken.AsArray();
            foreach SerailReservationJsonToken in ReservationJsonArray do begin
                UpdateReservationJsonObject := SerailReservationJsonToken.AsObject();
                Clear(SalesOrderVal);
                Clear(LineNoVal);
                Clear(LocationCodeVal);
                Clear(ItemNoVal);
                Clear(SerailNoVal);
                Clear(PreSerailNoVal);
                SalesOrderVal := GetJsonToken(UpdateReservationJsonObject, 'SalesOrder').AsValue().AsCode();
                LineNoVal := GetJsonToken(UpdateReservationJsonObject, 'LineNo.').AsValue().AsInteger();
                LocationCodeVal := GetJsonToken(UpdateReservationJsonObject, 'LocationCode').AsValue().AsCode();
                ItemNoVal := GetJsonToken(UpdateReservationJsonObject, 'ItemNo.').AsValue().AsCode();
                SerailNoVal := GetJsonToken(UpdateReservationJsonObject, 'SerialNo').AsValue().AsCode();
                PreSerailNoVal := GetJsonToken(UpdateReservationJsonObject, 'PreSerialNo').AsValue().AsCode();
                DeleteReservationEntry(SalesOrderVal, LineNoVal, LocationCodeVal, ItemNoVal, SerailNoVal, PreSerailNoVal);
                CreateReservEntrySalesOrderLine(SalesOrderVal, LineNoVal, LocationCodeVal, ItemNoVal, SerailNoVal, PreSerailNoVal);
            end;
        end;
    end;

    local procedure DeleteReservationEntry(SalesOrder: Code[20]; LineNo: Integer; LocationCode: Code[10]; ItemNo: Code[20]; SerailNo: Code[50]; PreSerailNo: Code[50])
    var
        DelReservEntry: Record "Reservation Entry";
    begin
        DelReservEntry.Reset();
        DelReservEntry.SetRange("Source Type", Database::"Sales Line");
        DelReservEntry.SetRange("Source ID", SalesOrder);
        DelReservEntry.SetRange("Source Ref. No.", LineNo);
        DelReservEntry.SetRange("Item No.", ItemNo);
        DelReservEntry.SetRange("Location Code", LocationCode);
        if PreSerailNo <> '' then
            DelReservEntry.SetRange("Serial No.", PreSerailNo);
        if not DelReservEntry.IsEmpty then
            DelReservEntry.DeleteAll();

    end;

    local procedure CreateReservEntrySalesOrderLine(SalesOrder: Code[20]; LineNo: Integer; LocationCode: Code[10]; ItemNo: Code[20]; SerailNo: Code[50]; PreSerailNo: Code[50])
    var
        SalesLine: Record "Sales Line";
        TempReservEntry: Record "Reservation Entry" temporary;
        CreateReservEntry: Codeunit "Create Reserv. Entry";
        ReservStatus: Enum "Reservation Status";

    begin
        if SalesLine.Get(SalesLine."Document Type"::Order, SalesOrder, LineNo) then begin
            TempReservEntry.Init();
            TempReservEntry."Entry No." := 0;
            TempReservEntry."Serial No." := SerailNo;
            TempReservEntry."Source ID" := SalesLine."Document No.";
            TempReservEntry.Quantity := 1;
            TempReservEntry.Insert();
            CreateReservEntry.SetDates(0D, TempReservEntry."Expiration Date");
            CreateReservEntry.CreateReservEntryFor(Database::"Sales Line", 1, SalesOrder, '', 0, SalesLine."Line No.", SalesLine."Qty. per Unit of Measure", TempReservEntry.Quantity, TempReservEntry.Quantity * SalesLine."Qty. per Unit of Measure", TempReservEntry);
            CreateReservEntry.CreateEntry(SalesLine."No.", SalesLine."Variant Code", SalesLine."Location Code", SalesLine.Description, 0D, Today, 0, Enum::"Reservation Status"::Surplus);
            ResponseSerial := true;
        end;

    end;

    local procedure GetJsonToken(JsonObject: JsonObject; TokenKey: Text) JsonToken: JsonToken;

    begin
        if not JsonObject.Get(TokenKey, JsonToken) then
            Error('Could not find a token with key %1', TokenKey);
    end;
    // Mapple NG 28032023 END - Added for Sales Order API

    procedure Hello(): Text
    begin
        exit('Hi');
    end;

    var
        ResponseSerial: Boolean;
}