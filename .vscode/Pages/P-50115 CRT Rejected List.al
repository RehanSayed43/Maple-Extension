page 50115 "CRT Rejected List"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ShowFilter = false;
    SourceTable = "CRT Records";
    SourceTableView = SORTING("API Entry No.", "Created DateTime")
                      ORDER(Ascending)
                      WHERE(Status = FILTER(Rejected));

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
            action("Record")
            {
                Caption = 'Open Record';
                Image = Document;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;
                ApplicationArea = All;

                trigger OnAction()
                var
                    CRTApprovedRejectedCard: Page "CRT Approved-Rejected Card";
                begin
                    CRTApprovedRejectedCard.SETRECORD(Rec);
                    CRTApprovedRejectedCard.RUNMODAL;
                end;
            }
            action(Reopen)
            {
                Caption = 'ReOpen';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit 1535;
                begin
                    Rec.TESTFIELD(Status, Rec.Status::Rejected);
                    IF Rec."Created Platform" = Rec."Created Platform"::Online THEN
                        Rec.Status := Rec.Status::"Pending for Verification"
                    ELSE
                        Rec.Status := Rec.Status::Open;

                    MESSAGE('CRT record Opened for Re-verification. Please go to the respective page to further process.');
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

