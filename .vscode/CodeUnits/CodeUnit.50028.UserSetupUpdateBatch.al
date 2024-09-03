codeunit 50028 "UserSetup Update Batch"
{
    // KPPLRJ3.00 01.03.22 : Batch for update Allow Posting Date in User Setup.


    trigger OnRun()
    begin
        UserSetupDateUpdate;
    end;

    [TryFunction]
    local procedure UserSetupDateUpdate()
    var
        RecUserSetup: Record "User Setup";//"91";
        Day: Integer;
        User_id: Text;
        RecGLS: Record "General Ledger Setup";//"98";
    begin
        RecGLS.GET;
        RecGLS."Allow Posting From" := TODAY;
        RecGLS."Allow Posting To" := TODAY;
        RecGLS.MODIFY(TRUE);

        RecUserSetup.RESET;
        RecUserSetup.SETRANGE("Allow Back Dated Entry", FALSE);
        IF RecUserSetup.FINDSET THEN
            REPEAT
                RecUserSetup."Allow Posting From" := TODAY;
                RecUserSetup."Allow Posting To" := TODAY;
                RecUserSetup.MODIFY;
            UNTIL RecUserSetup.NEXT = 0;

        RecUserSetup.RESET;
        RecUserSetup.SETRANGE("Allow Back Dated Entry", TRUE);
        IF RecUserSetup.FINDSET THEN
            REPEAT
                RecUserSetup."Allow Posting To" := TODAY;
                RecUserSetup.MODIFY;
            UNTIL RecUserSetup.NEXT = 0;
    end;
}

