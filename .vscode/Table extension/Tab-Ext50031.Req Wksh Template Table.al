tableextension 50031 "Req. Wksh. Template Table" extends "Req. Wksh. Template"
{
    fields
    {
        field(50000; USERID; Code[50])
        {
            TableRelation = "User Setup";
        }
    }
}
