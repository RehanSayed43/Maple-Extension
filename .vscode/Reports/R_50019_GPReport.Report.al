report 50019 GPReport
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './GPReport.rdl';

    dataset
    {
        //dataitem(DataItem1000000068; Table79)
        dataitem("Company Information"; "Company Information")
        {
            DataItemTableView = SORTING("Primary Key");
            column(compinfoName; "Company Information".Name)
            {
            }
            column(compinfoPicture; "Company Information".Picture)
            {
            }
            column(startdt; startdt)
            {
            }
            column(enddt; enddt)
            {
            }
            column(boo; boo)
            {
            }
        }
        //dataitem(DataItem4577; Table112)
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Sales Order Type", "Location Code", "Salesperson Code";
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
            //dataitem(DataItem1000000006; Table113)
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(zone; staterec.Zone)
                {
                }
                column(statenm; staterec.Description)
                {
                }
                column(venditemcd; item."Vendor Part Code Long")
                {
                }
                column(ItemCat_Code; "Sales Invoice Line"."Item Category Code")
                {
                }
                column(ProdGrp_Code; Catgry) //kj
                //column(ProdGrp_Code; "Sales Invoice Line"."Product Group Code")
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
                column(schemecode; "Sales Invoice Line"."Scheme Code")
                {
                }
                column(srlno; SerialNo)
                {
                }
                column(imeino; ImeiNo)
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
                // column(taxamt; "Sales Invoice Line"."Tax Amount")
                {
                }
                column(taxp; '')
                // column(taxp; "Sales Invoice Line"."Tax %")
                {
                } //need to check_kj
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
                column(COGS; "Sales Invoice Line"."Unit Cost (LCY)" + CostPerUnt)
                {
                }
                column(claimamt; "Sales Invoice Line"."Claim Amount")
                {
                }
                column(gpamt; gpamt)
                {
                }
                column(gpperc; gpperc)
                {
                }
                column(GPAmtWoTax; "Sales Invoice Line"."Unit Price")
                {
                }
                column(GPAmtWidTax; GPAmtWidTax)
                {
                }
                column(GPAmtWidShield; GPAmtWidShield)
                {
                }
                column(GPAmtWidSHieldPerc; GPAmtWidSHieldPerc)
                {
                }
                column(ShldAmt; ShldAmt)
                {
                }
                column(ShldServTax; ShldServTax)
                {
                }
                column(ShldGpAmt; ShldGpAmt)
                {
                }
                column(ShldGpPerc; ShldGpPerc)
                {
                }
                column(ShldCOGS; ShldCOGS)
                {
                }
                column(ShldAmtWOTax; ShldAmtWOTax)
                {
                }
                column(AmtTotal; AmtTotal)
                {
                }
                column(MRP_Value_Var; MRP_Value_Var) //kj
                {
                }
                column(ElevaSerialNo; "Sales Invoice Line"."Eleva Product Serial No.") //kj
                {
                }
                trigger OnAfterGetRecord()
                var
                    Location_L: Record Location;
                    TempSalesShipLine: Record "Sales Shipment Line" temporary;
                    ILE_L: Record "Item Ledger Entry";
                begin
                    SerialNo := '';
                    ImeiNo := '';
                    "Sales Invoice Line".GetSalesShptLines(TempSalesShipLine);
                    ILE_L.Reset;
                    ILE_L.SetRange("Document No.", TempSalesShipLine."Document No.");
                    ILE_L.SetRange("Document Line No.", TempSalesShipLine."Line No.");
                    ILE_L.SetRange("Item No.", TempSalesShipLine."No.");
                    IF ILE_L.FindFirst() then begin
                        SerialNo := ILE_L."Serial No.";
                        ImeiNo := ILE_L."IMEI No.";
                    end;

                    SHPer := 0;
                    AmtTotal := 0;

                    CostPerUnt := 0;
                    RecVE.RESET;
                    RecVE.SETRANGE(RecVE."Document No.", "Sales Invoice Line"."Document No.");
                    RecVE.SETRANGE(RecVE."Item No.", "Sales Invoice Line"."No.");
                    RecVE.SETFILTER(RecVE."Source Code", 'INVTADJMT');
                    IF RecVE.FIND('-') THEN
                        REPEAT
                            CostPerUnt := RecVE."Cost per Unit";
                        //MESSAGE(FORMAT( CostPerUnt));
                        UNTIL RecVE.NEXT = 0;
                    //MESSAGE(FORMAT(RecVE."Cost per Unit"));
                    Clear(Location_L);
                    Clear(staterec);
                    IF Location_L.Get("Sales Invoice Line"."Location Code") then
                        IF staterec.GET(Location_L."State Code") THEN; //kj
                    IF item.GET("Sales Invoice Line"."No.") THEN;
                    IF schem.GET("Sales Invoice Line"."Scheme Code") THEN;
                    salesprice := 0;
                    salesprice := "Sales Invoice Line".Quantity * "Sales Invoice Line"."Unit Price";
                    totsalesamt := 0;
                    totsalesamt := (("Sales Invoice Line".Quantity * "Sales Invoice Line"."Unit Price Incl. of Tax") - ("Sales Invoice Line"."Scheme Amount" + "Sales Invoice Line"."Line Discount Amount"));
                    netsaleswotax := 0;
                    netsaleswotax := (("Sales Invoice Line".Quantity * "Sales Invoice Line"."Unit Price") - ("Sales Invoice Line"."Scheme Amount" + "Sales Invoice Line"."Line Discount Amount"));
                    gpperc := 0;
                    IF netsaleswotax <> 0 THEN
                        gpperc := (("Sales Invoice Line"."Unit Cost (LCY)" + CostPerUnt) / netsaleswotax) * 100;
                    gpamt := 0;
                    gpamt := netsaleswotax - ("Sales Invoice Line"."Claim Amount" + (("Sales Invoice Line"."Unit Cost (LCY)" + CostPerUnt) * "Sales Invoice Line".Quantity));
                    IF (("Sales Invoice Line"."Unit Cost (LCY)" + CostPerUnt) <> 0) THEN
                        gpperc := (gpamt * 100) / (("Sales Invoice Line"."Unit Cost (LCY)" + CostPerUnt));
                    GPAmtWidTax := 0;
                    GPAmtWidShield := 0;
                    GPAmtWidSHieldPerc := 0;

                    //kj+++
                    /*  GPAmtWidTax := "Sales Invoice Line"."Unit Price" + "Sales Invoice Line"."Service Tax Amount";
                     GPAmtWidShield := gpamt + "Sales Invoice Line"."Unit Price" - "Sales Invoice Line"."Shield Cost";
                     IF (("Sales Invoice Line"."Unit Cost (LCY)" + CostPerUnt) <> 0) THEN
                         GPAmtWidSHieldPerc := (GPAmtWidShield * 100) / ("Sales Invoice Line"."Unit Cost (LCY)" + CostPerUnt);
                     //servtaxperc:=("Sales Invoice Line"."Service Tax Amount"+"Sales Invoice Line"."Service Tax eCess Amount"+"Sales Invoice Line"."Service Tax SHE Cess Amount")*100/"Sales Invoice Line"."Service Tax Base";
                     servtaxamt := "Sales Invoice Line"."Service Tax Amount" + "Sales Invoice Line"."Service Tax eCess Amount" + "Sales Invoice Line"."Service Tax SHE Cess Amount";
  */ //kj----
                    ShldServTax := 0;
                    ShldAmt := 0;
                    ShldGpAmt := 0;
                    ShldGpPerc := 0;
                    ShldCOGS := 0;
                    ShldAmtWOTax := 0;

                    SalesSetup.GET;
                    sInvHeader.SETFILTER("Ref. Invoice No.", '%1', "Sales Invoice Line"."Document No.");
                    IF sInvHeader.FINDFIRST THEN BEGIN
                        sInvLineLocal.RESET;
                        sInvLineLocal.SETCURRENTKEY("Document No.", "Line No.");
                        sInvLineLocal.SETFILTER("Document No.", '%1', sInvHeader."No.");
                        sInvLineLocal.SETFILTER("Description 2", '%1', "Sales Invoice Line"."No.");
                        IF sInvLineLocal.FINDSET THEN BEGIN
                            REPEAT
                                //kj
                                /*  IF sInvLineLocal."No." = SalesSetup."Shield Sales Account" THEN BEGIN
                                     ShldServTax := sInvLineLocal."Service Tax Amount" + sInvLineLocal."Service Tax eCess Amount" + sInvLineLocal."Service Tax SHE Cess Amount";
                                     ShldAmt := sInvLineLocal."Shield Value";
                                     ShldAmtWOTax := ShldAmt - ShldServTax; */ //kj
                                                                               //  END; //kj
                                IF sInvLineLocal."No." = SalesSetup."Purchase Shield" THEN BEGIN
                                    //ShldCOGS := sInvLineLocal.Amount*-1;
                                    ShldCOGS := ABS(sInvLineLocal.Amount);
                                    ShldGpAmt := ShldAmt - ShldCOGS;
                                    // IF sInvLineLocal.Amount <> 0 THEN
                                    //   ShldGpPerc := ( ShldGpAmt * 100)/(ShldCOGS);
                                    //ShldGpPerc := ( AmtTotal * 100)/(ShldCOGS + "Sales Invoice Line"."Unit Cost (LCY)");
                                END;
                            UNTIL sInvLineLocal.NEXT = 0; //kj
                        END;
                    END;

                    SHPer := (ShldCOGS + "Sales Invoice Line"."Unit Cost (LCY)");
                    AmtTotal := (ShldAmtWOTax - ShldCOGS) + gpamt;
                    //IF sInvLineLocal.Amount <> 0 THEN
                    IF SHPer <> 0 THEN
                        //ShldGpPerc := ( AmtTotal * 100)/(ShldCOGS + "Sales Invoice Line"."Unit Cost (LCY)");
                        ShldGpPerc := (AmtTotal * 100) / (SHPer);

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
                        //CCIT AN
                        item_Cat.Reset();
                        item_Cat.SetRange("No.", "Sales Cr.Memo Line"."No.");
                        if item_Cat.FindSet() then begin
                            Catgry := item_Cat."Product Category";
                        end;

                    end;

                    //cckj-----------180823  

                end;

                trigger OnPostDataItem()
                begin

                    /*
                    RecVE.RESET;
                    RecVE.SETRANGE(RecVE."Document No.","Sales Invoice Line"."Document No.");
                    RecVE.SETRANGE(RecVE."Item No.","Sales Invoice Line"."No.");
                    RecVE.SETFILTER(RecVE."Source Code",'INVTADJMT');
                    if RecVE.findfirst then
                    CostPerUnt:=RecVE."Cost per Unit";
                    message(format(CostPerUnt));
                     */

                end;

                trigger OnPreDataItem()
                begin
                    //AmtTotal := 0;
                    //CostPerUnt:=RecVE."Cost per Unit";
                    //message(format(CostPerUnt));
                end;
            }

            trigger OnAfterGetRecord()
            begin

                Srno += 1;

                IF salesp.GET("Sales Invoice Header"."Salesperson Code") THEN;


                IF payterms.GET("Sales Invoice Header"."Payment Terms Code") THEN;


                IF saleshdr.GET(saleshdr."Document Type"::Order, "Sales Invoice Header"."Order No.") THEN;


                IF purchhdr.GET(purchhdr."Document Type"::Order, saleshdr."PurchaseOrderNo.") THEN;
            end;

            trigger OnPreDataItem()
            begin
                Srno := 0;
                "Sales Invoice Header".SETRANGE("Sales Invoice Header"."Posting Date", startdt, enddt);
                "Sales Invoice Header".SETFILTER("Sales Invoice Header"."Ref. Invoice No.", '=%1', '');
                IF "Sales Invoice Header".FINDSET THEN;
            end;
        }
        //dataitem(DataItem1000000066; Table114)
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "Location Code", "Salesperson Code", "Sales Order Type";
            column(Srno1; Srno1)
            {
            }
            column(SalesHead_Selltocustno; "Sales Cr.Memo Header"."Sell-to Customer No.")
            {
            }
            column(SalesHead_LocCode; "Sales Cr.Memo Header"."Location Code")
            {
            }
            column(SalesHead_Selltocity; "Sales Cr.Memo Header"."Sell-to City")
            {
            }
            column(SalesHead_SelltoCustName; "Sales Cr.Memo Header"."Sell-to Customer Name")
            {
            }
            column(SalesHead_No; "Sales Cr.Memo Header"."No.")
            {
            }
            column(SalesHead_ShrtcutDim2Code; "Sales Cr.Memo Header"."Shortcut Dimension 2 Code")
            {
            }
            column(SalesHead_CustName; "Sales Cr.Memo Header"."Customer Name")
            {
            }
            column(SalesHead_PostingDate; "Sales Cr.Memo Header"."Posting Date")
            {
            }
            column(SalesHead_SalesPersonCode; "Sales Cr.Memo Header"."Salesperson Code")
            {
            }
            column(SalesHead_DeliveryNote; "Sales Cr.Memo Header"."Delivery Note")
            {
            }
            column(SalesHead_DispatchCocNo; "Sales Cr.Memo Header"."Dispatch Doc. No.")
            {
            }
            column(SalesHead_DispatchThrough; "Sales Cr.Memo Header"."Dispatch Through")
            {
            }
            column(SalesHead_PayTermCode; "Sales Cr.Memo Header"."Payment Terms Code")
            {
            }
            column(Salespnm_name; salesp.Name)
            {
            }
            column(Paytrrm_Desc; payterms.Description)
            {
            }
            column(PurcHead_No; purchhdr."No.")
            {
            }
            column(PurHead_PostDate; purchhdr."Posting Date")
            {
            }
            //dataitem(DataItem1000000081; Table115)
            dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(State_Zone; staterec.Zone)
                {
                }
                column(State_Desc; staterec.Description)
                {
                }
                column(Item_venditemcd; item."Vendor Part Code Long")
                {
                }
                column(SalesLine_ProdGroupCode; Catgry)
                //column(SalesLine_ProdGroupCode; "Sales Cr.Memo Line"."Product Group Code") //kj
                {
                }
                column(srlno_SCM; SerialNo)
                {
                }
                column(imeino_SCM; ImeiNo)
                {
                }
                column(SalesLine_PrimaryCat; "Sales Cr.Memo Line"."Primary category")
                {
                }
                column(SalesLine_SecCat; "Sales Cr.Memo Line"."Secondary category")
                {
                }
                column(SalesLine_ThirdCat; "Sales Cr.Memo Line"."Third category")
                {
                }
                column(SalesLine_qty; "Sales Cr.Memo Line".Quantity)
                {
                }
                column(Sales_Line_UnitPrice; "Sales Cr.Memo Line"."Unit Price")
                {
                }
                column(SalesLine_TaxAmt; '')
                //column(SalesLine_TaxAmt; "Sales Cr.Memo Line"."Tax Amount")
                {
                }
                column(SalesLine_TaxPer; '')
                //column(SalesLine_TaxPer; "Sales Cr.Memo Line"."Tax %")
                {
                }  //kj_need to check
                column(SalesLine_LineDistPer; "Sales Cr.Memo Line"."Line Discount %")
                {
                }
                column(SalesLine_LineDisctAmt; "Sales Cr.Memo Line"."Line Discount Amount")
                {
                }
                column(SalesLine_UnitCostLCY; "Sales Cr.Memo Line"."Unit Cost (LCY)")
                {
                }
                column(Scheme_desc; schem.Descritpion)
                {
                }
                column(servTax_Amt; servtaxamt1)
                {
                }
                column(NetSalesWo_Tax; netsaleswotax1)
                {
                }
                column(TotalSales_Amt; totsalesamt1)
                {
                }
                column(Sales_Price; salesprice1)
                {
                }
                column(Gp_Amt; gpamt1)
                {
                }
                column(Gp_Perc; gpperc1)
                {
                }
                column(GPAmtWid_Tax; GPAmtWidTax1)
                {
                }
                column(GPAmtWid_Shield; GPAmtWidShield1)
                {
                }
                column(GPAmtWidSHield_Perc; GPAmtWidSHieldPerc1)
                {
                }
                column(Shld_Amt; ShldAmt1)
                {
                }
                column(ShldServ_Tax; ShldServTax1)
                {
                }
                column(ShldGp_Amt; ShldGpAmt1)
                {
                }
                column(ShldGp_Perc; ShldGpPerc1)
                {
                }
                column(Shld_COGS; ShldCOGS1)
                {
                }
                column(ShldAmtWO_Tax; ShldAmtWOTax1)
                {
                }
                column(Amt_Total; AmtTotal1)
                {
                }
                column(SalesLine_ItemCatCode; "Sales Cr.Memo Line"."Item Category Code")
                {
                }
                column(SalesLine_No; "Sales Cr.Memo Line"."No.")
                {
                }
                column(SalesLine_Desc; "Sales Cr.Memo Line".Description)
                {
                }
                column(COGS1; "Sales Cr.Memo Line"."Unit Cost (LCY)" + CostPerUnt1)
                {
                }

                trigger OnAfterGetRecord()
                var
                    Location_L: Record Location;
                    TempReturnReceiptLine: Record "Return Receipt Line" temporary;
                    ILE_L: Record "Item Ledger Entry";
                begin
                    SerialNo := '';
                    ImeiNo := '';
                    "Sales Cr.Memo Line".GetReturnRcptLines(TempReturnReceiptLine);
                    ILE_L.Reset;
                    ILE_L.SetRange("Document No.", TempReturnReceiptLine."Document No.");
                    ILE_L.SetRange("Document Line No.", TempReturnReceiptLine."Line No.");
                    ILE_L.SetRange("Item No.", TempReturnReceiptLine."No.");
                    IF ILE_L.FindFirst() then begin
                        SerialNo := ILE_L."Serial No.";
                        ImeiNo := ILE_L."IMEI No.";
                    end;
                    SHPer1 := 0;
                    AmtTotal1 := 0;

                    CostPerUnt1 := 0;
                    RecVE.RESET;
                    RecVE.SETRANGE(RecVE."Document No.", "Sales Cr.Memo Line"."Document No.");
                    RecVE.SETRANGE(RecVE."Item No.", "Sales Cr.Memo Line"."No.");
                    RecVE.SETFILTER(RecVE."Source Code", 'INVTADJMT');
                    IF RecVE.FIND('-') THEN
                        REPEAT
                            CostPerUnt1 := RecVE."Cost per Unit";
                        //MESSAGE(FORMAT( CostPerUnt));
                        UNTIL RecVE.NEXT = 0;
                    //MESSAGE(FORMAT(RecVE."Cost per Unit"));

                    Clear(Location_L);
                    Clear(staterec);
                    IF Location_L.Get("Sales Cr.Memo Line"."Location Code") then
                        IF staterec.GET(Location_L."State Code") THEN; //kj
                    IF item.GET("Sales Cr.Memo Line"."No.") THEN;
                    //--IF schem.GET("Sales Cr.Memo Line"."Scheme Code") THEN;

                    salesprice1 := 0;
                    salesprice1 := "Sales Cr.Memo Line".Quantity * "Sales Cr.Memo Line"."Unit Price";
                    totsalesamt1 := 0;
                    totsalesamt1 := (("Sales Cr.Memo Line".Quantity * "Sales Cr.Memo Line"."Unit Price Incl. of Tax") - (0 + "Sales Cr.Memo Line"."Line Discount Amount"));
                    netsaleswotax1 := 0;
                    netsaleswotax1 := (("Sales Cr.Memo Line".Quantity * "Sales Cr.Memo Line"."Unit Price") - (0 + "Sales Cr.Memo Line"."Line Discount Amount"));
                    gpperc1 := 0;

                    IF netsaleswotax1 <> 0 THEN
                        gpperc1 := (("Sales Cr.Memo Line"."Unit Cost (LCY)" + CostPerUnt1) / netsaleswotax1) * 100;
                    gpamt1 := 0;
                    gpamt1 := netsaleswotax1 - (0 + (("Sales Cr.Memo Line"."Unit Cost (LCY)" + CostPerUnt1) * "Sales Cr.Memo Line".Quantity));
                    IF (("Sales Cr.Memo Line"."Unit Cost (LCY)" + CostPerUnt1) <> 0) THEN
                        gpperc1 := (gpamt1 * 100) / (("Sales Cr.Memo Line"."Unit Cost (LCY)" + CostPerUnt1));
                    GPAmtWidTax1 := 0;
                    GPAmtWidShield1 := 0;
                    GPAmtWidSHieldPerc1 := 0;
                    //kj++++++
                    /*   GPAmtWidTax1 := "Sales Cr.Memo Line"."Unit Price" + "Sales Cr.Memo Line"."Service Tax Amount";
                      GPAmtWidShield1 := gpamt1 + "Sales Cr.Memo Line"."Unit Price" - "Sales Cr.Memo Line"."Shield Cost";
                      IF (("Sales Cr.Memo Line"."Unit Cost (LCY)" + CostPerUnt1) <> 0) THEN
                          GPAmtWidSHieldPerc1 := (GPAmtWidShield1 * 100) / ("Sales Cr.Memo Line"."Unit Cost (LCY)" + CostPerUnt1);
                      //servtaxperc:=("Sales Invoice Line"."Service Tax Amount"+"Sales Invoice Line"."Service Tax eCess Amount"+"Sales Invoice Line"."Service Tax SHE Cess Amount")*100/"Sales Invoice Line"."Service Tax Base";
                      servtaxamt1 := "Sales Cr.Memo Line"."Service Tax Amount" + "Sales Cr.Memo Line"."Service Tax eCess Amount" + "Sales Cr.Memo Line"."Service Tax SHE Cess Amount";
   */ //kj----
                    ShldServTax1 := 0;
                    ShldAmt1 := 0;
                    ShldGpAmt1 := 0;
                    ShldGpPerc1 := 0;
                    ShldCOGS1 := 0;
                    ShldAmtWOTax1 := 0;


                    SalesSetup.GET;
                    SalesCrMemoHeader.SETFILTER("Ref. Invoice No.", '%1', "Sales Cr.Memo Line"."Document No.");
                    IF SalesCrMemoHeader.FINDFIRST THEN BEGIN
                        SalesCrMemoLine.RESET;
                        SalesCrMemoLine.SETCURRENTKEY("Document No.", "Line No.");
                        SalesCrMemoLine.SETFILTER("Document No.", '%1', SalesCrMemoHeader."No.");
                        SalesCrMemoLine.SETFILTER("Description 2", '%1', "Sales Cr.Memo Line"."No.");
                        IF SalesCrMemoLine.FINDSET THEN BEGIN
                            REPEAT
                                //kj++++++++
                                /* IF SalesCrMemoLine."No." = SalesSetup."Shield Sales Account" THEN BEGIN
                                    ShldServTax1 := SalesCrMemoLine."Service Tax Amount" + SalesCrMemoLine."Service Tax eCess Amount" + SalesCrMemoLine."Service Tax SHE Cess Amount";
                                    ShldAmt1 := SalesCrMemoLine."Shield Value";
                                    ShldAmtWOTax1 := ShldAmt1 - ShldServTax1; 
                                END;*/ //kj----
                                IF SalesCrMemoLine."No." = SalesSetup."Purchase Shield" THEN BEGIN
                                    //ShldCOGS := sInvLineLocal.Amount*-1;
                                    ShldCOGS1 := ABS(SalesCrMemoLine.Amount);
                                    ShldGpAmt1 := ShldAmt1 - ShldCOGS1;
                                    // IF sInvLineLocal.Amount <> 0 THEN
                                    //   ShldGpPerc := ( ShldGpAmt * 100)/(ShldCOGS);
                                    //ShldGpPerc := ( AmtTotal * 100)/(ShldCOGS + "Sales Invoice Line"."Unit Cost (LCY)");
                                END;
                            UNTIL SalesCrMemoLine.NEXT = 0;
                        END;
                    END;

                    SHPer1 := (ShldCOGS1 + "Sales Cr.Memo Line"."Unit Cost (LCY)");
                    AmtTotal1 := (ShldAmtWOTax1 - ShldCOGS1) + gpamt1;
                    //IF sInvLineLocal.Amount <> 0 THEN
                    IF SHPer1 <> 0 THEN
                        //ShldGpPerc := ( AmtTotal * 100)/(ShldCOGS + "Sales Invoice Line"."Unit Cost (LCY)");
                        ShldGpPerc1 := (AmtTotal1 * 100) / (SHPer1);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Srno1 += 1;

                IF salesp.GET("Sales Cr.Memo Header"."Salesperson Code") THEN;


                IF payterms.GET("Sales Cr.Memo Header"."Payment Terms Code") THEN;


                //IF saleshdr.GET(saleshdr."Document Type"::Order,"Sales Cr.Memo Header"."Order No.") THEN;
                //IF saleshdr.GET(saleshdr."Document Type"::Order,"Sales Cr.Memo Header"."Buyer's Order No.") THEN;
                saleshdr.RESET;
                saleshdr.SETRANGE(saleshdr."Document Type", saleshdr."Document Type"::Order);
                saleshdr.SETRANGE(saleshdr."Buyer's Order No.", "Sales Cr.Memo Header"."Buyer's Order No.");
                IF saleshdr.FINDFIRST THEN;

                IF purchhdr.GET(purchhdr."Document Type"::Order, saleshdr."PurchaseOrderNo.") THEN;
            end;

            trigger OnPreDataItem()
            begin
                Srno1 := 0;

                "Sales Cr.Memo Header".SETRANGE("Sales Cr.Memo Header"."Posting Date", startdt, enddt);

                //"Sales Cr.Memo Header".SETFILTER("Sales Cr.Memo Header"."Ref. Invoice No.",'=%1','');
                IF "Sales Cr.Memo Header".FINDSET THEN;
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

    trigger OnPreReport()
    begin
        /*IF USERID = 'ACCAM' THEN
            boo := TRUE
        ELSE
            boo := FALSE; */// commented by CCIT AN 
    end;

    var
        SerialNo: Code[30];
        ImeiNo: Code[30];
        "1": Integer;
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
        salesp: Record "Salesperson/Purchaser";//"13";
        salespnm: Text[250];
        staterec: Record State;//"13762";
        statnm: Text[250];
        payterms: Record "Payment Terms";//"3";
        paytermsdesc: Text[250];
        item: Record Item;//"27";
        schem: Record "Scheme Details";// "50001";
        netsaleswotax: Decimal;
        totsalesamt: Decimal;
        saleshdr: Record "Sales Header";//"36";
        purchhdr: Record "Purchase Header";//"38";
        gpamt: Decimal;
        gpperc: Decimal;
        GPAmtWidTax: Decimal;
        GPAmtWidShield: Decimal;
        GPAmtWidSHieldPerc: Decimal;
        sInvLineLocal: Record "Sales Invoice Line";//"113";
        sInvHeader: Record "Sales Invoice Header";// "112";
        SalesSetup: Record "Sales & Receivables Setup";// "311";
        ShldAmt: Decimal;
        ShldServTax: Decimal;
        ShldGpAmt: Decimal;
        ShldGpPerc: Decimal;
        ShldCOGS: Decimal;
        servtaxamt: Decimal;
        ShldAmtWOTax: Decimal;
        AmtTotal: Decimal;
        SHPer: Decimal;
        RecVE: Record "Value Entry";// "5802";
        CostPerUnt: Decimal;
        Srno1: Integer;
        AmtTotal1: Decimal;
        SHPer1: Decimal;
        CostPerUnt1: Decimal;
        salesprice1: Decimal;
        netsaleswotax1: Decimal;
        totsalesamt1: Decimal;
        gpperc1: Decimal;
        gpamt1: Decimal;
        GPAmtWidTax1: Decimal;
        GPAmtWidShield1: Decimal;
        GPAmtWidSHieldPerc1: Decimal;
        servtaxamt1: Decimal;
        ShldServTax1: Decimal;
        ShldGpAmt1: Decimal;
        ShldGpPerc1: Decimal;
        ShldCOGS1: Decimal;
        ShldAmt1: Decimal;
        ShldAmtWOTax1: Decimal;
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";// "114";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";// "115";
        boo: Boolean;
        itemLedEntry: Record "Item Ledger Entry"; //cckj
                                                  //         SerialNo: text[30]; //cckj
                                                  //         IMEINo: Code[20]; //cckj
        SalesShipLine: Record "Sales Shipment Line"; //cckj
        MRP_Value_Var: Decimal;
        item_Cat: Record Item;
        Catgry: Code[30]; //Catgry

}

