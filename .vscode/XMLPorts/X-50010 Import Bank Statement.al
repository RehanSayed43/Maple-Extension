xmlport 50010 "Import Bank Statement"
{
    Direction = Import;
    FieldSeparator = '<TAB>';
    Format = VariableText;
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement(bankline; "Bank Acc. Reconciliation Line")
            {
                XmlName = 'BankRecLine';
                // SourceTableView = SORTING(Field1, Field2)
                //                   ORDER(Ascending);   rahul
                textelement(BankAccountNo)
                {
                }
                textelement(CheckNo)
                {
                    MinOccurs = Zero;
                }
                textelement(ValueDate)
                {
                }
                textelement(Description)
                {
                }
                textelement(DebitAmt)
                {
                }
                textelement(CreditAmt)
                {
                }
                textelement(StatementNo)
                {
                }
                textelement(StatementAmount)
                {
                }
                textelement(StatementDate)
                {
                }

                trigger OnBeforeInsertRecord()
                begin
                    //MESSAGE('Start');
                    CLEAR(DocNo);
                    CLEAR(TranscationDate);
                    CLEAR(AppliedAmount);
                    Recon := FALSE;
                    IF NOT (recBankHdr."Bank Account No." = BankAccountNo) THEN BEGIN
                        recBankHdr."Bank Account No." := BankAccountNo;
                        recBankHdr.VALIDATE(recBankHdr."Bank Account No.", BankAccountNo);
                        IF EVALUATE(StDate, StatementDate) THEN
                            recBankHdr."Statement Date" := StDate;
                        IF EVALUATE(StAmt, StatementAmount) THEN
                            recBankHdr.VALIDATE(recBankHdr."Statement Ending Balance", StAmt);
                        recBankHdr.INSERT(TRUE);
                    END;

                    BankLine.INIT;
                    BankLine."Bank Account No." := recBankHdr."Bank Account No.";
                    BankLine."Statement No." := recBankHdr."Statement No.";
                    BankLine."Statement Line No." := LineNo;

                    BanKLedgerEntry.RESET;
                    BanKLedgerEntry.SETFILTER(BanKLedgerEntry."Bank Account No.", '=%1', recBankHdr."Bank Account No.");
                    //   BanKLedgerEntry.SETFILTER(BanKLedgerEntry."Cheque No.", '=%1', CheckNo);   rahul
                    IF BanKLedgerEntry.FIND('-') THEN BEGIN
                        DocNo := BanKLedgerEntry."Document No.";
                        TranscationDate := BanKLedgerEntry."Posting Date";
                        AppliedAmount := BanKLedgerEntry.Amount;
                        BanKLedgerEntry."Statement Status" := BanKLedgerEntry."Statement Status"::"Bank Acc. Entry Applied";
                        BanKLedgerEntry."Statement No." := BankLine."Statement No.";
                        BanKLedgerEntry."Statement Line No." := BankLine."Statement Line No.";
                        Recon := TRUE;
                        BanKLedgerEntry.MODIFY;
                    END;

                    //BankLine.Type := BankLine.Type::"Bank Account Ledger Entry";//commented
                    BankLine."Document No." := DocNo;
                    BankLine."Transaction Date" := TranscationDate;
                    BankLine.VALIDATE(BankLine."Applied Amount", AppliedAmount);
                    BankLine."Check No." := CheckNo;
                    BankLine.Reconciled := Recon;
                    IF EVALUATE(VDate, ValueDate) THEN
                        BankLine.VALIDATE(BankLine."Value Date", VDate);
                    BankLine.Description := Description;
                    IF EVALUATE(DAmt, DebitAmt) THEN
                        BankLine.VALIDATE(BankLine."Debit Amount", DAmt);
                    IF EVALUATE(CAmt, CreditAmt) THEN
                        BankLine.VALIDATE(BankLine."Credit Amount", CAmt);
                    BankLine."Statement Amount" := BankLine."Debit Amount" - BankLine."Credit Amount";
                    LineNo += 10000;
                    //MESSAGE('FINISH');
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("File Name"; FileName)
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        //FileName := CommonDialogMgt.OpenFile(Text001,FileName,1,'',1);
                        //    FileName := CommonDialogMgt.OpenFileDialog(Text001, FileName, '');
                    end;
                }
            }
        }

        actions
        {
        }
    }

    trigger OnPreXmlPort()
    begin
        //MESSAGE('Start');
        LineNo := 10000;
        Window.OPEN('Processing.....Please Wait!');

        //IF FileName = '' THEN
        //  ERROR('File name can not be blank');
    end;

    var
        FileName: Text[100];
        Text001: Label 'Choose the file to import.';
        CommonDialogMgt: Codeunit 419;
        BanKLedgerEntry: Record "Bank Account Ledger Entry";
        DocNo: Code[30];
        TranscationDate: Date;
        AppliedAmount: Decimal;
        recBankHdr: Record "Bank Acc. Reconciliation";
        DAmt: Decimal;
        CAmt: Decimal;
        VDate: Date;
        LineNo: Integer;
        StAmt: Decimal;
        StDate: Date;
        Recon: Boolean;
        Window: Dialog;
}

