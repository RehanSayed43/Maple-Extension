tableextension 50052 "Purch Cr. Memo Header Table" extends "Purch. Cr. Memo Hdr."
{
    fields
    {
        field(50051; CRM; Boolean)
        {
        }
        field(50053; "DOA Transaction"; Boolean)
        {
            Description = 'WIN234';
        }
        field(50206; Distance; Decimal)
        {
            Description = 'Eway Bill';
        }
        // field(50207; "E-Way Bill No."; Code[20])
        // {
        //     Description = 'Eway Bill';
        // }
        field(50208; "E-Way Bill Date"; DateTime)
        {
            Description = 'Eway Bill';
        }
        // field(50209; "Vehicle Type"; Option)
        // {
        //     Description = 'Eway Bill';
        //     OptionCaption = ' ,Regular,ODC';
        //     OptionMembers = " ",R,O;
        // }
        field(50210; "Cancel Reason Code"; Option)
        {
            Description = 'Eway Bill';
            OptionCaption = ' ,Duplicate,Order Cancelled,Data Entry Mistake,Other';
            OptionMembers = "0","1","2","3","4";
        }
        field(50211; "Cancel Remark"; Text[20])
        {
            Description = 'Eway Bill';
        }
        // field(50212; "Vehicle No."; Code[20])
        // {
        //     Description = 'Eway Bill';
        // }
    }
}
