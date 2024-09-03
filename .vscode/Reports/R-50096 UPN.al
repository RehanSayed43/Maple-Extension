report 50096 UPN
{
    DefaultLayout = RDLC;
    RDLCLayout = './UPN.rdl';
    ApplicationArea = FixedAsset;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            column(DocumentNo_ItemLedgerEntry; "Item Ledger Entry"."Document No.")
            {
            }
            column(OrderNO; "Item Ledger Entry"."Order No.")
            {
            }
            column(ItemNo_ItemLedgerEntry; "Item Ledger Entry"."Item No.")
            {
            }
            column(UPNCode_ItemLedgerEntry; "Item Ledger Entry"."UPN Code")
            {
            }
            column(PostingDate_ItemLedgerEntry; "Item Ledger Entry"."Posting Date")
            {
            }
            column(Description_ItemLedgerEntry; "Item Ledger Entry".Description)
            {
            }
            column(LocationCode_ItemLedgerEntry; "Item Ledger Entry"."Location Code")
            {
            }
            column(Quantity_ItemLedgerEntry; "Item Ledger Entry".Quantity)
            {
            }
            column(CostAmount; "Item Ledger Entry"."Cost Amount (Actual)")
            {
            }
            column(PurchaseAmount; "Item Ledger Entry"."Purchase Amount (Actual)")
            {
            }
            column(SerialNo; "Item Ledger Entry"."Serial No.")
            {
            }
            column(IMEI; "Item Ledger Entry"."IMEI No.")
            {
            }
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
}

