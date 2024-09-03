page 50197 "VBA Customers"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Customer;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the customer. The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the customer''s name.';
                }
                field("Search Name"; Rec."Search Name")
                {
                    ToolTip = 'Specifies an alternate name that you can use to search for a customer.';
                }
                field("Name 2"; Rec."Name 2")
                {
                    ToolTip = 'Specifies an additional part of the name.';
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the customer''s address. This address will appear on all sales documents for the customer.';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ToolTip = 'Specifies additional address information.';
                }
                field(City; Rec.City)
                {
                    ToolTip = 'Specifies the customer''s city.';
                }
                field(Contact; Rec.Contact)
                {
                    ToolTip = 'Specifies the name of the person you regularly contact when you do business with this customer.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'Specifies the customer''s telephone number.';
                }
                field("Telex No."; Rec."Telex No.")
                {
                    ToolTip = 'Specifies the value of the Telex No. field.';
                }
                field("Document Sending Profile"; Rec."Document Sending Profile")
                {
                    ToolTip = 'Specifies the preferred method of sending documents to this customer, so that you do not have to select a sending option every time that you post and send a document to the customer. Sales documents to this customer will be sent using the specified sending profile and will override the default document sending profile.';
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ToolTip = 'Specifies the code for another shipment address than the customer''s own address, which is entered by default.';
                }
                field("Our Account No."; Rec."Our Account No.")
                {
                    ToolTip = 'Specifies the value of the Our Account No. field.';
                }
                field("Territory Code"; Rec."Territory Code")
                {
                    ToolTip = 'Specifies the value of the Territory Code field.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                }
                field("Chain Name"; Rec."Chain Name")
                {
                    ToolTip = 'Specifies the value of the Chain Name field.';
                }
                field("Budgeted Amount"; Rec."Budgeted Amount")
                {
                    ToolTip = 'Specifies the value of the Budgeted Amount field.';
                }
                field("Credit Limit (LCY)"; Rec."Credit Limit (LCY)")
                {
                    ToolTip = 'Specifies the maximum amount you allow the customer to exceed the payment balance before warnings are issued.';
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    ToolTip = 'Specifies the customer''s market type to link business transactions to.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the default currency for the customer.';
                }
                field("Customer Price Group"; Rec."Customer Price Group")
                {
                    ToolTip = 'Specifies the customer price group code, which you can use to set up special sales prices in the Sales Prices window.';
                }
                field("Language Code"; Rec."Language Code")
                {
                    ToolTip = 'Specifies the language to be used on printouts for this customer.';
                }
                field("Registration Number"; Rec."Registration Number")
                {
                    ToolTip = 'Specifies the registration number of the customer. You can enter a maximum of 20 characters, both numbers and letters.';
                }
                field("Statistics Group"; Rec."Statistics Group")
                {
                    ToolTip = 'Specifies the value of the Statistics Group field.';
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ToolTip = 'Specifies a code that indicates the payment terms that you require of the customer.';
                }
                field("Fin. Charge Terms Code"; Rec."Fin. Charge Terms Code")
                {
                    ToolTip = 'Specifies finance charges are calculated for the customer.';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ToolTip = 'Specifies a code for the salesperson who normally handles this customer''s account.';
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ToolTip = 'Specifies which shipment method to use when you ship items to the customer.';
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ToolTip = 'Specifies which shipping company is used when you ship items to the customer.';
                }
                field("Place of Export"; Rec."Place of Export")
                {
                    ToolTip = 'Specifies the value of the Place of Export field.';
                }
                field("Invoice Disc. Code"; Rec."Invoice Disc. Code")
                {
                    ToolTip = 'Specifies a code for the invoice discount terms that you have defined for the customer.';
                }
                field("Customer Disc. Group"; Rec."Customer Disc. Group")
                {
                    ToolTip = 'Specifies the customer discount group code, which you can use as a criterion to set up special discounts in the Sales Line Discounts window.';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ToolTip = 'Specifies the country/region of the address.';
                }
                field("Collection Method"; Rec."Collection Method")
                {
                    ToolTip = 'Specifies the value of the Collection Method field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ToolTip = 'Specifies which transactions with the customer that cannot be processed, for example, because the customer is insolvent.';
                }
                field("Invoice Copies"; Rec."Invoice Copies")
                {
                    ToolTip = 'Specifies the value of the Invoice Copies field.';
                }
                field("Last Statement No."; Rec."Last Statement No.")
                {
                    ToolTip = 'Specifies the number of the last statement that was printed for this customer.';
                }
                field("Print Statements"; Rec."Print Statements")
                {
                    ToolTip = 'Specifies whether to include this customer when you print the Statement report.';
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ToolTip = 'Specifies a different customer who will be invoiced for products that you sell to the customer in the Name field on the customer card.';
                }
                field(Priority; Rec.Priority)
                {
                    ToolTip = 'Specifies a number that corresponds to the priority you give the customer. The higher the number, the higher the priority.';
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ToolTip = 'Specifies how the customer usually submits payment, such as bank transfer or check.';
                }
                field("Format Region"; Rec."Format Region")
                {
                    ToolTip = 'Specifies the Format Region to be used on printouts for this customer.';
                }
                field("Last Modified Date Time"; Rec."Last Modified Date Time")
                {
                    ToolTip = 'Specifies the value of the Last Modified Date Time field.';
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ToolTip = 'Specifies when the customer card was last modified.';
                }
                field(Balance; Rec.Balance)
                {
                    ToolTip = 'Specifies the value of the Balance field.';
                }
                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                    ToolTip = 'Specifies the customer''s balance.';
                }
                field("Net Change"; Rec."Net Change")
                {
                    ToolTip = 'Specifies the value of the Net Change field.';
                }
                field("Net Change (LCY)"; Rec."Net Change (LCY)")
                {
                    ToolTip = 'Specifies the value of the Net Change (LCY) field.';
                }
                field("Sales (LCY)"; Rec."Sales (LCY)")
                {
                    ToolTip = 'Specifies the total net amount of sales to the customer.';
                }
                field("Profit (LCY)"; Rec."Profit (LCY)")
                {
                    ToolTip = 'Specifies the value of the Profit (LCY) field.';
                }
                field("Inv. Discounts (LCY)"; Rec."Inv. Discounts (LCY)")
                {
                    ToolTip = 'Specifies the value of the Inv. Discounts (LCY) field.';
                }
                field("Pmt. Discounts (LCY)"; Rec."Pmt. Discounts (LCY)")
                {
                    ToolTip = 'Specifies the value of the Pmt. Discounts (LCY) field.';
                }
                field("Balance Due"; Rec."Balance Due")
                {
                    ToolTip = 'Specifies the value of the Balance Due field.';
                }
                field("Balance Due (LCY)"; Rec."Balance Due (LCY)")
                {
                    ToolTip = 'Specifies payments from the customer that are overdue per today''s date.';
                }
                field(Payments; Rec.Payments)
                {
                    ToolTip = 'Specifies the value of the Payments field.';
                }
                field("Invoice Amounts"; Rec."Invoice Amounts")
                {
                    ToolTip = 'Specifies the value of the Invoice Amounts field.';
                }
                field("Cr. Memo Amounts"; Rec."Cr. Memo Amounts")
                {
                    ToolTip = 'Specifies the value of the Cr. Memo Amounts field.';
                }
                field("Finance Charge Memo Amounts"; Rec."Finance Charge Memo Amounts")
                {
                    ToolTip = 'Specifies the value of the Finance Charge Memo Amounts field.';
                }
                field("Payments (LCY)"; Rec."Payments (LCY)")
                {
                    ToolTip = 'Specifies the sum of payments received from the customer.';
                }
                field("Inv. Amounts (LCY)"; Rec."Inv. Amounts (LCY)")
                {
                    ToolTip = 'Specifies the value of the Inv. Amounts (LCY) field.';
                }
                field("Cr. Memo Amounts (LCY)"; Rec."Cr. Memo Amounts (LCY)")
                {
                    ToolTip = 'Specifies the value of the Cr. Memo Amounts (LCY) field.';
                }
                field("Fin. Charge Memo Amounts (LCY)"; Rec."Fin. Charge Memo Amounts (LCY)")
                {
                    ToolTip = 'Specifies the value of the Fin. Charge Memo Amounts (LCY) field.';
                }
                field("Outstanding Orders"; Rec."Outstanding Orders")
                {
                    ToolTip = 'Specifies the value of the Outstanding Orders field.';
                }
                field("Shipped Not Invoiced"; Rec."Shipped Not Invoiced")
                {
                    ToolTip = 'Specifies the value of the Shipped Not Invoiced field.';
                }
                field("Application Method"; Rec."Application Method")
                {
                    ToolTip = 'Specifies how to apply payments to entries for this customer.';
                }
                field("Prices Including VAT"; Rec."Prices Including VAT")
                {
                    ToolTip = 'Specifies if the Unit Price and Line Amount fields on document lines should be shown with or without VAT.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies from which location sales to this customer will be processed by default.';
                }
                field("Fax No."; Rec."Fax No.")
                {
                    ToolTip = 'Specifies the customer''s fax number.';
                }
                field("Telex Answer Back"; Rec."Telex Answer Back")
                {
                    ToolTip = 'Specifies the value of the Telex Answer Back field.';
                }
                field("VAT Registration No."; Rec."VAT Registration No.")
                {
                    ToolTip = 'Specifies the customer''s VAT registration number for customers in EU countries/regions.';
                }
                field("Combine Shipments"; Rec."Combine Shipments")
                {
                    ToolTip = 'Specifies if several orders delivered to the customer can appear on the same sales invoice.';
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ToolTip = 'Specifies the customer''s trade type to link transactions made for this customer with the appropriate general ledger account according to the general posting setup.';
                }
                field(GLN; Rec.GLN)
                {
                    ToolTip = 'Specifies the customer in connection with electronic document sending.';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ToolTip = 'Specifies the postal code.';
                }
                field(County; Rec.County)
                {
                    ToolTip = 'Specifies the state, province or county as a part of the address.';
                }
                field("EORI Number"; Rec."EORI Number")
                {
                    ToolTip = 'Specifies the Economic Operators Registration and Identification number that is used when you exchange information with the customs authorities due to trade into or out of the European Union.';
                }
                field("Use GLN in Electronic Document"; Rec."Use GLN in Electronic Document")
                {
                    ToolTip = 'Specifies whether the GLN is used in electronic documents as a party identification number.';
                }
                field("Debit Amount"; Rec."Debit Amount")
                {
                    ToolTip = 'Specifies the value of the Debit Amount field.';
                }
                field("Credit Amount"; Rec."Credit Amount")
                {
                    ToolTip = 'Specifies the value of the Credit Amount field.';
                }
                field("Debit Amount (LCY)"; Rec."Debit Amount (LCY)")
                {
                    ToolTip = 'Specifies the value of the Debit Amount (LCY) field.';
                }
                field("Credit Amount (LCY)"; Rec."Credit Amount (LCY)")
                {
                    ToolTip = 'Specifies the value of the Credit Amount (LCY) field.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ToolTip = 'Specifies the customer''s email address.';
                }
                field("Home Page"; Rec."Home Page")
                {
                    ToolTip = 'Specifies the customer''s home page address.';
                }
                field("Reminder Terms Code"; Rec."Reminder Terms Code")
                {
                    ToolTip = 'Specifies how reminders about late payments are handled for this customer.';
                }
                field("Reminder Amounts"; Rec."Reminder Amounts")
                {
                    ToolTip = 'Specifies the value of the Reminder Amounts field.';
                }
                field("Reminder Amounts (LCY)"; Rec."Reminder Amounts (LCY)")
                {
                    ToolTip = 'Specifies the value of the Reminder Amounts (LCY) field.';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ToolTip = 'Specifies the value of the No. Series field.';
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
                    ToolTip = 'Specifies the customer''s VAT specification to link transactions made for this customer to.';
                }
                field("Outstanding Orders (LCY)"; Rec."Outstanding Orders (LCY)")
                {
                    ToolTip = 'Specifies your expected sales income from the customer in LCY based on ongoing sales orders.';
                }
                field("Shipped Not Invoiced (LCY)"; Rec."Shipped Not Invoiced (LCY)")
                {
                    ToolTip = 'Specifies your expected sales income from the customer in LCY based on ongoing sales orders where items have been shipped.';
                }
                field(Reserve; Rec.Reserve)
                {
                    ToolTip = 'Specifies whether items will never, automatically (Always), or optionally be reserved for this customer.';
                }
                field("Block Payment Tolerance"; Rec."Block Payment Tolerance")
                {
                    ToolTip = 'Specifies that the customer is not allowed a payment tolerance.';
                }
                field("Pmt. Disc. Tolerance (LCY)"; Rec."Pmt. Disc. Tolerance (LCY)")
                {
                    ToolTip = 'Specifies the value of the Pmt. Disc. Tolerance (LCY) field.';
                }
                field("Pmt. Tolerance (LCY)"; Rec."Pmt. Tolerance (LCY)")
                {
                    ToolTip = 'Specifies the value of the Pmt. Tolerance (LCY) field.';
                }
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    ToolTip = 'Specifies the customer''s intercompany partner code.';
                }
                field(Refunds; Rec.Refunds)
                {
                    ToolTip = 'Specifies the value of the Refunds field.';
                }
                field("Refunds (LCY)"; Rec."Refunds (LCY)")
                {
                    ToolTip = 'Specifies the sum of refunds received from the customer.';
                }
                field("Other Amounts"; Rec."Other Amounts")
                {
                    ToolTip = 'Specifies the value of the Other Amounts field.';
                }
                field("Other Amounts (LCY)"; Rec."Other Amounts (LCY)")
                {
                    ToolTip = 'Specifies the value of the Other Amounts (LCY) field.';
                }
                field("Prepayment %"; Rec."Prepayment %")
                {
                    ToolTip = 'Specifies a prepayment percentage that applies to all orders for this customer, regardless of the items or services on the order lines.';
                }
                field("Outstanding Invoices (LCY)"; Rec."Outstanding Invoices (LCY)")
                {
                    ToolTip = 'Specifies your expected sales income from the customer in LCY based on unpaid sales invoices.';
                }
                field("Outstanding Invoices"; Rec."Outstanding Invoices")
                {
                    ToolTip = 'Specifies the value of the Outstanding Invoices field.';
                }
                field("Bill-to No. Of Archived Doc."; Rec."Bill-to No. Of Archived Doc.")
                {
                    ToolTip = 'Specifies the value of the Bill-to No. Of Archived Doc. field.';
                }
                field("Sell-to No. Of Archived Doc."; Rec."Sell-to No. Of Archived Doc.")
                {
                    ToolTip = 'Specifies the value of the Sell-to No. Of Archived Doc. field.';
                }
                field("Partner Type"; Rec."Partner Type")
                {
                    ToolTip = 'Specifies for direct debit collections if the customer that the payment is collected from is a person or a company.';
                }
                field("Intrastat Partner Type"; Rec."Intrastat Partner Type")
                {
                    ToolTip = 'Specifies for Intrastat reporting if the customer is a person or a company.';
                }
                field("Exclude from Pmt. Practices"; Rec."Exclude from Pmt. Practices")
                {
                    ToolTip = 'Specifies that the customer must be excluded from Payment Practices calculations.';
                }
                field(Image; Rec.Image)
                {
                    ToolTip = 'Specifies the picture of the customer, for example, a logo.';
                }
                field("Privacy Blocked"; Rec."Privacy Blocked")
                {
                    ToolTip = 'Specifies whether to limit access to data for the data subject during daily operations. This is useful, for example, when protecting data from changes while it is under privacy review.';
                }
                field("Disable Search by Name"; Rec."Disable Search by Name")
                {
                    ToolTip = 'Specifies that you can change the customer name on open sales documents. The change applies only to the documents.';
                }
                field("Allow Multiple Posting Groups"; Rec."Allow Multiple Posting Groups")
                {
                    ToolTip = 'Specifies if multiple posting groups can be used for posting business transactions for this customer.';
                }
                field("Preferred Bank Account Code"; Rec."Preferred Bank Account Code")
                {
                    ToolTip = 'Specifies the customer''s bank account that will be used by default when you process refunds to the customer and direct debit collections.';
                }
                field("Coupled to CRM"; Rec."Coupled to CRM")
                {
                    ToolTip = 'Specifies that the customer is coupled to an account in Dataverse.';
                }
                field("Coupled to Dataverse"; Rec."Coupled to Dataverse")
                {
                    ToolTip = 'Specifies that the customer is coupled to an account in Dataverse.';
                }
                field("Cash Flow Payment Terms Code"; Rec."Cash Flow Payment Terms Code")
                {
                    ToolTip = 'Specifies a payment term that will be used to calculate cash flow for the customer.';
                }
                field("Primary Contact No."; Rec."Primary Contact No.")
                {
                    ToolTip = 'Specifies the contact number for the customer.';
                }
                field("Contact Type"; Rec."Contact Type")
                {
                    ToolTip = 'Specifies if the contact is a company or a person.';
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ToolTip = 'Specifies the customer''s mobile telephone number.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the code for the responsibility center that will administer this customer by default.';
                }
                field("Shipping Advice"; Rec."Shipping Advice")
                {
                    ToolTip = 'Specifies if the customer accepts partial shipment of orders.';
                }
                field("Shipping Time"; Rec."Shipping Time")
                {
                    ToolTip = 'Specifies how long it takes from when the items are shipped from the warehouse to when they are delivered.';
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    ToolTip = 'Specifies the code for the shipping agent service to use for this customer.';
                }
                field("Service Zone Code"; Rec."Service Zone Code")
                {
                    ToolTip = 'Specifies the code for the service zone that is assigned to the customer.';
                }
                field("Contract Gain/Loss Amount"; Rec."Contract Gain/Loss Amount")
                {
                    ToolTip = 'Specifies the value of the Contract Gain/Loss Amount field.';
                }
                field("Outstanding Serv. Orders (LCY)"; Rec."Outstanding Serv. Orders (LCY)")
                {
                    ToolTip = 'Specifies your expected service income from the customer in LCY based on ongoing service orders.';
                }
                field("Serv Shipped Not Invoiced(LCY)"; Rec."Serv Shipped Not Invoiced(LCY)")
                {
                    ToolTip = 'Specifies your expected service income from the customer in LCY based on service orders that are shipped but not invoiced.';
                }
                field("Outstanding Serv.Invoices(LCY)"; Rec."Outstanding Serv.Invoices(LCY)")
                {
                    ToolTip = 'Specifies your expected service income from the customer in LCY based on unpaid service invoices.';
                }
                field("Price Calculation Method"; Rec."Price Calculation Method")
                {
                    ToolTip = 'Specifies the default price calculation method.';
                }
                field("Allow Line Disc."; Rec."Allow Line Disc.")
                {
                    ToolTip = 'Specifies if a sales line discount is calculated when a special sales price is offered according to setup in the Sales Prices window.';
                }
                field("No. of Quotes"; Rec."No. of Quotes")
                {
                    ToolTip = 'Specifies the number of sales quotes that have been registered for the customer.';
                }
                field("No. of Blanket Orders"; Rec."No. of Blanket Orders")
                {
                    ToolTip = 'Specifies the number of sales blanket orders that have been registered for the customer.';
                }
                field("No. of Orders"; Rec."No. of Orders")
                {
                    ToolTip = 'Specifies the number of sales orders that have been registered for the customer.';
                }
                field("No. of Invoices"; Rec."No. of Invoices")
                {
                    ToolTip = 'Specifies the number of unposted sales invoices that have been registered for the customer.';
                }
                field("No. of Return Orders"; Rec."No. of Return Orders")
                {
                    ToolTip = 'Specifies the number of sales return orders that have been registered for the customer.';
                }
                field("No. of Credit Memos"; Rec."No. of Credit Memos")
                {
                    ToolTip = 'Specifies the number of unposted sales credit memos that have been registered for the customer.';
                }
                field("No. of Pstd. Shipments"; Rec."No. of Pstd. Shipments")
                {
                    ToolTip = 'Specifies the number of posted sales shipments that have been registered for the customer.';
                }
                field("No. of Pstd. Invoices"; Rec."No. of Pstd. Invoices")
                {
                    ToolTip = 'Specifies the number of posted sales invoices that have been registered for the customer.';
                }
                field("No. of Pstd. Return Receipts"; Rec."No. of Pstd. Return Receipts")
                {
                    ToolTip = 'Specifies the number of posted sales return receipts that have been registered for the customer.';
                }
                field("No. of Pstd. Credit Memos"; Rec."No. of Pstd. Credit Memos")
                {
                    ToolTip = 'Specifies the number of posted sales credit memos that have been registered for the customer.';
                }
                field("No. of Ship-to Addresses"; Rec."No. of Ship-to Addresses")
                {
                    ToolTip = 'Specifies the value of the No. of Ship-to Addresses field.';
                }
                field("Bill-To No. of Quotes"; Rec."Bill-To No. of Quotes")
                {
                    ToolTip = 'Specifies how many quotes have been registered for the customer when the customer acts as the bill-to customer.';
                }
                field("Bill-To No. of Blanket Orders"; Rec."Bill-To No. of Blanket Orders")
                {
                    ToolTip = 'Specifies how many blanket orders have been registered for the customer when the customer acts as the bill-to customer.';
                }
                field("Bill-To No. of Orders"; Rec."Bill-To No. of Orders")
                {
                    ToolTip = 'Specifies how many sales orders have been registered for the customer when the customer acts as the bill-to customer.';
                }
                field("Bill-To No. of Invoices"; Rec."Bill-To No. of Invoices")
                {
                    ToolTip = 'Specifies how many invoices have been registered for the customer when the customer acts as the bill-to customer.';
                }
                field("Bill-To No. of Return Orders"; Rec."Bill-To No. of Return Orders")
                {
                    ToolTip = 'Specifies how many return orders have been registered for the customer when the customer acts as the bill-to customer.';
                }
                field("Bill-To No. of Credit Memos"; Rec."Bill-To No. of Credit Memos")
                {
                    ToolTip = 'Specifies how many credit memos have been registered for the customer when the customer acts as the bill-to customer.';
                }
                field("Bill-To No. of Pstd. Shipments"; Rec."Bill-To No. of Pstd. Shipments")
                {
                    ToolTip = 'Specifies how many posted shipments have been registered for the customer when the customer acts as the bill-to customer.';
                }
                field("Bill-To No. of Pstd. Invoices"; Rec."Bill-To No. of Pstd. Invoices")
                {
                    ToolTip = 'Specifies how many posted invoices have been registered for the customer when the customer acts as the bill-to customer.';
                }
                field("Bill-To No. of Pstd. Return R."; Rec."Bill-To No. of Pstd. Return R.")
                {
                    ToolTip = 'Specifies how many posted return receipts have been registered for the customer when the customer acts as the bill-to customer.';
                }
                field("Bill-To No. of Pstd. Cr. Memos"; Rec."Bill-To No. of Pstd. Cr. Memos")
                {
                    ToolTip = 'Specifies how many posted credit memos have been registered for the customer when the customer acts as the bill-to customer.';
                }
                field("Base Calendar Code"; Rec."Base Calendar Code")
                {
                    ToolTip = 'Specifies a customizable calendar for shipment planning that holds the customer''s working days and holidays.';
                }
                field("Copy Sell-to Addr. to Qte From"; Rec."Copy Sell-to Addr. to Qte From")
                {
                    ToolTip = 'Specifies which customer address is inserted on sales quotes that you create for the customer.';
                }
                field("Validate EU Vat Reg. No."; Rec."Validate EU Vat Reg. No.")
                {
                    ToolTip = 'Specifies the value of the Validate EU VAT Reg. No. field.';
                }
                field("Currency Id"; Rec."Currency Id")
                {
                    ToolTip = 'Specifies the value of the Currency Id field.';
                }
                field("Payment Terms Id"; Rec."Payment Terms Id")
                {
                    ToolTip = 'Specifies the value of the Payment Terms Id field.';
                }
                field("Shipment Method Id"; Rec."Shipment Method Id")
                {
                    ToolTip = 'Specifies the value of the Shipment Method Id field.';
                }
                field("Payment Method Id"; Rec."Payment Method Id")
                {
                    ToolTip = 'Specifies the value of the Payment Method Id field.';
                }
                field("Tax Area ID"; Rec."Tax Area ID")
                {
                    ToolTip = 'Specifies the value of the Tax Area ID field.';
                }
                field("Contact ID"; Rec."Contact ID")
                {
                    ToolTip = 'Specifies the value of the Contact ID field.';
                }
                field("Contact Graph Id"; Rec."Contact Graph Id")
                {
                    ToolTip = 'Specifies the value of the Contact Graph Id field.';
                }
                field("PDC Unposted Amount"; Rec."PDC Unposted Amount")
                {
                    ToolTip = 'Specifies the value of the PDC Unposted Amount field.';
                }
                field("PDC Applied Amount"; Rec."PDC Applied Amount")
                {
                    ToolTip = 'Specifies the value of the PDC Applied Amount field.';
                }
                field("PDC Grace Period"; Rec."PDC Grace Period")
                {
                    ToolTip = 'Specifies the value of the PDC Grace Period field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Moto Cust Inv Id"; Rec."Moto Cust Inv Id")
                {
                    ToolTip = 'Specifies the value of the Moto Cust Inv Id field.';
                }
                field("Dr Change"; Rec."Dr Change")
                {
                    ToolTip = 'Specifies the value of the Dr Change field.';
                }
                field("Cr Change"; Rec."Cr Change")
                {
                    ToolTip = 'Specifies the value of the Cr Change field.';
                }
                field("Spouse Name"; Rec."Spouse Name")
                {
                    ToolTip = 'Specifies the value of the Spouse Name field.';
                }
                field("Child Name 1"; Rec."Child Name 1")
                {
                    ToolTip = 'Specifies the value of the Child Name 1 field.';
                }
                field("Child Name 2"; Rec."Child Name 2")
                {
                    ToolTip = 'Specifies the value of the Child Name 2 field.';
                }
                field("Aniversary Date"; Rec."Aniversary Date")
                {
                    ToolTip = 'Specifies the value of the Aniversary Date field.';
                }
                field("Child1 Birth  Date"; Rec."Child1 Birth  Date")
                {
                    ToolTip = 'Specifies the value of the Child1 Birth  Date field.';
                }
                field("Child2 Birth Date"; Rec."Child2 Birth Date")
                {
                    ToolTip = 'Specifies the value of the Child2 Birth Date field.';
                }
                field("Customer Birth Date"; Rec."Customer Birth Date")
                {
                    ToolTip = 'Specifies the value of the Customer Birth Date field.';
                }
                field("Spouse Birth Date"; Rec."Spouse Birth Date")
                {
                    ToolTip = 'Specifies the value of the Spouse Birth Date field.';
                }
                field("Customer Type"; Rec."Customer Type")
                {
                    ToolTip = 'Specifies the value of the Customer Type field.';
                }
                field("Customer State Code"; Rec."Customer State Code")
                {
                    ToolTip = 'Specifies the value of the Customer State Code field.';
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field.';
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ToolTip = 'Specifies the value of the Marital Status field.';
                }
                field("Parent Code"; Rec."Parent Code")
                {
                    ToolTip = 'Specifies the value of the Parent Code field.';
                }
                field(RelCustomerCnt; Rec.RelCustomerCnt)
                {
                    ToolTip = 'Specifies the value of the RelCustomerCnt field.';
                }
                field("Age Group"; Rec."Age Group")
                {
                    ToolTip = 'Specifies the value of the Age Group field.';
                }
                field("Income Group"; Rec."Income Group")
                {
                    ToolTip = 'Specifies the value of the Income Group field.';
                }
                field("Not Interested Customer"; Rec."Not Interested Customer")
                {
                    ToolTip = 'Specifies the value of the Not Interested Customer field.';
                }
                field("Phone No.2"; Rec."Phone No.2")
                {
                    ToolTip = 'Specifies the value of the Phone No.2 field.';
                }
                field("CRM Mobile No."; Rec."CRM Mobile No.")
                {
                    ToolTip = 'Specifies the value of the CRM Mobile No. field.';
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ToolTip = 'Specifies the value of the Creation Date field.';
                }
                field("Modified by User ID"; Rec."Modified by User ID")
                {
                    ToolTip = 'Specifies the value of the Modified by User ID field.';
                }
                field("Customer Points"; Rec."Customer Points")
                {
                    ToolTip = 'Specifies the value of the Customer Points field.';
                }
                field("Cust Adress 3"; Rec."Cust Adress 3")
                {
                    ToolTip = 'Specifies the value of the Cust Adress 3 field.';
                }
                field("ERP No."; Rec."ERP No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
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