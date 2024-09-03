Table 50033 "Maple MOTO Integration"
{
    // KPPLRJ1.00 01.02.22 : Added New Field for Error Handling
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
            Enabled = false;
        }
        field(3; number; Code[50])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(5; status; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; created_via; Text[30])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(7; currency; Code[10])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(8; date_created; DateTime)
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(9; date_modified; DateTime)
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(10; discount_total; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(11; discount_tax; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(12; shipping_totals; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(13; shipping_tax; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(14; cart_tax; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(17; prices_include_tax; Boolean)
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(18; customer_id; Code[20])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(19; "Bill To first_name"; Text[250])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(20; "Bill To last_name"; Text[250])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(21; "Bill To company"; Text[250])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(22; "Bill To address_1"; Text[250])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(23; "Bill To address_2"; Text[250])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(24; "Bill To city"; Text[100])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(25; "Bill To state"; Text[10])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(26; "Bill To postcode"; Code[10])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(27; "Bill To country"; Code[10])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(28; email; Text[50])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(29; phone; Code[15])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(30; "Ship To first_name"; Text[250])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(31; "Ship To last_name"; Text[250])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(32; "Ship To company"; Text[250])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(33; "Ship To address_1"; Text[200])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(34; "Ship To address_2"; Text[200])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(35; "Ship To city"; Text[100])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(36; "Ship To state"; Text[10])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(37; "Ship To postcode"; Code[10])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(38; "Ship To country"; Code[10])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(39; payment_method; Code[20])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(40; payment_method_title; Code[80])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(41; transaction_id; Code[50])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(42; cart_hash; Code[50])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(43; _alg_wc_custom_order_number; Code[50])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(44; _billing_order_notes; Text[100])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(45; _billing_type_of_delivery; Code[30])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(46; _billing_pickup_store; Code[20])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(47; _billing_gst; Code[20])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(48; _billing_store_reference; Code[50])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(49; _shipping_phone; Code[20])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(50; _shipping_email; Text[80])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(51; is_vat_exempt; Text[30])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(52; "Navision Order No"; Code[20])
        {
        }
        field(53; _billing_delivery_time; Text[30])
        {
            Enabled = false;
        }
        field(54; _billing_store_code; Text[30])
        {
            Enabled = false;
        }
        field(55; Processed; Boolean)
        {
            Enabled = false;
        }
        field(50000; "Is Error"; Boolean)
        {
            Description = 'KPPLRJ1.00';
            Enabled = false;
        }
        field(50001; order_number; Text[50])
        {
        }
        field(50002; order_date; Text[50])
        {
        }
        field(50003; order_type; Text[50])
        {
        }
        field(50004; ship_by_date; Text[50])
        {
        }
        field(50005; child_courier; Text[50])
        {
        }
        field(50006; invoice_number; Text[50])
        {
        }
        field(50008; invoice_url; Text[50])
        {
        }
        field(50009; "Order ID"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; name1; Text[100])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(50012; product_id; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50013; variation_id; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; quantity11; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; tax_class; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50016; subtotal; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50017; subtotal_tax; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50018; total; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; total_tax; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50020; initial_price; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50021; discounted_price; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50022; set_discount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50023; bulk_discount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50024; discount_type; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50025; discount_value; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50026; discount_quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50027; discount_price_per_quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50028; discount_price; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50029; cart_quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50030; sku; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50031; price; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50032; "Shipping method_title"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50033; "Shipping method_id"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50034; "Shipping instance_id"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50035; "Shipping total"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50036; "Shipping total_tax"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50039; order_key; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50040; LineNo; Integer)
        {
            AutoIncrement = true;
        }
        field(50042; "Navision Remarks"; Text[250])
        {
        }
        field(50044; _delivery_time; Text[30])
        {
            Description = 'KPPL LM';
        }
        field(50045; _expected_delivery_time; DateTime)
        {
        }
        field(50046; _is_lob; Boolean)
        {
        }
        field(50047; "CRT Coupon Code"; Code[20])
        {
            Description = 'KPPLDG00042';
        }
        field(50048; product_sku; Text[50])
        {
        }
        field(50049; quantity; Integer)
        {
        }
        field(50050; payment_mode; Text[30])
        {
        }
        field(50051; total_price; Decimal)
        {
        }
        field(50052; cod_amount; Decimal)
        {
        }
        field(50053; discount; Decimal)
        {
        }
        field(50054; mrp; Decimal)
        {
        }
        field(50055; advance_payment; Decimal)
        {
        }
        field(50056; round_off; Decimal)
        {
        }
        field(50058; cgst_percentage; Decimal)
        {
        }
        field(50059; cgst_amount; Decimal)
        {
        }
        field(50060; sgst_percentage; Decimal)
        {
        }
        field(50061; sgst_amount; Decimal)
        {
        }
        field(50062; igst_percentage; Decimal)
        {
        }
        field(50063; igst_amount; Decimal)
        {
        }
        field(50064; tan_number; Integer)
        {
        }
        field(50065; vat_number; Integer)
        {
        }
        field(50066; cst_number; Integer)
        {
        }
        field(50067; name; Text[30])
        {
        }
        field(50068; address_line1; Text[250])
        {
        }
        field(50069; pin_code; Text[30])
        {
        }
        field(50070; city; Text[30])
        {
        }
        field(50071; state; Text[30])
        {
        }
        field(50072; country; Text[30])
        {
        }
        field(50073; primary_phone_number; Text[30])
        {
        }
        field(50074; Payment_mode_1; Text[30])
        {
        }
        field(50075; primary_email_id; Text[100])
        {
        }
        field(50076; Status_Ret; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; id)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

