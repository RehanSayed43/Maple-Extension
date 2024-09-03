page 50020 "Sales Order Retail List"
{
    Caption = 'Sales Order Retail List';
    CardPageID = "Sales Order Retail";
    //Editable = false;
    PageType = List;
    Editable = false;
    InsertAllowed = false;
    SourceTable = 36;
    UsageCategory = Lists;
    ApplicationArea = all;
    SourceTableView = WHERE("Document Type" = CONST(Order),
                            "Sales Order Type" = CONST(Retail));

    layout
    {
        area(content)
        {
            repeater(Repeater)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Shield; Rec.Shield)
                {
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part(Part1; 9082)
            {
                SubPageLink = "No." = FIELD("Bill-to Customer No."),
                              "Date Filter" = FIELD("Date Filter");
                Visible = false;
                ApplicationArea = All;
            }
            part(Part2; 9084)
            {
                SubPageLink = "No." = FIELD("Bill-to Customer No."),
                              "Date Filter" = FIELD("Date Filter");
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Links; Links)
            {
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                Visible = true;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("O&rder")
            {
                Caption = 'O&rder';
                Image = "Order";
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                    end;
                }
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.CalcInvDiscForHeader;
                        COMMIT;
                        //PAGE.RUNMODAL(PAGE::"Sales Order Statistics",Rec);//tk
                    end;
                }
                action("A&pprovals")
                {
                    Caption = 'A&pprovals';
                    Image = Approvals;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        // ApprovalEntries.Setfilters(DATABASE::"Sales Header","Document Type","No.");
                        // ApprovalEntries.RUN;//tk
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                 "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                    ApplicationArea = All;
                }
                action("Send A&pproval Request")
                {
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit 439;
                    begin
                        //tk//IF ApprovalMgt.SendSalesApprovalRequest(Rec) THEN;
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                    // ApprovalMgt: Codeunit "439";
                    begin
                        //tk//IF ApprovalMgt.CancelSalesApprovalRequest(Rec,TRUE,TRUE) THEN;
                    end;
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                Image = Documents;
                action("S&hipments")
                {
                    Caption = 'S&hipments';
                    Image = Shipment;
                    RunObject = Page 142;
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                    Visible = false;
                    ApplicationArea = All;
                }
                action(Invoices)
                {
                    Caption = 'Invoices';
                    Image = Invoice;
                    RunObject = Page 143;
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                    Visible = false;
                    ApplicationArea = All;
                }
                action("Prepa&yment Invoices")
                {
                    Caption = 'Prepa&yment Invoices';
                    Image = PrepaymentInvoice;
                    RunObject = Page 143;
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                    Visible = false;
                    ApplicationArea = All;
                }
                action("Prepayment Credi&t Memos")
                {
                    Caption = 'Prepayment Credi&t Memos';
                    Image = PrepaymentCreditMemo;
                    RunObject = Page 144;
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                    Visible = false;
                    ApplicationArea = All;
                }
            }
            group(Warehouse2)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                Visible = false;
                action("Whse. Shipment Lines")
                {
                    Caption = 'Whse. Shipment Lines';
                    Image = ShipmentLines;
                    RunObject = Page 7341;
                    RunPageLink = "Source Type" = CONST(37),
                                  "Source Subtype" = FIELD("Document Type"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                    ApplicationArea = All;
                }
                action("In&vt. Put-away/Pick Lines")
                {
                    Caption = 'In&vt. Put-away/Pick Lines';
                    Image = PickLines;
                    RunObject = Page 5774;
                    RunPageLink = "Source Document" = CONST("Sales Order"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Document", "Source No.", "Location Code");
                    ApplicationArea = All;
                }
            }
        }
        area(processing)
        {
            group(Release)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                Visible = false;
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit 414;
                    begin
                        ReleaseSalesDoc.PerformManualRelease(Rec);
                    end;
                }
                action("Re&open")
                {
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit 414;
                    begin
                        ReleaseSalesDoc.PerformManualReopen(Rec);
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Pla&nning")
                {
                    Caption = 'Pla&nning';
                    Image = Planning;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        SalesOrderPlanningForm: Page 99000883;
                    begin
                        SalesOrderPlanningForm.SetSalesOrder(Rec."No.");
                        SalesOrderPlanningForm.RUNMODAL;
                    end;
                }
                action("Order &Promising")
                {
                    Caption = 'Order &Promising';
                    Image = OrderPromising;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        OrderPromisingLine: Record 99000880 temporary;
                    begin
                        OrderPromisingLine.SETRANGE("Source Type", Rec."Document Type");
                        OrderPromisingLine.SETRANGE("Source ID", Rec."No.");
                        PAGE.RUNMODAL(PAGE::"Order Promising Lines", OrderPromisingLine);
                    end;
                }
                action("Send IC Sales Order Cnfmn.")
                {
                    Caption = 'Send IC Sales Order Cnfmn.';
                    Image = IntercompanyOrder;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ICInOutboxMgt: Codeunit 427;
                        ApprovalMgt: Codeunit 439;
                        PurchaseHeader: Record 38;
                    begin
                        // IF ApprovalMgt.PrePostApprovalCheck(Rec,PurchaseHeader) THEN
                        //   ICInOutboxMgt.SendSalesDoc(Rec,FALSE);
                    end;
                }
            }
            group(Warehouse)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                Visible = false;
                action("Create Inventor&y Put-away/Pick")
                {
                    Caption = 'Create Inventor&y Put-away/Pick';
                    Ellipsis = true;
                    Image = CreatePutawayPick;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.CreateInvtPutAwayPick;

                        IF NOT Rec.FIND('=><') THEN
                            Rec.INIT;
                    end;
                }
                action("Create &Whse. Shipment")
                {
                    Caption = 'Create &Whse. Shipment';
                    Image = NewShipment;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        GetSourceDocOutbound: Codeunit 5752;
                    begin
                        GetSourceDocOutbound.CreateFromSalesOrder(Rec);

                        IF NOT Rec.FIND('=><') THEN
                            Rec.INIT;
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                Visible = false;
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //tk//SendToPosting(CODEUNIT::"Sales-Post (Yes/No)");
                    end;
                }
                action("Post and &Print")
                {
                    Caption = 'Post and &Print';
                    Ellipsis = true;
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //tk//SendToPosting(CODEUNIT::"Sales-Post + Print");
                    end;
                }
                action("Test Report")
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        // ReportPrint.PrintSalesHeader(Rec);//tk
                    end;
                }
                action("Post &Batch")
                {
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //tk //REPORT.RUNMODAL(REPORT::"Batch Post Sales Orders",TRUE,TRUE,Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Remove From Job Queue")
                {
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.CancelBackgroundPosting;
                    end;
                }
            }
            group("&Print")
            {
                Caption = '&Print';
                Image = Print;
                Visible = false;
                action("Order Confirmation")
                {
                    Caption = 'Order Confirmation';
                    Ellipsis = true;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        // DocPrint.PrintSalesOrder(Rec,Usage::"Order Confirmation");
                    end;
                }
                action("Work Order")
                {
                    Caption = 'Work Order';
                    Ellipsis = true;
                    Image = Print;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        // DocPrint.PrintSalesOrder(Rec,Usage::"Work Order");
                    end;
                }
                action("Pick Instruction")
                {
                    Caption = 'Pick Instruction';
                    Image = Print;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        // DocPrint.PrintSalesOrder(Rec,Usage::"Pick Instruction");
                    end;
                }
            }
        }
        area(reporting)
        {
            action("Sales Reservation Avail.")
            {
                Caption = 'Sales Reservation Avail.';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                ApplicationArea = All;
                // RunObject = Report 209;
                //                 Visible = false;//tk
            }
        }
    }

    trigger OnOpenPage()
    var
        SalesSetup: Record 311;
        UserSetup: Record "User Setup";

    begin
        //TK
        UserSetup.GET(USERID);
        IF UserSetup."Location Code" <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Location Code", UserSetup."Location Code");
            //SETRANGE("Responsibility Center", UserSetup."Sales Resp. Ctr. Filter");
            Rec.FILTERGROUP(0);
        END;

        // SETRANGE("Date Filter", 0D, WORKDATE - 1);// KPPL//tk

        // //TK
        // IF UserMgt.GetSalesFilter <> '' THEN BEGIN
        //     FILTERGROUP(1);
        //     SETRANGE("Responsibility Center", UserMgt.GetSalesFilter);
        //     FILTERGROUP(0);
        // END;

        Rec.SETRANGE("Date Filter", 0D, WORKDATE - 1);

        JobQueueActive := SalesSetup.JobQueueActive;
    end;

    var
        // DocPrint: Codeunit 229;
        // ReportPrint: Codeunit 228;//tk
        UserMgt: Codeunit 5700;
        Usage: Option "Order Confirmation","Work Order","Pick Instruction";

        JobQueueActive: Boolean;
}

