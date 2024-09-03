codeunit 50059 "Delete Intregration Log"
{
    trigger OnRun()
    var
        Date1: Date;
        IntegrationLogs: Record "Integration Logs";
    begin
        Date1 := CALCDATE('<-3D>', TODAY);
        IntegrationLogs.Reset();
        IntegrationLogs.SetRange(IntegrationLogs."Creation Date", 0D, Date1);
        IF IntegrationLogs.FindSet() THEN
            REPEAT
                IntegrationLogs.Delete(false);
            UNTIL IntegrationLogs.Next() = 0;
    end;

    var
        myInt: Integer;
}