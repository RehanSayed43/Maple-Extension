codeunit 50038 "Moto Order Create Batch"
{

    trigger OnRun()
    begin
        MapleMOTOIntegration1.RESET;
        MapleMOTOIntegration1.SETRANGE("Navision Order No", '');
        MapleMOTOIntegration1.SETFILTER(status, '%1|%2', ' ', 'Error');
        //MapleMOTOIntegration1.SETFILTER(status,'%1',' ');
        IF MapleMOTOIntegration1.FINDSET THEN
            REPEAT
                CheckSalesOrderInNav(MapleMOTOIntegration1.order_number);
            //lm COMMIT;
            UNTIL MapleMOTOIntegration1.NEXT = 0;
        //CheckSalesOrderInNav('');
        MESSAGE('Done');

        //CheckSalesOrderInNav('1302290654872-01');
    end;

    var
        Item: Record 27;
        RecCust: Record 18;
        NoSeriesManagement: Codeunit 396;
        ShipToaddresscode: Code[20];
        MapleMOTOIntegration: Record 50033;
        MapleMOTOIntegration1: Record 50033;


    procedure CheckSalesOrderInNav(OrderNo: Code[50])
    var
        Customer: Record 18;
        CustomeNo: Code[20];
    begin
        CLEAR(ShipToaddresscode);
        MapleMOTOIntegration.RESET;
        MapleMOTOIntegration.SETRANGE(order_number, OrderNo);
        MapleMOTOIntegration.SETFILTER(status, '%1|%2', ' ', 'Error');
        //MapleMOTOIntegration.SETFILTER(status,'%1',' ');
        IF MapleMOTOIntegration.FINDFIRST THEN BEGIN
            //MESSAGE('%1',MapleMOTOIntegration.primary_email_id);
            Customer.RESET;
            Customer.SETRANGE("Moto Cust Inv Id", MapleMOTOIntegration.invoice_number);
            IF Customer.FINDFIRST THEN BEGIN
                IF Customer."GST Registration No." <> MapleMOTOIntegration._billing_gst THEN BEGIN
                    CustomeNo := CreateCustomer(MapleMOTOIntegration);

                    IF CustomeNo <> '' THEN
                        CreatesalesOrder(MapleMOTOIntegration, CustomeNo)
                END ELSE BEGIN

                    ShipToaddresscode := FindShipToAddress(Customer."No.", MapleMOTOIntegration."Ship To address_1", MapleMOTOIntegration."Ship To address_2",
                                      MapleMOTOIntegration."Ship To city", MapleMOTOIntegration."Ship To state", MapleMOTOIntegration."Ship To postcode", MapleMOTOIntegration);
                    CreatesalesOrder(MapleMOTOIntegration, Customer."No.");
                END
            END ELSE BEGIN
                //new
                Customer.RESET;
                Customer.SETRANGE("Moto Cust Inv Id", MapleMOTOIntegration.invoice_number);
                IF Customer.FINDFIRST THEN BEGIN
                    IF Customer."GST Registration No." <> MapleMOTOIntegration._billing_gst THEN BEGIN
                        CustomeNo := CreateCustomer(MapleMOTOIntegration);

                        IF CustomeNo <> '' THEN
                            CreatesalesOrder(MapleMOTOIntegration, CustomeNo)
                    END ELSE BEGIN
                        ShipToaddresscode := FindShipToAddress(Customer."No.", MapleMOTOIntegration."Ship To address_1", MapleMOTOIntegration."Ship To address_2",
                                           MapleMOTOIntegration."Ship To city", MapleMOTOIntegration."Ship To state", MapleMOTOIntegration."Ship To postcode", MapleMOTOIntegration);
                        CreatesalesOrder(MapleMOTOIntegration, Customer."No.");
                    END;
                END ELSE BEGIN
                    //new


                    CustomeNo := CreateCustomer(MapleMOTOIntegration);
                    IF CustomeNo <> '' THEN
                        CreatesalesOrder(MapleMOTOIntegration, CustomeNo);
                END;
            END;//new

        END;
    end;

    local procedure CreatesalesOrder(MapleMOTOIntegration: Record 50033; CustomerNo: Code[20])
    var
        SalesHeader: Record 36;
        SalesLine: Record 37;
        LineNo: Integer;
        Inserted: Code[20];
        MapleMOTOIntegrationLine: Record 50033;
        intYear: Integer;
        intMonth: Integer;
        intDay: Integer;
        DateValue: Date;
        Location: Record 14;
    begin
        //MESSAGE('%1==cust%2',MapleMOTOIntegration.order_number,CustomerNo);
        SalesHeader.RESET;
        SalesHeader.SETRANGE("External Document No.", MapleMOTOIntegration.order_number);
        IF NOT SalesHeader.FINDFIRST THEN BEGIN
            SalesHeader.INIT;
            SalesHeader."Sales Order Type" := SalesHeader."Sales Order Type"::Online;
            SalesHeader."Mobile Type" := SalesHeader."Mobile Type"::Other;
            SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
            SalesHeader."No." := '';
            SalesHeader.VALIDATE("Sell-to Customer No.", CustomerNo);

            IF ShipToaddresscode <> '' THEN
                SalesHeader.VALIDATE("Ship-to Code", ShipToaddresscode);
            SalesHeader."Salesperson Code" := 'MOTO';
            EVALUATE(intYear, COPYSTR(MapleMOTOIntegration.order_date, 1, 4));
            EVALUATE(intMonth, COPYSTR(MapleMOTOIntegration.order_date, 6, 2));
            EVALUATE(intDay, COPYSTR(MapleMOTOIntegration.order_date, 9, 2));
            DateValue := DMY2DATE(intDay, intMonth, intYear);
            SalesHeader.VALIDATE("Shipment Date", DateValue);
            SalesHeader.VALIDATE("Posting Date", DateValue);
            //LM SalesHeader."Document Date":= DT2DATE(MapleMOTOIntegration.date_created);
            SalesHeader.VALIDATE("Document Date", DateValue); //LM
            SalesHeader."External Document No." := MapleMOTOIntegration.order_number;

            //LM SalesHeader."Due Date":= DT2DATE(MapleMOTOIntegration.date_created);
            //SalesHeader."Due Date":= MapleMOTOIntegration.order_date; //LM
            // SalesHeader.VALIDATE(Structure, 'GST PIT');//vC//tk
            SalesHeader.VALIDATE("Location Code", 'GW101');
            SalesHeader."Posting No." := MapleMOTOIntegration.invoice_number;
            IF Location.GET('GW101') THEN BEGIN
                // SalesHeader."Posting No. Series" := Location."Sales Invoice Nos.";
                // SalesHeader."Shipping No. Series" := Location."Sales Shipment Nos.";//TK
            END;
            SalesHeader."Web Order" := TRUE;
            SalesHeader."Payment Terms Code" := '';


            IF SalesHeader.INSERT THEN BEGIN
                MapleMOTOIntegration."Navision Order No" := SalesHeader."No.";
                MapleMOTOIntegrationLine.RESET;
                MapleMOTOIntegrationLine.SETRANGE(order_number, MapleMOTOIntegration.order_number);
                IF MapleMOTOIntegrationLine.FINDSET THEN
                    REPEAT

                        SalesLine.INIT;
                        SalesLine."Document Type" := SalesHeader."Document Type";
                        SalesLine."Document No." := SalesHeader."No.";
                        SalesLine."Line No." := GetLineNO(SalesLine);
                        SalesLine.Type := SalesLine.Type::Item;
                        IF SalesLine.INSERT THEN BEGIN
                            SalesLine.VALIDATE("No.", CheckItemVendorNo(MapleMOTOIntegrationLine.product_sku));
                            SalesLine.VALIDATE(Quantity, MapleMOTOIntegrationLine.quantity);
                            SalesLine.VALIDATE("Unit Price Incl. of Tax", MapleMOTOIntegrationLine.total_price);
                            // SalesLine.VALIDATE("PIT Structure", 'GST PIT'); //LM//tk
                            SalesLine.VALIDATE("Price Inclusive of Tax", TRUE); // LM
                            SalesLine.VALIDATE("Location Code", 'GW101');
                            SalesLine.VALIDATE("Unit Price", ((MapleMOTOIntegrationLine.total_price * 100) / 118)); //LM
                                                                                                                    //SalesLine.VALIDATE("Line Discount Amount",MapleMOTOIntegrationLine.discount);
                            SalesLine.VALIDATE("Salesperson Code", 'MOTO');
                            IF SalesLine.MODIFY() THEN
                                //WooCommerceLine."Navision Order No":= SalesHeader."No.";
                                Inserted := SalesHeader."No.";
                            MapleMOTOIntegrationLine.status := 'Completed';
                            MapleMOTOIntegrationLine."Navision Order No" := SalesHeader."No.";
                            MapleMOTOIntegrationLine.MODIFY;

                        END;
                    UNTIL MapleMOTOIntegrationLine.NEXT = 0;


            END;

        END;


        //SendmailOrderCreation(SalesHeader);


        IF SalesHeader.GET(SalesHeader."Document Type"::Order, Inserted) THEN BEGIN
            //SalesHeader.VALIDATE(Structure,'GST PIT');//vC
            // SalesHeader.VALIDATE("Price Inclusive of Taxes",TRUE);//LM
            SalesHeader.VALIDATE("Shortcut Dimension 1 Code", 'MOTOGURGAON');
            SalesHeader.VALIDATE("Shortcut Dimension 2 Code", 'MOTOROLA');
            SalesHeader.MODIFY;
        END;

        // SalesHeader.CALCFIELDS("Price Inclusive of Taxes");
        // IF SalesHeader."Price Inclusive of Taxes" THEN BEGIN
        //     SalesLine.InitStrOrdDetail(SalesHeader);
        //     SalesLine.GetSalesPriceExclusiveTaxes(SalesHeader);
        //     SalesLine.UpdateSalesLinesPIT(SalesHeader);
        // END;
        // SalesLine.CalculateStructures(SalesHeader);
        // SalesLine.AdjustStructureAmounts(SalesHeader);
        // SalesLine.UpdateSalesLines(SalesHeader);//tk
        COMMIT; //KPPL
    end;

    local procedure CreateCustomer(CusMapleMOTOIntegration: Record 50033): Code[20]
    var
        Customer: Record 18;
        ShiptoAddress: Record 222;
        Item: Record 27;
        SalesSetup: Record 311;
        State: Record State;
    begin

        Customer.INIT;
        SalesSetup.GET;
        Customer."No." := NoSeriesManagement.GetNextNo(SalesSetup."Retail Customer Nos.", TODAY, TRUE);

        Customer.Name := CusMapleMOTOIntegration.name + ' ' + CusMapleMOTOIntegration."Bill To last_name";
        Customer."Phone No." := CusMapleMOTOIntegration.phone;
        //Customer."Phone No.2"
        Customer."E-Mail" := CusMapleMOTOIntegration.primary_email_id;
        Customer."Moto Cust Inv Id" := CusMapleMOTOIntegration.invoice_number;
        Customer.Address := COPYSTR(CusMapleMOTOIntegration.address_line1, 1, 50);
        Customer."Address 2" := COPYSTR(CusMapleMOTOIntegration.address_line1, 51, 50);
        Customer."Cust Adress 3" := COPYSTR(CusMapleMOTOIntegration.address_line1, 101, 150);
        //Customer."Address 2":= COPYSTR(CusMapleMOTOIntegration.add,1,50);
        Customer.City := CusMapleMOTOIntegration.city;
        Customer."Post Code" := CusMapleMOTOIntegration.pin_code;
        State.RESET;
        State.SETRANGE(Description, CusMapleMOTOIntegration.state);
        IF State.FINDFIRST THEN
            Customer."State Code" := State.Code;
        Customer."Customer Type" := Customer."Customer Type"::Retail;
        Customer."Gen. Bus. Posting Group" := 'Retail';
        Customer."Customer Posting Group" := 'MOTO';
        // Customer.Structure := 'GST PIT';//VT+ST(PIT)//tk
        //Customer.Structure := 'VT+ST(PIT)';
        Customer."Tax Liable" := TRUE;
        IF CusMapleMOTOIntegration._billing_gst <> '' THEN BEGIN
            Customer."GST Customer Type" := Customer."GST Customer Type"::Registered;
            Customer."GST Registration No." := CusMapleMOTOIntegration._billing_gst;
            Customer."GST Registration Type" := 1;
        END ELSE BEGIN
            Customer."GST Customer Type" := Customer."GST Customer Type"::Unregistered;
        END;
        //IF Customer."Phone No."='' THEN
        //Customer."Not Interested Customer":=TRUE;
        IF Customer.INSERT THEN BEGIN

            IF Customer."Customer Points" <> 0 THEN
                Customer."Customer Points" := 0;
            IF Customer.INSERT THEN BEGIN
                IF CusMapleMOTOIntegration."Ship To first_name" <> '' THEN BEGIN
                    ShiptoAddress.INIT;
                    ShiptoAddress."Customer No." := Customer."No.";
                    ShiptoAddress.Code := Customer."No.";
                    ShiptoAddress.Name := CusMapleMOTOIntegration.name;
                    ShiptoAddress.Address := COPYSTR(CusMapleMOTOIntegration.address_line1, 1, 50);
                    //ShiptoAddress."Address 2":= COPYSTR(CusMapleMOTOIntegration."Ship To address_2",1,50);
                    ShiptoAddress."Phone No." := CusMapleMOTOIntegration.phone;
                    ShiptoAddress."E-Mail" := CusMapleMOTOIntegration.email;
                    ShiptoAddress.City := CusMapleMOTOIntegration."Ship To city";
                    ShiptoAddress."Post Code" := CusMapleMOTOIntegration."Ship To postcode";
                    ShiptoAddress.State := CusMapleMOTOIntegration."Ship To state";
                    IF ShiptoAddress.INSERT THEN
                        ShipToaddresscode := ShiptoAddress.Code;
                END;
                EXIT(Customer."No.");
            END;
        END;
    end;

    local procedure GetLineNO(salesline: Record 37): Integer
    var
        salesline1: Record 37;
    begin
        salesline1.RESET;
        salesline1.SETRANGE("Document No.", salesline."Document No.");
        IF salesline1.FINDLAST THEN
            EXIT(salesline1."Line No." + 10000)
        ELSE
            EXIT(10000);
    end;

    local procedure FindShipToAddress(customerno: Code[20]; Address1: Text[100]; Address2: Text[100]; City: Text[100]; State: Text[50]; Pincode: Code[10]; MapleMOTOIntegration: Record 50033): Code[20]
    var
        ShiptoAdd: Record 222;
        found: Boolean;
        Scode: Code[20];
        ShiptoAddress: Record 222;
    begin
        Scode := '';
        Address1 := COPYSTR(Address1, 1, 50);
        Address2 := COPYSTR(Address2, 1, 50);
        ShiptoAdd.RESET;
        ShiptoAdd.SETRANGE("Customer No.", customerno);
        IF ShiptoAdd.FINDSET THEN
            REPEAT
                found := TRUE;
                IF ShiptoAdd.Address = Address1 THEN
                    found := FALSE;
                IF ShiptoAdd."Address 2" = Address2 THEN
                    found := FALSE;
                IF ShiptoAdd.City = City THEN
                    found := FALSE;
                IF ShiptoAdd.State = State THEN
                    found := FALSE;
                IF ShiptoAdd."Post Code" = Pincode THEN
                    found := FALSE;
                IF found = TRUE THEN
                    Scode := ShiptoAdd.Code
                ELSE BEGIN
                    IF MapleMOTOIntegration."Ship To first_name" <> '' THEN BEGIN
                        ShiptoAddress.INIT;
                        ShiptoAddress."Customer No." := customerno;
                        ShiptoAddress.Code := '';
                        ShiptoAddress.Name := MapleMOTOIntegration."Ship To first_name" + ' ' + MapleMOTOIntegration."Ship To last_name";
                        ShiptoAddress.Address := COPYSTR(MapleMOTOIntegration."Ship To address_1", 1, 50);
                        ShiptoAddress."Address 2" := COPYSTR(MapleMOTOIntegration."Ship To address_2", 1, 50);
                        ShiptoAddress."Phone No." := MapleMOTOIntegration.phone;
                        ShiptoAddress."E-Mail" := MapleMOTOIntegration.email;
                        ShiptoAddress.City := MapleMOTOIntegration."Ship To city";
                        ShiptoAddress."Post Code" := MapleMOTOIntegration."Ship To postcode";
                        ShiptoAddress.State := MapleMOTOIntegration."Ship To state";
                        IF ShiptoAddress.INSERT THEN
                            Scode := ShiptoAddress.Code;
                    END;
                END;
            UNTIL (ShiptoAdd.NEXT = 0);

        EXIT(Scode);
    end;

    local procedure CheckItemVendorNo(SKU: Code[50]): Code[50]
    var
        Item: Record 27;
    begin
        Item.SETRANGE("Vendor Part Code Long", SKU);
        IF Item.FINDFIRST THEN
            EXIT(Item."No.");
    end;
}

