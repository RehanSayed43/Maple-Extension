codeunit 50001 "Report Management"
{
    // KPPLRJ1.00 01.02.22 : Update Process for Error Handling & Process Log.

    Permissions = TableData 91 = rim,
                  TableData 98 = rim,
                  TableData 112 = rim,
                  TableData 113 = rim;

    trigger OnRun()
    var
        ResponseStatus: Boolean;
    begin
        /*WooCommerceHeaderBatch.RESET;
        WooCommerceHeaderBatch.SETRANGE(status,'processing');
        IF WooCommerceHeaderBatch.FINDSET THEN
          WooCommerceHeaderBatch.MODIFYALL(Processed,TRUE);*/

        // WooCommerceHeaderBatch.RESET;
        // WooCommerceHeaderBatch.SETRANGE(status, 'processing');
        // WooCommerceHeaderBatch.SETRANGE(Processed, FALSE);
        // WooCommerceHeaderBatch.SETRANGE(number, '5260420210144415');
        // IF WooCommerceHeaderBatch.FINDSET THEN
        //     REPEAT

        //         CheckOrder(WooCommerceHeaderBatch); //KPPLDG00009
        //         COMMIT;
        //     UNTIL WooCommerceHeaderBatch.NEXT = 0;

        // WooCommerceHeaderBatch.RESET;
        // WooCommerceHeaderBatch.SETRANGE(status, 'processing');
        // WooCommerceHeaderBatch.SETRANGE(Processed, FALSE);
        // WooCommerceHeaderBatch.SETRANGE("Is Error", FALSE); //<< KPPLRJ1.00
        // IF WooCommerceHeaderBatch.FINDSET THEN
        //     REPEAT

        //         CLEARLASTERROR();
        //         IF NOT CheckOrder(WooCommerceHeaderBatch) THEN BEGIN //KPPLDG00009
        //             WooCommerceHeaderBatch."Is Error" := TRUE;
        //             WooCommerceHeaderBatch.MODIFY;
        //             InitProcessLog('Create Order', WooCommerceHeaderBatch.order_key);
        //             InsertProcessLog(GETLASTERRORTEXT);
        //         END;
        //         //<< KPPLRJ1.00
        //         COMMIT;
        //     UNTIL WooCommerceHeaderBatch.NEXT = 0;

        // SIH.RESET;
        // SIH.SETRANGE("Posting Date", TODAY);
        // SIH.SETFILTER("External Document No.", '<>%1', '');
        // IF SIH.FINDSET THEN
        //     REPEAT
        //         //>> KPPLRJ1.01
        //         CLEARLASTERROR();
        //         CLEAR(ResponseStatus);
        //         IF SendInvoice(SIH, ResponseStatus) THEN BEGIN
        //             // SendmailLogistic(SIH);
        //             SIH."Capillary Posted" := ResponseStatus;
        //             SIH.MODIFY;
        //             COMMIT;
        //         END ELSE BEGIN
        //             InitProcessLog('Send Invoice', SIH."No.");
        //             InsertProcessLog(GETLASTERRORTEXT);
        //         END;
        //     //<< KPPLRJ1.01
        //     UNTIL SIH.NEXT = 0;

        // SIH.RESET;
        // SIH.SETRANGE("Posting Date", TODAY);
        // SIH.SETRANGE("Email Sent", FALSE);
        // SIH.SETFILTER("External Document No.", '<>%1', '');
        // IF SIH.FINDSET THEN
        //     REPEAT
        //         //>> KPPLRJ1.01
        //         CLEARLASTERROR();
        //         IF SendmailLogistic(SIH) THEN BEGIN
        //             SIH."Email Sent" := TRUE;
        //             SIH.MODIFY;
        //             COMMIT;
        //         END ELSE BEGIN
        //             InitProcessLog('Send Mail Logistic', SIH."No.");
        //             InsertProcessLog(GETLASTERRORTEXT);
        //         END;
        //<< KPPLRJ1.01
        //  UNTIL SIH.NEXT = 0; // TEM LM}

    end;

    var
        Text001: Label 'Amounts are in whole 10s';
        Text002: Label 'Amounts are in whole 100s';
        Text003: Label 'Amounts are in whole 1,000s';
        Text004: Label 'Amounts are in whole 100,000s';
        Text005: Label 'Amounts are in whole 1,000,000s';
        Text006: Label 'Amounts are not rounded';
        // WooCommerceHeader: Record "50006";
        Item: Record 27;
        RecCust: Record 18;
        NoSeriesManagement: Codeunit 396;
        ShipToaddresscode: Code[20];
        //WooCommerceHeaderBatch: Record 50006;
        PostedSI: Record 113;
        XMLBuffer: Record 1235;
        XmlBufferImport: Codeunit 1237;
        ServerAttachmentFilePath: Text;
        File2: File;
        // ResponseHeaders: DotNet NameValueCollection; //kj
        // HttpStatusCode: DotNet HttpStatusCode; //kj
        // HttpResponseMessage: DotNet HttpResponseMessage; //kj
        Instr: InStream;
        // TempBlob: Record "99008535";
        TempBlob: codeunit "Temp Blob";
        HttpWebRequestMgt: Codeunit 1297;
        JsonString: Text;
        // JsonFormatting: DotNet Formatting; //kj
        // JsonTextWriter: DotNet JsonTextWriter;
        GlobalNULL: Variant;
        // StringWriter: DotNet StringWriter;
        // StringBuilder: DotNet StringBuilder;
        Jsonuri: Label 'https://api.clockme.in/schedulecall/PushNavisionData?vendorid=5563477b-619f-11eb-a23e-022832f4671a&password=9N@v1An50st&logistics_events=eComm';
        SalesInvoiceHeader: Record 112;
        // woocomH: Record "50006"; //kj
        SalesInvoiceLine: Record 113;
        Desc: Text;
        FileManagement: Codeunit 419;
        SIH: Record 112;
        // Sendfile: DotNet SendFile; //kj
        I: Integer;
        // SendfileN: DotNet SendFile0; //kj
        // WooCommerceProcessLog: Record "50022";
        CRTCouponValidationMessage: Text[250];
        SalesSetup: Record 311;

    //[Scope('Internal')]
    procedure RoundAmount(Amount: Decimal; Rounding: Option " ",Tens,Hundreds,Thousands,"Hundred Thousands",Millions): Decimal
    begin
        CASE Rounding OF
            Rounding::" ":
                EXIT(Amount);
            Rounding::Tens:
                EXIT(ROUND(Amount / 10, 0.1));
            Rounding::Hundreds:
                EXIT(ROUND(Amount / 100, 0.1));
            Rounding::Thousands:
                EXIT(ROUND(Amount / 1000, 0.1));
            Rounding::"Hundred Thousands":
                EXIT(ROUND(Amount / 100000, 0.1));
            Rounding::Millions:
                EXIT(ROUND(Amount / 1000000, 0.1));
        END;
    end;

    // [Scope('Internal')]
    procedure RoundDescription(Rounding: Option " ",Tens,Hundreds,Thousands,"Hundred Thousands",Millions): Text[50]
    begin
        CASE Rounding OF
            Rounding::" ":
                EXIT(Text006);
            Rounding::Tens:
                EXIT(Text001);
            Rounding::Hundreds:
                EXIT(Text002);
            Rounding::Thousands:
                EXIT(Text003);
            Rounding::"Hundred Thousands":
                EXIT(Text004);
            Rounding::Millions:
                EXIT(Text005);
        END;
    end;

    local procedure onDataInsert()
    begin
    end;

    // [Scope('Internal')]
    // procedure UpDateOrder(order_key: Text; status: Text; date_modified: DateTime; payment_method: Code[100]; payment_method_title: Code[100]; transaction_id: Code[100]): Text
    // var
    //     WooCommerceIntegration: Codeunit "50023";
    // begin
    //     WooCommerceHeader.RESET;
    //     WooCommerceHeader.SETFILTER(order_key, order_key);
    //     IF WooCommerceHeader.FINDFIRST THEN BEGIN
    //         WooCommerceHeader.status := status;
    //         WooCommerceHeader.date_modified := date_modified;
    //         WooCommerceHeader.payment_method := payment_method;
    //         WooCommerceHeader.payment_method_title := payment_method_title;
    //         WooCommerceHeader.transaction_id := transaction_id;
    //         IF WooCommerceHeader.MODIFY THEN BEGIN
    //             // WooCommerceIntegration.CheckOrderInNav(WooCommerceHeader.order_key);
    //             EXIT('Order Updated Sucessfully');
    //         END;
    //     END ELSE
    //         EXIT('');
    //     // COMMIT;
    // end;

    // [Scope('Internal')]
    // procedure CheckOrderInNav(order_key: Text)
    // var
    //     Customer: Record "18";
    //     CustomeNo: Code[20];
    //     Storecode: Code[20];
    //     WooCommerceLine2: Record "50010";
    //     WooCommerceLine3: Record "50010";
    //     SalesHeader: Record "36";
    //     xstorecode: Code[20];
    //     ExternalDoc: Code[35];
    // begin
    //     CLEAR(ShipToaddresscode);
    //     WooCommerceHeader.RESET;
    //     WooCommerceHeader.SETFILTER(order_key, order_key);
    //     WooCommerceHeader.SETFILTER(status, 'processing');
    //     IF WooCommerceHeader.FINDFIRST THEN BEGIN
    //         Customer.RESET;
    //         Customer.SETRANGE("Phone No.", WooCommerceHeader.phone);
    //         Customer.SETRANGE("GST Registration No.", WooCommerceHeader._billing_gst);
    //         IF Customer.FINDFIRST THEN BEGIN
    //             // IF Customer."GST Registration No."= WooCommerceHeader._billing_gst THEN BEGIN
    //             // CustomeNo:= CreateCustomer(WooCommerceHeader);

    //             // IF CustomeNo<>'' THEN
    //             //CreateOrder(WooCommerceHeader,CustomeNo)
    //             //END ELSE BEGIN

    //             ShipToaddresscode := FindShipToAddress(Customer."No.", WooCommerceHeader."Ship To address_1", WooCommerceHeader."Ship To address_2",
    //                               WooCommerceHeader."Ship To city", WooCommerceHeader."Ship To state", WooCommerceHeader."Ship To postcode", WooCommerceHeader);
    //             //KPPL
    //             Storecode := '';
    //             CLEAR(I); //KPPLDG00009
    //             CLEAR(ExternalDoc);//KPPLDG00009
    //             WooCommerceLine2.RESET;
    //             WooCommerceLine2.SETCURRENTKEY(order_key, _billing_store_code);
    //             WooCommerceLine2.SETRANGE(order_key, WooCommerceHeader.order_key);
    //             WooCommerceLine2.SETRANGE("Navision Order No", '');//KPPLDG00009
    //             WooCommerceLine2.SETFILTER(_billing_store_code, '<>%1', '');//KPPLDG00009
    //             IF WooCommerceLine2.FINDSET THEN
    //                 REPEAT

    //                     Storecode := WooCommerceLine2._billing_store_code;
    //                     I += 1;//KPPLDG00009

    //                     SalesHeader.RESET;
    //                     //SalesHeader.SETRANGE("External Document No.",WooCommerceHeader.number);//KPPLDG00009
    //                     SalesHeader.SETRANGE("External Document No.", (WooCommerceHeader.number) + '_' + FORMAT(I));//KPPLDG00009
    //                     SalesHeader.SETRANGE("Location Code", Storecode);
    //                     IF NOT SalesHeader.FINDFIRST THEN BEGIN

    //                         /*WooCommerceLine3.RESET;
    //                         WooCommerceLine3.SETCURRENTKEY(order_key,_billing_store_code);
    //                         WooCommerceLine3.SETRANGE(order_key,WooCommerceHeader.order_key);
    //                         WooCommerceLine3.SETRANGE(_billing_store_code,Storecode);
    //                         IF WooCommerceLine2.FINDSET THEN*/

    //                         //KPPL

    //                         CreateOrder(WooCommerceHeader, Customer."No.", Storecode);
    //                     END; //KPPL
    //                     xstorecode := Storecode;
    //                 UNTIL WooCommerceLine2.NEXT = 0; //KPPL
    //                                                  //END;
    //         END ELSE BEGIN
    //             Customer.RESET;
    //             Customer.SETRANGE("E-Mail", WooCommerceHeader.email);
    //             Customer.SETRANGE("GST Registration No.", WooCommerceHeader._billing_gst);
    //             IF Customer.FINDFIRST THEN BEGIN


    //                 ShipToaddresscode := FindShipToAddress(Customer."No.", WooCommerceHeader."Ship To address_1", WooCommerceHeader."Ship To address_2",
    //                                   WooCommerceHeader."Ship To city", WooCommerceHeader."Ship To state", WooCommerceHeader."Ship To postcode", WooCommerceHeader);
    //                 //KPPL CreateOrder(WooCommerceHeader,Customer."No.");
    //                 // END;
    //             END ELSE BEGIN
    //                 CustomeNo := CreateCustomer(WooCommerceHeader);
    //                 IF CustomeNo <> '' THEN;
    //                 //KPPL CreateOrder(WooCommerceHeader,CustomeNo);
    //             END;
    //         END;
    //         WooCommerceHeader.MODIFY;
    //     END;

    // end;

    // local procedure CreateOrder(Header: Record "50006"; CustomerNo: Code[20]; Billingstore: Code[20])
    // var
    //     SalesHeader: Record "36";
    //     WooCommerceLine: Record "50010";
    //     SalesLine: Record "37";
    //     LineNo: Integer;
    //     Inserted: Code[20];
    //     WooCommerceLine2: Record "50010";
    // begin


    //     SalesHeader.RESET;
    //     ///SalesHeader.SETRANGE("External Document No.",Header.number); //KPPLDG00009
    //     SalesHeader.SETRANGE("External Document No.", Header.number + '_' + FORMAT(I)); //KPPLDG00009
    //     SalesHeader.SETRANGE("Location Code", Billingstore); //KPPL
    //     IF NOT SalesHeader.FINDFIRST THEN BEGIN
    //         SalesHeader.INIT;
    //         SalesHeader."Sales Order Type" := SalesHeader."Sales Order Type"::B2B;
    //         SalesHeader."Mobile Type" := SalesHeader."Mobile Type"::Apple;
    //         SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
    //         SalesHeader."Web Order" := TRUE;
    //         SalesHeader.SetHideValidationDialog(TRUE);
    //         SalesHeader.VALIDATE("Sell-to Customer No.", CustomerNo);
    //         IF ShipToaddresscode <> '' THEN
    //             SalesHeader.VALIDATE("Ship-to Code", ShipToaddresscode);
    //         SalesHeader."Salesperson Code" := 'SKY JET';
    //         //KPPL LM SalesHeader."Document Date":= DT2DATE(Header.date_created);
    //         SalesHeader."Document Date" := DT2DATE(Header.date_modified);
    //         //SalesHeader."External Document No.":= Header.number;//KPPLDG00009
    //         SalesHeader."External Document No." := Header.number + '_' + FORMAT(I);//KPPLDG00009
    //         SalesHeader."Posting Date" := DT2DATE(Header.date_modified);
    //         SalesHeader."Cust. Mobile No." := Header.phone;
    //         SalesHeader.VALIDATE("Location Code", Billingstore);
    //         /*IF Header._billing_store_code= 'PW101' THEN
    //           SalesHeader.VALIDATE("Location Code",'PW101')
    //         ELSE  IF Header._billing_store_code= 'CW108' THEN
    //           SalesHeader.VALIDATE("Location Code",'CW108')
    //         ELSE
    //          SalesHeader.VALIDATE("Location Code",'CW106');
    //          KPPL */

    //         SalesHeader."Payment Terms Code" := '';
    //         //IF Header.payment_method='RAZORPAY' THEN BEGIN
    //         //SalesHeader."Paytm Approval Code":= Header.transaction_id;
    //         //SalesHeader."Paytm Transfer Amount" := Header.total;
    //         //END;
    //         // SalesHeader.VALIDATE(Structure,'GST PIT');
    //         IF SalesHeader.INSERT THEN BEGIN
    //             Header."Navision Order No" := SalesHeader."No.";
    //             WooCommerceLine.RESET;
    //             WooCommerceLine.SETRANGE(order_key, Header.order_key);
    //             WooCommerceLine.SETRANGE(_billing_store_code, Billingstore);  // KPPL
    //             IF WooCommerceLine.FINDSET THEN
    //                 REPEAT
    //                     //Item.RESET;
    //                     //Item.SETRANGE(SKU1,WooCommerceLine.sku);
    //                     IF Item.GET(WooCommerceLine.sku) THEN BEGIN

    //                         SalesLine.INIT;
    //                         SalesLine."Document Type" := SalesHeader."Document Type";
    //                         SalesLine."Document No." := SalesHeader."No.";
    //                         SalesLine."Line No." := GetLineNO(SalesLine);
    //                         SalesLine.Type := SalesLine.Type::Item;
    //                         SalesLine.VALIDATE("No.", Item."No.");
    //                         SalesLine.VALIDATE(Quantity, WooCommerceLine.quantity);
    //                         SalesLine.VALIDATE("Unit Price Incl. of Tax", ROUND(WooCommerceLine.price + WooCommerceLine.total_tax, 0.01, '='));
    //                         SalesLine."Salesperson Code" := 'SKY JET';
    //                         IF SalesLine.INSERT THEN
    //                             WooCommerceLine."Navision Order No" := SalesHeader."No.";
    //                         Inserted := SalesHeader."No.";
    //                         WooCommerceLine.MODIFY;
    //                     END ELSE BEGIN
    //                         WooCommerceLine."Navision Remarks" := 'SKU Not Found';
    //                         WooCommerceLine."Navision Order No" := SalesHeader."No.";
    //                     END;
    //                 UNTIL WooCommerceLine.NEXT = 0;
    //             //  Header.MODIFY;
    //         END;

    //     END;

    //     IF SalesHeader.GET(SalesHeader."Document Type"::Order, Inserted) THEN BEGIN
    //         SalesHeader.SetHideValidationDialog(TRUE);
    //         SalesHeader.VALIDATE(Structure, 'GST PIT');
    //         SalesHeader.VALIDATE("Shortcut Dimension 1 Code", 'VIKROLI');
    //         SalesHeader.VALIDATE("Shortcut Dimension 2 Code", 'ONLINE');
    //         SalesHeader.MODIFY;
    //     END;
    //     COMMIT; //KPPL
    //     //Header.MODIFY;

    // end;

    // local procedure CreateCustomer(Header: Record "50006"): Code[20]
    // var
    //     Customer: Record "18";
    //     ShiptoAddress: Record "222";
    //     Item: Record "27";
    //     SalesSetup: Record "311";
    // begin

    //     Customer.INIT;
    //     SalesSetup.GET;
    //     Customer."No." := NoSeriesManagement.GetNextNo(SalesSetup."Retail Customer Nos.", TODAY, TRUE);


    //     Customer.Name := WooCommerceHeader."Bill To first_name" + ' ' + WooCommerceHeader."Bill To last_name";
    //     Customer."Phone No." := WooCommerceHeader.phone;
    //     //Customer."Phone No.2"
    //     Customer."E-Mail" := WooCommerceHeader.email;
    //     IF STRLEN(WooCommerceHeader."Bill To address_1") > 2 THEN
    //         Customer.Address := COPYSTR(WooCommerceHeader."Bill To address_1", 1, 50)
    //     ELSE
    //         ERROR('Bill To Address 1 Field must be min length of 3');
    //     IF STRLEN(WooCommerceHeader."Bill To address_2") > 2 THEN
    //         Customer."Address 2" := COPYSTR(WooCommerceHeader."Bill To address_2", 1, 50)
    //     ELSE
    //         ERROR('Bill To Address 2 Field must be min length of 3');

    //     IF WooCommerceHeader."Bill To city" <> '' THEN BEGIN
    //         IF STRLEN(WooCommerceHeader."Bill To city") > 2 THEN BEGIN
    //             Customer.City := WooCommerceHeader."Bill To city";
    //         END ELSE BEGIN
    //             ERROR('Invalid City');
    //         END;
    //     END ELSE BEGIN
    //         ERROR('Bill to City Missing');
    //     END;
    //     IF WooCommerceHeader."Bill To postcode" <> '' THEN
    //         Customer."Post Code" := WooCommerceHeader."Bill To postcode"
    //     ELSE
    //         ERROR('Bill to Post Code Missing');
    //     IF (WooCommerceHeader."Bill To state" <> '') OR (STRLEN(WooCommerceHeader."Bill To state") <> 2) THEN
    //         Customer."State Code" := WooCommerceHeader."Bill To state"
    //     ELSE
    //         ERROR('Invalid Bill to State');
    //     Customer."Customer Type" := Customer."Customer Type"::Retail;
    //     Customer."Gen. Bus. Posting Group" := 'Retail';
    //     Customer."Customer Posting Group" := 'Retail';
    //     Customer.Structure := 'VT+ST(PIT)';
    //     Customer."Tax Liable" := TRUE;
    //     IF WooCommerceHeader._billing_gst <> '' THEN BEGIN
    //         Customer."GST Customer Type" := Customer."GST Customer Type"::Registered;
    //         Customer."GST Registration No." := WooCommerceHeader._billing_gst;
    //         Customer."GST Registration Type" := 1;
    //     END ELSE BEGIN
    //         Customer."GST Customer Type" := Customer."GST Customer Type"::Unregistered;
    //     END;
    //     IF Customer."Phone No." = '' THEN
    //         Customer."Not Interested Customer" := TRUE;
    //     //Customer.INSERT;
    //     IF Customer.INSERT THEN BEGIN

    //         //IF Customer."Customer Points"<>0 THEN
    //         //Customer."Customer Points":=0;
    //         //IF Customer.INSERT THEN BEGIN
    //         IF WooCommerceHeader."Ship To first_name" <> '' THEN BEGIN
    //             ShiptoAddress.INIT;
    //             ShiptoAddress."Customer No." := Customer."No.";
    //             ShiptoAddress.Code := COPYSTR(Customer."No.", 7, 10); //KPPL LM
    //                                                                   //ShiptoAddress.Code:= Customer."No.";
    //             IF (WooCommerceHeader."Ship To first_name" + ' ' + WooCommerceHeader."Ship To last_name") <> '' THEN //kppl-rj
    //                 ShiptoAddress.Name := WooCommerceHeader."Ship To first_name" + ' ' + WooCommerceHeader."Ship To last_name"
    //             ELSE
    //                 ERROR('Name Missing');
    //             IF STRLEN(WooCommerceHeader."Ship To address_1") > 2 THEN
    //                 ShiptoAddress.Address := COPYSTR(WooCommerceHeader."Ship To address_1", 1, 50)
    //             ELSE
    //                 ERROR('Shiping Address must be min length of 3 ');
    //             IF STRLEN(WooCommerceHeader."Ship To address_2") > 2 THEN
    //                 ShiptoAddress."Address 2" := COPYSTR(WooCommerceHeader."Ship To address_2", 1, 50)
    //             ELSE
    //                 ERROR('Ship to Address 2 must be min length of 3');
    //             ShiptoAddress."Phone No." := WooCommerceHeader.phone;
    //             ShiptoAddress."E-Mail" := WooCommerceHeader.email;
    //             IF WooCommerceHeader."Ship To city" <> '' THEN
    //                 ShiptoAddress.City := WooCommerceHeader."Ship To city"
    //             ELSE
    //                 ERROR('City Missing');
    //             IF WooCommerceHeader."Ship To postcode" <> '' THEN
    //                 ShiptoAddress."Post Code" := WooCommerceHeader."Ship To postcode"
    //             ELSE
    //                 ERROR('Ship to postcode is missing');
    //             ShiptoAddress.State := WooCommerceHeader."Ship To state";
    //             IF ShiptoAddress.INSERT THEN
    //                 ShipToaddresscode := ShiptoAddress.Code;
    //         END;

    //         //END;
    //         EXIT(Customer."No.");
    //     END;
    // end;

    // local procedure GetLineNO(salesline: Record "37"): Integer
    // var
    //     salesline1: Record "37";
    // begin
    //     salesline1.RESET;
    //     salesline1.SETRANGE("Document No.", salesline."Document No.");
    //     IF salesline1.FINDLAST THEN
    //         EXIT(salesline1."Line No." + 10000)
    //     ELSE
    //         EXIT(10000);
    // end;

    // [EventSubscriber(ObjectType::Table, 50026, 'OnAfterInsertEvent', '', true, true)]
    // local procedure OnafterInsert(var Rec: Record "50006"; RunTrigger: Boolean)
    // begin
    //     /*
    //     SLEEP(120000);
    //     CheckOrderInNav(Rec.order_key);
    //     */

    // end;

    // [EventSubscriber(ObjectType::Codeunit, 1, 'OnAfterOnDatabasemodify', '', true, true)]
    // local procedure OnafterModify(RecRef: RecordRef)
    // var
    //     xRecRef: RecordRef;
    //     FldRef: FieldRef;
    // begin

    //     IF RecRef.NUMBER = 50006 THEN BEGIN
    //         FldRef := RecRef.FIELDINDEX(3);
    //         CheckOrderInNav(FORMAT(FldRef.VALUE));
    //     END;
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 1, 'OnAfterOnDatabaseinsert', '', true, true)]
    // local procedure OnafterInsertMain(RecRef: RecordRef)
    // var
    //     xRecRef: RecordRef;
    //     FldRef: FieldRef;
    // begin

    //     IF RecRef.NUMBER = 50006 THEN BEGIN
    //         FldRef := RecRef.FIELDINDEX(3);
    //         CheckOrderInNav(FORMAT(FldRef.VALUE));
    //     END;
    // end;

    // local procedure FindShipToAddress(customerno: Code[20]; Address1: Text[100]; Address2: Text[100]; City: Text[100]; State: Text[50]; Pincode: Code[10]; WooCHeader: Record "50006"): Code[20]
    // var
    //     ShiptoAdd: Record "222";
    //     found: Boolean;
    //     Scode: Code[20];
    //     ShiptoAddress: Record "222";
    // begin
    //     Scode := '';
    //     Address1 := COPYSTR(Address1, 1, 50);
    //     Address2 := COPYSTR(Address2, 1, 50);
    //     ShiptoAdd.RESET;
    //     ShiptoAdd.SETRANGE("Customer No.", customerno);
    //     IF ShiptoAdd.FINDSET THEN BEGIN
    //         REPEAT
    //             found := TRUE;
    //             IF ShiptoAdd.Address = Address1 THEN
    //                 found := FALSE;
    //             IF ShiptoAdd."Address 2" = Address2 THEN
    //                 found := FALSE;
    //             IF ShiptoAdd.City = City THEN
    //                 found := FALSE;
    //             IF ShiptoAdd.State = State THEN
    //                 found := FALSE;
    //             IF ShiptoAdd."Post Code" = Pincode THEN
    //                 found := FALSE;
    //             IF found = TRUE THEN
    //                 Scode := ShiptoAdd.Code


    //         UNTIL (ShiptoAdd.NEXT = 0);
    //     END ELSE BEGIN
    //         IF (WooCHeader."Ship To first_name" <> '') AND (found = FALSE) THEN BEGIN
    //             ShiptoAddress.INIT;
    //             ShiptoAddress."Customer No." := customerno;
    //             ShiptoAddress.Code := NoSeriesManagement.GetNextNo('SHIP', TODAY, TRUE);
    //             ShiptoAddress.Name := WooCHeader."Ship To first_name" + ' ' + WooCHeader."Ship To last_name";
    //             ShiptoAddress.Address := COPYSTR(WooCHeader."Ship To address_1", 1, 50);
    //             ShiptoAddress."Address 2" := COPYSTR(WooCHeader."Ship To address_2", 1, 50);
    //             ShiptoAddress."Phone No." := WooCHeader.phone;
    //             ShiptoAddress."E-Mail" := WooCHeader.email;
    //             ShiptoAddress.City := WooCHeader."Ship To city";
    //             ShiptoAddress."Post Code" := WooCHeader."Ship To postcode";
    //             ShiptoAddress.State := WooCHeader."Ship To state";
    //             IF ShiptoAddress.INSERT THEN
    //                 Scode := ShiptoAddress.Code;
    //         END;

    //     END;

    //     EXIT(Scode);
    // end;

    // local procedure InitializeJson()
    // begin
    //     StringBuilder := StringBuilder.StringBuilder;
    //     StringWriter := StringWriter.StringWriter(StringBuilder);
    //     JsonTextWriter := JsonTextWriter.JsonTextWriter(StringWriter);
    //     JsonTextWriter.Formatting := JsonFormatting.Indented;

    //     CLEAR(GlobalNULL);
    // end;

    // local procedure WriteFileHeaderJson()
    // begin
    //     JsonTextWriter.WriteStartObject;
    //     JsonTextWriter.WritePropertyName('vendorid');
    //     JsonTextWriter.WriteValue('5563477b-619f-11eb-a23e-022832f4671a');
    //     JsonTextWriter.WritePropertyName('password');
    //     JsonTextWriter.WriteValue('9N@v1An50st');
    // end;

    // local procedure WriteBodyJson()
    // begin
    //     woocomH.RESET;
    //     woocomH.SETRANGE(number, COPYSTR(SalesInvoiceHeader."External Document No.", 1, 16));
    //     IF woocomH.FINDFIRST THEN BEGIN
    //         Desc := '';
    //         SalesInvoiceLine.RESET;
    //         SalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
    //         IF SalesInvoiceLine.FINDFIRST THEN;
    //         JsonTextWriter.WritePropertyName('data');
    //         JsonTextWriter.WriteStartArray;
    //         JsonTextWriter.WriteStartObject;
    //         JsonTextWriter.WritePropertyName('order_receive_on_web_date');
    //         JsonTextWriter.WriteValue(COPYSTR(FORMAT(woocomH.date_modified, 0, 9), 1, 10)); //Change Modified
    //         JsonTextWriter.WritePropertyName('order_receive_on_web_time');
    //         JsonTextWriter.WriteValue(COPYSTR(FORMAT(woocomH.date_modified, 0, 9), 12, 5)); //Change modified
    //         JsonTextWriter.WritePropertyName('remark');
    //         JsonTextWriter.WriteValue(SalesInvoiceHeader."No.");
    //         JsonTextWriter.WritePropertyName('order_id');
    //         //JsonTextWriter.WriteValue(woocomH.number);
    //         JsonTextWriter.WriteValue(SalesInvoiceHeader."External Document No."); //KPPL LM
    //         JsonTextWriter.WritePropertyName('name');
    //         JsonTextWriter.WriteValue(woocomH."Ship To first_name" + ' ' + woocomH."Ship To last_name");
    //         JsonTextWriter.WritePropertyName('contact');
    //         JsonTextWriter.WriteValue(woocomH.phone);
    //         JsonTextWriter.WritePropertyName('email');
    //         JsonTextWriter.WriteValue(woocomH._shipping_email);
    //         JsonTextWriter.WritePropertyName('address');
    //         JsonTextWriter.WriteValue(woocomH."Ship To address_1" + ', ' + woocomH."Ship To address_2" + ', ' + woocomH."Ship To city" + ', ' + woocomH."Ship To postcode" + ', ' + woocomH."Ship To state");
    //         JsonTextWriter.WritePropertyName('location');
    //         JsonTextWriter.WriteValue(woocomH."Ship To city");
    //         JsonTextWriter.WritePropertyName('pin_code');
    //         JsonTextWriter.WriteValue(woocomH."Ship To postcode");
    //         JsonTextWriter.WritePropertyName('store_code');
    //         JsonTextWriter.WriteValue(SalesInvoiceHeader."Location Code");
    //         SalesInvoiceLine.RESET;
    //         SalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
    //         SalesInvoiceLine.SETRANGE(Type, SalesInvoiceLine.Type::Item);
    //         IF SalesInvoiceLine.FINDSET THEN
    //             REPEAT
    //                 IF Desc <> '' THEN
    //                     Desc := Desc + ', ' + FORMAT(SalesInvoiceLine.Description)
    //                 ELSE
    //                     Desc := SalesInvoiceLine.Description;
    //             UNTIL SalesInvoiceLine.NEXT = 0;
    //         Desc := DELCHR(Desc, '=', 'ÿ');
    //         //MESSAGE(Desc);
    //         JsonTextWriter.WritePropertyName('product');
    //         JsonTextWriter.WriteValue(Desc);
    //         JsonTextWriter.WritePropertyName('logistics_events');
    //         JsonTextWriter.WriteValue('eComm');
    //         JsonTextWriter.WriteEndObject;
    //         JsonTextWriter.WriteEndArray;
    //     END;
    // end;

    // [Scope('Internal')]
    // procedure CallLogisticApi(OrderNo: Code[20])
    // begin
    //     //OrderNo := COPYSTR(OrderNo,1,16); //KPPL
    //     SalesInvoiceHeader.RESET;
    //     SalesInvoiceHeader.SETRANGE("External Document No.", OrderNo);
    //     IF SalesInvoiceHeader.FINDFIRST THEN BEGIN

    //         InitializeJson;
    //         WriteFileHeaderJson;
    //         WriteBodyJson;
    //         JsonTextWriter.WriteEndObject;
    //         JsonTextWriter.Flush;
    //         JsonString := StringBuilder.ToString;
    //         HttpWebRequestMgt.Initialize(Jsonuri);
    //         // Request
    //         // File2.CREATE(TEMPORARYPATH +'\'+OrderNo+'-Request.txt');
    //         File2.CREATE('C:\LogisticApi' + '\' + OrderNo + '-Request.txt', TEXTENCODING::UTF8);
    //         File2.TEXTMODE(TRUE);

    //         File2.WRITE(JsonString);
    //         File2.CLOSE;
    //         HttpWebRequestMgt.DisableUI;
    //         HttpWebRequestMgt.SetMethod('POST');
    //         HttpWebRequestMgt.SetContentType('application/json');
    //         HttpWebRequestMgt.SetReturnType('application/json');
    //         // HttpWebRequestMgt.AddBody(TEMPORARYPATH +'\'+OrderNo+'-Request.txt');
    //         HttpWebRequestMgt.AddBody('C:\LogisticApi' + '\' + OrderNo + '-Request.txt');
    //         // MESSAGE(JsonString);
    //         TempBlob.INIT;
    //         TempBlob.Blob.CREATEINSTREAM(Instr);
    //         IF HttpWebRequestMgt.GetResponse(Instr, HttpStatusCode, ResponseHeaders) THEN BEGIN

    //             // Response
    //             ServerAttachmentFilePath := 'C:\LogisticApi' + '\' + OrderNo + '-Response.txt';
    //             File2.CREATE(ServerAttachmentFilePath, TEXTENCODING::UTF8);
    //             File2.TEXTMODE(TRUE);
    //             File2.WRITE(TempBlob.ReadAsText('', TEXTENCODING::UTF8));
    //             File2.CLOSE;
    //             XMLBuffer.DELETEALL;
    //             // MESSAGE(TempBlob.ReadAsText('',TEXTENCODING::UTF8));
    //             //  XmlBufferImport.GenerateStructure(ServerAttachmentFilePath,XMLBuffer);
    //             //XMLBuffer.RESET;
    //             // XMLBuffer.SETRANGE(Name,'response');
    //             //IF XMLBuffer.FINDFIRST THEN BEGIN
    //             IF STRPOS(TempBlob.ReadAsText('', TEXTENCODING::UTF8), '"success"') <> 0 THEN BEGIN
    //                 SalesInvoiceHeader."Document Exchange Status" := SalesInvoiceHeader."Document Exchange Status"::"Delivered to Recipient";
    //                 SalesInvoiceHeader.MODIFY;
    //             END;

    //         END;
    //     END;
    //     //temp
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterPostSalesDoc', '', true, true)]
    // local procedure OnafterPostsales(var SalesHeader: Record "36"; var GenJnlPostLine: Codeunit "12"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20])
    // var
    //     SalesInvoiceHeader: Record "112";
    // begin

    //     IF SalesHeader."External Document No." <> '' THEN
    //         CallLogisticApi(SalesHeader."External Document No.");

    //     //temp
    // end;

    // [TryFunction]
    // [Scope('Internal')]
    // procedure SendInvoice(SalesInvoiceHeader: Record "112"; ResponseStatus: Boolean)
    // var
    //     FileName: Text;
    //     localSInvHeader: Record "112";
    //     SalesInvoiceReport: Report "50007";
    //     Response: Text;
    //     WooCommerceHeaderRec: Record "50006";
    //     FileNo: Text;
    // begin

    //     WooCommerceHeaderRec.RESET;
    //     WooCommerceHeaderRec.SETRANGE(number, SalesInvoiceHeader."External Document No.");
    //     IF WooCommerceHeaderRec.FINDFIRST THEN BEGIN

    //         FileName := 'C:\IvoiceApiLog' + '\' + WooCommerceHeaderRec.number + '.pdf';
    //         IF EXISTS(FileName) THEN
    //             FILE.ERASE(FileName);
    //         localSInvHeader := SalesInvoiceHeader;
    //         localSInvHeader.SETRECFILTER;
    //         CLEAR(SalesInvoiceReport);
    //         SalesInvoiceReport.USEREQUESTPAGE := TRUE;
    //         SalesInvoiceReport.SETTABLEVIEW(localSInvHeader);
    //         SalesInvoiceReport.SAVEASPDF(FileName);
    //         //KPPLDG00009 ->
    //         //Sendfile := Sendfile.SendFile();
    //         //Response:=Sendfile.UploadFileNew('https://maplestore.in/wp-json/mapleconnect/submitinvoice','Invoice'+SalesInvoiceHeader."External Document No.",FileName,'b6825cbc6a185dd38e2f0d5be75b72e3f001168b',WooCommerceHeaderRec.id);
    //         IF STRPOS(SalesInvoiceHeader."External Document No.", '_') > 0 THEN
    //             FileNo := COPYSTR(SalesInvoiceHeader."External Document No.", STRPOS(SalesInvoiceHeader."External Document No.", '_') + 1, STRLEN(SalesInvoiceHeader."External Document No."))//KPPLDG00009
    //         ELSE
    //             FileNo := '0';
    //         SendfileN := SendfileN.SendFile();
    //         Response := SendfileN.UploadFileNew('https://maplestore.in/wp-json/mapleconnect/submitinvoice', 'Invoice' + SalesInvoiceHeader."External Document No.", FileName, 'b6825cbc6a185dd38e2f0d5be75b72e3f001168b', WooCommerceHeaderRec.id, FileNo);
    //         //KPPLDG00009 <-
    //         ServerAttachmentFilePath := 'C:\IvoiceApiLog' + '\' + WooCommerceHeaderRec.number + '-Response.txt';
    //         File2.CREATE(ServerAttachmentFilePath, TEXTENCODING::UTF8);
    //         File2.TEXTMODE(TRUE);
    //         File2.WRITE(Response);
    //         File2.CLOSE;


    //     END;
    //     IF Response <> '' THEN
    //         ResponseStatus := TRUE
    //     ELSE
    //         ResponseStatus := FALSE;
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 1, 'OnAfterCompanyOpen', '', true, true)]
    // local procedure OnAfterCompanyOpen()
    // begin
    //     //REPORT.RUN(50069);
    //     //temp UsersetupDateUpdate;
    // end;

    // local procedure UsersetupDateUpdate()
    // var
    //     RecUserSetup: Record "91";
    //     Day: Integer;
    //     User_id: Text;
    //     RecGLS: Record "98";
    // begin
    //     /*
    //     RecGLS.GET;
    //     RecGLS."Allow Posting From":=TODAY;//+1;
    //     ///RecGLS."Allow Posting From":=CALCDATE('-CM-1M',TODAY);
    //     RecGLS."Allow Posting To":=TODAY;//+1;
    //     //MESSAGE('%1',TODAY+1);
    //     RecGLS.MODIFY(TRUE);


    //     RecUserSetup.RESET;
    //     //RecUserSetup.SETFILTER("User ID",User_id);
    //     IF RecUserSetup.FINDSET THEN
    //       REPEAT
    //        IF RecUserSetup."Allow Back Dated Entry" THEN
    //         RecUserSetup."Allow Posting From":=CALCDATE('-CM-1M',TODAY)
    //       ELSE
    //          RecUserSetup."Allow Posting From":=TODAY;//+1);
    //        RecUserSetup."Allow Posting To":=TODAY;//+1;
    //         RecUserSetup.MODIFY;
    //       UNTIL RecUserSetup.NEXT=0;
    //       *///temp

    //     /*
    //     User_id:='ACC4EXE|ACC1EXE|ACC3EXE|MAPLESERV|ACCAM|ACC2EXE|MAPLEIT';
    //     Day:=0;
    //     Day:=DATE2DMY(TODAY+1,1);
    //     CASE Day OF
    //       1..4:
    //         BEGIN
    //        // MESSAGE('1- %1',CALCDATE('-CM-1M',TODAY));
    //           RecUserSetup.RESET;
    //           RecUserSetup.SETFILTER("User ID",User_id);
    //           IF RecUserSetup.FINDSET THEN
    //             REPEAT
    //             // MESSAGE('1-%1',RecUserSetup."User ID");
    //             RecUserSetup."Allow Posting From":=CALCDATE('-CM-1M',TODAY);//+1);
    //             RecUserSetup."Allow Posting To":=TODAY;//+1;
    //             RecUserSetup.MODIFY;
    //             UNTIL RecUserSetup.NEXT=0;
    //         END;
    //       ELSE
    //         BEGIN
    //        // MESSAGE('2- %1',CALCDATE ('-CM',TODAY));
    //           RecUserSetup.RESET;
    //           RecUserSetup.SETFILTER("User ID",User_id);
    //           IF RecUserSetup.FINDSET THEN
    //             REPEAT
    //             // MESSAGE('2- %1',RecUserSetup."User ID");
    //              RecUserSetup."Allow Posting From":=CALCDATE ('-CM',TODAY);//+1);
    //              RecUserSetup."Allow Posting To":=TODAY;//+1;
    //              RecUserSetup.MODIFY;
    //             UNTIL RecUserSetup.NEXT=0;
    //         END;
    //     END;
    //     */

    // end;

    // [TryFunction]
    // [Scope('Internal')]
    // procedure CheckOrder(WooCommerceHeader: Record "50006")
    // var
    //     Customer: Record "18";
    //     CustomeNo: Code[20];
    //     Storecode: Code[20];
    //     WooCommerceLine: Record "50010";
    //     SalesHeader: Record "36";
    //     ExternalDoc: Code[35];
    // begin
    //     //KPPLDG00009
    //     CLEAR(ShipToaddresscode);
    //     WITH WooCommerceHeader DO BEGIN
    //         Customer.RESET;
    //         Customer.SETRANGE("Phone No.", WooCommerceHeader.phone);
    //         Customer.SETRANGE("GST Registration No.", WooCommerceHeader._billing_gst);
    //         IF Customer.FINDFIRST THEN BEGIN
    //             ShipToaddresscode := FindShipToAddressNew(Customer."No.", WooCommerceHeader."Ship To address_1", WooCommerceHeader."Ship To address_2",
    //                                     WooCommerceHeader."Ship To city", WooCommerceHeader."Ship To state", WooCommerceHeader."Ship To postcode", WooCommerceHeader);
    //             //KPPL
    //             Storecode := '';
    //             CLEAR(I);
    //             CLEAR(ExternalDoc);
    //             WooCommerceLine.RESET;
    //             WooCommerceLine.SETCURRENTKEY(order_key, _billing_store_code);
    //             WooCommerceLine.SETRANGE(order_key, WooCommerceHeader.order_key);
    //             WooCommerceLine.SETRANGE("Navision Order No", '');
    //             WooCommerceLine.SETFILTER(_billing_store_code, '<>%1', '');
    //             IF WooCommerceLine.FINDSET THEN
    //                 REPEAT
    //                     IF Storecode <> WooCommerceLine._billing_store_code THEN BEGIN
    //                         Storecode := WooCommerceLine._billing_store_code;
    //                         I += 1;
    //                         ExternalDoc := (WooCommerceHeader.number) + '_' + FORMAT(I);
    //                     END;
    //                     SalesHeader.RESET;
    //                     SalesHeader.SETRANGE("External Document No.", ExternalDoc);
    //                     SalesHeader.SETRANGE("Location Code", Storecode);
    //                     IF SalesHeader.FINDFIRST THEN
    //                         CreateSalesLines(SalesHeader, WooCommerceLine)
    //                     ELSE
    //                         CreateSalesOrder(WooCommerceHeader, Customer."No.", Storecode, ExternalDoc);
    //                     WooCommerceHeader.Processed := TRUE;
    //                     WooCommerceHeader.MODIFY;
    //                 UNTIL WooCommerceLine.NEXT = 0; //KPPL
    //         END
    //         ELSE BEGIN
    //             Customer.RESET;
    //             Customer.SETRANGE("E-Mail", WooCommerceHeader.email);
    //             Customer.SETRANGE("GST Registration No.", WooCommerceHeader._billing_gst);
    //             IF Customer.FINDFIRST THEN BEGIN
    //                 ShipToaddresscode := FindShipToAddressNew(Customer."No.", WooCommerceHeader."Ship To address_1", WooCommerceHeader."Ship To address_2",
    //                                       WooCommerceHeader."Ship To city", WooCommerceHeader."Ship To state", WooCommerceHeader."Ship To postcode", WooCommerceHeader);

    //                 //KPPL
    //                 Storecode := '';
    //                 CLEAR(I);
    //                 CLEAR(ExternalDoc);
    //                 WooCommerceLine.RESET;
    //                 WooCommerceLine.SETCURRENTKEY(order_key, _billing_store_code);
    //                 WooCommerceLine.SETRANGE(order_key, WooCommerceHeader.order_key);
    //                 WooCommerceLine.SETRANGE("Navision Order No", '');
    //                 WooCommerceLine.SETFILTER(_billing_store_code, '<>%1', '');
    //                 IF WooCommerceLine.FINDSET THEN
    //                     REPEAT
    //                         IF Storecode <> WooCommerceLine._billing_store_code THEN BEGIN
    //                             Storecode := WooCommerceLine._billing_store_code;
    //                             I += 1;
    //                             ExternalDoc := (WooCommerceHeader.number) + '_' + FORMAT(I);
    //                         END;
    //                         SalesHeader.RESET;
    //                         SalesHeader.SETRANGE("External Document No.", ExternalDoc);
    //                         SalesHeader.SETRANGE("Location Code", Storecode);
    //                         IF SalesHeader.FINDFIRST THEN
    //                             CreateSalesLines(SalesHeader, WooCommerceLine)
    //                         ELSE
    //                             CreateSalesOrder(WooCommerceHeader, Customer."No.", Storecode, ExternalDoc);
    //                         WooCommerceHeader.Processed := TRUE;
    //                         WooCommerceHeader.MODIFY;
    //                     UNTIL WooCommerceLine.NEXT = 0; //KPPL
    //             END
    //             ELSE BEGIN
    //                 CustomeNo := CreateCustomerNew(WooCommerceHeader);
    //                 IF CustomeNo <> '' THEN BEGIN
    //                     //KPPL CreateOrder(WooCommerceHeader,CustomeNo);
    //                     //KPPL
    //                     Storecode := '';
    //                     CLEAR(I);
    //                     CLEAR(ExternalDoc);
    //                     WooCommerceLine.RESET;
    //                     WooCommerceLine.SETCURRENTKEY(order_key, _billing_store_code);
    //                     WooCommerceLine.SETRANGE(order_key, WooCommerceHeader.order_key);
    //                     WooCommerceLine.SETRANGE("Navision Order No", '');
    //                     WooCommerceLine.SETFILTER(_billing_store_code, '<>%1', '');
    //                     IF WooCommerceLine.FINDSET THEN
    //                         REPEAT
    //                             IF Storecode <> WooCommerceLine._billing_store_code THEN BEGIN
    //                                 Storecode := WooCommerceLine._billing_store_code;
    //                                 I += 1;
    //                                 ExternalDoc := (WooCommerceHeader.number) + '_' + FORMAT(I);
    //                             END;
    //                             SalesHeader.RESET;
    //                             SalesHeader.SETRANGE("External Document No.", ExternalDoc);
    //                             SalesHeader.SETRANGE("Location Code", Storecode);
    //                             IF SalesHeader.FINDFIRST THEN
    //                                 CreateSalesLines(SalesHeader, WooCommerceLine)
    //                             ELSE
    //                                 CreateSalesOrder(WooCommerceHeader, CustomeNo, Storecode, ExternalDoc);
    //                             WooCommerceHeader.Processed := TRUE;
    //                             WooCommerceHeader.MODIFY;
    //                         UNTIL WooCommerceLine.NEXT = 0; //KPPL
    //                 END;
    //             END;
    //         END;
    //         WooCommerceHeader.MODIFY;
    //     END;
    // end;

    // local procedure CreateSalesOrder(Header: Record "50006"; CustomerNo: Code[20]; Billingstore: Code[20]; ExDoc: Code[35])
    // var
    //     SalesHeader: Record "36";
    //     WooCommerceLine: Record "50010";
    //     SalesLine: Record "37";
    // begin
    //     //KPPLDG00009
    //     WITH Header DO BEGIN
    //         SalesHeader.INIT;
    //         SalesHeader."Sales Order Type" := SalesHeader."Sales Order Type"::B2B;
    //         SalesHeader."Mobile Type" := SalesHeader."Mobile Type"::Apple;
    //         SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
    //         SalesHeader."Web Order" := TRUE;
    //         SalesHeader.SetHideValidationDialog(TRUE);
    //         SalesHeader.VALIDATE("Sell-to Customer No.", CustomerNo);
    //         IF ShipToaddresscode <> '' THEN
    //             SalesHeader.VALIDATE("Ship-to Code", ShipToaddresscode);
    //         SalesHeader."Salesperson Code" := 'SKY JET';
    //         SalesHeader."Document Date" := DT2DATE(Header.date_modified); //KPPL Modified
    //         SalesHeader."External Document No." := ExDoc;
    //         SalesHeader."Posting Date" := DT2DATE(Header.date_modified); //KPPL Modified
    //         SalesHeader."Due Date" := SalesHeader."Posting Date";
    //         SalesHeader."Cust. Mobile No." := Header.phone;
    //         SalesHeader.VALIDATE("Location Code", Billingstore);
    //         SalesHeader."Payment Terms Code" := '';
    //         IF SalesHeader.INSERT THEN BEGIN
    //             WooCommerceLine.RESET;
    //             WooCommerceLine.SETRANGE(order_key, Header.order_key);
    //             WooCommerceLine.SETRANGE(_billing_store_code, Billingstore);
    //             IF WooCommerceLine.FINDSET THEN
    //                 REPEAT
    //                     CreateSalesLines(SalesHeader, WooCommerceLine);
    //                 UNTIL WooCommerceLine.NEXT = 0;
    //             SalesHeader.SetHideValidationDialog(TRUE);
    //             SalesHeader.VALIDATE(Structure, 'GST PIT');
    //             SalesHeader.VALIDATE("Shortcut Dimension 1 Code", 'VIKROLI');
    //             SalesHeader.VALIDATE("Shortcut Dimension 2 Code", 'ONLINE');
    //             SalesHeader.MODIFY;
    //         END;
    //     END;
    //     //Calculate Structure Value
    //     SalesHeader.CALCFIELDS("Price Inclusive of Taxes");
    //     IF SalesHeader."Price Inclusive of Taxes" THEN BEGIN
    //         SalesLine.InitStrOrdDetail(SalesHeader);
    //         SalesLine.GetSalesPriceExclusiveTaxes(SalesHeader);
    //         SalesLine.UpdateSalesLinesPIT(SalesHeader);
    //     END;
    //     SalesLine.CalculateStructures(SalesHeader);
    //     SalesLine.AdjustStructureAmounts(SalesHeader);
    //     SalesLine.UpdateSalesLines(SalesHeader);
    //     COMMIT; //KPPL

    //     //
    //     SendmailOrderCreation(SalesHeader);
    //     COMMIT; //KPPL
    // end;

    // local procedure CreateSalesLines(SH: Record "36"; var WooCommerceLine: Record "50010")
    // var
    //     SalesLine: Record "37";
    //     LineNo: Integer;
    // begin
    //     //KPPLDG00009
    //     WITH SH DO BEGIN
    //         IF Item.GET(WooCommerceLine.sku) THEN BEGIN
    //             SalesLine.INIT;
    //             SalesLine."Document Type" := SH."Document Type";
    //             SalesLine."Document No." := SH."No.";
    //             SalesLine."Line No." := GetLineNO(SalesLine);
    //             SalesLine.Type := SalesLine.Type::Item;
    //             SalesLine.VALIDATE("No.", Item."No.");
    //             SalesLine.VALIDATE(Quantity, WooCommerceLine.quantity);
    //             // SalesLine.VALIDATE("Unit Price Incl. of Tax",ROUND(WooCommerceLine.price+WooCommerceLine.total_tax,0.01,'='));
    //             SalesLine.VALIDATE("Unit Price Incl. of Tax", ROUND(WooCommerceLine.price + (WooCommerceLine.total_tax / WooCommerceLine.quantity), 0.01, '=')); //KPPLAT-240322
    //             SalesLine."Salesperson Code" := 'SKY JET';
    //             SalesLine."Location Code" := SH."Location Code";
    //             //KPPLDG00042
    //             CLEAR(CRTCouponValidationMessage);
    //             IF ValidateCRTCoupon(WooCommerceLine."CRT Coupon Code", Item."No.") THEN BEGIN
    //                 SalesSetup.GET;
    //                 SalesLine."CRT Coupon Code" := WooCommerceLine."CRT Coupon Code";
    //                 SalesLine."Line Discount %" := SalesSetup."CRT Coupon Discount %";
    //             END
    //             ELSE BEGIN
    //                 WooCommerceLine."Navision Remarks" := CRTCouponValidationMessage;
    //             END;
    //             //KPPLDG00042
    //             IF SalesLine.INSERT THEN
    //                 WooCommerceLine."Navision Order No" := SH."No.";
    //         END
    //         ELSE BEGIN
    //             WooCommerceLine."Navision Remarks" := 'SKU Not Found';
    //         END;
    //         WooCommerceLine.MODIFY;
    //     END;
    // end;

    // [Scope('Internal')]
    // procedure SendmailOrderCreation(SOrder: Record "36")
    // var
    //     EmailItem: Record "9500";
    //     MailManagement: Codeunit "9520";
    //     DotNetExceptionHandler: Codeunit "1291";
    //     OutStream: OutStream;
    //     SMTP: Codeunit "400";
    //     RecLoc: Record "14";
    //     Body: Text;
    //     NotificationMailSubjectTxt: Label 'New Order Received With reference No- ';
    //     SmtpMailSetup: Record "409";
    //     T37: Record "37";
    //     RowCount: Integer;
    //     ProductDescription: Text;
    //     GSTAmount: Decimal;
    //     BillingAddress: Text[50];
    //     CustAddr: array[8] of Text[50];
    //     ShipToAddr: array[8] of Text[50];
    //     FormatAddr: Codeunit "365";
    //     WooCommerceHead: Record "50006";
    // begin
    //     EmailItem.Init;
    //     EmailItem."From Name" := COMPANYNAME;
    //     EmailItem.Subject := 'New Order Received -' + SOrder."External Document No.";
    //     Body := '<title> New Order Received </title>';
    //     RecLoc.GET(SOrder."Location Code");
    //     EmailItem."Send to" := RecLoc."E-Mail";
    //     EmailItem.Body.CREATEOUTSTREAM(OutStream);
    //     OutStream.WRITE(Body);

    //     FormatAddr.SalesHeaderBillTo(CustAddr, SOrder);
    //     FormatAddr.SalesHeaderShipTo(ShipToAddr, SOrder);
    //     CLEAR(RowCount);
    //     CLEAR(GSTAmount);
    //     CLEAR(ProductDescription);
    //     SOrder.CALCFIELDS("Amount to Customer");
    //     RowCount := 1;
    //     T37.RESET;
    //     T37.SETRANGE("Document Type", SOrder."Document Type");
    //     T37.SETRANGE("Document No.", SOrder."No.");
    //     IF T37.FINDFIRST THEN
    //         REPEAT
    //             IF RowCount = 1 THEN
    //                 ProductDescription := T37.Description
    //             ELSE
    //                 ProductDescription := ProductDescription + ' / ' + T37.Description;
    //             GSTAmount += T37."Total GST Amount";
    //             RowCount += 1;
    //         UNTIL T37.NEXT = 0;
    //     WooCommerceHead.RESET;
    //     WooCommerceHead.SETRANGE(number, COPYSTR(SOrder."External Document No.", 1, 16));
    //     IF WooCommerceHead.FINDFIRST THEN
    //         CLEAR(SMTP);
    //     SmtpMailSetup.GET;
    //     SMTP.CreateMessage(COMPANYNAME, SmtpMailSetup."User ID", RecLoc."E-Mail", NotificationMailSubjectTxt, EmailItem.GetBodyText, TRUE);
    //     //SMTP.CreateMessage(COMPANYNAME,SmtpMailSetup."User ID",'Atul@kppl.net',EmailItem.Subject,EmailItem.GetBodyText,TRUE);
    //     SMTP.AppendBody('<table border ="1">');
    //     SMTP.AppendBody('<tr>');
    //     SMTP.AppendBody('<th> Description </th>');
    //     SMTP.AppendBody('<th> Values </th>');
    //     SMTP.AppendBody('</tr>');
    //     SMTP.AppendBody('<tr>');
    //     SMTP.AppendBody('<td> Order No. </td>');
    //     SMTP.AppendBody('<td>' + SOrder."External Document No." + '</td>');
    //     SMTP.AppendBody('</tr>');
    //     SMTP.AppendBody('<tr>');
    //     SMTP.AppendBody('<td> Product Details/Description </td>');
    //     SMTP.AppendBody('<td>' + ProductDescription + '/td');
    //     SMTP.AppendBody('</tr>');
    //     SMTP.AppendBody('<tr>');
    //     SMTP.AppendBody('<td> Product Amount </td>');
    //     SMTP.AppendBody('<td>' + FORMAT(SOrder."Amount to Customer") + '</td>');
    //     SMTP.AppendBody('</tr>');
    //     SMTP.AppendBody('<tr>');
    //     SMTP.AppendBody('<td> GST Details </td>');
    //     SMTP.AppendBody('<td>' + FORMAT(GSTAmount) + '</td>');
    //     SMTP.AppendBody('</tr>');
    //     SMTP.AppendBody('<tr>');
    //     SMTP.AppendBody('<td> Billing Address </td>');
    //     SMTP.AppendBody('<td>' + CustAddr[1] + ' ' + CustAddr[1] + ' ' + CustAddr[2] + ' ' + CustAddr[3] + ' ' + CustAddr[4] + '</td>');
    //     SMTP.AppendBody('</tr>');
    //     SMTP.AppendBody('<tr>');
    //     IF ShipToAddr[1] <> '' THEN BEGIN
    //         SMTP.AppendBody('<td> Shipping Address </td>');
    //         SMTP.AppendBody('<td>' + ShipToAddr[1] + ' ' + ShipToAddr[1] + ' ' + ShipToAddr[2] + ' ' + ShipToAddr[3] + ' ' + ShipToAddr[4] + '</td>');
    //     END ELSE BEGIN
    //         SMTP.AppendBody('<td> Shipping Address </td>');
    //         SMTP.AppendBody('<td>' + CustAddr[1] + ' ' + CustAddr[1] + ' ' + CustAddr[2] + ' ' + CustAddr[3] + ' ' + CustAddr[4] + '</td>');
    //     END;
    //     SMTP.AppendBody('</tr>');
    //     SMTP.AppendBody('<tr>');
    //     SMTP.AppendBody('<td> Any Specific Notes </td>');
    //     SMTP.AppendBody('<td>' + WooCommerceHead._billing_order_notes + '</td>');
    //     SMTP.AppendBody('</tr>');

    //     SMTP.Send;
    // end;

    // [TryFunction]
    // [Scope('Internal')]
    // procedure SendmailLogistic(SOrder: Record "112")
    // var
    //     EmailItem: Record "9500";
    //     MailManagement: Codeunit "9520";
    //     DotNetExceptionHandler: Codeunit "1291";
    //     OutStream: OutStream;
    //     SMTP: Codeunit "400";
    //     RecLoc: Record "14";
    //     Body: Text;
    //     NotificationMailSubjectTxt: Label 'New Order Received With reference No- ';
    //     SmtpMailSetup: Record "409";
    //     RowCount: Integer;
    //     ProductDescription: Text;
    //     GSTAmount: Decimal;
    //     BillingAddress: Text[50];
    //     CustAddr: array[8] of Text[50];
    //     ShipToAddr: array[8] of Text[50];
    //     FormatAddr: Codeunit "365";
    //     WooCommerceHead: Record "50006";
    //     T113: Record "113";
    // begin
    //     EmailItem.Init;
    //     EmailItem."From Name" := COMPANYNAME;
    //     EmailItem.Subject := 'New Order For Pickup';
    //     Body := '';
    //     RecLoc.GET(SOrder."Location Code");
    //     EmailItem."Send to" := RecLoc."E-Mail";
    //     EmailItem.Body.CREATEOUTSTREAM(OutStream);
    //     OutStream.WRITE(Body);

    //     FormatAddr.SalesInvBillTo(CustAddr, SOrder);
    //     CLEAR(RowCount);
    //     CLEAR(ProductDescription);
    //     RowCount := 1;
    //     T113.RESET;
    //     T113.SETRANGE("Document No.", SOrder."No.");
    //     IF T113.FINDFIRST THEN
    //         REPEAT
    //             IF RowCount = 1 THEN
    //                 ProductDescription := T113.Description
    //             ELSE
    //                 ProductDescription := ProductDescription + ' / ' + T113.Description;
    //             RowCount += 1;
    //         UNTIL T113.NEXT = 0;
    //     WooCommerceHead.RESET;
    //     WooCommerceHead.SETRANGE(number, COPYSTR(SOrder."External Document No.", 1, 16));
    //     IF WooCommerceHead.FINDFIRST THEN
    //         CLEAR(SMTP);
    //     SmtpMailSetup.GET;
    //     //sunil@gearsoft.co.in
    //     IF SOrder."Location Code" = 'M1201' THEN
    //         SMTP.CreateMessage(COMPANYNAME, SmtpMailSetup."User ID", 'Jay.r@mapletechnologies.org;ankit.p@mapletechnologies.org;sagar.jadhwani@mapletechnologies.org', EmailItem.Subject, EmailItem.GetBodyText, TRUE)
    //     ELSE
    //         SMTP.CreateMessage(COMPANYNAME, SmtpMailSetup."User ID", 'Jay.r@mapletechnologies.org;ankit.p@mapletechnologies.org;sunil@gearsoft.co.in', EmailItem.Subject, EmailItem.GetBodyText, TRUE);
    //     SMTP.AppendBody('<table border ="1">');
    //     SMTP.AppendBody('<tr>');
    //     SMTP.AppendBody('<th> Description </th>');
    //     SMTP.AppendBody('<th> Values </th>');
    //     SMTP.AppendBody('</tr>');
    //     SMTP.AppendBody('<tr>');
    //     SMTP.AppendBody('<td> Order No. </td>');
    //     SMTP.AppendBody('<td>' + SOrder."External Document No." + '</td>');
    //     SMTP.AppendBody('</tr>');

    //     SMTP.AppendBody('<tr>');
    //     SMTP.AppendBody('<td> Pickup location </td>');
    //     SMTP.AppendBody('<td> ' + RecLoc."Name 2" + '<td>');
    //     SMTP.AppendBody('</tr>');
    //     SMTP.AppendBody('<tr>');
    //     SMTP.AppendBody('<td> Customer Name </td>');
    //     SMTP.AppendBody('<td> ' + SOrder."Bill-to Name" + '</td>');
    //     SMTP.AppendBody('</tr>');
    //     SMTP.AppendBody('<tr>');
    //     SMTP.AppendBody('<td> Customer Phone </td>');
    //     SMTP.AppendBody('<td> ' + SOrder."Cust. Mobile No." + '</td>');
    //     SMTP.AppendBody('</tr>');
    //     SMTP.AppendBody('<tr>');
    //     SMTP.AppendBody('<td> Customer Address </td>');
    //     SMTP.AppendBody('<td>' + CustAddr[1] + ' ' + CustAddr[1] + ' ' + CustAddr[2] + ' ' + CustAddr[3] + ' ' + CustAddr[4] + '</td>');
    //     SMTP.AppendBody('</tr>');
    //     SMTP.AppendBody('<tr>');
    //     SMTP.AppendBody('<td> Product Details/Description </td>');
    //     SMTP.AppendBody('<td>' + ProductDescription + '/td');
    //     SMTP.AppendBody('</tr>');
    //     SMTP.AppendBody('<tr>');
    //     SMTP.AppendBody('<td> Web order Date/time </td>');
    //     SMTP.AppendBody('<td> ' + FORMAT(DT2TIME(WooCommerceHead.date_modified)) + '<td>'); //KPPL Modified
    //     SMTP.AppendBody('</tr>');
    //     SMTP.AppendBody('<tr>');
    //     SMTP.AppendBody('<td> Billing Date/time  </td> ');
    //     SMTP.AppendBody('<td> ' + FORMAT(TIME) + '</td>');
    //     SMTP.AppendBody('</tr>');
    //     SMTP.Send;
    // end;

    // local procedure CreateCustomerNew(Header: Record "50006"): Code[20]
    // var
    //     Customer: Record "18";
    //     ShiptoAddress: Record "222";
    //     Item: Record "27";
    //     SalesSetup: Record "311";
    // begin
    //     Customer.INIT;
    //     SalesSetup.GET;
    //     Customer."No." := NoSeriesManagement.GetNextNo(SalesSetup."Retail Customer Nos.", TODAY, TRUE);
    //     IF Header."Bill To first_name" + ' ' + Header."Bill To last_name" <> '' THEN //kppl-rj
    //         Customer.Name := Header."Bill To first_name" + ' ' + Header."Bill To last_name"
    //     ELSE
    //         ERROR('Name is missing');
    //     Customer."Phone No." := Header.phone;
    //     //Customer."Phone No.2"
    //     Customer."E-Mail" := Header.email;
    //     IF STRLEN(Header."Bill To address_1") > 2 THEN
    //         Customer.Address := COPYSTR(Header."Bill To address_1", 1, 50)
    //     ELSE
    //         ERROR('Bill to Address must be min of length 3');
    //     IF STRLEN(Header."Bill To address_2") > 2 THEN
    //         Customer."Address 2" := COPYSTR(Header."Bill To address_2", 1, 50)
    //     ELSE
    //         ERROR('Bill to Address must be min of length 3');
    //     IF Header."Bill To city" <> '' THEN
    //         Customer.City := Header."Bill To city"
    //     ELSE
    //         ERROR('Bill to city is missing');
    //     IF Header."Bill To postcode" <> '' THEN
    //         Customer."Post Code" := Header."Bill To postcode"
    //     ELSE
    //         ERROR('Bill to post code is missing');
    //     IF (Header."Bill To state" <> '') OR (STRLEN(Header."Bill To state") <> 2) THEN
    //         Customer."State Code" := Header."Bill To state"
    //     ELSE
    //         ERROR('Invalid Bill to State');
    //     Customer."Customer Type" := Customer."Customer Type"::Retail;
    //     Customer."Gen. Bus. Posting Group" := 'Retail';
    //     Customer."Customer Posting Group" := 'Retail';
    //     Customer.Structure := 'VT+ST(PIT)';
    //     Customer."Tax Liable" := TRUE;
    //     IF Header._billing_gst <> '' THEN BEGIN
    //         Customer."GST Customer Type" := Customer."GST Customer Type"::Registered;
    //         Customer."GST Registration No." := Header._billing_gst;
    //         Customer."GST Registration Type" := 1;
    //     END ELSE BEGIN
    //         Customer."GST Customer Type" := Customer."GST Customer Type"::Unregistered;
    //     END;
    //     IF Customer."Phone No." = '' THEN
    //         Customer."Not Interested Customer" := TRUE;
    //     //Customer.INSERT;
    //     IF Customer.INSERT THEN BEGIN

    //         //IF Customer."Customer Points"<>0 THEN
    //         //Customer."Customer Points":=0;
    //         //IF Customer.INSERT THEN BEGIN
    //         IF Header."Ship To first_name" <> '' THEN BEGIN
    //             ShiptoAddress.INIT;
    //             ShiptoAddress."Customer No." := Customer."No.";
    //             ShiptoAddress.Code := COPYSTR(Customer."No.", 7, 10); //KPPL LM
    //                                                                   //ShiptoAddress.Code:= Customer."No.";
    //             ShiptoAddress.Name := Header."Ship To first_name" + ' ' + Header."Ship To last_name";
    //             IF STRLEN(Header."Ship To address_1") > 2 THEN  //kppl-rj
    //                 ShiptoAddress.Address := COPYSTR(Header."Ship To address_1", 1, 50)
    //             ELSE
    //                 ERROR('Ship to address length must be min of 3');
    //             IF STRLEN(Header."Ship To address_2") > 2 THEN
    //                 ShiptoAddress."Address 2" := COPYSTR(Header."Ship To address_2", 1, 50)
    //             ELSE
    //                 ERROR('Ship to Address length must be min of 3');
    //             ShiptoAddress."Phone No." := Header.phone;
    //             ShiptoAddress."E-Mail" := Header.email;
    //             IF Header."Ship To city" <> '' THEN
    //                 ShiptoAddress.City := Header."Ship To city"
    //             ELSE
    //                 ERROR('Ship to city is missing');
    //             IF Header."Ship To postcode" <> '' THEN
    //                 ShiptoAddress."Post Code" := Header."Ship To postcode"
    //             ELSE
    //                 ERROR('Ship to post code is missing');
    //             IF Header."Ship To state" <> '' THEN
    //                 ShiptoAddress.State := Header."Ship To state"
    //             ELSE
    //                 ERROR('Ship to state is missing');
    //             IF ShiptoAddress.INSERT THEN
    //                 ShipToaddresscode := ShiptoAddress.Code;
    //         END;

    //         //END;
    //         EXIT(Customer."No.");
    //     END;
    // end;

    // [Scope('Internal')]
    // procedure CallLogisticApiManual(OrderNo: Code[20])
    // begin
    //     SalesInvoiceHeader.RESET;
    //     SalesInvoiceHeader.SETRANGE("External Document No.", OrderNo);
    //     IF SalesInvoiceHeader.FINDFIRST THEN BEGIN

    //         InitializeJson;
    //         WriteFileHeaderJson;
    //         WriteBodyJsonMannual;
    //         JsonTextWriter.WriteEndObject;
    //         JsonTextWriter.Flush;
    //         JsonString := StringBuilder.ToString;
    //         HttpWebRequestMgt.Initialize(Jsonuri);
    //         File2.CREATE('C:\LogisticApi' + '\' + OrderNo + '-Request.txt', TEXTENCODING::UTF8);
    //         File2.TEXTMODE(TRUE);

    //         File2.WRITE(JsonString);
    //         File2.CLOSE;
    //         HttpWebRequestMgt.DisableUI;
    //         HttpWebRequestMgt.SetMethod('POST');
    //         HttpWebRequestMgt.SetContentType('application/json');
    //         HttpWebRequestMgt.SetReturnType('application/json');
    //         HttpWebRequestMgt.AddBody('C:\LogisticApi' + '\' + OrderNo + '-Request.txt');
    //         TempBlob.INIT;
    //         TempBlob.Blob.CREATEINSTREAM(Instr);
    //         IF HttpWebRequestMgt.GetResponse(Instr, HttpStatusCode, ResponseHeaders) THEN BEGIN

    //             // Response
    //             ServerAttachmentFilePath := 'C:\LogisticApi' + '\' + OrderNo + '-Response.txt';
    //             File2.CREATE(ServerAttachmentFilePath, TEXTENCODING::UTF8);
    //             File2.TEXTMODE(TRUE);
    //             File2.WRITE(TempBlob.ReadAsText('', TEXTENCODING::UTF8));
    //             File2.CLOSE;
    //             XMLBuffer.DELETEALL;
    //             IF STRPOS(TempBlob.ReadAsText('', TEXTENCODING::UTF8), '"success"') <> 0 THEN BEGIN
    //                 SalesInvoiceHeader."Document Exchange Status" := SalesInvoiceHeader."Document Exchange Status"::"Delivered to Recipient";
    //                 SalesInvoiceHeader.MODIFY;
    //             END;

    //         END;
    //     END;
    // end;

    // local procedure WriteBodyJsonMannual()
    // begin
    //     Desc := '';
    //     SalesInvoiceLine.RESET;
    //     SalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
    //     IF SalesInvoiceLine.FINDFIRST THEN;
    //     JsonTextWriter.WritePropertyName('data');
    //     JsonTextWriter.WriteStartArray;
    //     JsonTextWriter.WriteStartObject;
    //     JsonTextWriter.WritePropertyName('order_receive_on_web_date');
    //     JsonTextWriter.WriteValue(COPYSTR(FORMAT(SalesInvoiceHeader."Document Date", 0, 9), 1, 10));
    //     JsonTextWriter.WritePropertyName('order_receive_on_web_time');
    //     JsonTextWriter.WriteValue(COPYSTR(FORMAT(SalesInvoiceHeader."Time of Removal", 0, 9), 12, 5));
    //     JsonTextWriter.WritePropertyName('remark');
    //     JsonTextWriter.WriteValue(SalesInvoiceHeader."No.");
    //     JsonTextWriter.WritePropertyName('order_id');
    //     JsonTextWriter.WriteValue(SalesInvoiceHeader."External Document No.");
    //     JsonTextWriter.WritePropertyName('name');
    //     JsonTextWriter.WriteValue(SalesInvoiceHeader."Ship-to Name" + ' ' + SalesInvoiceHeader."Ship-to Name 2");
    //     JsonTextWriter.WritePropertyName('contact');
    //     JsonTextWriter.WriteValue(SalesInvoiceHeader."Cust. Mobile No.");
    //     JsonTextWriter.WritePropertyName('email');
    //     JsonTextWriter.WriteValue(SalesInvoiceHeader."Cust. email ID");
    //     JsonTextWriter.WritePropertyName('address');
    //     JsonTextWriter.WriteValue(SalesInvoiceHeader."Ship-to Address" + ', ' + SalesInvoiceHeader."Ship-to Address 2" + ', ' + SalesInvoiceHeader."Ship-to City" + ', ' + SalesInvoiceHeader."Ship-to Post Code" + ', ' + SalesInvoiceHeader.State);
    //     JsonTextWriter.WritePropertyName('location');
    //     JsonTextWriter.WriteValue(SalesInvoiceHeader."Ship-to City");
    //     JsonTextWriter.WritePropertyName('pin_code');
    //     JsonTextWriter.WriteValue(SalesInvoiceHeader."Ship-to Post Code");
    //     JsonTextWriter.WritePropertyName('store_code');
    //     JsonTextWriter.WriteValue(SalesInvoiceHeader."Location Code");
    //     SalesInvoiceLine.RESET;
    //     SalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
    //     SalesInvoiceLine.SETRANGE(Type, SalesInvoiceLine.Type::Item);
    //     IF SalesInvoiceLine.FINDSET THEN
    //         REPEAT
    //             IF Desc <> '' THEN
    //                 Desc := Desc + ', ' + FORMAT(SalesInvoiceLine.Description)
    //             ELSE
    //                 Desc := SalesInvoiceLine.Description;
    //         UNTIL SalesInvoiceLine.NEXT = 0;
    //     Desc := DELCHR(Desc, '=', 'ÿ');
    //     //MESSAGE(Desc);
    //     JsonTextWriter.WritePropertyName('product');
    //     JsonTextWriter.WriteValue(Desc);
    //     JsonTextWriter.WritePropertyName('logistics_events');
    //     JsonTextWriter.WriteValue('eComm');
    //     JsonTextWriter.WriteEndObject;
    //     JsonTextWriter.WriteEndArray;
    //     //END;
    // end;

    // [TryFunction]
    // [Scope('Internal')]
    // procedure SendmailFinance(SOrder: Record "36")
    // var
    //     EmailItem: Record "9500";
    //     MailManagement: Codeunit "9520";
    //     DotNetExceptionHandler: Codeunit "1291";
    //     OutStream: OutStream;
    //     SMTP: Codeunit "400";
    //     RecLoc: Record "14";
    //     Body: Text;
    //     NotificationMailSubjectTxt: Label 'New Order Received With reference No- ';
    //     SmtpMailSetup: Record "409";
    //     RowCount: Integer;
    //     ProductDescription: Text;
    //     GSTAmount: Decimal;
    //     BillingAddress: Text[50];
    //     CustAddr: array[8] of Text[50];
    //     ShipToAddr: array[8] of Text[50];
    //     FormatAddr: Codeunit "365";
    //     WooCommerceHead: Record "50006";
    //     T113: Record "113";
    // begin

    //     EmailItem.Init;
    //     EmailItem."From Name" := COMPANYNAME;
    //     EmailItem.Subject := 'New Order For Approval';
    //     Body := '';
    //     RecLoc.GET(SOrder."Location Code");
    //     EmailItem."Send to" := RecLoc."E-Mail";
    //     EmailItem.Body.CREATEOUTSTREAM(OutStream);
    //     OutStream.WRITE(Body);
    //     FormatAddr.SalesHeaderBillTo(CustAddr, SOrder);
    //     CLEAR(RowCount);
    //     CLEAR(ProductDescription);
    //     RowCount := 1;
    //     T113.RESET;
    //     T113.SETRANGE("Document No.", SOrder."No.");
    //     IF T113.FINDFIRST THEN
    //         REPEAT
    //             IF RowCount = 1 THEN
    //                 ProductDescription := T113.Description
    //             ELSE
    //                 ProductDescription := ProductDescription + ' / ' + T113.Description;
    //             RowCount += 1;
    //         UNTIL T113.NEXT = 0;
    //     WooCommerceHead.RESET;
    //     WooCommerceHead.SETRANGE(number, COPYSTR(SOrder."External Document No.", 1, 16));
    //     IF WooCommerceHead.FINDFIRST THEN
    //         CLEAR(SMTP);
    //     SmtpMailSetup.GET;
    //     //sunil@gearsoft.co.in
    //     SMTP.CreateMessage(COMPANYNAME, SmtpMailSetup."User ID", 'accounts1@mapletechnologies.org', EmailItem.Subject, EmailItem.GetBodyText, TRUE);
    //     SMTP.AppendBody('<table border ="1">');
    //     SMTP.AppendBody('<tr>');
    //     SMTP.AppendBody('<th> Description </th>');
    //     SMTP.AppendBody('<th> Values </th>');

    //     SMTP.AppendBody('<tr>');
    //     SMTP.AppendBody('<td> Store Name </td>');
    //     SMTP.AppendBody('<td> ' + RecLoc."Name 2" + '<td>');
    //     SMTP.AppendBody('</tr>');
    //     SMTP.AppendBody('</tr>');
    //     SMTP.AppendBody('<tr>');
    //     SMTP.AppendBody('<td> Order No. </td>');
    //     SMTP.AppendBody('<td>' + SOrder."External Document No." + '</td>');
    //     SMTP.AppendBody('</tr>');

    //     SMTP.AppendBody('</tr>');
    //     SMTP.AppendBody('<tr>');
    //     SMTP.AppendBody('<td> Sales Order No. </td>');
    //     SMTP.AppendBody('<td>' + SOrder."No." + '</td>');
    //     SMTP.AppendBody('</tr>');

    //     SMTP.AppendBody('</tr>');
    //     SMTP.AppendBody('<tr>');
    //     SMTP.AppendBody('<td> Order Date </td>');
    //     SMTP.AppendBody('<td>' + FORMAT(SOrder."Order Date") + '</td>');
    //     SMTP.AppendBody('</tr>');

    //     SMTP.AppendBody('<tr>');
    //     SMTP.AppendBody('<td> Customer Name </td>');
    //     SMTP.AppendBody('<td> ' + SOrder."Bill-to Name" + '</td>');
    //     SMTP.AppendBody('</tr>');
    //     SMTP.AppendBody('<tr>');
    //     SMTP.AppendBody('<td> Customer Phone </td>');
    //     SMTP.AppendBody('<td> ' + SOrder."Bill-to Contact No." + '</td>');
    //     SMTP.AppendBody('</tr>');
    //     SMTP.AppendBody('<tr>');
    //     SMTP.AppendBody('<td> Customer Address </td>');
    //     SMTP.AppendBody('<td>' + CustAddr[1] + ' ' + CustAddr[1] + ' ' + CustAddr[2] + ' ' + CustAddr[3] + ' ' + CustAddr[4] + '</td>');
    //     SMTP.AppendBody('</tr>');
    //     SMTP.AppendBody('<tr>');
    //     SMTP.AppendBody('<td> Product Details/Description </td>');
    //     SMTP.AppendBody('<td>' + ProductDescription + '/td');
    //     SMTP.AppendBody('</tr>');
    //     SMTP.AppendBody('</tr>');
    //     SMTP.AppendBody('<tr>');
    //     SMTP.AppendBody('<td> Payment Received Via </td>');
    //     SMTP.AppendBody('<td>' + WooCommerceHead.payment_method + '</td>');
    //     SMTP.AppendBody('</tr>');


    //     SMTP.Send;//Temp Lm}
    // end;

    // local procedure FindShipToAddressNew(customerno: Code[20]; Address1: Text[100]; Address2: Text[100]; City: Text[100]; State: Text[50]; Pincode: Code[10]; WooCHeader: Record "50006"): Code[20]
    // var
    //     ShiptoAdd: Record "222";
    //     found: Boolean;
    //     Scode: Code[20];
    //     ShiptoAddress: Record "222";
    // begin
    //     //KPPLDG00009
    //     Scode := '';
    //     Address1 := COPYSTR(Address1, 1, 50);
    //     Address2 := COPYSTR(Address2, 1, 50);

    //     ShiptoAdd.RESET;
    //     ShiptoAdd.SETRANGE("Customer No.", customerno);
    //     IF ShiptoAdd.FINDSET THEN
    //         REPEAT
    //             found := TRUE;
    //             IF ShiptoAdd.Address <> Address1 THEN
    //                 found := FALSE;
    //             IF ShiptoAdd."Address 2" <> Address2 THEN
    //                 found := FALSE;
    //             IF ShiptoAdd.City <> City THEN
    //                 found := FALSE;
    //             IF ShiptoAdd.State <> State THEN
    //                 found := FALSE;
    //             IF ShiptoAdd."Post Code" <> Pincode THEN
    //                 found := FALSE;

    //             IF found = TRUE THEN
    //                 Scode := ShiptoAdd.Code;

    //         UNTIL ShiptoAdd.NEXT = 0;

    //     IF (WooCHeader."Ship To first_name" <> '') AND (found = FALSE) THEN BEGIN
    //         ShiptoAddress.INIT;
    //         ShiptoAddress."Customer No." := customerno;
    //         ShiptoAddress.Code := NoSeriesManagement.GetNextNo('SHIP', TODAY, TRUE);
    //         ShiptoAddress.Name := WooCHeader."Ship To first_name" + ' ' + WooCHeader."Ship To last_name";
    //         ShiptoAddress.Address := COPYSTR(WooCHeader."Ship To address_1", 1, 50);
    //         ShiptoAddress."Address 2" := COPYSTR(WooCHeader."Ship To address_2", 1, 50);
    //         ShiptoAddress."Phone No." := WooCHeader.phone;
    //         ShiptoAddress."E-Mail" := WooCHeader.email;
    //         ShiptoAddress.City := WooCHeader."Ship To city";
    //         ShiptoAddress."Post Code" := WooCHeader."Ship To postcode";
    //         ShiptoAddress.State := WooCHeader."Ship To state";
    //         IF ShiptoAddress.INSERT THEN
    //             Scode := ShiptoAddress.Code;
    //     END;

    //     EXIT(Scode);
    // end;

    // local procedure InitProcessLog(ProcessName: Text; OrderKey: Text)
    // var
    //     WCPLogRec: Record "50022";
    //     LastEntryNo: Integer;
    // begin
    //     //>> KPPLRJ1.00
    //     WCPLogRec.RESET;
    //     IF WCPLogRec.FINDLAST THEN
    //         LastEntryNo := WCPLogRec."Entry No." + 1
    //     ELSE
    //         LastEntryNo := 1;

    //     WooCommerceProcessLog.INIT;
    //     WooCommerceProcessLog."Entry No." := LastEntryNo;
    //     WooCommerceProcessLog."Process Name" := COPYSTR(ProcessName, 1, 50);
    //     WooCommerceProcessLog."Start Date/Time" := CURRENTDATETIME;
    //     WooCommerceProcessLog."User ID" := USERID;
    //     WooCommerceProcessLog."Order Key" := OrderKey;
    //     WooCommerceProcessLog.INSERT;
    //     //<< KPPLRJ1.00
    // end;

    // local procedure InsertProcessLog(ErrorMsg: Text)
    // begin
    //     //>> KPPLRJ1.00
    //     WooCommerceProcessLog."End Date/Time" := CURRENTDATETIME;
    //     WooCommerceProcessLog."Error Description" := COPYSTR(ErrorMsg, 1, 250);
    //     WooCommerceProcessLog.MODIFY;
    //     //<< KPPLRJ1.00
    // end;

    // [Scope('Internal')]
    // procedure SendmailOrderCreationTemp(SOrder: Record "36")
    // var
    //     EmailItem: Record "9500";
    //     MailManagement: Codeunit "9520";
    //     DotNetExceptionHandler: Codeunit "1291";
    //     OutStream: OutStream;
    //     SMTP: Codeunit "400";
    //     RecLoc: Record "14";
    //     Body: Text;
    //     NotificationMailSubjectTxt: Label 'New Order Received With reference No- ';
    //     SmtpMailSetup: Record "409";
    //     T37: Record "37";
    //     RowCount: Integer;
    //     ProductDescription: Text;
    //     GSTAmount: Decimal;
    //     BillingAddress: Text[50];
    //     CustAddr: array[8] of Text[50];
    //     ShipToAddr: array[8] of Text[50];
    //     FormatAddr: Codeunit "365";
    //     WooCommerceHead: Record "50006";
    // begin
    //     EmailItem.Init;
    //     EmailItem."From Name" := COMPANYNAME;
    //     EmailItem.Subject := 'New Order Received -' + SOrder."External Document No.";
    //     Body := '<title> New Order Received </title>';
    //     RecLoc.GET(SOrder."Location Code");
    //     EmailItem."Send to" := RecLoc."E-Mail";
    //     EmailItem.Body.CREATEOUTSTREAM(OutStream);
    //     OutStream.WRITE(Body);

    //     FormatAddr.SalesHeaderBillTo(CustAddr, SOrder);
    //     FormatAddr.SalesHeaderShipTo(ShipToAddr, SOrder);
    //     CLEAR(RowCount);
    //     CLEAR(GSTAmount);
    //     CLEAR(ProductDescription);
    //     SOrder.CALCFIELDS("Amount to Customer");
    //     RowCount := 1;
    //     T37.RESET;
    //     T37.SETRANGE("Document Type", SOrder."Document Type");
    //     T37.SETRANGE("Document No.", SOrder."No.");
    //     IF T37.FINDFIRST THEN
    //         REPEAT
    //             IF RowCount = 1 THEN
    //                 ProductDescription := T37.Description
    //             ELSE
    //                 ProductDescription := ProductDescription + ' / ' + T37.Description;
    //             GSTAmount += T37."Total GST Amount";
    //             RowCount += 1;
    //         UNTIL T37.NEXT = 0;
    //     WooCommerceHead.RESET;
    //     WooCommerceHead.SETRANGE(number, COPYSTR(SOrder."External Document No.", 1, 16));
    //     IF WooCommerceHead.FINDFIRST THEN
    //         CLEAR(SMTP);
    //     SmtpMailSetup.GET;
    //     //SMTP.CreateMessage(COMPANYNAME,SmtpMailSetup."User ID",RecLoc."E-Mail",NotificationMailSubjectTxt,EmailItem.GetBodyText,TRUE);
    //     SMTP.CreateMessage(COMPANYNAME, SmtpMailSetup."User ID", 'Atul@kppl.net', EmailItem.Subject, EmailItem.GetBodyText, TRUE);
    //     SMTP.AppendBody('<table border ="1">');
    //     SMTP.AppendBody('<tr>');
    //     SMTP.AppendBody('<th> Description </th>');
    //     SMTP.AppendBody('<th> Values </th>');
    //     SMTP.AppendBody('</tr>');
    //     SMTP.AppendBody('<tr>');
    //     SMTP.AppendBody('<td> Order No. </td>');
    //     SMTP.AppendBody('<td>' + SOrder."External Document No." + '</td>');
    //     SMTP.AppendBody('</tr>');
    //     SMTP.AppendBody('<tr>');
    //     SMTP.AppendBody('<td> Product Details/Description </td>');
    //     SMTP.AppendBody('<td>' + ProductDescription + '/td');
    //     SMTP.AppendBody('</tr>');
    //     SMTP.AppendBody('<tr>');
    //     SMTP.AppendBody('<td> Product Amount </td>');
    //     SMTP.AppendBody('<td>' + FORMAT(SOrder."Amount to Customer") + '</td>');
    //     SMTP.AppendBody('</tr>');
    //     SMTP.AppendBody('<tr>');
    //     SMTP.AppendBody('<td> GST Details </td>');
    //     SMTP.AppendBody('<td>' + FORMAT(GSTAmount) + '</td>');
    //     SMTP.AppendBody('</tr>');
    //     SMTP.AppendBody('<tr>');
    //     SMTP.AppendBody('<td> Billing Address </td>');
    //     SMTP.AppendBody('<td>' + CustAddr[1] + ' ' + CustAddr[1] + ' ' + CustAddr[2] + ' ' + CustAddr[3] + ' ' + CustAddr[4] + '</td>');
    //     SMTP.AppendBody('</tr>');
    //     SMTP.AppendBody('<tr>');
    //     IF ShipToAddr[1] <> '' THEN BEGIN
    //         SMTP.AppendBody('<td> Shipping Address </td>');
    //         SMTP.AppendBody('<td>' + ShipToAddr[1] + ' ' + ShipToAddr[1] + ' ' + ShipToAddr[2] + ' ' + ShipToAddr[3] + ' ' + ShipToAddr[4] + '</td>');
    //     END ELSE BEGIN
    //         SMTP.AppendBody('<td> Shipping Address </td>');
    //         SMTP.AppendBody('<td>' + CustAddr[1] + ' ' + CustAddr[1] + ' ' + CustAddr[2] + ' ' + CustAddr[3] + ' ' + CustAddr[4] + '</td>');
    //     END;
    //     SMTP.AppendBody('</tr>');
    //     SMTP.AppendBody('<tr>');
    //     SMTP.AppendBody('<td> Any Specific Notes </td>');
    //     SMTP.AppendBody('<td>' + WooCommerceHead._billing_order_notes + '</td>');
    //     SMTP.AppendBody('</tr>');

    //     SMTP.Send;
    // end;

    // local procedure ValidateCRTCoupon(CRTCouponCode: Code[20]; ItemNo: Code[20]): Boolean
    // var
    //     LocSalesLine: Record "37";
    //     CRTCoupons: Record "50025";
    // begin
    //     //KPPLDG00042
    //     CRTCoupons.RESET;
    //     IF CRTCoupons.GET(CRTCoupons) THEN BEGIN
    //         IF CRTCoupons."Item No." <> ItemNo THEN BEGIN
    //             CRTCouponValidationMessage := ('Inavlid Coupon!. Coupon details does not belongs to the Sales item.');
    //             EXIT(FALSE);
    //         END
    //         ELSE
    //             EXIT(TRUE);
    //     END
    //     ELSE BEGIN
    //         CRTCouponValidationMessage := ('Invalid Coupon!. Coupon does not found in the system.');
    //         EXIT(FALSE);
    //     END;
    // end;
}

