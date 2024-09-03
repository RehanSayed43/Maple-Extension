pageextension 50015 "GeneralJournal" extends "General Journal"
{
    layout
    {
        addafter("Posting Date")
        {
            field("Due Date"; Rec."Due Date")
            {
                ApplicationArea = All;
            }
            field("Document Date1"; Rec."Document Date")
            {
                ApplicationArea = all;
            }
        }
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

            field(Narration; Rec.Narration)
            {
                Editable = true;
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field("Work Tax Nature Of Deduction"; Rec."Work Tax Nature Of Deduction")
            {
                Visible = false;
                ApplicationArea = All;
            }

        }
        addafter(ShortcutDimCode8)
        {

            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
            }

            field(BankChrgAmt; BankChrgAmt)
            {
                Caption = 'Bank Charge Amount';
                Editable = false;
                ApplicationArea = All;
            }

        }
    }

    actions
    {

    }

    var
        myInt: Integer;
        BankChrgAmt: Decimal;
        RecNarration: Record "Gen. Journal Narration";
        ShortcutDimCode: array[8] of Code[20];
        AccTypeNotSupportedErr: Label 'You cannot specify a deferral code for this type of account.';
        ChangeExchangeRate: Page 511;
        GLReconcile: Page 345;
}