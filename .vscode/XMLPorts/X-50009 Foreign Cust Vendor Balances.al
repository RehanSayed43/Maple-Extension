xmlport 50009 "Foreign Cust/Vendor Balances"
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Gen. Journal Line"; "Gen. Journal Line")
            {
                XmlName = 'GenJournalLine';
                fieldelement(GenJournalLine_Template; "Gen. Journal Line"."Journal Template Name")
                {
                }
                fieldelement(GenJournalLine_JournalBatchName; "Gen. Journal Line"."Journal Batch Name")
                {
                }
                fieldelement(GenJournalLine_LineNo; "Gen. Journal Line"."Line No.")
                {
                }
                fieldelement(GenJournalLine_PostingDate; "Gen. Journal Line"."Posting Date")
                {
                }
                fieldelement(GenJournalLine_DocumentType; "Gen. Journal Line"."Document Type")
                {
                }
                fieldelement(GenJournalLine_Document_No; "Gen. Journal Line"."Document No.")
                {
                }
                fieldelement(GenJournalLine_DocumentDate; "Gen. Journal Line"."Document Date")
                {
                }
                fieldelement(GenJournalLine_Ext_Document_No; "Gen. Journal Line"."External Document No.")
                {
                }
                fieldelement(GenJournalLine_AccountType; "Gen. Journal Line"."Account Type")
                {
                }
                fieldelement(GenJournalLine_AccountNo; "Gen. Journal Line"."Account No.")
                {
                }
                fieldelement(GenJournalLine_Description; "Gen. Journal Line".Description)
                {
                }
                fieldelement(GenJournalLine_Currency_Code; "Gen. Journal Line"."Currency Code")
                {
                }
                fieldelement(GenJournalLine_CurrencyFactor; "Gen. Journal Line"."Currency Factor")
                {
                }
                fieldelement(GenJournalLine_Amount; "Gen. Journal Line".Amount)
                {
                }
                fieldelement(GenJournalLine_Amount_LCY; "Gen. Journal Line"."Amount (LCY)")
                {
                }
                fieldelement(GenJournalLine_BalAccountType; "Gen. Journal Line"."Bal. Account Type")
                {
                }
                fieldelement(GenJournalLine_BalAccountNo; "Gen. Journal Line"."Bal. Account No.")
                {
                }
                fieldelement(GenJournalLine_Due_Date; "Gen. Journal Line"."Due Date")
                {
                }
            }

            trigger OnAfterAssignVariable()
            begin
                MESSAGE('Import Successful');
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }
}

