pageextension 50123 "General Ledger Entries" extends "General Ledger Entries"
{
    layout
    {
        addafter(Description)
        {
            field(Narration; Rec.Narration)
            {
                Editable = false;
                ApplicationArea = all;
            }
        }
        addafter("Bal. Account No.")
        {
            field("Bal Account Name"; Rec."Bal Account Name")
            {
                ApplicationArea = all;
            }
        }
        addafter("G/L Account No.")
        {
            field("G/LAccount Name"; Rec."G/L Account Name")
            {
                ApplicationArea = all;
            }
        }
        addafter(Amount)
        {
            field("DebitAmount"; Rec."Debit Amount")
            {
                ApplicationArea = all;
            }
            field("CreditAmount"; Rec."Credit Amount")
            {
                ApplicationArea = all;
            }


        }
    }

    actions
    {
        addafter(GLDimensionOverview)
        {

        }
    }

    var
        myInt: Integer;
}