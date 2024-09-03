// page 50028 "Vendor CR C Form Updation"
// {
//     Caption = 'Vendor C Form Updation';
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     PageType = List;
//     Permissions = TableData 122 = rimd;
//     RefreshOnActivate = true;
//     SourceTable = Table124;
//     SourceTableView = WHERE (State = FILTER (<> MH),
//                             Form Code=CONST(<>''),
//                             Form No.=CONST(''));

//     layout
//     {
//         area(content)
//         {
//             repeater(Group)
//             {
//                 field("Buy-from Vendor No."; "Buy-from Vendor No.")
//                 {
//                 }
//                 field("Pay-to Vendor No."; "Pay-to Vendor No.")
//                 {
//                 }
//                 field("Pay-to Name"; "Pay-to Name")
//                 {
//                 }
//                 field("No."; "No.")
//                 {
//                     Editable = false;
//                 }
//                 field("Posting Date"; "Posting Date")
//                 {
//                     Editable = false;
//                 }
//                 field("Document Date"; "Document Date")
//                 {
//                     Caption = 'Vendor Invoice Date';
//                     Editable = false;
//                 }
//                 field("Buy-from Vendor Name"; "Buy-from Vendor Name")
//                 {
//                     Editable = false;
//                 }
//                 field(State; State)
//                 {
//                     Editable = false;
//                 }
//                 field("Amount to Vendor"; "Amount to Vendor")
//                 {
//                 }
//                 field("Form Code"; "Form Code")
//                 {
//                 }
//                 field("Form No."; "Form No.")
//                 {
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(creation)
//         {
//             action("Form- C Used List ")
//             {
//                 Promoted = true;
//                 RunObject = Report 33020853;
//                 Visible = true;
//             }
//             action("Form- C Pending List")
//             {
//                 Image = Print;
//                 Promoted = true;
//                 RunObject = Report 33020854;
//             }
//         }
//     }
// }

