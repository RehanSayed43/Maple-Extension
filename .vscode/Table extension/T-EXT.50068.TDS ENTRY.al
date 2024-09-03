tableextension 50068 "CCIT TDS Entry" extends "TDS Entry"
{
    fields
    {
        // Add changes to table fields here
        modify("Assessee Code")
        {
            TableRelation = "Assessee Code";
        }
    }

    var
        myInt: Integer;
}