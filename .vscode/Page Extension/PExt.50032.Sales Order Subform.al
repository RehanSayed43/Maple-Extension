

pageextension 50032 "Sales Order Subform" extends "Sales Order Subform"
{
    layout
    {
        addafter("No.")
        {
            field(SKU1; Rec.SKU1)
            {
                ApplicationArea = all;
                Visible = true;
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


            field("UPN Code"; Rec."UPN Code")
            {
                ApplicationArea = all;
            }
            field("Salesperson Code"; Rec."Salesperson Code")
            {
                ApplicationArea = all;
            }

            field("Purchase Order No."; Rec."Purchase Order No.")
            {
                Visible = false;
                ApplicationArea = all;
            }
            field("Scheme Code"; Rec."Scheme Code")
            {
                Editable = true;
                ApplicationArea = all;
            }
            field("Scheme %"; Rec."Scheme %")
            {
                Editable = false;
                ApplicationArea = all;
            }
            field("Scheme Amount"; Rec."Scheme Amount")
            {
                Editable = false;
                ApplicationArea = all;
            }
            field("MRP Discount %"; Rec."MRP Discount %")
            {
                Caption = 'Maple Discount %';
                ApplicationArea = all;
            }
            field("MRP Discount Amount"; Rec."MRP Discount Amount")
            {
                Caption = 'Maple Discount Amount';
                ApplicationArea = all;
            }
            field("Invoice Type"; Rec."Invoice Type")
            {
                Visible = false;
                ApplicationArea = all;
            }

        }
        addafter("Document No.")
        {
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
            field("Shield Type"; Rec."Shield Type")
            {
                ApplicationArea = all;
            }
            field("Shield Value"; Rec."Shield Value")
            {
                ApplicationArea = all;
            }
            field(Shield; Rec.Shield)
            {
                ApplicationArea = all;
                Editable = true;
            }
            field("Shield Cost"; Rec."Shield Cost")
            {
                ApplicationArea = all;
                Editable = false;
            }

            field("MRP Value"; Rec."MRP Value")
            {
                ApplicationArea = all;
            }
            field("Capillary Line Discount Amount"; Rec."Capillary Line Discount Amount")
            {
                ApplicationArea = all;
                Editable = false;


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