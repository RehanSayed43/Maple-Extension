page 50114 "CRT Approved List"
{
    UsageCategory = Administration;
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
                      WHERE(Status = FILTER(Approved));

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
                    CRTApprovedRejectedCard: Page 50116;
                begin
                    CRTApprovedRejectedCard.SETRECORD(Rec);
                    CRTApprovedRejectedCard.RUNMODAL;
                end;
            }
            action(SendEmail)
            {
                Caption = 'Send Email';
                Image = Email;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                var
                    CRTCoupons: Record 50025;
                begin

                    CRTCoupons.RESET;
                    CRTCoupons.SETRANGE(CRTCoupons.Phone, Rec.Phone);
                    CRTCoupons.SETRANGE(CRTCoupons.Email, Rec.Email);
                    IF CRTCoupons.FINDFIRST THEN BEGIN
                        // SendManualEmail(CRTCoupons."Coupon Code");
                        MESSAGE('Email sent successfully.');
                    END
                    ELSE
                        ERROR('Coupon Code not found.');


                end;
            }
        }
        area(reporting)
        {
            action("CRT/BTS Report")
            {
                Image = ExportToExcel;
                Promoted = true;
                PromotedCategory = "Report";
                ApplicationArea = All;
                // RunObject = Report 50004;
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        Rec.TESTFIELD(Status, Rec.Status::Open);
    end;
}

