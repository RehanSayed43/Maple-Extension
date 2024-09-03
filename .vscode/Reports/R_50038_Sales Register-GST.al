report 50100 "Sales Register-GST" //50100
{
    DefaultLayout = RDLC;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Sales Register-GST.rdl';

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            DataItemTableView = SORTING("Primary Key");
            column(compinfoName; "Company Information".Name)
            {
            }
            column(startdt; startdt)
            {
            }
            column(enddt; enddt)
            {
            }
        }
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Sales Order Type", "Location Code", "Salesperson Code";
            column(EmailInv; EmailInv)
            {
            }
            column(IMEI_SERIAL_SHOW; IMEI_SERIAL_SHOW)
            {
            }
            column(MobileType_SalesInvoiceHeader; "Sales Invoice Header"."Mobile Type")
            {
            }
            column(Capillary_Order_no; Capillary_Order_no)
            {
            }
            column(Mobile_no; RecCustomer."Phone No.")
            {
            }
            column(Mobile_no2; RecCustomer."Phone No.2")
            {
            }
            //Rushab_CCIT++
            column(Age_group; "Sales Invoice Header"."Order ID")
            {
            }
            //Rushab_CCIT--
            //  column(Age_group; RecCustomer."Age Group")
            // {
            // }
            column(gender; RecCustomer.Gender)
            {
            }
            column(birth_date; RecCustomer."Customer Birth Date")
            {
            }
            column(anniversary_date; RecCustomer."Aniversary Date")
            {
            }
            column(marital_status; RecCustomer."Marital Status")
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(Srno; Srno)
            {
            }
            column(VATTINNo; '')//RecCustomer."T.I.N. No."
            {
            }
            column(selltocust; "Sales Invoice Header"."Sell-to Customer Name")
            {
            }
            column(Location; "Sales Invoice Header"."Location Code")
            {
            }
            column(so_dt; "Sales Invoice Header"."Order Date")
            {
            }
            column(Vertical; "Sales Invoice Header"."Shortcut Dimension 2 Code")
            {
            }
            column(invno; "Sales Invoice Header"."No.")
            {
            }
            column(Inv_dt; "Sales Invoice Header"."Posting Date")
            {
            }
            column(custnm; "Sales Invoice Header"."Sell-to Customer Name")
            {
            }
            column(custno; "Sales Invoice Header"."Sell-to Customer No.")
            {
            }
            column(selltocty; "Sales Invoice Header"."Sell-to City")
            {
            }
            column(delnote; "Sales Invoice Header"."Delivery Note")
            {
            }
            column(dispdocno; "Sales Invoice Header"."Dispatch Doc. No.")
            {
            }
            column(dispthru; "Sales Invoice Header"."Dispatch Through")
            {
            }
            column(payterms; "Sales Invoice Header"."Payment Terms Code")
            {
            }
            column(Structure_SalesInvoiceHeader; '')//"Sales Invoice Header".Structure
            {
            }
            column(paytermsdesc; payterms.Description)
            {
            }
            column(sono; "Sales Invoice Header"."Order No.")
            {
            }
            column(PoNo; purchhdr."No.")
            {
            }
            column(PoDt; purchhdr."Posting Date")
            {
            }
            column(ExternalDocumentNo_SalesInvoiceHeader; "Sales Invoice Header"."External Document No.")
            {
            }
            column(GSTTIN_No; GSTTIN_No)
            {
            }
            column(PlaceOfSupply; PlaceOfSupply)
            {
            }
            column(MapleGSTIN; MapleGSTIN)
            {
            }
            column(Applies_Doc_No; "Sales Invoice Header"."Applies-to Doc. No.")
            {
            }
            column(Applies_Doc_Date; "Sales Invoice Header"."Posting Date")
            {
            }
            column(BuyersOrderNo_SalesInvoiceHeader; "Sales Invoice Header"."Buyer's Order No.")
            {
            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                RequestFilterFields = Brand;
                column(salep; salepcode)
                {
                }
                column(salespnm; salespnm)
                {
                }
                column(SalespersonCode_SalesInvoiceLine; "Sales Invoice Line"."Salesperson Code")
                {
                }

                column(TaxAreaCode_SalesInvoiceLine; "Sales Invoice Line"."Tax Area Code")
                {
                }
                column(CorporateSalespersonCode_SalesInvoiceLine; "Corporate Salesperson Code")
                {
                }
                column(CorporateSalespersonName_SalesInvoiceLine; "Corporate Salesperson Name")
                {
                }
                column(zone; staterec.Zone)
                {
                }
                column(statenm; staterec.Description)
                {
                }
                column(venditemcd; Vendcode)
                {
                }
                column(ItemCat_Code; "Sales Invoice Line"."Item Category Code")
                {
                }
                column(ProdGrp_Code; '')//"Sales Invoice Line"."Product Group Code"
                {
                }
                column(primcat; "Sales Invoice Line"."Primary category")
                {
                }
                column(secondcat; "Sales Invoice Line"."Secondary category")
                {
                }
                column(thirdcat; "Sales Invoice Line"."Third category")
                {
                }
                column(Discount_Type; "Discount Type") { }
                column(schemecode; "Sales Invoice Line"."Scheme Code")
                {
                }
                column(srlno; "Sales Invoice Line"."Serial No.")
                {
                }
                column(imeino; "Sales Invoice Line"."IMEI No.")
                {
                }
                column(schmamt; "Sales Invoice Line"."Scheme Amount")
                {
                }
                column(schmperc; "Sales Invoice Line"."Scheme %")
                {
                }
                column(maplecode; "Sales Invoice Line"."No.")
                {
                }
                column(partdesc; "Sales Invoice Line".Description)
                {
                }
                column(qty; "Sales Invoice Line".Quantity)
                {
                }
                column(unitp; "Sales Invoice Line"."Unit Price")
                {
                }
                column(taxamt; 0.00)//"Sales Invoice Line"."Tax Amount"
                {
                }
                column(taxp; 0.00)//"Sales Invoice Line"."Tax %"
                {
                }
                column(servtaxamt; servtaxamt)
                {
                }
                column(schmdesc; schem.Descritpion)
                {
                }
                column(netsaleswotax; netsaleswotax)
                {
                }
                column(totsalesamt; totsalesamt)
                {
                }
                column(salesprice; salesprice)
                {
                }
                column(maplediscamt; "Sales Invoice Line"."Line Discount Amount")
                {
                }
                column(maplelinedisc; "Sales Invoice Line"."Line Discount %")
                {
                }
                column(Charges; 0.00)//"Sales Invoice Line"."Charges To Customer"
                {
                }
                column(servtaxperc; servtaxperc)
                {
                }
                column(venditemcode; venditemcode)
                {
                }
                column(ItemDesc; ItemDesc)
                {
                }
                column(uom; uom)
                {
                }
                column(Brand; Brand)
                {
                }
                column(Catgry; Catgry)
                {
                }
                column(PrimaryCat; PrimCat)
                {
                }
                column(SecCat; SecCat)
                {
                }
                column(ThirdCatgry; ThirdCat)
                {
                }
                column(ServiceTaxeCessAmount_SalesInvoiceLine; 0.00)//"Sales Invoice Line"."Service Tax eCess Amount"
                {
                }
                column(ServiceTaxSHECessAmount_SalesInvoiceLine; 0.00)//"Sales Invoice Line"."Service Tax SHE Cess Amount"
                {
                }
                column(ItemCode; ItemCode)
                {
                }
                column(SalesPoints_SalesInvoiceLine; "Sales Invoice Line"."Sales Points")
                {
                }
                column(GSTGroupCode; "Sales Invoice Line"."GST Group Code")
                {
                }
                column(HSN_SAC_Code; "Sales Invoice Line"."HSN/SAC Code")
                {
                }
                column(CGSTAmt; ABS(CGSTAmt))
                {
                }
                column(SGSTAmt; ABS(SGSTAmt))
                {
                }
                column(IGSTAmt; ABS(IGSTAmt))
                {
                }
                column(TotalGSTAmount; ABS(CGSTAmt) + ABS(SGSTAmt) + ABS(IGSTAmt))//"Sales Invoice Line"."Total GST Amount"
                {
                }
                column(ElevaSerialNo; "Sales Invoice Line"."Eleva Product Serial No.")
                {
                }
                column(MRP_Value_Var; MRP_Value_Var) //MRP //kj_210823
                {
                }

                trigger OnAfterGetRecord()
                begin

                    servtaxamt := 0;
                    // IF staterec.GET("Sales Invoice Line".state) THEN;//CCIT
                    Vendcode := '';
                    IF "Sales Invoice Header"."Sell-to Customer No." <> 'CC-00358' THEN BEGIN
                        IF item.GET("Sales Invoice Line"."No.") THEN
                            Vendcode := item."Vendor Part Code Long";
                    END;
                    IF schem.GET("Sales Invoice Line"."Scheme Code") THEN;
                    salesprice := 0;
                    salesprice := "Sales Invoice Line".Quantity * "Sales Invoice Line"."Unit Price";
                    totsalesamt := 0;
                    //totsalesamt:=(("Sales Invoice Line".Quantity*"Sales Invoice Line"."Unit Price Incl. of Tax")-("Sales Invoice Line"."Scheme Amount"+"Sales Invoice Line"."Line Discount Amount"));
                    netsaleswotax := 0;
                    netsaleswotax := (("Sales Invoice Line".Quantity * "Sales Invoice Line"."Unit Price") - ("Sales Invoice Line"."Scheme Amount" + "Sales Invoice Line"."Line Discount Amount"));
                    servtaxperc := 0;
                    // IF ("Sales Invoice Line"."Service Tax Amount" <> 0) AND ("Sales Invoice Line"."Service Tax Base" <> 0) THEN BEGIN//CCIT
                    //     servtaxperc := ("Sales Invoice Line"."Service Tax Amount" + "Sales Invoice Line"."Service Tax eCess Amount" + "Sales Invoice Line"."Service Tax SHE Cess Amount") * 100 / "Sales Invoice Line"."Service Tax Base";
                    //     servtaxamt := "Sales Invoice Line"."Service Tax Amount" + "Sales Invoice Line"."Service Tax eCess Amount" + "Sales Invoice Line"."Service Tax SHE Cess Amount";//CCIT
                    // END;
                    //MJ-160118
                    totsalesamt := ((salesprice + servtaxamt) - ("Sales Invoice Line"."Scheme Amount" + "Sales Invoice Line"."Line Discount Amount"));
                    //   totsalesamt := ((salesprice + servtaxamt + "Sales Invoice Line"."Tax Amount") - ("Sales Invoice Line"."Scheme Amount" + "Sales Invoice Line"."Line Discount Amount")) + "Sales Invoice Line"."Total GST Amount";//CCIT
                    //MJ-160118

                    Brand := '';
                    Catgry := '';
                    PrimCat := '';
                    SecCat := '';
                    ThirdCat := '';
                    ItemCode := '';

                    uom := '';
                    venditemcode := '';
                    ItemDesc := '';


                    //IF "Sales Invoice Line".Shield=TRUE THEN
                    IF "Sales Invoice Line".Type = "Sales Invoice Line".Type::"G/L Account" THEN
                        //IF "Sales Invoice Line"."No."<>'310008' THEN
                        IF ("Sales Invoice Line"."No." IN ['401004', '403012', '512073', '512040']) THEN
                            CurrReport.SKIP;

                    //IF "Sales Invoice Line"."No."='310008' THEN
                    IF NOT ("Sales Invoice Line"."No." IN ['401004', '403012', '512073', '512040']) THEN BEGIN
                        itemrec.RESET;
                        itemrec.SETFILTER(itemrec."No.", "Sales Invoice Line"."Description 2");
                        IF itemrec.FINDFIRST THEN
                            //venditemcode:=itemrec."Vendor Item No.";
                            venditemcode := itemrec."Vendor Part Code Long";
                        // Catgry := itemrec."Product Category"; //ccit_kj
                        salesinvline.RESET;
                        salesinvline.SETFILTER(salesinvline."Document No.", refno);
                        salesinvline.SETFILTER(salesinvline."No.", "Sales Invoice Line"."Description 2");
                        IF salesinvline.FINDFIRST THEN BEGIN
                            IF ("Sales Invoice Line".Type = "Sales Invoice Line".Type::"G/L Account") AND ("Sales Invoice Line"."No." = '310008') THEN
                                ItemDesc := salesinvline.Description;
                            uom := salesinvline."Unit of Measure";
                            Brand := salesinvline."Item Category Code";
                            //Catgry := salesinvline."Product Group Code";CCIT
                            PrimCat := salesinvline."Primary category";
                            SecCat := salesinvline."Secondary category";
                            ThirdCat := salesinvline."Third category";
                            IF ("Sales Invoice Line".Type = "Sales Invoice Line".Type::"G/L Account") AND ("Sales Invoice Line"."No." = '310008') THEN
                                ItemCode := salesinvline."No.";
                        END;
                    END;

                    //For GST Fields WIN347++
                    CLEAR(CGSTAmt);
                    CLEAR(CGSTRate);
                    CLEAR(GSTComponentCGST);
                    CLEAR(SGSTAmt);
                    CLEAR(SGSTRate);
                    CLEAR(GSTComponentSGST);
                    CLEAR(IGSTAmt);
                    CLEAR(IGSTRate);
                    CLEAR(GSTComponentIGST);
                    GSTDetailLeger.RESET;
                    GSTDetailLeger.SETRANGE(GSTDetailLeger."Document No.", "Sales Invoice Line"."Document No.");
                    GSTDetailLeger.SETRANGE(GSTDetailLeger."No.", "Sales Invoice Line"."No.");
                    GSTDetailLeger.SETRANGE(GSTDetailLeger."Document Line No.", "Sales Invoice Line"."Line No.");
                    IF GSTDetailLeger.FINDSET THEN
                        REPEAT
                            IF GSTDetailLeger."GST Component Code" = 'CGST' THEN BEGIN
                                GSTComponentCGST := 'CGST';
                                CGSTRate := GSTDetailLeger."GST %";
                                CGSTAmt := GSTDetailLeger."GST Amount";
                            END ELSE
                                IF GSTDetailLeger."GST Component Code" = 'SGST' THEN BEGIN
                                    GSTComponentSGST := 'SGST';
                                    SGSTRate := GSTDetailLeger."GST %";
                                    SGSTAmt := GSTDetailLeger."GST Amount";
                                END ELSE
                                    IF GSTDetailLeger."GST Component Code" = 'IGST' THEN BEGIN
                                        GSTComponentIGST := 'IGST';
                                        IGSTRate := GSTDetailLeger."GST %";
                                        IGSTAmt := GSTDetailLeger."GST Amount";
                                    END;
                        UNTIL GSTDetailLeger.NEXT = 0;
                    //For GST Fields WIN347--

                    IF "Sales Invoice Line"."Salesperson Code" <> '' THEN BEGIN
                        IF salesp.GET("Sales Invoice Line"."Salesperson Code") THEN BEGIN
                            salespnm := salesp.Name;
                            salepcode := salesp.Code;
                        END;
                    END ELSE
                        IF salesp.GET("Sales Invoice Header"."Salesperson Code") THEN BEGIN
                            salespnm := salesp.Name;
                            salepcode := salesp.Code;
                        END ELSE
                            salespnm := ''; //win-234 23-10-19

                    //   cckj+++++++++++180823
                    if "Sales Invoice Line".Type = "Sales Invoice Line".Type::Item then begin
                        SalesShipLine.Reset();
                        SalesShipLine.SetRange("Order No.", "Sales Invoice Line"."Order No.");
                        SalesShipLine.SetRange("Line No.", "Sales Invoice Line"."Line No.");
                        // SalesShipLine.SetRange(Type, SalesShipLine.Type::Item);
                        if SalesShipLine.FindFirst() then begin
                            repeat
                                itemLedEntry.Reset();
                                itemLedEntry.SetRange("Document No.", SalesShipLine."Document No.");
                                itemLedEntry.SetRange("Item No.", SalesShipLine."No.");
                                itemLedEntry.SetRange("Document Line No.", SalesShipLine."Line No.");
                                if itemLedEntry.FindSet() then
                                    // repeat
                                    //   SerialNo := itemLedEntry."Serial No.";
                                    //  IMEINo := itemLedEntry."IMEI No.";
                                    MRP_Value_Var := itemLedEntry."MRP Value";
                            until SalesShipLine.Next() = 0;
                        end;

                        item_Cat.Reset();
                        item_Cat.SetRange("No.", "Sales Invoice Line"."No.");
                        if item_Cat.FindSet() then begin
                            Catgry := item_Cat."Product Category";
                        end;

                    end;



                    //cckj-----------180823       
                end;

                trigger OnPreDataItem()
                begin
                    //IF "Sales Invoice Line".GETFILTER("Sales Invoice Line"."Item Category Code1")<>'' THEN
                    //"Sales Invoice Line".SETFILTER("Sales Invoice Line"."Item Category Code","Sales Invoice Line".GETFILTER("Sales Invoice Line"."Item Category Code1"));
                    //IF "Sales Invoice Line".FINDSET THEN;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF ReccCust.GET("Sales Invoice Header"."Sell-to Customer No.") THEN
                    EmailInv := ReccCust."E-Mail"
                ELSE
                    EmailInv := '';

                //WIN270+++
                RecCustomer.RESET;
                RecCustomer.SETRANGE(RecCustomer."No.", "Sales Invoice Header"."Sell-to Customer No.");
                IF RecCustomer.FINDFIRST THEN;
                //WIN270---
                Srno += 1;
                /*
                salespnm:='';
                IF salesp.GET("Sales Invoice Header"."Salesperson Code") THEN
                  salespnm:=salesp.Name;
                  *///win-234 23-11-2019

                IF payterms.GET("Sales Invoice Header"."Payment Terms Code") THEN;


                IF saleshdr.GET(saleshdr."Document Type"::Order, "Sales Invoice Header"."Order No.") THEN;


                IF purchhdr.GET(purchhdr."Document Type"::Order, saleshdr."PurchaseOrderNo.") THEN;
                // if saleshdr.get("Sales Invoice Header"."Order No.") then begin
                //     OrderId := saleshdr.no;
                // end;


                terms := '';
                refno := '';
                salesinvHdr.RESET;
                salesinvHdr.SETFILTER(salesinvHdr."No.", "Sales Invoice Header"."No.");
                IF salesinvHdr.FINDFIRST THEN
                    IF salesinvHdr."Ref. Invoice No." <> '' THEN
                        refno := salesinvHdr."Ref. Invoice No.";
                //MESSAGE('%1',refno);
                /*
                salesinvline.RESET;
                salesinvline.SETFILTER(salesinvline."Document No.",refno);
                IF salesinvline.FINDFIRST THEN
                BEGIN
                ShieldRec.RESET;
                ShieldRec.SETRANGE(ShieldRec."Scheme Code",salesinvline."Shield Type");
                IF ShieldRec.FINDFIRST THEN
                terms:=ShieldRec."Shield Insurance T&C" + ' ' + ShieldRec."Document Date" + ' ' + ShieldRec."Product Group Code" + ' ' + ShieldRec."Starting Date";
                END;
                */
                Cmnt := '';
                RecComment.SETFILTER(RecComment."No.", "Sales Invoice Header"."No.");
                IF RecComment.FINDFIRST THEN
                    Cmnt := RecComment.Comment;

                CLEAR(GSTTIN_No);
                CLEAR(Cust_State);
                CLEAR(PlaceOfSupply);
                RecCustomer.RESET;
                RecCustomer.SETRANGE("No.", "Sales Invoice Header"."Sell-to Customer No.");
                IF RecCustomer.FINDFIRST THEN
                    GSTTIN_No := RecCustomer."GST Registration No.";
                Cust_State := RecCustomer."State Code";

                staterec.RESET;
                staterec.SETRANGE(staterec.Code, Cust_State);
                IF staterec.FINDFIRST THEN BEGIN
                    PlaceOfSupply := staterec.Description + ' (' + staterec."State Code (GST Reg. No.)" + ')';
                END;

                RecLocation.RESET;
                RecLocation.SETRANGE(RecLocation.Code, "Sales Invoice Header"."Location Code");
                IF RecLocation.FINDFIRST THEN
                    MapleGSTIN := RecLocation."GST Registration No.";
                //win316++
                CLEAR(Capillary_Order_no);
                IF "Sales Invoice Header"."Order No." <> '' THEN
                    Capillary_Order_no := "Sales Invoice Header"."Order No."
                ELSE BEGIN
                    RecSIH.RESET;
                    RecSIH.SETRANGE("No.", "Sales Invoice Header"."Ref. Invoice No.");
                    IF RecSIH.FINDFIRST THEN
                        Capillary_Order_no := RecSIH."Order No."
                END;
                //win316--

            end;

            trigger OnPreDataItem()
            begin
                Srno := 0;
                "Sales Invoice Header".SETRANGE("Sales Invoice Header"."Posting Date", startdt, enddt);


                IF "Sales Invoice Header".FINDSET THEN;
                "Sales Invoice Header"."Salesperson Code" := '';
                salesp.Name := '';
            end;
        }
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            column(EmailCr; EmailCr)
            {
            }
            column(IMEI_SERIAL_SHOW1; IMEI_SERIAL_SHOW)
            {
            }
            column(Cr_CustomerName; "Sales Cr.Memo Header"."Sell-to Customer Name")
            {
            }
            column(Age_group1; "Sales Cr.Memo Header"."Order ID")
            {
            }
            column(Cr_LocationCode; "Sales Cr.Memo Header"."Location Code")
            {
            }
            column(Cr_exterDocNo; "Sales Cr.Memo Header"."External Document No.") { }
            column(Cr_PromoCode; "Sales Cr.Memo Header"."Promo Code") { }
            column(Cr_Vertical; "Sales Cr.Memo Header"."Shortcut Dimension 2 Code")
            {
            }
            column(Cr_No; "Sales Cr.Memo Header"."No.")
            {
            }
            column(Cr_PostingDt; "Sales Cr.Memo Header"."Posting Date")
            {
            }
            column(Cr_CustomerNo; "Sales Cr.Memo Header"."Sell-to Customer No.")
            {
            }
            column(Cr_SellToCity; "Sales Cr.Memo Header"."Sell-to City")
            {
            }
            column(PreAssignedNo_SalesCrMemoHeader; "Sales Cr.Memo Header"."Pre-Assigned No.")
            {
            }
            column(BilltoCity_SalesCrMemoHeader; "Sales Cr.Memo Header"."Bill-to City")
            {
            }
            column(SalespersonCode_SalesCrMemoHeader; "Sales Cr.Memo Header"."Salesperson Code")
            {
            }
            column(SelltoCustomerName_SalesCrMemoHeader; "Sales Cr.Memo Header"."Sell-to Customer Name")
            {
            }
            column(PaymentTermsCode_SalesCrMemoHeader; "Sales Cr.Memo Header"."Payment Terms Code")
            {
            }
            column(Structure_SalesCrMemoHeader; '')// "Sales Cr.Memo Header".Structure
            {
            }
            column(GSTTIN_No_Cr; GSTTIN_No_Cr)
            {
            }
            column(PlaceOfSupply_Cr; PlaceOfSupply_Cr)
            {
            }
            column(MapleGSTIN_Cr; MapleGSTIN_Cr)
            {
            }
            column(Applies_Doc_No_Cr; "Sales Cr.Memo Header"."Applies-to Doc. No.")
            {
            }
            column(Applies_Doc_Date_Cr; "Sales Cr.Memo Header"."Posting Date")
            {
            }
            column(BuyersOrderNo_SalesCrMemoHeader; "Sales Cr.Memo Header"."Buyer's Order No.")
            {
            }
            dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(Cr_Salesperson; salesp1.Name)
                {
                }
                column(Cr_SalesPersonCode; salepcode1)
                {
                }
                column(CorporateSalespersonCode_SalesCrMemoLine; "Corporate Salesperson Code")
                {
                }
                column(CorporateSalespersonName_SalesCrMemoLine; "Corporate Salesperson Name")
                {
                }
                column(Mobile_no1; RecCustomer."Phone No.")
                {
                }
                column(Mobile_no2C; RecCustomer."Phone No.2")
                {
                }
                // column(Age_group1; RecCustomer."Age Group")
                // {
                // }
                column(gender1; RecCustomer.Gender)
                {
                }
                column(birth_date1; RecCustomer."Customer Birth Date")
                {
                }
                column(anniversary_date1; RecCustomer."Aniversary Date")
                {
                }
                column(marital_status1; RecCustomer."Marital Status")
                {
                }
                column(Capillary_Order_no1; Capillary_Order_no1)
                {
                }
                column(TaxAreaCode_SalesCrMemoLine; "Sales Cr.Memo Line"."Tax Area Code")
                {
                }
                column(Cr_zone; staterec.Zone)
                {
                }
                column(Cr_statenm; staterec.Description)
                {
                }
                column(Cr_venditemcdLong; item."Vendor Part Code Long")
                {
                }
                column(Cr_ItemCatecodeCode; "Sales Cr.Memo Line"."Item Category Code")
                {
                }
                column(Cr_ProdGroupCode; '')//"Sales Cr.Memo Line"."Product Group Code"
                {
                }
                column(Cr_Primcat; "Sales Cr.Memo Line"."Primary category")
                {
                }
                column(Cr_Secondcat; "Sales Cr.Memo Line"."Secondary category")
                {
                }
                column(Cr_thirdcat; "Sales Cr.Memo Line"."Third category")
                {
                }
                column(Cr_srlno; "Sales Cr.Memo Line"."Item Serial No.")
                {
                }
                column(Cr_imeino; "Sales Cr.Memo Line"."IMEI No.")
                {
                }
                column(Cr_maplecode; "Sales Cr.Memo Line"."No.")
                {
                }
                column(Cr_partdesc; "Sales Cr.Memo Line".Description)
                {
                }
                column(Cr_qty; "Sales Cr.Memo Line".Quantity)
                {
                }
                column(Cr_unitp; "Sales Cr.Memo Line"."Unit Price")
                {
                }
                column(Cr_taxamt; 0.00)// "Sales Cr.Memo Line"."Tax Amount"
                {
                }
                column(Cr_taxpv; 0.00)//"Sales Cr.Memo Line"."Tax %"
                {
                }
                column(Cr_servtaxamt; 0.00)//"Sales Cr.Memo Line"."Service Tax Amount"
                {
                }
                column(Cr_netsaleswotax; netsaleswotax)
                {
                }
                column(Cr_totsalesamt; totsalesamt)
                {
                }
                column(Cr_salesprice; salesprice)
                {
                }
                column(Cr_maplediscamt; "Sales Cr.Memo Line"."Line Discount Amount")
                {
                }
                column(Cr_maplelinedisc; "Sales Cr.Memo Line"."Line Discount %")
                {
                }
                column(Cr_Charges; 0.00)//"Sales Cr.Memo Line"."Charges To Customer"
                {
                }
                column(Cr_servtaxperc; servtaxperc)
                {
                }
                column(Cr_venditemcode; venditemcode)
                {
                }
                column(Cr_uom; uom)
                {
                }
                column(Cr_totsalesamt1; totsalesamt1)
                {
                }
                column(Cr_servtaxperc1; servtaxperc1)
                {
                }
                column(Cr_servtaxamt1; servtaxamt1)
                {
                }
                column(Cr_netsaleswotax1; netsaleswotax1)
                {
                }
                column(Cr_salesprice1; salesprice1)
                {
                }
                column(GSTGroupCode_Cr; "Sales Cr.Memo Line"."GST Group Code")
                {
                }
                column(HSN_SAC_Code_Cr; "Sales Cr.Memo Line"."HSN/SAC Code")
                {
                }
                column(CGSTAmt_Cr; CGSTAmt_Cr)
                {
                }
                column(SGSTAmt_Cr; SGSTAmt_Cr)
                {
                }
                column(IGSTAmt_Cr; IGSTAmt_Cr)
                {
                }
                column(TotalGSTAmount_Cr; CGSTAmt_Cr + SGSTAmt_Cr + IGSTAmt_Cr)//"Sales Cr.Memo Line"."Total GST Amount"
                {
                }
                column(Cr_Category; Category)
                {
                }
                column(Cr_MRP; "Sales Cr.Memo Line"."MRP Value")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    Clear(Category);
                    servtaxamt1 := 0;
                    // IF CrState.GET("Sales Cr.Memo Line".State) THEN;//CCIT
                    IF item.GET("Sales Cr.Memo Line"."No.") THEN
                        Category := item."Product Category";
                    //IF schem.GET("Sales Cr.Memo Line"."Scheme Code") THEN;
                    salesprice1 := 0;
                    salesprice1 := "Sales Cr.Memo Line".Quantity * "Sales Cr.Memo Line"."Unit Price";
                    totsalesamt1 := 0;
                    totsalesamt1 := (("Sales Cr.Memo Line".Quantity * "Sales Cr.Memo Line"."Unit Price Incl. of Tax") - ("Sales Cr.Memo Line"."Line Discount Amount"));
                    netsaleswotax1 := 0;
                    netsaleswotax1 := (("Sales Cr.Memo Line".Quantity * "Sales Cr.Memo Line"."Unit Price") - ("Sales Cr.Memo Line"."Line Discount Amount"));
                    servtaxperc1 := 0;
                    // IF ("Sales Cr.Memo Line"."Service Tax Amount" <> 0) AND ("Sales Cr.Memo Line"."Service Tax Base" <> 0) THEN//CCIT
                    //     servtaxperc1 := ("Sales Cr.Memo Line"."Service Tax Amount" + "Sales Cr.Memo Line"."Service Tax eCess Amount" + "Sales Cr.Memo Line"."Service Tax SHE Cess Amount") * 100 / "Sales Cr.Memo Line"."Service Tax Base";//CCIT
                    // servtaxamt1 := "Sales Cr.Memo Line"."Service Tax Amount" + "Sales Cr.Memo Line"."Service Tax eCess Amount" + "Sales Cr.Memo Line"."Service Tax SHE Cess Amount";//CCIT

                    IF Type = Type::"G/L Account" THEN
                        IF ("No." IN ['401004', '403012', '512073', '512040']) THEN
                            CurrReport.SKIP;

                    IF NOT ("No." IN ['401004', '403012', '512073', '512040']) THEN
                        IF itemrec.FINDFIRST THEN
                            venditemcode := itemrec."Vendor Part Code Long";



                    //For GST Fields WIN347++
                    CLEAR(CGSTRate_Cr);
                    CLEAR(CGSTAmt_Cr);
                    CLEAR(GSTComponentCGST_Cr);
                    CLEAR(SGSTRate_Cr);
                    CLEAR(SGSTAmt_Cr);
                    CLEAR(GSTComponentSGST_Cr);
                    CLEAR(IGSTRate_Cr);
                    CLEAR(IGSTAmt_Cr);
                    CLEAR(GSTComponentIGST_Cr);
                    GSTDetailLeger.RESET;
                    GSTDetailLeger.SETRANGE(GSTDetailLeger."Document No.", "Sales Cr.Memo Line"."Document No.");
                    GSTDetailLeger.SETRANGE(GSTDetailLeger."No.", "Sales Cr.Memo Line"."No.");
                    GSTDetailLeger.SETRANGE(GSTDetailLeger."Document Line No.", "Sales Cr.Memo Line"."Line No.");
                    IF GSTDetailLeger.FINDSET THEN
                        REPEAT
                            IF GSTDetailLeger."GST Component Code" = 'CGST' THEN BEGIN
                                GSTComponentCGST_Cr := 'CGST';
                                CGSTRate_Cr := GSTDetailLeger."GST %";
                                CGSTAmt_Cr := GSTDetailLeger."GST Amount";
                            END ELSE
                                IF GSTDetailLeger."GST Component Code" = 'SGST' THEN BEGIN
                                    GSTComponentSGST_Cr := 'SGST';
                                    SGSTRate_Cr := GSTDetailLeger."GST %";
                                    SGSTAmt_Cr := GSTDetailLeger."GST Amount";
                                END ELSE
                                    IF GSTDetailLeger."GST Component Code" = 'IGST' THEN BEGIN
                                        GSTComponentIGST_Cr := 'IGST';
                                        IGSTRate_Cr := GSTDetailLeger."GST %";
                                        IGSTAmt_Cr := GSTDetailLeger."GST Amount";
                                    END;
                        UNTIL GSTDetailLeger.NEXT = 0;
                    //For GST Fields WIN347--
                    IF "Sales Cr.Memo Line"."Salesperson Code" <> '' THEN BEGIN
                        IF salesp1.GET("Sales Cr.Memo Line"."Salesperson Code") THEN
                            salepcode1 := salesp1.Code;
                    END ELSE
                        IF salesp1.GET("Sales Cr.Memo Header"."Salesperson Code") THEN
                            salepcode1 := salesp1.Code; //win-234 23-10-19
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //IF salesp1.GET("Sales Cr.Memo Header"."Salesperson Code") THEN;//win-234 23-10-19
                IF ReccCust.GET("Sales Cr.Memo Header"."Sell-to Customer No.") THEN
                    EmailCr := ReccCust."E-Mail"
                ELSE
                    EmailCr := '';


                CLEAR(GSTTIN_No_Cr);
                CLEAR(Cust_State_Cr);
                CLEAR(PlaceOfSupply_Cr);
                RecCustomer.RESET;
                RecCustomer.SETRANGE("No.", "Sales Cr.Memo Header"."Sell-to Customer No.");
                IF RecCustomer.FINDFIRST THEN
                    GSTTIN_No_Cr := RecCustomer."GST Registration No.";
                Cust_State_Cr := RecCustomer."State Code";

                staterec.RESET;
                staterec.SETRANGE(staterec.Code, Cust_State);
                IF staterec.FINDFIRST THEN BEGIN
                    PlaceOfSupply_Cr := staterec.Description + ' (' + staterec."State Code (GST Reg. No.)" + ')';
                END;

                RecLocation.RESET;
                RecLocation.SETRANGE(RecLocation.Code, "Sales Cr.Memo Header"."Location Code");
                IF RecLocation.FINDFIRST THEN
                    MapleGSTIN_Cr := RecLocation."GST Registration No.";
                //win316++
                RecCustomer.RESET;
                RecCustomer.SETRANGE(RecCustomer."No.", "Sales Cr.Memo Header"."Sell-to Customer No.");
                IF RecCustomer.FINDFIRST THEN;
                CLEAR(Capillary_Order_no1);
                RecSIH.RESET;
                RecSIH.SETRANGE("No.", "Sales Cr.Memo Header"."Applies-to Doc. No.");
                IF RecSIH.FINDFIRST THEN
                    IF RecSIH."Order No." <> '' THEN
                        Capillary_Order_no1 := RecSIH."Order No."
                    ELSE BEGIN
                        RecSIH1.RESET;
                        RecSIH1.SETRANGE("No.", RecSIH."Ref. Invoice No.");
                        IF RecSIH1.FINDFIRST THEN
                            Capillary_Order_no1 := RecSIH1."Order No."
                    END;
                //win316--
            end;

            trigger OnPreDataItem()
            begin
                "Sales Cr.Memo Header".SETRANGE("Sales Cr.Memo Header"."Posting Date", startdt, enddt);
                IF "Sales Cr.Memo Header".FINDSET THEN;
                "Sales Cr.Memo Header"."Salesperson Code" := '';
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    field("Start Date"; startdt)
                    {
                        ApplicationArea = All;
                    }
                    field("End Date"; enddt)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        IMEI_SERIAL_SHOW := true;
    end;

    trigger OnPreReport()
    begin
        IMEI_SERIAL_SHOW := true;
        /*   IF USERID IN ['ADMIN', 'ACCAM', 'ACCAPV', 'ACC4EXE', 'MAPLEIT'] THEN
               IMEI_SERIAL_SHOW := TRUE
           ELSE
               IMEI_SERIAL_SHOW := FALSE; //Win-234 19-03-2019
               */
    end;

    var
        LastFieldNo: Integer;
        Srno: Integer;
        txt1: Label 'give location';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        PURCHASE_REGISTER_FOR_THE_PERIOD_CaptionLbl: Label 'PURCHASE REGISTER FOR THE PERIOD ';
        Voucher_No_CaptionLbl: Label 'Voucher No.';
        Vendor_CodeCaptionLbl: Label 'Vendor Code';
        Vendor_NameCaptionLbl: Label 'Vendor Name';
        Bill_No_CaptionLbl: Label 'Bill No.';
        Bill_DateCaptionLbl: Label 'Bill Date';
        GRN_No_CaptionLbl: Label 'GRN No.';
        GRN_DateCaptionLbl: Label 'GRN Date';
        State_T_I_N_No_CaptionLbl: Label 'State T.I.N No.';
        CST_T_I_N_No_CaptionLbl: Label 'CST T.I.N No.';
        Voucher_DateCaptionLbl: Label 'Voucher Date';
        Item___G_L_DescriptionCaptionLbl: Label 'Item / G/L Description';
        Total_Bill__Invoice_Amt_CaptionLbl: Label 'Total Bill/ Invoice Amt.';
        Discount__Amt_CaptionLbl: Label 'Discount  Amt.';
        Item_CodeCaptionLbl: Label 'Item Code';
        Net_Amt_CaptionLbl: Label 'Net Amt.';
        Cenvat_Amt_CaptionLbl: Label 'Cenvat Amt.';
        G_L_CodeCaptionLbl: Label 'G/L Code';
        G_L_DescriptionCaptionLbl: Label 'G/L Description';
        Other_AmtCaptionLbl: Label 'Other Amt';
        Tax_CaptionLbl: Label ' Tax%';
        Tax_DescriptionCaptionLbl: Label 'Tax Description';
        Tax__Amt_CaptionLbl: Label 'Tax  Amt.';
        RecPurHead__Order_Date_CaptionLbl: Label 'Label1102159009';
        Grand_TotalCaptionLbl: Label 'Grand Total';
        Group_TotalCaptionLbl: Label 'Group Total';
        startdt: Date;
        enddt: Date;
        salesp: Record "Salesperson/Purchaser";
        salespnm: Text[250];
        staterec: Record state;
        statnm: Text[250];
        payterms: Record "Payment Terms";
        paytermsdesc: Text[250];
        item: Record Item;
        schem: Record "Scheme Details";
        saleshdr: Record "Sales Header";
        purchhdr: Record "Purchase Header";
        itemrec: Record Item;
        venditemcode: Code[30];
        salesinvline: Record "Sales Invoice Line";
        ItemDesc: Text[250];
        uom: Text[250];
        salesinvHdr: Record "Sales Invoice Header";
        ShieldRec: Record "Scheme Details";
        refno: Code[30];
        terms: Text[1024];
        Brand: Code[30];
        Catgry: Code[30]; //Catgry
        PrimCat: Code[30];
        SecCat: Code[30];
        ThirdCat: Code[30];
        ItemCode: Code[30];
        ItemCatCode: Code[30];
        CrItem: Record Item;
        CrState: Record State;
        salesp1: Record "Salesperson/Purchaser";
        RecComment: Record "Sales Comment Line";
        Cmnt: Text[80];
        totsalesamt1: Decimal;
        servtaxperc1: Decimal;
        servtaxamt1: Decimal;
        netsaleswotax1: Decimal;
        totsalesamt: Decimal;
        servtaxperc: Decimal;
        servtaxamt: Decimal;
        netsaleswotax: Decimal;
        salesprice1: Decimal;
        salesprice: Decimal;
        RecCustomer: Record Customer;
        Vendcode: Code[50];
        GSTDetailLeger: Record "Detailed GST Ledger Entry";
        CGSTRate: Decimal;
        CGSTAmt: Decimal;
        SGSTAmt: Decimal;
        SGSTRate: Decimal;
        IGSTRate: Decimal;
        IGSTAmt: Decimal;
        GSTComponentCGST: Text;
        GSTComponentSGST: Text;
        GSTComponentIGST: Text;
        CGSTRate_Cr: Decimal;
        CGSTAmt_Cr: Decimal;
        SGSTAmt_Cr: Decimal;
        SGSTRate_Cr: Decimal;
        IGSTRate_Cr: Decimal;
        IGSTAmt_Cr: Decimal;
        GSTComponentCGST_Cr: Text;
        GSTComponentSGST_Cr: Text;
        GSTComponentIGST_Cr: Text;
        GSTTIN_No: Code[20];
        Cust_State: Code[20];
        PlaceOfSupply: Text;
        GSTTIN_No_Cr: Code[20];
        Cust_State_Cr: Code[20];
        PlaceOfSupply_Cr: Text;
        RecLocation: Record Location;
        MapleGSTIN: Code[20];
        MapleGSTIN_Cr: Code[20];
        RecSIH: Record "Sales Invoice Header";
        Capillary_Order_no: Code[20];
        RecSIH1: Record "Sales Invoice Header";
        Capillary_Order_no1: Code[20];
        IMEI_SERIAL_SHOW: Boolean;
        salepcode: Code[20];
        salepcode1: Code[20];
        ReccCust: Record Customer;
        EmailInv: Text;
        EmailCr: Text;
        itemLedEntry: Record "Item Ledger Entry"; //cckj
                                                  //         SerialNo: text[30]; //cckj
                                                  //         IMEINo: Code[20]; //cckj
        SalesShipLine: Record "Sales Shipment Line"; //cckj
        MRP_Value_Var: Decimal;
        item_Cat: Record Item;
        Category: Code[20];
        OrderId: code[30];
    // SalesOrder:Record "Sales Header";

}

