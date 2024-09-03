report 50104 "Sales Credit Register Summary"
{
    DefaultLayout = RDLC;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Sales Credit Register Summary.rdl';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Cr.Memo Header")
        {
            DataItemTableView = ORDER(Ascending);
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
            column(AmounttoCustomer_SalesInvoiceHeader; AmountToCust)//"Sales Invoice Line".Amount + ABS(CGSTAmt) + ABS(SGSTAmt) + ABS(IGSTAmt) )//"Sales Invoice Header"."Amount to Customer"--CCIT
            {
            }
            column(ExternalDocumentNo_SalesInvoiceHeader; "Sales Invoice Header"."External Document No.")
            {
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

                //"Sales Invoice Line".Amount + ABS(CGSTAmt) + ABS(SGSTAmt) + ABS(IGSTAmt) 

                CLEAR(CGSTRate);
                CLEAR(CGSTAmt);
                CLEAR(GSTComponentCGST);
                CLEAR(SGSTRate);
                CLEAR(SGSTAmt);
                CLEAR(GSTComponentSGST);
                CLEAR(IGSTRate);
                CLEAR(IGSTAmt);
                CLEAR(GSTComponentIGST);

                SalesInvCrMemoLine.reset;
                SalesInvCrMemoLine.SetRange("Document No.", "Sales Invoice Header"."No.");
                SalesInvCrMemoLine.SetFilter(Type, '%1|%2', SalesInvCrMemoLine.Type::Item, SalesInvCrMemoLine.Type::"G/L Account");
                if SalesInvCrMemoLine.FindSet() then
                    //if (SalesInvCrMemoLine.Type = SalesInvCrMemoLine.Type::Item) and (SalesInvCrMemoLine.Type = SalesInvCrMemoLine.Type::"G/L Account") then begin
                    //if SalesInvCrMemoLine.FindFirst() then
                    repeat

                        GSTDetailLeger.RESET;
                        GSTDetailLeger.SETRANGE(GSTDetailLeger."Document No.", SalesInvCrMemoLine."Document No.");
                        GSTDetailLeger.SETRANGE(GSTDetailLeger."No.", SalesInvCrMemoLine."No.");
                        GSTDetailLeger.SETRANGE(GSTDetailLeger."Document Line No.", SalesInvCrMemoLine."Line No.");
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

                        AmountToCust := SalesInvCrMemoLine.Amount + ABS(CGSTAmt) + ABS(SGSTAmt) + ABS(IGSTAmt)
                        until SalesInvCrMemoLine.next = 0;
                //  end;
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
        CompanyInfo: Record "Company Information";
        Sno: Integer;
        PRE: Integer;
        Dimension_value: Record "Dimension Value";
        BRANCH_NAME: Text;
        SalesInvCrMemoLine: Record "Sales Cr.Memo Line";
        AmountToCust: Decimal;
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

