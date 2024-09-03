tableextension 50060 "Sales Shipment Header Table" extends "Sales Shipment Header"
{
    fields
    {
        field(50102; "Capillary Discount Amount"; Decimal)
        {
            Description = 'CAPILARY';
            Editable = false;
        }
        field(50115; "Order ID"; Code[20])
        {
            Description = 'E commerce';
            Editable = false;
        }
    }
}
