page 50038 "Cashier Retail"
{
    Caption = 'Role Center';
    PageType = RoleCenter;
    ApplicationArea = FixedAsset;

    layout
    {
        area(rolecenter)
        {
            group(Group)
            {
            }
            group(Group1)
            {
                systempart(part; MyNotes)
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
            action("Sales Register Detail")
            {
                ApplicationArea = All;
            }
            action("Sales Register Summary")
            {
                ApplicationArea = All;
            }
            action("Purchase Register Detail")
            {
                ApplicationArea = All;
            }
            action("Purchase Register Summary")
            {
                ApplicationArea = All;
            }
            action("Daily Cash Flow")
            {
                Image = "report";
                ApplicationArea = All;
                //RunObject = Report 50067;
            }
        }
        area(embedding)
        {
            action("Sales Order Retail")
            {
                Caption = 'Sales Order Retail';
                ApplicationArea = All;
                //RunObject = Page 50020;//tk
            }
            action("Purchase Orders Retail")
            {
                Caption = 'Purchase Orders Retail';
                Image = "Order";
                ApplicationArea = All;
                // RunObject = Page 50077;//tk
            }
            action("Sales Credit Memo")
            {
                Caption = 'Sales Credit Memo';
                RunObject = Page 9302;
                ApplicationArea = All;
            }
            action("Transfer Orders")
            {
                Caption = 'Transfer Orders';
                RunObject = Page 5742;
                ApplicationArea = All;
            }
            action(Customers)
            {
                Caption = 'Customers';
                RunObject = Page 22;
                ApplicationArea = All;
            }
            action("Customers Retail")
            {
                Caption = 'Customers Retail';
                RunObject = Page 50037;
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
            action("Sales Order Items")
            {
                Caption = 'Sales Order Items';
                RunObject = Page 50058;
                ApplicationArea = All;
            }
            action("Purchase Order Items")
            {
                Caption = 'Purchase Order Items';
                ApplicationArea = All;
                //RunObject = Page 50059;//tk
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
                    RunObject = Page 142;
                    ApplicationArea = All;
                }
                action("Posted Sales Invoices")
                {
                    Caption = 'Posted Sales Invoices';
                    Image = PostedOrder;
                    RunObject = Page 143;
                    ApplicationArea = All;
                }
                action("Posted Sales Shield Invoices")
                {
                    Caption = 'Posted Sales Shield Invoices';
                    Image = PostedOrder;
                    ApplicationArea = All;
                    //RunObject = Page 50027;//tk
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
                    RunObject = Page 144;
                    ApplicationArea = All;
                }
                action("Posted Purchase Receipts")
                {
                    Caption = 'Posted Purchase Receipts';
                    ApplicationArea = All;
                    //RunObject = Page 145;//tk
                }
                action("Posted Purchase Invoices")
                {
                    Caption = 'Posted Purchase Invoices';
                    ApplicationArea = All;
                    // RunObject = Page 146;//tk
                }
                action("Posted Sales Invoices Items")
                {
                    Caption = 'Posted Sales Invoices Items';
                    Image = PostedOrder;
                    RunObject = Page 50057;
                    ApplicationArea = All;
                }
                action("Posted Sales Credit Memo Items")
                {
                    Caption = 'Posted Sales Credit Memo Items';
                    Image = PostedOrder;
                    RunObject = Page 50063;
                    ApplicationArea = All;
                }
                action("Purchase Invoice Items")
                {
                    Caption = 'Purchase Invoice Items';
                    RunObject = Page 50060;
                    ApplicationArea = All;
                }
                action("Transfer Receipt Lines")
                {
                    Caption = 'Transfer Receipt Lines';
                    RunObject = Page 50061;
                    ApplicationArea = All;
                }
                action("Items Recd. Not Invoiced List")
                {
                    Caption = 'Items Recd. Not Invoiced List';
                    ApplicationArea = All;
                    // RunObject = Page 50062;//tk
                }
                action("Denomination Entry List")
                {
                    Caption = 'Denomination Entry List';
                    RunObject = Page 50043;
                    ApplicationArea = All;
                }
                action("Credit Card Payment List")
                {
                    Caption = 'Credit Card Payment List';
                    RunObject = Page 50044;
                    ApplicationArea = All;
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
                // RunObject = Page 16569;
                RunPageMode = Edit;
                ApplicationArea = All;
            }
            action("Bank Payment")
            {
                Caption = 'Bank Payment';
                Image = Invoice;
                ApplicationArea = All;
                //RunObject = Page 16577;
            }
            action("Cash Payment")
            {
                Caption = 'Cash Payment';
                Image = Invoice;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                //  RunObject = Page 16576;
                RunPageMode = Edit;
                ApplicationArea = All;
            }
            action("Cash Receipt")
            {
                Caption = 'Cash Receipt';
                Image = Quote;
                ApplicationArea = All;
                //RunObject = Page 16579;
            }
            action("Denomination Entry")
            {
                Caption = 'Denomination Entry';
                Image = Document;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 50023;
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action("Credit Card Payment Entry")
            {
                Caption = 'Credit Card Payment Entry';
                Image = Document;
                RunObject = Page 50035;
                ApplicationArea = All;
            }
        }
    }
}

