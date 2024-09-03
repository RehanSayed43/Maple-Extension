table 50004 "EInvoice Entry"
{
    DrillDownPageID = 50004;
    LookupPageID = 50004;

    fields
    {
        field(1; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Invoice,Credit Memo,Transfer,Transfer Cancel,Purch Cr Memo';
            OptionMembers = Invoice,"Credit Memo",Transfer,"Transfer Cancel","Purch Cr Memo";
        }
        field(2; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "QR Code"; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(4; IRN; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Signed Invoice"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Acknowledgment_number; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Acknowledgment Date"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Creation DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Cancel DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Cancel Reason"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Duplicate,Data Entry Mistake';
            OptionMembers = " ",Duplicate,"Data Entry Mistake";
        }
        field(11; "Cancel Remarks"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Ewb Status"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'Eway Fields Reuired Below';
        }
        field(13; EwbNo; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Eway Response';
        }
        field(14; EwbDt; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'Eway Response';
        }
        field(15; EwbValidTill; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'Eway Response';
        }
        field(16; "Transporter No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'EWaywthIRN OR incomplete Eway Data OF Eway';

            trigger OnValidate()
            begin
                TESTFIELD(EwbNo, '');
            end;
        }
        field(17; "Shipping Agent Code"; Code[10])
        {
            AccessByPermission = TableData 5790 = R;
            Caption = 'Shipping Agent Code';
            DataClassification = ToBeClassified;
            Description = 'EWaywthIRN OR incomplete Eway Data OF Eway';
            TableRelation = "Shipping Agent";

            trigger OnValidate()
            begin
                TESTFIELD(EwbNo, '');
            end;
        }
        field(18; "LR/RR No."; Code[20])
        {
            Caption = 'LR/RR No.';
            DataClassification = ToBeClassified;
            Description = 'EWaywthIRN OR incomplete Eway Data OF Eway';

            trigger OnValidate()
            begin
                TESTFIELD(EwbNo, '');
            end;
        }
        field(19; "LR/RR Date"; Date)
        {
            Caption = 'LR/RR Date';
            DataClassification = ToBeClassified;
            Description = 'EWaywthIRN OR incomplete Eway Data OF Eway';

            trigger OnValidate()
            begin
                TESTFIELD(EwbNo, '');
            end;
        }
        field(20; "Vehicle No."; Code[20])
        {
            Caption = 'Vehicle No.';
            DataClassification = ToBeClassified;
            Description = 'EWaywthIRN OR incomplete Eway Data OF Eway';

            trigger OnValidate()
            begin
                TESTFIELD(EwbNo, '');
            end;
        }
        field(21; "Mode of Transport"; Text[15])
        {
            Caption = 'Mode of Transport';
            DataClassification = ToBeClassified;
            Description = 'EWaywthIRN OR incomplete Eway Data OF Eway';

            trigger OnValidate()
            begin
                TESTFIELD(EwbNo, '');
            end;
        }
        field(22; "Distance (Km)"; Decimal)
        {
            Caption = 'Distance (Km)';
            DataClassification = ToBeClassified;
            Description = 'EWaywthIRN OR incomplete Eway Data OF Eway';

            trigger OnValidate()
            begin
                TESTFIELD(EwbNo, '');
            end;
        }
        field(23; "Vehicle Type"; Option)
        {
            Caption = 'Vehicle Type';
            DataClassification = ToBeClassified;
            Description = 'EWaywthIRN OR incomplete Eway Data OF Eway';
            OptionCaption = ' ,Regular,ODC';
            OptionMembers = " ",Regular,ODC;

            trigger OnValidate()
            begin
                TESTFIELD(EwbNo, '');
            end;
        }
        field(25; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            Description = 'EWaywthIRN OR incomplete Eway Data OF Eway';
            TableRelation = "Transport Method";

            trigger OnValidate()
            begin
                TESTFIELD(EwbNo, '');
            end;
        }
        field(26; "Eway Cancel Reason"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'Cancel Eway';
            OptionCaption = ' ,Duplicate,Data Entry Mistake';
            OptionMembers = " ",Duplicate,"Order Cancelled","Data Entry Mistake",Others;
        }
        field(27; "Eway Cancel Remarks"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'Cancel Eway';
        }
        field(28; "Eway Cancel Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "QR Code Part1"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'Einvoice 081220';
        }
        field(30; "QR Code Part2"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'Einvoice 081220';
        }
        field(31; "QR Code Part3"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'Einvoice 081220';
        }
        field(32; "QR Code Part4"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'Einvoice 081220';
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        //  PDCEntry: Record "PDC";
        ApplnBuffer1: Record "EInvoice Entry";
        AvlbForAppln: Decimal;
        Text001: Label 'Maximum Amount to apply is %1. Please check the entry.';
    //    PD: Record "PDC";
}

