// page 50029 "Vendor C Form Updation"
// {
//     Caption = 'Vendor C Form Updation';
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     PageType = List;
//     Permissions = TableData 122 = rimd;
//     RefreshOnActivate = true;
//     SourceTable = Table122;
//     SourceTableView = WHERE (State = FILTER (<> MH),
//                             Order No.=CONST(<>''),
//                             Form No.=CONST(''),
//                             Form Code=CONST(<>''));

//     layout
//     {
//         area(content)
//         {
//             repeater(Group)
//             {
//                 field("No."; "No.")
//                 {
//                     Editable = false;
//                 }
//                 field("Posting Date"; "Posting Date")
//                 {
//                     Editable = false;
//                 }
//                 field("Vendor Invoice No."; "Vendor Invoice No.")
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

