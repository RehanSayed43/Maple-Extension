xmlport 50200 "Item Revaluation Import"
{
    Format = VariableText;
    Direction = Import;
    FieldDelimiter = '"';
    FieldSeparator = ',';
    TextEncoding = WINDOWS;
    Permissions = tabledata 83 = rimd;
    schema
    {
        textelement(root)
        {
            tableelement(Integers; Integer)
            {
                AutoSave = false;
                AutoUpdate = false;
                AutoReplace = false;
                UseTemporary = true;
                // textelement("BatchName")
                // {
                //     XmlName = 'BatchName';
                // }
                textelement("PostingDate")
                {
                    XmlName = 'PostingDate';
                }
                textelement("DocumentNo")
                {
                    XmlName = 'DocumentNo';
                }
                textelement("ItemNo")
                {
                    XmlName = 'ItemNo';
                }
                textelement("Applies-toEntry")
                {
                    XmlName = 'Applies-toEntry';
                }
                // textelement("Description")
                // {
                //     XmlName = 'Description';
                // }
                // textelement("GenBusPostingGroup")
                // {
                //     XmlName = 'GenBusPostingGroup';
                // }
                // textelement("LocationCode")
                // {
                //     XmlName = 'LocationCode';
                // }
                // textelement("Quantity")
                // {
                //     XmlName = 'Quantity';
                // }
                // textelement("Amount")
                // {
                //     XmlName = 'Amount';
                // }
                // textelement("UnitCostCalculated")
                // {
                //     XmlName = 'UnitCostCalculated';
                // }
                // textelement("InventoryValueCalculated")
                // {
                //     XmlName = 'InventoryValueCalculated';
                // }
                // textelement("UnitCostRevalued")
                // {
                //     XmlName = 'UnitCostRevalued';
                // }
                textelement("InventoryValueRevalued") // AVISHEK//
                {
                    XmlName = 'InventoryValueRevalued';
                }

                trigger OnPreXmlItem()
                begin
                    LinNo := 1000;
                    ItemJour.Reset();
                    ItemJour.SetRange("Journal Template Name", 'REVALal');
                    ItemJour.SetRange("Journal Batch Name", 'DEFAULT');
                    ItemJour.DeleteAll();
                end;

                trigger OnAfterInsertRecord()
                var
                    unitcostrev: Decimal;
                    applentry: Integer;
                    posdate: Date;
                begin
                    Clear(ItemJour);
                    ItemJour.Init();
                    ItemJour."Journal Template Name" := 'REVAL';
                    ItemJour."Journal Batch Name" := 'DEFAULT';
                    ItemJour."Document No." := DocumentNo;
                    //ItemJour."External Document No." := "G/L Acc No.";
                    ItemJour."Line No." := LinNo;
                    Evaluate(posdate, PostingDate);
                    ItemJour.Validate("Posting Date", posdate);
                    ItemJour.Validate(ItemJour."Value Entry Type", ItemJour."Value Entry Type"::Revaluation);
                    ItemJour.Validate("Item No.", ItemNo);
                    Evaluate(applentry, "Applies-toEntry");
                    ItemJour.Validate("Applies-to Entry", applentry);
                    //CalcFields("Net Change");
                    Evaluate(unitcostrev, InventoryValueRevalued);
                    ItemJour.Validate("Inventory Value (Revalued)", unitcostrev);
                    //ItemJour.Validate("Gen. Prod. Posting Group", 'DIRECT EXP');
                    LinNo += 10000;
                    ItemJour.Insert();
                end;


            }
        }
    }





    var
        //ILE: Record "Item Ledger Entry";
        LinNo: Integer;
        RevJournalPage: Page "Revaluation Journal";
        ItemJour: Record "Item Journal Line";
}