page 50088 SalesInvLine
{
    UsageCategory = Lists;
    ApplicationArea = all;
    PageType = List;
    SourceTable = "Sales Invoice Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                }

                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = all;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
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

