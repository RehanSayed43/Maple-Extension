page 50116 "CRT Approved-Rejected Card"
{
    UsageCategory = Administration;
    ApplicationArea = all;
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    ShowFilter = false;
    SourceTable = "CRT Records";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Phone; Rec.Phone)
                {
                    ApplicationArea = all;
                    Editable = false;
                    ShowMandatory = true;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = all;
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Candidate Type"; Rec."Candidate Type")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ShowMandatory = true;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = all;
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = all;
                }
                field("Calculated Age"; Rec."Calculated Age")
                {
                    ApplicationArea = all;
                }
                field("Name of Institute"; Rec."Name of Institute")
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
                field("Verified By"; Rec."Verified By")
                {
                    ApplicationArea = all;
                    Visible = OnlineVisible;
                }
                field("Verification Comment"; Rec."Verification Comment")
                {
                    ApplicationArea = all;
                    MultiLine = true;
                    Visible = OnlineVisible;
                }
                field("Approval By"; Rec."Approval By")
                {
                    ApplicationArea = all;
                }
                field("Approval Comment"; Rec."Approval Comment")
                {
                    ApplicationArea = all;
                    MultiLine = true;
                    ShowMandatory = true;
                }
            }

            group(Attachments)
            {
                Caption = 'Attachments';
                group(Student)
                {
                    field("College Id"; Rec."College Id")
                    {
                        ApplicationArea = all;
                    }
                    field("Fee Reciept"; Rec."Fee Reciept")
                    {
                        ApplicationArea = all;
                    }
                    field("Aadhar Card"; Rec."Aadhar Card")
                    {
                        ApplicationArea = all;
                    }
                    field("Driving License"; Rec."Driving License")
                    {
                        ApplicationArea = all;
                    }
                    field(Passport; Rec.Passport)
                    {
                        ApplicationArea = all;
                    }
                    field(ConsentFile; ConsentFile)
                    {
                        ApplicationArea = all;
                        Caption = 'Consent File';

                        trigger OnAssistEdit()
                        begin
                            Rec.CALCFIELDS("Consent File");
                            IF Rec."Consent File".HASVALUE THEN BEGIN
                                //  TmpBLob.Blob := Rec."Consent File";
                                //  FileExtension := GetFileType(TmpBLob);
                                PDFFilePath := 'C:\PDF Attachment\' + FORMAT(Rec.Phone) + FileExtension;
                                // TempServerFileName := FileManagement.ServerTempFileName(FileExtension);
                                // FileManagement.BLOBExportToServerFile(TmpBLob, TempServerFileName);
                                // FileManagement.DownloadToFile(TempServerFileName, PDFFilePath);
                                HYPERLINK(PDFFilePath);
                            END;
                        end;
                    }
                }
                group(Teacher)
                {
                    field("Employee Id Card"; Rec."Employee Id Card")
                    {
                        ApplicationArea = all;
                    }

                    field("Secondary ID Type"; Rec."Secondary ID Type")
                    {
                        ApplicationArea = all;
                    }
                    field("Secondary ID Name"; Rec."Secondary ID Name")
                    {
                        ApplicationArea = all;
                    }

                    field("-0"; Rec."Secondary ID")
                    {
                        ApplicationArea = all;
                        Caption = 'i';
                    }
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Reopen)
            {
                Caption = 'ReOpen';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;
                Visible = ReopenVisible;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ApprovalEntry: Record 454;
                    ApprovalsMgmt: Codeunit 1535;
                begin
                    REc.TESTFIELD(Status, Rec.Status::Rejected);
                    IF Rec."Created Platform" = Rec."Created Platform"::Online THEN
                        Rec.Status := Rec.Status::"Pending for Verification"
                    ELSE
                        Rec.Status := Rec.Status::Open;
                    MESSAGE('CRT record Opened for Re-verification. Please go to the respective page to further process.');
                    CurrPage.CLOSE;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        ConsentFile := '';
        Rec.CALCFIELDS("Consent File");
        IF Rec."Consent File".HASVALUE THEN
            ConsentFile := 'Please click on Assist button (...) to open Consent File.';
    end;

    trigger OnOpenPage()
    begin
        Rec.FILTERGROUP(2);
        Rec.SETFILTER(Phone, Rec.Phone);
        Rec.SETFILTER(Email, Rec.Email);
        Rec.FILTERGROUP(0);

        CurrPage.EDITABLE := FALSE;

        IF Rec.Status = Rec.Status::Rejected THEN BEGIN
            ReopenVisible := TRUE;
            CurrPage.CAPTION := 'CRT Rejected Record';
        END
        ELSE BEGIN
            ReopenVisible := FALSE;
            CurrPage.CAPTION := 'CRT Approved Record';
        END;

        IF Rec."Created Platform" = Rec."Created Platform"::Online THEN
            OnlineVisible := TRUE
        ELSE
            OnlineVisible := FALSE;
    end;

    var
        ReopenVisible: Boolean;
        OnlineVisible: Boolean;
        //    TmpBLob: Record TempBlob;
        TempServerFileName: Text;
        FileManagement: Codeunit 419;
        FileExtension: Text;
        ConsentFile: Text;
        PDFFilePath: Text;
}

