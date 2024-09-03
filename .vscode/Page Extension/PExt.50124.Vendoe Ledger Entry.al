pageextension 50124 "Vendor Ledger Entries" extends "Vendor Ledger Entries"
{
    layout
    {
        addafter(Description)
        {
            field(Narration; Rec.Narration)
            {
                Editable = false;
                ApplicationArea = all;
            }
            field("ExternalDocument No."; Rec."External Document No.")
            {
                ApplicationArea = all;
            }

        }
        addafter(Amount)
        {
            field("DebitAmount"; Rec."Debit Amount")
            {
                ApplicationArea = all;
            }
            field("CreditAmount"; Rec."Credit Amount")
            {
                ApplicationArea = all;
            }
        }
        addafter("Document No.")
        {
            field("Total TDS Including SHE CESS"; Rec."Total TDS Including SHE CESS")
            {
                ApplicationArea = all;
            }
            field("TDS SectionCode"; Rec."TDS Section Code")
            {
                ApplicationArea = all;
            }
            field("UserID"; Rec."User ID")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}