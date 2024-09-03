codeunit 50013 "Restart Job Queue"
{

    trigger OnRun()
    begin
        ChangeJobStatus;
    end;

    var
        recJobQEntry: Record "Job Queue Entry";//"472";

    local procedure ChangeJobStatus()
    begin
        recJobQEntry.RESET;
        recJobQEntry.SETRANGE("Object ID to Run", 50001);
        IF recJobQEntry.FINDSET THEN
            REPEAT


                //*** STATE: ERROR OR FINISHED

                IF recJobQEntry.Status = recJobQEntry.Status::Error THEN BEGIN

                    recJobQEntry.Status := recJobQEntry.Status::Ready; // –> SET STATUS TO READY

                    recJobQEntry.MODIFY(FALSE);


                END;


                COMMIT;

            UNTIL recJobQEntry.NEXT = 0;
    end;
}

