tableextension 50012 "Cust Ledger Entry Table" extends "Cust. Ledger Entry"
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
        field(50003; "PDC Unposted Amount"; Decimal)
        {
            //  CalcFormula = Sum("Log Entry"."Document Type1" WHERE(Field10 = FIELD("Entry No.")));
            Description = 'PDC';
            FieldClass = FlowField;
        }
        field(50004; "PDC Due Date"; Date)
        {
            Description = 'PDC';
        }
        field(50005; "PDC Cancellation Debit Note"; Boolean)
        {
            Description = 'PDC';
        }
        field(50006; "Cheque No1"; Code[20])
        {
            Description = 'PDC';
        }
        field(50007; "Cheque Date1"; Date)
        {
            Description = 'PDC';
        }
        field(50008; "Scheme Code"; Code[10])
        {
        }
        field(50009; "Scheme Amount"; Decimal)
        {
        }
        field(50013; Narration; Text[50])
        {
            Description = '//*** WIN241';
        }
    }
}
