table 50101 "Bundle Items"
{
    Caption = 'Bundle Items';
    DataCaptionFields = "Bundle Code", Description, "Created Date";
    LookupPageId = "Bundle List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Bundle Code"; Code[20])
        {
            Caption = 'Bundle Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Created Date"; Date)
        {
            Caption = 'Created Date';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(4; "Created By"; Code[50])
        {
            Caption = 'Created By';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(6; "Modified Date"; Date)
        {
            Caption = 'Modified Date';
            Editable = false;
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Bundle Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Bundle Code", Description, "Created By", "Created Date")
        {
        }
        fieldgroup(Brick; "Bundle Code", Description, "Created By", "Created Date", "Modified By")
        {
        }
    }

    trigger OnInsert()
    begin
        Rec."Created By" := UserId;
        Rec."Created Date" := Today;
    end;

    trigger OnModify()
    begin
        Rec."Modified By" := UserId;
        Rec."Modified Date" := Today;
    end;
}
