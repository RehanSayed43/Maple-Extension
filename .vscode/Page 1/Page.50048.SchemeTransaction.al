// page 50048 "Scheme Transaction"
// {
//     PageType = Card;
//     SourceTable = Table7;
//     SourceTableView = WHERE (Scheme = CONST (Yes));

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 field(Code; Code)
//                 {
//                     Editable = false;
//                 }
//                 field(Description; Description)
//                 {
//                     Editable = true;
//                 }
//                 field(Scheme; Scheme)
//                 {
//                     Visible = false;
//                 }
//                 field("Item Category Code"; "Item Category Code")
//                 {
//                     Editable = true;
//                 }
//                 field("Product Group Code"; "Product Group Code")
//                 {
//                     Editable = true;
//                 }
//                 field("Starting Date"; "Starting Date")
//                 {
//                     Editable = true;
//                 }
//                 field("Ending Date"; "Ending Date")
//                 {
//                     Editable = true;
//                 }
//                 field("Scheme Vendor"; "Scheme Vendor")
//                 {
//                     Editable = true;
//                 }
//                 field(Open; Open)
//                 {
//                     Editable = false;
//                 }
//                 field(SchItemsEnabled; SchItemsEnabled)
//                 {
//                     Editable = false;
//                     Visible = false;
//                 }
//             }
//             part(; 50047)
//             {
//                 SubPageLink = Scheme Code=FIELD(Code);
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             action(GetItemList)
//             {
//                 Image = Item;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;

//                 trigger OnAction()
//                 begin
//                     UpdateItemList(Code, "Item Category Code", "Product Group Code", "Starting Date", "Ending Date", "Scheme Vendor");
//                 end;
//             }
//             action("Start Scheme")
//             {
//                 Image = SalesLineDisc;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;

//                 trigger OnAction()
//                 begin
//                     IF "Scheme Close Dt" <> 0D THEN
//                         ERROR('Scheme Already Closed');
//                     IF Open THEN
//                         MESSAGE('Scheme Already Started')
//                     ELSE BEGIN
//                         VALIDATE(Open, TRUE);
//                         CurrPage.CLOSE;
//                     END;
//                 end;
//             }
//             action("Close Scheme")
//             {
//                 Image = Cancel;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;

//                 trigger OnAction()
//                 begin
//                     IF CONFIRM('Do you want to Close the Scheme') THEN BEGIN
//                         VALIDATE(Open, FALSE);
//                         "Scheme Close Dt" := WORKDATE;
//                         CurrPage.UPDATE;
//                         CurrPage.CLOSE;
//                     END;
//                 end;
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         CALCFIELDS(SchItemsEnabled);
//         //SchemeHeaderEditable := TRUE;// NOT ( SchItemsEnabled > 0 );
//         //CurrPage.EDITABLE := NOT Open;
//     end;

//     trigger OnInit()
//     begin
//         //CurrPage.EDITABLE := TRUE;
//         //Open := TRUE;
//     end;

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         Scheme := TRUE;
//         //CurrPage.EDITABLE := TRUE;
//         GetNextScheme();
//     end;

//     trigger OnOpenPage()
//     begin
//         IF (Open OR ("Scheme Close Dt" <> 0D)) THEN
//             CurrPage.EDITABLE := FALSE;
//         //Open := TRUE;
//     end;

//     var
//         SchemeHeaderEditable: Boolean;
// }

