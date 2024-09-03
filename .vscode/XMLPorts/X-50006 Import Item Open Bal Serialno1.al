xmlport 50006 "Import Item Open Bal Serialno1"
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
                fieldelement(ItemJournalLine_LineNo; "Item Journal Line"."Line No.")
                {
                }
                fieldelement(ItemJournalLine_PostingDate; "Item Journal Line"."Posting Date")
                {
                }
                fieldelement(ItemJournalLine_DocumentDate; "Item Journal Line"."Document Date")
                {
                }
                fieldelement(ItemJournalLine_EntryType; "Item Journal Line"."Entry Type")
                {
                }
                fieldelement(ItemJournalLine_DocumentNo; "Item Journal Line"."Document No.")
                {
                }
                fieldelement(ItemJournalLine_ExtDocumentNo; "Item Journal Line"."External Document No.")
                {
                }
                fieldelement(ItemJournalLine_ItemNo; "Item Journal Line"."Item No.")
                {
                }
                fieldelement(ItemJournalLine_UNITOFMeasure; "Item Journal Line"."Unit of Measure Code")
                {
                }
                fieldelement(ItemJournalLine_Description; "Item Journal Line".Description)
                {
                }
                fieldelement(ItemJournalLine_LocationCode; "Item Journal Line"."Location Code")
                {
                }
                fieldelement(ItemJournalLine_MRP; "Item Journal Line"."MRP Value")
                {
                }
                fieldelement(ItemJournalLine_UPNCODE; "Item Journal Line"."UPN Code")
                {
                }
                fieldelement(ItemJournalLine_Quantity; "Item Journal Line".Quantity)
                {
                }
                fieldelement(UnitCost; "Item Journal Line"."Unit Cost")
                {
                }
                fieldelement(UnitAmount; "Item Journal Line"."Unit Amount")
                {
                }
                fieldelement(ItemJournalLine_Amount; "Item Journal Line".Amount)
                {
                }
                fieldelement(BRANCH; "Item Journal Line"."Shortcut Dimension 1 Code")
                {
                }
                fieldelement(VERTICAL; "Item Journal Line"."Shortcut Dimension 2 Code")
                {
                }

                trigger OnAfterGetRecord()
                begin

                    //MESSAGE(SrNo1);
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
                    //ResEntry."Serial No." := SrNo1;
                    ResEntry."Source Type" := 83;
                    ResEntry."Source Subtype" := 2;
                    ResEntry."Creation Date" := TODAY();
                    ResEntry."Created By" := USERID;
                    ResEntry.Positive := TRUE;
                    ResEntry."Item Tracking" := ResEntry."Item Tracking"::"Serial No.";
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

