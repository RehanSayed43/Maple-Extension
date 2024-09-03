table 50008 "Defective Accessory"
{

    fields
    {
        field(1; "Transaction No"; Code[20])
        {

            trigger OnValidate()
            begin
                //INSERT(TRUE);
                IF "Transaction No" <> xRec."Transaction No" THEN BEGIN
                    GetInventorySetup;
                    //   NoSeriesMgt.TestManual(GetNoSeriesCode);
                    "No. Series" := '';
                END;
            end;
        }
        field(2; "Creation Date"; Date)
        {
        }
        field(3; Zone; Code[20])
        {
            TableRelation = State.Zone;
        }
        field(4; State; Code[10])
        {
            TableRelation = State.Code;
        }
        field(5; City; Text[30])
        {
            TableRelation = "Post Code".City;
        }
        field(6; "Location Code"; Code[10])
        {
            TableRelation = Location.Code WHERE("Location Type" = FILTER(Saleable));
        }
        field(7; "Customer Type"; Option)
        {
            OptionCaption = ' ,Retail,Corporate';
            OptionMembers = " ",Retail,Corporate;
        }
        field(8; "Customer No"; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(9; "Customer Name"; Text[50])
        {
        }
        field(10; "Invoice No"; Code[20])
        {

            trigger OnLookup()
            begin
                //WIN316++
                IF "Document No" = '' THEN
                    ERROR('Please enter Document No. then begin');
                RecSalesInvLine.RESET;
                RecSalesInvLine.SETRANGE("Document No.", "Document No");
                IF RecSalesInvLine.FINDSET THEN BEGIN
                    IF PAGE.RUNMODAL(50088, RecSalesInvLine) = ACTION::LookupOK THEN BEGIN
                        "Invoice No" := RecSalesInvLine."Document No.";
                        "Maple Part Code" := RecSalesInvLine."No.";
                        "Qty. Taken Back" := RecSalesInvLine.Quantity;
                        Brand := RecSalesInvLine."Item Category Code";
                        // Category := RecSalesInvLine."Product Group Code";
                        "Primary Category" := RecSalesInvLine."Primary category";
                        "UPN No" := RecSalesInvLine."UPN Code";
                        "Customer No" := RecSalesInvLine."Sell-to Customer No.";
                        "Location Code" := RecSalesInvLine."Location Code";
                        Description := RecSalesInvLine.Description;
                        "Qty. Given" := RecSalesInvLine.Quantity;
                    END;
                END;
                /*
                CLEAR(PageSaleInvLine);
                PageSaleInvLine.SETTABLEVIEW(RecSalesInvLine);
                PageSaleInvLine.SETRECORD(RecSalesInvLine);
                PageSaleInvLine.LOOKUPMODE(TRUE);
                IF PageSaleInvLine.RUNMODAL = ACTION::LookupOK THEN BEGIN
                  PageSaleInvLine.GETRECORD(RecSalesInvLine);
                  "Invoice No":=RecSalesInvLine."Document No.";
                  "Maple Part Code":=RecSalesInvLine."No.";
                  "Qty. Taken Back":=RecSalesInvLine.Quantity;
                  Brand:=RecSalesInvLine."Item Category Code";
                  Category:= RecSalesInvLine."Product Group Code";
                  "Primary Category":=RecSalesInvLine."Primary category";
                 "UPN No":=RecSalesInvLine."UPN Code";
                 "Customer No":= RecSalesInvLine."Sell-to Customer No.";
                 "Location Code":=RecSalesInvLine."Location Code";
                 Description:=RecSalesInvLine.Description;
                 "Qty. Given":=RecSalesInvLine.Quantity;
                 END;
                 */
                //WIN316--
                RecItem.RESET;
                RecItem.SETRANGE(RecItem."No.", RecSalesInvLine."No.");
                IF RecItem.FINDFIRST THEN
                    "Vendor part Code" := RecItem."Vendor Part Code Long";

                RecCustomer.RESET;
                RecCustomer.SETRANGE(RecCustomer."No.", RecSalesInvLine."Sell-to Customer No.");
                IF RecCustomer.FINDFIRST THEN BEGIN
                    "Customer Name" := RecCustomer.Name;
                    "Customer Type" := RecCustomer."Customer Type";
                    State := RecCustomer."State Code";
                    City := RecCustomer.City;
                END;
                IF recState.GET(RecCustomer."State Code") THEN
                    Zone := recState.Zone;
                IF RecSalesInvoiceheader.GET(RecSalesInvLine."Document No.") THEN
                    "Invoice Date" := RecSalesInvoiceheader."Posting Date";

            end;
        }
        field(11; "Posting Date"; Date)
        {
        }
        field(12; Brand; Code[10])
        {
            TableRelation = "Item Category";
        }
        field(13; Category; Code[10])
        {
            TableRelation = "Product Group NEW".Code WHERE("Item Category Code" = FIELD(Brand));
        }
        field(14; "Primary Category"; Code[20])
        {
            TableRelation = "Standard Text" WHERE("Category Type" = CONST(Primary));
        }
        field(15; "Maple Part Code"; Code[20])
        {
            TableRelation = Item."No.";

            trigger OnValidate()
            begin
                SalesInvHeader.RESET;
                SalesInvHeader.SETRANGE(SalesInvHeader."Document No.", "Invoice No");
                SalesInvHeader.SETRANGE(SalesInvHeader."No.", "Maple Part Code");
                IF NOT SalesInvHeader.FINDFIRST THEN
                    ERROR(Text000, "Maple Part Code", "Invoice No");
            end;
        }
        field(16; "Vendor part Code"; Code[50])
        {
            Description = '//win234 changed from 20';
        }
        field(17; Description; Text[50])
        {
        }
        field(18; "Qty. Taken Back"; Integer)
        {
        }
        field(19; "UPN No"; Code[20])
        {
        }
        field(20; "Given Brand"; Code[10])
        {
            TableRelation = "Item Category";
        }
        field(21; "Given Category"; Code[10])
        {
            TableRelation = "Product Group New".Code WHERE("Item Category Code" = FIELD("Given Brand"));
        }
        field(22; "Given Primary Category"; Code[20])
        {
            TableRelation = "Standard Text" WHERE("Category Type" = CONST(Primary));
        }
        field(23; "Given Maple Part Code"; Code[20])
        {
            TableRelation = Item."No.";

            trigger OnValidate()
            begin
                RecItem.RESET;
                RecItem.SETRANGE(RecItem."No.", "Given Maple Part Code");
                IF RecItem.FINDFIRST THEN BEGIN
                    "Given Vendor part Code" := RecItem."Vendor Part Code Long";
                    "Given Description" := RecItem.Description;
                    "Given Brand" := RecItem."Item Category Code";
                    //   "Given Category" := RecItem."Product Group Code";
                    "Given Primary Category" := RecItem."Primary category";

                END;
            end;
        }
        field(24; "Given Vendor part Code"; Code[50])
        {
            Description = '//win234 changed from 20';
        }
        field(25; "Given Description"; Text[50])
        {
        }
        field(26; "Qty. Given"; Integer)
        {

            trigger OnValidate()
            begin
                inv := 0;
                RecItemLedEntry.RESET;
                RecItemLedEntry.SETRANGE(RecItemLedEntry."Item No.", "Given Maple Part Code");
                RecItemLedEntry.SETRANGE(RecItemLedEntry."Location Code", "Location Code");
                IF RecItemLedEntry.FINDSET THEN
                    REPEAT
                        inv += RecItemLedEntry.Quantity;
                    UNTIL RecItemLedEntry.NEXT = 0;

                IF inv <= 0 THEN
                    ERROR(Text001, "Location Code");
            end;
        }
        field(27; "Given UPN No"; Code[20])
        {

            trigger OnValidate()
            begin

                IF "Given UPN No" <> '' THEN BEGIN
                    ILE.RESET;
                    ILE.SETFILTER(ILE."UPN Code", "Given UPN No");
                    ILE.SETFILTER(ILE.Open, '=%1', TRUE);
                    IF ILE.FINDFIRST THEN BEGIN
                        VALIDATE("Given Maple Part Code", ILE."Item No.");
                    END
                    ELSE
                        MESSAGE('Product is not Available in Inventory');
                END;
            end;
        }
        field(28; "Damage Location"; Code[10])
        {
            TableRelation = Location.Code WHERE("Location Type" = FILTER(Damage));
        }
        field(29; Posted; Boolean)
        {
        }
        field(30; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(31; "Invoice Date"; Date)
        {
        }
        field(32; "Document No"; Code[20])
        {
        }
        field(33; "Line No."; Integer)
        {
        }
        field(34; "Given Serail No."; Code[20])
        {
        }
        field(35; "Return Serial No."; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Transaction No", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        GetInventorySetup;
        IF "Transaction No" = '' THEN BEGIN
            TestNoSeries;
            //   NoSeriesMgt.InitSeries(GetNoSeriesCode, xRec."No. Series", "Posting Date", "Transaction No", "No. Series");
        END;
        InitRecord;
    end;

    var
        RecCustomer: Record "Customer";
        RecItem: Record "Item";
        RecNoSeriesLine: Record "No. Series Line";
        TransHeader: Record 50008;
        //  NoSeriesMgt: Codeunit "NoSeriesManagement";
        InvtSetup: Record "Inventory Setup";
        HasInventorySetup: Boolean;
        SalesInvHeader: Record 113;
        Text000: Label 'Maple Part Code #1##########is not belongs to #2#################### Invoice';
        RecItemLedEntry: Record "Item Ledger Entry";
        inv: Integer;
        Text001: Label 'Quantity is not available at #1########## Location code';
        RecSalesInvLine: Record "Sales Invoice Line";
        PageSaleInvLine: Page 50088;
        recState: Record State;
        RecSalesInvoiceheader: Record "Sales Invoice Header";
        ILE: Record 32;


    procedure InitRecord()
    begin
        IF "Posting Date" = 0D THEN
            VALIDATE("Posting Date", WORKDATE);
        //"Time of Removal" := TIME;
    end;


    procedure AssistEdit(OldTransHeader: Record 50008): Boolean
    begin
        TransHeader := Rec;
        GetInventorySetup;
        TestNoSeries;
        //    IF NoSeriesMgt.SelectSeries(GetNoSeriesCode, OldTransHeader."No. Series", "No. Series")
        //     THEN BEGIN
        //         NoSeriesMgt.SetSeries("Transaction No");
        //         Rec := TransHeader;
        //         EXIT(TRUE);
        //     END;
    end;

    local procedure TestNoSeries(): Boolean
    begin
        InvtSetup.RESET;
        InvtSetup.SETRANGE(InvtSetup."Primary Key", 'DEF');
        IF InvtSetup.FINDFIRST THEN BEGIN
            InvtSetup.TESTFIELD("Transfer Order Nos.");
        END;
    end;

    local procedure GetNoSeriesCode(): Code[10]
    begin
        InvtSetup.RESET;
        InvtSetup.SETRANGE(InvtSetup."Primary Key", 'DEF');
        IF InvtSetup.FINDFIRST THEN
            EXIT(InvtSetup."Transfer Order Nos.");

        //EXIT(InvtSetup."Transfer Order Nos. (Captive)");
    end;

    local procedure GetInventorySetup()
    begin
        IF NOT HasInventorySetup THEN BEGIN
            InvtSetup.GET;
            HasInventorySetup := TRUE;
        END;
    end;
}

