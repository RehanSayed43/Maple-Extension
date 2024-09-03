tableextension 50036 "Sales Line Archive Table" extends "Sales Line Archive"
{
    fields
    {
        field(50000; "Credit Hold"; Boolean)
        {
            Description = 'Win127';
            InitValue = false;
        }
        field(50001; "Overdue Hold"; Boolean)
        {
            Description = 'Win127';
            InitValue = false;
        }
        field(50002; "Price Hold"; Boolean)
        {
            Description = 'Win127';
            InitValue = false;
        }
        field(50004; "PDC Hold"; Boolean)
        {
            Description = 'Win127';
            InitValue = false;
        }
        field(50005; "Discount Hold"; Boolean)
        {
            Description = 'Win127';
            InitValue = false;
        }
        field(50006; Shield; Boolean)
        {
            Description = 'win127';

            trigger OnValidate()
            begin
                //WBU.RefreshPage;
            end;
        }
        field(50007; "Item Serial No."; Text[30])
        {
            Description = 'win127';

            trigger OnValidate()
            var
                ILE: Record "Item Ledger Entry";
            begin
            end;
        }
        field(50059; "Eleva Product Serial No."; Code[20])
        {
        }
        field(50008; "Free Item"; Boolean)
        {
            Description = 'win127';
            InitValue = false;
        }
        field(50009; "Free Item Pend_for_ Delivery"; Boolean)
        {
            Description = 'win127';
        }
        field(50010; "Shield Value"; Decimal)
        {

            trigger OnValidate()
            begin
                //TESTFIELD(Shield);
            end;
        }
        field(50013; AMC; Boolean)
        {
        }
        field(50014; "AMC Due Date"; Date)
        {

            trigger OnValidate()
            begin
                //TESTFIELD(AMC);
            end;
        }
        field(50015; "Warranty Exp. Dt"; Date)
        {
        }
        field(50016; "shield Due Date"; Date)
        {

            trigger OnValidate()
            begin
                //TESTFIELD(Shield);
            end;
        }
        field(50017; "Cust. Mobile No."; Text[30])
        {
        }
        field(50018; "Cust. email ID"; Text[180])
        {
        }
        field(50019; "Customer Name"; Text[50])
        {
        }
        field(50020; "Shield Cost"; Decimal)
        {
        }
        field(50021; "Shield Type"; Option)
        {
            OptionCaption = ' ,Shield,Shield Plus';
            OptionMembers = " ",Shield,"Shield Plus";

            trigger OnValidate()
            var
                ShieldMast: Record "Scheme Details";
            begin
            end;
        }
        field(50022; "IMEI No."; Code[20])
        {
        }
        field(50039; "MRP Discount %"; Decimal)
        {
            DecimalPlaces = 0 : 2;
            Description = '//Win120 WS t0 calculate MRP Discount';
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            begin
                /*"MRP Discount Amount" :=
                  ROUND(ROUND(Quantity * "Unit Price",Currency."Amount Rounding Precision") * "MRP Discount %" / 100,
                   Currency."Amount Rounding Precision");*/
                /*   "MRP Discount Amount" :=
                  ROUND(ROUND(Quantity * "Unit Price",3) * "MRP Discount %" / 100,
                   0.001);
                
                
                VALIDATE("Line Discount Amount","MRP Discount Amount");
                */

            end;
        }
        field(50040; "MRP Discount Amount"; Decimal)
        {
            DecimalPlaces = 0 : 2;
            Description = '//Win120 WS t0 calculate MRP Discount';

            trigger OnValidate()
            begin
                /*IF NOT "Price Inclusive of Tax" THEN
                     IF ROUND(Quantity * "Unit Price",Currency."Amount Rounding Precision") <> 0 THEN
                       "MRP Discount %" :=
                         ROUND(
                          "MRP Discount %" / ROUND(Quantity * "Unit Price",Currency."Amount Rounding Precision") * 100,
                        0.00001)
                     ELSE
                      "MRP Discount %" := 0
                   ELSE
                     IF ROUND(Quantity * "Unit Price Incl. of Tax",Currency."Amount Rounding Precision") <> 0 THEN
                     "MRP Discount %" :=
                        ROUND(
                          "MRP Discount %" / ROUND(Quantity * "Unit Price Incl. of Tax",Currency."Amount Rounding Precision") * 100,
                          0.00001)
                     ELSE
                       "MRP Discount %" := 0;
                
                VALIDATE("MRP Discount %");
                */

            end;
        }
        field(50041; "MRP Line Discount Amount"; Decimal)
        {
            Description = '//Win120 WS t0 calculate MRP Discount';
        }
        field(50049; "Discount Type"; Code[20])
        {
            Caption = 'Discount Type';
            Description = '//CCIT-TK';
            TableRelation = Discounting;
        }
        field(50050; "Discount %"; decimal)
        {
            Description = '//CCIT-TK';

        }
        field(50051; "Discount Amount"; Decimal)
        {
            Description = '//CCIT-TK';//ccit-tk
        }
        field(50052; SKU1; Code[50])
        {
            Description = 'Ecom';
        }
        field(50053; "Net Amount"; Decimal)
        {
            Description = '//CCIT-TK';//ccit-tk

        }
        field(50054; "Product Category"; Code[20])
        {
            Editable = true;
            TableRelation = "Product Category";


        }
        field(50055; "MRP Value"; Decimal)
        {

        }
    }
}
