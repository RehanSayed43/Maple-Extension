report 50084 "B2B Annexture"
{
    DefaultLayout = RDLC;
    RDLCLayout = './B2BAnnexture.rdl';
    PreviewMode = PrintLayout;
    ApplicationArea = FixedAsset;

    dataset
    {
        dataitem("Sales Invoice Line"; "Sales Invoice Line")
        {
            column(SelltoCustomerNo_SalesInvoiceLine; "Sales Invoice Line"."Sell-to Customer No.")
            {
            }
            column(DocumentNo_SalesInvoiceLine; "Sales Invoice Line"."Document No.")
            {
            }
            column(No_SalesInvoiceLine; RecItem."Vendor Part Code Long")
            {
            }
            column(PostingDate_SalesInvoiceLine; "Sales Invoice Line"."Posting Date")
            {
            }
            dataitem("Value Entry"; "Value Entry")
            {
                DataItemLink = "Document No." = FIELD("Document No."),
                               "Item No." = FIELD("No."),
                               "Document Line No." = FIELD("Line No.");
                DataItemTableView = WHERE(Adjustment = FILTER(false));
                dataitem("Item Ledger Entry"; "Item Ledger Entry")
                {
                    DataItemLink = "Entry No." = FIELD("Item Ledger Entry No.");
                    column(LotNo_ItemLedgerEntry; "Item Ledger Entry"."Lot No.")
                    {
                    }
                    column(ItemNo_ItemLedgerEntry; "Item Ledger Entry"."Item No.")
                    {
                    }
                    column(SerialNo_ItemLedgerEntry; "Item Ledger Entry"."Serial No.")
                    {
                    }
                    column(IMEINo_ItemLedgerEntry; "Item Ledger Entry"."IMEI No.")
                    {
                    }
                }
            }

            trigger OnAfterGetRecord()
            begin
                IF RecItem.GET("Sales Invoice Line"."No.") THEN;
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
        RecItem: Record "Item";
}

