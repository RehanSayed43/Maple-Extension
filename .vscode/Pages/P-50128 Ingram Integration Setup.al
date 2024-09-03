page 50128 "Ingram Integration Setup"
{
    Caption = 'Ingram Integration Setup';
    // DeleteAllowed = false;
    // InsertAllowed = false;
    Editable = true;
    PageType = Card;
    SourceTable = "Ingram Integration Setup";
    UsageCategory = Administration;
    ApplicationArea = all;


    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("API Environment Activated"; rec."API Environment Activated")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the API Environment Activated field.';
                }
                field(client_id; rec.client_id)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the client_id field.';
                }
                field(client_secret; rec.client_secret)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the client_secret field.';
                }
                field("IM-CustomerNumber"; rec."IM-CustomerNumber")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the IM-CustomerNumber field.';
                }
                field("IM-CorrelationID"; rec."IM-CorrelationID")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the IM-CorrelationID field.';
                }
                field("IM-CountryCode"; rec."IM-CountryCode")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the IM-CountryCode field.';
                }
                field("IM-SenderID"; rec."IM-SenderID")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the IM-SenderID field.';
                }
                field(billToAddressId; rec.billToAddressId)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the billToAddressId field.';
                }
                field(shipToAddressId; rec.shipToAddressId)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the shipToAddressId field.';
                }
                field(shipFromWarehouseId; rec.shipFromWarehouseId)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the shipFromWarehouseId field.';
                }
                field(shipmentDetailsCarrierCode; rec.shipmentDetailsCarrierCode)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the shipmentDetailsCarrierCode field.';
                }
                field("Auth Token Url"; Rec."Auth Token Url")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Auth. Token Url field.';
                }
                field("Order API Url"; Rec."Order API Url")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Order API Url field.';
                }
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        // RESET;
        // IF NOT GET THEN BEGIN
        //     INIT;
        //     INSERT;
        // END;
    end;
}

