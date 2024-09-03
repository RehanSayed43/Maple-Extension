pageextension 50039 "Sales Credit Memos" extends "Sales Credit Memos"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
        UserSetup: Record 91;
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
}