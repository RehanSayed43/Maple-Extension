page 50004 "PDC Application Buffer"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "EInvoice Entry";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Type"; "CustLedgerEntry"."Document Type")
                {
                    ApplicationArea = all;
                }
                field("Document Types"; Rec."Document Type")
                {
                    ApplicationArea = all;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                }
                field("Document Date"; CustLedgerEntry."Document Date")
                {
                    ApplicationArea = all;
                }
                field("External Document No."; ExternalDocumentNo)
                {
                    ApplicationArea = all;
                    Caption = 'External Document No.';
                }
                field("Due Date"; CustLedgerEntry."Due Date")
                {
                    ApplicationArea = all;
                }
                field("Customer No."; CustLedgerEntry."Customer No.")
                {
                    ApplicationArea = all;
                }
                field("Customer Name"; CustLedgerEntry."Customer Name")
                {
                    ApplicationArea = all;
                }
                // field("Amount Available for Appln"; CustLedgerEntry."Amount Available for Appln")
                // {
                // }
                field("Amount to Apply"; CustLedgerEntry."Amount to Apply")
                {
                    ApplicationArea = all;
                }
                // field(Apply; Rec.Apply)
                // {
                // }
            }
        }
        area(factboxes)
        {
            part(Name; 9082)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        ExternalDocumentNo := '';
        IF rec."Cancel Reason" > 0 THEN
            IF CustLedgerEntry.GET(rec."Cancel Reason") THEN
                ExternalDocumentNo := CustLedgerEntry."External Document No.";
    end;

    var
        ExternalDocumentNo: Code[20];
        CustLedgerEntry: Record "Cust. Ledger Entry";
}

