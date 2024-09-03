pageextension 50087 "Posted Transfer Shipment" extends "Posted Transfer Shipment"
{
    layout
    {
        modify("Shipping Agent Code")
        {
            Editable = true;
        }
        addafter("Transfer Order Date")
        {
            field("Rental Sales Invoice No."; Rec."Rental Sales Invoice No.")
            {
                Editable = false;
                Style = Standard;
                StyleExpr = TRUE;
                ApplicationArea = all;
            }
            field("Customer No."; Rec."Customer No.")
            {
                Editable = false;
                ApplicationArea = all;
            }
            field("Shipped By User ID"; Rec."Shipped By User ID")
            {
                ApplicationArea = all;
            }
            field("Received By User ID"; Rec."Received By User ID")
            {
                ApplicationArea = all;
            }
        }
        addbefore("Foreign Trade")
        {
            group("E-Invoicing")
            {
                field("IRN No."; Rec."IRN No.")
                {
                    ApplicationArea = all;
                }
                field("MAcknowledgement No."; Rec."MAcknowledgement No.")
                {
                    Caption = 'Acknowledgement No.';
                    ApplicationArea = all;
                    Visible = false;
                }

                field("MAcknowledgement Date"; Rec."MAcknowledgement Date")
                {
                    Caption = 'Acknowledgement Date';
                    ApplicationArea = all;
                    Visible = false;
                }
                field("E-Invoice Cancel Remark"; Rec."E-Invoice Cancel Remark")
                {
                    ApplicationArea = all;
                }
                field("E-Invoice Reason Code"; Rec."E-Invoice Reason Code")
                {
                    ApplicationArea = all;
                }
                field("E-Invocie Cancel Date"; Rec."E-Invocie Cancel Date")
                {
                    ApplicationArea = all;
                }
                field("MQR Code"; Rec."MQR Code")
                {
                    Caption = 'QR Code';
                    ApplicationArea = All;
                }
                field("Envoice Cancelled"; Rec."Envoice Cancelled")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
            }
            group("Eway Bill")
            {
                field(Distance; Rec.Distance)
                {
                    ApplicationArea = all;
                }
                field("ME-Way Bill No."; Rec."ME-Way Bill No.")
                {
                    Caption = 'E-Way Bill No.';
                    ApplicationArea = all;
                }
                field("E-Way Bill Date"; Rec."E-Way Bill Date")
                {
                    ApplicationArea = all;
                }

                field("Cancel Reason Code"; Rec."Cancel Reason Code")
                {
                    ApplicationArea = all;
                }
                field("Cancel Remark"; Rec."Cancel Remark")
                {
                    ApplicationArea = all;
                }
            }

        }
        addafter("Transport Method")
        {
            field("Posting Date2"; Rec."Posting Date")
            {
                Caption = 'Date of Removal';
                ApplicationArea = all;
            }
            field("<Vehicle No11.>"; Rec."Vehicle No.")
            {
                Caption = 'Vehicle No.1';
                ApplicationArea = all;
            }
            field("<LR/RR No1.>"; Rec."LR/RR No.")
            {
                Caption = 'LR/RR No.1';
                ApplicationArea = all;
            }
            field("<LR/RR Date1>"; Rec."LR/RR Date")
            {
                Caption = 'LR/RR Date1';
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        addafter("&Print")
        {
            action("Generate E-Invoice IRN")
            {
                ApplicationArea = all;
                trigger OnAction()
                var
                    Einvoice: Codeunit "E-Invoice";
                begin
                    Einvoice.EInvoicingGenerationTransfer(Rec);
                end;
            }
            action("Cancel E-Invoice IRN")
            {
                ApplicationArea = all;
                trigger OnAction()
                var
                    Einvoice: Codeunit "E-Invoice";
                begin
                    Einvoice.CancelEInvTaxProTra(Rec);

                end;
            }
            action("E-Way Bill Generation")
            {
                ApplicationArea = all;
                Visible = false;
                trigger OnAction()
                var
                    Einvoice: Codeunit "E-Invoice";
                begin
                    Einvoice."E-WayBillByIRNTransfer"(Rec);


                end;
            }
            action("Cancel E-Way Bill")
            {
                ApplicationArea = all;
                Visible = false;
                trigger OnAction()
                var
                    Einvoice: Codeunit "E-Invoice";
                begin
                    Einvoice.CancelEwayBillTRansfer(Rec);


                end;
            }

            //   action("Print E-Way Bill")
            //     {
            //         Image = Print;
            //         Promoted = true;

            //         trigger OnAction()
            //         begin

            //             TESTFIELD("E-Way Bill No.");
            //             IF RecGeneLedSetup.GET THEN;
            //             IF RecLoc.GET("Transfer-from Code")THEN;
            //             "CUE-WayBill".PrintEwayBillSales("E-Way Bill No.",RecLoc."GST Registration No.",RecLoc."E-Invoice User ID",RecLoc."E-Invoice Password");
            //             MESSAGE('E-Way Bill Printed Sucessfully in %1 ',RecGeneLedSetup."E-Way Document Store Path");
            //         end;
            //     }

        }

    }

    var
        myInt: Integer;
}