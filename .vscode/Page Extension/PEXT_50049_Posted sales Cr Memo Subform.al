pageextension 50049 "Posted Sales Cr. Memo Subform" extends "Posted Sales Cr. Memo Subform"
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