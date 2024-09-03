page 50083 "Shield List"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    CardPageID = "Shield Card";
    PageType = List;
    SourceTable = "Standard Text";
    SourceTableView = WHERE(Shield = FILTER(True));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
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

    actions
    {
    }
}

