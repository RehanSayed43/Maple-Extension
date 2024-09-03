tableextension 50006 "Gen Journal Batch Table" extends "Gen. Journal Batch"
{
    fields
    {
        field(50000; "Approver ID"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
    }
}
