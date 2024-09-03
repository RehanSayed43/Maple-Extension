report 50260 "Sales Register Summary "
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './SalesRegisterSummary.rdl';
    PreviewMode = Normal;

    dataset
    {
        //dataitem(DataItem1000000019; Table112)
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("Posting Date")
                                ORDER(Ascending);
            RequestFilterHeading = '<>';
            column(No_SalesInvoiceHeader; "Sales Invoice Header"."No.")
            {
            }
            column(ShiptoCity_SalesInvoiceHeader; "Sales Invoice Header"."Ship-to City")
            {
            }
            column(ShortcutDimension1Code_SalesInvoiceHeader; "Sales Invoice Header"."Shortcut Dimension 1 Code")
            {
            }
            column(PostingDate_SalesInvoiceHeader; FORMAT("Sales Invoice Header"."Posting Date"))
            {
            }
            column(SelltoCustomerName_SalesInvoiceHeader; "Sales Invoice Header"."Sell-to Customer Name")
            {
            }
            column(EDATE; EDATE)
            {
            }
            column(SDATE; SDATE)
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(ExternalDocumentNo_SalesInvoiceHeader; "Sales Invoice Header"."External Document No.")
            {
            }
            //dataitem(DataItem1000000008; Table113)
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(Amount_SalesInvoiceLine; "Sales Invoice Line".Amount)
                {
                }
                //column(TaxAmount_SalesInvoiceLine; "Sales Invoice Line"."Tax Amount")
                column(TaxAmount_SalesInvoiceLine; '')
                {
                }
                //column(AmountIncludingTax_SalesInvoiceLine; "Sales Invoice Line"."Amount Including Tax")
                column(AmountIncludingTax_SalesInvoiceLine; '')
                {
                }  //kj_ need to check
                column(Sno; Sno)
                {
                }
                column(BRANCH_NAME; BRANCH_NAME)
                {
                }
                //column(AmountToCustomer_SalesInvoiceLine; "Sales Invoice Line"."Amount To Customer")
                column(AmountToCustomer_SalesInvoiceLine; "Sales Invoice Line".Amount + ABS(CGSTAmt) + ABS(SGSTAmt) + ABS(IGSTAmt))
                {
                }
                //column(TaxBaseAmount_SalesInvoiceLine; "Sales Invoice Line"."Tax Base Amount")
                column(TaxBaseAmount_SalesInvoiceLine; "Sales Invoice Line".Amount)
                {
                } //kj_ need to check
            }

            trigger OnAfterGetRecord()
            begin
                /*Dimension_value.RESET;
                Dimension_value.SETFILTER(Dimension_value."Dimension Code",'BR');
                 IF Dimension_value.FINDFIRST THEN REPEAT
                   IF Dimension_value.Code ="Shortcut Dimension 1 Code" THEN BEGIN
                    BRANCH_NAME := Dimension_value.Name;
                   END;
                UNTIL Dimension_value.NEXT = 0;
                */


                //IF PRE <> "Sales Invoice Header"."Entry No." THEN;
                Sno += 1;

                //PRE := "Sales Invoice Header"."Entry No." ;

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

            end;

            trigger OnPreDataItem()
            begin
                IF CompanyInfo.GET THEN;
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

    trigger OnPreReport()
    begin
        PRE := 0;
        Sno := 0;
    end;

    var
        SDATE: Date;
        EDATE: Date;
        CompanyInfo: Record "Company Information";//"79";
        Sno: Integer;
        PRE: Integer;
        Dimension_value: Record "Dimension Value";//"349";
        BRANCH_NAME: Text;
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

