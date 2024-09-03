pageextension 50119 Vendor extends "Vendor Card"
{
    layout
    {
        addafter(Transporter)
        {
            field("Branch Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = all;
            }
            field("Apple Distributor"; Rec."Apple Distributor")
            {
                ApplicationArea = all;
            }
            field("Scheme Provisional A/C"; Rec."Scheme Provisional A/C")
            {
                ApplicationArea = all;
            }
            field(Status; Rec.Status)
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