page 50200 "VBA SIH"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Sales Invoice Header";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'Specifies the number of the customer the invoice concerns.';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the record.';
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ToolTip = 'Specifies the number of the customer that you send or sent the invoice or credit memo to.';
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    ToolTip = 'Specifies the name of the customer that the invoice was sent to.';
                }
                field("Bill-to Name 2"; Rec."Bill-to Name 2")
                {
                    ToolTip = 'Specifies the value of the Bill-to Name 2 field.';
                }
                field("Bill-to Address"; Rec."Bill-to Address")
                {
                    ToolTip = 'Specifies the address of the customer that the invoice was sent to.';
                }
                field("Bill-to Address 2"; Rec."Bill-to Address 2")
                {
                    ToolTip = 'Specifies additional address information.';
                }
                field("Bill-to City"; Rec."Bill-to City")
                {
                    ToolTip = 'Specifies the city of the customer on the sales document.';
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    ToolTip = 'Specifies the name of the person you regularly contact when you communicate with the customer to whom the invoice was sent.';
                }
                field("Your Reference"; Rec."Your Reference")
                {
                    ToolTip = 'Specifies the customer''s reference. The contents will be printed on sales documents.';
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ToolTip = 'Specifies the address on purchase orders shipped with a drop shipment directly from the vendor to a customer.';
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ToolTip = 'Specifies the name of the customer that the items were shipped to.';
                }
                field("Ship-to Name 2"; Rec."Ship-to Name 2")
                {
                    ToolTip = 'Specifies the value of the Ship-to Name 2 field.';
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ToolTip = 'Specifies the address that the items on the invoice were shipped to.';
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    ToolTip = 'Specifies additional address information.';
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ToolTip = 'Specifies the city of the customer on the sales document.';
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ToolTip = 'Specifies the name of the person you regularly contact at the address that the items were shipped to.';
                }
                field("Order Date"; Rec."Order Date")
                {
                    ToolTip = 'Specifies the value of the Order Date field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the date on which the invoice was posted.';
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ToolTip = 'Specifies when items on the document are shipped or were shipped. A shipment date is usually calculated from a requested delivery date plus lead time.';
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ToolTip = 'Specifies any text that is entered to accompany the posting, for example for information to auditors.';
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ToolTip = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount on the sales document.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ToolTip = 'Specifies when the posted sales invoice must be paid.';
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ToolTip = 'Specifies the payment discount percent granted if payment is made on or before the date in the Pmt. Discount Date field.';
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    ToolTip = 'Specifies the date on which the amount in the entry must be paid for a payment discount to be granted.';
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ToolTip = 'Specifies the code that represents the shipment method for the invoice.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the code for the location from which the items were shipped.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    ToolTip = 'Specifies the customer''s market type to link business transactions to.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the currency code of the invoice.';
                }
                field("Currency Factor"; Rec."Currency Factor")
                {
                    ToolTip = 'Specifies the value of the Currency Factor field.';
                }
                field("Customer Price Group"; Rec."Customer Price Group")
                {
                    ToolTip = 'Specifies the value of the Customer Price Group field.';
                }
                field("Prices Including VAT"; Rec."Prices Including VAT")
                {
                    ToolTip = 'Specifies the value of the Prices Including VAT field.';
                }
                field("Invoice Disc. Code"; Rec."Invoice Disc. Code")
                {
                    ToolTip = 'Specifies the value of the Invoice Disc. Code field.';
                }
                field("Customer Disc. Group"; Rec."Customer Disc. Group")
                {
                    ToolTip = 'Specifies the value of the Customer Disc. Group field.';
                }
                field("Language Code"; Rec."Language Code")
                {
                    ToolTip = 'Specifies the value of the Language Code field.';
                }
                field("Format Region"; Rec."Format Region")
                {
                    ToolTip = 'Specifies the value of the Format Region field.';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ToolTip = 'Specifies which salesperson is associated with the invoice.';
                }
                field("Order No."; Rec."Order No.")
                {
                    ToolTip = 'Specifies the number of the sales order that this invoice was posted from.';
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.';
                }
                field("No. Printed"; Rec."No. Printed")
                {
                    ToolTip = 'Specifies how many times the document has been printed.';
                }
                field("On Hold"; Rec."On Hold")
                {
                    ToolTip = 'Specifies the value of the On Hold field.';
                }
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    ToolTip = 'Specifies the value of the Applies-to Doc. Type field.';
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                    ToolTip = 'Specifies the value of the Applies-to Doc. No. field.';
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                    ToolTip = 'Specifies the value of the Bal. Account No. field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the total amount on the sales invoice excluding VAT.';
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ToolTip = 'Specifies the total amount on the sales invoice including VAT.';
                }
                field("VAT Registration No."; Rec."VAT Registration No.")
                {
                    ToolTip = 'Specifies the customer''s VAT registration number for customers.';
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ToolTip = 'Specifies the value of the Reason Code field.';
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ToolTip = 'Specifies the value of the Gen. Bus. Posting Group field.';
                }
                field("EU 3-Party Trade"; Rec."EU 3-Party Trade")
                {
                    ToolTip = 'Specifies whether the invoice was part of an EU 3-party trade transaction.';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Type field.';
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ToolTip = 'Specifies the transport method of the sales header that this line was posted from.';
                }
                field("VAT Country/Region Code"; Rec."VAT Country/Region Code")
                {
                    ToolTip = 'Specifies the value of the VAT Country/Region Code field.';
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ToolTip = 'Specifies the customer''s name.';
                }
                field("Sell-to Customer Name 2"; Rec."Sell-to Customer Name 2")
                {
                    ToolTip = 'Specifies the value of the Sell-to Customer Name 2 field.';
                }
                field("Sell-to Address"; Rec."Sell-to Address")
                {
                    ToolTip = 'Specifies the address where the customer is located.';
                }
                field("Sell-to Address 2"; Rec."Sell-to Address 2")
                {
                    ToolTip = 'Specifies additional address information.';
                }
                field("Sell-to City"; Rec."Sell-to City")
                {
                    ToolTip = 'Specifies the address city.';
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    ToolTip = 'Specifies the name of the contact person at the customer the invoice was sent to.';
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    ToolTip = 'Specifies the postal code.';
                }
                field("Bill-to County"; Rec."Bill-to County")
                {
                    ToolTip = 'Specifies the state, province or county as a part of the address.';
                }
                field("Bill-to Country/Region Code"; Rec."Bill-to Country/Region Code")
                {
                    ToolTip = 'Specifies the country or region of the address.';
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    ToolTip = 'Specifies the postal code.';
                }
                field("Sell-to County"; Rec."Sell-to County")
                {
                    ToolTip = 'Specifies the address county.';
                }
                field("Sell-to Country/Region Code"; Rec."Sell-to Country/Region Code")
                {
                    ToolTip = 'Specifies the address country/region.';
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ToolTip = 'Specifies the postal code.';
                }
                field("Ship-to County"; Rec."Ship-to County")
                {
                    ToolTip = 'Specifies the state, province or county as a part of the address.';
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    ToolTip = 'Specifies the country or region of the address.';
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    ToolTip = 'Specifies the value of the Bal. Account Type field.';
                }
                field("Exit Point"; Rec."Exit Point")
                {
                    ToolTip = 'Specifies the point of exit through which you ship the items out of your country/region, for reporting to Intrastat.';
                }
                field(Correction; Rec.Correction)
                {
                    ToolTip = 'Specifies the value of the Correction field.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies when the posted sales invoice was created.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ToolTip = 'Specifies the external document number that is entered on the sales header that this line was posted from.';
                }
                field("Area"; Rec."Area")
                {
                    ToolTip = 'Specifies the area code used in the invoice.';
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ToolTip = 'Specifies the transaction specification that was used in the invoice.';
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ToolTip = 'Specifies how the customer must pay for products on the sales document.';
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ToolTip = 'Specifies which shipping agent is used to transport the items on the sales document to the customer.';
                }
                field("Package Tracking No."; Rec."Package Tracking No.")
                {
                    ToolTip = 'Specifies the shipping agent''s package number.';
                }
                field("Pre-Assigned No. Series"; Rec."Pre-Assigned No. Series")
                {
                    ToolTip = 'Specifies the value of the Pre-Assigned No. Series field.';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ToolTip = 'Specifies the value of the No. Series field.';
                }
                field("Order No. Series"; Rec."Order No. Series")
                {
                    ToolTip = 'Specifies the value of the Order No. Series field.';
                }
                field("Pre-Assigned No."; Rec."Pre-Assigned No.")
                {
                    ToolTip = 'Specifies the number of the sales document that the posted invoice was created for.';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field("Source Code"; Rec."Source Code")
                {
                    ToolTip = 'Specifies the value of the Source Code field.';
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    ToolTip = 'Specifies the tax area that is used to calculate and post sales tax.';
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                    ToolTip = 'Specifies if the sales invoice contains sales tax.';
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ToolTip = 'Specifies the value of the VAT Bus. Posting Group field.';
                }
                field("VAT Base Discount %"; Rec."VAT Base Discount %")
                {
                    ToolTip = 'Specifies the value of the VAT Base Discount % field.';
                }
                field("Invoice Discount Calculation"; Rec."Invoice Discount Calculation")
                {
                    ToolTip = 'Specifies the value of the Invoice Discount Calculation field.';
                }
                field("Invoice Discount Value"; Rec."Invoice Discount Value")
                {
                    ToolTip = 'Specifies the value of the Invoice Discount Value field.';
                }
                field("Prepayment No. Series"; Rec."Prepayment No. Series")
                {
                    ToolTip = 'Specifies the value of the Prepayment No. Series field.';
                }
                field("Prepayment Invoice"; Rec."Prepayment Invoice")
                {
                    ToolTip = 'Specifies the value of the Prepayment Invoice field.';
                }
                field("Prepayment Order No."; Rec."Prepayment Order No.")
                {
                    ToolTip = 'Specifies the value of the Prepayment Order No. field.';
                }
                field("Quote No."; Rec."Quote No.")
                {
                    ToolTip = 'Specifies the number of the sales quote document if a quote was used to start the sales process.';
                }
                field("Company Bank Account Code"; Rec."Company Bank Account Code")
                {
                    ToolTip = 'Specifies the bank account to use for bank information when the document is printed.';
                }
                //>>Commented
                /*
                field("Last Email Sent Time"; Rec."Last Email Sent Time")
                {
                    ToolTip = 'Specifies the value of the Last Email Sent Time field.';
                }
                field("Last Email Sent Status"; Rec."Last Email Sent Status")
                {
                    ToolTip = 'Specifies the value of the Last Email Sent Status field.';
                }
                field("Sent as Email"; Rec."Sent as Email")
                {
                    ToolTip = 'Specifies the value of the Sent as Email field.';
                }
                field("Last Email Notif Cleared"; Rec."Last Email Notif Cleared")
                {
                    ToolTip = 'Specifies the value of the Last Email Notif Cleared field.';
                }*/
                field("Sell-to Phone No."; Rec."Sell-to Phone No.")
                {
                    ToolTip = 'Specifies the value of the Sell-to Phone No. field.';
                }
                field("Sell-to E-Mail"; Rec."Sell-to E-Mail")
                {
                    ToolTip = 'Specifies the value of the Email field.';
                }
                field("VAT Reporting Date"; Rec."VAT Reporting Date")
                {
                    ToolTip = 'Specifies the VAT date on the invoice.';
                }
                field("Payment Reference"; Rec."Payment Reference")
                {
                    ToolTip = 'Specifies the payment of the sales invoice.';
                }
                field("Work Description"; Rec."Work Description")
                {
                    ToolTip = 'Specifies the value of the Work Description field.';
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ToolTip = 'Specifies the value of the Dimension Set ID field.';
                }
                field("Payment Service Set ID"; Rec."Payment Service Set ID")
                {
                    ToolTip = 'Specifies the value of the Payment Service Set ID field.';
                }
                field("Document Exchange Identifier"; Rec."Document Exchange Identifier")
                {
                    ToolTip = 'Specifies the value of the Document Exchange Identifier field.';
                }
                field("Document Exchange Status"; Rec."Document Exchange Status")
                {
                    ToolTip = 'Specifies the status of the document if you are using a document exchange service to send it as an electronic document. The status values are reported by the document exchange service.';
                }
                field("Doc. Exch. Original Identifier"; Rec."Doc. Exch. Original Identifier")
                {
                    ToolTip = 'Specifies the value of the Doc. Exch. Original Identifier field.';
                }
                field("Coupled to CRM"; Rec."Coupled to CRM")
                {
                    ToolTip = 'Specifies that the posted sales order is coupled to a sales order in Dynamics 365 Sales.';
                }
                field("Coupled to Dataverse"; Rec."Coupled to Dataverse")
                {
                    ToolTip = 'Specifies that the posted sales order is coupled to a sales order in Dynamics 365 Sales.';
                }
                field("Direct Debit Mandate ID"; Rec."Direct Debit Mandate ID")
                {
                    ToolTip = 'Specifies the direct-debit mandate that the customer has signed to allow direct debit collection of payments.';
                }
                field(Closed; Rec.Closed)
                {
                    ToolTip = 'Specifies if the posted invoice is paid. The check box will also be selected if a credit memo for the remaining amount has been applied.';
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    ToolTip = 'Specifies the amount that remains to be paid for the posted sales invoice.';
                }
                field("Cust. Ledger Entry No."; Rec."Cust. Ledger Entry No.")
                {
                    ToolTip = 'Specifies the value of the Cust. Ledger Entry No. field.';
                }
                field("Invoice Discount Amount"; Rec."Invoice Discount Amount")
                {
                    ToolTip = 'Specifies the value of the Invoice Discount Amount field.';
                }
                field(Cancelled; Rec.Cancelled)
                {
                    ToolTip = 'Specifies if the posted sales invoice has been either corrected or canceled.';
                }
                field(Corrective; Rec.Corrective)
                {
                    ToolTip = 'Specifies if the posted sales invoice is a corrective document.';
                }
                field(Reversed; Rec.Reversed)
                {
                    ToolTip = 'Specifies the value of the Reversed field.';
                }
                field("Campaign No."; Rec."Campaign No.")
                {
                    ToolTip = 'Specifies the value of the Campaign No. field.';
                }
                field("Sell-to Contact No."; Rec."Sell-to Contact No.")
                {
                    ToolTip = 'Specifies a unique identifier for the contact person at the customer the invoice was sent to.';
                }
                field("Bill-to Contact No."; Rec."Bill-to Contact No.")
                {
                    ToolTip = 'Specifies the number of the contact the invoice was sent to.';
                }
                field("Opportunity No."; Rec."Opportunity No.")
                {
                    ToolTip = 'Specifies the value of the Opportunity No. field.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the code of the responsibility center associated with the user who created the invoice, your company, or the customer in the sales invoice.';
                }
                field("Price Calculation Method"; Rec."Price Calculation Method")
                {
                    ToolTip = 'Specifies the value of the Price Calculation Method field.';
                }
                field("Allow Line Disc."; Rec."Allow Line Disc.")
                {
                    ToolTip = 'Specifies the value of the Allow Line Disc. field.';
                }
                field("Get Shipment Used"; Rec."Get Shipment Used")
                {
                    ToolTip = 'Specifies the value of the Get Shipment Used field.';
                }
                field("Draft Invoice SystemId"; Rec."Draft Invoice SystemId")
                {
                    ToolTip = 'Specifies the value of the Draft Invoice SystemId field.';
                }
                field("Ref. Invoice No. old"; Rec."Ref. Invoice No. old")
                {
                    ToolTip = 'Specifies the value of the Ref. Invoice No. old field.';
                }
                field("Shield Invoice"; Rec."Shield Invoice")
                {
                    ToolTip = 'Specifies the value of the Shield Invoice field.';
                }
                field("Sales Order Type"; Rec."Sales Order Type")
                {
                    ToolTip = 'Specifies the value of the Sales Order Type field.';
                }
                field(Shield; Rec.Shield)
                {
                    ToolTip = 'Specifies the value of the Shield field.';
                }
                field("Shield Posting No."; Rec."Shield Posting No.")
                {
                    ToolTip = 'Specifies the value of the Shield Posting No. field.';
                }
                field("Cust. Mobile No."; Rec."Cust. Mobile No.")
                {
                    ToolTip = 'Specifies the value of the Cust. Mobile No. field.';
                }
                field("Cust. email ID"; Rec."Cust. email ID")
                {
                    ToolTip = 'Specifies the value of the Cust. email ID field.';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer Name field.';
                }
                field("Product Bar Code"; Rec."Product Bar Code")
                {
                    ToolTip = 'Specifies the value of the Product Bar Code field.';
                }
                field(PayByCashAmt; Rec.PayByCashAmt)
                {
                    ToolTip = 'Specifies the value of the PayByCashAmt field.';
                }
                field("CashPay Method Code"; Rec."CashPay Method Code")
                {
                    ToolTip = 'Specifies the value of the Payment Method Code field.';
                }
                field(PayByCreditNo1; Rec.PayByCreditNo1)
                {
                    ToolTip = 'Specifies the value of the PayByCreditNo1 field.';
                }
                field("CreditCdPay Method Code1"; Rec."CreditCdPay Method Code1")
                {
                    ToolTip = 'Specifies the value of the Payment Method Code field.';
                }
                field(PayByCreditNo2; Rec.PayByCreditNo2)
                {
                    ToolTip = 'Specifies the value of the PayByCreditNo2 field.';
                }
                field(PayByCreditNo3; Rec.PayByCreditNo3)
                {
                    ToolTip = 'Specifies the value of the PayByCreditNo3 field.';
                }
                field(PayByCreditNo4; Rec.PayByCreditNo4)
                {
                    ToolTip = 'Specifies the value of the PayByCreditNo4 field.';
                }
                field(PayByCreditAmt1; Rec.PayByCreditAmt1)
                {
                    ToolTip = 'Specifies the value of the PayByCreditAmt1 field.';
                }
                field(PayByCreditAmt2; Rec.PayByCreditAmt2)
                {
                    ToolTip = 'Specifies the value of the PayByCreditAmt2 field.';
                }
                field(PayByCreditAmt3; Rec.PayByCreditAmt3)
                {
                    ToolTip = 'Specifies the value of the PayByCreditAmt3 field.';
                }
                field(PayByCreditAmt4; Rec.PayByCreditAmt4)
                {
                    ToolTip = 'Specifies the value of the PayByCreditAmt4 field.';
                }
                field(PayByDebitCdNo1; Rec.PayByDebitCdNo1)
                {
                    ToolTip = 'Specifies the value of the PayByDebitCdNo1 field.';
                }
                field(PayByDebitCdAmt1; Rec.PayByDebitCdAmt1)
                {
                    ToolTip = 'Specifies the value of the PayByDebitCdAmt1 field.';
                }
                field(PayByChqNo; Rec.PayByChqNo)
                {
                    ToolTip = 'Specifies the value of the PayByChqNo field.';
                }
                field(PayByChqDt; Rec.PayByChqDt)
                {
                    ToolTip = 'Specifies the value of the PayByChqDt field.';
                }
                field(PayByChqAmt; Rec.PayByChqAmt)
                {
                    ToolTip = 'Specifies the value of the PayByChqAmt field.';
                }
                field(GiftVoucherAmt; Rec.GiftVoucherAmt)
                {
                    ToolTip = 'Specifies the value of the GiftVoucherAmt field.';
                }
                field("RTGS Ref. No."; Rec."RTGS Ref. No.")
                {
                    ToolTip = 'Specifies the value of the RTGS Ref. No. field.';
                }
                field("RTGS Bank Name"; Rec."RTGS Bank Name")
                {
                    ToolTip = 'Specifies the value of the RTGS Bank Name field.';
                }
                field("RTGS Amount"; Rec."RTGS Amount")
                {
                    ToolTip = 'Specifies the value of the RTGS Amount field.';
                }
                field("Finance Comapny"; Rec."Finance Comapny")
                {
                    ToolTip = 'Specifies the value of the Finance Comapny field.';
                }
                field("Bank Approval Code"; Rec."Bank Approval Code")
                {
                    ToolTip = 'Specifies the value of the Bank Approval Code field.';
                }
                field("Finance Amount"; Rec."Finance Amount")
                {
                    ToolTip = 'Specifies the value of the Finance Amount field.';
                }
                field(TotalPayByCustomer; Rec.TotalPayByCustomer)
                {
                    ToolTip = 'Specifies the value of the TotalPayByCustomer field.';
                }
                field("Buyer's Order No."; Rec."Buyer's Order No.")
                {
                    ToolTip = 'Specifies the value of the Buyer''s Order No. field.';
                }
                field("Buyer's Order Dt"; Rec."Buyer's Order Dt")
                {
                    ToolTip = 'Specifies the value of the Buyer''s Order Dt field.';
                }
                field("DebitCdPay Method Code1"; Rec."DebitCdPay Method Code1")
                {
                    ToolTip = 'Specifies the value of the Payment Method Code field.';
                }
                field("ChqPay Method Code"; Rec."ChqPay Method Code")
                {
                    ToolTip = 'Specifies the value of the Payment Method Code field.';
                }
                field("GiftPay Method Code"; Rec."GiftPay Method Code")
                {
                    ToolTip = 'Specifies the value of the Payment Method Code field.';
                }
                field("RTGSPay Method Code"; Rec."RTGSPay Method Code")
                {
                    ToolTip = 'Specifies the value of the Payment Method Code field.';
                }
                field("FinPay Method Code"; Rec."FinPay Method Code")
                {
                    ToolTip = 'Specifies the value of the Payment Method Code field.';
                }
                field("Promo Code"; Rec."Promo Code")
                {
                    ToolTip = 'Specifies the value of the Promo Code field.';
                }
                field("Delivery Note"; Rec."Delivery Note")
                {
                    ToolTip = 'Specifies the value of the Delivery Note field.';
                }
                field("Dispatch Doc. No."; Rec."Dispatch Doc. No.")
                {
                    ToolTip = 'Specifies the value of the Dispatch Doc. No. field.';
                }
                field("Dispatch Through"; Rec."Dispatch Through")
                {
                    ToolTip = 'Specifies the value of the Dispatch Through field.';
                }
                field("Posted Shield Posting No."; Rec."Posted Shield Posting No.")
                {
                    ToolTip = 'Specifies the value of the Posted Shield Posting No. field.';
                }
                field("Discount Type"; Rec."Discount Type")
                {
                    ToolTip = 'Specifies the value of the Discount Type field.';
                }
                field("Entry No"; Rec."Entry No")
                {
                    ToolTip = 'Specifies the value of the Discount Type Entry No field.';
                }
                field("Ref. Invoice No."; Rec."Ref. Invoice No.")
                {
                    ToolTip = 'Specifies the value of the Ref. Invoice No. field.';
                }
                field("Maple Buyback Amt"; Rec."Maple Buyback Amt")
                {
                    ToolTip = 'Specifies the value of the Maple Buyback Amt field.';
                }
                field("Maple Buyback Method Code"; Rec."Maple Buyback Method Code")
                {
                    ToolTip = 'Specifies the value of the Maple Buyback Method Code field.';
                }
                field("Apple Buyback Amt"; Rec."Apple Buyback Amt")
                {
                    ToolTip = 'Specifies the value of the Apple Buyback Amt field.';
                }
                field("Apple Buyback method  Code"; Rec."Apple Buyback method  Code")
                {
                    ToolTip = 'Specifies the value of the Apple Buyback method  Code field.';
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ToolTip = 'Specifies the value of the Vendor No. field.';
                }
                field("Inward Location"; Rec."Inward Location")
                {
                    ToolTip = 'Specifies the value of the Inward Location field.';
                }
                field("Vendor Item"; Rec."Vendor Item")
                {
                    ToolTip = 'Specifies the value of the Vendor Item field.';
                }
                field("Party Item Price"; Rec."Party Item Price")
                {
                    ToolTip = 'Specifies the value of the Party Item Price field.';
                }
                field("Party No"; Rec."Party No")
                {
                    ToolTip = 'Specifies the value of the Party No field.';
                }
                field("Party Sales Location"; Rec."Party Sales Location")
                {
                    ToolTip = 'Specifies the value of the Party Sales Location field.';
                }
                field("Party Address"; Rec."Party Address")
                {
                    ToolTip = 'Specifies the value of the Party Address field.';
                }
                field("Party City"; Rec."Party City")
                {
                    ToolTip = 'Specifies the value of the Party City field.';
                }
                field("Party Name"; Rec."Party Name")
                {
                    ToolTip = 'Specifies the value of the Party Name field.';
                }
                field(BuyBackType; Rec.BuyBackType)
                {
                    ToolTip = 'Specifies the value of the BuyBackType field.';
                }
                field("Apple Refund Amt"; Rec."Apple Refund Amt")
                {
                    ToolTip = 'Specifies the value of the Apple Refund Amt field.';
                }
                field("Apple Refund Method Code"; Rec."Apple Refund Method Code")
                {
                    ToolTip = 'Specifies the value of the Apple Refund Method Code field.';
                }
                field(CreditCardNo1; Rec.CreditCardNo1)
                {
                    ToolTip = 'Specifies the value of the CreditCardNo1 field.';
                }
                field(CreditCardNo2; Rec.CreditCardNo2)
                {
                    ToolTip = 'Specifies the value of the CreditCardNo2 field.';
                }
                field(CreditCardNo3; Rec.CreditCardNo3)
                {
                    ToolTip = 'Specifies the value of the CreditCardNo3 field.';
                }
                field(CreditCardNo4; Rec.CreditCardNo4)
                {
                    ToolTip = 'Specifies the value of the CreditCardNo4 field.';
                }
                field(PurchaseLineExist; Rec.PurchaseLineExist)
                {
                    ToolTip = 'Specifies the value of the PurchaseLineExist field.';
                }
                field(DebitCardNo2; Rec.DebitCardNo2)
                {
                    ToolTip = 'Specifies the value of the DebitCardNo2 field.';
                }
                field(PayByDebitNo2; Rec.PayByDebitNo2)
                {
                    ToolTip = 'Specifies the value of the PayByDebitNo2 field.';
                }
                field(PayByDebitAmt2; Rec.PayByDebitAmt2)
                {
                    ToolTip = 'Specifies the value of the PayByDebitAmt2 field.';
                }
                field("CreditCdPay Method Code2"; Rec."CreditCdPay Method Code2")
                {
                    ToolTip = 'Specifies the value of the Payment Method Code field.';
                }
                field("CreditCdPay Method Code3"; Rec."CreditCdPay Method Code3")
                {
                    ToolTip = 'Specifies the value of the Payment Method Code field.';
                }
                field("CreditCdPay Method Code4"; Rec."CreditCdPay Method Code4")
                {
                    ToolTip = 'Specifies the value of the Payment Method Code field.';
                }
                field("DebitCdPay Method Code2"; Rec."DebitCdPay Method Code2")
                {
                    ToolTip = 'Specifies the value of the Payment Method Code field.';
                }
                field("PurchaseOrderNo."; Rec."PurchaseOrderNo.")
                {
                    ToolTip = 'Specifies the value of the PurchaseOrderNo. field.';
                }
                field("Total Shield Value"; Rec."Total Shield Value")
                {
                    ToolTip = 'Specifies the value of the Total Shield Value field.';
                }
                field("FA Disposal"; Rec."FA Disposal")
                {
                    ToolTip = 'Specifies the value of the FA Disposal field.';
                }
                field("Group Credit Limit Hold"; Rec."Group Credit Limit Hold")
                {
                    ToolTip = 'Specifies the value of the Group Credit Limit Hold field.';
                }
                field("Transfer Shipment No."; Rec."Transfer Shipment No.")
                {
                    ToolTip = 'Specifies the value of the Transfer Shipment No. field.';
                }
                field(BuybackRefundDistributor; Rec.BuybackRefundDistributor)
                {
                    ToolTip = 'Specifies the value of the BuybackRefundDistributor field.';
                }
                field(DebitCardNo1; Rec.DebitCardNo1)
                {
                    ToolTip = 'Specifies the value of the DebitCardNo1 field.';
                }
                field(CreditSale; Rec.CreditSale)
                {
                    ToolTip = 'Specifies the value of the CreditSale field.';
                }
                field(WebUserID; Rec.WebUserID)
                {
                    ToolTip = 'Specifies the value of the WebUserID field.';
                }
                field("Debit Note"; Rec."Debit Note")
                {
                    ToolTip = 'Specifies the value of the Debit Note field.';
                }
                field("Finance Comapny new"; Rec."Finance Comapny new")
                {
                    ToolTip = 'Specifies the value of the Finance Comapny new field.';
                }
                field("Amount To Customer UPIT"; Rec."Amount To Customer UPIT")
                {
                    ToolTip = 'Specifies the value of the Amount To Customer UPIT field.';
                }
                field("Capillary Discount Amount"; Rec."Capillary Discount Amount")
                {
                    ToolTip = 'Specifies the value of the Capillary Discount Amount field.';
                }
                field("Capillary Posted"; Rec."Capillary Posted")
                {
                    ToolTip = 'Specifies the value of the Capillary Posted field.';
                }
                field("Paytm Approval Code"; Rec."Paytm Approval Code")
                {
                    ToolTip = 'Specifies the value of the Paytm Approval Code field.';
                }
                field("Paytm Transfer Amount"; Rec."Paytm Transfer Amount")
                {
                    ToolTip = 'Specifies the value of the Paytm Transfer Amount field.';
                }
                field(paytmMethodCode; Rec.paytmMethodCode)
                {
                    ToolTip = 'Specifies the value of the paytmMethodCode field.';
                }
                field("Amazon Approval Code"; Rec."Amazon Approval Code")
                {
                    ToolTip = 'Specifies the value of the Amazon Approval Code field.';
                }
                field("Amazon Transfer Amount"; Rec."Amazon Transfer Amount")
                {
                    ToolTip = 'Specifies the value of the Amazon Transfer Amount field.';
                }
                field(ExMethodCode; Rec.ExMethodCode)
                {
                    ToolTip = 'Specifies the value of the ExMethodCode field.';
                }
                field("T.I.N. No."; Rec."T.I.N. No.")
                {
                    ToolTip = 'Specifies the value of the T.I.N. No. field.';
                }
                field("Address 3"; Rec."Address 3")
                {
                    ToolTip = 'Specifies the value of the Address 3 field.';
                }
                field("Capillary Transaction Id"; Rec."Capillary Transaction Id")
                {
                    ToolTip = 'Specifies the value of the Capillary Transaction Id field.';
                }
                field("Capillary Error"; Rec."Capillary Error")
                {
                    ToolTip = 'Specifies the value of the Capillary Error field.';
                }
                field("Order ID"; Rec."Order ID")
                {
                    ToolTip = 'Specifies the value of the Order ID field.';
                }
                field("Insurance Approval Code"; Rec."Insurance Approval Code")
                {
                    ToolTip = 'Specifies the value of the Insurance Approval Code field.';
                }
                field("Insurance Transfer Amount"; Rec."Insurance Transfer Amount")
                {
                    ToolTip = 'Specifies the value of the Insurance Transfer Amount field.';
                }
                field(InsuranceMethodCode; Rec.InsuranceMethodCode)
                {
                    ToolTip = 'Specifies the value of the InsuranceMethodCode field.';
                }
                field("Cashify Approval Code"; Rec."Cashify Approval Code")
                {
                    ToolTip = 'Specifies the value of the Cashify Approval Code field.';
                }
                field("Cashify Transfer Amount"; Rec."Cashify Transfer Amount")
                {
                    ToolTip = 'Specifies the value of the Cashify Transfer Amount field.';
                }
                field(CashifyMethodCode; Rec.CashifyMethodCode)
                {
                    ToolTip = 'Specifies the value of the CashifyMethodCode field.';
                }
                field("Pinelab Transfer Amount"; Rec."Pinelab Transfer Amount")
                {
                    ToolTip = 'Specifies the value of the Pinelab Transfer Amount field.';
                }
                field(PinelabMethodCode; Rec.PinelabMethodCode)
                {
                    ToolTip = 'Specifies the value of the PinelabMethodCode field.';
                }
                field("Pinelab Approval Code"; Rec."Pinelab Approval Code")
                {
                    ToolTip = 'Specifies the value of the Pinelab Approval Code field.';
                }
                field("Loyalty Riwardz Tr.Amount"; Rec."Loyalty Riwardz Tr.Amount")
                {
                    ToolTip = 'Specifies the value of the Loyalty Riwardz Tr.Amount field.';
                }
                field("Loyalty Riwardz Method Code"; Rec."Loyalty Riwardz Method Code")
                {
                    ToolTip = 'Specifies the value of the Loyalty Riwardz Method Code field.';
                }
                field("Loyalty Riwardz Approval Code"; Rec."Loyalty Riwardz Approval Code")
                {
                    ToolTip = 'Specifies the value of the Loyalty Riwardz Approval Code field.';
                }
                field("Mobile Type"; Rec."Mobile Type")
                {
                    ToolTip = 'Specifies the value of the Mobile Type field.';
                }
                field("Sales Invoice Time"; Rec."Sales Invoice Time")
                {
                    ToolTip = 'Specifies the value of the Sales Invoice Time field.';
                }
                field("E-Invoice Cancel Remark"; Rec."E-Invoice Cancel Remark")
                {
                    ToolTip = 'Specifies the value of the E-Invoice Cancel Remark field.';
                }
                field("E-Invoice Reason Code"; Rec."E-Invoice Reason Code")
                {
                    ToolTip = 'Specifies the value of the E-Invoice Reason Code field.';
                }
                field("IRN No."; Rec."IRN No.")
                {
                    ToolTip = 'Specifies the value of the IRN No. field.';
                }
                field("Acknowledgement No"; Rec."Acknowledgement No")
                {
                    ToolTip = 'Specifies the value of the Acknowledgement No field.';
                }
                field("Acknowledgement Date1"; Rec."Acknowledgement Date1")
                {
                    ToolTip = 'Specifies the value of the Acknowledgement Date1 field.';
                }
                field("E-Invocie Cancel Date"; Rec."E-Invocie Cancel Date")
                {
                    ToolTip = 'Specifies the value of the E-Invocie Cancel Date field.';
                }
                field(Distance; Rec.Distance)
                {
                    ToolTip = 'Specifies the value of the Distance field.';
                }
                field("E-Way Bill No"; Rec."E-Way Bill No")
                {
                    ToolTip = 'Specifies the value of the E-Way Bill No field.';
                }
                field("E-Way Bill Date"; Rec."E-Way Bill Date")
                {
                    ToolTip = 'Specifies the value of the E-Way Bill Date field.';
                }
                field("Cancel Reason Code"; Rec."Cancel Reason Code")
                {
                    ToolTip = 'Specifies the value of the Cancel Reason Code field.';
                }
                field("Cancel Remark"; Rec."Cancel Remark")
                {
                    ToolTip = 'Specifies the value of the Cancel Remark field.';
                }
                field("Voucher Amount"; Rec."Voucher Amount")
                {
                    ToolTip = 'Specifies the value of the Voucher Amount field.';
                }
                field("Email Sent"; Rec."Email Sent")
                {
                    ToolTip = 'Specifies the value of the Email Sent field.';
                }
                field("IS LOB Order"; Rec."IS LOB Order")
                {
                    ToolTip = 'Specifies the value of the IS LOB Order field.';
                }
                field(transaction_id; Rec.transaction_id)
                {
                    ToolTip = 'Specifies the value of the transaction_id field.';
                }
                field(payment_method; Rec.payment_method)
                {
                    ToolTip = 'Specifies the value of the payment_method field.';
                }
                field(payment_method_title; Rec.payment_method_title)
                {
                    ToolTip = 'Specifies the value of the payment_method_title field.';
                }
                field("E-Way Bill Date ValidTill"; Rec."E-Way Bill Date ValidTill")
                {
                    ToolTip = 'Specifies the value of the E-Way Bill Date ValidTill field.';
                }
                field("API GST Reg No"; Rec."API GST Reg No")
                {
                    ToolTip = 'Specifies the value of the API GST Reg No field.';
                }
                field("Payment Status"; Rec."Payment Status")
                {
                    ToolTip = 'Specifies the value of the Payment Status field.';
                }
                field("Order Time"; Rec."Order Time")
                {
                    ToolTip = 'Specifies the value of the Order Time field.';
                }
                field("Servify Approval Code"; Rec."Servify Approval Code")
                {
                    ToolTip = 'Specifies the value of the Servify Approval Code field.';
                }
                field(orderStatus; Rec.orderStatus)
                {
                    ToolTip = 'Specifies the value of the orderStatus field.';
                }
                field(orderDateTime; Rec.orderDateTime)
                {
                    ToolTip = 'Specifies the value of the orderDateTime field.';
                }
                field("Payment Mode"; Rec."Payment Mode")
                {
                    ToolTip = 'Specifies the value of the Payment Mode field.';
                }
                field("Buy Back Code"; Rec."Buy Back Code")
                {
                    ToolTip = 'Specifies the value of the Buy Back Code field.';
                }
                field(erpSoTimestamp; Rec.erpSoTimestamp)
                {
                    ToolTip = 'Specifies the value of the erpSoTimestamp field.';
                }
                field(ERPShipToAdd1; Rec.ERPShipToAdd1)
                {
                    ToolTip = 'Specifies the value of the ERPShipToAdd1 field.';
                }
                field(ERPShipToAdd2; Rec.ERPShipToAdd2)
                {
                    ToolTip = 'Specifies the value of the ERPShipToAdd2 field.';
                }
                field(ERPShipToCity; Rec.ERPShipToCity)
                {
                    ToolTip = 'Specifies the value of the ERPShipToCity field.';
                }
                field(ERPShipToPostCode; Rec.ERPShipToPostCode)
                {
                    ToolTip = 'Specifies the value of the ERPShipToPostCode field.';
                }
                field(ERPShipToState; Rec.ERPShipToState)
                {
                    ToolTip = 'Specifies the value of the ERPShipToState field.';
                }
                field(ERPBillToAdd1; Rec.ERPBillToAdd1)
                {
                    ToolTip = 'Specifies the value of the ERPBillToAdd1 field.';
                }
                field(ERPBillToAdd2; Rec.ERPBillToAdd2)
                {
                    ToolTip = 'Specifies the value of the ERPBillToAdd2 field.';
                }
                field(ERPBillToCity; Rec.ERPBillToCity)
                {
                    ToolTip = 'Specifies the value of the ERPBillToCity field.';
                }
                field(ERPBillToPostCode; Rec.ERPBillToPostCode)
                {
                    ToolTip = 'Specifies the value of the ERPBillToPostCode field.';
                }
                field(ERPBillToState; Rec.ERPBillToState)
                {
                    ToolTip = 'Specifies the value of the ERPBillToState field.';
                }
                field("Trade-in device IMEI no."; Rec."Trade-in device IMEI no.")
                {
                    ToolTip = 'Specifies the value of the Trade-in device IMEI no. field.';
                }
                field("Trade-in Device Model no."; Rec."Trade-in Device Model no.")
                {
                    ToolTip = 'Specifies the value of the Trade-in Device Model no. field.';
                }
                field("E-Inv Cancelled"; Rec."E-Inv Cancelled")
                {
                    ToolTip = 'Specifies the value of the E-Inv Cancelled field.';
                }
                field("Eway Cancelled"; Rec."Eway Cancelled")
                {
                    ToolTip = 'Specifies the value of the Eway Cancelled field.';
                }
                field("Shipping Label"; Rec."Shipping Label")
                {
                    ToolTip = 'Specifies the value of the Shipping Label field.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}