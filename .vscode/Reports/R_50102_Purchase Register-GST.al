report 50102 "Purchase Register-GST"
{
    DefaultLayout = RDLC;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Purchase Register-GST.rdl';

    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            column(IMEI_SERIAL_SHOW; IMEI_SERIAL_SHOW)
            {
            }
            column(Srno; Srno)
            {
            }
            column(salespnm; purchaserCode)
            {
            }
            column(startdt; startdt)
            {
            }
            column(enddt; enddt)
            {
            }
            column(OrderDate_PurchInvHeader; "Purch. Inv. Header"."Order Date")
            {
            }
            column(OrderNo_PurchInvHeader; "Purch. Inv. Header"."Order No.")
            {
            }
            column(ExpectedReceiptDate_PurchInvHeader; "Purch. Inv. Header"."Expected Receipt Date")
            {
            }
            column(BuyfromVendorNo_PurchInvHeader; "Purch. Inv. Header"."Buy-from Vendor No.")
            {
            }
            column(No_PurchInvHeader; "Purch. Inv. Header"."No.")
            {
            }
            column(BuyfromVendorName_PurchInvHeader; "Purch. Inv. Header"."Buy-from Vendor Name")
            {
            }
            column(ShiptoName_PurchInvHeader; "Purch. Inv. Header"."Ship-to Name")
            {
            }
            column(PostingDate_PurchInvHeader; "Purch. Inv. Header"."Posting Date")
            {
            }
            column(DueDate_PurchInvHeader; "Purch. Inv. Header"."Due Date")
            {
            }
            column(RemarksVendor_PurchInvHeader; "Purch. Inv. Header"."Remarks Vendor")
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(CompInfoName; CompInfo.Name)
            {
            }
            column(Store; "Purch. Inv. Header"."Location Code")
            {
            }
            column(paytermsdesc; payterms.Description)
            {
            }
            column(ShipNo; postedshipment."No.")
            {
            }
            column(DispatchDocNo_PurchInvHeader; "Purch. Inv. Header"."Dispatch Doc No")
            {
            }
            column(DispatchThrough_PurchInvHeader; "Purch. Inv. Header"."Dispatch Through")
            {
            }
            column(DispatchDate_PurchInvHeader; "Purch. Inv. Header"."Dispatch Date")
            {
            }
            column(ShortcutDimension2Code_PurchInvHeader; "Purch. Inv. Header"."Shortcut Dimension 2 Code")
            {
            }
            column(VendorInvoiceNo_PurchInvHeader; "Purch. Inv. Header"."Vendor Invoice No.")
            {
            }
            column(VendorInvoiceDate_PurchInvHeader; "Purch. Inv. Header"."Vendor Invoice Date")
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
            dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                //DataItemTableView = WHERE(Type = FILTER("G/L Account" | Item | 'Charge (Item)'),Quantity = FILTER(<> 0));
                DataItemTableView = where(Quantity = FILTER(<> 0), Type = filter(Item | "G/L Account" | "Charge (Item)" | "Fixed Asset"));
                column(VendorVAT; RecVendor."VAT Registration No.")
                {
                }
                column(VendorServiceTAX; '')//RecVendor."Service Tax Registration No."
                {
                }
                column(VendorCST; '')//RecVendor."C.S.T. No."
                {
                }
                column(VendorPAN; RecVendor."P.A.N. No.")
                {
                }
                column(VendorTIN; '')//RecVendor."T.I.N. No."--CCIT
                {
                }
                column(MRP; item."Unit Price")
                {
                }
                column(zone; staterec.Zone)
                {
                }
                column(statenm; staterec.Description)
                {
                }
                column(VendorItemNo_PurchInvLine; VendorPartCode)
                {
                }
                column(Description_PurchInvLine; "Purch. Inv. Line".Description)
                {
                }
                column(UnitofMeasure_PurchInvLine; "Purch. Inv. Line"."Unit of Measure")
                {
                }
                column(Quantity_PurchInvLine; "Purch. Inv. Line".Quantity)
                {
                }
                column(DirectUnitCost_PurchInvLine; "Purch. Inv. Line"."Direct Unit Cost")
                {
                }
                column(Amount_PurchInvLine; "Purch. Inv. Line".Amount)
                {
                }
                column(ItemCategoryCode_PurchInvLine; "Purch. Inv. Line"."Item Category Code")
                {
                }
                column(ProductGroupCode_PurchInvLine; category)//"Purch. Inv. Line"."Product Group Code"
                {
                }
                column(Primarycategory_PurchInvLine; "Purch. Inv. Line"."Primary category")
                {
                }
                column(Secondarycategory_PurchInvLine; "Purch. Inv. Line"."Secondary category")
                {
                }
                column(Thirdcategory_PurchInvLine; "Purch. Inv. Line"."Third category")
                {
                }
                column(UnitPriceLCY_PurchInvLine; "Purch. Inv. Line"."Unit Price (LCY)")
                {
                }
                column(No_PurchInvLine; "Purch. Inv. Line"."No.")
                {
                }
                column(Tax_PurchInvLine; '')//"Purch. Inv. Line"."Tax %"
                {
                }
                column(UnitCostLCY_PurchInvLine; "Purch. Inv. Line"."Unit Cost (LCY)")
                {
                }
                column(TaxAmount_PurchInvLine; '')//"Purch. Inv. Line"."Tax Amount"
                {
                }
                column(ServiceTaxAmount_PurchInvLine; ServTaxamt)
                {
                }
                column(GrTot; GrTot)//"Purch. Inv. Line"."Amount To Vendor"
                {
                }
                column(SerialNo; SrlNo)
                {
                }
                column(IMEINo; EmieNo)
                {
                }
                column(ServTaxPerc; ServTaxPerc)
                {
                }
                column(PRDt; PRDt)
                {
                }
                column(Charges; '')//"Purch. Inv. Line"."Charges To Vendor"--CCIT
                {
                }
                column(GRTLCY; GRTOTLCY)
                {
                }
                column(CGSTAmt; CGSTAmt)
                {
                }
                column(SGSTAmt; SGSTAmt)
                {
                }
                column(IGSTAmt; IGSTAmt)
                {
                }
                column(GSTGroupCode_PurchInvLine; "Purch. Inv. Line"."GST Group Code")
                {
                }
                column(HSNSACCode_PurchInvLine; "Purch. Inv. Line"."HSN/SAC Code")
                {
                }
                column(TotalGSTAmount_PurchInvLine; (CGSTAmt + SGSTAmt + IGSTAmt))//"Purch. Inv. Line"."Total GST Amount"--CCIt
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //rushab_ccit++
                    category := '';
                    RecItem.Reset();
                    RecItem.SetRange("No.", "Purch. Inv. Line"."No.");
                    if RecItem.FindSet() then
                        repeat
                            category := RecItem."Product Category";
                        until RecItem.Next() = 0;
                    //rushab_ccit--




                    GRTOTLCY := 0;
                    IF "Purch. Inv. Line"."No." = '' THEN
                        CurrReport.SKIP;


                    //For GST Fields WIN275
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
                    GSTDetailLeger.SETRANGE(GSTDetailLeger."Document No.", "Purch. Inv. Line"."Document No.");
                    GSTDetailLeger.SETRANGE(GSTDetailLeger."No.", "Purch. Inv. Line"."No.");
                    GSTDetailLeger.SETRANGE(GSTDetailLeger."Document Line No.", "Purch. Inv. Line"."Line No.");
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
                    //For GST Fields WIN275


                    /*
                    IF RecVendor.GET("Purch. Inv. Line"."Buy-from Vendor No.") THEN;
                    //IF "Purch. Inv. Line"."State Code" <>''THEN
                    //staterec.GET("Purch. Inv. Line"."State Code");
                    //item.GET("Purch. Inv. Line"."No.");
                    IF "Purch. Inv. Line".Type = "Purch. Inv. Line".Type::Item THEN
                    IF reclocation.GET("Purch. Inv. Line"."Location Code") THEN;
                    item.GET("Purch. Inv. Line"."No.") ELSE
                      glacnt.GET("Purch. Inv. Line"."No.");
                    reclocation.GET("Purch. Inv. Line"."Location Code");
                    IF reclocation."State Code" <>'' THEN
                    staterec.GET(reclocation."State Code");
                    */

                    VendorPartCode := '';
                    IF "Purch. Inv. Header"."Buy-from Vendor No." <> 'VE-00040' THEN BEGIN
                        IF (("Purch. Inv. Line".Type = "Purch. Inv. Line".Type::Item)) THEN BEGIN //OR ("Purch. Inv. Line".Type = "Purch. Inv. Line".Type::"Charge (Item)"))THEN
                            item.GET("Purch. Inv. Line"."No.");
                            IF RecVendor.GET("Purch. Inv. Line"."Buy-from Vendor No.") THEN
                                VendorPartCode := item."Vendor Part Code Long";
                        END
                        ELSE
                            IF "Purch. Inv. Line".Type = "Purch. Inv. Line".Type::"G/L Account" THEN
                                glacnt.GET("Purch. Inv. Line"."No.");
                    END;
                    IF reclocation.GET("Purch. Inv. Line"."Location Code") THEN;
                    IF reclocation."State Code" <> '' THEN
                        staterec.GET(reclocation."State Code");




                    //IF schem.GET("Sales Invoice Line"."Scheme Code") THEN;
                    //salesprice:=0;
                    //salesprice:="Sales Invoice Line".Quantity*"Sales Invoice Line"."Unit Price";
                    //totsalesamt:=0;
                    //totsalesamt:=(("Sales Invoice Line".Quantity*"Sales Invoice Line"."Unit Price Incl. of Tax")-("Sales Invoice Line"."Scheme Amount"+"Sales Invoice Line"."Line Discount Amount"));
                    //netsaleswotax:=0;
                    //netsaleswotax:=(("Sales Invoice Line".Quantity*"Sales Invoice Line"."Unit Price")-("Sales Invoice Line"."Scheme Amount"+"Sales Invoice Line"."Line Discount Amount"));
                    EmieNo := '';
                    SrlNo := '';


                    ServTaxPerc := 0;
                    // IF("Purch. Inv. Line"."Service Tax Amount"<>0) AND ("Purch. Inv. Line"."Service Tax Base"<>0) THEN//CCIT
                    // ServTaxPerc:=("Purch. Inv. Line"."Service Tax Amount"+"Purch. Inv. Line"."Service Tax eCess Amount"+"Purch. Inv. Line"."Service Tax SHE Cess Amount")*100/"Purch. Inv. Line"."Service Tax Base";//CCIT
                    // ServTaxamt:="Purch. Inv. Line"."Service Tax Amount"+"Purch. Inv. Line"."Service Tax eCess Amount"+"Purch. Inv. Line"."Service Tax SHE Cess Amount";//CCIT

                    PurchRectLine.RESET;
                    PurchRectLine.SETFILTER(PurchRectLine."No.", "Purch. Inv. Line"."No.");//CCIT
                    PurchRectLine.SETRANGE(PurchRectLine."Line No.", "Purch. Inv. Line"."Line No.");//CCIT
                    IF PurchRectLine.FINDFIRST THEN BEGIN
                        PRDt := PurchRectLine."Posting Date";
                    END;

                    RecItemLed.RESET;
                    RecItemLed.SETFILTER(RecItemLed."Document No.", "Purch. Inv. Line"."Document No.");
                    RecItemLed.SETRANGE(RecItemLed."Document Line No.", "Purch. Inv. Line"."Line No.");
                    RecItemLed.SETFILTER(RecItemLed."Item No.", "Purch. Inv. Line"."No.");
                    RecItemLed.SETRANGE(RecItemLed."Posting Date", PRDt);
                    IF RecItemLed.FINDFIRST THEN BEGIN
                        EmieNo := RecItemLed."IMEI No.";
                        SrlNo := RecItemLed."Serial No.";
                    END;

                    GRTOTLCY := ("Purch. Inv. Line"."Unit Cost (LCY)" * "Purch. Inv. Line".Quantity) + ("Purch. Inv. Line"."Amount Including VAT" + ServTaxamt);//CCIT
                    GrTot := 0;
                    IF "Purch. Inv. Header"."Currency Code" <> '' then
                        GrTot := "Purch. Inv. Line".Amount + (CGSTAmt + SGSTAmt + IGSTAmt) * "Purch. Inv. Header"."Currency Factor"
                    else
                        GrTot := "Purch. Inv. Line".Amount + (CGSTAmt + SGSTAmt + IGSTAmt);
                end;

                trigger OnPreDataItem()
                begin
                    ServTaxPerc := 0;
                    PRDt := 0D;

                    "Purch. Inv. Line".SETFILTER("Posting Group", '<>%1', 'FG-MOTO');
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //WIN275 code added for GST
                CLEAR(GSTTIN_No);
                CLEAR(Vend_State);
                CLEAR(PlaceOfSupply);
                RecVendor.RESET;
                RecVendor.SETRANGE(RecVendor."No.", "Purch. Inv. Header"."Buy-from Vendor No.");
                IF RecVendor.FINDFIRST THEN BEGIN
                    GSTTIN_No := RecVendor."GST Registration No.";
                    Vend_State := RecVendor."State Code";
                END;


                staterec.RESET;
                staterec.SETRANGE(staterec.Code, Vend_State);
                IF staterec.FINDFIRST THEN BEGIN
                    PlaceOfSupply := staterec.Description + ' (' + staterec."State Code (GST Reg. No.)" + ')';
                END;

                reclocation.RESET;
                reclocation.SETRANGE(reclocation.Code, "Purch. Inv. Header"."Location Code");
                IF reclocation.FINDFIRST THEN
                    MapleGSTIN := reclocation."GST Registration No.";

                //WIN275 code added for GST

                PINVL.RESET;
                PINVL.SETFILTER(PINVL."Document No.", "Purch. Inv. Header"."No.");
                IF PINVL.FINDFIRST THEN
                    //IF ((PINVL.Type<>PINVL.Type::Item) AND (PINVL.Type<>PINVL.Type::"G/L Account")) OR (PINVL.Quantity=0)  THEN
                    //IF(PINVL.Type<>PINVL.Type::Item) OR (PINVL.Quantity=0)  THEN
                    IF ((PINVL.Type <> PINVL.Type::Item) AND (PINVL.Type <> PINVL.Type::"G/L Account") AND (PINVL.Type <> PINVL.Type::"Charge (Item)")) THEN
                        CurrReport.SKIP;

                //Srno+=1;

                IF cnt = 1 THEN
                    CompInfo.GET;
                cnt += 1;
                IF cnt = 3 THEN
                    CLEAR(CompInfo);
                purchaserCode := '';
                IF salesp.GET("Purch. Inv. Header"."Purchaser Code") THEN
                    purchaserCode := salesp.Name;

                IF payterms.GET("Purch. Inv. Header"."Payment Terms Code") THEN;


                //IF saleshdr.GET(saleshdr."Document Type"::Order,"Sales Invoice Header"."Order No.") THEN;


                //IF purchhdr.GET(purchhdr."Document Type"::Order,saleshdr."PurchaseOrderNo.") THEN;
                /*
                CLEAR(GSTTIN_No);
                CLEAR(Vend_State);
                CLEAR(PlaceOfSupply);
                RecCustomer.RESET;
                RecCustomer.SETRANGE("No.","Sales Invoice Header"."Sell-to Customer No.");
                IF RecCustomer.FINDFIRST THEN
                  GSTTIN_No:=RecCustomer."GST Registration No.";
                  Cust_State:=RecCustomer."State Code";
                
                staterec.RESET;
                staterec.SETRANGE(staterec.Code,Cust_State);
                IF staterec.FINDFIRST THEN
                BEGIN
                  PlaceOfSupply:=staterec.Description + ' (' + staterec."State Code (GST Reg. No.)" + ')' ;
                END;
                */

            end;

            trigger OnPreDataItem()
            begin
                Srno := 0;

                "Purch. Inv. Header".SETRANGE("Purch. Inv. Header"."Posting Date", startdt, enddt);
                //IF "Purch. Inv. Header".FINDSET THEN;
                "Purch. Inv. Header"."Purchaser Code" := '';
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
        IMEI_SERIAL_SHOW := FALSE;
    end;

    trigger OnPreReport()
    begin
        //RecItemLed.GET;

        cnt := 1;
        IF USERID IN ['ADMIN', 'ACCAPV', 'PUREXE2'] THEN
            IMEI_SERIAL_SHOW := TRUE
        ELSE
            IMEI_SERIAL_SHOW := FALSE; //Win-234 19-03-2019
    end;

    var
        GrTot: Decimal;
        salesp: Record "Salesperson/Purchaser";
        staterec: Record State;
        item: Record Item;
        schem: Record "Scheme Details";
        saleshdr: Record "Sales Header";
        purchhdr: Record "Purchase Header";
        Srno: Integer;
        startdt: Date;
        enddt: Date;
        RecVendor: Record Vendor;
        CompInfo: Record "Company Information";
        payterms: Record "Payment Terms";
        postedshipment: Record "Purch. Rcpt. Header";
        RecItemLed: Record "Item Ledger Entry";
        PurchLine: Record "Purchase Line";
        ServTaxPerc: Decimal;
        PurchRectLine: Record "Purch. Rcpt. Line";
        PRDt: Date;
        EmieNo: Code[30];
        SrlNo: Code[30];
        cnt: Integer;
        PINVL: Record "Purch. Inv. Line";
        ServTaxamt: Decimal;
        reclocation: Record Location;
        glacnt: Record "G/L Account";
        GRTOTLCY: Decimal;
        purchaserCode: Code[50];
        VendorPartCode: Code[50];
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
        GSTTIN_No: Code[20];
        Vend_State: Code[20];
        PlaceOfSupply: Text;
        MapleGSTIN: Code[20];
        IMEI_SERIAL_SHOW: Boolean;
        category: Code[30];
        RecItem: record item;
}


