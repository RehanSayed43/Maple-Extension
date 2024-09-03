report 50015 "Invoice 1"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Invoice1.rdlc';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            column(CompInfoName; CompInfo.Name)
            {
            }
            column(CompInfoAdd; CompInfo.Address)
            {
            }
            column(CompInfoAdd2; CompInfo."Address 2")
            {
            }
            column(CompInfoCity; CompInfo.City)
            {
            }
            column(CompInfoPhoneNo; CompInfo."Phone No.")
            {
            }
            column(CompInfoFax; CompInfo."Fax No.")
            {
            }
            column(CompInfoVATRegNo; CompInfo."VAT Registration No.")
            {
            }
            column(CompInfoTIN; '')
            {
            }
            column(CompInfoCSTNo; CompInfo."C.S.T No.")
            {
            }
            column(CompInfoPAN; CompInfo."P.A.N. No.")
            {
            }
            column(CompInfoServiceTaxRegNo; '')
            {
            }
            column(VATeffeciveDt; CompInfo."VAT Effective Dt")
            {
            }
            column(CSTEffectiveDt; CompInfo."CST Effective Dt")
            {
            }
            column(CompInfoBankName; CompInfo."Bank Name")
            {
            }
            column(CompInfoBankBranchNo; CompInfo."Bank Branch No.")
            {
            }
            column(CompInfoBankAccNo; CompInfo."Bank Account No.")
            {
            }
            column(BankAdd; bankdetrec.Address)
            {
            }
            column(BankAdd2; bankdetrec."Address 2")
            {
            }
            column(BankCity; bankdetrec.City)
            {
            }
            column(bankIFSC; bankdetrec."IFSC Code")
            {
            }
            column(BankPost; bankdetrec."Post Code")
            {
            }
            column(LocName; LocationRec.Name)
            {
            }
            column(LocAdd; LocationRec.Address)
            {
            }
            column(LocAdd2; LocationRec."Address 2")
            {
            }
            column(LocCity; LocationRec.City)
            {
            }
            column(LocPhnNo; LocationRec."Phone No.")
            {
            }
            column(LocFax; LocationRec."Fax No.")
            {
            }
            column(LocPostCode; LocationRec."Post Code")
            {
            }
            column(LocCountry; LocationRec.County)
            {
            }
            column(LocEmail; LocationRec."E-Mail")
            {
            }
            column(LBT; LocationRec."LBT No.")
            {
            }
            column(EmployeeName; EmployeeRec.Name)
            {
            }
            column(VATDec1; "sales&rec"."VAT Declaration1")
            {
            }
            column(VATDec2; "sales&rec"."VAT Declaration2")
            {
            }
            column(VATDec3; "sales&rec"."VAT Declaration3")
            {
            }
            column(INsDec; "sales&rec"."Insurance Declaration")
            {
            }
            column(BuyersOrderNo_SalesInvoiceHeader; "Sales Invoice Header"."Buyer's Order No.")
            {
            }
            column(BuyersOrderDt_SalesInvoiceHeader; "Sales Invoice Header"."Buyer's Order Dt")
            {
            }
            column(No_SalesInvoiceHeader; "Sales Invoice Header"."No.")
            {
            }
            column(PostingDate_SalesInvoiceHeader; "Sales Invoice Header"."Posting Date")
            {
            }
            column(BilltoName_SalesInvoiceHeader; "Sales Invoice Header"."Bill-to Name")
            {
            }
            column(BilltoAddress_SalesInvoiceHeader; "Sales Invoice Header"."Bill-to Address")
            {
            }
            column(BilltoAddress2_SalesInvoiceHeader; "Sales Invoice Header"."Bill-to Address 2")
            {
            }
            column(BilltoCity_SalesInvoiceHeader; "Sales Invoice Header"."Bill-to City")
            {
            }
            column(BilltoContact_SalesInvoiceHeader; "Sales Invoice Header"."Bill-to Contact")
            {
            }
            column(ShiptoName_SalesInvoiceHeader; "Sales Invoice Header"."Ship-to Name")
            {
            }
            column(ShiptoAddress_SalesInvoiceHeader; "Sales Invoice Header"."Ship-to Address")
            {
            }
            column(ShiptoAddress2_SalesInvoiceHeader; "Sales Invoice Header"."Ship-to Address 2")
            {
            }
            column(ShiptoCity_SalesInvoiceHeader; "Sales Invoice Header"."Ship-to City")
            {
            }
            column(ShiptoContact_SalesInvoiceHeader; "Sales Invoice Header"."Ship-to Contact")
            {
            }
            column(SalespersonCode_SalesInvoiceHeader; "Sales Invoice Header"."Salesperson Code")
            {
            }
            column(AmounttoWord; AmounttoWord[1])
            {
            }
            column(AmounttoWord1; AmounttoWord[2])
            {
            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(No_SalesInvoiceLine; "Sales Invoice Line"."No.")
                {
                }
                column(Description_SalesInvoiceLine; "Sales Invoice Line".Description)
                {
                }
                column(UnitofMeasure_SalesInvoiceLine; "Sales Invoice Line"."Unit of Measure")
                {
                }
                column(Quantity_SalesInvoiceLine; "Sales Invoice Line".Quantity)
                {
                }
                column(UnitPrice_SalesInvoiceLine; "Sales Invoice Line"."Unit Price")
                {
                }
                column(Amount_SalesInvoiceLine; "Sales Invoice Line".Amount)
                {
                }
                column(SNo; Srno)
                {
                }
                column(SerialNo; "Sales Invoice Line"."Serial No.")
                {
                }
                column(Tax_SalesInvoiceLine; '')
                {
                }
                column(TaxAmount_SalesInvoiceLine; '')
                {
                }
                column(Servicetax; servtax)
                {
                }
                column(VAT_CST; "VAT/CST")
                {
                }
                column(AmountToCustomer_SalesInvoiceLine; "Sales Invoice Line"."Amount")
                {
                }
                column(ChargesToCustomer_SalesInvoiceLine; '')
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Srno := Srno + 1;

                    //Kartikey ++++++++++++

                    servtax := servtax;//+ "Service Tax SHE Cess Amount" + "Service Tax eCess Amount" + "Service Tax Amount";


                    "Tax Area Line".SETRANGE("Tax Area Line"."Tax Area", "Tax Area Code");
                    IF "Tax Area Line".FINDFIRST THEN
                        "Tax Juris".SETRANGE("Tax Juris".Code, "Tax Area Line"."Tax Jurisdiction Code");
                    IF "Tax Juris".FINDFIRST THEN
                        //  "VAT/CST" := FORMAT("Tax Juris"."Tax Type");
                        "VAT/CST" := FORMAT('');

                    // ------------
                end;
            }

            trigger OnAfterGetRecord()
            begin

                IF "Sales Invoice Header"."Location Code" <> '' THEN
                    LocationRec.GET("Sales Invoice Header"."Location Code");

                EmployeeRec.GET("Sales Invoice Header"."Salesperson Code");

                saleslinerec.RESET;
                //saleslinerec.SETRANGE(saleslinerec."Document Type","Sales Invoice Header"."Document Type");
                saleslinerec.SETRANGE(saleslinerec."Document No.", "Sales Invoice Header"."No.");
                IF saleslinerec.FINDFIRST THEN BEGIN
                    REPEAT
                        TotalAmount += saleslinerec."Amount";
                    UNTIL saleslinerec.NEXT = 0;
                END;

                CheckRep.InitTextVariable;
                CheckRep.FormatNoText(AmounttoWord, TotalAmount, "Sales Invoice Header"."Currency Code");
                //message('%1',AmounttoWord);

                //bankdetrec.GET(CompInfo."Bank Name");
            end;

            trigger OnPreDataItem()
            begin
                Srno := 0;
            end;
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

    labels
    {
    }

    trigger OnPreReport()
    begin
        CompInfo.GET;
        "sales&rec".GET;
    end;

    var
        CompInfo: Record 79;
        LocationRec: Record 14;
        Srno: Integer;
        EmployeeRec: Record 13;
        bankdetrec: Record 270;
        "sales&rec": Record 311;
        servtax: Decimal;
        "Tax Juris": Record 320;
        "VAT/CST": Text[100];
        "Tax Area Line": Record 319;
        CustRec: Record 18;
        CheckRep: Report Check;
        AmounttoWord: array[2] of Text[80];
        TotalAmount: Decimal;
        saleslinerec: Record 113;
}

