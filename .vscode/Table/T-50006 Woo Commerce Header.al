table 50006 "WooCommerce Header"
{
    // KPPLRJ1.00 24.02.22 : Added New Field for Error Handling
    //   # 50000 Is Error


    fields
    {
        field(1; id; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2; parent_id; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; number; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; order_key; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; status; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(6; created_via; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(7; currency; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(8; date_created; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(9; date_modified; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(10; discount_total; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; discount_tax; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; shipping_total; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; shipping_tax; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; cart_tax; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; total; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; total_tax; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; prices_include_tax; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(18; customer_id; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Bill To first_name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Bill To last_name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Bill To company"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Bill To address_1"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Bill To address_2"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Bill To city"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Bill To state"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Bill To postcode"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Bill To country"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(28; email; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(29; phone; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Ship To first_name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Ship To last_name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Ship To company"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Ship To address_1"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Ship To address_2"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Ship To city"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Ship To state"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Ship To postcode"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Ship To country"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(39; payment_method; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(40; payment_method_title; Code[80])
        {
            DataClassification = ToBeClassified;
        }
        field(41; transaction_id; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(42; cart_hash; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(43; _alg_wc_custom_order_number; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(44; _billing_order_notes; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(45; _billing_type_of_delivery; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(46; _billing_pickup_store; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(47; _billing_gst; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(48; _billing_store_reference; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(49; _shipping_phone; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50; _shipping_email; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(51; is_vat_exempt; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(52; "Navision Order No"; Code[20])
        {
        }
        field(53; _billing_delivery_time; Text[30])
        {
        }
        field(54; _billing_store_code; Text[30])
        {
        }
        field(55; Processed; Boolean)
        {
        }
        field(50000; "Is Error"; Boolean)
        {
            Description = 'KPPLRJ1.00';
        }
    }

    keys
    {
        key(Key1; order_key)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

