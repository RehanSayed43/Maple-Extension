page 50065 "Reservation Entry Maple"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    PageType = List;
    SourceTable = "Reservation Entry";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Quantity (Base)"; Rec."Quantity (Base)")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Reservation Status"; Rec."Reservation Status")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Source ID"; Rec."Source ID")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("IMEI No."; Rec."IMEI No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Lot No."; Rec."Lot No.")
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

