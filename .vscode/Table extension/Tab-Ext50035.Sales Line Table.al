tableextension 50035 "SalesLine.TableExt" extends "Sales Line"
{
    fields
    {
        field(50000; "Credit Hold"; Boolean)
        {
            Description = 'Win127';
            InitValue = false;
        }
        field(50001; "Overdue Hold"; Boolean)
        {
            Description = 'Win127';
            InitValue = false;
        }
        field(50002; "Price Hold"; Boolean)
        {
            Description = 'Win127';
            InitValue = false;
        }
        field(50003; "Sales Order Type"; Option)
        {
            Description = 'Win127';
            OptionCaption = 'Retail,Rental,B2B,AMC,Service';
            OptionMembers = Retail,Rental,B2B,AMC,Service;
        }
        field(50004; "PDC Hold"; Boolean)
        {
            Description = 'Win127';
            InitValue = false;
        }
        field(50005; "Discount Hold"; Boolean)
        {
            Description = 'Win127';
            InitValue = false;
        }
        field(50006; Shield; Boolean)
        {
            Description = 'win127';

            trigger OnValidate()
            begin
                // IF GUIALLOWED THEN
                //     WBU.RefreshPage;
            end;
        }
        field(50007; "Item Serial No."; Text[30])
        {
            Description = 'win127';


            trigger OnValidate()
            var
                ILE: Record "Item Ledger Entry";
                Header: Record "Sales Header";
                ReservationEntry: Record "Reservation Entry";
                ILE2: Record "Item Ledger Entry";
                FIFOTrackingDetails: Record "FIFO Tracking Details";
                SL: Record "Sales Line";
                SL1: Record "Sales Line";
                BundleItemLine: Record "Bundle Item Line";
                BundleCode: Code[20];
                EntryNo: Integer;
                DiscountType: Code[20];
                LineDiscount: Decimal;
                LineDiscountAmt: Decimal;
            begin
                IF "Item Serial No." <> '' THEN BEGIN
                    SL.Reset();
                    SL.SetFilter("Document No.", "Document No.");
                    SL.SetFilter("Line No.", '<>%1', "Line No.");
                    SL.SetRange("Item Serial No.", "Item Serial No.");
                    IF SL.FindFirst() THEN
                        Error('Serial no. already exist in Order %1', SL."Document No.")
                    ELSE BEGIN
                        SL1.Reset();
                        SL1.SetFilter("Document No.", '<>%1', "Document No.");
                        SL1.SetRange("Item Serial No.", "Item Serial No.");
                        IF SL1.FindFirst() THEN
                            Error('Serial no. already exist in Order %1', SL1."Document No.");
                    END;
                END;
                //Manual ++
                IF (Rec.Type = Rec.Type::Item) AND (Rec."Document Type" = Rec."Document Type"::Order) then BEGIN
                    ILE.Reset();
                    ILE.SetFilter(ILE."Entry Type", '%1|%2|%3', ILE."Entry Type"::Purchase, ILE."Entry Type"::Transfer, ILE."Entry Type"::"Positive Adjmt.");
                    // ILE.SetRange(ILE."Entry Type", ILE."Entry Type"::Purchase); //End, ILE."Entry Type"::"Positive Adjmt.");//ccit-Tk
                    ILE.SetRange(ILE."Item No.", Rec."No.");
                    ILE.SetRange(ILE."Serial No.", Rec."Item Serial No.");
                    ILE.SetRange(ILE."Location Code", Rec."Location Code");
                    ILE.SetRange(ILE."Item Tracking", ILE."Item Tracking"::"Serial No.");
                    IF ILE.FindFirst() THEN BEGIN
                        //Message('%1', ILE."IMEI No.");
                        Rec."IMEI No." := ILE."IMEI No.";
                        Rec."MRP Value" := ILE."MRP Value";
                        REc."Unit Price Incl. of Tax" := ILE."MRP Value";
                        Rec.Validate("Price Inclusive of Tax", true);//tk 180723
                        //Rec."Auto Generated" := ILE."Auto Generated";
                        Rec.Modify(false);
                    end;
                    if Rec."Item Serial No." <> '' then begin
                        ILE2.Reset();
                        ILE2.SetCurrentKey("Entry No.");
                        ILE2.SetRange("Item No.", Rec."No.");
                        ILE2.SetFilter("Remaining Quantity", '<>%1', 0);
                        ILE2.SetRange("Location Code", Rec."Location Code");
                        if ile2.FindFirst() then
                            if ILE2."Serial No." <> Rec."Item Serial No." then
                                Message('Serial No. Not in FIFO');
                    end;

                    // if rec."Auto Generated" = false then
                    //     Message('Serial No not Auto generated');
                END;

                //Manual--




                //RJ
                //>>>>>Code Commented


                IF "Item Serial No." = '' THEN
                    EXIT;



                // IF ChkDuplicateSerialNo("Item Serial No.") THEN BEGIN
                //     MESSAGE('Duplicate Item Serial No.');
                //     "Item Serial No." := '';
                // END;
                SalesHeader.Reset();
                SalesHeader.SetRange(SalesHeader."No.", Rec."Document No.");
                SalesHeader.SetRange(SalesHeader."Document Type", Rec."Document Type");
                IF SalesHeader.FindFirst() THEN;

                //GetSalesHeader;
                //ATUL0901
                Sno := '';
                ILE.RESET;
                ILE.SETFILTER("Item No.", "No.");
                ILE.SETRANGE("Location Code", SalesHeader."Location Code");
                ILE.SETFILTER(Open, '=%1', TRUE);
                IF ILE.FINDSET THEN
                    REPEAT
                        ReservationEntry.RESET;
                        ReservationEntry.SETRANGE("Item No.", "No.");
                        ReservationEntry.SETRANGE("Serial No.", ILE."Serial No.");
                        IF NOT ReservationEntry.FINDFIRST THEN
                            Sno := ILE."Serial No.";
                    UNTIL (ILE.NEXT = 0) OR (Sno <> '');

                // Message('%1', Sno);
                IF "Item Serial No." <> Sno THEN
                    //IF CONFIRM(STRSUBSTNO('Selected Serial %1 is not Matched with FIFO Serial No. %2, Do you want to proceed with  Your Selection', "Item Serial No.", Sno)) THEN 
                    BEGIN
                    /*
                    FIFOTrackingDetails.INIT;
                    FIFOTrackingDetails.Type := FIFOTrackingDetails.Type::Sales;
                    FIFOTrackingDetails."Document No." := SalesHeader."No.";
                    FIFOTrackingDetails."Item No." := "No.";
                    FIFOTrackingDetails."Line No." := "Line No.";
                    FIFOTrackingDetails."FIFO Serial No." := Sno;
                    FIFOTrackingDetails."Serial Date" := ILE."Posting Date";
                    FIFOTrackingDetails.Quantity := 1;
                    FIFOTrackingDetails."Selected Serial" := "Item Serial No.";
                    FIFOTrackingDetails."Selection Date" := TODAY;
                    FIFOTrackingDetails."Selection Time" := TIME;
                    FIFOTrackingDetails."User ID" := USERID;
                    IF NOT FIFOTrackingDetails.INSERT THEN
                        FIFOTrackingDetails.MODIFY;
                    //ATUL0901
*/
                    IF "Item Serial No." <> '' THEN BEGIN
                        Sno := "Item Serial No.";
                        // Message('Find ILE %1', SalesHeader."Location Code");
                        ILE.RESET;
                        ILE.SETCURRENTKEY("Serial No.");
                        ILE.SETFILTER("Serial No.", "Item Serial No.");
                        ILE.SETRANGE("Location Code", SalesHeader."Location Code");//win316
                        ILE.SETFILTER(Open, '=%1', TRUE);
                        IF ILE.FINDFIRST THEN BEGIN
                            IF Header.GET(Rec."Document Type", Rec."Document No.") THEN; //KPPL
                            IF NOT Header."Web Order" THEN BEGIN
                                Type := Type::Item;
                                // MAPPLE 1.0 Bundle Item >>>
                                BundleCode := Rec."Bundle Code";
                                EntryNo := Rec."Entry No";
                                DiscountType := Rec."Discount Type";
                                LineDiscount := Rec."Line Discount %";
                                BundleItemLine.Reset();
                                BundleItemLine.SetRange("Bundle Code", BundleCode);
                                BundleItemLine.SetRange("Item No.", Rec."No.");
                                BundleItemLine.SetRange("Discount Entry No.", EntryNo);
                                BundleItemLine.SetRange("Discount Type", DiscountType);
                                if BundleItemLine.FindFirst() then
                                    LineDiscountAmt := BundleItemLine."Line Discount Amount";
                                // MAPPLE 1.0 Bundle Item <<<
                                "No." := ILE."Item No.";
                                VALIDATE("No.");
                                "IMEI No." := ILE."IMEI No.";
                                "MRP Value" := ILE."MRP Value";
                                "Unit Price Incl. of Tax" := ILE."MRP Value";//tk
                                Rec.Validate("Price Inclusive of Tax", TRUE);
                                "Item Serial No." := Sno;
                                Rec.VALIDATE("Unit Price Incl. of Tax");

                                IF GUIALLOWED THEN
                                    VALIDATE(Quantity, 1);
                                UpdateUnitPrice(FIELDNO("Item Serial No."));


                                UpdateSerialNo;
                                IF "Unit Price Incl. of Tax" <> 0 THEN
                                    Rec.VALIDATE("Unit Price Incl. of Tax");
                                // MAPPLE 1.0 Bundle Item >>>
                                Rec."Bundle Code" := BundleCode;
                                Rec."Entry No" := EntryNo;
                                Rec."Discount Type" := DiscountType;
                                if LineDiscountAmt <> 0 then
                                    Rec."Line Discount %" := (LineDiscountAmt / Rec."MRP Value") * 100;
                                Rec."Line Discount Amount" := LineDiscountAmt;
                                Rec."Net Amount" := Rec."MRP Value" - rec."Line Discount Amount";
                                // MAPPLE 1.0 Bundle Item <<<
                                IF SalesHeader."Sales Order Type" = SalesHeader."Sales Order Type"::Retail THEN BEGIN
                                    IF SalesHeader."Sell-to Customer No." = '' THEN BEGIN
                                        MESSAGE('Select Customer');
                                        "Item Serial No." := '';
                                        EXIT;
                                    END;
                                    //    IF ("PIT Structure" = '') THEN BEGIN
                                    //        SalesSetup.GET;
                                    //        SalesSetup.TESTFIELD("PIT Structure");
                                    //        VALIDATE("PIT Structure", SalesSetup."PIT Structure");
                                    Rec.Validate("Price Inclusive of Tax", TRUE);
                                END;
                                IF "Unit Price Incl. of Tax" <> 0 THEN//tk
                                    Rec.VALIDATE("Unit Price Incl. of Tax");//tk
                                Rec.Validate("Price Inclusive of Tax", TRUE);
                                // MAPPLE 1.0 Bundle Item >>>
                                if LineDiscountAmt <> 0 then
                                    Rec."Line Discount %" := (LineDiscountAmt / Rec."MRP Value") * 100;
                                Rec."Line Discount Amount" := LineDiscountAmt;
                                Rec."Net Amount" := Rec."MRP Value" - rec."Line Discount Amount";
                                // MAPPLE 1.0 Bundle Item <<<
                            END ELSE BEGIN
                                "IMEI No." := ILE."IMEI No.";
                                // UpdateSerialNo;//tk
                                IF SalesHeader."Sales Order Type" = SalesHeader."Sales Order Type"::Retail THEN BEGIN
                                    IF SalesHeader."Sell-to Customer No." = '' THEN BEGIN
                                        MESSAGE('Select Customer');
                                        "Item Serial No." := '';
                                        EXIT;
                                    END;
                                    //  IF ("PIT Structure" = '') THEN BEGIN
                                    //      SalesSetup.GET;
                                    //      SalesSetup.TESTFIELD("PIT Structure");
                                    //      VALIDATE("PIT Structure", SalesSetup."PIT Structure");
                                    Rec.Validate("Price Inclusive of Tax", TRUE);//tk
                                                                                 //  END;
                                END;
                            END;
                        END
                        ELSE BEGIN
                            "Item Serial No." := '';
                            MESSAGE('Invalid Serial Number / Item not in inventory for location code - %1', SalesHeader."Location Code");
                        END
                    END;
                    // ATUL0901
                END ELSE
                    // Message('ELSE');
                    "Item Serial No." := '';
                //RJ

            end;

        }
        field(50008; "Free Item"; Boolean)
        {
            Description = 'win127';
            InitValue = false;

            trigger OnValidate()
            begin
                IF "Free Item" THEN BEGIN
                    //VALIDATE("PIT Structure",'');
                    // VALIDATE("Unit Price",0);
                    // VALIDATE("Unit Price Incl. of Tax",0);
                    Shield := FALSE;
                    VALIDATE("Shield Type", "Shield Type"::" ");
                    "Scheme Code" := '';
                    "Scheme Amount" := 0;
                    "Scheme %" := 0;
                    "Shield Value" := 0;
                    VALIDATE("Line Discount %", 100);
                END
                ELSE
                    VALIDATE("Line Discount %", 0);
            end;
        }
        field(50009; "Free Item Pend_for_ Delivery"; Boolean)
        {
            Description = 'win127';
        }
        field(50010; "Shield Value"; Decimal)
        {
            MinValue = 0;

            trigger OnValidate()
            begin
                TESTFIELD(Shield);
                /*
                IF "Shield Value" <> 0 THEN BEGIN
                GetSalesHeader;
                WITH SalesHeader DO BEGIN
                CALCFIELDS("Maple Buyback Amt");
                  TotalPayByCustomer := PayByCashAmt + PayByCreditAmt1+PayByCreditAmt2+PayByCreditAmt3+PayByCreditAmt4+PayByCreditAmt5+PayByDebitAmt+PayByChqAmt+GiftVoucherAmt+"RTGS Amount"+"Finance Amount"+"Maple Buyback Amt"+"Apple Buyback Amt"+"Apple Refund Amt
                ";
                CALCFIELDS("Total Shield Value");
                TotalPayByCustomer := TotalPayByCustomer + "Total Shield Value" + "Shield Value" - xRec."Shield Value";
                END;
                END;
                */
                // IF GUIALLOWED THEN
                //     WBU.RefreshPage();

            end;
        }
        field(50013; AMC; Boolean)
        {
        }
        field(50014; "AMC Due Date"; Date)
        {

            trigger OnValidate()
            begin
                TESTFIELD(AMC);
            end;
        }
        field(50015; "Warranty Exp. Dt"; Date)
        {
        }
        field(50016; "shield Due Date"; Date)
        {

            trigger OnValidate()
            begin
                //TESTFIELD(Shield);
                IF "shield Due Date" < "Posting Date" THEN
                    ERROR('Shield date should not be less than Posting Date');
            end;
        }
        field(50017; "Cust. Mobile No."; Text[30])
        {
        }
        field(50018; "Cust. email ID"; Text[180])
        {
        }
        field(50019; "Customer Name"; Text[50])
        {
        }
        field(50020; "Shield Cost"; Decimal)
        {
        }
        field(50021; "Shield Type"; Option)
        {
            OptionCaption = ' ,Shield,Shield Plus,Shield+Ex PAD/PHO,Shield Ex,Shield+ExCPU,ExCPU,ExIPH/IPAD,Shield Extended,Shield+Ext Watch,Shield EXT PAD/PHO,Shield EXTENDED CPU,Shield Ex Watch';
            OptionMembers = " ",Shield,"Shield Plus","Shield+Ex PAD/PHO","Shield Ex","Shield+ExCPU",ExCPU,"ExIPH/IPAD","Shield Extended","Shield+Ext Watch","Shield EXT PAD/PHO","Shield EXTENDED CPU","Shield Ex Watch";

            trigger OnValidate()
            var
                SalesLineLocal: Record "Sales Line";
            begin

                IF ("Shield Type" <> "Shield Type"::"Shield Plus") AND ("Shield Type" <> "Shield Type"::"Shield EXT PAD/PHO") AND ("Shield Type" <> "Shield Type"::"Shield+ExCPU")
                AND ("Shield Type" <> "Shield Type"::"Shield Ex Watch") AND ("Shield Type" <> "Shield Type"::"Shield+Ex PAD/PHO") THEN
                    ERROR('Select correct shield type');//WIN-234 04092020


                //WIN270+++
                IF "Shield Type" = "Shield Type"::Shield THEN
                    ERROR('Shield Expired');


                //WIN270---
                IF "Shield Type" = "Shield Type"::" " THEN BEGIN
                    Shield := FALSE;
                    "Shield Cost" := 0;
                    // "shield Due Date" := 0D;
                    "Shield Value" := 0;
                    EXIT;
                END
                ELSE BEGIN
                    Shield := TRUE;//win270
                    SalesLineLocal.RESET;
                    SalesLineLocal.SETRANGE("Document Type", Rec."Document Type");
                    SalesLineLocal.SETFILTER("Document No.", Rec."Document No.");
                    SalesLineLocal.SETFILTER(Shield, '%1', TRUE);
                    IF SalesLineLocal.FINDFIRST THEN
                        IF ("Shield Type" <> "Shield Type"::" ") AND (SalesLineLocal."Shield Type" <> "Shield Type") THEN
                            ERROR('Select same Shield Type for all Lines');
                    StandardText.RESET;
                    StandardText.SETFILTER(Shield, '%1', TRUE);
                    StandardText.SETFILTER("Shield Type", '%1', "Shield Type");
                    IF StandardText.FINDFIRST THEN BEGIN
                        IF StandardText."Shield Cost Perct" = 0 THEN
                            ERROR('Shield Cost Percent is not defined for Shield Type %1', "Shield Type");
                        Shield := TRUE;
                        // "Shield Cost" := ( Quantity * "Unit Price Incl. of Tax" ) * ( StandardText."Shield Cost Perct" / 100);
                        "Shield Cost" := (((Quantity * "Unit Price Incl. of Tax") - "Line Discount Amount" - "Scheme Amount") * (StandardText."Shield Cost Perct" / 100));//win270
                    END;
                END;
                //Win-234 17-05-2019++
                IF RecItem.GET("No.") THEN BEGIN
                    //   IF RecItem."Product Group Code" = 'CPU' THEN
                    IF ("Shield Type" <> "Shield Type"::"Shield+ExCPU") AND ("Shield Type" <> "Shield Type"::ExCPU) THEN
                        ERROR('Shield Type must be Shield+ExCPU or ExCPU');
                    //    IF RecItem."Product Group Code" = 'MINIPAD' THEN
                    IF ("Shield Type" <> "Shield Type"::"Shield+Ex PAD/PHO") AND ("Shield Type" <> "Shield Type"::"Shield Plus") AND ("Shield Type" <> "Shield Type"::"Shield EXT PAD/PHO") THEN
                        ERROR('Shield Type must be Shield+Ex PAD/PHO Or Shield Plus Or Shield EXT PAD/PHO');
                    //   IF RecItem."Product Group Code" = 'PAD' THEN
                    IF ("Shield Type" <> "Shield Type"::"Shield+Ex PAD/PHO") AND ("Shield Type" <> "Shield Type"::"Shield Plus") AND ("Shield Type" <> "Shield Type"::"Shield EXT PAD/PHO") THEN
                        ERROR('Shield Type must be Shield+Ex PAD/PHO  Or Shield Plus Or Shield EXT PAD/PHO');
                    /*
                    IF RecItem."Product Group Code"='PHO' THEN
                    IF ("Shield Type"<> "Shield Type"::"Shield+Ex PAD/PHO") AND ("Shield Type"<> "Shield Type"::"Shield Plus")THEN
                      ERROR('Shield Type must be Shield+Ex PAD/PHO oR Shield Plus');
                      *///win-234 09-10-2019

                    //Win-234 03-10-2019++
                    //  IF RecItem."Product Group Code" = 'PHO' THEN
                    IF RecVendPart.GET(RecItem."Vendor Part Code Long") THEN BEGIN
                        //++++++++++++++++
                        IF (RecVendPart."Shield EXT PAD/PHO" = TRUE) AND (RecVendPart."Shield Plus" = TRUE) AND (RecVendPart."Shield+Ex PAD/PHO" = TRUE) THEN
                            IF ("Shield Type" <> "Shield Type"::"Shield EXT PAD/PHO") AND ("Shield Type" <> "Shield Type"::"Shield Plus") AND ("Shield Type" <> "Shield Type"::"Shield+Ex PAD/PHO") THEN
                                ERROR('Wrong Shield Type Selected');
                        IF (RecVendPart."Shield EXT PAD/PHO" = TRUE) AND (RecVendPart."Shield Plus" = FALSE) AND (RecVendPart."Shield+Ex PAD/PHO" = FALSE) THEN
                            IF ("Shield Type" <> "Shield Type"::"Shield EXT PAD/PHO") THEN
                                ERROR('Wrong Shield Type Selected');
                        IF (RecVendPart."Shield EXT PAD/PHO" = TRUE) AND (RecVendPart."Shield Plus" = TRUE) AND (RecVendPart."Shield+Ex PAD/PHO" = FALSE) THEN
                            IF ("Shield Type" <> "Shield Type"::"Shield EXT PAD/PHO") AND ("Shield Type" <> "Shield Type"::"Shield Plus") THEN
                                ERROR('Wrong Shield Type Selected');
                        IF (RecVendPart."Shield EXT PAD/PHO" = FALSE) AND (RecVendPart."Shield Plus" = TRUE) AND (RecVendPart."Shield+Ex PAD/PHO" = TRUE) THEN
                            IF ("Shield Type" <> "Shield Type"::"Shield Plus") AND ("Shield Type" <> "Shield Type"::"Shield+Ex PAD/PHO") THEN
                                ERROR('Wrong Shield Type Selected');

                        IF (RecVendPart."Shield EXT PAD/PHO" = FALSE) AND (RecVendPart."Shield Plus" = FALSE) AND (RecVendPart."Shield+Ex PAD/PHO" = FALSE) THEN
                            ERROR('Shield Type not defined Vendor Part Master');

                        IF (RecVendPart."Shield EXT PAD/PHO" = FALSE) AND (RecVendPart."Shield Plus" = TRUE) AND (RecVendPart."Shield+Ex PAD/PHO" = FALSE) THEN
                            IF ("Shield Type" <> "Shield Type"::"Shield Plus") THEN
                                ERROR('Wrong Shield Type Selected');
                        IF (RecVendPart."Shield EXT PAD/PHO" = TRUE) AND (RecVendPart."Shield Plus" = FALSE) AND (RecVendPart."Shield+Ex PAD/PHO" = TRUE) THEN
                            IF ("Shield Type" <> "Shield Type"::"Shield EXT PAD/PHO") AND ("Shield Type" <> "Shield Type"::"Shield+Ex PAD/PHO") THEN
                                ERROR('Wrong Shield Type Selected');
                    END;
                    //------------------
                    //Win-234 03-10-2019--
                    //   IF RecItem."Product Group Code" = 'WAT' THEN
                    /*
                    IF "Shield Type"<> "Shield Type"::"Shield+Ext Watch" THEN
                      ERROR('Shield Type must be Shield+Ext Watch');
                      */
                    IF "Shield Type" <> "Shield Type"::"Shield Ex Watch" THEN
                        ERROR('Shield Type must be Shield Ex Watch');
                END;
                IF (Type = Type::"G/L Account") AND ("No." = '310014') THEN
                    IF ("Shield Type" <> "Shield Type"::"ExIPH/IPAD") AND ("Shield Type" <> "Shield Type"::"Shield EXTENDED CPU") AND ("Shield Type" <> "Shield Type"::"Shield EXT PAD/PHO") AND
                    ("Shield Type" <> "Shield Type"::ExCPU) THEN
                        ERROR('Shield Type must be from Shield EXTENDED CPU,Shield EXT PAD/PHO,ExIPH/IPAD,ExCPU');
                //Win-234 17-05-2019--

            end;
        }
        field(50022; "IMEI No."; Code[20])
        {
        }
        field(50023; "Primary category"; Code[20])
        {
            TableRelation = "Standard Text" WHERE("Category Type" = CONST(Primary));
        }
        field(50024; "Secondary category"; Code[20])
        {
            TableRelation = "Standard Text" WHERE("Category Type" = CONST(Secondary));
        }
        field(50025; "Third category"; Code[20])
        {
            TableRelation = "Standard Text" WHERE("Category Type" = CONST(Third));
        }
        field(50026; "UPN Code"; Code[20])
        {

            trigger OnValidate()
            var
                ILE: Record "Item Ledger Entry";
            begin
                IF "UPN Code" = '' THEN
                    EXIT;
                GetSalesHeader;
                IF SalesHeader."Sales Order Type" = SalesHeader."Sales Order Type"::Retail THEN
                    IF SalesHeader."Sell-to Customer No." = '' THEN BEGIN
                        MESSAGE('Select Customer');
                        "Item Serial No." := '';
                        EXIT;
                    END;
                //rahul--
                /*   IF ("PIT Structure" = '') THEN BEGIN
                      SalesSetup.GET;
                      SalesSetup.TESTFIELD("PIT Structure");
                      VALIDATE("PIT Structure", SalesSetup."PIT Structure");
                      VALIDATE("Price Inclusive of Tax", TRUE);
                  END;*/
                //--rahul
                /*
                IF SalesHeader.Structure = '' THEN
                BEGIN
                  MESSAGE('Select Structure');
                  "Item Serial No." := '';
                  EXIT;
                END
                ELSE BEGIN
                  "PIT Structure" := SalesHeader.Structure;
                  "Price Inclusive of Tax" := TRUE;
                END;
               */
                IF "UPN Code" <> '' THEN BEGIN
                    ILE.RESET;
                    ILE.SETFILTER("UPN Code", "UPN Code");
                    ILE.SETFILTER(Open, '=%1', TRUE);
                    IF ILE.FINDFIRST THEN BEGIN
                        VALIDATE("No.", ILE."Item No.");
                        IF GUIALLOWED THEN
                            VALIDATE(Quantity, 1);
                        VALIDATE("Item Serial No.", ILE."Serial No.");
                        UpdateUnitPrice(FIELDNO("UPN Code"));
                        "IMEI No." := ILE."IMEI No.";
                        "UPN Code" := ILE."UPN Code";
                        //02.11.14
                        //rahul--
                        // IF ("PIT Structure" = '') THEN BEGIN
                        //     SalesSetup.GET;
                        //     SalesSetup.TESTFIELD("PIT Structure");
                        //     VALIDATE("PIT Structure", SalesSetup."PIT Structure");
                        //     VALIDATE("Price Inclusive of Tax", TRUE);
                        // END;
                        //--rahul
                        IF "Unit Price Incl. of Tax" <> 0 THEN
                            VALIDATE("Unit Price Incl. of Tax");

                    END
                    ELSE
                        MESSAGE('Product is not Available in Inventory');
                END;

            end;
        }
        field(50027; "Scheme Code"; Code[10])
        {

            trigger OnLookup()
            var
                SchemeDetails: Record "Scheme Details";
            begin
                GetSalesHeader;
                SchemeDetails.RESET;
                SchemeDetails.SETFILTER(Open, '%1', TRUE);
                SchemeDetails.SETFILTER(ItemNo, '%1', "No.");
                SchemeDetails.SETFILTER("Starting Date", '<=%1', SalesHeader."Posting Date");
                SchemeDetails.SETFILTER("Ending Date", '>=%1', SalesHeader."Posting Date");
                SchemeDetails.SETFILTER("Enable Scheme", '%1', TRUE);
                IF PAGE.RUNMODAL(50047, SchemeDetails) = ACTION::LookupOK THEN BEGIN
                    "Scheme Code" := SchemeDetails."Scheme Code";
                    "Scheme Amount" := SchemeDetails."Sch Disc Amt";
                    "Scheme %" := SchemeDetails."Sch Disc %";
                    "Scheme Vendor" := SchemeDetails.Vendor;
                    "Claim Amount" := SchemeDetails."Claim Amt";
                    "Claim %" := SchemeDetails."Claim Disc %";
                    // VALIDATE(Quantity,0);
                END;
                UpdateUnitPrice(FIELDNO("Scheme Code"));
            end;

            trigger OnValidate()
            var
                SchemeDetails: Record "Scheme Details";
            begin
                IF ("Scheme Code" = '') AND (xRec."Scheme Code" <> '') THEN BEGIN
                    "Scheme Amount" := 0;
                    "Scheme %" := 0;
                    "Scheme Vendor" := '';
                    "Claim %" := 0;
                    "Claim Amount" := 0;
                END;
                IF ("Scheme Code" <> '') THEN BEGIN
                    SchemeDetails.GET("Scheme Code", "No.");
                    IF SchemeDetails."Sch Disc Amt" <> 0 THEN BEGIN
                        "Scheme Amount" := SchemeDetails."Sch Disc Amt";
                        "Claim Amount" := SchemeDetails."Claim Amt";
                        "Claim %" := SchemeDetails."Claim Disc %";
                        "Scheme Vendor" := SchemeDetails.Vendor;
                    END;
                    IF SchemeDetails."Sch Disc %" <> 0 THEN BEGIN
                        "Scheme %" := SchemeDetails."Sch Disc %";
                        "Scheme Vendor" := SchemeDetails.Vendor;
                        "Claim Amount" := SchemeDetails."Claim Amt";
                        "Claim %" := SchemeDetails."Claim Disc %";
                        //"Scheme Amount" := (TempSalesPrice."Unit Price" * SchemeDetails."Sch Disc %")/100 ;
                    END;

                END;
                UpdateUnitPrice(FIELDNO("Scheme Code"));
            end;
        }
        field(50028; "Scheme Amount"; Decimal)
        {
            MinValue = 0;
        }
        field(50029; "Claim Amount"; Decimal)
        {
            MinValue = 0;
        }
        field(50030; "Claim received"; Boolean)
        {
        }
        field(50031; "Claim Received Date"; Date)
        {
        }
        field(50032; "Scheme %"; Decimal)
        {
            DecimalPlaces = 2 : 2;
            MinValue = 0;
        }
        field(50033; "Claim %"; Decimal)
        {
            DecimalPlaces = 2 : 2;
            MinValue = 0;
        }
        field(50034; "Scheme Vendor"; Code[20])
        {
        }
        field(50035; "Vendor Part Code"; Code[50])
        {
        }
        field(50036; PITBaseAmount; Decimal)
        {
        }
        field(50037; "Amt to Customer UPIT"; Decimal)
        {
            Description = '//Win120';
        }
        field(50039; "MRP Discount %"; Decimal)
        {
            DecimalPlaces = 0 : 2;
            Description = '//Win120 WS t0 calculate MRP Discount';
            MaxValue = 100;
            MinValue = 0;


            trigger OnValidate()
            begin
                /*"MRP Discount Amount" :=
                  ROUND(ROUND(Quantity * "Unit Price",Currency."Amount Rounding Precision") * "MRP Discount %" / 100,
                   Currency."Amount Rounding Precision");*/


                "MRP Discount Amount" := ROUND(ROUND(Quantity * "Unit Price Incl. of Tax", 0.001) * "MRP Discount %" / 100,
                   0.001);
                "MRP Line Discount Amount" :=
               ROUND(ROUND(Quantity * "Unit Price", 0.001) * "MRP Discount %" / 100,
                0.001);


                VALIDATE("Line Discount Amount", "MRP Line Discount Amount");

            end;
        }
        field(50040; "MRP Discount Amount"; Decimal)
        {
            DecimalPlaces = 0 : 2;
            Description = '//Win120 WS t0 calculate MRP Discount';

            trigger OnValidate()
            begin
                //rahul--
                /*   IF NOT "Price Inclusive of Tax" THEN
                       IF ROUND(Quantity * "Unit Price", Currency."Amount Rounding Precision") <> 0 THEN
                           "MRP Discount %" :=
                             ROUND(
                             "MRP Discount Amount" / ROUND(Quantity * "Unit Price", Currency."Amount Rounding Precision") * 100,
                            0.00001)
                       ELSE
                           "MRP Discount %" := 0
                   ELSE
                       IF ROUND(Quantity * "Unit Price Incl. of Tax", Currency."Amount Rounding Precision") <> 0 THEN
                           "MRP Discount %" :=
                              ROUND(
                               "MRP Discount Amount" / ROUND(Quantity * "Unit Price Incl. of Tax", Currency."Amount Rounding Precision") * 100,
                                0.00001)
                       ELSE
                           "MRP Discount %" := 0;

                   VALIDATE("MRP Discount %");
                   */
                //-- rahul
            end;
        }
        field(50041; "MRP Line Discount Amount"; Decimal)
        {
            Description = '//Win120 WS t0 calculate MRP Discount';
        }
        field(50042; "Capillary Line Discount Amount"; Decimal)
        {
            Description = 'CAPILARY';

            trigger OnValidate()
            begin
                //rahul ---
                /*     IF "Capillary Line Discount Amount" > (Quantity * "Unit Price Incl. of Tax") THEN
                         ERROR('Discount amount is greater that Unit Price');
                     IF NOT "Price Inclusive of Tax" THEN
                         IF ROUND(Quantity * "Unit Price", Currency."Amount Rounding Precision") <> 0 THEN
                             "MRP Discount %" +=
                               ROUND(
                               "Capillary Line Discount Amount" / ROUND(Quantity * "Unit Price", Currency."Amount Rounding Precision") * 100,
                              0.00001)
                         ELSE
                             "MRP Discount %" := 0
                     ELSE
                         IF ROUND(Quantity * "Unit Price Incl. of Tax", Currency."Amount Rounding Precision") <> 0 THEN
                             "MRP Discount %" +=
                                ROUND(
                                 "Capillary Line Discount Amount" / ROUND(Quantity * "Unit Price Incl. of Tax", Currency."Amount Rounding Precision") * 100,
                                  0.00001)
                         ELSE
                             "MRP Discount %" := 0;

                     VALIDATE("MRP Discount %");*/
                // --- rahul
            end;
        }
        field(50043; "Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';
            Description = 'WIN234';
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate()
            begin
            end;
        }
        field(50044; "CRT Coupon Code"; Code[20])
        {
            Description = 'KPPLDG00016';
        }
        field(50045; "FIFO Serial Assigned"; Boolean)
        {
            Description = 'KPPL LM';
        }
        field(50046; "IS LOB Order"; Boolean)
        {
            Description = 'LOB';
        }
        field(50047; "Delivery Time"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(50048; "Expected Delivery Date Time"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(50049; "Discount Type"; Code[20])
        {
            Caption = 'Discount Type';
            Description = '//CCIT-TK';
            TableRelation = Discounting."Discount Type" WHERE("Discount Type" = FIELD("Discount Type"));
            Editable = False;
            //Editable = True;
            trigger OnValidate()
            begin

                // //Nitesh ++
                // IF Rec."Discount Type" <> 'NO DISCOUNT' THEN
                //     IF Item.Get(Rec."No.") THEN BEGIN
                //         DtCat := false;
                //         DiscountingRec.Reset();
                //         DiscountingRec.SetRange(DiscountingRec."Discount Type", Rec."Discount Type");
                //         DiscountingRec.SetRange(DiscountingRec."Primary category", Rec."Primary category");
                //         DiscountingRec.SetRange(DiscountingRec."Secondary category", Rec."Secondary category");
                //         // DiscountingRec.SetFilter(DiscountingRec."Entry No", '=%1', Rec."Entry No");//tk

                //         IF DiscountingRec.FindFirst() THEN BEGIN
                //             repeat


                //                 DiscountingRec.TestField("Primary category");
                //                 DiscountingRec.TestField("Secondary category");

                //                 // IF DiscountingRec."Primary category" <> Item."Primary category" THEN
                //                 //     Error('Item Primary category did not matched');
                //                 // IF DiscountingRec."Secondary category" <> Item."Secondary category" THEN
                //                 //     Error('Item Secondary category did not matched');
                //                 // IF DiscountingRec."Third category" <> '' THEN
                //                 IF DiscountingRec."Third category" = Item."Third category" THEN
                //                     dtcat := true;
                //                 Rec."Entry No" := DiscountingRec."Entry No";
                //             until (DiscountingRec.next = 0) or (dtcat);
                //         END;
                //         if dtcat = false then
                //             error('Item category did not matched with discount');

                //     END;
                // // Discounting.Reset();
                // // Discounting.SetCurrentKey(Discounting."Entry No", Discounting."Discount Type");
                // // Discounting.SetRange(Discounting."Discount Type", DiscountingRec."Discount Type");

                // // if Discounting.FindFirst() then begin
                // Validate("Line Discount %", DiscountingRec."Discount %");//tk


                // //rec."Line Discount Amount" := (rec."MRP Value" * Rec."Line Discount %") / 100;//tk
                // // rec."Discount %" := Discounting."Discount %";
                // // rec."Discount Amount" := (rec."MRP Value" * Rec."Discount %") / 100;
                // // rec."Discount Amount" := (rec."Unit Price Incl. of Tax" * Rec."Discount %") / 100;
                // // Rec."Net Amount" := Rec."Unit Price Incl. of Tax" - rec."Discount Amount";
                // // Rec."Net Amount" := Round(Rec."MRP Value" - rec."Discount Amount");
                // Rec."Net Amount" := Round(Rec."MRP Value" - rec."Line Discount Amount");//tk

                // //// Rec."Entry No" := Discounting."Entry No";
                // // Rec."Unit Price Incl. of Tax" := rec."Net Amount";
                // // Rec."Unit Price" := Rec."Net Amount";
                // // If "Unit Price Incl. of Tax" <> 0 then begin
                // //     Rec.Validate("Price Inclusive of Tax", true);
                // // end;//tk
                // // Rec."Unit Price" := Rec."Net Amount";
                // // If Rec."Discount Type" <> 'NO DISCOUNT' then begin
                // //     Rec."Net Amount" := Round(Rec."MRP Value");
                // //     Rec."Unit Price Incl. of Tax" := rec."Net Amount";
                // //     Rec."Unit Price" := Rec."Net Amount";
                // // end;//tk
                // // end;
                // //GetSalesHeader;//tk
                // ReCSH.Reset();
                // ReCSH.SetRange(ReCSH."Document Type", ReCSH."Document Type"::Order);
                // ReCSH.SetRange(ReCSH."No.", Rec."Document No.");
                // if ReCSH.FindFirst() then begin
                //     Discounting.Reset();
                //     Discounting.SetRange(Discounting."Entry No", DiscountingRec."Entry No");
                //     Discounting.SetRange("Discount Type", Discounting."Discount Type");
                //     Discounting.SetFilter(Discounting."From Date", '<=%1', ReCSH."Posting Date");
                //     Discounting.SetFilter(Discounting."To Date", '>=%1', ReCSH."Posting Date");
                //     if not Discounting.find('-') then begin
                //         Error('Discount type expired not in Date range');
                //     end;
                // End;
                // // //Nitesh --
                // //OLd Code
                // IF Rec."Discount Type" <> 'NO DISCOUNT' THEN
                //     IF Item.Get(Rec."No.") THEN BEGIN
                //         DiscountingRec.Reset();
                //         DiscountingRec.SetRange(DiscountingRec."Discount Type", Rec."Discount Type");
                //         IF DiscountingRec.FindFirst() THEN BEGIN
                //             DiscountingRec.TestField("Primary category");
                //             DiscountingRec.TestField("Secondary category");

                //             IF DiscountingRec."Primary category" <> Item."Primary category" THEN
                //                 Error('Item Primary category did not matched');
                //             IF DiscountingRec."Secondary category" <> Item."Secondary category" THEN
                //                 Error('Item Secondary category did not matched');
                //             IF DiscountingRec."Third category" <> '' THEN
                //                 IF DiscountingRec."Third category" <> Item."Third category" THEN
                //                     Error('Item Third category did not matched');
                //         END;
                //     END;
                // Discounting.Reset();
                // Discounting.SetRange(Discounting."Discount Type", rec."Discount Type");
                // if Discounting.find('-') then begin
                //     Validate("Line Discount %", Discounting."Discount %");//tk
                //                                                           //rec."Line Discount Amount" := (rec."MRP Value" * Rec."Line Discount %") / 100;//tk
                //                                                           // rec."Discount %" := Discounting."Discount %";
                //                                                           // rec."Discount Amount" := (rec."MRP Value" * Rec."Discount %") / 100;
                //                                                           // rec."Discount Amount" := (rec."Unit Price Incl. of Tax" * Rec."Discount %") / 100;
                //                                                           // Rec."Net Amount" := Rec."Unit Price Incl. of Tax" - rec."Discount Amount";
                //                                                           // Rec."Net Amount" := Round(Rec."MRP Value" - rec."Discount Amount");
                //     Rec."Net Amount" := Round(Rec."MRP Value" - rec."Line Discount Amount");//tk
                //                                                                             // Rec."Unit Price Incl. of Tax" := rec."Net Amount";
                //                                                                             // Rec."Unit Price" := Rec."Net Amount";
                //                                                                             // If "Unit Price Incl. of Tax" <> 0 then begin
                //                                                                             //     Rec.Validate("Price Inclusive of Tax", true);
                //                                                                             // end;//tk
                //                                                                             // Rec."Unit Price" := Rec."Net Amount";
                //                                                                             // If Rec."Discount Type" <> 'NO DISCOUNT' then begin
                //                                                                             //     Rec."Net Amount" := Round(Rec."MRP Value");
                //                                                                             //     Rec."Unit Price Incl. of Tax" := rec."Net Amount";
                //                                                                             //     Rec."Unit Price" := Rec."Net Amount";
                //                                                                             // end;//tk
                // end;
                // //GetSalesHeader;//tk
                // ReCSH.Reset();
                // ReCSH.SetRange(ReCSH."Document Type", ReCSH."Document Type"::Order);
                // ReCSH.SetRange(ReCSH."No.", Rec."Document No.");
                // if ReCSH.FindFirst() then begin
                //     Discounting.Reset();
                //     Discounting.SetRange(Discounting."Discount Type", Rec."Discount Type");
                //     Discounting.SetFilter(Discounting."From Date", '<=%1', ReCSH."Posting Date");
                //     Discounting.SetFilter(Discounting."To Date", '>=%1', ReCSH."Posting Date");
                //     if not Discounting.find('-') then begin
                //         Error('Discount type expired not in Date range');
                //     end;
                // End;

                // //OLD Code

            end;


            //
        }
        field(50050; "Discount %"; decimal)
        {
            Description = '//CCIT-TK';
            // trigger OnValidate()
            // var
            //     myInt: Integer;
            //     Discounting: Record Discounting;
            // begin
            //     // Discounting.Reset();
            //     // Discounting.SetRange(Discounting."Discount Type", rec."Discount Type");
            //     // Discounting.SetFilter(Discounting."Maximum % Limit", '<>%1', 0);
            //     // Discounting.SetFilter(Discounting."Maximum % Limit", '<%1', Rec."Discount %");

            //     // if Discounting.find('-') then begin
            //     //     Error('can not greater maximum limit');
            //     // end;
            //     // rec."Discount Amount" := (rec."MRP Value" * "Discount %") / 100;
            //     // Rec."Net Amount" := Round(Rec."MRP Value" - rec."Discount Amount");
            //     // rec."Unit Price Incl. of Tax" := Rec."Net Amount";
            //     // If "Unit Price Incl. of Tax" <> 0 then begin
            //     //     Rec.Validate("Price Inclusive of Tax", true);
            //     // end;
            //     // rec."Unit Price" := Rec."Net Amount";
            //     // // rec."Discount Amount" := (rec."Unit Price Incl. of Tax" * "Discount %") / 100;
            //     // // Rec."Net Amount" := Rec."Unit Price Incl. of Tax" - rec."Discount Amount";
            // end;


        }
        field(50051; "Discount Amount"; Decimal)
        {
            Description = '//CCIT-TK';//ccit-tk
            Editable = false;
        }
        field(50052; SKU1; Code[50])
        {
            Caption = 'SKU';
            Description = 'Ecom';
        }
        field(50053; "Net Amount"; Decimal)
        {
            Description = '//CCIT-TK';//ccit-tk
            Caption = 'Invoice Amount';
            Editable = false;

        }
        field(50054; "Product Category"; Code[20])
        {
            Editable = true;
            TableRelation = "Product Category";


        }
        field(50055; "MRP Value"; Decimal)
        {

        }
        field(50056; "Entry No"; Integer)
        {
            Caption = 'Discount Type Entry No';
            Description = '//CCIT-TK';

            TableRelation = Discounting."Entry No" WHERE("Entry No" = FIELD("Entry No"), "Primary category" = field("Primary category"), "Secondary category" = field("Secondary category"), "Item Category Code" = field("Item Category Code"), "Active/Inactive" = CONST(false));
            Editable = true;
            trigger OnValidate()
            var
                Discounting: Record Discounting;
                DiscountingB: Record Discounting;
                DiscountingRec: Record Discounting;
                Item: Record Item;
                ReCSH: Record "Sales Header";

            begin
                //CCIT_TK
                DiscountingB.Reset();
                DiscountingB.SetRange(DiscountingB."Entry No", Rec."Entry No");//tk
                IF DiscountingB.FindFirst() THEN
                    If DiscountingB."Active/Inactive" = true then
                        Error('Blocked Discount Not Allow');

                //CCIT_TK

                IF (Rec."Entry No" <> '8') Or (Rec."Discount Type" <> 'NO DISCOUNT') THEN
                    IF Item.Get(Rec."No.") THEN BEGIN
                        DiscountingRec.Reset();
                        DiscountingRec.SetRange(DiscountingRec."Entry No", Rec."Entry No");//tk
                        DiscountingRec.SetFilter(DiscountingRec."Discount Type", '<>%1', 'NO DISCOUNT');//tk
                                                                                                        // DiscountingRec.SetRange(DiscountingRec."Discount Type", Rec."Discount Type",);//tk
                        IF DiscountingRec.FindFirst() THEN BEGIN

                            DiscountingRec.TestField("Primary category");
                            DiscountingRec.TestField("Secondary category");
                            DiscountingRec.TestField("Item Category Code");
                            IF DiscountingRec."Item Category Code" <> Item."Item Category Code" THEN
                                Error('Item category did not matched');
                            IF DiscountingRec."Primary category" <> Item."Primary category" THEN
                                Error('Item Primary category did not matched');
                            IF DiscountingRec."Secondary category" <> Item."Secondary category" THEN
                                Error('Item Secondary category did not matched');
                            IF DiscountingRec."Third category" <> '' THEN
                                IF DiscountingRec."Third category" <> Item."Third category" THEN
                                    Error('Item Third category did not matched');
                        END;
                    END;
                Discounting.Reset();
                Discounting.SetRange(Discounting."Entry No", Rec."Entry No");//tk

                if Discounting.find('-') then begin
                    Validate("Line Discount %", Discounting."Discount %");//tk
                    Rec."Discount Type" := Discounting."Discount Type";
                    //rec."Line Discount Amount" := (rec."MRP Value" * Rec."Line Discount %") / 100;//tk
                    // rec."Discount %" := Discounting."Discount %";
                    // rec."Discount Amount" := (rec."MRP Value" * Rec."Discount %") / 100;
                    // rec."Discount Amount" := (rec."Unit Price Incl. of Tax" * Rec."Discount %") / 100;
                    // Rec."Net Amount" := Rec."Unit Price Incl. of Tax" - rec."Discount Amount";
                    // Rec."Net Amount" := Round(Rec."MRP Value" - rec."Discount Amount");
                    Rec."Net Amount" := Rec."MRP Value" - rec."Line Discount Amount";//tk
                    Rec."Discount Type" := Discounting."Discount Type";
                    // Rec."Unit Price Incl. of Tax" := rec."Net Amount";
                    // Rec."Unit Price" := Rec."Net Amount";
                    // If "Unit Price Incl. of Tax" <> 0 then begin
                    //     Rec.Validate("Price Inclusive of Tax", true);
                    // end;//tk
                    // Rec."Unit Price" := Rec."Net Amount";
                    // If Rec."Discount Type" <> 'NO DISCOUNT' then begin
                    //     Rec."Net Amount" := Round(Rec."MRP Value");
                    //     Rec."Unit Price Incl. of Tax" := rec."Net Amount";
                    //     Rec."Unit Price" := Rec."Net Amount";
                    // end;//tk
                end;

                //GetSalesHeader;//tk
                ReCSH.Reset();
                ReCSH.SetRange(ReCSH."Document Type", ReCSH."Document Type"::Order);
                ReCSH.SetRange(ReCSH."No.", Rec."Document No.");
                if ReCSH.FindFirst() then begin
                    Discounting.Reset();
                    Discounting.SetRange(Discounting."Entry No", Rec."Entry No");
                    Discounting.SetRange(Discounting."Discount Type", Rec."Discount Type");
                    Discounting.SetFilter(Discounting."From Date", '<=%1', ReCSH."Posting Date");
                    Discounting.SetFilter(Discounting."To Date", '>=%1', ReCSH."Posting Date");
                    if not Discounting.find('-') then
                        Error('Discount type expired not in Date range');
                End;
            end;
        }


        field(50057; "API Serial No."; Text[30])
        {
            DataClassification = CustomerContent; //DO NOT USE
        }
        field(50058; "API GST Reg No"; Code[20])
        {
            DataClassification = CustomerContent; //DO NOT USE
        }
        field(50059; "Eleva Product Serial No."; Code[20])
        {
        }
        field(50110; "Auto Generated"; Boolean)
        {

        }
        modify(Type)
        {
            trigger OnAfterValidate()
            begin
                //Updated WIN347++
                GetSalesHeader;
                IF (Rec.Type <> Rec.Type::"Fixed Asset") AND (SalesHeader."FA Disposal") THEN
                    ERROR(Text16509);

                // IF (Rec."Document Type" = Rec."Document Type"::Order) AND ((SalesHeader."Sales Order Type" = SalesHeader."Sales Order Type"::Rental) OR (SalesHeader."Sales Order Type" = SalesHeader."Sales Order Type"::Service)) AND (Type <> Type::"G/L Account") THEN BEGIN
                //     Type := xRec.Type;
                //     MESSAGE('Select type G/L Account');
                EXIT;
                // END;//tk
                //Updated WIN347--
            end;
        }
        field(50111; Apple; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        // MAPPLE 1.0 Bundle Item >>>
        field(50112; "Bundle Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        // MAPPLE 1.0 Bundle Item <<<
        // Mapple Voucher 1.0 >>>
        field(50113; "Voucher Code"; code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50114; "Voucher Name"; code[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50115; "Mapple Voucher Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(50116; "Mapple Voucher Apply"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50810; "Bundle Discount Amount"; Decimal)
        {

        }
        // Mapple Voucher 1.0 <<<
        modify("No.")
        {
            trigger OnAfterValidate()

            begin

                //Updated WIN347++
                TESTFIELD(Type);

                GetSalesHeader;
                SalesHeader.Reset();
                SalesHeader.SetRange(SalesHeader."No.", Rec."Document No.");
                SalesHeader.SetRange(SalesHeader."Document Type", Rec."Document Type");
                IF SalesHeader.FindFirst() THEN;
                IF SalesHeader."Sales Order Type" = SalesHeader."Sales Order Type"::Retail THEN BEGIN
                    IF SalesHeader."Location Code" = '' THEN BEGIN
                        MESSAGE('Select Location');
                        "No." := '';
                        EXIT;
                    END;
                    IF SalesHeader."Salesperson Code" = '' THEN BEGIN
                        MESSAGE('Select Sales Person');
                        "No." := '';
                        EXIT;
                    END;
                    IF SalesHeader."Sell-to Customer No." = '' THEN BEGIN
                        MESSAGE('Select Customer');
                        "No." := '';
                        EXIT;
                    END;
                    //IF SalesHeader.Structure = '' THEN
                    //BEGIN
                    //  MESSAGE('Select Structure');
                    ///  "No." := '';
                    //  EXIT;
                    //END
                    //ELSE BEGIN
                    // IF (Type = Type::Item) AND ("PIT Structure" = '') THEN BEGIN
                    //     SalesSetup.GET;
                    //     SalesSetup.TESTFIELD("PIT Structure");
                    //    // VALIDATE("PIT Structure", SalesSetup."PIT Structure");
                    //     //MESSAGE('PIT2');
                    //     //MESSAGE("PIT Structure");
                    //     VALIDATE("Price Inclusive of Tax", TRUE);
                    // END;//tk
                END;
                //Updated WIn347--
                //Updated WIN347++
                IF (Type = Type::Item) then begin
                    Rec.Validate("Item Serial No.", TempSalesLine."Item Serial No.");
                    "IMEI No." := TempSalesLine."IMEI No.";
                    //"PIT Structure" := TempSalesLine."PIT Structure";
                    //MESSAGE('PIT3');
                    //MESSAGE("PIT Structure");
                    "Price Inclusive of Tax" := TempSalesLine."Price Inclusive of Tax";//tk
                    SKU1 := TempSalesLine.SKU1;//tk
                    "UPN Code" := TempSalesLine."UPN Code";
                end;//tk

                //Updated WIN347--
                //Updated WIN347++
                //tk

                If Item.get(Rec."No.") then begin
                    if Rec."Bundle Code" = '' then // // MAPPLE 1.0 Bundle Item >>>
                        Rec."Discount Type" := 'NO DISCOUNT';
                    // If Rec."Discount Type" = 'NO DISCOUNT' then
                    //     Rec."Entry No" := '8';//Dev
                    // Message('EnTry%1', Rec."Entry No");

                    If Rec.Type = Rec.Type::Item then begin
                        rec.SKU1 := Item.SKU1;//CCIT-TK

                        // Rec."Entry No" := '8';//Dev





                        rec."Product Category" := item."Product Category";
                        IF "Item Serial No." <> '' THEN
                            Item.TESTFIELD("Item Tracking Code");
                        //Updated WIN347--
                        //Win127
                        "Primary category" := Item."Primary category";
                        "Secondary category" := Item."Secondary category";
                        "Third category" := Item."Third category";
                        rec.SKU1 := Item.SKU1;//CCIT-TK
                        IF Item.SKU1 = '' THEN
                            rec.SKU1 := Item."Vendor Part Code Long";
                        rec."Product Category" := item."Product Category";
                        "Vendor Part Code" := Item."Vendor Part Code Long"; //19.11.14
                    end;
                    //
                    //Updated WIN347--

                    //Updated WIN347++
                    //win127
                    VALIDATE("Free Item");
                    IF SalesHeader."Posting Date" <> 0D THEN BEGIN
                        VALIDATE("Warranty Exp. Dt", CALCDATE('+1Y-1D', SalesHeader."Posting Date"));//Win127
                        VALIDATE("shield Due Date", CALCDATE('+1Y-1D', SalesHeader."Posting Date"));//Win127
                    END;
                    //Win127 14.11.14 Validating line structure with header
                    IF ((SalesHeader."Sales Order Type" = SalesHeader."Sales Order Type"::Retail) OR (SalesHeader."Sales Order Type" = SalesHeader."Sales Order Type"::B2B)) AND (Type = Type::Item) THEN //AND (SalesHeader.Structure <> '')
                        // VALIDATE("PIT Structure", SalesHeader.Structure);
                        // MESSAGE('PIT4');
                        //MESSAGE("PIT Structure");
                        VALIDATE("Price Inclusive of Tax", TRUE);
                    //
                    //Tk++
                    IF ((SalesHeader."Sales Order Type" = SalesHeader."Sales Order Type"::Retail) OR (SalesHeader."Sales Order Type" = SalesHeader."Sales Order Type"::B2B)) AND (Type = Type::Item) THEN BEGIN//AND ("PIT Structure" = '')
                        SalesSetup.GET;
                        SalesSetup.TESTFIELD("PIT Structure");
                        //VALIDATE("PIT Structure", SalesSetup."PIT Structure");
                        //MESSAGE('PIT5');
                        //MESSAGE("PIT Structure");
                        VALIDATE("Price Inclusive of Tax", TRUE);
                    END;
                    //Tk--//tk
                    IF GUIALLOWED THEN
                        IF "Unit Price Incl. of Tax" <> 0 THEN
                            WBU.RefreshStatistics();
                    //Updated WIn347--

                end;//tk
                    //Updated WIN347++


            end;
        }
        field(50710; "Corporate Salesperson Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser".Code;

            trigger OnValidate()
            var
                SP: Record "Salesperson/Purchaser";
            BEGIN
                IF SP.Get(Rec."Corporate Salesperson Code") THEN
                    Rec."Corporate Salesperson Name" := SP.Name;
            END;
        }

        field(50711; "Corporate Salesperson Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                //Updated WIN347++
                VALIDATE("Shield Cost");

                IF ((SalesHeader."Sales Order Type" = SalesHeader."Sales Order Type"::Retail) OR (SalesHeader."Sales Order Type" = SalesHeader."Sales Order Type"::B2B)) AND (Type = Type::Item) THEN BEGIN//AND ("PIT Structure" = '')
                    SalesSetup.GET;
                    SalesSetup.TESTFIELD("PIT Structure");
                    // VALIDATE("PIT Structure", SalesSetup."PIT Structure");
                    //MESSAGE('PIT6');
                    //MESSAGE("PIT Structure");
                    // VALIDATE("Price Inclusive of Tax", TRUE);//np 03-823
                    // VALIDATE("Unit Price Incl. of Tax");//np 030823
                END;
                IF GUIALLOWED THEN
                    IF "UPN Code" <> '' THEN
                        WBU.RefreshStatistics();
                //Updated WIN347--

            end;
        }
        modify("Unit Price")
        {
            trigger OnAfterValidate()
            begin
                //Updated WIN347++
                // //Win127 Hold.0
                // GetSalesHeader;
                // IF ("Document Type" = "Document Type"::Order) AND (SalesHeader."Sales Order Type" <> SalesHeader."Sales Order Type"::Retail) AND (WBU.CheckPriceHold(Rec)) THEN BEGIN
                //     "Price Hold" := TRUE;
                //     IF GUIALLOWED THEN
                //         WBU.RefreshPage;
                // END
                // ELSE
                //     "Price Hold" := FALSE;

                // SalesSetup.GET;
                // IF ("Document Type" = "Document Type"::Order) AND (SalesHeader."Sales Order Type" <> SalesHeader."Sales Order Type"::Retail) THEN
                //     SalesHeader."Group Credit Limit Hold" := WBU.CheckGroupCreditLimitHold(SalesHeader);

                // IF ("Document Type" = "Document Type"::Order) AND (SalesHeader."Sales Order Type" <> SalesHeader."Sales Order Type"::Retail) AND ((SalesSetup."Overdue Hold Active") OR (SalesSetup."Credit Limit Hold Active")) THEN BEGIN
                //     IF (Quantity <> 0) AND ("Unit Price" <> 0) THEN BEGIN
                //         HoldType := CustCheckCreditLimit.SalesLineCheckNew(Rec);
                //         IF (HoldType > 0) THEN BEGIN
                //             CASE HoldType OF
                //                 1:
                //                     "Credit Hold" := TRUE;
                //                 2:
                //                     "Overdue Hold" := TRUE;
                //                 3:
                //                     BEGIN
                //                         "Credit Hold" := TRUE;
                //                         "Overdue Hold" := TRUE;
                //                     END;
                //             END;
                //             IF GUIALLOWED THEN
                //                 WBU.RefreshPage
                //         END;
                //     END;
                // END;
                //win127
                VALIDATE("Shield Cost");
                //Kaayam Uday


            end;
        }
        modify("Unit Price Incl. of Tax")
        {
            trigger OnBeforeValidate()
            begin
                // rec."Line Discount Amount" := (rec."MRP Value" * Rec."Line Discount %") / 100;//tk
                Rec."Net Amount" := Rec."MRP Value" - rec."Line Discount Amount";//tk
                // rec."Discount Amount" := (rec."MRP Value" * "Discount %") / 100;//tk
                // Rec."Net Amount" := Round(Rec."MRP Value" - rec."Discount Amount");//tk
                If "Unit Price Incl. of Tax" <> 0 then
                    Rec.Validate("Price Inclusive of Tax", true);
                //tk
                //Rec."Total UPIT Amount" := "Line Amount";//tk

                // rec."Discount Amount" := (rec."Unit Price Incl. of Tax" * "Discount %") / 100;//tk
                // Rec."Net Amount" := Rec."Unit Price Incl. of Tax" - rec."Discount Amount";//tk
                //updated WIN347++
                SalesHeader.GET(Rec."Document Type", Rec."Document No.");

                //COMMIT;
                //SalesLine1 := Rec;
                //WBU.CalculateStructure(SalesHeader);
                //Rec := SalesLine1;
                // CallStatistics;
                //MODIFY(TRUE);
                //WBU.RefreshPage();
                IF Shield THEN BEGIN
                    StandardText.RESET;
                    StandardText.SETFILTER(Shield, '%1', TRUE);
                    StandardText.SETFILTER("Shield Type", '%1', "Shield Type");
                    IF StandardText.FINDFIRST THEN BEGIN
                        IF StandardText."Shield Cost Perct" = 0 THEN
                            ERROR('Shield Cost Percent is not defined for Shield Type %1', "Shield Type");
                        Shield := TRUE;
                        "Shield Cost" := (Quantity * "Unit Price Incl. of Tax") * (StandardText."Shield Cost Perct" / 100);
                    END;
                END;
                IF GUIALLOWED THEN
                    //  Rec.Validate("Price Inclusive of Tax", true);//tk
                    WBU.RefreshStatistics;
                //Updated WIN347--

            end;
        }
        modify("Line Discount Amount")
        {
            trigger OnAfterValidate()
            var
                Discounting: Record Discounting;
            BEGIN
                Discounting.Reset();
                Discounting.SetRange(Discounting."Entry No", Rec."Entry No");
                //Discounting.SetRange(Discounting."Discount Type", rec."Discount Type");
                // Discounting.SetRange(Discounting."Primary category", Rec."Primary category");
                // Discounting.SetRange(Discounting."Secondary category", Rec."Secondary category");
                // Discounting.SetFilter(Discounting."Maximum % Limit", '<>%1', 0);
                //Discounting.SetFilter(Discounting."Maximum % Limit", '<%1', Rec."Line Discount %");
                if Discounting.find('-') then begin
                    IF Rec."Line Discount %" > Discounting."Maximum % Limit" THEN
                        Error('can not be greater than maximum limit');
                    rec."Line Discount %" := ("Line Discount Amount" / Rec."MRP Value") * 100;//tk
                    Rec."Net Amount" := Rec."MRP Value" - rec."Line Discount Amount";//tk
                end;

            END;
        }
        modify("Line Discount %")
        {
            Caption = 'Line Discount %';
            Description = '//CCIT-TK';

            trigger OnAfterValidate()
            var
                Discounting: Record Discounting;

            begin
                //TK
                Discounting.Reset();
                Discounting.SetRange(Discounting."Entry No", Rec."Entry No");//DEv
                //Discounting.SetRange(Discounting."Discount Type", rec."Discount Type");//tkold
                // Discounting.SetRange(Discounting."Primary category", Rec."Primary category");
                // Discounting.SetRange(Discounting."Secondary category", Rec."Secondary category");
                Discounting.SetFilter(Discounting."Maximum % Limit", '<>%1', 0);
                Discounting.SetFilter(Discounting."Maximum % Limit", '<%1', Rec."Line Discount %");
                if Discounting.find('-') then
                    Error('can not be greater than maximum limit');
                rec."Line Discount Amount" := (rec."MRP Value" * "Line Discount %") / 100;//tk
                //tk++
                Rec."Net Amount" := Rec."MRP Value" - rec."Line Discount Amount";
                // rec."Unit Price Incl. of Tax" := Rec."Net Amount";
                // rec."Unit Price" := Rec."Net Amount";
                // If "Unit Price Incl. of Tax" <> 0 then begin//tk
                //     Rec.Validate("Price Inclusive of Tax", true);//tk--
                // end;



            end;

        }
    }
    trigger OnAfterInsert()
    begin
        //WIN316++
        IF "Sales Order Type" = "Sales Order Type"::Retail THEN
            IF SalesHeader."Capillary Discount Amount" <> 0 THEN
                ERROR('You cannot Insert as capillery discount is applied on Order/Invoice');
        //WIN316--
        //Win127 updated WIN347++
        Rec."Cust. Mobile No." := SalesHeader."Cust. Mobile No.";
        Rec."Cust. email ID" := SalesHeader."Cust. email ID";
        Rec."Customer Name" := SalesHeader."Customer Name";
        Rec."Sales Order Type" := SalesHeader."Sales Order Type";
        //"PIT Structure" := SalesHeader.Structure;  //02.11.14
        //MESSAGE('PIT1');
        //MESSAGE("PIT Structure");
        //Updated WIN347--



    end;

    trigger OnAfterModify()
    begin
        //WIN316++/CAPILLARY
        IF ("Capillary Line Discount Amount" > 0) AND (Rec."Document Type" <> Rec."Document Type"::"Credit Memo") THEN
            IF "Posting Date" <> xRec."Posting Date" THEN
                ERROR('You cannot Change this as Capillary Discount is applied !!!');
        //WIN316--

    end;

    trigger OnAfterDelete()
    var
        myInt: Integer;
        DelSalesLine: Record "Sales Line";  // MAPPLE 1.0 Bundle Item >>>
    begin
        /*
        // MAPPLE 1.0 Bundle Item >>>
        if Rec."Bundle Code" <> '' then begin
            DelSalesLine.Reset();
            DelSalesLine.SetRange("Document Type", Rec."Document Type");
            DelSalesLine.SetRange("Document No.", Rec."Document No.");
            DelSalesLine.SetRange("Bundle Code", Rec."Bundle Code");
            if not DelSalesLine.IsEmpty then
                DelSalesLine.DeleteAll();
        end;
        // MAPPLE 1.0 Bundle Item <<<
        */

        // //WIN316++
        // IF ("Capillary Line Discount Amount" <> 0) AND (RecUserr."Capillary Disc.  Order Delete" = FALSE) THEN
        //     ERROR('You cannot Delete capillery discount is applied on Order/Invoice');
        // //WIN316--//tk

    end;

    var
        Sno: Code[30];
        Text16509: Label 'Only Type Fixed Asset is allowed in case of FA Disposal';
        //    WBU: Codeunit "50000";
        RecItem: Record Item;
        Item: Record item;
        SalesHeader: Record "Sales Header";
        RecVendPart: Record "Vendor Part Master Shield Bill";
        SalesSetup: Record "Sales & Receivables Setup";
        StandardText: Record "Standard Text";
        WBU: Codeunit 50000;
        TempSalesLine: Record 37;
        ReservEntry: Record 337;

    procedure UpdateSerialNo()
    var
        SalesLineLocal: Record 37;
        Line: Integer;
    begin
        DeleteSalesTrackingSpecification(Rec);
        TESTFIELD(Quantity);
        //TESTFIELD("Line No.");
        IF "Line No." = 0 THEN BEGIN
            SalesLineLocal.SETRANGE("Document Type", "Document Type");
            SalesLineLocal.SETFILTER("Document No.", "Document No.");
            IF SalesLineLocal.FINDLAST THEN
                Line := SalesLineLocal."Line No." + 10000
            ELSE
                Line := 10000;
        END
        ELSE
            Line := "Line No.";




        // CreateReservEntry.CreateReservEntryFor(
        //  DATABASE::"Sales Line", "Document Type", "Document No.", '', 0, Line, "Qty. per Unit of Measure", 0, Quantity, ReservEntry);//"Item Serial No.","IMEI No.");

        // CreateReservEntry.CreateEntry("No.", "Variant Code", "Location Code", Description, 0D, "Shipment Date", 0, ReservEntry."Reservation Status"::Surplus);
        CreateReservation(false, Rec."Document No.", Rec."No.", Rec."Item Serial No.", Line, Rec."Location Code", Rec.Quantity, Today, Rec."IMEI No.", Rec."MRP Value");

    end;


    procedure DeleteSalesTrackingSpecification(SalesLine: Record 37)
    begin
        ReservEntry.SETCURRENTKEY(
          "Source ID", "Source Ref. No.", "Source Type", "Source Subtype",
          "Source Batch Name", "Source Prod. Order Line", "Reservation Status",
          "Shipment Date", "Expected Receipt Date");
        ReservEntry.SETRANGE("Source ID", SalesLine."Document No.");
        ReservEntry.SETRANGE("Source Ref. No.", "Line No.");
        ReservEntry.SETRANGE("Source Type", DATABASE::"Sales Line");
        ReservEntry.SETRANGE("Source Subtype", SalesLine."Document Type");
        ReservEntry.SETRANGE("Source Batch Name", '');
        ReservEntry.SETRANGE("Source Prod. Order Line", 0);
        IF ReservEntry.FINDSET THEN
            REPEAT
                ReservEntry.DELETE;
            UNTIL ReservEntry.NEXT = 0;
    end;

    procedure ChkDuplicateSerialNo(SerialNo: Code[20]): Boolean
    var
    //PurchLine: Record 39;
    begin
        ReservEntry.SETRANGE("Source Type", DATABASE::"Sales Line");
        ReservEntry.SETFILTER("Serial No.", '%1', SerialNo);
        ReservEntry.Setfilter("Source ID", '<>%1', Rec."Document No.");
        ReservEntry.Setfilter("Source Ref. No.", '<>%1', Rec."Line No.");
        IF ReservEntry.FINDFIRST THEN BEGIN
            ERROR('Item Serial No. entry already done, Sales Order No. %1 Item No. %2 ', ReservEntry."Source ID", ReservEntry."Item No.");
            EXIT(TRUE);
        END
        ELSE
            EXIT(FALSE);
    end;

    procedure CreateReservation(Positive: boolean; ReserveDoc: Code[20]; ReserveItem: Code[20]; ReserveSerial: Code[30]; SourceRefLine: Integer; LocationCode: Code[20]; QTY: Decimal; PostingDate: Date; IMEINO: code[20]; MRPVALUE: Decimal)
    var
        ReservationEntryNo: Record "Reservation Entry";
        ReservationEntry: Record "Reservation Entry";
        EntryNo: Integer;
    begin
        if ReservationEntryNo.FindLast() then
            EntryNo := ReservationEntryNo."Entry No." + 1
        else
            EntryNo := 1;

        ReservationEntry.Reset();
        ReservationEntry.Init();
        ReservationEntry."Item No." := ReserveItem;
        ReservationEntry."Reservation Status" := ReservationEntry."Reservation Status"::Surplus;
        ReservationEntry."Creation Date" := Today;
        ReservationEntry."Source Type" := 37;
        ReservationEntry."Source Subtype" := 1;
        ReservationEntry."Source ID" := ReserveDoc;
        ReservationEntry."Source Ref. No." := SourceRefLine;
        ReservationEntry."Location Code" := LocationCode;
        ReservationEntry."Serial No." := ReserveSerial;
        ReservationEntry."IMEI No." := IMEINO;
        ReservationEntry."MRP Value" := MRPVALUE;
        ReservationEntry."Created By" := UserId;
        ReservationEntry."Source Subtype" := 1;
        ReservationEntry."Shipment Date" := PostingDate;
        ReservationEntry.Positive := false;
        ReservationEntry.Validate("Quantity (Base)", -QTY);
        ReservationEntry.Validate(Quantity, -QTY);
        ReservationEntry."Qty. to Handle (Base)" := -QTY;
        ReservationEntry."Qty. to Invoice (Base)" := -QTY;
        ReservationEntry."Suppressed Action Msg." := false;
        ReservationEntry.Positive := false;
        ReservationEntry."Item Tracking" := ReservationEntry."Item Tracking"::"Serial No.";
        ReservationEntry.Insert(true);

    end;


}
