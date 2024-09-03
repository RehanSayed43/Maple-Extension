tableextension 50023 "Finance CueTable" extends "Finance Cue"
{
    fields
    {
        field(50000; "Pending Transfer - Rental"; Integer)
        {
            CalcFormula = Count("Transfer Header" WHERE("Rental Sales Invoice No." = FILTER(<> ''),
                                                         "Total Shipment" = FILTER(> 0)));
            FieldClass = FlowField;
        }
    }
}
