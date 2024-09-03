page 50070 Inventory
{
    UsageCategory = Administration;
    ApplicationArea = all;
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Group)
            {
                part(Name; 9050)
                {
                    ApplicationArea = All;
                }
            }
            group(Group1)
            {
                part(Link; 760)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                part(Repeat; 675)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                part(Lists; 9150)
                {
                    ApplicationArea = All;
                }
                part(BC; 9175)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                systempart(MyNotes; MyNotes)
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
            action("Warehouse &Bin List")
            {
                Caption = 'Warehouse &Bin List';
                Image = "Report";
                RunObject = Report 7319;
                ApplicationArea = All;
            }
            separator(Visual)
            {
            }
            action("Physical &Inventory List")
            {
                Caption = 'Physical &Inventory List';
                Image = "Report";
                ApplicationArea = All;
                //   RunObject = Report 722;
            }
            separator(Studio)
            {
            }
            action("Customer &Labels")
            {
                Caption = 'Customer &Labels';
                Image = "Report";
                RunObject = Report 110;
                ApplicationArea = All;
            }
            action("Captive Consumption")
            {
                Caption = 'Captive Consumption';
                Image = "Report";
                ApplicationArea = All;
                //  RunObject = Report 16588;
            }
            action("Inter Unit Transfer Register")
            {
                Caption = 'Inter Unit Transfer Register';
                Image = "Report";
                ApplicationArea = All;
                //   RunObject = Report 16577;
            }
            separator(Transfer)
            {
            }
            action("Posted Gate Entry")
            {
                Caption = 'Posted Gate Entry';
                Image = "Report";
                ApplicationArea = All;
                //   RunObject = Report 16571;
            }
            action("Gate Entry")
            {
                Caption = 'Gate Entry';
                Image = InwardEntry;
                ApplicationArea = All;
                //  RunObject = Report 16572;
            }
            action("Gate Entry List")
            {
                Caption = 'Gate Entry List';
                Image = "Report";
                ApplicationArea = All;
                //  RunObject = Report 16573;
            }
            action("Posted Gate Entry List")
            {
                Caption = 'Posted Gate Entry List';
                Image = "Report";
                ApplicationArea = All;
                //  RunObject = Report 16574;
            }
            action("Gate Entry-Inward Status")
            {
                Caption = 'Gate Entry-Inward Status';
                Image = "Report";
                ApplicationArea = All;
                //  RunObject = Report 16575;
            }
        }
        area(embedding)
        {
            action("Sales Orders")
            {
                Caption = 'Sales Orders';
                Image = "Order";
                RunObject = Page 9305;
                ApplicationArea = All;
            }
            action(Release)
            {
                Caption = 'Released';
                RunObject = Page 9305;
                RunPageView = WHERE(Status = FILTER(Released));
                ApplicationArea = All;
            }
            action("Partially Shipped")
            {
                Caption = 'Partially Shipped';
                RunObject = Page 9305;
                RunPageView = WHERE(Status = FILTER(Released),
                                    "Completely Shipped" = FILTER(False));
                ApplicationArea = All;
            }
            action("Purchase Return Orders")
            {
                Caption = 'Purchase Return Orders';
                RunObject = Page 9311;
                RunPageView = WHERE("Document Type" = FILTER("Return Order"));
                ApplicationArea = All;
            }
            action("Transfer Orders")
            {
                Caption = 'Transfer Orders';
                Image = Document;
                RunObject = Page 5742;
                ApplicationArea = All;
            }
            action("Released Production Orders")
            {
                Caption = 'Released Production Orders';
                RunObject = Page 9326;
                ApplicationArea = All;
            }
            action("Purchase Orders")
            {
                Caption = 'Purchase Orders';
                RunObject = Page 9307;
                ApplicationArea = All;
            }
            action(Released)
            {
                Caption = 'Released';
                RunObject = Page 9307;
                RunPageView = WHERE(Status = FILTER(Released));
                ApplicationArea = All;
            }
            action("Partially Received")
            {
                Caption = 'Partially Received';
                RunObject = Page 9307;
                RunPageView = WHERE(Status = FILTER(Released),
                                    "Completely Received" = FILTER(False));
                ApplicationArea = All;
            }
            action("Assembly Orders")
            {
                Caption = 'Assembly Orders';
                RunObject = Page 902;
                ApplicationArea = All;
            }
            action("Sales Return Orders")
            {
                Caption = 'Sales Return Orders';
                Image = ReturnOrder;
                RunObject = Page 9304;
                ApplicationArea = All;
            }
            action("Inventory Picks")
            {
                Caption = 'Inventory Picks';
                RunObject = Page 9316;
                ApplicationArea = All;
            }
            action("Inventory Put-aways")
            {
                Caption = 'Inventory Put-aways';
                RunObject = Page 9315;
                ApplicationArea = All;
            }
            action("Inventory Movements")
            {
                Caption = 'Inventory Movements';
                RunObject = Page 9330;
                ApplicationArea = All;
            }
            action("Internal Movements")
            {
                Caption = 'Internal Movements';
                RunObject = Page 7400;
                ApplicationArea = All;
            }
            action("Bin Contents")
            {
                Caption = 'Bin Contents';
                Image = BinContent;
                RunObject = Page 7305;
                ApplicationArea = All;
            }
            action(Items)
            {
                Caption = 'Items';
                Image = Item;
                RunObject = Page 31;
                ApplicationArea = All;
            }
            action(Customers)
            {
                Caption = 'Customers';
                Image = Customer;
                RunObject = Page 22;
                ApplicationArea = All;
            }
            action(Vendors)
            {
                Caption = 'Vendors';
                Image = Vendor;
                RunObject = Page 27;
                ApplicationArea = All;
            }
            action("Shipping Agents")
            {
                Caption = 'Shipping Agents';
                RunObject = Page 428;
                ApplicationArea = All;
            }
            action("Item Reclassification Journals")
            {
                Caption = 'Item Reclassification Journals';
                RunObject = Page 262;
                RunPageView = WHERE("Template Type" = CONST(Transfer),
                                    Recurring = CONST(False));
                ApplicationArea = All;
            }
            action("Phys. Inventory Journals")
            {
                Caption = 'Phys. Inventory Journals';
                RunObject = Page 262;
                RunPageView = WHERE("Template Type" = CONST("Phys. Inventory"),
                                    Recurring = CONST(False));
                ApplicationArea = All;
            }
            action("Gate Entry-Inward")
            {
                Caption = 'Gate Entry-Inward';
                ApplicationArea = All;
                // RunObject = Page 35706;
            }
            action("Gate Entry-Outward")
            {
                Caption = 'Gate Entry-Outward';
                ApplicationArea = All;
                // RunObject = Page 35707;
            }
        }
        area(sections)
        {
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;
                action("Posted Invt. Picks")
                {
                    Caption = 'Posted Invt. Picks';
                    RunObject = Page 7395;
                    ApplicationArea = All;
                }
                action("Posted Sales Shipment")
                {
                    Caption = 'Posted Sales Shipment';
                    RunObject = Page 142;
                    ApplicationArea = All;
                }
                action("Posted Transfer Shipments")
                {
                    Caption = 'Posted Transfer Shipments';
                    RunObject = Page 5752;
                    ApplicationArea = All;
                }
                action("Posted Return Shipments")
                {
                    Caption = 'Posted Return Shipments';
                    RunObject = Page 6652;
                    ApplicationArea = All;
                }
                action("Posted Inward Gate Entry")
                {
                    Caption = 'Posted Inward Gate Entry';
                    ApplicationArea = All;
                    //  RunObject = Page 16479;
                }
                action("Posted Outward Gate Entry")
                {
                    Caption = 'Posted Outward Gate Entry';
                    ApplicationArea = All;
                    //  RunObject = Page 16366;
                }
                action("Posted Invt. Put-aways")
                {
                    Caption = 'Posted Invt. Put-aways';
                    RunObject = Page 7394;
                    ApplicationArea = All;
                }
                action("Registered Invt. Movements")
                {
                    Caption = 'Registered Invt. Movements';
                    RunObject = Page 7386;
                    ApplicationArea = All;
                }
                action("Posted Transfer Receipts")
                {
                    Caption = 'Posted Transfer Receipts';
                    RunObject = Page 5753;
                    ApplicationArea = All;
                }
                action("Posted Purchase Receipts")
                {
                    Caption = 'Posted Purchase Receipts';
                    RunObject = Page "Posted Purchase Receipts";
                    ApplicationArea = All;
                }
                action("Posted Return Receipts")
                {
                    Caption = 'Posted Return Receipts';
                    Image = PostedReturnReceipt;
                    RunObject = Page 6662;
                    ApplicationArea = All;
                }
                action("Posted Assembly Orders")
                {
                    Caption = 'Posted Assembly Orders';
                    RunObject = Page 922;
                    ApplicationArea = All;
                }
            }
        }
        area(creation)
        {
            action("T&ransfer Order")
            {
                Caption = 'T&ransfer Order';
                Image = Document;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 5740;
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action("&Purchase Order")
            {
                Caption = '&Purchase Order';
                Image = Document;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 50;
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action("Captive Consumptions")
            {
                Caption = 'Captive Consumption';
                ApplicationArea = All;
                // RunObject = Page 16465;
            }
            separator(Captive)
            {
            }
            action("Inventory Pi&ck")
            {
                Caption = 'Inventory Pi&ck';
                Image = CreateInventoryPickup;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 7377;
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action("Inventory P&ut-away")
            {
                Caption = 'Inventory P&ut-away';
                Image = CreatePutAway;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 7375;
                RunPageMode = Create;
                ApplicationArea = All;
            }
        }
        area(processing)
        {
            separator(Tasks)
            {
                Caption = 'Tasks';
                IsHeader = true;
            }
            action("Edit Item Reclassification &Journal")
            {
                Caption = 'Edit Item Reclassification &Journal';
                Image = OpenWorksheet;
                ApplicationArea = All;
                //  RunObject = Page 393;
            }
            separator(History)
            {
                Caption = 'History';
                IsHeader = true;
            }
            action("Item &Tracing")
            {
                Caption = 'Item &Tracing';
                Image = ItemTracing;
                ApplicationArea = All;
                //  RunObject = Page 6520;
            }
        }
    }
}

