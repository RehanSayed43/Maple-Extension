report 50013 "Sales Debit Note"
{
    DefaultLayout = RDLC;
    RDLCLayout = './SalesDebitNote.rdlc';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            column(CompInfoName; CompInfo.Name)
            {
            }
            column(CompInfoPAN; CompInfo."P.A.N. No.")
            {
            }
            // column(CompInfoTIN; CompInfo."T.I.N. No.")
            column(CompInfoTIN; '')
            {
            }//tk
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
            column(No_SalesCrMemoHeader; "Sales Invoice Header"."No.")
            {
            }
            column(BilltoCustomerNo_SalesCrMemoHeader; "Sales Invoice Header"."Bill-to Customer No.")
            {
            }
            column(PostingDate_SalesCrMemoHeader; "Sales Invoice Header"."Posting Date")
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
            // column(CustLST; CustRec."L.S.T. No.")
            column(CustLST; '')
            {
            }
            //column(CustCST; CustRec."C.S.T. No.")
            column(CustCST; '')
            {
            }
            column(CustPAN; CustRec."P.A.N. No.")
            {
            }
            //column(CustTIN; CustRec."T.I.N. No.")
            column(CustTIN; '')
            {
            }
            column(AmountToWord; AmounttoWord[1])
            {
            }
            column(AmountToWord1; AmounttoWord[2])
            {
            }//tk
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(SNo; Srno)
                {
                }//tk
                column(No; "Sales Invoice Line"."No.")
                {
                }
                column(Desc; "Sales Invoice Line".Description)
                {
                }
                column(Amt; "Sales Invoice Line".Amount)
                {
                }
                column(AmttoCust; "Sales Invoice Line"."Amount")
                {
                }//tk
                dataitem("Sales Comment Line"; "Sales Comment Line")
                {
                    DataItemLink = "No." = FIELD("Document No."),
                                   "Line No." = FIELD("Line No.");
                    column(Comment_SalesCommentLine; "Sales Comment Line".Comment)
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    Srno := Srno + 1;
                end;

                trigger OnPreDataItem()
                begin
                    Srno := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CustRec.GET("Sales Invoice Header"."Sell-to Customer No.");


                IF "Sales Invoice Header"."Location Code" <> '' THEN
                    LocationRec.GET("Sales Invoice Header"."Location Code");

                //CheckRep.InitTextVariable;
                //CheckRep.FormatNoText(AmounttoWord,"Sales Invoice Header"."Amount to Customer",'');

                saleslinerec.RESET;
                //saleslinerec.SETRANGE(saleslinerec."Document Type","Sales Invoice Header"."Document Type");
                saleslinerec.SETRANGE(saleslinerec."Document No.", "Sales Invoice Header"."No.");
                IF saleslinerec.FINDFIRST THEN BEGIN
                    REPEAT
                        TotalAmount += saleslinerec.Amount;
                    UNTIL saleslinerec.NEXT = 0;
                END;

                CheckRep.InitTextVariable;
                CheckRep.FormatNoText(AmounttoWord, TotalAmount, "Sales Invoice Header"."Currency Code");
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
        CompInfo: Record "Company Information";
        LocationRec: Record Location;
        CustRec: Record Customer;

        CheckRep: Report Check;
        AmounttoWord: array[2] of Text[80];
        TotalAmount: Decimal;
        saleslinerec: Record 113;
}

