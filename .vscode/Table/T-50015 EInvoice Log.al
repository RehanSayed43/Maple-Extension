table 50015 "E-Invoice Log"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "IRN No."; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Signed Invoice"; BLOB)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Signed QR Code"; BLOB)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Ack No"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(7; AckDate; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Inv Transaction"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Generate IRN",Cancelled,"Get Details","Generate E-Way Bill";
        }
        field(9; "E-Invoice Cancel Date"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Document Type"; Option)
        {
            Caption = 'Document Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(12; "E-Way bill No"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Eway bill Date"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(14; BitmapIma; BLOB)
        {
            SubType = Bitmap;
        }
        field(15; "Vouchr. Integration"; Boolean)
        {
        }
        field(16; "Vouchr. Authorization ID"; Text[50])
        {
        }
        field(17; "Vochr.Authorization Amount"; Decimal)
        {
        }
        field(18; "Vouchr.Redeem Date"; DateTime)
        {
        }
        field(19; "Vouchr. Code"; Text[30])
        {
        }
        field(20; "Vouchr. Pin"; Text[30])
        {
        }
        field(21; "Vochr.Acceptance Ref."; Text[50])
        {
        }
        field(22; "Vouchr. Capture id"; Text[50])
        {
        }
        field(23; "Vouchr. Cap Amt"; Decimal)
        {
        }
        field(24; "Refund ID"; Text[50])
        {
        }
        field(25; "Refund Amount"; Decimal)
        {
        }
        field(26; "Transaction Time"; DateTime)
        {
        }
        field(27; "Cancellation ID"; Text[50])
        {
        }
        field(28; "Cancellation Amount"; Decimal)
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

