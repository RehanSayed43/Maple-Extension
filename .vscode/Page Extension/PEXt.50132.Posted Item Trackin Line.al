pageextension 50132 "Poted Item Tracking Line" extends "Posted Item Tracking Lines"
{
    layout
    {
        addafter("Serial No.")
        {
            field("IMEI No."; rec."IMEI No.")
            {
                ApplicationArea = ALL;
                Editable = FALSE;
            }
            field("MRP Value"; Rec."MRP Value")
            {
                ApplicationArea = ALL;
                Editable = FALSE;
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