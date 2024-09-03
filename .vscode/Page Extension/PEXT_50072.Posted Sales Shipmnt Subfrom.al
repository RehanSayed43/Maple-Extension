pageextension 50072 "Posted Sales Shpt. Subform" extends "Posted Sales Shpt. Subform"
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