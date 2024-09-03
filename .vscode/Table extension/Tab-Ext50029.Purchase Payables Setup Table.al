tableextension 50029 "Purchase Payables Setup Table" extends "Purchases & Payables Setup"
{
    fields
    {
        field(50000; "Buyback Vendor"; Code[20])
        {
            TableRelation = Vendor;
        }
        field(50001; "Maximum Invoice Diff. Allowed"; Decimal)
        {
        }
        field(50002; "Sender Mail ID( Maple)"; Text[100])
        {
        }
        field(50003; "PDF Path"; Text[100])
        {
        }
        field(50004; "Retail Buyback Purchase Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50005; "In-Gram Show Json"; Boolean)
        {
        }
    }
}
