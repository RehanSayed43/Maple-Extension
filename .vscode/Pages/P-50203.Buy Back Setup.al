page 50203 "Buy Back Bonus Setup"
{
    //Caption = 'PageName';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Buy Back Bonus Setup";


    layout
    {
        area(Content)
        {
            repeater(Group)
            {


                field("Bonus Amount"; Rec."Bonus Amount")
                {
                    ToolTip = 'Specifies the value of the Bonus Amount field.';
                    ApplicationArea = all;
                }
                field("Apple Contribution"; Rec."Apple Contribution")
                {
                    ToolTip = 'Specifies the value of the Apple Contribution field.';
                    ApplicationArea = all;
                }
                field("Maple Contribution"; Rec."Maple Contribution")
                {
                    ToolTip = 'Specifies the value of the Maple Contribution field.';
                    ApplicationArea = all;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {

        }
    }
}