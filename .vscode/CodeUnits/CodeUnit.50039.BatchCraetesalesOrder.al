codeunit 50039 "Batch Craete sales Order"
{

    trigger OnRun()
    begin
        MapleMOTOIntegration.RESET;
        MapleMOTOIntegration.SETFILTER(status, '%1|%2', ' ', 'Error');
        IF MapleMOTOIntegration.FIND('-') THEN
            REPEAT
                IF NOT CODEUNIT.RUN(CODEUNIT::"Moto Order Create Batch", MapleMOTOIntegration) THEN BEGIN
                    MapleMOTOIntegration.FIND;
                    MapleMOTOIntegration.status := 'Error';
                    //MapleMOTOIntegration."Processed Date" := CURRENTDATETIME;
                    MapleMOTOIntegration."Navision Remarks" := COPYSTR(GETLASTERRORTEXT, 1, 250);
                    MapleMOTOIntegration.MODIFY(TRUE);
                    CLEARLASTERROR;
                    COMMIT;
                END;
            UNTIL MapleMOTOIntegration.NEXT = 0;
        MESSAGE('Success');
    end;

    var
        MapleMOTOIntegration: Record 50033;
}

