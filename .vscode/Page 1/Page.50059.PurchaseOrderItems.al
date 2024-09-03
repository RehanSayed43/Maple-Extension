page 50059 "Purchase Order Items"
{
    Editable = false;
    PageType = List;
    SourceTable = 39;
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Outstanding Quantity"; Rec."Outstanding Quantity")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Invoice"; Rec."Qty. to Invoice")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Receive"; Rec."Qty. to Receive")
                {
                    ApplicationArea = All;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Qty. Rcd. Not Invoiced"; Rec."Qty. Rcd. Not Invoiced")
                {
                    ApplicationArea = All;
                }
                field("Amt. Rcd. Not Invoiced"; Rec."Amt. Rcd. Not Invoiced")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Amount"; Rec."Outstanding Amount")
                {
                    ApplicationArea = All;
                }
                field("Quantity Received"; Rec."Quantity Received")
                {
                    ApplicationArea = All;
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    ApplicationArea = All;
                }
                field("Receipt No."; Rec."Receipt No.")
                {
                    ApplicationArea = All;
                }
                field("Receipt Line No."; Rec."Receipt Line No.")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                }
                // field("Product Group Code"; "Product Group Code")
                // {
                // }
                field("State Code"; Rec."State Code")
                {
                    ApplicationArea = All;
                }
                // field("Amount To Vendor"; "Amount To Vendor")
                // {
                // }
                // field("Charges To Vendor"; "Charges To Vendor")
                // {
                // }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Item Serial No"; Rec."Item Serial No")
                {
                    ApplicationArea = All;
                }
                field("IMEI No."; Rec."IMEI No.")
                {
                    ApplicationArea = All;
                }
                field("Primary category"; Rec."Primary category")
                {
                    ApplicationArea = All;
                }
                field("Secondary category"; Rec."Secondary category")
                {
                    ApplicationArea = All;
                }
                field("Third category"; Rec."Third category")
                {
                    ApplicationArea = All;
                }
                field("UPN Code"; Rec."UPN Code")
                {
                    ApplicationArea = All;
                }
                field("Vendor Part Code Long"; Rec."Vendor Part Code Long")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

