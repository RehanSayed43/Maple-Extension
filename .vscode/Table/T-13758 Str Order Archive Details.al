// table 13758 "Str Order Archive Details"
// {
//     Caption = 'Str Order Archive Details';

//     fields
//     {
//         field(1; Type; Option)
//         {
//             Caption = 'Type';
//             OptionCaption = ' ,Purchase,Sale,Transfer';
//             OptionMembers = " ",Purchase,Sale,Transfer;
//         }
//         field(2; "Document Type"; Option)
//         {
//             Caption = 'Document Type';
//             OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
//             OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
//         }
//         field(3; "Document No."; Code[20])
//         {
//             Caption = 'Document No.';
//         }
//         field(4; "Structure Code"; Code[10])
//         {
//             Caption = 'Structure Code';
//         }
//         field(5; "Calculation Order"; Integer)
//         {
//             Caption = 'Calculation Order';
//         }
//         field(6; "Tax/Charge Type"; Option)
//         {
//             Caption = 'Tax/Charge Type';
//             OptionCaption = 'Charges,Sales Tax,Excise,Other Taxes,Service Tax,GST';
//             OptionMembers = Charges,"Sales Tax",Excise,"Other Taxes","Service Tax",GST;

//             trigger OnValidate()
//             begin
//                 IF "Tax/Charge Type" IN ["Tax/Charge Type"::"Sales Tax", "Tax/Charge Type"::Excise, "Tax/Charge Type"::GST] THEN
//                     "Header/Line" := "Header/Line"::Line;
//                 IF "Tax/Charge Type" = "Tax/Charge Type"::Charges THEN
//                     "Charge Basis" := "Charge Basis"::Amount;
//             end;
//         }
//         field(7; "Tax/Charge Group"; Code[10])
//         {
//             Caption = 'Tax/Charge Group';

//             trigger OnValidate()
//             begin
//                 VALIDATE("Tax/Charge Type");
//             end;
//         }
//         field(8; "Tax/Charge Code"; Code[10])
//         {
//             Caption = 'Tax/Charge Code';
//         }
//         field(9; "Calculation Type"; Option)
//         {
//             Caption = 'Calculation Type';
//             OptionCaption = ' ,Percentage,Amount Per Qty,Fixed Value';
//             OptionMembers = " ",Percentage,"Amount Per Qty","Fixed Value";

//             trigger OnValidate()
//             begin
//                 IF "Calculation Type" = "Calculation Type"::"Amount Per Qty" THEN
//                     "Quantity Per" := 1
//                 ELSE
//                     "Quantity Per" := 0;
//             end;
//         }
//         field(10; "Calculation Value"; Decimal)
//         {
//             BlankZero = true;
//             Caption = 'Calculation Value';
//             DecimalPlaces = 0 : 5;
//         }
//         field(11; "Quantity Per"; Decimal)
//         {
//             BlankZero = true;
//             Caption = 'Quantity Per';
//         }
//         field(12; "Loading on Inventory"; Boolean)
//         {
//             Caption = 'Loading on Inventory';

//             trigger OnValidate()
//             begin
//                 IF "Tax/Charge Type" IN ["Tax/Charge Type"::Excise, "Tax/Charge Type"::GST] THEN
//                     TESTFIELD("Loading on Inventory", FALSE);

//                 IF "Loading on Inventory" THEN
//                     "% Loading on Inventory" := 100
//                 ELSE
//                     "% Loading on Inventory" := 0;
//             end;
//         }
//         field(13; "% Loading on Inventory"; Decimal)
//         {
//             BlankZero = true;
//             Caption = '% Loading on Inventory';
//             DecimalPlaces = 0 : 5;
//             Editable = false;
//             MaxValue = 100;
//             MinValue = 0;
//         }
//         field(14; "Payable to Third Party"; Boolean)
//         {
//             Caption = 'Payable to Third Party';

//             trigger OnValidate()
//             begin
//                 IF NOT "Payable to Third Party" THEN
//                     "Third Party Code" := '';
//             end;
//         }
//         field(15; "Third Party Code"; Code[20])
//         {
//             Caption = 'Third Party Code';
//             TableRelation = Vendor;
//         }
//         field(16; "Account No."; Code[20])
//         {
//             Caption = 'Account No.';
//             Editable = false;
//           //  TableRelation = IF ("Tax/Charge Type" = FILTER("Charges|Other Taxes")) "G/L Account";
//         }
//         field(17; "Base Formula"; Text[80])
//         {
//             Caption = 'Base Formula';
//         }
//         field(18; "Include Base"; Boolean)
//         {
//             Caption = 'Include Base';
//         }
//         field(19; "Include Line Discount"; Boolean)
//         {
//             Caption = 'Include Line Discount';
//         }
//         field(20; "Include Invoice Discount"; Boolean)
//         {
//             Caption = 'Include Invoice Discount';
//         }
//         field(21; "Charge Basis"; Option)
//         {
//             Caption = 'Charge Basis';
//             OptionCaption = ' ,Equally,Amount';
//             OptionMembers = " ",Equally,Amount;
//         }
//         field(22; "Header/Line"; Option)
//         {
//             Caption = 'Header/Line';
//             OptionCaption = 'Header,Line';
//             OptionMembers = Header,Line;
//         }
//         field(23; LCY; Boolean)
//         {
//             Caption = 'LCY';
//         }
//         field(24; "Available for VAT Input"; Boolean)
//         {
//             Caption = 'Available for VAT Input';
//         }
//         field(25; "Version No."; Integer)
//         {
//             Caption = 'Version No.';
//         }
//         field(26; "Doc. No. Occurrence"; Integer)
//         {
//             Caption = 'Doc. No. Occurrence';
//         }
//         field(30; CVD; Boolean)
//         {
//             Caption = 'CVD';
//             Editable = false;
//         }
//         field(31; "CVD Payable to Third Party"; Boolean)
//         {
//             Caption = 'CVD Payable to Third Party';
//         }
//         field(32; "CVD Third Party Code"; Code[20])
//         {
//             Caption = 'CVD Third Party Code';
//             TableRelation = "G/L Account";
//         }
//         field(36; "Include in TDS Base"; Boolean)
//         {
//             Caption = 'Include in TDS Base';
//         }
//         field(37; "Inc. GST in TDS Base"; Boolean)
//         {
//             Caption = 'Inc. GST in TDS Base';
//             Editable = false;
//         }
//         field(50000; "Document Line No."; Integer)
//         {
//             Caption = 'Document Line No.';
//         }
//         field(50001; "Price Inclusive of Tax"; Boolean)
//         {
//             Caption = 'Price Inclusive of Tax';
//         }
//         field(50002; "Include PIT Calculation"; Boolean)
//         {
//             Caption = 'Include PIT Calculation';
//         }
//     }

//     keys
//     {
//         key(Key1; Type, "Calculation Order", "Document Type", "Document No.", "Structure Code", "Tax/Charge Type", "Tax/Charge Group", "Tax/Charge Code", "Document Line No.", "Doc. No. Occurrence", "Version No.")
//         {
//             Clustered = true;
//         }
//         key(Key2; "Document Type", "Document No.", Type)
//         {
//         }
//     }

//     fieldgroups
//     {
//     }
// }

