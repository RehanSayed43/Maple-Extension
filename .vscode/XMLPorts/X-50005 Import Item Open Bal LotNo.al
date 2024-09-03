xmlport 50005 "Import Item Open Bal Lot No"
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Item Journal Line"; "Item Journal Line")
            {
                XmlName = 'ItemJournalLine';
                fieldelement(ItemJournalLine_JournalTemplateName; "Item Journal Line"."Journal Template Name")
                {
                }
                fieldelement(ItemJournalLine_JournalBatchName; "Item Journal Line"."Journal Batch Name")
                {
                }
                fieldelement(ItemJournalLine_DocumentNo; "Item Journal Line"."Document No.")
                {
                }
                fieldelement(ItemJournalLine_LineNo; "Item Journal Line"."Line No.")
                {
                }
                fieldelement(ItemJournalLine_ItemNo; "Item Journal Line"."Item No.")
                {
                }
                fieldelement(ItemJournalLine_PostingDate; "Item Journal Line"."Posting Date")
                {
                }
                fieldelement(ItemJournalLine_EntryType; "Item Journal Line"."Entry Type")
                {
                }
                fieldelement(ItemJournalLine_LocationCode; "Item Journal Line"."Location Code")
                {
                }
                fieldelement(ItemJournalLine_Quantity; "Item Journal Line".Quantity)
                {
                }
                fieldelement(ItemJournalLine_Amount; "Item Journal Line".Amount)
                {
                }
                textelement(lotno1)
                {
                    Unbound = false;
                    XmlName = 'LotNo';
                }

                trigger OnAfterGetRecord()
                begin
                    MESSAGE(LotNo1);
                end;

                trigger OnAfterInsertRecord()
                begin
                    ResEntry.RESET;
                    IF ResEntry.FINDLAST THEN
                        LastEntryNo := ResEntry."Entry No." + 1
                    ELSE
                        LastEntryNo := 1;

                    ResEntry.INIT;
                    ResEntry."Entry No." := LastEntryNo;
                    ResEntry."Source ID" := "Item Journal Line"."Journal Template Name";
                    ResEntry."Source Batch Name" := "Item Journal Line"."Journal Batch Name";
                    ResEntry."Source Ref. No." := "Item Journal Line"."Line No.";
                    ResEntry.VALIDATE(ResEntry."Item No.", "Item Journal Line"."Item No.");
                    ResEntry."Location Code" := "Item Journal Line"."Location Code";
                    ResEntry.VALIDATE(ResEntry."Quantity (Base)", "Item Journal Line"."Quantity (Base)");
                    ResEntry."Reservation Status" := ResEntry."Reservation Status"::Prospect;
                    ResEntry."Lot No." := LotNo1;
                    ResEntry."Source Type" := 83;
                    ResEntry."Source Subtype" := 2;
                    ResEntry."Creation Date" := TODAY();
                    ResEntry."Created By" := USERID;
                    ResEntry.Positive := TRUE;
                    ResEntry."Item Tracking" := ResEntry."Item Tracking"::"Lot No.";
                    ResEntry.INSERT;
                end;
            }

            trigger OnAfterAssignVariable()
            begin
                MESSAGE('Import Successful');
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

    var
        ResEntry: Record "Reservation Entry";
        NewEntryNo: Integer;
        LastEntryNo: Integer;
}

