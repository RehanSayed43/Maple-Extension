tableextension 50032 "Resource Setup Table" extends "Resources Setup"
{
    fields
    {
        field(50000; "Voucher Base URL"; Text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Voucher Auth Base URL"; Text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Capture Base URL"; Text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Cancel Base URL"; Text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Refund Base URL"; Text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Transaction Base URL"; Text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Show Json"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
}
