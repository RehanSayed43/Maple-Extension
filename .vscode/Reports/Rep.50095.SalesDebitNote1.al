report 50095 "Sales Debit Note 1"
{
    DefaultLayout = RDLC;
    RDLCLayout = './SalesDebitNote1.rdlc';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
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
            column(LocAdd2; "Purch. Cr. Memo Hdr."."Buy-from Address 2")
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
            column(No_SalesCrMemoHeader; "Purch. Cr. Memo Hdr."."No.")
            {
            }
            column(BilltoCustomerNo_SalesCrMemoHeader; "Purch. Cr. Memo Hdr."."Pay-to Vendor No.")
            {
            }
            column(PostingDate_SalesCrMemoHeader; "Purch. Cr. Memo Hdr."."Posting Date")
            {
            }
            column(CustName; CustRec.Name)
            {
            }
            column(CustAdd; "Purch. Cr. Memo Hdr."."Buy-from Address")
            {
            }
            column(CustAdd2; CustRec."Address 2")
            {
            }
            column(CustCiy; "Purch. Cr. Memo Hdr."."Buy-from City")
            {
            }
            column(CustPhn; CustRec."Phone No.")
            {
            }
            column(CustPost; "Purch. Cr. Memo Hdr."."Buy-from Post Code")
            {
            }
            //column(CustLST; CustRec."L.S.T. No.")
            column(CustLST; '')
            {
            }
            //  column(CustCST; CustRec."C.S.T. No.")
            column(CustCST; '')
            {
            }
            column(CustPAN; CustRec."P.A.N. No.")
            {
            }
            column(CustTIN; '')
            //column(CustTIN; CustRec."T.I.N. No.")
            {
            }
            column(TotalAmount; TotalAmount)
            {
            }
            column(AmountToWord; AmounttoWord[1])
            {
            }
            column(AmountToWord1; AmounttoWord[2])
            {
            }//tk
            column(VendorCrMemoNo_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."Vendor Cr. Memo No.")
            {
            }
            dataitem("Purch. Cr. Memo Line"; "Purch. Cr. Memo Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(SNo; Srno)
                {
                }//tk
                column(No; "Purch. Cr. Memo Line"."No.")
                {
                }
                column(Desc; "Purch. Cr. Memo Line".Description)
                {
                }
                column(Amt; "Purch. Cr. Memo Line".Amount)
                {
                }
                column(AmttoCust; "Purch. Cr. Memo Line"."Amount")
                {
                }
                column(Quantity_PurchCrMemoLine; "Purch. Cr. Memo Line".Quantity)
                {
                }
                column(Vendor_part_code; RecItem."Vendor Part Code Long")
                {
                }
                column(AmountIncludingTax; AmountIncludingTax)
                {
                }//tk
                column(Qty; Qty)
                {
                }//tk
                dataitem("Purch. Comment Line"; "Purch. Comment Line")
                {
                    DataItemLink = "No." = FIELD("Document No."),
                                   "Line No." = FIELD("Line No.");
                    DataItemTableView = WHERE("Document Type" = FILTER("Posted Credit Memo"));
                    column(Comment_SalesCommentLine; "Purch. Comment Line".Comment)
                    {
                    }
                }
                dataitem("Item Ledger Entry"; "Item Ledger Entry")
                {
                    DataItemLink = "Document No." = FIELD("Document No."),
                                   "Item No." = FIELD("No.");
                    column(SerialNo_ItemLedgerEntry; "Item Ledger Entry"."Serial No.")
                    {
                    }
                    column(IMEINo_ItemLedgerEntry; "Item Ledger Entry"."IMEI No.")
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    IF "Purch. Cr. Memo Line"."No." = '' THEN
                        CurrReport.SKIP;
                    Srno := Srno + 1;
                    RecItem.RESET;
                    RecItem.GET("Purch. Cr. Memo Line"."No.");

                    //win316++
                    Qty := 0;
                    AmountIncludingTax := 0;
                    RecPurCrMemoLine.RESET;
                    RecPurCrMemoLine.SETRANGE(RecPurCrMemoLine."Document No.", "Purch. Cr. Memo Line"."Document No.");
                    RecPurCrMemoLine.SETRANGE(RecPurCrMemoLine."No.", "Purch. Cr. Memo Line"."No.");
                    IF RecPurCrMemoLine.FINDSET THEN BEGIN
                        REPEAT
                            Qty += RecPurCrMemoLine.Quantity;
                            // AmountIncludingTax+=RecPurCrMemoLine."Amount Including Tax";
                            AmountIncludingTax += RecPurCrMemoLine."Amount Including VAT";
                        UNTIL RecPurCrMemoLine.NEXT = 0;
                    END;

                    //win316--
                end;

                trigger OnPreDataItem()
                begin
                    Srno := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CustRec.GET("Purch. Cr. Memo Hdr."."Buy-from Vendor No.");


                IF "Purch. Cr. Memo Hdr."."Location Code" <> '' THEN
                    LocationRec.GET("Purch. Cr. Memo Hdr."."Location Code");

                //CheckRep.InitTextVariable;
                //CheckRep.FormatNoText(AmounttoWord,"Sales Invoice Header"."Amount to Customer",'');

                saleslinerec.RESET;
                //saleslinerec.SETRANGE(saleslinerec."Document Type","Sales Invoice Header"."Document Type");
                saleslinerec.SETRANGE(saleslinerec."Document No.", "Purch. Cr. Memo Hdr."."No.");
                IF saleslinerec.FINDFIRST THEN BEGIN
                    REPEAT
                        TotalAmount += saleslinerec."Amount";
                    UNTIL saleslinerec.NEXT = 0;
                END;

                CheckRep.InitTextVariable;
                CheckRep.FormatNoText(AmounttoWord, TotalAmount, "Purch. Cr. Memo Hdr."."Currency Code");
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
        CustRec: Record 23;
        CheckRep: Report 1401;
        AmounttoWord: array[2] of Text[80];
        TotalAmount: Decimal;
        saleslinerec: Record 125;
        RecItem: Record 27;
        Qty: Decimal;
        RecPurCrMemoLine: Record 125;
        AmountIncludingTax: Decimal;
}

