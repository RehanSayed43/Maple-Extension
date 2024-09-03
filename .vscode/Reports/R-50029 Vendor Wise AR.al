report 50029 "VendorWise AR"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './VendorWise AR.rdl';

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            PrintOnlyIfDetail = true;
            column(No_Customer; Vendor."No.")
            {
            }
            column(Name_Customer; Vendor.Name)
            {
            }
            column(PaymentTerms1; Vendor."Payment Terms Code")
            {
            }
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemLink = "Vendor No." = FIELD("No.");
                PrintOnlyIfDetail = false;
                column(CustomerNo_CustLedgerEntry; "Vendor Ledger Entry"."Vendor No.")
                {
                }
                column(PostingDate_CustLedgerEntry; "Vendor Ledger Entry"."Posting Date")
                {
                }
                column(DocumentNo_CustLedgerEntry; "Vendor Ledger Entry"."Document No.")
                {
                }
                column(Description_CustLedgerEntry; "Vendor Ledger Entry".Description)
                {
                }
                column(Amount_CustLedgerEntry; "Vendor Ledger Entry".Amount)
                {
                }
                column(RemainingAmount_CustLedgerEntry; "Vendor Ledger Entry"."Remaining Amount")
                {
                }
                column(SalespersonCode_CustLedgerEntry; "Vendor Ledger Entry"."Purchaser Code")
                {
                }
                column(DueDate_CustLedgerEntry; "Vendor Ledger Entry"."Due Date")
                {
                }
                column(Store; LocRec.Code)
                {
                }
                column(Vertical; "Vendor Ledger Entry"."Global Dimension 2 Code")
                {
                }
                column(DueDate; "Vendor Ledger Entry"."Due Date")
                {
                }
                column(PaymentTerms; payterms)
                {
                }
                column(State; staterec.Description)
                {
                }
                column(Zone; staterec.Zone)
                {
                }
                column(SalesPerson; SP)
                {
                }
                column(RemainingAmount; "Vendor Ledger Entry"."Remaining Amount")
                {
                }
                column(City; Vendor.City)
                {
                }
                column(billcty; billcty)
                {
                }
                column(penddays; penddays)
                {
                }
                column(RecvdAmt; "Vendor Ledger Entry".Amount)
                {
                }
                column(ShiptoCode; salesinvhdr."Ship-to Code")
                {
                }
                column(ShipToCity; salesinvhdr."Ship-to City")
                {
                }
                column(SellToPostCode; '')
                //column(SellToPostCode; salesinvhdr."Buy-from Post Code")
                {
                }
                column(RecOrderNo; RecOrderNo)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    StateName := '';
                    Zone1 := '';

                    penddays := 0;
                    payterms := '';
                    billcty := '';
                    RecOrderNo := '';
                    salesp.RESET;
                    IF salesp.GET("Vendor Ledger Entry"."Purchaser Code") THEN
                        SP := salesp.Name
                    ELSE
                        SP := '';

                    penddays := "Vendor Ledger Entry"."Posting Date" - TODAY;
                    LocRec.RESET;
                    salesinvhdr.RESET;
                    salesinvhdr.SETFILTER(salesinvhdr."No.", "Vendor Ledger Entry"."Document No.");
                    IF salesinvhdr.FINDFIRST THEN BEGIN
                        //    billcty := salesinvhdr."Pay-to City";
                        //staterec.GET(salesinvhdr."Bill to Customer State");
                        RecOrderNo := salesinvhdr."Order No.";
                        payterms := salesinvhdr."Payment Terms Code";
                        LocRec.RESET;
                        //MESSAGE(salesinvhdr."Location Code");
                        IF LocRec.GET(salesinvhdr."Location Code") THEN
                            IF staterec.GET(LocRec."State Code") THEN BEGIN
                                StateName := staterec.Description;
                                Zone1 := staterec.Zone;
                            END;

                    END;

                    /*
                    salesinvhdr.RESET;
                    RecSalesInvLIne.RESET;
                    salesinvhdr.SETFILTER(salesinvhdr."No.","Cust. Ledger Entry"."Document No.");
                    IF salesinvhdr.FINDFIRST THEN
                    BEGIN
                    billcty:=salesinvhdr."Bill-to City";
                    RecSalesInvLIne.GET(RecSalesInvLIne."Document No.","Cust. Ledger Entry"."Document No.");
                    //staterec.GET(RecSalesInvLIne.State);
                    //staterec.GET(salesinvhdr."Bill to Customer State");
                    payterms:=salesinvhdr."Payment Terms Code";
                    reclocation.GET(RecSalesInvLIne."Location Code");
                    IF reclocation."State Code" <>'' THEN
                    staterec.GET(reclocation."State Code");

                    END;
                    */

                end;
            }

            trigger OnAfterGetRecord()
            begin
                /*RecCustLed.RESET;
                RecCustLed.SETFILTER("Customer No.",'%1',Customer."No.");
                IF NOT RecCustLed.FINDFIRST THEN
                CurrReport.SKIP; */

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
        staterec: Record "State";
        salesp: Record "Salesperson/Purchaser";
        penddays: Integer;
        salesinvhdr: Record "Purch. Inv. Header";  //kj
        billcty: Text[100];
        payterms: Text[100];
        RecCustLed: Record "Vendor Ledger Entry";
        SP: Text[100];
        RecSalesInvLIne: Record "Purch. Inv. Line";
        reclocation: Record Location;
        RecOrderNo: Text[50];
        LocRec: Record "location";
        StateName: Text[100];
        Zone1: Text[100];
}

