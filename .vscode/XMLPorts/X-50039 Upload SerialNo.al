xmlport 50039 "Upload Serial No."
{
    Caption = 'Upload Serial No.';
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Integer; Integer)
            {
                AutoSave = false;
                XmlName = 'Integer';
                // SourceTableView = SORTING (Field1)
                //                   WHERE (Field1 = CONST (1));
                textattribute(PurchaseOrderNo)
                {
                }
                textattribute(PurchaseOrderLineNo)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        EVALUATE(POLineNo, PurchaseOrderLineNo);
                    end;
                }
                textattribute(SerialNo)
                {
                }

                trigger OnAfterInitRecord()
                begin
                    IF HeaderRecord THEN BEGIN
                        HeaderRecord := FALSE;
                        currXMLport.SKIP;
                    END;
                end;

                trigger OnBeforeInsertRecord()
                var
                    PurchaseLine: Record 39;
                    ReservationEntry: Record 337;
                begin
                    IF SerialNo = '' THEN
                        ERROR('Serial No. should not be blank');

                    PurchaseLine.GET(PurchaseLine."Document Type"::Order, PurchaseOrderNo, POLineNo);

                    CLEAR(ReservationEntry);
                    ReservationEntry.INIT;
                    ReservationEntry."Entry No." := GetNextEntryNo;
                    ReservationEntry.Positive := TRUE;
                    ReservationEntry."Item Tracking" := ReservationEntry."Item Tracking"::"Serial No.";
                    ReservationEntry."Item No." := PurchaseLine."No.";
                    ReservationEntry."Location Code" := PurchaseLine."Location Code";
                    ReservationEntry."Reservation Status" := ReservationEntry."Reservation Status"::Surplus;
                    ReservationEntry."Creation Date" := TODAY;
                    ReservationEntry."Source Type" := DATABASE::"Purchase Line";
                    ReservationEntry."Source Subtype" := ReservationEntry."Source Subtype"::"1";
                    ReservationEntry."Source ID" := PurchaseOrderNo;
                    ReservationEntry."Source Ref. No." := POLineNo;
                    ReservationEntry."Expected Receipt Date" := PurchaseLine."Expected Receipt Date";
                    ReservationEntry."Created By" := USERID;
                    ReservationEntry."Serial No." := SerialNo;
                    ReservationEntry.VALIDATE("Qty. per Unit of Measure", PurchaseLine."Qty. per Unit of Measure");
                    ReservationEntry.VALIDATE("Quantity (Base)", 1);
                    ReservationEntry.INSERT(TRUE);
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

    trigger OnInitXmlPort()
    begin
        HeaderRecord := TRUE;
    end;

    trigger OnPostXmlPort()
    begin
        MESSAGE('Done');
    end;

    var
        HeaderRecord: Boolean;
        POLineNo: Integer;

    local procedure GetNextEntryNo(): Integer
    var
        ReservationEntry: Record 337;
    begin
        ReservationEntry.RESET;
        IF ReservationEntry.FINDLAST THEN
            EXIT(ReservationEntry."Entry No." + 1);

        EXIT(1);
    end;
}

