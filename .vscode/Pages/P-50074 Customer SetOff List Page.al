page 50074 "Customer Set Off List Page"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    PageType = List;
    SourceTable = "Customer Set Off";
    SourceTableView = WHERE("JV Created" = FILTER(False));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No"; Rec."Line No")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = all;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = all;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = all;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = all;
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                    ApplicationArea = all;
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                }
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    ApplicationArea = all;
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
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

