table 50030 "Ingram Integration Setup"
{
    Caption = 'Ingram Integration Setup';

    fields
    {
        field(1; "Prmiary Key"; Code[10])
        {
            Caption = 'Prmiary Key';
            DataClassification = ToBeClassified;
        }
        field(2; "API Environment Activated"; Option)
        {
            Caption = 'API Environment Activated';
            DataClassification = ToBeClassified;
            OptionCaption = 'Sandbox,Production';
            OptionMembers = Sandbox,Production;
        }
        field(3; "IM-CustomerNumber"; Code[20])
        {
            Caption = 'IM-CustomerNumber';
            DataClassification = ToBeClassified;
        }
        field(4; "IM-CorrelationID"; Text[30])
        {
            Caption = 'IM-CorrelationID';
            DataClassification = ToBeClassified;
        }
        field(5; "IM-CountryCode"; Code[10])
        {
            Caption = 'IM-CountryCode';
            DataClassification = ToBeClassified;
        }
        field(6; "IM-SenderID"; Text[30])
        {
            Caption = 'IM-SenderID';
            DataClassification = ToBeClassified;
        }
        field(7; billToAddressId; Code[10])
        {
            Caption = 'billToAddressId';
            DataClassification = ToBeClassified;
        }
        field(8; shipToAddressId; Code[10])
        {
            Caption = 'shipToAddressId';
            DataClassification = ToBeClassified;
        }
        field(9; client_id; Text[50])
        {
            Caption = 'client_id';
            DataClassification = ToBeClassified;
            ExtendedDatatype = Masked;
        }
        field(10; client_secret; Text[50])
        {
            Caption = 'client_secret';
            DataClassification = ToBeClassified;
            ExtendedDatatype = Masked;
        }
        field(11; shipFromWarehouseId; Code[10])
        {
            Caption = 'shipFromWarehouseId';
            DataClassification = ToBeClassified;
        }
        field(12; shipmentDetailsCarrierCode; Code[10])
        {
            Caption = 'shipmentDetailsCarrierCode';
            DataClassification = ToBeClassified;
        }
        field(13; "Auth Token Url"; Text[500])
        {
            Caption = 'Auth. Token Url';
            DataClassification = ToBeClassified;
        }
        field(14; "Order API Url"; Text[500])
        {
            Caption = 'Order API Url';
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "Prmiary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

