pageextension 50120 "Location Card" extends "Location Card"
{
    layout
    {
        addbefore("Use As In-Transit")
        {
            field("Name 2"; Rec."Name 2")
            {
                ApplicationArea = all;
            }

            // field("Post Code"; "Post Code")
            // {
            //     ApplicationArea = all;
            // }
            // field(City; City)
            // {
            //     ApplicationArea = all;
            // }
            // field("Country/Region Code"; "Country/Region Code")
            // {
            //     ApplicationArea = all;
            // }
            // field("State Code"; "State Code")
            // {
            //     ApplicationArea = all;
            // }
            // field(Contact; Contact)
            // {
            //     ApplicationArea = all;
            // }
            field("Location Type"; Rec."Location Type")
            {
                ApplicationArea = all;
            }
        }
        addafter("Use As In-Transit")
        {
            field("Rental From Location"; Rec."Rental From Location")
            {
                ApplicationArea = all;
            }
            field("Bank Account"; Rec."Bank Account")
            {
                ApplicationArea = all;
            }
            field("E Com Location Code"; Rec."E Com Location Code")
            {
                ApplicationArea = all;
            }
            field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
            {
                ApplicationArea = all;
            }
            field("POS Apple ID"; Rec."POS Apple ID")
            {
                ApplicationArea = all;
            }
            field("Voucher Client ID"; Rec."Voucher Client ID")
            {
                ApplicationArea = all;
            }
            field("Voucher Secret Code"; Rec."Voucher Secret Code")
            {
                ApplicationArea = all;
            }
            field("Salable Location Code"; Rec."Salable Location Code")
            {
                ApplicationArea = all;
            }
            field("Ingram Location"; Rec."Ingram Location")
            {
                ApplicationArea = all;
            }
        }
        addbefore(Warehouse)
        {

            group(Communication)
            {
                Caption = 'Communication';
                // field("Phone No."; "Phone No.")
                // {
                //     ApplicationArea = all;
                //     Importance = Promoted;
                // }
                // field("Fax No."; "Fax No.")
                // {
                //     ApplicationArea = all;
                // }
                // field("E-Mail"; "E-Mail")

                // {
                //     ApplicationArea = all;
                // }

                field("Einvoice E-Mail"; Rec."Einvoice E-Mail")
                {
                    Caption = 'E-Invoice E-mail ID';
                    ApplicationArea = all;
                }
                // field("Home Page"; "Home Page")
                // {
                //     ApplicationArea = all;
                // }
            }
            group("E-Invoice Credentisl")
            {


                field("E-Invoice User ID"; Rec."E-Invoice User ID")
                {
                    ApplicationArea = all;
                }
                field("E-Invoice Password"; Rec."E-Invoice Password")
                {
                    ApplicationArea = all;
                }
            }
        }
        addafter(Bins)
        {
            group(Numbering)
            {
                Caption = 'Numbering';
                field("Purchase Order Nos."; Rec."Purchase Order Nos.")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                // field("Purch. Receipt Nos."; "Purch. Receipt Nos.")
                // {
                // }
                // field("Purch. Invoice Nos."; "Purch. Invoice Nos.")
                // {
                // }
                // field("Purch. Ret. Shipment Nos."; "Purch. Ret. Shipment Nos.")
                // {
                // }
                // field("Purch. Credit Memo Nos."; "Purch. Credit Memo Nos.")
                // {
                // }
                // field("Sales Shipment Nos."; "Sales Shipment Nos.")
                // {
                // }
                // field("Sales Invoice Nos."; "Sales Invoice Nos.")
                // {
                // }
                // field("Sales Return Receipt Nos."; "Sales Return Receipt Nos.")
                // {
                // }
                // field("Sales Credit Memo Nos."; "Sales Credit Memo Nos.")
                // {
                // }
                // field("Sales Shipment Nos. (Captive)"; "Sales Shipment Nos. (Captive)")
                // {
                //     Visible = false;
                // }
                // field("Shield Invoice Nos."; "Shield Invoice Nos.")
                // {
                // }
                // field("Posted Shield Invoice Nos."; "Posted Shield Invoice Nos.")
                // {
                //     Caption = 'Posted Shield Invoice Nos.';
                // }
                // field("Transfer Shipment Nos."; "Transfer Shipment Nos.")
                // {
                // }
                // field("Transfer Receipt Nos."; "Transfer Receipt Nos.")
                // {
                // }
                // field("Purch. Rcpt. Nos. (Trading)"; "Purch. Rcpt. Nos. (Trading)")
                // {
                //     Visible = false;
                // }
                // field("Purh. Invoice Nos. (Trading)"; "Purh. Invoice Nos. (Trading)")
                // {
                //     Visible = false;
                // }
                // field("Purch. Ret Shpt Nos. (Trading)"; "Purch. Ret Shpt Nos. (Trading)")
                // {
                //     Visible = false;
                // }
                // field("Purch Cr. Memo Nos. (Trading)"; "Purch Cr. Memo Nos. (Trading)")
                // {
                //     Visible = false;
                // }
                // field("Sales Shpt. Nos. (Trading)"; "Sales Shpt. Nos. (Trading)")
                // {
                //     Visible = false;
                // }
                // field("Sales Invoice Nos. (Trading)"; "Sales Invoice Nos. (Trading)")
                // {
                //     Visible = false;
                // }
                // field("Sales Ret Rcpt Nos. (Trading)"; "Sales Ret Rcpt Nos. (Trading)")
                // {
                //     Visible = false;
                // }
                // field("Sale Cr. Memo Nos. (Trading)"; "Sale Cr. Memo Nos. (Trading)")
                // {
                //     Visible = false;
                // }
                // field("Posted Serv. Shipment Nos."; "Posted Serv. Shipment Nos.")
                // {
                //     Visible = false;
                // }
                // field("Posted Serv. Cr. Memo Nos."; "Posted Serv. Cr. Memo Nos.")
                // {
                //     Visible = false;
                // }
                // field("Posted Serv. Invoice Nos."; "Posted Serv. Invoice Nos.")
                // {
                //     Visible = false;
                // }
                // field("Serv. Shipment Nos. (Trading)"; "Serv. Shipment Nos. (Trading)")
                // {
                //     Visible = false;
                // }
                // field("Serv. Invoice Nos. (Trading)"; "Serv. Invoice Nos. (Trading)")
                // {
                //     Visible = false;
                // }
                // field("Serv. Cr. Memo Nos. (Trading)"; "Serv. Cr. Memo Nos. (Trading)")
                // {
                //     Visible = false;
                // }
                group(GST)
                {
                    Caption = 'GST';
                    // field("Sales Inv. Nos. (Exempt)"; "Sales Inv. Nos. (Exempt)")
                    // {
                    // }
                    // field("Sales Cr. Memo Nos. (Exempt)"; "Sales Cr. Memo Nos. (Exempt)")
                    // {
                    // }
                    // field("Sales Inv. No. (Export)"; "Sales Inv. No. (Export)")
                    // {
                    // }
                    // field("Sales Cr. Memo No. (Export)"; "Sales Cr. Memo No. (Export)")
                    // {
                    // }
                    // field("Sales Inv. No. (Supp)"; "Sales Inv. No. (Supp)")
                    // {
                    // }
                    // field("Sales Cr. Memo No. (Supp)"; "Sales Cr. Memo No. (Supp)")
                    // {
                    // }
                    // field("Sales Inv. No. (Debit Note)"; "Sales Inv. No. (Debit Note)")
                    // {
                    // }
                    // field("Serv. Inv. Nos. (Exempt)"; "Serv. Inv. Nos. (Exempt)")
                    // {
                    // }
                    // field("Serv. Cr. Memo Nos. (Exempt)"; "Serv. Cr. Memo Nos. (Exempt)")
                    // {
                    // }
                    // field("Serv. Inv. Nos. (Export)"; "Serv. Inv. Nos. (Export)")
                    // {
                    // }
                    // field("Serv. Cr. Memo Nos. (Export)"; "Serv. Cr. Memo Nos. (Export)")
                    // {
                    // }
                    // field("Serv. Inv. Nos. (Supp)"; "Serv. Inv. Nos. (Supp)")
                    // {
                    // }
                    // field("Serv. Cr. Memo Nos. (Supp)"; "Serv. Cr. Memo Nos. (Supp)")
                    // {
                    // }
                    // field("Serv. Inv. Nos. (Debit Note)"; "Serv. Inv. Nos. (Debit Note)")
                    // {
                    // }
                    // field("Sales Inv. Nos. (Non-GST)"; "Sales Inv. Nos. (Non-GST)")
                    // {
                    // }
                    // field("Sales Cr. Memo Nos. (Non-GST)"; "Sales Cr. Memo Nos. (Non-GST)")
                    // {
                    // }
                    // field("Posted Serv. Trans. Shpt. Nos."; "Posted Serv. Trans. Shpt. Nos.")
                    // {
                    // }
                    // field("Posted Serv. Trans. Rcpt. Nos."; "Posted Serv. Trans. Rcpt. Nos.")
                    // {
                    // }
                    // field("Purch. Inv. Nos. (Unreg)"; "Purch. Inv. Nos. (Unreg)")
                    // {
                    // }
                    // field("Purch. Cr. Memo Nos. (Unreg)"; "Purch. Cr. Memo Nos. (Unreg)")
                    // {
                    // }
                    // field("Purch. Inv. Nos. (Unreg Supp)"; "Purch. Inv. Nos. (Unreg Supp)")
                    // {
                    // }
                    // field("Pur. Inv. Nos.(Unreg Deb.Note)"; "Pur. Inv. Nos.(Unreg Deb.Note)")
                    // {
                    // }
                    // field("GST Transfer Shipment No."; "GST Transfer Shipment No.")
                    // {
                    // }
                    // field("GST Liability Invoice"; "GST Liability Invoice")
                    // {
                    // }
                }
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        //KPPLDG00039
        IF Rec."Location Type" = Rec."Location Type"::"Pre-Booking" THEN
            Rec.TESTFIELD("Salable Location Code");
        //KPPLDG00039
    end;

    var
        myInt: Integer;
}