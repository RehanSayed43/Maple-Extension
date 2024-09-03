page 50194 "Create Online Sales Order"
{
    UsageCategory = Administration;
    ApplicationArea = all;
    Caption = 'Online Sales Order';

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Create Ecommerce Order Id"; Order_ID)
                {
                    ApplicationArea = all;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        //  IF Order_ID <> '' THEN
                        //Store_ecommerce_order.Create_sales_order1(Order_ID);//tk
                    end;
                }
                field("Order To Be Cancel"; Order_ID1)
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        // IF Order_ID1 <> '' THEN
                        //    Store_ecommerce_order.Cancel_sales_order(Order_ID1);
                    end;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
        }
    }

    var
        Order_ID: Code[20];
        // Store_ecommerce_order: Codeunit "Store Ecommerce Order";//tk
        Order_ID1: Code[20];
}

