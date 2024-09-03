page 50093 "E commerce Order"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    Editable = false;
    PageType = List;
    SourceTable = "Store E-Commerce Order";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = all;
                }
                field("Order ID"; Rec."Order ID")
                {
                    ApplicationArea = all;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = all;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Item No"; Rec."Item No")
                {
                    ApplicationArea = all;
                }
                field("Customer Created"; Rec."Customer Created")
                {
                    ApplicationArea = All;
                }
                field("Order Created"; Rec."Order Created")
                {
                    ApplicationArea = all;
                }
                field("Transfer Order Created"; Rec."Transfer Order Created")
                {
                    ApplicationArea = All;
                }
                field("Order Posted"; Rec."Order Posted")
                {
                    ApplicationArea = all;
                }
                field("Transfer Order Posted"; Rec."Transfer Order Posted")
                {
                    ApplicationArea = all;
                }
                field("Payment Created"; Rec."Payment Created")
                {
                    ApplicationArea = all;
                }
                field("Payment Posted"; Rec."Payment Posted")
                {
                    ApplicationArea = all;
                }
                field("E Com Location Code"; Rec."E Com Location Code")
                {
                    ApplicationArea = all;
                }
                field(SKU1; Rec.SKU1)
                {
                    ApplicationArea = all;
                }
                field("Varient SKU"; Rec."Varient SKU")
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
                field("Return Order Created"; Rec."Return Order Created")
                {
                    ApplicationArea = all;
                }
                field("Return Order Posted"; Rec."Return Order Posted")
                {
                    ApplicationArea = all;
                }
                field("Return Transfer Order Created"; Rec."Return Transfer Order Created")
                {
                    ApplicationArea = all;
                }
                field("Return Transfer Order Posted"; Rec."Return Transfer Order Posted")
                {
                    ApplicationArea = all;
                }
                field("Return Payment Created"; Rec."Return Payment Created")
                {
                    ApplicationArea = all;
                }
                field("Return Payment Posted"; Rec."Return Payment Posted")
                {
                    ApplicationArea = all;
                }
                field("Skip Order"; Rec."Skip Order")
                {
                    ApplicationArea = all;
                }
                field("User Created Order"; Rec."User Created Order")
                {
                    ApplicationArea = all;
                }
                field("USER ID"; Rec."USER ID")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

