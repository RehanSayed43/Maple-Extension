page 50057 "Sales Invoice Items"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    Editable = false;
    PageType = List;
    SourceTable = "Sales Invoice Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = all;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = all;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = all;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = all;
                }

                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ApplicationArea = all;
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ApplicationArea = all;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ApplicationArea = all;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = all;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = all;
                }
                field("Scheme Code"; Rec."Scheme Code")
                {
                    ApplicationArea = all;
                }
                field("Scheme Amount"; Rec."Scheme Amount")
                {
                    ApplicationArea = all;
                }
                field("UPN Code"; Rec."UPN Code")
                {
                    ApplicationArea = all;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = all;
                }
                // field("Product Group Code";Rec. "Product Group Code")
                // {
                // }
                field("Primary category"; Rec."Primary category")
                {
                    ApplicationArea = all;
                }
                field("Secondary category"; Rec."Secondary category")
                {
                    ApplicationArea = all;
                }
                field("Third category"; Rec."Third category")
                {
                    ApplicationArea = all;
                }
                field("Shield Type"; Rec."Shield Type")
                {
                    ApplicationArea = all;
                }
                field("IMEI No."; Rec."IMEI No.")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

