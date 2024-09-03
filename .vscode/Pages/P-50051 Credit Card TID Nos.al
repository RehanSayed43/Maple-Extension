page 50051 "Credit Card TID Nos"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    PageType = List;
    SourceTable = "Standard Text";
    SourceTableView = WHERE(TID = CONST(True));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Credit Cd Machine Code"; Rec."Credit Cd Machine Code")
                {
                    ApplicationArea = all;
                    Lookup = true;
                    LookupPageID = "Standard Text Codes";
                    TableRelation = "Standard Text" WHERE("Credit Cd Machine Code" = FILTER(<> ''),
                                                           TID = CONST(False));
                    Visible = false;
                }
                field("TID NO"; Rec."TID NO")
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

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec.TID := TRUE;
    end;
}

