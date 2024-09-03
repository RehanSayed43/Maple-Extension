page 50118 "CRT Verification List"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    CardPageID = "CRT Verification Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "CRT Records";
    SourceTableView = SORTING("API Entry No.", "Created DateTime")
                      ORDER(Ascending)
                      WHERE(Status = FILTER("Pending for Verification"));

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
                    ApprovalsMgmt: Codeunit 1535;
                begin
                    Rec.TESTFIELD(Status, Rec.Status::"Pending for Verification");
                    Rec.TESTFIELD("Created Platform", Rec."Created Platform"::Online);
                    Rec.TESTFIELD("Verification Comment");
                    Rec.Status := Rec.Status::"Pending for Approval";
                    // "Verified By" := USERID;
                    // "Verified DateTime" := CURRENTDATETIME;
                    // SendEmailToApprover;//KPPLDG00038
                    MESSAGE('An Approval request has been sent.');
                    CurrPage.UPDATE;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        UserSetup.GET(USERID);
        IF NOT UserSetup."CRT Verifier" THEN
            ERROR('You do not have permission to verify CRT, Please contact your system administrator!');
    end;

    var
        UserSetup: Record "User Setup";
}

