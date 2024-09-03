codeunit 50031 UpdateCRTCoupon
{
    Permissions = TableData 113 = rimd;

    trigger OnRun()
    begin
        InvoiceDocumentNo[1] := '5260321220100066';
        InvoiceDocumentNo[2] := '1210321220100048';
        InvoiceDocumentNo[3] := '5260321220100094';
        InvoiceDocumentNo[4] := '5260321220100191';
        InvoiceDocumentNo[5] := '5910321220100027';
        InvoiceDocumentNo[6] := '2103212201000584';
        InvoiceDocumentNo[7] := '5260321220100334';
        InvoiceDocumentNo[8] := '5260321220100339';
        InvoiceDocumentNo[9] := '5910422230100005';
        InvoiceDocumentNo[10] := '2104222301000213';
        InvoiceDocumentNo[11] := '5260422230100169';
        InvoiceDocumentNo[12] := '5260422230100241';
        InvoiceDocumentNo[13] := '5260422230100410';
        InvoiceDocumentNo[14] := '5260522230100040';
        InvoiceDocumentNo[15] := '9105222301000387';
        InvoiceDocumentNo[16] := '5260522230100121';
        InvoiceDocumentNo[17] := '5260522230100216';



        CRTcoponCode[1] := 'crtmaple0000911894';
        CRTcoponCode[2] := 'crtmaple0001168697';
        CRTcoponCode[3] := 'crtmaple0001202101';
        CRTcoponCode[4] := 'crtmaple0001701692';
        CRTcoponCode[5] := 'crtmaple0001902023';
        CRTcoponCode[6] := 'crtmaple0002197550';
        CRTcoponCode[7] := 'crtmaple0002292602';
        CRTcoponCode[8] := 'crtmaple0002551546';
        CRTcoponCode[9] := 'crtmaple0003175277';
        CRTcoponCode[10] := 'crtmaple0003515133';
        CRTcoponCode[11] := 'crtmaple0004085733';
        CRTcoponCode[12] := 'crtmaple0004479330';
        CRTcoponCode[13] := 'cpu discount';
        CRTcoponCode[14] := 'crtmaple0005290214';
        CRTcoponCode[15] := 'crtmaple0005604411';
        CRTcoponCode[16] := 'crtmaple0006283013';
        CRTcoponCode[17] := 'crtmaple0006474448';

        i := 1;
        WHILE i <= ARRAYLEN(InvoiceDocumentNo) DO BEGIN
            SalesInvoiceLine.RESET;
            SalesInvoiceLine.SETRANGE("Document No.", InvoiceDocumentNo[i]);
            IF SalesInvoiceLine.FINDFIRST THEN BEGIN
                SalesInvoiceLine."CRT Coupon Code" := CRTcoponCode[i];
                SalesInvoiceLine.MODIFY(FALSE);
            END;
            i := i + 1;
        END;
        MESSAGE('Done');
    end;

    var
        i: Integer;
        SalesInvoiceLine: Record 113;
        InvoiceDocumentNo: array[17] of Text[30];
        CRTcoponCode: array[17] of Text[30];
}

