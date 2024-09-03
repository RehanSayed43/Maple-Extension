pageextension 50158 "Posted Sales Invoices" extends "Posted Sales Invoices"
{
    layout
    {
        addafter("No.")
        {
            field("Order ID"; Rec."Order ID")
            {
                ApplicationArea = all;
            }
            field("LocationCode"; Rec."Location Code")
            {
                ApplicationArea = all;
            }
        }
        addafter("Currency Code")
        {
            field("Cust. email ID"; Rec."Cust. email ID")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Cust. email ID field.';
            }
            field("Cust. Mobile No."; Rec."Cust. Mobile No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Cust. Mobile No. field.';
            }
        }
        addafter("Location Code")
        {
            field(SystemCreatedAt; Rec.SystemCreatedAt)
            {
                Caption = 'Posting Date & Time';
                ApplicationArea = all;

                //DataClassification = ToBeClassified;
            }
            field(SystemCreatedBy; Rec."User ID")
            {
                Caption = 'User Id';
                ApplicationArea = all;
            }
        }

    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        UserSetup.GET(USERID);
        IF UserSetup."Location Code" <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Location Code", UserSetup."Location Code");
            Rec.FILTERGROUP(0);
        END;
    end;

    var
        myInt: Integer;
        UserSetup: Record 91;
}