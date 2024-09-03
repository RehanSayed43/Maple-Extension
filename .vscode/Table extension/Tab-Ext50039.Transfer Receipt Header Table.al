tableextension 50039 "Transfer Receipt Header Table" extends "Transfer Receipt Header"
{
    fields
    {
        field(50000; "Rental Sales Invoice No."; Code[20])
        {
        }
        field(50001; "F Form No."; Code[10])
        {
            Description = 'Added for F Form';
        }
        field(50010; "ECom Order ID"; Code[20])
        {
            Editable = false;
        }
        field(50011; "Shipped By User ID"; Code[50])
        {
            Description = 'WIN316';
            Editable = false;
        }
        field(50012; "Received By User ID"; Code[50])
        {
            Description = 'WIN316';
            Editable = false;
        }
        field(50013; "Refreance No."; Code[20])
        {
            Description = 'KPPLDG00017';
        }
        field(50014; "WMS Process"; Boolean)
        {
            Description = 'KPPLDG00017';
        }
        field(50015; "Handover To Name"; Text[100])
        {
        }
    }
}
