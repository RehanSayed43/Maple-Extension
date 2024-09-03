pageextension 50089 "Posted Transfer Receipt" extends "Posted Transfer Receipt"
{
    layout
    {
        addafter("Posting Date")
        {
            field("Handover To Name"; Rec."Handover To Name")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}