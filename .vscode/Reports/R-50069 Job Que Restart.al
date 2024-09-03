report 50069 "Job Que Restart"
{
    // Report,Codeunit

    Permissions = TableData 98 = rim;
    ProcessingOnly = true;
    ShowPrintStatus = false;
    UseRequestPage = false;
    ApplicationArea = FixedAsset;

    dataset
    {
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

    labels
    {
    }

    trigger OnPostReport()
    begin
        JobQueRun(50016, CREATEDATETIME(TODAY, (TIME + (2 * 60000))), 'Codeunit');
        JobQueRun(50065, CREATEDATETIME(TODAY, (TIME + (4 * 60000))), 'Report');
        JobQueRun(50014, CREATEDATETIME(TODAY, (TIME + (11 * 60000))), 'Codeunit');
        RecGLS.GET;
        RecGLS."Allow Posting From" := TODAY;//+1;
        RecGLS."Allow Posting To" := TODAY;//+1;
        //MESSAGE('%1',TODAY+1);
        RecGLS.MODIFY(TRUE);
        //DATE2DMY(TODAY,1)
        UsersetupDateUpdate;
    end;

    var
        RecGLS: Record 98;

    local procedure JobQueRun(Id_to_run: Integer; Date_time: DateTime; Object_type_to_run: Text)
    var
        RecJobQue: Record 472;
        JobQueueDispatcher: Codeunit 448;
    begin
        RecJobQue.RESET;
        RecJobQue.SETRANGE("Object ID to Run", Id_to_run);
        IF Object_type_to_run = 'Report' THEN
            RecJobQue.SETFILTER("Object Type to Run", '%1', RecJobQue."Object Type to Run"::Report)
        ELSE
            RecJobQue.SETFILTER("Object Type to Run", '%1', RecJobQue."Object Type to Run"::Codeunit);

        IF RecJobQue.FINDFIRST THEN BEGIN
            RecJobQue."Last Ready State" := CREATEDATETIME(TODAY, 0T);
            RecJobQue."Earliest Start Date/Time" := CREATEDATETIME(TODAY, 0T);
            RecJobQue.MODIFY;
        END;
        RecJobQue.RESET;
        RecJobQue.SETRANGE("Object ID to Run", Id_to_run);
        IF Object_type_to_run = 'Report' THEN
            RecJobQue.SETFILTER("Object Type to Run", '%1', RecJobQue."Object Type to Run"::Report)
        ELSE
            RecJobQue.SETFILTER("Object Type to Run", '%1', RecJobQue."Object Type to Run"::Codeunit);
        IF RecJobQue.FINDFIRST THEN BEGIN

            RecJobQue.LOCKTABLE;

            RecJobQue."Earliest Start Date/Time" := JobQueueDispatcher.CalcInitialRunTime(RecJobQue, Date_time);

            RecJobQue.Status := RecJobQue.Status::Ready;
            RecJobQue."User Session Started" := 0DT;
            RecJobQue."User Service Instance ID" := 0;
            RecJobQue."User Session ID" := 0;

            //  STARTSESSION(RecJobQue."User Session ID", CODEUNIT::"Job Queue User Session", COMPANYNAME, RecJobQue);
            RecJobQue.MODIFY;

        END;
    end;

    local procedure UsersetupDateUpdate()
    var
        RecUserSetup: Record 91;
        Day: Integer;
        User_id: Text;
    begin
        User_id := 'ACC4EXE|ACC1EXE|ACC3EXE|MAPLESERV|ACCAM|ACC2EXE';
        Day := 0;
        Day := DATE2DMY(TODAY + 1, 1);
        CASE Day OF
            1 .. 4:
                BEGIN
                    // MESSAGE('1- %1',CALCDATE('-CM-1M',TODAY));
                    RecUserSetup.RESET;
                    RecUserSetup.SETFILTER("User ID", User_id);
                    IF RecUserSetup.FINDSET THEN
                        REPEAT
                            // MESSAGE('1-%1',RecUserSetup."User ID");
                            RecUserSetup."Allow Posting From" := CALCDATE('-CM-1M', TODAY);//+1);
                            RecUserSetup."Allow Posting To" := TODAY;//+1;
                            RecUserSetup.MODIFY;
                        UNTIL RecUserSetup.NEXT = 0;
                END;
            ELSE BEGIN
                // MESSAGE('2- %1',CALCDATE ('-CM',TODAY));
                RecUserSetup.RESET;
                RecUserSetup.SETFILTER("User ID", User_id);
                IF RecUserSetup.FINDSET THEN
                    REPEAT
                        // MESSAGE('2- %1',RecUserSetup."User ID");
                        RecUserSetup."Allow Posting From" := CALCDATE('-CM', TODAY);//+1);
                        RecUserSetup."Allow Posting To" := TODAY;//+1;
                        RecUserSetup.MODIFY;
                    UNTIL RecUserSetup.NEXT = 0;
            END;
        END;
    end;
}

