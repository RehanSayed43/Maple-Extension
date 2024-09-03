report 50057 "Purchase Register Summary"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './PurchaseRegisterSummary.rdl';

    dataset
    {
        // dataitem(DataItem1000000019; Table122)
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            DataItemTableView = SORTING("Posting Date")
                                ORDER(Ascending)
                                WHERE("Order No." = FILTER(<> ''));
            RequestFilterFields = "Shortcut Dimension 1 Code";
            RequestFilterHeading = '<>';
            column(No_PurchInvHeader; "Purch. Inv. Header"."No.")
            {
            }
            column(ShiptoCity_PurchInvHeader; "Purch. Inv. Header"."Ship-to City")
            {
            }
            column(ShortcutDimension1Code_PurchInvHeader; "Purch. Inv. Header"."Shortcut Dimension 1 Code")
            {
            }
            column(PostingDate_PurchInvHeader; FORMAT("Purch. Inv. Header"."Posting Date"))
            {
            }
            column(PostingDate11_PurchInvHeader; "Purch. Inv. Header"."Posting Date")
            {
            }
            column(BuyfromVendorNo_PurchInvHeader; "Purch. Inv. Header"."Buy-from Vendor No.")
            {
            }
            column(EDATE; EDATE)
            {
            }
            column(SDATE; SDATE)
            {
            }
            column(BuyfromVendorName_PurchInvHeader; "Purch. Inv. Header"."Buy-from Vendor Name")
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(OrderNo_PurchInvHeader; "Purch. Inv. Header"."Order No.")
            {
            }
            column(VendorInvoiceNo_PurchInvHeader; "Purch. Inv. Header"."Vendor Invoice No.")
            {
            }
            column(DocumentDate_PurchInvHeader; FORMAT("Purch. Inv. Header"."Document Date"))
            {
            }
            column(Currency_Code; "Currency Code")
            {
            }
            column(VendorTable_City; VendorTable.City)
            {
            }
            column(PurchINVAmountLCY; PurchINVAmountLCY)
            {
            }
            column(Dime_1; "Purch. Inv. Header"."Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code_PurchInvHeader; "Purch. Inv. Header"."Shortcut Dimension 2 Code")
            {
            }
            //dataitem(DataItem1000000008;Table123)
            dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Posting Date")
                                    ORDER(Ascending);
                column(Amount_PurchInvLine; "Purch. Inv. Line".Amount)
                {
                }
                /* column(TaxAmount_PurchInvLine;"Purch. Inv. Line"."Tax Amount")
                {
                }
                column(AmountIncludingTax_PurchInvLine;"Purch. Inv. Line"."Amount Including Tax")
                {
                } *///kj_need to check
                column(Quantity_PurchInvLine; "Purch. Inv. Line".Quantity)
                {
                }
                column(Sno; Sno)
                {
                }
                column(BRANCH_NAME; BRANCH_NAME)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                IF VendorTable.GET("Purch. Inv. Header"."Buy-from Vendor No.") THEN;

                Sno += 1;

                IF "Currency Code" <> '' THEN
                    "Currency Code" := "Purch. Inv. Header"."Currency Code"
                ELSE
                    "Currency Code" := 'INR';

                /*  CALCFIELDS("Amount to Vendor");
                 PurchINVAmount:="Purch. Inv. Header"."Amount to Vendor"; */ //kj_need to check

                //IF "Currency Code" <> '' THEN BEGIN
                IF "Currency Factor" <> 0 THEN
                    PurchINVAmountLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(WORKDATE, "Currency Code", PurchINVAmount, "Currency Factor"))
                ELSE
                    PurchINVAmountLCY := PurchINVAmount
                //END;
            end;

            trigger OnPreDataItem()
            begin
                IF CompanyInfo.GET THEN;
                SETFILTER("Posting Date", '%1..%2', SDATE, EDATE);

                CurrReport.CREATETOTALS(PurchINVAmount, PurchINVAmountLCY)//PurchINVOnOrder,PurchAmtOnOrderLCY);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Start Date"; SDATE)
                {
                    ApplicationArea = All;
                }
                field("End Date"; EDATE)
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
        PRE := 0;
        Sno := 0;
    end;

    var
        SDATE: Date;
        EDATE: Date;
        CompanyInfo: Record "Company Information";//"79";
        Sno: Integer;
        PRE: Integer;
        Dimension_value: Record "Dimension Value";//"349";
        BRANCH_NAME: Text;
        VendorTable: Record Vendor;//"23";
        "Currency Code": Code[10];
        PurchINVAmountLCY: Decimal;
        CurrExchRate: Record "Currency Exchange Rate";//"330";
        PurchINVHeader: Record "Purch. Inv. Header";//"122";
        PurchINVAmount: Decimal;
}

