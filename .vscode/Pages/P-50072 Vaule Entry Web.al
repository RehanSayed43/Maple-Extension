page 50072 "Vaule Entry-Web"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    PageType = List;
    SourceTable = "Value Entry";
    //     SourceTableView = WHERE("Source Code" = FILTER(INVTADJMT));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Item Ledger Entry Type"; Rec."Item Ledger Entry Type")
                {
                    ApplicationArea = all;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = all;
                }
                field("Cost per Unit"; Rec."Cost per Unit")
                {
                    ApplicationArea = all;
                }
                field(ILENo; ILENo)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        IF RECILE.GET(Rec."Item Ledger Entry No.") THEN
            ILENo := RECILE."Entry No."
        ELSE
            ILENo := 0;
    end;

    var
        RECILE: Record "Item Ledger Entry";
        ILENo: Integer;
}

