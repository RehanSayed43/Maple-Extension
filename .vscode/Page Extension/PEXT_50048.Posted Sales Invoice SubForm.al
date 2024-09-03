pageextension 50048 "Posted Sales Invoice Subform" extends "Posted Sales Invoice Subform"
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