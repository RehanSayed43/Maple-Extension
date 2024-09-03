tableextension 50041 "Transfer Shipment Header Table" extends "Transfer Shipment Header"
{
    fields
    {
        field(50000; "Rental Sales Invoice No."; Code[20])
        {
        }
        field(50003; "Customer No."; Code[20])
        {
            TableRelation = Customer;
        }
        field(50004; "Rental Transfer"; Boolean)
        {
        }
        field(50005; "Transporter Name"; Text[50])
        {
        }
        field(50006; "LR/AWB No."; Text[30])
        {
        }
        field(50007; "LR/AWB Date"; Date)
        {
        }
        field(50009; "No of Boxes"; Text[30])
        {
        }
        field(50010; "ECom Order ID"; Code[20])
        {
            Editable = false;
        }
        field(50011; "Shipped By User ID"; Code[50])
        {
            Description = 'WIN316';
            Editable = false;
        }
        field(50012; "Received By User ID"; Code[50])
        {
            Description = 'WIN316';
            Editable = false;
        }
        field(50013; "Refreance No."; Code[20])
        {
            Description = 'KPPLDG00017';
        }
        field(50014; "WMS Process"; Boolean)
        {
            Description = 'KPPLDG00017';
        }
        field(50015; "Handover To Name"; Text[100])
        {
        }
        field(50200; "E-Invoice Cancel Remark"; Text[10])
        {
            DataClassification = ToBeClassified;
            Description = 'E-Invoice';
        }
        field(50201; "E-Invoice Reason Code"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'E-Invoice';
            OptionCaption = ' ,Duplicate,Order Cancelled,Data Entry Mistake,Other';
            OptionMembers = "0","1","2","3","4";

        }
        field(50202; "IRN No."; Text[64])
        {
            DataClassification = ToBeClassified;
            Description = 'E-Invoice';
            Editable = false;
        }
        field(50203; "MAcknowledgement No."; Text[20])
        {
            DataClassification = ToBeClassified;
            Description = 'E-Invoice';
            Editable = false;
        }
        field(50204; "MAcknowledgement Date"; Text[10])
        {
            DataClassification = ToBeClassified;
            Description = 'E-Invoice';
            Editable = false;
        }
        field(50205; "E-Invocie Cancel Date"; Text[10])
        {
            DataClassification = ToBeClassified;
            Description = 'E-Invoice';
        }
        field(50206; Distance; Decimal)
        {
            Description = 'Eway Bill';
        }
        field(50207; "ME-Way Bill No."; Code[20])
        {
            Description = 'Eway Bill';
        }
        field(50208; "E-Way Bill Date"; DateTime)
        {
            Description = 'Eway Bill';
        }
        field(50209; "Vehicle Types"; Option)
        {
            Description = 'Eway Bill';
            OptionCaption = ' ,Regular,ODC';
            OptionMembers = " ",R,O;
        }
        field(50210; "Cancel Reason Code"; Option)
        {
            Description = 'Eway Bill';
            OptionCaption = ' ,Duplicate,Order Cancelled,Data Entry Mistake,Other';
            OptionMembers = "0","1","2","3","4";
        }
        field(50211; "Cancel Remark"; Text[20])
        {
            Description = 'Eway Bill';
        }
        field(50212; "MQR Code"; Blob)
        {
            Subtype = Bitmap;
            Caption = 'QR Code';
            DataClassification = CustomerContent;
        }
        field(50213; "Envoice Cancelled"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50214; "EWay Bill Cnacelled"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

    }
}
