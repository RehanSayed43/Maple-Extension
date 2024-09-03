table 50018 "CRM Payment Integration"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "CRM Customer No."; Code[30])
        {
            Caption = 'No.';
        }
        field(3; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(4; Address; Text[100])
        {
            Caption = 'Address';
            NotBlank = true;
        }
        field(5; City; Text[30])
        {
            Caption = 'City';
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(6; "State Code"; Code[20])
        {
        }
        field(7; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(8; Narration; Text[50])
        {
        }
        field(9; Amount; Decimal)
        {
        }
        field(10; "GL Account No."; Code[20])
        {
        }
        field(11; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
            end;
        }
        field(12; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
            end;
        }
        field(13; "Posting Date"; Date)
        {
        }
        field(14; "Location Code"; Code[20])
        {
        }
        field(15; "GST Group Code"; Code[20])
        {
        }
        field(16; "HSN/SAC Code"; Code[20])
        {
        }
        field(17; "GST on Advance Payment"; Boolean)
        {
        }
        field(18; "GST Registration No."; Code[15])
        {
            Caption = 'GST Registration No.';

            trigger OnValidate()
            var
                GSTRegistrationNos: Record "GST Registration Nos.";
            begin

                IF "GST Registration No." <> '' THEN
                    IF "GST Registration Type" = "GST Registration Type"::GSTIN THEN BEGIN
                        TESTFIELD("State Code");
                        //    GSTRegistrationNos.CheckGSTRegistrationNo("State Code", "GST Registration No.");  RahulGCCIT
                        IF "GST Customer Type" = "GST Customer Type"::" " THEN
                            "GST Customer Type" := "GST Customer Type"::Registered
                        ELSE
                            IF NOT ("GST Customer Type" IN ["GST Customer Type"::Registered, "GST Customer Type"::Exempted]) THEN
                                "GST Customer Type" := "GST Customer Type"::Registered;
                    END ELSE
                        "GST Customer Type" := "GST Customer Type"::" "
                ELSE
                    "GST Customer Type" := "GST Customer Type"::" ";


            end;
        }
        field(19; "GST Registration Type"; Option)
        {
            OptionCaption = 'GSTIN,UID,GID';
            OptionMembers = GSTIN,UID,GID;
        }
        field(20; "GST Customer Type"; Option)
        {
            OptionCaption = ' ,Registered,Unregistered,Export,Deemed Export,Exempted';
            OptionMembers = " ",Registered,Unregistered,Export,"Deemed Export",Exempted;
        }
        field(21; "Customer Created"; Boolean)
        {
        }
        field(22; "CRM Payment Cteated"; Boolean)
        {
        }
        field(25; "Account Type"; Option)
        {
            OptionMembers = " ",Cash,Other;
        }
        field(26; "External Doc No."; Code[35])
        {
        }
        field(27; CashFlow; Boolean)
        {
        }
        field(28; "GL Account No.1"; Code[20])
        {
        }
        field(29; Amount1; Decimal)
        {
        }
        field(30; Narration1; Text[50])
        {
        }
        field(31; "GL Account No.2"; Code[20])
        {
        }
        field(32; Amount2; Decimal)
        {
        }
        field(33; Narration2; Text[50])
        {
        }
        field(34; "GL Account No.3"; Code[20])
        {
        }
        field(35; Amount3; Decimal)
        {
        }
        field(36; Narration3; Text[50])
        {
        }
        field(37; "GL Account No.4"; Code[20])
        {
        }
        field(38; Amount4; Decimal)
        {
        }
        field(39; Narration4; Text[50])
        {
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
    }
}

