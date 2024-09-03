/*reportextension 50100 InventoryValuation extends "Inventory Valuation"
{
    RDLCLayout = 'InventoryValuationExtends.rdl';
    dataset
    {
        add(Item)
        {
            column(ItemLocFilter; ItemLocFilter) { }
        }
    }
    trigger OnPreReport()
    begin
        ItemLocFilter := Item.GetFilter("Location Filter");
    end;

    var
        ItemLocFilter: Text;

}
*/