pageextension 50013 "General Ledger Setup" extends "General Ledger Setup"
{

    layout
    {
        modify("Allow G/L Acc. Deletion Before")
        {
            Visible = false;
        }
        addbefore(AmountDecimalPlaces)
        {
            field("Vendor Cash Limit"; Rec."Vendor Cash Limit")
            {
                ApplicationArea = all;
            }
            field(gspappid; Rec.gspappid)
            {
                ApplicationArea = all;
            }
            field(gspappsecret; Rec.gspappsecret)
            {
                ApplicationArea = all;
            }
            field("Amount Rounding Precision"; Rec."Amount Rounding Precision")
            {
                ApplicationArea = all;
            }

            field("Unit-Amount Rounding Precision"; Rec."Unit-Amount Rounding Precision")
            {
                ApplicationArea = all;
            }
            field("Purchase Invoice IIIrd Party"; Rec."Purchase Invoice IIIrd Party")
            {
                ApplicationArea = all;
            }
            field("Sales Invoice IIIrd Party"; Rec."Sales Invoice IIIrd Party")
            {
                ApplicationArea = all;
            }
            field("Denomination Nos"; Rec."Denomination Nos")
            {
                ApplicationArea = all;
            }
            field("Daily Currency Nos"; Rec."Daily Currency Nos")
            {
                ApplicationArea = all;
            }
            field("Cash Account"; Rec."Cash Account")
            {
                ApplicationArea = all;
            }
        }
        addafter(AmountDecimalPlaces)
        {
            field("BB Cash Account"; Rec."BB Cash Account")
            {
                ApplicationArea = all;
                Visible = true;
            }

        }
        addafter(General)
        {

            Group("Invoice Terms")
            {
                Caption = 'Invoice Terms';
                field("InvoiceTerm1"; Rec."Invoice Terms 1")
                {
                    ApplicationArea = all;


                }
                field("InvoiceTerms2"; Rec."Invoice Terms 2")
                {
                    ApplicationArea = all;





                }
                field("InvoiceTerms3"; Rec."Invoice Terms 3")
                {
                    ApplicationArea = all;

                }
                field("Invoice Terms. 4"; Rec."Invoice Terms 4")
                {
                    ApplicationArea = all;
                    Visible = true;
                }
                field("Invoice Terms. 5"; Rec."Invoice Terms 5")
                {
                    ApplicationArea = all;
                    Visible = true;
                }
                field("Invoice Terms 6"; Rec."Invoice Terms 6")
                {
                    ApplicationArea = all;
                    Visible = true;
                }
            }
        }


        addafter("Payroll Trans. Import Format")
        {
            group("Maple File No.")
            {
                Caption = 'Maple File No.';
                field("Mapple File Date"; Rec."Mapple File Date")

                {
                    ApplicationArea = all;
                }
                field("ISL File No."; Rec."ISL File No.")
                {
                    ApplicationArea = all;
                }
                field("OSL File No."; Rec."OSL File No.")
                {
                    ApplicationArea = all;
                }

                field("RET File No."; Rec."RET File No.")
                {
                    ApplicationArea = all;
                }
            }
        }
        addafter("Bank Account Nos.")
        {
            field("Cust PDC Batch No."; Rec."Cust PDC Batch No.")
            {
                ApplicationArea = all;
            }
            field("Vend PDC Batch No."; Rec."Vend PDC Batch No.")
            {
                ApplicationArea = all;
            }
        }

    }

    actions
    {
        addafter("Bank Account Posting Groups")
        {
            action("Update GL Entry")
            {
                //AccessByPermission = tabledata "G/L Entry" = rmdi;
                ApplicationArea = all;
                Image = UpdateDescription;
                trigger OnAction()
                var
                    CC: Codeunit 50057;
                BEGIN
                    CC.UpdateGLEntry();
                END;

            }
        }
    }

    var
        myInt: Integer;
}