report 50021 "Inventory Ageing"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Inventory Ageing.rdl';
    Caption = 'Item Age Composition - Value';
    ApplicationArea = FixedAsset;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.")
                                WHERE(Type = CONST(Inventory));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Inventory Posting Group", "Statistics Group", "Location Filter";
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
            column(location; location)
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
            column(ProductGroupCode_Item; '')//Item."Product Group Code")
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
            column(VendorPartNo; Item."Vendor Part Code Long")
            {
            }
            column(No_Item; Item."No.")
            {
            }
            column(Description_Item; Item.Description)
            {
            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Item No." = FIELD("No."),
                               "Location Code" = FIELD("Location Filter"),
                               "Variant Code" = FIELD("Variant Filter"),
                               "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                               "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter");
                DataItemTableView = SORTING("Item No.", "Location Code", Open, "Variant Code", "Unit of Measure Code", "Lot No.", "Serial No.")
                                    WHERE(Open = CONST(True));
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
                column(Zone; staterec.Zone)
                {
                }
                column(State; staterec.Description)
                {
                }
                column(Store; "Item Ledger Entry"."Global Dimension 1 Code")
                {
                }
                column(NoOfAgeUnit; NoOfAgeUnit)
                {
                }
                column(NoOfCompAge; NoOfCompAge)
                {
                }
                column(DIOvalue; DIOvalue)
                {
                }

                trigger OnAfterGetRecord()
                var
                    ItemLocal: Record "Item";
                    ILE: Record "Item Ledger Entry";
                begin

                    StoreAge := 0;
                    DIOvalue := 0;
                    IF xLocationCode <> "Item Ledger Entry"."Location Code" THEN BEGIN
                        NoOfAgeUnit := 0;
                        NoOfCompAge := 0;
                        StoreAge := 0;
                        CompAge := 0;
                        xLocationCode := "Item Ledger Entry"."Location Code";

                        ItemLocal.RESET;
                        ItemLocal.SETAUTOCALCFIELDS(Inventory);
                        ItemLocal.SETFILTER("No.", '%1', "Item Ledger Entry"."Item No.");
                        ItemLocal.SETFILTER("Location Filter", '%1', "Item Ledger Entry"."Location Code");
                        IF ItemLocal.FINDSET THEN BEGIN
                            REPEAT
                                //ItemLocal.CALCFIELDS(ItemLocal.Inventory);
                                ItemInventory += ItemLocal.Inventory;
                            UNTIL ItemLocal.NEXT = 0;
                        END;

                        ILE.RESET;
                        //ILE.SETAUTOCALCFIELDS("Cost Amount (Actual)");
                        ILE.SETCURRENTKEY("Item No.", "Entry Type", "Variant Code", "Drop Shipment", "Location Code", "Posting Date");
                        ILE.SETFILTER("Item No.", '%1', "Item Ledger Entry"."Item No.");
                        //ILE.SETFILTER("Location Code",'%1',"Item Ledger Entry"."Location Code");
                        ILE.SETFILTER("Entry Type", '%1', "Item Ledger Entry"."Entry Type"::Sale);
                        ILE.SETRANGE(ILE."Posting Date", DIOdate, WORKDATE);
                        IF ILE.FINDSET THEN BEGIN
                            REPEAT
                                //MESSAGE('COUNT %1',ILE.COUNT);
                                ILE.CALCFIELDS("Cost Amount (Actual)");
                                IF ILE."Cost Amount (Actual)" < 0 THEN
                                    xItemCost += ILE."Cost Amount (Actual)" * -1;
                            UNTIL ILE.NEXT = 0;
                        END;

                        IF (ItemInventory > 0) AND (xItemCost > 0) THEN
                            //33    DIOvalue := (ItemInventory/xItemCost ) * 30 ;
                            DIOvalue := (ItemInventory / xItemCost) * 30;

                    END;

                    //TRH.RESET;
                    //TRH.SETFILTER(TRH."No.","Item Ledger Entry"."Document No.");
                    //IF TRH.FINDFIRST THEN
                    //StoreAge:=TODAY-TRH."Posting Date";

                    IF locatn.GET("Item Ledger Entry"."Location Code") THEN
                        staterec.GET(locatn."State Code");
                    CompAge := 0;
                    stockinhandval := 0;
                    stockinhandval := "Item Ledger Entry"."Remaining Quantity" * Item."Unit Cost";
                    IF (("Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."Entry Type"::Purchase) OR ("Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."Entry Type"::"Positive Adjmt.") OR
                    ("Item Ledger Entry"."Document Type" = "Item Ledger Entry"."Document Type"::"Sales Credit Memo"))
                     AND "Item Ledger Entry".Open THEN BEGIN
                        //if  entrytype purchase or positive adij and open

                        //PIH.RESET;
                        //PIH.SETFILTER(PIH."No.","Item Ledger Entry"."Document No.");
                        //IF PIH.FINDFIRST THEN BEGIN
                        CompAge := TODAY - "Item Ledger Entry"."Posting Date";
                        NoOfCompAge := 1;
                    END;

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
                    END;
                    IF "Item Ledger Entry".Open THEN BEGIN
                        StoreAge := TODAY - "Item Ledger Entry"."Posting Date";
                        NoOfAgeUnit := 1;
                    END;
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
                IF "Costing Method" = "Costing Method"::Average THEN
                    ItemCostMgt.CalculateAverageCost(Item, AverageCost, AverageCostACY);

                PrintLine := FALSE;
            end;

            trigger OnPreDataItem()
            begin
                // CurrReport.CREATETOTALS(InvtValue, TotalInvtValue_Item);
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
                    field(EndingDate; PeriodStartDate[5])
                    {
                        Caption = 'Ending Date';
                        Visible = false;
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

    trigger OnPreReport()
    var
        NegPeriodLength: DateFormula;
    begin
        ItemFilter := Item.GETFILTERS;
        location := '';
        location := Item.GETFILTER(Item."Location Filter");


        //  PeriodStartDate[6] := 12319999D;
        EVALUATE(NegPeriodLength, STRSUBSTNO('-%1', FORMAT(PeriodLength)));
        FOR i := 1 TO 3 DO
            PeriodStartDate[5 - i] := CALCDATE(NegPeriodLength, PeriodStartDate[6 - i]);
        DIOdate := CALCDATE('-30D', WORKDATE);
    end;

    var
        Text002: Label 'Enter the ending date';
        ItemCostMgt: Codeunit 5804;
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
        salesp: Record "Salesperson/Purchaser";
        staterec: Record "State";
        saleshdr: Record "Sales Header";
        purchhdr: Record "Purchase Header";
        locatn: Record Location;
        stockinhandval: Decimal;
        CompAge: Integer;
        PIH: Record "Purch. Inv. Header";
        TRH: Record "Transfer Receipt Header";
        StoreAge: Integer;
        NoOfAgeUnit: Integer;
        xLocationCode: Code[20];
        NoOfCompAge: Integer;
        DIOvalue: Decimal;
        DIOdate: Date;
        DIO_COGS: Decimal;
        ItemInventory: Decimal;
        xItemCost: Decimal;
        location: Text[50];


    procedure CalcRemainingQty()
    begin
        FOR i := 1 TO 5 DO
            InvtQty[i] := 0;

        TotalInvtQty := "Item Ledger Entry"."Remaining Quantity";
        FOR i := 1 TO 5 DO
            IF ("Item Ledger Entry"."Posting Date" > PeriodStartDate[i]) AND
               ("Item Ledger Entry"."Posting Date" <= PeriodStartDate[i + 1])
            THEN
                IF "Item Ledger Entry"."Remaining Quantity" <> 0 THEN BEGIN
                    InvtQty[i] := "Item Ledger Entry"."Remaining Quantity";
                    EXIT;
                END;
    end;


    procedure CalcUnitCost()
    var
        ValueEntry: Record "Value Entry";
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


    procedure InitializeRequest(NewEndingDate: Date; NewPeriodLength: DateFormula)
    begin
        PeriodStartDate[5] := NewEndingDate;
        PeriodLength := NewPeriodLength;
    end;
}

