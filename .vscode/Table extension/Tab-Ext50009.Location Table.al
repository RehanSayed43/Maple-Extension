tableextension 50009 "Location Table" extends Location
{
    fields
    {
        field(50000; "Location Type"; Option)
        {
            Description = 'win127,KPPLDG00039-> Added new option "Pre-Booking"';
            OptionCaption = ' ,Saleable,Intransit,Rental,Buyback,Demo,Damage,Ecommerce,Shortage,Pre-Booking';
            OptionMembers = " ",Saleable,Intransit,Rental,Buyback,Demo,Damage,Ecommerce,Shortage,"Pre-Booking";

            trigger OnValidate()
            begin
                IF "Location Type" = "Location Type"::Intransit THEN
                    "Use As In-Transit" := TRUE
                ELSE
                    "Use As In-Transit" := FALSE;

                "Salable Location Code" := '';//KPPLDG00039
            end;
        }
        field(50001; "LBT No."; Code[20])
        {
        }
        field(50002; "Shield Invoice Nos."; Code[10])
        {
            Caption = 'Shield Invoice Nos.';
            Description = 'win127';
            TableRelation = "No. Series";
        }
        field(50003; "Posted Shield Invoice Nos."; Code[10])
        {
            Caption = 'Shield Invoice Nos.';
            Description = 'win127';
            TableRelation = "No. Series";
        }
        field(50004; "Rental From Location"; Code[10])
        {
            TableRelation = Location;
        }
        field(50005; "Purchase Order Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50006; "Bank Account"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(50011; Header; BLOB)
        {
            SubType = Bitmap;
        }
        field(50012; Footer; BLOB)
        {
            SubType = Bitmap;
        }
        field(50013; "Capillary ID"; Text[30])
        {
            Description = 'WIN316';
        }
        field(50014; "Capillary Password"; Text[50])
        {
            Description = 'WIN316';
        }
        field(50015; "E Com Location Code"; Code[20])
        {
            Description = 'E com';
            TableRelation = Location.Code;
        }
        field(50016; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50017; "POS Apple ID"; Integer)
        {

            trigger OnValidate()
            begin
                IF STRLEN(FORMAT("POS Apple ID")) > 10 THEN
                    ERROR('ID can not be more than 10 digit');//WIN234 27-04-2020
            end;
        }
        field(50018; "E-Invoice User ID"; Text[30])
        {
        }
        field(50019; "E-Invoice Password"; Text[30])
        {
        }
        field(50021; "Voucher Client ID"; Text[50])
        {
            Description = 'WIN234 voucher integration';
        }
        field(50022; "Voucher Secret Code"; Text[50])
        {
            Description = 'WIN234 voucher integration';
        }
        field(50023; "Salable Location Code"; Code[10])
        {
            Description = 'KPPLDG00039';
            TableRelation = Location WHERE("Location Type" = FILTER(Saleable));

            trigger OnValidate()
            var
                LocLocation: Record "Location";
            begin
                //KPPLDG00039
                IF "Salable Location Code" <> '' THEN BEGIN
                    LocLocation.RESET;
                    LocLocation.GET("Salable Location Code");
                    LocLocation.TESTFIELD(LocLocation."Location Type", LocLocation."Location Type"::Saleable);
                END;
            end;
        }
        field(50024; "Einvoice E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
            Description = 'KPPLE_Inv';
            ExtendedDatatype = EMail;
        }
        field(50027; "Ingram Location"; Boolean)
        {
            Caption = 'Ingram Location';
            Description = 'KPPL-INGRAM';
        }
    }
}
