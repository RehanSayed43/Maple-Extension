pageextension 50022 "BankReceiptVoucher" extends "Bank Receipt Voucher"
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
                Caption = 'Credit AMOUNT';
                //Visible = false;
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
        addbefore("Document Date")
        {
            field("Party Type"; Rec."Party Type")
            {
                ApplicationArea = all;
            }
            field("Party Code"; Rec."Party Code")
            {
                ApplicationArea = all;
            }

            field("Credit Amount2"; Rec."Credit Amount")
            {
                //Editable = false;
                ApplicationArea = all;
            }



        }
        modify("Reason Code")
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                myInt: Integer;
            begin
                //WIn345++
                ReasonCode.RESET;
                ReasonCode.SETRANGE("Document Type", ReasonCode."Document Type"::Bank);
                IF PAGE.RUNMODAL(259, ReasonCode) = ACTION::LookupOK THEN BEGIN
                    Rec."Reason Code" := ReasonCode.Code;
                END;
            END;
            //WIN345-- 

        }

    }

    actions
    {
        modify(Post)
        {
            trigger OnAfterAction()
            var
                myInt: Integer;
            begin
                //WIn336//WIn345++
                RecNarration.RESET;
                RecNarration.SETFILTER(RecNarration."Document No.", '%1', Rec."Document No.");
                IF RecNarration.FINDSET THEN BEGIN
                    REPEAT
                        IF RecNarration.Narration = '' THEN BEGIN
                            ERROR('Narration is empty');
                            EXIT;
                        END;
                    UNTIL RecNarration.NEXT = 0;
                END
                ELSE
                    ERROR('Narration not defined');  //WIN336//WIn345--


            end;
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    var
        myInt: Integer;
    begin
        // UpdateDebitCreditAmount;//tk
        // default document type set as payment on 21/06/17
        Rec."Document Type" := Rec."Document Type"::Payment;//WIN345
                                                            // WIN336
    end;

    var
        myInt: Integer;
        ReasonCode: Record 231;
        UserSetup: Record 91;
        RecNarration: Record "Gen. Journal Narration";
        ChangeExchangeRate: Page 511;
        ShowBalance: Boolean;
        ShowTotalBalance: Boolean;
        TotalDebitAmount: Decimal;
        TotalCreditAmount: Decimal;
        OpenedFromBatch: Boolean;
        GLReconcile: Page 345;
        GenJnlManagement: Codeunit 230;

    local procedure AfterGetCurrentRecord()
    begin
        xRec := Rec;
        // GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);
        // UpdateBalance;
        // UpdateDebitCreditAmount;
    end;

}