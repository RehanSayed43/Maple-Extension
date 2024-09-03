table 50001 "Scheme Details"
{

    fields
    {
        field(1; "Scheme Code"; Code[10])
        {
        }
        field(3; "Document Date"; Date)
        {
        }
        field(4; "Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category";
        }
        field(5; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            TableRelation = "Product Group New".Code WHERE("Item Category Code" = FIELD("Item Category Code"));
        }
        field(6; "Starting Date"; Date)
        {
            NotBlank = false;
        }
        field(7; "Ending Date"; Date)
        {
            NotBlank = false;
        }
        field(8; Descritpion; Text[50])
        {
        }
        field(9; ItemNo; Code[20])
        {
        }
        field(10; "Sch Disc %"; Decimal)
        {
            DecimalPlaces = 2 : 2;

            trigger OnValidate()
            begin
                IF "Sch Disc %" <> 0 THEN
                    "Sch Disc Amt" := 0;
            end;
        }
        field(11; "Sch Disc Amt"; Decimal)
        {

            trigger OnValidate()
            begin
                IF "Sch Disc Amt" <> 0 THEN
                    "Sch Disc %" := 0;
            end;
        }
        field(12; "Claim Disc %"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(13; "Claim Amt"; Decimal)
        {
        }
        field(14; "Enable Scheme"; Boolean)
        {
        }
        field(15; Vendor; Code[20])
        {
        }
        field(16; Open; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Scheme Code", ItemNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

