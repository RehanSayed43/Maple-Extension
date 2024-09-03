page 50024 "Purchase Order Branch"
{
    Caption = 'Purchase Order Branch';
    DeleteAllowed = false;

    UsageCategory = Lists;
    ApplicationArea = all;

    InsertAllowed = true;//tk
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = 38;
    SourceTableView = WHERE("Document Type" = FILTER(Order),
                            Subcontracting = FILTER(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = false;
                field("No."; Rec."No.")
                {
                    Importance = Promoted;
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    Importance = Promoted;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        // BuyfromVendorNoOnAfterValidate;//tk1
                    end;
                }
                field("Buy-from Contact No."; Rec."Buy-from Contact No.")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Buy-from Address"; Rec."Buy-from Address")
                {
                    Editable = false;
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Buy-from Address 2"; Rec."Buy-from Address 2")
                {
                    Editable = false;
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Buy-from Post Code"; Rec."Buy-from Post Code")
                {
                    Editable = false;
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Buy-from City"; Rec."Buy-from City")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Buy-from Contact"; Rec."Buy-from Contact")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("No. of Archived Versions"; Rec."No. of Archived Versions")
                {
                    Importance = Additional;
                    Visible = false;
                    ApplicationArea = All;
                }
                // field(Structure;Structure)
                // {
                //     Importance = Promoted;
                // }//tk
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Quote No."; Rec."Quote No.")
                {
                    Importance = Additional;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Vendor Order No."; Rec."Vendor Order No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Vendor Shipment No."; Rec."Vendor Shipment No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                    ApplicationArea = All;
                }
                field("Order Address Code"; Rec."Order Address Code")
                {
                    Importance = Additional;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    Importance = Additional;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        // PurchaserCodeOnAfterValidate;//tk1
                    end;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    Importance = Additional;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job Queue Status"; Rec."Job Queue Status")
                {
                    Importance = Additional;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Vendor Invoice Value"; Rec."Vendor Invoice Value")
                {
                    ApplicationArea = All;
                }
                field("PO Validity Date"; Rec."PO Validity Date")
                {
                    ApplicationArea = All;
                }
                field("Closing Remark"; Rec."Closing Remark")
                {
                    ApplicationArea = All;
                }
                field(Closed; Rec.Closed)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            part(PurchLines; 50025)
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                Visible = false;
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    Importance = Promoted;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        // PaytoVendorNoOnAfterValidate;//tk1
                    end;
                }
                field("Pay-to Contact No."; Rec."Pay-to Contact No.")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                    ApplicationArea = All;
                }
                field("Pay-to Address"; Rec."Pay-to Address")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Pay-to Address 2"; Rec."Pay-to Address 2")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Pay-to Post Code"; Rec."Pay-to Post Code")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Pay-to City"; Rec."Pay-to City")
                {
                    ApplicationArea = All;
                }
                field("Pay-to Contact"; Rec."Pay-to Contact")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        // ShortcutDimension1CodeOnAfterV;/tk1
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        // ShortcutDimension2CodeOnAfterV;//tk1
                    end;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ApplicationArea = All;
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Payment Reference"; Rec."Payment Reference")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Creditor No."; Rec."Creditor No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("On Hold"; Rec."On Hold")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Prices Including VAT"; Rec."Prices Including VAT")
                {
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        // PricesIncludingVATOnAfterValid;//tk
                    end;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                Visible = false;
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ApplicationArea = All;
                }
                field("Inbound Whse. Handling Time"; Rec."Inbound Whse. Handling Time")
                {
                    Importance = Additional;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Promised Receipt Date"; Rec."Promised Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                Visible = false;
                field("Currency Code"; Rec."Currency Code")
                {
                    Importance = Promoted;
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        //tk
                        // CLEAR(ChangeExchangeRate);
                        // IF "Posting Date" <> 0D THEN
                        //     ChangeExchangeRate.SetParameter("Currency Code", "Currency Factor", "Posting Date")
                        // ELSE
                        //     ChangeExchangeRate.SetParameter("Currency Code", "Currency Factor", WORKDATE);
                        // IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
                        //     VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
                        //     CurrPage.UPDATE;
                        // END;
                        // CLEAR(ChangeExchangeRate);
                    end;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ApplicationArea = All;
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ApplicationArea = All;
                }
                field("Entry Point"; Rec."Entry Point")
                {
                    ApplicationArea = All;
                }
                // field(Area;Area)
                // {
                // }
            }
            group(Prepayment)
            {
                Caption = 'Prepayment';
                Visible = false;
                field("Prepayment %"; Rec."Prepayment %")
                {
                    Importance = Promoted;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        // Prepayment37OnAfterValidate;//tk
                    end;
                }
                field("Compress Prepayment"; Rec."Compress Prepayment")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Payment Terms Code"; Rec."Prepmt. Payment Terms Code")
                {
                    ApplicationArea = All;
                }
                field("Prepayment Due Date"; Rec."Prepayment Due Date")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Prepmt. Payment Discount %"; Rec."Prepmt. Payment Discount %")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Pmt. Discount Date"; Rec."Prepmt. Pmt. Discount Date")
                {
                    ApplicationArea = All;
                }
                field("Vendor Cr. Memo No."; Rec."Vendor Cr. Memo No.")
                {
                    ApplicationArea = All;
                }
            }
            group(Application)
            {
                Caption = 'Application';
                Visible = false;
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    ApplicationArea = All;
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                    ApplicationArea = All;
                }
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                    ApplicationArea = All;
                }
            }
            group("Tax Information")
            {
                Caption = 'Tax Information';
                Visible = false;
                // field("Service Type (Rev. Chrg.)";"Service Type (Rev. Chrg.)")
                // {
                //     Visible = false;
                // }
                // field("Consignment Note No.";"Consignment Note No.")
                // {
                //     Visible = false;
                // }
                // field("Declaration Form (GTA)";"Declaration Form (GTA)")
                // {
                //     Visible = false;
                // }
                // field("Input Service Distribution";"Input Service Distribution")
                // {
                //     Visible = false;
                // }
                // field("Transit Document";"Transit Document")
                // {
                //     Visible = false;
                // }//tk
                field(Trading; Rec.Trading)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                // field("C Form";"C Form")
                // {
                // }
                // field("Form Code";"Form Code")
                // {
                //     Importance = Promoted;
                // }
                // field("Form No.";"Form No.")
                // {
                // }
                // field("LC No.";"LC No.")
                // {
                //     Visible = false;
                // }
                // field("Service Tax Rounding Precision";"Service Tax Rounding Precision")
                // {
                //     Visible = false;
                // }
                // field("Service Tax Rounding Type";"Service Tax Rounding Type")
                // {
                //     Visible = false;
                // }
                // field(PoT;PoT)
                // {
                // }//tk
                group("Manufacturer Detail")
                {
                    Caption = 'Manufacturer Detail';
                    Visible = false;
                    // field("Manufacturer E.C.C. No.";"Manufacturer E.C.C. No.")
                    // {
                    // }
                    // field("Manufacturer Name";"Manufacturer Name")
                    // {
                    // }
                    // field("Manufacturer Address";"Manufacturer Address")
                    // {
                    // }//tk
                }
            }
        }
        area(factboxes)
        {
            part(PL; 9090)
            {
                Provider = PurchLines;
                SubPageLink = "No." = FIELD("No.");
                ApplicationArea = All;
                // Visible = false;
            }
            part(PH; 9092)
            {
                SubPageLink = "Table ID" = CONST(38),
                              "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
                ApplicationArea = All;

            }
            part(Ven; 9093)
            {
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
                Visible = false;
                ApplicationArea = All;
            }
            part(Vend; 9094)
            {
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
                Visible = true;
                ApplicationArea = All;
            }
            part(Vendor; 9095)
            {
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
                Visible = true;
                ApplicationArea = All;
            }
            part(Vend1; 9096)
            {
                SubPageLink = "No." = FIELD("Pay-to Vendor No.");
                Visible = false;
                ApplicationArea = All;
            }
            part(PurchaseLine; 9100)
            {
                Provider = PurchLines;
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("Document No."),
                              "Line No." = FIELD("Line No.");
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
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                        CurrPage.SAVERECORD;
                    end;
                }
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F7';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        // PurchSetup.GET;
                        // IF PurchSetup."Calc. Inv. Discount" THEN BEGIN
                        //     CalcInvDiscForHeader;
                        //     COMMIT;
                        // END;
                        // IF Structure <> '' THEN BEGIN
                        //     PurchLine.CalculateStructures(Rec);
                        //     PurchLine.AdjustStructureAmounts(Rec);
                        //     PurchLine.UpdatePurchLines(Rec);
                        //     PurchLine.CalculateTDS(Rec);
                        // END ELSE
                        //     PurchLine.CalculateTDS(Rec);

                        COMMIT;
                        PAGE.RUNMODAL(PAGE::"Purchase Order Statistics", Rec);
                    end;
                }
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Page 26;
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F7';
                    ApplicationArea = All;
                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = false;
                    ApplicationArea = All;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        //tk//ApprovalEntries.Setfilters(DATABASE::"Purchase Header", "Document Type", "No.");
                        ApprovalEntries.RUN;
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                    ApplicationArea = All;
                }
                action("Send mail to Vendor")
                {
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF (Rec.Status <> Rec.Status::Released) THEN
                            ERROR('Purchase order is not Approved');
                        WBU.SendMailtoVendorwithAttachment(Rec);
                    end;
                }
            }
            group(Closing)
            {
                action("Close Purchase Order")
                {
                    Ellipsis = true;
                    Image = Close;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        PurchLine: Record 39;
                    begin
                        //Win 127 Closing Order 10.07.14
                        PurchLine.RESET;
                        PurchLine.SETRANGE("Document Type", Rec."Document Type");
                        PurchLine.SETRANGE("Document No.", Rec."No.");
                        IF PurchLine.FINDFIRST THEN BEGIN
                            REPEAT
                                IF PurchLine."Qty. Rcd. Not Invoiced" <> 0 THEN
                                    ERROR('You can not close the Purchase Order, Received Quantity & Invoiced Quantity are not matching for Item %1', PurchLine."No.");
                            UNTIL PurchLine.NEXT = 0;
                        END;
                        IF Rec."Closing Remark" = '' THEN
                            ERROR('Closing Remark should not be blank')
                        ELSE BEGIN
                            Rec.Closed := TRUE;
                            Rec."Closed By" := USERID;
                            Rec."Closed Date & Time" := CURRENTDATETIME;
                        END;
                        //Win 127
                        CurrPage.CLOSE;
                    end;
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                Image = Documents;
                action(Receipts)
                {
                    Caption = 'Receipts';
                    Image = PostedReceipts;
                    RunObject = Page "Posted Purchase Receipts";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                    ApplicationArea = All;
                }
                action(Invoices)
                {
                    Caption = 'Invoices';
                    Image = Invoice;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Page "Posted Purchase Invoices";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                    ApplicationArea = All;
                }
                action("Prepa&yment Invoices")
                {
                    Caption = 'Prepa&yment Invoices';
                    Image = PrepaymentInvoice;
                    RunObject = Page "Posted Purchase Invoices";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                    Visible = false;
                    ApplicationArea = All;
                }
                action("Prepayment Credi&t Memos")
                {
                    Caption = 'Prepayment Credi&t Memos';
                    Image = PrepaymentCreditMemo;
                    RunObject = Page "Posted Purchase Credit Memos";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                    Visible = false;
                    ApplicationArea = All;
                }
            }
            group(Warehouse)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                Visible = false;
                separator(Sep4)
                {
                }
                action("In&vt. Put-away/Pick Lines")
                {
                    Caption = 'In&vt. Put-away/Pick Lines';
                    Image = PickLines;
                    RunObject = Page "Warehouse Activity List";
                    RunPageLink = "Source Document" = CONST("Purchase Order"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Document", "Source No.", "Location Code");
                    Visible = false;
                    ApplicationArea = All;
                }
                action("Whse. Receipt Lines")
                {
                    Caption = 'Whse. Receipt Lines';
                    Image = ReceiptLines;
                    RunObject = Page "Whse. Receipt Lines";
                    RunPageLink = "Source Type" = CONST(39),
                                  "Source Subtype" = FIELD("Document Type"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                    ApplicationArea = All;
                }
                separator(Seperate)
                {
                }
                group("Dr&opShipment")
                {
                    Caption = 'Dr&op Shipment';
                    Image = Delivery;
                    Visible = false;
                    action("Get&Sales Order")
                    {
                        Caption = 'Get &Sales Order';
                        Image = "Order";
                        ApplicationArea = All;
                        // RunObject = Codeunit 76;//tk
                    }
                }
                group("Speci&alOrder")
                {
                    Caption = 'Speci&al Order';
                    Image = SpecialOrder;
                    Visible = false;
                    action("Get&Sales Order1")
                    {
                        Caption = 'Get &Sales Order';
                        Image = "Order";
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            PurchHeader: Record 38;
                            DistIntegration: Codeunit 5702;
                        begin
                            PurchHeader.COPY(Rec);
                            DistIntegration.GetSpecialOrders(PurchHeader);
                            Rec := PurchHeader;
                        end;
                    }
                }
            }
        }
        area(processing)
        {
            group(Released)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                separator(Sep1)
                {
                }
                action(Release)
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualRelease(Rec);
                    end;
                }
                action("Re&open")
                {
                    Caption = 'Re&open';
                    Image = ReOpen;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualReopen(Rec);
                    end;
                }
                separator(Sep2)
                {
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Calculate &Invoice Discount")
                {
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        // ApproveCalcInvDisc;
                    end;
                }
                separator(Sep5)
                {
                }
                action("Get St&d. Vend. Purchase Codes")
                {
                    Caption = 'Get St&d. Vend. Purchase Codes';
                    Ellipsis = true;
                    Image = VendorCode;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        StdVendPurchCode: Record 175;
                    begin
                        StdVendPurchCode.InsertPurchLines(Rec);
                    end;
                }
                separator(Sep8)
                {
                }
                action(CopyDocument)
                {
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        // CopyPurchDoc.SetPurchHeader(Rec);
                        // CopyPurchDoc.RUNMODAL;
                        // CLEAR(CopyPurchDoc);//tk
                    end;
                }
                action("Move Negative Lines")
                {
                    Caption = 'Move Negative Lines';
                    Ellipsis = true;
                    Image = MoveNegativeLines;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        // CLEAR(MoveNegPurchLines);
                        // MoveNegPurchLines.SetPurchHeader(Rec);
                        // MoveNegPurchLines.RUNMODAL;
                        // MoveNegPurchLines.ShowDocument;//tk
                    end;
                }
                group("Dr&op Shipment")
                {
                    Caption = 'Dr&op Shipment';
                    Image = Delivery;
                    Visible = false;
                    action("Get &Sales Order")
                    {
                        Caption = 'Get &Sales Order';
                        Image = "Order";
                        ApplicationArea = All;
                        // RunObject = Codeunit 76;//tk
                    }
                }
                group("Speci&al Order")
                {
                    Caption = 'Speci&al Order';
                    Image = SpecialOrder;
                    action("Get&Sales Order.")
                    {
                        Caption = 'Get &Sales Order';
                        Image = "Order";
                        Visible = false;
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            DistIntegration: Codeunit 5702;
                            PurchHeader: Record 38;
                        begin
                            PurchHeader.COPY(Rec);
                            DistIntegration.GetSpecialOrders(PurchHeader);
                            Rec := PurchHeader;
                        end;
                    }
                }
                separator(Separator8)
                {
                }
                // action("St&ructure")
                // {
                //     Caption = 'St&ructure';
                //     Image = Hierarchy;
                //     RunObject = Page 16305;
                //                     RunPageLink = Type=CONST(Purchase),
                //                   Document Type=FIELD(Document Type),
                //                   Document No.=FIELD(No.);
                // }//tk
                action("Transit Documents")
                {
                    ApplicationArea = All;
                    // Caption = 'Transit Documents';
                    // Image = TransferOrder;
                    // RunObject = Page 13705;
                    // RunPageLink = Type = CONST(Purchase),
                    //               PO / SO No.=FIELD(No.),
                    //               Vendor / Customer Ref.=FIELD(Buy-from Vendor No.),
                    //               State=FIELD(State);
                    // Visible = false;
                }
                action("Deferment Schedule")
                {
                    ApplicationArea = All;
                    // Caption = 'Deferment Schedule';
                    // Image = Installments;
                    // RunObject = Page "Deferment Schedule";
                    //                 RunPageLink = "Document No."=FIELD("No.");
                    // Visible = false;//tk
                }
                action("Attached Gate Entry")
                {
                    ApplicationArea = All;
                    // Caption = 'Attached Gate Entry';
                    // Image = InwardEntry;
                    // RunObject = Page "Gate Entry Attachment List";
                    //                 RunPageLink = Source No.=FIELD(No.),
                    //               Source Type=CONST(Purchase Order),
                    //               Entry Type=CONST(Inward);
                    // Visible = false;//tk
                }
                // action("Detailed &Tax")
                // {
                //     Caption = 'Detailed &Tax';
                //     Image = TaxDetail;
                //     RunObject = Page 16341;
                //                     RunPageLink = Document Type=FIELD(Document Type),
                //                   Document No.=FIELD(No.),
                //                   Transaction Type=CONST(Purchase);
                //     Visible = false;
                // }//tk
                action("Archive Document")
                {
                    Caption = 'Archi&ve Document';
                    Image = Archive;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ArchiveManagement.ArchivePurchDocument(Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("SendIC Purchase Order")
                {
                    Caption = 'Send IC Purchase Order';
                    Image = IntercompanyOrder;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ICInOutboxMgt: Codeunit 427;
                        SalesHeader: Record 36;
                    //ApprovalMgt: Codeunit 439;
                    begin
                        //tk//IF ApprovalMgt.PrePostApprovalCheck(SalesHeader,Rec) THEN
                        ICInOutboxMgt.SendPurchDoc(Rec, FALSE);
                    end;
                }
                separator(Separator9)
                {
                }
                action("Calc&ulate Structure Values")
                {
                    Caption = 'Calc&ulate Structure Values';
                    Image = CalculateHierarchy;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        // PurchLine.CalculateStructures(Rec);
                        // PurchLine.AdjustStructureAmounts(Rec);
                        // PurchLine.UpdatePurchLines(Rec);
                    end;
                }
                action("Calculate TDS")
                {
                    Caption = 'Calculate TDS';
                    Image = CalculateVATExemption;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        // PurchLine.CalculateTDS(Rec);
                    end;
                }
                separator(Separator10)
                {
                }
            }
            group(Approval1)
            {
                Caption = 'Approval';
                Image = Approval;
                group(Approval)
                {
                    Caption = 'Approval';
                    Image = Approval;
                    action("Send A&pproval Request")
                    {
                        Caption = 'Send A&pproval Request';
                        Image = SendApprovalRequest;
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            ApprovalMgt: Codeunit "Approvals Mgmt.";
                        begin
                            //tk//IF ApprovalMgt.SendPurchaseApprovalRequest(Rec) THEN;
                        end;
                    }
                    action("Cancel Approval Re&quest")
                    {
                        Caption = 'Cancel Approval Re&quest';
                        Image = Cancel;
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            ApprovalMgt: Codeunit "Approval Workflow Setup Mgt.";
                        begin
                            //IF ApprovalMgt.CancelPurchaseApprovalRequest(Rec,TRUE,TRUE) THEN;
                        end;
                    }
                }
            }
            group(Warehouse6)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                Visible = false;
                action("Create &Whse. Receipt")
                {
                    Caption = 'Create &Whse. Receipt';
                    Image = NewReceipt;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        GetSourceDocInbound: Codeunit 5751;
                    begin
                        GetSourceDocInbound.CreateFromPurchOrder(Rec);

                        IF NOT Rec.FIND('=><') THEN
                            Rec.INIT;
                    end;
                }
                action("Create Inventor&y Put-away / Pick")
                {
                    Caption = 'Create Inventor&y Put-away / Pick';
                    Ellipsis = true;
                    Image = CreateInventoryPickup;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.CreateInvtPutAwayPick;

                        IF NOT Rec.FIND('=><') THEN
                            Rec.INIT;
                    end;
                }
                action("Get Gate Entry Lines")
                {
                    Caption = 'Get Gate Entry Lines';
                    Image = GetLines;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //GetGateEntryLines;//tk
                    end;
                }
                separator(Separator)
                {
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(TestSerialNo)
                {
                    Promoted = true;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        DeletePurchSpecification(Rec);
                        PurchLine.RESET;
                        PurchLine.SETRANGE("Document Type", Rec."Document Type"::Order);
                        PurchLine.SETFILTER("Document No.", Rec."No.");
                        PurchLine.SETFILTER(PurchLine."Item Serial No", '<>%1', '');
                        IF PurchLine.FINDFIRST THEN BEGIN
                            REPEAT
                                UpdateSerialNo(PurchLine);
                            UNTIL PurchLine.NEXT = 0;
                        END;
                    end;
                }
                action(Post1)
                {
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        PurchasePostViaJobQueue: Codeunit 98;
                        PurchLine: Record 39;
                    begin
                        // Code Shifted on Purchase Line Item Serial No. Validation.
                        /*
                        DeletePurchSpecification(Rec);
                        PurchLine.RESET;
                        PurchLine.SETRANGE("Document Type","Document Type"::Order);
                        PurchLine.SETFILTER("Document No.","No.");
                        PurchLine.SETFILTER(PurchLine."Item Serial No",'<>%1','');
                        IF PurchLine.FINDFIRST THEN BEGIN
                        REPEAT
                            UpdateSerialNo(PurchLine);
                        UNTIL PurchLine.NEXT = 0;
                        END;
                        */
                        WBU.RefreshStatistics();
                        Post(CODEUNIT::"Purch.-Post (Yes/No)");

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
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        WBU.RefreshStatistics();
                        Post(CODEUNIT::"Purch.-Post + Print");
                    end;
                }
                action("Test Report")
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintPurchHeader(Rec);
                    end;
                }
                action("Post &Batch")
                {
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Purchase Orders", TRUE, TRUE, Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Print Deferment Schedule")
                {
                    Caption = 'Print Deferment Schedule';
                    Image = PrintInstallments;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        // DefermentBuffer.RESET;
                        // DefermentBuffer.SETRANGE("No.","No.");
                        // REPORT.RUNMODAL(16543,TRUE,TRUE,DefermentBuffer);
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
                separator(Separator11)
                {
                }
                group("Prepa&yment")
                {
                    Caption = 'Prepa&yment';
                    Image = Prepayment;
                    Visible = false;
                    action("Prepayment Test &Report")
                    {
                        Caption = 'Prepayment Test &Report';
                        Ellipsis = true;
                        Image = PrepaymentSimulation;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            ReportPrint.PrintPurchHeaderPrepmt(Rec);
                        end;
                    }
                    action(PostPrepaymentInvoice)
                    {
                        Caption = 'Post Prepayment &Invoice';
                        Ellipsis = true;
                        Image = PrepaymentPost;
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            SalesHeader: Record 36;
                            // ApprovalMgt: Codeunit "439";
                            PurchPostYNPrepmt: Codeunit 445;
                        begin
                            // IF ApprovalMgt.PrePostApprovalCheck(SalesHeader,Rec) THEN
                            //   PurchPostYNPrepmt.PostPrepmtInvoiceYN(Rec,FALSE);
                        end;
                    }
                    action("Post and Print Prepmt. Invoic&e")
                    {
                        Caption = 'Post and Print Prepmt. Invoic&e';
                        Ellipsis = true;
                        Image = PrepaymentPostPrint;
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            SalesHeader: Record 36;
                            ApprovalMgt: Codeunit 439;
                            PurchPostYNPrepmt: Codeunit 445;
                        begin
                            // IF ApprovalMgt.PrePostApprovalCheck(SalesHeader,Rec) THEN
                            //   PurchPostYNPrepmt.PostPrepmtInvoiceYN(Rec,TRUE);
                        end;
                    }
                    action(PostPrepaymentCreditMemo)
                    {
                        Caption = 'Post Prepayment &Credit Memo';
                        Ellipsis = true;
                        Image = PrepaymentPost;
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            SalesHeader: Record 36;
                            ApprovalMgt: Codeunit 439;
                            PurchPostYNPrepmt: Codeunit 445;
                        begin
                            // IF ApprovalMgt.PrePostApprovalCheck(SalesHeader,Rec) THEN
                            //   PurchPostYNPrepmt.PostPrepmtCrMemoYN(Rec,FALSE);
                        end;
                    }
                    action("Post and Print Prepmt. Cr. Mem&o")
                    {
                        Caption = 'Post and Print Prepmt. Cr. Mem&o';
                        Ellipsis = true;
                        Image = PrepaymentPostPrint;
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            SalesHeader: Record 36;
                            ApprovalMgt: Codeunit 439;
                            PurchPostYNPrepmt: Codeunit 445;
                        begin
                            // IF ApprovalMgt.PrePostApprovalCheck(SalesHeader,Rec) THEN
                            //   PurchPostYNPrepmt.PostPrepmtCrMemoYN(Rec,TRUE);
                        end;
                    }
                }
            }
            group(Print)
            {
                Caption = 'Print';
                Image = Print;
                action("&Print")
                {
                    Caption = '&Print';
                    Ellipsis = true;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        DocPrint.PrintPurchHeader(Rec);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        JobQueueVisible := Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting";
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD;
        EXIT(Rec.ConfirmDeletion);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter;
    end;

    trigger OnOpenPage()
    begin
        // IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
        //     FILTERGROUP(2);
        //     SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter);
        //     FILTERGROUP(0);
        //     SETFILTER("Location Code", "Location Code");
        // END;
        // UserSetup.GET(USERID);
        // SETFILTER("Location Code", '%1', UserSetup."Location Code");//tk
    end;


    local procedure Post(PostingCodeunitID: Integer)
    begin
        Rec.SendToPosting(PostingCodeunitID);
        IF Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting" THEN
            CurrPage.CLOSE;
        CurrPage.UPDATE(FALSE);
    end;

    local procedure ApproveCalcInvDisc()
    begin
        CurrPage.PurchLines.PAGE.ApproveCalcInvDisc;
    end;

    local procedure BuyfromVendorNoOnAfterValidate()
    begin
        IF Rec.GETFILTER("Buy-from Vendor No.") = xRec."Buy-from Vendor No." THEN
            IF Rec."Buy-from Vendor No." <> xRec."Buy-from Vendor No." THEN
                Rec.SETRANGE("Buy-from Vendor No.");
        CurrPage.UPDATE;
    end;

    local procedure PurchaserCodeOnAfterValidate()
    begin
        // CurrPage.PurchLines.PAGE.UpdateForm(TRUE);//tk
    end;

    local procedure PaytoVendorNoOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.UPDATE;
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.UPDATE;
    end;

    local procedure PricesIncludingVATOnAfterValid()
    begin
        CurrPage.UPDATE;
    end;

    local procedure Prepayment37OnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;


    procedure UpdateSerialNo(PurchLine: Record 39)
    begin

    end;


    procedure DeletePurchSpecification(PurchHeader: Record 38)
    begin
        //ItemTrackingForm.SetSource(ReservEntry,PurchLine."Expected Receipt Date");
        //ItemTrackingForm.SetInbound(PurchLine.IsInbound);
        //ItemTrackingForm.RUNMODAL;
        /*
        ReservEntry.SETCURRENTKEY("Source ID","Source Type",
          "Source Subtype","Source Batch Name","Source Prod. Order Line","Source Ref. No.");
        ReservEntry.SETRANGE("Source ID",PurchHeader."No.");
        ReservEntry.SETRANGE("Source Type",DATABASE::"Purchase Line");
        ReservEntry.SETRANGE("Source Subtype",PurchHeader."Document Type");
        ReservEntry.SETRANGE("Source Batch Name",'');
        ReservEntry.SETRANGE("Source Prod. Order Line",0);
        //ReservEntry.SETRANGE("Source Ref. No.",PurchLine."Line No.");
        IF ReservEntry.FINDSET THEN
          REPEAT
            ReservEntry.DELETE;
          UNTIL ReservEntry.NEXT = 0;
         */
        ReservEntry.SETCURRENTKEY(
          "Source ID", "Source Ref. No.", "Source Type", "Source Subtype",
          "Source Batch Name", "Source Prod. Order Line", "Reservation Status",
          "Shipment Date", "Expected Receipt Date");
        ReservEntry.SETRANGE("Source ID", PurchHeader."No.");
        //ReservEntry.SETRANGE("Source Ref. No.",ReservEntry."Source Ref. No.");
        ReservEntry.SETRANGE("Source Type", DATABASE::"Purchase Line");
        ReservEntry.SETRANGE("Source Subtype", PurchHeader."Document Type");
        ReservEntry.SETRANGE("Source Batch Name", '');
        ReservEntry.SETRANGE("Source Prod. Order Line", 0);
        IF ReservEntry.FINDSET THEN
            REPEAT
                ReservEntry.DELETE;
            UNTIL ReservEntry.NEXT = 0;

    end;

    var
        PurchSetup: Record 312;
        WBU: Codeunit 50000;
        ChangeExchangeRate: Page 511;
        CopyPurchDoc: Report "Copy Purchase Document";
        MoveNegPurchLines: Report 6698;
        ReportPrint: Codeunit 228;
        DocPrint: Codeunit 229;
        UserMgt: Codeunit 5700;
        ArchiveManagement: Codeunit 5063;
        PurchLine: Record 39;
        // DefermentBuffer: Record "Deferment Buffer";


        JobQueueVisible: Boolean;
        BillAmtCalc: Decimal;
        PurchLineRec11: Record 39;
        DiffAmt: Decimal;
        Text060: Label 'Vendor Invoice Value %1 it must be equal to %2 & Difference is %3';
        TrackingSpecification: Record 336;
        ItemTackingLine: Page 6510;
        ReservEntry: Record 337;
        CreateReservEntry: Codeunit 99000830;

        UserSetup: Record 91;

}

