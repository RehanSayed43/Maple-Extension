page 50110 "Bulk Expense Booking"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = all;
    SourceTable = "Bulk Expense booking";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = all;
                }
                field(VendorName; Rec.VendorName)
                {
                    ApplicationArea = all;
                }
                field("Vendor Invoice No"; Rec."Vendor Invoice No")
                {
                    ApplicationArea = all;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field(Structure; Rec."GST Credit")//tk
                {
                    ApplicationArea = all;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = all;
                }
                field("Vendor Part Code"; Rec."Vendor Part Code")
                {
                    ApplicationArea = all;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field("Unit Price With Tax"; Rec."Unit Price With Tax")
                {
                    ApplicationArea = all;
                    Caption = 'Unit Price W/O Tax';
                }
                field("GST Group Code"; Rec."GST Group Code")
                {
                    ApplicationArea = all;
                }
                field("GST Group Type"; Rec."GST Group Type")
                {
                    ApplicationArea = all;
                }
                field("HSN/SAC Code"; Rec."HSN/SAC Code")
                {
                    ApplicationArea = all;
                }

                field(Comments; Rec.Comments)
                {
                    ApplicationArea = all;
                }
                field("Invoice  Created"; Rec."Invoice  Created")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                }
                field("Apply to Document Type"; Rec."Apply to Document Type")
                {
                    ApplicationArea = all;
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                    ApplicationArea = all;
                }
                field("Line No"; Rec."Line No")
                {
                    ApplicationArea = all;
                }
                field("TDS Nature of Deduction"; Rec."TDS Nature of Deduction")
                {
                    ApplicationArea = all;
                }
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = all;
                }
                field(Expense; Rec.Expense)
                {
                    ApplicationArea = all;
                }
                field("Vendor Invoice Value"; Rec."Vendor Invoice Value")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(option)
            {
                Caption = 'option';
                action("Upload Invoice Data")
                {
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                    // RecXml: XMLport "Bulk Expense Upload";//tk
                    begin
                        RecBulk.RESET;
                        RecBulk.DELETEALL;


                        XMLPORT.RUN(50021, FALSE, TRUE, Rec);
                    end;
                }
                action("Create Purchase Invoice")
                {
                    Image = CreateDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    RunObject = Codeunit 50021;
                }
            }
        }
    }

    var
        RecBulk: Record "Bulk Expense booking";
}

