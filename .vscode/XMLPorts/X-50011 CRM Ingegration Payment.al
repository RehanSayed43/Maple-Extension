xmlport 50011 "CRM Ingegration Payment"
{
    Format = VariableText;
    Permissions =;

    schema
    {
        textelement(Root)
        {
            tableelement("CRM Payment Integration"; "CRM Payment Integration")
            {
                XmlName = 'CRM_Integration_Payment';
                fieldelement(CustomerNo; "CRM Payment Integration"."CRM Customer No.")
                {
                }
                fieldelement(Name; "CRM Payment Integration".Name)
                {
                }
                fieldelement(Address; "CRM Payment Integration".Address)
                {
                }
                fieldelement(City; "CRM Payment Integration".City)
                {
                }
                fieldelement(State_Code; "CRM Payment Integration"."State Code")
                {
                }
                fieldelement(Phone_no; "CRM Payment Integration"."Phone No.")
                {
                }
                fieldelement(Narration; "CRM Payment Integration".Narration)
                {
                }
                fieldelement(Accounttype; "CRM Payment Integration"."Account Type")
                {
                }
                fieldelement(Amount; "CRM Payment Integration".Amount)
                {
                }
                fieldelement(accno; "CRM Payment Integration"."GL Account No.")
                {
                }
                fieldelement(Dim1; "CRM Payment Integration"."Shortcut Dimension 1 Code")
                {
                }
                fieldelement(Dim2; "CRM Payment Integration"."Shortcut Dimension 2 Code")
                {
                }
                fieldelement(PostingDate; "CRM Payment Integration"."Posting Date")
                {
                }
                fieldelement(LocCode; "CRM Payment Integration"."Location Code")
                {
                }
                fieldelement(GSTGroupCode; "CRM Payment Integration"."GST Group Code")
                {
                }
                fieldelement(HSNHAC; "CRM Payment Integration"."HSN/SAC Code")
                {
                }
                fieldelement(gstregno; "CRM Payment Integration"."GST Registration No.")
                {
                }
                fieldelement(gstregtype; "CRM Payment Integration"."GST Registration Type")
                {
                }
                fieldelement(gstcusttype; "CRM Payment Integration"."GST Customer Type")
                {

                    trigger OnAfterAssignField()
                    begin
                        CreateCustomer("CRM Payment Integration"."Phone No.");
                    end;
                }
                fieldelement(ExternalDocno; "CRM Payment Integration"."External Doc No.")
                {
                }
                fieldelement(Accno1; "CRM Payment Integration"."GL Account No.1")
                {
                    MinOccurs = Zero;
                }
                fieldelement(amount1; "CRM Payment Integration".Amount1)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Narration1; "CRM Payment Integration".Narration1)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Accno2; "CRM Payment Integration"."GL Account No.2")
                {
                    MinOccurs = Zero;
                }
                fieldelement(amount2; "CRM Payment Integration".Amount2)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Narration2; "CRM Payment Integration".Narration2)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Accno3; "CRM Payment Integration"."GL Account No.3")
                {
                    MinOccurs = Zero;
                }
                fieldelement(amount3; "CRM Payment Integration".Amount3)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Narration3; "CRM Payment Integration".Narration3)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Accno4; "CRM Payment Integration"."GL Account No.4")
                {
                    MinOccurs = Zero;
                }
                fieldelement(amount4; "CRM Payment Integration".Amount4)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Narration4; "CRM Payment Integration".Narration4)
                {
                    MinOccurs = Zero;
                }

                trigger OnAfterInsertRecord()
                begin
                    //PaymentRep.RUN;

                    /*
                    IF NOT "CRM Payment Integration"."CRM Payment Cteated" THEN
                      REPEAT
                    
                    UNTIL "CRM Payment Integration".NEXT=0;
                     */
                    PostPayment;

                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnPostXmlPort()
    begin
        RecGenJnlLine.RESET;
        RecGenJnlLine.SETRANGE(RecGenJnlLine."Journal Template Name", 'GENERAL1');
        RecGenJnlLine.SETRANGE(RecGenJnlLine."Journal Batch Name", 'SERVICE');
        IF RecGenJnlLine.FINDSET THEN
            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", RecGenJnlLine);

        //CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",RecGenJnlLine);
    end;

    var
        RecCustomer: Record 18;
        SRsetup: Record 311;
        custno: Code[20];
        NoSeriesMgt: Codeunit 396;
        RecCust: Record 18;
        RecGenJnlLine: Record 81;
        line_no: Integer;
        DoucNo: Code[20];
        PaymentRep: Report 50048;
        RecDim: Record 480;
        DimMgt: Codeunit 408;
        DimVal: Record 349;
        TempDimSetEntry: Record 480 temporary;


    procedure CreateCustomer("Mobile No.": Code[20])
    begin
        IF NOT "CRM Payment Integration"."Customer Created" THEN BEGIN
            CLEAR(RecCustomer."GST Registration No.");
            CLEAR(RecCustomer.Address);
            CLEAR(RecCustomer."Address 2");
            RecCustomer.RESET;
            RecCustomer.SETRANGE(RecCustomer."CRM Mobile No.", "CRM Payment Integration"."Phone No.");
            IF NOT RecCustomer.FINDFIRST THEN BEGIN
                SRsetup.GET;
                custno := NoSeriesMgt.GetNextNo(SRsetup."CRM Customer No.", WORKDATE, TRUE);
                RecCustomer."No." := custno;
                RecCustomer.Name := "CRM Payment Integration".Name;
                RecCustomer.Address := COPYSTR("CRM Payment Integration".Address, 1, 50);
                RecCustomer."Address 2" := COPYSTR("CRM Payment Integration".Address, 51, 100);
                RecCustomer.City := "CRM Payment Integration".City;
                RecCustomer.VALIDATE("State Code", "CRM Payment Integration"."State Code");
                RecCustomer."CRM Mobile No." := "CRM Payment Integration"."Phone No.";
                RecCustomer.VALIDATE("GST Registration No.", "CRM Payment Integration"."GST Registration No.");
                RecCustomer."GST Registration Type" := "CRM Payment Integration"."GST Registration Type";
                RecCustomer."GST Customer Type" := "CRM Payment Integration"."GST Customer Type";
                //RecCustomer.VALIDATE("Customer Posting Group",'RETAIL');
                //RecCustomer.VALIDATE("Gen. Bus. Posting Group",'RETAIL');
                RecCustomer.VALIDATE("Customer Posting Group", 'SERVICE'); //Win-234 As per mail rcvd from Mahendra chaulkar 26-02-2019
                RecCustomer.VALIDATE("Gen. Bus. Posting Group", 'SERVICE'); //Win-234 As per mail rcvd from Mahendra chaulkar 26-02-2019
                RecCustomer.INSERT;
                COMMIT;
                "CRM Payment Integration"."Customer Created" := TRUE;
                //   MESSAGE('Customer Created');
            END;
        END;
    end;


    procedure PostPayment()
    begin
        RecCust.RESET;
        RecCust.SETRANGE("CRM Mobile No.", "CRM Payment Integration"."Phone No.");
        IF RecCust.FINDFIRST THEN BEGIN
            IF "CRM Payment Integration"."GL Account No." <> '' THEN BEGIN
                RecGenJnlLine.RESET;
                RecGenJnlLine.SETRANGE(RecGenJnlLine."Journal Template Name", 'GENERAL1');
                RecGenJnlLine.SETRANGE(RecGenJnlLine."Journal Batch Name", 'SERVICE');
                IF RecGenJnlLine.FINDLAST THEN
                    line_no := RecGenJnlLine."Line No." + 10000
                ELSE
                    line_no := 10000;
                RecGenJnlLine.INIT;
                RecGenJnlLine."Journal Template Name" := 'GENERAL1';
                RecGenJnlLine."Journal Batch Name" := 'SERVICE';
                RecGenJnlLine."Line No." := line_no;
                SRsetup.GET;
                DoucNo := NoSeriesMgt.GetNextNo(SRsetup."CRM Payment No.", "CRM Payment Integration"."Posting Date", TRUE);
                RecGenJnlLine."Document No." := DoucNo;
                RecGenJnlLine."Posting Date" := "CRM Payment Integration"."Posting Date";
                RecGenJnlLine."Document Date" := "CRM Payment Integration"."Posting Date";
                RecGenJnlLine."Account Type" := RecGenJnlLine."Account Type"::Customer;
                RecGenJnlLine.VALIDATE("Document Type", RecGenJnlLine."Document Type"::Payment);
                RecGenJnlLine.VALIDATE("Account No.", RecCust."No.");
                RecGenJnlLine.VALIDATE(Amount, "CRM Payment Integration".Amount * -1);
                IF "CRM Payment Integration"."Account Type" = "CRM Payment Integration"."Account Type"::Cash THEN
                    RecGenJnlLine."Bal. Account Type" := RecGenJnlLine."Bal. Account Type"::"G/L Account";
                IF "CRM Payment Integration"."Account Type" = "CRM Payment Integration"."Account Type"::Other THEN
                    RecGenJnlLine."Bal. Account Type" := RecGenJnlLine."Bal. Account Type"::"Bank Account";
                RecGenJnlLine."Bal. Account No." := "CRM Payment Integration"."GL Account No.";
                RecGenJnlLine.VALIDATE("Location Code", "CRM Payment Integration"."Location Code");
                RecGenJnlLine.VALIDATE("GST Customer Type", "CRM Payment Integration"."GST Customer Type");
                RecGenJnlLine.Narration := "CRM Payment Integration".Narration;
                RecGenJnlLine."External Document No." := "CRM Payment Integration"."External Doc No.";
                RecGenJnlLine.VALIDATE("Shortcut Dimension 1 Code", "CRM Payment Integration"."Shortcut Dimension 1 Code");
                RecGenJnlLine.VALIDATE("Shortcut Dimension 2 Code", "CRM Payment Integration"."Shortcut Dimension 2 Code");
                RecGenJnlLine.INSERT(TRUE);
            END;
            //WIN316++//MOP
            IF "CRM Payment Integration"."GL Account No.1" <> '' THEN
                PostPayment1("CRM Payment Integration"."GL Account No.1", "CRM Payment Integration".Amount1, "CRM Payment Integration".Narration1);

            IF "CRM Payment Integration"."GL Account No.2" <> '' THEN
                PostPayment1("CRM Payment Integration"."GL Account No.2", "CRM Payment Integration".Amount2, "CRM Payment Integration".Narration2);

            IF "CRM Payment Integration"."GL Account No.3" <> '' THEN
                PostPayment1("CRM Payment Integration"."GL Account No.3", "CRM Payment Integration".Amount3, "CRM Payment Integration".Narration3);

            IF "CRM Payment Integration"."GL Account No.4" <> '' THEN
                PostPayment1("CRM Payment Integration"."GL Account No.4", "CRM Payment Integration".Amount4, "CRM Payment Integration".Narration4);

            //WIN316--//MOP
            "CRM Payment Integration"."CRM Payment Cteated" := TRUE;
            "CRM Payment Integration".MODIFY;
        END;
    end;


    procedure PostPayment1(Bal_Acc_No: Code[20]; Amt1: Decimal; Narration1: Text[60])
    begin
        RecCust.RESET;
        RecCust.SETRANGE("CRM Mobile No.", "CRM Payment Integration"."Phone No.");
        IF RecCust.FINDFIRST THEN BEGIN
            RecGenJnlLine.RESET;
            RecGenJnlLine.SETRANGE(RecGenJnlLine."Journal Template Name", 'GENERAL1');
            RecGenJnlLine.SETRANGE(RecGenJnlLine."Journal Batch Name", 'SERVICE');
            IF RecGenJnlLine.FINDLAST THEN
                line_no := RecGenJnlLine."Line No." + 10000
            ELSE
                line_no := 10000;
            RecGenJnlLine.INIT;
            RecGenJnlLine."Journal Template Name" := 'GENERAL1';
            RecGenJnlLine."Journal Batch Name" := 'SERVICE';
            RecGenJnlLine."Line No." := line_no;
            SRsetup.GET;
            DoucNo := NoSeriesMgt.GetNextNo(SRsetup."CRM Payment No.", "CRM Payment Integration"."Posting Date", TRUE);
            RecGenJnlLine."Document No." := DoucNo;
            RecGenJnlLine."Posting Date" := "CRM Payment Integration"."Posting Date";
            RecGenJnlLine."Document Date" := "CRM Payment Integration"."Posting Date";
            RecGenJnlLine."Account Type" := RecGenJnlLine."Account Type"::Customer;
            RecGenJnlLine.VALIDATE("Document Type", RecGenJnlLine."Document Type"::Payment);
            RecGenJnlLine.VALIDATE("Account No.", RecCust."No.");
            RecGenJnlLine.VALIDATE(Amount, Amt1 * -1);
            RecGenJnlLine."Bal. Account Type" := RecGenJnlLine."Bal. Account Type"::"G/L Account";
            RecGenJnlLine."Bal. Account No." := Bal_Acc_No;
            RecGenJnlLine.VALIDATE("Location Code", "CRM Payment Integration"."Location Code");
            RecGenJnlLine.VALIDATE("GST Customer Type", "CRM Payment Integration"."GST Customer Type");
            RecGenJnlLine.Narration := Narration1;
            RecGenJnlLine."External Document No." := "CRM Payment Integration"."External Doc No.";
            RecGenJnlLine.VALIDATE("Shortcut Dimension 1 Code", "CRM Payment Integration"."Shortcut Dimension 1 Code");
            RecGenJnlLine.VALIDATE("Shortcut Dimension 2 Code", "CRM Payment Integration"."Shortcut Dimension 2 Code");
            RecGenJnlLine.INSERT(TRUE);
        END;
    end;
}

