page 50041 "Posted R Sales Invoice Subform"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    AutoSplitKey = true;
    Caption = 'Lines';
    Editable = false;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "Sales Invoice Line";

    layout
    {
        area(content)
        {
            repeater(Groups)
            {
                field(Type; rec.Type)
                {
                    ApplicationArea = all;
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                }
                // field("Cross-Reference No."; rec."Cross-Reference No.")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                // }//tk
                field("IC Partner Code"; rec."IC Partner Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Variant Code"; rec."Variant Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Return Reason Code"; rec."Return Reason Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = all;
                    BlankZero = true;
                }
                field("Unit of Measure Code"; rec."Unit of Measure Code")
                {
                    ApplicationArea = all;
                }
                field("Unit of Measure"; rec."Unit of Measure")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Unit Cost (LCY)"; rec."Unit Cost (LCY)")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Unit Price"; rec."Unit Price")
                {
                    ApplicationArea = all;
                    BlankZero = true;
                }
                field("Line Amount"; rec."Line Amount")
                {
                    ApplicationArea = all;
                    BlankZero = true;
                }
                field("Line Discount %"; rec."Line Discount %")
                {
                    ApplicationArea = all;

                    BlankZero = true;
                }
                field("Line Discount Amount"; rec."Line Discount Amount")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Allow Invoice Disc."; rec."Allow Invoice Disc.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Shield Cost"; rec."Shield Cost")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Shield Type"; rec."Shield Type")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Job No."; rec."Job No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Appl.-to Item Entry"; rec."Appl.-to Item Entry")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Primary category"; rec."Primary category")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Secondary category"; rec."Secondary category")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Third category"; rec."Third category")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("GST Jurisdiction Type"; rec."GST Jurisdiction Type")
                {
                    ApplicationArea = all;
                }
                field("HSN/SAC Code"; rec."HSN/SAC Code")
                {
                    ApplicationArea = all;
                }
                field("GST Group Type"; rec."GST Group Type")
                {
                    ApplicationArea = all;
                }
                // field("GST Base Amount";rec. "GST Base Amount")
                // {
                // }
                // field("GST %";rec. "GST %")
                // {
                // }
                //  field("Total GST Amount";rec. "Total GST Amount")
                // {
                // }
                field("GST Group Code"; rec."GST Group Code")
                {
                    ApplicationArea = all;
                }
                field("GST Place of Supply"; rec."GST Place of Supply")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //      ShowDimensions;
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //      ShowLineComments;
                    end;
                }
                action(ItemTrackingEntries)
                {
                    Caption = 'Item &Tracking Entries';
                    Image = ItemTrackingLedger;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //    ShowItemTrackingLines;
                    end;
                }
                action("Item Shipment &Lines")
                {
                    Caption = 'Item Shipment &Lines';
                    Image = ShipmentLines;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF NOT (Rec.Type IN [Rec.Type::Item, Rec.Type::"Charge (Item)"]) THEN
                            rec.TESTFIELD(Type);
                        //   ShowItemShipmentLines;
                    end;
                }
                action("Str&ucture Details")
                {
                    Caption = 'Str&ucture Details';
                    Image = Hierarchy;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        // This functionality was copied from page #132. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesInvLines.PAGE.*/
                        ShowStrDetailsForm;

                    end;
                }
            }
        }
    }


    procedure ShowStrDetailsForm()
    var
        SalesInvHeader: Record 112;
    // StrOrderLineDetails: Record 13798;
    // StrOrderLineDetailsForm: Page 16309;
    begin
        /*
        StrOrderLineDetails.RESET;
        SalesInvHeader.GET("Document No.");
        StrOrderLineDetails.SETCURRENTKEY("Invoice No.", Type, "Item No.");
        StrOrderLineDetails.SETRANGE("Invoice No.", SalesInvHeader."No.");
        StrOrderLineDetails.SETRANGE(Type, StrOrderLineDetails.Type::Sale);
        StrOrderLineDetails.SETRANGE("Item No.", "No.");
        StrOrderLineDetails.SETRANGE("Line No.", "Line No.");
        StrOrderLineDetailsForm.SETTABLEVIEW(StrOrderLineDetails);
        StrOrderLineDetailsForm.RUNMODAL;
        */
    end;


    procedure ShowStrOrderDetailsPITForm()
    begin
        // ShowStrOrderDetailsPIT;
    end;
}

