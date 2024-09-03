page 50199 "VBA ILE"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Item Ledger Entry";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the number of the entry, as assigned from the specified number series when the entry was created.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the number of the item in the entry.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the entry''s posting date.';
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ToolTip = 'Specifies which type of transaction that the entry is created from.';
                }
                field("Source No."; Rec."Source No.")
                {
                    ToolTip = 'Specifies where the entry originated.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the document number on the entry. The document is the voucher that the entry was based on, for example, a receipt.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies a description of the entry.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the code for the location that the entry is linked to.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the number of units of the item in the item entry.';
                }
                field("Remaining Quantity"; Rec."Remaining Quantity")
                {
                    ToolTip = 'Specifies the quantity in the Quantity field that remains to be processed.';
                }
                field("Invoiced Quantity"; Rec."Invoiced Quantity")
                {
                    ToolTip = 'Specifies how many units of the item on the line have been invoiced.';
                }
                field("Applies-to Entry"; Rec."Applies-to Entry")
                {
                    ToolTip = 'Specifies if the quantity on the journal line must be applied to an already-posted entry. In that case, enter the entry number that the quantity will be applied to.';
                }
                field(Open; Rec.Open)
                {
                    ToolTip = 'Specifies whether the entry has been fully applied to.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the code for the global dimension that is linked to the record or entry for analysis purposes. Two global dimensions, typically for the company''s most important activities, are available on all cards, documents, reports, and lists.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the code for the global dimension that is linked to the record or entry for analysis purposes. Two global dimensions, typically for the company''s most important activities, are available on all cards, documents, reports, and lists.';
                }
                field(Positive; Rec.Positive)
                {
                    ToolTip = 'Specifies whether the item in the item ledge entry is positive.';
                }
                field("Shpt. Method Code"; Rec."Shpt. Method Code")
                {
                    ToolTip = 'Specifies the value of the Shpt. Method Code field.';
                }
                field("Source Type"; Rec."Source Type")
                {
                    ToolTip = 'Specifies the source type that applies to the source number, shown in the Source No. field.';
                }
                field("Drop Shipment"; Rec."Drop Shipment")
                {
                    ToolTip = 'Specifies if your vendor ships the items directly to your customer.';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Type field.';
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ToolTip = 'Specifies the value of the Transport Method field.';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ToolTip = 'Specifies the value of the Country/Region Code field.';
                }
                field("Entry/Exit Point"; Rec."Entry/Exit Point")
                {
                    ToolTip = 'Specifies the value of the Entry/Exit Point field.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the value of the Document Date field.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ToolTip = 'Specifies the value of the External Document No. field.';
                }
                field("Area"; Rec."Area")
                {
                    ToolTip = 'Specifies the value of the Area field.';
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ToolTip = 'Specifies the value of the Transaction Specification field.';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ToolTip = 'Specifies the value of the No. Series field.';
                }
                field("Reserved Quantity"; Rec."Reserved Quantity")
                {
                    ToolTip = 'Specifies how many units of the item on the line have been reserved.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies what type of document was posted to create the item ledger entry.';
                }
                field("Document Line No."; Rec."Document Line No.")
                {
                    ToolTip = 'Specifies the number of the line on the posted document that corresponds to the item ledger entry.';
                }
                field("Order Type"; Rec."Order Type")
                {
                    ToolTip = 'Specifies which type of order that the entry was created in.';
                }
                field("Order No."; Rec."Order No.")
                {
                    ToolTip = 'Specifies the number of the order that created the entry.';
                }
                field("Order Line No."; Rec."Order Line No.")
                {
                    ToolTip = 'Specifies the line number of the order that created the entry.';
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ToolTip = 'Specifies a reference to a combination of dimension values. The actual values are stored in the Dimension Set Entry table.';
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 3, which is one of dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 4, which is one of dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 5, which is one of dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 6, which is one of dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Shortcut Dimension 7 Code"; Rec."Shortcut Dimension 7 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 7, which is one of dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Shortcut Dimension 8 Code"; Rec."Shortcut Dimension 8 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 8, which is one of dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Assemble to Order"; Rec."Assemble to Order")
                {
                    ToolTip = 'Specifies if the posting represents an assemble-to-order sale.';
                }
                field("Job No."; Rec."Job No.")
                {
                    ToolTip = 'Specifies the number of the related job.';
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    ToolTip = 'Specifies the number of the related job task.';
                }
                field("Job Purchase"; Rec."Job Purchase")
                {
                    ToolTip = 'Specifies the value of the Job Purchase field.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ToolTip = 'Specifies the variant of the item on the line.';
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                    ToolTip = 'Specifies the quantity per item unit of measure.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies how each unit of the item or resource is measured, such as in pieces or hours. By default, the value in the Base Unit of Measure field on the item or resource card is inserted.';
                }
                field("Derived from Blanket Order"; Rec."Derived from Blanket Order")
                {
                    ToolTip = 'Specifies the value of the Derived from Blanket Order field.';
                }
                field("Originally Ordered No."; Rec."Originally Ordered No.")
                {
                    ToolTip = 'Specifies the value of the Originally Ordered No. field.';
                }
                field("Originally Ordered Var. Code"; Rec."Originally Ordered Var. Code")
                {
                    ToolTip = 'Specifies the value of the Originally Ordered Var. Code field.';
                }
                field("Out-of-Stock Substitution"; Rec."Out-of-Stock Substitution")
                {
                    ToolTip = 'Specifies the value of the Out-of-Stock Substitution field.';
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ToolTip = 'Specifies the value of the Item Category Code field.';
                }
                field(Nonstock; Rec.Nonstock)
                {
                    ToolTip = 'Specifies the value of the Catalog field.';
                }
                field("Purchasing Code"; Rec."Purchasing Code")
                {
                    ToolTip = 'Specifies the value of the Purchasing Code field.';
                }
                field("Item Reference No."; Rec."Item Reference No.")
                {
                    ToolTip = 'Specifies the value of the Item Reference No. field.';
                }
                field("Completely Invoiced"; Rec."Completely Invoiced")
                {
                    ToolTip = 'Specifies if the entry has been fully invoiced or if more posted invoices are expected. Only completely invoiced entries can be revalued.';
                }
                field("Last Invoice Date"; Rec."Last Invoice Date")
                {
                    ToolTip = 'Specifies the value of the Last Invoice Date field.';
                }
                field("Applied Entry to Adjust"; Rec."Applied Entry to Adjust")
                {
                    ToolTip = 'Specifies whether there is one or more applied entries, which need to be adjusted.';
                }
                field("Cost Amount (Expected)"; Rec."Cost Amount (Expected)")
                {
                    ToolTip = 'Specifies the expected cost, in LCY, of the quantity posting.';
                }
                field("Cost Amount (Actual)"; Rec."Cost Amount (Actual)")
                {
                    ToolTip = 'Specifies the adjusted cost, in LCY, of the quantity posting.';
                }
                field("Cost Amount (Non-Invtbl.)"; Rec."Cost Amount (Non-Invtbl.)")
                {
                    ToolTip = 'Specifies the adjusted non-inventoriable cost, that is an item charge assigned to an outbound entry.';
                }
                field("Cost Amount (Expected) (ACY)"; Rec."Cost Amount (Expected) (ACY)")
                {
                    ToolTip = 'Specifies the expected cost, in ACY, of the quantity posting.';
                }
                field("Cost Amount (Actual) (ACY)"; Rec."Cost Amount (Actual) (ACY)")
                {
                    ToolTip = 'Specifies the adjusted cost of the entry, in the additional reporting currency.';
                }
                field("Cost Amount (Non-Invtbl.)(ACY)"; Rec."Cost Amount (Non-Invtbl.)(ACY)")
                {
                    ToolTip = 'Specifies the adjusted non-inventoriable cost, that is, an item charge assigned to an outbound entry in the additional reporting currency.';
                }
                field("Purchase Amount (Expected)"; Rec."Purchase Amount (Expected)")
                {
                    ToolTip = 'Specifies the value of the Purchase Amount (Expected) field.';
                }
                field("Purchase Amount (Actual)"; Rec."Purchase Amount (Actual)")
                {
                    ToolTip = 'Specifies the value of the Purchase Amount (Actual) field.';
                }
                field("Sales Amount (Expected)"; Rec."Sales Amount (Expected)")
                {
                    ToolTip = 'Specifies the expected sales amount, in LCY.';
                }
                field("Sales Amount (Actual)"; Rec."Sales Amount (Actual)")
                {
                    ToolTip = 'Specifies the sales amount, in LCY.';
                }
                field(Correction; Rec.Correction)
                {
                    ToolTip = 'Specifies the value of the Correction field.';
                }
                field("Shipped Qty. Not Returned"; Rec."Shipped Qty. Not Returned")
                {
                    ToolTip = 'Specifies the quantity for this item ledger entry that was shipped and has not yet been returned.';
                }
                field("Prod. Order Comp. Line No."; Rec."Prod. Order Comp. Line No.")
                {
                    ToolTip = 'Specifies the line number of the production order component.';
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ToolTip = 'Specifies a serial number if the posted item carries such a number.';
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ToolTip = 'Specifies a lot number if the posted item carries such a number.';
                }
                field("Warranty Date"; Rec."Warranty Date")
                {
                    ToolTip = 'Specifies the last day of warranty for the item on the line.';
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    ToolTip = 'Specifies the last date that the item on the line can be used.';
                }
                field("Item Tracking"; Rec."Item Tracking")
                {
                    ToolTip = 'Specifies the value of the Item Tracking field.';
                }
                field("Package No."; Rec."Package No.")
                {
                    ToolTip = 'Specifies a package number if the posted item carries such a number.';
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    ToolTip = 'Specifies the code explaining why the item was returned.';
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
                field(HistoryData; Rec.HistoryData)
                {
                    ToolTip = 'Specifies the value of the HistoryData field.';
                }
                field("Sales Point"; Rec."Sales Point")
                {
                    ToolTip = 'Specifies the value of the Sales Point field.';
                }
                field("MRP Value"; Rec."MRP Value")
                {
                    ToolTip = 'Specifies the value of the MRP Value field.';
                }
                field("New External Document No "; Rec."New External Document No ")
                {
                    ToolTip = 'Specifies the value of the New External Document No. field.';
                }
                field("Auto Generated"; Rec."Auto Generated")
                {
                    ToolTip = 'Specifies the value of the Auto Generated field.';
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