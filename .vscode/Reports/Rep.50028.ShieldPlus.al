report 50028 "Shield Plus"
{

    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './ShieldPlus.rdl';
    Caption = 'Shield Plus';


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
            DataItemTableView = SORTING("No.")
                                WHERE("Ref. Invoice No." = FILTER(<> ''));
            RequestFilterFields = "Sales Order Type", "Location Code", "Salesperson Code";
            column(IMEI_SERIAL_SHOW; IMEI_SERIAL_SHOW)
            {
            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Type = FILTER("G/L Account"),
                                          "No." = FILTER(310008 | 310014));
            }
            dataitem(DataItem4577; "Sales Invoice Header")
            {
                DataItemLink = "No." = FIELD("Ref. Invoice No.");
                DataItemTableView = SORTING("No.");
                PrintOnlyIfDetail = false;
                column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
                {
                }
                column(CurrReport_PAGENO; CurrReport.PAGENO)
                {
                }
                column(Srno; Srno)
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
                column(salep; "Sales Invoice Header"."Salesperson Code")
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
                column(salespnm; salesp.Name)
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
                dataitem("<Sales Invoice Line1>"; "Sales Invoice Line")
                {
                    DataItemLink = "Document No." = FIELD("No.");
                    column(ItemNoShield; "<Sales Invoice Line1>"."Description 2")
                    {
                    }
                    column(ShieldTaxAmt; '')
                    {
                    }
                    column(ShieldType; "Sales Invoice Line"."Shield Type")
                    {
                        OptionCaption = '< ,Shield,Shield Plus,Shield+Ex,Shield Ex,Shield+ExCPU,ExCPU,ExIPH/IPAD>';
                        OptionMembers = "< ",Shield,"Shield Plus","Shield+Ex","Shield Ex","Shield+ExCPU",ExCPU,"ExIPH/IPAD>";
                    }
                    column(ShieldAmtWOTax; "<Sales Invoice Line1>"."Unit Price")
                    {
                    }
                    column(ShieldAmountWithTax; '')
                    {
                    }
                    column(zone; staterec.Zone)
                    {
                    }
                    column(statenm; staterec.Description)
                    {
                    }
                    column(venditemcd; item."Vendor Part Code Long")
                    {
                    }
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
                    column(taxamt; '')
                    {
                    }
                    column(taxp; '')
                    {
                    }
                    column(servtaxamt; '')
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
                    column(Charges; '')
                    {
                    }
                    column(servtaxperc; servtaxperc)
                    {
                    }
                    column(uom; "Sales Invoice Line"."Unit of Measure")
                    {
                    }
                    column(Brand; "Sales Invoice Line"."Item Category Code")
                    {
                    }
                    column(Catgry; '')
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        // IF staterec.GET("Sales Invoice Line".state) THEN;//tk
                        IF item.GET("Sales Invoice Line"."No.") THEN;
                        IF schem.GET("Sales Invoice Line"."Scheme Code") THEN;
                        salesprice := 0;
                        salesprice := "Sales Invoice Line".Quantity * "Sales Invoice Line"."Unit Price";
                        totsalesamt := 0;
                        totsalesamt := (("Sales Invoice Line".Quantity * "Sales Invoice Line"."Unit Price Incl. of Tax") - ("Sales Invoice Line"."Scheme Amount" + "Sales Invoice Line"."Line Discount Amount"));
                        netsaleswotax := 0;
                        netsaleswotax := (("Sales Invoice Line".Quantity * "Sales Invoice Line"."Unit Price") - ("Sales Invoice Line"."Scheme Amount" + "Sales Invoice Line"."Line Discount Amount"));
                        servtaxperc := 0;
                        // IF("Sales Invoice Line"."Service Tax Amount"<>0) AND ("Sales Invoice Line"."Service Tax Base"<>0) THEN
                        // servtaxperc:=("Sales Invoice Line"."Service Tax Amount"+"Sales Invoice Line"."Service Tax eCess Amount"+"Sales Invoice Line"."Service Tax SHE Cess Amount")/"Sales Invoice Line"."Service Tax Base";
                        //tk
                        /*
                        IF "Sales Invoice Line".Shield=TRUE THEN
                        IF "Sales Invoice Line".Type="Sales Invoice Line".Type::"G/L Account" THEN
                        IF "Sales Invoice Line"."No."<>'310008' THEN
                        CurrReport.SKIP;
                        
                        
                        Brand:='';
                        Catgry:='';
                        PrimCat:='';
                        SecCat:='';
                        ThirdCat:='';
                        ItemCode:='';
                        
                        uom:='';
                        venditemcode:='';
                        itemrec.RESET;
                        itemrec.SETFILTER(itemrec."No.","Sales Invoice Line"."No.");
                        IF itemrec.FINDFIRST THEN
                        //venditemcode:=itemrec."Vendor Item No.";
                        venditemcode:=itemrec."Vendor Part Code Long";
                        
                        ItemDesc:='';
                        salesinvline.RESET;
                        salesinvline.SETFILTER(salesinvline."Document No.",refno);
                        salesinvline.SETFILTER(salesinvline."No.","Sales Invoice Line"."Description 2");
                        IF salesinvline.FINDFIRST THEN
                        BEGIN
                        ItemDesc:=salesinvline.Description;
                        uom:=salesinvline."Unit of Measure";
                        Brand:=salesinvline."Item Category Code";
                        Catgry:=salesinvline."Product Group Code";
                        PrimCat:=salesinvline."Primary category";
                        SecCat:=salesinvline."Secondary category";
                        ThirdCat:=salesinvline."Third category";
                        ItemCode:=salesinvline."No.";
                        END;
                        */

                    end;
                }

                trigger OnAfterGetRecord()
                begin

                    Srno += 1;

                    IF salesp.GET("Sales Invoice Header"."Salesperson Code") THEN;


                    IF payterms.GET("Sales Invoice Header"."Payment Terms Code") THEN;


                    IF saleshdr.GET(saleshdr."Document Type"::Order, "Sales Invoice Header"."Order No.") THEN;


                    IF purchhdr.GET(purchhdr."Document Type"::Order, saleshdr."PurchaseOrderNo.") THEN;


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

                end;

                trigger OnPreDataItem()
                begin
                    Srno := 0;
                    "Sales Invoice Header".SETRANGE("Sales Invoice Header"."Posting Date", startdt, enddt);
                    IF "Sales Invoice Header".FINDSET THEN;
                end;
            }
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
        IMEI_SERIAL_SHOW := FALSE;
    end;

    trigger OnPreReport()
    begin
        IF USERID IN ['ADMIN', 'ACCAM'] THEN
            IMEI_SERIAL_SHOW := TRUE
        ELSE
            IMEI_SERIAL_SHOW := FALSE; //Win-234 19-03-2019
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
        salesprice: Decimal;
        salesp: Record 13;
        salespnm: Text[250];
        staterec: Record State;
        statnm: Text[250];
        payterms: Record 3;
        paytermsdesc: Text[250];
        item: Record 27;
        schem: Record 50001;
        netsaleswotax: Decimal;
        totsalesamt: Decimal;
        saleshdr: Record 36;
        purchhdr: Record 38;
        servtaxperc: Decimal;
        itemrec: Record 27;
        salesinvline: Record 113;
        ItemDesc: Text[250];
        uom: Text[250];
        salesinvHdr: Record 112;
        ShieldRec: Record 50001;
        refno: Code[30];
        terms: Text[1024];
        Brand: Code[30];
        Catgry: Code[30];
        CreditMemoEntry: Boolean;
        IMEI_SERIAL_SHOW: Boolean;
}

