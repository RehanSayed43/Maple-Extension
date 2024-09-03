report 50035 "GST-Debit Note"
{
    RDLCLayout = './GSTDebitNote.rdl';
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
        {
            //The property 'DataItemTableView' shouldn't have an empty value.
            //DataItemTableView = '';
            RequestFilterFields = "No.";
            column(No_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."No.")
            {
            }
            column(Company_Logo; CompanyInfo.Picture)
            {
            }
            column(Company_Name; CompanyInfo.Name)
            {
            }
            column(Company_Address; RecLocation.Address)
            {
            }
            column(Company_Address2; RecLocation."Address 2")
            {
            }
            column(Company_City; RecLocation.City)
            {
            }
            column(Company_Pincode; RecLocation."Post Code")
            {
            }
            column(Company_Phno; RecLocation."Phone No.")
            {
            }
            column(TotalValue; FinalTotal)
            {
            }
            column(FinalTotal; Round(FinalTotal))
            {
            }

            column(AmountInWord; AmountInWord) //column(AmountInWord; AmountInWord[1])
            {
            }

            dataitem(Integer; Integer)
            {
                DataItemTableView = SORTING(Number) where(Number = filter(1 .. 4));
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(Title; Title)
                    {
                    }
                    column(DebitNoteNo; "Purch. Cr. Memo Hdr."."No.")
                    {
                    }
                    column(DebitNoteDate; "Purch. Cr. Memo Hdr."."Document Date")
                    {
                    }
                    column(VendorName; "Purch. Cr. Memo Hdr."."Buy-from Vendor Name")
                    {
                    }
                    column(VendorName2; "Purch. Cr. Memo Hdr."."Buy-from Vendor Name 2")
                    {
                    }
                    column(VendorAddress; "Purch. Cr. Memo Hdr."."Buy-from Address")
                    {
                    }
                    column(VendorAddress2; "Purch. Cr. Memo Hdr."."Buy-from Address 2")
                    {
                    }
                    column(VendorCity; "Purch. Cr. Memo Hdr."."Buy-from City")
                    {
                    }
                    column(VendorPinCode; "Purch. Cr. Memo Hdr."."Buy-from Post Code")
                    {
                    }
                    column(GSTIN; GSTIN)
                    {
                    }
                    column(Comp_State; Comp_State)
                    {
                    }
                    column(Comp_State1; Comp_State1)
                    {
                    }
                    column(Comp_StateCode; Comp_StateCode)
                    {
                    }
                    column(Comp_StateCodeNo; Comp_StateCodeNo)
                    {
                    }
                    column(GSTIN2; GSTIN2)
                    {
                    }
                    column(Vendor_State; Vendor_State)
                    {
                    }
                    column(Vendor_StateCode; Vendor_StateCode)
                    {
                    }
                    column(Vendor_StateCodeNo; Vendor_StateCodeNo)
                    {
                    }
                    column(PurchInvoiceNo; "Purch. Cr. Memo Hdr."."Applies-to Doc. No.")
                    {
                    }
                    column(VendLedEntDate; VendLedEntDate)
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    dataitem("Purch. Cr. Memo Line"; "Purch. Cr. Memo Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purch. Cr. Memo Hdr.";
                        DataItemTableView = WHERE(Type = FILTER(Item | "Fixed Asset" | "G/L Account"));
                        // DataItemTableView = WHERE(Type = FILTER(Item | "Fixed Asset"));
                        column(SrNo; SrNo)
                        {
                        }
                        column(VendorItemNo; "Purch. Cr. Memo Line"."Vendor Item No.")
                        {
                        }
                        column(Vendor_Desc; "Purch. Cr. Memo Line".Description)
                        {
                        }
                        column(Vendor_Desc2; "Purch. Cr. Memo Line"."Description 2")
                        {
                        }
                        column(HSN_SACCode; "Purch. Cr. Memo Line"."HSN/SAC Code")
                        {
                        }
                        column(Qty; "Purch. Cr. Memo Line".Quantity)
                        {
                        }
                        column(UOM; "Purch. Cr. Memo Line"."Unit of Measure")
                        {
                        }
                        column(Unit_rate; ("Purch. Cr. Memo Line"."Direct Unit Cost"))
                        {
                        }
                        column(Disc_Amt; "Purch. Cr. Memo Line"."Line Discount Amount")
                        {
                        }
                        column(VendorPartCode; VendorPartCode)
                        {
                        }
                        column(Total_Amt; '')//"Purch. Cr. Memo Line"."Line Amount" + Abs(CGSTAmt) + Abs(SGSTAmt) + Abs(IGSTAmt))
                        {
                        }
                        column(SerialNo; SerialNo)
                        {
                        }
                        column(IMEINo; IMEINo)
                        {
                        }
                        column(GSTComponentCGST; GSTComponentCGST)
                        {
                        }
                        column(GSTComponentSGST; GSTComponentSGST)
                        {
                        }
                        column(GSTComponentIGST; GSTComponentIGST)
                        {
                        }
                        column(CGSTAmt; CGSTAmt)
                        {
                        }
                        column(CGSTRate; CGSTRate)
                        {
                        }
                        column(SGSTAmt; SGSTAmt)
                        {
                        }
                        column(SGSTRate; SGSTRate)
                        {
                        }
                        column(IGSTAmt; IGSTAmt)
                        {
                        }
                        column(IGSTRate; IGSTRate)
                        {
                        }
                        column(Line_Amount; "Purch. Cr. Memo Line"."Direct Unit Cost" * "Purch. Cr. Memo Line".Quantity)
                        {

                        }
                        column(Quantity; Quantity)
                        {

                        }
                        column(Unit_Cost; "Unit Cost")
                        {

                        }

                        trigger OnAfterGetRecord()
                        begin
                            //linecount+=2;
                            Clear(IGSTAmt);
                            Clear(CGSTAmt);
                            Clear(SGSTAmt);
                            Clear(IGSTRate);
                            Clear(CGSTRate);
                            Clear(SGSTRate);
                            // Clear(FinalTotal);

                            recItem.RESET;
                            recItem.SETRANGE("No.", "Purch. Cr. Memo Line"."No.");
                            IF recItem.FINDFIRST THEN
                                VendorPartCode := recItem."Vendor Part Code Long";

                            recDetailedGSTLedgerEntry.RESET;
                            recDetailedGSTLedgerEntry.SETRANGE(recDetailedGSTLedgerEntry."Document No.", "Purch. Cr. Memo Line"."Document No.");
                            IF recDetailedGSTLedgerEntry.FINDSET THEN BEGIN
                                IF recDetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN
                                    linecount += 3;


                                recDetailedGSTLedgerEntry.RESET;
                                IF recDetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN
                                    linecount += 1;
                            END;

                            //WIN345 Start
                            recDetailedGSTLedgerEntry.RESET;
                            //GSTDetailLeger.SETFILTER("Document Type",'%1',GSTDetailLeger."Document Type"::Invoice);
                            //GSTDetailLeger.SETRANGE(GSTDetailLeger."Document Type",GSTDetailLeger."Document Type"::Invoice);
                            recDetailedGSTLedgerEntry.SETRANGE(recDetailedGSTLedgerEntry."Document No.", "Purch. Cr. Memo Line"."Document No.");
                            recDetailedGSTLedgerEntry.SETFILTER(recDetailedGSTLedgerEntry."Document Line No.", '%1', "Purch. Cr. Memo Line"."Line No.");
                            IF recDetailedGSTLedgerEntry.FINDSET THEN
                                REPEAT
                                    IF recDetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN BEGIN
                                        CLEAR(CGSTRate);
                                        CLEAR(CGSTAmt);
                                        CLEAR(GSTComponentCGST);
                                        GSTComponentCGST := 'CGST';
                                        CGSTRate := recDetailedGSTLedgerEntry."GST %";
                                        CGSTAmt := recDetailedGSTLedgerEntry."GST Amount";
                                    END ELSE
                                        IF recDetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN BEGIN
                                            CLEAR(SGSTRate);
                                            CLEAR(SGSTAmt);
                                            CLEAR(GSTComponentSGST);

                                            GSTComponentSGST := 'SGST';
                                            SGSTRate := recDetailedGSTLedgerEntry."GST %";
                                            SGSTAmt := recDetailedGSTLedgerEntry."GST Amount";
                                        END ELSE
                                            IF recDetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN BEGIN
                                                CLEAR(IGSTRate);
                                                CLEAR(IGSTAmt);
                                                CLEAR(GSTComponentIGST);
                                                GSTComponentIGST := 'IGST';
                                                IGSTRate := recDetailedGSTLedgerEntry."GST %";
                                                IGSTAmt := recDetailedGSTLedgerEntry."GST Amount";
                                            END;


                                UNTIL recDetailedGSTLedgerEntry.NEXT = 0;
                            if "Purch. Cr. Memo Line".Description = 'Round Off' then begin

                                GSTComponentCGST := '';
                                GSTComponentIGST := '';
                                GSTComponentSGST := '';

                            end;




                            //FinalTotal := "Purch. Cr. Memo Line"."Direct Unit Cost" * "Purch. Cr. Memo Line".Quantity + Abs(CGSTAmt) + Abs(SGSTAmt) + Abs(IGSTAmt) - ("Purch. Cr. Memo Line"."Line Discount Amount");
                            FinalTotal := FinalTotal + "Purch. Cr. Memo Line"."Direct Unit Cost" * "Purch. Cr. Memo Line".Quantity + Abs(CGSTAmt) + Abs(SGSTAmt) + Abs(IGSTAmt) - ("Purch. Cr. Memo Line"."Line Discount Amount");

                            SrNo := SrNo + 1;
                            recILE.RESET;
                            CLEAR(SerialNo);
                            CLEAR(IMEINo);
                            //recILE.SETRANGE(recILE."Document Type",recILE."Document Type"::"Purchase Credit Memo");
                            recILE.SETRANGE(recILE."Document No.", "Purch. Cr. Memo Line"."Document No.");
                            //recILE.SETFILTER(recILE.Quantity,'>%1',0);
                            recILE.SETRANGE(recILE."Item No.", "Purch. Cr. Memo Line"."No.");
                            IF recILE.FINDSET THEN
                                REPEAT
                                    IF recILE."Serial No." <> '' THEN
                                        SerialNo := SerialNo + FORMAT(recILE."Serial No.") + ',';
                                    IF recILE."IMEI No." <> '' THEN
                                        IMEINo := IMEINo + FORMAT(recILE."IMEI No.") + ',';
                                UNTIL recILE.NEXT = 0;

                            len1 := STRLEN(SerialNo);
                            IF len1 <> 0 THEN
                                SerialNo := DELSTR(SerialNo, len1, 1);

                            len2 := STRLEN(IMEINo);
                            IF len2 <> 0 THEN
                                IMEINo := DELSTR(IMEINo, len2, 1);

                            IF (len1 <> 0) AND (len2 = 0) THEN
                                linecount := linecount + ROUND(((len1 - 1) / 27), 1, '>');
                            IF (len1 = 0) AND (len2 <> 0) THEN
                                linecount := linecount + ROUND(((len2 - 1) / 27), 1, '>');
                            IF (len1 <> 0) AND (len2 <> 0) THEN BEGIN
                                IF len1 > len2 THEN
                                    linecount := linecount + ROUND(((len1 - 1) / 27), 1, '>')
                                ELSE
                                    linecount := linecount + ROUND(((len2 - 1) / 27), 1, '>')
                            END
                            /*
                            ValueEntry.RESET;
                            ValueEntry.SETRANGE(ValueEntry."Document Type",ValueEntry."Document Type"::"Purchase Credit Memo");
                            ValueEntry.SETRANGE(ValueEntry."Document No.","Purch. Cr. Memo Line"."Document No.");
                            ValueEntry.SETRANGE(ValueEntry."Item No.","Purch. Cr. Memo Line"."No.");
                            //ValueEntry.SETRANGE(ValueEntry."Document Line No.","Purch. Cr. Memo Line"."Line No.");
                            //ValueEntry.SETRANGE(ValueEntry."Item Ledger Entry No.",RecItemLedger."Entry No.");
                            ValueEntry.SETRANGE("Source No.","Purch. Cr. Memo Line"."Buy-from Vendor No.");
                            //RecItemLedger.SETRANGE("Entry No.",ValueEntry."Item Ledger Entry No.");
                            
                            
                            IF RecItemLedger.FINDFIRST THEN
                              BEGIN
                                SerialNo:=RecItemLedger."Serial No.";
                                IMEINo:=RecItemLedger."IMEI No.";
                              END
                            *//*
                            Recitem.RESET;
                            Recitem.SETRANGE(Recitem."No.","Transfer Line"."Item No.");
                            IF Recitem.FINDFIRST THEN BEGIN
                              Unitcost:= Recitem."Unit Cost";
                              extendedcost:= Unitcost * "Transfer Line".Quantity;
                              REPEAT
                              UNTIL
                              RecTransferLine.NEXT=0;
                            END;*/

                            //Amnt:=Amnt+"Purch. Cr. Memo Line"."Line Amount" -"Purch. Cr. Memo Line"."Line Discount Amount";

                        end;

                        trigger OnPreDataItem()
                        begin
                            SrNo := 0;
                            linecount := 0;//Win345
                        end;

                        trigger OnPostDataItem()
                        var
                            PostedVoucher: Report "Posted Voucher";
                        begin
                            //  Message('%1', FinalTotal);
                            /* Clear(AmountInWord);
                            ReportCheck1.InitTextVariable;
                            ReportCheck1.FormatNoText(AmountInWord, Round(FinalTotal, 1), ' '); */
                            PostedVoucher.InitTextVariable();
                            PostedVoucher.FormatNoText(NoText, FinalTotal, '');
                            AmountInWord := NoText[1];
                        end;
                    }
                    dataitem(DataItem1000000058; Integer)
                    {
                        DataItemLinkReference = "Purch. Cr. Memo Hdr.";
                        column(Number_Integer; DataItem1000000058.Number)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            /*"Purch. Cr. Memo Line".RESET;
                            "Purch. Cr. Memo Line".SETRANGE("Document No.","Purch. Cr. Memo Hdr."."No.");
                            "Purch. Cr. Memo Line".FINDFIRST;
                            */

                        end;

                        trigger OnPreDataItem()
                        begin
                            IF linecount > maxline THEN
                                spline := maxline - ROUND((linecount / maxline - ROUND(linecount / maxline, 1, '<')) * maxline, 1)
                            ELSE
                                spline := maxline - linecount;
                            DataItem1000000058.SETRANGE(Number, 1, spline);
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
                        // "Sr.No":=0;
                        //TotAmt:=0;
                    END;

                    IF OutputNo = 2 THEN BEGIN
                        Title := Text2;
                        //"Sr.No":=0;
                        //TotAmt:=0;
                    END;

                    IF OutputNo = 3 THEN BEGIN
                        Title := Text3;
                        //"Sr.No":=0;
                        //TotAmt:=0;
                    END;
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
                RecLocation.SETRANGE(Code, "Purch. Cr. Memo Hdr."."Location Code");
                IF RecLocation.FINDFIRST THEN;

                //GSTIN:=CompanyInfo."GST Registration No.";
                //Comp_StateCode:=CompanyInfo.State;

                //RecState.SETRANGE(Code,CompanyInfo.State);
                RecState.SETRANGE(Code, RecLocation."State Code");
                IF RecState.FINDFIRST THEN BEGIN
                    Comp_State := RecState.Description;
                    Comp_StateCodeNo := RecState."State Code (GST Reg. No.)";
                    Comp_StateCode := RecState.Code;
                    GSTIN := RecLocation."GST Registration No.";
                END;

                RecVend.SETRANGE("No.", "Purch. Cr. Memo Hdr."."Buy-from Vendor No.");
                IF RecVend.FINDFIRST THEN
                    GSTIN2 := RecVend."GST Registration No.";

                RecState.SETRANGE(Code, "Purch. Cr. Memo Hdr."."Location State Code");
                IF RecState.FINDFIRST THEN BEGIN
                    Comp_State1 := RecState.Description;
                    Vendor_StateCode := RecState.Code;
                    Vendor_StateCodeNo := RecState."State Code (GST Reg. No.)";
                    Vendor_State := RecState.Description;
                END;
                /*
                recILE.RESET;
                CLEAR(SerialNo);
                CLEAR(IMEINo);
                recILE.SETRANGE(recILE."Document Type",recILE."Document Type"::"Purchase Credit Memo");
                recILE.SETRANGE(recILE."Document No.","Purch. Cr. Memo Line"."Document No.");
                recILE.SETFILTER(recILE.Quantity,'>%1',0);
                recILE.SETRANGE(recILE."Item No.","Purch. Cr. Memo Line"."Vendor Item No.");
                IF recILE.FINDSET THEN REPEAT
                  SerialNo:=SerialNo+FORMAT(recILE."Serial No.")+'|';
                  IMEINo:=IMEINo+FORMAT(recILE."IMEI No.")+'|';
                UNTIL recILE.NEXT=0;
                *//*
                recILE.RESET;
                CLEAR(SerialNo);
                CLEAR(IMEINo);
                //recILE.SETRANGE(recILE."Document Type",recILE."Document Type"::"Purchase Credit Memo");
                recILE.SETRANGE(recILE."Document No.","Purch. Cr. Memo Line"."Document No.");
                recILE.SETFILTER(recILE.Quantity,'>%1',0);
                recILE.SETRANGE(recILE."Item No.","Purch. Cr. Memo Line"."No.");
                IF recILE.FINDSET THEN REPEAT
                  SerialNo:=SerialNo+FORMAT(recILE."Serial No.")+'|';
                  MESSAGE(SerialNo);
                  IMEINo:=IMEINo+FORMAT(recILE."IMEI No.")+'|';
                UNTIL recILE.NEXT=0;
                
                len1:=STRLEN(SerialNo);
                IF len1<>0 THEN
                  SerialNo:=DELSTR(SerialNo,len1,1);
                
                len2:=STRLEN(IMEINo);
                IF len2<>0 THEN
                  IMEINo:=DELSTR(IMEINo,len2,1);*/
                  //Amount In Words
                  //Clear(FinalTotal);
                recDetailedGSTLedgerEntry.RESET;
                recDetailedGSTLedgerEntry.SETRANGE(recDetailedGSTLedgerEntry."Document No.", "Purch. Cr. Memo Hdr."."No.");
                recDetailedGSTLedgerEntry.CalcSums("GST Amount", "GST Base Amount");
                // FinalTotal := "Purch. Cr. Memo Line"."Line Amount" + CGSTAmt + SGSTAmt + IGSTAmt;
                // //FinalTotal := Abs(recDetailedGSTLedgerEntry."GST Base Amount") + Abs(recDetailedGSTLedgerEntry."GST Amount");
                // ReportCheck1.InitTextVariable;
                // ReportCheck1.FormatNoText(AmountInWord, FinalTotal, ' ');
                // Message('%1', FinalTotal);

                RecVendLedEnt.RESET;
                RecVendLedEnt.SETRANGE("Document No.", "Purch. Cr. Memo Hdr."."Applies-to Doc. No.");
                IF RecVendLedEnt.FINDFIRST THEN
                    VendLedEntDate := RecVendLedEnt."Posting Date";

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

    trigger OnInitReport()
    begin
        CompanyInfo.GET();
        CompanyInfo.CALCFIELDS(Picture);
        Clear(FinalTotal);
    end;

    trigger OnPreReport()
    begin
        //WIN345 For int line
        maxline := 20;
        linecount := 0;
        spline := 0;
        //WIn345 End

    end;

    var
        CompanyInfo: Record 79;
        GSTIN: Code[20];
        Comp_State: Text[30];
        Comp_StateCode: Text[20];
        Comp_StateCodeNo: Text[20];
        SrNo: Integer;
        RecState: Record State;
        SerialNo: Text;
        IMEINo: Text;
        ValueEntry: Record 5802;
        GSTIN2: Code[20];
        Vendor_State: Text[30];
        Vendor_StateCode: Text[20];
        Vendor_StateCodeNo: Text[20];
        CGSTAmt: Decimal;
        CGSTRate: Decimal;
        SGSTAmt: Decimal;
        SGSTRate: Decimal;
        IGSTAmt: Decimal;
        IGSTRate: Decimal;
        recDetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        GSTComponentCGST: Text;
        GSTComponentSGST: Text;
        GSTComponentIGST: Text;
        RecVend: Record Vendor;
        recILE: Record "Item Ledger Entry";
        len1: Integer;
        len2: Integer;
        //   AmountInWord: array[2] of Text[100];
        ReportCheck1: Report "Posted Voucher";
        FinalTotal: Decimal;
        Amnt: Decimal;
        RecVendLedEnt: Record "Vendor Ledger Entry";
        VendLedEntDate: Date;
        Text16502: Label 'COPY';
        Text1: Label 'Original for Recipient';
        Text2: Label 'Duplicate';
        Text3: Label 'Triplicate';
        Text4: Label 'Quadruplicate';
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        OutputNo: Integer;
        Title: Text[50];
        linecount: Integer;
        spline: Integer;
        maxline: Integer;
        recItem: Record item;
        VendorPartCode: Code[50];
        RecLocation: Record Location;
        Comp_State1: Text;
        NoText: array[2] of Text;
        AmountInWord: Text;


}

