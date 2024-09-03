xmlport 50012 "Bank Statement"
{
    Direction = Import;
    FieldSeparator = '<TAB>';
    Format = VariableText;
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement("Bank Acc. Reconciliation Line"; "Bank Acc. Reconciliation Line")
            {
                XmlName = 'BankRecoLine';
                fieldelement(Date; "Bank Acc. Reconciliation Line"."Transaction Date")
                {
                }
                fieldelement(Document; "Bank Acc. Reconciliation Line"."Document No.")
                {
                }
                fieldelement(Description; "Bank Acc. Reconciliation Line".Description)
                {
                }
                fieldelement(CheckNo; "Bank Acc. Reconciliation Line"."Check No.")
                {
                }
                fieldelement(ValueDt; "Bank Acc. Reconciliation Line"."Value Date")
                {
                }
                fieldelement(DebitAmount; "Bank Acc. Reconciliation Line"."Debit Amount")
                {
                }
                fieldelement(CreditAmount; "Bank Acc. Reconciliation Line"."Credit Amount")
                {
                }

                trigger OnBeforeInsertRecord()
                begin
                    LineNo := LineNo + 10000;
                    "Bank Acc. Reconciliation Line"."Bank Account No." := "Bank A/c Number";
                    "Bank Acc. Reconciliation Line"."Statement No." := StatementNo;
                    "Bank Acc. Reconciliation Line"."Statement Line No." := LineNo;
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
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        //FileName := CommonDialogMgt.OpenFile(Text001,FileName,1,'',1);
                        //   FileName := CommonDialogMgt.OpenFileDialog(Text001, FileName, '');
                    end;
                }
                field("Bank Account No."; "Bank A/c Number")
                {
                    TableRelation = "Bank Account"."No.";
                    ApplicationArea = All;
                }
                field("Statement No."; StatementNo)
                {
                    ApplicationArea = All;
                }
                field("Statement Date"; StatementDate)
                {
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    trigger OnPostXmlPort()
    begin

        /*
        BankRecoHdr.RESET;
        BankRecoHdr.SETFILTER("Bank Account No.","Bank A/c Number");
        BankRecoHdr.SETFILTER("Statement No.",StatementNo);
        BankRecoHdr.SETRANGE("Statement Date",StatementDate);

        IF NOT BankRecoHdr.FINDFIRST THEN BEGIN
          BankRecoHdr.INIT;
          BankRecoHdr."Bank Account No." := "Bank A/c Number";
          BankRecoHdr."Statement No." := StatementNo;
          BankRecoHdr."Statement Date" := StatementDate;
          BankRecoHdr.INSERT;
          COMMIT;
        END;
        //Window.CLOSE;
         */

    end;

    trigger OnPreXmlPort()
    begin
        ///IF FileName = '' THEN
        //  ERROR('File name can not be blank');
        //Window.OPEN('Processing.....Please Wait!');

        IF "Bank A/c Number" = '' THEN
            ERROR('Bank A/c Number can not be blank');
        IF StatementNo = '' THEN
            ERROR('Statement Number can not be blank');
        IF StatementDate = 0D THEN
            ERROR('Statement Date can not be blank');
        BankRecoHdr.RESET;
        BankRecoHdr.SETFILTER("Bank Account No.", "Bank A/c Number");
        BankRecoHdr.SETFILTER("Statement No.", StatementNo);
        BankRecoHdr.SETRANGE("Statement Date", StatementDate);
        IF NOT BankRecoHdr.FINDFIRST THEN BEGIN
            BankRecoHdr.INIT;
            BankRecoHdr."Bank Account No." := "Bank A/c Number";
            BankRecoHdr."Statement No." := StatementNo;
            BankRecoHdr."Statement Date" := StatementDate;
            BankRecoHdr.INSERT;
            COMMIT;
        END;
        LineNo := 10000;
        "Bank Acc. Reconciliation Line"."Bank Account No." := "Bank A/c Number";
        "Bank Acc. Reconciliation Line"."Statement No." := StatementNo;
        "Bank Acc. Reconciliation Line"."Statement Line No." := LineNo;
    end;

    var
        FileName: Text[100];
        CommonDialogMgt: Codeunit 419;
        Text001: Label 'Choose the file to import.';
        StatementNo: Code[30];
        StatementDate: Date;
        "Bank A/c Number": Code[20];
        BankRecoHdr: Record "Bank Acc. Reconciliation";
        LineNo: Integer;


    procedure UpdateParameter(BankAcNumber: Code[20]; StatementNumber: Code[30]; StatementDt: Date)
    begin
        "Bank A/c Number" := BankAcNumber;
        StatementNo := StatementNumber;
        StatementDate := StatementDt;
    end;
}

