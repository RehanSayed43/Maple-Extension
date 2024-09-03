page 50109 "CRT Record List"
{
    CardPageID = "CRT Record Card";
    UsageCategory = Lists;
    ApplicationArea = all;
    DeleteAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "CRT Records";
    SourceTableView = SORTING("API Entry No.", "Created DateTime")
                      ORDER(Ascending)
                      WHERE(Status = FILTER(Open | "Pending for Verification" | "Pending for Approval"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Candidate Type"; Rec."Candidate Type")
                {
                    ApplicationArea = all;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = all;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = all;
                }
                field(Phone; Rec.Phone)
                {
                    ApplicationArea = all;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = all;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
                field("Created Platform"; Rec."Created Platform")
                {
                    ApplicationArea = all;
                }

            }
        }
    }

    actions
    {
        area(processing)
        {
            action(SendApprovalRequest)
            {
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                //  ApprovalsMgmt: Codeunit 1535;//tk
                begin
                    Rec.TESTFIELD(Status, Rec.Status::Open);
                    Rec.TESTFIELD("Created Platform", Rec."Created Platform"::Store);
                    Rec.Status := Rec.Status::"Pending for Approval";
                    MESSAGE('An Approval request has been sent.');
                    CurrPage.UPDATE;
                end;

            }
            action(CancelApprovalRequest)
            {
                Caption = 'Cancel Approval Re&quest';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                //ApprovalsMgmt: Codeunit 1535;//tk
                begin
                    Rec.TESTFIELD(Status, Rec.Status::"Pending for Approval");
                    REc.TESTFIELD("Created Platform", Rec."Created Platform"::Store);
                    Rec.Status := Rec.Status::Open;
                    MESSAGE('An Approval request has been Cancelled.');
                    CurrPage.UPDATE;
                end;

            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        Rec.TESTFIELD(Status, Rec.Status::Open);
    end;
}

