page 50091 GLFilters
{
    ApplicationArea = All;
    Caption = 'GL Filters';
    UsageCategory = Administration;
    PageType = StandardDialog;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = '';

                field(FromDate; FromDate)
                {
                    Caption = 'From Date';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the From Date field.';
                }
                field(ToDate; ToDate)
                {
                    Caption = 'To Date';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the To Date field.';
                    trigger OnValidate()
                    begin
                        if FromDate = 0D then
                            Error('From Date Should not be blank');

                        if FromDate > ToDate then
                            Error('From Date should not be greter than To Date.');
                    end;
                }

                field(GLAccount; GLAccount)
                {
                    Caption = 'GL Account';
                    ApplicationArea = All;
                    TableRelation = "G/L Account";
                    ToolTip = 'Specifies the value of the GL Account field.';
                }
                field(NewGLAccount; NewGLAccount)
                {
                    Caption = 'New GL Account';
                    TableRelation = "G/L Account";
                    ToolTip = 'Specifies the value of the New GL Account field.';
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if CloseAction = CloseAction::OK then begin
            if GLAccount = '' then
                Error('GL Account should have value');
            if NewGLAccount = '' then
                Error('New GL Account should have value');
            if GLAccount = NewGLAccount then
                Error('New GL account should not be same as current GL Account.');
            GLMgmt.GLEntryUpdate(FromDate, ToDate, GLAccount, NewGLAccount);
        end;

    end;

    var
        GLMgmt: Codeunit GLMgmt;
        FromDate: Date;
        ToDate: Date;
        GLAccount: Code[20];
        NewGLAccount: Code[20];


}
