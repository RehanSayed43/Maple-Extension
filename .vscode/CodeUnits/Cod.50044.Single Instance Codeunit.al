codeunit 50044 "Single Instance Codeunit"
{
    SingleInstance = true;

    trigger OnRun()
    begin

    end;

    procedure GetPONumber(): text//Code[20]
    BEGIN
        exit(PONo);
    END;

    procedure SetPONumber(Number: Text)
    BEGIN
        IF PONo = '' THEN
            PONo := Number
        ELSE
            PONo += ',' + Number;
    END;

    var
        PONo: text;//Code[20];
}