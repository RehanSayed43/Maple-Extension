tableextension 50003 "Item Ledger Entry Table" extends "Item Ledger Entry"
{
    fields
    {
        field(50000; "IMEI No."; Code[20])
        {
        }
        field(50001; "Primary category"; Code[20])
        {
            TableRelation = "Standard Text" WHERE("Category Type" = CONST(Primary));
        }
        field(50002; "Secondary category"; Code[20])
        {
            TableRelation = "Standard Text" WHERE("Category Type" = CONST(Secondary));
        }
        field(50003; "Third category"; Code[20])
        {
            TableRelation = "Standard Text" WHERE("Category Type" = CONST(Third));
        }
        field(50004; "UPN Code"; Code[20])
        {
        }
        field(50008; "Scheme Code"; Code[10])
        {
        }
        field(50009; "Scheme Amount"; Decimal)
        {
        }
        field(50010; HistoryData; Boolean)
        {
        }
        field(50011; "Sales Point"; Decimal)
        {
        }
        field(50033; "MRP Value"; Decimal)
        {
            Description = 'CCIT-TK';
        }
        field(50034; "New External Document No "; Code[35])
        {
            Caption = 'New External Document No.';
        }
        field(50036; "Auto Generated"; Boolean)
        {

        }
    }
}
