table 50000 "Woo Commerce Line"
{

    fields
    {
        field(1; "Order ID"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2; id; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; product_id; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; variation_id; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; tax_class; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(8; subtotal; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; subtotal_tax; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; total; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; total_tax; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; initial_price; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; discounted_price; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; set_discount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; bulk_discount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; discount_type; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(17; discount_value; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; discount_quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; discount_price_per_quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20; discount_price; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(21; cart_quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(23; sku; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(24; price; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Shipping method_title"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Shipping method_id"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Shipping instance_id"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Shipping total"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Shipping total_tax"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(30; order_key; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(31; LineNo; Integer)
        {
            AutoIncrement = true;
        }
        field(32; "Navision Order No"; Code[20])
        {
        }
        field(33; "Navision Remarks"; Text[250])
        {
        }
        field(34; _billing_store_code; Code[20])
        {
            Description = 'KPPL LM';
        }
        field(35; _delivery_time; Text[30])
        {
            Description = 'KPPL LM';
        }
        field(36; _expected_delivery_time; DateTime)
        {
        }
        field(37; _is_lob; Boolean)
        {
        }
        field(50000; "CRT Coupon Code"; Code[20])
        {
            Description = 'KPPLDG00042';
        }
    }

    keys
    {
        key(Key1; order_key, LineNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

