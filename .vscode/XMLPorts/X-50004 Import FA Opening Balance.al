xmlport 50004 "Import FA Opening Balance"
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Gen. Journal Line"; "Gen. Journal Line")
            {
                XmlName = 'GenJournalLine';
                fieldelement(GenJournalLine_JournalTemplateName; "Gen. Journal Line"."Journal Template Name")
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
                fieldelement(GenJournalLine_FAPostingDate; "Gen. Journal Line"."FA Posting Date")
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
                fieldelement(GenJournalLine_ExternalDocumentNo; "Gen. Journal Line"."External Document No.")
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
                fieldelement(GenJournalLine_FAPostingType; "Gen. Journal Line"."FA Posting Type")
                {
                }
                fieldelement(GenJournalLine_Amount; "Gen. Journal Line".Amount)
                {
                }
                fieldelement(GenJournalLine_BalAccountType; "Gen. Journal Line"."Bal. Account Type")
                {
                }
                fieldelement(GenJournalLine_BalAccountNo; "Gen. Journal Line"."Bal. Account No.")
                {
                }
                fieldelement(DimBranchCode; "Gen. Journal Line"."Shortcut Dimension 1 Code")
                {
                    FieldValidate = Yes;
                }
            }
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

