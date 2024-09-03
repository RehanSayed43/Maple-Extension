codeunit 50145 testIMEI
{
    /*

        //CCIT_kj_ TrackSpec line update TASK+++++++++++++++++++++++

        //  [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterCreateReservEntryFor', '', false, false)]
        //  local procedure OnAfterCreateReservEntryFor(var CreateReservEntry: Codeunit "Create Reserv. Entry"; var NewTrackingSpecification: Record "Tracking Specification"; var OldTrackingSpecification: Record "Tracking Specification")
        //  begin
        //      OldTrackingSpecification."IMEI No." := NewTrackingSpecification."IMEI No.";
        //      OldTrackingSpecification."MRP Value" := NewTrackingSpecification."MRP Value";
        //  end;//tk

        //  OnAfterCopyTrackingSpec
        // [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterCopyTrackingSpec', '', false, false)]
        // local procedure OnAfterCopyTrackingSpec(var DestTrkgSpec: Record "Tracking Specification"; var SourceTrackingSpec: Record "Tracking Specification")
        // begin
        //     DestTrkgSpec."IMEI No." := SourceTrackingSpec."IMEI No.";
        //     DestTrkgSpec."MRP Value" := SourceTrackingSpec."MRP Value";
        // end;/tk kajal code commented

        // OnRegisterChangeOnAfterModify
        [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnRegisterChangeOnAfterModify', '', false, false)]
        local procedure OnRegisterChangeOnAfterModify(var NewTrackingSpecification: Record "Tracking Specification"; var OldTrackingSpecification: Record "Tracking Specification"; var SavedOldTrackingSpecification: Record "Tracking Specification")
        begin
            OldTrackingSpecification."IMEI No." := '';
            OldTrackingSpecification."MRP Value" := 0;
        end;
        //Tk
        // // OnAfterEntriesAreIdentical
        // [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterEntriesAreIdentical', '', false, false)]
        // local procedure OnAfterEntriesAreIdentical(var IdenticalArray: array[2] of Boolean; ReservEntry1: Record "Reservation Entry"; ReservEntry2: Record "Reservation Entry")
        // begin
        //     Clear(IdenticalArray[2]);
        //     IdenticalArray[2] :=
        //         (ReservEntry1.Description = ReservEntry2.Description) and
        //         (ReservEntry1."Expiration Date" = ReservEntry2."Expiration Date") and
        //         (ReservEntry1."Warranty Date" = ReservEntry2."Warranty Date") and
        //         (ReservEntry1."New Expiration Date" = ReservEntry2."New Expiration Date") and
        //         (ReservEntry1."IMEI No." = ReservEntry2."IMEI No.") and
        //         (ReservEntry1."MRP Value" = ReservEntry2."MRP Value") and
        //         ReservEntry1.HasSameNewTracking(ReservEntry2);
        // end;//tk

        //OnAfterMoveFields
        [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterMoveFields', '', false, false)]
        local procedure OnAfterMoveFields(var ReservEntry: Record "Reservation Entry"; var TrkgSpec: Record "Tracking Specification")
        begin
            ReservEntry."IMEI No." := TrkgSpec."IMEI No.";
            ReservEntry."MRP Value" := TrkgSpec."MRP Value";
        end;

        //OnRegisterItemTrackingLinesOnBeforeInsert
        [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnRegisterItemTrackingLinesOnBeforeInsert', '', false, false)]
        local procedure OnRegisterItemTrackingLinesOnBeforeInsert(var TempTrackingSpecification: Record "Tracking Specification" temporary; SourceTrackingSpecification: Record "Tracking Specification"; var TrackingSpecification: Record "Tracking Specification")
        begin
            TrackingSpecification."IMEI No." := TempTrackingSpecification."IMEI No.";
            TrackingSpecification."MRP Value" := TempTrackingSpecification."MRP Value";
        end;

        //OnSetupTempSplitItemJnlLineOnBeforeCalcPostItemJnlLine - codeunit 22 "Item Jnl.-Post Line"
        [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnSetupTempSplitItemJnlLineOnBeforeCalcPostItemJnlLine', '', false, false)]
        local procedure OnSetupTempSplitItemJnlLineOnBeforeCalcPostItemJnlLine(var TempSplitItemJnlLine: Record "Item Journal Line"; TempTrackingSpecification: Record "Tracking Specification")
        begin
            TempSplitItemJnlLine."IMEI No." := TempTrackingSpecification."IMEI No.";
            TempSplitItemJnlLine."MRP Value" := TempTrackingSpecification."MRP Value";
        end;

        // OnAfterInitItemLedgEntry
        [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitItemLedgEntry', '', false, false)]
        local procedure OnAfterInitItemLedgEntry(var ItemJournalLine: Record "Item Journal Line"; var ItemLedgEntryNo: Integer; var NewItemLedgEntry: Record "Item Ledger Entry")
        begin
            NewItemLedgEntry."IMEI No." := ItemJournalLine."IMEI No.";
            NewItemLedgEntry."MRP Value" := ItemJournalLine."MRP Value";
        end;


        //OnBeforeAddToGlobalRecordSet

        [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnBeforeAddToGlobalRecordSet', '', false, false)]
        local procedure OnBeforeAddToGlobalRecordSet(var TempTrackingSpecification: Record "Tracking Specification" temporary; var TrackingSpecification: Record "Tracking Specification"; CurrentSignFactor: Integer; EntriesExist: Boolean)
        var
            ItemTrackingSetup: Record "Item Tracking Setup";
            IMEINO: Code[20];
            MRPVal: Decimal;
        begin
            Clear(MRPVal);
            Clear(IMEINO);
            IMEINO := TrackingSpecification.ExistingIMEI(TrackingSpecification."Item No.", TrackingSpecification."Variant Code", ItemTrackingSetup, false, EntriesExist);
            MRPVal := TrackingSpecification.ExistingMRP(TrackingSpecification."Item No.", TrackingSpecification."Variant Code", ItemTrackingSetup, false, EntriesExist);
            if IMEINO <> '' then
                TrackingSpecification."IMEI No." := IMEINO;
            if MRPVal > 0 then
                TrackingSpecification."MRP Value" := MRPVal;
        end;
        //OnAfterInitExpirationDate
        [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnRegisterChangeOnAfterFullDelete', '', true, true)]
        local procedure OnRegisterChangeOnAfterFullDelete(var ReservEntry: Record "Reservation Entry"; var NewTrackingSpecification: Record "Tracking Specification"; var OldTrackingSpecification: Record "Tracking Specification"; CurrentPageIsOpen: Boolean)
        var
            CreateReservEntryFor: Codeunit 99000830;

        begin

            IF OldTrackingSpecification."IMEI No." <> '' THEN
                ReservEntry."IMEI No." := OldTrackingSpecification."IMEI No.";
            ReservEntry."MRP Value" := OldTrackingSpecification."MRP Value";
        end;


        //
    *///Kajal Changes

    //TK ++New Code
    [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", 'OnAfterCopyNewTrackingFromNewTrackingSpec', '', false, false)]
    local procedure OnAfterCopyNewTrackingFromNewTrackingSpec(var TrackingSpecification: Record "Tracking Specification"; FromTrackingSpecification: Record "Tracking Specification");
    begin
        TrackingSpecification."IMEI No." := FromTrackingSpecification."IMEI No.";
        TrackingSpecification."MRP Value" := FromTrackingSpecification."MRP Value";

    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnRegisterChangeOnChangeTypeModifyOnBeforeCheckEntriesAreIdentical', '', false, false)]
    local procedure OnRegisterChangeOnChangeTypeModifyOnBeforeCheckEntriesAreIdentical(var ReservEntry1: Record "Reservation Entry"; var ReservEntry2: Record "Reservation Entry"; var OldTrackingSpecification: Record "Tracking Specification"; var NewTrackingSpecification: Record "Tracking Specification"; var IdenticalArray: array[2] of Boolean);
    begin
        ReservEntry1."IMEI No." := ReservEntry2."IMEI No.";
        ReservEntry2."MRP Value" := ReservEntry2."MRP Value";
    end;


    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterCopyTrackingSpec', '', false, false)]
    local procedure OnAfterCopyTrackingSpec(var DestTrkgSpec: Record "Tracking Specification"; var SourceTrackingSpec: Record "Tracking Specification")
    begin
        DestTrkgSpec."IMEI No." := SourceTrackingSpec."IMEI No.";
        DestTrkgSpec."MRP Value" := SourceTrackingSpec."MRP Value";
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterCreateReservEntryFor', '', false, false)]
    local procedure OnAfterCreateReservEntryFor(var CreateReservEntry: Codeunit "Create Reserv. Entry"; var NewTrackingSpecification: Record "Tracking Specification"; var OldTrackingSpecification: Record "Tracking Specification")
    var
        CreateRes: Codeunit 50145;
    begin
        CreateRes.AddIMENO(NewTrackingSpecification."IMEI No.");
        CreateRes.AddMRPV(NewTrackingSpecification."MRP Value");

        // OldTrackingSpecification."IMEI No." := NewTrackingSpecification."IMEI No.";
        // OldTrackingSpecification."MRP Value" := NewTrackingSpecification."MRP Value";
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnSelectEntriesOnAfterTransferFields', '', false, false)]
    local procedure OnSelectEntriesOnAfterTransferFields(var TempTrackingSpec: Record "Tracking Specification" temporary; var TrackingSpecification: Record "Tracking Specification");
    begin
        TempTrackingSpec."IMEI No." := TrackingSpecification."IMEI No.";
        TempTrackingSpec."MRP Value" := TrackingSpecification."MRP Value";
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnRegisterItemTrackingLinesOnAfterReclass', '', false, false)]
    local procedure OnRegisterItemTrackingLinesOnAfterReclass(var TrackingSpecification: Record "Tracking Specification"; TempTrackingSpecification: Record "Tracking Specification" temporary);
    begin
        TrackingSpecification."IMEI No." := TempTrackingSpecification."IMEI No.";
        TrackingSpecification."MRP Value" := TempTrackingSpecification."MRP Value";
    end;






    procedure AddIMENO(FROMIMENO: Code[20]);
    begin
        InsertReservEntry."IMEI No." := FROMIMENO;
    end;

    procedure AddMRPV(FROMMRPV: Decimal);
    begin
        InsertReservEntry."MRP Value" := FROMMRPV;
    end;

    var
        InsertReservEntry: Record 337;
        CreteReCo: Codeunit 99000830;


    //TK-- Code
}
