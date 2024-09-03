page 50045 "Pending Free Items List"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Sales Line";
    SourceTableView = SORTING("Document Type", Type, "No.", "Variant Code", "Drop Shipment", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Location Code", "Shipment Date")
                      WHERE("Document Type" = CONST(Order),
                            Type = CONST(Item),
                            "Free Item" = CONST(True));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = all;
                    Caption = 'Customer No.';
                    StyleExpr = StyleTxt;
                }
                field(CustomerName; CustomerName)
                {
                    ApplicationArea = all;
                    Caption = 'Customer Name';
                    StyleExpr = StyleTxt;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleTxt;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleTxt;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleTxt;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                    StyleExpr = StyleTxt;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = all;
                    StyleExpr = StyleTxt;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleTxt;
                }
                field(ItemStock; ItemStock)
                {
                    ApplicationArea = all;
                    Caption = 'Item Inventory';
                    StyleExpr = StyleTxt;
                }
                field(CustomerPhone; CustomerPhone)
                {
                    ApplicationArea = all;
                    Caption = 'Customer Phone No.';
                    StyleExpr = StyleTxt;
                }
                field(CustomerEmail; CustomerEmail)
                {
                    ApplicationArea = all;
                    Caption = 'Customer Email ID';
                    StyleExpr = StyleTxt;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        Item.GET(Rec."No.");
        Item.CALCFIELDS(Inventory);
        ItemStock := Item.Inventory;
        IF ItemStock > 0 THEN
            StyleTxt := 'StrongAccent'
        ELSE
            StyleTxt := 'Standard';
        Customer.GET(Rec."Sell-to Customer No.");
        CustomerEmail := Customer."E-Mail";
        CustomerPhone := Customer."Phone No.";
        CustomerName := Customer.Name;
    end;

    var
        [InDataSet]
        CustomerPhone: Text[100];
        [InDataSet]
        ItemStock: Integer;
        [InDataSet]
        CustomerEmail: Text[150];
        Item: Record 27;
        StyleTxt: Text;
        Customer: Record 18;
        [InDataSet]
        CustomerName: Text;
}

