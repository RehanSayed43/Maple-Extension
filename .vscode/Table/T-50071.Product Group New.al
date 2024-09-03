table 50071 "Product Group New"
{
    Caption = 'Product Group';
    LookupPageID = 50171;

    fields
    {
        field(1; "Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category".Code;
        }
        field(2; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(7300; "Warehouse Class Code"; Code[10])
        {
            Caption = 'Warehouse Class Code';
            TableRelation = "Warehouse Class";
        }
    }

    keys
    {
        key(Key1; "Item Category Code", "Code")
        {
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}