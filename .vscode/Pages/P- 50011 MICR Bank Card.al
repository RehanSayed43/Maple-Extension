page 50011 "MICR/Bank Card"
{
    ApplicationArea = all;
    UsageCategory = Administration;
    PageType = Card;
    SourceTable = "MICR Codes";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code Type"; Rec."Code Type")
                {
                    ApplicationArea = all;
                }
                field("MICR Code"; Rec."MICR Code")
                {
                    ApplicationArea = all;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = all;
                }
                field("Bank Branch"; Rec."Bank Branch")
                {
                    ApplicationArea = all;
                }
                field("Bank No."; Rec."Bank No.")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Responsibility Centre"; Rec."Responsibility Centre")
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

