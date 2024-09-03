// page 50097 "Capillary Unposted Sales Inv"
// {
//     Caption = 'Capillary Not Posted Sales Invoices';
//     CardPageID = "Posted Sales Invoice";
//     Editable = false;
//     PageType = List;
//     PromotedActionCategories = 'New,Process,Report,Invoice,Navigate';
//     SourceTable = 112;
//   //  SourceTableView = WHERE("Ref. Invoice No."=FILTER(=''));//tk

//     layout
//     {
//         area(content)
//         {
//             repeater()
//             {
//                 field("Sales Order Type";"Sales Order Type")
//                 {
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field("Order No.";"Order No.")
//                 {
//                 }
//                 field("No.";"No.")
//                 {
//                 }
//                 field("Posting Date";"Posting Date")
//                 {
//                     Visible = true;
//                 }
//                 field("Capillary Error";"Capillary Error")
//                 {
//                 }
//                 field("Sell-to Customer No.";"Sell-to Customer No.")
//                 {
//                 }
//                 field("Sell-to Customer Name";"Sell-to Customer Name")
//                 {
//                 }
//                 field("Cust. Mobile No.";"Cust. Mobile No.")
//                 {
//                 }
//                 field("Cust. email ID";"Cust. email ID")
//                 {
//                 }
//                 field("Currency Code";"Currency Code")
//                 {
//                     Visible = false;
//                 }
//                 field(Amount;Amount)
//                 {

//                     trigger OnDrillDown()
//                     begin
//                         SETRANGE("No.");
//                         PAGE.RUNMODAL(PAGE::"Posted Sales Invoice",Rec)
//                     end;
//                 }
//                 field("Gross Amount";"Amount to Customer")
//                 {
//                     Caption = 'Gross Amount';
//                 }
//                 field("Amount Including VAT";"Amount Including VAT")
//                 {

//                     trigger OnDrillDown()
//                     begin
//                         SETRANGE("No.");
//                         PAGE.RUNMODAL(PAGE::"Posted Sales Invoice",Rec)
//                     end;
//                 }
//                 field("Sell-to Post Code";"Sell-to Post Code")
//                 {
//                     Visible = false;
//                 }
//                 field("Sell-to Country/Region Code";"Sell-to Country/Region Code")
//                 {
//                     Visible = false;
//                 }
//                 field("Sell-to Contact";"Sell-to Contact")
//                 {
//                     Visible = false;
//                 }
//                 field("Bill-to Customer No.";"Bill-to Customer No.")
//                 {
//                     Visible = false;
//                 }
//                 field("Bill-to Name";"Bill-to Name")
//                 {
//                     Visible = false;
//                 }
//                 field("Bill-to Post Code";"Bill-to Post Code")
//                 {
//                     Visible = false;
//                 }
//                 field("Bill-to Country/Region Code";"Bill-to Country/Region Code")
//                 {
//                     Visible = false;
//                 }
//                 field("Bill-to Contact";"Bill-to Contact")
//                 {
//                     Visible = false;
//                 }
//                 field("Ship-to Code";"Ship-to Code")
//                 {
//                     Visible = false;
//                 }
//                 field("Ship-to Name";"Ship-to Name")
//                 {
//                     Visible = false;
//                 }
//                 field("Ship-to Post Code";"Ship-to Post Code")
//                 {
//                     Visible = false;
//                 }
//                 field("Ship-to Country/Region Code";"Ship-to Country/Region Code")
//                 {
//                     Visible = false;
//                 }
//                 field("Ship-to Contact";"Ship-to Contact")
//                 {
//                     Visible = false;
//                 }
//                 field("Salesperson Code";"Salesperson Code")
//                 {
//                     Visible = false;
//                 }
//                 field("Shortcut Dimension 1 Code";"Shortcut Dimension 1 Code")
//                 {
//                     Visible = false;
//                 }
//                 field("Shortcut Dimension 2 Code";"Shortcut Dimension 2 Code")
//                 {
//                     Visible = false;
//                 }
//                 field("Location Code";"Location Code")
//                 {
//                     Visible = true;
//                 }
//                 field("No. Printed";"No. Printed")
//                 {
//                     Visible = false;
//                 }
//                 field("Document Date";"Document Date")
//                 {
//                     Visible = false;
//                 }
//                 field("Payment Terms Code";"Payment Terms Code")
//                 {
//                     Visible = false;
//                 }
//                 field("Due Date";"Due Date")
//                 {
//                     Visible = false;
//                 }
//                 field("Payment Discount %";"Payment Discount %")
//                 {
//                     Visible = false;
//                 }
//                 field("Shipment Method Code";"Shipment Method Code")
//                 {
//                     Visible = false;
//                 }
//                 field("Shipment Date";"Shipment Date")
//                 {
//                     Visible = false;
//                 }
//                 field(Shield;Shield)
//                 {
//                 }
//                 field("Document Exchange Status";"Document Exchange Status")
//                 {
//                     StyleExpr = DocExchStatusStyle;

//                     trigger OnDrillDown()
//                     begin
//                         DocExchStatusDrillDown;
//                     end;
//                 }
//                 field("Invoice Type";"Invoice Type")
//                 {
//                 }
//                 field("Coupled to CRM";"Coupled to CRM")
//                 {
//                     Visible = CRMIntegrationEnabled;
//                 }
//             }
//         }
//         area(factboxes)
//         {
//             part(IncomingDocAttachFactBox;193)
//             {
//                 ShowFilter = false;
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
//                         PAGE.RUN(PAGE::"Posted Sales Invoice",Rec)
//                     end;
//                 }
//                 action(Statistics)
//                 {
//                     Caption = 'Statistics';
//                     Image = Statistics;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedIsBig = true;
//                     RunObject = Page 397;
//                                     RunPageLink = No.=FIELD(No.);
//                     ShortCutKey = 'F7';
//                 }
//                 action("Co&mments")
//                 {
//                     Caption = 'Co&mments';
//                     Image = ViewComments;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedIsBig = true;
//                     RunObject = Page 67;
//                                     RunPageLink = Document Type=CONST(Posted Invoice),
//                                   No.=FIELD(No.);
//                 }
//                 action(Dimensions)
//                 {
//                     AccessByPermission = TableData 348=R;
//                     Caption = 'Dimensions';
//                     Image = Dimensions;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedIsBig = true;
//                     ShortCutKey = 'Shift+Ctrl+D';

//                     trigger OnAction()
//                     begin
//                         ShowDimensions;
//                     end;
//                 }
//                 action("Mail Invoice to Customer")
//                 {
//                     Promoted = true;
//                     PromotedIsBig = true;

//                     trigger OnAction()
//                     begin
//                         WBU.SendMailtoCustomerwithAttachment(Rec);
//                     end;
//                 }
//                 action(IncomingDoc)
//                 {
//                     AccessByPermission = TableData 130=R;
//                     Caption = 'Incoming Document';
//                     Image = Document;
//                     Promoted = true;
//                     PromotedCategory = Category4;

//                     trigger OnAction()
//                     var
//                         IncomingDocument: Record "130";
//                     begin
//                         IncomingDocument.ShowCard("No.","Posting Date");
//                     end;
//                 }
//             }
//             group(ActionGroupCRM)
//             {
//                 Caption = 'Dynamics CRM';
//                 Visible = CRMIntegrationEnabled;
//                 action(CRMGotoInvoice)
//                 {
//                     Caption = 'Invoice';
//                     Enabled = CRMIsCoupledToRecord;
//                     Image = CoupledInvoice;
//                     ToolTip = 'Open the coupled Microsoft Dynamics CRM account.';

//                     trigger OnAction()
//                     var
//                         CRMIntegrationManagement: Codeunit "5330";
//                     begin
//                         CRMIntegrationManagement.ShowCRMEntityFromRecordID(RECORDID);
//                     end;
//                 }
//                 action(CreateInCRM)
//                 {
//                     Caption = 'Create Invoice in Dynamics CRM';
//                     Enabled = NOT CRMIsCoupledToRecord;
//                     Image = NewInvoice;

//                     trigger OnAction()
//                     var
//                         SalesInvoiceHeader: Record "112";
//                         CRMIntegrationManagement: Codeunit "5330";
//                         SalesInvoiceHeaderRecordRef: RecordRef;
//                     begin
//                         CurrPage.SETSELECTIONFILTER(SalesInvoiceHeader);
//                         SalesInvoiceHeader.NEXT;

//                         IF SalesInvoiceHeader.COUNT = 1 THEN
//                           CRMIntegrationManagement.CreateNewRecordInCRM(RECORDID,FALSE)
//                         ELSE BEGIN
//                           SalesInvoiceHeaderRecordRef.GETTABLE(SalesInvoiceHeader);
//                           CRMIntegrationManagement.CreateNewRecordsInCRM(SalesInvoiceHeaderRecordRef);
//                         END;
//                     end;
//                 }
//             }
//         }
//         area(processing)
//         {
//             action(SendCustom)
//             {
//                 Caption = 'Send';
//                 Ellipsis = true;
//                 Image = SendToMultiple;
//                 Promoted = true;
//                 PromotedCategory = Category4;
//                 PromotedIsBig = true;

//                 trigger OnAction()
//                 var
//                     SalesInvHeader: Record "112";
//                 begin
//                     SalesInvHeader := Rec;
//                     CurrPage.SETSELECTIONFILTER(SalesInvHeader);
//                     // Call SendRecords to open sending profile dialog
//                     SalesInvHeader.SendRecords;
//                 end;
//             }
//             action("&Print")
//             {
//                 Caption = '&Print';
//                 Ellipsis = true;
//                 Image = Print;
//                 //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                 //PromotedCategory = Process;

//                 trigger OnAction()
//                 var
//                     SalesInvHeader: Record "112";
//                 begin
//                     SalesInvHeader := Rec;
//                     CurrPage.SETSELECTIONFILTER(SalesInvHeader);
//                     SalesInvHeader.PrintRecords(TRUE);
//                 end;
//             }
//             action("&Email")
//             {
//                 Caption = '&Email';
//                 Image = Email;
//                 //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                 //PromotedCategory = Process;

//                 trigger OnAction()
//                 var
//                     SalesInvHeader: Record "112";
//                 begin
//                     SalesInvHeader := Rec;
//                     CurrPage.SETSELECTIONFILTER(SalesInvHeader);
//                     SalesInvHeader.EmailRecords(TRUE);
//                 end;
//             }
//             action("&Navigate")
//             {
//                 Caption = '&Navigate';
//                 Image = Navigate;
//                 Promoted = true;
//                 PromotedCategory = Category5;
//                 PromotedIsBig = true;

//                 trigger OnAction()
//                 begin
//                     Navigate;
//                 end;
//             }
//             action(ActivityLog)
//             {
//                 Caption = 'Activity Log';
//                 Image = Log;

//                 trigger OnAction()
//                 var
//                     ActivityLog: Record "710";
//                 begin
//                     ActivityLog.ShowEntries(RECORDID);
//                 end;
//             }
//             action("Print Serial No")
//             {
//                 Caption = 'Print Serial No';
//                 Ellipsis = true;
//                 Image = Print;
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 var
//                     SalesInvHeader: Record "112";
//                 begin
//                     RecpurcLine12.RESET;
//                     RecpurcLine12.SETRANGE(RecpurcLine12."Document No.","No.");
//                     REPORT.RUN(50084,TRUE,TRUE,RecpurcLine12);
//                 end;
//             }
//             action(Taxable)
//             {
//                 Caption = 'Taxable';
//                 Ellipsis = true;
//                 Image = "Filter";
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;

//                 trigger OnAction()
//                 begin
//                     ShowInvoiceTypeDoc("Invoice Type"::Taxable);
//                 end;
//             }
//             action("Bill of Supply")
//             {
//                 Caption = 'Bill of Supply';
//                 Ellipsis = true;
//                 Image = "Filter";
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;

//                 trigger OnAction()
//                 begin
//                     ShowInvoiceTypeDoc("Invoice Type"::"Bill of Supply");
//                 end;
//             }
//             action(Export)
//             {
//                 Caption = 'Export';
//                 Ellipsis = true;
//                 Image = "Filter";
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;

//                 trigger OnAction()
//                 begin
//                     ShowInvoiceTypeDoc("Invoice Type"::Export);
//                 end;
//             }
//             action(Supplementary)
//             {
//                 Caption = 'Supplementary';
//                 Ellipsis = true;
//                 Image = "Filter";
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;

//                 trigger OnAction()
//                 begin
//                     ShowInvoiceTypeDoc("Invoice Type"::Supplementary);
//                 end;
//             }
//             action("Debit Note")
//             {
//                 Caption = 'Debit Note';
//                 Ellipsis = true;
//                 Image = "Filter";
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;

//                 trigger OnAction()
//                 begin
//                     ShowInvoiceTypeDoc("Invoice Type"::"Debit Note");
//                 end;
//             }
//             action("Non GST")
//             {
//                 Caption = 'Non GST';

//                 trigger OnAction()
//                 begin
//                     ShowInvoiceTypeDoc("Invoice Type"::"Non-GST");
//                 end;
//             }
//         }
//     }

//     trigger OnAfterGetCurrRecord()
//     var
//         CRMCouplingManagement: Codeunit "5331";
//     begin
//         DocExchStatusStyle := GetDocExchStatusStyle;
//         CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
//         CRMIsCoupledToRecord := CRMIntegrationEnabled AND CRMCouplingManagement.IsRecordCoupledToCRM(RECORDID);
//     end;

//     trigger OnAfterGetRecord()
//     begin
//         DocExchStatusStyle := GetDocExchStatusStyle;
//          //Updated WIN347++
//         //StyleTxt := SetStyle;
//         CALCFIELDS(Shield);
//         //Updated WIN347--
//     end;

//     trigger OnOpenPage()
//     var
//         CRMIntegrationManagement: Codeunit "CRM Integration Management";
//     begin
//         SetSecurityFilterOnRespCenter;
//         CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
//         FILTERGROUP(2);
//         SETFILTER("Posting Date",'%1..',20171122D);
//         SETRANGE("Capillary Posted",FALSE);
//         SETFILTER("Sales Order Type",'%1',"Sales Order Type"::Retail);
//         SETFILTER("Order No.",'<>%1','');
//         FILTERGROUP(0);
//     end;

//     var
//         DocExchStatusStyle: Text;
//         CRMIntegrationEnabled: Boolean;
//         CRMIsCoupledToRecord: Boolean;
//         RecpurcLine12: Record "113";
//        // WBU: Codeunit "50000";

//     local procedure ShowInvoiceTypeDoc(InvoiceType: Option Taxable,"Bill of Supply",Export,Supplementary,"Debit Notes")
//     var
//         SalesInvHeader: Record 112;
//     begin
//         SETRANGE("Invoice Type",InvoiceType);
//         IF FINDSET THEN
//           PAGE.RUN(PAGE::"Posted Sales Invoices",Rec);
//     end;
// }

