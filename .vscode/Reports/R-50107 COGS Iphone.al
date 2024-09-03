report 50107 " COGS Iphone"
{
    DefaultLayout = RDLC;
    Caption = 'COGS Iphone1';
    RDLCLayout = './COGSIphone.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = SORTING("Serial No.")
                                WHERE("Serial No." = FILTER(<> ''));
            column(SerialNo_ItemLedgerEntry; "Item Ledger Entry"."Serial No.")
            {
            }
            column(ItemNo_ItemLedgerEntry; "Item Ledger Entry"."Item No.")
            {
            }
            column(PostingDate_ItemLedgerEntry; "Item Ledger Entry"."Posting Date")
            {
            }
            column(VendorPartCode; VendorPartCode)
            {
            }
            column(PrimeCategory; PrimeCategory)
            {
            }
            column(SecondoryCategory; SecondoryCategory)
            {
            }
            column(ThirdCategory; ThirdCategory)
            {
            }
            column(Catgory; Catgory)
            {
            }
            column(Brand; Brand)
            {
            }
            column(PurchaseInvoiceValue; PurchaseInvoiceValue)
            {
            }
            column(DebitNoteOnPurchase; DebitNoteOnPurchase)
            {
            }
            column(VenodorName; VenodorName)
            {
            }
            column(DateOFPurchase; DateOFPurchase)
            {
            }
            column(DateOfDebitNote; DateOfDebitNote)
            {
            }
            column(COGS; COGS)
            {
            }
            column(ItemDesc; ItemDesc)
            {
            }

            column(MRP; "Item Ledger Entry"."MRP Value") { }
            //column(MRP; MRP)           {            }
            column(Diffrence; Diffrence)
            {
            }

            trigger OnAfterGetRecord()
            begin

                CLEAR(VendorPartCode);
                CLEAR(ItemDesc);
                CLEAR(PrimeCategory);
                CLEAR(SecondoryCategory);
                CLEAR(Brand);
                CLEAR(Catgory);
                CLEAR(ThirdCategory);
                CLEAR(COGS);
                CLEAR(DateOFPurchase);
                CLEAR(DateOfDebitNote);
                CLEAR(PurchaseInvoiceValue);
                CLEAR(DebitNoteOnPurchase);
                CLEAR(VenodorName);
                // CLEAR(MRP);

                ItemRec.RESET;
                ItemRec.GET("Item Ledger Entry"."Item No.");

                VendorPartCode := ItemRec."Vendor Part Code Long";
                ItemDesc := ItemRec.Description;
                PrimeCategory := ItemRec."Primary category";
                SecondoryCategory := ItemRec."Secondary category";
                Brand := ItemRec."Item Category Code"; //Brand
                Catgory := ItemRec."Product Category"; // category
                ThirdCategory := ItemRec."Third category";
                COGS := ItemRec."COGS (LCY)"; //CCIT AN
                //MRP := ItemRec."Unit Cost"; //CCIT AN

                IF "Item Ledger Entry"."Document Type" = "Item Ledger Entry"."Document Type"::"Purchase Receipt" THEN
                    DateOFPurchase := "Item Ledger Entry"."Posting Date";
                IF "Item Ledger Entry"."Document Type" = "Item Ledger Entry"."Document Type"::"Purchase Return Shipment" THEN
                    DateOfDebitNote := "Item Ledger Entry"."Posting Date";

                // Data from Value Entry table
                ValueEntryRec.RESET;
                ValueEntryRec.SETRANGE("Item Ledger Entry No.", "Entry No.");
                ValueEntryRec.SETRANGE("Item Ledger Entry Type", ValueEntryRec."Item Ledger Entry Type"::Purchase);

                IF ValueEntryRec.FINDSET THEN BEGIN
                    REPEAT
                        IF ValueEntryRec."Document Type" = ValueEntryRec."Document Type"::"Purchase Invoice" THEN
                            PurchaseInvoiceValue += ValueEntryRec."Cost Amount (Actual)";
                        IF ValueEntryRec."Document Type" = ValueEntryRec."Document Type"::"Purchase Credit Memo" THEN
                            DebitNoteOnPurchase += ValueEntryRec."Cost Amount (Actual)";
                        // get Vendor information
                        VendorRec.GET(ValueEntryRec."Source No.");
                        VenodorName := VendorRec.Name;
                    UNTIL ValueEntryRec.NEXT = 0;
                END;
                Diffrence := COGS - PurchaseInvoiceValue + DebitNoteOnPurchase;
            end;

            trigger OnPreDataItem()
            begin
                //"Item Ledger Entry".SETRANGE("Item Category Code",'APPLE');
                //"Item Ledger Entry".SETRANGE("Product Group Code",'PHO');
                "Item Ledger Entry".SETRANGE("Entry Type", "Item Ledger Entry"."Entry Type"::Purchase);
                "Item Ledger Entry".SETFILTER("Document Type", '%1 | %2', "Item Ledger Entry"."Document Type"::"Purchase Receipt", "Item Ledger Entry"."Document Type"::"Purchase Return Shipment");
                IF (StartDate <> 0D) AND (EndDate <> 0D) THEN BEGIN
                    "Item Ledger Entry".SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Start Date"; StartDate)
                {
                    ApplicationArea = All;
                }
                field("End Date"; EndDate)
                {
                    ApplicationArea = All;
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
        IF (StartDate <> 0D) AND (EndDate = 0D) THEN
            ERROR('Please Select End Date');
        IF (StartDate = 0D) AND (EndDate <> 0D) THEN
            ERROR('Please Select start date');
    end;

    var
        ItemRec: Record Item;
        ValueEntryRec: Record "Value Entry";
        VendorRec: Record Vendor;
        VendorPartCode: Code[50];
        ItemDesc: Text[250];
        PrimeCategory: Code[30];
        SecondoryCategory: Code[30];
        ThirdCategory: Code[30];
        Brand: Code[50];
        Catgory: Text[50];
        COGS: Decimal;
        PurchaseInvoiceValue: Decimal;
        DebitNoteOnPurchase: Decimal;
        VenodorName: Text[250];
        DateOFPurchase: Date;
        DateOfDebitNote: Date;
        MRP: Decimal;
        StartDate: Date;
        EndDate: Date;
        Diffrence: Decimal;
}

