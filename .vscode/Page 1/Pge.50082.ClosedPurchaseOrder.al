// page 50082 "Closed Purchase Order"
// {
//     Caption = 'Purchase Order';
//     PageType = Document;
//     RefreshOnActivate = true;
//     UsageCategory = Lists;
//     ApplicationArea = all;
//     SourceTable = 38;
//     SourceTableView = WHERE("Document Type" = FILTER("Order"),
//                             Subcontracting = FILTER(false),
//                             Closed = FILTER(true));

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field("No."; "No.")
//                 {
//                     Importance = Promoted;

//                     trigger OnAssistEdit()
//                     begin
//                         IF AssistEdit(xRec) THEN
//                             CurrPage.UPDATE;
//                     end;
//                 }
//                 field("Buy-from Vendor No."; "Buy-from Vendor No.")
//                 {
//                     Importance = Promoted;

//                     trigger OnValidate()
//                     begin
//                         BuyfromVendorNoOnAfterValidate;
//                     end;
//                 }
//                 field("Buy-from Contact No."; "Buy-from Contact No.")
//                 {
//                 }
//                 field("Buy-from Vendor Name"; "Buy-from Vendor Name")
//                 {
//                     Editable = false;
//                 }
//                 field("Buy-from Address"; "Buy-from Address")
//                 {
//                     Editable = false;
//                     Importance = Additional;
//                 }
//                 field("Buy-from Address 2"; "Buy-from Address 2")
//                 {
//                     Editable = false;
//                     Importance = Additional;
//                 }
//                 field("Buy-from Post Code"; "Buy-from Post Code")
//                 {
//                     Editable = false;
//                     Importance = Additional;
//                 }
//                 field("Buy-from City"; "Buy-from City")
//                 {
//                     Editable = false;
//                 }
//                 field("Buy-from Contact"; "Buy-from Contact")
//                 {
//                     Importance = Additional;
//                 }
//                 field("No. of Archived Versions"; "No. of Archived Versions")
//                 {
//                     Importance = Additional;
//                     Visible = false;
//                 }
//                 field(Structure; Structure)
//                 {
//                     Caption = '**Structure';
//                     Importance = Promoted;
//                 }
//                 field("Posting Date"; "Posting Date")
//                 {
//                     Caption = '**Posting Date';
//                 }
//                 field("Order Date"; "Order Date")
//                 {
//                     Importance = Promoted;
//                 }
//                 field("Document Date"; "Document Date")
//                 {
//                 }
//                 field("Quote No."; "Quote No.")
//                 {
//                     Importance = Additional;
//                     Visible = false;
//                 }
//                 field("Vendor Order No."; "Vendor Order No.")
//                 {
//                     Visible = false;
//                 }
//                 field("Vendor Shipment No."; "Vendor Shipment No.")
//                 {
//                 }
//                 field("Vendor Invoice No."; "Vendor Invoice No.")
//                 {
//                 }
//                 field("Import Document No."; "Import Document No.")
//                 {
//                     Visible = false;
//                 }
//                 field("Order Address Code"; "Order Address Code")
//                 {
//                     Importance = Additional;
//                     Visible = false;
//                 }
//                 field("Purchaser Code"; "Purchaser Code")
//                 {
//                     Caption = '**Purchaser Code';
//                     Importance = Additional;

//                     trigger OnValidate()
//                     begin
//                         PurchaserCodeOnAfterValidate;
//                     end;
//                 }
//                 field("Responsibility Center"; "Responsibility Center")
//                 {
//                     Caption = '**Responsibility Center';
//                     Importance = Additional;
//                 }
//                 field("Location Code"; "Location Code")
//                 {
//                     Caption = '**Location Code';
//                     Importance = Promoted;
//                 }
//                 field("Assigned User ID"; "Assigned User ID")
//                 {
//                     Importance = Additional;
//                     Visible = false;
//                 }
//                 field("Job Queue Status"; "Job Queue Status")
//                 {
//                     Importance = Additional;
//                     Visible = false;
//                 }
//                 field(Status; Status)
//                 {
//                     Importance = Promoted;
//                 }
//                 field("Vendor Invoice Value"; "Vendor Invoice Value")
//                 {
//                 }
//                 field("PO Validity Date"; "PO Validity Date")
//                 {
//                 }
//                 field("Closing Remark"; "Closing Remark")
//                 {
//                     Visible = false;
//                 }
//                 field(Closed; Closed)
//                 {
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Remarks Team"; "Remarks Team")
//                 {
//                     Visible = false;
//                 }
//                 field("Remarks Vendor"; "Remarks Vendor")
//                 {
//                     Visible = false;
//                 }
//             }
//             part(PurchLines; 54)
//             {
//                 SubPageLink = Document No.=FIELD(No.);
//             }
//             group(Invoicing)
//             {
//                 Caption = 'Invoicing';
//                 field("Pay-to Vendor No."; "Pay-to Vendor No.")
//                 {
//                     Importance = Promoted;

//                     trigger OnValidate()
//                     begin
//                         PaytoVendorNoOnAfterValidate;
//                     end;
//                 }
//                 field("Pay-to Contact No."; "Pay-to Contact No.")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Pay-to Name"; "Pay-to Name")
//                 {
//                 }
//                 field("Pay-to Address"; "Pay-to Address")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Pay-to Address 2"; "Pay-to Address 2")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Pay-to Post Code"; "Pay-to Post Code")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Pay-to City"; "Pay-to City")
//                 {
//                 }
//                 field("Pay-to Contact"; "Pay-to Contact")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
//                 {

//                     trigger OnValidate()
//                     begin
//                         ShortcutDimension1CodeOnAfterV;
//                     end;
//                 }
//                 field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
//                 {

//                     trigger OnValidate()
//                     begin
//                         ShortcutDimension2CodeOnAfterV;
//                     end;
//                 }
//                 field("Payment Terms Code"; "Payment Terms Code")
//                 {
//                     Importance = Promoted;
//                 }
//                 field("Due Date"; "Due Date")
//                 {
//                     Importance = Promoted;
//                 }
//                 field("Payment Discount %"; "Payment Discount %")
//                 {
//                 }
//                 field("Pmt. Discount Date"; "Pmt. Discount Date")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Payment Method Code"; "Payment Method Code")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Payment Reference"; "Payment Reference")
//                 {
//                     Visible = false;
//                 }
//                 field("Creditor No."; "Creditor No.")
//                 {
//                     Visible = false;
//                 }
//                 field("On Hold"; "On Hold")
//                 {
//                     Visible = false;
//                 }
//                 field("Prices Including VAT"; "Prices Including VAT")
//                 {
//                     Visible = false;

//                     trigger OnValidate()
//                     begin
//                         PricesIncludingVATOnAfterValid;
//                     end;
//                 }
//                 field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
//                 {
//                     Visible = false;
//                 }
//             }
//             group(Shipping)
//             {
//                 Caption = 'Shipping';
//                 field("Ship-to Name"; "Ship-to Name")
//                 {
//                 }
//                 field("Ship-to Address"; "Ship-to Address")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Ship-to Address 2"; "Ship-to Address 2")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Ship-to Post Code"; "Ship-to Post Code")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Ship-to Contact"; "Ship-to Contact")
//                 {
//                 }
//                 field("Ship-to City"; "Ship-to City")
//                 {
//                 }
//                 field("Inbound Whse. Handling Time"; "Inbound Whse. Handling Time")
//                 {
//                     Importance = Additional;
//                     Visible = false;
//                 }
//                 field("Shipment Method Code"; "Shipment Method Code")
//                 {
//                 }
//                 field("Lead Time Calculation"; "Lead Time Calculation")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Requested Receipt Date"; "Requested Receipt Date")
//                 {
//                 }
//                 field("Promised Receipt Date"; "Promised Receipt Date")
//                 {
//                 }
//                 field("Expected Receipt Date"; "Expected Receipt Date")
//                 {
//                     Importance = Promoted;
//                 }
//                 field("Sell-to Customer No."; "Sell-to Customer No.")
//                 {
//                     Visible = false;
//                 }
//                 field("Ship-to Code"; "Ship-to Code")
//                 {
//                     Visible = false;
//                 }
//             }
//             group("Foreign Trade")
//             {
//                 Caption = 'Foreign Trade';
//                 field("Currency Code"; "Currency Code")
//                 {
//                     Importance = Promoted;

//                     trigger OnAssistEdit()
//                     begin
//                         CLEAR(ChangeExchangeRate);
//                         IF "Posting Date" <> 0D THEN
//                             ChangeExchangeRate.SetParameter("Currency Code", "Currency Factor", "Posting Date")
//                         ELSE
//                             ChangeExchangeRate.SetParameter("Currency Code", "Currency Factor", WORKDATE);
//                         IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
//                             VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
//                             CurrPage.UPDATE;
//                         END;
//                         CLEAR(ChangeExchangeRate);
//                     end;
//                 }
//                 field("Transaction Type"; "Transaction Type")
//                 {
//                 }
//                 field("Transaction Specification"; "Transaction Specification")
//                 {
//                 }
//                 field("Transport Method"; "Transport Method")
//                 {
//                 }
//                 field("Entry Point"; "Entry Point")
//                 {
//                     Visible = false;
//                 }
//                 field(Area;Area)
//         {
//                                Visible = false;
//         }
//     }
//             group(Prepayment)
//             {
//                 Caption = 'Prepayment';
//                 Visible = false;
//                 field("Prepayment %";"Prepayment %")
//                 {
//                     Importance = Promoted;

//                     trigger OnValidate()
//                     begin
//                         Prepayment37OnAfterValidate;
//                     end;
//                 }
//                 field("Compress Prepayment";"Compress Prepayment")
//                 {
//                 }
//                 field("Prepmt. Payment Terms Code";"Prepmt. Payment Terms Code")
//                 {
//                 }
//                 field("Prepayment Due Date";"Prepayment Due Date")
//                 {
//                     Importance = Promoted;
//                 }
//                 field("Prepmt. Payment Discount %";"Prepmt. Payment Discount %")
//                 {
//                 }
//                 field("Prepmt. Pmt. Discount Date";"Prepmt. Pmt. Discount Date")
//                 {
//                 }
//                 field("Vendor Cr. Memo No.";"Vendor Cr. Memo No.")
//                 {
//                 }
//             }
//             group(Application)
//             {
//                 Caption = 'Application';
//                 Visible = false;
//                 field("Applies-to Doc. Type";"Applies-to Doc. Type")
//                 {
//                 }
//                 field("Applies-to Doc. No.";"Applies-to Doc. No.")
//                 {
//                 }
//                 field("Applies-to ID";"Applies-to ID")
//                 {
//                 }
//             }
//             group("Tax Information")
//             {
//                 Caption = 'Tax Information';
//                 field("Service Type (Rev. Chrg.)";"Service Type (Rev. Chrg.)")
//                 {
//                     Visible = false;
//                 }
//                 field("Consignment Note No.";"Consignment Note No.")
//                 {
//                     Visible = false;
//                 }
//                 field("Declaration Form (GTA)";"Declaration Form (GTA)")
//                 {
//                     Visible = false;
//                 }
//                 field("Input Service Distribution";"Input Service Distribution")
//                 {
//                     Visible = false;
//                 }
//                 field("Transit Document";"Transit Document")
//                 {
//                     Visible = false;
//                 }
//                 field(Trading;Trading)
//                 {
//                     Visible = false;
//                 }
//                 field("C Form";"C Form")
//                 {
//                 }
//                 field("Form Code";"Form Code")
//                 {
//                     Importance = Promoted;
//                 }
//                 field("Form No.";"Form No.")
//                 {
//                 }
//                 field("LC No.";"LC No.")
//                 {
//                     Visible = false;
//                 }
//                 field("Service Tax Rounding Precision";"Service Tax Rounding Precision")
//                 {
//                     Visible = false;
//                 }
//                 field("Service Tax Rounding Type";"Service Tax Rounding Type")
//                 {
//                     Visible = false;
//                 }
//                 field(PoT;PoT)
//                 {
//                 }
//                 group("Manufacturer Detail")
//                 {
//                     Caption = 'Manufacturer Detail';
//                     Visible = false;
//                     field("Manufacturer E.C.C. No.";"Manufacturer E.C.C. No.")
//                     {
//                     }
//                     field("Manufacturer Name";"Manufacturer Name")
//                     {
//                     }
//                     field("Manufacturer Address";"Manufacturer Address")
//                     {
//                     }
//                 }
//             }
//         }
//         area(factboxes)
//         {
//             part(;9090)
//             {
//                 Provider = PurchLines;
//                 SubPageLink = No.=FIELD(No.);
//                 Visible = false;
//             }
//             part(;9092)
//             {
//                 SubPageLink = Table ID=CONST(38),
//                               Document Type=FIELD(Document Type),
//                               Document No.=FIELD(No.);
//                 Visible = false;
//             }
//             part(;9093)
//             {
//                 SubPageLink = No.=FIELD(Buy-from Vendor No.);
//                 Visible = false;
//             }
//             part(;9094)
//             {
//                 SubPageLink = No.=FIELD(Buy-from Vendor No.);
//                 Visible = true;
//             }
//             part(;9095)
//             {
//                 SubPageLink = No.=FIELD(Buy-from Vendor No.);
//                 Visible = true;
//             }
//             part(;9096)
//             {
//                 SubPageLink = No.=FIELD(Pay-to Vendor No.);
//                 Visible = false;
//             }
//             part(;9100)
//             {
//                 Provider = PurchLines;
//                 SubPageLink = Document Type=FIELD(Document Type),
//                               Document No.=FIELD(Document No.),
//                               Line No.=FIELD(Line No.);
//             }
//             systempart(;Links)
//             {
//                 Visible = false;
//             }
//             systempart(;Notes)
//             {
//                 Visible = true;
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group("O&rder")
//             {
//                 Caption = 'O&rder';
//                 Image = "Order";
//                 action(Dimensions)
//                 {
//                     Caption = 'Dimensions';
//                     Image = Dimensions;
//                     Promoted = false;
//                     //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
//                     //PromotedIsBig = false;
//                     ShortCutKey = 'Shift+Ctrl+D';

//                     trigger OnAction()
//                     begin
//                         ShowDocDim;
//                         CurrPage.SAVERECORD;
//                     end;
//                 }
//                 action(Statistics)
//                 {
//                     Caption = 'Statistics';
//                     Image = Statistics;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     ShortCutKey = 'F7';

//                     trigger OnAction()
//                     begin
//                         PurchSetup.GET;
//                         IF PurchSetup."Calc. Inv. Discount" THEN BEGIN
//                           CalcInvDiscForHeader;
//                           COMMIT;
//                         END;
//                         IF Structure <> '' THEN BEGIN
//                           PurchLine.CalculateStructures(Rec);
//                           PurchLine.AdjustStructureAmounts(Rec);
//                           PurchLine.UpdatePurchLines(Rec);
//                           PurchLine.CalculateTDS(Rec);
//                         END ELSE
//                           PurchLine.CalculateTDS(Rec);

//                         COMMIT;
//                         PAGE.RUNMODAL(PAGE::"Purchase Order Statistics",Rec);
//                     end;
//                 }
//                 action("St&ructure")
//                 {
//                     Caption = 'St&ructure';
//                     Image = Hierarchy;
//                     RunObject = Page 16305;
//                                     RunPageLink = Type=CONST(Purchase),
//                                   Document Type=FIELD(Document Type),
//                                   Document No.=FIELD(No.);
//                 }
//                 action(Card)
//                 {
//                     Caption = 'Card';
//                     Image = EditLines;
//                     Promoted = false;
//                     //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
//                     //PromotedIsBig = false;
//                     RunObject = Page 26;
//                                     RunPageLink = No.=FIELD(Buy-from Vendor No.);
//                     ShortCutKey = 'Shift+F7';
//                 }
//                 action(Approvals)
//                 {
//                     Caption = 'Approvals';
//                     Image = Approvals;
//                     Promoted = false;
//                     //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
//                     //PromotedIsBig = false;

//                     trigger OnAction()
//                     var
//                         ApprovalEntries: Page "658";
//                     begin
//                         ApprovalEntries.Setfilters(DATABASE::"Purchase Header","Document Type","No.");
//                         ApprovalEntries.RUN;
//                     end;
//                 }
//                 action("Co&mments")
//                 {
//                     Caption = 'Co&mments';
//                     Image = ViewComments;
//                     RunObject = Page 66;
//                                     RunPageLink = Document Type=FIELD(Document Type),
//                                   No.=FIELD(No.),
//                                   Document Line No.=CONST(0);
//                 }
//                 action("Send mail to Vendor")
//                 {
//                     Promoted = true;
//                     PromotedCategory = "Report";
//                     PromotedIsBig = true;

//                     trigger OnAction()
//                     begin
//                         IF (Status <> Status:: Released) THEN
//                           ERROR('Purchase order is not Approved');
//                         WBU.SendMailtoVendorwithAttachment(Rec);
//                     end;
//                 }
//             }
//             group(Closing)
//             {
//                 action("Close Purchase Order")
//                 {
//                     Ellipsis = true;
//                     Image = Close;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;

//                     trigger OnAction()
//                     var
//                         PurchLine: Record "39";
//                         UserSetup: Record "91";
//                     begin
//                         UserSetup.GET(USERID);
//                         IF NOT UserSetup."Close PO" THEN
//                           EXIT;

//                         PurchLine.RESET;
//                         PurchLine.SETRANGE("Document Type","Document Type");
//                         PurchLine.SETRANGE("Document No.","No.");
//                         IF PurchLine.FINDSET THEN BEGIN
//                         REPEAT
//                           IF PurchLine."Qty. Rcd. Not Invoiced" <> 0 THEN
//                             ERROR('You can not close the Purchase Order, Received Quantity & Invoiced Quantity are not matching for Item %1',PurchLine."No.");
//                         UNTIL PurchLine.NEXT = 0;
//                         END;
//                         IF "Closing Remark" = '' THEN
//                           ERROR('Closing Remark should not be blank')
//                         ELSE BEGIN
//                           PurchLine.RESET;
//                           PurchLine.SETRANGE("Document Type","Document Type");
//                           PurchLine.SETRANGE("Document No.","No.");
//                           IF PurchLine.FINDSET THEN BEGIN
//                           REPEAT
//                             PurchLine.Quantity := PurchLine."Quantity Received";
//                             PurchLine.MODIFY;
//                           UNTIL PurchLine.NEXT = 0;
//                           END;

//                           Closed := TRUE;
//                           "Closed By" := USERID;
//                           "Closed Date & Time" := CURRENTDATETIME;
//                         END;
//                         //Win 127
//                         CurrPage.CLOSE;
//                     end;
//                 }
//             }
//             group(Documents)
//             {
//                 Caption = 'Documents';
//                 Image = Documents;
//                 action(Receipts)
//                 {
//                     Caption = 'Receipts';
//                     Image = PostedReceipts;
//                     RunObject = Page 145;
//                                     RunPageLink = Order No.=FIELD(No.);
//                     RunPageView = SORTING(Order No.);
//                 }
//                 action(Invoices)
//                 {
//                     Caption = 'Invoices';
//                     Image = Invoice;
//                     Promoted = false;
//                     //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
//                     //PromotedIsBig = false;
//                     RunObject = Page 146;
//                                     RunPageLink = Order No.=FIELD(No.);
//                     RunPageView = SORTING(Order No.);
//                 }
//                 action("Prepa&yment Invoices")
//                 {
//                     Caption = 'Prepa&yment Invoices';
//                     Image = PrepaymentInvoice;
//                     RunObject = Page 146;
//                                     RunPageLink = Prepayment Order No.=FIELD(No.);
//                     RunPageView = SORTING(Prepayment Order No.);
//                     Visible = false;
//                 }
//                 action("Prepayment Credi&t Memos")
//                 {
//                     Caption = 'Prepayment Credi&t Memos';
//                     Image = PrepaymentCreditMemo;
//                     RunObject = Page 147;
//                                     RunPageLink = Prepayment Order No.=FIELD(No.);
//                     RunPageView = SORTING(Prepayment Order No.);
//                     Visible = false;
//                 }
//             }
//             group(Warehouse)
//             {
//                 Caption = 'Warehouse';
//                 Image = Warehouse;
//                 Visible = false;
//                 separator()
//                 {
//                 }
//                 action("In&vt. Put-away/Pick Lines")
//                 {
//                     Caption = 'In&vt. Put-away/Pick Lines';
//                     Image = PickLines;
//                     RunObject = Page 5774;
//                                     RunPageLink = Source Document=CONST(Purchase Order),
//                                   Source No.=FIELD(No.);
//                     RunPageView = SORTING(Source Document,Source No.,Location Code);
//                 }
//                 action("Whse. Receipt Lines")
//                 {
//                     Caption = 'Whse. Receipt Lines';
//                     Image = ReceiptLines;
//                     RunObject = Page 7342;
//                                     RunPageLink = Source Type=CONST(39),
//                                   Source Subtype=FIELD(Document Type),
//                                   Source No.=FIELD(No.);
//                     RunPageView = SORTING(Source Type,Source Subtype,Source No.,Source Line No.);
//                 }
//                 separator()
//                 {
//                 }
//                 group("Dr&op Shipment")
//                 {
//                     Caption = 'Dr&op Shipment';
//                     Image = Delivery;
//                     action("Get &Sales Order")
//                     {
//                         Caption = 'Get &Sales Order';
//                         Image = "Order";
//                         RunObject = Codeunit 76;
//                     }
//                 }
//                 group("Speci&al Order")
//                 {
//                     Caption = 'Speci&al Order';
//                     Image = SpecialOrder;
//                     action("Get &Sales Order")
//                     {
//                         Caption = 'Get &Sales Order';
//                         Image = "Order";

//                         trigger OnAction()
//                         var
//                             PurchHeader: Record "38";
//                             DistIntegration: Codeunit "5702";
//                         begin
//                             PurchHeader.COPY(Rec);
//                             DistIntegration.GetSpecialOrders(PurchHeader);
//                             Rec := PurchHeader;
//                         end;
//                     }
//                 }
//             }
//         }
//         area(processing)
//         {
//             group(Release)
//             {
//                 Caption = 'Release';
//                 Image = ReleaseDoc;
//                 separator()
//                 {
//                 }
//                 action(Release)
//                 {
//                     Caption = 'Re&lease';
//                     Image = ReleaseDoc;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     ShortCutKey = 'Ctrl+F9';

//                     trigger OnAction()
//                     var
//                         ReleasePurchDoc: Codeunit "415";
//                     begin
//                         ReleasePurchDoc.PerformManualRelease(Rec);
//                     end;
//                 }
//                 action("Re&open")
//                 {
//                     Caption = 'Re&open';
//                     Image = ReOpen;

//                     trigger OnAction()
//                     var
//                         ReleasePurchDoc: Codeunit "415";
//                     begin
//                         ReleasePurchDoc.PerformManualReopen(Rec);
//                     end;
//                 }
//                 separator()
//                 {
//                 }
//             }
//             group("F&unctions")
//             {
//                 Caption = 'F&unctions';
//                 Image = "Action";
//                 action("Calculate &Invoice Discount")
//                 {
//                     Caption = 'Calculate &Invoice Discount';
//                     Image = CalculateInvoiceDiscount;

//                     trigger OnAction()
//                     begin
//                         ApproveCalcInvDisc;
//                     end;
//                 }
//                 separator()
//                 {
//                 }
//                 action("Get St&d. Vend. Purchase Codes")
//                 {
//                     Caption = 'Get St&d. Vend. Purchase Codes';
//                     Ellipsis = true;
//                     Image = VendorCode;
//                     Visible = false;

//                     trigger OnAction()
//                     var
//                         StdVendPurchCode: Record "175";
//                     begin
//                         StdVendPurchCode.InsertPurchLines(Rec);
//                     end;
//                 }
//                 separator()
//                 {
//                 }
//                 action(CopyDocument)
//                 {
//                     Caption = 'Copy Document';
//                     Ellipsis = true;
//                     Image = CopyDocument;
//                     Promoted = true;
//                     PromotedCategory = Process;

//                     trigger OnAction()
//                     begin
//                         CopyPurchDoc.SetPurchHeader(Rec);
//                         CopyPurchDoc.RUNMODAL;
//                         CLEAR(CopyPurchDoc);
//                     end;
//                 }
//                 action("Move Negative Lines")
//                 {
//                     Caption = 'Move Negative Lines';
//                     Ellipsis = true;
//                     Image = MoveNegativeLines;
//                     Visible = false;

//                     trigger OnAction()
//                     begin
//                         CLEAR(MoveNegPurchLines);
//                         MoveNegPurchLines.SetPurchHeader(Rec);
//                         MoveNegPurchLines.RUNMODAL;
//                         MoveNegPurchLines.ShowDocument;
//                     end;
//                 }
//                 group("Dr&op Shipment")
//                 {
//                     Caption = 'Dr&op Shipment';
//                     Image = Delivery;
//                     Visible = false;
//                     action("Get &Sales Order")
//                     {
//                         Caption = 'Get &Sales Order';
//                         Image = "Order";
//                         RunObject = Codeunit 76;
//                     }
//                 }
//                 group("Speci&al Order")
//                 {
//                     Caption = 'Speci&al Order';
//                     Image = SpecialOrder;
//                     action("Get &Sales Order")
//                     {
//                         Caption = 'Get &Sales Order';
//                         Image = "Order";

//                         trigger OnAction()
//                         var
//                             DistIntegration: Codeunit "5702";
//                             PurchHeader: Record "38";
//                         begin
//                             PurchHeader.COPY(Rec);
//                             DistIntegration.GetSpecialOrders(PurchHeader);
//                             Rec := PurchHeader;
//                         end;
//                     }
//                 }
//                 separator()
//                 {
//                 }
//                 action("Transit Documents")
//                 {
//                     Caption = 'Transit Documents';
//                     Image = TransferOrder;
//                     RunObject = Page 13705;
//                                     RunPageLink = Type=CONST(Purchase),
//                                   PO / SO No.=FIELD(No.),
//                                   Vendor / Customer Ref.=FIELD(Buy-from Vendor No.),
//                                   State=FIELD(State);
//                     Visible = false;
//                 }
//                 action("Deferment Schedule")
//                 {
//                     Caption = 'Deferment Schedule';
//                     Image = Installments;
//                     RunObject = Page 16558;
//                                     RunPageLink = Document No.=FIELD(No.);
//                     Visible = false;
//                 }
//                 action("Attached Gate Entry")
//                 {
//                     Caption = 'Attached Gate Entry';
//                     Image = InwardEntry;
//                     RunObject = Page 16481;
//                                     RunPageLink = Source No.=FIELD(No.),
//                                   Source Type=CONST(Purchase Order),
//                                   Entry Type=CONST(Inward);
//                     Visible = false;
//                 }
//                 action("Detailed &Tax")
//                 {
//                     Caption = 'Detailed &Tax';
//                     Image = TaxDetail;
//                     RunObject = Page 16341;
//                                     RunPageLink = Document Type=FIELD(Document Type),
//                                   Document No.=FIELD(No.),
//                                   Transaction Type=CONST(Purchase);
//                     Visible = false;
//                 }
//                 action("Archive Document")
//                 {
//                     Caption = 'Archi&ve Document';
//                     Image = Archive;

//                     trigger OnAction()
//                     begin
//                         ArchiveManagement.ArchivePurchDocument(Rec);
//                         CurrPage.UPDATE(FALSE);
//                     end;
//                 }
//                 action("Send IC Purchase Order")
//                 {
//                     Caption = 'Send IC Purchase Order';
//                     Image = IntercompanyOrder;
//                     Visible = false;

//                     trigger OnAction()
//                     var
//                         ICInOutboxMgt: Codeunit "427";
//                         SalesHeader: Record "36";
//                         ApprovalMgt: Codeunit "439";
//                     begin
//                         IF ApprovalMgt.PrePostApprovalCheck(SalesHeader,Rec) THEN
//                           ICInOutboxMgt.SendPurchDoc(Rec,FALSE);
//                     end;
//                 }
//                 separator()
//                 {
//                 }
//                 action("Calculate TDS")
//                 {
//                     Caption = 'Calculate TDS';
//                     Image = CalculateVATExemption;

//                     trigger OnAction()
//                     begin
//                         PurchLine.CalculateTDS(Rec);
//                     end;
//                 }
//                 separator()
//                 {
//                 }
//             }
//             group(Approval)
//             {
//                 Caption = 'Approval';
//                 Image = Approval;
//                 group(Approval)
//                 {
//                     Caption = 'Approval';
//                     Image = Approval;
//                     action("Send A&pproval Request")
//                     {
//                         Caption = 'Send A&pproval Request';
//                         Image = SendApprovalRequest;

//                         trigger OnAction()
//                         var
//                             ApprovalMgt: Codeunit "439";
//                         begin
//                             IF ApprovalMgt.SendPurchaseApprovalRequest(Rec) THEN;
//                         end;
//                     }
//                     action("Cancel Approval Re&quest")
//                     {
//                         Caption = 'Cancel Approval Re&quest';
//                         Image = Cancel;

//                         trigger OnAction()
//                         var
//                             ApprovalMgt: Codeunit "439";
//                         begin
//                             IF ApprovalMgt.CancelPurchaseApprovalRequest(Rec,TRUE,TRUE) THEN;
//                         end;
//                     }
//                 }
//             }
//             group(Warehouse)
//             {
//                 Caption = 'Warehouse';
//                 Image = Warehouse;
//                 Visible = false;
//                 action("Create &Whse. Receipt")
//                 {
//                     Caption = 'Create &Whse. Receipt';
//                     Image = NewReceipt;

//                     trigger OnAction()
//                     var
//                         GetSourceDocInbound: Codeunit "5751";
//                     begin
//                         GetSourceDocInbound.CreateFromPurchOrder(Rec);

//                         IF NOT FIND('=><') THEN
//                           INIT;
//                     end;
//                 }
//                 action("Create Inventor&y Put-away / Pick")
//                 {
//                     Caption = 'Create Inventor&y Put-away / Pick';
//                     Ellipsis = true;
//                     Image = CreateInventoryPickup;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     Visible = false;

//                     trigger OnAction()
//                     begin
//                         CreateInvtPutAwayPick;

//                         IF NOT FIND('=><') THEN
//                           INIT;
//                     end;
//                 }
//                 action("Get Gate Entry Lines")
//                 {
//                     Caption = 'Get Gate Entry Lines';
//                     Image = GetLines;

//                     trigger OnAction()
//                     begin
//                         GetGateEntryLines;
//                     end;
//                 }
//                 separator()
//                 {
//                 }
//             }
//             group("P&osting")
//             {
//                 Caption = 'P&osting';
//                 Image = Post;
//                 action(TestSerialNo)
//                 {
//                     Promoted = true;
//                     Visible = false;

//                     trigger OnAction()
//                     begin
//                          DeletePurchSpecification(Rec);
//                          PurchLine.RESET;
//                          PurchLine.SETRANGE("Document Type","Document Type"::Order);
//                          PurchLine.SETFILTER("Document No.","No.");
//                          PurchLine.SETFILTER(PurchLine."Item Serial No",'<>%1','');
//                          IF PurchLine.FINDFIRST THEN BEGIN
//                          REPEAT
//                              UpdateSerialNo(PurchLine);
//                          UNTIL PurchLine.NEXT = 0;
//                          END;
//                     end;
//                 }
//                 action("Calc&ulate Structure Values")
//                 {
//                     Caption = 'Calc&ulate Structure Values';
//                     Image = CalculateHierarchy;

//                     trigger OnAction()
//                     begin
//                         PurchLine.CalculateStructures(Rec);
//                         PurchLine.AdjustStructureAmounts(Rec);
//                         PurchLine.UpdatePurchLines(Rec);
//                     end;
//                 }
//                 action("Serial Details")
//                 {
//                     Caption = 'Serial Details';
//                     Ellipsis = true;
//                     Image = "Report";
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     ShortCutKey = 'F9';

//                     trigger OnAction()
//                     var
//                         PurchasePostViaJobQueue: Codeunit "98";
//                         PurchLine: Record "39";
//                     begin
//                         CLEAR(PODetails);
//                         RecpurcLine12.RESET;
//                         RecpurcLine12.SETFILTER(RecpurcLine12."No.","No.");
//                         IF RecpurcLine12.FINDFIRST THEN
//                         BEGIN
//                         PODetails.SETTABLEVIEW(RecpurcLine12);
//                         PODetails.RUNMODAL;
//                         END;
//                         //Try now
//                     end;
//                 }
//                 action(Post)
//                 {
//                     Caption = 'P&ost';
//                     Ellipsis = true;
//                     Image = PostOrder;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     ShortCutKey = 'F9';

//                     trigger OnAction()
//                     var
//                         PurchasePostViaJobQueue: Codeunit "98";
//                         PurchLine: Record "39";
//                     begin
//                         // Code Shifted on Purchase Line Item Serial No. Validation.
//                          /*
//                          DeletePurchSpecification(Rec);
//                          PurchLine.RESET;
//                          PurchLine.SETRANGE("Document Type","Document Type"::Order);
//                          PurchLine.SETFILTER("Document No.","No.");
//                          PurchLine.SETFILTER(PurchLine."Item Serial No",'<>%1','');
//                          IF PurchLine.FINDFIRST THEN BEGIN
//                          REPEAT
//                              UpdateSerialNo(PurchLine);
//                          UNTIL PurchLine.NEXT = 0;
//                          END;
//                          */
//                          PurchLine.RESET;
//                          PurchLine.SETRANGE("Document Type","Document Type"::Order);
//                          PurchLine.SETFILTER("Document No.","No.");
//                          PurchLine.SETFILTER(Type,'%1',PurchLine.Type::Item);
//                          IF PurchLine.FINDSET THEN BEGIN
//                          REPEAT
//                               IF NOT ReservEntryExistPurchLine(PurchLine) AND ( PurchLine."UPN Code" = '' ) THEN BEGIN
//                                IF (PurchLine."Qty. to Receive" <> 0) OR (PurchLine."Qty. to Invoice" <> 0 ) THEN
//                                 ERROR('Serial No. Or UPN Code required for Item %1',PurchLine."No." );
//                              END;
//                          UNTIL PurchLine.NEXT = 0;
//                          END;
//                           WBU.RefreshStatistics();
//                          Post(CODEUNIT::"Purch.-Post (Yes/No)");

//                     end;
//                 }
//                 action("Post and &Print")
//                 {
//                     Caption = 'Post and &Print';
//                     Ellipsis = true;
//                     Image = PostPrint;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     ShortCutKey = 'Shift+F9';

//                     trigger OnAction()
//                     begin
//                          PurchLine.RESET;
//                          PurchLine.SETRANGE("Document Type","Document Type"::Order);
//                          PurchLine.SETFILTER("Document No.","No.");
//                          PurchLine.SETFILTER(Type,'%1',PurchLine.Type::Item);
//                          IF PurchLine.FINDSET THEN BEGIN
//                          REPEAT
//                               IF NOT ReservEntryExistPurchLine(PurchLine) AND ( PurchLine."UPN Code" = '' ) THEN BEGIN
//                               IF (PurchLine."Qty. to Receive" <> 0) OR (PurchLine."Qty. to Invoice" <> 0 ) THEN
//                                 ERROR('Serial No. Or UPN Code required for Item %1',PurchLine."No." );
//                               END;
//                          UNTIL PurchLine.NEXT = 0;
//                          END;

//                         WBU.RefreshStatistics();
//                         Post(CODEUNIT::"Purch.-Post + Print");
//                     end;
//                 }
//                 action("Test Report")
//                 {
//                     Caption = 'Test Report';
//                     Ellipsis = true;
//                     Image = TestReport;

//                     trigger OnAction()
//                     begin
//                         ReportPrint.PrintPurchHeader(Rec);
//                     end;
//                 }
//                 action("Post &Batch")
//                 {
//                     Caption = 'Post &Batch';
//                     Ellipsis = true;
//                     Image = PostBatch;
//                     Visible = false;

//                     trigger OnAction()
//                     begin
//                         REPORT.RUNMODAL(REPORT::"Batch Post Purchase Orders",TRUE,TRUE,Rec);
//                         CurrPage.UPDATE(FALSE);
//                     end;
//                 }
//                 action("Print Deferment Schedule")
//                 {
//                     Caption = 'Print Deferment Schedule';
//                     Image = PrintInstallments;
//                     Visible = false;

//                     trigger OnAction()
//                     begin
//                         DefermentBuffer.RESET;
//                         DefermentBuffer.SETRANGE("Document No.","No.");
//                         REPORT.RUNMODAL(16543,TRUE,TRUE,DefermentBuffer);
//                     end;
//                 }
//                 action("Remove From Job Queue")
//                 {
//                     Caption = 'Remove From Job Queue';
//                     Image = RemoveLine;
//                     Visible = false;

//                     trigger OnAction()
//                     begin
//                         CancelBackgroundPosting;
//                     end;
//                 }
//                 separator()
//                 {
//                 }
//                 group("Prepa&yment")
//                 {
//                     Caption = 'Prepa&yment';
//                     Image = Prepayment;
//                     Visible = false;
//                     action("Prepayment Test &Report")
//                     {
//                         Caption = 'Prepayment Test &Report';
//                         Ellipsis = true;
//                         Image = PrepaymentSimulation;

//                         trigger OnAction()
//                         begin
//                             ReportPrint.PrintPurchHeaderPrepmt(Rec);
//                         end;
//                     }
//                     action(PostPrepaymentInvoice)
//                     {
//                         Caption = 'Post Prepayment &Invoice';
//                         Ellipsis = true;
//                         Image = PrepaymentPost;

//                         trigger OnAction()
//                         var
//                             SalesHeader: Record "36";
//                             ApprovalMgt: Codeunit "439";
//                             PurchPostYNPrepmt: Codeunit "445";
//                         begin
//                             IF ApprovalMgt.PrePostApprovalCheck(SalesHeader,Rec) THEN
//                               PurchPostYNPrepmt.PostPrepmtInvoiceYN(Rec,FALSE);
//                         end;
//                     }
//                     action("Post and Print Prepmt. Invoic&e")
//                     {
//                         Caption = 'Post and Print Prepmt. Invoic&e';
//                         Ellipsis = true;
//                         Image = PrepaymentPostPrint;
//                         Visible = false;

//                         trigger OnAction()
//                         var
//                             SalesHeader: Record "36";
//                             ApprovalMgt: Codeunit "439";
//                             PurchPostYNPrepmt: Codeunit "445";
//                         begin
//                             IF ApprovalMgt.PrePostApprovalCheck(SalesHeader,Rec) THEN
//                               PurchPostYNPrepmt.PostPrepmtInvoiceYN(Rec,TRUE);
//                         end;
//                     }
//                     action(PostPrepaymentCreditMemo)
//                     {
//                         Caption = 'Post Prepayment &Credit Memo';
//                         Ellipsis = true;
//                         Image = PrepaymentPost;

//                         trigger OnAction()
//                         var
//                             SalesHeader: Record "36";
//                             ApprovalMgt: Codeunit "439";
//                             PurchPostYNPrepmt: Codeunit "445";
//                         begin
//                             IF ApprovalMgt.PrePostApprovalCheck(SalesHeader,Rec) THEN
//                               PurchPostYNPrepmt.PostPrepmtCrMemoYN(Rec,FALSE);
//                         end;
//                     }
//                     action("Post and Print Prepmt. Cr. Mem&o")
//                     {
//                         Caption = 'Post and Print Prepmt. Cr. Mem&o';
//                         Ellipsis = true;
//                         Image = PrepaymentPostPrint;

//                         trigger OnAction()
//                         var
//                             SalesHeader: Record "36";
//                             ApprovalMgt: Codeunit "439";
//                             PurchPostYNPrepmt: Codeunit "445";
//                         begin
//                             IF ApprovalMgt.PrePostApprovalCheck(SalesHeader,Rec) THEN
//                               PurchPostYNPrepmt.PostPrepmtCrMemoYN(Rec,TRUE);
//                         end;
//                     }
//                 }
//             }
//             group(Print)
//             {
//                 Caption = 'Print';
//                 Image = Print;
//                 action("&Print")
//                 {
//                     Caption = '&Print';
//                     Ellipsis = true;
//                     Image = Print;
//                     Promoted = true;
//                     PromotedCategory = Process;

//                     trigger OnAction()
//                     begin
//                         DocPrint.PrintPurchHeader(Rec);
//                     end;
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         JobQueueVisible := "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting";
//     end;

//     trigger OnDeleteRecord(): Boolean
//     begin
//         CurrPage.SAVERECORD;
//         EXIT(ConfirmDeletion);
//     end;

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         "Responsibility Center" := UserMgt.GetPurchasesFilter;
//     end;

//     trigger OnOpenPage()
//     begin
//         IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
//           FILTERGROUP(2);
//           SETRANGE("Responsibility Center",UserMgt.GetPurchasesFilter);
//           FILTERGROUP(0);
//           SETFILTER("Location Code","Location Code");
//         END;
//     end;

//     var
//         PurchSetup: Record "312";
//         ChangeExchangeRate: Page "511";
//                                 CopyPurchDoc: Report "492";
//                                 MoveNegPurchLines: Report "6698";
//                                 ReportPrint: Codeunit "228";
//                                 DocPrint: Codeunit "229";
//                                 UserMgt: Codeunit "5700";
//                                 ArchiveManagement: Codeunit "5063";
//                                 PurchLine: Record "39";
//                                 DefermentBuffer: Record "16532";
//     [InDataSet]

//     JobQueueVisible: Boolean;
//     BillAmtCalc: Decimal;
//     PurchLineRec11: Record "39";
//     DiffAmt: Decimal;
//     Text060: Label 'Vendor Invoice Value %1 it must be equal to %2 & Difference is %3';
//     TrackingSpecification: Record "336";
//     ItemTackingLine: Page "6510";
//     ReservEntry: Record "337";
//     CreateReservEntry: Codeunit "99000830";
//     WBU: Codeunit "50000";
//     ReservePurchLine: Codeunit "99000834";
//     RecpurcLine12: Record "38";
//     PODetails: Report "50030";

// local procedure Post(PostingCodeunitID: Integer)
//     begin
//         SendToPosting(PostingCodeunitID);
//         IF "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting" THEN
//           CurrPage.CLOSE;
//         CurrPage.UPDATE(FALSE);
//     end;

//     local procedure ApproveCalcInvDisc()
//     begin
//         CurrPage.PurchLines.PAGE.ApproveCalcInvDisc;
//     end;

//     local procedure BuyfromVendorNoOnAfterValidate()
//     begin
//         IF GETFILTER("Buy-from Vendor No.") = xRec."Buy-from Vendor No." THEN
//           IF "Buy-from Vendor No." <> xRec."Buy-from Vendor No." THEN
//             SETRANGE("Buy-from Vendor No.");
//         CurrPage.UPDATE;
//     end;

//     local procedure PurchaserCodeOnAfterValidate()
//     begin
//         CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
//     end;

//     local procedure PaytoVendorNoOnAfterValidate()
//     begin
//         CurrPage.UPDATE;
//     end;

//     local procedure ShortcutDimension1CodeOnAfterV()
//     begin
//         CurrPage.UPDATE;
//     end;

//     local procedure ShortcutDimension2CodeOnAfterV()
//     begin
//         CurrPage.UPDATE;
//     end;

//     local procedure PricesIncludingVATOnAfterValid()
//     begin
//         CurrPage.UPDATE;
//     end;

//     local procedure Prepayment37OnAfterValidate()
//     begin
//         CurrPage.UPDATE;
//     end;

//     [Scope('Internal')]
//     procedure UpdateSerialNo(PurchLine: Record "39")
//     begin
//         //ReservEntry.INIT;
//         //ReservEntry."Source Type" := DATABASE::"Purchase Line";
//         WITH PurchLine DO BEGIN
//           /*
//           ReservEntry.INIT;
//           ReservEntry."Item No." := "No.";
//           ReservEntry."Location Code" := "Location Code";
//           ReservEntry.Description := Description;
//           ReservEntry."Variant Code" := "Variant Code";
//           ReservEntry."Source Subtype" := "Document Type";
//           ReservEntry."Source ID" := "Document No.";
//           ReservEntry."Source Batch Name" := '';
//           ReservEntry."Source Prod. Order Line" := 0;
//           ReservEntry."Source Ref. No." := "Line No.";
//           ReservEntry."Quantity (Base)" := "Quantity (Base)";
//           ReservEntry."Qty. to Invoice (Base)" := "Qty. to Invoice (Base)";
//           ReservEntry."Qty. to Handle (Base)" := "Quantity (Base)";
//           ReservEntry."Quantity Invoiced (Base)" := "Qty. Invoiced (Base)";
//           ReservEntry."Qty. per Unit of Measure" := "Qty. per Unit of Measure";
//           ReservEntry."Serial No." := PurchLine."Item Serial No";
//           ReservEntry.Positive := TRUE;
//           ReservEntry.INSERT;
//           */
//               CreateReservEntry.CreateReservEntryFor(
//                 DATABASE::"Purchase Line","Document Type","Document No.",'',0,"Line No.","Qty. per Unit of Measure",0,"Quantity (Base)","Item Serial No",'');

//             CreateReservEntry.CreateEntry("No.","Variant Code","Location Code",Description,"Expected Receipt Date",0D,0,ReservEntry."Reservation Status"::Surplus);
//         END;

//     end;

//     [Scope('Internal')]
//     procedure DeletePurchSpecification(PurchHeader: Record "38")
//     begin
//         //ItemTrackingForm.SetSource(ReservEntry,PurchLine."Expected Receipt Date");
//         //ItemTrackingForm.SetInbound(PurchLine.IsInbound);
//         //ItemTrackingForm.RUNMODAL;
//         /*
//         ReservEntry.SETCURRENTKEY("Source ID","Source Type",
//           "Source Subtype","Source Batch Name","Source Prod. Order Line","Source Ref. No.");
//         ReservEntry.SETRANGE("Source ID",PurchHeader."No.");
//         ReservEntry.SETRANGE("Source Type",DATABASE::"Purchase Line");
//         ReservEntry.SETRANGE("Source Subtype",PurchHeader."Document Type");
//         ReservEntry.SETRANGE("Source Batch Name",'');
//         ReservEntry.SETRANGE("Source Prod. Order Line",0);
//         //ReservEntry.SETRANGE("Source Ref. No.",PurchLine."Line No.");
//         IF ReservEntry.FINDSET THEN
//           REPEAT
//             ReservEntry.DELETE;
//           UNTIL ReservEntry.NEXT = 0;
//          */
//         ReservEntry.SETCURRENTKEY(
//           "Source ID","Source Ref. No.","Source Type","Source Subtype",
//           "Source Batch Name","Source Prod. Order Line","Reservation Status",
//           "Shipment Date","Expected Receipt Date");
//         ReservEntry.SETRANGE("Source ID",PurchHeader."No.");
//         //ReservEntry.SETRANGE("Source Ref. No.",ReservEntry."Source Ref. No.");
//         ReservEntry.SETRANGE("Source Type",DATABASE::"Purchase Line");
//         ReservEntry.SETRANGE("Source Subtype",PurchHeader."Document Type");
//         ReservEntry.SETRANGE("Source Batch Name",'');
//         ReservEntry.SETRANGE("Source Prod. Order Line",0);
//         IF ReservEntry.FINDSET THEN
//           REPEAT
//             ReservEntry.DELETE;
//           UNTIL ReservEntry.NEXT = 0;

//     end;

//     [Scope('Internal')]
//     procedure ReservEntryExistPurchLine(PurchLine: Record "39"): Boolean
//     var
//         NewReservEntry: Record "337";
//     begin
//         ReservEntry.RESET;
//         ReservEntry.SETRANGE("Source ID",PurchLine."Document No.");
//         ReservEntry.SETRANGE("Source Ref. No.",PurchLine."Line No.");
//         ReservEntry.SETRANGE("Source Type",DATABASE::"Purchase Line");
//         ReservEntry.SETRANGE("Source Subtype",PurchLine."Document Type");
//         ReservEntry.SETRANGE("Source Batch Name",'');
//         ReservEntry.SETRANGE("Source Prod. Order Line",0);
//         EXIT(ReservEntry.FINDSET);
//     end;
// }

