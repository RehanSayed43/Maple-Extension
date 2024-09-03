report 50014 "Purchase Order"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PurchaseOrder.rdlc';
    ApplicationArea = FixedAsset;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            RequestFilterFields = "No.";
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
            column(CompInfoPhnNo; CompInfo."Phone No.")
            {
            }
            column(CompInfoFAX; CompInfo."Fax No.")
            {
            }
            column(CompInfoPic; CompInfo.Picture)
            {
            }
            column(CompInfoPostCode; CompInfo."Post Code")
            {
            }
            column(CompInfoTIN; '')
            {
            }
            column(CompInfoCST; CompInfo."C.S.T No.")
            {
            }
            column(CompInfoPAN; CompInfo."P.A.N. No.")
            {
            }
            column(CompInfoServiceTax; '')
            {
            }
            column(CompInfoVATReg; CompInfo."VAT Registration No.")
            {
            }
            column(CompInfoCountryCode; CompInfo."Country/Region Code")
            {
            }
            column(LocationName; LocationRec.Name)
            {
            }
            column(LocationAdd; LocationRec.Address)
            {
            }
            column(LocationAdd2; LocationRec."Address 2")
            {
            }
            column(LocationCity; LocationRec.City)
            {
            }
            column(LocationPhnNo; LocationRec."Phone No.")
            {
            }
            column(LocationFAX; LocationRec."Fax No.")
            {
            }
            column(LocationPostCode; LocationRec."Post Code")
            {
            }
            column(LocationCountry; LocationRec.County)
            {
            }
            column(LocationCST; '')
            {
            }
            column(LocationTIN; '')
            {
            }
            column(LocationServTax; '')
            {
            }
            column(LocationLST; '')
            {
            }
            column(LocationLBT; LocationRec."LBT No.")
            {
            }
            column(VendorName; VendorRec.Name)
            {
            }
            column(VendorAdd; VendorRec.Address)
            {
            }
            column(VendorAdd2; VendorRec."Address 2")
            {
            }
            column(VendorCity; VendorRec.City)
            {
            }
            column(VendorPhnNo; VendorRec."Phone No.")
            {
            }
            column(VendorPostCode; VendorRec."Post Code")
            {
            }
            column(VendorCountry; VendorRec.County)
            {
            }
            column(VendorTIN; '')
            {
            }
            column(VendorCST; '')
            {
            }
            column(VendorPAN; VendorRec."P.A.N. No.")
            {
            }
            column(VendorVAT; VendorRec."VAT Registration No.")
            {
            }
            column(VendorServiceTax; '')
            {
            }
            column(BuyfromVendorNo_PurchaseHeader; "Purchase Header"."Buy-from Vendor No.")
            {
            }
            column(No_PurchaseHeader; "Purchase Header"."No.")
            {
            }
            column(OrderDate_PurchaseHeader; "Purchase Header"."Order Date")
            {
            }
            column(POValidityDate_PurchaseHeader; "Purchase Header"."PO Validity Date")
            {
            }
            column(ExpectedReceiptDate_PurchaseHeader; "Purchase Header"."Expected Receipt Date")
            {
            }
            column(PaymentTermsCode_PurchaseHeader; "Purchase Header"."Payment Terms Code")
            {
            }
            column(FormCode_PurchaseHeader; '')
            {
            }
            column(Remarks; "Purchase Header"."Remarks Vendor")
            {
            }
            column(AmounttoWord; AmounttoWord[1])
            {
            }
            column(AmounttoWord1; AmounttoWord[2])
            {
            }
            column(ShipNm; "Purchase Header"."Ship-to Name")
            {
            }
            column(ShipAddr; "Purchase Header"."Ship-to Address")
            {
            }
            column(ShipAddr2; "Purchase Header"."Ship-to Address 2")
            {
            }
            column(ShipCity; "Purchase Header"."Ship-to City")
            {
            }
            column(ShipToCont; "Purchase Header"."Ship-to Contact")
            {
            }
            column(ShipPostCd; "Purchase Header"."Ship-to Post Code")
            {
            }
            column(SHipCountry; "Purchase Header"."Ship-to County")
            {
            }
            column(AmountToVend; "Purchase Header"."Amount")
            {
            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                column(SNo; Srno)
                {
                }
                column(No_PurchaseLine; "Purchase Line"."No.")
                {
                }
                column(ExpectedReceiptDate_PurchaseLine; "Purchase Line"."Expected Receipt Date")
                {
                }
                column(Description_PurchaseLine; "Purchase Line".Description)
                {
                }
                column(UnitofMeasure_PurchaseLine; "Purchase Line"."Unit of Measure")
                {
                }
                column(Quantity_PurchaseLine; "Purchase Line".Quantity)
                {
                }
                column(Amount_PurchaseLine; "Purchase Line".Amount)
                {
                }
                column(UnitPriceLCY_PurchaseLine; "Purchase Line"."Unit Price (LCY)")
                {
                }
                column(DirectUnitCost_PurchaseLine; "Purchase Line"."Direct Unit Cost")
                {
                }
                column(VendorItemNo_PurchaseLine; "Purchase Line"."Vendor Part Code Long")
                {
                }
                column(TaxAmount_PurchaseLine; '')
                {
                }
                column(VAT_CST; "VAT/CST")
                {
                }
                column(ChargesToVendor_PurchaseLine; '')
                {
                }
                column(ExciseAmount_PurchaseLine; '')
                {
                }
                column(ServiceTaxAmount_PurchaseLine; '')
                {
                }
                column(AmountToVendor_PurchaseLine; "Purchase Line"."Amount")
                {
                }
                column(CurrCode; "Purchase Line"."Currency Code")
                {
                }
                column(servtax; servtax)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    Srno := Srno + 1;

                    //Kartikey ++++++++++++


                    servtax := servtax;// + "Service Tax SHE Cess Amount" + "Service Tax eCess Amount" + "Service Tax Amount";


                    "Tax Area Line".SETRANGE("Tax Area Line"."Tax Area", "Tax Area Code");
                    IF "Tax Area Line".FINDFIRST THEN
                        "Tax Juris".SETRANGE("Tax Juris".Code, "Tax Area Line"."Tax Jurisdiction Code");
                    IF "Tax Juris".FINDFIRST THEN
                        // "VAT/CST" := FORMAT("Tax Juris"."Tax Type");
                        "VAT/CST" := FORMAT('');

                    // ------------
                end;
            }
            dataitem("Purch. Comment Line"; "Purch. Comment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                column(Comments; "Purch. Comment Line".Comment)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                VendorRec.GET("Purchase Header"."Buy-from Vendor No.");

                IF "Purchase Header"."Location Code" <> '' THEN
                    LocationRec.GET("Purchase Header"."Location Code");

                purchaselinerec.RESET;
                //saleslinerec.SETRANGE(saleslinerec."Document Type","Sales Invoice Header"."Document Type");
                purchaselinerec.SETRANGE(purchaselinerec."Document No.", "Purchase Header"."No.");
                IF purchaselinerec.FINDFIRST THEN BEGIN
                    REPEAT
                        TotalAmount += purchaselinerec."Amount";
                    UNTIL purchaselinerec.NEXT = 0;
                END;

                //CheckRep.InitTextVariable;
                //CheckRep.FormatNoText(AmounttoWord,TotalAmount,GenJNLLine."Currency Code");   //"Purchase Header"."Currency Code"
                //message('%1',AmounttoWord);

                GLSETUP.GET;
                CheckRep.InitTextVariable;
                IF "Purchase Header"."Currency Code" = '' THEN
                //259
                BEGIN
                    IF GLSETUP."LCY Code" = 'INR' THEN
                        CheckRep.FormatNoText(AmounttoWord, TotalAmount, '')
                    ELSE
                        CheckRep.FormatNoText(AmounttoWord, TotalAmount, GLSETUP."LCY Code");
                END
                //259
                //CheckRep.FormatNoText(AmounttoWord,TotalAmount,GLSETUP."LCY Code")
                ELSE
                    CheckRep.FormatNoText(AmounttoWord, TotalAmount, "Purchase Header"."Currency Code");
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
        CompInfo.CALCFIELDS(CompInfo.Picture);
    end;

    var
        CompInfo: Record 79;
        LocationRec: Record 14;
        Srno: Integer;
        VendorRec: Record 23;
        CheckRep: Report Check;
        AmounttoWord: array[2] of Text[250];
        TotalAmount: Decimal;
        purchaselinerec: Record 39;
        servtax: Decimal;
        "Tax Juris": Record 320;
        "VAT/CST": Text[100];
        "Tax Area Line": Record 319;
        GenJNLLine: Record 81;
        GLSETUP: Record 98;
}

