report 50108 "Purchase Register BK 19"
{
    DefaultLayout = RDLC;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Purchase Register BK 19.rdl';
    Caption = '<Purchase Register New VAT>';

    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            column(IMEI_SERIAL_SHOW; IMEI_SERIAL_SHOW)
            {
            }
            column(CrDocument; CrDocument)
            {
            }
            column(CrDate; CrDate)
            {
            }
            column(Bill_State; recVen."State Code")
            {
            }
            column(State_code; recLoc."State Code")
            {
            }
            column(Ship_State; recLoc."State Code")
            {
            }
            column(ShiptoCity_PurchInvHeader; "Purch. Inv. Header"."Shortcut Dimension 1 Code")
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
                DataItemTableView = WHERE(Type = FILTER("G/L Account" | Item | 'Charge (Item)' | "Fixed Asset"),
                                          Quantity = FILTER(<> 0));
                column(GST_PER; '')//ROUND("Purch. Inv. Line"."GST %", 1,'=')
                {
                }
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
                column(VendorTIN; '')//RecVendor."T.I.N. No."
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
                column(ProductGroupCode_PurchInvLine; '')//"Purch. Inv. Line"."Product Group Code"
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
                column(GrTot; '')//"Purch. Inv. Line"."Amount To Vendor"
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
                column(Charges; '')//"Purch. Inv. Line"."Charges To Vendor"
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
                column(TotalGSTAmount_PurchInvLine; '')//"Purch. Inv. Line"."Total GST Amount"
                {
                }
                column(Frt; Frt)
                {
                }
                column(TaxAmount_PurchInvLine1; '')//"Purch. Inv. Line"."Tax Amount"
                {
                }
                column(Tax_PurchInvLine1; '')//"Purch. Inv. Line"."Tax %"
                {
                }
                column(AmountToVendor_PurchInvLine; '')//"Purch. Inv. Line"."Amount To Vendor"
                {
                }

                trigger OnAfterGetRecord()
                begin

                    GRTOTLCY := 0;
                    IF "Purch. Inv. Line"."No." = '' THEN
                        CurrReport.SKIP;

                    /*
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
                    GSTDetailLeger.SETRANGE(GSTDetailLeger."Document No.","Purch. Inv. Line"."Document No.");
                    GSTDetailLeger.SETRANGE(GSTDetailLeger."No.","Purch. Inv. Line"."No.");
                    GSTDetailLeger.SETRANGE(GSTDetailLeger."Document Line No.","Purch. Inv. Line"."Line No.");
                    IF GSTDetailLeger.FINDSET THEN REPEAT
                    IF GSTDetailLeger."GST Component Code"='CGST' THEN BEGIN
                      GSTComponentCGST:='CGST';
                      CGSTRate:=GSTDetailLeger."GST %";
                      CGSTAmt:=GSTDetailLeger."GST Amount";
                      END ELSE
                    IF GSTDetailLeger."GST Component Code"='SGST' THEN BEGIN
                      GSTComponentSGST:='SGST';
                      SGSTRate:=GSTDetailLeger."GST %";
                      SGSTAmt:=GSTDetailLeger."GST Amount";
                      END  ELSE
                    IF GSTDetailLeger."GST Component Code"='IGST' THEN BEGIN
                      GSTComponentIGST:='IGST';
                      IGSTRate:=GSTDetailLeger."GST %";
                      IGSTAmt:=GSTDetailLeger."GST Amount";
                      END;
                    UNTIL GSTDetailLeger.NEXT=0;
                    //For GST Fields WIN275
                    */

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
                    ServTaxamt := 0;
                    // IF("Purch. Inv. Line"."Service Tax Amount"<>0) AND ("Purch. Inv. Line"."Service Tax Base"<>0) THEN//CCIT
                    // ServTaxPerc:=("Purch. Inv. Line"."Service Tax Amount"+"Purch. Inv. Line"."Service Tax eCess Amount"+"Purch. Inv. Line"."Service Tax SHE Cess Amount")*100/"Purch. Inv. Line"."Service Tax Base";
                    // ServTaxamt:="Purch. Inv. Line"."Service Tax Amount"+"Purch. Inv. Line"."Service Tax eCess Amount"+"Purch. Inv. Line"."Service Tax SHE Cess Amount";//CCIT

                    PurchRectLine.RESET;
                    PurchRectLine.SETFILTER(PurchRectLine."Document No.", "Purch. Inv. Line"."Document No.");
                    PurchRectLine.SETRANGE(PurchRectLine."Line No.", "Purch. Inv. Line"."Line No.");
                    IF PurchRectLine.FINDFIRST THEN BEGIN
                        PRDt := PurchRectLine."Posting Date";
                    END;

                    RecItemLed.RESET;
                    RecItemLed.SETFILTER(RecItemLed."Document No.", "Purch. Inv. Line"."Document No.");
                    RecItemLed.SETRANGE(RecItemLed."Document Line No.", "Purch. Inv. Line"."Line No.");
                    RecItemLed.SETFILTER(RecItemLed."Item No.", "Purch. Inv. Line"."No.");
                    RecItemLed.SETRANGE(RecItemLed."Posting Date", PRDt);
                    IF RecItemLed.FINDSET THEN
                        REPEAT
                        BEGIN
                            EmieNo += RecItemLed."IMEI No." + ',';
                            SrlNo += RecItemLed."Serial No." + ',';

                        END;
                        UNTIL RecItemLed.NEXT = 0;

                    GRTOTLCY := ("Purch. Inv. Line"."Unit Cost (LCY)" * "Purch. Inv. Line".Quantity) + (ServTaxamt);
                    // GRTOTLCY := ("Purch. Inv. Line"."Unit Cost (LCY)" * "Purch. Inv. Line".Quantity) +  ("Purch. Inv. Line"."Tax Amount" + ServTaxamt + "Purch. Inv. Line"."Charges To Vendor");//CCIT


                    Frt := 0;
                    // RecFre.RESET;//CCIT+++
                    // RecFre.SETRANGE("Invoice No.","Purch. Inv. Line"."Document No.");
                    // RecFre.SETRANGE("Tax/Charge Type",RecFre."Tax/Charge Type"::Charges);
                    // RecFre.SETRANGE("Tax/Charge Group",'FREIGHT');
                    // RecFre.SETRANGE("Item No.","Purch. Inv. Line"."No.");
                    // RecFre.SETRANGE("Line No.","Purch. Inv. Line"."Line No.");
                    // IF RecFre.FINDFIRST THEN
                    // Frt:= RecFre.Amount;//CCIT----

                end;

                trigger OnPreDataItem()
                begin
                    ServTaxPerc := 0;
                    PRDt := 0D;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //MJ-010218+
                CrDocument := '';
                CrDate := 0D;
                recPostedCRmemo.RESET;
                recPostedCRmemo.SETRANGE(recPostedCRmemo."Applies-to Doc. No.", "Purch. Inv. Header"."No.");
                IF recPostedCRmemo.FINDFIRST THEN BEGIN
                    CrDocument := recPostedCRmemo."No.";
                    CrDate := recPostedCRmemo."Posting Date";
                END;

                IF recLoc.GET("Purch. Inv. Header"."Location Code") THEN;
                IF recVen.GET("Purch. Inv. Header"."Pay-to Vendor No.") THEN;
                //MJ-010218-


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
                    //IF ((PINVL.Type<>PINVL.Type::Item) AND (PINVL.Type<>PINVL.Type::"G/L Account") AND(PINVL.Type<>PINVL.Type::"Charge (Item)")) THEN
                    IF ((PINVL.Type <> PINVL.Type::Item) AND (PINVL.Type <> PINVL.Type::"G/L Account") AND (PINVL.Type <> PINVL.Type::"Charge (Item)") AND (PINVL.Type <> PINVL.Type::"Fixed Asset")) THEN//win-234 07/01/2019
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
        dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
        {
            column(purchaserCode1; purchaserCode1)
            {
            }
            column(IMEI_SERIAL_SHOW1; IMEI_SERIAL_SHOW)
            {
            }
            column(GSTTIN_No_CR; RecVendor2."GST Registration No.")
            {
            }
            column(MapleGSTIN_CR; recLoc1."GST Registration No.")
            {
            }
            column(PlaceofSupply_CR; PlaceofSupply_CR)
            {
            }
            column(AppliestoDocNo_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."Applies-to Doc. No.")
            {
            }
            column(AppliestoDocDate_CR; "Purch. Cr. Memo Hdr."."Document Date")
            {
            }
            column(LocationCode_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."Location Code")
            {
            }
            column(ShiptoCity_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."Shortcut Dimension 1 Code")
            {
            }
            column(BillToState_CR; recVen1."State Code")
            {
            }
            column(ShiptoSatet_CR; recLoc1."State Code")
            {
            }
            column(StateCode_CR; recLoc1."State Code")
            {
            }
            column(ShortcutDimension2Code_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."Shortcut Dimension 2 Code")
            {
            }
            column(Paytermsdec_CR; payterms1.Description)
            {
            }
            column(BuyfromVendorNo_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."Buy-from Vendor No.")
            {
            }
            column(BuyfromVendorName_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."Buy-from Vendor Name")
            {
            }
            column(No_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."No.")
            {
            }
            column(PostingDate_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."Posting Date")
            {
            }
            column(VendorCrMemoNo_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."Vendor Cr. Memo No.")
            {
            }
            dataitem("Purch. Cr. Memo Line"; "Purch. Cr. Memo Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Type = FILTER("G/L Account" | Item | 'Charge (Item)' | "Fixed Asset"),
                                          Quantity = FILTER(<> 0));
                column(VendorVAT_CR; recVen1."VAT Registration No.")
                {
                }
                column(PAN_No; recVen1."P.A.N. No.")
                {
                }
                column(CST_No; '')//"C.S.T. No."
                {
                }
                column(SerialNo11; SrlNo1)
                {
                }
                column(IMEINo11; EmieNo1)
                {
                }
                column(TIN_No; '')//"T.I.N. No."
                {
                }
                column(No_PurchCrMemoLine; "Purch. Cr. Memo Line"."No.")
                {
                }
                column(VendorItemNo_PurchCrMemoLine; "Purch. Cr. Memo Line"."Vendor Item No.")
                {
                }
                column(Description_PurchCrMemoLine; "Purch. Cr. Memo Line".Description)
                {
                }
                column(Quantity_PurchCrMemoLine; "Purch. Cr. Memo Line".Quantity)
                {
                }
                column(DirectUnitCost_PurchCrMemoLine; "Purch. Cr. Memo Line"."Direct Unit Cost")
                {
                }
                column(HSNSACCode_PurchCrMemoLine; "Purch. Cr. Memo Line"."HSN/SAC Code")
                {
                }
                column(GSTGroupCode_PurchCrMemoLine; "Purch. Cr. Memo Line"."GST Group Code")
                {
                }
                column(TotalGSTAmount_PurchCrMemoLine; '')//"Purch. Cr. Memo Line"."Total GST Amount"
                {
                }
                column(CGSTAmt1; CGSTAmt1)
                {
                }
                column(SGSTAmt1; SGSTAmt1)
                {
                }
                column(IGSTAmt1; IGSTAmt1)
                {
                }
                column(GrTot_CR; '')//"Purch. Cr. Memo Line"."Amount To Vendor"
                {
                }
                column(GST_per_CR; '')//ROUND("Purch. Cr. Memo Line"."GST %", 1, '=')
                {
                }
                column(ItemCategoryCode_PurchCrMemoLine; "Purch. Cr. Memo Line"."Item Category Code")
                {
                }
                column(ProductGroupCode_PurchCrMemoLine; '')//"Purch. Cr. Memo Line"."Product Group Code"
                {
                }
                column(Frt1; Frt1)
                {
                }
                column(Tax_PurchCrMemoLine; '')//"Purch. Cr. Memo Line"."Tax %"
                {
                }
                column(TaxAmount_PurchCrMemoLine; '')//"Purch. Cr. Memo Line"."Tax Amount"
                {
                }
                column(ItemCategoryCode_PurchCrMemoLine1; "Purch. Cr. Memo Line"."Item Category Code")
                {
                }
                column(ServTaxamt1; ServTaxamt1)
                {
                }
                column(ServTaxPerc1; ServTaxPerc1)
                {
                }
                column(AmountToVendor_PurchCrMemoLine; '')//"Purch. Cr. Memo Line"."Amount To Vendor"
                {
                }
                column(SerialNo1; SrlNo1)
                {
                }
                column(IMEINo1; EmieNo1)
                {
                }
                column(UnitofMeasure_PurchCrMemoLine; "Purch. Cr. Memo Line"."Unit of Measure")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF RecVendor1.GET("Purch. Cr. Memo Line"."Buy-from Vendor No.") THEN;
                    /*
                    //For GST Fields WIN396
                    CLEAR(CGSTAmt1);
                    CLEAR(CGSTRate1);
                    CLEAR(GSTComponentCGST1);
                    CLEAR(SGSTAmt1);
                    CLEAR(SGSTRate1);
                    CLEAR(GSTComponentSGST1);
                    CLEAR(IGSTAmt1);
                    CLEAR(IGSTRate1);
                    CLEAR(GSTComponentIGST1);
                    GSTDetailLeger.RESET;
                    GSTDetailLeger.SETRANGE(GSTDetailLeger."Document No.","Document No.");
                    GSTDetailLeger.SETRANGE(GSTDetailLeger."No.","No.");
                    GSTDetailLeger.SETRANGE(GSTDetailLeger."Document Line No.","Line No.");
                    IF GSTDetailLeger.FINDSET THEN REPEAT
                    IF GSTDetailLeger."GST Component Code"='CGST' THEN BEGIN
                      GSTComponentCGST1:='CGST';
                      CGSTRate1:=GSTDetailLeger."GST %";
                      CGSTAmt1:=GSTDetailLeger."GST Amount";
                      END ELSE
                    IF GSTDetailLeger."GST Component Code"='SGST' THEN BEGIN
                      GSTComponentSGST1:='SGST';
                      SGSTRate1:=GSTDetailLeger."GST %";
                      SGSTAmt1:=GSTDetailLeger."GST Amount";
                      END  ELSE
                    IF GSTDetailLeger."GST Component Code"='IGST' THEN BEGIN
                      GSTComponentIGST1:='IGST';
                      IGSTRate1:=GSTDetailLeger."GST %";
                      IGSTAmt1:=GSTDetailLeger."GST Amount";
                      END;
                    UNTIL GSTDetailLeger.NEXT=0;
                    //For GST Fields WIN396
                    */


                    ServTaxPerc1 := 0;
                    ServTaxamt1 := 0;
                    // IF("Purch. Cr. Memo Line"."Service Tax Amount"<>0) AND ("Purch. Cr. Memo Line"."Service Tax Base"<>0) THEN//CCIT
                    // ServTaxPerc1:=("Purch. Cr. Memo Line"."Service Tax Amount"+"Purch. Cr. Memo Line"."Service Tax eCess Amount"+"Purch. Cr. Memo Line"."Service Tax SHE Cess Amount")*100/"Purch. Cr. Memo Line"."Service Tax Base";
                    // ServTaxamt1:="Purch. Cr. Memo Line"."Service Tax Amount"+"Purch. Cr. Memo Line"."Service Tax eCess Amount"+"Purch. Cr. Memo Line"."Service Tax SHE Cess Amount";//CCIT


                    Frt1 := 0;
                    // RecFre1.RESET;//CCIT+++
                    // RecFre1.SETRANGE("Invoice No.","Document No.");
                    // RecFre1.SETRANGE("Tax/Charge Type",RecFre1."Tax/Charge Type"::Charges);
                    // RecFre1.SETRANGE("Tax/Charge Group",'FREIGHT');
                    // RecFre1.SETRANGE("Item No.","No.");
                    // RecFre1.SETRANGE("Line No.","Line No.");
                    // IF RecFre1.FINDFIRST THEN
                    // Frt1:= RecFre1.Amount;CCIT----

                    EmieNo1 := '';
                    SrlNo1 := '';

                    RecItemLed.RESET;
                    RecItemLed.SETFILTER(RecItemLed."Document No.", "Purch. Cr. Memo Line"."Document No.");
                    RecItemLed.SETRANGE(RecItemLed."Document Line No.", "Purch. Cr. Memo Line"."Line No.");
                    RecItemLed.SETFILTER(RecItemLed."Item No.", "Purch. Cr. Memo Line"."No.");

                    IF RecItemLed.FINDFIRST THEN BEGIN
                        EmieNo1 += RecItemLed."IMEI No." + ',';
                        SrlNo1 += RecItemLed."Serial No." + ',';
                    END;

                end;
            }

            trigger OnAfterGetRecord()
            begin
                //MJ
                IF RecVendor2.GET("Buy-from Vendor No.") THEN;
                IF RecState2.GET(RecVendor2."State Code") THEN;
                PlaceofSupply_CR := RecState2.Description + '(' + RecState2."State Code (GST Reg. No.)" + ')';
                IF recLoc1.GET("Purch. Cr. Memo Hdr."."Location Code") THEN;
                IF recVen1.GET("Purch. Cr. Memo Hdr."."Pay-to Vendor No.") THEN;
                IF payterms1.GET("Purch. Cr. Memo Hdr."."Payment Terms Code") THEN;
                //MJ

                purchaserCode1 := '';
                IF salesp.GET("Purch. Cr. Memo Hdr."."Purchaser Code") THEN
                    purchaserCode1 := salesp.Name;
            end;

            trigger OnPreDataItem()
            begin
                "Purch. Cr. Memo Hdr.".SETRANGE("Purch. Cr. Memo Hdr."."Posting Date", startdt, enddt); //MJ
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
        IMEI_SERIAL_SHOW := FALSE
    end;

    trigger OnPreReport()
    begin
        //RecItemLed.GET;

        cnt := 1;
        IF USERID IN ['ADMIN', 'ACCAPV', 'PUREXE2', 'ACC4EXE'] THEN
            IMEI_SERIAL_SHOW := TRUE
        ELSE
            IMEI_SERIAL_SHOW := FALSE; //Win-234 20-03-2019
    end;

    var
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
        EmieNo: Text;
        SrlNo: Text;
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
        recLoc: Record Location;
        recVen: Record Vendor;
        recGSTSetup: Record "GST Setup";
        recPostedCRmemo: Record "Purch. Cr. Memo Hdr.";
        CrDocument: Text;
        CrDate: Date;
        recLoc1: Record Location;
        recVen1: Record Vendor;
        payterms1: Record "Payment Terms";
        RecVendor1: Record Vendor;
        CGSTAmt1: Decimal;
        CGSTRate1: Decimal;
        GSTComponentCGST1: Text;
        SGSTAmt1: Decimal;
        SGSTRate1: Decimal;
        GSTComponentSGST1: Text;
        IGSTAmt1: Decimal;
        IGSTRate1: Decimal;
        GSTComponentIGST1: Text;
        RecVendor2: Record Vendor;
        RecState2: Record State;
        PlaceofSupply_CR: Text;
        IMEI_SERIAL_SHOW: Boolean;
        //RecFre: Record "Posted Str Order Line Details";
        Frt: Decimal;
        // RecFre1: Record "Posted Str Order Line Details";
        Frt1: Decimal;
        ServTaxPerc1: Decimal;
        ServTaxamt1: Decimal;
        EmieNo1: Text;
        SrlNo1: Text;
        purchaserCode1: Code[50];
}

