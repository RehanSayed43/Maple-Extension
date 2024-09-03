report 50259 "Sales Register Detailed "
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './SalesRegisterDetailed.rdl';

    dataset
    {
        //dataitem(DataItem1000000019; Table112)
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "Shortcut Dimension 1 Code";
            column(No_SalesInvoiceHeader; "Sales Invoice Header"."No.")
            {
            }
            column(SelltoCustomerNo_SalesInvoiceHeader; "Sales Invoice Header"."Sell-to Customer No.")
            {
            }
            column(PostingDate_SalesInvoiceHeader; FORMAT("Sales Invoice Header"."Posting Date"))
            {
            }
            column(SelltoCustomerName_SalesInvoiceHeader; "Sales Invoice Header"."Sell-to Customer Name")
            {
            }
            column(VehicleNo_SalesInvoiceHeader; "Sales Invoice Header"."Vehicle No.")
            {
            }
            column(Amount_SalesInvoiceHeader; "Sales Invoice Header".Amount)
            {
            }
            column(SalespersonCode_SalesInvoiceHeader; "Sales Invoice Header"."Salesperson Code")
            {
            }
            column(ShortcutDimension1Code_SalesInvoiceHeader; "Sales Invoice Header"."Shortcut Dimension 1 Code")
            {
            }
            column(PaymentTermsCode_SalesInvoiceHeader; "Sales Invoice Header"."Payment Terms Code")
            {
            }
            column(ShiptoCity_SalesInvoiceHeader; "Sales Invoice Header"."Ship-to City")
            {
            }
            column(OrderNo_SalesInvoiceHeader; "Sales Invoice Header"."Order No.")
            {
            }
            column(EDATE; EDATE)
            {
            }
            column(Payment_MethodDescription; '') //kj
            //column(Payment_MethodDescription; Payment_Method.Description)
            {
            }
            column(ShippingAgentCode_SalesInvoiceHeader; "Sales Invoice Header"."Shipping Agent Code")
            {
            }
            column(Transporter_Table_Name; "Transporter Table".Name)
            {
            }
            column(SDATE; SDATE)
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(SalesPerson_Purchaser_Name; SalesPerson_Purchaser.Name)
            {
            }
            column(ExternalDocumentNo_SalesInvoiceHeader; "Sales Invoice Header"."External Document No.")
            {
            }
            //dataitem(DataItem1000000008; Table113)
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {

                DataItemLink = "Document No." = FIELD("No.");
                DataItemLinkReference = "Sales Invoice Header";
                column(No_SalesInvoiceLine; "Sales Invoice Line"."No.")
                {
                }
                column(Description_SalesInvoiceLine; "Sales Invoice Line".Description)
                {
                }
                column(Quantity_SalesInvoiceLine; ROUND("Sales Invoice Line".Quantity))
                {
                }
                column(UnitPrice_SalesInvoiceLine; "Sales Invoice Line"."Unit Price")
                {
                }
                column(Amount_SalesInvoiceLine; "Sales Invoice Line".Amount)
                {
                }
                column(Tax_SalesInvoiceLine; 0)
                // column(Tax_SalesInvoiceLine; "Sales Invoice Line"."Tax %")
                {
                }
                column(TaxAmount_SalesInvoiceLine; 0)
                //column(TaxAmount_SalesInvoiceLine; "Sales Invoice Line"."Tax Amount")
                {
                }
                column(AmountIncludingTax_SalesInvoiceLine; "Sales Invoice Line".Amount + ABS(CGSTAmt) + ABS(SGSTAmt) + ABS(IGSTAmt))
                //column(AmountIncludingTax_SalesInvoiceLine; "Sales Invoice Line"."Amount Including Tax")
                {
                }  //kj_need to check
                column(Sno; Sno)
                {
                }
                column(BRANCH_NAME; BRANCH_NAME)
                {
                }
                column(QuantityBase_SalesInvoiceLine; ROUND("Sales Invoice Line"."Quantity (Base)"))
                {
                }
                column(UnitofMeasureCode_SalesInvoiceLine; "Sales Invoice Line"."Unit of Measure Code")
                {
                }
                //////////////////tax///////////////++++//kj_tax
                column(GSTComponentCGST; GSTComponentCGST)
                {
                }
                column(GSTComponentSGST; GSTComponentSGST)
                {
                }
                column(GSTComponentIGST; GSTComponentIGST)
                {
                }
                column(AmountToCustomer_SalesInvoiceLine; "Sales Invoice Line".Amount + ABS(CGSTAmt) + ABS(SGSTAmt) + ABS(IGSTAmt))
                // column(AmountToCustomer_SalesInvoiceLine; ROUND("Sales Invoice Line"."Amount To Customer"))
                {
                }
                column(GST_Base_Amount; "Sales Invoice Line".Amount)
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
                //////////////////tax///////////////-----------------------//kj_tax
                trigger OnAfterGetRecord()
                begin
                    Sno += 1;
                    //////TAX/////++++++++++++++++++++++++//kj
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
                    GSTDetailLeger.SETRANGE(GSTDetailLeger."Document No.", "Sales Invoice Line"."Document No.");
                    GSTDetailLeger.SETRANGE(GSTDetailLeger."No.", "Sales Invoice Line"."No.");
                    GSTDetailLeger.SETRANGE(GSTDetailLeger."Document Line No.", "Sales Invoice Line"."Line No.");
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
                    //////TAX/////----------------------------------//kj

                end;

                trigger OnPreDataItem()
                begin
                    Sno := 0;
                end;

            }

            trigger OnAfterGetRecord()
            begin
                IF SalesPerson_Purchaser.GET("Sales Invoice Header"."Salesperson Code") THEN;
                // IF Payment_Method.GET("Sales Invoice Header"."Payment Terms Code") THEN; //kj
                IF CompanyInfo.GET THEN;

                Dimension_value.RESET;
                Dimension_value.SETFILTER(Dimension_value."Dimension Code", 'BR');
                IF Dimension_value.FINDFIRST THEN
                    REPEAT
                        IF Dimension_value.Code = "Shortcut Dimension 1 Code" THEN BEGIN
                            BRANCH_NAME := Dimension_value.Name;
                        END;
                    UNTIL Dimension_value.NEXT = 0;

                IF "Transporter Table".GET("Sales Invoice Header"."Shipping Agent Code") THEN;




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
        SalesPerson_Purchaser: Record "Salesperson/Purchaser";//"13";
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

