page 50006 "PDC Deposit Cheques"
{
    PageType = Card;
    SourceTable = 50006;
    ApplicationArea = FixedAsset;

    layout
    {
        area(content)
        {
            group("Deposit Cheques")
            {
                Caption = 'Deposit Cheques';
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        REPORT.RUN(50004);
    end;

    var
        PDCDate: Date;
        frmForm2: Page 50007;
        TabDepositChq: Record 50006;
        TabPDC: Record 50002;
}

