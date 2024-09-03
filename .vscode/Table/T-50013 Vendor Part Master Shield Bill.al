table 50013 "Vendor Part Master Shield Bill"
{

    fields
    {
        field(1; "Vendor Part Code"; Code[20])
        {
        }
        field(2; "Shield Plus"; Boolean)
        {
        }
        field(3; "Shield EXT PAD/PHO"; Boolean)
        {
        }
        field(4; "Shield+Ex PAD/PHO"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Vendor Part Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

