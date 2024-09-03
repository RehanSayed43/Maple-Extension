table 50019 "Location Wise Inventory"
{

    fields
    {
        field(1; "Line No"; Integer)
        {
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                /*//Updated WIN347
                IF "No." <> xRec."No." THEN BEGIN
                  GetInvtSetup;
                  NoSeriesMgt.TestManual(InvtSetup."Item Nos.");
                  "No. Series" := '';
                END;
                */

            end;
        }
        field(3; SKU1; Code[50])
        {
        }
        field(4; "Vendor Part Code Long"; Code[50])
        {
        }
        field(5; Location; Code[10])
        {
        }
        field(6; "Previous Inventory"; Decimal)
        {
        }
        field(7; "Current Inventory"; Decimal)
        {
        }
        field(8; "Change in Inventory"; Decimal)
        {
            Caption = 'Change in Inventory';
            DecimalPlaces = 0 : 5;
        }
        field(9; Date; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Line No")
        {
            Clustered = true;
        }
        key(Key2; "No.")
        {
        }
    }

    fieldgroups
    {
    }
}

