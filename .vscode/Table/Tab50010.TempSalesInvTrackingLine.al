table 50010 TempSalesInvTrackingLine
{
    Caption = 'TempSalesInvTrackingLine';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            DataClassification = CustomerContent;
        }
        field(2; "Sales Invoice No."; Code[20])
        {
            Caption = 'Sales Invoice No.';
            DataClassification = CustomerContent;
        }
        field(3; "Sales Line"; Integer)
        {
            Caption = 'Sales Line';
            DataClassification = CustomerContent;
        }
        field(4; "Serial No."; Code[50])
        {
            Caption = 'Serial No.';
            DataClassification = CustomerContent;
        }
        field(5; "IMEI No"; Code[20])
        {
            Caption = 'IMEI No';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
