xmlport 50052 "VLEUPDATE"
{

    Format = VariableText;
    Direction = Import;
    Permissions = TableData "Vendor Ledger Entry" = rimd;


    schema
    {
        textelement(root)
        {
            MinOccurs = Zero;
            tableelement("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                AutoSave = false;
                XmlName = 'VENDLedgerEntryUpdate';
                UseTemporary = true;
                textelement(ENTRYNO)
                {
                }
                textelement(DueDate)
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
                    If ENTRYNO <> '' then
                        Evaluate(EntryNoD, ENTRYNO);


                    ILE.RESET;
                    ILE.SETRANGE(ILE."Entry No.", EntryNoD);
                    IF ILE.FindFirst() THEN
                        REPEAT

                            If DueDate <> '' then begin
                                EVALUATE(DueDate1, format(DueDate, 0, 9));
                                ILE."Due Date" := DueDate1;
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

    end;

    var

        EntryNoD: Integer;

        LineNo: Integer;
        DueDate1: Date;


        ILE: Record "Vendor Ledger Entry";



}

