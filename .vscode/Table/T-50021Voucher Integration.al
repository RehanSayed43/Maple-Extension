table 50021 "Voucher Integration"
{

    fields
    {
        field(1; "SO No."; Code[20])
        {
        }
        field(2; "Voucher Int. No.1"; Text[20])
        {
            Description = 'Voucher Integration';
        }
        field(3; "Voucher PIN1"; Text[10])
        {
            Description = 'Voucher Integration';
        }
        field(4; "Voucher Amount1"; Decimal)
        {
            Description = 'Voucher Integration';
        }
        field(5; "Voucher Int. No.2"; Text[20])
        {
            Description = 'Voucher Integration';
        }
        field(6; "Voucher PIN2"; Text[10])
        {
            Description = 'Voucher Integration';
        }
        field(7; "Voucher Amount2"; Decimal)
        {
            Description = 'Voucher Integration';
        }
        field(8; "Voucher Int. No.3"; Text[20])
        {
            Description = 'Voucher Integration';
        }
        field(9; "Voucher PIN3"; Text[10])
        {
            Description = 'Voucher Integration';
        }
        field(10; "Voucher Amount3"; Decimal)
        {
            Description = 'Voucher Integration';
        }
        field(11; "Voucher Int. No.4"; Text[20])
        {
            Description = 'Voucher Integration';
        }
        field(12; "Voucher PIN4"; Text[10])
        {
            Description = 'Voucher Integration';
        }
        field(13; "Voucher Amount4"; Decimal)
        {
            Description = 'Voucher Integration';
        }
        field(14; "Voucher Int. No.5"; Text[20])
        {
            Description = 'Voucher Integration';
        }
        field(15; "Voucher PIN5"; Text[10])
        {
            Description = 'Voucher Integration';
        }
        field(16; "Voucher Amount5"; Decimal)
        {
            Description = 'Voucher Integration';
        }
        field(17; "Voucher Int. No.6"; Text[20])
        {
            Description = 'Voucher Integration';
        }
        field(18; "Voucher PIN6"; Text[10])
        {
            Description = 'Voucher Integration';
        }
        field(19; "Voucher Amount6"; Decimal)
        {
            Description = 'Voucher Integration';
        }
        field(20; "Voucher Int. No.7"; Text[20])
        {
            Description = 'Voucher Integration';
        }
        field(21; "Voucher PIN7"; Text[10])
        {
            Description = 'Voucher Integration';
        }
        field(22; "Voucher Amount7"; Decimal)
        {
            Description = 'Voucher Integration';
        }
        field(23; "Voucher Int. No.8"; Text[20])
        {
            Description = 'Voucher Integration';
        }
        field(24; "Voucher PIN8"; Text[10])
        {
            Description = 'Voucher Integration';
        }
        field(25; "Voucher Amount8"; Decimal)
        {
            Description = 'Voucher Integration';
        }
        field(26; "Voucher Int. No.9"; Text[20])
        {
            Description = 'Voucher Integration';
        }
        field(27; "Voucher PIN9"; Text[10])
        {
            Description = 'Voucher Integration';
        }
        field(28; "Voucher Amount9"; Decimal)
        {
            Description = 'Voucher Integration';
        }
        field(29; "Voucher Int. No.10"; Text[20])
        {
            Description = 'Voucher Integration';
        }
        field(30; "Voucher PIN10"; Text[10])
        {
            Description = 'Voucher Integration';
        }
        field(31; "Voucher Amount10"; Decimal)
        {
            Description = 'Voucher Integration';
        }
        field(32; Cancel1; Boolean)
        {
        }
        field(33; Cancel2; Boolean)
        {
        }
        field(34; Cancel3; Boolean)
        {
        }
        field(35; Cancel4; Boolean)
        {
        }
        field(36; Cancel5; Boolean)
        {
        }
        field(37; Cancel6; Boolean)
        {
        }
        field(38; Cancel7; Boolean)
        {
        }
        field(39; Cancel8; Boolean)
        {
        }
        field(40; Cancel9; Boolean)
        {
        }
        field(41; Cancel10; Boolean)
        {
        }
        field(42; Refund1; Boolean)
        {
        }
        field(43; Refund2; Boolean)
        {
        }
        field(44; Refund3; Boolean)
        {
        }
        field(45; Refund4; Boolean)
        {
        }
        field(46; Refund5; Boolean)
        {
        }
        field(47; Refund6; Boolean)
        {
        }
        field(48; Refund7; Boolean)
        {
        }
        field(49; Refund8; Boolean)
        {
        }
        field(50; Refund9; Boolean)
        {
        }
        field(51; Refund10; Boolean)
        {
        }
        field(52; "Posted Inoice No."; Code[20])
        {
            CalcFormula = Lookup("Sales Invoice Header"."No." WHERE("Order No." = FIELD("SO No.")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "SO No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

