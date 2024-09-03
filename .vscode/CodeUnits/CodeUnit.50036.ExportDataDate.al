codeunit 50036 "Export Data Date"
{

    trigger OnRun()
    begin
    end;


    procedure ExporDailySalestData(TransactionFromDate: Text; TransactionToDate: Text): Text
    var
        FromDate: Date;
        ToDate: Date;
        SalesInvoiceHeader: Record 112;
        SalesXMLFile: File;
        ExportDailySalesData: XMLport 50036;
        SalesOutStream: OutStream;
        FileName: Text;
        XMLInStream: InStream;
        XMLText: Text;
        SalesData: BigText;
        ReturnData: Text;
        TempBlob: Codeunit "Temp Blob";
    begin
        IF TransactionFromDate <> '' THEN
            EVALUATE(FromDate, TransactionFromDate);

        IF TransactionToDate <> '' THEN
            EVALUATE(ToDate, TransactionToDate);

        IF FromDate = 0D THEN
            FromDate := TODAY - 90;

        IF FromDate < 20220109D THEN
            FromDate := 20220109D;

        IF ToDate = 0D THEN
            ToDate := FromDate + 90
        ELSE
            IF (ToDate - FromDate) > 90 THEN
                ToDate := FromDate + 90;

        SalesInvoiceHeader.RESET;
        SalesInvoiceHeader.SETRANGE("Posting Date", FromDate, ToDate);
        SalesInvoiceHeader.SETRANGE("Location Code", 'M1101');
        IF SalesInvoiceHeader.FINDSET THEN BEGIN
            //SalesXMLFile.CREATE(TEMPORARYPATH + 'SalesData.xml');
            TempBlob.CREATEOUTSTREAM(SalesOutStream);//tk
            ExportDailySalesData.SETTABLEVIEW(SalesInvoiceHeader);
            ExportDailySalesData.SETDESTINATION(SalesOutStream);
            ExportDailySalesData.EXPORT();
            // FileName := SalesXMLFile.NAME;//tk
            // SalesXMLFile.CLOSE;
            //SalesXMLFile.OPEN(FileName);
            TempBlob.CREATEINSTREAM(XMLInStream);//tk
            WHILE NOT XMLInStream.EOS DO BEGIN
                XMLInStream.READTEXT(XMLText);
                SalesData.ADDTEXT(XMLText);
            END;
            // SalesXMLFile.CLOSE;//tk
            SalesData.GETSUBTEXT(ReturnData, 1, SalesData.LENGTH);
        END;
        EXIT(ReturnData);

    end;
}

