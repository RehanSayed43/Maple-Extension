table 50022 "WooCommerce Process Log"
{
    // KPPLRJ1.00 01.02.22 : Create New Table for Process Log


    fields
    {
        field(1; "Entry No."; Integer)
        {
        }
        field(2; "Process Name"; Text[50])
        {
        }
        field(3; "Start Date/Time"; DateTime)
        {
        }
        field(4; "End Date/Time"; DateTime)
        {
        }
        field(5; "User ID"; Code[50])
        {
        }
        field(6; "Error Description"; Text[250])
        {
        }
        field(7; "Order Key"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

