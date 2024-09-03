#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50041 "Purch Credit Register Det -GST"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Purch Credit Register Det -GST.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Cr. Memo Hdr.")
        {
            RequestFilterFields = "Shortcut Dimension 1 Code";
            column(ReportForNavId_1000000019; 1000000019)
            {
            }
            column(No_PurchInvHeader; "Purch. Inv. Header"."No.")
            {
            }
            column(PostingDate_PurchInvHeader; Format("Purch. Inv. Header"."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(PostingDate11_PurchInvHeader; "Purch. Inv. Header"."Posting Date")
            {
            }
            column(BuyfromVendorName_PurchInvHeader; "Purch. Inv. Header"."Buy-from Vendor Name")
            {
            }
            column(Amount_PurchInvHeader; "Purch. Inv. Header".Amount)
            {
            }
            column(PurchaserCode_PurchInvHeader; "Purch. Inv. Header"."Purchaser Code")
            {
            }
            column(ShortcutDimension1Code_PurchInvHeader; "Purch. Inv. Header"."Shortcut Dimension 1 Code")
            {
            }
            column(EDATE; Format(EDATE, 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(Payment_MethodDescription; Payment_Method.Description)
            {
            }
            column(Transporter_Table_Name; "Transporter Table".Name)
            {
            }
            column(BuyfromCity_PurchInvHeader; "Purch. Inv. Header"."Buy-from City")
            {
            }
            column(SDATE; Format(SDATE, 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(SalesPerson_Purchase_Name; SalesPerson_Purchase.Name)
            {
            }
            column(AmounttoVendor_PurchInvHeader; "Purch. Inv. Header".Amount)
            {
            }
            column(DocumentDate_PurchInvHeader; Format("Purch. Inv. Header"."Document Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(GSTTIN_No; GSTTIN_No)
            {
            }
            column(PlaceOfSupply; PlaceOfSupply)
            {
            }
            dataitem("Purch. Inv. Line"; "Purch. Cr. Memo Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(ReportForNavId_1000000008; 1000000008)
                {
                }
                column(Sno; Sno)
                {
                }
                column(BRANCH_NAME; BRANCH_NAME)
                {
                }
                column(No_PurchInvLine; "Purch. Inv. Line"."No.")
                {
                }
                column(Description_PurchInvLine; "Purch. Inv. Line".Description)
                {
                }
                column(Quantity_PurchInvLine; "Purch. Inv. Line".Quantity)
                {
                }
                column(Amount_PurchInvLine; "Purch. Inv. Line".Amount)
                {
                }
                column(Tax_PurchInvLine; '')//"Purch. Inv. Line"."Tax %")//Rushab@ccit
                {
                }
                column(TaxAmount_PurchInvLine; '')// "Purch. Inv. Line"."Tax Amount")//Rushab@ccit
                {
                }
                column(DirectUnitCost_PurchInvLine; "Purch. Inv. Line"."Direct Unit Cost")
                {
                }
                column(AmountIncludingVAT_PurchInvLine; "Purch. Inv. Line"."Amount Including VAT")
                {
                }
                column(LineAmount_PurchInvLine; "Purch. Inv. Line"."Line Amount")
                {
                }
                column(AMT; AMT)
                {
                }
                column(UnitofMeasureCode_PurchInvLine; "Purch. Inv. Line"."Unit of Measure Code")
                {
                }
                column(Service_Tax_Amount; '')//"Purch. Inv. Line"."Service Tax Amount")//Rushab@ccit
                {
                }
                column(ServiceTaxeCessAmount_PurchInvLine; '')// "Purch. Inv. Line"."Service Tax eCess Amount")//Rushab@ccit
                {
                }
                column(ServiceTaxSHECessAmount_PurchInvLine; '')// "Purch. Inv. Line"."Service Tax SHE Cess Amount")//Rushab@ccit
                {
                }
                column(AmountToVendor_PurchInvLine; "Purch. Inv. Line"."Line Amount")
                {
                }
                column(CGSTAmt; Abs(CGSTAmt))
                {
                }
                column(SGSTAmt; Abs(SGSTAmt))
                {
                }
                column(IGSTAmt; Abs(IGSTAmt))
                {
                }
                column(TotalGSTAmount_PurchInvLine; '')// "Purch. Inv. Line"."Total GST Amount")//Rushab@ccit
                {
                }
                column(HSNSACCode_PurchInvLine; "Purch. Inv. Line"."HSN/SAC Code")
                {
                }
                column(GSTGroupCode_PurchInvLine; "Purch. Inv. Line"."GST Group Code")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Sno += 1;

                    //AMT := "Purch. Inv. Line"."Tax Amount" + "Purch. Inv. Line"."Line Amount" ;

                    //For GST Fields WIN275
                    Clear(CGSTAmt);
                    Clear(CGSTRate);
                    Clear(GSTComponentCGST);
                    Clear(SGSTAmt);
                    Clear(SGSTRate);
                    Clear(GSTComponentSGST);
                    Clear(IGSTAmt);
                    Clear(IGSTRate);
                    Clear(GSTComponentIGST);
                    GSTDetailLeger.Reset;
                    GSTDetailLeger.SetRange(GSTDetailLeger."Document No.", "Purch. Inv. Line"."Document No.");
                    GSTDetailLeger.SetRange(GSTDetailLeger."No.", "Purch. Inv. Line"."No.");
                    GSTDetailLeger.SetRange(GSTDetailLeger."Document Line No.", "Purch. Inv. Line"."Line No.");
                    if GSTDetailLeger.FindSet then
                        repeat
                            if GSTDetailLeger."GST Component Code" = 'CGST' then begin
                                GSTComponentCGST := 'CGST';
                                CGSTRate := GSTDetailLeger."GST %";
                                CGSTAmt := GSTDetailLeger."GST Amount";
                            end else
                                if GSTDetailLeger."GST Component Code" = 'SGST' then begin
                                    GSTComponentSGST := 'SGST';
                                    SGSTRate := GSTDetailLeger."GST %";
                                    SGSTAmt := GSTDetailLeger."GST Amount";
                                end else
                                    if GSTDetailLeger."GST Component Code" = 'IGST' then begin
                                        GSTComponentIGST := 'IGST';
                                        IGSTRate := GSTDetailLeger."GST %";
                                        IGSTAmt := GSTDetailLeger."GST Amount";
                                    end;
                        until GSTDetailLeger.Next = 0;
                    //For GST Fields WIN275
                end;

                trigger OnPreDataItem()
                begin
                    Sno := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //IF Payment_Method.GET("Purch. Inv. Header"."Payment Terms Code") THEN;
                if CompanyInfo.Get then;
                //IF SalesPerson_Purchase.GET("Purch. Inv. Header"."Purchaser Code") THEN;

                Clear(GSTTIN_No);
                Clear(Vend_State);
                Clear(PlaceOfSupply);
                RecVendor.Reset;
                RecVendor.SetRange(RecVendor."No.", "Purch. Inv. Header"."Buy-from Vendor No.");
                if RecVendor.FindFirst then begin
                    GSTTIN_No := RecVendor."GST Registration No.";
                    Vend_State := RecVendor."State Code";
                end;


                staterec.Reset;
                staterec.SetRange(staterec.Code, Vend_State);
                if staterec.FindFirst then begin
                    PlaceOfSupply := staterec.Description + ' (' + staterec."State Code (GST Reg. No.)" + ')';
                end;
            end;

            trigger OnPreDataItem()
            begin
                SetFilter("Posting Date", '%1..%2', SDATE, EDATE);
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
                    ApplicationArea = Basic;
                }
                field("End Date"; EDATE)
                {
                    ApplicationArea = Basic;
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

    var
        SDATE: Date;
        EDATE: Date;
        CompanyInfo: Record "Company Information";
        Payment_Method: Record "Payment Method";
        Sno: Integer;
        Dimension_value: Record "Dimension Value";
        BRANCH_NAME: Text;
        "Transporter Table": Record "Shipping Agent";
        SalesPerson_Purchase: Record "Salesperson/Purchaser";
        AMT: Decimal;
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
        RecVendor: Record Vendor;
        staterec: Record State;
}

