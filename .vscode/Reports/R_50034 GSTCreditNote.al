report 50034 "GST-Credit Note"
{
    DefaultLayout = RDLC;
    RDLCLayout = './GST-Credit Note.rdl';
    ApplicationArea = FixedAsset;

    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            RequestFilterFields = "No.";
            CalcFields = "QR Code";
            column(LUTNo; LUTNo)
            {
            }
            column(Inv_Comments; Inv_Comments)
            {
            }
            column(ReportCaption; ReportCaption)
            {
            }
            column(qrcode; "Sales Cr.Memo Header"."QR Code")
            {
            }
            column(IRNNo_SalesCrMemoHeader; IRN_No)
            {
            }
            column(Company_Name; RecCompany.Name)
            {
            }
            column(Image; RecCompany.Picture)
            {
            }
            column(Address1; RecLocation.Address)
            {
            }
            column(Address2; RecLocation."Address 2")
            {
            }
            column(Tel_No; RecLocation."Phone No.")
            {
            }
            column(GSTIN_No; RecLocation."GST Registration No.")
            {
            }
            column(Cust_GSTIN_No; RecCustomer."GST Registration No.")
            {
            }
            column(Mobile_no; RecCustomer."Phone No.")
            {
            }
            column(Age_group; RecCustomer."Age Group")
            {
            }
            column(gender; RecCustomer.Gender)
            {
            }
            column(birth_date; RecCustomer."Customer Birth Date")
            {
            }
            column(anniversary_date; RecCustomer."Aniversary Date")
            {
            }
            column(marital_status; RecCustomer."Marital Status")
            {
            }
            column(Company_State; Company_State)
            {
            }
            column(Company_StateCode; Company_StateCode)
            {
            }
            column(Customer_State; Customer_State)
            {
            }
            column(Customer_StateCode; Customer_StateCode)
            {
            }
            column(AmtToCust; TotAmtvar)
            {
            }
            column(AmountInWord; AmountInWord[1])
            {
            }
            column(GSTWithoutPaymentofDuty_SalesCrMemoHeader; "Sales Cr.Memo Header"."GST Without Payment of Duty")
            {
            }
            column(LocationStateCode_SalesCrMemoHeader; "Sales Cr.Memo Header"."Location State Code")
            {
            }
            column(No_Tax; No_Tax)
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(Title; Title)
                    {
                    }
                    column(Credit_No; "Sales Cr.Memo Header"."No.")
                    {
                    }
                    column(Credit_Date; "Sales Cr.Memo Header"."Posting Date")
                    {
                    }
                    column(Customer_Name; "Sales Cr.Memo Header"."Bill-to Name")
                    {
                    }
                    column(C_Address1; "Sales Cr.Memo Header"."Bill-to Address")
                    {
                    }
                    column(C_Address2; "Sales Cr.Memo Header"."Bill-to Address 2")
                    {
                    }
                    column(Reference_No; "Sales Cr.Memo Header"."Applies-to Doc. No.")
                    {
                    }
                    column(CustLedDate; CustLedDate)
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Cr.Memo Header";

                        column(SrNo; "Sr.No")
                        {
                        }
                        column(Serial_No; RecILE."Serial No.")
                        {
                        }
                        column(IMEINo; RecILE."IMEI No.")
                        {
                        }
                        column(SrlNo; SrlNo)
                        {
                        }
                        column(Comment; ("Sales Cr.Memo Line".Type = "Sales Cr.Memo Line".Type::" "))
                        { }
                        column(Item_No; "Sales Cr.Memo Line"."No.")
                        {
                        }
                        column(Item_Description; "Sales Cr.Memo Line".Description)
                        {
                        }
                        column(HSN_SAC; "Sales Cr.Memo Line"."HSN/SAC Code")
                        {
                        }
                        column(Quantity; "Sales Cr.Memo Line".Quantity)
                        {
                        }
                        column(UOM; "Sales Cr.Memo Line"."Unit of Measure")
                        {
                        }
                        column(Rate_Unit; "Sales Cr.Memo Line"."Unit Price")
                        {
                        }
                        column(Line_Discount; "Sales Cr.Memo Line"."Line Discount Amount")
                        {
                        }
                        column(Tax_1; Tax[1])
                        {
                        }
                        column(Tax_2; Tax[2])
                        {
                        }
                        column(Tax_3; Tax[3])
                        {
                        }
                        column(Tax_4; Tax[4])
                        {
                        }
                        column(Rate_1; Rate[1])
                        {
                        }
                        column(Rate_2; Rate[2])
                        {
                        }
                        column(Rate_3; Rate[3])
                        {
                        }
                        column(Rate_4; Rate[4])
                        {
                        }
                        column(Tax_Amount_1; Tax_Amount[1])
                        {
                        }
                        column(Tax_Amount_2; Tax_Amount[2])
                        {
                        }
                        column(Tax_Amount_3; Tax_Amount[3])
                        {
                        }
                        column(Tax_Amount_4; Tax_Amount[4])
                        {
                        }
                        column(Total_Amt; Total_Amt)
                        {
                        }
                        column(TotalGSTAmount_SalesCrMemoLine; 0)
                        {
                        }
                        column(GSTBaseAmount_SalesCrMemoLine; "Sales Cr.Memo Line".Amount)
                        {
                        }

                        trigger OnAfterGetRecord()
                        var
                            DesStrCunt: Integer;
                        begin
                            if "Sales Cr.Memo Line".Type = "Sales Cr.Memo Line".Type::" " then
                                CurrReport.skip;
                            RecDetailedGSTLE.RESET;
                            RecDetailedGSTLE.SETRANGE(RecDetailedGSTLE."Document Type", RecDetailedGSTLE."Document Type"::"Credit Memo");
                            RecDetailedGSTLE.SETRANGE(RecDetailedGSTLE."Document No.", "Sales Cr.Memo Line"."Document No.");
                            RecDetailedGSTLE.SETRANGE(RecDetailedGSTLE."No.", "Sales Cr.Memo Line"."No.");
                            RecDetailedGSTLE.SETRANGE("GST Component Code", 'CGST');
                            IF RecDetailedGSTLE.FINDFIRST THEN
                                linecount := linecount + 2
                            else
                                linecount += 1;

                            DesStrCunt := StrLen("Sales Cr.Memo Line".Description);
                            DesStrCunt := Round(DesStrCunt / 40, 1, '>');
                            IF DesStrCunt > 1 then
                                linecount += (DesStrCunt - 1);


                            /* RecDetailedGSTLE.RESET;
                            RecDetailedGSTLE.SETRANGE(RecDetailedGSTLE."Document Type", RecDetailedGSTLE."Document Type"::"Credit Memo");
                            RecDetailedGSTLE.SETRANGE(RecDetailedGSTLE."Document No.", "Sales Cr.Memo Line"."Document No.");
                            RecDetailedGSTLE.SETRANGE(RecDetailedGSTLE."No.", "Sales Cr.Memo Line"."No.");
                            RecDetailedGSTLE.SETRANGE(RecDetailedGSTLE."GST Component Code", '%1', 'IGST');
                            IF RecDetailedGSTLE.FINDFIRST THEN
                                linecount := linecount + 1; */


                            IF "Sales Cr.Memo Line".Type <> "Sales Cr.Memo Line".Type::" " THEN
                                "Sr.No" := "Sr.No" + 1;
                            //Tax
                            CLEAR(Tax);
                            CLEAR(Rate);
                            CLEAR(Tax_Amount);
                            No_Tax := true;
                            i := 1;
                            RecDetailedGSTLE.RESET;
                            RecDetailedGSTLE.SETRANGE("Document No.", "Sales Cr.Memo Line"."Document No.");
                            RecDetailedGSTLE.SETRANGE("No.", "Sales Cr.Memo Line"."No.");
                            RecDetailedGSTLE.SETFILTER("Document Line No.", '%1', "Sales Cr.Memo Line"."Line No.");
                            IF RecDetailedGSTLE.FINDFIRST THEN
                                REPEAT
                                    No_Tax := false;
                                    Tax[i] := RecDetailedGSTLE."GST Component Code";
                                    Rate[i] := RecDetailedGSTLE."GST %";
                                    Tax_Amount[i] := RecDetailedGSTLE."GST Amount";
                                    i := i + 1;
                                UNTIL RecDetailedGSTLE.NEXT = 0;

                            RecILE.RESET;
                            RecILE.SETRANGE("Item No.", "Sales Cr.Memo Line"."No.");
                            RecILE.SETFILTER("Document Line No.", '%1', "Sales Cr.Memo Line"."Line No.");
                            RecILE.SETRANGE("Document No.", "Sales Cr.Memo Line"."Document No.");
                            IF RecILE.FINDFIRST THEN;

                            Total_Amt := ("Sales Cr.Memo Line".Quantity) * ("Sales Cr.Memo Line"."Unit Price");

                            TotAmtvar += ("Sales Cr.Memo Line".Amount + Abs(Tax_Amount[1]) + Abs(Tax_Amount[2]) + Abs(Tax_Amount[3]));

                            SrlNo := RecILE."Serial No.";

                            ReportCheck.InitTextVariable;
                            ReportCheck.FormatNoText(AmountInWord, TotAmtvar, '');
                        end;

                        trigger OnPreDataItem()
                        begin
                            //linecount :=1;
                        end;
                    }
                    dataitem(Integer; Integer)
                    {
                        DataItemLinkReference = "Sales Cr.Memo Header";
                        column(Number_Integer; Integer.Number)
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            /*IF(linecount MOD maxline>0) THEN
                              spline:=maxline-(linecount MOD maxline)
                            ELSE
                              spline:=0;*/

                            //Integer.SETRANGE(Integer.Number,1,spline);

                            IF linecount > maxline THEN
                                spline := maxline - ROUND((linecount / maxline - ROUND(linecount / maxline, 1, '<')) * maxline, 1)
                            ELSE
                                spline := maxline - linecount;

                            Integer.SETRANGE(Number, 1, spline);

                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    IF Number > 1 THEN BEGIN
                        CopyText := Text16502;
                        OutputNo += 1;
                    END;
                    CurrReport.PAGENO := 1;


                    //Win 275
                    IF OutputNo = 1 THEN BEGIN
                        Title := Text1;
                        CLEAR(Tax);
                        CLEAR(Rate);
                        CLEAR(Tax_Amount);
                        CLEAR(Total_Amt);
                        "Sr.No" := 0;
                    END;

                    IF OutputNo = 2 THEN BEGIN
                        Title := Text2;
                        CLEAR(Tax);
                        CLEAR(Rate);
                        CLEAR(Tax_Amount);
                        CLEAR(Total_Amt);
                        "Sr.No" := 0;
                    END;

                    IF OutputNo = 3 THEN BEGIN
                        Title := Text3;
                        CLEAR(Tax);
                        CLEAR(Rate);
                        CLEAR(Tax_Amount);
                        CLEAR(Total_Amt);
                        "Sr.No" := 0;
                    END;

                    /*
                    IF OutputNo=4 THEN  BEGIN
                     Title:=Text4;
                     "Sr.No":=0;
                     TotAmt:=0;
                    END;
                    */

                end;

                trigger OnPostDataItem()
                begin
                    /*IF NOT CurrReport.PREVIEW THEN
                      SalesInvCountPrinted.RUN("Sales Invoice Header");
                      */

                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies);// + cust."Invoice Copies";
                    IF NoOfLoops <= 0 THEN
                        NoOfLoops := 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                RecLocation.RESET;
                RecLocation.SETRANGE(Code, "Sales Cr.Memo Header"."Location Code");
                IF RecLocation.FINDFIRST THEN;

                /*  IF "Sales Cr.Memo Header".Structure = 'NOTAX' THEN
                     No_Tax := TRUE
                 ELSE
                     No_Tax := FALSE;//WIN234 11122020 */

                //WIN316++
                CLEAR(Inv_Comments);
                SalesCommentLine.RESET;
                SalesCommentLine.SETRANGE("Document Type", SalesCommentLine."Document Type"::"Posted Credit Memo");
                SalesCommentLine.SETRANGE("Document Line No.", 0);
                SalesCommentLine.SETRANGE("No.", "Sales Cr.Memo Header"."No.");
                IF SalesCommentLine.FINDSET THEN
                    REPEAT
                        Inv_Comments += SalesCommentLine.Comment + ',';
                    UNTIL SalesCommentLine.NEXT = 0;
                //WIN316--

                CLEAR(IRN_No); // kppl rohit
                EInvoiceEntryRec.RESET;
                EInvoiceEntryRec.SETRANGE(EInvoiceEntryRec."Document No.", "Sales Cr.Memo Header"."No.");
                IF EInvoiceEntryRec.FINDSET THEN BEGIN
                    IRN_No := EInvoiceEntryRec.IRN;
                    EInvoiceEntryRec.CALCFIELDS("QR Code");
                END;

                RecState.RESET;
                RecState.SETRANGE(Code, "Sales Cr.Memo Header".State);
                IF RecState.FINDFIRST THEN BEGIN
                    Company_State := RecState.Description;
                    Company_StateCode := RecState.Code + ' (' + RecState."State Code (GST Reg. No.)" + ')';
                END;

                RecCustomer.RESET;
                RecCustomer.SETRANGE("No.", "Sales Cr.Memo Header"."Bill-to Customer No.");
                IF RecCustomer.FINDFIRST THEN
                    RecState.RESET;
                RecState.SETRANGE(Code, RecCustomer."State Code");
                IF RecState.FINDFIRST THEN
                    Customer_State := RecState.Description;
                Customer_StateCode := RecCustomer."State Code" + '(' + RecState."State Code (GST Reg. No.)" + ')';



                RecCustLedEnt.RESET;
                RecCustLedEnt.SETRANGE("Document No.", "Sales Cr.Memo Header"."Applies-to Doc. No.");
                IF RecCustLedEnt.FINDFIRST THEN
                    CustLedDate := RecCustLedEnt."Posting Date";

                //QR++
                IF "Sales Cr.Memo Header"."Acknowledgement No." <> '' THEN BEGIN
                    RecEinvoice.RESET;
                    RecEinvoice.SETRANGE("Document No.", "No.");

                    //RecEinvoice.SETRANGE("Inv Transaction",RecEinvoice."Inv Transaction"::"Generate IRN");
                    IF RecEinvoice.FINDLAST THEN BEGIN
                        IF RecEinvoice."Inv Transaction" = RecEinvoice."Inv Transaction"::"Generate IRN" THEN BEGIN
                            RecEinvoice.CALCFIELDS("Signed QR Code");
                            IF RecEinvoice."Signed QR Code".HASVALUE THEN BEGIN
                                RecEinvoice."Signed QR Code".CREATEINSTREAM(Streamin);
                                Streamin.READTEXT(qrtest);
                                qrtest := DELCHR(qrtest, '=', '"');
                                QRCodeInput := qrtest;
                                /* QRCodeFileName := GetQRCode(QRCodeInput);
                                QRCodeFileName := MoveToMagicPath(QRCodeFileName);
                                CLEAR(TempBlob);

                                ThreeTierMgt.BLOBImport(TempBlob, QRCodeFileName); */
                                IF RecEinvoice."Signed QR Code".HASVALUE THEN;

                            END;
                        END;
                    END;
                END;


                IF ("Sales Cr.Memo Header"."GST Without Payment of Duty" = TRUE) AND ("Sales Cr.Memo Header"."Location State Code" = 'MH') THEN BEGIN
                    //IF "Sales Cr.Memo Header"."Posting Date" > 040321D THEN
                    LUTNo := 'ARN -AD2704210097944'
                    //ELSE
                    //  LUTNo := 'ARN -D270618001954V';
                END;


                IF ("Sales Cr.Memo Header"."GST Without Payment of Duty" = TRUE) AND ("Sales Cr.Memo Header"."Location State Code" = 'KA') THEN BEGIN
                    // IF "Sales Cr.Memo Header"."Posting Date" > 040321D THEN
                    LUTNo := 'ARN -AD290421003626B';
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NoOfCopies; NoOfCopies)
                    {
                        Caption = 'No. of Copies';
                        ApplicationArea = All;
                    }
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
        maxline := 18;
        linecount := 0;
        spline := 0;

        RecCompany.GET();
        RecCompany.CALCFIELDS(Picture);
        "Sr.No" := 0;
    end;

    var
        RecCompany: Record 79;
        "Sr.No": Integer;
        RecState: Record State;
        RecCustomer: Record 18;
        Company_State: Text;
        Company_StateCode: Code[10];
        Customer_State: Text;
        Customer_StateCode: Code[10];
        Tax: array[5] of Text;
        Rate: array[5] of Decimal;
        Tax_Amount: array[5] of Decimal;
        i: Integer;
        RecDetailedGSTLE: Record "Detailed GST Ledger Entry";
        RecILE: Record 32;
        ReportCaption: Label 'CREDIT NOTE';
        ReportCheck: Report "Posted Voucher";
        AmountInWord: array[2] of Text;
        maxline: Integer;
        linecount: Integer;
        spline: Integer;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        OutputNo: Integer;
        Title: Text[50];
        cust: Record 18;
        Text16502: Label 'COPY';
        Text1: Label 'Original for Recipient';
        Text2: Label 'Duplicate';
        Text3: Label 'Triplicate';
        Text4: Label 'Quadruplicate';
        Total_Amt: Decimal;
        RecCustLedEnt: Record 21;
        CustLedDate: Date;
        RecLocation: Record 14;
        TotAmtvar: Decimal;
        SrlNo: Code[30];
        SalesCommentLine: Record 44;
        Inv_Comments: Text;
        No_Tax: Boolean;
        RecEinvoice: Record 50015;
        Streamin: InStream;
        qrtest: Text;
        QRBLOB: BigText;
        ThreeTierMgt: Codeunit 419;
        //TempBlob: Record 99008535;
        QRCodeInput: Text;
        QRCodeFileName: Text;
        LUTNo: Text;
        EInvoiceEntryRec: Record 50004;
        IRN_No: Text[64];

}

