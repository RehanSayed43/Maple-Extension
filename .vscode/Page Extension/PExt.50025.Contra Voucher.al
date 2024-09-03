pageextension 50025 "Contra Voucher" extends "Contra Voucher"
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
        addbefore(Preview)
        {
            group("&Payments")
            {
                Caption = '&Payments';
                Image = Payment;
                action("P&review Check")
                {
                    Caption = 'P&review Check';
                    Image = ViewCheck;
                    RunObject = Page 404;
                    RunPageLink = "Journal Template Name" = FIELD("Journal Template Name"),
                                  "Journal Batch Name" = FIELD("Journal Batch Name"),
                                  "Line No." = FIELD("Line No.");
                    ApplicationArea = All;
                }
                action("Print Check")
                {
                    Caption = 'Print Check';
                    Ellipsis = true;
                    Image = PrintCheck;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        GenJnlLine: Record 81;
                    begin
                        GenJnlLine.RESET;
                        GenJnlLine.COPY(Rec);
                        GenJnlLine.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                        GenJnlLine.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
                        // DocPrint.PrintCheck(GenJnlLine);//tk
                        // CODEUNIT.RUN(CODEUNIT::"Adjust Gen. Journal Balance",Rec);//tk
                    end;
                }
                action("Void Check")
                {
                    Caption = 'Void Check';
                    Image = VoidCheck;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.TESTFIELD("Bank Payment Type", Rec."Bank Payment Type"::"Computer Check");
                        Rec.TESTFIELD("Check Printed", TRUE);
                        IF CONFIRM(Text000, FALSE, Rec."Document No.") THEN
                            CheckManagement.VoidCheck(Rec);
                    end;
                }
                action("Void &All Checks")
                {
                    Caption = 'Void &All Checks';
                    Image = VoidAllChecks;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        GenJnlLine: Record 81;
                    begin
                        IF CONFIRM(Text001, FALSE) THEN BEGIN
                            GenJnlLine.RESET;
                            GenJnlLine.COPY(Rec);
                            GenJnlLine.SETRANGE("Bank Payment Type", Rec."Bank Payment Type"::"Computer Check");
                            GenJnlLine.SETRANGE("Check Printed", TRUE);
                            IF GenJnlLine.FIND('-') THEN
                                REPEAT
                                    GenJnlLine2 := GenJnlLine;
                                    CheckManagement.VoidCheck(GenJnlLine2);
                                UNTIL GenJnlLine.NEXT = 0;
                        END;
                    end;
                }
            }
        }
    }

    var
        myInt: Integer;
        Text000: Label 'Void Check %1?';
        Text001: Label 'Void all printed checks?';
        ChangeExchangeRate: Page 511;
        GenJnlLine: Record 81;
        GenJnlLine2: Record 81;
        GLReconcile: Page 345;
        ReportPrint: Codeunit 228;
        //DocPrint: Codeunit 229;
        CheckManagement: Codeunit 367;
        TotalCreditAmount: Decimal;
        RecNarration: Record "Gen. Journal Narration";
        TotalDebitAmount: Decimal;
        OpenedFromBatch: Boolean;

    local procedure AfterGetCurrentRecord()
    begin
        xRec := Rec;
        // GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);
        UpdateBalance;
        UpdateDebitCreditAmount;//tk
    end;

    local procedure UpdateBalance()
    begin
        // GenJnlManagement.CalcBalance(
        //   Rec,xRec,Balance,TotalBalance,ShowBalance,ShowTotalBalance);
        // BalanceVisible := ShowBalance;
        // TotalBalanceVisible := ShowTotalBalance;
    end;

    local procedure UpdateDebitCreditAmount()
    begin
        // GenJnlManagement.CalcTotDebitTotCreditAmount(Rec, TotalDebitAmount, TotalCreditAmount, FALSE);
    end;
}