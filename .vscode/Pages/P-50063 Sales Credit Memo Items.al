page 50063 "Sales Credit Memo Items"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    PageType = List;
    SourceTable = "Sales Cr.Memo Line";

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
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = all;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = all;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = all;
                }

                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = all;
                }
                field("IMEI No."; Rec."IMEI No.")
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
                field("UPN Code"; Rec."UPN Code")
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

