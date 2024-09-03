xmlport 50033 "OSL File"
{
    Direction = Export;
    FieldDelimiter = '<None>';
    FieldSeparator = '<TAB>';
    FileName = '.txt';
    Format = VariableText;
    TableSeparator = '<NewLine>';

    schema
    {
        textelement(root)
        {
            tableelement(Integer; Integer)
            {
                XmlName = 'Integer';
                SourceTableView = WHERE(Number = FILTER(1));
                textattribute(CTRL1)
                {

                    trigger OnBeforePassVariable()
                    begin
                        CTRL1 := FORMAT('CTRL');
                    end;
                }
                textattribute(SenderID)
                {

                    trigger OnBeforePassVariable()
                    begin
                        SenderID := '240603'
                    end;
                }
                textattribute(ReceiverID)
                {

                    trigger OnBeforePassVariable()
                    begin
                        ReceiverID := '060704780001000'
                    end;
                }
                textattribute(MessageType)
                {

                    trigger OnBeforePassVariable()
                    begin
                        MessageType := FORMAT('OSL');
                    end;
                }
                textattribute(ControlID)
                {

                    trigger OnBeforePassVariable()
                    begin
                        ControlID := NoSeriesManagement.GetNextNo('OSL', TODAY, TRUE);
                    end;
                }
                textattribute(DateTimeStamp)
                {

                    trigger OnBeforePassVariable()
                    begin
                        //Tday := CURRENTDATETIME++(5.5*60*60000);
                        Date1 := TODAY;
                        Time1 := '001501';
                        DateTimeStamp := FORMAT(Date1, 0, '<Year4><Month,2><Day,2>');
                        DateTimeStamp := DateTimeStamp + Time1;
                        //DateTimeStamp := FORMAT(Tday,0,'<year4><month,2><day,2><Hours24><Minutes,2><Seconds,2>');
                    end;
                }
                textattribute(SenderName)
                {

                    trigger OnBeforePassVariable()
                    begin
                        SenderName := FORMAT('MAPLE');
                    end;
                }
                textattribute(CountryCode)
                {

                    trigger OnBeforePassVariable()
                    begin
                        CountryCode := 'IN';
                    end;
                }
                textattribute(SourceEncodingType)
                {

                    trigger OnBeforePassVariable()
                    begin
                        SourceEncodingType := 'UTF-8';
                    end;
                }

                trigger OnPreXmlItem()
                begin
                    //currXMLport.FIELDSEPARATOR(' ');
                    //currXMLport.TABLESEPARATOR(FORMAT(LF));
                end;
            }
            tableelement(Integer1; Integer)
            {
                XmlName = 'Integer';
                SourceTableView = WHERE(Number = FILTER(1));
                textelement(HDR)
                {

                    trigger OnBeforePassVariable()
                    begin
                        HDR := 'HDR';
                    end;
                }
                textelement(ReportingDate)
                {

                    trigger OnBeforePassVariable()
                    begin
                        ReportingD := CALCDATE('-1D', TODAY);
                        ReportingDate := FORMAT(ReportingD, 0, '<year4><month,2><day,2>');
                    end;
                }
                textelement(PartnerID)
                {

                    trigger OnBeforePassVariable()
                    begin
                        PartnerID := '240603';
                    end;
                }
                textelement(PartnerType)
                {

                    trigger OnBeforePassVariable()
                    begin
                        PartnerType := 'T2';
                    end;
                }

                trigger OnPreXmlItem()
                begin
                    //currXMLport.FIELDSEPARATOR(' ');
                    //currXMLport.RECORDSEPARATOR('<NewLine>');
                    //currXMLport.TABLESEPARATOR(FORMAT(CR)+FORMAT(CR)+FORMAT(LF)+FORMAT(CR)+FORMAT(LF));
                    //currXMLport.RECORDSEPARATOR(FORMAT(CR)+FORMAT(LF)+FORMAT(CR)+FORMAT(LF));
                    currXMLport.TEXTENCODING := TEXTENCODING::UTF8;
                end;
            }
            tableelement("Item Ledger Entry"; "Item Ledger Entry")
            {
                XmlName = 'ItemLedgerEntry';
                SourceTableView = WHERE("Entry Type" = FILTER(1),
                                        "Document Type" = FILTER(1),
                                        "Item Category Code" = FILTER('APPLE'));
                textelement(DTL)
                {

                    trigger OnBeforePassVariable()
                    begin
                        DTL := 'DTL';
                        SetDTLS(DTL); //HR
                    end;
                }
                textelement(MPN)
                {

                    trigger OnBeforePassVariable()
                    begin
                        IF Item.GET("Item Ledger Entry"."Item No.") THEN
                            MPN := FORMAT(Item."Vendor Part Code Long");
                    end;
                }
                fieldelement(IMEI1; "Item Ledger Entry"."IMEI No.")
                {
                }
                textelement(IMEI2)
                {
                }
                fieldelement(SerialNo; "Item Ledger Entry"."Serial No.")
                {
                }
                textelement(OutwardOrderdate)
                {

                    trigger OnBeforePassVariable()
                    begin
                        OutwardOrderdate := FORMAT("Item Ledger Entry"."Posting Date", 0, '<year4><month,2><day,2>');
                    end;
                }
                textelement(OutShippingDate)
                {

                    trigger OnBeforePassVariable()
                    begin
                        OutShippingDate := FORMAT("Item Ledger Entry"."Posting Date", 0, '<year4><month,2><day,2>');
                    end;
                }
                textelement(OutwardSoldToPartnerHQID)
                {

                    trigger OnBeforePassVariable()
                    begin
                        /*
                        IF Location.GET("Item Ledger Entry"."Location Code") THEN
                          IF Location."POS Apple ID"<>0 THEN
                        OutwardSoldToPartnerHQID := FORMAT(Location."POS Apple ID");
                        *///For T1 Partner required this value

                    end;
                }
                textelement(OutwardInvoiceNo)
                {

                    trigger OnBeforePassVariable()
                    begin
                        ValueEntry1.RESET;
                        ValueEntry1.SETRANGE("Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
                        IF ValueEntry1.FINDFIRST THEN BEGIN
                            IF ValueEntry1."Document Type" = ValueEntry1."Document Type"::"Sales Invoice" THEN
                                OutwardInvoiceNo := ValueEntry1."Document No.";
                            OutwardDelivaryDate := FORMAT(ValueEntry1."Posting Date", 0, '<year4><month,2><day,2>');
                        END;
                    end;
                }
                textelement(OutwardDelivaryDate)
                {
                }
                textelement(OutwardSoldFromPosAppleId)
                {

                    trigger OnBeforePassVariable()
                    begin
                        IF Location.GET("Item Ledger Entry"."Location Code") THEN
                            IF Location."POS Apple ID" <> 0 THEN
                                OutwardSoldFromPosAppleId := FORMAT(Location."POS Apple ID");
                    end;
                }
                textelement(OutwardSolDToPosAppleId)
                {

                    trigger OnBeforePassVariable()
                    begin
                        /*
                        IF Location.GET("Item Ledger Entry"."Location Code") THEN
                          IF Location."POS Apple ID"<>0 THEN
                        OutwardSolDToPosAppleId := FORMAT(Location."POS Apple ID");
                        */
                        OutwardSolDToPosAppleId := FORMAT(9);

                    end;
                }
                textelement(PONumber)
                {

                    trigger OnBeforePassVariable()
                    begin
                        /*
                        ItemLedgerEntry.RESET;
                        ItemLedgerEntry.SETRANGE("Entry No.","Item Ledger Entry"."Entry No.");
                        ItemLedgerEntry.SETRANGE("Item No.","Item Ledger Entry"."Item No.");
                        IF ItemLedgerEntry.FINDFIRST THEN BEGIN
                          ValueEntry2.RESET;
                          ValueEntry2.SETRANGE("Posting Date",ItemLedgerEntry."Posting Date");
                          ValueEntry2.SETRANGE("Item Ledger Entry No.",ItemLedgerEntry."Entry No.");
                          ValueEntry2.SETRANGE("Entry Type",ItemLedgerEntry."Entry Type"::Purchase);
                          ValueEntry2.SETRANGE("Document Type",ItemLedgerEntry."Document Type"::"Purchase Receipt");
                          IF ValueEntry2.FINDFIRST THEN BEGIN
                            PurchRcptHeader.RESET;
                            PurchRcptHeader.SETRANGE("No.",ValueEntry2."Document No.");
                            IF PurchRcptHeader.FINDFIRST THEN
                              PONumber := PurchRcptHeader."Order No.";
                            END;
                          END;
                          */

                    end;
                }
                textelement(tinno1)
                {
                    XmlName = 'TINNO';

                    trigger OnBeforePassVariable()
                    begin
                        CompanyInformation.GET;
                        TINNo1 := '';
                        //TINNo1 := CompanyInformation."T.I.N. No.";
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    IF ("Item Ledger Entry"."Serial No." = '') AND ("Item Ledger Entry"."IMEI No." = '') THEN
                        currXMLport.SKIP;

                    ItemLedgerEntry.RESET;

                    //ItemLedgerEntry.SETRANGE("Item No.","Item Ledger Entry"."Item No.");
                    ItemLedgerEntry.SETRANGE("Serial No.", "Item Ledger Entry"."Serial No.");
                    ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);

                    IF ItemLedgerEntry.FINDFIRST THEN BEGIN

                        PurchRcptHeader.RESET;
                        //PurchRcptHeader.SETRANGE("No.",ValueEntry2."Document No.");
                        PurchRcptHeader.SETRANGE("No.", ItemLedgerEntry."Document No.");
                        IF PurchRcptHeader.FINDFIRST THEN
                            PONumber := DELCHR(PurchRcptHeader."Order No.", '=', '/');
                        /*
                    
                      ValueEntry2.RESET;
                      ValueEntry2.SETRANGE("Item Ledger Entry No.",ItemLedgerEntry."Entry No.");
                      ValueEntry2.SETRANGE("Entry Type",ItemLedgerEntry."Entry Type"::Purchase);
                      IF ValueEntry2.FINDFIRST THEN BEGIN
                       IF RecPIH.GET(ValueEntry2."Document No.") THEN
                       PONumber:= RecPIH."Vendor Invoice No.";
                      END;
                      */
                    END;

                end;

                trigger OnPreXmlItem()
                begin
                    //"Item Ledger Entry".SETRANGE("Posting Date",TODAY-7,TODAY-1);
                    "Item Ledger Entry".SETRANGE("Posting Date", TODAY - 1);
                    //currXMLport.FIELDSEPARATOR(' ');
                    //currXMLport.TABLESEPARATOR(FORMAT(CR)+FORMAT(CR)+FORMAT(LF)+FORMAT(CR)+FORMAT(LF));
                    currXMLport.TEXTENCODING := TEXTENCODING::UTF8;
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

    trigger OnInitXmlPort()
    begin
        CLEAR(CRLF);
        CR := 13;
        LF := 10;
        currXMLport.TEXTENCODING := TEXTENCODING::UTF8;
    end;

    var
        Tday: DateTime;
        ReportingD: Date;
        CompanyInformation: Record 79;
        NoSeriesManagement: Codeunit 396;
        ValueEntry: Record 5802;
        ShipmentDate: Date;
        ValueEntry1: Record 5802;
        OutwInvoiceNo: Code[50];
        OutInvoiceDate: Date;
        Location: Record 14;
        ItemLedgerEntry: Record 32;
        ValueEntry2: Record 5802;
        PurchRcptHeader: Record 120;
        Item: Record 27;
        RecPIH: Record 122;
        CR: Integer;
        LF: Integer;
        CRLF: array[2] of Text[2];
        Date1: Date;
        Time1: Text;
        GetDLSVAR: Text;

    procedure RemoveHiddenCharacters(var ValueToClean: Text[3])
    var
        Ch: array[3] of Text;
        i: Integer;
    begin
        FOR i := 1 TO 3
        DO BEGIN
            Ch[1] := '239'; //EF
            Ch[2] := '187';//BB
            Ch[3] := '191';//BF
            ValueToClean := DELCHR(ValueToClean, '=', Ch[i]);
        END;//EF BB BF
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

