codeunit 50030 GenerateQRCode
{

    trigger OnRun()
    begin

        //ProcessData('9104222301001181',0);
        //ProcessData('2104222301000640',0);

        EInvoiceEntry.RESET;
        EInvoiceEntry.SETFILTER(IRN, '<>%1', '');
        EInvoiceEntry.SETFILTER("QR Code Part1", '<>%1', '');
        IF EInvoiceEntry.FINDSET THEN
            REPEAT
                IF NOT EInvoiceEntry."QR Code".HASVALUE THEN
                    IF EInvoiceEntry."Document Type" = EInvoiceEntry."Document Type"::Invoice THEN
                        ProcessData(EInvoiceEntry."Document No.", 0)
                    ELSE
                        IF EInvoiceEntry."Document Type" = EInvoiceEntry."Document Type"::"Credit Memo" THEN
                            ProcessData(EInvoiceEntry."Document No.", 1)
                        ELSE
                            IF EInvoiceEntry."Document Type" = EInvoiceEntry."Document Type"::Transfer THEN
                                ProcessData(EInvoiceEntry."Document No.", 2)
                            ELSE
                                IF EInvoiceEntry."Document Type" = EInvoiceEntry."Document Type"::"Transfer Cancel" THEN
                                    ProcessData(EInvoiceEntry."Document No.", 3)
                                ELSE
                                    IF EInvoiceEntry."Document Type" = EInvoiceEntry."Document Type"::"Purch Cr Memo" THEN
                                        ProcessData(EInvoiceEntry."Document No.", 4);
                COMMIT;
            UNTIL EInvoiceEntry.NEXT = 0;


        MESSAGE('Done');
    end;

    var
        EInvoiceEntry: Record 50004;

    local procedure ProcessData(ParamDocNo: Code[20]; ParamDocType: Integer)
    var
        EInvoiceEntry: Record 50004;
        QRCodeFileName: Text;

        // TempBlob: Record 99008535;//tk
        FileMagmet: Codeunit 419;
        txtSignedQRCode: Text[1024];
    begin
        //Invoice,Credit Memo,Transfer,Transfer Cancel,Purch Cr Memo
        EInvoiceEntry.RESET;
        IF EInvoiceEntry.GET(ParamDocType, ParamDocNo) THEN BEGIN

            txtSignedQRCode := EInvoiceEntry."QR Code Part1";
            txtSignedQRCode += EInvoiceEntry."QR Code Part1";
            txtSignedQRCode += EInvoiceEntry."QR Code Part3";
            txtSignedQRCode += EInvoiceEntry."QR Code Part4";


            QRCodeFileName := GetQRCode(txtSignedQRCode);
            // QRCodeFileName := MoveToPath(QRCodeFileName);//tk

            // CLEAR(TempBlob);//tk++
            // FileMagmet.BLOBImport(TempBlob, QRCodeFileName);
            // IF TempBlob.Blob.HASVALUE THEN BEGIN
            //     EInvoiceEntry."QR Code" := TempBlob.Blob;//tk--
        END;
        IF NOT ISSERVICETIER THEN
            // IF EXISTS(QRCodeFileName) THEN//tk
            //     ERASE(QRCodeFileName);//tk

            EInvoiceEntry.MODIFY;
    END;
    //end;//tk


    procedure GetQRCode(QRCode: Text) QRCodeFileName: Text[1024]
    var
    // [RunOnClient]
    // IBarCodeProvider: DotNet IBarcodeProvider;//tk
    begin

        // GetBarCodeProvider(IBarCodeProvider);//tk
        // QRCodeFileName := IBarCodeProvider.GetBarcode(QRCode);//tk
    end;

    //TK++
    // procedure GetBarCodeProvider(var IBarCodeProvider: DotNet IBarcodeProvider)
    // var
    //     // [RunOnClient]
    //     // QRCodeProvider: DotNet QRCodeProvider;//tk
    // begin

    //     // QRCodeProvider := QRCodeProvider.QRCodeProvider;
    //     // IBarCodeProvider := QRCodeProvider;
    // end;//tk__

    //tk++
    // procedure MoveToPath(SourceFile: Text) DestFile: Text[1024]
    // var
    //     FileSysObj: Automation;
    //     FileMagmet: Codeunit 419;
    // begin
    //     DestFile := FileMagmet.ClientTempFileName('');
    //     IF ISCLEAR(FileSysObj) THEN
    //         CREATE(FileSysObj, TRUE, TRUE);
    //     FileSysObj.MoveFile(SourceFile, DestFile);
    // end;//tk__
}

