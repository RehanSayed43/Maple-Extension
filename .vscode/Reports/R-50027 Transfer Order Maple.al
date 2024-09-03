report 50027 "Transfer Order Maple"
{
    DefaultLayout = RDLC;
    RDLCLayout = './TransferOrderMaple.rdl';
    ApplicationArea = FixedAsset;

    dataset
    {
        dataitem("Transfer Shipment Header"; "Transfer Shipment Header")
        {
            column(CompName; comp.Name)
            {
            }
            column(Logo; comp.Picture)
            {
            }
            column(CompAddr; comp.Address)
            {
            }
            column(CompAddr2; comp."Address 2")
            {
            }
            column(CompCity; comp.City)
            {
            }
            column(CinNo; comp."CIN no")
            {
            }
            column(Fax; comp."Fax No.")
            {
            }
            column(Email; comp."E-Mail")
            {
            }
            column(PostCd; comp."Post Code")
            {
            }
            column(Phone_No; comp."Phone No.")
            {
            }
            column(PANNo; comp."P.A.N. No.")
            {
            }
            column(InvNo; "Transfer Shipment Header"."No.")
            {
            }
            column(TransferfromName_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-from Name")
            {
            }
            column(TransferfromAddress_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-from Address")
            {
            }
            column(TransferfromAddress2_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-from Address 2")
            {
            }
            column(TransferfromPostCode_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-from Post Code")
            {
            }
            column(TransferfromCity_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-from City")
            {
            }
            column(TransferfromCounty_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-from County")
            {
            }
            column(TransfertoCode_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-to Code")
            {
            }
            column(TransfertoName_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-to Name")
            {
            }
            column(TransfertoAddress_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-to Address")
            {
            }
            column(TransfertoAddress2_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-to Address 2")
            {
            }
            column(TransfertoPostCode_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-to Post Code")
            {
            }
            column(TransfertoCity_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-to City")
            {
            }
            column(TransfertoCounty_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-to County")
            {
            }
            column(TrsftoCountryRegionCode_TransferShipmentHeader; "Transfer Shipment Header"."Trsf.-to Country/Region Code")
            {
            }
            column(TransferOrderDate_TransferShipmentHeader; "Transfer Shipment Header"."Transfer Order Date")
            {
            }
            column(PostingDate_TransferShipmentHeader; "Transfer Shipment Header"."Posting Date")
            {
            }
            column(Comment_TransferShipmentHeader; "Transfer Shipment Header".Comment)
            {
            }
            column(TransferOrderNo_TransferShipmentHeader; "Transfer Shipment Header"."Transfer Order No.")
            {
            }
            column(ShipmentDate_TransferShipmentHeader; "Transfer Shipment Header"."Shipment Date")
            {
            }
            column(VehicleNo_TransferShipmentHeader; "Transfer Shipment Header"."Vehicle No.")
            {
            }
            column(ModeofTransport_TransferShipmentHeader; "Transfer Shipment Header"."Mode of Transport")
            {
            }
            column(TransporterName_TransferShipmentHeader; "Transfer Shipment Header"."Transporter Name")
            {
            }
            column(LRAWBNo_TransferShipmentHeader; "Transfer Shipment Header"."LR/AWB No.")
            {
            }
            column(LRAWBDate_TransferShipmentHeader; "Transfer Shipment Header"."LR/AWB Date")
            {
            }
            column(NoofBoxes_TransferShipmentHeader; "Transfer Shipment Header"."No of Boxes")
            {
            }
            // column(TINNo; Loctn."T.I.N. No.")
            // {
            // }
            // column(ServTaxNo; Loctn."Service Tax Registration No.")
            // {
            // }
            // column(CSTNo; Loctn."C.S.T No.")
            // {
            // }
            // column(TINNo1; RecLocation."T.I.N. No.")
            // {
            // }
            // column(CSTNo1; RecLocation."C.S.T No.")
            // {
            // }
            // column(ServTaxNo1; RecLocation."Service Tax Registration No.")
            // {
            // }
            column(AmounttoWord; AmounttoWord[1])
            {
            }
            dataitem("Transfer Shipment Line"; "Transfer Shipment Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(srno; srno)
                {
                }
                column(vendorPartCode; RecItem."Vendor Part Code Long")
                {
                }
                column(ItemNo_TransferShipmentLine; "Transfer Shipment Line"."Item No.")
                {
                }
                column(Quantity_TransferShipmentLine; "Transfer Shipment Line".Quantity)
                {
                }
                column(UnitofMeasure_TransferShipmentLine; "Transfer Shipment Line"."Unit of Measure")
                {
                }
                column(Description_TransferShipmentLine; "Transfer Shipment Line".Description)
                {
                }
                column(UnitPrice_TransferShipmentLine; "Transfer Shipment Line"."Unit Price")
                {
                }
                column(Amount_TransferShipmentLine; "Transfer Shipment Line".Amount)
                {
                }
                // column(ChargestoTransfer_TransferShipmentLine; "Transfer Shipment Line"."Charges to Transfer")
                // {
                // }
                // column(UnitCost_TransferShipmentLine; "Transfer Shipment Line"."Unit Cost")
                // {
                // }

                trigger OnAfterGetRecord()
                begin
                    IF cnt = 1 THEN BEGIN
                        comp.GET;
                        comp.CALCFIELDS(comp.Picture);
                    END;
                    cnt += 1;
                    IF cnt = 3 THEN
                        CLEAR(comp);

                    srno += 1;

                    RecItem.GET("Transfer Shipment Line"."Item No.");
                end;

                trigger OnPreDataItem()
                begin
                    srno := 0;
                    LinesCount := "Transfer Shipment Line".COUNT;
                end;
            }
            dataitem(Integer; Integer)
            {
                column(Number; Integer.Number)
                {
                }

                trigger OnPreDataItem()
                begin
                    IF LinesCount <= 30 THEN BEGIN
                        IF (LinesCount MOD MaxLines > 0) THEN BEGIN
                            CalLin := MaxLines - (LinesCount MOD MaxLines);
                            //CalLin :=(LinesCount MOD MaxLines);
                            Integer.SETRANGE(Number, 1, CalLin);
                        END
                    END
                    ELSE
                        Integer.SETRANGE(Number, 1, 1);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                TotalAmount := 0;

                Loctn.GET("Transfer Shipment Header"."Transfer-from Code");
                RecLocation.GET("Transfer Shipment Header"."Transfer-to Code");

                TransfLine.RESET;
                TransfLine.SETRANGE(TransfLine."Document No.", "Transfer Shipment Header"."No.");
                IF TransfLine.FINDFIRST THEN BEGIN
                    REPEAT
                        TotalAmount += TransfLine.Amount;
                    UNTIL TransfLine.NEXT = 0;
                END;

                //CheckRep.InitTextVariable;
                //CheckRep.FormatNoText(AmounttoWord,TotalAmount,GenJNLLine."Currency Code");   //"Purchase Header"."Currency Code"
                //message('%1',AmounttoWord);

                //GLSETUP.GET;
                CheckRep.InitTextVariable;
                //IF "Purchase Header"."Currency Code"='' THEN
                //CheckRep.FormatNoText(AmounttoWord,TotalAmount,GLSETUP."LCY Code")
                //ELSE
                CheckRep.FormatNoText(AmounttoWord, TotalAmount, '');
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
        cnt := 1;
        MaxLines := 30;
    end;

    var
        RecItem: Record "Item";
        RecLocation: Record Location;
        cnt: Integer;
        comp: Record "Company Information";
        srno: Integer;
        vattinno: Code[30];
        csttinno: Code[30];
        ServTaxNo: Code[30];
        PANNo: Code[30];
        vattinno1: Code[30];
        csttinno1: Code[30];
        ServTaxNo1: Code[30];
        Loctn: Record Location;
        CheckRep: Report 1401;
        AmounttoWord: array[2] of Text[250];
        TotalAmount: Decimal;
        GLSETUP: Record "General Ledger Setup";
        TransfLine: Record "Transfer Line";
        MaxLines: Integer;
        LinesCount: Integer;
        CalLin: Integer;
}

