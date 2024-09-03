// page 50040 "Posted Retail Sales Invoice"
// {
//     Caption = 'Posted Sales Invoice';
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     ModifyAllowed = false;
//     PageType = Document;
//     Permissions = TableData 112 = rm;
//     RefreshOnActivate = true;
//     SourceTable = Table112;

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field("No."; "No.")
//                 {
//                     Editable = false;
//                     Importance = Promoted;
//                 }
//                 field("Sales Order Type"; "Sales Order Type")
//                 {
//                     Visible = false;
//                 }
//                 field("Sell-to Customer No."; "Sell-to Customer No.")
//                 {
//                     Editable = false;
//                     Importance = Promoted;
//                 }
//                 field("Cust. Mobile No."; "Cust. Mobile No.")
//                 {
//                 }
//                 field("Cust. email ID"; "Cust. email ID")
//                 {
//                 }
//                 field("Sell-to Customer Name"; "Sell-to Customer Name")
//                 {
//                     Editable = false;
//                 }
//                 field(Structure; Structure)
//                 {
//                     Editable = false;
//                     Importance = Promoted;
//                     Visible = false;
//                 }
//                 field("Posting Date"; "Posting Date")
//                 {
//                     Editable = false;
//                     Importance = Promoted;
//                 }
//                 field("Order No."; "Order No.")
//                 {
//                     Editable = false;
//                     Importance = Promoted;
//                 }
//                 field("Ref. Invoice No."; "Ref. Invoice No.")
//                 {
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field("Buyer's Order No."; "Buyer's Order No.")
//                 {
//                 }
//                 field("Buyer's Order Dt"; "Buyer's Order Dt")
//                 {
//                 }
//                 field(TotalPayByCustomer; TotalPayByCustomer)
//                 {
//                 }
//                 field("Amount to Customer"; "Amount to Customer")
//                 {
//                 }
//                 group(Payment)
//                 {
//                     Caption = 'Payment';
//                     Editable = false;
//                     field(PayByCashAmt; PayByCashAmt)
//                     {
//                     }
//                     field(PayByChqNo; PayByChqNo)
//                     {
//                     }
//                     field(PayByChqDt; PayByChqDt)
//                     {
//                     }
//                     field(PayByChqAmt; PayByChqAmt)
//                     {
//                     }
//                     field("CreditCdPay Method Code1"; "CreditCdPay Method Code1")
//                     {
//                         Caption = 'Credit Card Payment Method';
//                         Editable = false;
//                     }
//                     field(CreditCardNo1; CreditCardNo1)
//                     {
//                         Caption = 'Credit Card No.';
//                         Editable = false;
//                     }
//                     field(PayByCreditNo1; PayByCreditNo1)
//                     {
//                         Caption = 'Credit Card machine Name';
//                     }
//                     field(PayByCreditAmt1; PayByCreditAmt1)
//                     {
//                         Caption = 'Credit Card Amount';
//                     }
//                     field("Maple Buyback Amt"; "Maple Buyback Amt")
//                     {
//                         Caption = 'Buyback Amount';
//                         Editable = false;
//                     }
//                     field("Apple Buyback Amt"; "Apple Buyback Amt")
//                     {
//                         Editable = false;
//                         Visible = false;
//                     }
//                     field("Apple Refund Amt"; "Apple Refund Amt")
//                     {
//                     }
//                 }
//             }
//             group("Additional Payments")
//             {
//                 Caption = 'Additional Payments';
//                 Editable = false;
//                 field("CreditCdPay Method Code2"; "CreditCdPay Method Code2")
//                 {
//                     Caption = 'Credit Card Payment Method';
//                     Editable = false;
//                 }
//                 field(CreditCardNo2; CreditCardNo2)
//                 {
//                     Caption = 'Credit Card No.';
//                     Editable = false;
//                 }
//                 field(PayByCreditNo2; PayByCreditNo2)
//                 {
//                     Caption = 'Credit Card machine Name';
//                 }
//                 field(PayByCreditAmt2; PayByCreditAmt2)
//                 {
//                     Caption = 'Credit Card Amount';
//                 }
//                 field("CreditCdPay Method Code3"; "CreditCdPay Method Code3")
//                 {
//                     Caption = 'Credit Card Payment Method';
//                     Editable = false;
//                 }
//                 field(CreditCardNo3; CreditCardNo3)
//                 {
//                     Caption = 'Credit Card No.';
//                     Editable = false;
//                 }
//                 field(PayByCreditNo3; PayByCreditNo3)
//                 {
//                     Caption = 'Credit Card machine Name';
//                 }
//                 field(PayByCreditAmt3; PayByCreditAmt3)
//                 {
//                     Caption = 'Credit Card Amount';
//                 }
//                 field("CreditCdPay Method Code4"; "CreditCdPay Method Code4")
//                 {
//                     Caption = 'Credit Card Payment Method';
//                     Editable = false;
//                 }
//                 field(CreditCardNo4; CreditCardNo4)
//                 {
//                     Caption = 'Credit Card No.';
//                     Editable = false;
//                 }
//                 field(PayByCreditNo4; PayByCreditNo4)
//                 {
//                     Caption = 'Credit Card machine Name';
//                 }
//                 field(PayByCreditAmt4; PayByCreditAmt4)
//                 {
//                     Caption = 'Credit Card Amount';
//                 }
//                 field("DebitCdPay Method Code2"; "DebitCdPay Method Code2")
//                 {
//                     Caption = 'Credit Card Payment Method';
//                     Editable = false;
//                 }
//                 field(DebitCardNo2; DebitCardNo2)
//                 {
//                     Caption = 'Credit Card No.';
//                     Editable = false;
//                 }
//                 field(PayByDebitNo2; PayByDebitNo2)
//                 {
//                     Caption = 'Credit Card machine Name';
//                     Editable = false;
//                 }
//                 field(PayByDebitAmt2; PayByDebitAmt2)
//                 {
//                     Caption = 'Credit Card Amount';
//                     Editable = false;
//                 }
//                 field(PayByDebitCdNo1; PayByDebitCdNo1)
//                 {
//                     Caption = 'Debit Card No.';
//                 }
//                 field(PayByDebitCdAmt1; PayByDebitCdAmt1)
//                 {
//                     Caption = 'Debit Card Amount';
//                 }
//                 field("RTGS Ref. No."; "RTGS Ref. No.")
//                 {
//                 }
//                 field("RTGS Bank Name"; "RTGS Bank Name")
//                 {
//                 }
//                 field(GiftVoucherAmt; GiftVoucherAmt)
//                 {
//                 }
//                 field("RTGS Amount"; "RTGS Amount")
//                 {
//                 }
//                 field("Finance Comapny"; "Finance Comapny")
//                 {
//                 }
//                 field("Bank Approval Code"; "Bank Approval Code")
//                 {
//                 }
//                 field("Finance Amount"; "Finance Amount")
//                 {
//                 }
//             }
//             part(SalesInvLines; 50041)
//             {
//                 SubPageLink = Document No.=FIELD(No.);
//             }
//             group("Purchase Details")
//             {
//                 Caption = 'Purchase Details';
//                 Editable = false;
//                 Enabled = true;
//                 Visible = false;
//                 field("Vendor No."; "Vendor No.")
//                 {
//                 }
//                 field("Inward Location"; "Inward Location")
//                 {
//                 }
//                 field("Vendor Item"; "Vendor Item")
//                 {
//                 }
//                 field("Purchase Amount"; PurchaseAmount)
//                 {
//                     Enabled = true;
//                 }
//             }
//             group("Third Party Sales Details")
//             {
//                 Caption = 'Third Party Sales Details';
//                 Editable = false;
//                 Visible = false;
//                 field("Party No"; "Party No")
//                 {
//                 }
//                 field("Party Name"; "Party Name")
//                 {
//                 }
//                 field("Party Sales Location"; "Party Sales Location")
//                 {
//                 }
//                 field("Party Address"; "Party Address")
//                 {
//                 }
//                 field("Party City"; "Party City")
//                 {
//                 }
//                 field("Party Item"; "Vendor Item")
//                 {
//                     Caption = 'Party item';
//                 }
//                 field("Party item Price"; "Party Item Price")
//                 {
//                     Caption = 'Party Item Price';
//                 }
//             }
//             group(Invoicing)
//             {
//                 Caption = 'Invoicing';
//                 Visible = false;
//                 field("Bill-to Customer No."; "Bill-to Customer No.")
//                 {
//                     Editable = false;
//                     Importance = Promoted;
//                 }
//                 field("Bill-to Contact No."; "Bill-to Contact No.")
//                 {
//                     Editable = false;
//                 }
//                 field("Bill-to Name"; "Bill-to Name")
//                 {
//                     Editable = false;
//                 }
//                 field("Bill-to Address"; "Bill-to Address")
//                 {
//                     Editable = false;
//                 }
//                 field("Bill-to Address 2"; "Bill-to Address 2")
//                 {
//                     Editable = false;
//                 }
//                 field("Bill-to Post Code"; "Bill-to Post Code")
//                 {
//                     Editable = false;
//                 }
//                 field("Bill-to City"; "Bill-to City")
//                 {
//                     Editable = false;
//                 }
//                 field("Bill-to Contact"; "Bill-to Contact")
//                 {
//                     Editable = false;
//                 }
//                 field("Form Code"; "Form Code")
//                 {
//                     Editable = false;
//                 }
//                 field("Form No."; "Form No.")
//                 {
//                 }
//                 field("Calc. Inv. Discount (%)"; "Calc. Inv. Discount (%)")
//                 {
//                 }
//                 field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
//                 {
//                     Editable = false;
//                 }
//                 field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
//                 {
//                     Editable = false;
//                 }
//                 field("Payment Terms Code"; "Payment Terms Code")
//                 {
//                     Editable = false;
//                     Importance = Promoted;
//                 }
//                 field("Due Date"; "Due Date")
//                 {
//                     Editable = false;
//                     Importance = Promoted;
//                 }
//                 field("Payment Discount %"; "Payment Discount %")
//                 {
//                     Editable = false;
//                 }
//                 field("Pmt. Discount Date"; "Pmt. Discount Date")
//                 {
//                     Editable = false;
//                 }
//                 field("Payment Method Code"; "Payment Method Code")
//                 {
//                     Editable = false;
//                 }
//                 field("Credit Card No."; "Credit Card No.")
//                 {
//                     Editable = false;
//                 }
//                 field(GetCreditcardNumber; GetCreditcardNumber)
//                 {
//                     Caption = 'Cr. Card Number (Last 4 Digits)';
//                     Editable = false;
//                 }
//                 field("LC No."; "LC No.")
//                 {
//                     Editable = false;
//                 }
//                 field("Export or Deemed Export"; "Export or Deemed Export")
//                 {
//                     Editable = false;
//                 }
//                 field("VAT Exempted"; "VAT Exempted")
//                 {
//                     Editable = false;
//                 }
//             }
//             group(Shipping)
//             {
//                 Caption = 'Shipping';
//                 Visible = false;
//                 field("Ship-to Code"; "Ship-to Code")
//                 {
//                     Editable = false;
//                     Importance = Promoted;
//                 }
//                 field("Ship-to Name"; "Ship-to Name")
//                 {
//                     Editable = false;
//                 }
//                 field("Ship-to Address"; "Ship-to Address")
//                 {
//                     Editable = false;
//                 }
//                 field("Ship-to Address 2"; "Ship-to Address 2")
//                 {
//                     Editable = false;
//                 }
//                 field("Ship-to Post Code"; "Ship-to Post Code")
//                 {
//                     Editable = false;
//                     Importance = Promoted;
//                 }
//                 field("Ship-to City"; "Ship-to City")
//                 {
//                     Editable = false;
//                 }
//                 field("Ship-to Contact"; "Ship-to Contact")
//                 {
//                     Editable = false;
//                 }
//                 field("Location Code"; "Location Code")
//                 {
//                     Editable = false;
//                 }
//                 field("Shipment Method Code"; "Shipment Method Code")
//                 {
//                     Editable = false;
//                 }
//                 field("Shipment Date"; "Shipment Date")
//                 {
//                     Editable = false;
//                     Importance = Promoted;
//                 }
//             }
//             group("Foreign Trade")
//             {
//                 Caption = 'Foreign Trade';
//                 Visible = false;
//                 field("Currency Code"; "Currency Code")
//                 {
//                     Importance = Promoted;

//                     trigger OnAssistEdit()
//                     begin
//                         ChangeExchangeRate.SetParameter("Currency Code", "Currency Factor", "Posting Date");
//                         ChangeExchangeRate.EDITABLE(FALSE);
//                         IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
//                             "Currency Factor" := ChangeExchangeRate.GetParameter;
//                             MODIFY;
//                         END;
//                         CLEAR(ChangeExchangeRate);
//                     end;
//                 }
//                 field("EU 3-Party Trade"; "EU 3-Party Trade")
//                 {
//                     Editable = false;
//                 }
//             }
//         }
//         area(factboxes)
//         {
//             systempart(; Links)
//             {
//                 Visible = false;
//             }
//             systempart(; Notes)
//             {
//                 Visible = false;
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group("&Invoice")
//             {
//                 Caption = '&Invoice';
//                 Image = Invoice;
//                 action(Statistics)
//                 {
//                     Caption = 'Statistics';
//                     Image = Statistics;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     RunObject = Page 397;
//                     RunPageLink = No.=FIELD(No.);
//                     ShortCutKey = 'F7';
//                 }
//                 action("Co&mments")
//                 {
//                     Caption = 'Co&mments';
//                     Image = ViewComments;
//                     RunObject = Page 67;
//                                     RunPageLink = Document Type=CONST(Posted Invoice),
//                                   No.=FIELD(No.),
//                                   Document Line No.=CONST(0);
//                 }
//                 action(Dimensions)
//                 {
//                     Caption = 'Dimensions';
//                     Image = Dimensions;
//                     ShortCutKey = 'Shift+Ctrl+D';

//                     trigger OnAction()
//                     begin
//                         ShowDimensions;
//                     end;
//                 }
//                 action(Approvals)
//                 {
//                     Caption = 'Approvals';
//                     Image = Approvals;

//                     trigger OnAction()
//                     var
//                         PostedApprovalEntries: Page "659";
//                     begin
//                         PostedApprovalEntries.Setfilters(DATABASE::"Sales Invoice Header","No.");
//                         PostedApprovalEntries.RUN;
//                     end;
//                 }
//                 separator()
//                 {
//                 }
//                 action("Credit Cards Transaction Lo&g Entries")
//                 {
//                     Caption = 'Credit Cards Transaction Lo&g Entries';
//                     Image = CreditCardLog;
//                     RunObject = Page 829;
//                                     RunPageLink = Document Type=CONST(Payment),
//                                   Document No.=FIELD(No.),
//                                   Customer No.=FIELD(Bill-to Customer No.);
//                 }
//                 action("St&ructure")
//                 {
//                     Caption = 'St&ructure';
//                     Image = Hierarchy;
//                     RunObject = Page 16308;
//                                     RunPageLink = Type=CONST(Sale),
//                                   No.=FIELD(No.),
//                                   Structure Code=FIELD(Structure),
//                                   Document Line No.=FILTER(0);
//                 }
//                 action("Third Party Invoices")
//                 {
//                     Caption = 'Third Party Invoices';
//                     Image = Invoice;
//                     RunObject = Page 16307;
//                                     RunPageLink = Type=CONST(Sale),
//                                   Invoice No.=FIELD(No.);
//                 }
//             }
//             group("&Line")
//             {
//                 Caption = '&Line';
//                 Image = Line;
//                 separator()
//                 {
//                 }
//                 action(Structure)
//                 {
//                     Caption = 'Structure';
//                     Image = Hierarchy;

//                     trigger OnAction()
//                     begin
//                         CurrPage.SalesInvLines.PAGE.ShowStrOrderDetailsPITForm;
//                     end;
//                 }
//             }
//         }
//         area(processing)
//         {
//             group("F&unctions")
//             {
//                 Caption = 'F&unctions';
//                 Image = "Action";
//             }
//             group("&Print")
//             {
//                 Caption = '&Print';
//                 Image = Print;
//                 action("Print Invoice")
//                 {
//                     Caption = 'Print Invoice';
//                     Image = Print;

//                     trigger OnAction()
//                     begin
//                         CurrPage.SETSELECTIONFILTER(SalesInvHeader);
//                         SalesInvHeader.PrintRecords(TRUE);
//                     end;
//                 }
//                 action("Print Tax Invoice")
//                 {
//                     Caption = 'Print Tax Invoice';
//                     Image = PrintVAT;

//                     trigger OnAction()
//                     begin
//                         SalesInvHeader.RESET;
//                         SalesInvHeader.SETRANGE("No.","No.");
//                         REPORT.RUNMODAL(REPORT::"Tax Invoice",TRUE,TRUE,SalesInvHeader);
//                     end;
//                 }
//                 action("Print Trading Invoice")
//                 {
//                     Caption = 'Print Trading Invoice';
//                     Image = PrintVoucher;

//                     trigger OnAction()
//                     var
//                         TradingInvoiceReport: Report "16555";
//                     begin
//                         CLEAR(TradingInvoiceReport);
//                         SalesInvHeader.RESET;
//                         SalesInvHeader.SETRANGE("No.","No.");
//                         SalesInvHeader.FINDFIRST;
//                         TradingInvoiceReport.SETTABLEVIEW(SalesInvHeader);
//                         TradingInvoiceReport.SetCustomerNo(SalesInvHeader."Sell-to Customer No.",SalesInvHeader."Ship-to Code");
//                         TradingInvoiceReport.RUNMODAL;
//                     end;
//                 }
//                 action("Print Excise Invoice")
//                 {
//                     Caption = 'Print Excise Invoice';
//                     Image = PrintExcise;

//                     trigger OnAction()
//                     var
//                         RepExciseInvoice: Report "16593";
//                                               Text001: Label 'Record not found.';
//                     begin
//                         CLEAR(RepExciseInvoice);
//                         SalesInvHeader.RESET;
//                         SalesInvHeader.SETRANGE("No.","No.");
//                         IF SalesInvHeader.FINDFIRST THEN BEGIN
//                           RepExciseInvoice.SETTABLEVIEW(SalesInvHeader);
//                           RepExciseInvoice.RUNMODAL;
//                         END ELSE
//                           ERROR(Text001);
//                     end;
//                 }
//             }
//             action("&Navigate")
//             {
//                 Caption = '&Navigate';
//                 Image = Navigate;
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     Navigate;
//                 end;
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         IF BuyBackType = BuyBackType::Apple THEN
//           PurchaseAmount:= "Apple Buyback Amt"
//         ELSE
//           PurchaseAmount:= "Maple Buyback Amt";
//     end;

//     trigger OnOpenPage()
//     begin
//         SetSecurityFilterOnRespCenter;
//     end;

//     var
//         SalesInvHeader: Record "112";
//         ChangeExchangeRate: Page "511";
//                                 PurchaseAmount: Decimal;
// }

