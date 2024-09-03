table 50151 TempPurchRegSerial
{
    Caption = 'TempPurchRegSerial';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            Caption = 'Entry No';
            AutoIncrement = true;
            DataClassification = CustomerContent;
        }
        field(2; "Purch Inv"; Code[20])
        {
            Caption = 'Purch Inv';
            DataClassification = CustomerContent;
        }
        field(3; "Purch Line"; Integer)
        {
            Caption = 'Purch Line';
            DataClassification = CustomerContent;
        }
        field(4; "Serial No"; Code[50])
        {
            Caption = 'Serial No';
            DataClassification = CustomerContent;
        }
        field(5; "IMEI No"; Code[20])
        {
            Caption = 'IMEI No';
            DataClassification = CustomerContent;
        }
        field(6; "Item Category Code"; Code[20])
        {
            Caption = 'Item Category Code';
            DataClassification = CustomerContent;
        }
        field(7; "Item Code"; Code[20])
        {
            Caption = 'Item Code';
            DataClassification = CustomerContent;
        }
        field(8; "VendorPartCode"; Code[50])
        {
            Caption = 'VendorPartCode';
            DataClassification = CustomerContent;
        }
        field(9; "Item Description"; Text[100])
        {
            Caption = 'Item Description';
            DataClassification = CustomerContent;
        }
        field(10; "Category"; Code[30])
        {
            Caption = 'Category';
            DataClassification = CustomerContent;
        }
        field(11; "Prime Category"; Code[20])
        {
            Caption = 'Prime Category';
            DataClassification = CustomerContent;
        }
        field(12; "Sec Category"; Code[20])
        {
            Caption = 'Prime Category';
            DataClassification = CustomerContent;
        }
        field(13; "Third Category"; Code[20])
        {
            Caption = 'Third Category';
            DataClassification = CustomerContent;
        }

    }
    keys
    {
        key(PK; "Entry No")
        {
            Clustered = true;
        }
    }
}
