pageextension 50030 "SalesInvoice" extends "Sales Invoice"
{
    layout
    {
        addafter("No.")
        {
            field("Sales Order Type"; Rec."Sales Order Type")
            {
                Visible = false;
                ApplicationArea = all;
            }
        }
        addafter("Document Date")
        {
            field("Total Shield Value"; Rec."Total Shield Value")
            {
                ApplicationArea = all;
            }
            field("Shield Payment Amount"; Rec."Shield Payment Amount")
            {
                ApplicationArea = all;
            }
            field(Shield; Rec.Shield)
            {
                ApplicationArea = all;
            }
            field("FA Disposal"; Rec."FA Disposal")
            {
                ApplicationArea = all;
            }
            field("Debit Note"; Rec."Debit Note")
            {
                ApplicationArea = all;
            }
            field("CIN Number"; recComp."CIN no")
            {
                ApplicationArea = all;

            }


        }
        // addafter("VAT Bus. Posting Group")
        // {
        //     field(GetCreditcardNumber; GetCreditcardNumber)
        //     {
        //         Caption = 'Cr. Card Number (Last 4 Digits)';
        //     }
        //     field("Credit Card No."; "Credit Card No.")
        //     {
        //     }
        // }

    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
        recComp: Record "Company Information";
}