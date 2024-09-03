tableextension 50062 "PurchaseHeader" extends "Purchase Header"
{
    fields
    {
        field(50000; "Vendor Invoice Value"; Decimal)
        {
        }
        field(50001; "PO Validity Date"; Date)
        {
        }
        field(50002; "Retail Sale Invoice Ref. No."; Code[20])
        {
        }
        field(50003; Closed; Boolean)
        {
            InitValue = false;
        }
        field(50004; "Closing Remark"; Text[100])
        {
        }
        field(50005; "Closed By"; Code[50])
        {
            TableRelation = User."User Name";//tk
        }
        field(50006; "Closed Date & Time"; DateTime)
        {
        }
        field(50007; "Retail Buyback Ref. No."; Code[20])
        {
        }
        field(50008; "Remarks Team"; Text[250])
        {
        }
        field(50009; "Remarks Vendor"; Text[250])
        {
        }
        field(50010; "Dispatch Doc No"; Text[50])
        {
        }
        field(50011; "Dispatch Through"; Text[50])
        {
        }
        field(50012; "Dispatch Date"; Date)
        {
        }
        field(50013; "Vendor Invoice Date"; Date)
        {
            Description = 'WIN234';
        }
        field(50050; "Import Document No."; Code[30])
        {
        }
        field(50051; CRM; Boolean)
        {
            Description = 'WIN292';
        }
        field(50052; "Expense Invoice"; Boolean)
        {
            Description = 'WIN234';
        }
        field(50053; "DOA Transaction"; Boolean)
        {
            Description = 'WIN234';
        }
        field(50054; "Refreance No."; Code[20])
        {
        }
        field(50055; "WMS Process"; Boolean)
        {
            Description = 'KPPLDG00017';
        }
        field(50056; "Ingram Order No."; Code[20])
        {
            Caption = 'Ingram Order No.';
            DataClassification = ToBeClassified;
            Description = 'KPPL-INGRAM';
        }
    }

    var
        myInt: Integer;
    // PostedGateEntryLine: Record 16556;
    // PostedGateEntryLineList: Page "16480";
    // PurchHeader2: Record "38";
    // GateEntryAttachment: Record "16557";
    // GateEntryAttachment2: Record "16557";

    local procedure SkipInitialization(): Boolean
    begin
        IF "No." = '' THEN
            EXIT(FALSE);

        IF "Buy-from Vendor No." = '' THEN
            EXIT(FALSE);

        IF xRec."Document Type" <> "Document Type" THEN
            EXIT(FALSE);

        IF GETFILTER("Buy-from Vendor No.") <> '' THEN
            IF GETRANGEMIN("Buy-from Vendor No.") = GETRANGEMAX("Buy-from Vendor No.") THEN
                IF "Buy-from Vendor No." = GETRANGEMIN("Buy-from Vendor No.") THEN
                    EXIT(FALSE);

        EXIT(TRUE);
    end;

    procedure GetGateEntryLines()
    begin
        // PostedGateEntryLine.MODIFYALL(Mark, FALSE);
        // PurchHeader2.GET("Document Type", "No.");
        // PostedGateEntryLine.RESET;
        // PostedGateEntryLine.SETCURRENTKEY("Entry Type", "Source Type", "Source No.", Status);

        // CASE "Document Type" OF
        //     "Document Type"::Order:
        //         BEGIN
        //             PostedGateEntryLine.SETRANGE("Source Type", PostedGateEntryLine."Source Type"::"Purchase Order");
        //             PostedGateEntryLine.SETRANGE("Entry Type", PostedGateEntryLine."Entry Type"::Inward);
        //             PostedGateEntryLine.SETRANGE("Source No.", "No.");
        //             PostedGateEntryLine.SETRANGE(Status, PostedGateEntryLine.Status::Open);
        //         END;
        //     "Document Type"::Invoice:
        //         BEGIN
        //             PostedGateEntryLine.SETRANGE("Source Type", PostedGateEntryLine."Source Type"::" ");
        //             PostedGateEntryLine.SETRANGE("Entry Type", PostedGateEntryLine."Entry Type"::Inward);
        //             PostedGateEntryLine.SETRANGE(Status, PostedGateEntryLine.Status::Open);
        //         END;
        // END;

        // GateEntryAttachment.SETCURRENTKEY("Source Type", "Source No.", "Entry Type", "Gate Entry No.", "Line No.");
        // IF PostedGateEntryLine.FINDSET THEN
        //     REPEAT
        //         GateEntryAttachment.SETRANGE("Source No.", PostedGateEntryLine."Source No.");
        //         GateEntryAttachment.SETRANGE("Gate Entry No.", PostedGateEntryLine."Gate Entry No.");
        //         GateEntryAttachment.SETRANGE("Line No.", PostedGateEntryLine."Line No.");
        //         IF NOT GateEntryAttachment.FINDFIRST THEN BEGIN
        //             PostedGateEntryLine.Mark := TRUE;
        //             PostedGateEntryLine.MODIFY;
        //             COMMIT;
        //         END;
        //     UNTIL PostedGateEntryLine.NEXT = 0;

        // PostedGateEntryLine.RESET;
        // PostedGateEntryLine.SETCURRENTKEY("Entry Type", "Source Type", "Source No.", Status);
        // PostedGateEntryLine.SETRANGE(Mark, TRUE);
        // IF PostedGateEntryLine.FINDFIRST THEN BEGIN
        //     PostedGateEntryLineList.SETTABLEVIEW(PostedGateEntryLine);
        //     IF PAGE.RUNMODAL(PAGE::"Posted Gate Entry Line List", PostedGateEntryLine) = ACTION::LookupOK THEN BEGIN
        //         GateEntryAttachment.INIT;
        //         GateEntryAttachment."Source Type" := PostedGateEntryLine."Source Type";
        //         GateEntryAttachment."Source No." := PostedGateEntryLine."Source No.";
        //         GateEntryAttachment."Entry Type" := PostedGateEntryLine."Entry Type";
        //         GateEntryAttachment."Gate Entry No." := PostedGateEntryLine."Gate Entry No.";
        //         GateEntryAttachment."Line No." := PostedGateEntryLine."Line No.";
        //         GateEntryAttachment."Purchase Invoice No." := "No.";
        //         GateEntryAttachment.INSERT;
        //     END;
        // END;
    end;




}