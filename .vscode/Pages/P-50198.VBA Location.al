page 50198 "VBA Location"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Location;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies a location code for the warehouse or distribution center where your items are handled and stored before being sold.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the name or address of the location.';
                }
                field("Default Bin Code"; Rec."Default Bin Code")
                {
                    ToolTip = 'Specifies the value of the Default Bin Code field.';
                }
                field("Name 2"; Rec."Name 2")
                {
                    ToolTip = 'Specifies the value of the Name 2 field.';
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the location address.';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ToolTip = 'Specifies additional address information.';
                }
                field(City; Rec.City)
                {
                    ToolTip = 'Specifies the city of the location.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'Specifies the telephone number of the location.';
                }
                field("Phone No. 2"; Rec."Phone No. 2")
                {
                    ToolTip = 'Specifies the value of the Phone No. 2 field.';
                }
                field("Telex No."; Rec."Telex No.")
                {
                    ToolTip = 'Specifies the value of the Telex No. field.';
                }
                field("Fax No."; Rec."Fax No.")
                {
                    ToolTip = 'Specifies the fax number of the location.';
                }
                field(Contact; Rec.Contact)
                {
                    ToolTip = 'Specifies the name of the contact person at the location';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ToolTip = 'Specifies the postal code.';
                }
                field(County; Rec.County)
                {
                    ToolTip = 'Specifies the value of the County field.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ToolTip = 'Specifies the email address of the location.';
                }
                field("Home Page"; Rec."Home Page")
                {
                    ToolTip = 'Specifies the location''s web site.';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ToolTip = 'Specifies the country/region of the address.';
                }
                field("Use As In-Transit"; Rec."Use As In-Transit")
                {
                    ToolTip = 'Specifies that this location is an in-transit location.';
                }
                field("Require Put-away"; Rec."Require Put-away")
                {
                    ToolTip = 'Specifies if the location requires a dedicated warehouse activity when putting items away.';
                }
                field("Require Pick"; Rec."Require Pick")
                {
                    ToolTip = 'Specifies if the location requires a dedicated warehouse activity when picking items.';
                }
                field("Cross-Dock Due Date Calc."; Rec."Cross-Dock Due Date Calc.")
                {
                    ToolTip = 'Specifies the cross-dock due date calculation.';
                }
                field("Use Cross-Docking"; Rec."Use Cross-Docking")
                {
                    ToolTip = 'Specifies if the location supports movement of items directly from the receiving dock to the shipping dock.';
                }
                field("Require Receive"; Rec."Require Receive")
                {
                    ToolTip = 'Specifies if the location requires a receipt document when receiving items.';
                }
                field("Require Shipment"; Rec."Require Shipment")
                {
                    ToolTip = 'Specifies if the location requires a shipment document when shipping items.';
                }
                field("Bin Mandatory"; Rec."Bin Mandatory")
                {
                    ToolTip = 'Specifies if the location requires that a bin code is specified on all item transactions.';
                }
                field("Directed Put-away and Pick"; Rec."Directed Put-away and Pick")
                {
                    ToolTip = 'Specifies if the location requires advanced warehouse functionality, such as calculated bin suggestion.';
                }
                field("Default Bin Selection"; Rec."Default Bin Selection")
                {
                    ToolTip = 'Specifies the method used to select the default bin.';
                }
                field("Outbound Whse. Handling Time"; Rec."Outbound Whse. Handling Time")
                {
                    ToolTip = 'Specifies a date formula for the time it takes to get items ready to ship from this location. The time element is used in the calculation of the delivery date as follows: Shipment Date + Outbound Warehouse Handling Time = Planned Shipment Date + Shipping Time = Planned Delivery Date.';
                }
                field("Inbound Whse. Handling Time"; Rec."Inbound Whse. Handling Time")
                {
                    ToolTip = 'Specifies the time it takes to make items part of available inventory, after the items have been posted as received.';
                }
                field("Put-away Template Code"; Rec."Put-away Template Code")
                {
                    ToolTip = 'Specifies the put-away template to be used at this location.';
                }
                field("Use Put-away Worksheet"; Rec."Use Put-away Worksheet")
                {
                    ToolTip = 'Specifies if put-aways for posted warehouse receipts must be created with the put-away worksheet. If the check box is not selected, put-aways are created directly when you post a warehouse receipt.';
                }
                field("Pick According to FEFO"; Rec."Pick According to FEFO")
                {
                    ToolTip = 'Specifies whether to use the First-Expired-First-Out (FEFO) method to determine which items to pick, according to expiration dates.';
                }
                field("Allow Breakbulk"; Rec."Allow Breakbulk")
                {
                    ToolTip = 'Specifies that an order can be fulfilled with items stored in alternate units of measure, if an item stored in the requested unit of measure is not found.';
                }
                field("Bin Capacity Policy"; Rec."Bin Capacity Policy")
                {
                    ToolTip = 'Specifies how bins are automatically filled, according to their capacity.';
                }
                field("Pick Bin Policy"; Rec."Pick Bin Policy")
                {
                    ToolTip = 'Specifies how bins are automatically selected for inventory picks.';
                }
                field("Check Whse. Class"; Rec."Check Whse. Class")
                {
                    ToolTip = 'Specifies if the warehouse class should be checked.';
                }
                field("Put-away Bin Policy"; Rec."Put-away Bin Policy")
                {
                    ToolTip = 'Specifies how bins are automatically selected for inventory put-away.';
                }
                field("Open Shop Floor Bin Code"; Rec."Open Shop Floor Bin Code")
                {
                    ToolTip = 'Specifies the bin that functions as the default open shop floor bin.';
                }
                field("To-Production Bin Code"; Rec."To-Production Bin Code")
                {
                    ToolTip = 'Specifies the bin in the production area where components picked for production are placed by default, before they can be consumed.';
                }
                field("From-Production Bin Code"; Rec."From-Production Bin Code")
                {
                    ToolTip = 'Specifies the bin in the production area, where finished end items are taken from by default, when the process involves warehouse activity.';
                }
                field("Prod. Consump. Whse. Handling"; Rec."Prod. Consump. Whse. Handling")
                {
                    ToolTip = 'Specifies the warehouse handling for consumption in production scenarios.';
                }
                field("Adjustment Bin Code"; Rec."Adjustment Bin Code")
                {
                    ToolTip = 'Specifies the code of the bin in which you record observed differences in inventory quantities.';
                }
                field("Prod. Output Whse. Handling"; Rec."Prod. Output Whse. Handling")
                {
                    ToolTip = 'Specifies the warehouse handling for output in production scenarios';
                }
                field("Always Create Put-away Line"; Rec."Always Create Put-away Line")
                {
                    ToolTip = 'Specifies that a put-away line is created, even if an appropriate zone and bin in which to place the items cannot be found.';
                }
                field("Always Create Pick Line"; Rec."Always Create Pick Line")
                {
                    ToolTip = 'Specifies that a pick line is created, even if an appropriate zone and bin from which to pick the item cannot be found.';
                }
                field("Special Equipment"; Rec."Special Equipment")
                {
                    ToolTip = 'Specifies where the program will first looks for special equipment designated for warehouse activities.';
                }
                field("Receipt Bin Code"; Rec."Receipt Bin Code")
                {
                    ToolTip = 'Specifies the default receipt bin code.';
                }
                field("Shipment Bin Code"; Rec."Shipment Bin Code")
                {
                    ToolTip = 'Specifies the default shipment bin code.';
                }
                field("Cross-Dock Bin Code"; Rec."Cross-Dock Bin Code")
                {
                    ToolTip = 'Specifies the bin code that is used by default for the receipt of items to be cross-docked.';
                }
                field("To-Assembly Bin Code"; Rec."To-Assembly Bin Code")
                {
                    ToolTip = 'Specifies the bin in the assembly area where components are placed by default before they can be consumed in assembly.';
                }
                field("From-Assembly Bin Code"; Rec."From-Assembly Bin Code")
                {
                    ToolTip = 'Specifies the bin in the assembly area where finished assembly items are posted to when they are assembled to stock.';
                }
                field("Asm.-to-Order Shpt. Bin Code"; Rec."Asm.-to-Order Shpt. Bin Code")
                {
                    ToolTip = 'Specifies the bin where finished assembly items are posted to when they are assembled to a linked sales order.';
                }
                field("To-Job Bin Code"; Rec."To-Job Bin Code")
                {
                    ToolTip = 'Specifies the bin where an item will be put away or picked in warehouse and inventory processes at this location. For example, when you choose this location on a job planning line, this bin will be suggested.';
                }
                field("Asm. Consump. Whse. Handling"; Rec."Asm. Consump. Whse. Handling")
                {
                    ToolTip = 'Specifies the warehouse handling for consumption in assembly scenarios.';
                }
                field("Job Consump. Whse. Handling"; Rec."Job Consump. Whse. Handling")
                {
                    ToolTip = 'Specifies the warehouse handling for consumption in job scenarios.';
                }
                field("Base Calendar Code"; Rec."Base Calendar Code")
                {
                    ToolTip = 'Specifies a customizable calendar for planning that holds the location''s working days and holidays.';
                }
                field("Use ADCS"; Rec."Use ADCS")
                {
                    ToolTip = 'Specifies the automatic data capture system that warehouse employees must use to keep track of items within the warehouse.';
                }
                field("Location Type"; Rec."Location Type")
                {
                    ToolTip = 'Specifies the value of the Location Type field.';
                }
                field("LBT No."; Rec."LBT No.")
                {
                    ToolTip = 'Specifies the value of the LBT No. field.';
                }
                field("Shield Invoice Nos."; Rec."Shield Invoice Nos.")
                {
                    ToolTip = 'Specifies the value of the Shield Invoice Nos. field.';
                }
                field("Posted Shield Invoice Nos."; Rec."Posted Shield Invoice Nos.")
                {
                    ToolTip = 'Specifies the value of the Shield Invoice Nos. field.';
                }
                field("Rental From Location"; Rec."Rental From Location")
                {
                    ToolTip = 'Specifies the value of the Rental From Location field.';
                }
                field("Purchase Order Nos."; Rec."Purchase Order Nos.")
                {
                    ToolTip = 'Specifies the value of the Purchase Order Nos. field.';
                }
                field("Bank Account"; Rec."Bank Account")
                {
                    ToolTip = 'Specifies the value of the Bank Account field.';
                }
                field(Header; Rec.Header)
                {
                    ToolTip = 'Specifies the value of the Header field.';
                }
                field(Footer; Rec.Footer)
                {
                    ToolTip = 'Specifies the value of the Footer field.';
                }
                field("Capillary ID"; Rec."Capillary ID")
                {
                    ToolTip = 'Specifies the value of the Capillary ID field.';
                }
                field("Capillary Password"; Rec."Capillary Password")
                {
                    ToolTip = 'Specifies the value of the Capillary Password field.';
                }
                field("E Com Location Code"; Rec."E Com Location Code")
                {
                    ToolTip = 'Specifies the value of the E Com Location Code field.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                }
                field("POS Apple ID"; Rec."POS Apple ID")
                {
                    ToolTip = 'Specifies the value of the POS Apple ID field.';
                }
                field("E-Invoice User ID"; Rec."E-Invoice User ID")
                {
                    ToolTip = 'Specifies the value of the E-Invoice User ID field.';
                }
                field("E-Invoice Password"; Rec."E-Invoice Password")
                {
                    ToolTip = 'Specifies the value of the E-Invoice Password field.';
                }
                field("Voucher Client ID"; Rec."Voucher Client ID")
                {
                    ToolTip = 'Specifies the value of the Voucher Client ID field.';
                }
                field("Voucher Secret Code"; Rec."Voucher Secret Code")
                {
                    ToolTip = 'Specifies the value of the Voucher Secret Code field.';
                }
                field("Salable Location Code"; Rec."Salable Location Code")
                {
                    ToolTip = 'Specifies the value of the Salable Location Code field.';
                }
                field("Einvoice E-Mail"; Rec."Einvoice E-Mail")
                {
                    ToolTip = 'Specifies the value of the E-Mail field.';
                }
                field("Ingram Location"; Rec."Ingram Location")
                {
                    ToolTip = 'Specifies the value of the Ingram Location field.';
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