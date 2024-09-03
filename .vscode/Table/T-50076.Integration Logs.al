table 50076 "Integration Logs"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Order ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Creation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Time; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Invoice No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Request; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Response; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Document Type"; Enum "Integartion Document")
        {
            DataClassification = ToBeClassified;
        }
        field(9; Token; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
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