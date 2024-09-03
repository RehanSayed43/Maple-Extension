page 50111 "CRT Approval List"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "CRT Records";
    SourceTableView = SORTING("API Entry No.", "Created DateTime")
                      ORDER(Ascending)
                      WHERE(Status = FILTER("Pending for Approval"));

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
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = all;
                }
                field("Name of Institute"; Rec."Name of Institute")
                {
                    ApplicationArea = all;
                }
                field("Calculated Age"; Rec."Calculated Age")
                {
                    ApplicationArea = all;
                }
                field(Course; Rec.Course)
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
                    CRTApprovalCard: Page "CRT Approval Card";
                begin
                    Rec."Approval Entry" := TRUE;
                    CRTApprovalCard.SETRECORD(Rec);
                    CRTApprovalCard.RUNMODAL;
                end;
            }
            action(Approve)
            {
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ApprovalEntry: Record 454;
                    ApprovalsMgmt: Codeunit 1535;
                begin
                    Rec.TESTFIELD("Approval Comment");
                    Rec.Status := Rec.Status::Approved;
                    //     CreateCouponEntry;
                    //    SendEmailNotification;
                    MESSAGE('Approved');
                    CurrPage.UPDATE;
                end;
            }
            action(Reject)
            {
                Caption = 'Reject';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ApprovalEntry: Record 454;
                    ApprovalsMgmt: Codeunit 1535;
                begin
                    Rec.TESTFIELD("Approval Comment");
                    Rec.Status := Rec.Status::Rejected;
                    //     SendRejectedEmail;
                    MESSAGE('Rejected');
                    CurrPage.UPDATE;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        UserSetup.GET(USERID);
        IF NOT UserSetup."CRT Approval" THEN
            ERROR('You do not have permission to approve, Please contact your system administrator!');
    end;

    var
        UserSetup: Record "User Setup";
}

