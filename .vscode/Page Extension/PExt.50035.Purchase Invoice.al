pageextension 50035 "PurchaseInvoice" extends "Purchase Invoice"
{
    layout
    {
        addafter("Document Date")
        {
            field("Retail Sale Invoice Ref. No."; Rec."Retail Sale Invoice Ref. No.")
            {
                ApplicationArea = all;
            }

            field("Vendor Invoice Date"; Rec."Vendor Invoice Date")
            {

                ApplicationArea = all;
            }
            field("Import Document No."; Rec."Import Document No.")
            {
                ApplicationArea = all;
            }

        }
        addafter("Purchaser Code")
        {
            field("Vendor Invoice Value"; Rec."Vendor Invoice Value")
            {
                ApplicationArea = all;
            }
            field("CIN Number"; recCI."CIN no")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
        recCI: Record "Company Information";
}