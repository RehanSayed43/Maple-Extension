tableextension 50055 "Sales Cr. Memo Line Table" extends "Sales Cr.Memo Line"
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
                //    WBU.RefreshPage;
            end;
        }
        field(50007; "Item Serial No."; Text[30])
        {
            Description = 'win127';

            trigger OnValidate()
            var
                ILE: Record 32;
            begin
            end;
        }
        field(50008; "Free Item"; Boolean)
        {
            Description = 'win127';
            InitValue = false;

            trigger OnValidate()
            begin
                IF "Free Item" THEN BEGIN
                    //VALIDATE("PIT Structure",'');
                    VALIDATE("Unit Price", 0);
                    VALIDATE("Unit Price Incl. of Tax", 0);
                END;
            end;
        }
        field(50009; "Free Item Pend_for_ Delivery"; Boolean)
        {
            Description = 'win127';
        }
        field(50010; "Shield Value"; Decimal)
        {

            trigger OnValidate()
            begin
                TESTFIELD(Shield);
            end;
        }
        field(50013; AMC; Boolean)
        {
        }
        field(50014; "AMC Due Date"; Date)
        {

            trigger OnValidate()
            begin
                TESTFIELD(AMC);
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
            OptionCaption = ' ,Shield,Shield Plus,Shield+Ex PAD/PHO,Shield Ex,Shield+ExCPU,ExCPU,ExIPH/IPAD,Shield Extended,Shield+Ext Watch,Shield EXT PAD/PHO,Shield EXTENDED CPU';
            OptionMembers = " ",Shield,"Shield Plus","Shield+Ex PAD/PHO","Shield Ex","Shield+ExCPU",ExCPU,"ExIPH/IPAD","Shield Extended","Shield+Ext Watch","Shield EXT PAD/PHO","Shield EXTENDED CPU";

            trigger OnValidate()
            var
                ShieldMast: Record 50001;
                SalesLineLocal: Record 37;
            begin
            end;
        }
        field(50022; "IMEI No."; Code[20])
        {
        }
        field(50023; "Primary category"; Code[20])
        {
            TableRelation = "Standard Text" WHERE("Category Type" = CONST(Primary));
        }
        field(50024; "Secondary category"; Code[20])
        {
            TableRelation = "Standard Text" WHERE("Category Type" = CONST(Secondary));
        }
        field(50025; "Third category"; Code[20])
        {
            TableRelation = "Standard Text" WHERE("Category Type" = CONST(Third));
        }
        field(50026; "UPN Code"; Code[20])
        {

            trigger OnValidate()
            var
                ILE: Record 32;
            begin
                IF "UPN Code" = '' THEN
                    EXIT;
            end;
        }
        field(50035; "Vendor Part Code"; Code[50])
        {
        }
        field(50037; "Sales Points"; Decimal)
        {
        }
        field(50038; "ST%"; Decimal)
        {
            //  CalcFormula = Max("Service Tax Entry"."Service Tax %" WHERE ("Document No."=FIELD("Document No.")));
            //FieldClass = FlowField;
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
        field(50042; "Capillary Line Discount Amount"; Decimal)
        {
            Description = 'CAPILARY';
            Editable = false;
        }
        field(50043; "Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';
            Description = 'WIN234';
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate()
            var
                ApprovalEntry: Record 454;
            begin
            end;
        }
        field(50044; "CRT Coupon Code"; Code[20])
        {
            Description = 'KPPLDG00042';
        }
        field(50049; "Discount Type"; Code[20])
        {
            Caption = 'Discount Type';
            Description = '//CCIT-TK';
            TableRelation = Discounting;
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
        field(50050; "Discount %"; decimal)
        {
            Description = '//CCIT-TK';

        }
        field(50051; "Discount Amount"; Decimal)
        {
            Description = '//CCIT-TK';//ccit-tk
        }
        field(50055; "MRP Value"; Decimal)
        {

        }
        field(50059; "Eleva Product Serial No."; Code[20])
        {
        }
        field(50710; "Corporate Salesperson Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser".Code;


        }

        field(50711; "Corporate Salesperson Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }
}
