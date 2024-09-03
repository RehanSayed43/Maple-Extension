pageextension 50033 "Sales Invoice Subform" extends "Sales Invoice Subform"
{
    layout
    {
        addafter("No.")
        {
            field(SKU1; Rec.SKU1)
            {
                ApplicationArea = all;
            }
            field("Eleva Product Serial No."; Rec."Eleva Product Serial No.")
            {
                ApplicationArea = all;
                Editable = true;
            }
            field(Shield; Rec.Shield)
            {
                ApplicationArea = all;
            }
            field("shield Due Date"; Rec."shield Due Date")
            {
                ApplicationArea = all;
            }
            field("Free Item"; Rec."Free Item")
            {
                ApplicationArea = all;
            }
            field("Free Item Pend_for_ Delivery"; Rec."Free Item Pend_for_ Delivery")
            {
                ApplicationArea = all;
            }
            field("Product Category"; Rec."Product Category")
            {
                ApplicationArea = all;
            }
            field("Discount Type"; Rec."Discount Type")
            {
                ApplicationArea = all;
            }
            field("Discount %"; Rec."Discount %")
            {
                ApplicationArea = all;
            }
            field("Discount Amount"; Rec."Discount Amount")
            {
                ApplicationArea = all;
            }
            field("Net Amount"; Rec."Net Amount")
            {
                ApplicationArea = all;
            }
            field("Shield Value"; Rec."Shield Value")
            {
                ApplicationArea = all;
            }
            field("Shield Cost"; Rec."Shield Cost")
            {
                ApplicationArea = all;
            }
            field("Primary category"; Rec."Primary category")
            {
                ApplicationArea = all;

            }
            field("Secondary category"; Rec."Secondary category")
            {
                ApplicationArea = all;
            }
            field("Third category"; Rec."Third category")
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