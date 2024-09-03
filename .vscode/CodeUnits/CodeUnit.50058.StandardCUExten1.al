codeunit 50058 StandardCUExten1
{
    //Transfer TK++ Flow Field In posted Table
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnAfterInsertTransShptHeader', '', false, false)]
    local procedure OnAfterInsertTransShptHeader(var TransferHeader: Record "Transfer Header"; var TransferShipmentHeader: Record "Transfer Shipment Header");
    begin
        TransferShipmentHeader."Handover To Name" := TransferHeader."Handover To Name";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnAfterInsertTransRcptHeader', '', false, false)]
    local procedure OnAfterInsertTransRcptHeader(var TransRcptHeader: Record "Transfer Receipt Header"; var TransHeader: Record "Transfer Header");
    begin
        TransRcptHeader."Handover To Name" := TransRcptHeader."Handover To Name";
    end;
    //Transfer TK++Flow Field In posted Table

    //Transfer Validation On Post CCIT-TK ++
    //FINAL LOcation Filter Validation


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforeOnRun', '', true, true)]
    local procedure OnBeforeOnRunReceipt(var TransferHeader2: Record "Transfer Header"; HideValidationDialog: Boolean; SuppressCommit: Boolean; var IsHandled: Boolean)
    var
        RecUserSetup: Record "User Setup";
        RecUserSetup1: Record "User Setup";
    begin
        RecUserSetup.RESET;
        RecUserSetup.SETRANGE("User ID", USERID);
        RecUserSetup.SETRANGE("All Location Transfer", FALSE);
        IF RecUserSetup.FINDFIRST THEN BEGIN
            RecUserSetup1.RESET;
            RecUserSetup1.SETRANGE("User ID", USERID);
            RecUserSetup1.SETFILTER("Location Filter", '%1', '*' + TransferHeader2."Transfer-to Code" + '*');
            IF NOT RecUserSetup1.FINDFIRST THEN
                ERROR('You are not Authorised to Receive Transfer Order.');
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnBeforeOnRun', '', true, true)]
    local procedure OnBeforeOnRunShipment(var TransferHeader: Record "Transfer Header"; var HideValidationDialog: Boolean; var SuppressCommit: Boolean; var IsHandled: Boolean)
    var
        RecUserSetup: Record "User Setup";
        RecUserSetup1: Record "User Setup";
    begin
        RecUserSetup.RESET;
        RecUserSetup.SETRANGE("User ID", USERID);
        RecUserSetup.SETRANGE("All Location Transfer", FALSE);
        IF RecUserSetup.FINDFIRST THEN BEGIN
            RecUserSetup1.RESET;
            RecUserSetup1.SETRANGE("User ID", USERID);
            RecUserSetup1.SETFILTER("Location Filter", '%1', '*' + TransferHeader."Transfer-from Code" + '*');
            IF NOT RecUserSetup1.FINDFIRST THEN
                ERROR('You are not Authorised to Ship Transfer Order.');
        END;
    end;


    /////////////////////////////CODEUNIT 22///////////////////////////////+++++++++++++++

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitItemLedgEntry', '', true, true)]
    local procedure CheckOnAfterInitItemLedgEntry(var ItemJournalLine: Record "Item Journal Line"; var ItemLedgEntryNo: Integer; var NewItemLedgEntry: Record "Item Ledger Entry")

    begin


        //WIN316++ GST UPGRADE
        NewItemLedgEntry."Primary category" := ItemJournalLine."Primary category";
        NewItemLedgEntry."Secondary category" := ItemJournalLine."Secondary category";
        NewItemLedgEntry."Third category" := ItemJournalLine."Third category";
        NewItemLedgEntry."UPN Code" := ItemJournalLine."UPN Code";
        NewItemLedgEntry."New External Document No " := ItemJournalLine."New External Document No ";
        //WIN316-- GST UPGRADE
        //WIN316++GST UPGRADE
        //ItemJournalLine.TestField(ItemJournalLine."MRP Value");//Validation
        NewItemLedgEntry."IMEI No." := ItemJournalLine."IMEI No.";//Win127
        NewItemLedgEntry."MRP Value" := ItemJournalLine."MRP Value";//tk
        NewItemLedgEntry."Scheme Code" := ItemJournalLine."Scheme Code";
        NewItemLedgEntry."Scheme Amount" := ItemJournalLine."Scheme Amount";
        NewItemLedgEntry."New External Document No " := ItemJournalLine."New External Document No ";
        //WIN316--GST UPGRADE
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInsertValueEntry', '', true, true)]
    local procedure checkOnAfterInsertValueEntry(var ItemLedgerEntry: Record "Item Ledger Entry"; var ValueEntry: Record "Value Entry")
    var
        ItemJournalLine: Record "Item Journal Line";
    begin
        //WIN316++GST UPGRADE
        //Win127
        ValueEntry."Primary category" := ItemJournalLine."Primary category";
        ValueEntry."Secondary category" := ItemJournalLine."Secondary category";
        ValueEntry."Third category" := ItemJournalLine."Third category";
        //
        ValueEntry."Scheme Code" := ItemJournalLine."Scheme Code";
        ValueEntry."Scheme Amount" := ItemJournalLine."Scheme Amount";
        ValueEntry."New External Document No " := ItemJournalLine."New External Document No ";
        //WIN316-- GST UPGRADE
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterCreateItemJnlLineFromEntry', '', true, true)]
    local procedure CheckOnAfterCreateItemJnlLineFromEntry(var ItemJournalLine: Record "Item Journal Line"; ItemLedgerEntry: Record "Item Ledger Entry")
    begin
        //ItemLedgerEntry.TestField(ItemLedgerEntry."MRP Value");
        //WIN316++ GST UPGRADE
        ItemJournalLine."IMEI No." := ItemLedgerEntry."IMEI No.";
        ItemJournalLine."MRP Value" := ItemLedgerEntry."MRP Value";//tk
        ItemJournalLine."New External Document No " := ItemLedgerEntry."New External Document No ";
        //WIN316-- GST UPGRADE
    end;

    /*  
    Codeunit::"Item Jnl.-Post Line"     Event not found //CCIT_kj
 local procedure InsertAsmItemEntryRelation(ItemLedgerEntry: Record "Item Ledger Entry")
 begine
  //WIN316++GST UPGRADE
            TempItemEntryRelation."IMEI No." := ItemLedgerEntry."IMEI No.";
            //WIN316--GST UPGRADE
            end;
    */

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterSetupTempSplitItemJnlLineSetQty', '', true, true)]
    local procedure CheckOnAfterSetupTempSplitItemJnlLineSetQty(var TempSplitItemJnlLine: Record "Item Journal Line" temporary; ItemJournalLine: Record "Item Journal Line"; var TempTrackingSpecification: Record "Tracking Specification" temporary)
    begin
        //WIN316++ GST UPGDARE
        TempSplitItemJnlLine."IMEI No." := TempTrackingSpecification."IMEI No.";
        TempSplitItemJnlLine."MRP Value" := TempTrackingSpecification."MRP Value";//tk
        //WIN316-- GST UPGRADE
    end;

    /////////////////////////////CODEUNIT 22///////////////////////////////--------------------------

    //////////////////////////////////////CU231//////////////+++++++++++++++++++++++++++++++++++++
    //>>Commented JV
    /* 
        [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post", 'OnCodeOnAfterCheckTemplate', '', true, true)]
        local procedure CheckOnCodeOnAfterCheckTemplate(var GenJnlLine: Record "Gen. Journal Line")
        var
            Text001: Label 'Do you want to post the journal lines?';
            PreviewMode: Boolean;
        begin
            //win316++
            IF (GenJnlLine."Order ID" = '') AND (GenJnlLine.CRM = FALSE) THEN BEGIN
                IF NOT PreviewMode THEN
                    IF NOT CONFIRM(Text001, FALSE) THEN
                        EXIT;
            END;
            //win316--
        end;



        [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post", 'OnBeforeShowPostResultMessage', '', true, true)]
        local procedure CheckOnBeforeShowPostResultMessage(var GenJnlLine: Record "Gen. Journal Line"; TempJnlBatchName: Code[10]; var IsHandled: Boolean)
        var
            Text002: Label 'There is nothing to post.';
            Text003: Label 'The journal lines were successfully posted.';
            Text004: Label 'The journal lines were successfully posted. You are now in the %1 journal.';
        begin
            IF GenJnlLine."Line No." = 0 THEN
                MESSAGE(Text002)
            ELSE
                IF TempJnlBatchName = GenJnlLine."Journal Batch Name" THEN
                    IF GenJnlLine.CRM = FALSE THEN BEGIN//WIn292
                        MESSAGE(Text003)
                    END
                    ELSE
                        IF GenJnlLine.CRM = FALSE THEN BEGIN//WIn292
                            MESSAGE(
                              Text004,
                              GenJnlLine."Journal Batch Name");
                        END;
        end;
    */
    //<<Commented JV
    //////////////////////////////////////CU231/////////////-----------------------------------------------

    ///////////////////////////////////////////////CU241///////////+++++++++++++++++
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post", 'OnCodeOnBeforeItemJnlPostBatchRun', '', true, true)]
    local procedure CheckOnCodeOnBeforeItemJnlPostBatchRun(var ItemJournalLine: Record "Item Journal Line")
    var
        InventoryTransfer: Boolean;
    begin
        InventoryTransfer := ItemJournalLine."Inventory Transfer";//KPPLDG00039
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post", 'OnCodeOnAfterItemJnlPostBatchRun', '', true, true)]
    local procedure CheckOnCodeOnAfterItemJnlPostBatchRun(var ItemJournalLine: Record "Item Journal Line")
    var
        InventoryTransfer: Boolean;
        TempJnlBatchName: Code[10];
        Text003: Label 'The journal lines were successfully posted.';
        Text004: Label 'The journal lines were successfully posted. ';
        Text005: Label 'You are now in the %1 journal.';
    begin
        // if not HideDialog then
        //  if not PreviewMode then
        if ItemJournalLine."Line No." = 0 then
            Message('There is nothing to post.')
        else
            IF NOT InventoryTransfer THEN BEGIN //KPPLDG00039
                if TempJnlBatchName = ItemJournalLine."Journal Batch Name" then
                    Message(Text003)
                else
                    Message(
                      Text004 +
                      Text005,
                      ItemJournalLine."Journal Batch Name");
            END;//KPPLDG00039
        IF NOT InventoryTransfer THEN //KPPLDG00039
        begin
            /*     if not Find('=><') or (TempJnlBatchName <> ItemJournalLine."Journal Batch Name") then begin
                    Reset();
                    FilterGroup(2);
                    SetRange(ItemJournalLine."Journal Template Name", ItemJournalLine."Journal Template Name");
                    SetRange(ItemJournalLine."Journal Batch Name", ItemJournalLine."Journal Batch Name");
                    FilterGroup(0);
                    "Line No." := 1;
                end;*/
        end;


    end;

    ///////////////////////////////////////CU241///////////////////////-----------------------------

    ////////////////////////CU400 -- Not Applicable////////////////+++++++++++
    ////////////////////////CU400 -- Not Applicable////////////////-----------

    ////////////////////////////CU7000 /////////////+++++++++++++
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Price Calc. Mgt.", 'OnAfterFindSalesLineItemPrice', '', true, true)]
    local procedure CheckOnAfterFindSalesLineItemPrice(var FoundSalesPrice: Boolean; var SalesLine: Record "Sales Line"; var TempSalesPrice: Record "Sales Price" temporary; CalledByFieldNo: Integer)
    var
        SalesHeader: Record "Sales Header";
    begin
        //WIN362++
        //updated Win349++

        //  Win127
        /*
        "Scheme %" := 0;
        "Scheme Code" := '';
        "Scheme Amount" :=0;
        "Claim Amount" := 0;
        "Claim %" := 0;
        Vendor := '';
        IF TempSalesPrice."Allow Scheme Disc" THEN
          "Unit Price" := TempSalesPrice."Unit Price";
          SchemeDetails.RESET;
          SchemeDetails.SETFILTER(Open,'%1',TRUE);
          SchemeDetails.SETFILTER(ItemNo,'%1',"No.");
          SchemeDetails.SETFILTER("Starting Date",'<=%1',SalesHeader."Posting Date");
          SchemeDetails.SETFILTER("Ending Date",'>=%1',SalesHeader."Posting Date");
          SchemeDetails.SETFILTER("Enable Scheme",'%1',TRUE);
          IF SchemeDetails.FINDFIRST THEN BEGIN
            IF SchemeDetails."Sch Disc Amt" <> 0 THEN BEGIN
               "Unit Price" := TempSalesPrice."Unit Price" -SchemeDetails."Sch Disc Amt";
               "Scheme %" := SchemeDetails."Sch Disc %";
               "Scheme Code" := SchemeDetails."Scheme Code";
               "Scheme Amount" := SchemeDetails."Sch Disc Amt";
               "Claim Amount" := SchemeDetails."Claim Amt";
               "Claim %" := SchemeDetails."Claim Disc %";
               Vendor := SchemeDetails.Vendor;
             END
            ELSE
              IF SchemeDetails."Sch Disc %" <> 0 THEN BEGIN
               "Unit Price" := TempSalesPrice."Unit Price" - ((TempSalesPrice."Unit Price" * SchemeDetails."Sch Disc %")/100) ;
               "Scheme %" := SchemeDetails."Sch Disc %";
               "Scheme Code" := SchemeDetails."Scheme Code";
               "Scheme Amount" := (TempSalesPrice."Unit Price" * SchemeDetails."Sch Disc %")/100;
               "Claim Amount" := SchemeDetails."Claim Amt";
               "Claim %" := SchemeDetails."Claim Disc %";
               Vendor := SchemeDetails.Vendor;
              END;
          END;
        */
        IF (SalesLine."Scheme Amount" <> 0) OR (SalesLine."Scheme %" <> 0) THEN BEGIN
            IF (SalesLine."Scheme %" <> 0) THEN
                SalesLine."Scheme Amount" := (TempSalesPrice."Unit Price" * SalesLine."Scheme %") / 100;

            IF (SalesLine."Claim %" <> 0) THEN
                SalesLine."Claim Amount" := (TempSalesPrice."Unit Price" * SalesLine."Claim %") / 100;

            SalesLine."Unit Price" := TempSalesPrice."Unit Price" - SalesLine."Scheme Amount";
        END;



        //updated Win349--

        //updated Win349++
        IF TempSalesPrice."Price Inclusive of Tax" THEN BEGIN
            //IF "Unit Price Incl. of Tax" = 0 THEN
            // "Unit Price Incl. of Tax" := TempSalesPrice."Unit Price"
            //ELSE
            //"Unit Price Incl. of Tax" := "Unit Price Incl. of Tax";

            SalesLine."Unit Price Incl. of Tax" := SalesLine."Unit Price";
            // PIT Structure in B2B - 17.01.2015 ++++
            //CCIT_kj  // IF (SalesHeader."Sales Order Type" = SalesHeader."Sales Order Type"::B2B) AND (SalesHeader.Structure <> '') THEN BEGIN
            // SalesLine."PIT Structure" := SalesHeader.Structure; //CCIT_kj(Field [PIT Structure] and [Structure] standard field )
            //Win120
            //END ELSE //CCIT_kj
            // -----

            //updated Win349--
            //WIN362--

        end;
    end;
    //////////////////////////CU7000////////////------------------------

    //OnAfterCreateReservEntryFor

    //////////////////////////CU99000830////////////////+++++++++++++++++++++++
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Reserv. Entry", 'OnAfterCreateReservEntryFor', '', true, true)]
    local procedure CheckOnAfterCreateReservEntryFor(var ReservationEntry: Record "Reservation Entry")
    var
        ForLotNo: Code[20];
        ForLotNo1: Decimal;
    begin
        //InsertReservEntry."Lot No." := ForLotNo; Updated WIN347(//)
        ReservationEntry."IMEI No." := ForLotNo; //Used Lot No. for passing IMEI No UPdated WIN347   //WIN362
        ReservationEntry."MRP Value" := ForLotNo1;
        //InsertReservEntry."Lot No." := ForLotNo;
    end;

    //////////////////////////CU99000830///////////////---------------------------------

    //////////////////CU99000831//////////////++++++++++++++++++++++++++
    //OnModifyItemTrackingOnTempRecOnBeforeModifyReservEntry
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Reservation Engine Mgt.", 'OnBeforeUpdateItemTracking', '', true, true)]
    local procedure CheckOnBeforeUpdateItemTracking(var ReservEntry: Record "Reservation Entry"; var TrackingSpecification: Record "Tracking Specification")

    begin
        ReservEntry."IMEI No." := TrackingSpecification."IMEI No.";//Updated WIN347    //WIN362
        ReservEntry."MRP Value" := TrackingSpecification."MRP Value";//tk

    end;
    //////////////////CU99000831//////////////---------------------

    //////////////////////////CUCU99000832////////////////++++++++++++++++++++++
    //CCIT_kj
    //OnAfterSetSourceFromSalesLine

    // Codeunit::"Sales Line-Reserve"
    [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", 'OnAfterSetSourceFromSalesLine', '', true, true)]
    local procedure CheckOnAfterSetSourceFromSalesLine(SalesLine: Record "Sales Line"; var TrackingSpecification: Record "Tracking Specification")
    begin
        TrackingSpecification."Serial No." := SalesLine."Item Serial No.";
        TrackingSpecification."IMEI No." := SalesLine."IMEI No.";//TK 123
        TrackingSpecification."MRP Value" := SalesLine."MRP Value";//TK 123

    end;

    //////////////////////////CUCU99000832////////////////--------------------------

    //////////////////CU99000845/////////////////+++++++++++++++++++++++++
    /// OnBeforeDeleteItemTrackingConfirm

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Reservation Management", 'OnBeforeDeleteItemTrackingConfirm', '', true, true)]
    local procedure CheckOnBeforeDeleteItemTrackingConfirm(var CalcReservEntry2: Record "Reservation Entry")
    var
        Text011: Label 'Item tracking is defined for item %1 in the %2.\Do you want to delete the %2 and the item tracking lines?';

    begin
        /*   IF NOT ItemTrackingExist(CalcReservEntry2) THEN
              EXIT(TRUE);
          IF GUIALLOWED THEN BEGIN //Updated WIN347       //WIN362
              IF CONFIRM(Text011, FALSE, CalcReservEntry2."Item No.", CalcReservEntry2.TextCaption) THEN
                  //WIN362++
                  //Updated WIN347++
                  EXIT(TRUE);
          END
          ELSE
              //Updated WIN347--
              //WIN362--
              EXIT(TRUE);

          EXIT(FALSE); */  //need to discuss with client the functionality._ccit_kj
    end;
    //CCIT-tk Commented 
    //////////////////CU99000845/////////////////-----------------------------

    //////////////////CU5706/////////////++++++++++++
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post (Yes/No)", 'OnCodeOnBeforePostTransferOrder', '', true, true)]
    // local procedure CheckOnCodeOnBeforePostTransferOrder(var TransHeader: Record "Transfer Header")
    // var
    //     RecUserSetup: Record "User Setup";
    //     RecUserSetup1: Record "User Setup";
    //     Text000: Label '&Ship,&Receive';
    //     TransferPostShipment: Codeunit "TransferOrder-Post Shipment";//"5704";
    //     TransferPostReceipt: Codeunit "TransferOrder-Post Receipt";
    //     Selection: Option ,Shipment,Receipt;
    //     DefaultNumber: Integer;
    // begin
    //     //WIN316++
    //     IF TransHeader."ECom Order ID" = '' THEN BEGIN
    //         Selection := STRMENU(Text000, DefaultNumber);
    //         CASE Selection OF
    //             0:
    //                 EXIT;
    //             1:
    //                 BEGIN
    //                     //WIN316++
    //                     RecUserSetup.RESET;
    //                     RecUserSetup.SETRANGE("User ID", USERID);
    //                     RecUserSetup.SETRANGE("All Location Transfer", FALSE);
    //                     IF RecUserSetup.FINDFIRST THEN BEGIN
    //                         RecUserSetup1.RESET;
    //                         RecUserSetup1.SETRANGE("User ID", USERID);
    //                         RecUserSetup1.SETFILTER("Location Filter", '%1', '*' + TransHeader."Transfer-from Code" + '*');
    //                         IF NOT RecUserSetup1.FINDFIRST THEN
    //                             ERROR('You are not Authorised to Ship Transfer Order.');
    //                     END;
    //                     TransHeader."Shipped By User ID" := USERID;
    //                     TransHeader.MODIFY;
    //                     //WIN316--
    //                     TransferPostShipment.RUN(TransHeader);
    //                 END;
    //             2:
    //                 BEGIN
    //                     //WIN316++
    //                     RecUserSetup.RESET;
    //                     RecUserSetup.SETRANGE("User ID", USERID);
    //                     RecUserSetup.SETRANGE("All Location Transfer", FALSE);
    //                     IF RecUserSetup.FINDFIRST THEN BEGIN
    //                         RecUserSetup1.RESET;
    //                         RecUserSetup1.SETRANGE("User ID", USERID);
    //                         RecUserSetup1.SETFILTER("Location Filter", '%1', '*' + TransHeader."Transfer-to Code" + '*');
    //                         IF NOT RecUserSetup1.FINDFIRST THEN
    //                             ERROR('You are not Authorised to Receive Transfer Order.');
    //                     END;
    //                     TransHeader."Received By User ID" := USERID;
    //                     TransHeader.MODIFY;
    //                     //WIN316--
    //                     TransferPostReceipt.RUN(TransHeader);
    //                 END;
    //         END;
    //         // END
    //         // ELSE BEGIN
    //         //     //  IF TransHeader."No."<>'TO20548' THEN BEGIN
    //         //     TransferPostShipment.RUN(TransHeader);
    //         //     TransferPostReceipt.RUN(TransHeader);
    //         //     /*
    //         // END ELSE
    //         // TransferPostReceipt.RUN(TransHeader);
    //         // */
    //     END;
    //     //WIN316--
    // END;

    // ////////////////////CU5706////////-------------


    // ///////////////////////////////CU5912///////////////++++++++++++++++++++++++++

    /* [EventSubscriber(ObjectType::Codeunit, Codeunit::"ServLedgEntries-Post", 'OnBeforeServLedgerEntryInsert', '', true, true)]
    local procedure OnBeforeServLedgerEntryInsert(var ServiceLedgerEntry: Record "Service Ledger Entry"; ServiceHeader: Record "Service Header")
    begin
        ServiceLedgerEntry."Responsibility Center New 1" := ServiceHeader."Responsibility Center New 1";         //WIN362
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ServLedgEntries-Post", 'OnBeforeServLedgerEntrySaleInsert', '', true, true)]
    local procedure OnBeforeServLedgerEntrySaleInsert(var ServiceLedgerEntry: Record "Service Ledger Entry"; ServiceHeader: Record "Service Header")
    begin
        ServiceLedgerEntry."Responsibility Center New 1" := ServiceHeader."Responsibility Center New 1";           //WIN362       //WIN362
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ServLedgEntries-Post", 'OnInsertServLedgEntryCrMemoOnBeforeServLedgEntryInsert', '', true, true)]
    local procedure OnInsertServLedgEntryCrMemoOnBeforeServLedgEntryInsert(var ServiceLedgerEntry: Record "Service Ledger Entry"; ServiceHeader: Record "Service Header")
    begin
        ServiceLedgerEntry."Responsibility Center New 1" := ServiceHeader."Responsibility Center New 1";         //WIN362
    end;
 */
    /////////////////////////////////////CU5912/////////////-------------------


    //////////////////////////cu5918///////////////++++++++++++++++++
    //exixting Code can not be replacable, need to check alternate option.

    //Responsibility Center New 1 - field
    ///cu5918/////////////////--------------------------


    //////////////////////////cu5920///////////////++++++++++++++++++
    //nothing change available
    ///cu5920/////////////////--------------------------

    //////////////////////////cu5940///////////////++++++++++++++++++
    //Responsibility Center New 1 - field  need to skip for while          
    /////////////////////////cu5940/////////////////--------------------------

    /// //////////////////////////cu5942///////////////++++++++++++++++++
    //Responsibility Center New 1 - field  need to skip for while          
    /////////////////////////cu5942/////////////////--------------------------


    //////////////////////////cu5988///////////////++++++++++++++++++
    /* TableIDArr[3] := DATABASE::"Responsibility Center New 1";//Updated WIN349   //WIN362
                NumberArr[3] := ServHeader."Responsibility Center New 1";                   //WIN362
     */
    /////////////////////////cu5988/////////////////--------------------------

    /////////////////////////CU6620///////////////+++++++++++++++++++
    //OnBeforeCopySalesHeaderDone
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnBeforeCopySalesHeaderDone', '', true, true)]
    local procedure CheckOnBeforeCopySalesHeaderDone()
    var
        InvoiceTypeErr: Label 'Invoice Type must be same for %1 and %2';
        SalesDocType: Option Quote,"Blanket Order","Order",Invoice,"Return Order","Credit Memo","Posted Shipment","Posted Invoice","Posted Return Receipt","Posted Credit Memo","Posted Shield Invoice";
    begin
        // SalesDocType:: "Posted Shield Invoice": ; //SHLD001//updated Win349    //WIN362 //need to check_ //ccit_kj

    end;

    //  PurchDocType::"Posted Shield Invoice",   //SHLD001//updated Win349   //WIN362  //need to check_ //ccit_kj




    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnBeforeCopySalesInvLinesToBuffer', '', true, true)]
    local procedure OnBeforeCopySalesInvLinesToBuffer(var FromSalesInvLine: Record "Sales Invoice Line"; var FromSalesLine: Record "Sales Line"; var ToSalesHeader: Record "Sales Header")

    begin
        ToSalesHeader.VALIDATE("Location Code", FromSalesLine."Location Code"); //SHLD001//updated Win349    //WIN362
    end;

    /////////////////////////CU6620///////////////---------------------

    ///////////////////////////////////CU1535(BC) and NAV(439)////////////////////+++++++++++++ //ccit_kj need to check (on hold)
    //OnBeforeApprovalEntryInsert
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnBeforeApprovalEntryInsert', '', true, true)]
    local procedure OnBeforeApprovalEntryInsert(var ApprovalEntry: Record "Approval Entry"; ApprovalEntryArgument: Record "Approval Entry"; ApproverId: Code[50]; var IsHandled: Boolean; WorkflowStepArgument: Record "Workflow Step Argument")
    var
        TableID: Integer;
    begin
        // Win127++
        IF TableID = DATABASE::"Gen. Journal Line" THEN
             // SETRANGE(ApprovalEntry."Document Type", ApprovalEntry."Document Type"::Voucher) // Voucher is not an option
             //  ELSE
             ;   // Win127--
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post (Yes/No)", 'OnAfterPost', '', false, false)]
    // local procedure OnAfterPost(var TransHeader: Record "Transfer Header"; Selection: Option);
    // var
    //     RecUserSetup: Record 91;
    //     RecUserSetup1: Record 91;
    //     Text000: Label '&Ship,&Receive';
    //     TransferPostShipment: Codeunit "TransferOrder-Post Shipment";//"5704";
    //     TransferPostReceipt: Codeunit "TransferOrder-Post Receipt";
    //     //Selection: Option ,Shipment,Receipt;
    //     DefaultNumber: Integer;
    // begin
    //     //WIN316++
    //     IF TransHeader."ECom Order ID" = '' THEN BEGIN
    //         Selection := STRMENU(Text000, DefaultNumber);
    //         CASE Selection OF
    //             0:
    //                 EXIT;
    //             1:
    //                 BEGIN
    //                     //WIN316++
    //                     RecUserSetup.RESET;
    //                     RecUserSetup.SETRANGE("User ID", USERID);
    //                     RecUserSetup.SETRANGE("All Location Transfer", FALSE);
    //                     IF RecUserSetup.FINDFIRST THEN BEGIN
    //                         RecUserSetup1.RESET;
    //                         RecUserSetup1.SETRANGE("User ID", USERID);
    //                         RecUserSetup1.SETFILTER("Location Filter", '%1', '*' + TransHeader."Transfer-from Code" + '*');
    //                         IF NOT RecUserSetup1.FINDFIRST THEN
    //                             ERROR('You are not Authorised to Ship Transfer Order.');
    //                     END;
    //                     TransHeader."Shipped By User ID" := USERID;
    //                     TransHeader.MODIFY;
    //                     //WIN316--
    //                     // TransferPostShipment.RUN(TransHeader);
    //                 END;
    //             2:
    //                 BEGIN
    //                     //WIN316++
    //                     RecUserSetup.RESET;
    //                     RecUserSetup.SETRANGE("User ID", USERID);
    //                     RecUserSetup.SETRANGE("All Location Transfer", FALSE);
    //                     IF RecUserSetup.FINDFIRST THEN BEGIN
    //                         RecUserSetup1.RESET;
    //                         RecUserSetup1.SETRANGE("User ID", USERID);
    //                         RecUserSetup1.SETFILTER("Location Filter", '%1', '*' + TransHeader."Transfer-to Code" + '*');
    //                         IF NOT RecUserSetup1.FINDFIRST THEN
    //                             ERROR('You are not Authorised to Receive Transfer Order.');
    //                     END;
    //                     TransHeader."Received By User ID" := USERID;
    //                     TransHeader.MODIFY;
    //                     //WIN316--
    //                     // TransferPostReceipt.RUN(TransHeader);
    //                 END;
    //         END;
    //     END;
    //     //         // ELSE BEGIN
    //     //         //     //  IF TransHeader."No."<>'TO20548' THEN BEGIN
    //     //         //     TransferPostShipment.RUN(TransHeader);
    //     //         //     TransferPostReceipt.RUN(TransHeader);
    //     //         //     /*
    //     //         // END ELSE
    //     //         // TransferPostReceipt.RUN(TransHeader);
    //     //         // */
    //     //     END;
    //     //     //WIN316--

    // end;









}
