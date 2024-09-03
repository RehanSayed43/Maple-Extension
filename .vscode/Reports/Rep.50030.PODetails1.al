report 50030 "PO Details 1"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PODetails1.rdlc';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            column(LocationCode_PurchaseHeader; "Purchase Header"."Location Code")
            {
            }
            column(No_PurchaseHeader; "Purchase Header"."No.")
            {
            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                column(LineNo_PurchaseLine; "Purchase Line"."Line No.")
                {
                }
                column(UPNCode_PurchaseLine; "Purchase Line"."UPN Code")
                {
                }
                column(Quantity_PurchaseLine; "Purchase Line"."Qty. to Receive")
                {
                }
                column(No_PurchaseLine; "Purchase Line"."No.")
                {
                }
                column(Description_PurchaseLine; "Purchase Line".Description)
                {
                }
                column(VendorPartCodeLong_PurchaseLine; "Purchase Line"."Vendor Part Code Long")
                {
                }
                dataitem("Reservation Entry"; "Reservation Entry")
                {
                    DataItemLink = "Source ID" = FIELD("Document No."),
                                   "Item No." = FIELD("No.");
                    column(IMEINo_TrackingSpecification; "Reservation Entry"."Serial No.")
                    {
                    }
                    column(SerialNo_TrackingSpecification; "Reservation Entry"."IMEI No.")
                    {
                    }
                }
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

