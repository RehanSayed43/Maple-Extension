report 50033 "GST-Purchase Order"

{
    DefaultLayout = RDLC;
    RDLCLayout = './GSTPurchaseOrder.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("No.", "Document Type")
                                ORDER(Ascending)
                                WHERE("Document Type" = FILTER(Order));
            RequestFilterFields = "No.";
            column(PO_No; "Purchase Header"."No.")
            {
            }
            column(Purch_Date; "Purchase Header"."Document Date")
            {
            }
            column(Supplier_code; "Purchase Header"."Buy-from Vendor No.")
            {
            }
            column(Shipment_method; "Purchase Header"."Transport Method")
            {
            }
            column(ExpectedDeliveryDate; "Purchase Header"."Expected Receipt Date")
            {
            }
            column(PaymentDescription; PaymentDescription)
            {
            }
            column(Company_Logo; CompanyInfo.Picture)
            {
            }
            column(Company_Name; CompanyInfo.Name)
            {
            }
            column(Company_Name2; CompanyInfo."Name 2")
            {
            }
            column(Company_Addr; Location.Address)
            {
            }
            column(Company_Addr2; Location."Address 2")
            {
            }
            column(Company_City; Location.City)
            {
            }
            column(Company_Pincode; Location."Post Code")
            {
            }
            column(SupplierName; SupplierName)
            {
            }
            column(SupplierAddress; SupplierAddress)
            {
            }
            column(SupplierAddress2; SupplierAddress2)
            {
            }
            column(SupplierCity; SupplierCity)
            {
            }
            column(SupplierPinCode; SupplierPinCode)
            {
            }
            column(ShiptoName; ShiptoName)
            {
            }
            column(ShiptoAddress; ShiptoAddress)
            {
            }
            column(ShiptoAddress2; ShiptoAddress2)
            {
            }
            column(ShiptoCity; ShiptoCity)
            {
            }
            column(ShiptoPinCode; ShiptoPinCode)
            {
            }
            column(GSTIN; GSTIN)
            {
            }
            column(GSTIN2; GSTIN2)
            {
            }
            column(ShiptoStateCode; ShiptoStateCode)
            {
            }
            column(ShiptoStateCodeNo; ShiptoStateCodeNo)
            {
            }
            column(ShiptoState; ShiptoState)
            {
            }
            column(CompState; CompState)
            {
            }
            column(CompStateCode; CompStateCode)
            {
            }
            column(CompStateCodeNo; CompStateCodeNo)
            {
            }
            column(AmounttoVendor_PurchaseHeader; FinalTotal)
            {
            }
            column(AmountInWord; AmountInWord[1])
            {
            }
            column(SupplierState; SupplierState)
            {
            }
            column(SupplierStateCode; SupplierStateCode)
            {
            }
            column(SupplierGSTNNo; SupplierGSTNNo)
            {
            }//tk
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE("Document Type" = FILTER(Order));
                column(VendorItemCode; "Purchase Line"."Vendor Item No.")
                {
                }
                column(ItemNo; "Purchase Line"."No.")
                {
                }
                column(ItemDesc; "Purchase Line".Description)
                {
                }
                column(HSN_SACCode; "Purchase Line"."HSN/SAC Code")
                {
                }
                column(Qty; "Purchase Line".Quantity)
                {
                }
                column(UOM; "Purchase Line"."Unit of Measure Code")
                {
                }
                column(Unit_Cost; "Purchase Line"."Unit Cost (LCY)")
                {
                }
                column(Amount; "Purchase Line".Amount)
                {
                }
                column(LineAmt; "Purchase Line"."Amount")
                {
                }
                column(GSTComponentCode; recDetailedGSTEntryBuffer."GST Component Code")
                {
                }
                column(SerialNo; SerialNo)
                {
                }
                column(GSTRate; recDetailedGSTEntryBuffer."GST %")
                {
                }
                column(GSTAmount; recDetailedGSTEntryBuffer."GST Amount")
                {
                }
                column(CGSTRate; CGSTRate)
                {
                }
                column(CGSTAmt; CGSTAmt)
                {
                }
                column(SGSTRate; SGSTRate)
                {
                }
                column(SGSTAmt; SGSTAmt)
                {
                }
                column(IGSTRate; IGSTRate)
                {
                }
                column(IGSTAmt; IGSTAmt)
                {
                }
                column(AmttoVendor; purchaselinerec."Amount")
                {
                }
                column(GSTComponentCGST; GSTComponentCGST)
                {
                }
                column(GSTComponentSGST; GSTComponentSGST)
                {
                }
                column(GSTComponentIGST; GSTComponentIGST)
                {
                }
                column(TotalGSTAmount_PurchaseLine; '')
                {
                }
                column(VendorPartCode; "Purchase Line"."Vendor Part Code Long")
                {
                }
                column(s; s)
                {
                }

                trigger OnAfterGetRecord()
                Var
                    TaxTransactionValue: Record "Tax Transaction Value";
                    GSTSetup: Record "GST Setup";
                    TDSSetup: Record "TDS Setup";
                begin
                    IF GSTSetup.get() Then;
                    IF TDSSetup.Get() Then;
                    Clear(SGSTAmt);
                    Clear(CGSTAmt);
                    Clear(IGSTAmt);
                    Clear(SGSTRate);
                    Clear(CGSTRate);
                    Clear(IGSTRate);

                    Clear(GSTComponentIGST);
                    Clear(GSTComponentCGST);
                    Clear(GSTComponentSGST);

                    GetGSTAmounts(TaxTransactionValue, "Purchase Line", GSTSetup);

                    GetGSTCaptions(TaxTransactionValue, "Purchase Line", GSTSetup);

                    GetCessAmount(TaxTransactionValue, "Purchase Line", GSTSetup);

                    GetTDSAmount(TaxTransactionValue, "Purchase Line", TDSSetup);


                    //For Blank Space between body and footer


                    s := "Purchase Line".COUNT;

                    RecItem.RESET;
                    RecItem.SETRANGE("No.", "Purchase Line"."No.");
                    IF RecItem.FINDFIRST THEN
                        VendorPartCode := RecItem."Vendor Part Code Long";


                    SerialNo += 1;

                end;

                trigger OnPreDataItem()
                begin
                    //SerialNo:=0;

                    linecount := 0;
                end;
            }
            dataitem(Integer; Integer)
            {
                DataItemLinkReference = "Purchase Header";
                column(Number_Integer; Integer.Number)
                {
                }

                trigger OnPreDataItem()
                begin
                    IF linecount > maxline THEN
                        spline := maxline - ROUND((linecount / maxline - ROUND(linecount / maxline, 1, '<')) * maxline, 1)
                    ELSE
                        spline := maxline - linecount;
                    Integer.SETRANGE(Number, 1, spline);
                end;
            }

            trigger OnAfterGetRecord()
            Var
                TaxTransactionValue: Record "Tax Transaction Value";
                GSTSetup: Record "GST Setup";
                PurchLine_L: Record "Purchase Line";
                TDSSetup: Record "TDS Setup";
                PostedVoucher: Report "Posted Voucher";
            begin
                IF GSTSetup.get() Then;
                IF TDSSetup.Get() Then;
                // WIN316++
                IF Loc_code = '' THEN
                    ERROR('Please select Bill to Location Code');
                Location.GET(Loc_code);
                //WIN316--

                //-payment term
                RecPayment.RESET;
                RecPayment.SETRANGE(Code, "Purchase Header"."Payment Terms Code");
                IF RecPayment.FINDFIRST THEN
                    PaymentDescription := RecPayment.Description;

                RecVendor.SETRANGE("No.", "Purchase Header"."Buy-from Vendor No.");
                IF RecVendor.FINDFIRST THEN BEGIN
                    SupplierName := RecVendor.Name + RecVendor."Name 2";
                    SupplierAddress := RecVendor.Address;
                    SupplierAddress2 := RecVendor."Address 2";
                    SupplierCity := RecVendor.City;
                    SupplierPinCode := RecVendor."Post Code";
                    SupplierGSTNNo := RecVendor."GST Registration No.";
                    RecState.RESET;
                    RecState.SETRANGE(Code, RecVendor."State Code");
                    IF RecState.FINDFIRST THEN
                        SupplierState := RecState.Description;
                    SupplierStateCode := RecState.Code + '(' + RecState."State Code (GST Reg. No.)" + ')';
                END;
                RecLocation.RESET;
                RecLocation.SETRANGE(Code, "Purchase Header"."Location Code");
                IF RecLocation.FINDFIRST THEN
                    ShiptoName := RecLocation.Name;
                ShiptoAddress := RecLocation.Address;
                ShiptoAddress2 := RecLocation."Address 2";
                ShiptoCity := RecLocation.City;
                ShiptoPinCode := RecLocation."Post Code";
                GSTIN2 := RecLocation."GST Registration No.";
                RecState.RESET;
                RecState.SETRANGE(Code, RecLocation."State Code");
                IF RecState.FINDFIRST THEN
                    ShiptoStateCode := RecLocation."State Code";
                ShiptoStateCodeNo := RecState."State Code (GST Reg. No.)";
                ShiptoState := RecState.Description;

                GSTIN := Location."GST Registration No.";
                RecState.SETRANGE(Code, CompanyInfo."State Code");
                IF RecState.FINDFIRST THEN BEGIN
                    CompStateCode := RecState.Code;
                    CompStateCodeNo := RecState."State Code (GST Reg. No.)";
                    CompState := RecState.Description;
                END;
                //FinalTotal := "Purchase Header"."Amount";
                PurchLine_L.Reset;
                PurchLine_L.Setrange("Document Type", "Purchase Header"."Document Type");
                PurchLine_L.SetRange("Document No.", "Purchase Header"."No.");
                IF PurchLine_L.Findset then
                    Repeat
                        Clear(SGSTAmt);
                        Clear(CGSTAmt);
                        Clear(IGSTAmt);
                        Clear(TDSAmt);
                        GetGSTAmounts(TaxTransactionValue, PurchLine_L, GSTSetup);
                        GetTDSAmount(TaxTransactionValue, PurchLine_L, TDSSetup);
                        FinalTotal += (PurchLine_L.Amount - ABS(TDSAmt) + Abs(CGSTAmt) + Abs(SGSTAmt) + Abs(IGSTAmt));
                    until PurchLine_L.Next = 0;

                //MESSAGE(FORMAT(FinalTotal));
                PostedVoucher.InitTextVariable;
                PostedVoucher.FormatNoText(AmountInWord, FinalTotal, '');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Bill to Location Code"; Loc_code)
                {
                    TableRelation = Location;
                    ApplicationArea = All;
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
        CompanyInfo.GET();
        CompanyInfo.CALCFIELDS(Picture);
        maxline := 23;
        linecount := 0;
        spline := 0;
    end;

    var
        CompanyInfo: Record 79;
        RecVendor: Record 23;
        RecItem: Record 27;
        RecPayment: Record 3;
        PaymentDescription: Text[80];
        SupplierName: Text[80];
        SupplierAddress: Text[100];
        SupplierAddress2: Text[100];
        SupplierCity: Text[30];
        SupplierPinCode: Code[10];
        RecLocation: Record 14;
        ShiptoName: Text[80];
        RecState: Record State;
        ShiptoAddress: Text[100];
        ShiptoAddress2: Text[100];
        ShiptoCity: Text[30];
        ShiptoPinCode: Text[10];
        ShiptoState: Text[30];
        ShiptoStateCode: Code[20];
        ShiptoStateCodeNo: Code[20];
        GSTIN: Code[20];
        GSTIN2: Code[20];
        CompState: Text[30];
        CompStateCode: Code[20];
        CompStateCodeNo: Code[20];
        recDetailedGSTEntryBuffer: Record "Detailed GST Entry Buffer";

        FinalTotal: Decimal;
        ReportCheck1: Report Check;
        AmountInWord: array[2] of Text;
        SerialNo: Integer;
        Amount: Decimal;
        Unit_Price: Decimal;
        TaxAmount: Decimal;
        GSTRate: Decimal;
        GSTAmount: Decimal;
        GSTComponentCGST: Text;
        GSTComponentSGST: Text;
        GSTComponentIGST: Text;
        GSTComponentCode: Text;
        Remarks: Record 43;
        purchaselinerec: Record 39;
        TotalAmount: Decimal;
        maxline: Integer;
        linecount: Integer;
        spline: Integer;
        GSTComponent: Code[30];
        GSTAmt: Decimal;
        SupplierState: Text;
        SupplierStateCode: Code[20];
        SupplierGSTNNo: Code[20];
        s: Integer;
        VendorPartCode: Code[60];
        Loc_code: Code[20];
        Location: Record 14;
        IGSTLbl: Label 'IGST';
        SGSTLbl: Label 'SGST';
        CGSTLbl: Label 'CGST';
        CESSLbl: Label 'CESS';
        GSTLbl: Label 'GST';
        GSTCESSLbl: Label 'GST CESS';
        CessAmount: Decimal;
        GSTComponentCodeName: array[20] of Code[20];
        CGSTAmt: Decimal;
        SGSTAmt: Decimal;
        CGSTRate: Decimal;
        SGSTRate: Decimal;
        IGSTRate: Decimal;
        IGSTAmt: Decimal;
        TDSAmt: Decimal;

    local procedure GetGSTAmounts(TaxTransactionValue: Record "Tax Transaction Value";
PurchaseLine: Record "Purchase Line";
GSTSetup: Record "GST Setup")
    var
        ComponentName: Code[30];
    begin
        ComponentName := GetComponentName("Purchase Line", GSTSetup);

        if (PurchaseLine.Type <> PurchaseLine.Type::" ") then begin
            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", PurchaseLine.RecordId);
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
            TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
            TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
            if TaxTransactionValue.FindSet() then
                repeat
                    case TaxTransactionValue."Value ID" of
                        6:
                            begin
                                SGSTAmt += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
                                SGSTRate := TaxTransactionValue.Percent;
                            End;
                        2:
                            begin
                                CGSTAmt += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
                                CGSTRate := TaxTransactionValue.Percent;
                            End;
                        3:
                            begin
                                IGSTAmt += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
                                IGSTRate := TaxTransactionValue.Percent;
                            End;

                    end;
                until TaxTransactionValue.Next() = 0;
        end;
    end;

    local procedure GetCessAmount(TaxTransactionValue: Record "Tax Transaction Value";
        PurchaseLine: Record "Purchase Line";
        GSTSetup: Record "GST Setup")
    begin
        if (PurchaseLine.Type <> PurchaseLine.Type::" ") then begin
            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", PurchaseLine.RecordId);
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."Cess Tax Type");
            TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
            if TaxTransactionValue.FindSet() then
                repeat
                    CessAmount += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(GetComponentName(PurchaseLine, GSTSetup)));
                until TaxTransactionValue.Next() = 0;
        end;
    end;

    local procedure GetGSTCaptions(TaxTransactionValue: Record "Tax Transaction Value";
        PurchaseLine: Record "Purchase Line";
        GSTSetup: Record "GST Setup")
    begin
        TaxTransactionValue.Reset();
        TaxTransactionValue.SetRange("Tax Record ID", PurchaseLine.RecordId);
        TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if TaxTransactionValue.FindSet() then
            repeat
                case TaxTransactionValue."Value ID" of
                    /*  6:
                         GSTComponentCodeName[6] := SGSTLbl;
                     2:
                         GSTComponentCodeName[2] := CGSTLbl;
                     3:
                         GSTComponentCodeName[3] := IGSTLbl; */
                    6:
                        begin
                            GSTComponentSGST := SGSTLbl;
                            linecount := linecount + 2;
                        end;
                    2:
                        begin
                            GSTComponentCGST := CGSTLbl;
                            linecount := linecount + 2;
                        end;
                    3:
                        begin
                            GSTComponentIGST := IGSTLbl;
                            linecount := linecount + 1;
                        end;
                end;
            until TaxTransactionValue.Next() = 0;
    end;

    local procedure GetComponentName(PurchaseLine: Record "Purchase Line";
        GSTSetup: Record "GST Setup"): Code[30]
    var
        ComponentName: Code[30];
    begin
        if GSTSetup."GST Tax Type" = GSTLbl then
            if PurchaseLine."GST Jurisdiction Type" = PurchaseLine."GST Jurisdiction Type"::Interstate then
                ComponentName := IGSTLbl
            else
                ComponentName := CGSTLbl
        else
            if GSTSetup."Cess Tax Type" = GSTCESSLbl then
                ComponentName := CESSLbl;
        exit(ComponentName)
    end;

    local procedure GetTDSAmount(TaxTransactionValue: Record "Tax Transaction Value";
        PurchaseLine: Record "Purchase Line";
        TDSSetup: Record "TDS Setup")
    begin
        if (PurchaseLine.Type <> PurchaseLine.Type::" ") then begin
            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", PurchaseLine.RecordId);
            TaxTransactionValue.SetRange("Tax Type", TDSSetup."Tax Type");
            TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
            TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
            if TaxTransactionValue.FindSet() then
                repeat
                    TDSAmt += TaxTransactionValue.Amount;
                until TaxTransactionValue.Next() = 0;
        end;
        TDSAmt := Round(TDSAmt, 1);
    end;

    procedure GetGSTRoundingPrecision(ComponentName: Code[30]): Decimal
    var
        TaxComponent: Record "Tax Component";
        GSTSetup: Record "GST Setup";
        GSTRoundingPrecision: Decimal;
    begin
        if not GSTSetup.Get() then
            exit;
        GSTSetup.TestField("GST Tax Type");

        TaxComponent.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxComponent.SetRange(Name, ComponentName);
        TaxComponent.FindFirst();
        if TaxComponent."Rounding Precision" <> 0 then
            GSTRoundingPrecision := TaxComponent."Rounding Precision"
        else
            GSTRoundingPrecision := 1;
        exit(GSTRoundingPrecision);
    end;
}



