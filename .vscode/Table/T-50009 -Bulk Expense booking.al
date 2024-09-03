table 50009 "Bulk Expense booking"
{

    fields
    {
        field(1; "Vendor No."; Code[20])
        {

            trigger OnValidate()
            begin
                IF recvend.GET("Vendor No.") THEN
                    VendorName := recvend.Name;
            end;
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
        field(27; "Invoice  Created"; Boolean)
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
        }
        field(36; "TDS Nature of Deduction"; Code[10])
        {
            // TableRelation = "TDS Nature of Deduction";

            trigger OnValidate()
            var
                Vend: Record Vendor;
            begin
            end;
        }
        field(37; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(38; Expense; Boolean)
        {
        }
        field(39; "Invoice Uploaded"; Boolean)
        {
        }
        field(40; "Vendor Invoice Date"; Date)
        {
        }
        field(41; Comments; Text[80])
        {
        }
        field(42; "Vendor Invoice Value"; Decimal)
        {
        }
        field(43; "GST Credit"; Option) //TK
        {
            OptionCaption = ' ,Availment,Non-Availment';
            OptionMembers = " ","Availment","Non-Availment";
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Document Type" := "Document Type"::Invoice;
        Type := Type::"G/L Account";
    end;

    var
        recvend: Record Vendor;
}

