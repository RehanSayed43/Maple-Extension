pageextension 50135 "Item Lookup" extends "Item Lookup"
{
    layout
    {
        addafter("Base Unit of Measure")
        {

            field("Vendor Part Code Long"; Rec."Vendor Part Code Long")
            {
                Caption = 'Vendor Part Code';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Part Code Long field.';
            }
        }

        modify(InventoryCtrl)
        {
            Visible = false;
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin

            end;
        }

    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}