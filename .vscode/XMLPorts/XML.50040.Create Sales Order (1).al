xmlport 50040 "Create Sales Order"
{
    //UseDefaultNamespace = true;
    Direction = Import;

    schema
    {
        textelement(NodeName1)
        {
            tableelement(SalesHeader; "Sales Header")
            {
                MinOccurs = Once;
                UseTemporary = true;

                fieldattribute(ERPCustomerNo; SalesHeader."Sell-to Customer No.")
                {
                    Occurrence = Optional;
                }
                fieldattribute(EcommCustomerID; SalesHeader."E-Commerce Customer")
                {

                }

                fieldattribute(EcomOrder; SalesHeader."Order ID")
                {

                }
                fieldattribute(OrderKey; SalesHeader.orderKey)
                {

                }
                fieldattribute(GSTNo; SalesHeader."API GST Reg No")
                {
                    Occurrence = Optional;
                }
                fieldattribute(PAN; SalesHeader."API PAN")
                {
                    Occurrence = Optional;
                }
                fieldattribute(PaymentStatus; SalesHeader."Payment Status")
                {
                    Occurrence = Optional;
                }
                fieldattribute(BillToFirstName; SalesHeader."Bill-to Name")
                {
                    Occurrence = Optional;
                }
                fieldattribute(BillToLastName; SalesHeader."Bill-to Name 2")
                {
                    Occurrence = Optional;
                }
                fieldattribute(PhoneNumber; SalesHeader."Sell-to Phone No.")
                {
                    Occurrence = Optional;
                }
                fieldattribute(Email; SalesHeader."Sell-to E-Mail")
                {
                    Occurrence = Optional;
                }

                fieldattribute(BillToAddress; SalesHeader."Bill-to Address")
                {
                    Occurrence = Optional;
                }
                fieldattribute(BillToAddress2; SalesHeader."Bill-to Address 2")
                {
                    Occurrence = Optional;
                }
                fieldattribute(BillToCity; SalesHeader."Bill-to City")
                {
                    Occurrence = Optional;
                }
                fieldattribute(BillToPostCode; SalesHeader."Bill-to Post Code")
                {
                    Occurrence = Optional;
                }
                fieldattribute(BillToState; SalesHeader."Bill-to County")
                {
                    Occurrence = Optional;
                }
                fieldattribute(ShipToFirstName; SalesHeader."Ship-to Name")
                {
                    Occurrence = Optional;
                }
                fieldattribute(ShipToLastName; SalesHeader."Ship-to Name 2")
                {
                    Occurrence = Optional;
                }
                fieldattribute(ShipToAddress; SalesHeader."Ship-to Address")
                {
                    Occurrence = Optional;
                }
                fieldattribute(ShipToAddress2; SalesHeader."Ship-to Address 2")
                {
                    Occurrence = Optional;
                }
                fieldattribute(ShipToCity; SalesHeader."Ship-to City")
                {
                    Occurrence = Optional;
                }
                fieldattribute(ShipToPostCode; SalesHeader."Ship-to Post Code")
                {
                    Occurrence = Optional;
                }
                fieldattribute(ShipToSate; SalesHeader."Ship-to County")
                {
                    Occurrence = Optional;
                }
                fieldattribute(GSTRegistrationNumber; SalesHeader."Ship-to GST Reg. No.")
                {
                    Occurrence = Optional;
                }
                fieldattribute(orderStatus; SalesHeader.orderStatus)
                {
                    Occurrence = Optional;
                }
                fieldattribute(orderDateTime; SalesHeader.orderDateTime)
                {
                    Occurrence = Optional;
                }
                fieldattribute(paymentMode; SalesHeader."Payment Mode")
                {
                    Occurrence = Optional;
                }
                /*
                tableelement(DimensionSetEntry; "Dimension Set Entry")
                {
                    LinkTable = SalesHeader;
                    UseTemporary = true;
                    MinOccurs = Zero;
                    fieldelement(DimensionCode; DimensionSetEntry."Dimension Code")
                    {
                        MinOccurs = Zero;
                    }
                    fieldelement(DimensionValueCode; DimensionSetEntry."Dimension Value Code")
                    {
                        MinOccurs = Zero;
                    }


                    trigger OnAfterInsertRecord();
                    var
                        PH: Record "Sales Header";
                        GLSetup: Record "General Ledger Setup";
                        boolDimnotFound1: Boolean;//CITS_RS
                        boolDimnotFound2: Boolean;//CITS_RS
                        DimensionSetEntry2: Record "Dimension Set Entry";
                        tmpDimensionSetEntry4: Record "Dimension Set Entry" temporary;//CITS_RS
                        DimensionSetEntry3: Record "Dimension Set Entry";
                    begin

                        GLSetup.Get();
                        IF PH.GET(SalesHeader."Document Type", DocNo) THEN;

                        Clear(TempDimSetEntry);
                        Clear(DimMngt);
                        DimMngt.GetDimensionSet(TempDimSetEntry, PH."Dimension Set ID");


                        // DimMngt.GetDimensionSet(TempDimSetEntry, PH."Dimension Set ID");
                        // if PH."Dimension Set ID" <> 0 then begin//CITS_RS
                        //     DimensionSetEntry2.Reset();
                        //     DimensionSetEntry2.SetRange(DimensionSetEntry2."Dimension Set ID", PH."Dimension Set ID");
                        //     DimensionSetEntry2.SetRange(DimensionSetEntry2."Dimension Code", DimensionSetEntry."Dimension Code");
                        //     IF DimensionSetEntry2.FindFirst() THEN BEGIN
                        //         DimensionSetEntry2.Validate(DimensionSetEntry2."Dimension Value Code", DimensionSetEntry."Dimension Value Code");
                        //         DimensionSetEntry2.Modify();
                        //     END else begin //CITS_RS ++

                        GeneralBBQFunctions.UpdateDimension(TempDimSetEntry, DimensionSetEntry."Dimension Code", DimensionSetEntry."Dimension Value Code");

                        NewDimSetID := DimMngt.GetDimensionSetID(TempDimSetEntry);
                        //     END;
                        //     IF PH."Dimension Set ID" <> NewDimSetID THEN BEGIN
                        //         PH."Dimension Set ID" := NewDimSetID;
                        //         // PH.Validate("Dimension Set ID", NewDimSetID);//CITS_RS

                        //         PH.Modify(true);
                        //     end;
                        //     //CITS_RS ++
                        // end
                        // ELSE BEGIN

                        //     GeneralBBQFunctions.UpdateDimension(TempDimSetEntry, DimensionSetEntry."Dimension Code", DimensionSetEntry."Dimension Value Code");

                        //     NewDimSetID := DimMngt.GetDimensionSetID(TempDimSetEntry);
                        // END;
                        IF PH."Dimension Set ID" <> NewDimSetID THEN BEGIN
                            PH."Dimension Set ID" := NewDimSetID;
                            // PH.Validate("Dimension Set ID", NewDimSetID);//CITS_RS

                            PH.Modify(true);
                        END;

                        IF DimensionSetEntry."Dimension Code" = GLSetup."Global Dimension 1 Code" THEN BEGIN
                            PH.validate("Shortcut Dimension 1 Code", DimensionSetEntry."Dimension Value Code");
                        END;
                        IF DimensionSetEntry."Dimension Code" = GLSetup."Global Dimension 2 Code" THEN
                            PH.validate("Shortcut Dimension 2 Code", DimensionSetEntry."Dimension Value Code");
                        PH.MODIFY(TRUE);

                    end;

                }
                */
                tableelement(SalesLine; "Sales Line")
                {
                    LinkTable = SalesHeader;
                    MinOccurs = Zero;
                    UseTemporary = true;

                    fieldattribute(Type; SalesLine.Type)
                    {
                        Occurrence = Optional;
                    }
                    fieldattribute(No; SalesLine."Vendor Part Code")
                    {
                        Occurrence = Optional;
                    }

                    fieldattribute(Qty; SalesLine.Quantity)
                    {
                        Occurrence = Optional;
                    }
                    fieldattribute(UnitPrice; SalesLine."Unit Price Incl. of Tax")
                    {
                        Occurrence = Optional;
                    }
                    fieldattribute(DeliveryTime; SalesLine."Delivery Time")
                    {
                        Occurrence = Optional;
                    }
                    fieldattribute(ExpectedDeliveryTime; SalesLine."Expected Delivery Date Time")
                    {
                        Occurrence = Optional;
                    }
                    fieldattribute(Is_Lob; SalesLine."IS LOB Order")
                    {
                        Occurrence = Optional;
                    }
                    fieldattribute(SerialNo; SalesLine."API Serial No.")
                    {
                        Occurrence = Optional;
                    }
                    fieldattribute(BillingLocationCode; SalesLine."Location Code")
                    {
                        Occurrence = Optional;
                    }
                    fieldattribute(Apple; SalesLine.Apple)//SalesLine.Apple)
                    {
                        Occurrence = Optional;
                    }


                    //Sales Line Line
                    trigger OnAfterInitRecord()
                    BEGIN
                        LineNo += 10000;
                        SalesLine."Line No." := LineNo;
                    END;

                    trigger OnAfterInsertRecord()
                    var
                        Cust: Record Customer;
                        SH: Record "Sales Header";
                        TempReservEntry: Record "Reservation Entry" temporary;
                        CreateReservEntry: Codeunit "Create Reserv. Entry";
                        ReservStatus: Enum "Reservation Status";
                        ItemRec: Record Item;
                    BEGIN
                        BEGIN
                            IF Cust.GET(SalesHeader."Sell-to Customer No.") THEN;
                            //IF NOT SalesLineRec.GET(SalesLineRec."Document Type", SalesLineRec."Document No.", SalesLineRec."Line No.") THEN 
                            BEGIN
                                // NG 28072023 +++
                                IF SH.GET(SalesHeader."Document Type"::Order, DocNo) THEN BEGIN
                                    IF SH."Location Code" = '' THEN BEGIN
                                        /*           SH.VALIDATE("Location Code", SalesLine."Location Code");//'CW101'; */
                                        SH."Location Code" := SalesLine."Location Code";
                                        SH.Modify(false);
                                    END;
                                end;

                                // NG 28072023 ---
                                SalesLineRec.INIT();
                                SalesLineRec."Document Type" := SalesLineRec."Document Type"::Order;
                                SalesLineRec."Document No." := DocNo;
                                SalesLineRec."Line No." := LineNo;
                                SalesLineRec.Type := SalesLine.Type::Item;
                                //>>>>>
                                IF SalesLine.Apple THEN BEGIN
                                    ItemRec.Reset();
                                    ItemRec.SetRange(ItemRec."Vendor Part Code Long", SalesLine."Vendor Part Code");
                                    IF ItemRec.FindFirst() THEN
                                        SalesLineRec.VALIDATE("No.", ItemRec."No.");
                                END
                                ELSE
                                    //<<<<<
                                    SalesLineRec.VALIDATE("No.", SalesLine."Vendor Part Code");

                                //SalesLine."No." := SalesLine."Vendor Part Code";

                                /* SalesLineRec.Validate("Location Code", SalesLine."Location Code"); */
                                SalesLineRec."Location Code" := SalesLine."Location Code";
                                SalesLineRec."API Serial No." := SalesLine."API Serial No.";
                                SalesLineRec.VALIDATE(Quantity, SalesLine.quantity);
                                SalesLineRec.VALIDATE(SalesLineRec."Unit Price Incl. of Tax", ROUND(SalesLine."Unit Price Incl. of Tax"));//+ WooCommerceLine.total_tax));
                                SalesLineRec."Salesperson Code" := 'ECOMM';
                                SalesLineRec.INSERT();
                                // NG 28072023 ++
                                TempReservEntry.Init();
                                TempReservEntry."Entry No." := 0;
                                TempReservEntry."Serial No." := SalesLine."API Serial No.";
                                TempReservEntry."Source ID" := SalesLine."Document No.";
                                TempReservEntry.Quantity := 1;
                                TempReservEntry.Insert();
                                CreateReservEntry.SetDates(0D, TempReservEntry."Expiration Date");
                                //CreateReservEntry.CreateReservEntryFor(Database::"Sales Line", SalesLine."Document Type".AsInteger(), SalesLine."Document No.", '', 0, SalesLine."Line No.", SalesLine."Qty. per Unit of Measure", TempReservEntry.Quantity, TempReservEntry.Quantity * SalesLine."Qty. per Unit of Measure", TempReservEntry);
                                //  CreateReservEntry.CreateEntry(SalesLine."No.", SalesLine."Variant Code", SalesLine."Location Code", '', Today, Today, 0, ReservStatus::Surplus);
                                CreateReservEntry.CreateReservEntryFor(Database::"Sales Line", 1, DocNo, '', 0,
    SalesLine."Line No.", SalesLine."Qty. per Unit of Measure", TempReservEntry.Quantity, TempReservEntry.Quantity * SalesLine."Qty. per Unit of Measure", TempReservEntry);
                                CreateReservEntry.CreateEntry(SalesLineRec."No.", SalesLine."Variant Code", SalesLine."Location Code", SalesLine.Description, 0D,
      Today, 0, Enum::"Reservation Status"::Surplus);
                                /* CreateEntryResSalesLine(SalesLine."No.", SalesLine."Variant Code", SalesLine."Location Code", SalesLine.Description, 0D,
                                SalesLine."Shipment Date", 0, Enum::"Reservation Status"::Surplus, SalesLine, DocNo); */
                                // NG 28072023 --

                                IF SH.GET(SalesHeader."Document Type", DocNo) THEN BEGIN
                                    SalesLineRec.VALIDATE(SalesLineRec."Shortcut Dimension 1 Code", SH."Shortcut Dimension 1 Code");
                                    SalesLineRec.VALIDATE(SalesLineRec."Shortcut Dimension 2 Code", SH."Shortcut Dimension 2 Code");
                                    SalesLineRec.VALIDATE(SalesLineRec."Dimension Set ID", SH."Dimension Set ID");
                                    SalesLineRec."Delivery Time" := SalesLine."Delivery Time";
                                    SalesLineRec."Expected Delivery Date Time" := SalesLine."Expected Delivery Date Time";
                                    SalesLineRec."IS LOB Order" := SalesLine."IS LOB Order";
                                    SalesLineRec."Salesperson Code" := 'ECOMM';
                                    SalesLineRec.MODIFY(TRUE);
                                END;
                            END;
                        END;
                    END;
                }
                //Sales Header



                trigger OnAfterInsertRecord()
                VAR
                    SH: Record "Sales Header";
                    SalesCommentLine: Record 43;
                    CustNo: Code[20];
                    SingleInstanceCodeunit: Codeunit "Single Instance Codeunit";
                BEGIN
                    Clear(CustNo);

                    IF NOT SalesHeaderRec.GET(SalesHeader."Document Type"::Order, SalesHeader."No.") THen BEGIN
                        SalesNPayable.Get();
                        DocNo := NoSeriesMgt.GetNextNo(SalesNPayable."Order Nos.", Today, TRUE);
                        SalesHeader."Document Type" := SalesHeader."Document Type";
                        SalesHeader."No." := DocNo;
                        SalesHeader."Document Date" := Today;
                        SingleInstanceCodeunit.SetPONumber(DocNo);
                        SalesHeader."Location Code" := 'CW101';

                        //IF (SalesHeader."Sell-to Customer No." = '') OR (SalesHeader."API GST Reg No" <> '') THEN;
                        BEGIN
                            CustNo := CheckCustomer(SalesHeader);
                            ShipToaddresscode := FindShipToAddress(CustNo, SalesHeader."Ship-to Address", SalesHeader."Ship-to Address 2",
                                                               SalesHeader."Ship-to City", SalesHeader."Ship-to County", SalesHeader."Ship-to Post Code", SalesHeader);
                        END;
                        // ELSE
                        //     ShipToaddresscode := FindShipToAddress(SalesHeader."Sell-to Customer No.", SalesHeader."Ship-to Address", SalesHeader."Ship-to Address 2",
                        //                                                               SalesHeader."Ship-to City", SalesHeader."Ship-to County", SalesHeader."Ship-to Post Code", SalesHeader);

                        SalesHeaderRec.INIT();
                        SalesHeaderRec.TRANSFERFIELDS(SalesHeader);
                        SalesHeaderRec."Sales Order Type" := SalesHeader."Sales Order Type"::B2B;
                        SalesHeaderRec."Mobile Type" := SalesHeader."Mobile Type"::Apple;
                        SalesHeaderRec."Document Type" := SalesHeader."Document Type"::Order;
                        IF SalesHeader."Sell-to Customer No." <> '' THEN
                            SalesHeaderRec.VALIDATE("Sell-to Customer No.", SalesHeader."Sell-to Customer No.")
                        ELSE
                            SalesHeaderRec.VALIDATE("Sell-to Customer No.", CustNo);

                        IF ShipToaddresscode <> '' THEN
                            SalesHeaderRec.VALIDATE("Ship-to Code", ShipToaddresscode);
                        SalesHeaderRec."Salesperson Code" := 'ECOMM';
                        SalesHeaderRec."External Document No." := SalesHeader."External Document No.";
                        //   SalesHeaderRec.VALIDATE("Location Code", 'CW101'); // Comment NG
                        // SalesHeaderRec."Location Code" := 'CW101';//SalesHeader."Location Code"; // Added NG
                        SalesHeaderRec."Order Date" := Today;
                        SalesHeaderRec.Validate("Posting Date", Today);
                        SalesHeaderRec.Validate("Document Date", Today);
                        //SalesHeaderRec.Validate("Payment Terms Code", SalesHeader."Payment Terms Code");
                        SalesHeaderRec.INSERT(TRUE);
                        //*******   

                        IF SH.GET(SalesHeader."Document Type"::Order, DocNo) THEN BEGIN
                            /*      SH.VALIDATE("Shortcut Dimension 1 Code", 'VIKROLI');
                                 SH.VALIDATE("Shortcut Dimension 2 Code", 'ONLINE'); 
                                 Comment NG
                                 */
                            SH."Web Order" := true;
                            SH."E-Commerce Customer" := SalesHeader."E-Commerce Customer";
                            SH.orderKey := SalesHeader.orderKey;
                            SH."Order Time" := Time;
                            SH."Payment Status" := SalesHeader."Payment Status";
                            SH.orderDateTime := SalesHeader.orderDateTime;
                            SH.orderStatus := SalesHeader.orderStatus;
                            SH."Payment Mode" := SalesHeader."Payment Mode";
                            SH.erpSoTimestamp := CurrentDateTime;
                            /*
                            PH.Validate("Location Code", SalesHeader."Location Code");
                            SalesCommentLine.RESET;
                            SalesCommentLine.SETRANGE(SalesCommentLine."Document Type", DocType);
                            SalesCommentLine.SETRANGE(SalesCommentLine."No.", DocNo);
                            IF NOT SalesCommentLine.FindFirst() THEN
                                IF Comment <> '' THEN BEGIN
                                    deleteCount := 0;
                                    InsertNarrationPurch(PH, 0, COPYSTR(Comment, 1, 50));
                                    InsertNarrationPurch(PH, 0, COPYSTR(Comment, 51, 50));
                                    InsertNarrationPurch(PH, 0, COPYSTR(Comment, 101, 50));
                                    InsertNarrationPurch(PH, 0, COPYSTR(Comment, 151, 50));
                                    InsertNarrationPurch(PH, 0, COPYSTR(Comment, 251, 50));
                                END;
*/
                            // SH."Sell-to Customer Name" := SalesHeader."Ship-to Name";
                            // SH."Sell-to Customer Name 2" := SalesHeader."Ship-to Name 2";


                            SH."Sell-to Address" := SalesHeader."Ship-to Address";
                            SH."Sell-to Address 2" := SalesHeader."Ship-to Address 2";
                            SH."Sell-to City" := SalesHeader."Ship-to City";
                            SH."Sell-to Post Code" := SalesHeader."Ship-to Post Code";
                            SH."Sell-to County" := SalesHeader."Ship-to County";

                            SH."Ship-to Name" := SalesHeader."Ship-to Name" + ' ' + SalesHeader."Ship-to Name 2";
                            //SH."Ship-to Name 2" := SalesHeader."Ship-to Name 2";

                            SH."Ship-to Address" := SalesHeader."Ship-to Address";
                            SH."Ship-to Address 2" := SalesHeader."Ship-to Address 2";
                            SH."Ship-to City" := SalesHeader."Ship-to City";
                            SH."Ship-to Post Code" := SalesHeader."Ship-to Post Code";
                            SH."Ship-to County" := SalesHeader."Ship-to County";
                            DimensionSetEntry.init();
                            DimensionSetEntry.validate("Dimension Code", 'VERTICAL');
                            DimensionSetEntry.validate("Dimension Value Code", 'ONLINE');
                            DimensionSetEntry.Insert();
                            DimensionSetEntry.init();
                            DimensionSetEntry.validate("Dimension Code", 'BRANCH');
                            DimensionSetEntry.validate("Dimension Value Code", 'VIKROLI');
                            DimensionSetEntry.Insert();
                            UpdateDimSetOnSalesHeader(SH, DimensionSetEntry);
                            SH.Validate("Shortcut Dimension 1 Code", 'VIKROLI');
                            SH.Validate("Shortcut Dimension 2 Code", 'ONLINE');
                            SH.Validate("Dimension Set ID", SH."Dimension Set ID");


                            SH.ERPBillToAdd1 := SalesHeader."Bill-to Address";
                            SH.ERPBillToAdd2 := SalesHeader."Bill-to Address 2";
                            SH.ERPBillToCity := SalesHeader."Bill-to City";
                            SH.ERPBillToPostCode := SalesHeader."Bill-to Post Code";
                            SH.ERPBillToState := SalesHeader."Bill-to County";

                            SH.ERPShipToAdd1 := SalesHeader."Ship-to Address";
                            SH.ERPShipToAdd2 := SalesHeader."Ship-to Address 2";
                            SH.ERPShipToCity := SalesHeader."Ship-to City";
                            SH.ERPShipToState := SalesHeader."Ship-to City";
                            SH.ERPShipToPostCode := SalesHeader."Ship-to Post Code";
                            SH.Modify();
                        END;
                    END;
                    LineNo := 0;
                END;
            }

        }

    }


    requestpage
    {
        layout
        {

        }


    }

    local procedure CheckCustomer(SH: Record "Sales Header"): Code[20]
    var
        Customer: Record Customer;
        CustomeNo: Code[20];
        CreateNewCustomer: Boolean;
    BEGIN
        CreateNewCustomer := false;

        Customer.RESET();
        Customer.SETRANGE("Phone No.", SH."Sell-to Phone No.");
        Customer.SETRANGE("GST Registration No.", SH."API GST Reg No");
        Customer.SETRANGE(Name, SH."Bill-to Name" + ' ' + SH."Bill-to Name 2");
        //Customer.SETRANGE("Name 2", );
        Customer.SETRANGE("State Code", SH."Bill-to County");
        Customer.SETRANGE(Address, SH."Bill-to Address");
        Customer.SETRANGE("Address 2", SH."Bill-to Address 2");
        Customer.SETRANGE(City, SH."Bill-to City");
        Customer.SETRANGE("Post Code", SH."Bill-to Post Code");
        IF Customer.FINDFIRST() THEN BEGIN
            exit(Customer."No.");
        END
        ELSE
            CreateNewCustomer := true;

        IF CreateNewCustomer THEN BEGIN
            CustomeNo := CreateCustomer(SH);
            exit(CustomeNo);
        END;
        /*
                Customer.RESET();
                Customer.SETRANGE("Phone No.", SH."Sell-to Phone No.");
                IF Customer.FINDFIRST() THEN BEGIN
                    IF Customer."GST Registration No." <> SH."API GST Reg No" THEN BEGIN
                        CustomeNo := CreateCustomer(SH);

                        IF CustomeNo <> '' THEN
                            exit(CustomeNo);
                    END
                    ELSE BEGIN
                        exit(Customer."No."); // Added NG 280723
                        // exit(CustomeNo); 
                    END;
                END ELSE BEGIN
                    Customer.RESET();
                    Customer.SETRANGE("E-Mail", SH."Sell-to E-Mail");
                    IF Customer.FINDFIRST() THEN BEGIN
                        IF Customer."GST Registration No." <> SH."API GST Reg No" THEN BEGIN
                            CustomeNo := CreateCustomer(SH);
                            IF CustomeNo <> '' THEN
                                exit(CustomeNo);
                        END ELSE BEGIN
                            exit(Customer."No."); // Added NG 280723
                            //exit(CustomeNo); 
                        END;
                    END ELSE BEGIN
                        CustomeNo := CreateCustomer(SH);
                        IF CustomeNo <> '' THEN
                            exit(CustomeNo);
                    END;
                END;
        */
    END;



    local procedure CreateCustomer(SalesH: Record "Sales Header"): Code[20]
    var
        Customer: Record Customer;
        NoSeriesManagement: Codeunit NoSeriesManagement;
        SalesSetup: Record "Sales & Receivables Setup";
        ShiptoAddress: Record 222;
        CustomerNumber: Code[20];
    BEGIN
        Clear(CustomerNumber);
        SalesSetup.Get();
        Customer.INIT();
        CustomerNumber := NoSeriesManagement.GetNextNo(SalesSetup."Retail Customer Nos.", TODAY, TRUE);
        Customer."No." := CustomerNumber;
        Customer.Name := SalesH."Bill-to Name" + ' ' + SalesH."Bill-to Name 2";
        //Customer."Name 2" := ;
        Customer."Phone No." := SalesH."Sell-to Phone No.";
        //Customer."Phone No.2"
        Customer."E-Mail" := SalesH."Sell-to E-Mail";
        Customer.Address := SalesH."Bill-to Address";
        Customer."Address 2" := SalesH."Bill-to Address 2";
        Customer.City := SalesH."Bill-to City";
        Customer."Post Code" := SalesH."Bill-to Post Code";
        Customer."State Code" := SalesH."Bill-to County";
        Customer."Country/Region Code" := 'IN';
        Customer."Customer Type" := Customer."Customer Type"::Retail;
        Customer."Gen. Bus. Posting Group" := 'Retail';
        Customer."Customer Posting Group" := 'Retail';
        Customer."P.A.N. No." := SalesH."API PAN";
        //Customer.Structure := 'VT+ST(PIT)';
        Customer."Tax Liable" := TRUE;
        IF SalesH."API GST Reg No" <> '' THEN BEGIN
            Customer."GST Customer Type" := Customer."GST Customer Type"::Registered;
            Customer."GST Registration No." := SalesH."API GST Reg No";
            Customer."GST Registration Type" := 1;
        END ELSE BEGIN
            Customer."GST Customer Type" := Customer."GST Customer Type"::Unregistered;
        END;
        IF Customer."Phone No." = '' THEN
            Customer."Not Interested Customer" := TRUE;
        IF Customer.INSERT() THEN BEGIN
            /* //COMMENTED
                // Mapple NG 1.0 START 30062023 - Customer ERP Mapping After Customer Create
                if Customer."No." <> '' then
                    CustomerERPMapping(Customer."No.");
                // Mapple NG 1.0 END 30062023 - Customer ERP Mapping After Customer Create
                */
            IF Customer."Customer Points" <> 0 THEN
                Customer."Customer Points" := 0;
            /* IF Customer.INSERT() THEN BEGIN */ // 2707203 NG No Need
            IF SalesH."Ship-to Name" <> '' THEN BEGIN
                ShiptoAddress.INIT();
                ShiptoAddress."Customer No." := CustomerNumber;
                ShiptoAddress.Code := '';
                ShiptoAddress.Name := SalesH."Ship-to Name";// + ' ' + WooCHeader."Ship To last_name";
                ShiptoAddress.Address := SalesH."Ship-to Address";
                ShiptoAddress."Address 2" := SalesH."Ship-to Address 2";
                ShiptoAddress."Phone No." := SalesH."Sell-to Phone No.";//Check if Ship to Phone No. is required
                ShiptoAddress."E-Mail" := SalesH."Sell-to E-Mail";
                ShiptoAddress.City := SalesH."Ship-to City";
                ShiptoAddress."Post Code" := SalesH."Ship-to Post Code";
                ShiptoAddress.State := SalesH."Ship-to County";
                ShiptoAddress.INSERT();
            END;
            EXIT(Customer."No.");
            /* END; */
        END;
    END;

    local procedure FindShipToAddress(customerno: Code[20]; Address1: Text[100]; Address2: Text[100]; City: Text[100]; State: Text[50]; Pincode: Code[10]; SHeader: Record 36): Code[20]
    var
        ShiptoAdd: Record 222;
        found: Boolean;
        Scode: Code[20];
        ShiptoAddress: Record 222;
    begin
        Scode := '';
        // Address1 := COPYSTR(Address1, 1, 50);
        // Address2 := COPYSTR(Address2, 1, 50);
        ShiptoAdd.RESET();
        ShiptoAdd.SETRANGE("Customer No.", customerno);
        IF ShiptoAdd.FINDSET() THEN
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
                    IF SHeader."Ship-to Name" <> '' THEN BEGIN
                        ShiptoAddress.INIT();
                        ShiptoAddress."Customer No." := customerno;
                        ShiptoAddress.Code := '';
                        ShiptoAddress.Name := SHeader."Ship-to Name";// + ' ' + WooCHeader."Ship To last_name";
                        ShiptoAddress.Address := SHeader."Ship-to Address";
                        ShiptoAddress."Address 2" := SHeader."Ship-to Address 2";
                        ShiptoAddress."Phone No." := SHeader."Sell-to Phone No.";//Check if Ship to Phone No. is required
                        ShiptoAddress."E-Mail" := SHeader."Sell-to E-Mail";
                        ShiptoAddress.City := SHeader."Ship-to City";
                        ShiptoAddress."Post Code" := SHeader."Ship-to Post Code";
                        ShiptoAddress.State := SHeader."Ship-to County";
                        IF ShiptoAddress.INSERT() THEN
                            Scode := ShiptoAddress.Code;
                    END;
                END;
            UNTIL (ShiptoAdd.NEXT() = 0);

        EXIT(Scode);
    end;

    local procedure InsertNarrationPurch(SalesHeader: Record 36; DocumentLineNo: Integer; LineNarration: Text[50])
    var
        PurchCommentLine: Record "Sales Comment Line";
        LineNo: Integer;
        boolDelete: Boolean;

    begin
        IF LineNarration <> '' THEN BEGIN
            deleteCount += 1;
            if deleteCount = 1 then begin
                PurchCommentLine.RESET();
                PurchCommentLine.SETRANGE(PurchCommentLine."Document Type", SalesHeader."Document Type");
                PurchCommentLine.SETRANGE(PurchCommentLine."No.", SalesHeader."No.");
                if PurchCommentLine.FindLast() then
                    PurchCommentLine.DeleteAll();
            end;

            PurchCommentLine.RESET();
            PurchCommentLine.SETRANGE(PurchCommentLine."Document Type", SalesHeader."Document Type");
            PurchCommentLine.SETRANGE(PurchCommentLine."No.", SalesHeader."No.");
            PurchCommentLine.SETRANGE(PurchCommentLine."Document Line No.", DocumentLineNo);
            IF PurchCommentLine.FINDLAST() THEN
                LineNo := PurchCommentLine."Line No." + 10000
            else
                LineNo := 10000;


            PurchCommentLine.INIT();
            PurchCommentLine."Document Type" := SalesHeader."Document Type";
            PurchCommentLine."No." := SalesHeader."No.";
            PurchCommentLine."Line No." := LineNo;
            PurchCommentLine.Date := SalesHeader."Posting Date";
            PurchCommentLine.Comment := LineNarration;
            PurchCommentLine."Document Line No." := DocumentLineNo;
            PurchCommentLine.INSERT(TRUE);
        END;
    end;
    // Mapple NG 1.0 START 30062023 - Customer ERP Mapping After Customer Create

    procedure CustomerERPMapping(CustomerID: Code[20])
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        HttpContent: HttpContent;
        HttpHeaders: HttpHeaders;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        HttpClient: HttpClient;
        JAccessToken: JsonObject;
        ResponseText: Text;
        RequestJson: Text;
    begin
        Clear(RequestJson);
        SalesReceivablesSetup.Get();
        SalesReceivablesSetup.TestField("Cust ERP Url");
        SalesReceivablesSetup.TestField("Cust Parm ID");
        SalesReceivablesSetup.TestField("Auth. User Name");
        SalesReceivablesSetup.TestField("Auth. Password");
        RequestJson := RequestCustERPMapping(CustomerID);
        if SalesReceivablesSetup."Display JSON" then
            Message(RequestJson);
        //HttpContent.WriteFrom('{"meta_data":[{"key":"ErpCustomerNo","value":"34345346"}]}');
        HttpContent.WriteFrom(RequestJson);
        HttpContent.GetHeaders(HttpHeaders);
        //  HttpClient.DefaultRequestHeaders.Add('Authorization', CreteBasicAuthHeader('ck_b2cb9b294acb4d7d55afa8c8ca25c3c3ae2c76b0', 'cs_f65dfa6177b18db0631cb28c28e59aaf77b34882'));
        HttpClient.DefaultRequestHeaders.Add('Authorization', CreteBasicAuthHeader(SalesReceivablesSetup."Auth. User Name", SalesReceivablesSetup."Auth. Password"));
        HttpHeaders.Remove('Content-Type');
        HttpHeaders.Add('Content-Type', 'application/json');
        HttpRequestMessage.Method := 'PUT';
        //HttpRequestMessage.SetRequestUri('https://staging-bd9c-mapledtiecom.wpcomstaging.com/wp-json/wc/v3/customers/23?content=view');
        HttpRequestMessage.SetRequestUri(SalesReceivablesSetup."Cust ERP Url" + '/' + Format(SalesReceivablesSetup."Cust Parm ID") + '?content=view');
        HttpRequestMessage.Content(HttpContent);
        if HttpClient.Send(HttpRequestMessage, HttpResponseMessage) then
            if HttpResponseMessage.IsSuccessStatusCode() then begin
                if HttpResponseMessage.Content.ReadAs(ResponseText) then
                    if SalesReceivablesSetup."Display JSON" then
                        Message(ResponseText);
            end else
                if HttpResponseMessage.Content.ReadAs(ResponseText) then begin
                    JAccessToken.ReadFrom(ResponseText);
                    Message(ResponseText);
                end;
    end;

    procedure RequestCustERPMapping(NewCustId: Code[20]): Text
    var
        meta_dataJsonArray: JsonArray;
        meta_dataJsonObject: JsonObject;
        meta_dataReqJsonObject: JsonObject;
    begin
        //{"meta_data":[{"key":"ErpCustomerNo","value":"34345346"}]}
        Clear(meta_dataJsonArray);
        Clear(meta_dataJsonObject);
        Clear(meta_dataReqJsonObject);
        meta_dataJsonObject.Add('key', 'ErpCustomerNo');
        meta_dataJsonObject.Add('value', NewCustId);
        meta_dataJsonArray.Add(meta_dataJsonObject);
        meta_dataReqJsonObject.Add('meta_data', meta_dataJsonArray);
        exit(Format(meta_dataReqJsonObject));
    end;

    local procedure CreteBasicAuthHeader(UserName: Text; Password: Text): Text
    var
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        BasicAuthInput: Text;
        OutStream: OutStream;
        UserPassLbl: Label '%1:%2', Comment = '%1:%2';
        BasicLbl: Label 'Basic %1', Comment = 'Basic %1';
    begin
        Clear(BasicAuthInput);
        TempBlob.CreateOutStream(OutStream);
        BasicAuthInput := StrSubstNo(UserPassLbl, UserName, Password);
        OutStream.WriteText(BasicAuthInput);
        exit(StrSubstNo(BasicLbl, Base64Convert.ToBase64(BasicAuthInput)));
    end;
    // Mapple NG 1.0 END 30062023 - Customer ERP Mapping After Customer Create
    procedure UpdateDimSetOnSalesHeader(var SalesHeader: Record "Sales Header"; var ToAddDims: Record "Dimension Set Entry" temporary)
    var
        NewDimSet: Record "Dimension Set Entry" temporary;
        DimMgt: Codeunit DimensionManagement;
    begin
        DimMgt.GetDimensionSet(NewDimSet, SalesHeader."Dimension Set ID");
        if ToAddDims.FindSet() then
            repeat
                if NewDimSet.Get(SalesHeader."Dimension Set ID", ToAddDims."Dimension Code") then begin
                    NewDimSet.validate("Dimension Value Code", ToAddDims."Dimension Value Code");
                    NewDimSet.Modify();
                end else begin
                    NewDimSet := ToAddDims;
                    NewDimSet."Dimension Set ID" := SalesHeader."Dimension Set ID";
                    NewDimSet.Insert();
                end;
            until ToAddDims.Next() = 0;
        SalesHeader."Dimension Set ID" := DimMgt.GetDimensionSetID(NewDimSet);
        DimMgt.UpdateGlobalDimFromDimSetID(SalesHeader."Dimension Set ID", SalesHeader."Shortcut Dimension 1 Code", SalesHeader."Shortcut Dimension 2 Code");
    end;

    procedure CreateEntryResSalesLine(ItemNo: Code[20]; VariantCode: Code[10]; LocationCode: Code[10]; Description: Text[100]; ExpectedReceiptDate: Date; ShipmentDate: Date; TransferredFromEntryNo: Integer; Status: Enum "Reservation Status"; var SalesLine: Record "Sales Line"; Doc: Code[20])
    var
        ReservEntry: Record "Reservation Entry";
    begin
        ReservEntry.Init();
        ReservEntry."Entry No." := 0;
        ReservEntry."Item No." := ItemNo;
        ReservEntry."Location Code" := LocationCode;
        ReservEntry."Quantity (Base)" := -1;
        ReservEntry."Reservation Status" := Status;
        ReservEntry."Creation Date" := Today;
        ReservEntry."Source Type" := Database::"Sales Line";
        ReservEntry."Source Subtype" := 1; //SalesLine."Document Type".AsInteger();
        ReservEntry."Source ID" := Doc;
        ReservEntry."Source Ref. No." := SalesLine."Line No.";
        ReservEntry."Shipment Date" := Today;
        ReservEntry."Serial No." := SalesLine."API Serial No.";
        ReservEntry."Created By" := UserId;
        ReservEntry."Qty. per Unit of Measure" := 1;
        ReservEntry.Quantity := -1;
        ReservEntry."Qty. to Handle (Base)" := -1;
        ReservEntry."Qty. to Invoice (Base)" := -1;
        ReservEntry."Item Tracking" := ReservEntry."Item Tracking"::"Serial No.";
        ReservEntry.Insert();
    end;


    var
        SalesHeaderRec: Record "Sales Header";
        SalesLineRec: Record "Sales Line";
        DocNo: Code[20];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SalesNPayable: Record "Sales & Receivables Setup";
        Position: Integer;
        SingleFilePathString: Code[200];

        FileManagement: Codeunit 419;

        ReleaseBoolean: Boolean;
        SendForApprovalBoolean: Boolean;
        NewDimSetID: Integer;
        DimMngt: Codeunit 408;
        TempDimSetEntry: Record 480 temporary;
        ApprovalsMgmt: Codeunit 1535;
        ReleasePurchDoc: Codeunit "Release Sales Document";
        ArchiveManagement: Codeunit 5063;
        LineNo: Integer;
        deleteCount: Integer;
        DocType: Integer;
        ShipToaddresscode: Code[20];
        //NG 2072023 +++
        DimensionSetEntry: Record "Dimension Set Entry" temporary;
    //NG 2072023 ---
    //PAN: Code[20];


}