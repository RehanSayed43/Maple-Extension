tableextension 50000 "Vendor Table" extends Vendor
{
    fields
    {
        field(50004; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment,Approved';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment",Approved;
        }
        field(51018; "Dr Change"; Decimal)
        {
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Debit Amount (LCY)" WHERE("Vendor No." = FIELD("No."),
                                                                                        "Entry Type" = CONST("Initial Entry"),
                                                                                        "Posting Date" = FIELD("Date Filter"),
                                                                                        "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                        "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter")));
            Description = 'Added for Vendor Trial Balance';
            FieldClass = FlowField;
        }
        field(51019; "Cr Change"; Decimal)
        {
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Credit Amount (LCY)" WHERE("Vendor No." = FIELD("No."),
                                                                                         "Entry Type" = CONST("Initial Entry"),
                                                                                         "Posting Date" = FIELD("Date Filter"),
                                                                                        "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                         "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter")));
            Description = 'Added for Vendor Trial Balance';
            FieldClass = FlowField;
        }
        field(51020; "Apple Distributor"; Boolean)
        {
        }
        field(51021; "Scheme Provisional A/C"; Code[20])
        {
            TableRelation = "G/L Account";
        }
    }
}
