table 50012 "Customer Set Off"
{

    fields
    {
        field(10; "Line No"; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(20; "Posting Date"; Date)
        {
            ClosingDates = true;
        }
        field(21; "Document No"; Code[20])
        {
        }
        field(22; "Account Type"; Option)
        {
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        }
        field(30; "Account No."; Code[20])
        {

            trigger OnValidate()
            var
                CompanyInfo: Record "Company Information";
                Location: Record Location;
            begin
            end;
        }
        field(40; Amount; Decimal)
        {
            AutoFormatType = 1;

            trigger OnValidate()
            var
                CustLedgerEntry: Record "Cust. Ledger Entry";
                CustLedgerEntry1: Record "Cust. Ledger Entry";
                VendLedgEntry: Record "Vendor Ledger Entry";
                VendLedgEntry1: Record "Vendor Ledger Entry";
                DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
                TransactionType: Option Purchase,Sales,Transfer,Settlement;
            begin
            end;
        }
        field(41; "Bal. Account No."; Code[20])
        {
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account" WHERE("Account Type" = CONST(Posting),
                                                                                           Blocked = CONST(False))
            ELSE
            IF ("Bal. Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Bal. Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Bal. Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Bal. Account Type" = CONST("IC Partner")) "IC Partner";

            trigger OnValidate()
            var
                CompanyInfo: Record "Company Information";
                Location: Record Location;
            begin
            end;
        }
        field(42; "Bal. Account Type"; Option)
        {
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        }
        field(50; "Shortcut Dimension 1 Code"; Code[20])
        {
        }
        field(60; "Shortcut Dimension 2 Code"; Code[20])
        {
        }
        field(70; "Applies-to Doc. Type"; Option)
        {
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(80; "Applies-to Doc. No."; Code[20])
        {

            trigger OnLookup()
            var
                PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
                //     ServTaxEntry: Record "Service Tax Management";
                AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
                AccNo: Code[20];
                TransactionType: Option Purchase,Sales,Transfer;
            begin
            end;

            trigger OnValidate()
            var
                CustLedgEntry: Record "Cust. Ledger Entry";
                VendLedgEntry: Record "Vendor Ledger Entry";
                TempGenJnlLine: Record "Gen. Journal Line" temporary;
                VendLedgEntry2: Record "Vendor Ledger Entry";
                //   ServTaxEntry: Record "Service Tax Management";
                CustLedgerEntry2: Record "Cust. Ledger Entry";
                TransactionType: Option Purchase,Sales,Transfer;
                NotOpenedLookUpErr: Label 'Please Drill Down and Select Appropriate HSN when applying a GST Document';
            begin
            end;
        }
        field(81; "JV Created"; Boolean)
        {
            Editable = false;
        }
        field(90; "JV Posted"; Boolean)
        {
        }
        field(100; Skip; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

