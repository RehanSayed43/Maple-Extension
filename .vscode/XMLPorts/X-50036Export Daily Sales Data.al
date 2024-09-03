xmlport 50036 "Export Daily Sales Data"
{
    Direction = Export;
    Encoding = UTF8;
    Format = Xml;
    FormatEvaluate = Legacy;

    schema
    {
        textelement(root)
        {
            tableelement("Sales Invoice Header"; "Sales Invoice Header")
            {
                XmlName = 'SalesInvoiceHeader';
                fieldelement(Location_Code; "Sales Invoice Header"."Location Code")
                {

                }
                fieldelement(Bill_No; "Sales Invoice Header"."No.")
                {
                }
                fieldelement(Bill_Dtae; "Sales Invoice Header"."Posting Date")
                {
                }
                textelement(Gross_Amount)
                {
                }
                textelement(Tax_Amount)
                {
                }
                textelement(Net_Amount)
                {
                }
                textelement(Txn_status)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CalculateSalesAmount();
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    local procedure CalculateSalesAmount()
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
        GAmt: Decimal;
        NAmt: Decimal;
        TAmt: Decimal;
        dtlGstLedger: Record "Detailed GST Ledger Entry";
    begin
        GAmt := 0;
        NAmt := 0;
        TAmt := 0;
        SalesInvoiceLine.RESET;
        SalesInvoiceLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
        SalesInvoiceLine.SETFILTER("No.", '<>%1', '');
        IF SalesInvoiceLine.FINDFIRST THEN BEGIN
            REPEAT
                GAmt := GAmt + SalesInvoiceLine."Line Amount";
                dtlGstLedger.Reset();
                dtlGstLedger.SetRange("Document No.", SalesInvoiceLine."Document No.");
                dtlGstLedger.SetRange("Document Line No.", SalesInvoiceLine."Line No.");
                if dtlGstLedger.FindFirst() then begin
                    repeat
                        TAmt := TAmt + dtlGstLedger."GST Amount";
                        if dtlGstLedger."GST Component Code" in ['CGST', 'IGST'] then
                            NAmt := NAmt + dtlGstLedger."GST Base Amount";
                    until dtlGstLedger.Next() = 0;
                end;
            // NAmt := NAmt + SalesInvoiceLine."Amount To Customer";    rahul
            // TAmt := TAmt + SalesInvoiceLine."Total GST Amount";      rahul
            UNTIL SalesInvoiceLine.NEXT = 0;
        END;
        Gross_Amount := FORMAT(ABS(NAmt + TAmt));
        Net_Amount := FORMAT(ABS(GAmt));
        Tax_Amount := FORMAT(ABS(TAmt));
        Txn_status := 'Sales';
    end;
}

