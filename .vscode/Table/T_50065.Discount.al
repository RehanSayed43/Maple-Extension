table 50065 "Discounting"
{
    //CCIT-TK
    DataClassification = ToBeClassified;
    Caption = 'Discounting';
    LookupPageID = Discounting;
    fields
    {

        field(1; "Entry No"; Integer)
        {

            AutoIncrement = true;
        }
        field(2; "Discount Type"; code[20])
        {
            Editable = true;
            TableRelation = "Discount group";
        }
        field(3; "Description"; text[50])
        {
        }
        field(4; "Discount %"; Decimal)
        {
        }

        field(5; "Sales Type"; Option)
        {
            OptionCaption = 'Retail,Ecom,B2B';
            OptionMembers = Retail,Ecom,B2B;


        }
        field(6; "Maximum % Limit"; Decimal)
        {
        }
        field(7; "Product Category"; Code[20])
        {
            Editable = true;
            TableRelation = "Product Category";


        }
        field(8; "Active/Inactive"; Boolean)
        {

            trigger OnValidate()
            var
                re: record "Item Category";
            begin

            end;
        }
        field(9; "Primary category"; Code[20])
        {
            TableRelation = "Standard Text" WHERE("Category Type" = CONST(Primary));
            ValidateTableRelation = true;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                If "Discount Type" <> 'NO DISCOUNT' then begin
                    rec.TestField("Primary category");

                end;
            end;
        }
        field(10; "Secondary category"; Code[20])
        {
            TableRelation = "Standard Text" WHERE("Category Type" = CONST(Secondary));
            ValidateTableRelation = true;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                If "Discount Type" <> 'NO DISCOUNT' then begin
                    rec.TestField("Primary category");

                end;
            end;
        }
        field(11; "Third category"; Code[20])
        {
            TableRelation = "Standard Text" WHERE("Category Type" = CONST(Third));
            ValidateTableRelation = true;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                If "Discount Type" <> 'NO DISCOUNT' then begin
                    rec.TestField("Primary category");
                    rec.TestField("Secondary category");
                end;
            end;
        }
        field(12; "From Date"; Date)
        {
            Caption = 'From Date';
        }

        field(13; "To Date"; Date)
        {
            Caption = 'To Date';
        }
        field(14; "Item Category Code"; Code[20])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category";
        }
    }

    keys
    {

        key(Key1; "Entry No", "Discount Type")
        {
            Clustered = true;
        }
        // key(Key2; "Discount Type")
        // {
        //     // Clustered = true;
        // }

        // key(Key4; Indentation, Code, Description)
        // {
        // }






    }

    fieldgroups
    {

    }
    trigger OnModify()
    var
        myInt: Integer;
    begin
        if UserId <> 'KAVISH.S' then
            Error('You do not have permission to Modify');
        If "Discount Type" <> 'NO DISCOUNT' then begin
            rec.TestField("Primary category");
            Rec.TestField("Secondary category");
        end;
    end;

    trigger OnInsert()
    var
        myInt: Integer;
    begin
        if UserId <> 'KAVISH.S' then
            Error('You do not have permission to Insert');
        If "Discount Type" <> 'NO DISCOUNT' then begin
            rec.TestField("Primary category");
            Rec.TestField("Secondary category");
        end;
    end;

    trigger OnDelete()
    begin
        if UserId <> 'KAVISH.S' then
            Error('You do not have permission to Modify');
    end;

    var




}

