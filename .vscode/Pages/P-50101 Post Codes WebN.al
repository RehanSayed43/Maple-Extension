page 50101 "Post Codes-WebN"
{
    Caption = 'Post Codes';
    PageType = List;
    SourceTable = "Post Code";
    ApplicationArea = FixedAsset;

    layout
    {
        area(content)
        {
            repeater(Groups)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field(County; Rec.County)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

