tableextension 50033 "Sales Cue Table" extends "Sales Cue"
{
    fields
    {
        field(50000; "Pending Transfer - Rental"; Integer)
        {
            CalcFormula = Count("Transfer Header" WHERE("Rental Sales Invoice No." = FILTER(<> ''),
                                                         "Total Shipment" = FILTER(> 0)));
            FieldClass = FlowField;
        }
        field(50001; "Pending Transfer Rept - Rental"; Integer)
        {
            CalcFormula = Count("Transfer Header" WHERE("Rental Sales Invoice No." = FILTER(<> ''),
                                                         "Total Receipt" = FILTER(> 0)));
            FieldClass = FlowField;
        }
    }
}
