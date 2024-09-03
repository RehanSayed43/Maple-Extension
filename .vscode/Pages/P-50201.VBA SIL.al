page 50201 "VBA SIL"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Sales Invoice Line";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'Specifies the number of the customer.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the invoice number.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the line type.';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the location in which the invoice line was registered.';
                }
                field("Posting Group"; Rec."Posting Group")
                {
                    ToolTip = 'Specifies the value of the Posting Group field.';
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ToolTip = 'Specifies when items on the document are shipped or were shipped. A shipment date is usually calculated from a requested delivery date plus lead time.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies a description of the item or service on the line.';
                }
                field("Description 2"; Rec."Description 2")
                {
                    ToolTip = 'Specifies information in addition to the description.';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ToolTip = 'Specifies the unit of measure code for the item.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the number of units of the item specified on the line.';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ToolTip = 'Specifies the price for one unit on the sales line.';
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ToolTip = 'Specifies the cost, in LCY, of one unit of the item or resource on the line.';
                }
                field("VAT %"; Rec."VAT %")
                {
                    ToolTip = 'Specifies the VAT % that was used on the sales or purchase lines with this VAT Identifier.';
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ToolTip = 'Specifies the discount percentage that is granted for the item on the line.';
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ToolTip = 'Specifies the discount amount that is granted for the item on the line.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the line''s net amount.';
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ToolTip = 'Specifies the net amount, including VAT, for this line.';
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    ToolTip = 'Specifies if the invoice line is included when the invoice discount is calculated.';
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                    ToolTip = 'Specifies the gross weight of one unit of the item. In the sales statistics window, the gross weight on the line is included in the total gross weight of all the lines for the particular sales document.';
                }
                field("Net Weight"; Rec."Net Weight")
                {
                    ToolTip = 'Specifies the net weight of one unit of the item. In the sales statistics window, the net weight on the line is included in the total net weight of all the lines for the particular sales document.';
                }
                field("Units per Parcel"; Rec."Units per Parcel")
                {
                    ToolTip = 'Specifies the number of units per parcel of the item. In the sales statistics window, the number of units per parcel on the line helps to determine the total number of units for all the lines for the particular sales document.';
                }
                field("Unit Volume"; Rec."Unit Volume")
                {
                    ToolTip = 'Specifies the volume of one unit of the item. In the sales statistics window, the volume of one unit of the item on the line is included in the total volume of all the lines for the particular sales document.';
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    ToolTip = 'Specifies the number of the item ledger entry that the document or journal line is applied to.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Customer Price Group"; Rec."Customer Price Group")
                {
                    ToolTip = 'Specifies the value of the Customer Price Group field.';
                }
                field("Job No."; Rec."Job No.")
                {
                    ToolTip = 'Specifies the number of the related job.';
                }
                field("Work Type Code"; Rec."Work Type Code")
                {
                    ToolTip = 'Specifies the value of the Work Type Code field.';
                }
                field("Shipment No."; Rec."Shipment No.")
                {
                    ToolTip = 'Specifies the value of the Shipment No. field.';
                }
                field("Shipment Line No."; Rec."Shipment Line No.")
                {
                    ToolTip = 'Specifies the value of the Shipment Line No. field.';
                }
                field("Order No."; Rec."Order No.")
                {
                    ToolTip = 'Specifies the value of the Order No. field.';
                }
                field("Order Line No."; Rec."Order Line No.")
                {
                    ToolTip = 'Specifies the value of the Order Line No. field.';
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ToolTip = 'Specifies the number of the customer that you send or sent the invoice or credit memo to.';
                }
                field("Inv. Discount Amount"; Rec."Inv. Discount Amount")
                {
                    ToolTip = 'Specifies the total calculated invoice discount amount for the line.';
                }
                field("Drop Shipment"; Rec."Drop Shipment")
                {
                    ToolTip = 'Specifies the value of the Drop Shipment field.';
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ToolTip = 'Specifies the vendor''s or customer''s trade type to link transactions made for this business partner with the appropriate general ledger account according to the general posting setup.';
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ToolTip = 'Specifies the item''s product type to link transactions made for this item with the appropriate general ledger account according to the general posting setup.';
                }
                field("VAT Calculation Type"; Rec."VAT Calculation Type")
                {
                    ToolTip = 'Specifies the value of the VAT Calculation Type field.';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Type field.';
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ToolTip = 'Specifies the value of the Transport Method field.';
                }
                field("Attached to Line No."; Rec."Attached to Line No.")
                {
                    ToolTip = 'Specifies the value of the Attached to Line No. field.';
                }
                field("Exit Point"; Rec."Exit Point")
                {
                    ToolTip = 'Specifies the value of the Exit Point field.';
                }
                field("Area"; Rec."Area")
                {
                    ToolTip = 'Specifies the value of the Area field.';
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ToolTip = 'Specifies the value of the Transaction Specification field.';
                }
                field("Tax Category"; Rec."Tax Category")
                {
                    ToolTip = 'Specifies the value of the Tax Category field.';
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    ToolTip = 'Specifies the tax area that is used to calculate and post sales tax.';
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                    ToolTip = 'Specifies if the customer or vendor is liable for sales tax.';
                }
                field("Tax Group Code"; Rec."Tax Group Code")
                {
                    ToolTip = 'Specifies the tax group code for the tax-detail entry.';
                }
                field("VAT Clause Code"; Rec."VAT Clause Code")
                {
                    ToolTip = 'Specifies the value of the VAT Clause Code field.';
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ToolTip = 'Specifies the VAT specification of the involved customer or vendor to link transactions made for this record with the appropriate general ledger account according to the VAT posting setup.';
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ToolTip = 'Specifies the VAT specification of the involved item or resource to link transactions made for this record with the appropriate general ledger account according to the VAT posting setup.';
                }
                field("Blanket Order No."; Rec."Blanket Order No.")
                {
                    ToolTip = 'Specifies the number of the blanket order that the record originates from.';
                }
                field("Blanket Order Line No."; Rec."Blanket Order Line No.")
                {
                    ToolTip = 'Specifies the number of the blanket order line that the record originates from.';
                }
                field("VAT Base Amount"; Rec."VAT Base Amount")
                {
                    ToolTip = 'Specifies the value of the VAT Base Amount field.';
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ToolTip = 'Specifies the value of the Unit Cost field.';
                }
                field("System-Created Entry"; Rec."System-Created Entry")
                {
                    ToolTip = 'Specifies the value of the System-Created Entry field.';
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ToolTip = 'Specifies the net amount, excluding any invoice discount amount, that must be paid for products on the line.';
                }
                field("VAT Difference"; Rec."VAT Difference")
                {
                    ToolTip = 'Specifies the value of the VAT Difference field.';
                }
                field("VAT Identifier"; Rec."VAT Identifier")
                {
                    ToolTip = 'Specifies the value of the VAT Identifier field.';
                }
                field("IC Partner Ref. Type"; Rec."IC Partner Ref. Type")
                {
                    ToolTip = 'Specifies the value of the IC Partner Ref. Type field.';
                }
                field("IC Partner Reference"; Rec."IC Partner Reference")
                {
                    ToolTip = 'Specifies the value of the IC Partner Reference field.';
                }
                field("Prepayment Line"; Rec."Prepayment Line")
                {
                    ToolTip = 'Specifies the value of the Prepayment Line field.';
                }
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    ToolTip = 'Specifies the code of the intercompany partner that the transaction is related to if the entry was created from an intercompany transaction.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("IC Item Reference No."; Rec."IC Item Reference No.")
                {
                    ToolTip = 'Specifies the value of the IC Item Reference No. field.';
                }
                field("Pmt. Discount Amount"; Rec."Pmt. Discount Amount")
                {
                    ToolTip = 'Specifies the value of the Pmt. Discount Amount field.';
                }
                field("Line Discount Calculation"; Rec."Line Discount Calculation")
                {
                    ToolTip = 'Specifies the value of the Line Discount Calculation field.';
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ToolTip = 'Specifies the value of the Dimension Set ID field.';
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    ToolTip = 'Specifies the number of the related job task.';
                }
                field("Job Contract Entry No."; Rec."Job Contract Entry No.")
                {
                    ToolTip = 'Specifies the entry number of the job planning line that the sales line is linked to.';
                }
                field("Deferral Code"; Rec."Deferral Code")
                {
                    ToolTip = 'Specifies the deferral template that governs how revenue earned with this sales document is deferred to the different accounting periods when the good or service was delivered.';
                }
                field("Allocation Account No."; Rec."Allocation Account No.")
                {
                    ToolTip = 'Specifies the value of the Allocation Account No. field.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ToolTip = 'Specifies the variant of the item on the line.';
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ToolTip = 'Specifies the bin where the items are picked or put away.';
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                    ToolTip = 'Specifies the value of the Qty. per Unit of Measure field.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies how each unit of the item or resource is measured, such as in pieces or hours. By default, the value in the Base Unit of Measure field on the item or resource card is inserted.';
                }
                field("Quantity (Base)"; Rec."Quantity (Base)")
                {
                    ToolTip = 'Specifies the value of the Quantity (Base) field.';
                }
                field("FA Posting Date"; Rec."FA Posting Date")
                {
                    ToolTip = 'Specifies the value of the FA Posting Date field.';
                }
                field("Depreciation Book Code"; Rec."Depreciation Book Code")
                {
                    ToolTip = 'Specifies the value of the Depreciation Book Code field.';
                }
                field("Depr. until FA Posting Date"; Rec."Depr. until FA Posting Date")
                {
                    ToolTip = 'Specifies the value of the Depr. until FA Posting Date field.';
                }
                field("Duplicate in Depreciation Book"; Rec."Duplicate in Depreciation Book")
                {
                    ToolTip = 'Specifies the value of the Duplicate in Depreciation Book field.';
                }
                field("Use Duplication List"; Rec."Use Duplication List")
                {
                    ToolTip = 'Specifies the value of the Use Duplication List field.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ToolTip = 'Specifies the value of the Item Category Code field.';
                }
                field(Nonstock; Rec.Nonstock)
                {
                    ToolTip = 'Specifies that this item is a catalog item.';
                }
                field("Purchasing Code"; Rec."Purchasing Code")
                {
                    ToolTip = 'Specifies the value of the Purchasing Code field.';
                }
                field("Item Reference No."; Rec."Item Reference No.")
                {
                    ToolTip = 'Specifies the referenced item number.';
                }
                field("Item Reference Unit of Measure"; Rec."Item Reference Unit of Measure")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure (Item Ref.) field.';
                }
                field("Item Reference Type"; Rec."Item Reference Type")
                {
                    ToolTip = 'Specifies the value of the Item Reference Type field.';
                }
                field("Item Reference Type No."; Rec."Item Reference Type No.")
                {
                    ToolTip = 'Specifies the value of the Item Reference Type No. field.';
                }
                field("Appl.-from Item Entry"; Rec."Appl.-from Item Entry")
                {
                    ToolTip = 'Specifies the number of the item ledger entry that the document or journal line is applied from.';
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    ToolTip = 'Specifies the code explaining why the item was returned.';
                }
                field("Price Calculation Method"; Rec."Price Calculation Method")
                {
                    ToolTip = 'Specifies the value of the Price Calculation Method field.';
                }
                field("Allow Line Disc."; Rec."Allow Line Disc.")
                {
                    ToolTip = 'Specifies the value of the Allow Line Disc. field.';
                }
                field("Customer Disc. Group"; Rec."Customer Disc. Group")
                {
                    ToolTip = 'Specifies the value of the Customer Disc. Group field.';
                }
                field("Price description"; Rec."Price description")
                {
                    ToolTip = 'Specifies the value of the Price description field.';
                }
                field("Credit Hold"; Rec."Credit Hold")
                {
                    ToolTip = 'Specifies the value of the Credit Hold field.';
                }
                field("Overdue Hold"; Rec."Overdue Hold")
                {
                    ToolTip = 'Specifies the value of the Overdue Hold field.';
                }
                field("Price Hold"; Rec."Price Hold")
                {
                    ToolTip = 'Specifies the value of the Price Hold field.';
                }
                field("Sales Order Type"; Rec."Sales Order Type")
                {
                    ToolTip = 'Specifies the value of the Sales Order Type field.';
                }
                field("PDC Hold"; Rec."PDC Hold")
                {
                    ToolTip = 'Specifies the value of the PDC Hold field.';
                }
                field("Discount Hold"; Rec."Discount Hold")
                {
                    ToolTip = 'Specifies the value of the Discount Hold field.';
                }
                field(Shield; Rec.Shield)
                {
                    ToolTip = 'Specifies the value of the Shield field.';
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ToolTip = 'Specifies the value of the Serial No. field.';
                }
                field("Free Item"; Rec."Free Item")
                {
                    ToolTip = 'Specifies the value of the Free Item field.';
                }
                field("Free Item Pend_for_ Delivery"; Rec."Free Item Pend_for_ Delivery")
                {
                    ToolTip = 'Specifies the value of the Free Item Pend_for_ Delivery field.';
                }
                field("Shield Value"; Rec."Shield Value")
                {
                    ToolTip = 'Specifies the value of the Shield Value field.';
                }
                field(AMC; Rec.AMC)
                {
                    ToolTip = 'Specifies the value of the AMC field.';
                }
                field("AMC Due Date"; Rec."AMC Due Date")
                {
                    ToolTip = 'Specifies the value of the AMC Due Date field.';
                }
                field("Warranty Exp. Dt"; Rec."Warranty Exp. Dt")
                {
                    ToolTip = 'Specifies the value of the Warranty Exp. Dt field.';
                }
                field("shield Due Date"; Rec."shield Due Date")
                {
                    ToolTip = 'Specifies the value of the shield Due Date field.';
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
                field("Shield Cost"; Rec."Shield Cost")
                {
                    ToolTip = 'Specifies the value of the Shield Cost field.';
                }
                field("Shield Type"; Rec."Shield Type")
                {
                    ToolTip = 'Specifies the value of the Shield Type field.';
                }
                field("IMEI No."; Rec."IMEI No.")
                {
                    ToolTip = 'Specifies the value of the IMEI No. field.';
                }
                field("Primary category"; Rec."Primary category")
                {
                    ToolTip = 'Specifies the value of the Primary category field.';
                }
                field("Secondary category"; Rec."Secondary category")
                {
                    ToolTip = 'Specifies the value of the Secondary category field.';
                }
                field("Third category"; Rec."Third category")
                {
                    ToolTip = 'Specifies the value of the Third category field.';
                }
                field("UPN Code"; Rec."UPN Code")
                {
                    ToolTip = 'Specifies the value of the UPN Code field.';
                }
                field("Scheme Code"; Rec."Scheme Code")
                {
                    ToolTip = 'Specifies the value of the Scheme Code field.';
                }
                field("Scheme Amount"; Rec."Scheme Amount")
                {
                    ToolTip = 'Specifies the value of the Scheme Amount field.';
                }
                field("Claim Amount"; Rec."Claim Amount")
                {
                    ToolTip = 'Specifies the value of the Claim Amount field.';
                }
                field("Claim received"; Rec."Claim received")
                {
                    ToolTip = 'Specifies the value of the Claim received field.';
                }
                field("Claim Received Date"; Rec."Claim Received Date")
                {
                    ToolTip = 'Specifies the value of the Claim Received Date field.';
                }
                field("Scheme %"; Rec."Scheme %")
                {
                    ToolTip = 'Specifies the value of the Scheme % field.';
                }
                field("Claim %"; Rec."Claim %")
                {
                    ToolTip = 'Specifies the value of the Claim % field.';
                }
                field(Vendor; Rec.Vendor)
                {
                    ToolTip = 'Specifies the value of the Vendor field.';
                }
                field("Vendor Part Code"; Rec."Vendor Part Code")
                {
                    ToolTip = 'Specifies the value of the Vendor Part Code field.';
                }
                field("Sales Points"; Rec."Sales Points")
                {
                    ToolTip = 'Specifies the value of the Sales Points field.';
                }
                field("MRP Discount %"; Rec."MRP Discount %")
                {
                    ToolTip = 'Specifies the value of the MRP Discount % field.';
                }
                field("MRP Discount Amount"; Rec."MRP Discount Amount")
                {
                    ToolTip = 'Specifies the value of the MRP Discount Amount field.';
                }
                field("MRP Line Discount Amount"; Rec."MRP Line Discount Amount")
                {
                    ToolTip = 'Specifies the value of the MRP Line Discount Amount field.';
                }
                field("Capillary Line Discount Amount"; Rec."Capillary Line Discount Amount")
                {
                    ToolTip = 'Specifies the value of the Capillary Line Discount Amount field.';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ToolTip = 'Specifies the value of the Salesperson Code field.';
                }
                field("CRT Coupon Code"; Rec."CRT Coupon Code")
                {
                    ToolTip = 'Specifies the value of the CRT Coupon Code field.';
                }
                field("Discount Type"; Rec."Discount Type")
                {
                    ToolTip = 'Specifies the value of the Discount Type field.';
                }
                field("Discount %"; Rec."Discount %")
                {
                    ToolTip = 'Specifies the value of the Discount % field.';
                }
                field("Discount Amount"; Rec."Discount Amount")
                {
                    ToolTip = 'Specifies the value of the Discount Amount field.';
                }
                field(SKU1; Rec.SKU1)
                {
                    ToolTip = 'Specifies the value of the SKU1 field.';
                }
                field("Net Amount"; Rec."Net Amount")
                {
                    ToolTip = 'Specifies the value of the Net Amount field.';
                }
                field("Product Category"; Rec."Product Category")
                {
                    ToolTip = 'Specifies the value of the Product Category field.';
                }
                field("MRP Value"; Rec."MRP Value")
                {
                    ToolTip = 'Specifies the value of the MRP Value field.';
                }
                field("Eleva Product Serial No."; Rec."Eleva Product Serial No.")
                {
                    ToolTip = 'Specifies the value of the Eleva Product Serial No. field.';
                }
                field(Select; Rec.Select)
                {
                    ToolTip = 'Specifies the value of the Select field.';
                }
                field(Brand; Rec.Brand)
                {
                    ToolTip = 'Specifies the value of the Brand field.';
                }
                field("Auto Generated"; Rec."Auto Generated")
                {
                    ToolTip = 'Specifies the value of the Auto Generated field.';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.';
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