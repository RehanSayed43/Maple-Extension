page 50087 "Posted Defective Accessory ent"
{
    UsageCategory = Administration;
    ApplicationArea = all;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Worksheet;
    SourceTable = "Defective Accessory";
    SourceTableView = WHERE(Posted = FILTER(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction No"; Rec."Transaction No")
                {
                    ApplicationArea = all;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = all;
                }
                field(Zone; Rec.Zone)
                {
                    ApplicationArea = all;
                }
                field(State; Rec.State)
                {
                    ApplicationArea = all;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = all;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Customer Type"; Rec."Customer Type")
                {
                    ApplicationArea = all;
                }
                field("Customer No"; Rec."Customer No")
                {
                    ApplicationArea = all;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = all;
                }
                field("Invoice No"; Rec."Invoice No")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field(Brand; Rec.Brand)
                {
                    ApplicationArea = all;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = all;
                }
                field("Primary Category"; Rec."Primary Category")
                {
                    ApplicationArea = all;
                }
                field("Maple Part Code"; Rec."Maple Part Code")
                {
                    ApplicationArea = all;
                }
                field("Vendor part Code"; Rec."Vendor part Code")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Qty. Taken Back"; Rec."Qty. Taken Back")
                {
                    ApplicationArea = all;
                }
                field("UPN No"; Rec."UPN No")
                {
                    ApplicationArea = all;
                }
                field("Given Brand"; Rec."Given Brand")
                {
                    ApplicationArea = all;
                }
                field("Given Category"; Rec."Given Category")
                {
                    ApplicationArea = all;
                }
                field("Given Primary Category"; Rec."Given Primary Category")
                {
                    ApplicationArea = all;
                }
                field("Given Maple Part Code"; Rec."Given Maple Part Code")
                {
                    ApplicationArea = all;
                }

                field("Given Vendor part Code"; Rec."Given Vendor part Code")
                {
                    ApplicationArea = all;
                }
                field("Given Description"; Rec."Given Description")
                {
                    ApplicationArea = all;
                }
                field("Qty. Given"; Rec."Qty. Given")
                {
                    ApplicationArea = all;
                }
                field("Given UPN No"; Rec."Given UPN No")
                {
                    ApplicationArea = all;
                }
                field("Damage Location"; Rec."Damage Location")
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

