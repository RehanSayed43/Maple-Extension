report 50044 "Customer Purchase Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './CustomerPurchaseReport.rdl';
    ApplicationArea = FixedAsset;

    dataset
    {
        dataitem("Sales Invoice Line"; "Sales Invoice Line")
        {
            column(PostingDate_SalesInvoiceLine; "Sales Invoice Line"."Posting Date")
            {
            }
            // column(AmountToCustomer_SalesInvoiceLine; "Sales Invoice Line"."Amount To Customer")
            // {
            // }
            column(DocumentNo_SalesInvoiceLine; "Sales Invoice Line"."Document No.")
            {
            }
            column(No_SalesInvoiceLine; "Sales Invoice Line"."No.")
            {
            }

            trigger OnPreDataItem()
            begin
                "Sales Invoice Line".SETFILTER("Sales Invoice Line"."Posting Date", '%1..%2', StartDate, EndDate);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(StartDate; StartDate)
                {
                    Caption = 'Starting Date';
                    ApplicationArea = All;
                }
                field(EndDate; EndDate)
                {
                    Caption = 'Ending Date';
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

    var
        StartDate: Date;
        EndDate: Date;
        Text16503: Label 'Please enter the starting date and ending date.';
        Text16504: Label 'Ending date cannot be before starting date.';
}

