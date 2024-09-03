page 50155 "E-Invoice Log Entry List"
{
    UsageCategory = Lists;
    Editable = false;
    PageType = List;
    SourceTable = "Log Entry";
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Creation DateTime"; Rec."Creation DateTime")
                {
                    ApplicationArea = all;
                }
                field(Message; Rec.GetErrorMessage)
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

