report 50023 "PO Planning"
{
    DefaultLayout = RDLC;
    RDLCLayout = './POPlanning.rdl';
    ApplicationArea = FixedAsset;

    dataset
    {
        dataitem(Item; Item)
        {
            CalcFields = Inventory;
            DataItemTableView = SORTING("No.")
                                WHERE(Blocked = CONST(False));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Item Category Code", "Date Filter";
            column(Grade_Item; Item.Grade)
            {
            }
            column(location1; location)
            {
            }
            column(Srno; Srno)
            {
            }
            column(location; xLocationCode)
            {
            }
            column(ItemNo; Item."No.")
            {
            }
            column(Description; Item.Description)
            {
            }
            column(VendorItem; Item."Vendor Part Code Long")
            {
            }
            // column(ItemCategory; Item."Product Group Code")
            // {
            // }
            column(ItemProductGrpCode; Item."Item Category Code")
            {
            }
            column(Primcategory; Item."Primary category")
            {
            }
            column(SecondCategory; Item."Secondary category")
            {
            }
            column(ThirdCategory; Item."Third category")
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(CompInfoName; CompInfo.Name)
            {
            }
            column(CompInfoLogo; CompInfo.Picture)
            {
            }
            column(CurMonthCaption; CurMonthCaption)
            {
            }
            column(LastMon1Caption; LastMon1Caption)
            {
            }
            column(LastMon2Caption; LastMon2Caption)
            {
            }
            column(LastMon3Caption; LastMon3Caption)
            {
            }
            column(Inventory_Item; Item.Inventory)
            {
            }
            column(UnitCost_Item; Item."Unit Cost" * Item.Inventory)
            {
            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Item No." = FIELD("No."),
                               "Location Code" = FIELD("Location Filter"),
                               "Posting Date" = FIELD("Date Filter");
                DataItemTableView = SORTING("Item No.", "Location Code", Open, "Variant Code", "Unit of Measure Code", "Lot No.", "Serial No.")
                                    ORDER(Ascending);
                column(zone; staterec.Zone)
                {
                }
                column(statenm; staterec.Description)
                {
                }
                column(LocationCode; "Item Ledger Entry"."Location Code")
                {
                }
                column(StockInHandUnit; "Item Ledger Entry".Quantity)
                {
                }
                column(StockInHandValue; "Item Ledger Entry"."Sales Amount (Actual)")
                {
                }
                column(StockInHandValue1; StockInHandValue)
                {
                }
                column(CurMonUnit; CurMonUnit)
                {
                }
                column(CurMonValue; CurMonValue)
                {
                }
                column(LastMon1Unit; LastMon1Unit)
                {
                }
                column(LastMon1Value; LastMon1Value)
                {
                }
                column(LastMon2Unit; LastMon2Unit)
                {
                }
                column(LastMon2Value; LastMon2Value)
                {
                }
                column(LastMon3Unit; LastMon3Unit)
                {
                }
                column(LastMon3Value; LastMon3Value)
                {
                }
                column(StockInTransUnit; StockInTransUnit)
                {
                }
                column(StockInTransValue; StockInTransValue)
                {
                }
                column(POQty; POQty)
                {
                }
                column(POValue; POValue)
                {
                }
                column(DIOvalue; DIOvalue)
                {
                }
                column(StoreAgeUnit; StoreAgeUnit)
                {
                }
                column(NoOfAgeUnit; NoOfAgeUnit)
                {
                }
                column(CompAge; CompAge)
                {
                }
                column(NoOfCompAge; NoOfCompAge)
                {
                }
                column(DIOSaleValue; DIOSaleValue)
                {
                }

                trigger OnAfterGetRecord()
                var
                    ItemLocal: Record 27;
                    ItemInventory: Decimal;
                    xItemCost: Decimal;
                    ILE: Record 32;
                begin
                    //Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output, ,Assembly Consumption,Assembly Output

                    DIOvalue := 0;

                    IF locatn.GET("Item Ledger Entry"."Location Code") THEN
                        staterec.GET(locatn."State Code");
                    CurMonUnit := 0;
                    CurMonValue := 0;
                    LastMon1Unit := 0;
                    LastMon1Value := 0;
                    LastMon2Unit := 0;
                    LastMon2Value := 0;
                    LastMon3Unit := 0;
                    LastMon3Value := 0;
                    StockInTransUnit := 0;
                    StockInTransValue := 0;
                    NoOfCompAge := 0;
                    NoOfAgeUnit := 0;
                    DIOSaleValue := 0;
                    StockInHandUnit := "Item Ledger Entry".Quantity;
                    //StockInHandValue := "Item Ledger Entry"."Sales Amount (Actual)";
                    "Item Ledger Entry".CALCFIELDS("Item Ledger Entry"."Cost Amount (Actual)");
                    "Item Ledger Entry".CALCFIELDS("Item Ledger Entry"."Cost Amount (Expected)");
                    StockInHandValue := "Item Ledger Entry"."Cost Amount (Actual)" + "Item Ledger Entry"."Cost Amount (Expected)";
                    IF "Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."Entry Type"::Sale THEN BEGIN
                        IF ("Item Ledger Entry"."Posting Date" >= DIOdate) AND ("Item Ledger Entry"."Posting Date" <= WORKDATE) THEN BEGIN
                            DIOSaleValue := "Item Ledger Entry"."Sales Amount (Actual)";
                        END;

                        IF ("Item Ledger Entry"."Posting Date" >= CurStrtDt) THEN BEGIN
                            CurMonUnit := "Item Ledger Entry".Quantity * -1;
                            CurMonValue := "Item Ledger Entry"."Sales Amount (Actual)";
                        END;

                        IF ("Item Ledger Entry"."Posting Date" >= LstStrtDt1) AND ("Item Ledger Entry"."Posting Date" <= LstEndDt1) THEN BEGIN
                            LastMon1Unit := "Item Ledger Entry".Quantity * -1;
                            LastMon1Value := "Item Ledger Entry"."Sales Amount (Actual)";
                        END;
                        IF ("Item Ledger Entry"."Posting Date" >= LstStrtDt2) AND ("Item Ledger Entry"."Posting Date" <= LstEndDt2) THEN BEGIN
                            LastMon2Unit := "Item Ledger Entry".Quantity * -1;
                            LastMon2Value := "Item Ledger Entry"."Sales Amount (Actual)";
                        END;
                        IF ("Item Ledger Entry"."Posting Date" >= LstStrtDt3) AND ("Item Ledger Entry"."Posting Date" <= LstEndDt3) THEN BEGIN
                            LastMon3Unit := "Item Ledger Entry".Quantity * -1;
                            LastMon3Value := "Item Ledger Entry"."Sales Amount (Actual)";
                        END;
                    END;

                    //IF "Item Ledger Entry"."Entry Type"="Item Ledger Entry"."Entry Type"::Transfer THEN BEGIN
                    IF ("Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."Entry Type"::Transfer) AND ("Item Ledger Entry"."Document Type" = "Item Ledger Entry"."Document Type"::"Transfer Shipment") THEN BEGIN
                        IF "Item Ledger Entry".Quantity < 0 THEN
                            IF ItemOpenInTransit("Item Ledger Entry"."Document No.", "Item Ledger Entry"."Location Code") THEN BEGIN
                                //MESSAGE('DOCUMENT %1',"Item Ledger Entry"."Document No.");
                                StockInTransUnit := "Item Ledger Entry".Quantity * -1;
                                StockInTransValue := "Item Ledger Entry"."Cost Amount (Actual)" * -1;
                                //StockInHandValue :=  StockInHandValue - StockInTransValue;
                            END;
                    END;

                    IF locatn.GET("Item Ledger Entry"."Location Code") THEN
                        staterec.GET(locatn."State Code");
                    CompAge := 0;
                    //stockinhandval:=0;
                    //stockinhandval:="Item Ledger Entry"."Remaining Quantity"*Item."Unit Cost";
                    IF (("Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."Entry Type"::Purchase) OR
                    ("Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."Entry Type"::"Positive Adjmt.") OR
                    ("Item Ledger Entry"."Document Type" = "Item Ledger Entry"."Document Type"::"Sales Credit Memo"))
                     AND "Item Ledger Entry".Open THEN BEGIN
                        IF "Item Ledger Entry"."Serial No." <> '' THEN BEGIN
                            ILE.RESET;
                            ILE.SETRANGE("Item No.", "Item Ledger Entry"."Item No.");
                            ILE.SETRANGE("Serial No.", "Item Ledger Entry"."Serial No.");
                            ILE.SETRANGE("Entry Type", "Item Ledger Entry"."Entry Type"::Purchase, "Item Ledger Entry"."Entry Type"::"Positive Adjmt.");
                            IF ILE.FINDFIRST THEN BEGIN
                                CompAge := TODAY - ILE."Posting Date";
                                NoOfCompAge := 1;
                            END
                            ELSE BEGIN
                                CompAge := TODAY - "Item Ledger Entry"."Posting Date";
                                NoOfCompAge := 1;
                            END;
                        END
                        ELSE BEGIN
                            // IF ("Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."Entry Type":: "Positive Adjmt.") THEN BEGIN
                            CompAge := TODAY - "Item Ledger Entry"."Posting Date";
                            NoOfCompAge := 1;
                        END;
                    END;

                    IF (("Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."Entry Type"::Transfer) AND "Item Ledger Entry".Open) THEN BEGIN
                        IF "Item Ledger Entry"."Document Type" = "Item Ledger Entry"."Document Type"::"Transfer Shipment" THEN BEGIN
                            CompAge := CalcCompAge("Item Ledger Entry"."Item No.", "Item Ledger Entry"."Location Code", "Item Ledger Entry"."Posting Date");// TODAY-"Item Ledger Entry"."Posting Date";
                            IF CompAge = 0 THEN
                                CompAge := TODAY - "Item Ledger Entry"."Posting Date";
                            NoOfCompAge := 1;
                        END;
                        IF "Item Ledger Entry"."Document Type" = "Item Ledger Entry"."Document Type"::"Transfer Receipt" THEN BEGIN
                            ILE.RESET;
                            ILE.SETRANGE("Item No.", "Item Ledger Entry"."Item No.");
                            ILE.SETRANGE("Order No.", "Item Ledger Entry"."Order No.");
                            ILE.SETRANGE("Document Type", "Item Ledger Entry"."Document Type"::"Transfer Shipment");
                            IF ILE.FINDFIRST THEN BEGIN
                                CompAge := CalcCompAge("Item Ledger Entry"."Item No.", "Item Ledger Entry"."Location Code", "Item Ledger Entry"."Posting Date");// TODAY-"Item Ledger Entry"."Posting Date";
                                IF CompAge = 0 THEN
                                    CompAge := TODAY - "Item Ledger Entry"."Posting Date";
                                NoOfCompAge := 1;
                            END;
                        END;

                    END;
                    IF "Item Ledger Entry".Open THEN BEGIN
                        StoreAgeUnit := WORKDATE - "Item Ledger Entry"."Posting Date";
                        NoOfAgeUnit := 1;
                    END
                    ELSE
                        StoreAgeUnit := 0;


                    //IF staterec.GET("Sales Invoice Line".State) THEN;
                    //IF item.GET("Sales Invoice Line"."No.") THEN;
                end;
            }

            trigger OnAfterGetRecord()
            var
                ItemLocal: Record 27;
                ItemInventory: Decimal;
                xItemCost: Decimal;
                ILE: Record 32;
            begin
                Srno += 1;
                xLocationCode := '';
                //WIN
                xItemCost := 0;
                ItemInventory := 0;
                POQty := 0;
                POValue := 0;
                xLocationCode := Item.GETFILTER(Item."Location Filter");
                IF location = 'TRUE' THEN BEGIN
                    IF xLocationCode <> '' THEN BEGIN
                        NoOfAgeUnit := 0;
                        StoreAgeUnit := 0;
                        //StockInTransUnit := 0;
                        //StockInTransValue := 0;
                        //xLocationCode := Item.GETFILTER(Item."Location Filter");
                        PurchLine.RESET;
                        PurchLine.SETRANGE(PurchLine."Document Type", PurchLine."Document Type"::Order);
                        PurchLine.SETRANGE("No.", "No.");
                        //   PurchLine.SETRANGE("Location Code",xLocationCode);
                        // PurchLine.SETRANGE("Quantity Received",'=%1',0);
                        IF PurchLine.FINDSET THEN BEGIN
                            REPEAT
                                POQty += PurchLine.Quantity - PurchLine."Quantity Received";
                                POValue += (PurchLine."Direct Unit Cost" * (PurchLine.Quantity - PurchLine."Quantity Received"))
                            UNTIL PurchLine.NEXT = 0;
                        END;
                    END;
                END
                ELSE BEGIN
                    NoOfAgeUnit := 0;
                    StoreAgeUnit := 0;
                    //StockInTransUnit := 0;
                    //StockInTransValue := 0;
                    PurchLine.RESET;
                    PurchLine.SETRANGE(PurchLine."Document Type", PurchLine."Document Type"::Order);
                    PurchLine.SETRANGE("No.", "No.");
                    //PurchLine.SETRANGE("Location Code",'%1',"Item Ledger Entry"."Location Code");
                    // PurchLine.SETRANGE(PurchLine."Quantity Received",'<>%1',0);
                    //  PurchLine.SETRANGE(PurchLine."Outstanding Quantity",'<>%1',0);
                    IF PurchLine.FINDSET THEN BEGIN
                        REPEAT
                            POQty += PurchLine.Quantity - PurchLine."Quantity Received";
                            POValue += (PurchLine."Direct Unit Cost" * (PurchLine.Quantity - PurchLine."Quantity Received"))
                        UNTIL PurchLine.NEXT = 0;
                    END;
                END;

                //
            end;

            trigger OnPreDataItem()
            begin
                Srno := 0;
                location := '';
                IF Item.GETFILTER(Item."Location Filter") <> '' THEN
                    location := 'TRUE';
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CurStrtDt := DMY2DATE(1, DATE2DMY(WORKDATE, 2), DATE2DMY(WORKDATE, 3));
        LstStrtDt1 := CALCDATE('-1M', CurStrtDt);
        LstEndDt1 := CALCDATE('-1D', CurStrtDt);
        LstStrtDt2 := CALCDATE('-1M', LstStrtDt1);
        LstEndDt2 := CALCDATE('-1D', LstStrtDt1);
        LstStrtDt3 := CALCDATE('-1M', LstStrtDt2);
        LstEndDt3 := CALCDATE('-1D', LstStrtDt2);
        DIOdate := CALCDATE('-30D', WORKDATE);

        LastMon1Caption := FORMAT(LstStrtDt1, 0, '<Month Text,3>');
        LastMon2Caption := FORMAT(LstStrtDt2, 0, '<Month Text,3>');
        LastMon3Caption := FORMAT(LstStrtDt3, 0, '<Month Text,3>');

        xLocationCode := '';
        xLocationCode := Item.GETFILTER(Item."Location Filter");
        //xLocationCode := Item.GETFILTER("Item Ledger Entry"."Location Code");

        //LastMon2Caption :=
        //LastMon3Caption :=
    end;

    var
        salesp: Record 13;
        staterec: Record State;
        schem: Record 50001;
        saleshdr: Record 36;
        purchhdr: Record 38;
        Srno: Integer;
        startdt: Date;
        enddt: Date;
        RecVendor: Record 23;
        CompInfo: Record 79;
        payterms: Record 3;
        CurMonthCaption: Code[10];
        LastMon1Caption: Code[10];
        LastMon2Caption: Code[10];
        LastMon3Caption: Code[10];
        LastMon1Unit: Decimal;
        LastMon1Value: Decimal;
        LastMon2Unit: Decimal;
        LastMon2Value: Decimal;
        LastMon3Unit: Decimal;
        LastMon3Value: Decimal;
        CurMonUnit: Decimal;
        CurMonValue: Decimal;
        StockInTransUnit: Decimal;
        StockInTransValue: Decimal;
        xLocationCode: Code[20];
        CurStrtDt: Date;
        LstStrtDt1: Date;
        LstEndDt1: Date;
        LstStrtDt2: Date;
        LstEndDt2: Date;
        LstStrtDt3: Date;
        LstEndDt3: Date;
        StockInHandUnit: Decimal;
        StockInHandValue: Decimal;
        POQty: Decimal;
        POValue: Decimal;
        PurchLine: Record 39;
        locatn: Record 14;
        DIOvalue: Decimal;
        DIOdate: Date;
        DIO_COGS: Decimal;
        StoreAgeUnit: Decimal;
        StoreAgeValue: Decimal;
        NoOfAgeUnit: Integer;
        location: Text;
        Loc1: Code[20];
        CompAge: Integer;
        NoOfCompAge: Integer;
        DIOSaleValue: Decimal;


    procedure ItemOpenInTransit(DocNo: Code[20]; LocCode: Code[20]): Boolean
    var
        ILE: Record 32;
    begin
        ILE.RESET;
        ILE.SETRANGE("Entry Type", "Item Ledger Entry"."Entry Type"::Transfer);
        ILE.SETRANGE("Document No.", DocNo);
        ILE.SETFILTER("Location Code", '<>%1', LocCode);
        IF ILE.FINDFIRST THEN BEGIN
            //MESSAGE('DOCUMENT %1 Open %2 Location %3',ILE."Document No.",ILE.Open, ILE."Location Code");
            IF ILE.Open THEN
                EXIT(TRUE);
        END;
        EXIT(FALSE);
    end;


    procedure CalcCompAge(ItemNo: Code[20]; LocationCode: Code[20]; TDate: Date): Decimal
    var
        ILE: Record 32;
    begin
        ILE.RESET;
        ILE.SETCURRENTKEY("Item No.", "Entry Type", "Variant Code", "Drop Shipment", "Location Code", "Posting Date");
        ILE.SETRANGE(ILE."Item No.", ItemNo);
        ILE.SETRANGE("Entry Type", "Item Ledger Entry"."Entry Type"::Purchase, "Item Ledger Entry"."Entry Type"::Purchase);
        ILE.SETFILTER("Location Code", '<>%1', LocationCode);
        ILE.SETRANGE("Posting Date", 0D, TDate);
        IF ILE.FINDLAST THEN
            EXIT(TODAY - ILE."Posting Date")
        ELSE
            EXIT(0);
    end;
}

