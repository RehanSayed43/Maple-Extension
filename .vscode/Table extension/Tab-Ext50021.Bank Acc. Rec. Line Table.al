tableextension 50021 "Bank Acc. Rec. Line Table" extends "Bank Acc. Reconciliation Line"
{
    fields
    {
        field(50000; Reconciled; Boolean)
        {
        }
        field(50001; "Debit Amount"; Decimal)
        {
        }
        field(50002; "Credit Amount"; Decimal)
        {
        }
    }
}
