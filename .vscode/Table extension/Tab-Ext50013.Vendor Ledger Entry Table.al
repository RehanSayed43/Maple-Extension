tableextension 50013 "Vendor Ledger Entry Table" extends "Vendor Ledger Entry"
{
    fields
    {
        field(50000; "Cheque No."; Code[20])
        {
            Description = '// WIN 30-04-2014';
        }
        field(50001; "Cheque Date"; Date)
        {
            Description = '// WIN 30-04-2014';
        }
        field(50002; "PDC Unposted Amount"; Decimal)
        {
            // CalcFormula = Sum("Log Entry"."Document Type1" WHERE("Amount Available for Appln" = FIELD("Entry No.")));
            Description = 'PDC';
            FieldClass = FlowField;
        }
        field(50013; Narration; Text[50])
        {
            Description = '//*** WIN241';
        }
    }
}
