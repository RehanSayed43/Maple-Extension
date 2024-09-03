report 50103 "Purch Cr Register Summary-GST"
{
    DefaultLayout = RDLC;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Purch Cr Register Summary-GST.rdl';

    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Cr. Memo Hdr.")
        {
            RequestFilterHeading = '<>';
            column(No_PurchInvHeader; "Purch. Inv. Header"."No.")
            {
            }
            column(ShiptoCity_PurchInvHeader; "Purch. Inv. Header"."Ship-to City")
            {
            }
            column(ShortcutDimension1Code_PurchInvHeader; "Purch. Inv. Header"."Shortcut Dimension 1 Code")
            {
            }
            column(PostingDate_PurchInvHeader; FORMAT("Purch. Inv. Header"."Posting Date"))
            {
            }
            column(PostingDate11_PurchInvHeader; "Purch. Inv. Header"."Posting Date")
            {
            }
            column(BuyfromVendorNo_PurchInvHeader; "Purch. Inv. Header"."Buy-from Vendor No.")
            {
            }
            column(EDATE; EDATE)
            {
            }
            column(SDATE; SDATE)
            {
            }
            column(BuyfromVendorName_PurchInvHeader; "Purch. Inv. Header"."Buy-from Vendor Name")
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(DocumentDate_PurchInvHeader; FORMAT("Purch. Inv. Header"."Document Date"))
            {
            }
            column(Currency_Code; "Currency Code")
            {
            }
            column(VendorTable_City; VendorTable.City)
            {
            }
            column(AppliestoDocNo_PurchInvHeader; "Purch. Inv. Header"."Applies-to Doc. No.")
            {
            }
            column(PurchINVAmountLCY; PurchINVAmountLCY)
            {
            }
            column(GSTTIN_No; GSTTIN_No)
            {
            }
            column(Vendor_Cr_Memo_No; "Purch. Inv. Header"."Vendor Cr. Memo No.")
            {
            }
            column(Vendor_Inv_No; RecPurInvHeader."Vendor Invoice No.")
            {
            }
            column(Vendor_Inv_Date; RecPurInvHeader."Posting Date")
            {
            }
            dataitem("Purch. Inv. Line"; "Purch. Cr. Memo Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(Amount_PurchInvLine; "Purch. Inv. Line".Amount)
                {
                }
                column(TaxAmount_PurchInvLine; '')//"Purch. Inv. Line"."Tax Amount"
                {
                }
                column(AmountIncludingTax_PurchInvLine; "Purch. Inv. Line"."Amount Including VAT")//"Amount Including Tax"--CCIT
                {
                }
                column(Quantity_PurchInvLine; "Purch. Inv. Line".Quantity)
                {
                }
                column(Sno; Sno)
                {
                }
                column(BRANCH_NAME; BRANCH_NAME)
                {
                }
                column(GSTGroupCode; "Purch. Inv. Line"."GST Group Code")
                {
                }
                column(HSN_SAC_Code; "Purch. Inv. Line"."HSN/SAC Code")
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
                column(TotalGSTAmt; Abs(CGSTAmt) + Abs(SGSTAmt) + Abs(IGSTAmt)) { }
                column(taxTotal; taxTotal) { }
                trigger OnAfterGetRecord()
                begin
                    // Clear(taxTotal);
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
                    taxTotal += Abs(CGSTAmt + SGSTAmt + IGSTAmt);
                    // Message('%1', taxTotal);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF VendorTable.GET("Purch. Inv. Header"."Buy-from Vendor No.") THEN;

                Sno += 1;

                IF "Currency Code" <> '' THEN
                    "Currency Code" := "Purch. Inv. Header"."Currency Code"
                ELSE
                    "Currency Code" := 'INR';

                CALCFIELDS("Amount Including VAT");//220623--CCIt
                PurchINVAmount := "Purch. Inv. Header"."Amount Including VAT";////220623--CCIt

                //IF "Currency Code" <> '' THEN BEGIN
                IF "Currency Factor" <> 0 THEN
                    PurchINVAmountLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(WORKDATE, "Currency Code", PurchINVAmount, "Currency Factor"))
                ELSE
                    PurchINVAmountLCY := PurchINVAmount;
                //END;


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

                RecPurInvHeader.RESET;
                RecPurInvHeader.SETRANGE("Buy-from Vendor No.", "Purch. Inv. Header"."Buy-from Vendor No.");
                RecPurInvHeader.SETRANGE("No.", "Purch. Inv. Header"."Applies-to Doc. No.");
                IF RecPurInvHeader.FINDFIRST THEN;
            end;

            trigger OnPreDataItem()
            begin
                IF CompanyInfo.GET THEN;
                SETFILTER("Posting Date", '%1..%2', SDATE, EDATE);

                CurrReport.CREATETOTALS(PurchINVAmount, PurchINVAmountLCY)
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Start Date"; SDATE)
                {
                    ApplicationArea = All;
                }
                field("End Date"; EDATE)
                {
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

        PRE := 0;
        Sno := 0;
    end;

    var
        SDATE: Date;
        EDATE: Date;
        CompanyInfo: Record "Company Information";
        Sno: Integer;
        PRE: Integer;
        Dimension_value: Record "Dimension Value";
        BRANCH_NAME: Text;
        VendorTable: Record Vendor;
        "Currency Code": Code[10];
        PurchINVAmountLCY: Decimal;
        CurrExchRate: Record "Currency Exchange Rate";
        PurchINVHeader: Record "Purch. Inv. Header";
        PurchINVAmount: Decimal;
        GSTDetailLeger: Record "Detailed GST Ledger Entry";
        CGSTRate: Decimal;
        CGSTAmt: Decimal;
        SGSTAmt: Decimal;
        SGSTRate: Decimal;
        IGSTRate: Decimal;
        IGSTAmt: Decimal;
        taxTotal: Decimal;
        GSTComponentCGST: Text;
        GSTComponentSGST: Text;
        GSTComponentIGST: Text;
        RecVendor: Record Vendor;
        GSTTIN_No: Code[15];
        Vend_State: Code[10];
        PlaceOfSupply: Text;
        staterec: Record State;
        RecPurInvHeader: Record "Purch. Inv. Header";
}

