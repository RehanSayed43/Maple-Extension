tableextension 50061 "Purch Rcpt Header Table" extends "Purch. Rcpt. Header"
{
    fields
    {
        field(50050; "Import Document No."; Code[30])
        {
        }
        field(50054; "Refreance No."; Code[20])
        {
        }
        field(50055; "WMS Process"; Boolean)
        {
            Description = 'KPPLDG00017';
        }
    }
}
