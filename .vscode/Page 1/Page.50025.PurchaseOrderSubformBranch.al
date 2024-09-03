page 50025 "Purchase Order Subform  Branch"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    // UsageCategory = Lists;
    // ApplicationArea = all;
    SourceTable = 39;
    SourceTableView = WHERE("Document Type" = FILTER(Order));
    ApplicationArea = FixedAsset;

    layout
    {
        area(content)
        {
            repeater(Repeater)
            {
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        NoOnAfterValidate;
                        IF Rec.Type <> Rec.Type::"Charge (Item)" THEN
                            ERROR('Only Charge (Item) Type is allowed');
                    end;
                }
                field("UPN Code"; Rec."UPN Code")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate;
                    end;
                }
                field("IMEI No."; Rec."IMEI No.")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Item Serial No"; Rec."Item Serial No")
                {
                    Caption = 'Item Serial Number';
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.VALIDATE(Quantity, 1);
                        WBU.NextLine();
                    end;
                }
                // field("Cross-Reference No.";"Cross-Reference No.")
                // {
                //     Visible = false;

                //     trigger OnLookup(var Text: Text): Boolean
                //     begin
                //         CrossReferenceNoLookUp;
                //         InsertExtendedText(FALSE);
                //         NoOnAfterValidate;
                //     end;

                //     trigger OnValidate()
                //     begin
                //         CrossReferenceNoOnAfterValidat;
                //         NoOnAfterValidate;
                //     end;
                // }
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("IC Partner Ref. Type"; Rec."IC Partner Ref. Type")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                // field("CWIP G/L Type";"CWIP G/L Type")
                // {
                //     Visible = false;
                // }//tk
                field("IC Partner Reference"; Rec."IC Partner Reference")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Nonstock; Rec.Nonstock)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                // field("Service Tax Registration No.";"Service Tax Registration No.")
                // {
                //     Visible = false;
                // }
                // field("Service Tax Group";"Service Tax Group")
                // {
                //     Visible = false;
                // }//tk
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Reserved Quantity"; Rec."Reserved Quantity")
                {
                    BlankZero = true;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job Remaining Qty."; Rec."Job Remaining Qty.")
                {
                    BlankZero = true;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Indirect Cost %"; Rec."Indirect Cost %")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Unit Price (LCY)"; Rec."Unit Price (LCY)")
                {
                    BlankZero = true;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                // field("Non ITC Claimable Usage %";"Non ITC Claimable Usage %")
                // {
                //     Visible = false;
                // }
                // field("Amount Loaded on Inventory";"Amount Loaded on Inventory")
                // {
                //     Visible = false;
                // // }//tk
                // field("Excise Loading on Inventory";"Excise Loading on Inventory")
                // {
                //     Visible = false;
                // }
                // field("Input Tax Credit Amount";"Input Tax Credit Amount")
                // {
                //     Visible = false;
                // }
                // field("VAT able Purchase Tax Amount";"VAT able Purchase Tax Amount")
                // {
                //     Visible = false;
                // }//tk
                field("Tax Group Code"; Rec."Tax Group Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                // field("Assessable Value";"Assessable Value")
                // {
                //     Visible = false;
                // }
                // field("CIF Amount";"CIF Amount")
                // {
                //     Visible = false;
                // }
                // field("BCD Amount";"BCD Amount")
                // {
                //     Visible = false;
                // }
                // field("BED Amount";"BED Amount")
                // {
                //     Visible = false;
                // }
                // field("AED(GSI) Amount";"AED(GSI) Amount")
                // {
                //     Visible = false;
                // }
                // field("SED Amount";"SED Amount")
                // {
                //     Visible = false;
                // }
                // field("SAED Amount";"SAED Amount")
                // {
                //     Visible = false;
                // }
                // field("CESS Amount";"CESS Amount")
                // {
                //     Visible = false;
                // }
                // field("ADET Amount";"ADET Amount")
                // {
                //     Visible = false;
                // }
                // field("AED(TTA) Amount";"AED(TTA) Amount")
                // {
                //     Visible = false;
                // }
                // field("ADE Amount";"ADE Amount")
                // {
                //     Visible = false;
                // }
                // field("NCCD Amount";"NCCD Amount")
                // {
                //     Visible = false;
                // }
                // field("Custom eCess Amount";"Custom eCess Amount")
                // {
                //     Visible = false;
                // }
                // field("Custom SHECess Amount";"Custom SHECess Amount")
                // {
                //     Visible = false;
                // }
                // field("eCess Amount";"eCess Amount")
                // {
                //     Visible = false;
                // }
                // field("SHE Cess Amount";"SHE Cess Amount")
                // {
                //     Visible = false;
                // }
                // field("ADC VAT Amount";"ADC VAT Amount")
                // {
                //     Visible = false;
                // }
                // field("Excise Refund";"Excise Refund")
                // {
                //     Visible = false;
                // }
                // field("Assessee Code";"Assessee Code")
                // {
                //     Visible = false;
                // }//tk
                field("Line Discount %"; Rec."Line Discount %")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Prepayment %"; Rec."Prepayment %")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Prepmt. Line Amount"; Rec."Prepmt. Line Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Prepmt. Amt. Inv."; Rec."Prepmt. Amt. Inv.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Inv. Discount Amount"; Rec."Inv. Discount Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Qty. to Receive"; Rec."Qty. to Receive")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Quantity Received"; Rec."Quantity Received")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Qty. to Invoice"; Rec."Qty. to Invoice")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Prepmt Amt to Deduct"; Rec."Prepmt Amt to Deduct")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Prepmt Amt Deducted"; Rec."Prepmt Amt Deducted")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Allow Item Charge Assignment"; Rec."Allow Item Charge Assignment")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Supplementary; Rec.Supplementary)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Source Document Type"; Rec."Source Document Type")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Source Document No."; Rec."Source Document No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job No."; Rec."Job No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job Planning Line No."; Rec."Job Planning Line No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job Line Type"; Rec."Job Line Type")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job Unit Price"; Rec."Job Unit Price")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job Line Amount"; Rec."Job Line Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job Line Discount Amount"; Rec."Job Line Discount Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job Line Discount %"; Rec."Job Line Discount %")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job Total Price"; Rec."Job Total Price")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job Unit Price (LCY)"; Rec."Job Unit Price (LCY)")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job Total Price (LCY)"; Rec."Job Total Price (LCY)")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job Line Amount (LCY)"; Rec."Job Line Amount (LCY)")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job Line Disc. Amount (LCY)"; Rec."Job Line Disc. Amount (LCY)")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Promised Receipt Date"; Rec."Promised Receipt Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Planned Receipt Date"; Rec."Planned Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Planning Flexibility"; Rec."Planning Flexibility")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Prod. Order Line No."; Rec."Prod. Order Line No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Operation No."; Rec."Operation No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Work Center No."; Rec."Work Center No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Finished; Rec.Finished)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Whse. Outstanding Qty. (Base)"; Rec."Whse. Outstanding Qty. (Base)")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Inbound Whse. Handling Time"; Rec."Inbound Whse. Handling Time")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                // field("Reason Code";"Reason Code")
                // {
                //     Visible = false;
                // }//tk
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Primary category"; Rec."Primary category")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Secondary category"; Rec."Secondary category")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Third category"; Rec."Third category")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    Image = ItemAvailability;
                    action("Event")
                    {
                        Caption = 'Event';
                        Image = "Event";
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByEvent)
                        end;
                    }
                    action(Period)
                    {
                        Caption = 'Period';
                        Image = Period;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByPeriod)
                        end;
                    }
                    action(Variant)
                    {
                        Caption = 'Variant';
                        Image = ItemVariant;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByVariant)
                        end;
                    }
                    action(Location)
                    {
                        Caption = 'Location';
                        Image = Warehouse;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByLocation)
                        end;
                    }
                    action("BOM Level")
                    {
                        Caption = 'BOM Level';
                        Image = BOMLevel;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByBOM)
                        end;
                    }
                }
                action("Reservation Entries")
                {
                    Caption = 'Reservation Entries';
                    Image = ReservationLedger;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.ShowReservationEntries(TRUE);
                    end;
                }
                action("Item Tracking Lines")
                {
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.OpenItemTrackingLines;
                    end;
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions;
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.ShowLineComments;
                    end;
                }
                action(ItemChargeAssignment)
                {
                    Caption = 'Item Charge &Assignment';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.ShowItemChargeAssgnt;
                    end;
                }
                action("Str&ucture Details")
                {
                    Caption = 'Str&ucture Details';
                    Image = Hierarchy;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        // This functionality was copied from page #50. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.PAGE.*/
                        // ShowStrDetailsForm;//tk

                    end;
                }
                action("E&xcise Detail")
                {
                    Caption = 'E&xcise Detail';
                    Image = Excise;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        // This functionality was copied from page #50. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.PAGE.*/
                        ShowExcisePostingSetup;

                    end;
                }
                action("Detailed Tax")
                {
                    Caption = 'Detailed Tax';
                    Image = TaxDetail;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        // ShowDetailedTaxEntryBuffer;//tk
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("E&xplode BOM")
                {
                    Caption = 'E&xplode BOM';
                    Image = ExplodeBOM;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ExplodeBOM;
                    end;
                }
                action("Insert Ext. Texts")
                {
                    Caption = 'Insert &Ext. Text';
                    Image = Text;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        InsertExtendedText(TRUE);
                    end;
                }
                action(Reserve)
                {
                    Caption = '&Reserve';
                    Ellipsis = true;
                    Image = Reserve;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.FIND;
                        Rec.ShowReservation;
                    end;
                }
                action(OrderTracking)
                {
                    Caption = 'Order &Tracking';
                    Image = OrderTracking;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ShowTracking;
                    end;
                }
            }
            group("O&rder")
            {
                Caption = 'O&rder';
                Image = "Order";
                group("Dr&op Shipment")
                {
                    Caption = 'Dr&op Shipment';
                    Image = Delivery;
                    action("Sales&Order")
                    {
                        Caption = 'Sales &Order';
                        Image = Document;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            OpenSalesOrderForm;
                        end;
                    }
                }
                group("Speci&al Order")
                {
                    Caption = 'Speci&al Order';
                    Image = SpecialOrder;
                    action("Sales &Order")
                    {
                        Caption = 'Sales &Order';
                        Image = Document;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            OpenSpecOrderSalesOrderForm;
                        end;
                    }
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnDeleteRecord(): Boolean
    var
        ReservePurchLine: Codeunit 99000834;
    begin
        IF (Rec.Quantity <> 0) AND Rec.ItemExists(Rec."No.") THEN BEGIN
            COMMIT;
            IF NOT ReservePurchLine.DeleteLineConfirm(Rec) THEN
                EXIT(FALSE);
            ReservePurchLine.DeleteLine(Rec);
        END;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        IF Rec.Type = Rec.Type::Item THEN
            ERROR('Modification is not allowed');
        WBU.RefreshPage();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.InitType;
        CLEAR(ShortcutDimCode);
        Rec.Type := Rec.Type::"Charge (Item)";
    end;

    var
        TransferExtendedText: Codeunit 378;
        ItemAvailFormsMgt: Codeunit 353;
        ShortcutDimCode: array[8] of Code[20];
        UpdateAllowedVar: Boolean;
        Text000: Label 'Unable to execute this function while in view only mode.';
        PurchHeader: Record 38;
        PurchPriceCalcMgt: Codeunit 7010;
        Text001: Label 'You cannot use the Explode BOM function because a prepayment of the purchase order has been invoiced.';
        WBU: Codeunit 50000;


    procedure ApproveCalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Disc. (Yes/No)", Rec);
    end;


    procedure CalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Calc.Discount", Rec);
    end;


    procedure ExplodeBOM()
    begin
        IF Rec."Prepmt. Amt. Inv." <> 0 THEN
            ERROR(Text001);
        CODEUNIT.RUN(CODEUNIT::"Purch.-Explode BOM", Rec);
    end;


    procedure OpenSalesOrderForm()
    var
        SalesHeader: Record 36;
        SalesOrder: Page 42;
    begin
        Rec.TESTFIELD("Sales Order No.");
        SalesHeader.SETRANGE("No.", Rec."Sales Order No.");
        SalesOrder.SETTABLEVIEW(SalesHeader);
        SalesOrder.EDITABLE := FALSE;
        SalesOrder.RUN;
    end;


    procedure InsertExtendedText(Unconditionally: Boolean)
    begin
        IF TransferExtendedText.PurchCheckIfAnyExtText(Rec, Unconditionally) THEN BEGIN
            CurrPage.SAVERECORD;
            TransferExtendedText.InsertPurchExtText(Rec);
        END;
        IF TransferExtendedText.MakeUpdate THEN
            UpdateForm(TRUE);
    end;


    procedure ShowTracking()
    var
        TrackingForm: Page 99000822;
    begin
        TrackingForm.SetPurchLine(Rec);
        TrackingForm.RUNMODAL;
    end;


    procedure OpenSpecOrderSalesOrderForm()
    var
        SalesHeader: Record 36;
        SalesOrder: Page 42;
    begin
        Rec.TESTFIELD("Special Order Sales No.");
        SalesHeader.SETRANGE("No.", Rec."Special Order Sales No.");
        SalesOrder.SETTABLEVIEW(SalesHeader);
        SalesOrder.EDITABLE := FALSE;
        SalesOrder.RUN;
    end;


    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.UPDATE(SetSaveRecord);
    end;


    procedure SetUpdateAllowed(UpdateAllowed: Boolean)
    begin
        UpdateAllowedVar := UpdateAllowed;
    end;


    procedure UpdateAllowed(): Boolean
    begin
        IF UpdateAllowedVar = FALSE THEN BEGIN
            MESSAGE(Text000);
            EXIT(FALSE);
        END;
        EXIT(TRUE);
    end;


    procedure ShowPrices()
    begin
        PurchHeader.GET(Rec."Document Type", Rec."Document No.");
        CLEAR(PurchPriceCalcMgt);
        PurchPriceCalcMgt.GetPurchLinePrice(PurchHeader, Rec);
    end;


    procedure ShowLineDisc()
    begin
        PurchHeader.GET(Rec."Document Type", Rec."Document No.");
        CLEAR(PurchPriceCalcMgt);
        PurchPriceCalcMgt.GetPurchLineLineDisc(PurchHeader, Rec);
    end;

    local procedure NoOnAfterValidate()
    begin
        InsertExtendedText(FALSE);
        IF (Rec.Type = Rec.Type::"Charge (Item)") AND (Rec."No." <> xRec."No.") AND
           (xRec."No." <> '')
        THEN
            CurrPage.SAVERECORD;
    end;

    local procedure CrossReferenceNoOnAfterValidat()
    begin
        InsertExtendedText(FALSE);
    end;
    //tk++

    // procedure ShowStrDetailsForm()
    // var
    //     StrOrderLineDetails: Record "13795";
    //     StrOrderLineDetailsForm: Page "16306";
    // begin
    //     StrOrderLineDetails.RESET;
    //     StrOrderLineDetails.SETCURRENTKEY("Document Type","Document No.",Type);
    //     StrOrderLineDetails.SETRANGE("Document Type","Document Type");
    //     StrOrderLineDetails.SETRANGE("Document No.","Document No.");
    //     StrOrderLineDetails.SETRANGE(Type,StrOrderLineDetails.Type::Purchase);
    //     StrOrderLineDetails.SETRANGE("Item No.","No.");
    //     StrOrderLineDetails.SETRANGE("Line No.","Line No.");
    //     StrOrderLineDetailsForm.SETTABLEVIEW(StrOrderLineDetails);
    //     StrOrderLineDetailsForm.RUNMODAL;
    // end;
    //tk--


    procedure ShowExcisePostingSetup()
    begin
        // GetExcisePostingSetup;//tk
    end;

    //tk++
    // procedure ShowDetailedTaxEntryBuffer()
    // var
    //     DetailedTaxEntryBuffer: Record "16480";
    // begin
    //     DetailedTaxEntryBuffer.RESET;
    //     DetailedTaxEntryBuffer.SETCURRENTKEY("Transaction Type","Document Type","Document No.","Line No.");
    //     DetailedTaxEntryBuffer.SETRANGE("Transaction Type",DetailedTaxEntryBuffer."Transaction Type"::Purchase);
    //     DetailedTaxEntryBuffer.SETRANGE("Document Type","Document Type");
    //     DetailedTaxEntryBuffer.SETRANGE("Document No.","Document No.");
    //     DetailedTaxEntryBuffer.SETRANGE("Line No.","Line No.");
    //     PAGE.RUNMODAL(PAGE::"Purch. Detailed Tax",DetailedTaxEntryBuffer);
    // end;
    //Tk--
}

