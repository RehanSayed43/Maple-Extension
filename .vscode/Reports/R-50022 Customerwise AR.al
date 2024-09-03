report 50022 "Customerwise AR"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Customerwise AR.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            CalcFields = "Balance (LCY)";
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Balance (LCY)";
            column(No_Customer; Customer."No.")
            {
            }
            column(Name_Customer; Customer.Name)
            {
            }
            column(PaymentTerms1; Customer."Payment Terms Code")
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                CalcFields = "Remaining Amount";
                DataItemLink = "Customer No." = FIELD("No.");
                DataItemTableView = WHERE("Remaining Amount" = FILTER(<> 0));
                PrintOnlyIfDetail = false;
                column(ExternalDocumentNo_CustLedgerEntry; "Cust. Ledger Entry"."External Document No.")
                {
                }
                column(DocumentType_CustLedgerEntry; "Cust. Ledger Entry"."Document Type")
                {
                }
                column(CustomerNo_CustLedgerEntry; "Cust. Ledger Entry"."Customer No.")
                {
                }
                column(PostingDate_CustLedgerEntry; "Cust. Ledger Entry"."Posting Date")
                {
                }
                column(DocumentNo_CustLedgerEntry; "Cust. Ledger Entry"."Document No.")
                {
                }
                column(Description_CustLedgerEntry; "Cust. Ledger Entry".Description)
                {
                }
                column(Amount_CustLedgerEntry; "Cust. Ledger Entry".Amount)
                {
                }
                column(RemainingAmount_CustLedgerEntry; "Cust. Ledger Entry"."Remaining Amount")
                {
                }
                column(SalespersonCode_CustLedgerEntry; "Cust. Ledger Entry"."Salesperson Code")
                {
                }
                column(DueDate_CustLedgerEntry; "Cust. Ledger Entry"."Due Date")
                {
                }
                column(Store; "Cust. Ledger Entry"."Global Dimension 1 Code")
                {
                }
                column(Vertical; "Cust. Ledger Entry"."Global Dimension 2 Code")
                {
                }
                column(DueDate; "Cust. Ledger Entry"."Due Date")
                {
                }
                column(PaymentTerms; payterms)
                {
                }
                column(State; StateName)
                {
                }
                column(Zone; Zone1)
                {
                }
                column(SalesPerson; SP)
                {
                }
                column(RemainingAmount; "Cust. Ledger Entry"."Remaining Amount")
                {
                }
                column(City; Customer.City)
                {
                }
                column(billcty; billcty)
                {
                }
                column(penddays; penddays)
                {
                }
                column(RecvdAmt; "Cust. Ledger Entry".Amount)
                {
                }
                column(ShiptoCode; salesinvhdr."Ship-to Code")
                {
                }
                column(ShipToCity; salesinvhdr."Ship-to City")
                {
                }
                column(SellToPostCode; salesinvhdr."Sell-to Post Code")
                {
                }
                column(RecOrderNo; RecOrderNo)
                {
                }
                column(Header_comments; Header_comments)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    /*//WIN316++
                    "Cust. Ledger Entry".CALCFIELDS("Cust. Ledger Entry"."Remaining Amount");
                    IF ("Cust. Ledger Entry"."Remaining Amount">-0.5) AND ("Cust. Ledger Entry"."Remaining Amount"<0.5) THEN
                    CurrReport.SKIP;
                    //WIN316--
                    */
                    CLEAR(Header_comments);
                    StateName := '';
                    Zone1 := '';

                    penddays := 0;
                    payterms := '';
                    billcty := '';
                    RecOrderNo := '';
                    staterec.RESET;
                    salesp.RESET;
                    IF salesp.GET("Cust. Ledger Entry"."Salesperson Code") THEN
                        SP := salesp.Name
                    ELSE
                        SP := '';

                    penddays := "Cust. Ledger Entry"."Posting Date" - TODAY;
                    LocRec.RESET;
                    salesinvhdr.RESET;
                    salesinvhdr.SETFILTER(salesinvhdr."No.", "Cust. Ledger Entry"."Document No.");
                    IF salesinvhdr.FINDFIRST THEN BEGIN
                        billcty := salesinvhdr."Bill-to City";
                        // RecOrderNo := salesinvhdr."Buyer's Order No.";
                        payterms := salesinvhdr."Payment Terms Code";

                        //WIN316++

                        RecSalCommentLine.RESET;
                        RecSalCommentLine.SETRANGE("No.", salesinvhdr."No.");
                        IF RecSalCommentLine.FINDSET THEN BEGIN
                            REPEAT
                                Header_comments += RecSalCommentLine.Comment + ',';
                            UNTIL RecSalCommentLine.NEXT = 0
                        END;
                        POS := STRLEN(Header_comments);
                        IF POS <> 0 THEN
                            Header_comments := COPYSTR(Header_comments, 1, POS - 1);

                        //WIN316++

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
                    RecOrderNo:=salesinvhdr."Buyer's Order No.";
                    payterms:=salesinvhdr."Payment Terms Code";
                    reclocation.GET(RecSalesInvLIne."Location Code");
                    IF reclocation."State Code" <>'' THEN
                    staterec.GET(reclocation."State Code");

                    END;
                    */

                end;

                trigger OnPreDataItem()
                begin
                    //WIN316++
                    //"Cust. Ledger Entry".CALCFIELDS("Cust. Ledger Entry"."Remaining Amount");
                    //"Cust. Ledger Entry".SETFILTER("Cust. Ledger Entry"."Remaining Amount",'<-0.5|>0.5');

                    //WIN316--
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
        staterec: Record State;
        salesp: Record "Salesperson/Purchaser";
        penddays: Integer;
        salesinvhdr: Record "Sales Invoice Header";
        billcty: Text[100];
        payterms: Text[100];
        RecCustLed: Record "Cust. Ledger Entry";
        SP: Text[100];
        RecSalesInvLIne: Record "Sales Invoice Line";
        reclocation: Record Location;
        RecOrderNo: Text[50];
        LocRec: Record "location";
        StateName: Text[100];
        Zone1: Text[100];
        RecSalCommentLine: Record "Sales Comment Line";
        Header_comments: Text;
        POS: Integer;
}

