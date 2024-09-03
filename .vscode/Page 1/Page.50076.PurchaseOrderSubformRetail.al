page 50076 "Purchase Order Subform Retail"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
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
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        NoOnAfterValidate;
                    end;
                }
                field("UPN Code"; Rec."UPN Code")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Vendor Part Code Long"; Rec."Vendor Part Code Long")
                {
                    Caption = 'Vendor Part Code';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Vendor Item No."; Rec."Vendor Item No.")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
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
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Item Serial No"; Rec."Item Serial No")
                {
                    Caption = 'Item Serial Number';
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.VALIDATE(Quantity, 1);
                        //WBU.NextLine();//tk
                    end;
                }
                // field("Cross-Reference No.";"Cross-Reference No.")
                // {
                //     Editable = false;
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
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("IC Partner Ref. Type"; Rec."IC Partner Ref. Type")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                // field("CWIP G/L Type";"CWIP G/L Type")
                // {
                //     Editable = false;
                //     Visible = false;
                // }
                field("IC Partner Reference"; Rec."IC Partner Reference")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Nonstock; Rec.Nonstock)
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    BlankZero = true;
                    Editable = false;
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
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    BlankZero = true;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Indirect Cost %"; Rec."Indirect Cost %")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Unit Price (LCY)"; Rec."Unit Price (LCY)")
                {
                    BlankZero = true;
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    BlankZero = true;
                    Editable = false;
                    ApplicationArea = All;
                }
                // field("Non ITC Claimable Usage %";"Non ITC Claimable Usage %")
                // {
                //     Editable = false;
                //     Visible = false;
                // }
                // field("Amount Loaded on Inventory";"Amount Loaded on Inventory")
                // {
                //     Visible = false;
                // }
                // field("Excise Loading on Inventory";"Excise Loading on Inventory")
                // {
                //     Editable = false;
                //     Visible = false;
                // }
                // field("Input Tax Credit Amount";"Input Tax Credit Amount")
                // {
                //     Visible = false;
                // }
                // field("VAT able Purchase Tax Amount";"VAT able Purchase Tax Amount")
                // {
                //     Visible = false;
                // }
                field("Tax Group Code"; Rec."Tax Group Code")
                {
                    Editable = false;
                    Visible = true;
                    ApplicationArea = All;
                }
                // field("Service Tax Group";"Service Tax Group")
                // {
                //     Editable = false;
                //     Visible = true;
                // }
                // field("Service Tax Registration No.";"Service Tax Registration No.")
                // {
                //     Editable = false;
                //     Visible = true;
                // }
                // field("Assessable Value";"Assessable Value")
                // {
                //     Editable = false;
                //     Visible = false;
                // }
                // field("CIF Amount";"CIF Amount")
                // {
                //     Editable = false;
                //     Visible = false;
                // }
                // field("BCD Amount";"BCD Amount")
                // {
                //     Editable = false;
                //     Visible = false;
                // }
                // field("BED Amount";"BED Amount")
                // {
                //     Editable = false;
                //     Visible = false;
                // }
                // field("AED(GSI) Amount";"AED(GSI) Amount")
                // {
                //     Editable = false;
                //     Visible = false;
                // }
                // field("SED Amount";"SED Amount")
                // {
                //     Editable = false;
                //     Visible = false;
                // }
                // field("SAED Amount";"SAED Amount")
                // {
                //     Editable = false;
                //     Visible = false;
                // }
                // field("CESS Amount";"CESS Amount")
                // {
                //     Editable = false;
                //     Visible = false;
                // }
                // field("ADET Amount";"ADET Amount")
                // {
                //     Editable = false;
                //     Visible = false;
                // }
                // field("AED(TTA) Amount";"AED(TTA) Amount")
                // {
                //     Editable = false;
                //     Visible = false;
                // }
                // field("ADE Amount";"ADE Amount")
                // {
                //     Editable = false;
                //     Visible = false;
                // }
                // field("NCCD Amount";"NCCD Amount")
                // {
                //     Editable = false;
                //     Visible = false;
                // }
                // field("Custom eCess Amount";"Custom eCess Amount")
                // {
                //     Editable = false;
                //     Visible = false;
                // }
                // field("Custom SHECess Amount";"Custom SHECess Amount")
                // {
                //     Editable = false;
                //     Visible = false;
                // }
                // field("eCess Amount";"eCess Amount")
                // {
                //     Editable = false;
                //     Visible = false;
                // }
                // field("SHE Cess Amount";"SHE Cess Amount")
                // {
                //     Editable = false;
                //     Visible = false;
                // }
                // field("ADC VAT Amount";"ADC VAT Amount")
                // {
                //     Editable = false;
                //     Visible = false;
                // }
                // field("Excise Refund";"Excise Refund")
                // {
                //     Editable = false;
                //     Visible = false;
                // }
                // field("Assessee Code";"Assessee Code")
                // {
                //     Visible = false;
                // }/tk
                field("Line Discount %"; Rec."Line Discount %")
                {
                    BlankZero = true;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    Editable = false;
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Prepayment %"; Rec."Prepayment %")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Prepmt. Line Amount"; Rec."Prepmt. Line Amount")
                {
                    Editable = false;
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
                    Editable = false;
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
                    Editable = true;
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
                    Editable = false;
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
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Supplementary; Rec.Supplementary)
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Source Document Type"; Rec."Source Document Type")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Source Document No."; Rec."Source Document No.")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job No."; Rec."Job No.")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job Planning Line No."; Rec."Job Planning Line No.")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job Line Type"; Rec."Job Line Type")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job Unit Price"; Rec."Job Unit Price")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job Line Amount"; Rec."Job Line Amount")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job Line Discount Amount"; Rec."Job Line Discount Amount")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job Line Discount %"; Rec."Job Line Discount %")
                {
                    Editable = false;
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
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Promised Receipt Date"; Rec."Promised Receipt Date")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Planned Receipt Date"; Rec."Planned Receipt Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Planning Flexibility"; Rec."Planning Flexibility")
                {
                    Editable = false;
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
                    Editable = false;
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
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                // field("Reason Code";"Reason Code")
                // {
                //     Editable = false;
                //     Visible = false;
                // }
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
                field("Tax Liable"; Rec."Tax Liable")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("VAT %"; Rec."VAT %")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                // field("Service Tax Amount";"Service Tax Amount")
                // {
                //     Editable = false;
                // }
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
                        ShowStrDetailsForm;

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
                        ShowDetailedTaxEntryBuffer;
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

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.InitType;
        CLEAR(ShortcutDimCode);
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
    // WBU: Codeunit 50000;


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


    procedure ShowStrDetailsForm()
    var
    // StrOrderLineDetails: Record "13795";
    // StrOrderLineDetailsForm: Page "16306";
    begin
        // StrOrderLineDetails.RESET;
        // StrOrderLineDetails.SETCURRENTKEY("Document Type","Document No.",Type);
        // StrOrderLineDetails.SETRANGE("Document Type","Document Type");
        // StrOrderLineDetails.SETRANGE("Document No.","Document No.");
        // StrOrderLineDetails.SETRANGE(Type,StrOrderLineDetails.Type::Purchase);
        // StrOrderLineDetails.SETRANGE("Item No.","No.");
        // StrOrderLineDetails.SETRANGE("Line No.","Line No.");
        // StrOrderLineDetailsForm.SETTABLEVIEW(StrOrderLineDetails);
        // StrOrderLineDetailsForm.RUNMODAL;
    end;


    procedure ShowExcisePostingSetup()
    begin
        // GetExcisePostingSetup;
    end;


    procedure ShowDetailedTaxEntryBuffer()
    var
    //DetailedTaxEntryBuffer: Record "16480";
    begin
        // DetailedTaxEntryBuffer.RESET;
        // DetailedTaxEntryBuffer.SETCURRENTKEY("Transaction Type","Document Type","Document No.","Line No.");
        // DetailedTaxEntryBuffer.SETRANGE("Transaction Type",DetailedTaxEntryBuffer."Transaction Type"::Purchase);
        // DetailedTaxEntryBuffer.SETRANGE("Document Type","Document Type");
        // DetailedTaxEntryBuffer.SETRANGE("Document No.","Document No.");
        // DetailedTaxEntryBuffer.SETRANGE("Line No.","Line No.");
        // PAGE.RUNMODAL(PAGE::"Purch. Detailed Tax",DetailedTaxEntryBuffer);
    end;
}

