tableextension 50059 "Sales Shipment Line Table" extends "Sales Shipment Line"
{
    fields
    {
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
    }
}
