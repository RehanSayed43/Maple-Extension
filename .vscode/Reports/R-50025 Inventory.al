report 50025 Inventory
{
    DefaultLayout = RDLC;
    RDLCLayout = './Inventory.rdl';
    ApplicationArea = FixedAsset;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            column(ItemNo_ItemLedgerEntry; "Item Ledger Entry"."Item No.")
            {
            }
            column(PostingDate_ItemLedgerEntry; "Item Ledger Entry"."Posting Date")
            {
            }
            column(Quantity_ItemLedgerEntry; "Item Ledger Entry".Quantity)
            {
            }
            column(RemainingQuantity_ItemLedgerEntry; "Item Ledger Entry"."Remaining Quantity")
            {
            }
            column(InvoicedQuantity_ItemLedgerEntry; "Item Ledger Entry"."Invoiced Quantity")
            {
            }
            column(GlobalDimension1Code_ItemLedgerEntry; "Item Ledger Entry"."Global Dimension 1 Code")
            {
            }
            column(VarDays; VarDays)
            {
            }
            column(ItemCategoryCode_ItemLedgerEntry; "Item Ledger Entry"."Item Category Code")
            {
            }
            // column(ProductGroupCode_ItemLedgerEntry; "Item Ledger Entry"."Product Group Code")
            // {
            // }
            column(Description_ItemLedgerEntry; "Item Ledger Entry".Description)
            {
            }
            column(LocationCode_ItemLedgerEntry; "Item Ledger Entry"."Location Code")
            {
            }
            column(Primarycategory_ItemLedgerEntry; "Item Ledger Entry"."Primary category")
            {
            }
            column(Secondarycategory_ItemLedgerEntry; "Item Ledger Entry"."Secondary category")
            {
            }
            column(Thirdcategory_ItemLedgerEntry; "Item Ledger Entry"."Third category")
            {
            }
            column(State; RecState.Description)
            {
            }
            column(Zone; RecState.Zone)
            {
            }

            trigger OnAfterGetRecord()
            begin
                RecState.GET;

                VarDays := TODAY - "Item Ledger Entry"."Posting Date";

                VarStoreDays := TODAY - "Item Ledger Entry"."Posting Date";
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

    var
        VarDays: Integer;
        RecState: Record "State";
        VarStoreDays: Integer;
}

