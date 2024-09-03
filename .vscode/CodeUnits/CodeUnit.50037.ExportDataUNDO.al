codeunit 50037 "Export Data - UNDO"
{

    trigger OnRun()
    begin
    end;


    procedure ExportSalesData(): Text
    var
        SalesInvoiceHeader: Record 112;
        XMLData: OutStream;
        SalesData: Text;
        TempBlob: Codeunit "Temp Blob";
        DataInStream: InStream;
        ExportDailySalesData: XMLport 50036;//tk
        FileName: Text;
        SalesData1: Text;
    begin
        SalesInvoiceHeader.RESET;
        //SalesInvoiceHeader.SETRANGE("Posting Date",TODAY);
        SalesInvoiceHeader.SETRANGE("Posting Date", 20220109D);
        SalesInvoiceHeader.SETRANGE("Location Code", 'M1101');
        IF SalesInvoiceHeader.FINDSET THEN
            ExportDailySalesData.SETTABLEVIEW(SalesInvoiceHeader);
        TempBlob.CREATEOUTSTREAM(XMLData, TEXTENCODING::UTF8);//tk
        ExportDailySalesData.SETDESTINATION(XMLData);
        ExportDailySalesData.EXPORT();
        //TempBlob.CALCFIELDS(Blob);//tk
        TempBlob.CREATEINSTREAM(DataInStream, TEXTENCODING::UTF8);//tk
        WHILE NOT DataInStream.EOS DO BEGIN
            DataInStream.READTEXT(SalesData);
            SalesData1 += SalesData;
        END;
        EXIT(SalesData1);
    end;


    procedure ExporDailySalestData(): Text
    var
        SalesXMLFile: File;
        SalesOutStream: OutStream;
        SalesInvoiceHeader: Record 112;
        ExportDailySalesData: XMLport 50036;//tk
        SalesData: BigText;
        FileName: Text;
        XMLInStream: InStream;
        XMLText: Text;
        ReturnData: Text;
        NewReturnData: Text;
        StartDateFilter: Date;
        TempBlob: Codeunit "Temp Blob";
    begin
        StartDateFilter := TODAY - 90;

        SalesInvoiceHeader.RESET;
        IF StartDateFilter < 20220109D THEN
            SalesInvoiceHeader.SETRANGE("Posting Date", 20220109D, TODAY)
        ELSE
            SalesInvoiceHeader.SETRANGE("Posting Date", StartDateFilter, TODAY);
        SalesInvoiceHeader.SETRANGE("Location Code", 'M1101');
        //SalesInvoiceHeader.SETRANGE("Posting Date",032318D);
        IF SalesInvoiceHeader.FINDSET THEN
            //SalesXMLFile.CREATE(TEMPORARYPATH + 'Sales.xml');
        TempBlob.CREATEOUTSTREAM(SalesOutStream);
        ExportDailySalesData.SETTABLEVIEW(SalesInvoiceHeader);
        ExportDailySalesData.SETDESTINATION(SalesOutStream);
        ExportDailySalesData.EXPORT();
        //FileName := SalesXMLFile.NAME;
        // SalesXMLFile.CLOSE;
        // SalesXMLFile.OPEN(FileName);
        TempBlob.CREATEINSTREAM(XMLInStream);//tk
        WHILE NOT XMLInStream.EOS DO BEGIN
            XMLInStream.READTEXT(XMLText);
            SalesData.ADDTEXT(XMLText);
        END;
        // SalesXMLFile.CLOSE;//tk
        SalesData.GETSUBTEXT(ReturnData, 1, SalesData.LENGTH);
        //NewReturnData:=CONVERTSTR(ReturnData,'&amp;','<');
        //NewReturnData:=DELCHR(ReturnData,'=','&gt');
        //ReturnData:=CONVERTSTR(ReturnData,'&gt','>');
        //NewReturnData:=ReplaceString(ReturnData,'&gt','>');
        EXIT(ReturnData);
    end;

    local procedure ReplaceString(String: Text; OldText: Text; NewText: Text): Text
    var
        Pos: Integer;
    begin
        Pos := STRPOS(String, OldText);
        WHILE Pos <> 0 DO BEGIN
            String := DELSTR(String, Pos, STRLEN(OldText));
            String := INSSTR(String, NewText, Pos);
            Pos := STRPOS(String, OldText);
        END;
        EXIT(String);
    end;
}

