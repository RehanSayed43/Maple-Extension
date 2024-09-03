pageextension 50005 "Customer List" extends "Customer List"
{
    layout
    {
        addafter("No.")
        {
            field("Phone No.2"; Rec."Phone No.2")
            {
                ApplicationArea = all;
            }
            field("PostCode"; Rec."Post Code")
            {
                ApplicationArea = all;
            }
            field("Country/RegionCode"; Rec."Country/Region Code")
            {
                ApplicationArea = all;
            }
            field(City; Rec.City)
            {
                ApplicationArea = all;
            }
            field("State Code"; Rec."State Code")
            {
                ApplicationArea = all;
            }
            field("GST Customer Type"; Rec."GST Customer Type")
            {
                ApplicationArea = all;
            }
            field("GST Registration No."; Rec."GST Registration No.")
            {
                ApplicationArea = all;
            }
            field(Address; Rec.Address)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the street and number.';
            }
            field("Address 2"; Rec."Address 2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies additional address information.';
            }
            field(County; Rec.County)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the state, province or county as a part of the address.';
            }
        }
    }

    actions
    {
        addafter("Blanket Orders")
        {

        }
    }

    var
        myInt: Integer;
}