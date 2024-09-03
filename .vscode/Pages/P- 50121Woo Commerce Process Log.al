page 50121 "WooCommerce Process Log"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "WooCommerce Process Log";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Process Name"; Rec."Process Name")
                {
                    ApplicationArea = All;
                }
                field("Start Date/Time"; Rec."Start Date/Time")
                {
                    ApplicationArea = All;
                }
                field("End Date/Time"; Rec."End Date/Time")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("Error Description"; Rec."Error Description")
                {
                    ApplicationArea = All;
                }
                field("Order Key"; Rec."Order Key")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

