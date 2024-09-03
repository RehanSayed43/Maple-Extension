table 50102 "Bundle Item Line"
{
    Caption = 'Bundle Item Line';
    DataCaptionFields = "Bundle Code", "Line No.";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Bundle Code"; Code[20])
        {
            Caption = 'Bundle Code';
            TableRelation = "Bundle Items";
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            AutoIncrement = true;
            DataClassification = CustomerContent;
        }
        field(3; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item."No." where(Blocked = const(false));
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                Item: Record Item;
            begin
                if Item.Get(Rec."Item No.") then
                    Rec."Item Description" := Item.Description;
            end;
        }
        field(4; "Item Description"; Text[100])
        {
            Caption = 'Item Description';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(6; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Unit of Measure";
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(7; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code where("Item No." = field("Item No."));
            DataClassification = CustomerContent;
        }
        field(5; "Minimum Quantity"; Decimal)
        {
            Caption = 'Minimum Quantity';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(8; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            AutoFormatType = 2;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(9; "Line Discount"; Decimal)
        {
            Caption = 'Line Discount %';
            AutoFormatType = 2;
            MaxValue = 100;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(10; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = CustomerContent;
        }
        field(11; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                Rec.TestField("Item No.");
                if Rec."Starting Date" = 0D then
                    Error('Start Date should not be blank');
                if Rec."Starting Date" > Rec."Ending Date" then
                    Error('Start Date should be less than Ending Date');
            end;
        }
        field(12; "Create By"; Code[50])
        {
            Caption = 'Create By';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13; "Created Date"; Date)
        {
            Caption = 'Created Date';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(14; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(15; "Modified Date"; Date)
        {
            Caption = 'Modified Date';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16; "Discount Entry No."; Integer)
        {
            Caption = 'Discount Entry No.';
            TableRelation = Discounting."Entry No" where("Active/Inactive" = const(false));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                Discounting: Record Discounting;
            begin
                Discounting.Reset();
                Discounting.SetRange("Entry No", Rec."Discount Entry No.");
                if Discounting.FindFirst() then begin
                    Rec."Discount Type" := Discounting."Discount Type";
                    Rec."Line Discount" := Discounting."Discount %";
                end;
            end;
        }
        field(17; "Discount Type"; Code[20])
        {
            Caption = 'Discount Type';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(18; "Line Discount Amount"; Decimal)
        {
            Caption = 'Line Discount Amount';
            AutoFormatType = 2;

            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Bundle Code", "Line No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        Rec."Create By" := UserId;
        Rec."Created Date" := Today;
    end;

    trigger OnModify()
    begin
        Rec."Modified By" := UserId;
        Rec."Modified Date" := Today;
    end;
}
