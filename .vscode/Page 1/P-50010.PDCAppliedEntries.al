page 50010 "PDC Applied Entries"
{
    Editable = false;
    PageType = List;
    SourceTable = 50004;
    Caption = 'PDC Applied Entries';
    ApplicationArea = FixedAsset;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Cancel Reason"; Rec."Cancel Reason")
                {
                    ApplicationArea = All;
                }

                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }

                // field("Due Date"; "Due Date")
                // {
                // }
                // field("Customer No."; "Customer No.")
                // {
                // }
                // field("Customer Name"; "Customer Name")
                // {
                // }
                // field("Document Amount"; "Document Amount")
                // {
                // }
                // field("PDC Unposted Amount"; "PDC Unposted Amount")
                // {
                // }
                // field("Amount Available for Appln"; "Amount Available for Appln")
                // {
                // }
                // field("PDC Amount Available"; "PDC Amount Available")
                // {
                // }
                // field("Amount to Apply"; "Amount to Apply")
                // {
                // }
                // field(Apply; Apply)
                // {
                // }
            }
        }
    }

    actions
    {
    }
}

