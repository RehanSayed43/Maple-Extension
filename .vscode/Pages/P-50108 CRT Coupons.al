page 50108 "CRT Coupons"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "CRT Coupons";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Coupon Code"; Rec."Coupon Code")
                {
                    ApplicationArea = all;
                }
                field(Phone; Rec.Phone)
                {
                    ApplicationArea = all;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = all;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = all;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = all;
                }
                field("Coupon Generate Date"; Rec."Coupon Generate Date")
                {
                    ApplicationArea = all;
                }
                field("Coupon Expiry Date"; Rec."Coupon Expiry Date")
                {
                    ApplicationArea = all;
                }
                field("Verification ID"; Rec."Verification ID")
                {
                    ApplicationArea = all;
                }
                field("Verified By"; Rec."Verified By")
                {
                    ApplicationArea = all;
                }
                field("Verified DateTime"; Rec."Verified DateTime")
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

