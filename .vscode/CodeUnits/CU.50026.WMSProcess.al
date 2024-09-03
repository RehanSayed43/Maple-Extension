codeunit 50026 "WMS Process"
{

    trigger OnRun()
    begin
        ProcessData;

        MESSAGE('Done');
    end;

    var
        Text001: Label 'WMS Order Posting  #1##########';
        Window: Dialog;
        Text002: Label 'There is nothing to Receive.';
        Text010: Label 'Item no. %1 does not belong to the %2 %3 ';
        Text031: Label 'You cannot define item tracking on this line because it is linked to production order %1.';
        Text003: Label 'WMS Order Error Checking  #1##########';
        Text004: Label 'WMS Order Posting  #1##########';
        PostedDocNo: Code[20];
        NAVDocNo: Code[20];
        ShortDim1: Label 'DELHI';
        ShortDim2: Label 'RETAIL';
        NAVDocLineNo: Integer;
        Text005: Label 'There is no transfer shipment against the document no. %1';
        Text006: Label 'Serial No. %1 does not belongs to original shipment, TO %2, Item %3.';
        Text008: Label 'There is nothing to Post.';
        JournalBatch: Label 'WMS';


    procedure ProcessData()
    var
        IntegrationData: Record 50029;
    begin
        IF GUIALLOWED THEN
            Window.OPEN(Text001);

        IntegrationData.RESET;
        IntegrationData.SETCURRENTKEY("Entry No.", "Document Type", "Document No.");
        IntegrationData.SETRANGE(IntegrationData.Posted, FALSE);
        IntegrationData.SETRANGE(IntegrationData."Found Error", FALSE);
        IntegrationData.SETRANGE(IntegrationData."Move to Posting", FALSE);
        IntegrationData.SETRANGE(IntegrationData."Sibling Error", FALSE);
        IF IntegrationData.FINDSET THEN
            REPEAT
                IF GUIALLOWED THEN
                    Window.UPDATE(1, IntegrationData."Document No.");

                ProcessLine(IntegrationData."Document No.", IntegrationData."Document Type");
                CheckDocument(IntegrationData."Document No.", IntegrationData."Document Type");
                PostDocument(IntegrationData."Document No.", IntegrationData."Document Type");

            UNTIL IntegrationData.NEXT = 0;
    end;


    procedure ProcessLine(DocNo: Code[20]; DocType: Option " ","Transfer Receipts","Transfer Shipments","Purchase Receipts","Positive Adjustment","Negative Adjustment")
    var
        IntegrationData: Record 50029;
        PurchaseHeader: Record 38;
        TransferHeader: Record 5740;
        IntegrationData2: Record 50029;
    begin
        IF GUIALLOWED THEN
            Window.OPEN(Text001);

        IntegrationData.RESET;
        IntegrationData.SETRANGE(IntegrationData."Document Type", DocType);
        IntegrationData.SETRANGE(IntegrationData."Document No.", DocNo);
        IntegrationData.SETRANGE(IntegrationData.Posted, FALSE);
        IntegrationData.SETRANGE(IntegrationData."Found Error", FALSE);
        IntegrationData.SETRANGE(IntegrationData."Move to Posting", FALSE);
        IntegrationData.SETRANGE(IntegrationData."Sibling Error", FALSE);
        IF IntegrationData.FINDSET THEN
            REPEAT
                IF GUIALLOWED THEN
                    Window.UPDATE(1, IntegrationData."Document No.");

                CLEARLASTERROR;
                CLEAR(NAVDocNo);
                CLEAR(NAVDocLineNo);

                //->PO
                IF IntegrationData."Document Type" = IntegrationData."Document Type"::"Purchase Receipts" THEN BEGIN
                    IF PurchaseHeader.GET(PurchaseHeader."Document Type"::Order, IntegrationData."Document No.") THEN BEGIN
                        IF NOT ProcessPO(PurchaseHeader, IntegrationData) THEN BEGIN
                            IntegrationData."Found Error" := TRUE;
                            IntegrationData."Response Message" := COPYSTR(GETLASTERRORTEXT, 1, 250);
                        END
                        ELSE BEGIN
                            IntegrationData."Move to Posting" := TRUE;
                            IntegrationData."Response Message" := '';
                            IntegrationData."NAV Document No." := NAVDocNo;
                            IntegrationData."NAV Document Line No." := NAVDocLineNo;
                        END;
                        IntegrationData.MODIFY;
                    END;
                END;
                //->PO

                //->Transfer Shipment
                IF IntegrationData."Document Type" = IntegrationData."Document Type"::"Transfer Shipments" THEN BEGIN
                    IF NOT ProcessTransferShipment(IntegrationData) THEN BEGIN
                        IntegrationData."Found Error" := TRUE;
                        IntegrationData."Response Message" := COPYSTR(GETLASTERRORTEXT, 1, 250);
                    END
                    ELSE BEGIN
                        IntegrationData."Move to Posting" := TRUE;
                        IntegrationData."Response Message" := '';
                        IntegrationData."NAV Document No." := NAVDocNo;
                        IntegrationData."NAV Document Line No." := NAVDocLineNo;
                    END;
                    IntegrationData.MODIFY;
                END;
                //<-Transfer Shipment

                //->Transfer Receipt
                IF IntegrationData."Document Type" = IntegrationData."Document Type"::"Transfer Receipts" THEN BEGIN
                    IntegrationData2.RESET;
                    IntegrationData2.SETRANGE(IntegrationData2."Document Type", IntegrationData2."Document Type"::"Transfer Shipments");
                    IntegrationData2.SETRANGE(IntegrationData2."Document No.", IntegrationData."Document No.");
                    IntegrationData2.SETFILTER(IntegrationData2."NAV Document No.", '<>%1', '');
                    IF IntegrationData2.FINDFIRST THEN BEGIN
                        IF TransferHeader.GET(IntegrationData2."NAV Document No.") THEN BEGIN
                            IF NOT ProcessTransferReceipt(TransferHeader, IntegrationData) THEN BEGIN
                                IntegrationData."Found Error" := TRUE;
                                IntegrationData."Response Message" := COPYSTR(GETLASTERRORTEXT, 1, 250);
                            END
                            ELSE BEGIN
                                IntegrationData."Move to Posting" := TRUE;
                                IntegrationData."Response Message" := '';
                                IntegrationData."NAV Document No." := NAVDocNo;
                                IntegrationData."NAV Document Line No." := NAVDocLineNo;
                            END;
                        END;
                    END
                    ELSE BEGIN
                        IntegrationData."Found Error" := TRUE;
                        IntegrationData."Response Message" := STRSUBSTNO(Text005, IntegrationData."Document No.");
                    END;
                    IntegrationData.MODIFY;
                END;
                //<-Transfer Receipt


                //->Positive Adjustment
                IF IntegrationData."Document Type" = IntegrationData."Document Type"::"Positive Adjustment" THEN BEGIN
                    CLEARLASTERROR;
                    IF NOT ProcessInventoryAdjustment(IntegrationData, 1) THEN BEGIN
                        IntegrationData."Found Error" := TRUE;
                        IntegrationData."Response Message" := COPYSTR(GETLASTERRORTEXT, 1, 250);
                    END
                    ELSE BEGIN
                        IntegrationData."Move to Posting" := TRUE;
                        IntegrationData."Response Message" := '';
                        IntegrationData."NAV Document No." := NAVDocNo;
                        IntegrationData."NAV Document Line No." := NAVDocLineNo;
                    END;
                    IntegrationData.MODIFY;
                END;
                //<-Positive Adjustment

                //->Negative Adjustment
                IF IntegrationData."Document Type" = IntegrationData."Document Type"::"Negative Adjustment" THEN BEGIN
                    CLEARLASTERROR;
                    IF NOT ProcessInventoryAdjustment(IntegrationData, 2) THEN BEGIN
                        IntegrationData."Found Error" := TRUE;
                        IntegrationData."Response Message" := COPYSTR(GETLASTERRORTEXT, 1, 250);
                    END
                    ELSE BEGIN
                        IntegrationData."Move to Posting" := TRUE;
                        IntegrationData."Response Message" := '';
                        IntegrationData."NAV Document No." := NAVDocNo;
                        IntegrationData."NAV Document Line No." := NAVDocLineNo;
                    END;
                    IntegrationData.MODIFY;
                END;
            //<-Negative Adjustment


            UNTIL IntegrationData.NEXT = 0;
    end;


    procedure CheckDocument(DocNo: Code[20]; DocType: Option " ","Transfer Receipts","Transfer Shipments","Purchase Receipts","Positive Adjustment","Negative Adjustment")
    var
        IntegrationData: Record 50029;
        IntegrationData2: Record 50029;
    begin
        IF GUIALLOWED THEN
            Window.OPEN(Text003);

        IntegrationData.RESET;
        IntegrationData.SETRANGE(IntegrationData."Document Type", DocType);
        IntegrationData.SETRANGE(IntegrationData."Document No.", DocNo);
        IntegrationData.SETRANGE(IntegrationData.Posted, FALSE);
        IntegrationData.SETRANGE(IntegrationData."Found Error", TRUE);
        IF IntegrationData.FINDFIRST THEN BEGIN
            IntegrationData2.RESET;
            IntegrationData2.SETRANGE(IntegrationData2."Document Type", IntegrationData."Document Type");
            IntegrationData2.SETRANGE(IntegrationData2."Document No.", IntegrationData."Document No.");
            IntegrationData2.SETFILTER(IntegrationData2."Entry No.", '<>%1', IntegrationData."Entry No.");
            IF IntegrationData2.FINDSET THEN BEGIN
                IntegrationData2.MODIFYALL(IntegrationData2."Found Error", IntegrationData."Found Error");
                IntegrationData2.MODIFYALL(IntegrationData2."Response Message", IntegrationData."Response Message");
                IntegrationData2.MODIFYALL(IntegrationData2."Sibling Error", TRUE);
            END;
        END;
    end;


    procedure PostDocument(DocNo: Code[20]; DocType: Option " ","Transfer Receipts","Transfer Shipments","Purchase Receipts","Positive Adjustment","Negative Adjustment")
    var
        IntegrationData: Record 50029;
        DocumentNo: Code[20];
        DocumentType: Option " ","Transfer Receipts","Transfer Shipments","Purchase Receipts","Positive Adjustment","Negative Adjustment";
        EntryNo: Integer;
        IntegrationData2: Record 50029;
        PurchaseHeader: Record 38;
        TransferHeader: Record 5740;
        ItemJournalLine: Record 83;
    begin
        IF GUIALLOWED THEN
            Window.OPEN(Text004);

        IntegrationData.RESET;
        IntegrationData.SETRANGE(IntegrationData."Document Type", DocType);
        IntegrationData.SETRANGE(IntegrationData."Document No.", DocNo);
        IntegrationData.SETRANGE(IntegrationData.Posted, FALSE);
        IntegrationData.SETRANGE(IntegrationData."Found Error", FALSE);
        IntegrationData.SETRANGE(IntegrationData."Move to Posting", TRUE);
        IntegrationData.SETRANGE(IntegrationData."Sibling Error", FALSE);
        IF IntegrationData.FINDSET THEN
            REPEAT
                IF GUIALLOWED THEN
                    Window.UPDATE(1, IntegrationData."Document No.");

                //->PO
                IF IntegrationData."Document Type" = IntegrationData."Document Type"::"Purchase Receipts" THEN BEGIN
                    IF (DocumentNo <> IntegrationData."Document No.") AND (DocumentType <> IntegrationData."Document Type") THEN BEGIN
                        DocumentNo := IntegrationData."Document No.";
                        DocumentType := IntegrationData."Document Type";
                        EntryNo := IntegrationData."Entry No.";
                        CLEARLASTERROR;
                        CLEAR(PostedDocNo);

                        IF PurchaseHeader.GET(PurchaseHeader."Document Type"::Order, IntegrationData."Document No.") THEN BEGIN
                            IF NOT PostPO(PurchaseHeader) THEN BEGIN
                                IntegrationData."Found Error" := TRUE;
                                IntegrationData."Response Message" := COPYSTR(GETLASTERRORTEXT, 1, 250);
                            END
                            ELSE BEGIN
                                IntegrationData.Posted := TRUE;
                                IntegrationData."Response Message" := '';
                                IntegrationData."NAV Posted No." := PostedDocNo;
                            END;
                            IntegrationData.MODIFY;
                        END;
                    END
                    ELSE BEGIN
                        IntegrationData2.RESET;
                        IF IntegrationData2.GET(EntryNo) THEN BEGIN
                            IntegrationData.Posted := IntegrationData2.Posted;
                            IntegrationData."Found Error" := IntegrationData2."Found Error";
                            IntegrationData."Response Message" := IntegrationData2."Response Message";
                            IntegrationData."NAV Posted No." := IntegrationData2."NAV Posted No.";
                            IntegrationData.MODIFY;
                        END;
                    END;
                END;
                //<-PO

                //->Transfer Shipment
                IF IntegrationData."Document Type" = IntegrationData."Document Type"::"Transfer Shipments" THEN BEGIN
                    IF (DocumentNo <> IntegrationData."Document No.") AND (DocumentType <> IntegrationData."Document Type") THEN BEGIN
                        DocumentNo := IntegrationData."Document No.";
                        DocumentType := IntegrationData."Document Type";
                        EntryNo := IntegrationData."Entry No.";
                        CLEARLASTERROR;
                        CLEAR(PostedDocNo);

                        IF TransferHeader.GET(IntegrationData."NAV Document No.") THEN BEGIN
                            IF NOT PostTransferShipment(TransferHeader) THEN BEGIN
                                IntegrationData."Found Error" := TRUE;
                                IntegrationData."Response Message" := COPYSTR(GETLASTERRORTEXT, 1, 250);
                            END
                            ELSE BEGIN
                                IntegrationData.Posted := TRUE;
                                IntegrationData."Response Message" := '';
                                IntegrationData."NAV Posted No." := PostedDocNo;
                            END;
                            IntegrationData.MODIFY;
                        END;
                    END
                    ELSE BEGIN
                        IntegrationData2.RESET;
                        IF IntegrationData2.GET(EntryNo) THEN BEGIN
                            IntegrationData.Posted := IntegrationData2.Posted;
                            IntegrationData."Found Error" := IntegrationData2."Found Error";
                            IntegrationData."Response Message" := IntegrationData2."Response Message";
                            IntegrationData."NAV Posted No." := IntegrationData2."NAV Posted No.";
                            IntegrationData.MODIFY;
                        END;
                    END;
                END;
                //<-Transfer Shipment

                //->Transfer Receipt
                IF IntegrationData."Document Type" = IntegrationData."Document Type"::"Transfer Receipts" THEN BEGIN
                    IF (DocumentNo <> IntegrationData."Document No.") AND (DocumentType <> IntegrationData."Document Type") THEN BEGIN
                        DocumentNo := IntegrationData."Document No.";
                        DocumentType := IntegrationData."Document Type";
                        EntryNo := IntegrationData."Entry No.";
                        CLEARLASTERROR;
                        CLEAR(PostedDocNo);

                        IF TransferHeader.GET(IntegrationData."NAV Document No.") THEN BEGIN
                            IF NOT PostTransferReceipt(TransferHeader) THEN BEGIN
                                IntegrationData."Found Error" := TRUE;
                                IntegrationData."Response Message" := COPYSTR(GETLASTERRORTEXT, 1, 250);
                            END
                            ELSE BEGIN
                                IntegrationData.Posted := TRUE;
                                IntegrationData."Response Message" := '';
                                IntegrationData."NAV Posted No." := PostedDocNo;
                            END;
                            IntegrationData.MODIFY;
                        END;
                    END
                    ELSE BEGIN
                        IntegrationData2.RESET;
                        IF IntegrationData2.GET(EntryNo) THEN BEGIN
                            IntegrationData.Posted := IntegrationData2.Posted;
                            IntegrationData."Found Error" := IntegrationData2."Found Error";
                            IntegrationData."Response Message" := IntegrationData2."Response Message";
                            IntegrationData."NAV Posted No." := IntegrationData2."NAV Posted No.";
                            IntegrationData.MODIFY;
                        END;
                    END;
                END;
                //<-Transfer Receipt

                //->Positive Adjustment
                IF IntegrationData."Document Type" = IntegrationData."Document Type"::"Positive Adjustment" THEN BEGIN
                    IF (DocumentNo <> IntegrationData."Document No.") AND (DocumentType <> IntegrationData."Document Type") THEN BEGIN
                        DocumentNo := IntegrationData."Document No.";
                        DocumentType := IntegrationData."Document Type";
                        EntryNo := IntegrationData."Entry No.";
                        CLEARLASTERROR;
                        CLEAR(PostedDocNo);

                        ItemJournalLine.RESET;
                        ItemJournalLine.SETRANGE(ItemJournalLine."Journal Template Name", 'ITEM');
                        ItemJournalLine.SETRANGE(ItemJournalLine."Journal Batch Name", JournalBatch);
                        ItemJournalLine.SETRANGE(ItemJournalLine."Entry Type", ItemJournalLine."Entry Type"::"Positive Adjmt.");
                        ItemJournalLine.SETRANGE(ItemJournalLine."Document No.", IntegrationData."NAV Document No.");
                        IF ItemJournalLine.FINDSET THEN BEGIN
                            IF NOT PostItemJnlLine(ItemJournalLine) THEN BEGIN
                                IntegrationData."Found Error" := TRUE;
                                IntegrationData."Response Message" := COPYSTR(GETLASTERRORTEXT, 1, 250);
                            END
                            ELSE BEGIN
                                IntegrationData.Posted := TRUE;
                                IntegrationData."Response Message" := '';
                                IntegrationData."NAV Posted No." := PostedDocNo;
                            END;
                            IntegrationData.MODIFY;
                        END;
                    END
                    ELSE BEGIN
                        IntegrationData2.RESET;
                        IF IntegrationData2.GET(EntryNo) THEN BEGIN
                            IntegrationData.Posted := IntegrationData2.Posted;
                            IntegrationData."Found Error" := IntegrationData2."Found Error";
                            IntegrationData."Response Message" := IntegrationData2."Response Message";
                            IntegrationData."NAV Posted No." := IntegrationData2."NAV Posted No.";
                            IntegrationData.MODIFY;
                        END;
                    END;
                END;
                //<-Positive Adjustment

                //->Negative Adjustment
                IF IntegrationData."Document Type" = IntegrationData."Document Type"::"Negative Adjustment" THEN BEGIN
                    IF (DocumentNo <> IntegrationData."Document No.") AND (DocumentType <> IntegrationData."Document Type") THEN BEGIN
                        DocumentNo := IntegrationData."Document No.";
                        DocumentType := IntegrationData."Document Type";
                        EntryNo := IntegrationData."Entry No.";
                        CLEARLASTERROR;
                        CLEAR(PostedDocNo);

                        ItemJournalLine.RESET;
                        ItemJournalLine.SETRANGE(ItemJournalLine."Journal Template Name", 'ITEM');
                        ItemJournalLine.SETRANGE(ItemJournalLine."Journal Batch Name", JournalBatch);
                        ItemJournalLine.SETRANGE(ItemJournalLine."Entry Type", ItemJournalLine."Entry Type"::"Negative Adjmt.");
                        ItemJournalLine.SETRANGE(ItemJournalLine."Document No.", IntegrationData."NAV Document No.");
                        IF ItemJournalLine.FINDSET THEN BEGIN
                            IF NOT PostItemJnlLine(ItemJournalLine) THEN BEGIN
                                IntegrationData."Found Error" := TRUE;
                                IntegrationData."Response Message" := COPYSTR(GETLASTERRORTEXT, 1, 250);
                            END
                            ELSE BEGIN
                                IntegrationData.Posted := TRUE;
                                IntegrationData."Response Message" := '';
                                IntegrationData."NAV Posted No." := PostedDocNo;
                            END;
                            IntegrationData.MODIFY;
                        END;
                    END
                    ELSE BEGIN
                        IntegrationData2.RESET;
                        IF IntegrationData2.GET(EntryNo) THEN BEGIN
                            IntegrationData.Posted := IntegrationData2.Posted;
                            IntegrationData."Found Error" := IntegrationData2."Found Error";
                            IntegrationData."Response Message" := IntegrationData2."Response Message";
                            IntegrationData."NAV Posted No." := IntegrationData2."NAV Posted No.";
                            IntegrationData.MODIFY;
                        END;
                    END;
                END;
            //<-Negative Adjustment


            UNTIL IntegrationData.NEXT = 0;
    end;

    // local procedure "----------------------------------------------------Purchase Receipt------------------------------------------------------------"()
    // begin
    // end;

    [TryFunction]
    local procedure ProcessPO(PH: Record 38; IntData: Record 50029)
    var
        PurchaseLine: Record 39;
        SerialNo: Text;
        TrimValue: Text;
        Item: Record 27;
    begin
        PurchaseLine.RESET;
        PurchaseLine.SETRANGE(PurchaseLine."Document Type", PH."Document Type");
        PurchaseLine.SETRANGE(PurchaseLine."Document No.", PH."No.");
        PurchaseLine.SETRANGE(PurchaseLine.Type, PurchaseLine.Type::Item);
        PurchaseLine.SETRANGE(PurchaseLine."No.", IntData."Item No.");
        IF PurchaseLine.FINDFIRST THEN BEGIN
            PurchaseLine.VALIDATE("Qty. to Receive", 0);
            PurchaseLine.VALIDATE("Qty. to Invoice", 0);

            PurchaseLine.VALIDATE("Qty. to Receive", IntData.Quantity);

            //Dimesion
            IF PurchaseLine."Shortcut Dimension 1 Code" = '' THEN
                PurchaseLine.VALIDATE("Shortcut Dimension 1 Code", ShortDim1);
            IF PurchaseLine."Shortcut Dimension 2 Code" = '' THEN
                PurchaseLine.VALIDATE("Shortcut Dimension 2 Code", ShortDim2);
            //Dimesion

            NAVDocNo := PurchaseLine."Document No.";
            NAVDocLineNo := PurchaseLine."Line No.";

            PurchaseLine.MODIFY;

            IF PurchaseLine."Qty. to Receive" = 0 THEN
                ERROR(Text002);

            //Add Item Tracking Lines
            Item.GET(PurchaseLine."No.");
            IF Item."Item Tracking Code" <> '' THEN BEGIN
                DeleteItemTracking(DATABASE::"Purchase Line", PurchaseLine."Document Type", PurchaseLine."Document No.", PurchaseLine."No.");
                SerialNo := IntData."Serial No.";
                WHILE SerialNo <> '' DO BEGIN
                    IF STRPOS(SerialNo, ',') > 0 THEN BEGIN
                        TrimValue := COPYSTR(SerialNo, 1, STRPOS(SerialNo, ',') - 1);
                        SerialNo := COPYSTR(SerialNo, STRPOS(SerialNo, ',') + 1, STRLEN(SerialNo));
                    END
                    ELSE BEGIN
                        TrimValue := SerialNo;
                        SerialNo := '';
                    END;
                    CreatePOItemTracking(PurchaseLine, TrimValue);
                END;
            END;
            //Add Item Tracking Lines

        END
        ELSE
            ERROR(Text010, IntData."Item No.", 'PO No.', IntData."Document No.");
    end;

    local procedure DeleteItemTracking(Type: Integer; Subtype: Integer; DocNo: Code[20]; ItemNo: Code[20])
    var
        ReservationEntry: Record 337;
    begin
        ReservationEntry.RESET;
        ReservationEntry.SETRANGE(ReservationEntry."Source Type", Type);
        ReservationEntry.SETRANGE(ReservationEntry."Source Subtype", Subtype);
        ReservationEntry.SETRANGE(ReservationEntry."Source ID", DocNo);
        ReservationEntry.SETRANGE(ReservationEntry."Item No.", ItemNo);
        IF ReservationEntry.FINDSET THEN BEGIN
            REPEAT
                ReservationEntry.DELETE;
            UNTIL ReservationEntry.NEXT = 0;
        END;
    end;

    local procedure CreatePOItemTracking(PL: Record 39; SerialNo: Code[20])
    var
        CreateReservEntry: Codeunit 99000830;
        ReservationEntry: Record "Reservation Entry";
    begin
        CreateReservEntry.CreateReservEntryFor(DATABASE::"Purchase Line", PL."Document Type", PL."Document No.", '', 0, PL."Line No.", PL."Qty. per Unit of Measure", 0, 1, ReservationEntry);
        CreateReservEntry.CreateEntry(PL."No.", PL."Variant Code", PL."Location Code", PL.Description, PL."Expected Receipt Date", 0D, 0, 2);
    end;

    [TryFunction]
    local procedure PostPO(PH: Record 38)
    var
        boolPost: Boolean;
        IntegrationData: Record 50029;
        PurchaseLine: Record 39;
    begin
        CLEAR(boolPost);
        PH.Receive := TRUE;
        PH.Invoice := FALSE;
        PH.VALIDATE("Posting Date", TODAY);
        PH.CRM := TRUE;

        //Dimesion
        IF PH."Shortcut Dimension 1 Code" = '' THEN
            PH.VALIDATE("Shortcut Dimension 1 Code", ShortDim1);
        IF PH."Shortcut Dimension 2 Code" = '' THEN
            PH.VALIDATE("Shortcut Dimension 2 Code", ShortDim2);
        //Dimesion

        PH.MODIFY;
        COMMIT;

        IF NOT CODEUNIT.RUN(CODEUNIT::"Purch.-Post", PH) THEN BEGIN
            ERROR(GETLASTERRORTEXT);
        END;
        PostedDocNo := PH."Last Receiving No.";
        PH."WMS Process" := TRUE;
        PH.MODIFY;
    end;

    // local procedure "---------------------------------------------------------Transfer Shipment------------------------------------------------------"()
    // begin
    // end;

    [TryFunction]
    local procedure ProcessTransferShipment(IntData: Record 50029)
    var
        IntegrationData: Record 50029;
        TransferHeader: Record 5740;
    begin
        IntegrationData.RESET;
        IntegrationData.SETRANGE(IntegrationData."Document Type", IntData."Document Type");
        IntegrationData.SETRANGE(IntegrationData."Document No.", IntData."Document No.");
        IntegrationData.SETFILTER(IntegrationData."NAV Document No.", '<>%1', '');
        IF IntegrationData.FINDFIRST THEN BEGIN
            TransferHeader.RESET;
            TransferHeader.GET(IntegrationData."NAV Document No.");
            NAVDocNo := TransferHeader."No.";
            CreateTransferLine(IntData, TransferHeader);
        END
        ELSE BEGIN
            CreateTransferOrder(IntData);
        END;

    end;

    local procedure CreateTransferOrder(IntData: Record 50029)
    var
        TransferHeader: Record 5740;
    begin
        TransferHeader.INIT;
        IF TransferHeader.INSERT(TRUE) THEN BEGIN
            NAVDocNo := TransferHeader."No.";
            TransferHeader.VALIDATE("Posting Date", TODAY);
            TransferHeader.VALIDATE("Transfer-from Code", IntData."From Location");
            TransferHeader.VALIDATE("Transfer-to Code", IntData."To Location");
            TransferHeader."Refreance No." := IntData."Document No.";
            TransferHeader.VALIDATE("Shortcut Dimension 1 Code", ShortDim1);
            TransferHeader.VALIDATE("Shortcut Dimension 2 Code", ShortDim2);
            TransferHeader.MODIFY;
        END;
        CreateTransferLine(IntData, TransferHeader);
    end;

    local procedure CreateTransferLine(IntData: Record 50029; TH: Record 5740)
    var
        TransferHeader: Record 5740;
        TransferLine: Record 5741;
        LineNo: Integer;
        SerialNo: Text;
        TrimValue: Text;
        Item: Record 27;
    begin
        CLEAR(LineNo);
        TransferLine.RESET;
        TransferLine.SETRANGE(TransferLine."Document No.", IntData."Document No.");
        IF TransferLine.FINDLAST THEN
            LineNo := TransferLine."Line No.";

        TransferLine.INIT;
        TransferLine."Document No." := TH."No.";
        TransferLine."Line No." := LineNo + 10000;
        TransferLine.VALIDATE("Item No.", IntData."Item No.");
        TransferLine.VALIDATE("Transfer-from Code", IntData."From Location");
        TransferLine.VALIDATE("Transfer-to Code", IntData."To Location");
        TransferLine.VALIDATE(Quantity, IntData.Quantity);
        TransferLine.VALIDATE("Shipment Date", TODAY);
        TransferLine.VALIDATE("Qty. to Ship", IntData.Quantity);
        TransferLine.VALIDATE("Shortcut Dimension 1 Code", ShortDim1);
        TransferLine.VALIDATE("Shortcut Dimension 2 Code", ShortDim2);
        TransferLine.INSERT(TRUE);

        //Add Item Tracking Lines
        Item.GET(TransferLine."Item No.");
        IF Item."Item Tracking Code" <> '' THEN BEGIN
            //DeleteItemTracking(DATABASE::"Transfer Line",0,TransferLine."Document No.",TransferLine."Item No.");
            SerialNo := IntData."Serial No.";
            WHILE SerialNo <> '' DO BEGIN
                IF STRPOS(SerialNo, ',') > 0 THEN BEGIN
                    TrimValue := COPYSTR(SerialNo, 1, STRPOS(SerialNo, ',') - 1);
                    SerialNo := COPYSTR(SerialNo, STRPOS(SerialNo, ',') + 1, STRLEN(SerialNo));
                END
                ELSE BEGIN
                    TrimValue := SerialNo;
                    SerialNo := '';
                END;
                CreateTransfertItemTracking(TransferLine, TrimValue, 0);
            END;
        END;
        //Add Item Tracking Lines

        NAVDocNo := TransferLine."Document No.";
        NAVDocLineNo := TransferLine."Line No.";
    end;

    local procedure CreateTransfertItemTracking(TL: Record 5741; SerialNo: Code[20]; Direction: Option Outbound,Inbound)
    var
        CreateReservEntry: Codeunit 99000830;
        ReservationEntry: Record "Reservation Entry";
    begin
        CASE Direction OF
            Direction::Outbound:
                BEGIN
                    CreateReservEntry.CreateReservEntryFor(DATABASE::"Transfer Line", 0, TL."Document No.", '', TL."Derived From Line No.", TL."Line No.", TL."Qty. per Unit of Measure", 0, 1, ReservationEntry);
                    //   CreateReservEntry.CreateReservEntryFor(DATABASE::"Transfer Line", 0, "Document No.", '', "Derived From Line No.", "Line No.", "Qty. per Unit of Measure", 0, 1, SerialNo, '');
                    CreateReservEntry.CreateEntry(TL."Item No.", TL."Variant Code", TL."Transfer-from Code", TL.Description, 0D, TL."Shipment Date", 0, 2);

                    CreateReservEntry.CreateReservEntryFor(DATABASE::"Transfer Line", 0, TL."Document No.", '', TL."Derived From Line No.", TL."Line No.", TL."Qty. per Unit of Measure", 0, -1, ReservationEntry);
                    //CreateReservEntry.CreateReservEntryFor(DATABASE::"Transfer Line", 0, "Document No.", '', "Derived From Line No.", "Line No.", "Qty. per Unit of Measure", 0, -1, SerialNo, '');
                    CreateReservEntry.CreateEntry(TL."Item No.", TL."Variant Code", TL."Transfer-to Code", TL.Description, TL."Receipt Date", 0D, 0, 2);
                END;
            Direction::Inbound:
                BEGIN
                    CreateReservEntry.CreateReservEntryFor(DATABASE::"Transfer Line", 1, TL."Document No.", '', TL."Derived From Line No.", TL."Line No.", TL."Qty. per Unit of Measure", 0, 1, ReservationEntry);
                    //CreateReservEntry.CreateReservEntryFor(DATABASE::"Transfer Line", 1, "Document No.", '', "Derived From Line No.", "Line No.", "Qty. per Unit of Measure", 0, 1, SerialNo, '');
                    CreateReservEntry.CreateEntry(TL."Item No.", TL."Variant Code", TL."Transfer-to Code", TL.Description, TL."Receipt Date", 0D, 0, 2);
                END;
        END;
    end;

    [TryFunction]
    local procedure PostTransferShipment(TH: Record 5740)
    var
        TransferPostShipment: Codeunit 5704;
        ReservationEntry: Record 337;
    begin

        ReservationEntry.RESET;
        ReservationEntry.SETRANGE(ReservationEntry."Source Type", DATABASE::"Transfer Line");
        ReservationEntry.SETRANGE(ReservationEntry."Source ID", TH."No.");
        ReservationEntry.SETRANGE(ReservationEntry."Location Code", TH."Transfer-to Code");
        IF ReservationEntry.FINDSET THEN
            ReservationEntry.MODIFYALL(ReservationEntry."Source Subtype", 1);

        COMMIT;
        IF NOT CODEUNIT.RUN(CODEUNIT::"TransferOrder-Post Shipment", TH) THEN BEGIN
            ERROR(GETLASTERRORTEXT);
        END;
        PostedDocNo := TH."Last Shipment No.";
        TH."WMS Process" := TRUE;
        TH.MODIFY;
    end;

    // local procedure "----------------------------------------------------------Transfer Receipt------------------------------------------------------"()
    // begin
    // end;

    [TryFunction]
    local procedure ProcessTransferReceipt(var TH: Record 5740; IntData: Record 50029)
    var
        TransferLine: Record 5741;
        SerialNo: Text;
        TrimValue: Text;
        Item: Record 27;
    begin
        TransferLine.RESET;
        TransferLine.SETRANGE(TransferLine."Document No.", TH."No.");
        TransferLine.SETRANGE(TransferLine."Item No.", IntData."Item No.");
        IF TransferLine.FINDFIRST THEN BEGIN
            TransferLine.VALIDATE("Qty. to Receive", 0);
            TransferLine.VALIDATE("Qty. to Receive", IntData.Quantity);

            NAVDocNo := TransferLine."Document No.";
            NAVDocLineNo := TransferLine."Line No.";

            TransferLine.MODIFY;

            IF TransferLine."Qty. to Receive" = 0 THEN
                ERROR(Text002);

            //Check Item Tracking Lines
            Item.GET(TransferLine."Item No.");
            IF Item."Item Tracking Code" <> '' THEN BEGIN
                SerialNo := IntData."Serial No.";
                WHILE SerialNo <> '' DO BEGIN
                    IF STRPOS(SerialNo, ',') > 0 THEN BEGIN
                        TrimValue := COPYSTR(SerialNo, 1, STRPOS(SerialNo, ',') - 1);
                        SerialNo := COPYSTR(SerialNo, STRPOS(SerialNo, ',') + 1, STRLEN(SerialNo));
                    END
                    ELSE BEGIN
                        TrimValue := SerialNo;
                        SerialNo := '';
                    END;
                    IF NOT CheckItemTracking(TransferLine, TrimValue, 1) THEN
                        ERROR(Text006, TrimValue, TransferLine."Document No.", TransferLine."Item No.");
                END;
            END;
            //Check Item Tracking Lines
        END
        ELSE
            ERROR(Text010, IntData."Item No.", 'Transfer Order', TH."No.");
    end;

    local procedure CheckItemTracking(TL: Record 5741; SerialNo: Code[20]; Direction: Option Outbound,Inbound): Boolean
    var
        ReservationEntry: Record 337;
    begin
        ReservationEntry.RESET;
        ReservationEntry.SETRANGE(ReservationEntry."Source Type", DATABASE::"Transfer Line");
        ReservationEntry.SETRANGE(ReservationEntry."Source Subtype", Direction);
        ReservationEntry.SETRANGE(ReservationEntry."Source ID", TL."Document No.");
        ReservationEntry.SETRANGE(ReservationEntry."Location Code", TL."Transfer-to Code");
        ReservationEntry.SETRANGE(ReservationEntry."Item No.", TL."Item No.");
        ReservationEntry.SETRANGE(ReservationEntry."Serial No.", SerialNo);
        IF ReservationEntry.FINDSET THEN
            EXIT(TRUE)
        ELSE
            EXIT(FALSE);
    end;

    [TryFunction]
    local procedure PostTransferReceipt(TH: Record 5740)
    var
        TransferPostReceipt: Codeunit 5705;
        TransferReceiptHeader: Record 5746;
        TransOrderNo: Code[20];
    begin
        TransOrderNo := TH."No.";
        TH."WMS Process" := TRUE;
        TH.MODIFY;
        COMMIT;
        IF NOT CODEUNIT.RUN(CODEUNIT::"TransferOrder-Post Receipt", TH) THEN BEGIN
            ERROR(GETLASTERRORTEXT);
        END;
        TransferReceiptHeader.RESET;
        TransferReceiptHeader.SETRANGE(TransferReceiptHeader."Transfer Order No.", TransOrderNo);
        IF TransferReceiptHeader.FINDLAST THEN
            PostedDocNo := TransferReceiptHeader."No.";
    end;

    // local procedure "-----------------------------------------------------------Inventory Adjustment-------------------------------------------------"()
    // begin
    // end;

    [TryFunction]
    local procedure ProcessInventoryAdjustment(IntData: Record 50029; EntryType: Option " ","Positive Adjustment","Negative Adjustment")
    var
        ItemJournalLine: Record 83;
        LineNo: Integer;
        ItemJnlLine: Record 83;
        SerialNo: Text;
        TrimValue: Text;
        Item: Record 27;
    begin
        CLEAR(LineNo);
        ItemJournalLine.RESET;
        ItemJournalLine.SETRANGE(ItemJournalLine."Journal Template Name", 'ITEM');
        ItemJournalLine.SETRANGE(ItemJournalLine."Journal Batch Name", JournalBatch);
        IF ItemJournalLine.FINDLAST THEN
            LineNo := ItemJournalLine."Line No.";

        IF IntData.Quantity = 0 THEN
            ERROR(Text002);

        LineNo += 10000;
        ItemJournalLine.RESET;
        ItemJournalLine.INIT;
        ItemJournalLine."Journal Template Name" := 'ITEM';
        ItemJournalLine."Journal Batch Name" := JournalBatch;
        ItemJournalLine."Line No." := LineNo;
        IF EntryType = EntryType::"Positive Adjustment" THEN
            ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::"Positive Adjmt."
        ELSE
            IF EntryType = EntryType::"Negative Adjustment" THEN
                ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::"Negative Adjmt.";
        ItemJournalLine.VALIDATE(ItemJournalLine."Posting Date", TODAY);
        ItemJournalLine."Document No." := IntData."Document No.";
        ItemJournalLine.VALIDATE(ItemJournalLine."Item No.", IntData."Item No.");
        ItemJournalLine.VALIDATE(ItemJournalLine.Quantity, ABS(IntData.Quantity));
        ItemJournalLine.VALIDATE(ItemJournalLine."Location Code", IntData."From Location");
        ItemJournalLine.VALIDATE(ItemJournalLine."Shortcut Dimension 1 Code", ShortDim1);
        ItemJournalLine.VALIDATE(ItemJournalLine."Shortcut Dimension 2 Code", ShortDim2);
        ItemJournalLine."WMS Process" := TRUE;
        ItemJournalLine.INSERT;

        //Add Item Tracking Lines
        Item.GET(ItemJournalLine."Item No.");
        IF Item."Item Tracking Code" <> '' THEN BEGIN
            SerialNo := IntData."Serial No.";
            WHILE SerialNo <> '' DO BEGIN
                IF STRPOS(SerialNo, ',') > 0 THEN BEGIN
                    TrimValue := COPYSTR(SerialNo, 1, STRPOS(SerialNo, ',') - 1);
                    SerialNo := COPYSTR(SerialNo, STRPOS(SerialNo, ',') + 1, STRLEN(SerialNo));
                END
                ELSE BEGIN
                    TrimValue := SerialNo;
                    SerialNo := '';
                END;
                CreateInventoryAdjustmentItemTracking(ItemJournalLine, TrimValue);
            END;
        END;
        //Add Item Tracking Lines

        NAVDocNo := ItemJournalLine."Document No.";
        NAVDocLineNo := ItemJournalLine."Line No.";
    end;

    local procedure CreateInventoryAdjustmentItemTracking(ItemJnlLine: Record 83; SerialNo: Code[20])
    var
        CreateReservEntry: Codeunit 99000830;
        ReservationEntry: Record "Reservation Entry";
    begin
        CreateReservEntry.CreateReservEntryFor(DATABASE::"Item Journal Line", ItemJnlLine."Entry Type", ItemJnlLine."Journal Template Name", ItemJnlLine."Journal Batch Name", 0, ItemJnlLine."Line No.", ItemJnlLine."Qty. per Unit of Measure", 0, 1, ReservationEntry);
        // CreateReservEntry.CreateReservEntryFor(DATABASE::"Item Journal Line", "Entry Type", "Journal Template Name", "Journal Batch Name", 0, "Line No.", "Qty. per Unit of Measure", 0, 1, SerialNo, '');
        IF ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::"Positive Adjmt." THEN
            CreateReservEntry.CreateEntry(ItemJnlLine."Item No.", ItemJnlLine."Variant Code", ItemJnlLine."Location Code", ItemJnlLine.Description, ItemJnlLine."Posting Date", 0D, 0, 3)
        ELSE
            IF ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::"Negative Adjmt." THEN
                CreateReservEntry.CreateEntry(ItemJnlLine."Item No.", ItemJnlLine."Variant Code", ItemJnlLine."Location Code", ItemJnlLine.Description, 0D, ItemJnlLine."Posting Date", 0, 3);


    end;

    [TryFunction]
    local procedure PostItemJnlLine(ItemJnlLine: Record 83)
    var
        ItemJournalLine: Record 83;
        EntryType: Integer;
    begin
        PostedDocNo := ItemJnlLine."Document No.";
        EntryType := ItemJnlLine."Entry Type";
        COMMIT;
        IF NOT CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post Batch", ItemJnlLine) THEN BEGIN
            ERROR(GETLASTERRORTEXT);
        END;

        ItemJournalLine.RESET;
        ItemJournalLine.RESET;
        ItemJournalLine.SETRANGE(ItemJournalLine."Journal Template Name", 'ITEM');
        ItemJournalLine.SETRANGE(ItemJournalLine."Journal Batch Name", JournalBatch);
        ItemJournalLine.SETRANGE(ItemJournalLine."Document No.", PostedDocNo);
        ItemJournalLine.SETRANGE(ItemJournalLine."Entry Type", EntryType);
        IF ItemJournalLine.FINDSET THEN
            ItemJournalLine.DELETEALL;
    end;
}

