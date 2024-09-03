page 50005 "PDC Application Entry"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "EInvoice Entry";
    ApplicationArea = FixedAsset;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                // field("Document Type"; Rec."Document Type")
                // {
                //     Editable = false;
                // }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = all;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                }
                // field("Document Date"; Rec."Document Date")
                // {
                // }
                // field("Due Date"; Rec."Due Date")
                // {
                // }
                // field("Customer No."; Rec."Customer No.")
                // {
                // }
                // field("Customer Name"; Rec."Customer Name")
                // {
                // }
                // field("Amount Available for Appln"; Rec."Amount Available for Appln")
                // {
                // }
                // field("Amount to Apply"; Rec."Amount to Apply")
                // {
                // }
                // field(Apply; Rec.Apply)
                // {
                // }
                // field("External Document No."; Rec."External Document No.")
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
}

