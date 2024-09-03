pageextension 50059 "Bank Account Ledger Entries" extends "Bank Account Ledger Entries"
{
    layout
    {
        addafter(Description)

        {
            field(Narration; Rec.Narration)
            {
                ApplicationArea = all;
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