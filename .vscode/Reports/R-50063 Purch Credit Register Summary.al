report 50263 "Purch Credit Register Summary "
{
    DefaultLayout = RDLC;
    RDLCLayout = './PurchCreditRegisterSummary.rdl';
    ApplicationArea = FixedAsset;

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
            dataitem("Purch. Inv. Line"; "Purch. Cr. Memo Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(Amount_PurchInvLine; "Purch. Inv. Line".Amount)
                {
                }
                //column(TaxAmount_PurchInvLine; "Purch. Inv. Line"."Tax Amount")
                column(TaxAmount_PurchInvLine; '')
                {
                }
                // column(AmountIncludingTax_PurchInvLine; "Purch. Inv. Line"."Amount Including Tax")
                column(AmountIncludingTax_PurchInvLine; "Purch. Inv. Line".Amount + ABS(CGSTAmt) + ABS(SGSTAmt) + ABS(IGSTAmt))
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
                column(IGSTAmt; ABS(IGSTAmt))
                {
                }
                column(CGSTAmt; ABS(CGSTAmt))
                {
                }
                column(SGSTAmt; ABS(SGSTAmt))
                {
                }
                column(CGSTRate; CGSTRate)
                {
                }
                column(IGSTRate; IGSTRate)
                {
                }
                column(SGSTRate; SGSTRate)
                {
                }
                column(gstAmnt; gstAmnt)
                {

                }

            }

            trigger OnAfterGetRecord()
            begin
                IF VendorTable.GET("Purch. Inv. Header"."Buy-from Vendor No.") THEN;

                Sno += 1;

                IF "Currency Code" <> '' THEN
                    "Currency Code" := "Purch. Inv. Header"."Currency Code"
                ELSE
                    "Currency Code" := 'INR';

                // CALCFIELDS("Amount to Vendor");
                // PurchINVAmount := "Purch. Inv. Header"."Amount to Vendor";

                //IF "Currency Code" <> '' THEN BEGIN
                IF "Currency Factor" <> 0 THEN
                    PurchINVAmountLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(WORKDATE, "Currency Code", PurchINVAmount, "Currency Factor"))
                ELSE
                    PurchINVAmountLCY := PurchINVAmount;
                //END;

                CLEAR(CGSTRate);
                CLEAR(CGSTAmt);
                CLEAR(GSTComponentCGST);
                CLEAR(SGSTRate);
                CLEAR(SGSTAmt);
                CLEAR(GSTComponentSGST);
                CLEAR(IGSTRate);
                CLEAR(IGSTAmt);
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
        CompanyInfo: Record 79;
        Sno: Integer;
        PRE: Integer;
        Dimension_value: Record 349;
        BRANCH_NAME: Text;
        VendorTable: Record 23;
        "Currency Code": Code[10];
        PurchINVAmountLCY: Decimal;
        CurrExchRate: Record 330;
        PurchINVHeader: Record 124;
        PurchINVAmount: Decimal;
        GSTComponentCGST: Text;
        GSTComponentSGST: Text;
        GSTComponentIGST: Text;
        GSTDetailLeger: Record "Detailed GST Ledger Entry";//"16419";
        CGSTRate: Decimal;
        CGSTAmt: Decimal;
        SGSTAmt: Decimal;
        SGSTRate: Decimal;
        IGSTRate: Decimal;
        IGSTAmt: Decimal;
        gstAmnt: Decimal;
}

