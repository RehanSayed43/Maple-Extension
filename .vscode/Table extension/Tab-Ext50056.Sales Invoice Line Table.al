tableextension 50056 "Sales Invoice Line Table" extends "Sales Invoice Line"
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
        field(50003; "Sales Order Type"; Option)
        {
            Description = 'Win127';
            OptionCaption = 'Retail,Rental,B2B,AMC,Service';
            OptionMembers = Retail,Rental,B2B,AMC,Service;
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
        }
        field(50007; "Serial No."; Text[30])
        {
            Description = 'win127';
        }
        field(50008; "Free Item"; Boolean)
        {
            Description = 'win127';
            InitValue = false;

            trigger OnValidate()
            begin
                IF "Free Item" THEN
                    VALIDATE("Unit Price", 0);


            end;
        }
        field(50009; "Free Item Pend_for_ Delivery"; Boolean)
        {
            Description = 'win127';
        }
        field(50010; "Shield Value"; Decimal)
        {
        }
        field(50013; AMC; Boolean)
        {
        }
        field(50014; "AMC Due Date"; Date)
        {
        }
        field(50015; "Warranty Exp. Dt"; Date)
        {
        }
        field(50016; "shield Due Date"; Date)
        {
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
            OptionCaption = ' ,Shield,Shield Plus,Shield+Ex PAD/PHO,Shield Ex,Shield+ExCPU,ExCPU,ExIPH/IPAD,Shield Extended,Shield+Ext Watch,Shield EXT PAD/PHO,Shield EXTENDED CPU,Shield Ex Watch';
            OptionMembers = " ",Shield,"Shield Plus","Shield+Ex PAD/PHO","Shield Ex","Shield+ExCPU",ExCPU,"ExIPH/IPAD","Shield Extended","Shield+Ext Watch","Shield EXT PAD/PHO","Shield EXTENDED CPU","Shield Ex Watch";

            trigger OnValidate()
            var
                ShieldMast: Record 50001;
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
            end;
        }
        field(50027; "Scheme Code"; Code[10])
        {
        }
        field(50028; "Scheme Amount"; Decimal)
        {
        }
        field(50029; "Claim Amount"; Decimal)
        {
        }
        field(50030; "Claim received"; Boolean)
        {
        }
        field(50031; "Claim Received Date"; Date)
        {
        }
        field(50032; "Scheme %"; Decimal)
        {
            DecimalPlaces = 2 : 2;
            MinValue = 0;
        }
        field(50033; "Claim %"; Decimal)
        {
            DecimalPlaces = 2 : 2;
            MinValue = 0;
        }
        field(50034; Vendor; Code[20])
        {
        }
        field(50035; "Vendor Part Code"; Code[50])
        {
        }
        field(50037; "Sales Points"; Decimal)
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
                /*  "MRP Discount Amount" :=
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
        field(50099; Select; Boolean)
        {
        }
        field(50100; Brand; Code[10])
        {
            TableRelation = "Item Category".Code;
        }
        field(50055; "MRP Value"; Decimal)
        {

        }
        field(50059; "Eleva Product Serial No."; Code[20])
        {
        }
        field(50110; "Auto Generated"; Boolean)
        {

        }
        //Rushab_CCIT++
        field(50111; "User ID"; Code[50])
        {
            Caption = 'User ID';

            FieldClass = FlowField;
            CalcFormula = lookup(User."User Name" where("User Security ID" = field(SystemCreatedBy)));
        }
        //Rushab_CCIT--
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
