page 50075 "Purchase Order Retail"
{
    Caption = 'Purchase Order';
    CardPageID = "Purchase Order Retail";
    PageType = Document;
    RefreshOnActivate = true;
    UsageCategory = Lists;
    ApplicationArea = all;
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
                field("No."; Rec."No.")
                {
                    Editable = false;
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
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        // BuyfromVendorNoOnAfterValidate;//tk
                    end;
                }
                field("Buy-from Contact No."; Rec."Buy-from Contact No.")
                {
                    Editable = false;
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
                    Editable = false;
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
                //     Caption = '**Structure';
                //     Editable = false;
                //     Importance = Promoted;
                // }//tk
                field("Posting Date"; Rec."Posting Date")
                {
                    Caption = '**Posting Date';
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    Editable = false;
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
                    Editable = false;
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
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    Caption = '**Purchaser Code';
                    Importance = Additional;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        // PurchaserCodeOnAfterValidate;
                    end;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Caption = '**Responsibility Center';
                    Editable = false;
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Caption = '**Location Code';
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    Editable = false;
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
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Closing Remark"; Rec."Closing Remark")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Closed; Rec.Closed)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Remarks Team"; Rec."Remarks Team")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Remarks Vendor"; Rec."Remarks Vendor")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            part(PurchLines; 50076)
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        // PaytoVendorNoOnAfterValidate;//tk
                    end;
                }
                field("Pay-to Contact No."; Rec."Pay-to Contact No.")
                {
                    Editable = false;
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Pay-to Address"; Rec."Pay-to Address")
                {
                    Editable = false;
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Pay-to Address 2"; Rec."Pay-to Address 2")
                {
                    Editable = false;
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Pay-to Post Code"; Rec."Pay-to Post Code")
                {
                    Editable = false;
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Pay-to City"; Rec."Pay-to City")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Pay-to Contact"; Rec."Pay-to Contact")
                {
                    Editable = false;
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        // ShortcutDimension1CodeOnAfterV;
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        // ShortcutDimension2CodeOnAfterV;
                    end;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    Editable = false;
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    Editable = false;
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Payment Reference"; Rec."Payment Reference")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Creditor No."; Rec."Creditor No.")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("On Hold"; Rec."On Hold")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Prices Including VAT"; Rec."Prices Including VAT")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        // PricesIncludingVATOnAfterValid;//tk
                    end;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    Editable = false;
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    Editable = false;
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    Editable = false;
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Inbound Whse. Handling Time"; Rec."Inbound Whse. Handling Time")
                {
                    Editable = false;
                    Importance = Additional;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    Editable = false;
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Promised Receipt Date"; Rec."Promised Receipt Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    Editable = false;
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
                field("Currency Code"; Rec."Currency Code")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
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
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Entry Point"; Rec."Entry Point")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                //         field(Area;Area)
                // {
                //             Editable = false;
                //             Visible = false;
                // }
            }
            group(Prepayment)
            {
                Caption = 'Prepayment';
                Visible = false;
                field("Prepayment %"; Rec."Prepayment %")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        // Prepayment37OnAfterValidate;//tk
                    end;
                }
                field("Compress Prepayment"; Rec."Compress Prepayment")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Prepmt. Payment Terms Code"; Rec."Prepmt. Payment Terms Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Prepayment Due Date"; Rec."Prepayment Due Date")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Prepmt. Payment Discount %"; Rec."Prepmt. Payment Discount %")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Prepmt. Pmt. Discount Date"; Rec."Prepmt. Pmt. Discount Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Vendor Cr. Memo No."; Rec."Vendor Cr. Memo No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group(Application)
            {
                Caption = 'Application';
                Visible = false;
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group("Tax Information")
            {
                Caption = 'Tax Information';
                // field("Service Type (Rev. Chrg.)";"Service Type (Rev. Chrg.)")
                // {
                //     Visible = false;
                // }
                // field("Consignment Note No.";"Consignment Note No.")
                // {
                //     Visible = false;
                // }
                // //tk
                field(Trading; Rec.Trading)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                // field("C Form";"C Form")
                // {
                //     Editable = false;
                // }
                // field("Form Code";"Form Code")
                // {
                //     Editable = false;
                //     Importance = Promoted;
                // }
                // field("Form No.";"Form No.")
                // {
                //     Editable = false;
                // }
                // field("LC No.";"LC No.")
                // {
                //     Editable = false;
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
                //     Editable = false;
                // }
                group("Manufacturer Detail")
                {
                    Caption = 'Manufacturer Detail';
                    Visible = false;
                    // field("Manufacturer E.C.C. No.";"Manufacturer E.C.C. No.")
                    // {
                    //     Editable = false;
                    // }
                    // field("Manufacturer Name";"Manufacturer Name")
                    // {
                    //     Editable = false;
                    // }
                    // field("Manufacturer Address";"Manufacturer Address")
                    // {
                    //     Editable = false;
                    // }
                }
            }
        }
        area(factboxes)
        {
            part(PL; 9090)
            {
                Provider = PurchLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = false;
                ApplicationArea = All;
            }
            part("Approval FactBox"; 9092)
            {
                SubPageLink = "Table ID" = CONST(38),
                              "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
                Visible = false;
                ApplicationArea = All;
            }
            part("Vendor Details FactBox"; 9093)
            {
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
                Visible = false;
                ApplicationArea = All;
            }
            part("Vendor Statistics FactBox"; 9094)
            {
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
                Visible = true;
                ApplicationArea = All;
            }
            part("Vendor Hist. Buy-from FactBox"; 9095)
            {
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
                Visible = true;
                ApplicationArea = All;
            }
            part("Vendor Hist. Pay-to FactBox"; 9096)
            {
                SubPageLink = "No." = FIELD("Pay-to Vendor No.");
                Visible = false;
                ApplicationArea = All;
            }
            part("Purchase Line FactBox"; 9100)
            {
                Provider = PurchLines;
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("Document No."),
                              "Line No." = FIELD("Line No.");
                ApplicationArea = All;
            }
            systempart(Link; Links)
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
                        //   CalcInvDiscForHeader;
                        //   COMMIT;
                        // END;
                        // IF Structure <> '' THEN BEGIN
                        //   PurchLine.CalculateStructures(Rec);
                        //   PurchLine.AdjustStructureAmounts(Rec);
                        //   PurchLine.UpdatePurchLines(Rec);
                        //   PurchLine.CalculateTDS(Rec);
                        // END ELSE
                        //   PurchLine.CalculateTDS(Rec);

                        // COMMIT;
                        // PAGE.RUNMODAL(PAGE::"Purchase Order Statistics",Rec);
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
                    // ApprovalEntries: Page 658;
                    begin
                        // ApprovalEntries.Setfilters(DATABASE::"Purchase Header","Document Type","No.");
                        // ApprovalEntries.RUN;
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page 66;
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
                        UserSetup: Record 91;
                    begin
                        UserSetup.GET(USERID);
                        IF NOT UserSetup."Close PO" THEN
                            EXIT;

                        PurchLine.RESET;
                        PurchLine.SETRANGE("Document Type", Rec."Document Type");
                        PurchLine.SETRANGE("Document No.", Rec."No.");
                        IF PurchLine.FINDSET THEN BEGIN
                            REPEAT
                                IF PurchLine."Qty. Rcd. Not Invoiced" <> 0 THEN
                                    ERROR('You can not close the Purchase Order, Received Quantity & Invoiced Quantity are not matching for Item %1', PurchLine."No.");
                            UNTIL PurchLine.NEXT = 0;
                        END;
                        IF Rec."Closing Remark" = '' THEN
                            ERROR('Closing Remark should not be blank')
                        ELSE BEGIN
                            PurchLine.RESET;
                            PurchLine.SETRANGE("Document Type", Rec."Document Type");
                            PurchLine.SETRANGE("Document No.", Rec."No.");
                            IF PurchLine.FINDSET THEN BEGIN
                                REPEAT
                                    PurchLine.Quantity := PurchLine."Quantity Received";
                                    PurchLine.MODIFY;
                                UNTIL PurchLine.NEXT = 0;
                            END;

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
                    RunObject = Page 145;
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
                    RunObject = Page 146;
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                    ApplicationArea = All;
                }
                action("Prepa&yment Invoices")
                {
                    Caption = 'Prepa&yment Invoices';
                    Image = PrepaymentInvoice;
                    // RunObject = Page 146;
                    //                 RunPageLink = Prepayment Order No.=FIELD(No.);
                    // RunPageView = SORTING(Prepayment Order No.);
                    Visible = false;
                    ApplicationArea = All;
                }
                action("Prepayment Credi&t Memos")
                {
                    Caption = 'Prepayment Credi&t Memos';
                    Image = PrepaymentCreditMemo;
                    // RunObject = Page 147;
                    //                 RunPageLink = Prepayment Order No.=FIELD(No.);
                    // RunPageView = SORTING(Prepayment Order No.);
                    Visible = false;
                    ApplicationArea = All;
                }
            }
            group(Warehouse1)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                Visible = false;
                separator(Separator8)
                {
                }
                action("In&vt. Put-away/Pick Lines")
                {
                    Caption = 'In&vt. Put-away/Pick Lines';
                    Image = PickLines;
                    ApplicationArea = All;
                    // RunObject = Page 5774;
                    //                 RunPageLink = Source Document=CONST(Purchase Order),
                    //               Source No.=FIELD(No.);
                    // RunPageView = SORTING(Source Document,Source No.,Location Code);
                }
                action("Whse. Receipt Lines")
                {
                    Caption = 'Whse. Receipt Lines';
                    Image = ReceiptLines;
                    ApplicationArea = All;
                    // RunObject = Page 7342;
                    //                 RunPageLink = Source Type=CONST(39),
                    //               Source Subtype=FIELD(Document Type),
                    //               Source No.=FIELD(No.);
                    //RunPageView = SORTING(Source Type,Source Subtype,Source No.,Source Line No.);
                }
                separator(Separator1)
                {
                }
                group("Dr&opShipment")
                {
                    Caption = 'Dr&op Shipment';
                    Image = Delivery;
                    action("Get&SalesOrder1")
                    {
                        Caption = 'Get &Sales Order';
                        Image = "Order";
                        ApplicationArea = All;
                        //     RunObject = Codeunit 76;
                    }
                }
                group("Speci&alOrder")
                {
                    Caption = 'Speci&al Order';
                    Image = SpecialOrder;
                    action("Get&SalesOrder")
                    {
                        Caption = 'Get &Sales Order';
                        Image = "Order";
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            PurchHeader: Record 38;
                        // DistIntegration: Codeunit 5702;
                        begin
                            PurchHeader.COPY(Rec);
                            // DistIntegration.GetSpecialOrders(PurchHeader);
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
                separator(Separator12)
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
                    //ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        //ReleasePurchDoc.PerformManualRelease(Rec);
                    end;
                }
                action("Re&open")
                {
                    Caption = 'Re&open';
                    Image = ReOpen;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                    // ReleasePurchDoc: codeunit 415;
                    begin
                        //ReleasePurchDoc.PerformManualReopen(Rec);
                    end;
                }
                separator(Separator9)
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
                        ApproveCalcInvDisc;
                    end;
                }
                separator(separator)
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
                separator(Separator11)
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
                        // CLEAR(CopyPurchDoc);
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
                        // MoveNegPurchLines.ShowDocument;
                    end;
                }
                group("Dr&op Shipment")
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
                group("Speci&al Order")
                {
                    Caption = 'Speci&al Order';
                    Image = SpecialOrder;
                    action("Get &Sales Order")
                    {
                        Caption = 'Get &Sales Order';
                        Image = "Order";
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            // DistIntegration: Codeunit 5702;
                            PurchHeader: Record 38;
                        begin
                            PurchHeader.COPY(Rec);
                            // DistIntegration.GetSpecialOrders(PurchHeader);
                            Rec := PurchHeader;
                        end;
                    }
                }
                separator(separator3)
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
                // }
                // action("Transit Documents")
                // {
                //     Caption = 'Transit Documents';
                //     Image = TransferOrder;
                //     RunObject = Page 13705;
                //                     RunPageLink = Type=CONST(Purchase),
                //                   PO / SO No.=FIELD(No.),
                //                   Vendor / Customer Ref.=FIELD(Buy-from Vendor No.),
                //                   State=FIELD(State);
                //     Visible = false;
                // }
                action("Deferment Schedule")
                {
                    Caption = 'Deferment Schedule';
                    Image = Installments;
                    ApplicationArea = All;
                    // RunObject = Page 16558;
                    //                 RunPageLink = Document No.=FIELD(No.);
                    // Visible = false;
                }
                action("Attached Gate Entry")
                {
                    Caption = 'Attached Gate Entry';
                    Image = InwardEntry;
                    ApplicationArea = All;
                    // RunObject = Page 16481;
                    //                 RunPageLink = Source No.=FIELD(No.),
                    //               Source Type=CONST(Purchase Order),
                    //               Entry Type=CONST(Inward);
                    // Visible = false;
                }
                action("Detailed &Tax")
                {
                    Caption = 'Detailed &Tax';
                    Image = TaxDetail;
                    ApplicationArea = All;
                    // RunObject = Page 16341;
                    //                 RunPageLink = Document Type=FIELD(Document Type),
                    //               Document No.=FIELD(No.),
                    //               Transaction Type=CONST(Purchase);
                    // Visible = false;
                }
                action("Archive Document")
                {
                    Caption = 'Archi&ve Document';
                    Image = Archive;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        // ArchiveManagement.ArchivePurchDocument(Rec);//tk
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Send IC Purchase Order")
                {
                    Caption = 'Send IC Purchase Order';
                    Image = IntercompanyOrder;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        // ICInOutboxMgt: Codeunit 427;
                        SalesHeader: Record 36;
                    // ApprovalMgt: Codeunit "439";
                    begin
                        // IF ApprovalMgt.PrePostApprovalCheck(SalesHeader,Rec) THEN//tk
                        //   ICInOutboxMgt.SendPurchDoc(Rec,FALSE);//tk
                    end;
                }
                separator(Separator2)
                {
                }
                action("Calc&ulate Structure Values")
                {
                    Caption = 'Calc&ulate Structure Values';
                    Image = CalculateHierarchy;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        // PurchLine.CalculateStructures(Rec);//tk
                        // PurchLine.AdjustStructureAmounts(Rec);//tk
                        // PurchLine.UpdatePurchLines(Rec);//tk
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
                separator(separator4)
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
                        // ApprovalMgt: Codeunit "439";
                        begin
                            // IF ApprovalMgt.SendPurchaseApprovalRequest(Rec) THEN;
                        end;
                    }
                    action("Cancel Approval Re&quest")
                    {
                        Caption = 'Cancel Approval Re&quest';
                        Image = Cancel;
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                        // ApprovalMgt: Codeunit "439";
                        begin
                            // IF ApprovalMgt.CancelPurchaseApprovalRequest(Rec,TRUE,TRUE) THEN;
                        end;
                    }
                }
            }
            group(Warehouse)
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
                    // GetSourceDocInbound: Codeunit 5751;
                    begin
                        // GetSourceDocInbound.CreateFromPurchOrder(Rec);

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
                    Visible = false;
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
                        Rec.GetGateEntryLines;//tk
                    end;
                }
                separator(Separator5)
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
                        //  DeletePurchSpecification(Rec);//tk
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
                action("Serial Details")
                {
                    Caption = 'Serial Details';
                    Ellipsis = true;
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        // PurchasePostViaJobQueue: Codeunit 98;
                        PurchLine: Record 39;
                    begin
                        // CLEAR(PODetails);//tk
                        RecpurcLine12.RESET;
                        RecpurcLine12.SETFILTER(RecpurcLine12."No.", Rec."No.");
                        IF RecpurcLine12.FINDFIRST THEN BEGIN
                            // PODetails.SETTABLEVIEW(RecpurcLine12);
                            // PODetails.RUNMODAL;
                        END;
                        //Try now
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
                        // PurchasePostViaJobQueue: Codeunit 98;
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
                        PurchLine.RESET;
                        PurchLine.SETRANGE("Document Type", Rec."Document Type"::Order);
                        PurchLine.SETFILTER("Document No.", Rec."No.");
                        PurchLine.SETFILTER(Type, '%1', PurchLine.Type::Item);
                        IF PurchLine.FINDSET THEN BEGIN
                            REPEAT
                            //   IF NOT ReservEntryExistPurchLine(PurchLine) AND ( PurchLine."UPN Code" = '' ) THEN BEGIN
                            //    IF (PurchLine."Qty. to Receive" <> 0) OR (PurchLine."Qty. to Invoice" <> 0 ) THEN
                            //     ERROR('Serial No. Or UPN Code required for Item %1',PurchLine."No." );
                            //  END;//tk
                            UNTIL PurchLine.NEXT = 0;
                        END;
                        WBU.RefreshStatistics();
                        //  Post(CODEUNIT::"Purch.-Post (Yes/No)");//tk

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
                        PurchLine.RESET;
                        PurchLine.SETRANGE("Document Type", Rec."Document Type"::Order);
                        PurchLine.SETFILTER("Document No.", Rec."No.");
                        PurchLine.SETFILTER(Type, '%1', PurchLine.Type::Item);
                        IF PurchLine.FINDSET THEN BEGIN
                            REPEAT
                            //   IF NOT ReservEntryExistPurchLine(PurchLine) AND ( PurchLine."UPN Code" = '' ) THEN BEGIN
                            //   IF (PurchLine."Qty. to Receive" <> 0) OR (PurchLine."Qty. to Invoice" <> 0 ) THEN
                            //     ERROR('Serial No. Or UPN Code required for Item %1',PurchLine."No." );
                            //   END;//tk
                            UNTIL PurchLine.NEXT = 0;
                        END;

                        WBU.RefreshStatistics();
                        // Post(CODEUNIT::"Purch.-Post + Print");
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
                        // ReportPrint.PrintPurchHeader(Rec);//tk
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
                        //REPORT.RUNMODAL(REPORT::"Batch Post Purchase Orders",TRUE,TRUE,Rec);
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
                        // DefermentBuffer.SETRANGE("Document No.","No.");
                        // // REPORT.RUNMODAL(16543,TRUE,TRUE,DefermentBuffer);
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
                separator(Separator6)
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
                            // ReportPrint.PrintPurchHeaderPrepmt(Rec);//tk
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
                        // ApprovalMgt: Codeunit 439;
                        // PurchPostYNPrepmt: Codeunit 445;
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
                        Visible = false;
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            SalesHeader: Record 36;
                        // ApprovalMgt: Codeunit 439;
                        // PurchPostYNPrepmt: Codeunit "445";
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
                        // ApprovalMgt: Codeunit "439";
                        // PurchPostYNPrepmt: Codeunit "445";
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
                        // ApprovalMgt: Codeunit "439";
                        // PurchPostYNPrepmt: Codeunit "445";
                        begin
                            // IF ApprovalMgt.PrePostApprovalCheck(SalesHeader,Rec) THEN
                            //   PurchPostYNPrepmt.PostPrepmtCrMemoYN(Rec,TRUE);//tk
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
                        // DocPrint.PrintPurchHeader(Rec);//tk
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
        // "Responsibility Center" := UserMgt.GetPurchasesFilter;//tk
    end;

    trigger OnOpenPage()
    begin
        IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter);
            Rec.FILTERGROUP(0);
            Rec.SETFILTER("Location Code", Rec."Location Code");
        END;
    end;

    var
        PurchSetup: Record 312;
        // ChangeExchangeRate: Page 511;
        //                         CopyPurchDoc: Report 492;
        //                         MoveNegPurchLines: Report 6698;
        //                         ReportPrint: Codeunit 228;
        //                         DocPrint: Codeunit 229;
        UserMgt: Codeunit 5700;
        //                         ArchiveManagement: Codeunit 5063;
        PurchLine: Record 39;
        // DefermentBuffer: Record 16532;
        //[InDataSet]

        JobQueueVisible: Boolean;
        BillAmtCalc: Decimal;
        PurchLineRec11: Record 39;
        DiffAmt: Decimal;
        Text060: Label 'Vendor Invoice Value %1 it must be equal to %2 & Difference is %3';
        TrackingSpecification: Record 336;
        // ItemTackingLine: Page 6510;
        ReservEntry: Record 337;
        //  CreateReservEntry: Codeunit 99000830;
        WBU: Codeunit 50000;
        //  ReservePurchLine: Codeunit 99000834;
        RecpurcLine12: Record 38;
    //  PODetails: Report 50030;//tk1

    local procedure Post(PostingCodeunitID: Integer)
    begin
        // SendToPosting(PostingCodeunitID);
        // IF "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting" THEN
        //     CurrPage.CLOSE;
        // CurrPage.UPDATE(FALSE);//tk
    end;

    local procedure ApproveCalcInvDisc()
    begin
        // CurrPage.PurchLines.PAGE.ApproveCalcInvDisc;//tk
    end;

    local procedure BuyfromVendorNoOnAfterValidate()
    begin
        // IF GETFILTER("Buy-from Vendor No.") = xRec."Buy-from Vendor No." THEN
        //     IF "Buy-from Vendor No." <> xRec."Buy-from Vendor No." THEN
        //         SETRANGE("Buy-from Vendor No.");
        // CurrPage.UPDATE;
    end;

    local procedure PurchaserCodeOnAfterValidate()
    begin
        // CurrPage.PurchLines.PAGE.UpdateForm(TRUE);//tk
    end;

    local procedure PaytoVendorNoOnAfterValidate()
    begin
        // CurrPage.UPDATE;//tk
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        // CurrPage.UPDATE;
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


    procedure ReservEntryExistPurchLine(PurchLine: Record 39): Boolean
    var
        NewReservEntry: Record 337;
    begin
        ReservEntry.RESET;
        ReservEntry.SETRANGE("Source ID", PurchLine."Document No.");
        ReservEntry.SETRANGE("Source Ref. No.", PurchLine."Line No.");
        ReservEntry.SETRANGE("Source Type", DATABASE::"Purchase Line");
        ReservEntry.SETRANGE("Source Subtype", PurchLine."Document Type");
        ReservEntry.SETRANGE("Source Batch Name", '');
        ReservEntry.SETRANGE("Source Prod. Order Line", 0);
        EXIT(ReservEntry.FINDSET);
    end;
}

