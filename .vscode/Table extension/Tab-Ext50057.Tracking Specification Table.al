tableextension 50057 "Tracking Specification Table" extends "Tracking Specification"
{
    fields
    {
        field(50000; "IMEI No."; Code[20])
        {
            trigger OnValidate()
            BEGIN
                Rec.TestField("Serial No.");

            END;
        }
        field(50001; "Force Addition"; Boolean)
        {
            Description = 'kppl';
        }
        field(50033; "MRP Value"; Decimal)
        {
            Description = 'CCIT-TK';
            trigger OnValidate()
            BEGIN
                Rec.TestField("Serial No.");
            END;
        }
        field(50036; "Auto Generated"; Boolean)
        {

        }
        modify("Serial No.")
        {
            trigger OnAfterValidate()
            var
                ILE: Record "Item Ledger Entry";
                SL: Record "Purchase Line";
                IJ: Record "Item Journal Line";
                ReservationEntry1: Record 337;
                TrackingSpecidfication: Record "Tracking Specification";

            BEGIN
                IF Rec."Source Type" = 39 THEN BEGIN
                    SL.Reset();

                    SL.SetRange(SL."Document No.", Rec."Source ID");
                    SL.SetRange(SL."Line No.", Rec."Source Ref. No.");
                    IF SL.FindFirst() THEN BEGIN
                        //  Rec."IMEI No." := SL."IMEI No.";
                        Rec."MRP Value" := SL."MRP Value";

                    END;
                END;
                //Message('Validate');
                IF Rec."Source Type" = 37 THEN BEGIN
                    ILE.Reset();
                    ILE.SetRange(ILE."Entry Type", ILE."Entry Type"::Purchase);
                    ILE.SetRange(ILE."Item No.", Rec."Item No.");
                    ILE.SetRange(ILE."Serial No.", Rec."Serial No.");
                    ILE.SetRange(ILE."Location Code", Rec."Location Code");
                    ILE.SetRange(ILE."Item Tracking", ILE."Item Tracking"::"Serial No.");
                    IF ILE.FindFirst() THEN BEGIN
                        Rec."IMEI No." := ILE."IMEI No.";
                        Rec."MRP Value" := ILE."MRP Value";
                    end;
                END;
                // //CCIT-TK Item Journal ++
                IF Rec."Source Type" = 83 THEN BEGIN
                    IJ.Reset();
                    IJ.SetRange(IJ."Journal Template Name", Rec."Source ID");
                    IJ.SetRange(IJ."Journal Batch Name", rec."Source Batch Name");
                    IJ.SetRange(IJ."Line No.", Rec."Source Ref. No.");
                    IF IJ.FindFirst() THEN BEGIN
                        //  Rec."IMEI No." := SL."IMEI No.";
                        Rec."MRP Value" := IJ."MRP Value";

                    END;
                END;
                // //CCIT-TK--


                //Transfer Shipment Tracking Safe
                IF (Rec."Source Type" = 5741) and (rec."Source Prod. Order Line" = 0) THEN BEGIN
                    ILE.Reset();
                    ILE.SetFilter(ILE."Entry Type", '%1|%2', ILE."Entry Type"::Purchase, ILE."Entry Type"::Transfer);
                    ILE.SetRange(ILE."Item No.", Rec."Item No.");
                    ILE.SetRange(ILE."Serial No.", Rec."Serial No.");
                    ILE.SetRange(ILE."Location Code", Rec."Location Code");
                    ILE.SetRange(ILE."Item Tracking", ILE."Item Tracking"::"Serial No.");
                    IF ILE.FindFirst() THEN BEGIN
                        Rec."IMEI No." := ILE."IMEI No.";
                        Rec."MRP Value" := ILE."MRP Value";
                    end;
                END;
                //Transfer Shipment Tracking Safe

            End;






        }
    }
    //CCIT_TK++
    //CCIT_kj_ TrackSpec line update TASK++++++++++++++++++
    procedure ExistingIMEI(ItemNo: Code[20]; VariantCode: Code[20]; ItemTrackingSetup: Record "Item Tracking Setup"; TestMultiple: Boolean; var EntriesExist: Boolean): Code[20]
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        ItemTracingMgt: Codeunit "Item Tracing Mgt.";
        "Item Tracking Management": Codeunit "Item Tracking Management";
        Text007: Label 'There are multiple expiration dates registered for lot %1.';
    begin


        if not "Item Tracking Management".FindLastItemLedgerEntry(ItemNo, VariantCode, ItemTrackingSetup, ItemLedgEntry) then begin
            EntriesExist := false;
            exit;
        end;

        EntriesExist := true;
        "IMEI No." := ItemLedgEntry."IMEI No.";

        if TestMultiple and ItemTracingMgt.IsSpecificTracking(ItemNo, ItemTrackingSetup) then begin
            ItemLedgEntry.SetFilter("IMEI No.", '<>%1', ItemLedgEntry."IMEI No.");
            ItemLedgEntry.SetRange(Open, true);
            if not ItemLedgEntry.IsEmpty() then
                Error(Text007, ItemTrackingSetup."Lot No.");
        end;
    end;

    procedure ExistingMRP(ItemNo: Code[20]; VariantCode: Code[20]; ItemTrackingSetup: Record "Item Tracking Setup"; TestMultiple: Boolean; var EntriesExist: Boolean): Decimal
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        ItemTracingMgt: Codeunit "Item Tracing Mgt.";
        "Item Tracking Management": Codeunit "Item Tracking Management";
        Text007: Label 'There are multiple expiration dates registered for lot %1.';
    begin


        if not "Item Tracking Management".FindLastItemLedgerEntry(ItemNo, VariantCode, ItemTrackingSetup, ItemLedgEntry) then begin
            EntriesExist := false;
            exit;



        end;

        EntriesExist := true;
        "MRP Value" := ItemLedgEntry."MRP Value";

        if TestMultiple and ItemTracingMgt.IsSpecificTracking(ItemNo, ItemTrackingSetup) then begin
            ItemLedgEntry.SetFilter("MRP Value", '<>%1', ItemLedgEntry."MRP Value");
            ItemLedgEntry.SetRange(Open, true);
            if not ItemLedgEntry.IsEmpty() then
                Error(Text007, ItemTrackingSetup."Lot No.");
        end;
    end;
    //CCIT_kj_ TrackSpec line update TASK------------------------
    //TK -- 27 Jul 23
}
