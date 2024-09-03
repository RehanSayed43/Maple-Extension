tableextension 50011 "Company Information Table" extends "Company Information"
{
    fields
    {
        field(50000; "VAT Effective Dt"; Date)
        {
        }
        field(50001; "CST Effective Dt"; Date)
        {
        }
        field(50002; "Bank Code"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(50003; "CIN no"; Code[50])
        {
        }
        field(50004; "L.S.T. No."; Code[20])
        {
            Caption = 'L.S.T. No.';
        }
        field(50005; "C.S.T No."; Code[20])
        {
            Caption = 'C.S.T No.';
        }
        field(50006; "Ward No"; Text[30])
        {
            Caption = 'Ward No.';
        }
    }
}
