page 50049 "Scheme List"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    CardPageID = "Scheme Transaction";
    PageType = List;
    SourceTable = "Standard Text";
    SourceTableView = WHERE(Scheme = CONST(True));

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
                field("Scheme Vendor"; Rec."Scheme Vendor")
                {
                    ApplicationArea = all;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = all;
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    ApplicationArea = all;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = all;
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ApplicationArea = all;
                }
                field(Open; Rec.Open)
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

