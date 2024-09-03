page 50099 "Customer Capillery Card"
{
    UsageCategory = Administration;
    ApplicationArea = all;
    PageType = Card;
    SourceTable = "Customer Capillary";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Mobile No"; Rec."Mobile No")
                {
                    ApplicationArea = all;
                    Editable = false;
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
                field(Email; Rec.Email)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Customer Code"; Rec."Customer Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Birthdate; Rec.Birthdate)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Anniversary; Rec.Anniversary)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Age Group"; Rec."Age Group")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Income Group"; Rec."Income Group")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Pincode; Rec.Pincode)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Work Address"; Rec."Work Address")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Customer Points"; Rec."Customer Points")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Customer Points Value in Rs"; Rec."Customer Points Value in Rs")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Points To Be Redeem"; Rec."Points To Be Redeem")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        Rec.TESTFIELD("Amount Payable");//Win-234 08/01/2019
                    end;
                }
                field("Validation Code For Points"; Rec."Validation Code For Points")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        rec.TESTFIELD("Amount Payable");//Win-234 08/01/2019
                    end;
                }
                field("Point Redeem Value In Rs."; Rec."Point Redeem Value In Rs.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Coupon Code"; Rec."Coupon Code")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        rec.TESTFIELD("Amount Payable");//Win-234 08/01/2019
                    end;
                }
                field("Coupon Value In Rs."; Rec."Coupon Value In Rs.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Amount Payable"; Rec."Amount Payable")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Update Amount")
            {
                Caption = 'Update Amount';
                Promoted = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    // IF (Rec."Validation Code For Points" = '') OR (Rec."Coupon Code" = '') THEN
                    //     Update_amount_payable( "Sales Order No")
                    // ELSE
                    //     MESSAGE('"Validation Code" for this order is already confirmed');
                end;
            }
            action("Point Post")
            {
                Caption = 'Point Post';
                Enabled = false;
                Promoted = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //   Post_Point;
                end;
            }
            action("Coupon Post")
            {
                Caption = 'Coupon Post';
                Enabled = false;
                Promoted = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //  Post_Coupon;
                end;
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF Rec."Points To Be Redeem" <> 0 THEN
            Rec.TESTFIELD("Validation Code For Points");

        IF (Rec."Validation Code For Points" <> '') AND (Rec."Point Posted" = FALSE) THEN
            ERROR('Kindly post the points');
        IF (Rec."Coupon Code" <> '') AND (Rec."Coupon posted" = FALSE) THEN
            ERROR('Kindly post the coupon'); //win-234 14-03-2019
    end;
}

