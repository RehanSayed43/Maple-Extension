pageextension 50096 "Item Tracking Lines" extends "Item Tracking Lines"
{
    layout
    {
        modify("Serial No.")
        {
            ApplicationArea = all;
            trigger OnAfterValidate()
            var
                CreateReservEntry: Codeunit 99000830;

            begin
                TrackingSpecidfication.Reset();
                TrackingSpecidfication.SetRange(TrackingSpecidfication."Item No.", Rec."Item No.");
                TrackingSpecidfication.SetRange(TrackingSpecidfication."Source ID", Rec."Source ID");
                TrackingSpecidfication.SetRange(TrackingSpecidfication."Source Ref. No.", Rec."Source Ref. No.");
                TrackingSpecidfication.SetRange(TrackingSpecidfication."Serial No.", Rec."Serial No.");
                IF TrackingSpecidfication.FindFirst() THEN BEGIN
                    TrackingSpecidfication."IMEI No." := Rec."IMEI No.";
                    TrackingSpecidfication."MRP Value" := Rec."MRP Value";
                    TrackingSpecidfication.Modify(false);
                END
                ELSE BEGIN
                    EntryNo += 1;
                    TrackingSpecidfication.INIT;
                    TrackingSpecidfication.TransferFields(Rec);
                    TrackingSpecidfication."Entry No." := EntryNo;
                    TrackingSpecidfication.Insert(FALSE);
                END;

                // IF ("IMEI No." <> xRec."IMEI No.") AND (xRec."IMEI No." <> '') THEN
                // BEGIN
                // CreateReservEntry.UpdReservEntryIMEI("Source Type","Source Subtype","Source ID","Source Batch Name","Source Prod. Order Line","Source Ref. No.","Qty. per Unit of Measure","Serial No.","Lot No.","IMEI No.");
                // END;//kajal changes

            end;
        }

        addafter("New Serial No.")
        {
            field("IMEI No."; Rec."IMEI No.")
            {
                ApplicationArea = all;
                // Editable = ExpirationDateEditable;//tk

                trigger OnValidate()
                var
                    CreateReservEntry: Codeunit 99000830;

                begin
                    TrackingSpecidfication.Reset();
                    TrackingSpecidfication.SetRange(TrackingSpecidfication."Item No.", Rec."Item No.");
                    TrackingSpecidfication.SetRange(TrackingSpecidfication."Source ID", Rec."Source ID");
                    TrackingSpecidfication.SetRange(TrackingSpecidfication."Source Ref. No.", Rec."Source Ref. No.");
                    TrackingSpecidfication.SetRange(TrackingSpecidfication."Serial No.", Rec."Serial No.");
                    IF TrackingSpecidfication.FindFirst() THEN BEGIN
                        TrackingSpecidfication."IMEI No." := Rec."IMEI No.";
                        TrackingSpecidfication."MRP Value" := Rec."MRP Value";
                        TrackingSpecidfication.Modify(false);
                    END
                    ELSE BEGIN
                        EntryNo += 1;
                        TrackingSpecidfication.INIT;
                        TrackingSpecidfication.TransferFields(Rec);
                        TrackingSpecidfication."Entry No." := EntryNo;
                        TrackingSpecidfication.Insert(FALSE);
                    END;

                    // IF ("IMEI No." <> xRec."IMEI No.") AND (xRec."IMEI No." <> '') THEN
                    // BEGIN
                    // CreateReservEntry.UpdReservEntryIMEI("Source Type","Source Subtype","Source ID","Source Batch Name","Source Prod. Order Line","Source Ref. No.","Qty. per Unit of Measure","Serial No.","Lot No.","IMEI No.");
                    // END;//kajal changes

                end;
            }
            field("MRP Value"; Rec."MRP Value")
            {
                ApplicationArea = all;
                //Editable = ExpirationDateEditable;
                trigger OnValidate()
                var
                    myInt: Integer;
                    CreateReservEntry: Codeunit 50057;
                    RecResEntry: Record "Reservation Entry";
                    RecResEntry1: Record "Reservation Entry";
                    IJ: Record "Item Journal Line";
                    RecPl: Record "Purchase Line";

                begin
                    //Message('Page Validate %1', Rec."Serial No.");
                    TrackingSpecidfication.Reset();
                    TrackingSpecidfication.SetRange(TrackingSpecidfication."Item No.", Rec."Item No.");
                    TrackingSpecidfication.SetRange(TrackingSpecidfication."Source ID", Rec."Source ID");
                    TrackingSpecidfication.SetRange(TrackingSpecidfication."Source Ref. No.", Rec."Source Ref. No.");
                    TrackingSpecidfication.SetRange(TrackingSpecidfication."Serial No.", Rec."Serial No.");
                    IF TrackingSpecidfication.FindFirst() THEN BEGIN
                        TrackingSpecidfication."IMEI No." := Rec."IMEI No.";
                        TrackingSpecidfication."MRP Value" := Rec."MRP Value";
                        TrackingSpecidfication.Modify(false);
                    END
                    ELSE BEGIN
                        EntryNo += 1;
                        TrackingSpecidfication.INIT;
                        TrackingSpecidfication.TransferFields(Rec);
                        TrackingSpecidfication."Entry No." := EntryNo;
                        TrackingSpecidfication.Insert(FALSE);
                    END;

                    IF (Rec."MRP Value" <> xRec."MRP Value") AND (xRec."MRP Value" <> 0) THEN BEGIN
                        CreateReservEntry.UpdReservEntryIMEI(Rec."Source Type", Rec."Source Subtype", Rec."Source ID", Rec."Source Batch Name", Rec."Source Prod. Order Line", Rec."Source Ref. No.", Rec."Qty. per Unit of Measure", Rec."Serial No.", Rec."Lot No.", Rec."MRP Value");
                    END;
                    RecResEntry.Reset();
                    RecPl.Reset();
                    RecResEntry.SetRange(RecResEntry."Source Type", 39);
                    RecResEntry.SetRange(RecResEntry."Source Subtype", 1);
                    RecResEntry.SetRange(RecResEntry."Source ID", RecPl."Document No.");
                    // //CCIT-TK
                    // RecResEntry1.Reset();
                    // IJ.Reset();
                    // RecResEntry1.SetRange(RecResEntry1."Source Type", 83);
                    // RecResEntry1.SetRange(RecResEntry1."Source Subtype", 2);
                    // RecResEntry1.SetRange(RecResEntry1."Source ID", IJ."Document No.")

                end;
            }
        }
    }

    actions
    {
        addafter("Create Customized SN")
        {
            action("Assign Specific Serial No.")
            {
                ApplicationArea = all;

                trigger OnAction()
                begin
                    IF InsertIsBlocked THEN
                        EXIT;
                    AssignSerialNoS;
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        ReservationEntry: Record "Reservation Entry";
        ILE: Record "Item Ledger Entry";
        ReservationEntry1: Record "Reservation Entry";
    BEGIN
        IF (Rec."Source Type" = 5741) and (rec."Source Prod. Order Line" = 0) then BEGIN
            ReservationEntry.Reset();
            ReservationEntry.SetRange(ReservationEntry."Serial No.", Rec."Serial No.");
            ReservationEntry.SetRange(ReservationEntry."Item No.", Rec."Item No.");
            ReservationEntry.SetRange(ReservationEntry."Source Type", Rec."Source Type");
            ReservationEntry.SetRange(ReservationEntry."Source ID", Rec."Source ID");
            ReservationEntry.SetRange(ReservationEntry."Source Ref. No.", Rec."Source Ref. No.");
            if ReservationEntry.FindFirst() then
                if ReservationEntry."MRP Value" <> 0 then
                    Rec."MRP Value" := ReservationEntry."MRP Value";
            // Rec."IMEI No." := ReservationEntry."IMEI No.";
        end;



        IF (Rec."Source Type" = 37) OR (Rec."Source Type" = 83) OR (Rec."Source Type" = 39) THEN BEGIN //TK added Negative OR  (Rec."Source Type" = 83 20823 adeeed source type 39
            ILE.Reset();
            //ILE.SetFilter(ILE."Entry Type", '%1|%2|%3', ILE."Entry Type"::Purchase, ILE."Entry Type"::"Positive Adjmt.", ILE."Entry Type"::Transfer);//np
            ILE.SetFILTER(ILE."Entry Type", '%1|%2|%3', ILE."Entry Type"::Purchase, ILE."Entry Type"::Transfer, ILE."Entry Type"::"Positive Adjmt.");
            //ILE.SetFilter("Remaining Quantity", '>%1', 0);
            ILE.SetRange(ILE."Item No.", Rec."Item No.");
            ILE.SetRange(ILE."Serial No.", Rec."Serial No.");
            ILE.SetRange(ILE."Location Code", Rec."Location Code");
            ILE.SetRange(ILE."Item Tracking", ILE."Item Tracking"::"Serial No.");
            IF ILE.FindFirst() THEN BEGIN
                // Rec.VALIDATE("IMEI No.", ILE."IMEI No.");//rV
                // Rec.VALIDATE("MRP Value", ILE."MRP Value");//rv
                Rec."IMEI No." := ILE."IMEI No.";
                Rec."MRP Value" := ILE."MRP Value";
                TrackingSpecidfication.Reset();
                TrackingSpecidfication.SetRange(TrackingSpecidfication."Item No.", Rec."Item No.");
                TrackingSpecidfication.SetRange(TrackingSpecidfication."Source ID", Rec."Source ID");
                TrackingSpecidfication.SetRange(TrackingSpecidfication."Source Ref. No.", Rec."Source Ref. No.");
                TrackingSpecidfication.SetRange(TrackingSpecidfication."Serial No.", Rec."Serial No.");
                IF TrackingSpecidfication.FindFirst() THEN BEGIN
                    TrackingSpecidfication."IMEI No." := Rec."IMEI No.";
                    TrackingSpecidfication."MRP Value" := Rec."MRP Value";
                    TrackingSpecidfication.Modify(false);
                END
                ELSE BEGIN
                    EntryNo += 1;
                    TrackingSpecidfication.INIT;
                    TrackingSpecidfication.TransferFields(Rec);
                    TrackingSpecidfication."Entry No." := EntryNo;
                    TrackingSpecidfication.Insert(FALSE);
                END;


            end;
        END;
        //Transfer Shipment--

        IF (Rec."Source Type" = 5741) and (rec."Source Prod. Order Line" = 0) then BEGIN
            ILE.Reset();
            ILE.SetFilter(ILE."Entry Type", '%1|%2|%3', ILE."Entry Type"::Purchase, ile."Entry Type"::"Positive Adjmt.", ILE."Entry Type"::Transfer);//np
            //  ILE.SetRange(ILE."Entry Type", ILE."Entry Type"::Purchase);
            //ILE.SetFilter("Remaining Quantity", '>%1', 0);//tk test
            ILE.SetRange(ILE."Item No.", Rec."Item No.");
            ILE.SetRange(ILE."Serial No.", Rec."Serial No.");
            ILE.SetRange(ILE."Location Code", Rec."Location Code");
            ILE.SetRange(ILE."Item Tracking", ILE."Item Tracking"::"Serial No.");
            IF ILE.FindFirst() THEN BEGIN
                // Rec.VALIDATE("IMEI No.", ILE."IMEI No.");//rV
                // Rec.VALIDATE("MRP Value", ILE."MRP Value");//rv
                Rec."IMEI No." := ILE."IMEI No.";
                Rec."MRP Value" := ILE."MRP Value";
                //Message('Current rec updated');
                TrackingSpecidfication.Reset();
                TrackingSpecidfication.SetRange(TrackingSpecidfication."Item No.", Rec."Item No.");
                TrackingSpecidfication.SetRange(TrackingSpecidfication."Source ID", Rec."Source ID");
                TrackingSpecidfication.SetRange(TrackingSpecidfication."Source Ref. No.", Rec."Source Ref. No.");
                TrackingSpecidfication.SetRange(TrackingSpecidfication."Serial No.", Rec."Serial No.");
                TrackingSpecidfication.SetFilter(TrackingSpecidfication."Source Prod. Order Line", '%1', Rec."Source Prod. Order Line");
                IF TrackingSpecidfication.FindFirst() THEN BEGIN
                    //  Message('Updated');
                    TrackingSpecidfication."IMEI No." := Rec."IMEI No.";
                    TrackingSpecidfication."MRP Value" := Rec."MRP Value";
                    //Message('TK', TrackingSpecidfication."MRP Value");
                    TrackingSpecidfication.Modify(false);
                END
                ELSE BEGIN
                    //Message('New');
                    EntryNo += 1;
                    TrackingSpecidfication.INIT;
                    TrackingSpecidfication.TransferFields(Rec);
                    TrackingSpecidfication."Entry No." := EntryNo;
                    TrackingSpecidfication.Insert(FALSE);
                END;


            end;
        END;
        IF Rec."Source Type" = 39 THEN BEGIN
            ReservationEntry.Reset();
            ReservationEntry.SetRange(ReservationEntry."Serial No.", Rec."Serial No.");
            ReservationEntry.SetRange(ReservationEntry."Item No.", Rec."Item No.");
            ReservationEntry.SetRange(ReservationEntry."Source Type", Rec."Source Type");
            ReservationEntry.SetRange(ReservationEntry."Source ID", Rec."Source ID");
            ReservationEntry.SetRange(ReservationEntry."Source Ref. No.", Rec."Source Ref. No.");
            IF ReservationEntry.FindFirst() THEN BEGIN
                Rec."IMEI No." := ReservationEntry."IMEI No.";
                Rec."MRP Value" := ReservationEntry."MRP Value";
            END;
        END;
        //CCIT-TK Item Journal Page
        IF Rec."Source Type" = 83 THEN BEGIN
            ReservationEntry.Reset();
            ReservationEntry.SetRange(ReservationEntry."Serial No.", Rec."Serial No.");
            ReservationEntry.SetRange(ReservationEntry."Item No.", Rec."Item No.");
            ReservationEntry.SetRange(ReservationEntry."Source Type", Rec."Source Type");
            ReservationEntry.SetRange(ReservationEntry."Source ID", Rec."Source ID");
            ReservationEntry.SetRange(ReservationEntry."Source Ref. No.", Rec."Source Ref. No.");
            IF ReservationEntry.FindFirst() THEN BEGIN
                Rec."IMEI No." := ReservationEntry."IMEI No.";
                Rec."MRP Value" := ReservationEntry."MRP Value";
            END;
        END;
        //CCIT-TK Flow to tracking on SO to ILE
        IF ((Rec."Source Type" = 5741) AND (Rec."Source Prod. Order Line" <> 0)) Then BEGIN//Or  THEN BEGIN
            ReservationEntry1.Reset();
            ReservationEntry1.SetRange(ReservationEntry1."Source Type", Rec."Source Type");
            ReservationEntry1.SetRange(ReservationEntry1."Source ID", Rec."Source ID");
            ReservationEntry1.SetRange(ReservationEntry1."Serial No.", Rec."Serial No.");
            ReservationEntry1.SetRange(ReservationEntry1."Item No.", Rec."Item No.");
            ReservationEntry1.SetRange(ReservationEntry1."Source Ref. No.", Rec."Source Ref. No.");
            IF ReservationEntry1.FindFirst() THEN BEGIN
                ReservationEntry1."IMEI No." := Rec."IMEI No.";
                ReservationEntry1."MRP Value" := Rec."MRP Value";
                //Message('TK', ReservationEntry1."MRP Value");
                ReservationEntry1.Modify(false);
            end;
        end;
        // END;//CCIT_TK
        IF ((Rec."Source Type" = 5741) AND (Rec."Source Prod. Order Line" = 0)) Then BEGIN//Or  THEN BEGIN
            ReservationEntry1.Reset();
            ReservationEntry1.SetRange(ReservationEntry1."Source Type", Rec."Source Type");
            ReservationEntry1.SetRange(ReservationEntry1."Source ID", Rec."Source ID");
            ReservationEntry1.SetRange(ReservationEntry1."Serial No.", Rec."Serial No.");
            ReservationEntry1.SetRange(ReservationEntry1."Item No.", Rec."Item No.");
            ReservationEntry1.SetRange(ReservationEntry1."Source Ref. No.", Rec."Source Ref. No.");
            IF ReservationEntry1.FindFirst() THEN BEGIN
                ReservationEntry1."IMEI No." := Rec."IMEI No.";
                ReservationEntry1."MRP Value" := Rec."MRP Value";
                //  Message('TK', ReservationEntry1."MRP Value");
                ReservationEntry1.Modify(true);
            end;
        end;
        // END;//CCIT_TK
    END;

    trigger OnClosePage()
    var
        ReservationEntry: Record "Reservation Entry";
        ReservationEntry1: Record "Reservation Entry";

    BEGIN
        //TrackingSpecidfication.copy(Rec);//RV
        //Message(' %1', TrackingSpecidfication);//RV
        TrackingSpecidfication.Reset();
        TrackingSpecidfication.SetRange(TrackingSpecidfication."Item No.", Rec."Item No.");
        TrackingSpecidfication.SetRange(TrackingSpecidfication."Source ID", Rec."Source ID");
        TrackingSpecidfication.SetRange(TrackingSpecidfication."Source Ref. No.", Rec."Source Ref. No.");
        IF TrackingSpecidfication.FindSet() THEN
            REPEAT
                //IF (TrackingSpecidfication."Source Type" = 39) OR (TrackingSpecidfication."Source Type" = 37) Or ((TrackingSpecidfication."Source Type" = 83)) then begin
                IF (TrackingSpecidfication."Source Type" = 39) OR (TrackingSpecidfication."Source Type" = 37) Or ((TrackingSpecidfication."Source Type" = 83)) OR ((TrackingSpecidfication."Source Type" = 5741) AND (TrackingSpecidfication."Source Prod. Order Line" = 0)) Then BEGIN//Or  THEN BEGIN
                    ReservationEntry.Reset();
                    ReservationEntry.SetRange(ReservationEntry."Serial No.", TrackingSpecidfication."Serial No.");
                    ReservationEntry.SetRange(ReservationEntry."Item No.", TrackingSpecidfication."Item No.");
                    ReservationEntry.SetRange(ReservationEntry."Source Type", TrackingSpecidfication."Source Type");
                    ReservationEntry.SetRange(ReservationEntry."Source ID", TrackingSpecidfication."Source ID");
                    ReservationEntry.SetRange(ReservationEntry."Source Ref. No.", TrackingSpecidfication."Source Ref. No.");
                    IF ReservationEntry.FindFirst() THEN BEGIN
                        ReservationEntry."IMEI No." := TrackingSpecidfication."IMEI No.";
                        ReservationEntry."MRP Value" := TrackingSpecidfication."MRP Value";
                        ReservationEntry.Modify(false);
                        //  Message('Reservation Entry Found');
                    END;
                END;

            UNTIL TrackingSpecidfication.Next() = 0;

        //  Message('%1', TrackingSpecidfication."Serial No.");
        TrackingSpecidfication.Reset();
        TrackingSpecidfication.SetRange(TrackingSpecidfication."Item No.", Rec."Item No.");
        TrackingSpecidfication.SetRange(TrackingSpecidfication."Source ID", Rec."Source ID");
        TrackingSpecidfication.SetRange(TrackingSpecidfication."Source Prod. Order Line", Rec."Source Ref. No.");
        IF TrackingSpecidfication.FindSet() THEN
            REPEAT
                //IF (TrackingSpecidfication."Source Type" = 39) OR (TrackingSpecidfication."Source Type" = 37) Or ((TrackingSpecidfication."Source Type" = 83)) then begin
                IF ((TrackingSpecidfication."Source Type" = 5741) AND (TrackingSpecidfication."Source Prod. Order Line" <> 0)) Then BEGIN//Or  THEN BEGIN
                    ReservationEntry.Reset();
                    ReservationEntry.SetRange(ReservationEntry."Serial No.", TrackingSpecidfication."Serial No.");
                    ReservationEntry.SetRange(ReservationEntry."Item No.", TrackingSpecidfication."Item No.");
                    ReservationEntry.SetRange(ReservationEntry."Source Type", TrackingSpecidfication."Source Type");
                    ReservationEntry.SetRange(ReservationEntry."Source ID", TrackingSpecidfication."Source ID");
                    ReservationEntry.SetRange(ReservationEntry."Source Prod. Order Line", TrackingSpecidfication."Source Ref. No.");
                    IF ReservationEntry.FindFirst() THEN BEGIN
                        ReservationEntry."IMEI No." := TrackingSpecidfication."IMEI No.";
                        ReservationEntry."MRP Value" := TrackingSpecidfication."MRP Value";
                        ReservationEntry.Modify(false);
                        //  Message('Reservation Entry Found');
                    END;

                END;

            UNTIL TrackingSpecidfication.Next() = 0;
        // Message('%3', Rec."Serial No.");
        // TrackingSpecidfication.Reset();
        // TrackingSpecidfication.SetRange(TrackingSpecidfication."Item No.", Rec."Item No.");
        // TrackingSpecidfication.SetRange(TrackingSpecidfication."Source ID", Rec."Source ID");
        // TrackingSpecidfication.SetRange(TrackingSpecidfication."Source Ref. No.", Rec."Source Ref. No.");
        // IF TrackingSpecidfication.FindSet() THEN
        //     REPEAT
        //         //IF (TrackingSpecidfication."Source Type" = 39) OR (TrackingSpecidfication."Source Type" = 37) Or ((TrackingSpecidfication."Source Type" = 83)) then begin
        //         IF ((TrackingSpecidfication."Source Type" = 5741) AND (TrackingSpecidfication."Source Prod. Order Line" = 0)) Then BEGIN//Or  THEN BEGIN
        //             ReservationEntry.Reset();
        //             ReservationEntry.SetRange(ReservationEntry."Serial No.", TrackingSpecidfication."Serial No.");
        //             ReservationEntry.SetRange(ReservationEntry."Item No.", TrackingSpecidfication."Item No.");
        //             ReservationEntry.SetRange(ReservationEntry."Source Type", TrackingSpecidfication."Source Type");
        //             ReservationEntry.SetRange(ReservationEntry."Source ID", TrackingSpecidfication."Source ID");
        //             ReservationEntry.SetRange(ReservationEntry."Source Ref. No.", TrackingSpecidfication."Source Ref. No.");
        //             IF ReservationEntry.FindFirst() THEN BEGIN
        //                 ReservationEntry."IMEI No." := TrackingSpecidfication."IMEI No.";
        //                 ReservationEntry."MRP Value" := TrackingSpecidfication."MRP Value";
        //                 ReservationEntry.Modify(False);
        //                 Message('Reservation Entry Found');
        //             END;

        //         END;

        //     UNTIL TrackingSpecidfication.Next() = 0;


    END;


    var
        myInt: Integer;
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        Text008: Label 'The quantity to create must be an integer.';
        Text009: Label 'quantity to create must be positive.';
        ItemTrackingDataCollection: Codeunit "Item Tracking Data Collection";

    procedure AssignSerialNoS()
    var
        EnterQuantityToCreate: Page 6513;
        QtyToCreate: Decimal;
        QtyToCreateInt: Integer;
        CreateLotNo: Boolean;
        CreatePackageNo: Boolean;
        CreateSNInfo: Boolean;
    begin
        IF ZeroLineExists THEN
            Rec.DELETE;

        QtyToCreate := UndefinedQtyArray[1] * QtySignFactor;
        IF QtyToCreate < 0 THEN
            QtyToCreate := 0;

        IF QtyToCreate MOD 1 <> 0 THEN
            ERROR(Text008);

        QtyToCreateInt := QtyToCreate;

        CLEAR(EnterQuantityToCreate);
        EnterQuantityToCreate.SetFields(Rec."Item No.", Rec."Variant Code", QtyToCreate, FALSE, FALSE);
        IF EnterQuantityToCreate.RUNMODAL = ACTION::OK THEN BEGIN
            EnterQuantityToCreate.GetFields(QtyToCreateInt, CreateLotNo, CreateSNInfo);
            AssignSerialNoBatchS(QtyToCreateInt, FALSE);
        END;
        //new 24
        /*
                EnterQuantityToCreate.SetFields(Rec."Item No.", Rec."Variant Code", QtyToCreate, FALSE, false, false);
                IF EnterQuantityToCreate.RUNMODAL = ACTION::OK THEN BEGIN
                    EnterQuantityToCreate.GetFields(QtyToCreateInt, CreateLotNo, CreatePackageNo, CreateSNInfo);
                    AssignSerialNoBatchS(QtyToCreateInt, FALSE);
                END;
        */
    end;

    procedure AssignSerialNoBatchS(QtyToCreate: Integer; CreateLotNo: Boolean)
    var

        itm: Record 27;
        i: Integer;
        j: Integer;
        SL: Record "Purchase Line";
        IJ: Record "Item Journal Line";
        ILE: Record "Item Ledger Entry";
    begin
        IF QtyToCreate <= 0 THEN
            ERROR(Text009);
        IF QtyToCreate MOD 1 <> 0 THEN
            ERROR(Text008);

        // GetItem("Item No.");
        itm.GET(Rec."Item No.");

        IF CreateLotNo THEN BEGIN
            Rec.TESTFIELD("Lot No.", '');
            Item.TESTFIELD("Lot Nos.");
            Rec.VALIDATE("Lot No.", NoSeriesMgt.GetNextNo(Item."Lot Nos.", WORKDATE, TRUE));
            Rec."Auto Generated" := true;//np
        END;

        //Item.TESTFIELD("Serial Nos.");
        ItemTrackingDataCollection.SetSkipLot(TRUE);
        FOR i := 1 TO QtyToCreate DO BEGIN
            Rec.VALIDATE("Quantity Handled (Base)", 0);
            Rec.VALIDATE("Quantity Invoiced (Base)", 0);
            Rec.VALIDATE("Serial No.", 'S' + Rec."Item No." + itm."Last No. Used");
            Rec.VALIDATE("Quantity (Base)", QtySignFactor);
            Rec."Entry No." := NextEntryNo;
            IF TestTempSpecificationExists THEN
                ERROR('');
            Rec.INSERT;
            TempItemTrackLineInsert.TRANSFERFIELDS(Rec);
            //>>RY

            IF Rec."Source Type" = 39 THEN BEGIN
                SL.Reset();
                SL.SetRange(SL."Document No.", Rec."Source ID");
                SL.SetRange(SL."Line No.", Rec."Source Ref. No.");
                IF SL.FindFirst() THEN BEGIN
                    //  Rec."IMEI No." := SL."IMEI No.";
                    Rec."MRP Value" := SL."MRP Value";
                END;
                //     //CCITK-++  Tacking Specication Table  to Item Journal table
                //     IF Rec."Source Type" = 83 THEN BEGIN
                //         IJ.Reset();
                //         IJ.SetRange(IJ."Journal Template Name", Rec."Source ID");
                //         IJ.SetRange(IJ."Journal Batch Name", rec."Source Batch Name");
                //         IJ.SetRange(IJ."Line No.", Rec."Source Ref. No.");
                //         IF IJ.FindFirst() THEN BEGIN
                //             //  Rec."IMEI No." := SL."IMEI No.";
                //             Rec."MRP Value" := IJ."MRP Value";
                //         END;
                //     end;
                //     //CCIT-TK--
            END;



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



            TrackingSpecidfication.Reset();
            TrackingSpecidfication.SetRange(TrackingSpecidfication."Item No.", Rec."Item No.");
            TrackingSpecidfication.SetRange(TrackingSpecidfication."Source ID", Rec."Source ID");
            TrackingSpecidfication.SetRange(TrackingSpecidfication."Source Ref. No.", Rec."Source Ref. No.");
            TrackingSpecidfication.SetRange(TrackingSpecidfication."Serial No.", Rec."Serial No.");
            IF TrackingSpecidfication.FindFirst() THEN BEGIN
                TrackingSpecidfication."IMEI No." := Rec."IMEI No.";
                TrackingSpecidfication."MRP Value" := Rec."MRP Value";
                TrackingSpecidfication.Modify(false);
            END
            ELSE BEGIN
                EntryNo += 1;
                TrackingSpecidfication.INIT;
                TrackingSpecidfication.TransferFields(Rec);

                TrackingSpecidfication."Entry No." := EntryNo;
                TrackingSpecidfication.Insert(FALSE);
            END;

            //<<RY
            EVALUATE(j, itm."Last No. Used", 1);
            j += 1;

            itm."Last No. Used" := FORMAT(j);
            IF STRLEN(itm."Last No. Used") = 1 THEN
                itm."Last No. Used" := '0000' + itm."Last No. Used"
            ELSE
                IF STRLEN(itm."Last No. Used") = 2 THEN
                    itm."Last No. Used" := '000' + itm."Last No. Used"
                ELSE
                    IF STRLEN(itm."Last No. Used") = 3 THEN
                        itm."Last No. Used" := '00' + itm."Last No. Used"
                    ELSE
                        IF STRLEN(itm."Last No. Used") = 4 THEN
                            itm."Last No. Used" := '0' + itm."Last No. Used";
            itm.MODIFY;
            TempItemTrackLineInsert.INSERT;
            IF i = QtyToCreate THEN
                ItemTrackingDataCollection.SetSkipLot(FALSE);
            ItemTrackingDataCollection.UpdateTrackingDataSetWithChange(TempItemTrackLineInsert, CurrentSignFactor * SourceQuantityArray[1] < 0, CurrentSignFactor, 0);
        END;
        CalculateSums;
    end;

    trigger OnOpenPage()
    BEGIN
        TrackingSpecidfication.DeleteAll();
        EntryNo := 0;
    END;

    trigger OnDeleteRecord(): Boolean
    BEGIN
        TrackingSpecidfication.Reset();
        TrackingSpecidfication.SetRange(TrackingSpecidfication."Item No.", Rec."Item No.");
        TrackingSpecidfication.SetRange(TrackingSpecidfication."Source ID", Rec."Source ID");
        TrackingSpecidfication.SetRange(TrackingSpecidfication."Source Ref. No.", Rec."Source Ref. No.");
        TrackingSpecidfication.SetRange(TrackingSpecidfication."Serial No.", Rec."Serial No.");
        IF TrackingSpecidfication.FindFirst() THEN
            TrackingSpecidfication.Delete(false);
    END;

    var
        TrackingSpecidfication: Record "Tracking Specification" temporary;
        EntryNo: Integer;
        FormRunMode: Option ,"Reclass","Combined Ship/Rcpt","Drop Shipment","Transfer";

    // //Defective Pafe Function
    // procedure SetFormRunMode(Mode: Option ,Reclass,"Combined Ship/Rcpt","Drop Shipment")
    // begin
    //     FormRunMode := Mode;
    // end;


    // procedure SetSource(TrackingSpecification: Record 336;AvailabilityDate: Date)
    // var
    //     ReservEntry: Record 337;
    //     TempTrackingSpecification: Record 336 temporary;
    //     TempTrackingSpecification2: Record 336 temporary;
    //     CreateReservEntry: Codeunit 99000830;
    //     Controls: Option Handle,Invoice,Quantity,Reclass,LotSN;
    // begin
    //     GetItem(TrackingSpecification."Item No.");
    //     ForBinCode := TrackingSpecification."Bin Code";
    //     "Serial No.":=TrackingSpecification."Serial No.";  //WIN336//WIN345
    //     SetFilters(TrackingSpecification);
    //     TempTrackingSpecification.DELETEALL;
    //     TempItemTrackLineInsert.DELETEALL;
    //     TempItemTrackLineModify.DELETEALL;
    //     TempItemTrackLineDelete.DELETEALL;

    //     TempReservEntry.DELETEALL;
    //     LastEntryNo := 0;
    //     IF ItemTrackingMgt.IsOrderNetworkEntity(TrackingSpecification."Source Type",
    //          TrackingSpecification."Source Subtype") AND NOT (FormRunMode = FormRunMode::"Drop Shipment")
    //     THEN
    //       CurrentEntryStatus := CurrentEntryStatus::Surplus
    //     ELSE
    //       CurrentEntryStatus := CurrentEntryStatus::Prospect;

    //     // Set controls for Qty to handle:
    //     SetControls(Controls::Handle,GetHandleSource(TrackingSpecification));
    //     // Set controls for Qty to Invoice:
    //     SetControls(Controls::Invoice,GetInvoiceSource(TrackingSpecification));

    //     SetControls(Controls::Reclass,FormRunMode = FormRunMode::Reclass);

    //     IF FormRunMode = FormRunMode::"Combined Ship/Rcpt" THEN
    //       SetControls(Controls::LotSN,FALSE);
    //     IF ItemTrackingMgt.ItemTrkgIsManagedByWhse(
    //          TrackingSpecification."Source Type",
    //          TrackingSpecification."Source Subtype",
    //          TrackingSpecification."Source ID",
    //          TrackingSpecification."Source Prod. Order Line",
    //          TrackingSpecification."Source Ref. No.",
    //          TrackingSpecification."Location Code",
    //          TrackingSpecification."Item No.")
    //     THEN BEGIN
    //       SetControls(Controls::Quantity,FALSE);
    //       "Qty. to Handle (Base)Editable" := TRUE;
    //       DeleteIsBlocked := TRUE;
    //     END;

    //     ReservEntry."Source Type" := TrackingSpecification."Source Type";
    //     ReservEntry."Source Subtype" := TrackingSpecification."Source Subtype";
    //     CurrentSignFactor := CreateReservEntry.SignFactor(ReservEntry);
    //     CurrentSourceCaption := ReservEntry.TextCaption;
    //     CurrentSourceType := ReservEntry."Source Type";

    //     IF CurrentSignFactor < 0 THEN BEGIN
    //       ExpectedReceiptDate := 0D;
    //       ShipmentDate := AvailabilityDate;
    //     END ELSE BEGIN
    //       ExpectedReceiptDate := AvailabilityDate;
    //       ShipmentDate := 0D;
    //     END;

    //     SourceQuantityArray[1] := TrackingSpecification."Quantity (Base)";
    //     SourceQuantityArray[2] := TrackingSpecification."Qty. to Handle (Base)";
    //     SourceQuantityArray[3] := TrackingSpecification."Qty. to Invoice (Base)";
    //     SourceQuantityArray[4] := TrackingSpecification."Quantity Handled (Base)";
    //     SourceQuantityArray[5] := TrackingSpecification."Quantity Invoiced (Base)";
    //     QtyPerUOM := TrackingSpecification."Qty. per Unit of Measure";

    //     ReservEntry.SETCURRENTKEY(
    //       "Source ID","Source Ref. No.","Source Type","Source Subtype",
    //       "Source Batch Name","Source Prod. Order Line","Reservation Status");

    //     ReservEntry.SETRANGE("Source ID",TrackingSpecification."Source ID");
    //     ReservEntry.SETRANGE("Source Ref. No.",TrackingSpecification."Source Ref. No.");
    //     ReservEntry.SETRANGE("Source Type",TrackingSpecification."Source Type");
    //     ReservEntry.SETRANGE("Source Subtype",TrackingSpecification."Source Subtype");
    //     ReservEntry.SETRANGE("Source Batch Name",TrackingSpecification."Source Batch Name");
    //     ReservEntry.SETRANGE("Source Prod. Order Line",TrackingSpecification."Source Prod. Order Line");

    //     // Transfer Receipt gets special treatment:
    //     IF (TrackingSpecification."Source Type" = DATABASE::"Transfer Line") AND
    //        (FormRunMode <> FormRunMode::Transfer) AND
    //        (TrackingSpecification."Source Subtype" = 1)
    //     THEN BEGIN
    //       ReservEntry.SETRANGE("Source Subtype",0);
    //       AddReservEntriesToTempRecSet(ReservEntry,TempTrackingSpecification2,TRUE,8421504);
    //       ReservEntry.SETRANGE("Source Subtype",1);
    //       ReservEntry.SETRANGE("Source Prod. Order Line",TrackingSpecification."Source Ref. No.");
    //       ReservEntry.SETRANGE("Source Ref. No.");
    //       DeleteIsBlocked := TRUE;
    //       SetControls(Controls::Quantity,FALSE);
    //     END;

    //     AddReservEntriesToTempRecSet(ReservEntry,TempTrackingSpecification,FALSE,0);

    //     TempReservEntry.COPYFILTERS(ReservEntry);

    //     TrackingSpecification.SETCURRENTKEY(
    //       "Source ID","Source Type","Source Subtype",
    //       "Source Batch Name","Source Prod. Order Line","Source Ref. No.");

    //     TrackingSpecification.SETRANGE("Source ID",TrackingSpecification."Source ID");
    //     TrackingSpecification.SETRANGE("Source Type",TrackingSpecification."Source Type");
    //     TrackingSpecification.SETRANGE("Source Subtype",TrackingSpecification."Source Subtype");
    //     TrackingSpecification.SETRANGE("Source Batch Name",TrackingSpecification."Source Batch Name");
    //     TrackingSpecification.SETRANGE("Source Prod. Order Line",TrackingSpecification."Source Prod. Order Line");
    //     TrackingSpecification.SETRANGE("Source Ref. No.",TrackingSpecification."Source Ref. No.");

    //     IF TrackingSpecification.FINDSET THEN
    //       REPEAT
    //         TempTrackingSpecification := TrackingSpecification;
    //         TempTrackingSpecification.INSERT;
    //       UNTIL TrackingSpecification.NEXT = 0;

    //     // Data regarding posted quantities on transfers is collected from Item Ledger Entries:
    //     IF TrackingSpecification."Source Type" = DATABASE::"Transfer Line" THEN
    //       CollectPostedTransferEntries(TrackingSpecification,TempTrackingSpecification);

    //     // Data regarding posted quantities on assembly orders is collected from Item Ledger Entries:
    //     IF NOT ExcludePostedEntries THEN
    //       IF (TrackingSpecification."Source Type" = DATABASE::"Assembly Line") OR
    //          (TrackingSpecification."Source Type" = DATABASE::"Assembly Header")
    //       THEN
    //         CollectPostedAssemblyEntries(TrackingSpecification,TempTrackingSpecification);

    //     // Data regarding posted output quantities on prod.orders is collected from Item Ledger Entries:
    //     IF TrackingSpecification."Source Type" = DATABASE::"Prod. Order Line" THEN
    //       IF TrackingSpecification."Source Subtype" = 3 THEN
    //         CollectPostedOutputEntries(TrackingSpecification,TempTrackingSpecification);

    //     // If run for Drop Shipment a RowID is prepared for synchronisation:
    //     IF FormRunMode = FormRunMode::"Drop Shipment" THEN
    //       CurrentSourceRowID := ItemTrackingMgt.ComposeRowID(TrackingSpecification."Source Type",
    //           TrackingSpecification."Source Subtype",TrackingSpecification."Source ID",
    //           TrackingSpecification."Source Batch Name",TrackingSpecification."Source Prod. Order Line",
    //           TrackingSpecification."Source Ref. No.");

    //     // Synchronization of outbound transfer order:
    //     IF (TrackingSpecification."Source Type" = DATABASE::"Transfer Line") AND
    //        (TrackingSpecification."Source Subtype" = 0)
    //     THEN BEGIN
    //       BlockCommit := TRUE;
    //       CurrentSourceRowID := ItemTrackingMgt.ComposeRowID(TrackingSpecification."Source Type",
    //           TrackingSpecification."Source Subtype",TrackingSpecification."Source ID",
    //           TrackingSpecification."Source Batch Name",TrackingSpecification."Source Prod. Order Line",
    //           TrackingSpecification."Source Ref. No.");
    //       SecondSourceRowID := ItemTrackingMgt.ComposeRowID(TrackingSpecification."Source Type",
    //           1,TrackingSpecification."Source ID",
    //           TrackingSpecification."Source Batch Name",TrackingSpecification."Source Prod. Order Line",
    //           TrackingSpecification."Source Ref. No.");
    //       FormRunMode := FormRunMode::Transfer;
    //     END;

    //     AddToGlobalRecordSet(TempTrackingSpecification);
    //     AddToGlobalRecordSet(TempTrackingSpecification2);
    //     CalculateSums;

    //     ItemTrackingDataCollection.SetCurrentBinAndItemTrkgCode(ForBinCode,ItemTrackingCode);
    //     ItemTrackingDataCollection.RetrieveLookupData(Rec,FALSE);

    //     FunctionsDemandVisible := CurrentSignFactor * SourceQuantityArray[1] < 0;
    //     FunctionsSupplyVisible := NOT FunctionsDemandVisible;
    // end;



}