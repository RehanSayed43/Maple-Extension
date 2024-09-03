table 50017 "CRM Integration Purchase"
{

    fields
    {
        field(1; "Vendor No."; Code[20])
        {
        }
        field(2; VendorName; Text[60])
        {
        }
        field(3; VendorAddress; Text[60])
        {
        }
        field(4; City; Code[20])
        {
        }
        field(5; "State Code"; Code[20])
        {
        }
        field(6; "Mobile No."; Text[30])
        {
        }
        field(7; "Vendor Invoice No"; Code[20])
        {
        }
        field(8; "GST Registration No."; Code[15])
        {
        }
        field(9; "GST Vendor Type"; Option)
        {
            Caption = 'GST Vendor Type';
            OptionCaption = ' ,Registered,Composite,Unregistered,Import,Exempted';
            OptionMembers = " ",Registered,Composite,Unregistered,Import,Exempted;
        }
        field(10; "Document Type"; Option)
        {
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(11; "Posting Date"; Date)
        {
        }
        field(14; Structure; Code[20])
        {
        }
        field(15; "CRM invoice No"; Code[20])
        {
        }
        field(16; "Invocie No to Apply"; Code[20])
        {
        }
        field(17; "Location Code"; Code[20])
        {
        }
        field(18; Type; Option)
        {
            OptionMembers = " ","G/L Account",Item,,"Fixed Asset","Charge (Item)";
        }
        field(19; "Vendor Part Code"; Code[20])
        {
        }
        field(20; "No."; Code[20])
        {
        }
        field(21; Quantity; Decimal)
        {
        }
        field(22; "Unit Price With Tax"; Decimal)
        {
        }
        field(23; "GST Group Code"; Code[20])
        {
        }
        field(24; "GST Group Type"; Option)
        {
            OptionMembers = Goods,Service;
        }
        field(25; "HSN/SAC Code"; Code[20])
        {
        }
        field(26; "Vendor Created"; Boolean)
        {
        }
        field(27; "Order Created"; Boolean)
        {
        }
        field(28; "Order Posted"; Boolean)
        {
        }
        field(29; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
            end;
        }
        field(30; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
            end;
        }
        field(31; "Apply to Document Type"; Option)
        {
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(32; "Applies-to Doc. No."; Code[20])
        {
        }
        field(33; "Vendor Cr. Memo No."; Code[20])
        {
        }
        field(34; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(35; Comment; Text[80])
        {
        }
        field(36; "TDS Nature of Deduction"; Code[10])
        {
            Description = 'WIN316';
            TableRelation = "TDS Section";

            trigger OnValidate()
            var
                Vend: Record Vendor;
            begin
            end;
        }

        field(37; "GST Credit"; Option) //kj
        {
            OptionCaption = ' ,Availment,Non-Availment';
            OptionMembers = " ","Availment","Non-Availment";
        }
    }

    keys
    {
        key(Key1; "Vendor No.", "Vendor Invoice No", "Vendor Part Code", "No.", "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

