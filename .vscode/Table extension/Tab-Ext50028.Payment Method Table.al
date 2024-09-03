tableextension 50028 "Payment Method Table Ext" extends "Payment Method"
{
    fields
    {
        field(50000; "Pay Type"; Option)
        {
            OptionCaption = ' ,Cash,Cheque,Credit Card,Debit Card,Gift Voucher,RTGS,Finance,Advance,Maple BuyBack,Apple BuyBack,Apple Refund,RazorPay,PAYTM DCEMI,PAYTM,Cashify,Servify Transfer,Servify Bonus,Paytm Transfer';
            OptionMembers = " ",Cash,Cheque,"Credit Card","Debit Card","Gift Voucher",RTGS,Finance,Advance,"Maple BuyBack","Apple BuyBack","Apple Refund",RazorPay,"PAYTM DCEMI",PAYTM,Cashify,"Servify Transfer","Servify Bonus","Paytm Transfer";
        }
        field(50001; "Service Charge Account No."; Code[20])
        {
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account";
        }
        field(50002; "Service Charge Perc"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(50003; "Credit card Machine Code"; Code[20])
        {
            TableRelation = "Standard Text" WHERE("Credit Cd Machine Code" = FILTER(<> ''),
                                                   TID = CONST(false));

            trigger OnLookup()
            var
                StandardText: Record "Standard Text";
            begin
                StandardText.RESET;
                StandardText.SETFILTER("Credit Cd Machine Code", '<>%1', '');
                IF PAGE.RUNMODAL(8, StandardText) = ACTION::LookupOK THEN BEGIN
                    "Credit card Machine Code" := StandardText."Credit Cd Machine Code";
                END;
            end;

            trigger OnValidate()
            var
                StandardText: Record "Standard Text";
            begin
                StandardText.RESET;
                StandardText.SETFILTER("Credit Cd Machine Code", '%1', "Credit card Machine Code");
                IF NOT FINDFIRST THEN BEGIN
                    MESSAGE('Invalid Credit Card Machine Code');
                    "Credit card Machine Code" := '';
                END;
            end;
        }
        field(50004; "Branch Code"; Code[10])
        {
            //  TableRelation = "Responsibility Center New 1";
        }
    }
}
