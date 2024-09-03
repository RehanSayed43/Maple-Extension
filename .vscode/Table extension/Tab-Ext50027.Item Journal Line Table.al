tableextension 50027 "Item Journal Line Table" extends "Item Journal Line"
{
    fields
    {
        field(50000; "IMEI No."; Code[20])
        {
        }
        field(50001; "Primary category"; Code[20])
        {
            TableRelation = "Standard Text" WHERE("Category Type" = CONST(Primary));
        }
        field(50002; "Secondary category"; Code[20])
        {
            TableRelation = "Standard Text" WHERE("Category Type" = CONST(Secondary));
        }
        field(50003; "Third category"; Code[20])
        {
            TableRelation = "Standard Text" WHERE("Category Type" = CONST(Third));
        }
        field(50004; "UPN Code"; Code[20])
        {
        }
        field(50005; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment";
        }
        field(50008; "Scheme Code"; Code[10])
        {
        }
        field(50009; "Scheme Amount"; Decimal)
        {
        }
        field(50010; "Assign Batch Serial"; Boolean)
        {
            Description = 'DG';
        }
        field(50011; "WMS Process"; Boolean)
        {
            Description = 'KPPLDG00017';
        }
        field(50012; "Inventory Transfer"; Boolean)
        {
            Description = 'KPPLDG00039';
        }
        field(50033; "MRP Value"; Decimal)
        {
            Description = 'CCIT-TK';
        }
        field(50034; "New External Document No "; Code[35])
        {
            Caption = 'New External Document No.';
        }
        field(50036; "Auto Generated"; Boolean)
        {

        }
        modify("Serial No.")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
                ILE: Record "Item Ledger Entry";
                ResENTRY: Record "Reservation Entry";
            begin
                //Message('RJ%1', REC."Serial No.");

                ILE.Reset();
                //ILE.SetRange(ILE."Source Type", 83);
                //ILE.SetRange(ILE."Source ID", "Journal Template Name");
                //ILE.SetRange(ILE."Source Batch Name", "Journal Batch Name");
                ILE.SetFilter(ILE."Entry Type", '%1|%2|%3', ILE."Entry Type"::Purchase, ILE."Entry Type"::Transfer, ILE."Entry Type"::"Positive Adjmt.");
                ILE.SetRange(ILE."Item No.", Rec."Item No.");
                //ILE.SetRange(ILE."Source Ref. No.", "Line No.");
                ILE.SetRange(ILE."Serial No.", Rec."Serial No.");
                ILE.SetRange(ILE."Location Code", Rec."Location Code");
                ILE.SetRange(ILE."Item Tracking", ILE."Item Tracking"::"Serial No.");
                ILE.SetFilter(ILE."Remaining Quantity", '>%1', 0);
                ILE.SetRange(ILE.Open, true);
                IF ILE.FindFirst() THEN BEGIN
                    //Message('%1', ILE."IMEI No.");

                    Rec."MRP Value" := ILE."MRP Value";
                    Message('%1', ILE."MRP Value");

                    Rec.Modify();

                END;

                ResENTRY.Reset();
                ResENTRY.SetRange(ResENTRY."Source Type", 83);
                ResENTRY.SetRange(ResENTRY."Source ID", "Journal Template Name");
                ResENTRY.SetRange(ResENTRY."Source Batch Name", "Journal Batch Name");
                ResENTRY.SetRange(ResENTRY."Item No.", Rec."No.");
                ResENTRY.SetRange(ResENTRY."Source Ref. No.", "Line No.");
                ResENTRY.SetRange(ResENTRY."Serial No.", Rec."Serial No.");
                ResENTRY.SetRange(ResENTRY."Location Code", Rec."Location Code");
                ResENTRY.SetRange(ResENTRY."Item Tracking", ResENTRY."Item Tracking"::"Serial No.");

                IF ResENTRY.FindFirst() THEN BEGIN
                    //Message('%1', ILE."IMEI No.");

                    Rec."MRP Value" := ResENTRY."MRP Value";
                    Message('%1', ResENTRY."MRP Value");

                    Rec.Modify(true);

                END;

                // //Item Tacking speci to Item Journal
                // ILE.Reset();
                // ILE.SetFilter(ILE."Entry Type", '%1|%2|%3', ILE."Entry Type"::Purchase, ILE."Entry Type"::Transfer, ILE."Entry Type"::"Positive Adjmt.");
                // // ILE.SetRange(ILE."Entry Type", ILE."Entry Type"::Purchase); //End, ILE."Entry Type"::"Positive Adjmt.");//ccit-Tk
                // ILE.SetRange(ILE."Item No.", Rec."No.");
                // ILE.SetRange(ILE."Serial No.", Rec."Serial No.");
                // ILE.SetRange(ILE."Location Code", Rec."Location Code");
                // ILE.SetRange(ILE."Item Tracking", ILE."Item Tracking"::"Serial No.");
                // IF ILE.FindFirst() THEN BEGIN
                //     //Message('%1', ILE."IMEI No.");

                //     Rec."MRP Value" := ILE."MRP Value";

                //     Rec.Modify(false);
                // end;


            end;
        }
    }

}
