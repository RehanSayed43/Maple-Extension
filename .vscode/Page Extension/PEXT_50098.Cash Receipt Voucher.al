pageextension 50098 "Cash Receipt Voucher." extends "Cash Receipt Voucher"
{
    layout
    {
        addafter(Amount)
        {
            field("DebitAmount"; Rec."Debit Amount")
            {
                ApplicationArea = all;
                Caption = 'Debit AMOUNT';
            }
            field("CreditAmount"; Rec."Credit Amount")
            {
                ApplicationArea = all;
                Caption = 'Creadit AMOUNT';
            }
        }
        addafter("External Document No.")
        {

            field("Narration."; Rec.Narration)
            {
                Editable = true;
                ApplicationArea = All;
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