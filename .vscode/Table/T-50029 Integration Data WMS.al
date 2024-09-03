table 50029 "Integration Data WMS"
{

    fields
    {
        field(1; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Transfer Receipts,Transfer Shipments,Purchase Receipts,Positive Adjustment,Negative Adjustment';
            OptionMembers = " ","Transfer Receipts","Transfer Shipments","Purchase Receipts","Positive Adjustment","Negative Adjustment";
        }
        field(2; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "From Location"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "To Location"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; UOM; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Serial No."; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(10; Posted; Boolean)
        {
            Description = 'KPPL';
        }
        field(11; "Posting Date Time"; DateTime)
        {
            Description = 'KPPL';
        }
        field(12; "Found Error"; Boolean)
        {
            Description = 'KPPL';
        }
        field(13; "Response Message"; Text[250])
        {
            Description = 'KPPL';
        }
        field(14; "Move to Posting"; Boolean)
        {
            Description = 'KPPL';
        }
        field(15; "NAV Posted No."; Code[20])
        {
            Description = 'KPPL';
        }
        field(16; "Sibling Error"; Boolean)
        {
            Description = 'KPPL';
        }
        field(17; "NAV Document No."; Code[20])
        {
            Description = 'KPPL';
        }
        field(18; "NAV Document Line No."; Integer)
        {
            Description = 'KPPL';
        }
        field(50; "Transfer Shipment No"; Code[20])
        {
        }
        field(51; "Navision Document No"; Code[20])
        {
        }
        field(52; Error1; Text[250])
        {
        }
        field(53; "Transfer Receipt No"; Code[20])
        {
        }
        field(54; "Purchase Receipt No"; Code[20])
        {
        }
        field(55; "Purchase Order No"; Code[20])
        {
        }
        field(56; "Negative Adjustment No"; Code[20])
        {
        }
        field(57; "Postive Adjustment No"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Document Type", "Document No.")
        {
        }
    }

    fieldgroups
    {
    }
}

