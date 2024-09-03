tableextension 50004 "Standard Text Table" extends "Standard Text"
{
    fields
    {
        field(50000; "Category Type"; Option)
        {
            OptionCaption = ' ,Primary,Secondary,Third';
            OptionMembers = " ",Primary,Secondary,Third;
        }
        field(50001; "Credit Cd Machine Code"; Code[20])
        {
        }
        field(50002; Shield; Boolean)
        {
        }
        field(50003; "Shield Type"; Option)
        {
            OptionCaption = ' ,Shield,Shield Plus,Shield+Ex PAD/PHO,Shield Ex,Shield+ExCPU,ExCPU,ExIPH/IPAD,Shield Extended,Shield+Ext Watch,Shield EXT PAD/PHO,Shield EXTENDED CPU,Shield Ex Watch';
            OptionMembers = " ",Shield,"Shield Plus","Shield+Ex PAD/PHO","Shield Ex","Shield+ExCPU",ExCPU,"ExIPH/IPAD","Shield Extended","Shield+Ext Watch","Shield EXT PAD/PHO","Shield EXTENDED CPU","Shield Ex Watch";
        }
        field(50004; "Shield Insurance T&C"; Text[250])
        {
        }
        field(50005; "Shield Insurance T&C1"; Text[250])
        {
        }
        field(50006; "Shield Cost Perct"; Decimal)
        {
        }
        field(50007; "Shield Insurance T&C2"; Text[250])
        {
        }
        field(50008; "Shield Insurance T&C3"; Text[250])
        {
        }
        field(50009; TID; Boolean)
        {
        }
        field(50010; "TID NO"; Code[20])
        {
        }
        field(50011; "Credit Card Machine"; Boolean)
        {
        }
        field(50012; Scheme; Boolean)
        {
        }
        field(50013; "Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category";

            trigger OnValidate()
            begin
                /*
                IF "Item Category Code" <> xRec."Item Category Code" THEN BEGIN
                  IF ItemCategory.GET("Item Category Code") THEN BEGIN
                    IF "Gen. Prod. Posting Group" = '' THEN
                      VALIDATE("Gen. Prod. Posting Group",ItemCategory."Def. Gen. Prod. Posting Group");
                    IF ("VAT Prod. Posting Group" = '') OR
                       (GenProdPostingGrp.ValidateVatProdPostingGroup(GenProdPostingGrp,"Gen. Prod. Posting Group") AND
                        ("Gen. Prod. Posting Group" = ItemCategory."Def. Gen. Prod. Posting Group") AND
                        ("VAT Prod. Posting Group" = GenProdPostingGrp."Def. VAT Prod. Posting Group"))
                    THEN
                      VALIDATE("VAT Prod. Posting Group",ItemCategory."Def. VAT Prod. Posting Group");
                    IF "Inventory Posting Group" = '' THEN
                      VALIDATE("Inventory Posting Group",ItemCategory."Def. Inventory Posting Group");
                    IF "Tax Group Code" = '' THEN
                      VALIDATE("Tax Group Code",ItemCategory."Def. Tax Group Code");
                    VALIDATE("Costing Method",ItemCategory."Def. Costing Method");
                  END;
                
                  IF NOT ProductGrp.GET("Item Category Code","Product Group Code") THEN
                    VALIDATE("Product Group Code",'')
                  ELSE
                    VALIDATE("Product Group Code");
                END;
                 */

            end;
        }
        field(50014; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            TableRelation = "Product Group New".Code WHERE("Item Category Code" = FIELD("Item Category Code"));
        }
        field(50015; "Starting Date"; Date)
        {
            NotBlank = false;
        }
        field(50016; "Ending Date"; Date)
        {
            NotBlank = false;
        }
        field(50017; "Scheme Vendor"; Code[20])
        {
            TableRelation = Vendor WHERE("Apple Distributor" = CONST(True));
        }
        field(50018; Open; Boolean)
        {

            trigger OnValidate()
            var
                SchemeDetails: Record "Scheme Details";
            begin
                SchemeDetails.RESET;
                SchemeDetails.SETFILTER("Scheme Code", '%1', Code);
                IF SchemeDetails.FINDFIRST THEN
                    REPEAT
                        SchemeDetails.Open := Open;
                        SchemeDetails.MODIFY;
                    UNTIL SchemeDetails.NEXT = 0;
                MODIFY;
            end;
        }
        field(50019; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(50020; SchItemsEnabled; Integer)
        {
            CalcFormula = Count("Scheme Details" WHERE("Enable Scheme" = CONST(True),
                                                        "Scheme Code" = FIELD(Code)));
            FieldClass = FlowField;
        }
        field(50021; "Scheme Close Dt"; Date)
        {
        }
        field(50022; "Shield Insurance T&C4"; Text[250])
        {
        }
        field(50023; "Shield Insurance T&C5"; Text[250])
        {
        }
        field(50024; "Shield Insurance T&C6"; Text[250])
        {
        }
        field(50025; "Shield Insurance T&C7"; Text[250])
        {
        }
    }
}
