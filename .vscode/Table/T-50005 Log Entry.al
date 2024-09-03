table 50005 "Log Entry"
{
    DrillDownPageID = 50005;
    LookupPageID = 50005;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Invoice,Credit Memo';
            OptionMembers = Invoice,"Credit Memo";
        }
        field(3; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Message; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Message1; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Message2; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Message3; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Creation DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(100; "Document Type1"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(200; "Document No.1"; Code[20])
        {
        }
        field(300; "Document Date"; Date)
        {
            Editable = false;
        }
        field(400; "Due Date"; Date)
        {
            Editable = true;
        }
        field(500; "Customer No."; Code[20])
        {
            Editable = false;
        }
        field(600; "Customer Name"; Text[30])
        {
            Editable = false;
        }
        field(1000; "Document Amount"; Decimal)
        {
            Editable = false;
        }
        field(2000; "Remaining Amount"; Decimal)
        {
            Editable = false;
        }
        field(3000; "PDC Unposted Amount"; Decimal)
        {
            Editable = false;
        }
        field(5000; "Amount Available for Appln"; Decimal)
        {
            Editable = false;
        }
        field(6000; "PDC Amount Available"; Decimal)
        {
            Editable = false;
        }
        field(10000; "Amount to Apply"; Decimal)
        {
        }
        field(20000; Apply; Boolean)
        {
        }
        field(30000; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
        }
        field(30001; "Send For Authorization"; Boolean)
        {
        }
        field(30002; Athorized; Boolean)
        {
        }
        field(30003; "PDC Cheque Date"; Date)
        {

            trigger OnValidate()
            begin
                //TESTFIELD("PDC Status","PDC Status"::Open);
            end;
        }
        field(30004; "Vend Ledger Entry No."; Integer)
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

    var
        // PDCEntry: Record "PDC";
        CustLedgEntry: Record "Cust. Ledger Entry";
        Text001: Label 'Maximum Additional Amount to apply is %1. Please check the entry.';


    procedure GetErrorMessage(): Text
    begin
        EXIT(Message + Message1 + Message2 + Message3);
    end;
}

