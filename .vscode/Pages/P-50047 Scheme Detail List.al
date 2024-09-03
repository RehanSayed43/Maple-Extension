page 50047 "Scheme Detail List"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    AutoSplitKey = true;
    PageType = List;
    SourceTable = "Scheme Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Enable Scheme"; Rec."Enable Scheme")
                {
                    ApplicationArea = all;
                    Visible = true;
                }
                field(ItemNo; Rec.ItemNo)
                {
                    ApplicationArea = all;
                }
                field(Descritpion; Rec.Descritpion)
                {
                    ApplicationArea = all;
                }
                field(Vendor; Rec.Vendor)
                {
                    ApplicationArea = all;
                }
                field("Sch Disc %"; Rec."Sch Disc %")
                {
                    ApplicationArea = all;
                }

                field("Sch Disc Amt"; Rec."Sch Disc Amt")
                {
                    ApplicationArea = all;
                }
                field("Claim Disc %"; Rec."Claim Disc %")
                {
                    ApplicationArea = all;
                }
                field("Claim Amt"; Rec."Claim Amt")
                {
                    ApplicationArea = all;
                }
                field(Open; Rec.Open)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

