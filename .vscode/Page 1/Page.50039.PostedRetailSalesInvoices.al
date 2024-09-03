// page 50039 "Posted Retail Sales Invoices"
// {
//     Caption = 'Posted Sales Invoices';
//     CardPageID = "Posted Retail Sales Invoice";
//     Editable = false;
//     PageType = List;
//     SourceTable = Table112;

//     layout
//     {
//         area(content)
//         {
//             repeater()
//             {
//                 field("Sales Order Type"; "Sales Order Type")
//                 {
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                     Visible = false;
//                 }
//                 field("No."; "No.")
//                 {
//                 }
//                 field("Posting Date"; "Posting Date")
//                 {
//                     Visible = false;
//                 }
//                 field("Sell-to Customer No."; "Sell-to Customer No.")
//                 {
//                 }
//                 field("Sell-to Customer Name"; "Sell-to Customer Name")
//                 {
//                 }
//                 field(Amount; Amount)
//                 {

//                     trigger OnDrillDown()
//                     begin
//                         SETRANGE("No.");
//                         PAGE.RUNMODAL(PAGE::"Posted Sales Invoice", Rec)
//                     end;
//                 }
//                 field("Location Code"; "Location Code")
//                 {
//                     Visible = true;
//                 }
//                 field("Shield Invoice"; "Shield Invoice")
//                 {
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
//                 Visible = true;
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
//                 action(Card)
//                 {
//                     Caption = 'Card';
//                     Image = EditLines;
//                     ShortCutKey = 'Shift+F7';

//                     trigger OnAction()
//                     begin
//                         PAGE.RUN(PAGE::"Posted Sales Invoice", Rec)
//                     end;
//                 }
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
//                                   No.=FIELD(No.);
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
//             }
//         }
//         area(processing)
//         {
//             action("&Print")
//             {
//                 Caption = '&Print';
//                 Ellipsis = true;
//                 Image = Print;
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 var
//                     SalesInvHeader: Record "112";
//                 begin
//                     CurrPage.SETSELECTIONFILTER(SalesInvHeader);
//                     SalesInvHeader.PrintRecords(TRUE);
//                 end;
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
//         //StyleTxt := SetStyle;
//     end;

//     trigger OnOpenPage()
//     begin
//         SetSecurityFilterOnRespCenter;
//     end;
// }

