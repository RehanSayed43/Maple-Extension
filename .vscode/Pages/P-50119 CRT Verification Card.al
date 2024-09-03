page 50119 "CRT Verification Card"
{
    UsageCategory = Administration;
    ApplicationArea = all;
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = Card;
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

                    trigger OnValidate()
                    begin
                        AllowModify := TRUE;
                    end;
                }
                field("Calculated Age"; Rec."Calculated Age")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        AllowModify := TRUE;
                    end;
                }
                field("Name of Institute"; Rec."Name of Institute")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        AllowModify := TRUE;
                    end;
                }
                field(Course; Rec.Course)
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        AllowModify := TRUE;
                    end;
                }
                field("Verification Comment"; Rec."Verification Comment")
                {
                    ApplicationArea = all;
                    MultiLine = true;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        AllowModify := TRUE;
                    end;
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

                        trigger OnValidate()
                        begin
                            AllowModify := TRUE;
                        end;
                    }
                    field("Fee Reciept"; Rec."Fee Reciept")
                    {
                        ApplicationArea = all;

                        trigger OnValidate()
                        begin
                            AllowModify := TRUE;
                        end;
                    }
                    field("Aadhar Card"; Rec."Aadhar Card")
                    {
                        ApplicationArea = all;

                        trigger OnValidate()
                        begin
                            AllowModify := TRUE;
                        end;
                    }
                    field("Driving License"; Rec."Driving License")
                    {
                        ApplicationArea = all;

                        trigger OnValidate()
                        begin
                            AllowModify := TRUE;
                        end;
                    }
                    field(Passport; Rec.Passport)
                    {
                        ApplicationArea = all;

                        trigger OnValidate()
                        begin
                            AllowModify := TRUE;
                        end;
                    }
                    field(ConsentFile; ConsentFile)
                    {
                        ApplicationArea = all;
                        Caption = 'Consent File';

                        trigger OnAssistEdit()
                        begin
                            Rec.CALCFIELDS("Consent File");
                            IF Rec."Consent File".HASVALUE THEN BEGIN
                                //  TmpBLob.Blob := "Consent File";
                                //  FileExtension := GetFileType(TmpBLob);
                                PDFFilePath := 'C:\PDF Attachment\' + FORMAT(Rec.Phone) + FileExtension;
                                // TempServerFileName := FileManagement.ServerTempFileName(FileExtension);
                                // FileManagement.BLOBExportToServerFile(TmpBLob, TempServerFileName);
                                // FileManagement.DownloadToFile(TempServerFileName, PDFFilePath);
                                // HYPERLINK(PDFFilePath);
                            END;
                        end;
                    }
                }
                group(Teacher)
                {
                    field("Employee Id Card"; Rec."Employee Id Card")
                    {
                        ApplicationArea = all;
                        trigger OnValidate()
                        begin
                            AllowModify := TRUE;
                        end;
                    }
                    field("Secondary ID Type"; Rec."Secondary ID Type")
                    {
                        ApplicationArea = all;

                        trigger OnValidate()
                        begin
                            AllowModify := TRUE;
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
                            AllowModify := TRUE;
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
                    Rec.TESTFIELD(Status, Rec.Status::"Pending for Verification");
                    Rec.TESTFIELD("Created Platform", Rec."Created Platform"::Online);
                    Rec.TESTFIELD("Verification Comment");
                    AllowModify := TRUE;
                    Rec.Status := Rec.Status::"Pending for Approval";
                    Rec."Verified By" := USERID;
                    Rec."Verified DateTime" := CURRENTDATETIME;
                    //  SendEmailToApprover;//KPPLDG00038
                    MESSAGE('An Approval request has been sent.');
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
        UserSetup.GET(USERID);
        IF NOT UserSetup."CRT Verifier" THEN
            ERROR('You do not have permission to verify CRT, Please contact your system administrator!');

        IF Rec."Secondary ID Type" = Rec."Secondary ID Type"::Other THEN
            SecondIDEditable := TRUE
        ELSE
            SecondIDEditable := FALSE;

        // FILTERGROUP(2);
        // SETFILTER(Phone, Rec.Phone);
        // SETFILTER(Email, Rec.Email);
        // FILTERGROUP(0);
    end;

    var
        SecondIDEditable: Boolean;
        AllowModify: Boolean;
        ApprovalButtonVisible: Boolean;
        ApprovalPageVisibile: Boolean;
        UserSetup: Record 91;
        //  TmpBLob: Record "99008535";
        TempServerFileName: Text;
        FileManagement: Codeunit 419;
        FileExtension: Text;
        ConsentFile: Text;
        PDFFilePath: Text;
}

