page 50162 "Items Recd. Not Invoiced List"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Purchase Line";
    SourceTableView = SORTING(Type, "No.", "Variant Code", "Drop Shipment", "Location Code", "Document Type", "Expected Receipt Date")
                      ORDER(Ascending)
                      WHERE("Document Type" = CONST(Order),
                            "Qty. Rcd. Not Invoiced" = FILTER(<> 0));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = all;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field("Quantity Received"; Rec."Quantity Received")
                {
                    ApplicationArea = all;
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    ApplicationArea = all;
                }
                field("Outstanding Quantity"; Rec."Outstanding Quantity")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        //FILTERGROUP(10);
        //SETFILTER("Quantity Received",'<>%1',"Quantity Invoiced");
        //FILTERGROUP(0);
    end;
}

