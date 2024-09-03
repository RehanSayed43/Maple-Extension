page 50015 "Approval List part"
{
    Caption = 'Approval List';
    UsageCategory = Lists;
    ApplicationArea = all;
    DeleteAllowed = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = ListPart;
    SourceTable = "Approval Entry";
    SourceTableView = WHERE(Status = CONST(Open));


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = all;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = all;
                    //ExtendedDatatype = None;
                    Style = Favorable;
                    StyleExpr = TRUE;
                }
                field("Sender ID"; Rec."Sender ID")
                {
                    ApplicationArea = all;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = all;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Open)
            {
                Caption = 'Open';
                Image = Edit;
                RunPageMode = View;
                ShortCutKey = 'Return';
                ApplicationArea = All;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                begin
                    ApprovalEntry.RESET;
                    ApprovalEntry.SETRANGE("Document Type", ApprovalEntry."Document Type");
                    ApprovalEntry.SETFILTER("Document No.", ApprovalEntry."Document No.");
                    PAGE.RUN(PAGE::"Approval Entries", ApprovalEntry);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        //    SETFILTER("Approver ID", '%1', USERID);
    end;
}

