page 50017 "Posted Retail Invoice Line"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    AutoSplitKey = true;
    Caption = 'Lines';
    Editable = false;
    LinksAllowed = false;
    PageType = List;
    SourceTable = "Sales Invoice Line";
    SourceTableView = SORTING("Warranty Exp. Dt")
                      ORDER(Descending)
                      WHERE("Sales Order Type" = CONST(Retail));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = all;
                    Caption = 'Customer No.';
                    StyleExpr = StyleTxt;
                    Visible = true;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    StyleExpr = StyleTxt;
                    Visible = true;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    StyleExpr = StyleTxt;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                    StyleExpr = StyleTxt;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Warranty Exp. Dt"; Rec."Warranty Exp. Dt")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleTxt;
                }
                field("AMC Due Date"; Rec."AMC Due Date")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleTxt;
                    Visible = false;
                }
                field("shield Due Date"; Rec."shield Due Date")
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
                        // ShowDimensions;
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //    ShowLineComments;
                    end;
                }
                action(ItemTrackingEntries)
                {
                    Caption = 'Item &Tracking Entries';
                    Image = ItemTrackingLedger;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //  ShowItemTrackingLines;
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
                            Rec.TESTFIELD(Type);
                        //  ShowItemShipmentLines;
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

    trigger OnAfterGetRecord()
    begin
        //    StyleTxt := SetStyle;
    end;

    trigger OnInit()
    begin
        //SETCURRENTKEY("Cust. Mobile No.");
    end;

    trigger OnOpenPage()
    begin
        //SETFILTER(OrderType,'%1',OrderType::Retail);
    end;

    var
        OrderType: Option Retail,Rental,B2B,AMC,Service;
        StyleTxt: Text;


    procedure ShowStrDetailsForm()
    var
        SalesInvHeader: Record 112;
    // StrOrderLineDetails: Record 13798;
    // StrOrderLineDetailsForm: Page 16309;
    begin
        /* StrOrderLineDetails.RESET;
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
        //  ShowStrOrderDetailsPIT;
    end;
}

