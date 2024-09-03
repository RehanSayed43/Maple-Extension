page 50142 "Voucher Integration Log"
{
    UsageCategory = Administration;
    ApplicationArea = all;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "E-Invoice Log";
    SourceTableView = WHERE("Vouchr. Integration" = FILTER(True));

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
                field("Transaction Time"; Rec."Transaction Time")
                {
                    ApplicationArea = all;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = all;
                }
                field("Vouchr. Integration"; Rec."Vouchr. Integration")
                {
                    ApplicationArea = all;
                }
                field("Vouchr. Authorization ID"; Rec."Vouchr. Authorization ID")
                {
                    ApplicationArea = all;
                }
                field("Vochr.Authorization Amount"; Rec."Vochr.Authorization Amount")
                {
                    ApplicationArea = all;
                }
                field("Vouchr. Code"; Rec."Vouchr. Code")
                {
                    ApplicationArea = all;
                }
                field("Vouchr. Pin"; Rec."Vouchr. Pin")
                {
                    ApplicationArea = all;
                }
                field("Vochr.Acceptance Ref."; Rec."Vochr.Acceptance Ref.")
                {
                    ApplicationArea = all;
                }
                field("Vouchr. Capture id"; Rec."Vouchr. Capture id")
                {
                    ApplicationArea = all;
                }
                field("Vouchr. Cap Amt"; Rec."Vouchr. Cap Amt")
                {
                    ApplicationArea = all;
                }
                field("Refund ID"; Rec."Refund ID")
                {
                    ApplicationArea = all;
                }
                field("Refund Amount"; Rec."Refund Amount")
                {
                    ApplicationArea = all;
                }
                field("Cancellation ID"; Rec."Cancellation ID")
                {
                    ApplicationArea = all;
                }
                field("Cancellation Amount"; Rec."Cancellation Amount")
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

