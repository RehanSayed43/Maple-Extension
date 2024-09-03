page 50052 "Credit Card Machine Code"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    PageType = List;
    SourceTable = "Standard Text";
    SourceTableView = WHERE("Credit Card Machine" = CONST(True));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = all;
                    Caption = 'Bank Code';
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec."Credit Cd Machine Code" := Rec.Code;
                    end;
                }
                field("Credit Cd Machine Code"; Rec."Credit Cd Machine Code")
                {
                    ApplicationArea = all;
                    Visible = true;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Credit Card Machine"; Rec."Credit Card Machine")
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
        Rec."Credit Card Machine" := TRUE;
    end;
}

