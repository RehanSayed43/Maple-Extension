report 50031 "Daily Inventory Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Daily Inventory Report.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Location; Location)
        {
            DataItemTableView = SORTING(Code)
                                WHERE("Location Type" = FILTER(Saleable));
            RequestFilterFields = "Code";
            column(Code_Location; Location.Code)
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            dataitem(Item; Item)
            {
                DataItemLink = "Location Filter" = FIELD(Code);
                //  DataItemTableView = SORTING("Item Category Code", "Product Group Code", "Primary category,No.");
                PrintOnlyIfDetail = false;
                RequestFilterFields = "No.";
                column(No_Item; Item."No.")
                {
                }
                column(Description_Item; Item.Description)
                {
                }
                column(ProductGroupCode_Item; '')//Item."Product Group Code")
                {
                }
                column(Primarycategory_Item; Item."Primary category")
                {
                }
                //CCIT AN 04092023 // Additonal field added ++
                column(Secondary_category; "Secondary category") { }
                column(Third_category; "Third category") { }
                column(Vendor_Part_Code_Long; "Vendor Part Code Long") { }
                column(Brand; "Item Category Code") { }
                column(Category; "Product Category") { }
                //CCIT AN--
                column(VendorPartCodeLong_Item; Item."Vendor Part Code Long")
                {
                }
                column(Inventory_Item; Item.Inventory)
                {
                }
                column(EntryCaption; EntryCaption)
                {
                }
                column(InvQty; Qty)
                {
                }
                dataitem(Integer; Integer)
                {
                    column(Number; Integer.Number)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF Integer.Number = 1 THEN BEGIN
                            Qty := OpQty;
                            EntryCaption := 'Opening';
                        END;
                        IF Integer.Number = 2 THEN BEGIN
                            Qty := CloseQty;
                            EntryCaption := 'xClosing';
                        END;
                        IF Integer.Number = 3 THEN BEGIN
                            Qty := PRQTY;
                            EntryCaption := 'Purchase Return';
                        END;
                        IF Integer.Number = 4 THEN BEGIN
                            Qty := SRQTY;
                            EntryCaption := 'Sales Return';
                        END;
                        IF Integer.Number = 5 THEN BEGIN
                            Qty := SQTY;
                            EntryCaption := 'Sales';
                        END;
                        IF Integer.Number = 6 THEN BEGIN
                            Qty := PQTY;
                            EntryCaption := 'Purchase';
                        END;
                        IF Integer.Number = 7 THEN BEGIN
                            Qty := TQTY;
                            EntryCaption := 'Transfer';
                        END;
                    end;

                    trigger OnPreDataItem()
                    begin
                        Integer.SETRANGE(Integer.Number, 1, 7);
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    ILE: Record "Item Ledger Entry";
                begin
                    OpQty := GetOpQty(Item."No.", Location.Code, StartDate - 1);
                    CloseQty := GetOpQty(Item."No.", Location.Code, EndDate);
                    Qty := 0;
                    SQTY := 0;
                    PQTY := 0;
                    TQTY := 0;
                    SRQTY := 0;
                    PRQTY := 0;
                    ILE.RESET;
                    ILE.SETCURRENTKEY("Location Code", "Item No.", "Entry Type");
                    ILE.SETFILTER(ILE."Item No.", '%1', Item."No.");
                    ILE.SETFILTER(ILE."Location Code", '%1', Location.Code);
                    IF ILE.FINDSET THEN
                        REPEAT
                            EntryCaption := FORMAT(ILE."Entry Type");
                            CASE ILE."Entry Type" OF
                                ILE."Entry Type"::Sale:
                                    BEGIN
                                        IF ILE.Quantity >= 0 THEN
                                            SRQTY += ILE.Quantity
                                        ELSE
                                            SQTY += ILE.Quantity * -1;
                                    END;
                                ILE."Entry Type"::Purchase:
                                    BEGIN
                                        IF ILE.Quantity < 0 THEN
                                            PRQTY += ILE.Quantity * -1
                                        ELSE
                                            PQTY += ILE.Quantity;
                                    END;
                                ILE."Entry Type"::Transfer:
                                    BEGIN
                                        IF (ILE."Document Type" = ILE."Document Type"::"Transfer Shipment") AND (ILE.Open) THEN
                                            TQTY += ILE.Quantity * -1;
                                    END;
                            END;
                        UNTIL ILE.NEXT = 0;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("")
                {
                    field(StartDate; StartDate)
                    {
                        Caption = 'From Date';
                        ApplicationArea = All;
                    }
                    field(EndDate; EndDate)
                    {
                        Caption = 'To Date';
                        ApplicationArea = All;
                    }
                }
            }
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
        IF StartDate = 0D THEN
            ERROR('From date should not be blank');

        IF EndDate = 0D THEN
            ERROR('To date should not be blank');
    end;

    var
        Qty: Decimal;
        OpQty: Decimal;
        CloseQty: Decimal;
        StartDate: Date;
        EndDate: Date;
        EntryCaption: Text[50];
        SQTY: Decimal;
        PQTY: Decimal;
        TQTY: Decimal;
        SRQTY: Decimal;
        PRQTY: Decimal;


    procedure GetOpQty(ItemNo: Code[20]; LocationCode: Code[20]; PDate: Date): Decimal
    var
        ItemLocal: Record "Item";
    begin
        ItemLocal.RESET;
        ItemLocal.SETFILTER("No.", '%1', ItemNo);
        ItemLocal.SETFILTER("Location Filter", '%1', LocationCode);
        ItemLocal.SETRANGE("Date Filter", 0D, PDate);
        IF ItemLocal.FINDFIRST THEN BEGIN
            ItemLocal.CALCFIELDS(ItemLocal."Inventory at date");
            EXIT(ItemLocal."Inventory at date");
        END;
        EXIT(0);
    end;
}

