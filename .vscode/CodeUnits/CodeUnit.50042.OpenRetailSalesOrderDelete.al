codeunit 50042 "Open Retail Sales Order Delete"
{

    trigger OnRun()
    var
        SalesHeader: Record 36;
        Date1: Date;
        SalesLine1: Record 37;
        SalesLine: Record 37;
        ReservationEntry: Record 337;
    begin
        Date1 := CALCDATE('<-2D>', TODAY);
        SalesHeader.SETRANGE("Posting Date", 0D, Date1);
        SalesHeader.SETRANGE(Status, SalesHeader.Status::Open);
        // SalesHeader.SetRange(Ship, false);
        // SalesHeader.SetRange(Invoice, false);
        //SalesHeader.SETRANGE("Sales Order Type", SalesHeader."Sales Order Type"::B2B);
        //SalesHeader.SetRange("Web Order", true);
        IF SalesHeader.FINDSET THEN
            REPEAT
                SalesLine1.Reset();
                SalesLine1.SetRange(SalesLine1."Document No.", SalesHeader."No.");
                IF SalesLine1.FindSet() THEN
                    REPEAT
                        ReservationEntry.SETRANGE("Source Type", 37);
                        ReservationEntry.SETRANGE("Source Subtype", 1);
                        ReservationEntry.SetRange("Source ID", SalesLine1."Document No.");
                        ReservationEntry.SetRange("Source Ref. No.", SalesLine1."Line No.");
                        IF ReservationEntry.FINDSET THEN
                            REPEAT
                                ReservationEntry.DELETE(false); //Reservation entry delete
                            UNTIL ReservationEntry.NEXT = 0;

                        SalesLine1.Delete(false); //Sales Line Delete
                    UNTIL SalesLine1.Next() = 0;

                SalesHeader.DELETE(false);//Sales Header Delete

            UNTIL SalesHeader.NEXT = 0;
    end;
}

