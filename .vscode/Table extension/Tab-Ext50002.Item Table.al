tableextension 50002 "Item Table" extends Item
{
    fields
    {
        field(50000; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment,Approved';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment",Approved;
        }
        field(50001; "Primary category"; Code[20])
        {
            TableRelation = "Standard Text" WHERE("Category Type" = CONST(Primary));
            ValidateTableRelation = true;
        }
        field(50002; "Secondary category"; Code[20])
        {
            TableRelation = "Standard Text" WHERE("Category Type" = CONST(Secondary));
            ValidateTableRelation = true;
        }
        field(50003; "Third category"; Code[20])
        {
            TableRelation = "Standard Text" WHERE("Category Type" = CONST(Third));
            ValidateTableRelation = true;
        }
        field(50004; "Purchase Block"; Boolean)
        {
        }
        field(50005; "Sales Block"; Boolean)
        {
        }
        field(50006; SeriesPattern; Code[8])
        {
        }
        field(50015; "Lond Description"; Text[80])
        {
        }
        field(50016; "Vendor Part Code Long"; Code[50])
        {
        }
        field(50017; "UPN Code"; Code[20])
        {
            Description = ' added 19.11.14';
        }
        field(50018; "Sales Points"; Decimal)
        {
        }
        field(50019; "Inventory at date"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No."),
                                                                  "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                  "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                  "Location Code" = FIELD("Location Filter"),
                                                                  "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                 "Posting Date" = FIELD(UPPERLIMIT("Date Filter")),
                                                                  "Variant Code" = FIELD("Variant Filter"),
                                                                 "Lot No." = FIELD("Lot No. Filter"),
                                                                 "Serial No." = FIELD("Serial No. Filter")));
            Caption = 'Net Change';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50020; SKU1; Code[50])
        {
            Description = 'Ecom';
        }
        field(50021; "Ecommerce Item"; Boolean)
        {
            Description = 'Ecom';
        }
        field(50022; Grade; Code[20])
        {
            Description = 'Win-234';
        }
        field(50023; "Old Item No"; Code[20])
        {
        }
        field(50024; "Last No. Used"; Text[30])
        {
            Description = 'kppl';
        }
        field(50025; "Sync with WMS"; Boolean)
        {
            Description = 'KPPL';
        }
        field(50026; "Old Item No. 2"; Code[20])
        {
            Description = 'KPPL-KB';
        }
        field(50027; COGS; Decimal)
        {
            Description = 'KPPL-KB';
        }
        field(50030; "Ingram Part Code"; Code[20])
        {
            Caption = 'Ingram Part Code';
            Description = 'KPPL-INGRAM';
        }
        field(50031; "Product Category"; Code[20])
        {

            Caption = 'Category';
            TableRelation = "Product Group New".Code WHERE("Item Category Code" = FIELD("Item Category Code"));
            //Editable = true;

        }
        field(50032; "PowerBI CompAge"; Integer)
        {
        }
        field(50033; "PowerBI Amount"; Decimal)
        {
        }


    }
}
