pageextension 50301 ItemRevalExt extends "Revaluation Journal"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addafter("&Line")
        {
            action(Upload)
            {
                ApplicationArea = All;
                Image = Excel;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    Xmlport.run(Xmlport::"Item Revaluation Import")
                end;
            }
        }
    }

    var
        myInt: Integer;
}