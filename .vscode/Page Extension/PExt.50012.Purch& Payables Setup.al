pageextension 50012 "Purchases & Payables Setup" extends "Purchases & Payables Setup"
{
    layout
    {
        modify("Allow Document Deletion Before")
        {
            Visible = false;
        }
        addafter("Default Qty. to Receive")
        {
            field("Buyback Vendor"; Rec."Buyback Vendor")
            {
                ApplicationArea = all;

            }
            field("Maximum Invoice Diff. Allowed"; Rec."Maximum Invoice Diff. Allowed")
            {

                ApplicationArea = all;
            }
            field("Sender Mail ID( Maple)"; Rec."Sender Mail ID( Maple)")
            {
                ApplicationArea = all;
            }
            field("PDF Path"; Rec."PDF Path")
            {
                ApplicationArea = all;
            }
            field("In-Gram Show Json"; Rec."In-Gram Show Json")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the In-Gram Show Json field.';
            }
        }
    }

    actions
    {

    }

    var
        myInt: Integer;
}