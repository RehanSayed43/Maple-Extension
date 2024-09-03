page 50090 "Vendor Part Master List"
{
    PageType = List;
    SourceTable = "Vendor Part Master Shield Bill";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Vendor Part Code"; Rec."Vendor Part Code")
                {
                    ApplicationArea = all;
                }
                field("Shield Plus"; Rec."Shield Plus")
                {
                    ApplicationArea = all;
                }
                field("Shield EXT PAD/PHO"; Rec."Shield EXT PAD/PHO")
                {
                    ApplicationArea = all;
                }
                field("Shield+Ex PAD/PHO"; Rec."Shield+Ex PAD/PHO")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        IF USERID <> 'ACC4EXE' THEN
            ERROR('Not Allowed');
    end;
}

