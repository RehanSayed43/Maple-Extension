// page 50042 "Sales Shield Statistics"
// {
//     PageType = Card;
//     SourceTable = Table36;

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 field(PayByCashAmt; PayByCashAmt)
//                 {
//                     Caption = 'Cash';
//                 }
//                 field(Arpayment[1,3];Arpayment[1,3])
//                 {
//                     Caption = 'Cash after Adjusted for Shield';
//                 }
//                 field(PayByChqAmt;PayByChqAmt)
//                 {
//                     Caption = 'Cheque';
//                 }
//                 field(Arpayment[2,3];Arpayment[2,3])
//                 {
//                 }
//                 field(PayByCreditAmt1;PayByCreditAmt1)
//                 {
//                 }
//                 field(Arpayment[3,3];Arpayment[3,3])
//                 {
//                 }
//                 field(PayByCreditAmt2;PayByCreditAmt2)
//                 {
//                     Caption = 'Credit Card 2';
//                 }
//                 field(Arpayment[4,3];Arpayment[4,3])
//                 {
//                 }
//                 field(PayByCreditAmt3;PayByCreditAmt3)
//                 {
//                     Caption = 'Credit Card 3';
//                 }
//                 field(Arpayment[5,3];Arpayment[5,3])
//                 {
//                 }
//                 field(PayByCreditAmt4;PayByCreditAmt4)
//                 {
//                     Caption = 'Credit Card 4';
//                 }
//                 field(Arpayment[6,3];Arpayment[6,3])
//                 {
//                 }
//                 field(PayByDebitAmt2;PayByDebitAmt2)
//                 {
//                 }
//                 field(Arpayment[7,3];Arpayment[7,3])
//                 {
//                 }
//                 field(PayByDebitCdAmt1;PayByDebitCdAmt1)
//                 {
//                     Caption = 'Debit Card';
//                 }
//                 field(Arpayment[8,3];Arpayment[8,3])
//                 {
//                 }
//                 field(GiftVoucherAmt;GiftVoucherAmt)
//                 {
//                     Caption = 'Gift Voucher';
//                 }
//                 field(Arpayment[9,3];Arpayment[9,3])
//                 {
//                 }
//                 field("RTGS Amount";"RTGS Amount")
//                 {
//                 }
//                 field(Arpayment[10,3];Arpayment[10,3])
//                 {
//                 }
//                 field("Finance Amount";"Finance Amount")
//                 {
//                 }
//                 field(Arpayment[11,3];Arpayment[11,3])
//                 {
//                 }
//                 field("RTGSPay Method Code";"RTGSPay Method Code")
//                 {
//                 }
//                 field("Total Shield Value";"Total Shield Value")
//                 {
//                 }
//                 field("Amount to Customer";"Amount to Customer")
//                 {
//                 }
//                 field(TotalPayByCustomer;TotalPayByCustomer)
//                 {
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnAfterGetRecord()
//     begin
//         CalShieldPayment(Rec);
//     end;

//     trigger OnInit()
//     begin
//          CurrPage.EDITABLE :=FALSE;
//     end;

//     var
//         Arpayment: array [11,4] of Text;
//         "Exact Match": Boolean;
//         ExactID: Integer;
//         TotalShieldValue: Decimal;
//         MaxValue: Decimal;
//         AmountAdjFinished: Boolean;

//     [Scope('Internal')]
//     procedure CalShieldPayment(SalesHeader: Record "36")
//     var
//         SalesHeaderLocal: Record "36";
//         SalesLineLocal: Record "37";
//         TotalShieldPayment: Decimal;
//         i: Integer;
//         j: Integer;
//         PendingAmt: Decimal;
//         Amount: Decimal;
//     begin
//         //SalesHeaderLocal.GET(SalesHeader."Document Type",SalesHeader."No.");
//         WITH SalesHeader DO BEGIN
//         SalesLineLocal.SETFILTER("Document Type",'%1',"Document Type");
//         SalesLineLocal.SETFILTER("Document No.",'%1',"No.");
//         SalesLineLocal.SETFILTER(Shield,'%1',TRUE);
//         IF SalesLineLocal.FINDFIRST THEN BEGIN
//           REPEAT
//             TotalShieldValue := TotalShieldValue + SalesLineLocal."Shield Value";
//           UNTIL SalesLineLocal.NEXT = 0;

//            IF TotalShieldValue = 0 THEN
//             ERROR('Shield Value is 0');

//           IF TotalShieldValue <> 0 THEN BEGIN
//            i := 0; j:=0;
//             FOR i:=1 TO 11 DO BEGIN
//                 FOR j:=1 TO 4 DO BEGIN
//                    Arpayment[i,j] :='';
//                 END;
//             END;
//           END;
//           i := 1;j:=1;
//           IF PayByCashAmt <> 0 THEN BEGIN
//             IF TotalShieldValue = PayByCashAmt THEN  BEGIN
//               "Exact Match" := TRUE;
//               //ExactID := i;
//               Arpayment[i,j] := FORMAT('Cash'); j:= j+1;
//               Arpayment[i,j] := FORMAT(PayByCashAmt); j:= j+1;
//               Arpayment[i,j] := FORMAT(PayByCashAmt-TotalShieldValue);j:= j+1;
//               Arpayment[i,j] := '1';
//             END
//             ELSE BEGIN
//               IF PayByCashAmt > MaxValue THEN
//                 MaxValue :=PayByCashAmt;
//                 Arpayment[i,j] := FORMAT('Cash');j:= j+1;
//                 Arpayment[i,j] := FORMAT(PayByCashAmt);j:= j+1;
//                 Arpayment[i,j] := FORMAT(PayByCashAmt);j:= j+1;
//                 Arpayment[i,j] := '0';
//             END;
//           END;
//           i := i+1; j:= 1;
//           IF PayByChqAmt <> 0 THEN BEGIN
//             IF (TotalShieldValue =  PayByChqAmt) AND NOT "Exact Match"  THEN  BEGIN
//               "Exact Match" := TRUE;
//               //ExactID := i;
//               Arpayment[i,j] := FORMAT('Cheque');j:= j+1;
//               Arpayment[i,j] := FORMAT( PayByChqAmt); j:= j+1;
//               Arpayment[i,j] := FORMAT( PayByChqAmt-TotalShieldValue); j:= j+1;
//               Arpayment[i,j] := '1';
//             END
//             ELSE BEGIN
//               IF PayByChqAmt > MaxValue THEN
//                 MaxValue :=PayByChqAmt;
//                 Arpayment[i,j] := FORMAT('Cheque');j:= j+1;
//                 Arpayment[i,j] := FORMAT(PayByChqAmt);j:= j+1;
//                 Arpayment[i,j] := FORMAT(PayByChqAmt);j:= j+1;
//                 Arpayment[i,j] := '0';
//             END;
//           END;
//            i := i+1; j:= 1;
//           IF PayByCreditAmt1 <> 0 THEN BEGIN
//             IF (TotalShieldValue = PayByCreditAmt1) AND NOT "Exact Match"  THEN  BEGIN
//               "Exact Match" := TRUE;
//               //ExactID := i;
//               Arpayment[i,j] := FORMAT('Credit Card 1');j:= j+1;
//               Arpayment[i,j] := FORMAT(PayByCreditAmt1); j:= j+1;
//               Arpayment[i,j] := FORMAT(PayByCreditAmt1-TotalShieldValue);j:= j+1;
//               Arpayment[i,j] := '1';
//             END
//             ELSE BEGIN
//               IF PayByCreditAmt1 > MaxValue THEN
//                 MaxValue :=PayByCreditAmt1;
//                 Arpayment[i,j] := FORMAT('Credit Card 1');j:= j+1;
//                 Arpayment[i,j] := FORMAT(PayByCreditAmt1);j:= j+1;
//                 Arpayment[i,j] := FORMAT(PayByCreditAmt1);j:= j+1;
//                 Arpayment[i,j] := '0';
//             END;
//           END;
//            i := i+1; j:= 1;
//           IF PayByCreditAmt2 <> 0 THEN BEGIN
//             IF (TotalShieldValue = PayByCreditAmt2) AND NOT "Exact Match"  THEN  BEGIN
//               "Exact Match" := TRUE;
//               //ExactID := i;
//               Arpayment[i,j] := FORMAT('Credit Card 2');j:= j+1;
//               Arpayment[i,j] := FORMAT(PayByCreditAmt2);j:= j+1;
//               Arpayment[i,j] := FORMAT(PayByCreditAmt2-TotalShieldValue);j:= j+1;
//               Arpayment[i,j] := '1';
//             END
//             ELSE BEGIN
//               IF PayByCreditAmt2 > MaxValue THEN
//                 MaxValue :=PayByCreditAmt2;
//                 Arpayment[i,j] := FORMAT('Credit Card 2');j:= j+1;
//                 Arpayment[i,j] := FORMAT(PayByCreditAmt2);j:= j+1;
//                 Arpayment[i,j] := FORMAT(PayByCreditAmt2);j:= j+1;
//                 Arpayment[i,j] := '0';
//             END;
//           END;
//             i := i+1; j:= 1;
//           IF PayByCreditAmt3 <> 0 THEN BEGIN
//             IF (TotalShieldValue = PayByCreditAmt3) AND NOT "Exact Match"  THEN  BEGIN
//               "Exact Match" := TRUE;
//               //ExactID := i;
//               Arpayment[i,j] := FORMAT('Credit Card 3');j:= j+1;
//               Arpayment[i,j] := FORMAT(PayByCreditAmt3);j:= j+1;
//               Arpayment[i,j] := FORMAT(PayByCreditAmt3-TotalShieldValue);j:= j+1;
//               Arpayment[i,j] := '1';
//             END
//             ELSE BEGIN
//               IF PayByCreditAmt3 > MaxValue THEN
//                 MaxValue :=PayByCreditAmt3;
//                 Arpayment[i,j] := FORMAT('Credit Card 3');j:= j+1;
//                 Arpayment[i,j] := FORMAT(PayByCreditAmt3);j:= j+1;
//                 Arpayment[i,j] := FORMAT(PayByCreditAmt3); j:= j+1;
//                 Arpayment[i,j] := '0';
//             END;
//           END;
//           i := i+1; j:= 1;
//           IF PayByCreditAmt4 <> 0 THEN BEGIN
//             IF (TotalShieldValue = PayByCreditAmt1) AND NOT "Exact Match"  THEN  BEGIN
//               "Exact Match" := TRUE;
//               //ExactID := i;
//               Arpayment[i,j] := FORMAT('Credit Card 4'); j:= j+1;
//               Arpayment[i,j] := FORMAT(PayByCreditAmt4);j:= j+1;
//               Arpayment[i,j] := FORMAT(PayByCreditAmt4-TotalShieldValue);j:= j+1;
//               Arpayment[i,j] := '1';
//             END
//             ELSE BEGIN
//               IF PayByCreditAmt4 > MaxValue THEN
//                 MaxValue :=PayByCreditAmt4;
//                 Arpayment[i,j] := FORMAT('Credit Card 4'); j:= j+1;
//                 Arpayment[i,j] := FORMAT(PayByCreditAmt4);j:= j+1;
//                 Arpayment[i,j] := FORMAT(PayByCreditAmt4);j:= j+1;
//                 Arpayment[i,j] := '0';
//             END;
//           END;
//           i := i+1; j:= 1;
//           IF PayByDebitAmt2 <> 0 THEN BEGIN
//             IF (TotalShieldValue = PayByDebitAmt2) AND NOT "Exact Match"  THEN  BEGIN
//               "Exact Match" := TRUE;
//               //ExactID := i;
//               Arpayment[i,j] := FORMAT('Credit Card 5'); j:= j+1;
//               Arpayment[i,j] := FORMAT(PayByDebitAmt2); j:= j+1;
//               Arpayment[i,j] := FORMAT(PayByDebitAmt2-TotalShieldValue);j:= j+1;
//               Arpayment[i,j] := '1';
//             END
//             ELSE BEGIN
//               IF PayByDebitAmt2 > MaxValue THEN
//                 MaxValue :=PayByDebitAmt2;
//                 Arpayment[i,j] := FORMAT('Credit Card 5');j:= j+1;
//                 Arpayment[i,j] := FORMAT(PayByDebitAmt2);j:= j+1;
//                 Arpayment[i,j] := FORMAT(PayByDebitAmt2); j:= j+1;
//                 Arpayment[i,j] := '0';
//             END;
//           END;
//             i := i+1; j:= 1;
//           IF PayByDebitCdAmt1 <> 0 THEN BEGIN
//             IF (TotalShieldValue =PayByDebitCdAmt1) AND NOT "Exact Match"  THEN  BEGIN
//               "Exact Match" := TRUE;
//               //ExactID := i;
//               Arpayment[i,j] := FORMAT('Debit Card');j:= j+1;
//               Arpayment[i,j] := FORMAT(PayByDebitCdAmt1);j:= j+1;
//               Arpayment[i,j] := FORMAT(PayByDebitCdAmt1-TotalShieldValue); j:= j+1;
//               Arpayment[i,j] := '1';
//             END
//             ELSE BEGIN
//               IF PayByDebitCdAmt1 > MaxValue THEN
//                 MaxValue :=PayByDebitCdAmt1;
//                 Arpayment[i,j] := FORMAT('Debit Card');j:= j+1;
//                 Arpayment[i,j] := FORMAT(PayByDebitCdAmt1);j:= j+1;
//                 Arpayment[i,j] := FORMAT(PayByDebitCdAmt1);j:= j+1;
//                 Arpayment[i,j] := '0';
//             END;
//          END;
//           i := i+1; j:= 1;
//          IF GiftVoucherAmt <> 0 THEN BEGIN
//             IF (TotalShieldValue = GiftVoucherAmt) AND NOT "Exact Match"  THEN  BEGIN
//               "Exact Match" := TRUE;
//               //ExactID := i;
//               Arpayment[i,j] := FORMAT('Gift Voucher');j:= j+1;
//               Arpayment[i,j] := FORMAT(GiftVoucherAmt);j:= j+1;
//               Arpayment[i,j] := FORMAT(GiftVoucherAmt-TotalShieldValue);j:= j+1;
//               Arpayment[i,j] := '1';
//             END
//             ELSE BEGIN
//               IF GiftVoucherAmt > MaxValue THEN
//                 MaxValue :=GiftVoucherAmt;
//                 Arpayment[i,j] := FORMAT('Gift Voucher');j:= j+1;
//                 Arpayment[i,j] := FORMAT(GiftVoucherAmt);j:= j+1;
//                 Arpayment[i,j] := FORMAT(GiftVoucherAmt);j:= j+1;
//                 Arpayment[i,j] := '0';
//             END;
//          END;
//             i := i+1; j:= 1;
//           IF "RTGS Amount" <> 0 THEN BEGIN
//             IF (TotalShieldValue = "RTGS Amount") AND NOT "Exact Match"  THEN  BEGIN
//               "Exact Match" := TRUE;
//               //ExactID := i;
//               Arpayment[i,j] := FORMAT('RTGS');j:= j+1;
//               Arpayment[i,j] := FORMAT("RTGS Amount");j:= j+1;
//               Arpayment[i,j] := FORMAT("RTGS Amount"-TotalShieldValue); j:= j+1;
//               Arpayment[i,j] := '1';
//             END
//             ELSE BEGIN
//               IF "RTGS Amount" > MaxValue THEN
//                 MaxValue :="RTGS Amount";
//                 Arpayment[i,j] := FORMAT('RTGS');j:= j+1;
//                 Arpayment[i,j] := FORMAT("RTGS Amount");j:= j+1;
//                 Arpayment[i,j] := FORMAT("RTGS Amount");j:= j+1;
//                 Arpayment[i,j] := '0';
//             END;
//          END;
//             i := i+1; j:= 1;

//           IF "Finance Amount" <> 0 THEN BEGIN
//             IF (TotalShieldValue = "Finance Amount") AND NOT "Exact Match"  THEN  BEGIN
//               "Exact Match" := TRUE;
//               //ExactID := i;
//               Arpayment[i,j] := FORMAT('Finance'); j:= j+1;
//               Arpayment[i,j] := FORMAT("Finance Amount");j:= j+1;
//               Arpayment[i,j] := FORMAT("Finance Amount"-TotalShieldValue);j:= j+1;
//               Arpayment[i,j] := '1';
//             END
//             ELSE BEGIN
//               IF "Finance Amount" > MaxValue THEN
//                 MaxValue :="Finance Amount";
//                 Arpayment[i,j] := FORMAT('Finance');
//                 Arpayment[i,j] := FORMAT("Finance Amount"); j:= j+1;
//                 Arpayment[i,j] := FORMAT("Finance Amount");j:= j+1;
//                 Arpayment[i,j] := '0';
//             END;
//            END;
//          AmountAdjFinished:= FALSE;

//            IF NOT "Exact Match" THEN BEGIN
//               IF MaxValue > TotalShieldValue THEN BEGIN
//                 FOR i:=1 TO 11 DO BEGIN
//                  IF Arpayment[i,2]  = FORMAT(MaxValue) THEN BEGIN
//                     Arpayment[i,3] := FORMAT(MaxValue-TotalShieldValue);
//                     Arpayment[i,4] := '1';
//                     AmountAdjFinished := TRUE;
//                   END;
//                 END;
//               END
//               ELSE BEGIN
//                 PendingAmt :=TotalShieldValue;
//                 FOR i:=1 TO 11 DO BEGIN
//                  IF (PendingAmt >0) AND (Arpayment[i,2] <> '') THEN BEGIN
//                     EVALUATE(Amount,Arpayment[i,2] );
//                     IF PendingAmt > Amount THEN
//                       Arpayment[i,3] := FORMAT(0)
//                     ELSE
//                       Arpayment[i,3] := FORMAT(Amount-PendingAmt);
//                     Arpayment[i,4] := '1';
//                     PendingAmt := PendingAmt - Amount;
//                  END
//                  ELSE
//                   EXIT;
//                 END;
//               END;
//            END
//            ELSE
//             AmountAdjFinished := TRUE;
//            IF AmountAdjFinished THEN
//               "Shield Payment Amount" := TotalShieldValue;
//         //SalesHeader.MODIFY;
//         END; //SALES LINE
//         END; //SALESHEADER
//     end;
// }

