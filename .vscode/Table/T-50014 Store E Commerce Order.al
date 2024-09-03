table 50014 "Store E-Commerce Order"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
        }
        field(2; "Order ID"; Code[50])
        {
            Description = 'CAPILLARY';
        }
        field(3; "Order Date"; Date)
        {
        }
        field(4; "USER ID"; Code[20])
        {
        }
        field(6; "Total Amount"; Decimal)
        {
        }
        field(7; "Amount Payable"; Decimal)
        {
        }
        field(8; "Bill First Name"; Text[30])
        {
        }
        field(9; "Bill Country"; Code[20])
        {
        }
        field(10; "Bill State"; Code[20])
        {
        }
        field(11; "Bill CIty"; Code[20])
        {
        }
        field(12; "Bill Email"; Text[50])
        {
        }
        field(13; "Bill Zip"; Code[20])
        {
        }
        field(14; "Bill Phone No."; Text[30])
        {
        }
        field(15; "Bill to Address 1"; Text[50])
        {
        }
        field(16; "Bill to Address 2"; Text[50])
        {
        }
        field(17; "Ship First Name"; Text[30])
        {
        }
        field(18; "Ship Country"; Code[20])
        {
        }
        field(19; "Ship State"; Code[20])
        {
        }
        field(20; "Shipl CIty"; Code[20])
        {
        }
        field(21; "Ship Email"; Text[30])
        {
        }
        field(22; "Ship Zip"; Code[20])
        {
        }
        field(23; "Ship Phone No."; Text[30])
        {
        }
        field(24; "Ship to Address1"; Text[50])
        {
        }
        field(25; "Ship to Address2"; Text[50])
        {
        }
        field(26; "Delivery Option"; Option)
        {
            OptionMembers = " ",Ship;
        }
        field(27; "Tax Total"; Decimal)
        {
        }
        field(28; "Voucher Code"; Code[20])
        {
        }
        field(29; "Lead Time"; Time)
        {
        }
        field(30; "Is Gift"; Boolean)
        {
        }
        field(31; "Product ID"; Code[20])
        {
        }
        field(32; "Variant Code"; Code[20])
        {
        }
        field(33; "Is Parent Product"; Boolean)
        {
        }
        field(34; Description; Text[100])
        {
        }
        field(35; Quantity; Decimal)
        {
        }
        field(36; "Shipping Cost"; Decimal)
        {
        }
        field(37; "Product Price"; Decimal)
        {
        }
        field(38; "Total Pramotion Discount"; Decimal)
        {
        }
        field(39; "Return Reason"; Text[30])
        {
        }
        field(40; "Is Back Order"; Boolean)
        {
        }
        field(41; "Total Voucher Discount"; Decimal)
        {
        }
        field(42; "Total Tax Amount"; Decimal)
        {
        }
        field(43; "Shipping Vouchser Discount"; Decimal)
        {
        }
        field(44; "Location Code"; Code[20])
        {
            TableRelation = Location.Code;

            trigger OnValidate()
            begin
                IF "Location Code" <> '' THEN BEGIN
                    RecLocation.RESET;
                    RecLocation.SETRANGE(Code, "Location Code");
                    IF RecLocation.FINDFIRST THEN BEGIN
                        // RecLocation.TESTFIELD("E Com Location Code");
                        // "E Com Location Code" := RecLocation."E Com Location Code";
                        // "In Transit Location" := COPYSTR(RecLocation."E Com Location Code", 1, STRLEN(RecLocation."E Com Location Code") - 1) + '3';
                    END;
                END
                ELSE BEGIN
                    "E Com Location Code" := '';
                    "In Transit Location" := '';
                END;
            end;
        }
        field(45; "Category ID"; Code[10])
        {
        }
        field(46; "Category Name"; Text[30])
        {
        }
        field(47; "Cancle Quantity"; Decimal)
        {
        }
        field(48; "Order Line Id"; Code[20])
        {
        }
        field(49; "Item No"; Code[20])
        {
            TableRelation = Item."No.";
        }
        field(50; "Customer Created"; Boolean)
        {
        }
        field(51; "GST Registration No."; Code[20])
        {
        }
        field(52; "GST Customer Type"; Option)
        {
            Caption = 'GST Customer Type';
            OptionCaption = ' ,Registered,Unregistered,Export,Deemed Export,Exempted';
            OptionMembers = " ",Registered,Unregistered,Export,"Deemed Export",Exempted;

            trigger OnValidate()
            var
                GSTRegistrationNos: Record "GST Registration Nos.";
            begin
                /*IF "GST Customer Type" = "GST Customer Type"::" " THEN BEGIN
                  "GST Registration No." := '';
                  EXIT;
                END;
                //  TESTFIELD(Address);
                IF "GST Customer Type" = "GST Customer Type"::Registered THEN
                  TESTFIELD("GST Registration No.");
                IF "GST Customer Type" IN ["GST Customer Type"::Registered,"GST Customer Type"::Exempted,"GST Customer Type"::Unregistered] THEN
                  TESTFIELD("State Code")
                ELSE
                  IF "GST Customer Type" <>  "GST Customer Type"::"Deemed Export" THEN
                    TESTFIELD("State Code",'');
                IF NOT ("GST Customer Type" IN
                    ["GST Customer Type"::Registered,"GST Customer Type"::Exempted,"GST Customer Type"::"Deemed Export"]) THEN
                  "GST Registration No." := '';
                IF ("GST Registration Type" = "GST Registration Type"::GSTIN) AND ("GST Registration No." <> '') THEN BEGIN
                  TESTFIELD("State Code");
                  GSTRegistrationNos.CheckGSTRegistrationNo("State Code","GST Registration No.");
                END;
                */

            end;
        }
        field(53; "e-Commerce Operator"; Boolean)
        {
            Caption = 'e-Commerce Operator';
        }
        field(54; "Order Created"; Boolean)
        {
        }
        field(55; "Transfer Order Created"; Boolean)
        {
        }
        field(56; "Order Posted"; Boolean)
        {
        }
        field(57; "Transfer Order Posted"; Boolean)
        {
        }
        field(58; "Payment Created"; Boolean)
        {
        }
        field(59; "Payment Posted"; Boolean)
        {
        }
        field(60; "E Com Location Code"; Code[20])
        {
        }
        field(61; "In Transit Location"; Code[20])
        {
        }
        field(62; "Varient SKU"; Code[50])
        {

            trigger OnValidate()
            begin
                IF "Varient SKU" <> '' THEN BEGIN
                    RecITEM.RESET;
                    // RecITEM.SETRANGE("Ecommerce Item", TRUE);
                    // RecITEM.SETRANGE("Vendor Part Code Long", "Varient SKU");
                    // RecITEM.SETRANGE(SKU1, SKU1);
                    IF RecITEM.FINDFIRST THEN
                        "Item No" := RecITEM."No."
                    ELSE
                        ERROR('Item not exists, Vendor Part Code - %1, SKU- %2', "Varient SKU", SKU1)
                END
                ELSE
                    "Item No" := '';

                IF "Item No" = '' THEN
                    ERROR('Item No cannot be blank');
            end;
        }
        field(63; "Payment Type"; Code[20])
        {

            trigger OnValidate()
            begin
                IF "Payment Type" <> '' THEN BEGIN

                    IF "Payment Type" = 'BILLDESK' THEN
                        "G/L Account No" := '298027';

                    IF "Payment Type" = 'RAZORPAY' THEN
                        "G/L Account No" := '298028';

                END;
                IF "G/L Account No" = '' THEN
                    ERROR('Payment Type %1 doesnot exists', "Payment Type");
            end;
        }
        field(64; "G/L Account No"; Code[20])
        {
        }
        field(65; Status; Option)
        {
            OptionCaption = ' ,Return Order,Canceled Order';
            OptionMembers = " ","Return Order","Canceled Order";
        }
        field(66; "Return Order Posted"; Boolean)
        {
        }
        field(67; "Return Transfer Order Created"; Boolean)
        {
        }
        field(68; "Return Transfer Order Posted"; Boolean)
        {
        }
        field(69; "Skip Order"; Boolean)
        {
        }
        field(70; "User Created Order"; Boolean)
        {
        }
        field(71; "Return Order Created"; Boolean)
        {
        }
        field(72; "Return Payment Created"; Boolean)
        {
        }
        field(73; "Return Payment Posted"; Boolean)
        {
        }
        field(74; "Capillary Discount Amount"; Decimal)
        {
        }
        field(75; SKU1; Code[50])
        {
        }
    }

    keys
    {
        key(Key1; "Entry No", "Order ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        RecLocation: Record "Location";
        RecITEM: Record Item;
}

