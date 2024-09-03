page 50202 "VBA Items"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Item;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field("No. 2"; Rec."No. 2")
                {
                    ToolTip = 'Specifies the value of the No. 2 field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies what you are selling.';
                }
                field("Search Description"; Rec."Search Description")
                {
                    ToolTip = 'Specifies a search description that you use to find the item in lists.';
                }
                field("Description 2"; Rec."Description 2")
                {
                    ToolTip = 'Specifies information in addition to the description.';
                }
                field("Assembly BOM"; Rec."Assembly BOM")
                {
                    ToolTip = 'Specifies if the item is an assembly BOM.';
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    ToolTip = 'Specifies the unit in which the item is held in inventory. The base unit of measure also serves as the conversion basis for alternate units of measure.';
                }
                field("Price Unit Conversion"; Rec."Price Unit Conversion")
                {
                    ToolTip = 'Specifies the value of the Price Unit Conversion field.';
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies if the item card represents a physical inventory unit (Inventory), a labor time unit (Service), or a physical unit that is not tracked in inventory (Non-Inventory).';
                }
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                    ToolTip = 'Specifies links between business transactions made for the item and an inventory account in the general ledger, to group amounts for that item type.';
                }
                field("Shelf No."; Rec."Shelf No.")
                {
                    ToolTip = 'Specifies where to find the item in the warehouse. This is informational only.';
                }
                field("Item Disc. Group"; Rec."Item Disc. Group")
                {
                    ToolTip = 'Specifies an item group code that can be used as a criterion to grant a discount when the item is sold to a certain customer.';
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    ToolTip = 'Specifies if the item should be included in the calculation of an invoice discount on documents where the item is traded.';
                }
                field("Statistics Group"; Rec."Statistics Group")
                {
                    ToolTip = 'Specifies the value of the Statistics Group field.';
                }
                field("Commission Group"; Rec."Commission Group")
                {
                    ToolTip = 'Specifies the value of the Commission Group field.';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ToolTip = 'Specifies the price for one unit.';
                }
                field("Price/Profit Calculation"; Rec."Price/Profit Calculation")
                {
                    ToolTip = 'Specifies the relationship between the Unit Cost, Unit Price, and Profit Percentage fields associated with this item.';
                }
                field("Profit %"; Rec."Profit %")
                {
                    ToolTip = 'Specifies the profit margin that you want to sell the item at. You can enter a profit percentage manually or have it entered according to the Price/Profit Calculation field';
                }
                field("Costing Method"; Rec."Costing Method")
                {
                    ToolTip = 'Specifies how the item''s cost flow is recorded and whether an actual or budgeted value is capitalized and used in the cost calculation.';
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ToolTip = 'Specifies the cost of one unit of the item or resource on the line.';
                }
                field("Standard Cost"; Rec."Standard Cost")
                {
                    ToolTip = 'Specifies the unit cost that is used as an estimation to be adjusted with variances later. It is typically used in assembly and production where costs can vary.';
                }
                field("Last Direct Cost"; Rec."Last Direct Cost")
                {
                    ToolTip = 'Specifies the most recent direct unit cost of the item.';
                }
                field("Indirect Cost %"; Rec."Indirect Cost %")
                {
                    ToolTip = 'Specifies the percentage of the item''s last purchase cost that includes indirect costs, such as freight that is associated with the purchase of the item.';
                }
                field("Cost is Adjusted"; Rec."Cost is Adjusted")
                {
                    ToolTip = 'Specifies whether the item''s unit cost has been adjusted, either automatically or manually.';
                }
                field("Allow Online Adjustment"; Rec."Allow Online Adjustment")
                {
                    ToolTip = 'Specifies the value of the Allow Online Adjustment field.';
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ToolTip = 'Specifies the vendor code of who supplies this item by default.';
                }
                field("Vendor Item No."; Rec."Vendor Item No.")
                {
                    ToolTip = 'Specifies the number that the vendor uses for this item.';
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    ToolTip = 'Specifies a date formula for the amount of time it takes to replenish the item.';
                }
                field("Reorder Point"; Rec."Reorder Point")
                {
                    ToolTip = 'Specifies a stock quantity that sets the inventory below the level that you must replenish the item.';
                }
                field("Maximum Inventory"; Rec."Maximum Inventory")
                {
                    ToolTip = 'Specifies a quantity that you want to use as a maximum inventory level.';
                }
                field("Reorder Quantity"; Rec."Reorder Quantity")
                {
                    ToolTip = 'Specifies a standard lot size quantity to be used for all order proposals.';
                }
                field("Alternative Item No."; Rec."Alternative Item No.")
                {
                    ToolTip = 'Specifies the value of the Alternative Item No. field.';
                }
                field("Unit List Price"; Rec."Unit List Price")
                {
                    ToolTip = 'Specifies the value of the Unit List Price field.';
                }
                field("Duty Due %"; Rec."Duty Due %")
                {
                    ToolTip = 'Specifies the value of the Duty Due % field.';
                }
                field("Duty Code"; Rec."Duty Code")
                {
                    ToolTip = 'Specifies the value of the Duty Code field.';
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                    ToolTip = 'Specifies the gross weight of the item.';
                }
                field("Net Weight"; Rec."Net Weight")
                {
                    ToolTip = 'Specifies the net weight of the item.';
                }
                field("Units per Parcel"; Rec."Units per Parcel")
                {
                    ToolTip = 'Specifies the value of the Units per Parcel field.';
                }
                field("Unit Volume"; Rec."Unit Volume")
                {
                    ToolTip = 'Specifies the volume of one unit of the item.';
                }
                field(Durability; Rec.Durability)
                {
                    ToolTip = 'Specifies the value of the Durability field.';
                }
                field("Freight Type"; Rec."Freight Type")
                {
                    ToolTip = 'Specifies the value of the Freight Type field.';
                }
                field("Tariff No."; Rec."Tariff No.")
                {
                    ToolTip = 'Specifies a code for the item''s tariff number.';
                }
                field("Duty Unit Conversion"; Rec."Duty Unit Conversion")
                {
                    ToolTip = 'Specifies the value of the Duty Unit Conversion field.';
                }
                field("Country/Region Purchased Code"; Rec."Country/Region Purchased Code")
                {
                    ToolTip = 'Specifies the value of the Country/Region Purchased Code field.';
                }
                field("Budget Quantity"; Rec."Budget Quantity")
                {
                    ToolTip = 'Specifies the value of the Budget Quantity field.';
                }
                field("Budgeted Amount"; Rec."Budgeted Amount")
                {
                    ToolTip = 'Specifies the value of the Budgeted Amount field.';
                }
                field("Budget Profit"; Rec."Budget Profit")
                {
                    ToolTip = 'Specifies the value of the Budget Profit field.';
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ToolTip = 'Specifies that the related record is blocked from being posted in transactions, for example an item that is placed in quarantine.';
                }
                field("Cost is Posted to G/L"; Rec."Cost is Posted to G/L")
                {
                    ToolTip = 'Specifies that all the inventory costs for this item have been posted to the general ledger.';
                }
                field("Block Reason"; Rec."Block Reason")
                {
                    ToolTip = 'Specifies the value of the Block Reason field.';
                }
                field("Last DateTime Modified"; Rec."Last DateTime Modified")
                {
                    ToolTip = 'Specifies the value of the Last DateTime Modified field.';
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ToolTip = 'Specifies when the item card was last modified.';
                }
                field("Last Time Modified"; Rec."Last Time Modified")
                {
                    ToolTip = 'Specifies the value of the Last Time Modified field.';
                }
                field(Inventory; Rec.Inventory)
                {
                    ToolTip = 'Specifies the total quantity of the item that is currently in inventory at all locations.';
                }
                field("Net Invoiced Qty."; Rec."Net Invoiced Qty.")
                {
                    ToolTip = 'Specifies how many units of the item in inventory have been invoiced.';
                }
                field("Net Change"; Rec."Net Change")
                {
                    ToolTip = 'Specifies the value of the Net Change field.';
                }
                field("Purchases (Qty.)"; Rec."Purchases (Qty.)")
                {
                    ToolTip = 'Specifies the value of the Purchases (Qty.) field.';
                }
                field("Sales (Qty.)"; Rec."Sales (Qty.)")
                {
                    ToolTip = 'Specifies the value of the Sales (Qty.) field.';
                }
                field("Positive Adjmt. (Qty.)"; Rec."Positive Adjmt. (Qty.)")
                {
                    ToolTip = 'Specifies the value of the Positive Adjmt. (Qty.) field.';
                }
                field("Negative Adjmt. (Qty.)"; Rec."Negative Adjmt. (Qty.)")
                {
                    ToolTip = 'Specifies the value of the Negative Adjmt. (Qty.) field.';
                }
                field("Purchases (LCY)"; Rec."Purchases (LCY)")
                {
                    ToolTip = 'Specifies the value of the Purchases (LCY) field.';
                }
                field("Sales (LCY)"; Rec."Sales (LCY)")
                {
                    ToolTip = 'Specifies the value of the Sales (LCY) field.';
                }
                field("Positive Adjmt. (LCY)"; Rec."Positive Adjmt. (LCY)")
                {
                    ToolTip = 'Specifies the value of the Positive Adjmt. (LCY) field.';
                }
                field("Negative Adjmt. (LCY)"; Rec."Negative Adjmt. (LCY)")
                {
                    ToolTip = 'Specifies the value of the Negative Adjmt. (LCY) field.';
                }
                field("COGS (LCY)"; Rec."COGS (LCY)")
                {
                    ToolTip = 'Specifies the value of the COGS (LCY) field.';
                }
                field("Qty. on Purch. Order"; Rec."Qty. on Purch. Order")
                {
                    ToolTip = 'Specifies how many units of the item are inbound on purchase orders, meaning listed on outstanding purchase order lines.';
                }
                field("Qty. on Sales Order"; Rec."Qty. on Sales Order")
                {
                    ToolTip = 'Specifies how many units of the item are allocated to sales orders, meaning listed on outstanding sales orders lines.';
                }
                field("Price Includes VAT"; Rec."Price Includes VAT")
                {
                    ToolTip = 'Specifies if the Unit Price and Line Amount fields on sales document lines for this item should be shown with or without VAT.';
                }
                field("VAT Bus. Posting Gr. (Price)"; Rec."VAT Bus. Posting Gr. (Price)")
                {
                    ToolTip = 'Specifies the VAT business posting group for customers for whom you want the sales price including VAT to apply.';
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ToolTip = 'Specifies the item''s product type to link transactions made for this item with the appropriate general ledger account according to the general posting setup.';
                }
                field(Picture; Rec.Picture)
                {
                    ToolTip = 'Specifies the picture that has been inserted for the item.';
                }
                field("Transferred (Qty.)"; Rec."Transferred (Qty.)")
                {
                    ToolTip = 'Specifies the value of the Transferred (Qty.) field.';
                }
                field("Transferred (LCY)"; Rec."Transferred (LCY)")
                {
                    ToolTip = 'Specifies the value of the Transferred (LCY) field.';
                }
                field("Country/Region of Origin Code"; Rec."Country/Region of Origin Code")
                {
                    ToolTip = 'Specifies a code for the country/region where the item was produced or processed.';
                }
                field("Automatic Ext. Texts"; Rec."Automatic Ext. Texts")
                {
                    ToolTip = 'Specifies that an extended text that you have set up will be added automatically on sales or purchase documents for this item.';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ToolTip = 'Specifies the value of the No. Series field.';
                }
                field("Tax Group Code"; Rec."Tax Group Code")
                {
                    ToolTip = 'Specifies the tax group code for the tax-detail entry.';
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ToolTip = 'Specifies the VAT specification of the involved item or resource to link transactions made for this record with the appropriate general ledger account according to the VAT posting setup.';
                }
                field(Reserve; Rec.Reserve)
                {
                    ToolTip = 'Specifies if and how the item will be reserved. Never: It is not possible to reserve the item. Optional: You can reserve the item manually. Always: The item is automatically reserved from demand, such as sales orders, against inventory, purchase orders, assembly orders, and production orders.';
                }
                field("Reserved Qty. on Inventory"; Rec."Reserved Qty. on Inventory")
                {
                    ToolTip = 'Specifies the value of the Reserved Qty. on Inventory field.';
                }
                field("Reserved Qty. on Purch. Orders"; Rec."Reserved Qty. on Purch. Orders")
                {
                    ToolTip = 'Specifies the value of the Reserved Qty. on Purch. Orders field.';
                }
                field("Reserved Qty. on Sales Orders"; Rec."Reserved Qty. on Sales Orders")
                {
                    ToolTip = 'Specifies the value of the Reserved Qty. on Sales Orders field.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                }
                field("Res. Qty. on Outbound Transfer"; Rec."Res. Qty. on Outbound Transfer")
                {
                    ToolTip = 'Specifies the value of the Res. Qty. on Outbound Transfer field.';
                }
                field("Res. Qty. on Inbound Transfer"; Rec."Res. Qty. on Inbound Transfer")
                {
                    ToolTip = 'Specifies the value of the Res. Qty. on Inbound Transfer field.';
                }
                field("Res. Qty. on Sales Returns"; Rec."Res. Qty. on Sales Returns")
                {
                    ToolTip = 'Specifies the value of the Res. Qty. on Sales Returns field.';
                }
                field("Res. Qty. on Purch. Returns"; Rec."Res. Qty. on Purch. Returns")
                {
                    ToolTip = 'Specifies the value of the Res. Qty. on Purch. Returns field.';
                }
                field("Stockout Warning"; Rec."Stockout Warning")
                {
                    ToolTip = 'Specifies if a warning is displayed when you enter a quantity on a sales document that brings the item''s inventory below zero.';
                }
                field("Prevent Negative Inventory"; Rec."Prevent Negative Inventory")
                {
                    ToolTip = 'Specifies whether you can post a transaction that will bring the item''s inventory below zero. Negative inventory is always prevented for Consumption and Transfer type transactions.';
                }
                field("Variant Mandatory if Exists"; Rec."Variant Mandatory if Exists")
                {
                    ToolTip = 'Specifies whether a variant must be selected if variants exist for the item. ';
                }
                field("Cost of Open Production Orders"; Rec."Cost of Open Production Orders")
                {
                    ToolTip = 'Specifies the value of the Cost of Open Production Orders field.';
                }
                field("Application Wksh. User ID"; Rec."Application Wksh. User ID")
                {
                    ToolTip = 'Specifies the ID of a user who is working in the Application Worksheet window.';
                }
                field("Coupled to CRM"; Rec."Coupled to CRM")
                {
                    ToolTip = 'Specifies that the item is coupled to a product in Dynamics 365 Sales.';
                }
                field("Coupled to Dataverse"; Rec."Coupled to Dataverse")
                {
                    ToolTip = 'Specifies that the item is coupled to a product in Dynamics 365 Sales.';
                }
                field("Assembly Policy"; Rec."Assembly Policy")
                {
                    ToolTip = 'Specifies which default order flow is used to supply this assembly item.';
                }
                field("Res. Qty. on Assembly Order"; Rec."Res. Qty. on Assembly Order")
                {
                    ToolTip = 'Specifies the value of the Res. Qty. on Assembly Order field.';
                }
                field("Res. Qty. on  Asm. Comp."; Rec."Res. Qty. on  Asm. Comp.")
                {
                    ToolTip = 'Specifies the value of the Res. Qty. on  Asm. Comp. field.';
                }
                field("Qty. on Assembly Order"; Rec."Qty. on Assembly Order")
                {
                    ToolTip = 'Specifies how many units of the item are allocated to assembly orders, which is how many are listed on outstanding assembly order headers.';
                }
                field("Qty. on Asm. Component"; Rec."Qty. on Asm. Component")
                {
                    ToolTip = 'Specifies how many units of the item are allocated as assembly components, which means how many are listed on outstanding assembly order lines.';
                }
                field("Qty. on Job Order"; Rec."Qty. on Job Order")
                {
                    ToolTip = 'Specifies how many units of the item are allocated to jobs, meaning listed on outstanding job planning lines.';
                }
                field("Res. Qty. on Job Order"; Rec."Res. Qty. on Job Order")
                {
                    ToolTip = 'Specifies the value of the Res. Qty. on Job Order field.';
                }
                field(GTIN; Rec.GTIN)
                {
                    ToolTip = 'Specifies the Global Trade Item Number (GTIN) for the item. For example, the GTIN is used with bar codes to track items, and when sending and receiving documents electronically. The GTIN number typically contains a Universal Product Code (UPC), or European Article Number (EAN).';
                }
                field("Default Deferral Template Code"; Rec."Default Deferral Template Code")
                {
                    ToolTip = 'Specifies how revenue or expenses for the item are deferred to other accounting periods by default.';
                }
                field("Low-Level Code"; Rec."Low-Level Code")
                {
                    ToolTip = 'Specifies the value of the Low-Level Code field.';
                }
                field("Lot Size"; Rec."Lot Size")
                {
                    ToolTip = 'Specifies the default number of units of the item that are processed in one production operation. This affects standard cost calculations and capacity planning. If the item routing includes fixed costs such as setup time, the value in this field is used to calculate the standard cost and distribute the setup costs. During demand planning, this value is used together with the value in the Default Dampener % field to ignore negligible changes in demand and avoid re-planning. Note that if you leave the field blank, it will be threated as 1.';
                }
                field("Serial Nos."; Rec."Serial Nos.")
                {
                    ToolTip = 'Specifies a number series code to assign consecutive serial numbers to items produced.';
                }
                field("Last Unit Cost Calc. Date"; Rec."Last Unit Cost Calc. Date")
                {
                    ToolTip = 'Specifies the value of the Last Unit Cost Calc. Date field.';
                }
                field("Rolled-up Material Cost"; Rec."Rolled-up Material Cost")
                {
                    ToolTip = 'Specifies the value of the Rolled-up Material Cost field.';
                }
                field("Rolled-up Capacity Cost"; Rec."Rolled-up Capacity Cost")
                {
                    ToolTip = 'Specifies the value of the Rolled-up Capacity Cost field.';
                }
                field("Scrap %"; Rec."Scrap %")
                {
                    ToolTip = 'Specifies the percentage of the item that you expect to be scrapped in the production process.';
                }
                field("Inventory Value Zero"; Rec."Inventory Value Zero")
                {
                    ToolTip = 'Specifies whether the item on inventory must be excluded from inventory valuation. This is relevant if the item is kept on inventory on someone else''s behalf.';
                }
                field("Discrete Order Quantity"; Rec."Discrete Order Quantity")
                {
                    ToolTip = 'Specifies the value of the Discrete Order Quantity field.';
                }
                field("Minimum Order Quantity"; Rec."Minimum Order Quantity")
                {
                    ToolTip = 'Specifies a minimum allowable quantity for an item order proposal.';
                }
                field("Maximum Order Quantity"; Rec."Maximum Order Quantity")
                {
                    ToolTip = 'Specifies a maximum allowable quantity for an item order proposal.';
                }
                field("Safety Stock Quantity"; Rec."Safety Stock Quantity")
                {
                    ToolTip = 'Specifies a quantity of stock to have in inventory to protect against supply-and-demand fluctuations during replenishment lead time.';
                }
                field("Order Multiple"; Rec."Order Multiple")
                {
                    ToolTip = 'Specifies a parameter used by the planning system to modify the quantity of planned supply orders.';
                }
                field("Safety Lead Time"; Rec."Safety Lead Time")
                {
                    ToolTip = 'Specifies a date formula to indicate a safety lead time that can be used as a buffer period for production and other delays.';
                }
                field("Flushing Method"; Rec."Flushing Method")
                {
                    ToolTip = 'Specifies how consumption of the item (component) is calculated and handled in production processes. Manual: Enter and post consumption in the consumption journal manually. Forward: Automatically posts consumption according to the production order component lines when the first operation starts. Backward: Automatically calculates and posts consumption according to the production order component lines when the production order is finished. Pick + Forward / Pick + Backward: Variations with warehousing.';
                }
                field("Replenishment System"; Rec."Replenishment System")
                {
                    ToolTip = 'Specifies the type of supply order created by the planning system when the item needs to be replenished.';
                }
                field("Scheduled Receipt (Qty.)"; Rec."Scheduled Receipt (Qty.)")
                {
                    ToolTip = 'Specifies the value of the Scheduled Receipt (Qty.) field.';
                }
                field("Scheduled Need (Qty.)"; Rec."Scheduled Need (Qty.)")
                {
                    ToolTip = 'Specifies the value of the Scheduled Need (Qty.) field.';
                }
                field("Rounding Precision"; Rec."Rounding Precision")
                {
                    ToolTip = 'Specifies how calculated consumption quantities are rounded when entered on consumption journal lines.';
                }
                field("Sales Unit of Measure"; Rec."Sales Unit of Measure")
                {
                    ToolTip = 'Specifies the unit of measure code used when you sell the item.';
                }
                field("Purch. Unit of Measure"; Rec."Purch. Unit of Measure")
                {
                    ToolTip = 'Specifies the unit of measure code used when you purchase the item.';
                }
                field("Time Bucket"; Rec."Time Bucket")
                {
                    ToolTip = 'Specifies a time period that defines the recurring planning horizon used with Fixed Reorder Qty. or Maximum Qty. reordering policies.';
                }
                field("Reserved Qty. on Prod. Order"; Rec."Reserved Qty. on Prod. Order")
                {
                    ToolTip = 'Specifies the value of the Reserved Qty. on Prod. Order field.';
                }
                field("Res. Qty. on Prod. Order Comp."; Rec."Res. Qty. on Prod. Order Comp.")
                {
                    ToolTip = 'Specifies the value of the Res. Qty. on Prod. Order Comp. field.';
                }
                field("Res. Qty. on Req. Line"; Rec."Res. Qty. on Req. Line")
                {
                    ToolTip = 'Specifies the value of the Res. Qty. on Req. Line field.';
                }
                field("Reordering Policy"; Rec."Reordering Policy")
                {
                    ToolTip = 'Specifies the reordering policy.';
                }
                field("Include Inventory"; Rec."Include Inventory")
                {
                    ToolTip = 'Specifies that the inventory quantity is included in the projected available balance when replenishment orders are calculated.';
                }
                field("Manufacturing Policy"; Rec."Manufacturing Policy")
                {
                    ToolTip = 'Specifies if additional orders for any related components are calculated.';
                }
                field("Rescheduling Period"; Rec."Rescheduling Period")
                {
                    ToolTip = 'Specifies a period within which any suggestion to change a supply date always consists of a Reschedule action and never a Cancel + New action.';
                }
                field("Lot Accumulation Period"; Rec."Lot Accumulation Period")
                {
                    ToolTip = 'Specifies a period in which multiple demands are accumulated into one supply order when you use the Lot-for-Lot reordering policy.';
                }
                field("Dampener Period"; Rec."Dampener Period")
                {
                    ToolTip = 'Specifies a period of time during which you do not want the planning system to propose to reschedule existing supply orders forward. The dampener period limits the number of insignificant rescheduling of existing supply to a later date if that new date is within the dampener period. The dampener period function is only initiated if the supply can be rescheduled to a later date and not if the supply can be rescheduled to an earlier date. Accordingly, if the suggested new supply date is after the dampener period, then the rescheduling suggestion is not blocked. If the lot accumulation period is less than the dampener period, then the dampener period is dynamically set to equal the lot accumulation period. This is not shown in the value that you enter in the Dampener Period field. The last demand in the lot accumulation period is used to determine whether a potential supply date is in the dampener period. If this field is empty, then the value in the Default Dampener Period field in the Manufacturing Setup window applies. The value that you enter in the Dampener Period field must be a date formula, and one day (1D) is the shortest allowed period.';
                }
                field("Dampener Quantity"; Rec."Dampener Quantity")
                {
                    ToolTip = 'Specifies a dampener quantity to block insignificant change suggestions for an existing supply, if the change quantity is lower than the dampener quantity.';
                }
                field("Overflow Level"; Rec."Overflow Level")
                {
                    ToolTip = 'Specifies a quantity you allow projected inventory to exceed the reorder point, before the system suggests to decrease supply orders.';
                }
                field("Planning Transfer Ship. (Qty)."; Rec."Planning Transfer Ship. (Qty).")
                {
                    ToolTip = 'Specifies the value of the Planning Transfer Ship. (Qty). field.';
                }
                field("Planning Worksheet (Qty.)"; Rec."Planning Worksheet (Qty.)")
                {
                    ToolTip = 'Specifies the value of the Planning Worksheet (Qty.) field.';
                }
                field("Stockkeeping Unit Exists"; Rec."Stockkeeping Unit Exists")
                {
                    ToolTip = 'Specifies that a stockkeeping unit exists for this item.';
                }
                field("Manufacturer Code"; Rec."Manufacturer Code")
                {
                    ToolTip = 'Specifies a code for the manufacturer of the catalog item.';
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ToolTip = 'Specifies the category that the item belongs to. Item categories also contain any assigned item attributes.';
                }
                field("Created From Nonstock Item"; Rec."Created From Nonstock Item")
                {
                    ToolTip = 'Specifies that the item was created from a catalog item.';
                }
                field("Substitutes Exist"; Rec."Substitutes Exist")
                {
                    ToolTip = 'Specifies that a substitute exists for this item.';
                }
                field("Qty. in Transit"; Rec."Qty. in Transit")
                {
                    ToolTip = 'Specifies the quantity of the items that are currently in transit.';
                }
                field("Trans. Ord. Receipt (Qty.)"; Rec."Trans. Ord. Receipt (Qty.)")
                {
                    ToolTip = 'Specifies the quantity of the items that remains to be received but are not yet shipped as the difference between the Quantity and the Quantity Shipped fields.';
                }
                field("Trans. Ord. Shipment (Qty.)"; Rec."Trans. Ord. Shipment (Qty.)")
                {
                    ToolTip = 'Specifies the quantity of the items that remains to be shipped as the difference between the Quantity and the Quantity Shipped fields.';
                }
                field("Purchasing Code"; Rec."Purchasing Code")
                {
                    ToolTip = 'Specifies the code for a special procurement method, such as drop shipment.';
                }
                field("Qty. Assigned to ship"; Rec."Qty. Assigned to ship")
                {
                    ToolTip = 'Specifies the value of the Qty. Assigned to ship field.';
                }
                field("Qty. Picked"; Rec."Qty. Picked")
                {
                    ToolTip = 'Specifies the value of the Qty. Picked field.';
                }
                field("Service Item Group"; Rec."Service Item Group")
                {
                    ToolTip = 'Specifies the code of the service item group that the item belongs to.';
                }
                field("Qty. on Service Order"; Rec."Qty. on Service Order")
                {
                    ToolTip = 'Specifies how many units of the item are allocated to service orders, meaning listed on outstanding service order lines.';
                }
                field("Res. Qty. on Service Orders"; Rec."Res. Qty. on Service Orders")
                {
                    ToolTip = 'Specifies the value of the Res. Qty. on Service Orders field.';
                }
                field("Item Tracking Code"; Rec."Item Tracking Code")
                {
                    ToolTip = 'Specifies how serial or lot numbers assigned to the item are tracked in the supply chain.';
                }
                field("Lot Nos."; Rec."Lot Nos.")
                {
                    ToolTip = 'Specifies the number series code that will be used when assigning lot numbers.';
                }
                field("Expiration Calculation"; Rec."Expiration Calculation")
                {
                    ToolTip = 'Specifies the date formula for calculating the expiration date on the item tracking line. Note: This field will be ignored if the involved item has Require Expiration Date Entry set to Yes on the Item Tracking Code page.';
                }
                field("Qty. on Purch. Return"; Rec."Qty. on Purch. Return")
                {
                    ToolTip = 'Specifies the value of the Qty. on Purch. Return field.';
                }
                field("Qty. on Sales Return"; Rec."Qty. on Sales Return")
                {
                    ToolTip = 'Specifies the value of the Qty. on Sales Return field.';
                }
                field("No. of Substitutes"; Rec."No. of Substitutes")
                {
                    ToolTip = 'Specifies the number of substitutions that have been registered for the item.';
                }
                field("Warehouse Class Code"; Rec."Warehouse Class Code")
                {
                    ToolTip = 'Specifies the warehouse class code for the item.';
                }
                field("Special Equipment Code"; Rec."Special Equipment Code")
                {
                    ToolTip = 'Specifies the code of the equipment that warehouse employees must use when handling the item.';
                }
                field("Put-away Template Code"; Rec."Put-away Template Code")
                {
                    ToolTip = 'Specifies the code of the put-away template by which the program determines the most appropriate zone and bin for storage of the item after receipt.';
                }
                field("Put-away Unit of Measure Code"; Rec."Put-away Unit of Measure Code")
                {
                    ToolTip = 'Specifies the code of the item unit of measure in which the program will put the item away.';
                }
                field("Phys Invt Counting Period Code"; Rec."Phys Invt Counting Period Code")
                {
                    ToolTip = 'Specifies the code of the counting period that indicates how often you want to count the item in a physical inventory.';
                }
                field("Last Counting Period Update"; Rec."Last Counting Period Update")
                {
                    ToolTip = 'Specifies the last date on which you calculated the counting period. It is updated when you use the function Calculate Counting Period.';
                }
                field("Last Phys. Invt. Date"; Rec."Last Phys. Invt. Date")
                {
                    ToolTip = 'Specifies the date on which you last posted the results of a physical inventory for the item to the item ledger.';
                }
                field("Use Cross-Docking"; Rec."Use Cross-Docking")
                {
                    ToolTip = 'Specifies if this item can be cross-docked.';
                }
                field("Next Counting Start Date"; Rec."Next Counting Start Date")
                {
                    ToolTip = 'Specifies the starting date of the next counting period.';
                }
                field("Next Counting End Date"; Rec."Next Counting End Date")
                {
                    ToolTip = 'Specifies the ending date of the next counting period.';
                }
                field("Unit Group Exists"; Rec."Unit Group Exists")
                {
                    ToolTip = 'Specifies the value of the Unit Group Exists field.';
                }
                field("Identifier Code"; Rec."Identifier Code")
                {
                    ToolTip = 'Specifies a unique code for the item in terms that are useful for automatic data capture.';
                }
                field("Unit of Measure Id"; Rec."Unit of Measure Id")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure Id field.';
                }
                field("Tax Group Id"; Rec."Tax Group Id")
                {
                    ToolTip = 'Specifies the value of the Tax Group Id field.';
                }
                field("Sales Blocked"; Rec."Sales Blocked")
                {
                    ToolTip = 'Specifies that the item cannot be entered on sales documents, except return orders and credit memos, and journals.';
                }
                field("Purchasing Blocked"; Rec."Purchasing Blocked")
                {
                    ToolTip = 'Specifies that the item cannot be entered on purchase documents, except return orders and credit memos, and journals.';
                }
                field("Item Category Id"; Rec."Item Category Id")
                {
                    ToolTip = 'Specifies the value of the Item Category Id field.';
                }
                field("Inventory Posting Group Id"; Rec."Inventory Posting Group Id")
                {
                    ToolTip = 'Specifies the value of the Inventory Posting Group Id field.';
                }
                field("Gen. Prod. Posting Group Id"; Rec."Gen. Prod. Posting Group Id")
                {
                    ToolTip = 'Specifies the value of the Gen. Prod. Posting Group Id field.';
                }
                field("Over-Receipt Code"; Rec."Over-Receipt Code")
                {
                    ToolTip = 'Specifies the policy that will be used for the item if more items than ordered are received.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
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
                field("Purchase Block"; Rec."Purchase Block")
                {
                    ToolTip = 'Specifies the value of the Purchase Block field.';
                }
                field("Sales Block"; Rec."Sales Block")
                {
                    ToolTip = 'Specifies the value of the Sales Block field.';
                }
                field(SeriesPattern; Rec.SeriesPattern)
                {
                    ToolTip = 'Specifies the value of the SeriesPattern field.';
                }
                field("Lond Description"; Rec."Lond Description")
                {
                    ToolTip = 'Specifies the value of the Lond Description field.';
                }
                field("Vendor Part Code Long"; Rec."Vendor Part Code Long")
                {
                    ToolTip = 'Specifies the value of the Vendor Part Code Long field.';
                }
                field("UPN Code"; Rec."UPN Code")
                {
                    ToolTip = 'Specifies the value of the UPN Code field.';
                }
                field("Sales Points"; Rec."Sales Points")
                {
                    ToolTip = 'Specifies the value of the Sales Points field.';
                }
                field("Inventory at date"; Rec."Inventory at date")
                {
                    ToolTip = 'Specifies the value of the Net Change field.';
                }
                field(SKU1; Rec.SKU1)
                {
                    ToolTip = 'Specifies the value of the SKU1 field.';
                }
                field("Ecommerce Item"; Rec."Ecommerce Item")
                {
                    ToolTip = 'Specifies the value of the Ecommerce Item field.';
                }
                field(Grade; Rec.Grade)
                {
                    ToolTip = 'Specifies the value of the Grade field.';
                }
                field("Old Item No"; Rec."Old Item No")
                {
                    ToolTip = 'Specifies the value of the Old Item No field.';
                }
                field("Last No. Used"; Rec."Last No. Used")
                {
                    ToolTip = 'Specifies the value of the Last No. Used field.';
                }
                field("Sync with WMS"; Rec."Sync with WMS")
                {
                    ToolTip = 'Specifies the value of the Sync with WMS field.';
                }
                field("Old Item No. 2"; Rec."Old Item No. 2")
                {
                    ToolTip = 'Specifies the value of the Old Item No. 2 field.';
                }
                field(COGS; Rec.COGS)
                {
                    ToolTip = 'Specifies the value of the COGS field.';
                }
                field("Ingram Part Code"; Rec."Ingram Part Code")
                {
                    ToolTip = 'Specifies the value of the Ingram Part Code field.';
                }
                field("Product Category"; Rec."Product Category")
                {
                    ToolTip = 'Specifies the value of the Category field.';
                }
                field("PowerBI CompAge"; Rec."PowerBI CompAge")
                {
                    ToolTip = 'Specifies the value of the PowerBI CompAge field.';
                }
                field("PowerBI Amount"; Rec."PowerBI Amount")
                {
                    ToolTip = 'Specifies the value of the PowerBI Amount field.';
                }
                field("Routing No."; Rec."Routing No.")
                {
                    ToolTip = 'Specifies the number of the production routing that the item is used in.';
                }
                field("Production BOM No."; Rec."Production BOM No.")
                {
                    ToolTip = 'Specifies the number of the production BOM that the item represents.';
                }
                field("Single-Level Material Cost"; Rec."Single-Level Material Cost")
                {
                    ToolTip = 'Specifies the value of the Single-Level Material Cost field.';
                }
                field("Single-Level Capacity Cost"; Rec."Single-Level Capacity Cost")
                {
                    ToolTip = 'Specifies the value of the Single-Level Capacity Cost field.';
                }
                field("Single-Level Subcontrd. Cost"; Rec."Single-Level Subcontrd. Cost")
                {
                    ToolTip = 'Specifies the value of the Single-Level Subcontrd. Cost field.';
                }
                field("Single-Level Cap. Ovhd Cost"; Rec."Single-Level Cap. Ovhd Cost")
                {
                    ToolTip = 'Specifies the value of the Single-Level Cap. Ovhd Cost field.';
                }
                field("Single-Level Mfg. Ovhd Cost"; Rec."Single-Level Mfg. Ovhd Cost")
                {
                    ToolTip = 'Specifies the value of the Single-Level Mfg. Ovhd Cost field.';
                }
                field("Overhead Rate"; Rec."Overhead Rate")
                {
                    ToolTip = 'Specifies the item''s indirect cost as an absolute amount.';
                }
                field("Rolled-up Subcontracted Cost"; Rec."Rolled-up Subcontracted Cost")
                {
                    ToolTip = 'Specifies the value of the Rolled-up Subcontracted Cost field.';
                }
                field("Rolled-up Mfg. Ovhd Cost"; Rec."Rolled-up Mfg. Ovhd Cost")
                {
                    ToolTip = 'Specifies the value of the Rolled-up Mfg. Ovhd Cost field.';
                }
                field("Rolled-up Cap. Overhead Cost"; Rec."Rolled-up Cap. Overhead Cost")
                {
                    ToolTip = 'Specifies the value of the Rolled-up Cap. Overhead Cost field.';
                }
                field("Planning Issues (Qty.)"; Rec."Planning Issues (Qty.)")
                {
                    ToolTip = 'Specifies the value of the Planning Issues (Qty.) field.';
                }
                field("Planning Receipt (Qty.)"; Rec."Planning Receipt (Qty.)")
                {
                    ToolTip = 'Specifies the value of the Planning Receipt (Qty.) field.';
                }
                field("Planned Order Receipt (Qty.)"; Rec."Planned Order Receipt (Qty.)")
                {
                    ToolTip = 'Specifies the value of the Planned Order Receipt (Qty.) field.';
                }
                field("FP Order Receipt (Qty.)"; Rec."FP Order Receipt (Qty.)")
                {
                    ToolTip = 'Specifies the value of the FP Order Receipt (Qty.) field.';
                }
                field("Rel. Order Receipt (Qty.)"; Rec."Rel. Order Receipt (Qty.)")
                {
                    ToolTip = 'Specifies the value of the Rel. Order Receipt (Qty.) field.';
                }
                field("Planning Release (Qty.)"; Rec."Planning Release (Qty.)")
                {
                    ToolTip = 'Specifies the value of the Planning Release (Qty.) field.';
                }
                field("Planned Order Release (Qty.)"; Rec."Planned Order Release (Qty.)")
                {
                    ToolTip = 'Specifies the value of the Planned Order Release (Qty.) field.';
                }
                field("Purch. Req. Receipt (Qty.)"; Rec."Purch. Req. Receipt (Qty.)")
                {
                    ToolTip = 'Specifies the value of the Purch. Req. Receipt (Qty.) field.';
                }
                field("Purch. Req. Release (Qty.)"; Rec."Purch. Req. Release (Qty.)")
                {
                    ToolTip = 'Specifies the value of the Purch. Req. Release (Qty.) field.';
                }
                field("Order Tracking Policy"; Rec."Order Tracking Policy")
                {
                    ToolTip = 'Specifies if and how order tracking entries are created and maintained between supply and its corresponding demand.';
                }
                field("Prod. Forecast Quantity (Base)"; Rec."Prod. Forecast Quantity (Base)")
                {
                    ToolTip = 'Specifies the value of the Prod. Forecast Quantity (Base) field.';
                }
                field("Qty. on Prod. Order"; Rec."Qty. on Prod. Order")
                {
                    ToolTip = 'Specifies how many units of the item are allocated to production orders, meaning listed on outstanding production order lines.';
                }
                field("Qty. on Component Lines"; Rec."Qty. on Component Lines")
                {
                    ToolTip = 'Specifies how many units of the item are allocated as production order components, meaning listed under outstanding production order lines.';
                }
                field(Critical; Rec.Critical)
                {
                    ToolTip = 'Specifies if the item is included in availability calculations to promise a shipment date for its parent item.';
                }
                field("Common Item No."; Rec."Common Item No.")
                {
                    ToolTip = 'Specifies the unique common item number that the intercompany partners agree upon.';
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