page 50029 " XMLPORTS RUN"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    //SourceTable = "";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("CRM Integration")
            {
                ApplicationArea = All;
                RunObject = xmlport "CRM Integration";

                trigger OnAction()
                begin

                end;
            }
            action("CRM Integration Purchase")
            {
                ApplicationArea = All;
                RunObject = xmlport "CRM Integration Purchase";

                trigger OnAction()
                begin

                end;
            }
            action("CRM Ingegration Payment")
            {
                ApplicationArea = All;
                RunObject = xmlport "CRM Ingegration Payment";

                trigger OnAction()
                begin

                end;
            }
            action("General Opening Balance Upload")
            {
                ApplicationArea = All;
                RunObject = xmlport "Import Gen. Jnl. Entries";

                trigger OnAction()
                begin

                end;
            }
            action("Item Opening Balance Upload")
            {
                Caption = 'Item Opening Balance Upload';
                ApplicationArea = All;
                RunObject = xmlport ItemOpening;
                // RunObject = xmlport "Import Item Open Bal Serial no";

                trigger OnAction()
                begin

                end;
            }
            action("ITEM LEDGER ENTRY Updated MRP")
            {
                ApplicationArea = All;
                RunObject = xmlport ILEUPDATE;

                // trigger OnAction()
                // begin

                // end;
            }
            action("CLE Duedate Update")
            {
                Caption = 'Cust Ledger Entry Duedate update';
                ApplicationArea = All;
                RunObject = xmlport CLEUPDATE;


            }
            action("VLE Duedate Update")
            {
                Caption = 'Vendor Ledger Entry Duedate update';
                ApplicationArea = All;
                RunObject = xmlport VLEUPDATE;
            }
            action("Sales Line Duedate Update")
            {
                Caption = 'SLUpdate';
                ApplicationArea = All;
                RunObject = xmlport SalesLineUPDATE;


            }
            //CCIT AN ++

            action("Update CLE Entries")
            {
                ApplicationArea = All;
                RunObject = xmlport Update_CLE_Records;
            }
            action("Update VLE Entries")
            {
                ApplicationArea = All;
                RunObject = xmlport Update_VLE_Records;
            }
            action("Update ILE Actual Cost")
            {
                ApplicationArea = All;
                RunObject = xmlport Update_ILE;
            }
            //CCIT AN ++

            // action("Import Cheque Details")
            // {
            //     ApplicationArea = All;
            //     RunObject = xmlport "Import Cheque Details";

            //     trigger OnAction()
            //     begin

            //     end;
            // }
            // action("Import Po Document")
            // {
            //     ApplicationArea = All;
            //     RunObject = xmlport "Import Purchase Document";

            //     trigger OnAction()
            //     begin

            //     end;
            // }
            action("Item Uploaod")
            {
                ApplicationArea = All;
                RunObject = xmlport "Item Import";

                trigger OnAction()
                begin

                end;
            }
            // action("Import transfer Order")
            // {
            //     ApplicationArea = All;
            //     RunObject = xmlport "Transfer Order Upload";

            //     trigger OnAction()
            //     begin

            //     end;
            // }
            // action("Sales Price")
            // {
            //     ApplicationArea = All;
            //     RunObject = xmlport "Sales Price";

            //     trigger OnAction()
            //     begin

            //     end;
            // }
            // action("Sales Line Upload")
            // {
            //     ApplicationArea = All;
            //     RunObject = xmlport "Sales Line Upload";

            //     trigger OnAction()
            //     begin

            //     end;
            // }
            // action("Scan List Upload SO")
            // {
            //     ApplicationArea = All;
            //     RunObject = xmlport "Scan List Upload Sales Order";

            //     trigger OnAction()
            //     begin

            //     end;
            // }
            // action("Scan TO Qty to Ship")
            // {
            //     ApplicationArea = All;
            //     RunObject = xmlport "Scan  Transfer Order Qty To Sh";

            //     trigger OnAction()
            //     begin

            //     end;
            // }
            // action("Scan List Upload PO")
            // {
            //     ApplicationArea = All;
            //     RunObject = xmlport "Scan List Upload Purchas Order";

            //     trigger OnAction()
            //     begin

            //     end;
            // }
            // action("Scan List Upload PO With LOT")
            // {
            //     ApplicationArea = All;
            //     RunObject = xmlport "SLUPO WITH LOTWISE";

            //     trigger OnAction()
            //     begin

            //     end;
            // }
            // action("Scan TO Qty to Receive")
            // {
            //     ApplicationArea = All;
            //     RunObject = xmlport "Scan  Transfer Order Qty To Re";

            //     trigger OnAction()
            //     begin

            //     end;
            // }
            // action("Employee Staff Discunt")
            // {
            //     ApplicationArea = All;
            //     RunObject = xmlport "Employee-Staff Discount";

            //     trigger OnAction()
            //     begin

            //     end;
            // }
            // action("Customer Staff Discoun")
            // {
            //     ApplicationArea = All;
            //     RunObject = xmlport "Customer-Staff Discount";

            //     trigger OnAction()
            //     begin

            //     end;
            // }
            // action("Credit Memo Qty Import")
            // {
            //     ApplicationArea = All;
            //     RunObject = xmlport "Credit Memo Qty import";

            //     trigger OnAction()
            //     begin

            //     end;
            // }
            // action("Sales Line Upload With MRP")
            // {
            //     ApplicationArea = All;
            //     RunObject = xmlport "Sales Line Upload with MRP";

            //     trigger OnAction()
            //     begin

            //     end;
            // }
            // action("ITEM LAST PURCH. DATE UPDATE")
            // {

            //     ApplicationArea = All;
            //     RunObject = xmlport "Item Last Purchase Date Update";

            //     trigger OnAction()
            //     begin

            //     end;
            // }
            // action("Item Jnl Unit Amount")
            // {
            //     ApplicationArea = All;
            //     RunObject = xmlport "Item Jnl Unit Amount";

            //     trigger OnAction()
            //     begin

            //     end;
            // }
            // action("Item Import Modify")
            // {
            //     ApplicationArea = All;
            //     RunObject = xmlport "Item Import Modify";

            //     trigger OnAction()
            //     begin

            //     end;
            // }
            // action("GST Item Master Upload MB")
            // {
            //     ApplicationArea = All;
            //     RunObject = xmlport "GST Item Master Upload MB";

            //     trigger OnAction()
            //     begin

            //     end;
            // }
            // action("GST Location")
            // {
            //     ApplicationArea = All;
            //     RunObject = xmlport "GST location";

            //     trigger OnAction()
            //     begin

            //     end;
            // }
            // action("Item Journal")
            // {
            //     ApplicationArea = All;
            //     RunObject = xmlport "Item journal";

            //     trigger OnAction()
            //     begin

            //     end;
            // }
            // action("Seasone Code Update")
            // {
            //     ApplicationArea = All;
            //     RunObject = xmlport "Seasone Code Update";

            //     trigger OnAction()
            //     begin

            //     end;
            // }
            // action("Purchase Line Upload")
            // {
            //     ApplicationArea = All;
            //     RunObject = xmlport "Import Purchase Line Qty";

            //     trigger OnAction()
            //     begin

            //     end;
            // }
            // action("TEST XML")
            // {
            //     ApplicationArea = All;
            //     RunObject = xmlport "Test Xml";

            //     trigger OnAction()
            //     begin

            //     end;
            // }
            // action("IMP Purchase With Blanket PO")
            // {
            //     ApplicationArea = All;
            //     RunObject = xmlport "Imp.Purch. Line with BlankePO";

            //     trigger OnAction()
            //     begin

            //     end;
            // }
            // action("Item Ecom Update")
            // {
            //     ApplicationArea = All;
            //     RunObject = xmlport "Item Ecom Update";

            //     trigger OnAction()
            //     begin

            //     end;
            // }
            // action("Item Unit Price Order")
            // {
            //     ApplicationArea = All;
            //     RunObject = xmlport "Import UnPric-Order";

            //     trigger OnAction()
            //     begin

            //     end;
            // }


            // action("Trans Header Channel Update")
            // {
            //     ApplicationArea = All;
            //     RunObject = xmlport "Trans Header Channel Update";

            //     trigger OnAction()
            //     begin

            //     end;
            // }
        }
    }

    var
        myInt: Integer;
}