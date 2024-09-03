tableextension 50043 "Value Entry Table" extends "Value Entry"
{
    fields
    {
        field(50002; "Primary category"; Code[20])
        {
            TableRelation = "Standard Text" WHERE("Category Type" = CONST(Primary));
        }
        field(50003; "Secondary category"; Code[20])
        {
            TableRelation = "Standard Text" WHERE("Category Type" = CONST(Secondary));
        }
        field(50004; "Third category"; Code[20])
        {
            TableRelation = "Standard Text" WHERE("Category Type" = CONST(Third));
        }
        field(50008; "Scheme Code"; Code[10])
        {
        }
        field(50009; "Scheme Amount"; Decimal)
        {
        }
        field(50034; "New External Document No "; Code[35])
        {
            Caption = 'New External Document No.';
        }
    }
}
