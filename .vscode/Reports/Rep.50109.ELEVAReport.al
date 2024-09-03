REPORT 50109 "ELEVA REPORT"
{
    DEFAULTLAYOUT = RDLC;
    RDLCLAYOUT = './ELEVAREPORT.rdl';
    ApplicationArea = FixedAsset;

    DATASET
    {
        DATAITEM("COMPANY INFORMATION"; "COMPANY INFORMATION")
        {
            DATAITEMTABLEVIEW = SORTING("PRIMARY KEY");
            COLUMN(COMPINFONAME; "COMPANY INFORMATION".NAME)
            {
            }
            COLUMN(STARTDT; STARTDT)
            {
            }
            COLUMN(ENDDT; ENDDT)
            {
            }
        }
        DATAITEM("Sales Invoice Header"; "Sales Invoice Header")
        {
            DATAITEMTABLEVIEW = SORTING("No.");
            PRINTONLYIFDETAIL = FALSE;
            REQUESTFILTERFIELDS = "NO.", "SELL-TO CUSTOMER NO.";
            DATAITEM("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = where("Item Category Code" = filter(<> 'ELEVA'));
                COLUMN(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
                {
                }
                COLUMN(CURRREPORT_PAGENO; CURRREPORT.PAGENO)
                {
                }
                COLUMN(SRNO; SRNO) { }
                COLUMN(SELLTOCUST; "SALES INVOICE HEADER"."SELL-TO CUSTOMER NAME")
                {
                }
                COLUMN(LOCATION; "SALES INVOICE HEADER"."LOCATION CODE")
                {
                }
                COLUMN(SO_DT; "SALES INVOICE HEADER"."ORDER DATE")
                {
                }
                COLUMN(VERTICAL; "SALES INVOICE HEADER"."SHORTCUT DIMENSION 2 CODE")
                {
                }
                COLUMN(INVNO; "SALES INVOICE HEADER"."NO.")
                {
                }
                COLUMN(INV_DT; "SALES INVOICE HEADER"."POSTING DATE")
                {
                }
                COLUMN(CUSTNM; "SALES INVOICE HEADER"."SELL-TO CUSTOMER NAME")
                {
                }
                COLUMN(CUSTNO; "SALES INVOICE HEADER"."SELL-TO CUSTOMER NO.")
                {
                }
                COLUMN(SELLTOCTY; "SALES INVOICE HEADER"."SELL-TO CITY")
                {
                }
                COLUMN(SALEP; "SALES INVOICE HEADER"."SALESPERSON CODE")
                {
                }
                COLUMN(DELNOTE; "SALES INVOICE HEADER"."DELIVERY NOTE")
                {
                }
                COLUMN(DISPDOCNO; "SALES INVOICE HEADER"."DISPATCH DOC. NO.")
                {
                }
                COLUMN(DISPTHRU; "SALES INVOICE HEADER"."DISPATCH THROUGH")
                {
                }
                COLUMN(PAYTERMS; "SALES INVOICE HEADER"."PAYMENT TERMS CODE")
                {
                }
                COLUMN(CUSTOMERMOBNO; "SALES INVOICE HEADER"."CUST. MOBILE NO.")
                {
                }
                COLUMN(CUSTEMAILID; "SALES INVOICE HEADER"."CUST. EMAIL ID")
                {
                }
                COLUMN(SALESPNM; SALESP.NAME) { }
                COLUMN(PAYTERMSDESC; PAYTERMS.DESCRIPTION) { }
                COLUMN(SONO; "SALES INVOICE HEADER"."ORDER NO.")
                {
                }
                COLUMN(PONO; PURCHHDR."NO.") { }
                COLUMN(PODT; PURCHHDR."POSTING DATE")
                {
                }
                COLUMN(GSTTIN_NO; GSTTIN_NO)
                {
                }
                COLUMN(PLACEOFSUPPLY; PLACEOFSUPPLY)
                {
                }
                COLUMN(SHIELDAMTWOTAX; "SALES INVOICE LINE"."UNIT PRICE")
                {
                }
                //COLUMN(SHIELDTAXAMT; "SALES INVOICE LINE"."TAX AMOUNT") { }
                COLUMN(ITEMNOSHIELD; "SALES INVOICE LINE"."DESCRIPTION 2")
                {
                }
                COLUMN(SHIELDTYPE; "SALES INVOICE LINE"."SHIELD TYPE")
                {
                }
                //COLUMN(SHIELDAMOUNTWITHTAX; "SALES INVOICE LINE"."AMOUNT INCLUDING TAX")                {                }
                COLUMN(ZONE; STATEREC.ZONE)
                {
                }
                COLUMN(STATENM; STATEREC.DESCRIPTION)
                {
                }
                COLUMN(VENDITEMCD; ITEM."VENDOR PART CODE LONG")
                {
                }
                COLUMN(SCHEMECODE; "SALES INVOICE LINE"."SCHEME CODE")
                {
                }
                COLUMN(SRLNO; "SALES INVOICE LINE"."SERIAL NO.")
                {
                }
                COLUMN(IMEINO; "SALES INVOICE LINE"."IMEI NO.")
                {
                }
                COLUMN(SCHMAMT; "SALES INVOICE LINE"."SCHEME AMOUNT")
                {
                }
                COLUMN(SCHMPERC; "SALES INVOICE LINE"."SCHEME %")
                {
                }
                COLUMN(MAPLECODE; "SALES INVOICE LINE"."NO.")
                {
                }
                COLUMN(PARTDESC; "SALES INVOICE LINE".DESCRIPTION)
                {
                }
                COLUMN(QTY; "SALES INVOICE LINE".QUANTITY)
                {
                }
                COLUMN(UNITP; "SALES INVOICE LINE"."UNIT PRICE")
                {
                }
                //COLUMN(TAXAMT; "SALES INVOICE LINE"."TAX AMOUNT")                {                }
                // COLUMN(TAXP; "SALES INVOICE LINE"."TAX %")                {                }
                //COLUMN(SERVTAXAMT; "SALES INVOICE LINE"."SERVICE TAX AMOUNT")                {                }
                COLUMN(SCHMDESC; SCHEM.DESCRITPION)
                {
                }
                COLUMN(NETSALESWOTAX; NETSALESWOTAX)
                {
                }
                COLUMN(TOTSALESAMT; TOTSALESAMT)
                {
                }
                COLUMN(SALESPRICE; SALESPRICE)
                {
                }
                COLUMN(MAPLEDISCAMT; "SALES INVOICE LINE"."LINE DISCOUNT AMOUNT")
                {
                }
                COLUMN(MAPLELINEDISC; "SALES INVOICE LINE"."LINE DISCOUNT %")
                {
                }
                // COLUMN(CHARGES; "SALES INVOICE LINE"."CHARGES TO CUSTOMER")                {                }
                COLUMN(SERVTAXPERC; SERVTAXPERC)
                {
                }
                COLUMN(UOM; "SALES INVOICE LINE"."UNIT OF MEASURE")
                {
                }
                COLUMN(BRAND; "SALES INVOICE LINE"."ITEM CATEGORY CODE")
                {
                }
                COLUMN(CATGRY; "SALES INVOICE LINE"."Product Category")
                {
                }
                COLUMN(SALESPOINTS_SALESINVOICELINE; "SALES INVOICE LINE"."SALES POINTS")
                {
                }
                COLUMN(GSTGROUPCODE; "SALES INVOICE LINE"."GST GROUP CODE")
                {
                }
                COLUMN(HSN_SAC_CODE; "SALES INVOICE LINE"."HSN/SAC CODE")
                {
                }
                COLUMN(CGSTAMT; ABS(CGSTAMT))
                {
                }
                COLUMN(SGSTAMT; ABS(SGSTAMT))
                {
                }
                COLUMN(IGSTAMT; ABS(IGSTAMT))
                {
                }
                COLUMN(TOTALGSTAMOUNT; ABS(CGSTAMT) + ABS(SGSTAMT) + ABS(IGSTAMT))
                {
                }
                COLUMN(AMOUNTTOCUSTOMER_SALESINVOICELINE; "SALES INVOICE LINE".Amount)
                {
                }
                COLUMN(ELEVADES; ELEVADES)
                {
                }
                COLUMN(ELEVAIMEINO; ELEVAIMEINO)
                {
                }
                COLUMN(ELEVASERIALNO; ELEVASERIALNO)
                {
                }
                COLUMN(ELEVAPRICE; ELEVAPRICE)
                {
                }
                COLUMN(CRITEMNO; SALESCRMEMOLINE1."NO.")
                {
                }
                COLUMN(CRAMOUNT; SALESCRMEMOLINE1."AMOUNT INCLUDING VAT")
                {
                }
                COLUMN(CRSERIALNO; SALESCRMEMOLINE1."ITEM SERIAL NO.")
                {
                }
                COLUMN(CRIMEINO; SALESCRMEMOLINE1."IMEI NO.")
                {
                }
                COLUMN(CRDOCNO; SALESCRMEMOLINE1."DOCUMENT NO.")
                {
                }
                COLUMN(CRCUSTNO; SALESCRMEMOLINE1."SELL-TO CUSTOMER NO.")
                {
                }
                COLUMN(CRLOC; SALESCRMEMOLINE1."LOCATION CODE")
                {
                }
                COLUMN(CRPOST; SALESCRMEMOLINE1."POSTING DATE")
                {
                }
                COLUMN(CRSELLTOCUSTNAME; "SALES INVOICE HEADER"."SELL-TO CUSTOMER NAME")
                {
                }
                COLUMN(CGSTRATECR; CGSTRATECR)
                {
                }
                COLUMN(CGSTAMTCR; CGSTAMTCR)
                {
                }
                COLUMN(SGSTAMTCR; SGSTAMTCR)
                {
                }
                COLUMN(SGSTRATECR; SGSTRATECR)
                {
                }
                COLUMN(IGSTRATECR; IGSTRATECR)
                {
                }
                COLUMN(IGSTAMTCR; IGSTAMTCR)
                {
                }
                COLUMN(GSTCOMPONENTCGSTCR; GSTCOMPONENTCGSTCR)
                {
                }
                COLUMN(GSTCOMPONENTSGSTCR; GSTCOMPONENTSGSTCR)
                {
                }
                COLUMN(GSTCOMPONENTIGSTCR; GSTCOMPONENTIGSTCR)
                {
                }
                COLUMN(CRDESC; SALESCRMEMOLINE1.DESCRIPTION)
                {
                }
                COLUMN(CRMOBILE; SALESCRMEMOLINE1."CUST. MOBILE NO.")
                {
                }
                COLUMN(CREMAILID; SALESCRMEMOLINE1."CUST. EMAIL ID")
                {
                }
                COLUMN(CUSTINVNO; CUSTINVNO)
                {
                }
                COLUMN(TCGSTAMTCR; TCGSTAMTCR)
                {
                }
                COLUMN(TSGSTAMTCR; TSGSTAMTCR)
                {
                }
                COLUMN(TIGSTAMTCR; TIGSTAMTCR)
                {
                }

                TRIGGER ONAFTERGETRECORD()
                VAR
                    SALESINVOICELINE1: RECORD "Sales Invoice Line";
                    CUSTOMERMOBNO: DECIMAL;
                    CUSTOMEREMAILID: TEXT[100];
                BEGIN
                    //SCM CHECK++
                    //MESSAGE("SALES INVOICE LINE"."DOCUMENT NO.");
                    // SALESCRMEMOHEADER.RESET;
                    // SALESCRMEMOHEADER.SETRANGE("APPLIES-TO DOC. NO.","SALES INVOICE LINE"."DOCUMENT NO.");
                    // IF SALESCRMEMOHEADER.FINDFIRST THEN BEGIN
                    //   ITEMLEDGERENTRY.RESET;
                    //   ITEMLEDGERENTRY.SETRANGE("DOCUMENT NO.",SALESCRMEMOHEADER."NO.");
                    //   ITEMLEDGERENTRY.SETRANGE("ITEM NO.","SALES INVOICE LINE"."NO.");
                    //   ITEMLEDGERENTRY.SETRANGE("DOCUMENT TYPE",ITEMLEDGERENTRY."DOCUMENT TYPE"::"SALES CREDIT MEMO");
                    //   ITEMLEDGERENTRY.SETRANGE("SERIAL NO.","SALES INVOICE LINE"."SERIAL NO.");
                    //   IF ITEMLEDGERENTRY.FINDFIRST THEN
                    //     CURRREPORT.SKIP;
                    // END;
                    // //FOR SHIELD RETURN++
                    // SALESCRMEMOHEADER.RESET;
                    // SALESCRMEMOHEADER.SETRANGE("APPLIES-TO DOC. NO.","SALES INVOICE LINE"."DOCUMENT NO.");
                    // IF SALESCRMEMOHEADER.FINDFIRST THEN BEGIN
                    //   IF "SALES INVOICE LINE".TYPE="SALES INVOICE LINE".TYPE::"G/L ACCOUNT" THEN BEGIN
                    //      SALESCRMEMOLINE.RESET;
                    //      SALESCRMEMOLINE.SETRANGE("DOCUMENT NO.",SALESCRMEMOHEADER."NO.");
                    //      SALESCRMEMOLINE.SETRANGE(TYPE,"SALES INVOICE LINE".TYPE::"G/L ACCOUNT");
                    //      SALESCRMEMOLINE.SETRANGE("NO.","SALES INVOICE LINE"."NO.");
                    //      SALESCRMEMOLINE.SETRANGE("IMEI NO.","SALES INVOICE LINE"."IMEI NO.");
                    //      IF SALESCRMEMOLINE.FINDFIRST THEN
                    //        CURRREPORT.SKIP;
                    //   END;
                    //END;
                    //SCM CHECK--
                    //MESSAGE('2'+"SALES INVOICE LINE"."DOCUMENT NO.");
                    //IF STATEREC.GET("SALES INVOICE LINE".STATE) THEN;
                    IF ITEM.GET("SALES INVOICE LINE"."NO.") THEN;
                    IF SCHEM.GET("SALES INVOICE LINE"."SCHEME CODE") THEN;
                    SALESPRICE := 0;
                    SALESPRICE := "SALES INVOICE LINE".QUANTITY * "SALES INVOICE LINE"."UNIT PRICE";
                    TOTSALESAMT := 0;
                    TOTSALESAMT := (("SALES INVOICE LINE".QUANTITY * "SALES INVOICE LINE"."UNIT PRICE INCL. OF TAX") - ("SALES INVOICE LINE"."SCHEME AMOUNT" + "SALES INVOICE LINE"."LINE DISCOUNT AMOUNT"));
                    NETSALESWOTAX := 0;
                    NETSALESWOTAX := (("SALES INVOICE LINE".QUANTITY * "SALES INVOICE LINE"."UNIT PRICE") - ("SALES INVOICE LINE"."SCHEME AMOUNT" + "SALES INVOICE LINE"."LINE DISCOUNT AMOUNT"));
                    SERVTAXPERC := 0;
                    //IF ("SALES INVOICE LINE"."SERVICE TAX AMOUNT" <> 0) AND ("SALES INVOICE LINE"."SERVICE TAX BASE" <> 0) THEN
                    //  SERVTAXPERC := ("SALES INVOICE LINE"."SERVICE TAX AMOUNT" + "SALES INVOICE LINE"."SERVICE TAX ECESS AMOUNT" + "SALES INVOICE LINE"."SERVICE TAX SHE CESS AMOUNT") / "SALES INVOICE LINE"."SERVICE TAX BASE";

                    /*
                    IF "SALES INVOICE LINE".SHIELD=TRUE THEN
                    IF "SALES INVOICE LINE".TYPE="SALES INVOICE LINE".TYPE::"G/L ACCOUNT" THEN
                    IF "SALES INVOICE LINE"."NO."<>'310008' THEN
                    CURRREPORT.SKIP;


                    BRAND:='';
                    CATGRY:='';
                    PRIMCAT:='';
                    SECCAT:='';
                    THIRDCAT:='';
                    ITEMCODE:='';

                    UOM:='';
                    VENDITEMCODE:='';
                    ITEMREC.RESET;
                    ITEMREC.SETFILTER(ITEMREC."NO.","SALES INVOICE LINE"."NO.");
                    IF ITEMREC.FINDFIRST THEN
                    //VENDITEMCODE:=ITEMREC."VENDOR ITEM NO.";
                    VENDITEMCODE:=ITEMREC."VENDOR PART CODE LONG";

                    ITEMDESC:='';
                    SALESINVLINE.RESET;
                    SALESINVLINE.SETFILTER(SALESINVLINE."DOCUMENT NO.",REFNO);
                    SALESINVLINE.SETFILTER(SALESINVLINE."NO.","SALES INVOICE LINE"."DESCRIPTION 2");
                    IF SALESINVLINE.FINDFIRST THEN
                    BEGIN
                    ITEMDESC:=SALESINVLINE.DESCRIPTION;
                    UOM:=SALESINVLINE."UNIT OF MEASURE";
                    BRAND:=SALESINVLINE."ITEM CATEGORY CODE";
                    CATGRY:=SALESINVLINE."PRODUCT GROUP CODE";
                    PRIMCAT:=SALESINVLINE."PRIMARY CATEGORY";
                    SECCAT:=SALESINVLINE."SECONDARY CATEGORY";
                    THIRDCAT:=SALESINVLINE."THIRD CATEGORY";
                    ITEMCODE:=SALESINVLINE."NO.";
                    END;
                    */

                    //FOR GST FIELDS WIN347++
                    CLEAR(CGSTAMT);
                    CLEAR(CGSTRATE);
                    CLEAR(GSTCOMPONENTCGST);
                    CLEAR(SGSTAMT);
                    CLEAR(SGSTRATE);
                    CLEAR(GSTCOMPONENTSGST);
                    CLEAR(IGSTAMT);
                    CLEAR(IGSTRATE);
                    CLEAR(GSTCOMPONENTIGST);
                    GSTDETAILLEGER.RESET;
                    GSTDETAILLEGER.SETRANGE(GSTDETAILLEGER."DOCUMENT NO.", "SALES INVOICE LINE"."DOCUMENT NO.");
                    GSTDETAILLEGER.SETRANGE(GSTDETAILLEGER."NO.", "SALES INVOICE LINE"."NO.");
                    GSTDETAILLEGER.SETRANGE(GSTDETAILLEGER."DOCUMENT LINE NO.", "SALES INVOICE LINE"."LINE NO.");
                    IF GSTDETAILLEGER.FINDSET THEN
                        REPEAT
                            IF GSTDETAILLEGER."GST COMPONENT CODE" = 'CGST' THEN BEGIN
                                GSTCOMPONENTCGST := 'CGST';
                                CGSTRATE := GSTDETAILLEGER."GST %";
                                CGSTAMT := GSTDETAILLEGER."GST AMOUNT";
                            END ELSE
                                IF GSTDETAILLEGER."GST COMPONENT CODE" = 'SGST' THEN BEGIN
                                    GSTCOMPONENTSGST := 'SGST';
                                    SGSTRATE := GSTDETAILLEGER."GST %";
                                    SGSTAMT := GSTDETAILLEGER."GST AMOUNT";
                                END ELSE
                                    IF GSTDETAILLEGER."GST COMPONENT CODE" = 'IGST' THEN BEGIN
                                        GSTCOMPONENTIGST := 'IGST';
                                        IGSTRATE := GSTDETAILLEGER."GST %";
                                        IGSTAMT := GSTDETAILLEGER."GST AMOUNT";
                                    END;
                        UNTIL GSTDETAILLEGER.NEXT = 0;
                    //FOR GST FIELDS WIN347--

                    //HR+
                    ELEVADES := '';
                    ELEVAIMEINO := '';
                    ELEVASERIALNO := '';
                    ELEVAPRICE := 0;
                    CUSTINVNO := '';

                    SALESINVOICELINE1.SETRANGE("DOCUMENT NO.", "SALES INVOICE LINE"."DOCUMENT NO.");
                    SALESINVOICELINE1.SETRANGE("PRIMARY CATEGORY", "SALES INVOICE LINE"."PRIMARY CATEGORY");
                    SALESINVOICELINE1.SETRANGE("ITEM CATEGORY CODE", 'ELEVA');
                    IF SALESINVOICELINE1.FINDFIRST THEN BEGIN
                        ELEVADES := SALESINVOICELINE1.DESCRIPTION;
                        ELEVAIMEINO := SALESINVOICELINE1."IMEI NO.";
                        ELEVASERIALNO := SALESINVOICELINE1."SERIAL NO.";
                        ELEVAPRICE := SALESINVOICELINE1."UNIT PRICE INCL. OF TAX";
                        CUSTINVNO := SALESINVOICELINE1."DOCUMENT NO.";
                        CLEAR(SALESCRMEMOLINE1);
                        SALESCRMEMOLINE1.RESET;
                        SALESCRMEMOLINE1.SETRANGE("NO.", SALESINVOICELINE1."NO.");
                        SALESCRMEMOLINE1.SETRANGE("IMEI NO.", SALESINVOICELINE1."IMEI NO.");
                        SALESCRMEMOLINE1.SETRANGE("ITEM SERIAL NO.", SALESINVOICELINE1."SERIAL NO.");
                        SALESCRMEMOLINE1.SETRANGE("ITEM CATEGORY CODE", 'ELEVA');
                        SALESCRMEMOLINE1.SETRANGE("SELL-TO CUSTOMER NO.", SALESINVOICELINE1."SELL-TO CUSTOMER NO.");
                        IF SALESCRMEMOLINE1.FINDFIRST THEN BEGIN
                            CLEAR(CGSTAMTCR);
                            CLEAR(CGSTRATECR);
                            CLEAR(GSTCOMPONENTCGSTCR);
                            CLEAR(SGSTAMTCR);
                            CLEAR(SGSTRATECR);
                            CLEAR(GSTCOMPONENTSGSTCR);
                            CLEAR(IGSTAMTCR);
                            CLEAR(IGSTRATECR);
                            CLEAR(GSTCOMPONENTIGSTCR);
                            GSTDETAILLEGER.RESET;
                            GSTDETAILLEGER.SETRANGE(GSTDETAILLEGER."DOCUMENT NO.", SALESCRMEMOLINE1."DOCUMENT NO.");
                            GSTDETAILLEGER.SETRANGE(GSTDETAILLEGER."NO.", SALESCRMEMOLINE1."NO.");
                            GSTDETAILLEGER.SETRANGE(GSTDETAILLEGER."DOCUMENT LINE NO.", SALESCRMEMOLINE1."LINE NO.");
                            IF GSTDETAILLEGER.FINDSET THEN
                                REPEAT
                                    IF GSTDETAILLEGER."GST COMPONENT CODE" = 'CGST' THEN BEGIN
                                        GSTCOMPONENTCGSTCR := 'CGST';
                                        CGSTRATECR := GSTDETAILLEGER."GST %";
                                        CGSTAMTCR := GSTDETAILLEGER."GST AMOUNT";
                                        TCGSTAMTCR += GSTDETAILLEGER."GST AMOUNT";
                                    END ELSE
                                        IF GSTDETAILLEGER."GST COMPONENT CODE" = 'SGST' THEN BEGIN
                                            GSTCOMPONENTSGSTCR := 'SGST';
                                            SGSTRATECR := GSTDETAILLEGER."GST %";
                                            SGSTAMTCR := GSTDETAILLEGER."GST AMOUNT";
                                            TSGSTAMTCR += GSTDETAILLEGER."GST AMOUNT";
                                        END ELSE
                                            IF GSTDETAILLEGER."GST COMPONENT CODE" = 'IGST' THEN BEGIN
                                                GSTCOMPONENTIGSTCR := 'IGST';
                                                IGSTRATECR := GSTDETAILLEGER."GST %";
                                                IGSTAMTCR := GSTDETAILLEGER."GST AMOUNT";
                                                TIGSTAMTCR += GSTDETAILLEGER."GST AMOUNT";
                                            END;
                                UNTIL GSTDETAILLEGER.NEXT = 0;
                        END;


                    END;

                    IF ELEVADES = '' THEN
                        CURRREPORT.SKIP;


                    //HR-

                END;
            }
            DATAITEM(SalesInvoiceLineNew; "Sales Invoice Line")
            {
                DATAITEMLINK = "DOCUMENT NO." = FIELD("NO.");
                DATAITEMTABLEVIEW = WHERE("ITEM CATEGORY CODE" = FILTER('ELEVA'));
                COLUMN(FORMAT_TODAY_0_4_1; FORMAT(TODAY, 0, 4))
                {
                }
                COLUMN(CURRREPORT_PAGENO1; CURRREPORT.PAGENO)
                {
                }
                COLUMN(SRNO1; SRNO)
                {
                }
                COLUMN(SELLTOCUST1; "SALES INVOICE HEADER"."SELL-TO CUSTOMER NAME")
                {
                }
                COLUMN(LOCATION1; "SALES INVOICE HEADER"."LOCATION CODE")
                {
                }
                COLUMN(SO_DT1; "SALES INVOICE HEADER"."ORDER DATE")
                {
                }
                COLUMN(VERTICAL1; "SALES INVOICE HEADER"."SHORTCUT DIMENSION 2 CODE")
                {
                }
                COLUMN(INVNO1; "SALES INVOICE HEADER"."NO.")
                {
                }
                COLUMN(INV_DT1; "SALES INVOICE HEADER"."POSTING DATE")
                {
                }
                COLUMN(CUSTNM1; "SALES INVOICE HEADER"."SELL-TO CUSTOMER NAME")
                {
                }
                COLUMN(CUSTNO1; "SALES INVOICE HEADER"."SELL-TO CUSTOMER NO.")
                {
                }
                COLUMN(SELLTOCTY1; "SALES INVOICE HEADER"."SELL-TO CITY")
                {
                }
                COLUMN(SALEP1; "SALES INVOICE HEADER"."SALESPERSON CODE")
                {
                }
                COLUMN(DELNOTE1; "SALES INVOICE HEADER"."DELIVERY NOTE")
                {
                }
                COLUMN(DISPDOCNO1; "SALES INVOICE HEADER"."DISPATCH DOC. NO.")
                {
                }
                COLUMN(DISPTHRU1; "SALES INVOICE HEADER"."DISPATCH THROUGH")
                {
                }
                COLUMN(PAYTERMS1; "SALES INVOICE HEADER"."PAYMENT TERMS CODE")
                {
                }
                COLUMN(CUSTOMERMOBNO1; "SALES INVOICE HEADER"."CUST. MOBILE NO.")
                {
                }
                COLUMN(CUSTEMAILID1; "SALES INVOICE HEADER"."CUST. EMAIL ID")
                {
                }
                COLUMN(SALESPNM1; SALESP.NAME)
                {
                }
                COLUMN(PAYTERMSDESC1; PAYTERMS.DESCRIPTION)
                {
                }
                COLUMN(SONO1; "SALES INVOICE HEADER"."ORDER NO.")
                {
                }
                COLUMN(PONO1; PURCHHDR."NO.")
                {
                }
                COLUMN(PODT1; PURCHHDR."POSTING DATE")
                {
                }
                COLUMN(GSTTIN_NO1; GSTTIN_NO)
                {
                }
                COLUMN(PLACEOFSUPPLY1; PLACEOFSUPPLY)
                {
                }
                COLUMN(SHIELDAMTWOTAX1; SalesInvoiceLineNew."UNIT PRICE")
                {
                }
                //COLUMN(SHIELDTAXAMT1; SALESINVOICELINE."TAX AMOUNT") { }
                COLUMN(ITEMNOSHIELD1; SalesInvoiceLineNew."DESCRIPTION 2")
                {
                }
                COLUMN(SHIELDTYPE1; SalesInvoiceLineNew."SHIELD TYPE")
                {
                }
                // COLUMN(SHIELDAMOUNTWITHTAX1; SALESINVOICELINE."AMOUNT INCLUDING TAX")                {                }
                COLUMN(ZONE1; STATEREC.ZONE)
                {
                }
                COLUMN(STATENM1; STATEREC.DESCRIPTION)
                {
                }
                COLUMN(VENDITEMCD1; ITEM."VENDOR PART CODE LONG")
                {
                }
                COLUMN(SCHEMECODE1; SalesInvoiceLineNew."SCHEME CODE")
                {
                }
                COLUMN(SRLNO1; SalesInvoiceLineNew."SERIAL NO.")
                {
                }
                COLUMN(IMEINO1; SalesInvoiceLineNew."IMEI NO.")
                {
                }
                COLUMN(SCHMAMT1; SalesInvoiceLineNew."SCHEME AMOUNT")
                {
                }
                COLUMN(SCHMPERC1; SalesInvoiceLineNew."SCHEME %")
                {
                }
                COLUMN(MAPLECODE1; SalesInvoiceLineNew."NO.")
                {
                }
                COLUMN(PARTDESC1; SalesInvoiceLineNew.DESCRIPTION)
                {
                }
                COLUMN(QTY1; SalesInvoiceLineNew.QUANTITY)
                {
                }
                COLUMN(UNITP1; SalesInvoiceLineNew."UNIT PRICE")
                {
                }
                //COLUMN(TAXAMT1; SALESINVOICELINE."TAX AMOUNT")                {                }
                //COLUMN(TAXP1; SALESINVOICELINE."TAX %")                {                }
                //COLUMN(SERVTAXAMT1; SALESINVOICELINE."SERVICE TAX AMOUNT")                {                }
                COLUMN(SCHMDESC1; SCHEM.DESCRITPION)
                {
                }
                COLUMN(NETSALESWOTAX1; NETSALESWOTAX)
                {
                }
                COLUMN(TOTSALESAMT1; TOTSALESAMT)
                {
                }
                COLUMN(SALESPRICE1; SALESPRICE)
                {
                }
                COLUMN(MAPLEDISCAMT1; SalesInvoiceLineNew."LINE DISCOUNT AMOUNT")
                {
                }
                COLUMN(MAPLELINEDISC1; SalesInvoiceLineNew."LINE DISCOUNT %")
                {
                }
                //COLUMN(CHARGES1; SALESINVOICELINE."CHARGES TO CUSTOMER")                {                }
                COLUMN(SERVTAXPERC1; SERVTAXPERC)
                {
                }
                COLUMN(UOM1; SalesInvoiceLineNew."UNIT OF MEASURE")
                {
                }
                COLUMN(BRAND1; SalesInvoiceLineNew."ITEM CATEGORY CODE")
                {
                }
                COLUMN(CATGRY1; SalesInvoiceLineNew."Product Category")
                {
                }
                COLUMN(SALESPOINTS_SALESINVOICELINE1; SalesInvoiceLineNew."SALES POINTS")
                {
                }
                COLUMN(GSTGROUPCODE1; SalesInvoiceLineNew."GST GROUP CODE")
                {
                }
                COLUMN(HSN_SAC_CODE1; SalesInvoiceLineNew."HSN/SAC CODE")
                {
                }
                COLUMN(CGSTAMT1; ABS(CGSTAMT))
                {
                }
                COLUMN(SGSTAMT1; ABS(SGSTAMT))
                {
                }
                COLUMN(IGSTAMT1; ABS(IGSTAMT))
                {
                }
                COLUMN(TOTALGSTAMOUNT1; ABS(CGSTAMT) + ABS(SGSTAMT) + ABS(IGSTAMT)) { }
                COLUMN(AMOUNTTOCUSTOMER_SALESINVOICELINE1; SalesInvoiceLineNew.Amount)
                {
                }
                COLUMN(ELEVADES1; ELEVADES)
                {
                }
                COLUMN(ELEVAIMEINO1; ELEVAIMEINO)
                {
                }
                COLUMN(ELEVASERIALNO1; ELEVASERIALNO)
                {
                }
                COLUMN(ELEVAPRICE1; ELEVAPRICE)
                {
                }
                COLUMN(CRITEMNO1; SALESCRMEMOLINE1."NO.")
                {
                }
                COLUMN(CRAMOUNT1; SALESCRMEMOLINE1."AMOUNT INCLUDING VAT")
                {
                }
                COLUMN(CRSERIALNO1; SALESCRMEMOLINE1."ITEM SERIAL NO.")
                {
                }
                COLUMN(CRIMEINO1; SALESCRMEMOLINE1."IMEI NO.")
                {
                }
                COLUMN(CRDOCNO1; SALESCRMEMOLINE1."DOCUMENT NO.")
                {
                }
                COLUMN(CRCUSTNO1; SALESCRMEMOLINE1."SELL-TO CUSTOMER NO.")
                {
                }
                COLUMN(CRLOC1; SALESCRMEMOLINE1."LOCATION CODE")
                {
                }
                COLUMN(CRPOST1; SALESCRMEMOLINE1."POSTING DATE")
                {
                }
                COLUMN(CRSELLTOCUSTNAME1; "SALES INVOICE HEADER"."SELL-TO CUSTOMER NAME")
                {
                }
                COLUMN(CGSTRATECR1; CGSTRATECR)
                {
                }
                COLUMN(CGSTAMTCR1; CGSTAMTCR)
                {
                }
                COLUMN(SGSTAMTCR1; SGSTAMTCR)
                {
                }
                COLUMN(SGSTRATECR1; SGSTRATECR)
                {
                }
                COLUMN(IGSTRATECR1; IGSTRATECR)
                {
                }
                COLUMN(IGSTAMTCR1; IGSTAMTCR)
                {
                }
                COLUMN(GSTCOMPONENTCGSTCR1; GSTCOMPONENTCGSTCR)
                {
                }
                COLUMN(GSTCOMPONENTSGSTCR1; GSTCOMPONENTSGSTCR)
                {
                }
                COLUMN(GSTCOMPONENTIGSTCR1; GSTCOMPONENTIGSTCR)
                {
                }
                COLUMN(CRDESC1; SALESCRMEMOLINE1.DESCRIPTION)
                {
                }
                COLUMN(CRMOBILE1; SALESCRMEMOLINE1."CUST. MOBILE NO.")
                {
                }
                COLUMN(CREMAILID1; SALESCRMEMOLINE1."CUST. EMAIL ID")
                {
                }
                COLUMN(CUSTINVNO1; CUSTINVNO)
                {
                }
                COLUMN(TCGSTAMTCR1; TCGSTAMTCR)
                {
                }
                COLUMN(TSGSTAMTCR1; TSGSTAMTCR)
                {
                }
                COLUMN(TIGSTAMTCR1; TIGSTAMTCR)
                {
                }

                TRIGGER ONAFTERGETRECORD()
                VAR
                    SALESINVOICELINE2: RECORD "Sales Invoice Line";
                    CUSTOMERMOBNO: DECIMAL;
                    CUSTOMEREMAILID: TEXT[100];
                BEGIN
                    //SCM CHECK++
                    //MESSAGE("SALES INVOICE LINE"."DOCUMENT NO.");
                    // SALESCRMEMOHEADER.RESET;
                    // SALESCRMEMOHEADER.SETRANGE("APPLIES-TO DOC. NO.","SALES INVOICE LINE"."DOCUMENT NO.");
                    // IF SALESCRMEMOHEADER.FINDFIRST THEN BEGIN
                    //   ITEMLEDGERENTRY.RESET;
                    //   ITEMLEDGERENTRY.SETRANGE("DOCUMENT NO.",SALESCRMEMOHEADER."NO.");
                    //   ITEMLEDGERENTRY.SETRANGE("ITEM NO.","SALES INVOICE LINE"."NO.");
                    //   ITEMLEDGERENTRY.SETRANGE("DOCUMENT TYPE",ITEMLEDGERENTRY."DOCUMENT TYPE"::"SALES CREDIT MEMO");
                    //   ITEMLEDGERENTRY.SETRANGE("SERIAL NO.","SALES INVOICE LINE"."SERIAL NO.");
                    //   IF ITEMLEDGERENTRY.FINDFIRST THEN
                    //     CURRREPORT.SKIP;
                    // END;
                    // //FOR SHIELD RETURN++
                    // SALESCRMEMOHEADER.RESET;
                    // SALESCRMEMOHEADER.SETRANGE("APPLIES-TO DOC. NO.","SALES INVOICE LINE"."DOCUMENT NO.");
                    // IF SALESCRMEMOHEADER.FINDFIRST THEN BEGIN
                    //   IF "SALES INVOICE LINE".TYPE="SALES INVOICE LINE".TYPE::"G/L ACCOUNT" THEN BEGIN
                    //      SALESCRMEMOLINE.RESET;
                    //      SALESCRMEMOLINE.SETRANGE("DOCUMENT NO.",SALESCRMEMOHEADER."NO.");
                    //      SALESCRMEMOLINE.SETRANGE(TYPE,"SALES INVOICE LINE".TYPE::"G/L ACCOUNT");
                    //      SALESCRMEMOLINE.SETRANGE("NO.","SALES INVOICE LINE"."NO.");
                    //      SALESCRMEMOLINE.SETRANGE("IMEI NO.","SALES INVOICE LINE"."IMEI NO.");
                    //      IF SALESCRMEMOLINE.FINDFIRST THEN
                    //        CURRREPORT.SKIP;
                    //   END;
                    //END;
                    //SCM CHECK--
                    //MESSAGE('2'+"SALES INVOICE LINE"."DOCUMENT NO.");

                    //IF STATEREC.GET(SalesInvoiceLineNew.State) THEN;
                    IF ITEM.GET(SalesInvoiceLineNew."NO.") THEN;
                    IF SCHEM.GET(SalesInvoiceLineNew."SCHEME CODE") THEN;
                    SALESPRICE := 0;
                    SALESPRICE := SalesInvoiceLineNew.QUANTITY * SalesInvoiceLineNew."UNIT PRICE";
                    TOTSALESAMT := 0;
                    TOTSALESAMT := ((SalesInvoiceLineNew.QUANTITY * SalesInvoiceLineNew."UNIT PRICE INCL. OF TAX") - (SalesInvoiceLineNew."SCHEME AMOUNT" + SalesInvoiceLineNew."LINE DISCOUNT AMOUNT"));
                    NETSALESWOTAX := 0;
                    NETSALESWOTAX := ((SalesInvoiceLineNew.QUANTITY * SalesInvoiceLineNew."UNIT PRICE") - (SalesInvoiceLineNew."SCHEME AMOUNT" + SalesInvoiceLineNew."LINE DISCOUNT AMOUNT"));
                    SERVTAXPERC := 0;
                    //IF (SalesInvoiceLineNew."SERVICE TAX AMOUNT" <> 0) AND (SalesInvoiceLineNew."SERVICE TAX BASE" <> 0) THEN
                    //SERVTAXPERC := (SalesInvoiceLineNew."SERVICE TAX AMOUNT" + SalesInvoiceLineNew."SERVICE TAX ECESS AMOUNT" + SalesInvoiceLineNew."SERVICE TAX SHE CESS AMOUNT") / SalesInvoiceLineNew."SERVICE TAX BASE";

                    /*
                    IF "SALES INVOICE LINE".SHIELD=TRUE THEN
                    IF "SALES INVOICE LINE".TYPE="SALES INVOICE LINE".TYPE::"G/L ACCOUNT" THEN
                    IF "SALES INVOICE LINE"."NO."<>'310008' THEN
                    CURRREPORT.SKIP;


                    BRAND:='';
                    CATGRY:='';
                    PRIMCAT:='';
                    SECCAT:='';
                    THIRDCAT:='';
                    ITEMCODE:='';

                    UOM:='';
                    VENDITEMCODE:='';
                    ITEMREC.RESET;
                    ITEMREC.SETFILTER(ITEMREC."NO.","SALES INVOICE LINE"."NO.");
                    IF ITEMREC.FINDFIRST THEN
                    //VENDITEMCODE:=ITEMREC."VENDOR ITEM NO.";
                    VENDITEMCODE:=ITEMREC."VENDOR PART CODE LONG";

                    ITEMDESC:='';
                    SALESINVLINE.RESET;
                    SALESINVLINE.SETFILTER(SALESINVLINE."DOCUMENT NO.",REFNO);
                    SALESINVLINE.SETFILTER(SALESINVLINE."NO.","SALES INVOICE LINE"."DESCRIPTION 2");
                    IF SALESINVLINE.FINDFIRST THEN
                    BEGIN
                    ITEMDESC:=SALESINVLINE.DESCRIPTION;
                    UOM:=SALESINVLINE."UNIT OF MEASURE";
                    BRAND:=SALESINVLINE."ITEM CATEGORY CODE";
                    CATGRY:=SALESINVLINE."PRODUCT GROUP CODE";
                    PRIMCAT:=SALESINVLINE."PRIMARY CATEGORY";
                    SECCAT:=SALESINVLINE."SECONDARY CATEGORY";
                    THIRDCAT:=SALESINVLINE."THIRD CATEGORY";
                    ITEMCODE:=SALESINVLINE."NO.";
                    END;
                    */

                    //FOR GST FIELDS WIN347++
                    CLEAR(CGSTAMT);
                    CLEAR(CGSTRATE);
                    CLEAR(GSTCOMPONENTCGST);
                    CLEAR(SGSTAMT);
                    CLEAR(SGSTRATE);
                    CLEAR(GSTCOMPONENTSGST);
                    CLEAR(IGSTAMT);
                    CLEAR(IGSTRATE);
                    CLEAR(GSTCOMPONENTIGST);
                    GSTDETAILLEGER.RESET;
                    GSTDETAILLEGER.SETRANGE(GSTDETAILLEGER."DOCUMENT NO.", SalesInvoiceLineNew."DOCUMENT NO.");
                    GSTDETAILLEGER.SETRANGE(GSTDETAILLEGER."NO.", SalesInvoiceLineNew."NO.");
                    GSTDETAILLEGER.SETRANGE(GSTDETAILLEGER."DOCUMENT LINE NO.", SalesInvoiceLineNew."LINE NO.");
                    IF GSTDETAILLEGER.FINDSET THEN
                        REPEAT
                            IF GSTDETAILLEGER."GST COMPONENT CODE" = 'CGST' THEN BEGIN
                                GSTCOMPONENTCGST := 'CGST';
                                CGSTRATE := GSTDETAILLEGER."GST %";
                                CGSTAMT := GSTDETAILLEGER."GST AMOUNT";
                            END ELSE
                                IF GSTDETAILLEGER."GST COMPONENT CODE" = 'SGST' THEN BEGIN
                                    GSTCOMPONENTSGST := 'SGST';
                                    SGSTRATE := GSTDETAILLEGER."GST %";
                                    SGSTAMT := GSTDETAILLEGER."GST AMOUNT";
                                END ELSE
                                    IF GSTDETAILLEGER."GST COMPONENT CODE" = 'IGST' THEN BEGIN
                                        GSTCOMPONENTIGST := 'IGST';
                                        IGSTRATE := GSTDETAILLEGER."GST %";
                                        IGSTAMT := GSTDETAILLEGER."GST AMOUNT";
                                    END;
                        UNTIL GSTDETAILLEGER.NEXT = 0;
                    //FOR GST FIELDS WIN347--

                    //HR+
                    ELEVADES := '';
                    ELEVAIMEINO := '';
                    ELEVASERIALNO := '';
                    ELEVAPRICE := 0;
                    CUSTINVNO := '';

                    SALESINVOICELINE2.SETRANGE("DOCUMENT NO.", SalesInvoiceLineNew."DOCUMENT NO.");
                    SALESINVOICELINE2.SETRANGE("PRIMARY CATEGORY", SalesInvoiceLineNew."PRIMARY CATEGORY");
                    SALESINVOICELINE2.SETFILTER("ITEM CATEGORY CODE", '<>%1', 'ELEVA');
                    IF SALESINVOICELINE2.FINDFIRST THEN BEGIN
                        ELEVADES := SALESINVOICELINE2.DESCRIPTION;
                        ELEVAIMEINO := SALESINVOICELINE2."IMEI NO.";
                        ELEVASERIALNO := SALESINVOICELINE2."SERIAL NO.";
                        ELEVAPRICE := SALESINVOICELINE2."UNIT PRICE INCL. OF TAX";
                        CUSTINVNO := SALESINVOICELINE2."DOCUMENT NO.";
                        CLEAR(SALESCRMEMOLINE1);
                        SALESCRMEMOLINE1.RESET;
                        SALESCRMEMOLINE1.SETRANGE("NO.", SALESINVOICELINE2."NO.");
                        SALESCRMEMOLINE1.SETRANGE("IMEI NO.", SALESINVOICELINE2."IMEI NO.");
                        SALESCRMEMOLINE1.SETRANGE("ITEM SERIAL NO.", SALESINVOICELINE2."SERIAL NO.");
                        SALESCRMEMOLINE1.SETRANGE("ITEM CATEGORY CODE", 'ELEVA');
                        SALESCRMEMOLINE1.SETRANGE("SELL-TO CUSTOMER NO.", SALESINVOICELINE2."SELL-TO CUSTOMER NO.");
                        IF SALESCRMEMOLINE1.FINDFIRST THEN BEGIN
                            CLEAR(CGSTAMTCR);
                            CLEAR(CGSTRATECR);
                            CLEAR(GSTCOMPONENTCGSTCR);
                            CLEAR(SGSTAMTCR);
                            CLEAR(SGSTRATECR);
                            CLEAR(GSTCOMPONENTSGSTCR);
                            CLEAR(IGSTAMTCR);
                            CLEAR(IGSTRATECR);
                            CLEAR(GSTCOMPONENTIGSTCR);
                            GSTDETAILLEGER.RESET;
                            GSTDETAILLEGER.SETRANGE(GSTDETAILLEGER."DOCUMENT NO.", SALESCRMEMOLINE1."DOCUMENT NO.");
                            GSTDETAILLEGER.SETRANGE(GSTDETAILLEGER."NO.", SALESCRMEMOLINE1."NO.");
                            GSTDETAILLEGER.SETRANGE(GSTDETAILLEGER."DOCUMENT LINE NO.", SALESCRMEMOLINE1."LINE NO.");
                            IF GSTDETAILLEGER.FINDSET THEN
                                REPEAT
                                    IF GSTDETAILLEGER."GST COMPONENT CODE" = 'CGST' THEN BEGIN
                                        GSTCOMPONENTCGSTCR := 'CGST';
                                        CGSTRATECR := GSTDETAILLEGER."GST %";
                                        CGSTAMTCR := GSTDETAILLEGER."GST AMOUNT";
                                        TCGSTAMTCR += GSTDETAILLEGER."GST AMOUNT";
                                    END ELSE
                                        IF GSTDETAILLEGER."GST COMPONENT CODE" = 'SGST' THEN BEGIN
                                            GSTCOMPONENTSGSTCR := 'SGST';
                                            SGSTRATECR := GSTDETAILLEGER."GST %";
                                            SGSTAMTCR := GSTDETAILLEGER."GST AMOUNT";
                                            TSGSTAMTCR += GSTDETAILLEGER."GST AMOUNT";
                                        END ELSE
                                            IF GSTDETAILLEGER."GST COMPONENT CODE" = 'IGST' THEN BEGIN
                                                GSTCOMPONENTIGSTCR := 'IGST';
                                                IGSTRATECR := GSTDETAILLEGER."GST %";
                                                IGSTAMTCR := GSTDETAILLEGER."GST AMOUNT";
                                                TIGSTAMTCR += GSTDETAILLEGER."GST AMOUNT";
                                            END;
                                UNTIL GSTDETAILLEGER.NEXT = 0;
                        END;


                    END;

                    IF ELEVADES <> '' THEN
                        CURRREPORT.SKIP;


                    //HR-

                END;
            }

            TRIGGER ONAFTERGETRECORD()
            VAR
                SALESINVOICELINE: RECORD "Sales Invoice Line";
            BEGIN

                SRNO += 1;

                IF SALESP.GET("SALES INVOICE HEADER"."SALESPERSON CODE") THEN;


                IF PAYTERMS.GET("SALES INVOICE HEADER"."PAYMENT TERMS CODE") THEN;


                IF SALESHDR.GET(SALESHDR."DOCUMENT TYPE"::ORDER, "SALES INVOICE HEADER"."ORDER NO.") THEN;


                IF PURCHHDR.GET(PURCHHDR."DOCUMENT TYPE"::ORDER, SALESHDR."PURCHASEORDERNO.") THEN;


                TERMS := '';
                REFNO := '';
                SALESINVHDR.RESET;
                SALESINVHDR.SETFILTER(SALESINVHDR."NO.", "SALES INVOICE HEADER"."NO.");
                IF SALESINVHDR.FINDFIRST THEN
                    IF SALESINVHDR."REF. INVOICE NO." <> '' THEN
                        REFNO := SALESINVHDR."REF. INVOICE NO.";
                //MESSAGE('%1',REFNO);
                /*
                SALESINVLINE.RESET;
                SALESINVLINE.SETFILTER(SALESINVLINE."DOCUMENT NO.",REFNO);
                IF SALESINVLINE.FINDFIRST THEN
                BEGIN
                SHIELDREC.RESET;
                SHIELDREC.SETRANGE(SHIELDREC."SCHEME CODE",SALESINVLINE."SHIELD TYPE");
                IF SHIELDREC.FINDFIRST THEN
                TERMS:=SHIELDREC."SHIELD INSURANCE T&C" + ' ' + SHIELDREC."DOCUMENT DATE" + ' ' + SHIELDREC."PRODUCT GROUP CODE" + ' ' + SHIELDREC."STARTING DATE";
                END;
                */

                CLEAR(GSTTIN_NO);
                CLEAR(CUST_STATE);
                CLEAR(PLACEOFSUPPLY);
                RECCUSTOMER.RESET;
                RECCUSTOMER.SETRANGE("NO.", "SALES INVOICE HEADER"."SELL-TO CUSTOMER NO.");
                IF RECCUSTOMER.FINDFIRST THEN
                    GSTTIN_NO := RECCUSTOMER."GST REGISTRATION NO.";
                CUST_STATE := RECCUSTOMER."STATE CODE";

                STATEREC.RESET;
                STATEREC.SETRANGE(STATEREC.CODE, CUST_STATE);
                IF STATEREC.FINDFIRST THEN BEGIN
                    PLACEOFSUPPLY := STATEREC.DESCRIPTION + ' (' + STATEREC."STATE CODE (GST REG. NO.)" + ')';
                END;

            END;

            TRIGGER ONPREDATAITEM()
            BEGIN
                SRNO := 0;
                "SALES INVOICE HEADER".SETRANGE("SALES INVOICE HEADER"."POSTING DATE", STARTDT, ENDDT);
                //IF "SALES INVOICE HEADER".FINDSET THEN;
            END;
        }
    }

    REQUESTPAGE
    {
        SAVEVALUES = TRUE;
        LAYOUT
        {
            AREA(CONTENT)
            {
                GROUP(OPTIONS)
                {
                    Caption = 'Options';
                    FIELD("START DATE"; STARTDT)
                    {
                        Visible = true;
                        ApplicationArea = All;
                    }
                    FIELD("END DATE"; ENDDT)
                    {
                        Visible = true;
                        ApplicationArea = All;
                    }
                }
            }
        }

        ACTIONS
        {
        }
    }

    LABELS
    {
    }

    TRIGGER ONINITREPORT()
    BEGIN
        //IMEI_SERIAL_SHOW:=FALSE;
    END;

    TRIGGER ONPREREPORT()
    BEGIN
        //IF USERID IN ['ADMIN','ACCAM'] THEN
        //IMEI_SERIAL_SHOW:= TRUE
        // ELSE
        // IMEI_SERIAL_SHOW:= FALSE; //WIN-234 20-03-2019
        //MESSAGE(FORMAT(IMEI_SERIAL_SHOW));
    END;

    VAR
        LASTFIELDNO: Integer;
        SRNO: Integer;
        TXT1: LABEL 'GIVE LOCATION';
        CURRREPORT_PAGENOCAPTIONLBL: LABEL 'PAGE';
        PURCHASE_REGISTER_FOR_THE_PERIOD_CAPTIONLBL: LABEL 'PURCHASE REGISTER FOR THE PERIOD ';
        VOUCHER_NO_CAPTIONLBL: LABEL 'VOUCHER NO.';
        VENDOR_CODECAPTIONLBL: LABEL 'VENDOR CODE';
        VENDOR_NAMECAPTIONLBL: LABEL 'VENDOR NAME';
        BILL_NO_CAPTIONLBL: LABEL 'BILL NO.';
        BILL_DATECAPTIONLBL: LABEL 'BILL DATE';
        GRN_NO_CAPTIONLBL: LABEL 'GRN NO.';
        GRN_DATECAPTIONLBL: LABEL 'GRN DATE';
        STATE_T_I_N_NO_CAPTIONLBL: LABEL 'STATE T.I.N NO.';
        CST_T_I_N_NO_CAPTIONLBL: LABEL 'CST T.I.N NO.';
        VOUCHER_DATECAPTIONLBL: LABEL 'VOUCHER DATE';
        ITEM___G_L_DESCRIPTIONCAPTIONLBL: LABEL 'ITEM / G/L DESCRIPTION';
        TOTAL_BILL__INVOICE_AMT_CAPTIONLBL: LABEL 'TOTAL BILL/ INVOICE AMT.';
        DISCOUNT__AMT_CAPTIONLBL: LABEL 'DISCOUNT  AMT.';
        ITEM_CODECAPTIONLBL: LABEL 'ITEM CODE';
        NET_AMT_CAPTIONLBL: LABEL 'NET AMT.';
        CENVAT_AMT_CAPTIONLBL: LABEL 'CENVAT AMT.';
        G_L_CODECAPTIONLBL: LABEL 'G/L CODE';
        G_L_DESCRIPTIONCAPTIONLBL: LABEL 'G/L DESCRIPTION';
        OTHER_AMTCAPTIONLBL: LABEL 'OTHER AMT';
        TAX_CAPTIONLBL: LABEL ' TAX%';
        TAX_DESCRIPTIONCAPTIONLBL: LABEL 'TAX DESCRIPTION';
        TAX__AMT_CAPTIONLBL: LABEL 'TAX  AMT.';
        RECPURHEAD__ORDER_DATE_CAPTIONLBL: LABEL 'LABEL1102159009';
        GRAND_TOTALCAPTIONLBL: LABEL 'GRAND TOTAL';
        GROUP_TOTALCAPTIONLBL: LABEL 'GROUP TOTAL';
        STARTDT: date;
        ENDDT: DATE;
        SALESPRICE: DECIMAL;
        SALESP: RECORD 13;
        SALESPNM: TEXT[250];
        STATEREC: RECORD State;
        STATNM: TEXT[250];
        PAYTERMS: RECORD 3;
        PAYTERMSDESC: TEXT[250];
        ITEM: RECORD 27;
        SCHEM: RECORD 50001;
        NETSALESWOTAX: DECIMAL;
        TOTSALESAMT: DECIMAL;
        SALESHDR: RECORD "Sales Header";
        PURCHHDR: RECORD "Purchase Header";
        SERVTAXPERC: DECIMAL;
        ITEMREC: RECORD Item;
        SALESINVLINE: RECORD "Sales Invoice Line";
        ITEMDESC: TEXT[250];
        UOM: TEXT[250];
        SALESINVHDR: RECORD "Sales Invoice Header";
        SHIELDREC: RECORD 50001;
        REFNO: CODE[30];
        TERMS: TEXT[1024];
        BRAND: CODE[30];
        CATGRY: CODE[30];
        CREDITMEMOENTRY: BOOLEAN;
        GSTDETAILLEGER: RECORD "DETAILED GST LEDGER ENTRY";
        CGSTRATE: DECIMAL;
        CGSTAMT: DECIMAL;
        SGSTAMT: DECIMAL;
        SGSTRATE: DECIMAL;
        IGSTRATE: DECIMAL;
        IGSTAMT: DECIMAL;
        GSTCOMPONENTCGST: TEXT;
        GSTCOMPONENTSGST: TEXT;
        GSTCOMPONENTIGST: TEXT;
        GSTTIN_NO: CODE[20];
        CUST_STATE: CODE[20];
        PLACEOFSUPPLY: TEXT;
        RECCUSTOMER: RECORD 18;
        SALESCRMEMOHEADER: RECORD 114;
        ITEMLEDGERENTRY: RECORD 32;
        SALESCRMEMOLINE: RECORD 115;
        IMEI_SERIAL_SHOW: BOOLEAN;
        ELEVADES: TEXT[250];
        ELEVASERIALNO: CODE[20];
        ELEVAIMEINO: CODE[20];
        ELEVAPRICE: DECIMAL;
        SALESCRMEMOLINE1: RECORD 115;
        CGSTRATECR: DECIMAL;
        CGSTAMTCR: DECIMAL;
        SGSTAMTCR: DECIMAL;
        SGSTRATECR: DECIMAL;
        IGSTRATECR: DECIMAL;
        IGSTAMTCR: DECIMAL;
        GSTCOMPONENTCGSTCR: TEXT;
        GSTCOMPONENTSGSTCR: TEXT;
        GSTCOMPONENTIGSTCR: TEXT;
        CUSTINVNO: CODE[20];
        TCGSTAMTCR: DECIMAL;
        TSGSTAMTCR: DECIMAL;
        TIGSTAMTCR: DECIMAL;

}

