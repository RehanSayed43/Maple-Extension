page 50204 "Buy Back Ledger"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Buy Back Ledger";
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    Caption = 'Trade';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field("Sr. no."; Rec."Sr. no.")
                {
                    ToolTip = 'Specifies the value of the Sr. no. field.';
                    ApplicationArea = all;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                    ApplicationArea = all;
                }
                field("Cr. no."; Rec."Cr. no.")
                {
                    ToolTip = 'Specifies the value of the Cr. no. field.';
                    ApplicationArea = all;
                }
                field("Customer Sub Type"; Rec."Customer Sub Type")
                {
                    ToolTip = 'Specifies the value of the Customer Sub-Type field.';
                    ApplicationArea = all;
                }
                field("Invoice no."; Rec."Invoice no.")
                {
                    ToolTip = 'Specifies the value of the Invoice no. field.';
                    ApplicationArea = all;
                }
                field("Trade-in Device model no."; Rec."Trade-in Device model no.")
                {
                    ToolTip = 'Specifies the value of the Trade-in Device model no. field.';
                    ApplicationArea = all;
                }
                field("Trade-in device IMEI no."; Rec."Trade-in device IMEI no.")
                {
                    ToolTip = 'Specifies the value of the Trade-in device IMEI no. field.';
                    ApplicationArea = all;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Servify Approval Code"; Rec."Servify Approval Code")
                {
                    ToolTip = 'Specifies the value of the Servify Approval Code field.';
                    ApplicationArea = all;
                }
                field("Transfer Amount"; Rec."Transfer Amount")
                {
                    ToolTip = 'Specifies the value of the Transfer Amount field.';
                    ApplicationArea = all;
                }
                field("Normal Buyback Amt"; Rec."Normal Buyback Amt")
                {
                    ToolTip = 'Specifies the value of the Normal Buyback Amt field.';
                    ApplicationArea = all;
                }

                field("Sweetner Amount"; Rec."Sweetner Amount")
                {
                    ToolTip = 'Specifies the value of the Sweetner Amount field.';
                    ApplicationArea = all;
                }
                field("EasyOzy Purchase Amount"; Rec."Servify Purchase Amount")
                {
                    ToolTip = 'Specifies the value of the EasyOzy Purchase Amount field.';
                    ApplicationArea = all;
                }
                field("EasyOzy Bonus Amount"; Rec."EasyOzy Bonus Amount")
                {
                    ToolTip = 'Specifies the value of the EasyOzy Bonus Amount field.';
                    ApplicationArea = all;
                }
                field("Maple Contribution"; Rec."Maple Contribution")
                {
                    ToolTip = 'Specifies the value of the Maple Contribution field.';
                    ApplicationArea = all;
                }
                field("Apple Contribution"; Rec."Apple Contribution")
                {
                    ToolTip = 'Specifies the value of the Apple Contribution field.';
                    ApplicationArea = all;
                }
                field("Total BB Value"; Rec."Total BB Value")
                {
                    ToolTip = 'Specifies the value of the Total BB Value field.';
                    ApplicationArea = all;
                }
                field("Device Retailer Amount"; Rec."Device Retailer Amount")
                {
                    ToolTip = 'Specifies the value of the Device Retailer Amount field.', Comment = '%';
                }
                field("Bonus Amount"; Rec."Bonus Amount")
                {
                    ToolTip = 'Specifies the value of the Bonus Amount field.', Comment = '%';
                }
                field("Vendor Amount"; Rec."Vendor Amount")
                {
                    ToolTip = 'Specifies the value of the Vendor Amount field.';
                    ApplicationArea = all;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ToolTip = 'Specifies the value of the Vendor Name field.';
                    ApplicationArea = all;
                }
                field("Sold out Date"; Rec."Sold out Date")
                {
                    ToolTip = 'Specifies the value of the Sold out Date field.';
                    ApplicationArea = all;
                }
                field(Soldout; Rec.Soldout)
                {
                    ToolTip = 'Specifies the value of the Soldout field.';
                    ApplicationArea = all;
                }
                field(Remark; Rec.Remark)
                {
                    ToolTip = 'Specifies the value of the Remark field.';
                    ApplicationArea = all;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {

        }
    }
}