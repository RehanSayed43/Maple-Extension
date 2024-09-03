tableextension 50046 "Purch Inv. Header Table" extends "Purch. Inv. Header"
{
    fields
    {
        field(50000; "Vendor Invoice Value"; Decimal)
        {
        }
        field(50001; "PO Validity Date"; Date)
        {
        }
        field(50002; "Retail Sale Invoice Ref. No."; Code[20])
        {
        }
        // field(50003;Closed;Boolean)
        // {
        //     InitValue = false;
        // }
        field(50004; "Closing Remark"; Text[100])
        {
        }
        field(50005; "Closed By"; Code[50])
        {
            TableRelation = User."User Name";
        }
        field(50006; "Closed Date & Time"; DateTime)
        {
        }
        field(50007; "Retail Buyback Ref. No."; Code[20])
        {
        }
        field(50008; "Remarks Team"; Text[250])
        {
        }
        field(50009; "Remarks Vendor"; Text[250])
        {
        }
        field(50010; "Dispatch Doc No"; Text[50])
        {
        }
        field(50011; "Dispatch Through"; Text[50])
        {
        }
        field(50012; "Dispatch Date"; Date)
        {
        }
        field(50013; "Vendor Invoice Date"; Date)
        {
            Description = 'WIN234';
        }
        field(50050; "Import Document No."; Code[30])
        {
        }
        field(50052; "Expense Invoice"; Boolean)
        {
            Description = 'WIN234';
        }
        field(50053; "DOA Transaction"; Boolean)
        {
            Description = 'WIN234';
        }
    }
}
