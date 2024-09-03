pageextension 50122 "Company Information" extends "Company Information"
{
    layout
    {
        addafter("State Code")
        {
            field("VAT Effective Dt"; Rec."VAT Effective Dt")
            {
                ApplicationArea = all;
            }
            field("CST Effective Dt"; Rec."CST Effective Dt")
            {
                ApplicationArea = all;
            }
            field("CIN no"; Rec."CIN no")
            {
                ApplicationArea = all;
            }
            field("Ward No"; Rec."Ward No")
            {
                ApplicationArea = all;
                Caption = 'Ward No.';
            }
        }
        addafter("Allow Blank Payment Info.")
        {
            field("Bank Code"; Rec."Bank Code")
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