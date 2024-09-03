page 50104 "G/L Entry Edit"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    PageType = List;
    Permissions = TableData 17 = rm;
    SourceTable = "G/L Entry";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = all;
                }
                field("G/L Account No."; Rec."G/L Account No.")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = all;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                    ApplicationArea = all;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = all;
                }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = all;
                }
                field("System-Created Entry"; Rec."System-Created Entry")
                {
                    ApplicationArea = all;
                }
                field("Prior-Year Entry"; Rec."Prior-Year Entry")
                {
                    ApplicationArea = all;
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = all;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    ApplicationArea = all;
                }
                field("Business Unit Code"; Rec."Business Unit Code")
                {
                    ApplicationArea = all;
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ApplicationArea = all;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = all;
                }
                field("Gen. Posting Type"; Rec."Gen. Posting Type")
                {
                    ApplicationArea = all;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = all;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = all;
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    ApplicationArea = all;
                }
                field("Transaction No."; Rec."Transaction No.")
                {
                    ApplicationArea = all;
                }
                field("Debit Amount"; Rec."Debit Amount")
                {
                    ApplicationArea = all;
                }
                field("Credit Amount"; Rec."Credit Amount")
                {
                    ApplicationArea = all;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = all;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = all;
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = all;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = all;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = all;
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    ApplicationArea = all;
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                    ApplicationArea = all;
                }
                field("Tax Group Code"; Rec."Tax Group Code")
                {
                    ApplicationArea = all;
                }
                field("Use Tax"; Rec."Use Tax")
                {
                    ApplicationArea = all;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = all;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = all;
                }
                field("Additional-Currency Amount"; Rec."Additional-Currency Amount")
                {
                    ApplicationArea = all;
                }
                field("Add.-Currency Debit Amount"; Rec."Add.-Currency Debit Amount")
                {
                    ApplicationArea = all;
                }
                field("Add.-Currency Credit Amount"; Rec."Add.-Currency Credit Amount")
                {
                    ApplicationArea = all;
                }
                field("Close Income Statement Dim. ID"; Rec."Close Income Statement Dim. ID")
                {
                    ApplicationArea = all;
                }
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    ApplicationArea = all;
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = all;
                }
                field("Reversed by Entry No."; Rec."Reversed by Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Reversed Entry No."; Rec."Reversed Entry No.")
                {
                    ApplicationArea = all;
                }
                field("G/L Account Name"; Rec."G/L Account Name")
                {
                    ApplicationArea = all;
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ApplicationArea = all;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ApplicationArea = all;
                }
                field("FA Entry Type"; Rec."FA Entry Type")
                {
                    ApplicationArea = all;
                }
                field("FA Entry No."; Rec."FA Entry No.")
                {
                    ApplicationArea = all;
                }
                // field("Tax Amount"; Rec."Tax Amount")
                // {
                // }
                // field("Location Code"; Rec."Location Code")
                // {
                // }
                // field("Tax Type"; Rec."Tax Type")
                // {
                // }
                field("Scheme Code"; Rec."Scheme Code")
                {
                    ApplicationArea = all;
                }
                field("Scheme Amount"; Rec."Scheme Amount")
                {
                    ApplicationArea = all;
                }
                field("Bal Account Name"; Rec."Bal Account Name")
                {
                    ApplicationArea = all;
                }
                field(Narration; Rec.Narration)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

