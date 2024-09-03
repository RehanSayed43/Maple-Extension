page 50021 "Shield Card"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Standard Text";
    SourceTableView = WHERE(Shield = CONST(True));

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field(Shield; Rec.Shield)
                {
                    ApplicationArea = all;
                }
                field("Shield Type"; Rec."Shield Type")
                {
                    ApplicationArea = all;
                    OptionCaption = ' ,Shield,Shield Plus,Shield+Ex PAD/PHO,Shield Ex,Shield+ExCPU,ExCPU,ExIPH/IPAD,Shield Extended,Shield+Ext Watch,Shield EXT PAD/PHO,Shield EXTENDED CPU';
                }
                field("Shield Insurance T&C"; Rec."Shield Insurance T&C")
                {
                    ApplicationArea = all;
                }
                field("Shield Insurance T&C1"; Rec."Shield Insurance T&C1")
                {
                    ApplicationArea = all;
                }
                field("Shield Cost Perct"; Rec."Shield Cost Perct")
                {
                    ApplicationArea = all;
                }
                field("Shield Insurance T&C2"; Rec."Shield Insurance T&C2")
                {
                    ApplicationArea = all;
                }
                field("Shield Insurance T&C3"; Rec."Shield Insurance T&C3")
                {
                    ApplicationArea = all;
                }
                field("Shield Insurance T&C4"; Rec."Shield Insurance T&C4")
                {
                    ApplicationArea = all;
                    Caption = 'Shield Insurance T&C Old';
                }
                field("Shield Insurance T&C5"; Rec."Shield Insurance T&C5")
                {
                    ApplicationArea = all;
                    Caption = 'Shield Insurance T&C1 Old';
                }
                field("Shield Insurance T&C6"; Rec."Shield Insurance T&C6")
                {
                    ApplicationArea = all;
                    Caption = 'Shield Insurance T&C2 Old';
                }
                field("Shield Insurance T&C7"; Rec."Shield Insurance T&C7")
                {
                    ApplicationArea = all;
                    Caption = 'Shield Insurance T&C3 Old';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Shield := TRUE;
    end;
}

