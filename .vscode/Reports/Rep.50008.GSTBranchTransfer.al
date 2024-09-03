report 50008 "GST- Branch Transfer"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './GSTBranchTransfer.rdl';

    dataset
    {
        dataitem("Transfer Shipment Header"; "Transfer Shipment Header")
        {
            RequestFilterFields = "No.";
            column(qrcode; "Transfer Shipment Header"."MQR Code") //kj 100823
            {

            }
            column(IRNNo_TransferShipmentHeader; "Transfer Shipment Header"."IRN No.")
            {
            }
            column(ComponyInfo_Name; ComponyInfo.Name)
            {
            }
            column(ComponyInfo_Address; ComponyInfo.Address)
            {
            }
            column(ComponyInfo_Address2; ComponyInfo."Address 2")
            {
            }
            column(ComponyInfo_City; ComponyInfo.City + '-' + ComponyInfo."Post Code")
            {
            }
            column(ComponyInfo_State; ComponyInfo."State Code" + ComponyInfo.County)
            {
            }
            column(ComponyInfo_Phone_No; ComponyInfo."Phone No.")
            {
            }
            column(ComponyInfo_FaxNo; ComponyInfo."Fax No.")
            {
            }
            column(ComponyInfo_EMail; ComponyInfo."E-Mail")
            {
            }
            column(ComponyInfo_PAN_No; ComponyInfo."P.A.N. No.")
            {
            }
            column(ComponyInfo_GST_Registration_No; ComponyInfo."GST Registration No.")
            {
            }
            column(ComponyInfo_BankName; ComponyInfo."Bank Name")
            {
            }
            column(ComponyInfo_BankAcc_No; ComponyInfo."Bank Account No.")
            {
            }
            column(ComponyInfo_HomePage; ComponyInfo."Home Page")
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
                    column(No_TransferShipmentHeader; "Transfer Shipment Header"."No.")
                    {
                    }
                    column(HSN_Code; ItemRec."HSN/SAC Code")
                    {
                    }
                    column(PostingDate_TransferShipmentHeader; "Transfer Shipment Header"."Posting Date")
                    {
                    }
                    column(ComponyInfo_Picture; ComponyInfo.Picture)
                    {
                    }
                    column(State; State)
                    {
                    }
                    column(AmountInWord; AmountInWord[1])
                    {
                    }
                    column(ShipDesc; ShipDesc)
                    {
                    }
                    column(C_GSTINState; C_GSTINState)
                    {
                    }
                    column(Transfer_fromcode; "Transfer Shipment Header"."Transfer-from Code")
                    {
                    }
                    column(Transfer_tocode; "Transfer Shipment Header"."Transfer-to Code")
                    {
                    }
                    column(PlaceOfSupply; PlaceOfSupply)
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    dataitem("Transfer Shipment Line"; "Transfer Shipment Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Transfer Shipment Header";
                        column(From_Name; From_Name)
                        {
                        }
                        column(From_Address1; From_Address1)
                        {
                        }
                        column(TotalGSTAmount_TransferShipmentLine; '')
                        {
                        }
                        // column(TotalGSTAmount_TransferShipmentLine; "Transfer Shipment Line"."Total GST Amount")
                        // {
                        // }
                        column(From_Address2; From_Address2)
                        {
                        }
                        column(From_StateCode; From_StateCode)
                        {
                        }
                        column(From_State; From_State)
                        {
                        }
                        column(FromCity; FromCity)
                        {
                        }
                        column(From_GSTIN; From_GSTIN)
                        {
                        }
                        column(From_Tel; From_Tel)
                        {
                        }
                        column(To_Name; To_Name)
                        {
                        }
                        column(To_Address; To_Address)
                        {
                        }
                        column(To_Address2; To_Address2)
                        {
                        }
                        column(To_City; To_City)
                        {
                        }
                        column(To_StateCode; To_StateCode)
                        {
                        }
                        column(To_State; To_State)
                        {
                        }
                        column(To_GSTIN; To_GSTIN)
                        {
                        }
                        column(ItemNo_TransferShipmentLine; "Transfer Shipment Line"."Item No.")
                        {
                        }
                        column(Description_TransferShipmentLine; "Transfer Shipment Line".Description)
                        {
                        }
                        column(Description2_TransferShipmentLine; "Transfer Shipment Line"."Description 2")
                        {
                        }
                        column(Qty; Qty)
                        {
                        }
                        column(Unit; "Transfer Shipment Line"."Unit of Measure Code")
                        {
                        }
                        column(RatePerItem; "Transfer Shipment Line"."Unit Price")
                        {
                            IncludeCaption = true;
                        }
                        column(TaxableValue; TaxableValue)
                        {
                        }
                        column(CGST_RATE; CGST_RATE)
                        {
                        }
                        column(CGST_AMOUNT; ABS(CGST_AMOUNT))
                        {
                        }
                        column(SGST_RATE; SGST_RATE)
                        {
                        }
                        column(SGST_AMOUNT; ABS(SGST_AMOUNT))
                        {
                        }
                        column(IGST_RATE; IGST_RATE)
                        {
                        }
                        column(IGST_AMOUNT; ABS(IGST_AMOUNT))
                        {
                        }
                        column(Total; Total)
                        {
                        }
                        column(HSNSACCode_TransferShipmentLine; "Transfer Shipment Line"."HSN/SAC Code")
                        {
                        }
                        column(CESSAmount_TransferShipmentLine; '')
                        {
                        }
                        // column(CESSAmount_TransferShipmentLine; "Transfer Shipment Line"."CESS Amount")
                        // {
                        // }
                        column(VendorItemNo; VendorItemNo)
                        {
                        }
                        column(FinalTotal; FinalTotal)
                        {
                        }
                        column(UnitofMeasure_TransferShipmentLine; "Transfer Shipment Line"."Unit of Measure")
                        {
                        }
                        column(UnitPrice_TransferShipmentLine; "Transfer Shipment Line"."Unit Price")
                        {
                        }
                        column(Sr_No; Sr_No)
                        {
                        }
                        column(Amount_TransferShipmentLine; "Transfer Shipment Line".Amount)
                        {
                        }
                        column(SerialNo; SerialNo)
                        {
                        }
                        column(IMEI; IMEI)
                        {
                        }
                        column(GSTBaseAmount_TransferShipmentLine; '')
                        {
                        }
                        // column(GSTBaseAmount_TransferShipmentLine; "Transfer Shipment Line"."GST Base Amount")
                        // {
                        // }
                        // column(GST_TransferShipmentLine; "Transfer Shipment Line"."GST %")
                        // {
                        // }
                        column(GST_TransferShipmentLine; '')
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
                        column(TaxTotal; ABS(TaxTotal))
                        {
                        }
                        column(From_GSTState; From_GSTState)
                        {
                        }
                        column(To_GSTState; To_GSTState)
                        {
                        }
                        column(Disc; Disc)
                        {
                        }
                        column(GSTBASEAMNT_; GSTBASEAMNT_) //kj 100823
                        {

                        }

                        trigger OnAfterGetRecord()
                        begin
                            linecount += 1;

                            Sr_No += 1;
                            /*
                            Packing:=0;
                            Freight:=0;
                            Insurance:=0;
                            CGST_AMOUNT:=0;
                            IGST_AMOUNT:=0;
                            SGST_AMOUNT:=0;
                            */
                            CLEAR(VendorItemNo);
                            IF ItemRec.GET("Item No.") THEN
                                VendorItemNo := ItemRec."Vendor Part Code Long";

                            recILE.RESET;
                            CLEAR(SerialNo);
                            CLEAR(IMEI);
                            recILE.SETRANGE(recILE."Document No.", "Transfer Shipment Line"."Document No.");
                            recILE.SETFILTER(recILE.Quantity, '>%1', 0);
                            recILE.SETRANGE(recILE."Item No.", "Transfer Shipment Line"."Item No.");
                            IF recILE.FINDSET THEN
                                REPEAT
                                    IF recILE."Serial No." <> '' THEN
                                        SerialNo := SerialNo + FORMAT(recILE."Serial No.") + '|';
                                    IF recILE."IMEI No." <> '' THEN
                                        IMEI := IMEI + FORMAT(recILE."IMEI No.") + '|';
                                UNTIL recILE.NEXT = 0;

                            len1 := STRLEN(SerialNo);
                            IF len1 <> 0 THEN
                                SerialNo := DELSTR(SerialNo, len1, 1);

                            len2 := STRLEN(IMEI);
                            IF len2 <> 0 THEN
                                IMEI := DELSTR(IMEI, len2, 1);

                            //win355++
                            Qty := ROUND((Quantity / "Qty. per Unit of Measure"), 0.01, '=');
                            QtyBase := Quantity;
                            Total := Total + QtyBase * "Transfer Shipment Line"."Unit Price";
                            //Total := Qty * RatePerItem;


                            //RatePerItem := "Transfer Shipment Line"."Unit Price" * "Transfer Shipment Line"."Qty. per Unit of Measure";

                            TaxableValue := QtyBase * "Transfer Shipment Line"."Unit Price";


                            GSTDetailLeger.RESET;
                            GSTDetailLeger.SETRANGE(GSTDetailLeger."Document No.", "Transfer Shipment Line"."Document No.");
                            GSTDetailLeger.SETRANGE(GSTDetailLeger."No.", "Transfer Shipment Line"."Item No.");
                            GSTDetailLeger.SETRANGE("Document Line No.", "Transfer Shipment Line"."Line No.");//WIN234 27092020
                            IF GSTDetailLeger.FINDSET THEN BEGIN
                                REPEAT
                                    IF GSTDetailLeger."GST Component Code" = 'CGST' THEN BEGIN
                                        CLEAR(CGST_RATE);
                                        CLEAR(CGST_AMOUNT);
                                        CLEAR(GSTComponentCGST);
                                        GSTComponentCGST := 'CGST';
                                        CGST_RATE := GSTDetailLeger."GST %";
                                        CGST_AMOUNT := GSTDetailLeger."GST Amount";
                                        GSTBASEAMNT_ := 0; //kj 100823
                                    END ELSE
                                        IF GSTDetailLeger."GST Component Code" = 'SGST' THEN BEGIN
                                            CLEAR(SGST_RATE);
                                            CLEAR(SGST_AMOUNT);
                                            CLEAR(GSTComponentSGST);
                                            GSTComponentSGST := 'SGST';
                                            SGST_RATE := GSTDetailLeger."GST %";
                                            SGST_AMOUNT := GSTDetailLeger."GST Amount";
                                            GSTBASEAMNT_ := 0; //kj 100823
                                        END ELSE
                                            IF GSTDetailLeger."GST Component Code" = 'IGST' THEN BEGIN
                                                CLEAR(IGST_RATE);
                                                CLEAR(IGST_AMOUNT);
                                                CLEAR(GSTComponentIGST);
                                                GSTComponentIGST := 'IGST';
                                                IGST_RATE := GSTDetailLeger."GST %";
                                                IGST_AMOUNT := GSTDetailLeger."GST Amount";
                                                GSTBASEAMNT_ := ("Transfer Shipment Line"."Quantity (Base)") * ("Transfer Shipment Line"."Unit Price"); //kj 100823
                                            END;
                                UNTIL GSTDetailLeger.NEXT = 0;
                            END ELSE BEGIN
                                GSTComponentCGST := 'CGST';
                                GSTComponentSGST := 'SGST';
                            END;
                            FromLocation.RESET;
                            FromLocation.SETRANGE(FromLocation.Code, "Transfer-from Code");
                            IF FromLocation.FINDFIRST THEN
                                From_Name := FromLocation.Name;
                            From_Address1 := FromLocation.Address;
                            From_Address2 := FromLocation."Address 2";
                            FromCity := FromLocation.City + ' ' + FromLocation."Post Code";
                            From_StateCode := FromLocation."State Code";
                            From_GSTIN := FromLocation."GST Registration No.";
                            From_Tel := FromLocation."Phone No.";
                            StateRec.RESET;
                            StateRec.SETRANGE(StateRec.Code, From_StateCode);
                            IF StateRec.FINDFIRST THEN BEGIN
                                From_State := StateRec.Description;
                                From_GSTState := StateRec.Code + ' (' + StateRec."State Code (GST Reg. No.)" + ')';

                            END;

                            ToLocation.RESET;
                            ToLocation.SETRANGE(ToLocation.Code, "Transfer-to Code");
                            IF ToLocation.FINDFIRST THEN
                                To_Name := ToLocation.Name;
                            To_Address := ToLocation.Address;
                            To_Address2 := ToLocation."Address 2";
                            To_City := ToLocation.City + '  ' + ToLocation."Post Code";
                            To_StateCode := ToLocation."State Code";
                            To_GSTIN := ToLocation."GST Registration No.";

                            StateRec.RESET;
                            StateRec.SETRANGE(StateRec.Code, To_StateCode);
                            IF StateRec.FINDFIRST THEN BEGIN
                                To_State := StateRec.Description;
                                To_GSTState := StateRec.Code + ' (' + StateRec."State Code (GST Reg. No.)" + ')';
                            END;

                            //win355--
                            TaxTotal := TaxTotal + CGST_AMOUNT + SGST_AMOUNT + IGST_AMOUNT;
                            //FinalTotal:=FinalTotal+Amount+CGST_AMOUNT+SGST_AMOUNT+IGST_AMOUNT+"CESS Amount";
                            FinalTotal := FinalTotal + "Transfer Shipment Line".Amount + ABS(CGST_AMOUNT) + ABS(SGST_AMOUNT) + ABS(IGST_AMOUNT);//+ "CESS Amount";//WIN347_310717
                            ReportCheck.InitTextVariable;
                            ReportCheck.FormatNoText(AmountInWord, FinalTotal, ' ');

                            /*      RecPayTerm.RESET;
                     RecPayTerm.SETRANGE(RecPayTerm.Code, "Sales Invoice Header"."Payment Terms Code");
                     IF RecPayTerm.FINDFIRST THEN
                         PayTerm := RecPayTerm.Description;


                     RemAmt := 0;
                     RecCLE.RESET;
                     RecCLE.SETRANGE(RecCLE."Customer No.", "Sales Invoice Header"."Sell-to Customer No.");
                     RecCLE.SETRANGE(RecCLE."Document No.", "Sales Invoice Header"."No.");
                     IF RecCLE.FINDFIRST THEN BEGIN
                         RecCLE.CALCFIELDS("Remaining Amt. (LCY)", "Amount (LCY)");
                         RemAmt := RecCLE."Remaining Amt. (LCY)";
                         FinalTotal := RecCLE."Amount (LCY)";
                     END;


                     ReportCheck.InitTextVariable;
                     ReportCheck.FormatNoText(AmtInWordNetPayable, RemAmt, ' ');
                     ReportCheck.InitTextVariable;
                     ReportCheck.FormatNoText(AmountInWord, FinalTotal, ' ');*/



                            Disc := 0.0;

                        end;


                    }
                    dataitem(Integer; Integer)
                    {
                        DataItemLinkReference = "Transfer Shipment Header";
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



                    IF OutputNo = 1 THEN BEGIN
                        Title := Text1;
                        Sr_No := 0;
                        SGST_AMOUNT := 0;
                        CGST_AMOUNT := 0;
                        IGST_AMOUNT := 0;
                        Total := 0;
                        TotAmt := 0;
                    END;

                    IF OutputNo = 2 THEN BEGIN
                        Title := Text2;
                        Sr_No := 0;
                        SGST_AMOUNT := 0;
                        CGST_AMOUNT := 0;
                        IGST_AMOUNT := 0;
                        Total := 0;
                        TotAmt := 0;
                    END;

                    IF OutputNo = 3 THEN BEGIN
                        Title := Text3;
                        Sr_No := 0;
                        SGST_AMOUNT := 0;
                        CGST_AMOUNT := 0;
                        IGST_AMOUNT := 0;
                        Total := 0;
                        TotAmt := 0;
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
                    NoOfLoops := ABS(NoOfCopies) + cust."Invoice Copies";
                    IF NoOfLoops <= 0 THEN
                        NoOfLoops := 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF recShipMethod.GET("Shipment Method Code") THEN
                    ShipDesc := recShipMethod.Description;

                StateRec.RESET;
                StateRec.SETRANGE(StateRec.Code, ComponyInfo."State Code");
                IF StateRec.FINDFIRST THEN BEGIN
                    C_GSTINState := StateRec.Code + ' (' + StateRec."State Code (GST Reg. No.)" + ')';
                END;

                Location.RESET;
                StateRec.RESET;
                Location.SETRANGE(Code, "Transfer Shipment Header"."Transfer-to Code");
                IF Location.FINDFIRST THEN BEGIN
                    // Transfer_To_StateCode:=Location."State Code";
                    StateRec.SETRANGE(Code, Location."State Code");
                    IF StateRec.FINDFIRST THEN
                        PlaceOfSupply := StateRec.Code + ' (' + StateRec."State Code (GST Reg. No.)" + ')';
                END;
                //QR++
                IF "Transfer Shipment Header"."MAcknowledgement No." <> '' THEN BEGIN
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
                                // QRCodeFileName := GetQRCode(QRCodeInput);//tk++
                                // QRCodeFileName := MoveToMagicPath(QRCodeFileName);//TK
                                // CLEAR(TempBlob);//tk

                                // ThreeTierMgt.BLOBImport(TempBlob, QRCodeFileName);//tk
                                IF RecEinvoice."Signed QR Code".HASVALUE THEN;

                            END;
                        END;
                    END;
                END;
            end;

            trigger OnPreDataItem()
            begin

                IF ComponyInfo.GET() THEN BEGIN
                    ComponyInfo.CALCFIELDS(Picture);
                END;

                IF StateRec.GET(ComponyInfo."State Code") THEN
                    State := StateRec.Description;
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
        //win355++
        ComponyInfo.GET;

        //win355--
    end;

    trigger OnPreReport()
    begin
        Sr_No := 0;
        maxline := 13;
        linecount := 0;
        spline := 0;
    end;

    var
        ComponyInfo: Record 79;
        FromLocation: Record 14;
        ToLocation: Record 14;
        Location: Record 14;
        StateRec: Record State;
        VendorRec: Record 23;
        ItemRec: Record 27;
        State: Text[50];
        Qty: Decimal;
        QtyBase: Decimal;
        Total: Decimal;
        RatePerItem: Decimal;
        TaxableValue: Decimal;
        GSTDetailLeger: Record "Detailed GST Ledger Entry";
        CGST_RATE: Decimal;
        CGST_AMOUNT: Decimal;
        SGST_RATE: Decimal;
        SGST_AMOUNT: Decimal;
        IGST_RATE: Decimal;
        IGST_AMOUNT: Decimal;
        From_Name: Text[50];
        From_Address: Text[150];
        From_StateCode: Code[20];
        From_State: Text;
        From_GSTIN: Code[20];
        To_Name: Text[50];
        To_Address: Text[150];
        To_StateCode: Code[20];
        To_State: Text;
        To_GSTIN: Code[20];
        Sr_No: Integer;
        "Sr.No": Integer;
        FromCity: Text;
        VendorItemNo: Text[50];
        // StructureLineDetails: Record "13798";//tk
        ChargesAmount: Decimal;
        //ReportCheck: Report Check;
        ReportCheck: Report "Posted Voucher"; //kj
        FinalTotal: Decimal;
        AmountInWord: array[2] of Text;
        From_Address2: Text;
        From_Address1: Text;
        To_Address2: Text;
        To_City: Text;
        recShipMethod: Record 10;
        ShipDesc: Text;
        recILE: Record 32;
        SerialNo: Text;
        IMEI: Text;
        len1: Integer;
        len2: Integer;
        GSTComponentCGST: Text;
        GSTComponentSGST: Text;
        GSTComponentIGST: Text;
        GSTBASEAMNT_: Decimal; //kj 100823
        TaxTotal: Decimal;
        C_GSTINState: Code[20];
        From_GSTState: Text[20];
        To_GSTState: Text[20];
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        OutputNo: Integer;
        Title: Text[50];
        cust: Record 18;
        Text16502: Label 'COPY';
        Text1: Label 'Original for Recipient';
        Text2: Label 'Duplicate for Transporter';
        Text3: Label 'Triplicate Copy';
        Text4: Label 'Quadruplicate';
        TotAmt: Decimal;
        linecount: Integer;
        maxline: Integer;
        spline: Integer;
        From_Tel: Text;
        PlaceOfSupply: Text;
        Disc: Decimal;
        RecEinvoice: Record 50015;
        Streamin: InStream;
        qrtest: Text;
        QRBLOB: BigText;
        ThreeTierMgt: Codeunit 419;
        TempBlob: Codeunit "Temp Blob";
        QRCodeInput: Text;
        QRCodeFileName: Text;
    //tk++

    // local procedure GetQRCode(QRCodeInput: Text) QRCodeFileName: Text
    // var
    //     [RunOnClient]
    //     IBarCodeProvider: DotNet IBarcodeProvider;
    // begin
    //     GetBarCodeProvider(IBarCodeProvider);
    //     QRCodeFileName := IBarCodeProvider.GetBarcode(QRCodeInput);
    // end;


    // procedure GetBarCodeProvider(var IBarCodeProvider: DotNet IBarcodeProvider)
    // var
    //     [RunOnClient]
    //     QRCodeProvider: DotNet QRCodeProvider;
    // begin
    //     QRCodeProvider := QRCodeProvider.QRCodeProvider;
    //     IBarCodeProvider := QRCodeProvider;
    // end;


    // procedure MoveToMagicPath(SourceFileName: Text) DestinationFileName: Text
    // var
    //     FileSystemObject: Automation;
    // begin
    //     // User Temp Path

    //     DestinationFileName := ThreeTierMgt.ClientTempFileName('');
    //     IF ISCLEAR(FileSystemObject) THEN
    //         CREATE(FileSystemObject, TRUE, TRUE);
    //     FileSystemObject.MoveFile(SourceFileName, DestinationFileName);
    // end;

    // local procedure CreateQRCodeInput1(Line: Code[10]; TMLPONo: Code[20]) QRCodeInput: Text
    // begin
    //     QRCodeInput := TMLPONo + Line;
    // end;//tk--
}


