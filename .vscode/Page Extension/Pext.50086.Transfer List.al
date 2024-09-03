pageextension 50086 "Transfer Orders" extends "Transfer Orders"


{
    Editable = true;
    layout
    {

    }

    actions
    {
        modify(BatchPost)
        {
            ApplicationArea = all;
            Visible = false;
        }
        modify(Post)
        {
            ApplicationArea = all;
            Visible = false;
        }
        // Add changes to page actions here
        modify(PostAndPrint)
        {
            Visible = false;
            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin
                IF Rec."ECom Order ID" = '' THEN; //Win-234 08/01/2019

            end;
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
        UserWiseAreas: Record 91;
        UserSetup: Record 91;
        StoreCount: Integer;
        FilterString: TextBuilder;
    begin


        // UserSetup.GET(USERID);
        // IF (UserSetup."Location Filter" <> '') AND (UserSetup."All Location Transfer" <> TRUE) THEN BEGIN
        //     Rec.FILTERGROUP(2);
        //     Rec.SetFilter(Rec."Transfer-From Code", UserSetup."Location Filter");
        //     Rec.SetFilter(Rec."Transfer-to Code", UserSetup."Location Filter");
        //     Rec.FILTERGROUP(0);
        // END;
    end;

    var
        myInt: Integer;
        UserSetup: Record 91;
}