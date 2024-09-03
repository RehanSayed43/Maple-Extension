page 50032 "Item Series Patteren"
{
    UsageCategory = Administration;
    ApplicationArea = all;
    PageType = Card;
    SourceTable = Item;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        IF (STRLEN(Rec."Item Category Code") >= 3) AND (STRLEN(Rec."Product Category") >= 3) THEN
                            Rec.SeriesPattern := COPYSTR(Rec."Item Category Code", 1, 3) + '\' + COPYSTR(Rec."Product Category", 1, 3) + '\';
                    end;
                }
                field("Product Category"; Rec."Product Category")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        IF (STRLEN(Rec."Item Category Code") >= 3) AND (STRLEN(Rec."Product Category") >= 3) THEN
                            Rec.SeriesPattern := COPYSTR(Rec."Item Category Code", 1, 3) + '\' + COPYSTR(Rec."Product Category", 1, 3) + '\';
                    end;
                }
                field(SeriesPattern; Rec.SeriesPattern)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        Rec."Item Category Code" := '';
        //  Rec. "Product Category" := '';
        Rec.SeriesPattern := '';
    end;

    trigger OnClosePage()
    begin
        //IF (STRLEN("Item Category Code") >=3) AND (STRLEN("Product Category") >=3) THEN
        // SeriesPattern := COPYSTR("Item Category Code",1,3) +'\'+ COPYSTR("Product Category",1,3)+'\';
    end;

    trigger OnInit()
    begin
        Rec."Item Category Code" := '';
        // Rec. "Product Category" := '';
        Rec.SeriesPattern := '';
    end;
}

