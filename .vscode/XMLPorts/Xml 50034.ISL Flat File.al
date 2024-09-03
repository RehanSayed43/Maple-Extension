xmlport 50034 "ISL Flat File"
{
    Direction = Export;
    FieldDelimiter = '<None>';
    FieldSeparator = '<TAB>';
    FileName = '.txt';
    Format = VariableText;
    TableSeparator = '<NewLine>';
    TextEncoding = UTF8;

    schema
    {
        textelement(Root)
        {
            tableelement(Integer; Integer)
            {
                XmlName = 'CTRL_1';
                SourceTableView = WHERE(Number = FILTER(1));
                textelement(CTRL_S)
                {

                    trigger OnBeforePassVariable()
                    begin
                        CTRL_S := 'CTRL';
                        //Filenameq:='240603_AP_ISL_'+FORMAT(TODAY,0,'<Year4><Month,2><Day,2>')+Fileno+'.txt';
                    end;
                }
                textelement(SENDERID)
                {

                    trigger OnBeforePassVariable()
                    begin
                        SENDERID := '240603';
                    end;
                }
                textelement(RECEIVERID)
                {

                    trigger OnBeforePassVariable()
                    begin
                        RECEIVERID := '060704780001000';
                    end;
                }
                textelement(MESSAGETYPE)
                {

                    trigger OnBeforePassVariable()
                    begin
                        MESSAGETYPE := 'ISL';
                    end;
                }
                textelement(CONTROLID)
                {

                    trigger OnBeforePassVariable()
                    begin
                        CONTROLID := Fileno;//"no.series".GetNextNo('ISL',TODAY,TRUE);
                    end;
                }
                textelement(DATETIMESTAMP)
                {

                    trigger OnBeforePassVariable()
                    begin
                        //DATETIMESTAMP:=FORMAT(CURRENTDATETIME);//'YYYMMDDhhmmss' <Day,2>-<Month,2>-<Year> <Hours24,2>.<Minutes,2>.<Seconds,2>
                        Date1 := TODAY;
                        Time1 := '001501';
                        DATETIMESTAMP := FORMAT(Date1, 0, '<Year4><Month,2><Day,2>');
                        DATETIMESTAMP := DATETIMESTAMP + Time1;
                        //DATETIMESTAMP:= FORMAT(CURRENTDATETIME+(5.5*60*60000),0,'<Year4><Month,2><Day,2><Hours24,2><Minutes,2><Seconds,2>');
                    end;
                }
                textelement(SENDERNAME)
                {

                    trigger OnBeforePassVariable()
                    begin
                        SENDERNAME := 'MAPLE';
                    end;
                }
                textelement(COUNTRYCODE)
                {

                    trigger OnBeforePassVariable()
                    begin
                        COUNTRYCODE := 'IN';
                    end;
                }
                textelement(SOURCEENCODINGTYPE)
                {

                    trigger OnBeforePassVariable()
                    begin
                        SOURCEENCODINGTYPE := 'UTF-8';
                    end;
                }

                trigger OnPreXmlItem()
                begin
                    //currXMLport.FIELDSEPARATOR(' ');
                end;
            }
            tableelement(Integer1; Integer)
            {
                XmlName = 'HDR_1';
                SourceTableView = WHERE(Number = FILTER(1));
                textelement(HDR_S)
                {

                    trigger OnBeforePassVariable()
                    begin
                        HDR_S := 'HDR';
                    end;
                }
                textelement(REP_DATE)
                {

                    trigger OnBeforePassVariable()
                    begin
                        REP_DATE := FORMAT(TODAY - 1, 0, '<Year4><Month,2><Day,2>');
                    end;
                }
                textelement(PARTNER_ID)
                {

                    trigger OnBeforePassVariable()
                    begin
                        PARTNER_ID := '240603';
                    end;
                }
                textelement(PARTNER_TYPE)
                {

                    trigger OnBeforePassVariable()
                    begin
                        PARTNER_TYPE := 'T2';
                    end;
                }

                trigger OnPreXmlItem()
                begin
                    //currXMLport.FIELDSEPARATOR(' ');
                end;
            }
            tableelement("Item Ledger Entry"; "Item Ledger Entry")
            {
                XmlName = 'DTL_2';
                SourceTableView = WHERE("Entry Type" = FILTER(0),
                                        "Document Type" = FILTER(5),
                                        "Item Category Code" = FILTER('APPLE'),
                                        "Serial No." = FILTER(<> ''));
                textelement(DTL_SS)
                {

                    trigger OnBeforePassVariable()
                    begin
                        DTL_SS := 'DTL';
                        SetDTLS(DTL_SS);//HR
                    end;
                }
                textelement(MPN1)
                {
                }
                textelement(IMEI11)
                {

                    trigger OnBeforePassVariable()
                    begin
                        //IMEI11:= "Item Ledger Entry"."IMEI No.";
                        //IMEI11:='';
                    end;
                }
                textelement(IMEI22)
                {

                    trigger OnBeforePassVariable()
                    begin
                        //IMEI22:='';
                    end;
                }
                textelement(SerialNo1)
                {

                    trigger OnBeforePassVariable()
                    begin
                        IF "Item Ledger Entry"."Serial No." <> '' THEN
                            SerialNo1 := "Item Ledger Entry"."Serial No.";
                        //ELSE
                        // SerialNo1:='';
                    end;
                }
                textelement(POE1)
                {
                }
                textelement(In_OrderDt1)
                {
                }
                textelement(In_ReceiptDt1)
                {

                    trigger OnBeforePassVariable()
                    begin
                        In_ReceiptDt1 := FORMAT("Item Ledger Entry"."Posting Date", 0, '<Year4><Month,2><Day,2>');
                    end;
                }
                textelement(In_Invoice_No1)
                {
                }
                textelement(In_PostingDt1)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF ("Item Ledger Entry"."Serial No." = '') AND ("Item Ledger Entry"."IMEI No." = '') THEN
                        currXMLport.SKIP;

                    IF RecItem.GET("Item Ledger Entry"."Item No.") THEN
                        MPN1 := FORMAT(RecItem."Vendor Part Code Long");

                    RecPurRcpt.RESET;
                    RecPurRcpt.SETRANGE("Document No.", "Item Ledger Entry"."Document No.");
                    IF RecPurRcpt.FINDFIRST THEN
                        In_OrderDt1 := FORMAT(RecPurRcpt."Order Date", 0, '<Year4><Month,2><Day,2>');

                    IF RecLoc.GET("Item Ledger Entry"."Location Code") THEN
                        POE1 := RecLoc.City;

                    RecVLE.RESET;
                    RecVLE.SETRANGE("Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
                    IF RecVLE.FINDFIRST THEN BEGIN
                        IF RecPIH.GET(RecVLE."Document No.") THEN
                            In_Invoice_No1 := RecPIH."Vendor Invoice No.";
                        // In_Invoice_No1:= RecVLE."Document No.";
                        In_PostingDt1 := FORMAT(RecVLE."Posting Date", 0, '<Year4><Month,2><Day,2>');
                    END;
                end;

                trigger OnPreXmlItem()
                begin
                    //"Item Ledger Entry".SETRANGE("Posting Date",TODAY-7,TODAY-1);
                    "Item Ledger Entry".SETRANGE("Item Ledger Entry"."Posting Date", TODAY - 1);
                    //currXMLport.FIELDSEPARATOR(' ');
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnPreXmlPort()
    begin
        Fileno := "no.series".GetNextNo('ISL', TODAY, TRUE);
    end;

    var
        "no.series": Codeunit 396;
        RecItem: Record 27;
        RecLoc: Record 14;
        RecVLE: Record 5802;
        RecILE: Record 32;
        RecPurRcpt: Record 121;
        Filenameq: Text;
        Fileno: Code[250];
        RecPIH: Record 122;
        Date1: Date;
        Time1: Text;
        GetDLSVAR: Text;

    procedure GetFileNo(FiNo: Code[100]): Code[100]
    begin
        EXIT(FiNo);
    end;

    procedure GetDTLS(var GetDTLS: Text)
    begin
        GetDTLS := GetDLSVAR;//HR
    end;

    procedure SetDTLS(SetDLS: Text)
    begin
        GetDLSVAR := SetDLS;//HR
    end;
}

