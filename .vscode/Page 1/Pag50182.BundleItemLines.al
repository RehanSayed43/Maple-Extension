page 50182 "Bundle Item Lines"
{
    AutoSplitKey = true;
    ApplicationArea = All;
    Caption = 'Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Bundle Item Line";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("Item Description"; Rec."Item Description")
                {
                    ToolTip = 'Specifies the value of the Item Description field.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ToolTip = 'Specifies the value of the Variant Code field.';
                }
                field("Minimum Quantity"; Rec."Minimum Quantity")
                {
                    ToolTip = 'Specifies the value of the Minimum Quantity field.';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ToolTip = 'Specifies the value of the Unit Price field.';
                }
                field("Discount Entry No."; Rec."Discount Entry No.")
                {
                    ToolTip = 'Specifies the value of the Discount Entry No. field.';
                }
                field("Discount Type"; Rec."Discount Type")
                {
                    ToolTip = 'Specifies the value of the Discount Type field.';
                }
                field("Line Discount"; Rec."Line Discount")
                {
                    ToolTip = 'Specifies the value of the Line Discount % field.';
                    Visible = false;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ToolTip = 'Specifies the value of the Line Discount Amount field.';

                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ToolTip = 'Specifies the value of the Starting Date field.';
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ToolTip = 'Specifies the value of the Ending Date field.';
                }
            }
        }
    }
}
