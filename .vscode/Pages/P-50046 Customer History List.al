page 50046 "Customer History List"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ShowFilter = false;
    SourceTable = "Bulk Expense booking";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = all;
                }
                field(VendorName; Rec.VendorName)
                {
                    ApplicationArea = all;
                }
                field("State Code"; Rec."State Code")
                {
                    ApplicationArea = all;
                }
                field("GST Registration No."; Rec."GST Registration No.")
                {
                    ApplicationArea = all;
                }
                field(Structure; Rec.Structure)
                {
                    ApplicationArea = all;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = all;
                }
                field("Vendor Part Code"; Rec."Vendor Part Code")
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

