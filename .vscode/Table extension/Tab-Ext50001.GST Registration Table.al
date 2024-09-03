tableextension 50001 "GST Registration Table" extends "GST Registration Nos."
{
    fields
    {
        field(57300; "Token Exp Date Time"; DateTime)
        {
            DataClassification = ToBeClassified;
            Description = 'KPPL_EINV 1.0';
        }
        field(57301; "Token No"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'KPPL_EINV 1.0';
        }
        field(57302; "User Name"; Text[60])
        {
            DataClassification = ToBeClassified;
            Description = 'KPPL_EINV 1.0';
        }
        field(57303; Password; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'KPPL_EINV 1.0';
        }
        field(57304; "Generated DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
            Description = 'KPPL_EINV 1.0';
        }
        field(57305; "Eway Token No"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'KPPL_EINV 1.0';
        }
        field(57306; "Eway Token Exp Date Time"; DateTime)
        {
            DataClassification = ToBeClassified;
            Description = 'KPPL_EINV 1.0';
        }
        field(57307; "Eway Generated DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
            Description = 'KPPL_EINV 1.0';
        }
    }
}
