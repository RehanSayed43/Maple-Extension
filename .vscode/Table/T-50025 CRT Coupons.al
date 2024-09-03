table 50025 "CRT Coupons"
{

    fields
    {
        field(1; "Coupon Code"; Code[20])
        {
        }
        field(2; Phone; Text[11])
        {
        }
        field(3; Email; Text[100])
        {
        }
        field(4; "Item No."; Code[20])
        {
        }
        field(5; "Coupon Generate Date"; Date)
        {
        }
        field(6; "Coupon Expiry Date"; Date)
        {
        }
        field(7; "Verification ID"; Code[10])
        {
        }
        field(8; "Item Description"; Text[50])
        {
        }
        field(9; "Verified By"; Code[50])
        {
            TableRelation = User;
        }
        field(10; "Verified DateTime"; DateTime)
        {
        }
        field(37; crt_institute_address; Text[100])
        {
            Description = '//KPPL-UC';
        }
        field(38; crt_institute_city; Text[30])
        {
            Description = '//Kppl-UC';
        }
        field(39; crt_institute_zipcode; Code[10])
        {
            Description = '//KPPL-UC';
        }
    }

    keys
    {
        key(Key1; "Coupon Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

