tableextension 50051 "General Ledger Setup Table" extends "General Ledger Setup"
{
    fields
    {
        field(50000; "Vendor Cash Limit"; Decimal)
        {
            Description = 'Added by Sandip Deshpande for Vendor Cash Limit';
        }
        field(50002; "Cheque No. Length"; Integer)
        {
            Description = 'PDC';
        }
        field(50003; "MICR Code Length"; Integer)
        {
            Description = 'PDC';
        }
        field(50004; "Cust PDC Batch No."; Code[20])
        {
            Description = 'PDC';
            // TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = CONST(GENERAL));
        }
        field(50005; "Vend PDC Batch No."; Code[20])
        {
            Description = 'PDC';
            // TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = CONST(GENERAL));
        }
        field(50006; "Cust PDC Posting Group"; Code[10])
        {
            Description = 'PDC';
        }
        field(50007; "Vend PDC Posting Group"; Code[10])
        {
            Description = 'PDC';
        }
        field(50008; "Purchase Invoice IIIrd Party"; Boolean)
        {
        }
        field(50009; "Sales Invoice IIIrd Party"; Boolean)
        {
        }
        field(50010; "Denomination Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50011; "Daily Currency Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50012; "Cash Account"; Code[20])
        {
            TableRelation = "G/L Account" WHERE("Cash Account" = CONST(true));
        }
        field(50034; "Invoice Terms 1"; Text[250])
        {
        }
        field(50035; "Invoice Terms 2"; Text[250])
        {
        }
        field(50036; "Invoice Terms 3"; Text[250])
        {
        }
        field(50037; "Invoice Terms 4"; Text[250])
        {
        }
        field(50038; "Invoice Terms 5"; Text[250])
        {
        }
        field(50039; "Invoice Terms 6"; Text[250])
        {
        }
        field(50040; "BB Cash Account"; Code[20])
        {
            Description = 'added for buyback';
            TableRelation = "G/L Account";
        }
        field(50041; "E-Way Amount Limit"; Decimal)
        {
            Description = 'EwayBill';
        }
        field(50042; "E-Way Distance Limit"; Decimal)
        {
            Description = 'EwayBill';
        }
        field(50043; "E-Way Document Store Path"; Text[30])
        {
            Description = 'EwayBill';
        }
        field(50044; "Mapple File Date"; Date)
        {
            Description = 'Harish';
        }
        field(50045; "ISL File No."; Integer)
        {
        }
        field(50046; "OSL File No."; Integer)
        {
        }
        field(50047; "RET File No."; Integer)
        {
        }
        field(50048; "gspappid"; Text[250])
        {
            //Description = 
        }
        field(50049; "gspappsecret"; Text[250])
        {
            //Description = 
        }
    }
}
