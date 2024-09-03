table 50023 "EWay Bill Entry"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; "E-Way Bill Operation"; Option)
        {
            DataClassification = ToBeClassified;
            InitValue = "Generate EWB";
            OptionCaption = ' ,Generate EWB,Update Vehicle No.,Generate CEWB,Cancel EWB,Reject EWB,Update Transporter,Extend Validity of EWB,Re-Gen CEWB,Get EWB Details,Get EWB Assign for Trans.,Get EWB Assign to Trans by GSTIN,Get EWB gen on req of Other Party,Get CEWB,Get GSTIN details,Get Transin details,Get HSN details,Print EWB';
            OptionMembers = " ","Generate EWB","Update Vehicle No.","Generate CEWB","Cancel EWB","Reject EWB","Update Transporter","Extend Validity of EWB","Re-Gen CEWB","Get EWB Details","Get EWB Assign for Trans.","Get EWB Assign to Trans by GSTIN","Get EWB gen on req of Other Party","Get CEWB","Get GSTIN details","Get Transin details","Get HSN details","Print EWB";
        }
        field(3; Status; Boolean)
        {
            DataClassification = ToBeClassified;
            InitValue = false;
        }
        field(4; "Document No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Transaction Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Sales Invoice,Sales Return,Transfer Shipment,Purchse Return,Sales Creditmemo,Purchase Invoice';
            OptionMembers = " ","Sales Invoice","Sales Return","Transfer Shipment","Purchse Return","Sales Creditmemo","Purchase Invoice";
        }
        field(6; "E-Way Bill No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Date; DateTime)
        {
            Caption = 'eWay Bill Date';
            DataClassification = ToBeClassified;
        }
        field(8; "Valid Until"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Error1; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Error2; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Error3; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Vehicle Update Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Cancel Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Cancel Reason Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Cancel Remark"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Rejected Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Transaction Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Transporter Id"; Text[30])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(19; "Transporter Updated Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "EWB Updated Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Remaining Distance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Update Vehicle Reason Remark"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "E-Way Bill Valid Upto"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Vehicle Update Reason"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Vehicle Type"; Text[1])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Sub Supply Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Supply,Import,Export,Job Work,For Own Use,Job Work Returns,Sales Return,Others,SKD/CKD,Line Sales,Recipient Not Known,Exhibition or Fairs';
            OptionMembers = " ",Supply,Import,Export,"Job Work","For Own Use","Job Work Returns","Sales Return",Others,"SKD/CKD","Line Sales","Recipient Not Known","Exhibition or Fairs";
        }
        field(27; "E-Way Reason For Updation"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Due to Break Down,Due to Transhipment,Others,First Time';
            OptionMembers = " ","1","2","3","4";
        }
        field(28; "LR/RR No."; Code[20])
        {
            Caption = 'LR/RR No.';
            DataClassification = ToBeClassified;
        }
        field(29; "LR/RR Date"; DateTime)
        {
            Caption = 'LR/RR Date';
            DataClassification = ToBeClassified;
        }
        field(30; "Vehicle No."; Code[20])
        {
            Caption = 'Vehicle No.';
            DataClassification = ToBeClassified;
        }
        field(31; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            DataClassification = ToBeClassified;
            TableRelation = "Transport Method";
        }
        field(32; "Extension Remark"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Extension Reason Code"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Transport Assign Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = User."User Name";
            ValidateTableRelation = false;

            trigger OnLookup()
            var
                UserMgt: Codeunit "User Management";
            begin
            end;

            trigger OnValidate()
            var
                UserMgt: Codeunit "User Management";
            begin
            end;
        }
        field(36; Retrive; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

