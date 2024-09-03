tableextension 50038 "Ship To Address Table" extends "Ship-to Address"
{
    fields
    {
        field(50001; "L.S.T. No."; Code[20])
        {
            Caption = 'L.S.T. No.';
        }
        field(50002; "C.S.T. No."; Code[20])
        {
            Caption = 'C.S.T. No.';
        }
        field(50111; "T.I.N. No."; Code[20])
        {
        }
        field(50112; "Address 3"; Text[50])
        {
        }
    }
}
