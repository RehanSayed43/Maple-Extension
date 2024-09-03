table 50007 "Denomination Entry"
{

    fields
    {
        field(1; DenominationNo; Code[10])
        {
        }
        field(2; "Dinomination Date"; Date)
        {

            trigger OnValidate()
            begin
                IF TransType = TransType::CreditCard THEN BEGIN
                    IF ChkduplicateCreditEntry(TransType, "Dinomination Date", "Credit CD Bank AC", Branch) THEN
                        ERROR('Payment Entry already done for Branch %1 Account %2 for %3', Branch, "Credit CD Bank AC", "Dinomination Date");
                    IF ("Dinomination Date" <> 0D) AND ("Dinomination Date" <> xRec."Dinomination Date") THEN
                        VALIDATE("Credit CD Bank AC");

                END
                ELSE BEGIN
                    IF ChkduplicateDate(TransType, "Dinomination Date", Branch) THEN
                        ERROR('Denimination Entry already done for Branch %1 for %2', Branch, "Dinomination Date");
                END;
                //ELSE
                //  DisplayFields(TransType,"Dinomination Date");
            end;
        }
        field(3; Branch; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('BRANCH'));//tk

            trigger OnLookup()
            var
                DimValue: Record 349;
                UserSetup: Record 91;
                DefDimension: Record 352;
            begin

                UserSetup.GET(USERID);
                UserSetup.TESTFIELD("Sales Resp. Ctr. Filter");
                DefDimension.GET(50000, UserSetup."Sales Resp. Ctr. Filter", 'BRANCH');

                DimValue.RESET;
                DimValue.SETFILTER("Dimension Code", '%1', 'BRANCH');
                DimValue.SETFILTER(Code, '%1', DefDimension."Dimension Value Code");
                IF PAGE.RUNMODAL(537, DimValue) = ACTION::LookupOK THEN BEGIN
                    VALIDATE(Branch, DimValue.Code);
                    IF (TransType = TransType::CreditCard) AND (Branch <> '') THEN BEGIN
                        IF NOT "Document Posted" THEN BEGIN
                            GLSetup.GET;
                            GLSetup.TESTFIELD(GLSetup."Cash Account");
                            "G/L Cash Ac" := GLSetup."Cash Account";
                            MESSAGE('CASH A/C %1', "G/L Cash Ac");
                            GLAc.RESET;
                            GLAc.SETRANGE("No.", "G/L Cash Ac");
                            GLAc.SETFILTER("Global Dimension 1 Filter", '%1', Branch);
                            GLAc.SETRANGE("Date Filter", 0D, CALCDATE('-1D', "Dinomination Date"));
                            IF GLAc.FINDFIRST THEN;
                            GLAc.CALCFIELDS("Balance at Date");
                            PreClosingAmt := GLAc."Balance at Date";
                            MESSAGE('BALANCE %1', PreClosingAmt);
                            GLAc.RESET;
                            GLAc.SETFILTER("No.", '%1', "G/L Cash Ac");
                            GLAc.SETFILTER("Global Dimension 1 Filter", Branch);
                            GLAc.SETRANGE("Date Filter", 0D, "Dinomination Date");
                            IF GLAc.FINDFIRST THEN;
                            GLAc.CALCFIELDS("Net Change");

                            "Closing Balance" := PreClosingAmt + GLAc."Net Change";
                            //CurrPage.UPDATE;
                        END;//tk
                    END;

                END;
            end;

            trigger OnValidate()
            var
                DenoEntry: Record 50007;
            begin
                IF Branch <> xRec.Branch THEN BEGIN
                    IF TransType = TransType::CreditCard THEN BEGIN
                        //DenoEntry := Rec;
                        VALIDATE("Credit CD Bank AC");//tk
                                                      //UpdateBalance(DenominationNo,'',0,Branch);
                                                      //Rec := DenoEntry;
                    END;
                    IF TransType = TransType::CreditCard THEN BEGIN
                        IF ChkduplicateCreditEntry(TransType, "Dinomination Date", "Credit CD Bank AC", Branch) THEN
                            ERROR('Payment Entry already done for Branch %1 Account %2 for %3', Branch, "Credit CD Bank AC", "Dinomination Date");
                        IF ("Dinomination Date" <> 0D) AND ("Dinomination Date" <> xRec."Dinomination Date") THEN
                            VALIDATE("Credit CD Bank AC");

                    END
                    ELSE BEGIN
                        IF ChkduplicateDate(TransType, "Dinomination Date", Branch) THEN
                            ERROR('Denimination Entry already done for Branch %1 for %2', Branch, "Dinomination Date");
                    END;
                END;//tk
            end;
        }
        field(4; Denomination; Integer)
        {

            trigger OnValidate()
            begin
                VALIDATE(Amount, Quantity * Denomination);
            end;
        }
        field(5; Quantity; Integer)
        {
            MinValue = 0;

            trigger OnValidate()
            begin
                //VALIDATE(Amount,Quantity *  Denomination);
                IF Quantity < 0 THEN BEGIN
                    MESSAGE('Negative Quantity not allowed');
                    Quantity := 0;
                END;
            end;
        }
        field(6; Amount; Decimal)
        {
            MinValue = 0;

            trigger OnValidate()
            begin
                IF Amount < 0 THEN BEGIN
                    MESSAGE('Negative Amount not allowed');
                    Amount := 0;
                END;
            end;
        }
        field(7; "Entry Date"; Date)
        {
        }
        field(8; Total; Decimal)
        {
            FieldClass = Normal;

            trigger OnValidate()
            begin
                TotalAmt := D1000 + D500 + D100 + D50 + D20 + D10 + D5 + D2 + D1 + COINS;
                // WBU.RefreshPage();
            end;
        }
        field(9; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(10; TotalAmt; Decimal)
        {
            MinValue = 0;

            trigger OnValidate()
            begin
                //TotalAmt := D1000 + D500 + D100 + D50 + D20 + D10 + D5 + D2 + D1 + COINS ;
                //WBU.RefreshPage();
            end;
        }
        field(11; "Machine Name"; Code[20])
        {

            trigger OnLookup()
            var
                PaymentMethod: Record 289;
            begin
                TESTFIELD("Credit CD Bank AC");
                CRMachineCode.RESET;
                CRMachineCode.SETFILTER("Credit Card Machine", '%1', TRUE);
                IF PAGE.RUNMODAL(50052, CRMachineCode) = ACTION::LookupOK THEN BEGIN
                    PaymentMethod.SETFILTER("Bal. Account No.", '%1', "Credit CD Bank AC");
                    PaymentMethod.SETFILTER("Credit card Machine Code", '%1', CRMachineCode."Credit Cd Machine Code");
                    IF NOT PaymentMethod.ISEMPTY THEN
                        "Machine Name" := CRMachineCode."Credit Cd Machine Code"
                    ELSE
                        ERROR('Machine Name %1 with Account Code %2 not found in Payment Methods', CRMachineCode."Credit Cd Machine Code", "Credit CD Bank AC");
                END;//tk
            end;
        }
        field(12; "TID No"; Code[10])
        {
            TableRelation = "Standard Text"."TID NO" WHERE("TID" = CONST(True));

            trigger OnLookup()
            begin
                TESTFIELD("Machine Name");
                CRMachineCode.RESET;
                CRMachineCode.SETFILTER(TID, '%1', TRUE);
                CRMachineCode.SETFILTER("Credit Cd Machine Code", '%1', "Machine Name");
                IF PAGE.RUNMODAL(50051, CRMachineCode) = ACTION::LookupOK THEN BEGIN
                    "TID No" := CRMachineCode."TID NO";
                END;//tk
            end;
        }
        field(13; CreditCardAmt; Decimal)
        {
            MinValue = 0;

            trigger OnValidate()
            begin
                IF CreditCardAmt < 0 THEN BEGIN
                    MESSAGE('Negative Amount not allowed');
                    CreditCardAmt := 0;
                END;
            end;
        }
        field(14; TransType; Option)
        {
            OptionCaption = 'Denomination,CreditCard';
            OptionMembers = Denomination,CreditCard;
        }
        field(15; TotalCreditAmt; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Denomination Entry".CreditCardAmt WHERE(Branch = FIELD(Branch),
                                                                        "Dinomination Date" = FIELD("Date Filter"),
                                                                        "Credit CD Bank AC" = FIELD("Credit CD Bank AC"),
                                                                        DenominationNo = FIELD(DenominationNo)));

            MinValue = 0;
        }
        field(16; EntryUserID; Code[20])
        {
        }
        field(17; Remarks; Text[250])
        {

            trigger OnValidate()
            var
                DenoEntry: Record 50007;
            begin
                IF (Remarks <> '') AND (TransType = TransType::CreditCard) THEN BEGIN
                    DenoEntry.SETFILTER(TransType, '%1', TransType::CreditCard);
                    DenoEntry.SETFILTER(DenominationNo, '%1', DenominationNo);
                    IF DenoEntry.FINDFIRST THEN BEGIN
                        REPEAT
                            DenoEntry.Remarks := Remarks;
                            DenoEntry.MODIFY;
                        UNTIL DenoEntry.NEXT = 0;
                    END;
                    // WBU.RefreshPage();//tk
                END;
            end;
        }
        field(18; D1000; Decimal)
        {
            DecimalPlaces = 0 : 0;
            MinValue = 0;

            trigger OnValidate()
            begin
                TotalAmt := (D1000 * 1000) + (D500 * 500) + (D100 * 100) + (D50 * 50) + (D20 * 20) + (D10 * 10) + (D5 * 5) + (D2 * 2) + D1 + COINS;
            end;
        }
        field(19; D500; Decimal)
        {
            DecimalPlaces = 0 : 0;
            // MaxValue = 99.999.999;//tk
            MinValue = 0;

            trigger OnValidate()
            begin
                TotalAmt := (D1000 * 1000) + (D500 * 500) + (D100 * 100) + (D50 * 50) + (D20 * 20) + (D10 * 10) + (D5 * 5) + (D2 * 2) + D1 + COINS;
            end;
        }
        field(20; D100; Decimal)
        {
            DecimalPlaces = 0 : 0;
            MinValue = 0;

            trigger OnValidate()
            begin
                TotalAmt := (D1000 * 1000) + (D500 * 500) + (D100 * 100) + (D50 * 50) + (D20 * 20) + (D10 * 10) + (D5 * 5) + (D2 * 2) + D1 + COINS;
            end;
        }
        field(21; D50; Decimal)
        {
            DecimalPlaces = 0 : 0;
            MinValue = 0;

            trigger OnValidate()
            begin
                TotalAmt := (D1000 * 1000) + (D500 * 500) + (D100 * 100) + (D50 * 50) + (D20 * 20) + (D10 * 10) + (D5 * 5) + (D2 * 2) + D1 + COINS;
            end;
        }
        field(22; D20; Decimal)
        {
            DecimalPlaces = 0 : 0;
            MinValue = 0;

            trigger OnValidate()
            begin
                TotalAmt := (D1000 * 1000) + (D500 * 500) + (D100 * 100) + (D50 * 50) + (D20 * 20) + (D10 * 10) + (D5 * 5) + (D2 * 2) + D1 + COINS;
            end;
        }
        field(23; D10; Decimal)
        {
            DecimalPlaces = 0 : 0;
            MinValue = 0;

            trigger OnValidate()
            begin
                TotalAmt := (D1000 * 1000) + (D500 * 500) + (D100 * 100) + (D50 * 50) + (D20 * 20) + (D10 * 10) + (D5 * 5) + (D2 * 2) + D1 + COINS;
            end;
        }
        field(24; D5; Decimal)
        {
            DecimalPlaces = 0 : 0;
            MinValue = 0;

            trigger OnValidate()
            begin
                TotalAmt := (D1000 * 1000) + (D500 * 500) + (D100 * 100) + (D50 * 50) + (D20 * 20) + (D10 * 10) + (D5 * 5) + (D2 * 2) + D1 + COINS;
            end;
        }
        field(25; D2; Decimal)
        {
            DecimalPlaces = 0 : 0;
            MinValue = 0;

            trigger OnValidate()
            begin
                TotalAmt := (D1000 * 1000) + (D500 * 500) + (D100 * 100) + (D50 * 50) + (D20 * 20) + (D10 * 10) + (D5 * 5) + (D2 * 2) + D1 + COINS;
            end;
        }
        field(26; D1; Decimal)
        {
            DecimalPlaces = 0 : 0;
            MinValue = 0;

            trigger OnValidate()
            begin
                TotalAmt := (D1000 * 1000) + (D500 * 500) + (D100 * 100) + (D50 * 50) + (D20 * 20) + (D10 * 10) + (D5 * 5) + (D2 * 2) + D1 + COINS;
            end;
        }
        field(27; COINS; Decimal)
        {
            MinValue = 0;

            trigger OnValidate()
            begin
                TotalAmt := (D1000 * 1000) + (D500 * 500) + (D100 * 100) + (D50 * 50) + (D20 * 20) + (D10 * 10) + (D5 * 5) + (D2 * 2) + D1 + COINS;
            end;
        }
        field(107; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(108; "Closing Balance"; Decimal)
        {
            FieldClass = Normal;
            TableRelation = "G/L Account"."Net Change" WHERE("No." = FIELD("G/L Cash Ac"));
        }
        field(109; "Document Posted"; Boolean)
        {
        }
        field(110; "Amount Posted"; Decimal)
        {
        }
        field(111; "G/L Cash Ac"; Code[10])
        {
            TableRelation = "G/L Account"."No." WHERE("Global Dimension 1 Code" = FIELD(Branch));
        }
        field(112; Posted; Boolean)
        {
        }
        field(113; "Location Code"; Code[10])
        {
            TableRelation = Location;
        }
        field(114; LocationFilter; Code[10])
        {
        }
        field(50012; "Credit CD Bank AC"; Code[20])
        {
            TableRelation = "Payment Method"."Bal. Account No." WHERE("Credit card Machine Code" = FIELD("Machine Name"));

            trigger OnLookup()
            begin
                //TESTFIELD("Machine Name");
                PaymentMethod.RESET;
                PaymentMethod.SETFILTER(PaymentMethod."Credit card Machine Code", '<>%1', '');
                //PaymentMethod.SETFILTER(PaymentMethod."Branch Code",'%1',Branch);
                IF PAGE.RUNMODAL(427, PaymentMethod) = ACTION::LookupOK THEN BEGIN
                    "Credit CD Bank AC" := PaymentMethod."Bal. Account No.";
                    IF "Credit CD Bank AC" <> '' THEN BEGIN
                        IF ChkduplicateCreditEntry(TransType, "Dinomination Date", "Credit CD Bank AC", Branch) THEN
                            ERROR('Payment Entry already done for Branch %1 Account %2 for %3', Branch, "Credit CD Bank AC", "Dinomination Date");

                        GLAc.RESET;
                        GLAc.SETFILTER("No.", '%1', "Credit CD Bank AC");
                        GLAc.SETFILTER(GLAc."Global Dimension 1 Filter", Branch);
                        GLAc.SETFILTER("Date Filter", '%1', CALCDATE('-1D', "Dinomination Date"));
                        GLAc.FINDFIRST;
                        GLAc.CALCFIELDS("Balance at Date");
                        PreBalance := GLAc."Balance at Date";

                        GLAc.RESET;
                        GLAc.SETFILTER("No.", '%1', "Credit CD Bank AC");
                        GLAc.SETFILTER(GLAc."Global Dimension 1 Filter", Branch);
                        GLAc.SETFILTER("Date Filter", '%1', "Dinomination Date");
                        GLAc.FINDFIRST;
                        GLAc.CALCFIELDS("Net Change");
                        "Closing Balance" := PreBalance + GLAc."Net Change";
                        UpdateBalance(DenominationNo, "Credit CD Bank AC", "Closing Balance", Branch);
                    END;
                END;
            end;

            trigger OnValidate()
            begin
                IF "Credit CD Bank AC" <> '' THEN BEGIN
                    IF ChkduplicateCreditEntry(TransType, "Dinomination Date", "Credit CD Bank AC", Branch) THEN
                        ERROR('Payment Entry already done for Branch %1 Account %2 for %3', Branch, "Credit CD Bank AC", "Dinomination Date");

                    GLAc.RESET;
                    GLAc.SETFILTER("No.", '%1', "Credit CD Bank AC");
                    GLAc.SETFILTER(GLAc."Global Dimension 1 Filter", Branch);
                    GLAc.SETFILTER("Date Filter", '%1', CALCDATE('-1D', "Dinomination Date"));
                    GLAc.FINDFIRST;
                    GLAc.CALCFIELDS("Balance at Date");
                    PreBalance := GLAc."Balance at Date";

                    GLAc.RESET;
                    GLAc.SETFILTER("No.", '%1', "Credit CD Bank AC");
                    GLAc.SETFILTER(GLAc."Global Dimension 1 Filter", Branch);
                    GLAc.SETFILTER("Date Filter", '%1', "Dinomination Date");
                    GLAc.FINDFIRST;
                    GLAc.CALCFIELDS("Net Change");
                    "Closing Balance" := PreBalance + GLAc."Net Change";
                    UpdateBalance(DenominationNo, "Credit CD Bank AC", "Closing Balance", Branch);
                END;
            end;
        }
        field(50013; LineNo; Integer)
        {
        }
    }

    keys
    {
        key(Key1; TransType, DenominationNo, LineNo)
        {
        }
        key(Key2; TransType, Branch, "Dinomination Date")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        DenoLocal: Record 50007;
    begin
        IF NOT "Document Posted" THEN BEGIN
            DenoLocal.SETFILTER(DenominationNo, '%1', DenominationNo);
            DenoLocal.DELETEALL;
        END
        ELSE
            MESSAGE('Document already posted can not delete');
    end;

    trigger OnInsert()
    begin
        IF DenominationNo = '' THEN BEGIN
            //TestNoSeries;
            GLSetup.GET;
            IF TransType = TransType::Denomination THEN BEGIN
                GLSetup.TESTFIELD(GLSetup."Denomination Nos");
                DenoNoSeries := GLSetup."Denomination Nos";
            END;
            IF TransType = TransType::CreditCard THEN BEGIN
                GLSetup.TESTFIELD(GLSetup."Daily Currency Nos");
                DenoNoSeries := GLSetup."Daily Currency Nos";
            END;
            IF DenoNoSeries = '' THEN
                ERROR('No. Series not defined');
            NoSeriesMgt.InitSeries(DenoNoSeries, xRec."No. Series", WORKDATE, DenominationNo, "No. Series");

        END;
        DenoNumber := DenominationNo;
        UserSetup.GET(USERID);
        UserSetup.TESTFIELD(UserSetup."Location Code");
        "Location Code" := UserSetup."Location Code";
        Branch := UserSetup."Service Resp. Ctr. Filter";
        //SETFILTER(DenominationNo,DenoNumber);
    end;

    var
        CRMachineCode: Record 7;
        //WBU: Codeunit 50000;//tk
        GLSetup: Record 98;
        DenoNoSeries: Code[10];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UserSetup: Record 91;
        PaymentMethod: Record 289;
        GLAc: Record 15;
        PreBalance: Decimal;
        DenoNumber: Code[10];
        PreClosingAmt: Decimal;

    procedure GetEntryNo(): Integer
    var
        EntNo: Integer;
    begin
        /*
         RESET;
        IF FINDLAST THEN
          EntNo := DenoNo + 1
        ELSE
         EntNo := 1;
       EXIT(EntNo);
       */

    end;

    procedure CalAmount(): Decimal
    var
        Total: Decimal;
        DenominationLocal: Record 50007;
    begin
        DenominationLocal.RESET;
        IF DenominationLocal.FINDFIRST THEN
            REPEAT
                Total := Total + DenominationLocal.Amount;
            UNTIL DenominationLocal.NEXT = 0;
        DenominationLocal.RESET;
        IF DenominationLocal.FINDFIRST THEN
            REPEAT
                TotalAmt := Total;
            UNTIL DenominationLocal.NEXT = 0;
        EXIT(Total);
    end;

    procedure MakeDenominationEntry(DenominationBranch: Text[20]; DenominationDate: Date; DenominationValue: Integer)
    var
        DenominationEntryLocal: Record 50007;
    begin
        DenominationEntryLocal.INIT;
        // DenominationEntryLocal.DenoNo := GetEntryNo;
        //MESSAGE(FORMAT(EntryNo));
        DenominationEntryLocal.TransType := DenominationEntryLocal.TransType::Denomination;
        DenominationEntryLocal.Branch := DenominationBranch;
        DenominationEntryLocal."Dinomination Date" := DenominationDate;
        DenominationEntryLocal.Denomination := DenominationValue;
        DenominationEntryLocal.EntryUserID := EntryUserID;
        DenominationEntryLocal.INSERT;
    end;

    procedure InserCreditCdPayment(Branch: Text[20]; EntryDate: Date)
    var
        MachineNameRec: Record 7;
        DenominationEntryLocal: Record 50007;
    begin
        SETRANGE(TransType, TransType::CreditCard);
        // SETFILTER(Branch ,'%1',Branch);//tk
        SETFILTER("Dinomination Date", '%1', EntryDate);
        IF ISEMPTY THEN BEGIN
            RESET;
            MachineNameRec.RESET;
            MachineNameRec.SETFILTER("Credit Cd Machine Code", '<>%1', '');
            IF MachineNameRec.FINDFIRST THEN BEGIN
                REPEAT
                    DenominationEntryLocal.INIT;
                    // DenominationEntryLocal.DenoNo := GetEntryNo;
                    DenominationEntryLocal.TransType := DenominationEntryLocal.TransType::CreditCard;
                    DenominationEntryLocal.Branch := Branch;
                    DenominationEntryLocal."Machine Name" := MachineNameRec."Credit Cd Machine Code";
                    DenominationEntryLocal."Dinomination Date" := EntryDate;
                    DenominationEntryLocal.EntryUserID := EntryUserID;
                    DenominationEntryLocal.INSERT;
                UNTIL MachineNameRec.NEXT = 0;
            END;
        END;
    end;

    procedure ChkduplicateDate("Transaction Type": Option Denomination,CreditCard; CurDate: Date; Brch: Code[10]): Boolean
    var
        DenominationEntry: Record 50007;
    begin
        IF TransType = TransType::CreditCard THEN
            EXIT(TRUE);
        IF Brch = '' THEN
            EXIT;
        IF CurDate = 0D THEN
            EXIT;

        DenominationEntry.RESET;
        DenominationEntry.SETRANGE(TransType, "Transaction Type");
        DenominationEntry.SETFILTER("Dinomination Date", '%1', CurDate);
        DenominationEntry.SETFILTER(Branch, '%1', Brch);
        DenominationEntry.SETFILTER(DenominationNo, '<>%1', DenominationNo);
        EXIT(NOT DenominationEntry.ISEMPTY);
    end;

    procedure DisplayFields("Transaction Type": Option Denomination,CreditCard; CurDate: Date)
    begin
    end;

    procedure UpdateBalance(DenoNo: Code[20]; CreditCdAc: Code[20]; ClosingAmt: Decimal; Brch: Code[10])
    var
        DenoEntry: Record 50007;
    begin
        DenoEntry.SETFILTER(TransType, '%1', TransType::CreditCard);
        DenoEntry.SETFILTER(DenominationNo, '%1', DenoNo);
        IF DenoEntry.FINDFIRST THEN BEGIN
            REPEAT
                DenoEntry."Credit CD Bank AC" := CreditCdAc;
                DenoEntry."Closing Balance" := ClosingAmt;
                DenoEntry.Branch := Brch;
                IF LineNo <> DenoEntry.LineNo THEN
                    DenoEntry.MODIFY;
            UNTIL DenoEntry.NEXT = 0;
        END;
        //CurrPage.UPDATE;
        //WBU.RefreshPage();//tk
    end;

    procedure ChkduplicateCreditEntry("Transaction Type": Option Denomination,CreditCard; CurDate: Date; CreditCdAc: Code[20]; Brch: Code[10]): Boolean
    var
        DenominationEntry: Record 50007;
    begin
        IF CurDate = 0D THEN
            EXIT;
        IF CreditCdAc = '' THEN
            EXIT;
        IF Brch = '' THEN
            EXIT;
        DenominationEntry.RESET;
        DenominationEntry.SETRANGE(TransType, "Transaction Type");
        DenominationEntry.SETFILTER("Dinomination Date", '%1', CurDate);
        DenominationEntry.SETFILTER("Credit CD Bank AC", '%1', CreditCdAc);
        DenominationEntry.SETFILTER(Branch, '%1', Brch);
        DenominationEntry.SETFILTER(DenominationNo, '<>%1', DenominationNo);
        EXIT(NOT DenominationEntry.ISEMPTY);
    end;
}

