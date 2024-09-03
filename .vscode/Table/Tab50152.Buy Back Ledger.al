table 50152 "Buy Back Ledger"
{
    DataClassification = ToBeClassified;
    Caption = 'Trade';

    fields
    {
        field(1; "Sr. no."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Cr. no."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Customer Sub Type"; Enum "Customer SubType")
        {
            dataclassification = tobeclassified;

        }
        field(5; "Invoice no."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Trade-in Device model no."; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Trade-in device IMEI no."; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Transfer Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Sweetner Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Maple Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Apple Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Total BB Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Vendor Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Vendor Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Sold out Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(16; Soldout; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(17; Remark; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Servify Approval Code"; Code[12])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Normal Buyback Amt"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Servify Purchase Amount"; Decimal)
        {
            Caption = 'EasyOzy Purchase Amount';
            DataClassification = ToBeClassified;
        }
        field(21; "EasyOzy Bonus Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Location Code"; code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Device Retailer Amount"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Bonus Amount"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Sr. no.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}