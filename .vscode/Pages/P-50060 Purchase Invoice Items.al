page 50060 "Purchase Invoice Items"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    Editable = false;
    PageType = List;
    SourceTable = "Purch. Inv. Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = all;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = all;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
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
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = all;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;

                }
                field("Receipt No."; Rec."Receipt No.")
                {
                    ApplicationArea = all;
                }
                field("Receipt Line No."; Rec."Receipt Line No.")
                {
                    ApplicationArea = all;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = all;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = all;
                }
                field("Quantity (Base)"; Rec."Quantity (Base)")
                {
                    ApplicationArea = all;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = all;
                }
                // field("Product Group Code";Rec. "Product Group Code")
                // {
                // }
                // field("Amount To Vendor";Rec. "Amount To Vendor")
                // {
                // }
                // field("Charges To Vendor";Rec. "Charges To Vendor")
                // {
                // }
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

