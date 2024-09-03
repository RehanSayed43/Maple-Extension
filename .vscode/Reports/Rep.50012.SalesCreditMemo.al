report 50012 "Sales Credit Memo"
{
    DefaultLayout = RDLC;
    RDLCLayout = './SalesCreditMemo.50012.rdlc';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            column(CompInfoName; CompInfo.Name)
            {
            }
            column(CompInfoPAN; CompInfo."P.A.N. No.")
            {
            }
            column(CompInfoTIN; '')
            // column(CompInfoTIN; CompInfo."T.I.N. No.")
            {
            }
            column(CinNo; CompInfo."CIN no")
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
            column(LocPhn; LocationRec."Phone No.")
            {
            }
            column(LocFAX; LocationRec."Fax No.")
            {
            }
            column(LocCountry; LocationRec.County)
            {
            }
            column(AppliestoDocNo_SalesCrMemoHeader; "Sales Cr.Memo Header"."Applies-to Doc. No.")
            {
            }
            column(No_SalesCrMemoHeader; "Sales Cr.Memo Header"."No.")
            {
            }
            column(BilltoCustomerNo_SalesCrMemoHeader; "Sales Cr.Memo Header"."Bill-to Customer No.")
            {
            }
            column(PostingDate_SalesCrMemoHeader; "Sales Cr.Memo Header"."Posting Date")
            {
            }
            column(CustName; CustRec.Name)
            {
            }
            column(CustAdd; CustRec.Address)
            {
            }
            column(CustAdd2; CustRec."Address 2")
            {
            }
            column(CustCiy; CustRec.City)
            {
            }
            column(CustPhn; CustRec."Phone No.")
            {
            }
            column(CustPost; CustRec."Post Code")
            {
            }
            column(CustLST; '')
            //column(CustLST; CustRec."L.S.T. No.")
            {
            }
            //column(CustCST; CustRec."C.S.T. No.")
            column(CustCST; '')
            {
            }
            column(CustPAN; CustRec."P.A.N. No.")
            {
            }
            column(CustTINl; '')
            //column(CustTINl; CustRec."T.I.N. No.")
            {
            }
            column(AmounttoWord; AmounttoWord[1])
            {
            }
            column(AmounttoWord1; AmounttoWord[2])
            {
            }//tk
            dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(ST_SalesCrMemoLine; "Sales Cr.Memo Line"."ST%")
                {
                }
                column(SNo; Srno)
                {
                }//tk
                column(No; "Sales Cr.Memo Line"."No.")
                {
                }
                column(Desc; "Sales Cr.Memo Line".Description)
                {
                }
                column(Amt; "Sales Cr.Memo Line".Amount)
                {
                }
                column(AmttoCust; "Sales Cr.Memo Line"."Amount")
                {
                }
                column(UnitofMeasure_SalesCrMemoLine; "Sales Cr.Memo Line".Quantity)
                {
                }
                column(ServiceTaxGroup_SalesCrMemoLine; '')
                {
                }
                column(ServiceTaxAmount_SalesCrMemoLine; '')
                {
                }//tk
                column(LineAmount_SalesCrMemoLine; "Sales Cr.Memo Line"."Line Amount")
                {
                }
                column(LineDiscountAmount_SalesCrMemoLine; "Sales Cr.Memo Line"."Line Discount Amount")
                {
                }
                // column(ChargesToCustomer_SalesCrMemoLine; "Sales Cr.Memo Line"."Charges To Customer")
                // {
                // }
                // column(totAmt; totAmt)
                // {
                // }
                // column(roundamt; roundamt)
                // {
                // }//tk

                trigger OnAfterGetRecord()
                begin
                    IF "Sales Cr.Memo Line"."No." <> '' THEN
                        Srno := Srno + 1;
                    IF "Sales Cr.Memo Line"."No." = '' THEN
                        CurrReport.SKIP;
                    /*
                   IF (("Sales Cr.Memo Line"."No." <>'512073') OR("Sales Cr.Memo Line"."No."<>'512073')) THEN BEGIN

                     totAmt+="Sales Cr.Memo Line".Amount+"Sales Cr.Memo Line"."Line Discount Amount";
                     //MESSAGE(FORMAT(totAmt));
                   END;
                    */
                    IF ("Sales Cr.Memo Line"."No." = '512040') OR ("Sales Cr.Memo Line"."No." = '512073') THEN BEGIN
                        roundamt += "Sales Cr.Memo Line"."Line Amount" + "Sales Cr.Memo Line"."Line Discount Amount";
                    END;

                end;

                trigger OnPreDataItem()
                begin
                    Srno := 0;
                    totAmt := 0;
                    roundamt := 0;
                end;
            }
            dataitem("Sales Comment Line"; "Sales Comment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                column(Comment_SalesCommentLine; "Sales Comment Line".Comment)
                {
                }
                column(roundamt1; totAmt)
                {
                }
            }
            // dataitem("Detailed Tax Entry";"Detailed Tax Entry")
            // {
            //     DataItemLink = "Document No."=FIELD("No.");
            //     DataItemTableView = SORTING ("Entry No.")
            //                         ORDER(Ascending)
            //                         WHERE ("Transaction Type"=FILTER(Sale),
            //                               "Document Type"=FILTER(Credit Memo));
            //     column(Tax_DetailedTaxEntry;"Detailed Tax Entry"."Tax %")
            //     {
            //     }
            //     column(TaxAmount_DetailedTaxEntry;"Detailed Tax Entry"."Tax Amount")
            //     {
            //     }
            //     column(TaxType_DetailedTaxEntry;"Detailed Tax Entry"."Tax Type")
            //     {
            //     }
            //     column(roundamt2;totAmt)
            //     {
            //     }
            // }

            trigger OnAfterGetRecord()
            begin
                CustRec.GET("Sales Cr.Memo Header"."Sell-to Customer No.");


                IF "Sales Cr.Memo Header"."Location Code" <> '' THEN
                    LocationRec.GET("Sales Cr.Memo Header"."Location Code");

                saleslinerec.RESET;
                //saleslinerec.SETRANGE(saleslinerec."Document Type","Sales Invoice Header"."Document Type");
                saleslinerec.SETRANGE(saleslinerec."Document No.", "Sales Cr.Memo Header"."No.");
                IF saleslinerec.FINDFIRST THEN BEGIN
                    REPEAT
                        TotalAmount += saleslinerec."Amount";
                    UNTIL saleslinerec.NEXT = 0;
                END;

                CheckRep.InitTextVariable;
                CheckRep.FormatNoText(AmounttoWord, TotalAmount, "Sales Cr.Memo Header"."Currency Code");
                //message('%1',AmounttoWord);
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
    end;

    var
        Srno: Integer;
        CompInfo: Record 79;
        LocationRec: Record 14;
        CustRec: Record 18;
        CheckRep: Report Check;
        AmounttoWord: array[2] of Text[80];
        TotalAmount: Decimal;
        saleslinerec: Record 115;
        // RecDetailedTaxEntry: Record 16522;
        totAmt: Decimal;
        roundamt: Decimal;
}

