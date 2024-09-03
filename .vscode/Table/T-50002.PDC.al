table 50002 PDC
{
    // 
    // ISH01  03-NOV-09 - Validation for Duplicate PDC Cheque No.

    DataCaptionFields = "PDC Cheque No.", "PDC Cheque Date";
    //DrillDownPageID = 50034;
    //LookupPageID = 50034;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(5; "Document No."; Code[20])
        {
            Editable = false;
        }
        field(10; "PDC Type"; Option)
        {
            OptionCaption = 'Fully Filled,Blank';
            OptionMembers = "Fully Filled",Blank;
        }
        field(20; "Res Center"; Code[10])
        {
            // TableRelation = "WooCommerce Line";//tk
        }
        field(50; "Account Type"; Option)
        {
            Description = 'Vendor/Customer';
            OptionCaption = 'Customer,Vendor';
            OptionMembers = Customer,Vendor;
        }
        field(60; "Account No."; Code[20])
        {
            // TableRelation = IF ("Account Type"=CONST(Vendor)) //Vendor.No.
            //ELSE IF ("Account Type"=CONST(Customer)) Customer.No.;//tk
            //
            trigger OnValidate()
            begin
                IF "Account Type" = "Account Type"::Vendor THEN BEGIN
                    Vend.GET("Account No.");
                    Name := Vend.Name;
                    // "MICR Code" :='41124002' ;
                    //"Bank Name" := 'HDF-HDFC BANK LTD.';
                    //  "Bank Branch" := 'BHANKADKAR ROAD';
                    // "Bank Deposit Code" :='HDFC O/D';
                    "LONG _NAME" := Vend."Name 2";
                    MODIFY;
                END ELSE BEGIN
                    Cust.GET("Account No.");
                    Name := Cust.Name;
                    "LONG _NAME" := Cust."Name 2";
                END;
            end;
        }
        field(80; Name; Text[50])
        {
            Editable = false;
        }
        field(100; "PDC Received Date"; Date)
        {

            trigger OnValidate()
            begin
                IF "PDC Received Date" = 0D THEN
                    ERROR(Text007);
            end;
        }
        field(200; "PDC Cheque Date"; Date)
        {

            trigger OnValidate()
            begin
                TESTFIELD("PDC Status", "PDC Status"::Open);
            end;
        }
        field(300; "PDC Cheque No."; Code[10])
        {

            trigger OnValidate()
            begin
                TESTFIELD("PDC Status", "PDC Status"::Open);


                // ISH01 START
                /*
                Recusersetup.get;
                Recusersetup.setrange(Recusersetup."User ID","PDC Accepted By");
                if Recusersetup."Super User" :=false then
                 */

                CustLedgerEntry.SETRANGE(CustLedgerEntry."Customer No.", "Account No.");
                CustLedgerEntry.SETRANGE(CustLedgerEntry."Cheque No1", "PDC Cheque No.");
                IF CustLedgerEntry.FIND('-') THEN
                    ERROR('Cheque No. -  %1 already exists', "PDC Cheque No.");




                recPDC.SETRANGE(recPDC."Account Type", recPDC."Account Type"::Customer);
                recPDC.SETRANGE(recPDC."Account No.", "Account No.");
                recPDC.SETRANGE(recPDC."PDC Cheque No.", "PDC Cheque No.");
                IF recPDC.FIND('-') THEN
                    ERROR('Cheque No. -  %1 already exists', "PDC Cheque No.");

                IF "PDC Cheque No." <> '' THEN BEGIN
                    GLSetup.GET;
                    IF GLSetup."Cheque No. Length" <> 0 THEN
                        IF STRLEN("PDC Cheque No.") <> GLSetup."Cheque No. Length" THEN
                            ERROR(Text002, GLSetup."Cheque No. Length");
                END;


                // ISH01 END.

                "Applies-to ID" := "PDC Cheque No.";

            end;
        }
        field(500; "PDC Amount"; Decimal)
        {
            MinValue = 0;

            trigger OnValidate()
            begin
                TESTFIELD("PDC Status", "PDC Status"::Open);
                TESTFIELD("PDC Type", "PDC Type"::"Fully Filled");

                IF ("PDC Amount" <> xRec."PDC Amount") AND (xRec."PDC Amount" <> 0) THEN BEGIN
                    PDCAppln.RESET;
                    PDCAppln.SETRANGE(PDCAppln."Entry No.", "Entry No.");
                    IF PDCAppln.FIND('-') THEN BEGIN
                        IF CONFIRM(Text004) THEN BEGIN
                            PDCAppln.DELETEALL;
                        END ELSE BEGIN
                            ERROR(Text005);
                        END;
                    END;
                END;
            end;
        }
        field(600; "PDC Not Over Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                TESTFIELD("PDC Type", "PDC Type"::Blank);
            end;
        }
        field(1000; "MICR Code"; Code[10])
        {
            TableRelation = "MICR Codes"."MICR Code" WHERE("Code Type" = CONST(MICR));
            ValidateTableRelation = false;


            trigger OnValidate()
            begin
                IF "MICR Code" = '' THEN EXIT;

                GLSetup.GET;
                IF GLSetup."MICR Code Length" <> 0 THEN
                    IF STRLEN("MICR Code") <> GLSetup."MICR Code Length" THEN
                        ERROR(Text002, GLSetup."MICR Code Length");



                IF MICR.GET(MICR."Code Type"::MICR, "MICR Code") THEN BEGIN
                    "Bank No." := MICR."Bank No.";
                    "Bank Name" := MICR."Bank Name";
                    "Bank Branch" := MICR."Bank Branch";
                END ELSE BEGIN
                    MICR.INIT;
                    MICR."Code Type" := MICR."Code Type"::MICR;
                    MICR."MICR Code" := "MICR Code";
                    MICR.INSERT;
                    COMMIT;
                    MESSAGE(Text001, MICR."MICR Code");
                    //PAGE.RUNMODAL(50001,MICR,MICR."Bank Name"); Freight Details win127
                    MICR.GET("MICR Code");
                    "Bank No." := MICR."Bank No.";
                    "Bank Name" := MICR."Bank Name";
                    "Bank Branch" := MICR."Bank Branch";
                END;

                "Applies-to ID" := "MICR Code" + '-' + "PDC Cheque No.";
            end;
        }
        field(1100; "Bank No."; Code[20])
        {
            Caption = 'Bank Drawn/Deposit Code';

            trigger OnValidate()
            begin
                TESTFIELD("Account Type", "Account Type"::Vendor);
            end;
        }
        field(1200; "Bank Name"; Text[250])
        {
            Editable = false;
        }
        field(1300; "Bank Branch"; Text[250])
        {
            Editable = false;
        }
        field(1400; "Bank Deposit Code"; Code[10])
        {
            TableRelation = "MICR Codes"."MICR Code" WHERE("Code Type" = CONST(BankDeposit));

            trigger OnValidate()
            var
                BankDepCode: Record 50003;
            begin
                IF "Bank Deposit Code" <> '' THEN BEGIN
                    //TESTFIELD("Account Type","Account Type"::Customer);
                    BankDepCode.GET(BankDepCode."Code Type"::BankDeposit, "Bank Deposit Code");
                    BankDepCode.TESTFIELD(BankDepCode."Bank No.");
                    "Bank No." := BankDepCode."Bank No.";
                END ELSE BEGIN
                    "Bank No." := '';
                END;
            end;
        }
        field(1500; "PDC Deposit Date"; Date)
        {
        }
        field(2000; "PDC Status"; Option)
        {
            OptionCaption = 'Open,Posted,PaySlip Generated';
            OptionMembers = Open,Posted,"PaySlip Generated";
        }
        field(5000; "Applies-to ID"; Code[20])
        {
            Editable = false;
        }
        field(6000; "PDC Amount Applied"; Decimal)
        {
            //FieldClass = FlowField;
            //CalcFormula = Sum("Log Entry"."Document Type1" WHERE ("Entry No."=FIELD("Entry No.")));

        }
        field(7000; "PDC Deposited"; Boolean)
        {
        }
        field(10000; "PDC Accepted By"; Code[30])
        {
            Editable = false;
        }
        field(15000; "PDC Applied By"; Code[30])
        {
            Editable = false;
        }
        field(16000; "PDC Pay Slip Generated By"; Code[30])
        {
        }
        field(20000; "PDC Posted By"; Code[30])
        {
            Editable = false;
        }
        field(25000; "Pay Slip No."; Code[20])
        {
        }
        field(30000; "PDC Cheque Printed"; Boolean)
        {
        }
        field(30001; Remarks; Text[50])
        {
        }
        field(30002; RTGS; Boolean)
        {
            Description = 'RTGS Entry';
        }
        field(30003; Transfer; Boolean)
        {
            Description = 'Transfer Entry';
        }
        field(30004; "AtPar Outstation"; Boolean)
        {
        }
        field(30005; "CRM Amt"; Decimal)
        {
        }
        field(30006; "PDC Received Time"; Time)
        {
            Editable = false;
        }
        field(30007; "PDC DateTime"; DateTime)
        {
        }
        field(30010; "Select For Print"; Boolean)
        {

            trigger OnValidate()
            begin
                TESTFIELD(Printed, FALSE)
            end;
        }
        field(30011; Printed; Boolean)
        {
            Editable = false;
        }
        field(30012; "LONG _NAME"; Text[120])
        {
        }
        field(30013; "PAYMENT TYPE"; Option)
        {
            OptionCaption = 'NORMAL,OTHER';
            OptionMembers = NORMAL,OTHER;
        }
        field(30014; RTGS1; Boolean)
        {
        }
        field(30015; NEFT1; Boolean)
        {
        }
        field(30016; "TRANSFER B2B"; Boolean)
        {
        }
        field(30017; RTGS_NO; Code[20])
        {

            trigger OnLookup()
            begin
                "PDC Cheque No." := RTGS_NO;
            end;

            trigger OnValidate()
            begin
                "PDC Cheque No." := RTGS_NO;
            end;
        }
        field(30018; NEFT_NO; Code[20])
        {

            trigger OnLookup()
            begin

                "PDC Cheque No." := NEFT_NO;
            end;

            trigger OnValidate()
            begin

                "PDC Cheque No." := NEFT_NO;
            end;
        }
        field(30019; TRAN_NO; Code[20])
        {

            trigger OnLookup()
            begin
                "PDC Cheque No." := TRAN_NO;
            end;

            trigger OnValidate()
            begin
                "PDC Cheque No." := TRAN_NO;
            end;
        }
        field(30020; "Ref No"; Code[30])
        {
        }
        field(50000; Select; Boolean)
        {
        }
        field(50001; "Sent to Bank"; Boolean)
        {
            Description = 'A Stage which captures that Cheque has been transffered to bank';
            Editable = true;
        }
        field(50002; "Bank deposit date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "PDC Status", "Account No.")
        {
            SumIndexFields = "PDC Amount";
        }
        key(Key3; "Bank Deposit Code", "Res Center", "Pay Slip No.")
        {
            SumIndexFields = "PDC Amount";
        }
        key(Key4; "PDC Cheque Date", "PDC Status", "Res Center", "Account Type", "Account No.")
        {
        }
        key(Key5; "PDC Cheque Date", "Account Type", "Account No.")
        {
        }
        key(Key6; "PDC Deposited", "Account No.")
        {
            SumIndexFields = "PDC Amount";
        }
        key(Key7; "PDC Amount")
        {
        }
        key(Key8; "Account Type", "PDC Deposited", "Account No.")
        {
            SumIndexFields = "PDC Amount";
        }
        key(Key9; "Account Type", "PDC Status", "Account No.")
        {
            SumIndexFields = "PDC Amount";
        }
        key(Key10; "Account Type", "Account No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TESTFIELD("PDC Status", "PDC Status"::Open);
        PDCAppln.RESET;
        PDCAppln.SETRANGE(PDCAppln."Entry No.", "Entry No.");
        IF PDCAppln.FIND('-') THEN
            PDCAppln.DELETEALL;
    end;

    trigger OnInsert()
    var
        DefDim: Record 352;
        GLSetup: Record 98;
        // UserSetup: Codeunit 5700;//tk
        RespCode: Code[10];
    begin
        "PDC Accepted By" := USERID;
        "PDC Received Date" := TODAY;
        "PDC Received Time" := TIME;
        "PDC DateTime" := CURRENTDATETIME;
        GLSetup.GET;

        //RespCode := UserSetup.GetSalesFilter;
        //IF RespCode <> '' THEN BEGIN
        //  VALIDATE("Res Center",RespCode);
        //END ELSE MESSAGE('Please manually enter the Res Center');

        /*
        Recusersetup.SETFILTER(Recusersetup."User ID",USERID);
        IF Recusersetup.FIND('-') THEN BEGIN
         IF NOT Recusersetup."Allow Payroll Module" THEN BEGIN
        IF Recusersetup."Customer Master" THEN BEGIN
        //"PDC Type" :="PDC Type"::VENDOR;
        "Account Type" :="Account Type"::Vendor;

         END
         ELSE
         IF Recusersetup."Super User" THEN
         "Account Type" :="Account Type"::Customer;
         END


         END
         ELSE
        */

    end;

    trigger OnModify()
    begin
        //TESTFIELD("PDC Status","PDC Status"::Open);
    end;

    trigger OnRename()
    begin
        ERROR('Not Allowed');
    end;

    var
        MICR: Record 50003;
        Text001: Label 'Please enter the details for MIRC Code %1';
        GLSetup: Record 98;
        Text002: Label 'The MICR code must have %1 characters. Please check.';
        Cust: Record 18;
        Vend: Record 23;
        CustLedgerEntry: Record 21;
        VendLedgerEntry: Record 25;
        Text003: Label 'You have not selected any transactions to apply. ';
        PDCAppln: Record 50005;
        Text004: Label 'This PDC Cheque is already applied. If you change the amount, all the application entries will be deleted and you will need to reapply. Do you want to continue?';
        Text005: Label 'PDC Amount is not changed. Please press Escape.';
        Text006: Label 'This will delete all the applications for this Cheque.\\ You can also unapply single application entry through Apply button. \\ Do you want to Unapply this cheque completely?';
        Text007: Label 'Please do not keep the PDC Received Date blank.';
        VenLedgerEntry: Record 25;
        recPDC: Record 50002;
        Recusersetup: Record 91;
        RsVendLedg: Record 25;
        CustomerLedger: Record 21;
        SalesSetup: Record 311;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        TEST: Code[10];
        SalesHeader: Record 50002;

    procedure FillBuffer()
    var
        PDCApplnBuffer: Record 50004;
        PDCAppln: Record 50005;
        PDCAvlblAmnt: Decimal;
        PDCApplnForm: Page 50005;
        PDCApplnBufferForm: Page 50004;
    begin
        CALCFIELDS("PDC Amount Applied");

        IF "PDC Amount" = 0 THEN
            EXIT;

        MESSAGE('Please Click OK button after selecting the entries');
        IF "Account Type" = "Account Type"::Customer THEN
            PDCAvlblAmnt := "PDC Amount" - "PDC Amount Applied"
        ELSE
            IF "Account Type" = "Account Type"::Vendor THEN
                PDCAvlblAmnt := ABS("PDC Amount") - ABS("PDC Amount Applied");

        IF PDCAvlblAmnt = 0 THEN BEGIN
            PDCAppln.RESET;
            PDCAppln.SETRANGE(PDCAppln."Entry No.", "Entry No.");
            PDCAppln.FIND('-');
            CLEAR(PDCApplnForm);
            PDCApplnForm.SETTABLEVIEW(PDCAppln);
            MESSAGE('This PDC is completely applied. Please check these Application entries');
            PDCApplnForm.RUNMODAL;
            EXIT;
        END;

        PDCApplnBuffer.LOCKTABLE;
        PDCApplnBuffer.RESET;
        PDCApplnBuffer.SETRANGE(PDCApplnBuffer."Document Type", "Entry No.");
        PDCApplnBuffer.DELETEALL;

        //Check For Customer/Vendor ++
        IF "Account Type" = "Account Type"::Customer THEN BEGIN
            CustLedgerEntry.RESET;
            CustLedgerEntry.SETRANGE("Customer No.", "Account No.");
            CustLedgerEntry.SETRANGE(Positive, TRUE);
            CustLedgerEntry.SETRANGE(Open, TRUE);
            IF CustLedgerEntry.FIND('-') THEN
                REPEAT
                    CustLedgerEntry.CALCFIELDS(Amount, "Remaining Amount", "PDC Unposted Amount");
                    IF CustLedgerEntry."Remaining Amount" > CustLedgerEntry."PDC Unposted Amount" THEN BEGIN
                        PDCApplnBuffer.INIT;
                        PDCApplnBuffer."Document Type" := "Entry No.";
                        //PDCApplnBuffer."Account Type" := "Account Type";//tk
                        PDCApplnBuffer."Cancel Reason" := CustLedgerEntry."Entry No.";
                        PDCApplnBuffer."Document Type" := CustLedgerEntry."Document Type";
                        PDCApplnBuffer."Document No." := CustLedgerEntry."Document No.";
                        // PDCApplnBuffer."Document Date" := CustLedgerEntry."Posting Date";
                        // PDCApplnBuffer."Due Date" := CustLedgerEntry."Due Date";
                        // PDCApplnBuffer."Customer No." := CustLedgerEntry."Customer No.";
                        // PDCApplnBuffer."Document Amount" := CustLedgerEntry.Amount;
                        // PDCApplnBuffer."Remaining Amount" := CustLedgerEntry."Remaining Amount";
                        // PDCApplnBuffer."PDC Unposted Amount" := CustLedgerEntry."PDC Unposted Amount";
                        // PDCApplnBuffer."Amount Available for Appln" := CustLedgerEntry."Remaining Amount" - CustLedgerEntry."PDC Unposted Amount";

                        // PDCApplnBuffer."PDC Amount Available" := PDCAvlblAmnt;//tk
                        PDCApplnBuffer.INSERT;
                    END;
                UNTIL CustLedgerEntry.NEXT = 0;
        END
        ELSE
            IF "Account Type" = "Account Type"::Vendor THEN BEGIN
                VenLedgerEntry.RESET;
                VenLedgerEntry.SETRANGE("Vendor No.", "Account No.");
                VenLedgerEntry.SETRANGE(Positive, FALSE);
                VenLedgerEntry.SETRANGE(Open, TRUE);
                IF VenLedgerEntry.FIND('-') THEN
                    REPEAT

                        VenLedgerEntry.CALCFIELDS(Amount, "Remaining Amount", "PDC Unposted Amount");
                        IF -(VenLedgerEntry."Remaining Amount") > VendLedgerEntry."PDC Unposted Amount" THEN BEGIN
                            PDCApplnBuffer.INIT;
                            PDCApplnBuffer."Document Type" := "Entry No.";
                            ////tk PDCApplnBuffer."Account Type" := "Account Type";
                            // PDCApplnBuffer."Vend Ledger Entry No." := VenLedgerEntry."Entry No.";


                            PDCApplnBuffer."Cancel Reason" := VenLedgerEntry."Entry No.";
                            PDCApplnBuffer."Document Type" := VenLedgerEntry."Document Type";
                            PDCApplnBuffer."Document No." := VenLedgerEntry."Document No.";
                            //TK
                            // PDCApplnBuffer."Document Date" := VenLedgerEntry."Posting Date";
                            // PDCApplnBuffer."Due Date" := VenLedgerEntry."Due Date";
                            // PDCApplnBuffer."Customer No." := VenLedgerEntry."Vendor No.";
                            // PDCApplnBuffer."Document Amount" := VenLedgerEntry.Amount;
                            // PDCApplnBuffer."Remaining Amount" := VenLedgerEntry."Remaining Amount";
                            // PDCApplnBuffer."External Document No." := VendLedgerEntry."External Document No.";
                            // PDCApplnBuffer."PDC Unposted Amount" := VenLedgerEntry."PDC Unposted Amount";
                            // PDCApplnBuffer."Amount Available for Appln" := VenLedgerEntry."Remaining Amount" -
                            //VenLedgerEntry."PDC Unposted Amount";//tk
                            //PDCApplnBuffer."PDC Amount Available" := PDCAvlblAmnt;//tk
                            PDCApplnBuffer.INSERT;
                        END;
                    UNTIL VenLedgerEntry.NEXT = 0;
            END;

        //Check For Customer/Vendor --

        IF PDCApplnBuffer.ISEMPTY THEN BEGIN
            MESSAGE('There are no transactions for application');
            EXIT;
        END;

        COMMIT;

        CLEAR(PDCApplnBufferForm);
        PDCApplnBufferForm.SETTABLEVIEW(PDCApplnBuffer);
        PDCApplnBufferForm.LOOKUPMODE := TRUE;

        IF PDCApplnBufferForm.RUNMODAL IN [ACTION::OK, ACTION::LookupOK] THEN BEGIN
            // PDCApplnBuffer.SETRANGE(PDCApplnBuffer.Apply, TRUE);//tk

            // IF "Account Type" = "Account Type"::Customer THEN
            //    // PDCApplnBuffer.SETFILTER(PDCApplnBuffer."Amount to Apply", '>0')//tk
            // ELSE
            //     IF "Account Type" = "Account Type"::Vendor THEN
            //         PDCApplnBuffer.SETFILTER(PDCApplnBuffer."Amount to Apply", '<0');//tk

            IF PDCApplnBuffer.FIND('-') THEN BEGIN
                PDCAppln.LOCKTABLE;
                REPEAT
                    IF PDCAppln.GET(PDCApplnBuffer."Document Type", PDCApplnBuffer."Cancel Reason") THEN BEGIN
                        //PDCAppln."Document Type1" += PDCApplnBuffer."Amount to Apply";//tk
                        PDCAppln.MODIFY;
                    END ELSE BEGIN
                        PDCAppln.INIT;
                        PDCAppln."Entry No." := PDCApplnBuffer."Document Type";
                        //PDCAppln."Account Type" := PDCApplnBuffer."Account Type";//tk
                        //IF "Account Type"="Account Type"::Customer THEN
                        //PDCAppln."Cust Ledger Entry No." := PDCApplnBuffer."Cancel Reason";//tk
                        //ELSE
                        //  PDCAppln."Vend Ledger Entry No." := PDCApplnBuffer."Vend Ledger Entry No.";
                        // PDCAppln."Document No.1" := PDCApplnBuffer."Customer No.";
                        // PDCAppln."Document Type1" := PDCApplnBuffer."Amount to Apply";
                        // PDCAppln.Message1 := PDCApplnBuffer."Document Type";
                        // PDCAppln."Remaining Amount" := PDCApplnBuffer."Document No.";
                        // PDCAppln."PDC Unposted Amount" := PDCApplnBuffer."Document Date";
                        // PDCAppln."Due Date" := PDCApplnBuffer."Due Date";//tk
                        PDCAppln.INSERT;
                    END;
                UNTIL PDCApplnBuffer.NEXT = 0;
                "PDC Applied By" := USERID;
            END ELSE BEGIN
                // PDCApplnBuffer.SETRANGE(PDCApplnBuffer.Apply, TRUE);//tk
                PDCApplnBuffer.DELETEALL;
                ERROR(Text003);
            END;
        END ELSE BEGIN
            PDCApplnBuffer.RESET;
            PDCApplnBuffer.SETRANGE(PDCApplnBuffer."Document Type", "Entry No.");
            PDCApplnBuffer.DELETEALL;
            ERROR(Text003);
        END;
    end;

    procedure DelAppln()
    begin
        IF NOT CONFIRM(Text006) THEN
            EXIT;

        PDCAppln.RESET;
        PDCAppln.SETRANGE(PDCAppln."Entry No.", "Entry No.");
        IF PDCAppln.FIND('-') THEN
            PDCAppln.DELETEALL;
    end;

    procedure AssistEdit(OldSalesHeader: Record 50002): Boolean
    begin

        SalesHeader.COPY(Rec);
        SalesSetup.GET;
        // TestNoSeries;
        IF NoSeriesMgt.SelectSeries(SalesSetup."Posted Prepmt. Inv. Nos.", OldSalesHeader.RTGS_NO, SalesHeader.RTGS_NO) THEN BEGIN
            NoSeriesMgt.SetSeries(SalesHeader.RTGS_NO);

            Rec := SalesHeader;
            EXIT(TRUE);
        END;


        /*
       WITH SalesHeader DO BEGIN
         COPY(Rec);
         SalesSetup.GET;
        // TestNoSeries;
         IF NoSeriesMgt.SelectSeries(SalesSetup."Third Party Nos.",OldSalesHeader.NEFT_NO,NEFT_NO) THEN BEGIN
              NoSeriesMgt.SetSeries(NEFT_NO);

            Rec:=SalesHeader;
            EXIT(TRUE);
           END;
            END;


       WITH SalesHeader DO BEGIN
         COPY(Rec);
         SalesSetup.GET;
        // TestNoSeries;
         IF NoSeriesMgt.SelectSeries(SalesSetup."Posted Prepmt. Inv. Nos.",OldSalesHeader.TRAN_NO,TRAN_NO) THEN BEGIN
              NoSeriesMgt.SetSeries(TRAN_NO);

            Rec:=SalesHeader;
            EXIT(TRUE);
           END;
            END;
         */

    end;

    procedure AssistEdit1(OldSalesHeader: Record 50002): Boolean
    begin
        SalesHeader.COPY(Rec);
        SalesSetup.GET;
        // TestNoSeries;
        // IF NoSeriesMgt.SelectSeries(SalesSetup."Third Party Nos.", OldSalesHeader.NEFT_NO, NEFT_NO) THEN BEGIN
        //     NoSeriesMgt.SetSeries(NEFT_NO);//tk

        Rec := SalesHeader;
        EXIT(TRUE);
    END;
    // end;//tk

    procedure AssistEdit2(OldSalesHeader: Record 50002): Boolean
    begin
        SalesHeader.COPY(Rec);
        SalesSetup.GET;
        // TestNoSeries;
        IF NoSeriesMgt.SelectSeries(SalesSetup."Posted Prepmt. Cr. Memo Nos.", OldSalesHeader.TRAN_NO, SalesHeader.TRAN_NO) THEN BEGIN
            NoSeriesMgt.SetSeries(SalesHeader.TRAN_NO);

            Rec := SalesHeader;
            EXIT(TRUE);
        END;
    end;
}

