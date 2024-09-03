xmlport 50060 "Import Item Open Bal Serial no"
{
    Format = VariableText;
    Direction = Import;


    schema
    {
        textelement(ROOT)
        {
            tableelement("Item Journal Line"; "Item Journal Line")
            {
                AutoSave = false;
                ///AutoReplace = true;

                XmlName = 'ITEMJnlLine';
                fieldelement(JournalTemplateName; "Item Journal Line"."Journal Template Name")
                {
                }
                fieldelement(JournalBatchName; "Item Journal Line"."Journal Batch Name")
                {
                }
                fieldelement(LineNo; "Item Journal Line"."Line No.")
                {
                }

                fieldelement(PostingDate; "Item Journal Line"."Posting Date")
                {
                }
                fieldelement(DocumentDate; "Item Journal Line"."Document Date")
                {
                }
                fieldelement(EntryTy; "Item Journal Line"."Entry Type")
                {
                }
                fieldelement(DocNo; "Item Journal Line"."Document No.")
                {
                }
                fieldelement(EXTDocNo; "Item Journal Line"."External Document No.")
                {
                }
                fieldelement(ItemNo; "Item Journal Line"."Item No.")
                {
                }
                fieldelement(UnitofMeasureCode; "Item Journal Line"."Unit of Measure Code")
                {
                }
                fieldelement(Des; "Item Journal Line".Description)
                {
                }
                fieldelement(Loc; "Item Journal Line"."Location Code")
                {
                }
                fieldelement(MRP; "Item Journal Line"."MRP Value")
                {
                }
                fieldelement(UPNCODE; "Item Journal Line"."UPN Code")
                {
                }
                fieldelement(Qty; "Item Journal Line".Quantity)
                {
                }
                fieldelement(UNITCOST; "Item Journal Line"."Unit Cost")
                {
                }
                fieldelement(UNITAMOUNT; "Item Journal Line"."Unit Amount")
                {
                }
                fieldelement(AMOUNT; "Item Journal Line".Amount)
                {
                }
                fieldelement(BRANCH; "Item Journal Line"."Shortcut Dimension 1 Code")
                {
                }
                fieldelement(VERTICAL; "Item Journal Line"."Shortcut Dimension 2 Code")
                {
                }
                textelement(TLineNO)
                {
                    MinOccurs = Zero;
                }
                textelement(TSRNNO)
                {
                    MinOccurs = Zero;
                }

                textelement(TSRNQTY)
                {
                    MinOccurs = Zero;
                }
                textelement(IMENO)
                {
                    MinOccurs = Zero;
                }
                textelement(TEXPDATE)
                {
                    MinOccurs = Zero;
                }

                trigger OnAfterInsertRecord()
                begin

                    if LineNo1 <> "Item Journal Line"."Line No." then begin


                        IJ.RESET;
                        IJ.SETRANGE(IJ."Journal Template Name", "Item Journal Line"."Journal Template Name");
                        IJ.SETRANGE(IJ."Journal Batch Name", "Item Journal Line"."Journal Batch Name");
                        IF IJ.FINDLAST THEN
                            LineNo1 := IJ."Line No."
                        ELSE
                            LineNo1 := 0;

                        IJL.INIT;
                        IJL."Journal Template Name" := "Item Journal Line"."Journal Template Name";
                        IJL."Journal Batch Name" := "Item Journal Line"."Journal Batch Name";
                        //IJL."Line No." := LineNo1 + 10000;
                        IJL."Line No." := "Item Journal Line"."Line No.";
                        //IJL."Source Code" := 'ITEMJNL';
                        IF IJL.INSERT(TRUE) THEN;

                        IJL.VALIDATE(IJL."Posting Date", "Item Journal Line"."Posting Date");
                        IJL.VALIDATE(IJL."Document Date", "Item Journal Line"."Document Date");
                        IJL.VALIDATE(IJL."Entry Type", "Item Journal Line"."Entry Type");
                        IJL.VALIDATE(IJL."Document No.", "Item Journal Line"."Document No.");
                        IJL.VALIDATE(IJL."External Document No.", "Item Journal Line"."External Document No.");
                        IJL.VALIDATE(IJL."Item No.", "Item Journal Line"."Item No.");
                        IJL.VALIDATE(IJL."Unit of Measure Code", "Item Journal Line"."Unit of Measure Code");
                        IJL.Validate(IJL.Description, "Item Journal Line".Description);
                        IJL.Validate("Location Code", "Item Journal Line"."Location Code");
                        IJL.VALIDATE(IJL."MRP Value", "Item Journal Line"."MRP Value");
                        IJL.VALIDATE(IJL."UPN Code", "Item Journal Line"."UPN Code");
                        IJL.VALIDATE(IJL.Quantity, "Item Journal Line".Quantity);
                        IJL.VALIDATE(IJL."Unit Cost", "Item Journal Line"."Unit Cost");
                        IJL.VALIDATE(IJL."Unit Amount", "Item Journal Line"."Unit Amount");
                        IJL.VALIDATE(IJL.Amount, "Item Journal Line".Amount);
                        IJL.VALIDATE("Shortcut Dimension 1 Code", "Item Journal Line"."Shortcut Dimension 1 Code");
                        IJL.VALIDATE("Shortcut Dimension 2 Code", "Item Journal Line"."Shortcut Dimension 2 Code");
                        IJL.MODIFY(TRUE);
                        CreateReservEntry(IJL);
                        //END;
                    end;
                    LineNo1 := "Item Journal Line"."Line No."

                end;
            }
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
        ItemNo: Code[20];
        Qty: Decimal;
        Loc: Code[10];
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
        ReturnFrom: Text[30];
        BinCode: Code[10];
        Vend: Code[20];
        Length: Decimal;
        INTLINENO: Integer;
        SRNNO: Code[20];

        ReservationEntry: Record "Reservation Entry";
        Lotqty: Decimal;
        //
        ReservationEntry1: Record "Reservation Entry";
        Lotexp: date;
        Serial: Code[20];
        LotDC: Code[20];

        Varnt: Code[20];
        GCode: Code[20];
        IJ: Record "Item Journal Line";
        RE: Record "Reservation Entry";
        ExtDocNo: Code[20];
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
        IF TLineNO <> '' THEN
            EVALUATE(INTLINENO, TLineNO);
        REntry."Source Ref. No." := INTLINENO;
        // If TSRNNO<>'' then
        // Evaluate(SRNNO,TSRNNO)
        // REntry."Serial No.":=TSRNNO;
        REntry.VALIDATE(REntry."Qty. per Unit of Measure", ItemJL."Qty. per Unit of Measure");

        REntry.VALIDATE(REntry."Serial No.", TSRNNO);
        REntry.Validate(REntry."MRP Value", "Item Journal Line"."MRP Value");
        IF TEXPDATE <> '' THEN BEGIN
            EVALUATE(Lotexp, TEXPDATE);
            REntry.VALIDATE("Expiration Date", Lotexp);
        END;
        REntry."Created By" := USERID;
        IF ItemJL."Entry Type" = ItemJL."Entry Type"::"Positive Adjmt." THEN BEGIN
            REntry.VALIDATE(REntry.Positive, TRUE);
            IF TSRNQTY <> '' THEN BEGIN
                EVALUATE(Lotqty, TSRNQTY);
                REntry.VALIDATE(Quantity, Lotqty);
                REntry.VALIDATE("Quantity (Base)", Lotqty);
            END;
            REntry.Positive := TRUE;
        END;
        IF ItemJL."Entry Type" = ItemJL."Entry Type"::"Negative Adjmt." THEN BEGIN
            IF TSRNQTY <> '' THEN BEGIN
                EVALUATE(Lotqty, TSRNQTY);
                REntry.VALIDATE(Quantity, -1 * Lotqty);
                REntry.VALIDATE("Quantity (Base)", -1 * Lotqty);
            END;
            REntry.Positive := FALSE;
        END;
        REntry.INSERT;
    end;
}

