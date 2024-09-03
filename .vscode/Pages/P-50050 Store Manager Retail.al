page 50050 "Store Manager Retail"
{
    Caption = 'Role Center';
    PageType = RoleCenter;
    ApplicationArea = FixedAsset;

    layout
    {
        area(rolecenter)
        {
            group(Store)
            {
            }
            group(Manager)
            {
                systempart(Mynotes; MyNotes)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Inventory valuation")
            {
                ApplicationArea = All;
            }
            action("Inventory Ageing")
            {
                ApplicationArea = All;
            }
            action("Debtors Outstanding")
            {
                ApplicationArea = All;
            }
            action("Sales Register Detail")
            {
                ApplicationArea = All;
            }
            action("Cash Book")
            {
                ApplicationArea = All;
                //  RunObject = Report 16565;
            }
            action("Daily Cash Flow")
            {
                ApplicationArea = All;
            }
            action("Sales Register Summary")
            {
                ApplicationArea = All;
            }
            action("Purchase register detail")
            {
                ApplicationArea = All;
            }
            action("Purchase register summary")
            {
                ApplicationArea = All;
            }
            action("GP Report")
            {
                ApplicationArea = All;
            }
            action("Purchase Planning Report")
            {
                ApplicationArea = All;
            }
        }
        area(embedding)
        {
            action("Purchase Order List")
            {
                Caption = 'Purchase Orders';
                Image = "Order";
                RunObject = Page 9307;
                ApplicationArea = All;
            }
            action("Sales Invoice")
            {
                Caption = 'Sales Invoice';
                RunObject = Page 9301;
                ApplicationArea = All;
            }
            action(Customers)
            {
                Caption = 'Customers';
                RunObject = Page 22;
                ApplicationArea = All;
            }
            action("Sales Credit Memo")
            {
                Caption = 'Sales Credit Memo';
                RunObject = Page 9302;
                ApplicationArea = All;
            }
            action(Item)
            {
                Caption = 'Item';
                RunObject = Page 31;
                ApplicationArea = All;
            }
            action(Vendor)
            {
                Caption = 'Vendor';
                RunObject = Page 27;
                ApplicationArea = All;
            }
        }
        area(sections)
        {
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;
                action("Posted Sales Shipments")
                {
                    Caption = 'Posted Sales Shipments';
                    Image = PostedShipment;
                    RunObject = Page "Posted Sales Shipments";
                    ApplicationArea = All;
                }
                action("Posted Sales Invoices")
                {
                    Caption = 'Posted Sales Invoices';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Invoices";
                    ApplicationArea = All;
                }
                action("Posted Return Receipts")
                {
                    Caption = 'Posted Return Receipts';
                    Image = PostedReturnReceipt;
                    RunObject = Page 6662;
                    ApplicationArea = All;
                }
                action("Posted Sales Credit Memos")
                {
                    Caption = 'Posted Sales Credit Memos';
                    Image = PostedOrder;
                    RunObject = Page "Posted Return Receipts";
                    ApplicationArea = All;
                }
                action("Posted Purchase Receipts")
                {
                    Caption = 'Posted Purchase Receipts';
                    ApplicationArea = All;
                    // RunObject = Page "Posted Purchase Receipts";
                }
                action("Posted Purchase Invoices")
                {
                    Caption = 'Posted Purchase Invoices';
                    ApplicationArea = All;
                    // RunObject = Page "Posted Purchase Invoices";
                }
                action("Posted Bank Receipt")
                {
                    Caption = 'Posted Bank Receipt';
                    RunObject = Page 116;
                    ApplicationArea = All;
                    //    RunPageView = WHERE ("Source Code"=FILTER(BANKRCPTV));
                }
            }
        }
        area(creation)
        {
            action("Bank Receipt")
            {
                Caption = 'Bank Receipt';
                Image = Quote;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                //   RunObject = Page 16569;
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action("Cash Payment")
            {
                Caption = 'Cash Payment';
                Image = Invoice;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                //  RunObject = Page 16576;
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action("Denomination Entry")
            {
                Caption = 'Denomination Entry';
                Image = Document;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                //  RunObject = Page 50023;
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action("Credit Card Payment Entry")
            {
                Caption = 'Credit Card Payment Entry';
                ApplicationArea = All;
                //  RunObject = Page 50035;
            }
        }
    }
}

