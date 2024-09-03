page 50112 "CRT Coupons Web Service"
{
    ApplicationArea = all;
    UsageCategory = Lists;
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
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = all;
                }
                field("Item Description"; Rec."Item Description")
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
                field("Coupon Generate Date"; Rec."Coupon Generate Date")
                {
                    ApplicationArea = all;
                }
                field("Coupon Expiry Date"; Rec."Coupon Expiry Date")
                {
                    ApplicationArea = all;
                }
                field(crt_institute_address; Rec.crt_institute_address)
                {
                    ApplicationArea = all;
                }
                field(crt_institute_city; Rec.crt_institute_city)
                {
                    ApplicationArea = all;
                }

                field(crt_institute_zipcode; Rec.crt_institute_zipcode)
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

