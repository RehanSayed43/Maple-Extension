report 50264 "PurchCreditRegisterDetailed_1"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PurchCreditRegisterDetailed.rdl';
    ApplicationArea = FixedAsset;

    dataset
    {
        //dataitem("Purch. Inv. Header"; Table124)
        dataitem("Purch. Inv. Header"; "Purch. Cr. Memo Hdr.")
        {
            RequestFilterFields = "Shortcut Dimension 1 Code";
            column(No_PurchInvHeader; "Purch. Inv. Header"."No.")
            {
            }
            column(PostingDate_PurchInvHeader; FORMAT("Purch. Inv. Header"."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'))
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
            column(EDATE; FORMAT(EDATE, 0, '<Day,2>/<Month,2>/<Year4>'))
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
            column(SDATE; FORMAT(SDATE, 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(SalesPerson_Purchase_Name; SalesPerson_Purchase.Name)
            {
            }
            //column(AmounttoVendor_PurchInvHeader; "Purch. Inv. Header"."Amount to Vendor")
            column(AmounttoVendor_PurchInvHeader; "Purch. Inv. Line".Amount + ABS(CGSTAmt) + ABS(SGSTAmt) + ABS(IGSTAmt))
            {
            }  //need to check_kj
            column(DocumentDate_PurchInvHeader; FORMAT("Purch. Inv. Header"."Document Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            dataitem("Purch. Inv. Line"; "Purch. Cr. Memo Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
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
                //column(Tax_PurchInvLine; "Purch. Inv. Line"."Tax %")
                column(Tax_PurchInvLine; '')
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
                // column(TaxAmount_PurchInvLine; "Purch. Inv. Line"."Tax Amount")
                column(TaxAmount_PurchInvLine; '')
                {
                }  //kj_need to check
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
                //column(Service_Tax_Amount; "Purch. Inv. Line"."Service Tax Amount")
                column(Service_Tax_Amount; 0)
                {
                }
                //column(ServiceTaxeCessAmount_PurchInvLine; "Purch. Inv. Line"."Service Tax eCess Amount")
                column(ServiceTaxeCessAmount_PurchInvLine; 0)
                {
                }
                //column(ServiceTaxSHECessAmount_PurchInvLine; "Purch. Inv. Line"."Service Tax SHE Cess Amount")
                column(ServiceTaxSHECessAmount_PurchInvLine; 0)
                {
                }
                //column(AmountToVendor_PurchInvLine; "Purch. Inv. Line"."Amount To Vendor")
                column(AmountToVendor_PurchInvLine; "Purch. Inv. Line".Amount + ABS(CGSTAmt) + ABS(SGSTAmt) + ABS(IGSTAmt))
                {
                }   //need to check_kj

                trigger OnAfterGetRecord()
                begin
                    Sno += 1;

                    //AMT := "Purch. Inv. Line"."Tax Amount" + "Purch. Inv. Line"."Line Amount" ;
                end;

                trigger OnPreDataItem()
                begin
                    Sno := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //IF Payment_Method.GET("Purch. Inv. Header"."Payment Terms Code") THEN;
                IF CompanyInfo.GET THEN;
                //IF SalesPerson_Purchase.GET("Purch. Inv. Header"."Purchaser Code") THEN;
            end;

            trigger OnPreDataItem()
            begin
                SETFILTER("Posting Date", '%1..%2', SDATE, EDATE);
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

    var
        SDATE: Date;
        EDATE: Date;
        CompanyInfo: Record "Company Information";//"79";
        Payment_Method: Record "Payment Method";//"289";
        Sno: Integer;
        Dimension_value: Record "Dimension Value";//"349";
        BRANCH_NAME: Text;
        "Transporter Table": Record "Shipping Agent";//"291";
        SalesPerson_Purchase: Record "Salesperson/Purchaser";//"13";
        AMT: Decimal;
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

