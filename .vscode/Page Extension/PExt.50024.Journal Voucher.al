pageextension 50024 "JournalVoucher" extends "Journal Voucher"
{

    layout
    {
        addafter("Document No.")
        {

            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Line No. field.';
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

            field("Narration."; Rec.Narration)
            {
                Editable = true;
                ApplicationArea = All;
            }
        }

        addafter(Description)
        {



        }
        modify("Debit Amount")
        {
            trigger OnAfterValidate()
            begin
                //Win317++//WIN345++
                IF (Rec."Document Type" = Rec."Document Type"::Payment) AND (Rec."Debit Amount" < 0) THEN
                    ERROR('Amount Must Be Positve');
                //Win317--//WIN345--
            end;
        }
        modify("Credit Amount")
        {
            trigger OnAfterValidate()
            begin
                //Win317++//WIN345++
                IF (Rec."Document Type" = Rec."Document Type"::Payment) AND (Rec."Credit Amount" < 0) THEN
                    ERROR('Amount Must Be Positve');
                //Win317--//WIN345--
            end;
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
                // To check voucher narration at the time of posting - WIN336//WIN345++
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
                    ERROR('Narration not defined');
                //WIN336//WIN345--

            end;
        }
        modify(PostAndPrint)
        {
            trigger OnAfterAction()
            var
                myInt: Integer;
            begin
                // To check voucher narration at the time of posting - WIN336//WIN345++
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
                    ERROR('Narration not defined');
                //WIN336//WIN345--
                CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post+Print", Rec);
                // CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");//tk
                CurrPage.UPDATE(FALSE);


            end;
        }
    }

    var
        myInt: Integer;
        Text001: Label 'Standard General Journal %1 has been successfully created.';
        TotalDebitAmount: Decimal;
        TotalCreditAmount: Decimal;
        ChangeExchangeRate: Page 511;
        GLReconcile: Page 345;
        GenJnlManagement: Codeunit 230;
        ReportPrint: Codeunit 228;
        RecNarration: Record "Gen. Journal Narration";
        ApprovalMgt: Codeunit "Approvals Mgmt.";
        OpenedFromBatch: Boolean;
        GenJnlLine: Record 81;



}