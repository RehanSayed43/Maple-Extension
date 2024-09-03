report 50099 "InventoryAgeingSkuwiseDocDate"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './InventoryAgeingSkuwiseDocDate.rdl';
    Caption = 'Item Age Composition - Value-Document Date';

    dataset
    {
        //dataitem(DataItem8129; Table27)
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.")
                                WHERE(Type = CONST(Inventory));
            RequestFilterFields = "No.", "Inventory Posting Group", "Statistics Group", "Location Filter";
            column(IMEI_SERIAL_SHOW; IMEI_SERIAL_SHOW)
            {
            }
            column(TodayFormatted; FORMAT(TODAY, 0, 4))
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(ItemTableCaptItemFilter; TABLECAPTION + ': ' + ItemFilter)
            {
            }
            column(ItemFilter; ItemFilter)
            {
            }
            column(PeriodStartDate21; FORMAT(PeriodStartDate[2] + 1))
            {
            }
            column(PeriodStartDate3; FORMAT(PeriodStartDate[3]))
            {
            }
            column(PeriodStartDate31; FORMAT(PeriodStartDate[3] + 1))
            {
            }
            column(PeriodStartDate4; FORMAT(PeriodStartDate[4]))
            {
            }
            column(PeriodStartDate41; FORMAT(PeriodStartDate[4] + 1))
            {
            }
            column(PeriodStartDate5; FORMAT(PeriodStartDate[5]))
            {
            }
            column(PrintLine; PrintLine)
            {
            }
            column(InvtValueRTC1; InvtValueRTC[1])
            {
            }
            column(InvtValueRTC2; InvtValueRTC[2])
            {
            }
            column(InvtValueRTC5; InvtValueRTC[5])
            {
            }
            column(InvtValueRTC4; InvtValueRTC[4])
            {
            }
            column(InvtValueRTC3; InvtValueRTC[3])
            {
            }
            column(TotalInvtValueRTC; TotalInvtValueRTC)
            {
            }
            column(InvtValue1_Item; InvtValue[1])
            {
                AutoFormatType = 1;
            }
            column(InvtValue2_Item; InvtValue[2])
            {
                AutoFormatType = 1;
            }
            column(InvtValue3_Item; InvtValue[3])
            {
                AutoFormatType = 1;
            }
            column(InvtValue4_Item; InvtValue[4])
            {
                AutoFormatType = 1;
            }
            column(InvtValue5_Item; InvtValue[5])
            {
                AutoFormatType = 1;
            }
            column(TotalInvtValue_Item; TotalInvtValue_Item)
            {
                AutoFormatType = 1;
            }
            column(ItemAgeCompositionValueCaption; ItemAgeCompositionValueCaptionLbl)
            {
            }
            column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
            {
            }
            column(AfterCaption; AfterCaptionLbl)
            {
            }
            column(BeforeCaption; BeforeCaptionLbl)
            {
            }
            column(InventoryValueCaption; InventoryValueCaptionLbl)
            {
            }
            column(ItemDescriptionCaption; ItemDescriptionCaptionLbl)
            {
            }
            column(ItemNoCaption; ItemNoCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(ItemCategoryCode_Item; Item."Item Category Code")
            {
            }
            column(ProductGroupCode_Item; '')
            // column(ProductGroupCode_Item; Item."Product Group Code")
            {
            }
            column(Primarycategory_Item; Item."Primary category")
            {
            }
            column(Secondarycategory_Item; Item."Secondary category")
            {
            }
            column(Thirdcategory_Item; Item."Third category")
            {
            }
            column(Description_Item; Item.Description)
            {
            }
            column(No_Item; Item."No.")
            {
            }
            column(VendorPartNo; Item."Vendor Part Code Long")
            {
            }
            column(Grade; Item.Grade)
            {
            }
            //dataitem(DataItem7209; Table32)
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Item No." = FIELD("No."),
                               "Location Code" = FIELD("Location Filter"),
                               "Variant Code" = FIELD("Variant Filter"),
                               "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                               "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter");
                DataItemTableView = SORTING("Item No.", "Location Code", Open, "Variant Code", "Unit of Measure Code", "Lot No.", "Serial No.")
                                    WHERE("Open" = CONST(true),
                                          "Location Code" = FILTER(<> ''));
                column(Zone; staterec.Zone)
                {
                }
                column(State; staterec.Description)
                {
                }
                column(StoreAge; StoreAge)
                {
                }
                column(CompAge; CompAge)
                {
                }
                column(LocName; "Item Ledger Entry"."Location Code")
                {
                }
                column(StockInHandQty; "Item Ledger Entry"."Remaining Quantity")
                {
                }
                column(stockinhandval; stockinhandval)
                {
                }
                column(SerialNo; "Item Ledger Entry"."Serial No.")
                {
                }
                column(IMEINo; "Item Ledger Entry"."IMEI No.")
                {
                }
                column(Store; "Item Ledger Entry"."Global Dimension 1 Code")
                {
                }

                trigger OnAfterGetRecord()
                var
                    ILE_L: Record "Item Ledger Entry";
                begin
                    StoreAge := 0;
                    //TRH.RESET;
                    //TRH.SETFILTER(TRH."No.","Item Ledger Entry"."Document No.");
                    //IF TRH.FINDFIRST THEN
                    //StoreAge:=TODAY-TRH."Posting Date";
                    IF "Item Ledger Entry"."Location Code" = '' THEN
                        CurrReport.SKIP;

                    IF locatn.GET("Item Ledger Entry"."Location Code") THEN
                        staterec.GET(locatn."State Code");

                    stockinhandval := 0;
                    stockinhandval := "Item Ledger Entry"."Remaining Quantity" * Item."Unit Cost";


                    CompAge := 0;
                    PIH.RESET;
                    PIH.SETFILTER(PIH."No.", "Item Ledger Entry"."Document No.");
                    IF PIH.FINDFIRST THEN BEGIN
                        CompAge := TODAY - PIH."Document Date";
                    END;

                    //WIN316++ //TO GET PURCHASE DATE OF TRANSFERED ITEM
                    IF CompAge = 0 THEN BEGIN

                        RecItemAppEntry.RESET;
                        RecItemAppEntry.SETRANGE(RecItemAppEntry."Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
                        IF RecItemAppEntry.FINDFIRST THEN BEGIN
                            RecItemAppEntry1.RESET;
                            RecItemAppEntry1.SETRANGE(RecItemAppEntry1."Item Ledger Entry No.", RecItemAppEntry."Transferred-from Entry No.");
                            IF RecItemAppEntry1.FINDFIRST THEN BEGIN
                                RecItemAppEntry2.RESET;
                                RecItemAppEntry2.SETRANGE(RecItemAppEntry2."Item Ledger Entry No.", RecItemAppEntry1."Transferred-from Entry No.");
                                IF RecItemAppEntry2.FINDFIRST THEN begin
                                    // MESSAGE('1');
                                    //CompAge := TODAY - RecItemAppEntry2."Posting Date";
                                    IF ILE_L.Get(RecItemAppEntry2."Item Ledger Entry No.") then
                                        CompAge := TODAY - ILE_L."Document Date";
                                    //  MESSAGE(FORMAT(CompAge));
                                end;
                            END;
                        END;
                    END;

                    //FOR CREDIT MEMO
                    IF CompAge = 0 THEN BEGIN

                        RecItemAppEntry.RESET;
                        RecItemAppEntry.SETRANGE(RecItemAppEntry."Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
                        IF RecItemAppEntry.FINDFIRST THEN BEGIN
                            IF RecItemAppEntry."Outbound Item Entry No." = 0 THEN BEGIN
                                //CompAge := TODAY - RecItemAppEntry."Posting Date";
                                IF ILE_L.Get(RecItemAppEntry."Item Ledger Entry No.") then
                                    CompAge := TODAY - ILE_L."Document Date";
                            END
                            ELSE BEGIN
                                RecItemAppEntry1.RESET;
                                RecItemAppEntry1.SETRANGE(RecItemAppEntry1."Item Ledger Entry No.", RecItemAppEntry."Outbound Item Entry No.");//
                                IF RecItemAppEntry1.FINDFIRST THEN BEGIN
                                    RecItemAppEntry2.RESET;
                                    RecItemAppEntry2.SETRANGE(RecItemAppEntry2."Item Ledger Entry No.", RecItemAppEntry1."Inbound Item Entry No."); //
                                    IF RecItemAppEntry2.FINDFIRST THEN BEGIN
                                        IF RecItemAppEntry2."Outbound Item Entry No." = 0 THEN BEGIN
                                            //CompAge := TODAY - RecItemAppEntry2."Posting Date";
                                            IF ILE_L.Get(RecItemAppEntry2."Item Ledger Entry No.") then
                                                CompAge := TODAY - ILE_L."Document Date";
                                        END
                                        ELSE BEGIN
                                            RecItemAppEntry3.RESET;
                                            RecItemAppEntry3.SETRANGE(RecItemAppEntry3."Item Ledger Entry No.", RecItemAppEntry2."Transferred-from Entry No.");//
                                            IF RecItemAppEntry3.FINDFIRST THEN BEGIN
                                                RecItemAppEntry4.RESET;
                                                RecItemAppEntry4.SETRANGE(RecItemAppEntry4."Item Ledger Entry No.", RecItemAppEntry3."Transferred-from Entry No.");
                                                IF RecItemAppEntry4.FINDFIRST THEN begin
                                                    //CompAge := TODAY - RecItemAppEntry4."Posting Date";
                                                    IF ILE_L.Get(RecItemAppEntry4."Item Ledger Entry No.") then
                                                        CompAge := TODAY - ILE_L."Document Date";
                                                end;
                                            END;
                                            //
                                            IF CompAge = 0 THEN BEGIN
                                                IF RecItemAppEntry2."Transferred-from Entry No." = 0 THEN BEGIN
                                                    RecItemAppEntry3.RESET;
                                                    RecItemAppEntry3.SETRANGE(RecItemAppEntry3."Item Ledger Entry No.", RecItemAppEntry2."Outbound Item Entry No.");//
                                                    IF RecItemAppEntry3.FINDFIRST THEN BEGIN
                                                        RecItemAppEntry4.RESET;
                                                        RecItemAppEntry4.SETRANGE(RecItemAppEntry4."Item Ledger Entry No.", RecItemAppEntry3."Inbound Item Entry No.");
                                                        IF RecItemAppEntry4.FINDFIRST THEN begin
                                                            //CompAge := TODAY - RecItemAppEntry4."Posting Date";
                                                            IF ILE_L.Get(RecItemAppEntry4."Item Ledger Entry No.") then
                                                                CompAge := TODAY - ILE_L."Document Date";
                                                        end;
                                                    END;
                                                END;
                                            END;
                                            //
                                        END;
                                    END;
                                END;
                            END;
                        END;
                    END;


                    // FOR POSITIVE & NEGATIVE ADJUSTMENT
                    IF CompAge = 0 THEN BEGIN
                        IF "Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."Entry Type"::"Positive Adjmt." THEN
                            CompAge := TODAY - "Item Ledger Entry"."Document Date";
                        IF "Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."Entry Type"::"Negative Adjmt." THEN
                            CompAge := TODAY - "Item Ledger Entry"."Document Date";
                    END;


                    //WIN316--

                    /*
                     TRH.RESET;
                     TRH.SETFILTER(TRH."No.","Item Ledger Entry"."Document No.");
                     IF TRH.FINDFIRST THEN  BEGIN
                            CompAge:=TODAY-TRH."Posting Date";
                     END;
                     */

                    StoreAge := TODAY - "Document Date";


                    IF "Remaining Quantity" = 0 THEN
                        CurrReport.SKIP;
                    PrintLine := TRUE;
                    CalcRemainingQty;

                    IF Item."Costing Method" = Item."Costing Method"::Average THEN BEGIN
                        TotalInvtValue_Item += AverageCost * TotalInvtQty;
                        InvtValue[i] += AverageCost * InvtQty[i];

                        TotalInvtValueRTC += AverageCost * TotalInvtQty;
                        InvtValueRTC[i] += AverageCost * InvtQty[i];
                    END ELSE BEGIN
                        CalcUnitCost;
                        TotalInvtValue_Item += UnitCost * ABS(TotalInvtQty);
                        InvtValue[i] += UnitCost * ABS(InvtQty[i]);

                        TotalInvtValueRTC += UnitCost * ABS(TotalInvtQty);
                        InvtValueRTC[i] += UnitCost * ABS(InvtQty[i]);
                    END

                end;

                trigger OnPreDataItem()
                begin
                    TotalInvtValue_Item := 0;
                    FOR i := 1 TO 5 DO
                        InvtValue[i] := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                ILE.RESET;
                ILE.SETFILTER("Item No.", '%1', Item."No.");
                IF NOT ILE.FINDFIRST THEN
                    CurrReport.SKIP;

                IF "Costing Method" = "Costing Method"::Average THEN
                    ItemCostMgt.CalculateAverageCost(Item, AverageCost, AverageCostACY);

                PrintLine := FALSE;
            end;

            trigger OnPreDataItem()
            begin
                //CurrReport.CREATETOTALS(InvtValue, TotalInvtValue_Item); //kj
                Item.SETFILTER("Inventory Posting Group", '<>%1', 'FG-MOTO');
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    Visible = false;
                    field(EndingDate; PeriodStartDate[5])
                    {
                        Caption = 'Ending Date';
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            IF PeriodStartDate[5] = 0D THEN
                                ERROR(Text002);
                        end;
                    }
                    field(PeriodLength; PeriodLength)
                    {
                        Caption = 'Period Length';
                        Visible = false;
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            IF FORMAT(PeriodLength) = '' THEN
                                EVALUATE(PeriodLength, '<0D>');
                        end;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            IF PeriodStartDate[5] = 0D THEN
                PeriodStartDate[5] := CALCDATE('<CM>', WORKDATE);
            IF FORMAT(PeriodLength) = '' THEN
                EVALUATE(PeriodLength, '<1M>');
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        IMEI_SERIAL_SHOW := FALSE;
    end;

    trigger OnPreReport()
    var
        NegPeriodLength: DateFormula;
    begin
        ItemFilter := Item.GETFILTERS;

        PeriodStartDate[6] := 99991231D;//12319999D;
        EVALUATE(NegPeriodLength, STRSUBSTNO('-%1', FORMAT(PeriodLength)));
        FOR i := 1 TO 3 DO
            PeriodStartDate[5 - i] := CALCDATE(NegPeriodLength, PeriodStartDate[6 - i]);
        IF USERID IN ['ADMIN', 'INVENTORYAM'] THEN
            IMEI_SERIAL_SHOW := TRUE
        ELSE
            IMEI_SERIAL_SHOW := FALSE; //Win-234 20-03-2019
    end;

    var
        Text002: Label 'Enter the ending date';
        ItemCostMgt: Codeunit ItemCostManagement;//"5804";
        ItemFilter: Text;
        InvtValue: array[6] of Decimal;
        InvtValueRTC: array[6] of Decimal;
        InvtQty: array[6] of Decimal;
        UnitCost: Decimal;
        PeriodStartDate: array[6] of Date;
        PeriodLength: DateFormula;
        i: Integer;
        TotalInvtValue_Item: Decimal;
        TotalInvtValueRTC: Decimal;
        TotalInvtQty: Decimal;
        PrintLine: Boolean;
        AverageCost: Decimal;
        AverageCostACY: Decimal;
        ItemAgeCompositionValueCaptionLbl: Label 'Item Age Composition - Value';
        CurrReportPageNoCaptionLbl: Label 'Page';
        AfterCaptionLbl: Label 'After...';
        BeforeCaptionLbl: Label '...Before';
        InventoryValueCaptionLbl: Label 'Inventory Value';
        ItemDescriptionCaptionLbl: Label 'Description';
        ItemNoCaptionLbl: Label 'Item No.';
        TotalCaptionLbl: Label 'Total';
        salesp: Record "Salesperson/Purchaser";//"13";
        staterec: Record State;//"13762";
        saleshdr: Record "Sales Header";//"36";
        purchhdr: Record "Purchase Header";//"38";
        locatn: Record Location;//"14";
        stockinhandval: Decimal;
        CompAge: Integer;
        PIH: Record "Purch. Inv. Header";//"120";
        TRH: Record "Transfer Receipt Header";//"5746";
        StoreAge: Integer;
        ILE: Record "Item Ledger Entry";//"32";
        RecItemAppEntry: Record "Item Application Entry";//"339";
        RecItemAppEntry1: Record "Item Application Entry";//"339";
        RecItemAppEntry2: Record "Item Application Entry";//"339";
        RecItemAppEntry3: Record "Item Application Entry";//"339";
        RecItemAppEntry4: Record "Item Application Entry";//"339";
        IMEI_SERIAL_SHOW: Boolean;

    //[Scope('Internal')]
    procedure CalcRemainingQty()
    begin
        FOR i := 1 TO 5 DO
            InvtQty[i] := 0;

        TotalInvtQty := "Item Ledger Entry"."Remaining Quantity";
        FOR i := 1 TO 5 DO
            IF ("Item Ledger Entry"."Document Date" > PeriodStartDate[i]) AND
               ("Item Ledger Entry"."Document Date" <= PeriodStartDate[i + 1])
            THEN
                IF "Item Ledger Entry"."Remaining Quantity" <> 0 THEN BEGIN
                    InvtQty[i] := "Item Ledger Entry"."Remaining Quantity";
                    EXIT;
                END;
    end;

    // [Scope('Internal')]
    procedure CalcUnitCost()
    var
        ValueEntry: Record "Value Entry";//"5802";
    begin
        ValueEntry.SETRANGE("Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
        UnitCost := 0;

        IF ValueEntry.FIND('-') THEN
            REPEAT
                IF ValueEntry."Partial Revaluation" THEN
                    SumUnitCost(UnitCost, ValueEntry."Cost Amount (Actual)" + ValueEntry."Cost Amount (Expected)", ValueEntry."Valued Quantity")
                ELSE
                    SumUnitCost(UnitCost, ValueEntry."Cost Amount (Actual)" + ValueEntry."Cost Amount (Expected)", "Item Ledger Entry".Quantity);
            UNTIL ValueEntry.NEXT = 0;
    end;

    local procedure SumUnitCost(var UnitCost: Decimal; CostAmount: Decimal; Quantity: Decimal)
    begin
        UnitCost := UnitCost + CostAmount / ABS(Quantity);
    end;

    [Scope('Internal')]
    procedure InitializeRequest(NewEndingDate: Date; NewPeriodLength: DateFormula)
    begin
        PeriodStartDate[5] := NewEndingDate;
        PeriodLength := NewPeriodLength;
    end;
}

