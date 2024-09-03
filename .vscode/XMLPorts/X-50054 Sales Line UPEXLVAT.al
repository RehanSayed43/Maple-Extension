xmlport 50054 "SalesLineUPDATE"
{

    Format = VariableText;
    Direction = Import;
    Permissions = TableData "Sales Line" = rimd;

    schema
    {
        textelement(root)
        {
            MinOccurs = Zero;
            tableelement("Sales Line"; "Sales Line")
            {
                AutoSave = false;
                XmlName = 'SalesLine';
                UseTemporary = true;

                textelement(DocNo)
                {
                }

                textelement(Item)
                {
                }
                textelement(LineNotext)
                {
                }
                textelement(MRPVALUE)
                {
                    MinOccurs = Zero;
                }

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin

                end;

                trigger OnAfterInsertRecord()
                begin
                    //LFS-AY++

                    If DocNo <> '' then
                        EVALUATE(DocumentNo, DocNo);
                    if item <> '' then
                        EVALUATE(ItemNo, Item);
                    if LineNotext <> '' then
                        EVALUATE(LineNo, LineNotext);
                    ILE.RESET;
                    ILE.SETRANGE(ILE."Document No.", DocumentNo);
                    ILE.SETRANGE(ILE."No.", ItemNo);
                    ILE.SETRANGE(ILE."Line No.", LineNo);
                    IF ILE.FindFirst() THEN
                        REPEAT
                            If MRPVALUE <> '' then begin
                                Evaluate(MRPValueD, MRPVALUE);
                                ILE.Validate("Unit Price", MRPValueD);
                                ILE.Validate("Line Amount", MRPValueD);
                            end;
                            //   Message('%1', ILE."MRP Value");



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


        ILE: Record "Sales Line";
        SerialNo: Code[20];


}

