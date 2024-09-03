#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50058 "Purchase Register Detailed"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Purchase Register Detailed.rdlc';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            DataItemTableView = where("Order No." = filter(<> ''));
            RequestFilterFields = "Shortcut Dimension 1 Code";
            column(ReportForNavId_1000000019; 1000000019)
            {
            }
            column(BuyfromVendorNo_PurchInvHeader; "Purch. Inv. Header"."Buy-from Vendor No.")
            {
            }
            column(No_PurchInvHeader; "Purch. Inv. Header"."No.")
            {
            }
            column(PostingDate_PurchInvHeader; Format("Purch. Inv. Header"."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(PostingDate11_PurchInvHeader; "Purch. Inv. Header"."Posting Date")
            {
            }
            column(BuyfromVendorName_PurchInvHeader; "Purch. Inv. Header"."Buy-from Vendor Name")
            {
            }
            column(Amount_PurchInvHeader; "Purch. Inv. Header".Amount)
            {
            }
            column(PurchaserCode_PurchInvHeader; "Purch. Inv. Header"."Purchaser Code")
            {
            }
            column(ShortcutDimension1Code_PurchInvHeader; "Purch. Inv. Header"."Shortcut Dimension 1 Code")
            {
            }
            column(OrderNo_PurchInvHeader; "Purch. Inv. Header"."Order No.")
            {
            }
            column(EDATE; Format(EDATE, 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(Payment_MethodDescription; Payment_Method.Description)
            {
            }
            column(Transporter_Table_Name; "Transporter Table".Name)
            {
            }
            column(BuyfromCity_PurchInvHeader; "Purch. Inv. Header"."Buy-from City")
            {
            }
            column(SDATE; Format(SDATE, 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(VendorInvoiceNo_PurchInvHeader; "Purch. Inv. Header"."Vendor Invoice No.")
            {
            }
            column(SalesPerson_Purchase_Name; SalesPerson_Purchase.Name)
            {
            }
            column(AmounttoVendor_PurchInvHeader; "Purch. Inv. Header".Amount)
            {
            }
            column(DocumentDate_PurchInvHeader; Format("Purch. Inv. Header"."Document Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(ReportForNavId_1000000008; 1000000008)
                {
                }
                column(Sno; Sno)
                {
                }
                column(BRANCH_NAME; BRANCH_NAME)
                {
                }
                column(No_PurchInvLine; "Purch. Inv. Line"."No.")
                {
                }
                column(Description_PurchInvLine; "Purch. Inv. Line".Description)
                {
                }
                column(Quantity_PurchInvLine; "Purch. Inv. Line".Quantity)
                {
                }
                column(Amount_PurchInvLine; "Purch. Inv. Line".Amount)
                {
                }
                column(Tax_PurchInvLine; '')//"Purch. Inv. Line"."Tax %")
                {
                }
                column(TaxAmount_PurchInvLine; '')//"Purch. Inv. Line"."Tax Amount")
                {
                }
                column(DirectUnitCost_PurchInvLine; "Purch. Inv. Line"."Direct Unit Cost")
                {
                }
                column(AmountIncludingVAT_PurchInvLine; "Purch. Inv. Line"."Amount Including VAT")
                {
                }
                column(LineAmount_PurchInvLine; "Purch. Inv. Line"."Line Amount")
                {
                }
                column(AMT; AMT)
                {
                }
                column(UnitofMeasureCode_PurchInvLine; "Purch. Inv. Line"."Unit of Measure Code")
                {
                }
                column(Service_Tax_Amount; '')//"Purch. Inv. Line"."Service Tax Amount")
                {
                }
                column(TDS_Amount; '')//"Purch. Inv. Line"."TDS Amount")
                {
                }
                column(TDS_Percentage; '')//"Purch. Inv. Line"."TDS %")
                {
                }
                column(ServiceTaxeCessAmount_PurchInvLine; '')//"Purch. Inv. Line"."Service Tax eCess Amount")
                {
                }
                column(ServiceTaxSHECessAmount_PurchInvLine; '')//"Purch. Inv. Line"."Service Tax SHE Cess Amount")
                {
                }
                column(AmountToVendor_PurchInvLine; '')//"Purch. Inv. Line"."Amount To Vendor")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Sno += 1;

                    AMT := "Purch. Inv. Line"."Amount Including VAT" + "Purch. Inv. Line"."Line Amount";
                end;

                trigger OnPreDataItem()
                begin
                    Sno := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if Payment_Method.Get("Purch. Inv. Header"."Payment Terms Code") then;
                if CompanyInfo.Get then;
                if SalesPerson_Purchase.Get("Purch. Inv. Header"."Purchaser Code") then;
            end;

            trigger OnPreDataItem()
            begin
                // SetFilter("Posting Date", '%1..%2', SDATE, EDATE);
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
                    ApplicationArea = Basic;
                }
                field("End Date"; EDATE)
                {
                    ApplicationArea = Basic;
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
        SDATE: Date;
        EDATE: Date;
        CompanyInfo: Record "Company Information";
        Payment_Method: Record "Payment Method";
        Sno: Integer;
        Dimension_value: Record "Dimension Value";
        BRANCH_NAME: Text;
        "Transporter Table": Record "Shipping Agent";
        SalesPerson_Purchase: Record "Salesperson/Purchaser";
        AMT: Decimal;
}

