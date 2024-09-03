table 50020 "FIFO Tracking Details"
{

    fields
    {
        field(1; Type; Option)
        {
            OptionMembers = " ",Sales," Transfer"," Journal ";
        }
        field(2; "Document No."; Code[20])
        {
        }
        field(3; "Item No."; Code[20])
        {
        }
        field(4; "FIFO Serial No."; Code[30])
        {
        }
        field(5; "Serial Date"; Date)
        {
        }
        field(6; Quantity; Decimal)
        {
        }
        field(7; "Selected Serial"; Code[30])
        {
        }
        field(8; "Selection Date"; Date)
        {
        }
        field(9; "Selection Time"; Time)
        {
        }
        field(10; "User ID"; Code[100])
        {
        }
        field(11; "Line No."; Integer)
        {
        }
    }

    keys
    {
        key(Key1; Type, "Document No.", "Item No.", "FIFO Serial No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

