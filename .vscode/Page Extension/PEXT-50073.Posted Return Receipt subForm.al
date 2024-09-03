pageextension 50073 "Posted Return Receipt Subform" extends "Posted Return Receipt Subform"
{
    layout
    {
        addafter("No.")
        {
            field("Eleva Product Serial No."; Rec."Eleva Product Serial No.")
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