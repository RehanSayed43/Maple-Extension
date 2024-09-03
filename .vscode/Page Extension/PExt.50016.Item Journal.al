pageextension 50016 "Item Journal" extends "Item Journal"
{
    layout
    {

        // moveafter("Location Code";"Serial No.")
        addafter("Location Code")
        {
            field("MRP Value"; REc."MRP Value")
            {
                ApplicationArea = all;
            }
            field("UPN Code"; Rec."UPN Code")
            {
                ApplicationArea = all;

            }
            field("New External Document No "; Rec."New External Document No ")
            {
                ApplicationArea = all;
                Editable = true;
            }
            field("Serial No"; Rec."Serial No.")
            {
                ApplicationArea = all;
            }

        }
    }

    actions
    {
        addafter("&Print")
        {
            action("Assign Specific Serial No.")
            {
                Image = SerialNo;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CreateItemTrackingLines;
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
        ResENTRY: Record 337;
    begin
        UpdateNatureOfDisposal;
        MakeFieldNonEditable;
        ResENTRY.Reset();
        ResENTRY.SetRange(ResENTRY."Source Type", 83);
        ResENTRY.SetRange(ResENTRY."Source ID", Rec."Journal Template Name");
        ResENTRY.SetRange(ResENTRY."Source Batch Name", Rec."Journal Batch Name");
        ResENTRY.SetRange(ResENTRY."Item No.", Rec."No.");
        ResENTRY.SetRange(ResENTRY."Source Ref. No.", Rec."Line No.");
        ResENTRY.SetRange(ResENTRY."Serial No.", Rec."Serial No.");
        ResENTRY.SetRange(ResENTRY."Location Code", Rec."Location Code");
        ResENTRY.SetRange(ResENTRY."Item Tracking", ResENTRY."Item Tracking"::"Serial No.");

        IF ResENTRY.FindFirst() THEN BEGIN
            //Message('%1', ILE."IMEI No.");

            Rec."MRP Value" := ResENTRY."MRP Value";
            Message('%1', ResENTRY."MRP Value");

            Rec.Modify(true);
        end;
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
        ResENTRY: Record "Reservation Entry";
    begin
        UpdateNatureOfDisposal;
        MakeFieldNonEditable;
        ResENTRY.Reset();
        ResENTRY.SetRange(ResENTRY."Source Type", 83);
        ResENTRY.SetRange(ResENTRY."Source ID", Rec."Journal Template Name");
        ResENTRY.SetRange(ResENTRY."Source Batch Name", Rec."Journal Batch Name");
        ResENTRY.SetRange(ResENTRY."Item No.", Rec."No.");
        ResENTRY.SetRange(ResENTRY."Source Ref. No.", Rec."Line No.");
        ResENTRY.SetRange(ResENTRY."Serial No.", Rec."Serial No.");
        ResENTRY.SetRange(ResENTRY."Location Code", Rec."Location Code");
        ResENTRY.SetRange(ResENTRY."Item Tracking", ResENTRY."Item Tracking"::"Serial No.");

        IF ResENTRY.FindFirst() THEN BEGIN
            //Message('%1', ILE."IMEI No.");

            Rec."MRP Value" := ResENTRY."MRP Value";
            Message('%1', ResENTRY."MRP Value");

            Rec.Modify(true);
        end;


    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        myInt: Integer;
    begin
        IF Rec."Entry Type" > Rec."Entry Type"::"Negative Adjmt." THEN
            ERROR(Text000, Rec."Entry Type");
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        myInt: Integer;
    begin
        Rec.SetUpNewLine(xRec);
        CLEAR(ShortcutDimCode);

    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        UpdateNatureOfDisposal;
        MakeFieldNonEditable;
        OnActivateForm;
    end;

    var
        myInt: Integer;
        Text000: Label 'You cannot use entry type %1 in this journal.';
        ItemJnlMgt: Codeunit 240;
        ReportPrint: Codeunit 228;
        ItemAvailFormsMgt: Codeunit 353;
        CalcWhseAdjmt: Report 7315;
        CurrentJnlBatchName: Code[10];
        ItemDescription: Text[50];
        ShortcutDimCode: array[8] of Code[20];
        Text001: Label 'Item Journal lines have been successfully inserted from Standard Item Journal %1.';
        Text002: Label 'Standard Item Journal %1 has been successfully created.';
        [InDataSet]
        "Other UsageEditable": Boolean;
        [InDataSet]
        "Nature of DisposalEditable": Boolean;
        Recuser: Record 91;

    procedure UpdateNatureOfDisposal()
    begin
        // IF "Entry Type" <> "Entry Type"::"Negative Adjmt." THEN BEGIN
        //   "Other UsageEditable" := FALSE;
        //   "Nature of DisposalEditable" := FALSE;
        //   "Other Usage" := 0;
        //   "Nature of Disposal" := '';
        // END ELSE BEGIN
        //   "Other UsageEditable" := TRUE;
        //   "Nature of DisposalEditable" := TRUE;
        // END;
        // IF "Other Usage" <> "Other Usage"::"Wasted/Destroyed" THEN
        //   "Nature of DisposalEditable" := FALSE;
    end;


    procedure MakeFieldNonEditable()
    begin
        //     // IF ("Other Usage" = "Other Usage"::"Wasted/Destroyed") OR ("Other Usage" = "Other Usage"::" ") THEN BEGIN
        //     //   "Nature of DisposalEditable" := FALSE;
        //     //   "Nature of Disposal" := '';
        //     END ELSE
        //       "Nature of DisposalEditable" := TRUE;
    end;

    local procedure CurrentJnlBatchNameOnAfterVali()
    begin
        CurrPage.SAVERECORD;
        ItemJnlMgt.SetName(CurrentJnlBatchName, Rec);
        CurrPage.UPDATE(FALSE);
    end;

    local procedure OtherUsageOnActivate()
    begin
        MakeFieldNonEditable;
    end;

    local procedure OnActivateForm()
    begin
        UpdateNatureOfDisposal;
    end;

    local procedure OtherUsageOnAfterInput(var Text: Text[1024])
    begin
        MakeFieldNonEditable;
    end;

    local procedure OtherUsageOnInputChange(var Text: Text[1024])
    begin
        MakeFieldNonEditable;
    end;

    local procedure "----DG----"()
    begin
    end;

    local procedure CreateItemTrackingLines()
    var
        ItemJournalLine: Record 83;
        ReserveItemJnlLine: Codeunit 99000835;
    begin
        ItemJournalLine.RESET;
        ItemJournalLine.SETRANGE(ItemJournalLine."Journal Template Name", Rec."Journal Template Name");
        ItemJournalLine.SETRANGE(ItemJournalLine."Journal Batch Name", 'OPENING');
        ItemJournalLine.SETRANGE(ItemJournalLine."Assign Batch Serial", FALSE);
        IF ItemJournalLine.FINDSET THEN
            REPEAT
                //ReserveItemJnlLine.CallItemTrackingNew(ItemJournalLine,FALSE);//tk
                ItemJournalLine."Assign Batch Serial" := TRUE;
                ItemJournalLine.MODIFY;
            UNTIL ItemJournalLine.NEXT = 0;
        MESSAGE('Serial no. assigned successfully.');
    end;

}