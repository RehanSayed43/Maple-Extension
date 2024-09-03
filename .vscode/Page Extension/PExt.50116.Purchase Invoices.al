pageextension 50116 "Purchase Invoices" extends "Purchase Invoices"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        modify(PostAndPrint)
        {
            trigger OnAfterAction()
            begin
                IF Rec."Vendor Invoice Date" = 0D THEN
                    ERROR('Vendor Invoice Date can not be blank');//Win-234 18-12-2019
                Rec.SendToPosting(CODEUNIT::"Purch.-Post + Print");
            end;
        }
    }


    var
        myInt: Integer;
}