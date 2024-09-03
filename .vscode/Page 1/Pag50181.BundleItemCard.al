page 50181 "Bundle Item Card"
{
    ApplicationArea = All;
    Caption = 'Bundle Item Card';
    PageType = Card;
    SourceTable = "Bundle Items";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Bundle Code"; Rec."Bundle Code")
                {
                    ToolTip = 'Specifies the value of the Bundle Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                group(created)
                {
                    Caption = '';
                    Visible = (Rec."Created By" <> '');
                    field("Created By"; Rec."Created By")
                    {
                        ToolTip = 'Specifies the value of the Created By field.';
                    }
                    field("Created Date"; Rec."Created Date")
                    {
                        ToolTip = 'Specifies the value of the Created Date field.';
                    }
                }

                group(modifed)
                {
                    Caption = '';
                    Visible = (Rec."Modified By" <> '');
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
            part(Lines; "Bundle Item Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Bundle Code" = field("Bundle Code");
            }

        }
    }
}
