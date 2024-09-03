page 50166 "Product Categories"
{
    ApplicationArea = Basic, Suite;
    Caption = 'Product Categories';

    PageType = List;
    RefreshOnActivate = true;
    ShowFilter = false;
    SourceTable = "Product Category";
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