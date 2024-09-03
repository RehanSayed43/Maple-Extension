pageextension 50085 "Transfer Order Subform" extends "Transfer Order Subform"
{
    layout

    {
        addbefore("Shipping Agent Code")
        {

            field("UPN Code"; rec."UPN Code")
            {
                ApplicationArea = all;
                Style = Strong;
                StyleExpr = TRUE;
            }
            field("Primary category"; Rec."Primary category")
            {
                Editable = false;
                ApplicationArea = all;
            }
            field("Secondary category"; Rec."Secondary category")
            {
                Editable = false;
                ApplicationArea = all;
            }
            field("Third category"; Rec."Third category")
            {
                Editable = false;
                ApplicationArea = all;

            }
            field("Quantity Transfered"; Rec."Quantity Transfered")
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