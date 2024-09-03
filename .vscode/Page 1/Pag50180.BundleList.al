page 50180 "Bundle List"
{
    ApplicationArea = All;
    Caption = 'Bundle List';
    PageType = List;
    SourceTable = "Bundle Items";
    CardPageId = "Bundle Item Card";
    Editable = false;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Bundle Code"; Rec."Bundle Code")
                {
                    ToolTip = 'Specifies the value of the Bundle Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field("Created Date"; Rec."Created Date")
                {
                    ToolTip = 'Specifies the value of the Created Date field.';
                }
                field("Modified By"; Rec."Modified By")
                {
                    ToolTip = 'Specifies the value of the Modified By field.';
                }
                field("Modified Date"; Rec."Modified Date")
                {
                    ToolTip = 'Specifies the value of the Modified Date field.';
                }
            }
        }
    }
}
