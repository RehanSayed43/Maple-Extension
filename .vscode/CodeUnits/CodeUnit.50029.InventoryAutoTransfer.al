codeunit 50029 "Inventory Auto Transfer"
{

    trigger OnRun()
    begin
        ProcessData;
    end;

    local procedure ProcessData()
    var
        Location: Record Location;//"14";
        ItemLedgerEntry: Record "Item Ledger Entry";//"32";
        FilterDate: Date;
        DocumentNo: Code[20];
        NoSeriesManagement: Codeunit NoSeriesManagement;//"396";
        LineNo: Integer;
        ItemJnlLine: Record "Item Journal Line";//"83";
        Item: Record Item;

    begin
        FilterDate := TODAY - 5;
        CLEAR(DocumentNo);
        CLEAR(LineNo);
        DocumentNo := NoSeriesManagement.GetNextNo3('INV-TRANS', TODAY, TRUE, FALSE);

        Location.RESET;
        Location.SETRANGE("Location Type", 9);
        Location.SETFILTER("Salable Location Code", '<>%1', '');
        IF Location.FINDSET THEN
            REPEAT
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE("Location Code", Location.Code);
                ItemLedgerEntry.SETFILTER("Remaining Quantity", '>%1', 0);
                ItemLedgerEntry.SETFILTER("Posting Date", '<%1', FilterDate);
                IF ItemLedgerEntry.FINDSET THEN
                    REPEAT
                        Item.RESET;
                        Item.SETRANGE("No.", ItemLedgerEntry."Item No.");
                        Item.SETRANGE(Blocked, FALSE);
                        IF Item.FINDFIRST THEN BEGIN
                            LineNo += 10000;
                            CreateReclassLines(DocumentNo, LineNo, Location."Salable Location Code", ItemLedgerEntry."Entry No.");
                        END;
                    UNTIL ItemLedgerEntry.NEXT = 0;
            UNTIL Location.NEXT = 0;

        //Posting
        ItemJnlLine.RESET;
        ItemJnlLine.SETRANGE("Inventory Transfer", TRUE);
        IF ItemJnlLine.FINDSET THEN
            CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", ItemJnlLine);
        //Posting


        //Delete Auto Created Line
        ItemJnlLine.RESET;
        ItemJnlLine.SETRANGE("Document No.", DocumentNo);
        IF ItemJnlLine.FINDSET THEN
            ItemJnlLine.DELETEALL;
    end;

    local procedure CreateReclassLines(ParamDocNo: Code[20]; ParamLine: Integer; ParamToLocation: Code[10]; ParamEntryNo: Integer)
    var
        ItemJournalLine: Record "Item Journal Line";//"83";
        ILE: Record "Item Ledger Entry";//"32";
        Item: Record Item;//"27";
    begin
        ILE.RESET;
        IF ILE.GET(ParamEntryNo) THEN BEGIN
            ItemJournalLine.RESET;
            ItemJournalLine.INIT;
            ItemJournalLine."Journal Batch Name" := 'DEFAULT';
            ItemJournalLine."Journal Template Name" := 'RECLASS';
            ItemJournalLine."Document No." := ParamDocNo;
            ItemJournalLine."Line No." := ParamLine;
            ItemJournalLine.VALIDATE("Posting Date", TODAY);
            ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::Transfer;
            ItemJournalLine.VALIDATE("Item No.", ILE."Item No.");
            ItemJournalLine.VALIDATE("Location Code", ILE."Location Code");
            ItemJournalLine.VALIDATE(Quantity, ILE."Remaining Quantity");
            IF ILE."Item Tracking" = ILE."Item Tracking"::None THEN
                ItemJournalLine.VALIDATE("Applies-to Entry", ILE."Entry No.");
            ItemJournalLine.VALIDATE("New Location Code", ParamToLocation);
            ItemJournalLine.VALIDATE("Shortcut Dimension 1 Code", ILE."Global Dimension 1 Code");
            ItemJournalLine.VALIDATE("Shortcut Dimension 2 Code", ILE."Global Dimension 2 Code");
            ItemJournalLine.VALIDATE("New Shortcut Dimension 1 Code", ILE."Global Dimension 1 Code");
            ItemJournalLine.VALIDATE("New Shortcut Dimension 2 Code", ILE."Global Dimension 2 Code");
            ItemJournalLine."Inventory Transfer" := TRUE;
            //Add Item Tracking Lines
            IF ILE."Item Tracking" <> ILE."Item Tracking"::None THEN BEGIN
                IF ILE."Serial No." <> '' THEN BEGIN
                    CreateInventoryAdjustmentItemTracking(ItemJournalLine, ILE."Serial No.");
                END;
            END;
            //Add Item Tracking Lines
            ItemJournalLine.INSERT;
        END;
    end;

    local procedure CreateInventoryAdjustmentItemTracking(ItemJnlLine: Record "Item Journal Line"; SerialNo: Code[20])
    var
        CreateReservEntry: Codeunit "Create Reserv. Entry";//"99000830";
    begin
    end;
}

