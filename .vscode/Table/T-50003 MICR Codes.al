table 50003 "MICR Codes"
{
    DrillDownPageID = 50008;
    LookupPageID = 50008;

    fields
    {
        field(1; "Code Type"; Option)
        {
            OptionCaption = 'MICR,BankDeposit';
            OptionMembers = MICR,BankDeposit;
        }
        field(2; "MICR Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(10; "Bank Name"; Text[250])
        {
        }
        field(20; "Bank Branch"; Text[250])
        {
        }
        field(50; "Bank No."; Code[20])
        {
            Description = 'If Internal';
            TableRelation = "Bank Account";
        }
        field(60; Description; Text[30])
        {
            Description = 'For Bank Deposit Code';
        }
        field(100; "Responsibility Centre"; Code[10])
        {
            TableRelation = "Bank Account";
        }
        field(101; "Cheque Type"; Option)
        {
            OptionMembers = ,"Local",Outstation;
        }
    }

    keys
    {
        key(Key1; "Code Type", "MICR Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //PROTECTED
        //  IF UserMgt.GetSalesFilter() <> '' THEN
        //    "Responsibility Centre" := UserMgt.GetSalesFilter();
    end;

    var
        UserMgt: Codeunit "User Management";
}

