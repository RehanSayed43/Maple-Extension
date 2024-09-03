pageextension 50003 "Item List" extends "Item List"
{
    layout
    {
        addafter("No.")
        {
            field("Old Item No"; Rec."Old Item No")
            {
                ApplicationArea = All;
            }

            field("Ingram Part Code"; Rec."Ingram Part Code")
            {
                ApplicationArea = All;
            }
            field("Vendor Part Code Long"; Rec."Vendor Part Code Long")
            {
                Caption = 'Vendor Part Code';
                ApplicationArea = All;
            }

            field("Primary category"; Rec."Primary category")
            {
                ApplicationArea = All;
            }
            field("Secondary category"; Rec."Secondary category")
            {
                ApplicationArea = All;
            }
            field("Third category"; Rec."Third category")
            {
                ApplicationArea = All;
            }
            field("HSN/SAC Code"; Rec."HSN/SAC Code")
            {
                ApplicationArea = All;
            }
            field("GST Group Code"; Rec."GST Group Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Costing Method")
        {
            field(Grade; Rec.Grade)
            {
                ApplicationArea = All;
            }
            field("Tax Group Code"; Rec."Tax Group Code")
            {
                ApplicationArea = All;
            }

        }
        modify(InventoryField)
        {
            Visible = false;
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin

            end;
        }

    }

    actions
    {
        addafter("E&ntries")
        {
            action(TEST)
            {
                APPLICATIONAREA = ALL;
                PROMOTED = true;
                Visible = false;
                trigger OnAction()
                var
                    TT: Record "Posting No. Series";
                BEGIN
                    TT.Reset();
                    TT.DeleteAll();
                    Message('Done');
                END;
            }
        }
    }

    var
        myInt: Integer;
}