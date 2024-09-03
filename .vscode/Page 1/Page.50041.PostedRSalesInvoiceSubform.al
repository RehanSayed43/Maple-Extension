// page 50041 "Posted R Sales Invoice Subform"
// {
//     AutoSplitKey = true;
//     Caption = 'Lines';
//     Editable = false;
//     LinksAllowed = false;
//     PageType = ListPart;
//     SourceTable = Table113;

//     layout
//     {
//         area(content)
//         {
//             repeater()
//             {
//                 field(Type; Type)
//                 {
//                 }
//                 field("No."; "No.")
//                 {
//                 }
//                 field("Cross-Reference No."; "Cross-Reference No.")
//                 {
//                     Visible = false;
//                 }
//                 field("IC Partner Code"; "IC Partner Code")
//                 {
//                     Visible = false;
//                 }
//                 field("Variant Code"; "Variant Code")
//                 {
//                     Visible = false;
//                 }
//                 field(Description; Description)
//                 {
//                 }
//                 field("Return Reason Code"; "Return Reason Code")
//                 {
//                     Visible = false;
//                 }
//                 field(Quantity; Quantity)
//                 {
//                     BlankZero = true;
//                 }
//                 field("Unit of Measure Code"; "Unit of Measure Code")
//                 {
//                 }
//                 field("Unit of Measure"; "Unit of Measure")
//                 {
//                     Visible = false;
//                 }
//                 field("Unit Cost (LCY)"; "Unit Cost (LCY)")
//                 {
//                     Visible = false;
//                 }
//                 field("Unit Price"; "Unit Price")
//                 {
//                     BlankZero = true;
//                 }
//                 field("Line Amount"; "Line Amount")
//                 {
//                     BlankZero = true;
//                 }
//                 field("Line Discount %"; "Line Discount %")
//                 {
//                     BlankZero = true;
//                 }
//                 field("Line Discount Amount"; "Line Discount Amount")
//                 {
//                     Visible = false;
//                 }
//                 field("Allow Invoice Disc."; "Allow Invoice Disc.")
//                 {
//                     Visible = false;
//                 }
//                 field("Shield Cost"; "Shield Cost")
//                 {
//                     Editable = false;
//                 }
//                 field("Shield Type"; "Shield Type")
//                 {
//                     Editable = false;
//                 }
//                 field("Job No."; "Job No.")
//                 {
//                     Visible = false;
//                 }
//                 field("Appl.-to Item Entry"; "Appl.-to Item Entry")
//                 {
//                     Visible = false;
//                 }
//                 field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
//                 {
//                     Visible = false;
//                 }
//                 field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
//                 {
//                     Visible = false;
//                 }
//                 field("Primary category"; "Primary category")
//                 {
//                     Editable = false;
//                 }
//                 field("Secondary category"; "Secondary category")
//                 {
//                     Editable = false;
//                 }
//                 field("Third category"; "Third category")
//                 {
//                     Editable = false;
//                 }
//                 field("GST Jurisdiction Type"; "GST Jurisdiction Type")
//                 {
//                 }
//                 field("HSN/SAC Code"; "HSN/SAC Code")
//                 {
//                 }
//                 field("GST Group Type"; "GST Group Type")
//                 {
//                 }
//                 field("GST Base Amount"; "GST Base Amount")
//                 {
//                 }
//                 field("GST %"; "GST %")
//                 {
//                 }
//                 field("Total GST Amount"; "Total GST Amount")
//                 {
//                 }
//                 field("GST Group Code"; "GST Group Code")
//                 {
//                 }
//                 field("GST Place of Supply"; "GST Place of Supply")
//                 {
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             group("&Line")
//             {
//                 Caption = '&Line';
//                 Image = Line;
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
//                 action("Co&mments")
//                 {
//                     Caption = 'Co&mments';
//                     Image = ViewComments;

//                     trigger OnAction()
//                     begin
//                         ShowLineComments;
//                     end;
//                 }
//                 action(ItemTrackingEntries)
//                 {
//                     Caption = 'Item &Tracking Entries';
//                     Image = ItemTrackingLedger;

//                     trigger OnAction()
//                     begin
//                         ShowItemTrackingLines;
//                     end;
//                 }
//                 action("Item Shipment &Lines")
//                 {
//                     Caption = 'Item Shipment &Lines';
//                     Image = ShipmentLines;

//                     trigger OnAction()
//                     begin
//                         IF NOT (Type IN [Type::Item, Type::"Charge (Item)"]) THEN
//                             TESTFIELD(Type);
//                         ShowItemShipmentLines;
//                     end;
//                 }
//                 action("Str&ucture Details")
//                 {
//                     Caption = 'Str&ucture Details';
//                     Image = Hierarchy;

//                     trigger OnAction()
//                     begin
//                         // This functionality was copied from page #132. Unsupported part was commented. Please check it.
//                         /*CurrPage.SalesInvLines.PAGE.*/
//                         ShowStrDetailsForm;

//                     end;
//                 }
//             }
//         }
//     }

//     [Scope('Internal')]
//     procedure ShowStrDetailsForm()
//     var
//         SalesInvHeader: Record "112";
//         StrOrderLineDetails: Record "13798";
//         StrOrderLineDetailsForm: Page "16309";
//     begin
//         StrOrderLineDetails.RESET;
//         SalesInvHeader.GET("Document No.");
//         StrOrderLineDetails.SETCURRENTKEY("Invoice No.", Type, "Item No.");
//         StrOrderLineDetails.SETRANGE("Invoice No.", SalesInvHeader."No.");
//         StrOrderLineDetails.SETRANGE(Type, StrOrderLineDetails.Type::Sale);
//         StrOrderLineDetails.SETRANGE("Item No.", "No.");
//         StrOrderLineDetails.SETRANGE("Line No.", "Line No.");
//         StrOrderLineDetailsForm.SETTABLEVIEW(StrOrderLineDetails);
//         StrOrderLineDetailsForm.RUNMODAL;
//     end;

//     [Scope('Internal')]
//     procedure ShowStrOrderDetailsPITForm()
//     begin
//         ShowStrOrderDetailsPIT;
//     end;
// }

