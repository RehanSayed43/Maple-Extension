table 50026 "Sales Order Extension"
{

    fields
    {
        field(1; "Document Type"; Option)
        {
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,Posted Shipment,Posted Invoice';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Posted Shipment","Posted Invoice";
        }
        field(2; "No."; Code[20])
        {
        }
        field(3; "Order No."; Code[20])
        {
        }
        field(50000; "Servify Approval Code"; Code[12])
        {
            Description = 'KPPLDG00008';

            trigger OnValidate()
            begin
                "Servify Transfer Amount" := 0;
                //UpdateCustomerTotal;
            end;
        }
        field(50001; "Servify Transfer Amount"; Decimal)
        {
            Description = 'KPPLDG00008';

            trigger OnValidate()
            begin
                TESTFIELD("Servify Approval Code");
                ServifyMethodCode := 'Servify';
                //ValidateServiceChargeAc('Servify');
            end;
        }
        field(50002; ServifyMethodCode; Code[10])
        {
            Description = 'KPPLDG00008';
        }
        field(50003; "Advance Payment Received"; Decimal)
        {
            Description = 'KPPLDG00010';
        }
        field(50004; "Paytm Approval Code"; Code[10])
        {
            Description = 'KPPLDG00033';
        }
        field(50005; "Paytm Transfer Amount"; Decimal)
        {
            Description = 'KPPLDG00033';
        }
        field(50006; PaytmMethodCode; Code[10])
        {
            Description = 'KPPLDG00033';
        }
        field(50008; ServifyBonusMethodCode; Code[10])
        {
            Description = 'TK';
        }
        field(50007; "Servify Bonus Amount"; Decimal)
        {
            Description = 'KPPLDG00008';

            trigger OnValidate()
            begin
                TESTFIELD("Servify Approval Code");
                ServifyMethodCode := 'Servify';

                //ValidateServiceChargeAc('Servify');
            end;
        }
    }

    keys
    {
        key(Key1; "Document Type", "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

