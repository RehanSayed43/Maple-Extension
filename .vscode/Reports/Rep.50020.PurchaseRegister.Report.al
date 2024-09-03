report 50020 "Purchase Register"
{

    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './PurchaseRegister.rdl';

    dataset
    {
        // dataitem(DataItem1000000000; Table122)
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
            //dataitem(DataItem1000000001; Table123)
            dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Type = FILTER("G/L Account" | Item | "Charge (Item)"),
                                          Quantity = FILTER(<> 0));

                column(PurchInvLine; "Line No.") { }
                column(PurchInvDocNo; "Document No.") { }
                column(VendorVAT; RecVendor."VAT Registration No.")
                {
                }
                column(VendorServiceTAX; '')
                //column(VendorServiceTAX; RecVendor."Service Tax Registration No.")//kj
                {
                }
                column(VendorCST; '')
                //column(VendorCST; RecVendor."C.S.T. No.") //kj
                {
                }
                column(VendorPAN; RecVendor."P.A.N. No.")
                {
                }
                column(VendorTIN; '')
                //column(VendorTIN; RecVendor."T.I.N. No.") //kj
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
                // column(ProductGroupCode_PurchInvLine; '')
                column(ProductGroupCode_PurchInvLine; ProductCode)
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
                column(Tax_PurchInvLine; CGSTRate + SGSTRate + IGSTRate) //need to check_kj
                                                                         // column(Tax_PurchInvLine; "Purch. Inv. Line"."Tax %") //need to check_kj
                {
                }
                column(UnitCostLCY_PurchInvLine; "Purch. Inv. Line"."Unit Cost (LCY)")
                {
                }
                column(TaxAmount_PurchInvLine; CGSTAmt + SGSTAmt + IGSTAmt)
                // column(TaxAmount_PurchInvLine; "Purch. Inv. Line"."Tax Amount")
                {
                }  //need to check_kj
                column(ServiceTaxAmount_PurchInvLine; ServTaxamt)
                {
                }
                column(GrTot; GrTot) //kj
                // column(GrTot; "Purch. Inv. Line"."Amount To Vendor")
                {
                } //need to check_kj
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
                column(Charges; 0.00)
                //column(Charges; "Purch. Inv. Line"."Charges To Vendor")
                {
                } //need to check_kj
                column(GRTLCY; GRTOTLCY)
                {
                }
                column(PurchInvQty; PurchInvQty) { }
                column(MRPTot; MRPTot) { }
                column(TotUnitCost; TotUnitCost) { }
                column(TotGr; TotGr) { }
                column(TotGRLCY; TotGRLCY) { }
                column(TotTaxAmt; TotTaxAmt) { }
                dataitem(TempPurchRegSerialDI; TempPurchRegSerial)
                {
                    DataItemLinkReference = "Purch. Inv. Line";
                    DataItemLink = "Purch Inv" = field("Document No."), "Purch Line" = field("Line No.");

                    column(ILESerialNo; "Serial No") { }
                    column(PurchNo; "Purch Inv") { }
                    column("PurchLines"; "Purch Line") { }
                    column(ILEIMEINo; "IMEI No") { }
                    column(ILEVendorPart; VendorPartCode) { }
                    column(ILEItemCode; "Item Code") { }
                    column(ILEItemDes; "Item Description") { }
                    column(ItemCategCode; "Item Category Code") { }
                    column(ILECategory; Category) { }
                    column(ILEPrimeCat; "Prime Category") { }
                    column(ILESecCat; "Sec Category") { }
                    column(ILEThirdCat; "Third Category") { }


                }
                /* dataitem(ValueEntryRelation; "Value Entry Relation")
                {
                    DataItemLinkReference = "Purch. Inv. Line";
                    column(Source_RowId; "Source RowId") { }

                    dataitem(ValueEntry; "Value Entry")
                    {
                        DataItemLinkReference = ValueEntryRelation;
                        DataItemLink = "Entry No." = field("Value Entry No.");

                        dataitem(ItemLedgerEntry; "Item Ledger Entry")
                        {
                            DataItemLinkReference = ValueEntry;
                            DataItemLink = "Entry No." = field("Item Ledger Entry No.");
                            column(ILESerialNo; "Serial No.") { }
                            column(ILEIMEINo; "IMEI No.") { }
                            trigger OnAfterGetRecord()
                            begin
                                //    Message('%1 %2', ItemLedgerEntry."Serial No.", ItemLedgerEntry."IMEI No.");
                            end;

                            trigger OnPreDataItem()
                            begin

                            end;

                        }
                        trigger OnPreDataItem()
                        begin

                        end;


                    }

                    trigger OnPreDataItem()
                    var
                        ItemTrackingMgt: Codeunit "Item Tracking Management";
                        RefSourcID: Text[250];
                    begin
                        Clear(RefSourcID);
                        RefSourcID := ItemTrackingMgt.ComposeRowID(DATABASE::"Purch. Inv. Line", 0, "Purch. Inv. Line"."Document No.", '', 0, "Purch. Inv. Line"."Line No.");
                        SetRange("Source RowId", RefSourcID);
                    end;
                } */


                trigger OnAfterGetRecord()
                var
                    ItemTrackingMgt: Codeunit "Item Tracking Management";
                    ValueEntryRelation: Record "Value Entry Relation";
                    ValueEntry: Record "Value Entry";
                    ItemLedgEntry: Record "Item Ledger Entry";
                    SignFactor: Integer;
                    RefSourcID: Text[250];
                begin
                    GRTOTLCY := 0;
                    GrTot := 0;
                    IF "Purch. Inv. Line"."No." = '' THEN
                        CurrReport.SKIP;



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

                    CLEAR(CGSTAmt);
                    CLEAR(CGSTRate);
                    CLEAR(SGSTAmt);
                    CLEAR(SGSTRate);
                    CLEAR(IGSTAmt);
                    CLEAR(IGSTRate);
                    GSTDetailLeger.RESET;
                    GSTDetailLeger.SETRANGE(GSTDetailLeger."Document No.", "Purch. Inv. Line"."Document No.");
                    GSTDetailLeger.SETRANGE(GSTDetailLeger."No.", "Purch. Inv. Line"."No.");
                    GSTDetailLeger.SETRANGE(GSTDetailLeger."Document Line No.", "Purch. Inv. Line"."Line No.");
                    IF GSTDetailLeger.FINDSET THEN
                        REPEAT
                            IF GSTDetailLeger."GST Component Code" = 'CGST' THEN BEGIN
                                CGSTRate := GSTDetailLeger."GST %";
                                CGSTAmt := GSTDetailLeger."GST Amount";
                            END ELSE
                                IF GSTDetailLeger."GST Component Code" = 'SGST' THEN BEGIN
                                    SGSTRate := GSTDetailLeger."GST %";
                                    SGSTAmt := GSTDetailLeger."GST Amount";
                                END ELSE
                                    IF GSTDetailLeger."GST Component Code" = 'IGST' THEN BEGIN
                                        IGSTRate := GSTDetailLeger."GST %";
                                        IGSTAmt := GSTDetailLeger."GST Amount";
                                    END;
                        UNTIL GSTDetailLeger.NEXT = 0;

                    IF "Purch. Inv. Header"."Currency Code" <> '' then begin
                        GRTOTLCY := ("Purch. Inv. Line".Amount) / "Purch. Inv. Header"."Currency Factor" + CGSTAmt + SGSTAmt + IGSTAmt;
                        GrTot := "Purch. Inv. Line".Amount + (CGSTAmt + SGSTAmt + IGSTAmt) * "Purch. Inv. Header"."Currency Factor";
                    end else begin
                        GRTOTLCY := "Purch. Inv. Line".Amount + CGSTAmt + SGSTAmt + IGSTAmt;
                        GrTot := "Purch. Inv. Line".Amount + CGSTAmt + SGSTAmt + IGSTAmt;
                    end;
                    //IF schem.GET("Sales Invoice Line"."Scheme Code") THEN;
                    //salesprice:=0;
                    //salesprice:="Sales Invoice Line".Quantity*"Sales Invoice Line"."Unit Price";
                    //totsalesamt:=0;
                    //totsalesamt:=(("Sales Invoice Line".Quantity*"Sales Invoice Line"."Unit Price Incl. of Tax")-("Sales Invoice Line"."Scheme Amount"+"Sales Invoice Line"."Line Discount Amount"));
                    //netsaleswotax:=0;
                    //netsaleswotax:=(("Sales Invoice Line".Quantity*"Sales Invoice Line"."Unit Price")-("Sales Invoice Line"."Scheme Amount"+"Sales Invoice Line"."Line Discount Amount"));
                    EmieNo := '';
                    SrlNo := '';
                    PurchRectLine.RESET;
                    PurchRectLine.SETFILTER(PurchRectLine."Document No.", "Purch. Inv. Line"."Receipt No.");
                    PurchRectLine.SETRANGE(PurchRectLine."Line No.", "Purch. Inv. Line"."Receipt Line No.");
                    IF PurchRectLine.FINDFIRST THEN BEGIN
                        PRDt := PurchRectLine."Posting Date";
                    END;

                    RecItemLed.RESET;
                    RecItemLed.SETFILTER(RecItemLed."Document No.", "Purch. Inv. Line"."Receipt No.");
                    RecItemLed.SETRANGE(RecItemLed."Document Line No.", "Purch. Inv. Line"."Receipt Line No.");
                    RecItemLed.SETFILTER(RecItemLed."Item No.", "Purch. Inv. Line"."No.");
                    RecItemLed.SETRANGE(RecItemLed."Posting Date", PRDt);
                    IF RecItemLed.FINDFIRST THEN BEGIN
                        EmieNo := RecItemLed."IMEI No.";
                        SrlNo := RecItemLed."Serial No.";
                    END;
                    RecItem.Reset();
                    RecItem.SetRange("No.", "Purch. Inv. Line"."No.");
                    if RecItem.FindFirst() then begin
                        ProductCode := RecItem."Product Category";
                    end;
                    //kj_ need to check tax +++++++++++++
                    /* ServTaxPerc := 0;
                    IF ("Purch. Inv. Line"."Service Tax Amount" <> 0) AND ("Purch. Inv. Line"."Service Tax Base" <> 0) THEN
                        ServTaxPerc := ("Purch. Inv. Line"."Service Tax Amount" + "Purch. Inv. Line"."Service Tax eCess Amount" + "Purch. Inv. Line"."Service Tax SHE Cess Amount") * 100 / "Purch. Inv. Line"."Service Tax Base";
                    ServTaxamt := "Purch. Inv. Line"."Service Tax Amount" + "Purch. Inv. Line"."Service Tax eCess Amount" + "Purch. Inv. Line"."Service Tax SHE Cess Amount"; 
                    

                    PurchRectLine.RESET;
                    PurchRectLine.SETFILTER(PurchRectLine."Document No.", "Purch. Inv. Line"."Receipt Document No.");
                    PurchRectLine.SETRANGE(PurchRectLine."Line No.", "Purch. Inv. Line"."Receipt Document Line No.");
                    IF PurchRectLine.FINDFIRST THEN BEGIN
                        PRDt := PurchRectLine."Posting Date";
                    END;

                    RecItemLed.RESET;
                    RecItemLed.SETFILTER(RecItemLed."Document No.", "Purch. Inv. Line"."Receipt Document No.");
                    RecItemLed.SETRANGE(RecItemLed."Document Line No.", "Purch. Inv. Line"."Receipt Document Line No.");
                    RecItemLed.SETFILTER(RecItemLed."Item No.", "Purch. Inv. Line"."No.");
                    RecItemLed.SETRANGE(RecItemLed."Posting Date", PRDt);
                    IF RecItemLed.FINDFIRST THEN BEGIN
                        EmieNo := RecItemLed."IMEI No.";
                        SrlNo := RecItemLed."Serial No.";
                    END; */
                    //kj_ need to check tax ------------
                    //kj_ need to check  //  GRTOTLCY := ("Purch. Inv. Line"."Unit Cost (LCY)" * "Purch. Inv. Line".Quantity) + ("Purch. Inv. Line"."Tax Amount" + ServTaxamt + "Purch. Inv. Line"."Charges To Vendor");
                    PurchInvQty += "Purch. Inv. Line".Quantity;
                    MRPTot += item."Unit Price";
                    TotUnitCost += "Purch. Inv. Line"."Direct Unit Cost";
                    TotTaxAmt := TotTaxAmt + CGSTAmt + SGSTAmt + IGSTAmt;
                    TotGr += GrTot;
                    TotGRLCY += GRTOTLCY;
                    Clear(RefSourcID);
                    RefSourcID := ItemTrackingMgt.ComposeRowID(DATABASE::"Purch. Inv. Line", 0, "Purch. Inv. Line"."Document No.", '', 0, "Purch. Inv. Line"."Line No.");
                    ValueEntryRelation.SetCurrentKey("Source RowId");
                    ValueEntryRelation.SetRange("Source RowId", RefSourcID);
                    if ValueEntryRelation.Find('-') then begin
                        repeat
                            ValueEntry.Get(ValueEntryRelation."Value Entry No.");
                            if ValueEntry."Item Ledger Entry Type" in
                               [ValueEntry."Item Ledger Entry Type"::Purchase,
                                ValueEntry."Item Ledger Entry Type"::Sale,
                                ValueEntry."Item Ledger Entry Type"::"Positive Adjmt.",
                                ValueEntry."Item Ledger Entry Type"::"Negative Adjmt."]
                            then begin
                                if ItemLedgEntry.Get(ValueEntry."Item Ledger Entry No.") then begin
                                    TempPurchRegSerial.Reset();
                                    TempPurchRegSerial.SetRange("Purch Inv", "Purch. Inv. Line"."Document No.");
                                    TempPurchRegSerial.SetRange("Purch Inv", "Purch. Inv. Line"."Document No.");
                                    TempPurchRegSerial.SetRange("Serial No", ItemLedgEntry."Serial No.");
                                    TempPurchRegSerial.SetRange("IMEI No", ItemLedgEntry."IMEI No.");
                                    if not TempPurchRegSerial.FindFirst() then begin
                                        TempPurchRegSerial.Init();
                                        TempPurchRegSerial."Entry No" := 0;
                                        TempPurchRegSerial."Purch Inv" := "Purch. Inv. Line"."Document No.";
                                        TempPurchRegSerial."Purch Line" := "Purch. Inv. Line"."Line No.";
                                        TempPurchRegSerial."Serial No" := ItemLedgEntry."Serial No.";
                                        TempPurchRegSerial."IMEI No" := ItemLedgEntry."IMEI No.";
                                        TempPurchRegSerial.VendorPartCode := VendorPartCode;
                                        TempPurchRegSerial."Item Code" := "Purch. Inv. Line"."No.";
                                        TempPurchRegSerial."Item Description" := "Purch. Inv. Line".Description;
                                        TempPurchRegSerial."Item Category Code" := "Purch. Inv. Line"."Item Category Code";
                                        TempPurchRegSerial.Category := ProductCode;
                                        TempPurchRegSerial."Prime Category" := "Purch. Inv. Line"."Primary category";
                                        TempPurchRegSerial."Sec Category" := "Purch. Inv. Line"."Secondary category";
                                        TempPurchRegSerial."Third Category" := "Purch. Inv. Line"."Third category";
                                        TempPurchRegSerial.Insert();
                                    end;
                                end;
                            end;
                        until ValueEntryRelation.Next() = 0;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    ServTaxPerc := 0;
                    PRDt := 0D;
                end;
            }

            trigger OnAfterGetRecord()
            begin
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
        PurchInvQty := 0;
        MRPTot := 0;
        TotUnitCost := 0;
        TotTaxAmt := 0;
        TotGr := 0;
        TotGRLCY := 0;
    end;

    trigger OnPreReport()
    begin
        //RecItemLed.GET;

        cnt := 1;

        IF USERID IN ['ACCAPV', 'PUREXE2'] THEN
            IMEI_SERIAL_SHOW := TRUE
        ELSE
            IMEI_SERIAL_SHOW := FALSE; //Win-234 19-03-2019
    end;

    trigger OnPostReport()
    begin
        TempPurchRegSerial.Reset();
        TempPurchRegSerial.DeleteAll();
    end;

    var
        salesp: Record "Salesperson/Purchaser";// "13";
        staterec: Record State;//"13762";
        item: Record Item;// "27";
        schem: Record "Scheme Details";//"50001";
        saleshdr: Record "Sales Header";// "36";
        purchhdr: Record "Purchase Header";// "38";
        Srno: Integer;
        startdt: Date;
        enddt: Date;
        RecVendor: Record Vendor;// "23";
        CompInfo: Record "Company Information";// "79";
        payterms: Record "Payment Terms";// "3";
        postedshipment: Record "Purch. Rcpt. Header";// "120";
        RecItemLed: Record "Item Ledger Entry";// "32";
        PurchLine: Record "Purchase Line";// "39";
        ServTaxPerc: Decimal;
        PurchRectLine: Record "Purch. Rcpt. Line";// "121";
        PRDt: Date;
        EmieNo: Code[30];
        SrlNo: Code[30];
        cnt: Integer;
        PINVL: Record "Purch. Inv. Line";//"123";
        ServTaxamt: Decimal;
        reclocation: Record Location;//"14";
        glacnt: Record "G/L Account";//"15";
        GrTot: Decimal;
        GRTOTLCY: Decimal;
        purchaserCode: Code[50];

        VendorPartCode: Code[50];
        IMEI_SERIAL_SHOW: Boolean;
        GSTDetailLeger: Record "Detailed GST Ledger Entry";//"16419";
        CGSTRate: Decimal;
        CGSTAmt: Decimal;
        SGSTAmt: Decimal;
        SGSTRate: Decimal;
        IGSTRate: Decimal;
        IGSTAmt: Decimal;
        RecItem: Record Item;
        ProductCode: Code[30];
        PurchInvQty: Decimal;
        TempPurchRegSerial: Record TempPurchRegSerial;
        MRPTot: Decimal;
        TotUnitCost: Decimal;
        TotTaxAmt: Decimal;
        TotGr: Decimal;
        TotGRLCY: Decimal;



}
