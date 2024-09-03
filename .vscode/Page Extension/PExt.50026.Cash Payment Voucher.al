pageextension 50026 "CashPaymentVoucher" extends "Cash Payment Voucher"
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

    }

    var
        myInt: Integer;
}