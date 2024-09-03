page 50100 "WMS Integration"
{
    PageType = List;
    SourceTable = "Integration Data WMS";
    ApplicationArea = all;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = all;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                }
                field("From Location"; Rec."From Location")
                {
                    ApplicationArea = all;
                }
                field("To Location"; Rec."To Location")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = all;
                }
                field(UOM; Rec.UOM)
                {
                    ApplicationArea = all;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = all;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

