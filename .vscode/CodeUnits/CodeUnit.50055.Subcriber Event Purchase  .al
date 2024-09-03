codeunit 50055 "Subcriber Event Purchase"
{
    trigger OnRun()
    begin

    end;





    [EventSubscriber(ObjectType::Page, Page::"Purchase Order", 'OnBeforeActionEvent', 'Post', true, true)]
    procedure OnBeforePostActionPurchaseOrder(var Rec: Record "Purchase Header")
    var
        PurchasePostViaJobQueue: Codeunit 98;
        PurchLine: Record 39;
        WBU: Codeunit 50000;
        PurchaseOrder: Page "Purchase Order";
    begin

        // Code Shifted on Purchase Line Item Serial No. Validation.
        /*
        DeletePurchSpecification(Rec);
        PurchLine.RESET;
        PurchLine.SETRANGE("Document Type","Document Type"::Order);
        PurchLine.SETFILTER("Document No.","No.");
        PurchLine.SETFILTER(PurchLine."Item Serial No",'<>%1','');
        IF PurchLine.FINDFIRST THEN BEGIN
        REPEAT
            UpdateSerialNo(PurchLine);
        UNTIL PurchLine.NEXT = 0;
        END;
        */
        IF Rec."Vendor Invoice Date" = 0D THEN
            ERROR('Vendor Invoice Date can not be blank');//Win-234 18-12-2019
        PurchLine.RESET;
        PurchLine.SETRANGE("Document Type", Rec."Document Type"::Order);
        PurchLine.SETFILTER("Document No.", Rec."No.");
        PurchLine.SETFILTER(Type, '%1', PurchLine.Type::Item);
        IF PurchLine.FINDSET THEN BEGIN
            REPEAT
                IF NOT PurchaseOrder.ReservEntryExistPurchLine(PurchLine) AND (PurchLine."UPN Code" = '') THEN BEGIN
                    IF (PurchLine."Qty. to Receive" <> 0) OR (PurchLine."Qty. to Invoice" <> 0) THEN
                        ERROR('Serial No. Or UPN Code required for Item %1', PurchLine."No.");
                END;
            UNTIL PurchLine.NEXT = 0;
        END;
        WBU.RefreshStatistics();
    end;

    [EventSubscriber(ObjectType::Page, Page::"Purchase Order", 'OnBeforeActionEvent', 'Post and &Print', true, true)]
    procedure OnBeforePostActionPostPrint(var Rec: Record "Purchase Header")
    var
        PurchasePostViaJobQueue: Codeunit 98;
        PurchLine: Record 39;
        WBU: Codeunit 50000;
        PurchaseOrder: Page "Purchase Order";
    begin

        IF Rec."Vendor Invoice Date" = 0D THEN
            ERROR('Vendor Invoice Date can not be blank');//Win-234 18-12-2019
                                                          //win344++
        PurchLine.RESET;
        PurchLine.SETRANGE("Document Type", Rec."Document Type"::Order);
        PurchLine.SETFILTER("Document No.", Rec."No.");
        PurchLine.SETFILTER(Type, '%1', PurchLine.Type::Item);
        IF PurchLine.FINDSET THEN BEGIN
            REPEAT
                IF NOT PurchaseOrder.ReservEntryExistPurchLine(PurchLine) AND (PurchLine."UPN Code" = '') THEN BEGIN
                    IF (PurchLine."Qty. to Receive" <> 0) OR (PurchLine."Qty. to Invoice" <> 0) THEN
                        ERROR('Serial No. Or UPN Code required for Item %1', PurchLine."No.");
                END;
            UNTIL PurchLine.NEXT = 0;
        END;

        WBU.RefreshStatistics();
        //win344-   end;
    end;

    //CodeUnit 90++

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostPurchaseDoc', '', false, false)]
    // local procedure OnBeforePostPurchaseDoc(var Sender: Codeunit "Purch.-Post"; var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; CommitIsSupressed: Boolean; var HideProgressWindow: Boolean; var ItemJnlPostLine: Codeunit "Item Jnl.-Post Line"; var IsHandled: Boolean);
    // var
    //     PurchHeader: Record "Purchase Header";
    // begin



    //     /*
    // IF ("Document Type"<> "Document Type"::"Return Order") OR ("Document Type" <> "Document Type"::"Credit Memo") THEN
    // IF "Vendor Invoice Date"=0D THEN
    //   ERROR('Vendor Invoice Date Can not be blank');//WIN234 04092020
    //   */
    //     // PurchHeader.COPY(PurchaseHeader);
    //     // WITH PurchHeader DO BEGIN
    //     //     IF RecVenda.GET(PurchHeader."Buy-from Vendor No.") THEN
    //     //         IF RecVenda."Vendor Posting Group" <> 'IMPORT' THEN BEGIN
    //     //             IF ("Document Type" = "Document Type"::Order) OR ("Document Type" = "Document Type"::Invoice) THEN BEGIN
    //     //                 RecPLLL.RESET;
    //     //                 RecPLLL.SETRANGE("Document No.", "No.");
    //     //                 RecPLLL.SETRANGE(Type, RecPLLL.Type::Item);

    //     //                 // RecPLLL.SETFILTER("TDS Group", '<>%1', RecPLLL."TDS Group"::TDSOnGoods);
    //     //                 IF RecPLLL.FINDFIRST THEN BEGIN
    //     //                     IF RecvaItem.GET(RecPLLL."No.") THEN
    //     //                         IF RecvaItem."Secondary category" <> 'APPLECAREPLUS' THEN //win234 20072021 As per Kailas mail
    //     //                            // ERROR('Select TDS nature of deduction for part code %1', RecPLLL."No.");
    //     //                 END;
    //     //             END;
    //     //         END;//WIN234 07072021

    //     // end;
    // end;

    //CodeUnit 90--
    /*
    //>>CodeUnit 91 PurchPostYesNo++
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnBeforeSelectPostOrderOption', '', false, false)]
    local procedure OnBeforeSelectPostOrderOption(var PurchaseHeader: Record "Purchase Header";
    DefaultOption: Integer;
    var Result: Boolean;
    var IsHandled: Boolean)
    var
        Selection: Integer;
        ReceiveInvoiceQst: Label '&Receive';
        recPurchHdr: Record "Purchase Header";
    begin
        //CCIT-Tk
        DefaultOption := 1;
        recPurchHdr := PurchaseHeader;
        recPurchHdr.Reset();
        recPurchHdr.SetRange("No.", PurchaseHeader."No.");
        recPurchHdr.SetRange("Document Type", PurchaseHeader."Document Type");
        if recPurchHdr.FindFirst() then begin
            Selection := StrMenu(ReceiveInvoiceQst, DefaultOption);
            if Selection = 0 then
                Result := false
            else
                Result := true;
            PurchaseHeader.Receive := Selection in [1, 3];
        end;
        IsHandled := true;
    end;

    //>>CodeUnit 1 PurchPostYesNo--

    */
    //Rahul
    [EventSubscriber(ObjectType::Table, database::"Tracking Specification", 'OnAfterValidateEvent', 'Serial No.', true, true)]
    local procedure OnAfterValidateEventPONo(CurrFieldNo: Integer; var Rec: Record "Tracking Specification"; var xRec: Record "Tracking Specification")
    var
        ReservationEntry: Record "Reservation Entry";
    BEGIN
        Rec.VALIDATE("Quantity (Base)", 1);//Win127

    END;

    //Rahul

    // item card on assist button
    [EventSubscriber(ObjectType::Table, Database::Item, 'OnBeforeAssistEdit', '', false, false)]
    local procedure OnBeforeAssistEdit(var Item: Record Item; var xItem: Record Item; var Result: Boolean; var IsHandled: Boolean);
    var

        ItemLocal: Record Item;
        SeriesL: Text[8];
        TmpNo: Code[20];
        LastSeriesNo: Code[20];
        LastNo: Integer;
    begin
        //IsHandled := true;
        IF Item."No." <> '' THEN BEGIN
            IF CONFIRM('Do you want to Change Item Code') THEN
                CLEAR(ItemSeriesPatteren)
            ELSE
                ERROR('');
        END
        ELSE
            CLEAR(ItemSeriesPatteren);
        ItemSeriesPatteren.LOOKUPMODE(TRUE);

        IF ItemSeriesPatteren.RUNMODAL = ACTION::LookupOK THEN BEGIN
            ItemSeriesPatteren.GETRECORD(ItemSeriesRec);
            SeriesL := COPYSTR(ItemSeriesRec."Item Category Code", 1, 3) + COPYSTR(ItemSeriesRec."Product Category", 1, 3);
            IF SeriesL <> '' THEN BEGIN
                ItemLocal.RESET;
                ItemLocal.SETCURRENTKEY(SeriesPattern, "No.");
                ItemLocal.SETFILTER(SeriesPattern, '%1', SeriesL);
                //  ItemLocal.SETFILTER("No.",'<>%1','');
                ItemLocal.SETFILTER("No.", '<>%1&<>%2', '', 'S');//win-234 18-06-2019
                IF ItemLocal.FINDLAST THEN BEGIN
                    LastSeriesNo := COPYSTR(ItemLocal."No.", 7);
                    EVALUATE(LastNo, LastSeriesNo);
                    LastNo := LastNo + 1;
                END
                ELSE
                    LastNo := 1001;

                LastSeriesNo := FORMAT(LastNo);
                Item."No." := SeriesL + LastSeriesNo;
                Item.SeriesPattern := SeriesL;
                Item."Item Category Code" := ItemSeriesRec."Item Category Code";
                Item."Product Category" := ItemSeriesRec."Product Category";

                DimMgt.UpdateDefaultDim(
                  DATABASE::Item, Item."No.",
                  Item."Global Dimension 1 Code", Item."Global Dimension 2 Code");


                // after adding new item was blocked Changes done by sandeep deshpande 14-05-14 //
                Item.VALIDATE(Blocked, TRUE);
                // RsComments.INIT;
                // RsComments."Table Name" := RsComments."Table Name"::Item;
                // RsComments."No." := Item."No.";
                // RsComments."Line No." := 10000;
                // RsComments.Date := WORKDATE;
                // RsComments.Comment := 'New Item Created by : ' + USERID;
                // RsComments.INSERT;//tk
                //customization ends

            END;

        END;
        //exit(true);
        exit;//tk


        //Updated WIN347--
    end;

    //item card tk

    var

        RsComments: Record "Comment Line";
        DimMgt: Codeunit "DimensionManagement";
        ItemSeriesRec: Record "Item";
        ItemSeriesPatteren: Page "Item Series Patteren";
        myInt: Integer;
        //CodeUnit90: Codeunit 90;
        RecPLLL: Record 39;
        RecvaItem: Record 27;
        RecVenda: Record 23;
    //CodeUnit90: Codeunit 90;
}