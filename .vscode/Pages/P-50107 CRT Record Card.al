page 50107 "CRT Record Card"
{
    PageType = Card;
    SourceTable = "CRT Records";
    ApplicationArea = all;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Phone; Rec.Phone)
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                }
                field("Candidate Type"; Rec."Candidate Type")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = all;
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
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Created Platform"; Rec."Created Platform")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Verified By"; Rec."Verified By")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = OnlineVisible;
                }
                field("Verification Comment"; Rec."Verification Comment")
                {
                    ApplicationArea = all;
                    Editable = false;
                    MultiLine = true;
                    Visible = OnlineVisible;
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
                                // TmpBLob.Blob := "Consent File";
                                //  FileExtension := GetFileType(TmpBLob);
                                PDFFilePath := 'C:\PDF Attachment\' + FORMAT(Rec.Phone) + FileExtension;
                                //  TempServerFileName := FileManagement.ServerTempFileName(FileExtension);
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
                        trigger OnValidate()
                        begin
                            IF Rec."Secondary ID Type" = Rec."Secondary ID Type"::Other THEN BEGIN
                                SecondIDEditable := TRUE;
                                Rec."Secondary ID Name" := '';
                            END
                            ELSE BEGIN
                                SecondIDEditable := FALSE;
                                Rec."Secondary ID Name" := FORMAT(Rec."Secondary ID Type");
                            END;
                        end;
                    }
                    field("Secondary ID Name"; Rec."Secondary ID Name")
                    {
                        ApplicationArea = all;
                        Editable = SecondIDEditable;
                    }
                    field("Secondary ID"; Rec."Secondary ID")
                    {
                        ApplicationArea = all;
                        trigger OnValidate()
                        begin
                            Rec.TESTFIELD("Secondary ID Type");
                            Rec.TESTFIELD("Secondary ID Name");
                        end;

                    }
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
                    Rec.TESTFIELD(Status, Rec.Status::Open);
                    Rec.TESTFIELD("Created Platform", Rec."Created Platform"::Store);
                    AllowModify := TRUE;
                    Rec.Status := Rec.Status::"Pending for Approval";
                    MESSAGE('An Approval request has been sent.');
                    CurrPage.CLOSE;
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
                    ApprovalsMgmt: Codeunit 1535;
                begin
                    Rec.TESTFIELD(Status, Rec.Status::"Pending for Approval");
                    Rec.TESTFIELD("Created Platform", Rec."Created Platform"::Store);
                    AllowModify := TRUE;
                    Rec.Status := Rec.Status::Open;
                    MESSAGE('An Approval request has been Cancelled.');
                    CurrPage.CLOSE;
                end;

            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        ConsentFile := '';
        REc.CALCFIELDS("Consent File");
        IF Rec."Consent File".HASVALUE THEN
            ConsentFile := 'Please click on Assist button (...) to open Consent File.';
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        Rec.TESTFIELD(Status, Rec.Status::Open);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.TESTFIELD(Phone);
        Rec.TESTFIELD(Email);

        Rec."Created By" := USERID;
        Rec."Created Platform" := Rec."Created Platform"::Store;
        Rec."Created DateTime" := CURRENTDATETIME;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        IF NOT AllowModify THEN
            Rec.TESTFIELD(Status, Rec.Status::Open);
        AllowModify := FALSE;
    end;

    trigger OnOpenPage()
    begin
        IF Rec.Status <> Rec.Status::Open THEN
            CurrPage.EDITABLE := FALSE;

        IF Rec."Secondary ID Type" = Rec."Secondary ID Type"::Other THEN
            SecondIDEditable := TRUE
        ELSE
            SecondIDEditable := FALSE;

        IF Rec."Created Platform" = Rec."Created Platform"::Online THEN
            OnlineVisible := TRUE
        ELSE
            OnlineVisible := FALSE;
    end;

    var
        SecondIDEditable: Boolean;
        AllowModify: Boolean;
        ApprovalButtonVisible: Boolean;
        ApprovalPageVisibile: Boolean;
        OnlineVisible: Boolean;
        // TmpBLob: Record TempBlob;
        TempServerFileName: Text;
        FileManagement: Codeunit 419;
        FileExtension: Text;
        ConsentFile: Text;
        PDFFilePath: Text;
}

