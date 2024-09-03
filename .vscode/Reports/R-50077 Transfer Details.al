report 50077 "Transfer Details"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = './Transfer Details.rdl';

    dataset
    {
        dataitem("Transfer Shipment Header"; "Transfer Shipment Header")
        {
            RequestFilterFields = "Posting Date", "Transfer Order No.";
            column(TransferOrderNo_TransferShipmentHeader; "Transfer Shipment Header"."Transfer Order No.")
            {
            }
            column(No_TransferShipmentHeader; "Transfer Shipment Header"."No.")
            {
            }
            column(TransferfromCode_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-from Code")
            {
            }
            column(TransfertoCode_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-to Code")
            {
            }
            column(PostingDate_TransferShipmentHeader; "Transfer Shipment Header"."Posting Date")
            {
            }
            column(TransferOrderDate_TransferShipmentHeader; "Transfer Shipment Header"."Transfer Order Date")
            {
            }
            column(FromGSTIN; FromGSTIN)
            {
            }
            column(TotAmt; TotAmt)
            {
            }
            column(GSTAmt; GSTAmt)
            {
            }
            column(ToGSTIN; ToGSTIN)
            {
            }
            column(TextFilter; TextFilter)
            {
            }
            column(ShippedByUserID_TransferShipmentHeader; "Transfer Shipment Header"."Shipped By User ID")
            {
            }
            dataitem("Transfer Receipt Header"; "Transfer Receipt Header")
            {
                DataItemLink = "Transfer Order No." = FIELD("Transfer Order No.");
                column(PostingDate_TransferReceiptHeader; "Transfer Receipt Header"."Posting Date")
                {
                }
                column(No_TransferReceiptHeader; "Transfer Receipt Header"."No.")
                {
                }
                column(TransferfromCode_TransferReceiptHeader; "Transfer Receipt Header"."Transfer-from Code")
                {
                }
                column(ReceivedByUserID_TransferReceiptHeader; "Transfer Receipt Header"."Received By User ID")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                TotAmt := 0;
                GSTAmt := 0;
                ToGSTIN := '';
                FromGSTIN := '';

                RecTSL.RESET;
                RecTSL.SETRANGE("Document No.", "Transfer Shipment Header"."No.");
                IF RecTSL.FINDSET THEN
                    REPEAT
                        TotAmt += RecTSL.Amount;
                    //    GSTAmt += RecTSL."Total GST Amount";
                    UNTIL RecTSL.NEXT = 0;

                IF RecLoc.GET("Transfer Shipment Header"."Transfer-from Code") THEN BEGIN
                    FromGSTIN := RecLoc."GST Registration No.";
                    FromLoc := RecLoc.Name;
                END;
                IF RecLoc.GET("Transfer Shipment Header"."Transfer-to Code") THEN BEGIN
                    ToGSTIN := RecLoc."GST Registration No.";
                    ToLoc := RecLoc.Name;
                END;
            end;

            trigger OnPreDataItem()
            begin
                TextFilter := "Transfer Shipment Header".GETFILTERS;
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
        FromGSTIN: Text;
        ToGSTIN: Text;
        TotAmt: Decimal;
        GSTAmt: Decimal;
        FromLoc: Text;
        ToLoc: Text;
        RecLoc: Record Location;
        RecTSL: Record "Transfer Shipment Line";
        TextFilter: Text;
}

