tableextension 50063 "PurchaseLine" extends "Purchase Line"
{
    fields
    {
        field(50000; "Item Serial No"; Code[20])
        {

            trigger OnValidate()
            begin
                IF "Item Serial No" <> '' THEN BEGIN
                    TESTFIELD(Type, Type::Item);
                    TESTFIELD("No.");
                    IF NOT ChkDuplicateSerialNo("Item Serial No", Rec) THEN BEGIN
                        VALIDATE(Quantity, 1);
                        UpdateSerialNo(Rec);//tk
                    END
                    ELSE BEGIN
                        MESSAGE('Duplicate Item Serial No.');
                        "Item Serial No" := '';
                    END;
                END;
            end;
        }
        field(50001; "IMEI No."; Code[20])
        {

            trigger OnValidate()
            begin
                IF ("Item Serial No" <> '') AND ("IMEI No." <> '') THEN BEGIN
                    //TESTFIELD(Type,Type::Item);
                    //VALIDATE(Quantity,1);
                    //UpdateSerialNo(Rec);
                    ReservEntry.SETFILTER("Source ID", '%1', "Document No.");
                    ReservEntry.SETFILTER("Source Ref. No.", '%1', "Line No.");
                    ReservEntry.SETFILTER("Source Type", '%1', DATABASE::"Purchase Line");
                    ReservEntry.SETFILTER("Source Subtype", '%1', "Document Type");
                    ReservEntry.SETRANGE("Source Batch Name", '');
                    ReservEntry.SETRANGE("Source Prod. Order Line", 0);
                    IF ReservEntry.FINDFIRST THEN BEGIN
                        //MESSAGE('Entry %1', ReservEntry."Serial No.");
                        ReservEntry."IMEI No." := "IMEI No.";//tk
                        ReservEntry.MODIFY;
                    END;
                END;
            end;
        }
        field(50002; "Primary category"; Code[20])
        {
            // TableRelation = "Standard Text" WHERE("Category Type"=CONST(Primary));
        }
        field(50003; "Secondary category"; Code[20])
        {
            //TableRelation = "Standard Text" WHERE("Category Type"=CONST(Secondary));
        }
        field(50004; "Third category"; Code[20])
        {
            // TableRelation = "Standard Text" WHERE("Category Type"=CONST(Third))
        }
        field(50005; "UPN Code"; Code[20])
        {

            trigger OnValidate()
            begin
                VALIDATE("Item Serial No", '');
            end;
        }
        field(50006; "Retail Buyback Ref. No."; Code[20])
        {
        }
        field(50016; "Vendor Part Code Long"; Code[50])
        {
        }
        field(50030; "Ingram Part Code"; Code[20])
        {
            Caption = 'Ingram Part Code';
            Description = 'KPPL-INGRAM';
        }
        field(50031; "Ingram Order No."; Code[20])
        {
            Caption = 'Ingram Order No.';
            DataClassification = ToBeClassified;
            Description = 'KPPL-INGRAM';
        }
        field(50032; "Ingram Sub Order No."; Code[20])
        {
            Caption = 'Ingram Sub Order No.';
            DataClassification = ToBeClassified;
            Description = 'KPPL-INGRAM';
        }
        field(50033; "MRP Value"; Decimal)
        {

            trigger OnValidate()
            begin
                IF ("Item Serial No" <> '') AND ("MRP Value" <> 0) THEN BEGIN
                    //TESTFIELD(Type,Type::Item);
                    //VALIDATE(Quantity,1);
                    //UpdateSerialNo(Rec);
                    ReservEntry.SETFILTER("Source ID", '%1', "Document No.");
                    ReservEntry.SETFILTER("Source Ref. No.", '%1', "Line No.");
                    ReservEntry.SETFILTER("Source Type", '%1', DATABASE::"Purchase Line");
                    ReservEntry.SETFILTER("Source Subtype", '%1', "Document Type");
                    ReservEntry.SETRANGE("Source Batch Name", '');
                    ReservEntry.SETRANGE("Source Prod. Order Line", 0);
                    IF ReservEntry.FINDFIRST THEN BEGIN
                        //MESSAGE('Entry %1', ReservEntry."Serial No.");
                        ReservEntry."MRP Value" := "MRP Value";//tk
                        ReservEntry.MODIFY;
                    END;
                END;
            end;
        }
        field(50034; "Ingram Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
                PrepmtMgt: Codeunit 441;

            begin
                // IF (PurchHeader."Document Type" <> PurchHeader."Document Type"::"Credit Memo") AND (Type = Type::Item) AND (PurchHeader."Location Code" = '') THEN BEGIN
                //     MESSAGE('Select Location');
                //     "No." := '';
                //     EXIT;
                // END;//tk
                // IF (PurchHeader."Document Type" <> PurchHeader."Document Type"::"Credit Memo") AND (Type = Type::Item) AND (PurchHeader.Structure = '') THEN BEGIN
                //     MESSAGE('Select Structure');
                //     "No." := '';
                //     EXIT;
                // END;
                If Item.Get("No.") then begin
                    "IMEI No." := TempPurchLine."IMEI No.";
                    "Item Serial No" := TempPurchLine."Item Serial No";
                    "Retail Buyback Ref. No." := TempPurchLine."Retail Buyback Ref. No.";
                    "UPN Code" := TempPurchLine."UPN Code";
                    // Vendor part code long
                    "Vendor Part Code Long" := Item."Vendor Part Code Long";
                    //
                    //Win127
                    "Primary category" := Item."Primary category";
                    "Secondary category" := Item."Secondary category";
                    "Third category" := Item."Third category";
                    //
                end;

            end;

        }
    }

    var
        myInt: Integer;
        Text003: Label 'You cannot purchase resources.';
        Text040: Label 'You must use form %1 to enter %2, if item tracking is used.';
        TempPurchLine: Record 39;
        Item: Record 27;
        ItemTranslation: Record 30;
        SalesOrderLine: Record 37;
        QtyEnable: Boolean;
        CreateReservEntry: Codeunit 99000830;
        // WBU: Codeunit 50000;//tk
        // TDSNOD: Record 13726;
        // NODLines: Record 13785;
        Text13700: Label 'You are not allowed to select this Nature of deduction.';
        Text13701: Label 'BED AMOUNT';
        Text13702: Label 'AED AMOUNT';
        Text13703: Label 'SED AMOUNT';
        Text13704: Label 'SAED AMOUNT';
        Text13705: Label 'CESS AMOUNT';
        Text13706: Label 'NCCD AMOUNT';
        Text13707: Label 'ECESS AMOUNT';
        Text13708: Label 'ADET AMOUNT';
        Text13709: Label 'LINE AMOUNT';
        Text13710: Label 'ADE AMOUNT';
        //TDSBuf: array[2] of Record "13714" temporary;
        //TDSSetup: Record "13728";
        Text16362: Label 'No Transaction allowed; Status is Closed.';
        Text16363: Label 'Invalid Quantity.';
        Text16501: Label 'Item %1 is short by %2 quantity in RG 23 D. Please adjust the quantity to proceed.';
        CFactor: Decimal;
        Text13713: Label 'SHE CESS AMOUNT';
        CompanyInfo: Record 79;
        CompanyInfoRead: Boolean;
        Text13714: Label 'ASSESSABLE VALUE';
        Text16502: Label 'ADC VAT AMOUNT';
        Text16503: Label 'BCD AMOUNT';
        Text16504: Label 'CIF AMOUNT';
        // ExcisePostingSetup: Record 13711;
        PurchHeader2: Record 38;
        Text16505: Label 'CUST. ECESS AMOUNT';
        Text16506: Label 'CUST. SHECESS AMOUNT';
        Text16507: Label 'Type must be G/L Account or Item in Purchase Line Document Type=%1'',Document No.=%2,Line No.=%3.';
        Text16508: Label 'To view Excise Detail the Structure should include Excise. ';
        Text16509: Label 'You cannot deduct TDS for negative line amounts.\ Document Type=%1'''',Document No.=%2,Line No.=%3.';
        TaxAmount: Decimal;
        AssessableValueCalc: Boolean;
        Text16510: Label 'RG register already created for the receipts. In order to make the changes reflect in the RG registers, please use the ''Get Receipt lines'' functionality from the invoice and then post.';
        //  TempRG23DRemainder: Record 16537 temporary;
        //TempRG23DConsumedInCurrDoc: Record 16537 temporary;
        BEDAmt: Decimal;
        "AED(GSI)Amt": Decimal;
        "AED(TTA)Amt": Decimal;
        SEDAmt: Decimal;
        SAEDAmt: Decimal;
        CESSAmt: Decimal;
        NCCDAmt: Decimal;
        eCessAmt: Decimal;
        ADETAmt: Decimal;
        ADEAmt: Decimal;
        SHECessAmt: Decimal;
        ADCVATAmt: Decimal;
        InvtBuffer: array[2] of Record 307 temporary;
        DataConflictQst: Label 'The change creates a date conflict with existing reservations. Do you want to continue?';
        Text16512: Label 'The document type for posting transactions that have TDS specified must be Invoice or Order.';
        Text16511: Label 'The document type for posting transactions that have Work Tax specified must be Invoice or Order.';
        Text16513: Label 'You are not allowed to select this Nature of Remittance.';
        ILE: Record 32;
        PurchHeader: Record 38;
        TDSBaseLCY1: Decimal;
        PrevInvoiceAmt: Decimal;

        StdTxt: Record 7;
        FA: Record 5600;
        FADeprBook: Record 5612;
        FASetup: Record 5603;

        ReservEntry: Record 337;
        PurchHeader1: Record 38;

    procedure ChkDuplicateSerialNo(SerialNo: Code[20]; PurchaseLine: Record 39): Boolean
    var
        PurchLine: Record 39;
    begin
        /*
        PurchLine.RESET;
        PurchLine.SETFILTER("Document Type",'%1',PurchaseLine."Document Type");
        PurchLine.SETFILTER("Document No.",'%1',PurchaseLine."Document No.");
        PurchLine.SETFILTER("Item Serial No",'%1',SerialNo);
        EXIT(NOT PurchLine.ISEMPTY);
        */
        ILE.RESET;
        ILE.SETCURRENTKEY("Serial No.");
        ILE.SETFILTER("Serial No.", SerialNo);
        ILE.SETRANGE("Entry Type", ILE."Entry Type"::Purchase, ILE."Entry Type"::"Positive Adjmt.");
        ILE.SETFILTER(Open, '=%1', TRUE);
        IF NOT ILE.FINDFIRST THEN BEGIN
            ReservEntry.SETFILTER("Source Type", '%1', DATABASE::"Purchase Line");
            ReservEntry.SETFILTER("Serial No.", SerialNo);
            IF ReservEntry.FINDFIRST THEN
                EXIT(TRUE)
            ELSE
                EXIT(FALSE);
        END
        ELSE
            EXIT(TRUE);

    end;

    local procedure "***************"()
    begin
    end;

    procedure GetCurrentPurchHeader(PurchaseHeaderRec: Record 38)
    begin
        PurchHeader1 := PurchaseHeaderRec;
    end;

    procedure UpdateSalesOrderTotalAmt(SalesOrderNo: Code[20]; LineAmount: Decimal; xLineAmount: Integer)
    var
        SalesHeader: Record 36;
    begin
        SalesHeader.RESET;
        SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SETFILTER("No.", '%1', SalesOrderNo);
        IF SalesHeader.FINDFIRST THEN BEGIN
            SalesHeader.CALCFIELDS("Maple Buyback Amt");
            //VALIDATE(TotalPayByCustomer);
            SalesHeader.TotalPayByCustomer := SalesHeader.PayByCashAmt + SalesHeader.PayByCreditAmt1 + SalesHeader.PayByCreditAmt2 + SalesHeader.PayByCreditAmt3 + SalesHeader.PayByCreditAmt4 + SalesHeader.PayByDebitCdAmt1 + SalesHeader.PayByChqAmt + SalesHeader.GiftVoucherAmt + SalesHeader."RTGS Amount" + SalesHeader."Finance Amount" + SalesHeader."Maple Buyback Amt" + SalesHeader."Apple Buyback Amt" + SalesHeader."Apple Refund Amt";
            SalesHeader.TotalPayByCustomer := SalesHeader.TotalPayByCustomer + SalesHeader.PayByDebitAmt2 + LineAmount - xLineAmount;
            SalesHeader.MODIFY;
            COMMIT;
            SalesHeader.CALCFIELDS("Maple Buyback Amt");
        END;
    end;
    // procedure UpdateSerialNo(PurchLine: Record 39)
    // var
    //     PurchLineLocal: Record 39;
    //     Line: Integer;
    // begin
    //     TESTFIELD(Quantity);
    //     TESTFIELD("Line No.");
    //     DeletePurchSpecification(Rec);
    //     CreateReservEntry.CreateReservEntryFor(
    //         DATABASE::"Purchase Line","Document Type","Document No.",'',0,"Line No.","Qty. per Unit of Measure",0,Quantity,"Item Serial No","IMEI No.");

    //     CreateReservEntry.CreateEntry("No.","Variant Code","Location Code",Description,"Expected Receipt Date",0D,0,ReservEntry."Reservation Status"::Surplus);
    // end;//tk


    procedure DeletePurchSpecification(PurchLine: Record 39)
    begin
        //ReservEntry.SETCURRENTKEY(
        //  "Source ID","Source Ref. No.","Source Type","Source Subtype",
        //  "Source Batch Name","Source Prod. Order Line","Reservation Status",
        //  "Shipment Date","Expected Receipt Date");
        ReservEntry.SETFILTER("Source ID", '%1', PurchLine."Document No.");
        ReservEntry.SETFILTER("Source Ref. No.", '%1', PurchLine."Line No.");
        ReservEntry.SETFILTER("Source Type", '%1', DATABASE::"Purchase Line");
        ReservEntry.SETFILTER("Source Subtype", '%1', PurchLine."Document Type");
        ReservEntry.SETRANGE("Source Batch Name", '');
        ReservEntry.SETRANGE("Source Prod. Order Line", 0);
        IF ReservEntry.FINDFIRST THEN
            REPEAT
                ReservEntry.DELETE;
            UNTIL ReservEntry.NEXT = 0;
    end;


    procedure GetRetailSalesOrderNo(PurchLine: Record 39): Code[20]
    var
        SaleHeader: Record 36;
    begin
        PurchHeader.RESET;
        PurchHeader.SETRANGE("Document Type", PurchHeader."Document Type"::Order);
        PurchHeader.SETFILTER("No.", PurchLine."Document No.");
        IF PurchHeader.FINDFIRST THEN
            EXIT(PurchHeader."Retail Buyback Ref. No.")
        ELSE
            EXIT('');
    end;


    procedure GetRetailPurchOrderNo(SalesOrderNo: Code[20]): Code[20]
    var
        PurchHeader: Record 38;
    begin
        PurchHeader.RESET;
        PurchHeader.SETRANGE("Document Type", PurchHeader."Document Type"::Order);
        PurchHeader.SETFILTER("Retail Buyback Ref. No.", '%1', SalesOrderNo);
        IF PurchHeader.FINDFIRST THEN
            EXIT(PurchHeader."No.")
        ELSE
            EXIT('');
    end;

    procedure UpdateSerialNo(PurchLine: Record 39)
    var
        PurchLineLocal: Record 39;
        SalesLine: record 39;
        Line: Integer;
        TempReservEntry: Record "Reservation Entry" temporary;
    begin
        TESTFIELD(Quantity);
        TESTFIELD("Line No.");
        DeletePurchSpecification(Rec);
        // CreateReservEntry.CreateReservEntryFor(
        //     DATABASE::"Purchase Line","Document Type","Document No.",'',0,"Line No.","Qty. per Unit of Measure",0,Quantity,"Item Serial No","IMEI No.");

        CreateReservEntry.CreateReservEntryFor(DATABASE::"Purchase Line", "Document Type", "Document No.", '', 0, "Line No.", "Qty. per Unit of Measure", 0, Quantity, ReservEntry);
        CreateReservEntry.CreateEntry("No.", "Variant Code", "Location Code", Description, "Expected Receipt Date", 0D, 0, ReservEntry."Reservation Status"::Surplus);
    end;





}