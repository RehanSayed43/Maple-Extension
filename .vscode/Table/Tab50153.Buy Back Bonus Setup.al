table 50153 "Buy Back Bonus Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Bonus Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Maple Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Apple Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Bonus Amount")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
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