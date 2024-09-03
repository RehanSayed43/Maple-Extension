pageextension 50075 "Ship-to Address" extends "Ship-to Address"
{
    layout
    {
        moveafter(Name; City)
        moveafter(city; State)
        addafter(Name)
        {
            field("PostCode"; Rec."Post Code")
            {
                ApplicationArea = all;
            }
            field("Country/RegionCode"; Rec."Country/Region Code")
            {
                ApplicationArea = all;
            }
            field("Shipto GST Customer Type"; Rec."Ship-to GST Customer Type")
            {
                ApplicationArea = all;
            }

            field("GST RegistrationNo."; Rec."GST Registration No.")
            {
                ApplicationArea = all;
            }
            field("Address "; Rec.Address)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Address  field.';
            }
            field("Address 2 "; Rec."Address 2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Address 2 field.';
            }
            field("Address 3"; Rec."Address 3")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Address 3 field.';
            }

        }

    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}