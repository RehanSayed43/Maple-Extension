pageextension 50046 "Posted Purchase Invoice" extends "Posted Purchase Invoice"
{
    layout
    {
        addafter("Document Date")
        {
            field("Import Document No."; Rec."Import Document No.")
            {
                ApplicationArea = all;
            }

        }
        addafter("Purchaser Code")
        {
            field("CIN Number"; recComp."CIN no")
            {
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
        recComp.GET;//Updated WIN347

    end;

    var
        myInt: Integer;
        recComp: Record "Company Information";
}