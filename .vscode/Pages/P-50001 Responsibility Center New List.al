page 50001 "Responsibility Center New List"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    Caption = 'Responsibility Center New List';
    CardPageID = "Responsibility Center New Card";
    Editable = false;
    PageType = List;
    SourceTable = "Responsibility Center New 1";

    layout
    {
        area(content)
        {
            repeater(Responsibility)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = all;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Resp. Ctr.")
            {
                Caption = '&Resp. Ctr.';
                Image = Dimensions;
                group(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    action("Dimensions-Single")
                    {
                        Caption = 'Dimensions-Single';
                        Image = Dimensions;
                        RunObject = Page 540;
                        RunPageLink = "Table ID" = CONST(5714),
                                      "No." = FIELD(Code);
                        ShortCutKey = 'Shift+Ctrl+D';
                        ApplicationArea = All;
                    }
                    action("Dimensions-&Multiple")
                    {
                        Caption = 'Dimensions-&Multiple';
                        Image = DimensionSets;
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            RespCenter: Record 5714;
                            DefaultDimMultiple: Page 542;
                        begin
                            CurrPage.SETSELECTIONFILTER(RespCenter);
                            //   DefaultDimMultiple.SetMultiRespCenter(RespCenter);
                            DefaultDimMultiple.RUNMODAL;
                        end;
                    }
                }
            }
        }
    }
}

