page 50086 "Defective Accessory"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = Worksheet;
    UsageCategory = Lists;
    ApplicationArea = all;
    SourceTable = 50008;
    SourceTableView = WHERE(Posted = FILTER(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction No"; Rec."Transaction No")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = All;
                }
                field("Invoice No"; Rec."Invoice No")
                {
                    ApplicationArea = All;
                }
                field("Invoice Date"; Rec."Invoice Date")
                {
                    ApplicationArea = All;
                }
                field(Zone; Rec.Zone)
                {
                    ApplicationArea = All;
                }
                field(State; Rec.State)
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Customer Type"; Rec."Customer Type")
                {
                    ApplicationArea = All;
                }
                field("Customer No"; Rec."Customer No")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field(Brand; Rec.Brand)
                {
                    ApplicationArea = All;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                }
                field("Primary Category"; Rec."Primary Category")
                {
                    ApplicationArea = All;
                }
                field("Maple Part Code"; Rec."Maple Part Code")
                {
                    ApplicationArea = All;
                }
                field("Vendor part Code"; Rec."Vendor part Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Qty. Taken Back"; Rec."Qty. Taken Back")
                {
                    ApplicationArea = All;
                }
                field("UPN No"; Rec."UPN No")
                {
                    ApplicationArea = All;
                }
                field("Given UPN No"; Rec."Given UPN No")
                {
                    ApplicationArea = All;
                }
                field("Given Maple Part Code"; Rec."Given Maple Part Code")
                {
                    ApplicationArea = All;
                }
                field("Given Brand"; Rec."Given Brand")
                {
                    ApplicationArea = All;
                }
                field("Given Category"; Rec."Given Category")
                {
                    ApplicationArea = All;
                }
                field("Given Primary Category"; Rec."Given Primary Category")
                {
                    ApplicationArea = All;
                }
                field("Given Vendor part Code"; Rec."Given Vendor part Code")
                {
                    ApplicationArea = All;
                }
                field("Given Description"; Rec."Given Description")
                {
                    ApplicationArea = All;
                }
                field("Qty. Given"; Rec."Qty. Given")
                {
                    ApplicationArea = All;
                }
                field("Damage Location"; Rec."Damage Location")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Post1)
            {
                Caption = 'Post';
                action(post)
                {
                    Caption = 'post';
                    Image = post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        PostJournal(Rec);
                        RecDefectiveAccessiry.RESET;
                        //// RecDefectiveAccessiry.INIT;
                        RecDefectiveAccessiry.SETRANGE(RecDefectiveAccessiry."Transaction No", Rec."Transaction No");
                        IF RecDefectiveAccessiry.FINDFIRST THEN BEGIN
                            RecDefectiveAccessiry.Posted := TRUE;
                            RecDefectiveAccessiry.MODIFY;
                        END;


                    end;
                }
                action("Item Tracking Lines")
                {
                    Caption = 'Item Tracking Lines';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        AssignSerialNumber;
                    end;
                }
            }
        }
    }

    var
        RecItemJournalLine: Record 83;
        LineNo: Integer;
        RecDefectiveAccessiry: Record 50008;
        CurrentJnlBatchName: Code[10];
        RecItemJournalNew: Record 83;
        DocumentNo: Code[20];
        NoSeriesLine: Record 309;
        RecSalesInvHeader: Record 112;


    procedure PostEntriesToItemJournalLine()
    begin
        //-------------------------WIN 270---------for line no--------------------------------------
        CLEAR(LineNo);
        RecItemJournalLine.RESET;
        RecItemJournalLine.SETRANGE(RecItemJournalLine."Journal Template Name", 'ITEM');
        RecItemJournalLine.SETRANGE(RecItemJournalLine."Journal Batch Name", 'DEFACC');
        IF RecItemJournalLine.FINDLAST THEN BEGIN
            LineNo := RecItemJournalLine."Line No." + 10000;
        END
        ELSE BEGIN
            LineNo := 10000;
        END;



        // RecSalesInvHeader.reset;
        IF RecSalesInvHeader.GET(Rec."Invoice No") THEN;
        //---------------------------------negative adj-------------------------------------------------------------//
        RecItemJournalLine.RESET;
        RecItemJournalLine.INIT;
        RecItemJournalLine."Journal Template Name" := 'ITEM';
        RecItemJournalLine."Journal Batch Name" := 'DEFACC';
        RecItemJournalLine."Line No." := LineNo;
        RecItemJournalLine."Document No." := Rec."Transaction No";
        RecItemJournalLine."Posting Date" := Rec."Creation Date";
        RecItemJournalLine."Entry Type" := RecItemJournalLine."Entry Type"::"Negative Adjmt.";
        RecItemJournalLine.VALIDATE(RecItemJournalLine."Item No.", Rec."Given Maple Part Code");
        RecItemJournalLine.VALIDATE(RecItemJournalLine."Location Code", Rec."Location Code");
        RecItemJournalLine.VALIDATE(RecItemJournalLine.Quantity, Rec."Qty. Given");
        RecItemJournalLine.VALIDATE(RecItemJournalLine."UPN Code", Rec."Given UPN No");
        RecItemJournalLine.VALIDATE(RecItemJournalLine."Shortcut Dimension 1 Code", RecSalesInvHeader."Shortcut Dimension 1 Code");
        RecItemJournalLine.VALIDATE(RecItemJournalLine."Shortcut Dimension 2 Code", RecSalesInvHeader."Shortcut Dimension 2 Code");
        RecItemJournalLine.INSERT(TRUE);




        //--------------------------------positive adj--------------------------------------------------------------------//
        RecItemJournalLine.RESET;
        RecItemJournalLine.INIT;
        RecItemJournalLine."Journal Template Name" := 'ITEM';
        RecItemJournalLine."Journal Batch Name" := 'DEFACC';
        RecItemJournalLine."Line No." := LineNo + 10000;
        RecItemJournalLine."Document No." := Rec."Transaction No";
        RecItemJournalLine."Posting Date" := Rec."Creation Date";
        RecItemJournalLine."Entry Type" := RecItemJournalLine."Entry Type"::"Positive Adjmt.";
        RecItemJournalLine.VALIDATE(RecItemJournalLine."Item No.", Rec."Maple Part Code");
        RecItemJournalLine.VALIDATE(RecItemJournalLine."Location Code", Rec."Damage Location");
        RecItemJournalLine.VALIDATE(RecItemJournalLine.Quantity, Rec."Qty. Taken Back");
        RecItemJournalLine.VALIDATE(RecItemJournalLine."UPN Code", Rec."UPN No");
        RecItemJournalLine.VALIDATE(RecItemJournalLine."Shortcut Dimension 1 Code", RecSalesInvHeader."Shortcut Dimension 1 Code");
        RecItemJournalLine.VALIDATE(RecItemJournalLine."Shortcut Dimension 2 Code", RecSalesInvHeader."Shortcut Dimension 2 Code");
        RecItemJournalLine.INSERT(TRUE);


        //---------------------------posting item journal lines----------------------------------------
        RecItemJournalLine.RESET;
        RecItemJournalLine.SETRANGE(RecItemJournalLine."Journal Template Name", 'ITEM');
        RecItemJournalLine.SETRANGE(RecItemJournalLine."Journal Batch Name", 'DEFACC');
        RecItemJournalLine.SETRANGE(RecItemJournalLine."Document No.", Rec."Transaction No");
        IF RecItemJournalLine.FINDSET THEN;
        CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", RecItemJournalLine);
    end;


    procedure PostJournal(var RecDefAcc: Record 50008)
    var
        ItemJournalLine: Record 83;
        TrackingSpecification: Record 336;
        ReservationEntry: Record 337;
        ItemJnlPost: Codeunit 22;
    begin
        IF RecSalesInvHeader.GET(Rec."Invoice No") THEN;
        ItemJournalLine.INIT;
        ItemJournalLine."Journal Template Name" := 'RECLASS';
        ItemJournalLine."Journal Batch Name" := 'DEFAULT';
        ItemJournalLine."Line No." := GetLineNoIssue('RECLASS', 'DEFAULT');
        ItemJournalLine."Document No." := RecDefAcc."Transaction No";
        ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::Transfer;
        ItemJournalLine.VALIDATE("Item No.", RecDefAcc."Given Maple Part Code");
        ItemJournalLine."Posting Date" := RecDefAcc."Posting Date";
        ItemJournalLine.VALIDATE("Location Code", RecDefAcc."Location Code");
        ItemJournalLine.VALIDATE(Quantity, RecDefAcc."Qty. Given");
        ItemJournalLine.VALIDATE("New Location Code", RecDefAcc."Damage Location");
        ItemJournalLine.VALIDATE(ItemJournalLine."UPN Code", RecDefAcc."Given UPN No");
        ItemJournalLine.VALIDATE(ItemJournalLine."Shortcut Dimension 1 Code", RecSalesInvHeader."Shortcut Dimension 1 Code");
        ItemJournalLine.VALIDATE(ItemJournalLine."Shortcut Dimension 2 Code", RecSalesInvHeader."Shortcut Dimension 2 Code");
        ItemJournalLine.VALIDATE(ItemJournalLine."New Shortcut Dimension 1 Code", RecSalesInvHeader."Shortcut Dimension 1 Code");
        ItemJournalLine.VALIDATE(ItemJournalLine."New Shortcut Dimension 2 Code", RecSalesInvHeader."Shortcut Dimension 2 Code");

        TrackingSpecification.RESET;
        TrackingSpecification.SETRANGE("Item No.", RecDefAcc."Given Maple Part Code");
        TrackingSpecification.SETRANGE("Location Code", RecDefAcc."Location Code");
        TrackingSpecification.SETRANGE("Quantity (Base)", RecDefAcc."Qty. Given");
        IF TrackingSpecification.FINDLAST THEN BEGIN
            ItemJournalLine.VALIDATE("Serial No.", TrackingSpecification."Serial No.");
            //MESSAGE('%1',ItemJournalLine."Serial No.")
        END;

        ReservationEntry.RESET;
        ReservationEntry.SETRANGE("Item No.", RecDefAcc."Given Maple Part Code");
        ReservationEntry.SETRANGE("Location Code", RecDefAcc."Location Code");
        ReservationEntry.SETRANGE("Source ID", 'RECLASS');
        ReservationEntry.SETRANGE("Source Batch Name", 'DEFAULT');
        IF ReservationEntry.FINDFIRST THEN
            REPEAT
                ReservationEntry."Source Ref. No." := ItemJournalLine."Line No.";
                ReservationEntry.MODIFY;
            UNTIL ReservationEntry.NEXT = 0;

        ItemJnlPost.RunWithCheck(ItemJournalLine);
    end;

    local procedure AssignSerialNumber()
    begin
        Rec.TESTFIELD("Given Maple Part Code");
        Rec.TESTFIELD("Qty. Given");
        Rec.TESTFIELD("Qty. Taken Back");
        Rec.TESTFIELD("Creation Date");
        Rec.TESTFIELD("Location Code");
        IF Rec."Qty. Given" <> Rec."Qty. Taken Back" THEN
            ERROR('Qty. Given is not equal to Qty. taken back');
        CallItemTracking(Rec);
    end;

    local procedure CallItemTracking(var RecDefAcc: Record 50008)
    var
        TrackingSpecification: Record 336;
        ItemTrackingPage: Page 6510;
        ItemJnlLine: Record 83;
    begin
        ItemTracking(RecDefAcc, TrackingSpecification);
        // ItemTrackingPage.SetFormRunMode(1);//tk
        //ItemTrackingPage.SetSource(TrackingSpecification, RecDefAcc."Creation Date");//tk
        ItemTrackingPage.SetInbound(ItemJnlLine.IsInbound);
        ItemTrackingPage.RUNMODAL;
    end;

    local procedure ItemTracking(var RecDefAcc: Record 50008; var TrackingSpecification: Record 336)
    begin
        IF RecDefAcc."Qty. Given" > 0 THEN BEGIN
            TrackingSpecification.INIT;
            TrackingSpecification."Source Type" := DATABASE::"Item Journal Line";
            TrackingSpecification."Item No." := RecDefAcc."Given Maple Part Code";
            TrackingSpecification."Location Code" := RecDefAcc."Location Code";
            TrackingSpecification."Source Subtype" := TrackingSpecification."Source Subtype"::"4";
            TrackingSpecification."Source ID" := 'RECLASS';
            TrackingSpecification."Source Batch Name" := 'DEFAULT';
            TrackingSpecification."Source Prod. Order Line" := 0;
            TrackingSpecification."Source Ref. No." := RecDefAcc."Line No.";
            TrackingSpecification."Quantity (Base)" := RecDefAcc."Qty. Given";
            TrackingSpecification."Qty. to Handle" := RecDefAcc."Qty. Given";
            TrackingSpecification."Qty. to Handle (Base)" := RecDefAcc."Qty. Given";
            TrackingSpecification."Qty. to Invoice" := RecDefAcc."Qty. Given";
            TrackingSpecification."Qty. to Invoice (Base)" := RecDefAcc."Qty. Given";
            TrackingSpecification."Quantity Handled (Base)" := 0;
            TrackingSpecification."Quantity Invoiced (Base)" := 0;
            TrackingSpecification."Qty. per Unit of Measure" := 1;
        END;
    end;

    local procedure GetLineNoIssue(ParaTemplate: Code[20]; ParaBatch: Code[20]): Integer
    var
        ParaItemJnl: Record 83;
    begin
        ParaItemJnl.RESET;
        ParaItemJnl.SETRANGE(ParaItemJnl."Journal Template Name", ParaTemplate);
        ParaItemJnl.SETRANGE(ParaItemJnl."Journal Batch Name", ParaBatch);
        IF ParaItemJnl.FINDLAST THEN
            EXIT(ParaItemJnl."Line No." + 10000)
        ELSE
            EXIT(10000);
    end;
}

