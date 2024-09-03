pageextension 50041 "PostedSales Invoice" extends "Posted Sales Invoice"
{
    Editable = true;


    layout
    {
        addafter("Shipping and Billing")
        {
            group("Servify Details")
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Mobile Number"; Rec."Mobile Number")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Email ID"; Rec."Email ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Name Of Firm"; Rec."Name Of Firm")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Service Location Name"; Rec."Service Location Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Servify Currency Code"; Rec."Servify Currency Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Logistics Reference ID"; Rec."Logistics Reference ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Trade In Status"; Rec."Trade In Status")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Model Storage"; Rec."Model Storage")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Product Unique ID"; Rec."Product Unique ID")
                {
                    Caption = 'Product Unique ID old';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Product Unique ID New"; Rec."Product Unique ID New")
                {
                    ToolTip = 'Specifies the value of the Product Unique ID New field.', Comment = '%';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Model Name"; Rec."Model Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Model Grade"; Rec."Model Grade")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Model Brand"; Rec."Model Brand")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Device Customer Amount"; Rec."Device Customer Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Device Retailer Amount"; Rec."Device Retailer Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bonus Amount"; Rec."Bonus Amount")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Bonus Amount field.', Comment = '%';
                    ApplicationArea = All;
                }
            }

        }
        addafter("No.")
        {
            field("Order ID"; Rec."Order ID")
            {
                ApplicationArea = All;
            }
            field("LocationCode"; Rec."Location Code")
            {
                ApplicationArea = all;
            }
            field("Sales Order Type"; Rec."Sales Order Type")
            {
                ApplicationArea = all;
            }
            field("User Type"; Rec."Mobile Type")
            {
                Caption = 'User Type';
                ApplicationArea = all;

            }
            field(SystemCreatedAt; Rec.SystemCreatedAt)
            {
                Caption = 'Posting Date & Time';
                ApplicationArea = all;

                //DataClassification = ToBeClassified;
            }
            field(SystemCreatedBy; Rec."User ID")
            {
                Caption = 'User Id';
                ApplicationArea = all;
            }

        }
        addafter("Posting Date")
        {

            field("Cust. email ID"; Rec."Cust. email ID")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Cust. email ID field.';
            }
            field("Cust. Mobile No."; Rec."Cust. Mobile No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Cust. Mobile No. field.';
            }
        }



        addafter("GST Customer Type")
        {
            field("Customer GST Reg. No."; Rec."Customer GST Reg. No.")
            {
                ApplicationArea = all;
            }
        }
        addafter("E-Way Bill No.")
        {
            field("IRN No."; Rec."IRN No.")
            {
                ApplicationArea = all;
            }
            field("E-Way Bill Date"; Rec."E-Way Bill Date")
            {
                ApplicationArea = all;
            }
            field("E-Way Bill Date ValidTill"; Rec."E-Way Bill Date ValidTill")
            {
                ApplicationArea = all;
            }
        }
        addafter("E-Inv. Cancelled Date")
        {
            field("e-Inv Cancelled"; Rec."E-Inv Cancelled")
            {
                ApplicationArea = all;
            }
            field("E-Invoice Reason Code"; Rec."E-Invoice Reason Code")
            {
                ApplicationArea = all;
            }
            field("E-Invoice Cancel Remark"; Rec."E-Invoice Cancel Remark")
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
                ApplicationArea = all;
            }
            field("Promo Code"; Rec."Promo Code")
            {
                Editable = false;
                ApplicationArea = all;
            }
            field("Delivery Note"; Rec."Delivery Note")
            {
                Editable = true;
                ApplicationArea = all;
            }
            field("Dispatch Doc. No."; Rec."Dispatch Doc. No.")
            {
                Editable = true;
                ApplicationArea = all;
            }
            field("Dispatch Through"; Rec."Dispatch Through")
            {
                Editable = true;
                ApplicationArea = all;

            }

        }
        //CCIT AN 12092023++
        modify("Nature of Supply")
        {
            Editable = true;
            ApplicationArea = all;
        }
        modify("GST Bill-to State Code")
        {
            Editable = true;
            ApplicationArea = all;
        }
        modify("GST Customer Type")
        {
            Editable = true;
            ApplicationArea = all;
        }

        //CCIT AN --
        modify("Vehicle No.")
        {
            Editable = true;
            Visible = true;

        }
        modify("Mode of Transport")
        {
            Editable = true;
            Visible = true;
        }
        //addafter()
    }


    actions
    {
        modify("Generate IRN")
        {
            Visible = false;
            Enabled = false;
        }
        modify("Generate QR Code")
        {
            Visible = false;
            Enabled = false;
        }
        modify("Generate E-Invoice")
        {
            Visible = false;
            Enabled = false;
        }
        // Add changes to page actions here
        addafter("Generate IRN")
        {
            action("Print Shipping Label")
            {
                Promoted = true;
                Image = Shipment;
                ApplicationArea = all;
                trigger OnAction()
                BEGIN
                    Hyperlink(Rec."Shipping Label");
                END;
            }
            action(TEST)
            {
                ApplicationArea = ALL;
                Promoted = true;
                Visible = false;
                trigger OnAction()
                var
                    CC: Codeunit 50057;
                BEGIN
                    CC.ClockmeAPI(Rec);
                END;
            }
            action("GenerateEInvoice_ASP")
            {
                ApplicationArea = all;
                trigger OnAction()
                var
                    Einvoice: Codeunit "E-Invoice";
                begin
                    Einvoice.EInvoicingGeneration(Rec);
                end;
            }
            action("Cancel E-Invoice IRN")
            {
                ApplicationArea = all;
                trigger OnAction()
                var
                    Einvoice: Codeunit "E-Invoice";
                begin
                    Einvoice.CancelEInvTaxPro(Rec);

                end;
            }
            action("E-Way Bill Generation")
            {
                ApplicationArea = all;
                trigger OnAction()
                var
                    Einvoice: Codeunit "E-Invoice";
                begin
                    Einvoice."E-WayBillByIRN"(Rec);

                end;
            }
            action("Cancel E-Way Bill")
            {
                ApplicationArea = all;
                trigger OnAction()
                var
                    Einvoice: Codeunit "E-Invoice";
                begin
                    Einvoice.CancelEwayBill(Rec);

                end;
            }
            // action("GenerateEInvoice_ASP")
            // {
            //     ApplicationArea = all;
            //     trigger OnAction()
            //     var
            //         myInt: Integer;
            //     // eInvoice_ASP: Codeunit 50025;
            //     begin
            //         // eInvoice_ASP.SetEwayRequirement(FALSE);

            //         // eInvoice_ASP.SetSalesInvHeader(Rec);
            //         // eInvoice_ASP.RUN;
            //     end;
            // }
            // action("GetEinvoice")
            // {
            //     ApplicationArea = all;
            //     trigger OnAction()
            //     var
            //         myInt: Integer;
            //         // eInvoice_ASP: Codeunit 50025;
            //         RecLoc: Record Location;
            //     begin
            //         //    RecLoc.GET(Rec."Location Code");
            //         // eInvoice_ASP.GetEInvoice(DocType::Invoice,rec."No.",RecLoc."GST Registration No.");
            //     end;
            // }



        }
        addafter(Print)
        {
            action("Print GST- Sales Invoice")
            {
                Caption = 'Print GST-Sales Invoice Retail';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;
                Visible = true;

                trigger OnAction()
                begin
                    SalesInvHeader.RESET;
                    SalesInvHeader.SETRANGE("No.", Rec."No.");
                    SalesInvHeader.SETRANGE(Shield, TRUE);
                    SalesInvHeader.SETFILTER("Ref. Invoice No.", '<>%1', '');
                    IF SalesInvHeader.FINDFIRST THEN
                        ERROR('You cannot use this report for shield transaction');//WIN-234 06-03-2020
                    SalesInvHeader.RESET;
                    SalesInvHeader.SETRANGE("No.", Rec."No.");
                    REPORT.RUNMODAL(50009, TRUE, TRUE, SalesInvHeader);
                end;
            }
            action("Print GST- Sales Invoice Domestic")
            {
                Caption = 'Print GST-Sales Invoice Ecom';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;
                Visible = true;

                trigger OnAction()
                begin
                    SalesInvHeader.RESET;
                    SalesInvHeader.SETRANGE("No.", Rec."No.");
                    SalesInvHeader.SETRANGE(Shield, TRUE);
                    SalesInvHeader.SETFILTER("Ref. Invoice No.", '<>%1', '');
                    IF SalesInvHeader.FINDFIRST THEN
                        ERROR('You cannot use this report for shield transaction');//WIN-234 06-03-2020
                    SalesInvHeader.RESET;
                    SalesInvHeader.SETRANGE("No.", Rec."No.");
                    REPORT.RUNMODAL(50007, TRUE, TRUE, SalesInvHeader);
                end;
            }
            action("GSTB2BSalesInvoiceFinal11")
            {
                //ApplicationArea = Basic, Suite;
                Caption = 'Print GST-B2B Sales Invoice';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;
                //RunObject = Report 50018;

                ToolTip = 'View your company''s assets, liabilities, and equity.';

                trigger OnAction()
                BEGIN
                    SalesInvHeader.RESET;
                    SalesInvHeader.SETRANGE("No.", Rec."No.");
                    REPORT.RUNMODAL(50018, TRUE, TRUE, SalesInvHeader);
                END;

            }


        }


    }



    var
        myInt: Integer;
        DocType: Option Invoice,"or Credit Memo";
        UserSetup: Record 91;
}