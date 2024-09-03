page 50168 "Discount group"
{
    ApplicationArea = Basic, Suite;
    Caption = 'Discount Type';

    PageType = List;
    RefreshOnActivate = true;
    ShowFilter = false;
    SourceTable = "Discount group";
    SourceTableView = SORTING(Code);
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {

                field("Code"; Rec.Code)
                {
                    ApplicationArea = all;

                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
            }
        }





    }
}