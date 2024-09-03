pageextension 50150 RTC_Actions extends "Business Manager Role Center"
{
    layout
    { }

    actions
    {
        addafter("Chart of Accounts")
        {
            group(Mapple_Reports)
            {
                Caption = 'Mapple_Reports';
                group(Account_Reports)       //grp1. Account_Reports 
                {
                    Caption = 'Account Reports';
                    Image = ReferenceData;

                    action("Balance_SheetS")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Balance Sheet';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50051;
                        ToolTip = 'View your company''s assets, liabilities, and equity.';

                    }

                    action("Trial_Balance_WS")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Trial Balance WS';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50053;
                        ToolTip = 'View your company''s assets, liabilities, and equity.';

                    }

                    action("Customer Trial Balance")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer Trial Balance';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50054;
                        ToolTip = 'View your company''s assets, liabilities, and equity.';

                    }

                    action("Vendor Trial Balance")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor Trial Balance';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50055;
                        ToolTip = 'View your company''s assets, liabilities, and equity.';

                    }

                    action("Shield Plus")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Shield Plus';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50028;
                        ToolTip = 'View your company''s assets, liabilities, and equity.';

                    }

                    action("Customerwise AR")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customerwise AR';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50022;
                        ToolTip = 'View your company''s assets, liabilities, and equity.';

                    }

                    action("PDC in HAND")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'PDC in HAND';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50000;
                        ToolTip = 'View your company''s assets, liabilities, and equity.';

                    }

                    action("Bank Account Reconciliation1")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bank Account Reconciliation1';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50006;
                        ToolTip = 'View your company''s assets, liabilities, and equity.';

                    }

                    action("VendorWise AR")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'VendorWise AR';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50029;
                        ToolTip = 'View your company''s assets, liabilities, and equity.';

                    }

                    action("Customer Sales Data11")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer Sales Data';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50091;
                        ToolTip = 'View your company''s assets, liabilities, and equity.';

                    }

                    action("Income Satatement1")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Income Satatement';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50052;
                        ToolTip = 'View your company''s assets, liabilities, and equity.';

                    }
                }

                group(Inventory_Reports) // grp2. Inventory_Reports
                {
                    Caption = 'Inventory Reports';
                    Image = ReferenceData;
                    action("Inventory Ageing")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory Ageing';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50021;
                        ToolTip = 'View your company''s assets, liabilities, and equity.';

                    }
                    action("Report GDV")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Report GDV';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50089;
                        ToolTip = 'View your company''s assets, liabilities, and equity.';

                    }

                    action("Inventory Ageing Skuwise")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory Ageing Skuwise';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50098;
                        ToolTip = 'View your company''s assets, liabilities, and equity.';

                    }

                    action("Daily Inventory Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Daily Inventory Report';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50031;
                        ToolTip = 'View your company''s assets, liabilities, and equity.';

                    }

                    action("Transfer Details")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Transfer Details';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50077;
                        ToolTip = 'View your company''s assets, liabilities, and equity.';

                    }
                }

                group(Sales_Report)  // grp3. Sales_Reports
                {
                    Caption = 'Sales Report';
                    Image = ReferenceData;

                    action("GPReport")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'GPReport';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50019;
                        ToolTip = 'View your company''s assets, liabilities, and equity.';

                    }


                    action("Sales Register Detailed")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Sales Register Detailed';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        //RunObject = Report 50059;//kj
                        ToolTip = 'View your company''s assets, liabilities, and equity.';

                    }


                    action("Sales Register Summary")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Sales Register Summary';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        //RunObject = Report 50060;//kj
                        ToolTip = 'View your company''s assets, liabilities, and equity.';

                    }

                    action("Sales Credit Register Detailed")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Sales Credit Register Detailed';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50105;
                        ToolTip = 'View your company''s assets, liabilities, and equity.';

                    }

                    action("Sales Credit Register Summary")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Sales Credit Register Summary';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50104;
                        ToolTip = 'View your company''s assets, liabilities, and equity.';

                    }

                    action("GST-Sales Invoice Domestic")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'GST-Sales Invoice Domestic';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50007;
                        ToolTip = 'View your company''s assets, liabilities, and equity.';

                    }

                    action("GST-Sales Invoice Final11")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'GST-Sales Invoice Final';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50009;
                        ToolTip = 'View your company''s assets, liabilities, and equity.';

                    }
                    action("GSTB2BSalesInvoiceFinal11")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'GST B2B Sales Invoice';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50018;
                        ToolTip = 'View your company''s assets, liabilities, and equity.';

                    }

                    action("Daily Cash Flow")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Daily Cash Flow ';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50067; // comented report added to extension id 50067 repo
                        ToolTip = 'View your company''s assets, liabilities, and equity.';
                    }

                    action("Daily Sales Report1 ")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Daily Sales Report1';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        //                        //RunObject = Report 50090; // comented report added to extension id 50067 repo
                        ToolTip = 'View your company''s assets, liabilities, and equity.';
                    }


                }

                group(Purchase_Reports)  //grp4. Purchase_Reports
                {
                    Caption = 'Purchase Reports';
                    Image = ReferenceData;

                    action("Purchase Register Summary")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purchase Register Summary';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50057;
                        ToolTip = 'View your company''s assets, liabilities, and equity.';

                    }
                    //CCIT AN++
                    action("Purch Credit Register Det -GST")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purch Credit Register Det -GST';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50041;
                        ToolTip = 'View your company''s assets, liabilities, and equity.';

                    }//CCIT AN--
                    action("Purch Credit Register Detailed")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purch Credit Register Detailed';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50264;
                        ToolTip = 'View your company''s assets, liabilities, and equity.';

                    }

                    action("Purch Credit Register Summary")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purch Credit Register Summary';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50263;
                        ToolTip = 'View your company''s assets, liabilities, and equity.';

                    }
                    action("Purch Cr Register Summary - GST")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purch Cr Register Summary-GST';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50103;
                        ToolTip = 'View your company''s assets, liabilities, and equity.';

                    }

                    action("Apply Customer Entries")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Apply Customer Entries';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50197;
                        ToolTip = 'View your company''s assets, liabilities, and equity.';

                    }

                    action("Purchase Register")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purchase Register';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50020;
                        ToolTip = 'View your company''s assets, liabilities, and equity.';

                    }

                    action("PO Planning")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'PO Planning';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50023;
                        ToolTip = 'View your company''s assets, liabilities, and equity.';

                    }

                    action("GST-Purchase Order")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'GST-Purchase Order';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50033;
                        ToolTip = 'View your company''s assets, liabilities, and equity.';

                    }

                    action("GST-Debit Note")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'GST-Debit Note';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50035;
                        ToolTip = 'View your company''s assets, liabilities, and equity.';

                    }

                    action("Purchase Register BK 19")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purchase Register BK 19';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50108;
                        ToolTip = 'View your company''s assets, liabilities, and equity.';

                    }

                    action("Purchase Register-GST 1")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purchase Register-GST 1';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50094;
                        ToolTip = 'View your company''s assets, liabilities, and equity.';

                    }
                }
                group(GST_Reports)   //grp5. GST_Reports
                {
                    Caption = 'GST Reports';
                    Image = ReferenceData;

                    action("GPReport-GST_1")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'GPReport-GST';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50160;
                        ToolTip = 'View your company''s assets, liabilities, and equity.';

                    }

                    action("Purchase Register-GST")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purchase Register-GST';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50102;
                        ToolTip = 'View your company''s assets, liabilities, and equity.';

                    }

                    action("Purch Cr Register Summary-GST")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purch Cr Register Summary-GST';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50103;
                        ToolTip = 'View your company''s assets, liabilities, and equity.';

                    }

                    action("Shield Plus-GST")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Shield Plus-GST';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50043;
                        ToolTip = 'View your company''s assets, liabilities, and equity.';

                    }

                    action("Sales Register-GST")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Sales Register-GST';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50100;
                        ToolTip = 'View your company''s assets, liabilities, and equity.';

                    }

                    action("Sales Register-GST 1")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Sales Register-GST 1';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50093;
                        ToolTip = 'View your company''s assets, liabilities, and equity.';

                    }

                    action("Aged Account Rec 180")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Aged Account Rec 180';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50128;
                        ToolTip = 'View your company''s assets, liabilities, and equity.';

                    }



                }
                group(ELEVA_Reports)       //grp6. ELEVA_Reports
                {
                    Caption = 'ELEVA Reports';
                    Image = ReferenceData;
                    action("ELEVA Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'ELEVA Report';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50109;
                        ToolTip = '';

                    }

                    action("Customer Details")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer Details';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50045;
                        ToolTip = '';

                    }
                    action("COGS Iphone")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'COGS Iphone';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report 50107;
                        ToolTip = '';

                    }
                }
            }
        }

    }
}