pageextension 50133 "Sales Order Statistics" extends "Sales Order Statistics"
{
    layout
    {

    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin

        PurchaseLine.SETRANGE("Document Type", Rec."Document Type");
        PurchaseLine.SETRANGE("Document No.", Rec."No.");
        PurchaseLine.SETFILTER(Type, '=%1', PurchaseLine.Type::Item);
        PurchaseLine.SETFILTER(Quantity, '<>%1', 0);
        IF PurchaseLine.FINDSET THEN begin
            iTEMGSTAmount += PurchaseLine.Quantity;
        end;

    END;

    var
        myInt: Integer;
        PurchaseLine: Record "Sales Line";
        iTEMGSTAmount: Decimal;
}