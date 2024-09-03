xmlport 50050 "ILEUPDATE"
{

    Format = VariableText;
    Direction = Import;
    Permissions = TableData "Item Ledger Entry" = rimd;

    schema
    {
        textelement(root)
        {
            MinOccurs = Zero;
            tableelement("Item Ledger Entry"; "Item Ledger Entry")
            {
                AutoSave = false;
                XmlName = 'ITEMLedgerEntry1';
                UseTemporary = true;
                textelement(ENTRYNO)
                {
                }
                textelement(DocNo)
                {
                }
                textelement(Item)
                {
                }
                textelement(MRPVALUE)
                {
                    MinOccurs = Zero;
                }
                textelement(IMEINO)
                {
                    MinOccurs = zero;
                }
                textelement(SRNO)
                {
                    MinOccurs = zero;
                }
                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin

                end;

                trigger OnAfterInsertRecord()
                begin
                    //LFS-AY++
                    If ENTRYNO <> '' then
                        Evaluate(EntryNoD, ENTRYNO);
                    If DocNo <> '' then
                        EVALUATE(DocumentNo, DocNo);
                    if item <> '' then
                        EVALUATE(ItemNo, Item);
                    ILE.RESET;
                    ILE.SETRANGE(ILE."Entry No.", EntryNoD);
                    ILE.SETRANGE(ILE."Document No.", DocumentNo);
                    ILE.SETRANGE(ILE."Item No.", ItemNo);
                    IF ILE.FindFirst() THEN
                        REPEAT
                            If MRPVALUE <> '' then begin
                                Evaluate(MRPValueD, MRPVALUE);
                                ILE."MRP Value" := MRPValueD;
                            end;
                            //   Message('%1', ILE."MRP Value");
                            If IMEINO <> '' then begin
                                Evaluate(IMEVALUED, IMEINO);
                                ILE."IMEI No." := IMEVALUED;
                            end;
                            If SRNO <> '' then begin
                                Evaluate(SerialNo, SRNO);
                                ILE."Serial No." := SerialNo;
                            end;


                            ILE.MODIFY();
                        UNTIL ILE.NEXT = 0;


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
        MESSAGE('Updated!')
    end;

    trigger OnPreXmlPort()
    begin
        //Window.OPEN('Generating statements for #1##########\' + 'BarcodeNo' + Item);// #2###########');
    end;

    var
        DocumentNo: code[20];
        EntryNoD: Integer;
        MRPValueD: Decimal;
        IMEVALUED: Code[20];
        ItemNo: Code[20];
        LineNo: Integer;


        ILE: Record "Item Ledger Entry";
        SerialNo: Code[20];


}

