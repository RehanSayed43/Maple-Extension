page 50096 "Capillary Transaction"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Customer Capillary";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = all;
                }
                field("Transaction ID"; Rec."Transaction ID")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Sales Order No"; Rec."Sales Order No")
                {
                    ApplicationArea = all;
                }
                field("Customer Code"; Rec."Customer Code")
                {
                    ApplicationArea = all;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Customer Points"; Rec."Customer Points")
                {
                    ApplicationArea = all;
                }
                field("Points To Be Redeem"; Rec."Points To Be Redeem")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Awarded Points"; Rec."Awarded Points")
                {
                    ApplicationArea = all;
                }
                field("Coupon Code"; Rec."Coupon Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Coupon Value In Rs."; Rec."Coupon Value In Rs.")
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

