tableextension 50054 "Reservation Entry Table" extends "Reservation Entry"
{
    fields
    {
        field(50000; "IMEI No."; Code[20])
        {
        }
        field(50033; "MRP Value"; Decimal)
        {
            Description = 'CCIT-TK';
        }
        field(50036; "Auto Generated"; Boolean)
        {

        }
    }
}
