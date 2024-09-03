codeunit 50032 "Export Data"

{



    trigger OnRun()

    begin

    end;



    var

        FromDate: Date;

        ToDate: Date;

        XMLFile: File;

        OutStr: OutStream;

        FileName: Text;

        InStr: InStream;

        XMLText: Text;

        BigData: BigText;

        ReturnData: Text;





    procedure ExportSalesData(TransactionFromDate: Text; TransactionToDate: Text; Location_Code: Text): Text

    var

        SalesInvoiceHeader: Record 112;

        ExportDailySalesData: XMLport 50036;//tk

        tempblob: Codeunit "Temp Blob";

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



        if Location_Code in ['M1101', 'M0801'] then begin//check Location

            SalesInvoiceHeader.RESET;

            SalesInvoiceHeader.SETRANGE("Posting Date", FromDate, ToDate);

            SalesInvoiceHeader.SETRANGE("Location Code", Location_Code);

            IF SalesInvoiceHeader.FINDSET THEN BEGIN

                // XMLFile.CREATE(TEMPORARYPATH + 'SalesData.xml');

                // XMLFile.CREATEOUTSTREAM(OutStr);

                tempblob.CreateOutStream(OutStr);//np

                ExportDailySalesData.SETTABLEVIEW(SalesInvoiceHeader);

                ExportDailySalesData.SETDESTINATION(OutStr);

                ExportDailySalesData.EXPORT();

                //FileName := XMLFile.NAME;

                // XMLFile.CLOSE;

                // XMLFile.OPEN(FileName);

                // XMLFile.CREATEINSTREAM(InStr);//tk

                tempblob.CreateInStream(InStr);//np

                WHILE NOT InStr.EOS DO BEGIN

                    InStr.READTEXT(XMLText);

                    BigData.ADDTEXT(XMLText);

                END;

                // XMLFile.CLOSE;//tk

                BigData.GETSUBTEXT(ReturnData, 1, BigData.LENGTH);

            END;

        end

        else
            ReturnData := 'Location Code is not valid.';

        EXIT(ReturnData);





    end;





    procedure ExportSalesReturnData(TransactionFromDate: Text; TransactionToDate: Text; Location_Code: Text): Text

    var

        FromDate: Date;

        ToDate: Date;

        SalesCrMemoHeader: Record 114;

        ExportDailyReturnData: XMLport 50037;//tk

        tempblob: Codeunit "Temp Blob";

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



        if Location_Code in ['M1101', 'M0801'] then begin//check Location

            SalesCrMemoHeader.RESET;

            SalesCrMemoHeader.SETRANGE("Posting Date", FromDate, ToDate);

            SalesCrMemoHeader.SETRANGE("Location Code", Location_Code);

            IF SalesCrMemoHeader.FINDSET THEN BEGIN

                // XMLFile.CREATE(TEMPORARYPATH + 'SalesReturn.xml');

                // XMLFile.CREATEOUTSTREAM(OutStr);//tk

                tempblob.CreateOutStream(OutStr);

                ExportDailyReturnData.SETTABLEVIEW(SalesCrMemoHeader);

                ExportDailyReturnData.SETDESTINATION(OutStr);

                ExportDailyReturnData.EXPORT();//tk

                tempblob.CreateInStream(InStr);

                // FileName := XMLFile.NAME;

                // XMLFile.CLOSE;

                // XMLFile.OPEN(FileName);

                // XMLFile.CREATEINSTREAM(InStr);//tk

                WHILE NOT InStr.EOS DO BEGIN

                    InStr.READTEXT(XMLText);

                    BigData.ADDTEXT(XMLText);

                END;

                // XMLFile.CLOSE;//tk

                BigData.GETSUBTEXT(ReturnData, 1, BigData.LENGTH);

            end;

        END

        else
            ReturnData := 'Location Code is not valid.';



        EXIT(ReturnData);

    end;

}

