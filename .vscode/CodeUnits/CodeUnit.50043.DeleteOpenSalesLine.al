codeunit 50043 "Delete Open Sales Line"
{

    trigger OnRun()
    var
        SalesLine: Record 37;
        SalesHeader: Record 36;
        ReserveSalesLine: Codeunit 99000832;
        Item: Record 27;
        ReservationEntry: Record 337;
        MyHTMLFile: File;
        TestOutStream: OutStream;
    begin
        ReservationEntry.SETRANGE("Creation Date", 0D, 20230228D);
        ReservationEntry.SETRANGE("Source Type", 37);
        ReservationEntry.SETRANGE("Source Subtype", 1);
        IF ReservationEntry.FINDSET THEN
            REPEAT
                IF NOT SalesLine.GET(SalesLine."Document Type"::Order, ReservationEntry."Source ID", ReservationEntry."Source Ref. No.") THEN BEGIN
                    ReservationEntry.DELETE;
                END;
            UNTIL ReservationEntry.NEXT = 0;

        MESSAGE('Deleted');
    end;
}

