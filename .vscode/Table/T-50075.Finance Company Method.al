table 50075 "Finance Company Method"
{

    DataClassification = ToBeClassified;
    Caption = 'Finance Company Method';
    LookupPageID = "Finance Company Method";

    fields
    {
        field(2; "Code"; code[20])
        {
            Editable = true;
            TableRelation = "Payment Method"."Pay Type";
        }
        field(3; "Description"; text[50])
        {

        }
    }

    keys
    {
        key(Key1; Code)
        {
            Clustered = true;
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