page 50055 "Customer HistoryList"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    CardPageID = "Customer History Entry(ILE)";
    PageType = List;
    SourceTable = "Item Ledger Entry";
    SourceTableView = WHERE(HistoryData = CONST(True));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = all;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = all;
                    Caption = 'Actual Qty';
                    Visible = false;
                }
                field(Qty; Qty)
                {
                    ApplicationArea = all;
                    Caption = 'Quantity';
                }
                field("Sales Amount (Actual)"; Rec."Sales Amount (Actual)")
                {
                    ApplicationArea = all;
                    Caption = 'Sales Amount';
                }
                field("Warranty Date"; Rec."Warranty Date")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        Qty := Rec.Quantity * -1;
    end;

    var
        [InDataSet]
        Qty: Integer;
}

