pageextension 50010 "TDS Setup" extends "TDS Setup"
{
    layout
    {
        addbefore("Tax Type")
        {
            field("Calc.Over&Above Threshold"; rec."Calc.Over&Above Threshold")
            {
                ApplicationArea = All;
            }

        }
    }

    actions
    {

    }

    var
        myInt: Integer;
}