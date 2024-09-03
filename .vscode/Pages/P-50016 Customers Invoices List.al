page 50016 "Customer's Invoices List"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    AutoSplitKey = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
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
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Line No."; Rec."Line No.")
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
                field("Free Item Pend_for_ Delivery"; Rec."Free Item Pend_for_ Delivery")
                {
                    ApplicationArea = all;
                }
                field("Shield Value"; Rec."Shield Value")
                {
                    ApplicationArea = all;
                }
                field("AMC Due Date"; Rec."AMC Due Date")
                {
                    ApplicationArea = all;
                }
                field("Warranty Exp. Dt"; Rec."Warranty Exp. Dt")
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

