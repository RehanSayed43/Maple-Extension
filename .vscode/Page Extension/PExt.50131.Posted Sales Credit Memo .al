pageextension 50131 "Posted Sales CreditMemo" extends "Posted Sales Credit Memo"
{
    Editable = true;

    layout
    {
        addafter("No.")
        {
            field("Sales Order Type"; Rec."Sales Order Type")
            {
                ApplicationArea = all;
            }

        }

        addbefore("External Document No.")
        {


            field("Ref. Invoice No."; Rec."Ref. Invoice No.")
            {
                Editable = false;
                Style = Strong;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            field("Promo Code"; Rec."Promo Code")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Delivery Note"; Rec."Delivery Note")
            {
                Editable = true;
                ApplicationArea = All;
            }
            field("Dispatch Doc. No."; Rec."Dispatch Doc. No.")
            {
                Editable = true;
                ApplicationArea = All;
            }
            field("Dispatch Through"; Rec."Dispatch Through")
            {
                Editable = true;
                ApplicationArea = All;

            }

        }


        addafter("Cancel Reason")
        {
            field("E-Invoice Cancel Remark"; Rec."E-Invoice Cancel Remark")
            {
                ApplicationArea = All;
            }
            field("E-Invoice Reason Code"; Rec."E-Invoice Reason Code")
            {
                ApplicationArea = all;
            }
            field("E-invoice Cancelled"; Rec."E-invoice Cancelled")
            {
                ApplicationArea = All;
            }

        }
    }


    actions
    {
        modify("Generate E-Invoice")
        {
            Visible = false;
        }
        // Add changes to page actions here
        addafter("Generate IRN")
        {
            action("Generate E-Invoice IRN")
            {
                ApplicationArea = all;
                trigger OnAction()
                var
                    Einvoice: Codeunit "E-Invoice";
                begin
                    Einvoice.EInvoicingGenerationCRMemo(Rec);

                end;
            }
            action("Cancel E-Invoice IRN")
            {
                ApplicationArea = all;
                trigger OnAction()
                var
                    Einvoice: Codeunit "E-Invoice";
                begin
                    Einvoice.CancelEInvTaxProCN(Rec);


                end;
            }
        }
    }

    var
        myInt: Integer;
}