xmlport 50062 "ItemOpening"
{

    Format = VariableText;
    Direction = Import;




    schema
    {
        textelement(ROOT)
        {
            tableelement(Integer; Integer)
            {
                // AutoReplace = false;
                AutoSave = false;
                // AutoUpdate = false;
                XmlName = 'ItemJnl';
                // UseTemporary = true;
                textelement(JournalTemplateName)
                {
                    MinOccurs = Once;
                }
                textelement(JournalBatchName)
                {
                    MinOccurs = Zero;
                }
                textelement(LineNo)
                {
                    MinOccurs = Zero;
                }
                textelement(PostingDate)
                {
                    MinOccurs = Zero;
                }
                textelement(DocumentDate)
                {
                    MinOccurs = Zero;
                }
                textelement(EntryTy)//6
                {
                    MinOccurs = Zero;
                }
                textelement(DocNo)
                {
                    MinOccurs = Zero;
                }
                textelement(EXTDocNO)
                {
                    MinOccurs = Zero;
                }
                textelement(ItemNo)
                {
                    MinOccurs = Zero;
                }
                // textelement(DescriptionTEXT)
                // {
                //     MinOccurs = Zero;
                // }
                textelement(UOM)
                {
                    MinOccurs = Zero;
                }



                textelement(loc)
                {
                    MinOccurs = Zero;
                }


                textelement(MRPValue)
                {
                    MinOccurs = Zero;
                }
                textelement(UPNCODE)
                {
                    MinOccurs = Zero;
                }
                textelement(Qty)
                {
                    MinOccurs = Zero;
                }
                textelement(UnitCost)
                {
                    MinOccurs = Zero;
                }
                textelement(UnitAmt)
                {
                    MinOccurs = Zero;
                }
                textelement(Amount)
                {
                    MinOccurs = Zero;
                }
                textelement(GlobalDim1)
                {
                    MinOccurs = Zero;
                }
                textelement(GlobalDim2)
                {
                    MinOccurs = Zero;
                }
                textelement(TLineNO)
                {
                    MinOccurs = Zero;
                }
                textelement(TSRNO)
                {
                    MinOccurs = Zero;
                }

                textelement(TLOTQTY)
                {
                    MinOccurs = Zero;
                }
                textelement(TIMEINO)
                {
                    MinOccurs = Zero;
                }
                textelement(TEXPDATE)
                {
                    MinOccurs = Zero;
                }

                trigger OnAfterInsertRecord()
                begin

                    if TXTLINENO <> LineNO then begin//tk
                        IJ.RESET;
                        IJ.SETRANGE(IJ."Journal Template Name", JournalTemplateName);
                        IJ.SETRANGE(IJ."Journal Batch Name", JournalBatchName);
                        IF IJ.FINDLAST THEN
                            LineNo1 := IJ."Line No."
                        ELSE
                            LineNo1 := 0;

                        IJL.INIT;
                        IJL."Journal Template Name" := JournalTemplateName;
                        IJL."Journal Batch Name" := JournalBatchName;
                        IJL."Line No." := LineNo1 + 10000;
                        IJL."Source Code" := 'ITEMJNL';
                        IF IJL.INSERT(TRUE) THEN;
                        IF PostingDate <> '' THEN BEGIN
                            EVALUATE(IJPostineDate, PostingDate);
                            IJL.VALIDATE("Posting Date", IJPostineDate);
                        End;
                        IF DocumentDate <> '' THEN BEGIN
                            EVALUATE(IJDOCDate, DocumentDate);
                            IJL.VALIDATE("Document date", IJDOCDate);
                        END;
                        EVALUATE(EntryType, EntryTy);

                        IJL.Validate(IJL."Entry Type", EntryType);
                        IJL.VALIDATE(IJL."Document No.", DocNo);
                        IJL.VALIDATE(IJL."External Document No.", EXTDocNO);
                        IJL.VALIDATE(IJL."Item No.", ItemNo);
                        If RECITEM.Get(IJL."Item No.") then begin
                            IJL.Validate(IJL.Description, RECITEM.Description);
                        end;

                        IJL.VALIDATE(IJL."Unit of Measure Code", UOM);


                        IJL."Location Code" := Loc;
                        If MRPValue <> '' then begin
                            Evaluate(MRPVALUE1, MRPValue);
                            IJL.Validate("MRP Value", MRPValue1);
                        End;
                        IJL.Validate(IJL."UPN Code", UPNCODE);
                        If Qty <> '' then begin
                            Evaluate(Qty1, Qty);
                            IJL.VALIDATE(IJL.Quantity, Qty1);
                        end;
                        If UnitCost <> '' then Begin
                            Evaluate(UnitCost1, UnitCost);
                            IJL.VALIDATE(IJL."Unit Cost", UnitCost1);
                        End;
                        If UnitAmt <> '' then begin
                            Evaluate(UnitAmt1, UnitAmt);
                            IJL.VALIDATE(IJL."Unit Amount", UnitAmt1);
                        End;
                        If Amount <> '' then begin
                            Evaluate(Amount1, Amount);
                            IJL.VALIDATE(IJL."Amount", Amount1);
                        end;
                        IJL.VALIDATE("Shortcut Dimension 1 Code", GlobalDim1);
                        IJL.VALIDATE("Shortcut Dimension 2 Code", GlobalDim2);
                        IJL.MODIFY(TRUE);
                        TXTLINENO := LineNO;//tk


                    end;//tk
                    CreateReservEntry(IJL);
                End;
            }
        }
    }

    requestpage//
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnPostXmlPort()
    begin
        MESSAGE('Uploaded Successfully');
    end;

    trigger OnPreXmlPort()
    begin
        // LastResEntry.RESET;

        // IF LastResEntry.FINDLAST THEN
        //     lastEntryNo := LastResEntry."Entry No." + 1
        // ELSE
        //     lastEntryNo := 1;
        SkipFirstLine := TRUE;
    end;

    var
        PostDate: Date;
        ItemName: text[100];
        RECITEM: Record 27;
        UnitCost1: Decimal;
        Amount1: Decimal;
        ItemNo1: Code[20];
        Qty1: Decimal;
        MRPVALUE1: Decimal;
        Description: text[100];
        UnitAmt1: Decimal;
        Loc1: Code[10];
        lastEntryNo: Integer;
        IJL: Record "Item Journal Line";


        LineNo1: integer;

        LastResEntry: Record "Reservation Entry";
        recResEntry: Record "Reservation Entry";
        EType: Integer;
        DocNumber: Code[20];
        SCode: Code[20];
        MRPrice: Decimal;
        Lotno: Code[20];
        LineNo2: Integer;

        txtitemno: code[20];
        UCost: Decimal;
        VendNo: Code[20];


        BinCode: Code[10];
        Vend: Code[20];
        Length: Decimal;
        INTLINENO: Integer;

        ReservationEntry: Record "Reservation Entry";
        Lotqty: Decimal;
        //
        ReservationEntry1: Record "Reservation Entry";
        Lotexp: date;
        IJPostineDate: date;
        IJDOCDate: date;

        EntryType: Option "Purchase","Sale","Positive Adjmt.","Negative Adjmt.","Transfer","Consumption","Output","Assembly Consumption","Assembly Output";
        Serial: Code[20];
        LotDC: Code[20];

        Varnt: Code[20];
        GCode: Code[20];

        TXTLINENO: Code[20];
        IJ: Record "Item Journal Line";
        RE: Record "Reservation Entry";
        ExtDocNo1: Code[20];
        JobType: Option " ","Block Printing",Embroidery,Fusing,Swarsky,"Dyeing & Printing",Sampling,Lacing,Calendering,Waterfall,Book,Hanger;
        LinNo: Integer;
        SkipFirstLine: Boolean;

    procedure CreateReservEntry(ItemJL: Record "Item Journal Line")
    var
        REntry: Record "Reservation Entry";
        ENo: Integer;
    begin
        RE.RESET;
        IF RE.FINDLAST THEN
            ENo := RE."Entry No." + 1
        ELSE
            ENo := 1;

        REntry.INIT;
        REntry."Entry No." := ENo;
        REntry.VALIDATE("Item No.", ItemJL."Item No.");
        REntry.VALIDATE("Location Code", ItemJL."Location Code");
        REntry."Reservation Status" := REntry."Reservation Status"::Prospect;
        REntry."Item Tracking" := REntry."Item Tracking"::"Serial No.";
        REntry."Source Type" := 83;
        IF ItemJL."Entry Type" = itemJl."Entry Type"::"Positive Adjmt." THEN
            REntry."Source Subtype" := 2;
        IF ItemJL."Entry Type" = itemJl."Entry Type"::"Negative Adjmt." THEN
            REntry."Source Subtype" := 3;
        REntry."Source ID" := ItemJL."Journal Template Name";
        REntry."Source Batch Name" := ItemJL."Journal Batch Name";
        IF LineNO <> '' THEN
            EVALUATE(INTLINENO, LineNO);
        REntry."Source Ref. No." := INTLINENO;
        REntry.VALIDATE(REntry."Qty. per Unit of Measure", ItemJL."Qty. per Unit of Measure");
        REntry.VALIDATE(REntry."Serial No.", TSRNO);
        REntry.Validate(REntry."MRP Value", IJL."MRP Value");
        REntry.Validate(REntry."IMEI No.", TIMEINO);
        IF TEXPDATE <> '' THEN BEGIN
            EVALUATE(Lotexp, TEXPDATE);
            REntry.VALIDATE("Expiration Date", Lotexp);
        END;
        REntry."Created By" := USERID;
        IF (ItemJL."Entry Type" = ItemJL."Entry Type"::"Positive Adjmt.") OR (ItemJL."Entry Type" = ItemJL."Entry Type"::Purchase) THEN BEGIN
            REntry.VALIDATE(REntry.Positive, TRUE);
            IF TLOTQTY <> '' THEN BEGIN
                EVALUATE(Lotqty, TLOTQTY);
                REntry.VALIDATE("Quantity (Base)", Lotqty);
                REntry.VALIDATE(Quantity, Lotqty);
                REntry.VALIDATE("Qty. to Handle (Base)", Lotqty);
                REntry.VALIDATE("Qty. to Invoice (Base)", Lotqty);
            END;
            REntry.Positive := TRUE;
        END;
        IF ItemJL."Entry Type" = ItemJL."Entry Type"::"Negative Adjmt." THEN BEGIN
            IF TLOTQTY <> '' THEN BEGIN
                EVALUATE(Lotqty, TLOTQTY);
                REntry.VALIDATE("Quantity (Base)", -1 * Lotqty);
                REntry.VALIDATE(Quantity, -1 * Lotqty);
                REntry.VALIDATE("Qty. to Handle (Base)", -1 * Lotqty);
                REntry.VALIDATE("Qty. to Invoice (Base)", -1 * Lotqty);

            END;
            REntry.Positive := FALSE;
        END;
        REntry.INSERT;
    end;
}

