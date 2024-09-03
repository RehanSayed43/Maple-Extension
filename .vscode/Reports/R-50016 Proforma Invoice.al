report 50016 "Proforma Invoice"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Proforma Invoice.rdl';
    PreviewMode = PrintLayout;
    ApplicationArea = FixedAsset;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                ORDER(Ascending)
                                WHERE("Document Type" = CONST(Order));
            PrintOnlyIfDetail = false;
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
            column(CompInfoPhoneNo; CompInfo."Phone No.")
            {
            }
            column(CompInfoFax; CompInfo."Fax No.")
            {
            }
            column(CompInfoVATRegNo; CompInfo."VAT Registration No.")
            {
            }
            // column(CompInfoTIN; CompInfo."T.I.N. No.")
            // {
            // }
            // column(CompInfoCSTNo; CompInfo."C.S.T No.")
            // {
            // }
            column(CompInfoPAN; CompInfo."P.A.N. No.")
            {
            }
            // column(CompInfoServiceTaxRegNo; CompInfo."Service Tax Registration No.")
            // {
            // }
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
            column(BankNm; BankNm)
            {
            }
            column(BankAddr; BankAdd)
            {
            }
            column(BankAddr2; BankAdd2)
            {
            }
            column(BankCty; BankCity)
            {
            }
            column(BankPinCode; BankPinCode)
            {
            }
            column(BankIFSCCd; BankIFSC)
            {
            }
            column(BankAccntNo; BankAccntNo)
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
            column(BuyersOrderNo_SalesInvoiceHeader; "Sales Header"."Buyer's Order No.")
            {
            }
            column(BuyersOrderDt_SalesInvoiceHeader; "Sales Header"."Buyer's Order Dt")
            {
            }
            column(No_SalesInvoiceHeader; "Sales Header"."No.")
            {
            }
            column(PostingDate_SalesInvoiceHeader; "Sales Header"."Posting Date")
            {
            }
            column(BilltoName_SalesInvoiceHeader; "Sales Header"."Bill-to Name")
            {
            }
            column(BilltoAddress_SalesInvoiceHeader; "Sales Header"."Bill-to Address")
            {
            }
            column(BilltoAddress2_SalesInvoiceHeader; "Sales Header"."Bill-to Address 2")
            {
            }
            column(BilltoCity_SalesInvoiceHeader; "Sales Header"."Bill-to City")
            {
            }
            column(BilltoContact_SalesInvoiceHeader; "Sales Header"."Bill-to Contact")
            {
            }
            column(BillToPostCode; "Sales Header"."Bill-to Post Code")
            {
            }
            column(ShiptoName_SalesInvoiceHeader; "Sales Header"."Ship-to Name")
            {
            }
            column(ShiptoAddress_SalesInvoiceHeader; "Sales Header"."Ship-to Address")
            {
            }
            column(ShiptoAddress2_SalesInvoiceHeader; "Sales Header"."Ship-to Address 2")
            {
            }
            column(ShiptoCity_SalesInvoiceHeader; "Sales Header"."Ship-to City")
            {
            }
            column(ShiptoContact_SalesInvoiceHeader; "Sales Header"."Ship-to Contact")
            {
            }
            column(ShipToCode; "Sales Header"."Ship-to Post Code")
            {
            }
            column(PromoCd; "Sales Header"."Promo Code")
            {
            }
            column(DispDoc; "Sales Header"."Dispatch Doc. No.")
            {
            }
            column(DispThru; "Sales Header"."Dispatch Through")
            {
            }
            column(SalespersonCode_SalesInvoiceHeader; "Sales Header"."Salesperson Code")
            {
            }
            column(AmounttoWord; AmounttoWord[1])
            {
            }
            column(AmounttoWord1; AmounttoWord[2])
            {
            }
            column(DelNote; "Sales Header"."Delivery Note")
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")
                                    ORDER(Ascending);
                column(totalamt; totalamt)
                {
                }
                column(venditemcode; venditemcode)
                {
                }
                column(Srial_No; "Sales Line"."Item Serial No.")
                {
                }
                column(IMEI_No; "Sales Line"."IMEI No.")
                {
                }
                column(Discamt; Discamt)
                {
                }
                column(No_SalesInvoiceLine; "Sales Line"."No.")
                {
                }
                column(LineDiscAmt; "Sales Line"."Line Discount Amount")
                {
                }
                column(Description_SalesInvoiceLine; "Sales Line".Description)
                {
                }
                column(UnitofMeasure_SalesInvoiceLine; "Sales Line"."Unit of Measure")
                {
                }
                column(Quantity_SalesInvoiceLine; "Sales Line".Quantity)
                {
                }
                column(UnitPrice_SalesInvoiceLine; "Sales Line"."Unit Price")
                {
                }
                column(Amount_SalesInvoiceLine; "Sales Line".Amount)
                {
                }
                column(SNo; Srno)
                {
                }
                // column(Tax_SalesInvoiceLine;"Sales Line"."Tax %")
                // {
                // }
                // column(TaxAmount_SalesInvoiceLine;"Sales Line"."Tax Amount")
                // {
                // }
                column(Servicetax; servtax)
                {
                }
                column(VAT_CST; "VAT/CST")
                {
                }
                // column(AmountToCustomer_SalesInvoiceLine;"Sales Line"."Amount To Customer")
                // {
                // }
                // column(ChargesToCustomer_SalesInvoiceLine;"Sales Line"."Charges To Customer")
                // {
                // }
                column(comments; comments)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    /*
                    comments:='';
                    reccomment.RESET;
                    reccomment.SETFILTER(reccomment."No.","Sales Line"."Document No.");
                    reccomment.SETRANGE(reccomment."Line No.",lineno);
                    IF reccomment.FINDFIRST THEN
                    BEGIN
                    //repeat
                    comments:=reccomment.Comment;
                    //until reccomment.NEXT=0;
                    END;
                    lineno:=lineno+10000;


                    venditemcode:='';
                    itemrec.RESET;
                    itemrec.SETFILTER(itemrec."No.","Sales Line"."No.");
                    IF itemrec.FINDFIRST THEN
                    venditemcode:=itemrec."Vendor Item No.";



                    Srno:=Srno+1;
                    //totalamt:="Sales Invoice Line".Quantity * "Sales Invoice Line"."Unit Price";
                    totalamt:="Sales Line"."Line Amount";
                    //Kartikey ++++++++++++
                    servtax:=servtax+"Service Tax SHE Cess Amount"+"Service Tax eCess Amount"+ "Service Tax Amount";


                    "Tax Area Line".SETRANGE("Tax Area Line"."Tax Area","Tax Area Code");
                      IF "Tax Area Line".FINDFIRST THEN
                      "Tax Juris".SETRANGE("Tax Juris".Code,"Tax Area Line"."Tax Jurisdiction Code");
                        IF "Tax Juris".FINDFIRST THEN
                         "VAT/CST":=FORMAT("Tax Juris"."Tax Type");

                    // ------------
                    IF  "VAT/CST"='VAT' THEN
                    IF vatperc1=0 THEN
                    vatperc1:="Sales Line"."Tax %";

                    IF  "VAT/CST"='CST' THEN
                    IF cstperc1=0 THEN
                    cstperc1:="Sales Line"."Tax %";


                    IF  "VAT/CST"='VAT' THEN
                    IF "Sales Line"."Tax %"=vatperc1 THEN
                    BEGIN
                    vatperc1:="Sales Line"."Tax %";
                    vat1:='VAT';
                    vatamt1+="Sales Line"."Tax Amount";
                    END;

                    IF  "VAT/CST"='VAT' THEN
                    IF "Sales Line"."Tax %"<>vatperc1 THEN
                    BEGIN
                    vat2:='VAT';
                    vatperc2:="Sales Line"."Tax %";
                    //MESSAGE('%1',vatperc2);
                    vatamt2+="Sales Line"."Tax Amount";
                    END;

                    IF  "VAT/CST"='VAT' THEN
                    IF ("Sales Line"."Tax %"<>vatperc1) AND ("Sales Line"."Tax %"<>vatperc2)  THEN
                    BEGIN
                    vat3:='VAT';
                    vatperc3:="Sales Line"."Tax %";
                    //MESSAGE('%1',vatperc2);
                    vatamt3+="Sales Line"."Tax Amount";
                    END;


                    IF  "VAT/CST"='CST' THEN
                    IF "Sales Line"."Tax %"=cstperc1 THEN
                    BEGIN
                    cstperc1:="Sales Line"."Tax %";
                    cst1:='CST';
                    cstamt1+="Sales Line"."Tax Amount";
                    END;

                    IF  "VAT/CST"='CST' THEN
                    IF "Sales Line"."Tax %"<>cstperc1 THEN
                    BEGIN
                    cst2:='CST';
                    cstperc2:="Sales Line"."Tax %";
                    cstamt2+="Sales Line"."Tax Amount";
                    END;

                    IF  "VAT/CST"='CST' THEN
                    IF ("Sales Line"."Tax %"<>cstperc1) AND ("Sales Line"."Tax %"<>cstperc2) THEN
                    BEGIN
                    cst3:='CST';
                    cstperc3:="Sales Line"."Tax %";
                    cstamt3+="Sales Line"."Tax Amount";
                    END;

                    Discamt+="Sales Line"."Line Discount Amount";
                    */
                end;

                trigger OnPreDataItem()
                begin
                    LinesCount := "Sales Line".COUNT;
                    Srno := 0;
                    totalamt := 0;
                    salesinvHdr.RESET;
                    salesinvHdr.SETFILTER(salesinvHdr."No.", "Sales Header"."No.");
                    IF salesinvHdr.FINDFIRST THEN
                        IF salesinvHdr."Ref. Invoice No." <> '' THEN
                            "Sales Line".SETFILTER("Sales Line"."No.", '310008');

                    lineno := 10000;
                end;
            }
            dataitem(Integer; Integer)
            {
                column(Number; Integer.Number)
                {
                }
                column(vatamt1; vatamt1)
                {
                }
                column(vat1; vat1)
                {
                }
                column(vat2; vat2)
                {
                }
                column(vat3; vat3)
                {
                }
                column(cst1; cst1)
                {
                }
                column(cst2; cst2)
                {
                }
                column(cst3; cst3)
                {
                }
                column(vatamt2; vatamt2)
                {
                }
                column(cstamt1; cstamt1)
                {
                }
                column(cstamt2; cstamt2)
                {
                }
                column(vatamt3; vatamt3)
                {
                }
                column(cstamt3; cstamt3)
                {
                }
                column(vatperc1; vatperc1)
                {
                }
                column(vatperc2; vatperc2)
                {
                }
                column(vatperc3; vatperc3)
                {
                }
                column(cstperc1; cstperc1)
                {
                }
                column(cstperc2; cstperc2)
                {
                }
                column(cstperc3; cstperc3)
                {
                }

                trigger OnPreDataItem()
                begin

                    IF LinesCount <= 7 THEN
                        IF (LinesCount MOD MaxLines > 0) THEN BEGIN
                            CalLin := MaxLines - (LinesCount MOD MaxLines);
                            //CalLin :=(LinesCount MOD MaxLines);
                            Integer.SETRANGE(Number, 1, CalLin);
                        END
                        ELSE
                            Integer.SETRANGE(Number, 1, 1);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                LinesCount := 0;
                IF "Sales Header"."Location Code" <> '' THEN
                    LocationRec.GET("Sales Header"."Location Code");
                IF "Sales Header"."Salesperson Code" <> '' THEN
                    EmployeeRec.GET("Sales Header"."Salesperson Code");

                saleslinerec.RESET;
                //saleslinerec.SETRANGE(saleslinerec."Document Type","Sales Invoice Header"."Document Type");
                saleslinerec.SETRANGE(saleslinerec."Document No.", "Sales Header"."No.");
                IF saleslinerec.FINDFIRST THEN BEGIN
                    REPEAT
                    //    TotalAmount += saleslinerec."Amount To Customer";
                    UNTIL saleslinerec.NEXT = 0;
                END;

                CheckRep.InitTextVariable;
                CheckRep.FormatNoText(AmounttoWord, TotalAmount, "Sales Header"."Currency Code");
                //message('%1',AmounttoWord);

                //bankdetrec.GET(CompInfo."Bank Name");
                ItemTrack("Sales Line");
            end;

            trigger OnPreDataItem()
            begin
                vatamt1 := 0;
                vatamt2 := 0;
                cstamt1 := 0;
                cstamt2 := 0;
                vatamt3 := 0;
                cstamt3 := 0;
                vatperc1 := 0;
                vatperc2 := 0;
                vatperc3 := 0;
                cstperc1 := 0;
                cstperc2 := 0;
                cstperc3 := 0;
                vat1 := '';
                vat2 := '';
                vat3 := '';
                cst1 := '';
                cst2 := '';
                cst3 := '';
                Discamt := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("BANK NAME"; BANKNAME)
                {
                    TableRelation = "Bank Account";
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
        MaxLines := 7;
        BankNm := '';
        BankAdd := '';
        BankAdd2 := '';
        BankCity := '';
        BankPinCode := '';
        BankIFSC := '';
        BankAccntNo := '';

        CompInfo.GET;
        "sales&rec".GET;

        IF BANKNAME <> '' THEN BEGIN
            bankdetrec.GET(CompInfo."Bank Code");
            BankNm := bankdetrec.Name;
            BankAdd := bankdetrec.Address;
            BankAdd2 := bankdetrec."Address 2";
            BankCity := bankdetrec.City;
            BankPinCode := bankdetrec."Post Code";
            BankIFSC := bankdetrec."IFSC Code";
            BankAccntNo := bankdetrec."Bank Account No.";
        END;

        IF BANKNAME = '' THEN BEGIN
            bankdetrec.GET(CompInfo."Bank Code");
            BankNm := bankdetrec.Name;
            BankAdd := bankdetrec.Address;
            BankAdd2 := bankdetrec."Address 2";
            BankCity := bankdetrec.City;
            BankPinCode := bankdetrec."Post Code";
            BankIFSC := bankdetrec."IFSC Code";
            BankAccntNo := bankdetrec."Bank Account No.";
        END;
        //ELSE
        //bankdetrec.FINDFIRST;

        //ERROR('Bank not Selected');
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
        CheckRep: Report 1401;
        AmounttoWord: array[2] of Text[80];
        TotalAmount: Decimal;
        saleslinerec: Record 37;
        BANKNAME: Text[30];
        BankNm: Text[250];
        BankAdd: Text[250];
        BankAdd2: Text[250];
        BankCity: Text[250];
        BankPinCode: Code[30];
        BankIFSC: Code[30];
        BankAccntNo: Code[30];
        bankdetrec1: Record 270;
        vatamt1: Decimal;
        vatamt2: Decimal;
        cstamt1: Decimal;
        cstamt2: Decimal;
        vatamt3: Decimal;
        cstamt3: Decimal;
        vatperc1: Decimal;
        vatperc2: Decimal;
        vatperc3: Decimal;
        cstperc1: Decimal;
        cstperc2: Decimal;
        cstperc3: Decimal;
        vat1: Text[20];
        vat2: Text[20];
        vat3: Text[20];
        cst1: Text[20];
        cst2: Text[20];
        cst3: Text[20];
        Discamt: Decimal;
        totalamt: Decimal;
        salesinvHdr: Record 36;
        itemrec: Record 27;
        venditemcode: Code[30];
        MaxLines: Integer;
        LinesCount: Integer;
        CalLin: Integer;
        reccomment: Record 44;
        comments: Text[1024];
        lineno: Integer;
        ReservEntry: Record 337;
        imeino: Code[30];
        srlno: Code[30];


    procedure ItemTrack(var SalesLine: Record 37)
    begin
        ReservEntry.SETFILTER("Source ID", '%1', SalesLine."Document No.");
        ReservEntry.SETFILTER("Source Ref. No.", '%1', SalesLine."Line No.");
        ReservEntry.SETFILTER("Source Type", '%1', DATABASE::"Sales Line");
        ReservEntry.SETFILTER("Source Subtype", '%1', SalesLine."Document Type");
        ReservEntry.SETRANGE("Source Batch Name", '');
        ReservEntry.SETRANGE("Source Prod. Order Line", 0);
        IF ReservEntry.FINDFIRST THEN BEGIN
            Message('Updated');
            SalesLine."Item Serial No." := ReservEntry."Serial No.";
            SalesLine."IMEI No." := ReservEntry."IMEI No.";
            //"Unit Price Incl. of Tax" := ReservEntry."MRP Value"; //ccit_kj
        END;
        //RND TK
    end;
}

