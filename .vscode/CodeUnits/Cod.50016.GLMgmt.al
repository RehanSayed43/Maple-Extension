codeunit 50016 GLMgmt
{
    Permissions = TableData "G/L Entry" = rimd;

    procedure GLEntryUpdate(var FromDate: Date; ToDate: Date; GetGLAcc: Code[20]; NewGL: Code[20])
    var
        GLEntry: Record "G/L Entry";
        GLAccountRec: Record "G/L Account";
        DataFound: Boolean;
    begin
        GLEntry.Reset();
        GLEntry.SetRange("Posting Date", FromDate, ToDate);
        GLEntry.SetRange("G/L Account No.", GetGLAcc);
        if GLEntry.FindSet() then
            repeat
                if GLAccountRec.Get(NewGL) then begin
                    GLEntry."G/L Account No." := GLAccountRec."No.";
                    GLEntry."G/L Account Name" := GLAccountRec.Name;
                    GLEntry.Modify(false);
                    DataFound := true;
                end;
            until
            GLEntry.Next() = 0;
        if DataFound then
            Message('Data Updated')
        else
            Message('No data found.')
    end;
}
