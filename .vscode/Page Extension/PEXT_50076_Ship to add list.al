pageextension 50076 "Ship-to Address List" extends "Ship-to Address List"
{
    layout
    {
        moveafter(Name; City)

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
            field(State; Rec.State)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the state code of Ship to Address';
            }
            field(County; Rec.County)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the state, province, or county as a part of the address.';
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