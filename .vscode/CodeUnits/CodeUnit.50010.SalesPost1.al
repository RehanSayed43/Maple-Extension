codeunit 50010 SalesPost1
{

    //not applicable in BC
    /*   ShieldInvoice := FALSE; //WIN127//win352
       ShieldLineNo := 0; //Win127*/


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnPostItemJnlLineOnBeforeIsJobContactLineCheck', '', true, true)]
    local procedure OnPostItemJnlLineOnBeforeIsJobContactLineCheck(var ItemJnlLine: Record "Item Journal Line"; SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line")
    var
        IsATO: Boolean;
    begin
        //win352
        ItemJnlLine."Primary category" := SalesLine."Primary category";
        ItemJnlLine."Secondary category" := SalesLine."Secondary category";
        ItemJnlLine."Third category" := SalesLine."Third category";
        ItemJnlLine."UPN Code" := SalesLine."UPN Code";
        ItemJnlLine."Shortcut Dimension 1 Code" := SalesLine."Shortcut Dimension 1 Code";
        ItemJnlLine."Shortcut Dimension 2 Code" := SalesLine."Shortcut Dimension 2 Code";
        ItemJnlLine."Dimension Set ID" := SalesLine."Dimension Set ID";
        ItemJnlLine."Location Code" := SalesLine."Location Code";
        ItemJnlLine."Bin Code" := SalesLine."Bin Code";
        ItemJnlLine."Variant Code" := SalesLine."Variant Code";
        ItemJnlLine."Inventory Posting Group" := SalesLine."Posting Group";
        ItemJnlLine."Gen. Bus. Posting Group" := SalesLine."Gen. Bus. Posting Group";
        ItemJnlLine."Gen. Prod. Posting Group" := SalesLine."Gen. Prod. Posting Group";
        IF IsATO THEN
            ItemJnlLine."Applies-to Entry" := SalesLine.FindOpenATOEntry('', '')
        ELSE
            ItemJnlLine."Applies-to Entry" := SalesLine."Appl.-to Item Entry";
        ItemJnlLine."Transaction Type" := SalesLine."Transaction Type";
        ItemJnlLine."Transport Method" := SalesLine."Transport Method";
        ItemJnlLine."Entry/Exit Point" := SalesLine."Exit Point";
        ItemJnlLine.Area := SalesLine.Area;
        ItemJnlLine."Transaction Specification" := SalesLine."Transaction Specification";
        ItemJnlLine."Drop Shipment" := SalesLine."Drop Shipment";
        ItemJnlLine."Assemble to Order" := IsATO;
        ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::Sale;
        ItemJnlLine."Unit of Measure Code" := SalesLine."Unit of Measure Code";
        ItemJnlLine."Qty. per Unit of Measure" := SalesLine."Qty. per Unit of Measure";
        ItemJnlLine."Derived from Blanket Order" := SalesLine."Blanket Order No." <> '';
        //ItemJnlLine."Cross-Reference No." := SalesLine."Cross-Reference No.";//tk
        ItemJnlLine."Originally Ordered No." := SalesLine."Originally Ordered No.";
        ItemJnlLine."Originally Ordered Var. Code" := SalesLine."Originally Ordered Var. Code";
        ItemJnlLine."Out-of-Stock Substitution" := SalesLine."Out-of-Stock Substitution";
        ItemJnlLine."Item Category Code" := SalesLine."Item Category Code";
        ItemJnlLine.Nonstock := SalesLine.Nonstock;
        ItemJnlLine."Purchasing Code" := SalesLine."Purchasing Code";
        //ItemJnlLine."Product Group Code" := SalesLine."Product Group Code";
        ItemJnlLine."Return Reason Code" := SalesLine."Return Reason Code";

        ItemJnlLine."Planned Delivery Date" := SalesLine."Planned Delivery Date";
        ItemJnlLine."Order Date" := SalesHeader."Order Date";

        //EVENT not found+++++++++++++++_kj
        /* ItemJnlLine."Serial No." := TrackingSpecification."Serial No.";
         ItemJnlLine."Lot No." := TrackingSpecification."Lot No.";
         ItemJnlLine."IMEI No." := TrackingSpecification."IMEI No."; //Win127//win352*/   //event not found//kj------------
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostItemChargePerOrder', '', true, true)]
    local procedure OnBeforePostItemChargePerOrder(var ItemJnlLine2: Record "Item Journal Line"; var ItemChargeSalesLine: Record "Sales Line")
    var
        NonDistrItemJnlLine: Record "Item Journal Line";

    begin
        ItemJnlLine2."IMEI No." := ItemChargeSalesLine."IMEI No."; //Win127//win352
                                                                   /*  ItemJnlPostLine.RunWithCheck(ItemJnlLine2);
                                                                    ItemJnlLine2."Location Code" := NonDistrItemJnlLine."Location Code";
                                                                    NonDistrItemJnlLine."Quantity (Base)" -= ItemJnlLine2."Quantity (Base)";
                                                                    NonDistrItemJnlLine.Amount -= ItemJnlLine2.Amount;
                                                                    NonDistrItemJnlLine."Discount Amount" -= ItemJnlLine2."Discount Amount";
                                                                END ELSE BEGIN // the last time
                                                                    NonDistrItemJnlLine."Quantity (Base)" := -"Quantity (Base)";
                                                                    NonDistrItemJnlLine."Invoiced Qty. (Base)" := -"Quantity (Base)";
                                                                    NonDistrItemJnlLine."Unit Cost" :=
                                                                      ROUND(NonDistrItemJnlLine.Amount / NonDistrItemJnlLine."Invoiced Qty. (Base)",
                                                                        GLSetup."Unit-Amount Rounding Precision");
                                                                    NonDistrItemJnlLine."Item Shpt. Entry No." := "Item Ledger Entry No.";
                                                                    NonDistrItemJnlLine."Applies-to Entry" := "Item Ledger Entry No.";
                                                                    NonDistrItemJnlLine."Lot No." := "Lot No.";
                                                                    NonDistrItemJnlLine."Serial No." := "Serial No."; */
        NonDistrItemJnlLine."IMEI No." := ItemChargeSalesLine."IMEI No."; //Win127//win352

    end;

    //kj+++++++++++= not applicable++++

    //Win127++ 20.10.14  Added Code Below to Consider Total Service Tax Amount in field "Amount to Customer UPIT"
    /*     IF StrOrdLineDetails2."Tax/Charge Type" = StrOrdLineDetails2."Tax/Charge Type"::"Service Tax" THEN
             "Amount To Customer UPIT" += "Service Tax Amount" + "Service Tax eCess Amount" + "Service Tax SHE Cess Amount";
         //Win127--//win352--
------------------------------------------------------------------------------------------------------


local procedure InsertShptEntryRelation(var SalesShptLine: Record "111"): Integer

ItemEntryRelation."IMEI No." := TempHandlingSpecification."IMEI No.";//win352
---------------------------------------------------------------------------------------------------------

local procedure InsertReturnEntryRelation(var ReturnRcptLine: Record "6661"): Integer
  ItemEntryRelation."IMEI No." := TempHandlingSpecification."IMEI No.";//win352 
 ------------------------------------------------------------------------------------------------------

  local procedure TransferReservToItemJnlLine(var SalesOrderLine: Record "Sales Line"; var ItemJnlLine: Record "83"; QtyToBeShippedBase: Decimal; var TempTrackingSpecification2: Record "336" temporary; var CheckApplFromItemEntry: Boolean)
   ItemJnlLine."IMEI No." := TempTrackingSpecification2."IMEI No.";//win352 
   
   ---------------------------------------------------------------------------------------------------------------
   
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnInsertInvoiceHeaderOnAfterSalesInvHeaderTransferFields', '', true,true)]
    local procedure OnInsertInvoiceHeaderOnAfterSalesInvHeaderTransferFields(var SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
        IF Rec."Document Type" = Rec."Document Type"::Invoice THEN
                SalesInvHeader."Ref. Invoice No." := "Ref. Invoice No.";
    end;*/


    //kj--------------- not applicable-----------



}
