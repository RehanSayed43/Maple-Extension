pageextension 50037 "Sales Cr. Memo Subform" extends "Sales Cr. Memo Subform"
{
    layout
    {
        addafter(Description)
        {

            field("Corporate Salesperson Code"; Rec."Corporate Salesperson Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Corporate Salesperson Code field.';
            }
            field("Corporate Salesperson Name"; Rec."Corporate Salesperson Name")
            {
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Corporate Salesperson Name field.', Comment = '%';
            }
        }
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
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}