tableextension 50022 "Customer Table" extends Customer
{

    fields
    {
        field(50001; "PDC Unposted Amount"; Decimal)
        {
            CalcFormula = Sum(PDC."PDC Amount" WHERE("Account No." = FIELD("No."),
                                                       "PDC Deposited" = FILTER(False),
                                                       "Account Type" = FILTER(Customer)));
            Description = 'PDC';
            FieldClass = FlowField;
        }
        field(50002; "PDC Applied Amount"; Decimal)
        {
            Description = 'PDC';
            FieldClass = Normal;
        }
        field(50003; "PDC Grace Period"; DateFormula)
        {
            Description = 'PDC';
        }
        field(50004; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment,Approved';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment",Approved;
        }
        field(50005; "Moto Cust Inv Id"; Code[50])
        {
            Description = 'Moto integration';
        }
        field(51026; "Dr Change"; Decimal)
        {
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Debit Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                       "Entry Type" = CONST("Initial Entry"),
                                                                                       "Posting Date" = FIELD("Date Filter"),
                                                                                       "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                       "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter")));
            Description = 'Added for Customer Trial Balances';
            FieldClass = FlowField;
        }
        field(51027; "Cr Change"; Decimal)
        {
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Credit Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                        "Entry Type" = CONST("Initial Entry"),
                                                                                        "Posting Date" = FIELD("Date Filter"),
                                                                                       "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                        "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter")));
            Description = 'Added for Customer Trial Balances';
            FieldClass = FlowField;
        }
        field(51028; "Spouse Name"; Text[50])
        {
        }
        field(51029; "Child Name 1"; Text[50])
        {
        }
        field(51030; "Child Name 2"; Text[50])
        {
        }
        field(51031; "Aniversary Date"; Date)
        {
            Description = 'Capillary';
        }
        field(51032; "Child1 Birth  Date"; Date)
        {
        }
        field(51033; "Child2 Birth Date"; Date)
        {
        }
        field(51034; "Customer Birth Date"; Date)
        {
            Description = 'Capillary';
        }
        field(51035; "Spouse Birth Date"; Date)
        {
        }
        field(51036; "Customer Type"; Option)
        {
            OptionCaption = ' ,Retail,Corporate,Service,B2C';
            OptionMembers = " ",Retail,Corporate,Service,B2C;
        }
        field(51037; "Customer State Code"; Code[20])
        {
            TableRelation = State;
        }
        field(51038; Gender; Option)
        {
            Description = 'Capillary';
            OptionCaption = 'Male,Female';
            OptionMembers = Male,Female;
        }
        field(51039; "Marital Status"; Option)
        {
            OptionCaption = 'Married,Unmarried';
            OptionMembers = Married,Unmarried;
        }
        field(51040; "Parent Code"; Code[20])
        {
            TableRelation = Customer;

            trigger OnValidate()
            begin
                IF "Parent Code" <> '' THEN BEGIN
                    IF "Parent Code" = "No." THEN
                        ERROR('Parent Code not Allowed');
                    TESTFIELD("Credit Limit (LCY)", 0);
                    CustomerLocal.GET("Parent Code");
                    CustomerLocal.TESTFIELD("Parent Code", '');
                END;
            end;
        }
        field(51041; RelCustomerCnt; Integer)
        {
            CalcFormula = Count(Customer WHERE("Parent Code" = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(51044; "Age Group"; Option)
        {
            Description = 'Capillary';
            OptionCaption = ' ,<18,18-29,30-45,56-69,70-87';
            OptionMembers = " ","<18","18-29","30-45","56-69","70-87";
        }
        field(51045; "Income Group"; Option)
        {
            Description = 'Capillary';
            OptionCaption = ' ,Up to 3,3-6,6-9,10-13,14-18,19-25,>25';
            OptionMembers = " ","Up to 3","3-6","6-9","10-13","14-18","19-25",">25";
        }
        field(51046; "Not Interested Customer"; Boolean)
        {
            Description = 'Capillary';

            trigger OnValidate()
            begin
                IF "Phone No." <> '' THEN
                    "Not Interested Customer" := FALSE
                ELSE
                    "Not Interested Customer" := TRUE;
            end;
        }
        field(51047; "Phone No.2"; Text[30])
        {
            Caption = 'Phone No.2';
            Description = 'Capillary';
            ExtendedDatatype = PhoneNo;
        }
        field(51048; "CRM Mobile No."; Text[30])
        {
            Caption = 'CRM Mobile No.';
            Description = 'WIN318';
            ExtendedDatatype = PhoneNo;

            trigger OnValidate()
            begin
                //WIN316++//FOR CAPILLERY
                IF "Phone No." <> '' THEN BEGIN
                    IF (STRLEN("Phone No.") > 10) OR ((STRLEN("Phone No.") < 10)) THEN
                        ERROR('Phone No Should be 10 Digit');
                    xRec.SETRANGE("Phone No.", Rec."Phone No.");
                    IF xRec.FINDFIRST THEN
                        ERROR('No Already exists');
                END;

                IF "Phone No." <> '' THEN
                    "Not Interested Customer" := FALSE
                ELSE
                    "Not Interested Customer" := TRUE;
                //WIN316--
            end;
        }
        field(51049; "Creation Date"; DateTime)
        {
            Caption = 'Creation Date';
            Description = 'WIN316';
        }
        field(51050; "Modified by User ID"; Code[50])
        {
            Description = 'WIN316';
        }
        field(51051; "Customer Points"; Decimal)
        {
            Caption = 'Customer Points';
            Description = 'Capillary';
            Editable = false;
        }
        field(51052; "Cust Adress 3"; Text[150])
        {
            Description = 'Moto integration';
        }
        field(51053; "ERP No."; Code[20])
        {
            dataclassification = tobeclassified;
            caption = 'No.';
        }
        field(51054; "Customer Sub Type"; Enum "Customer SubType")
        {
            dataclassification = tobeclassified;

        }
        modify("Phone No.") //CCIT-TK-24723
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //WIN316++//FOR CAPILLERY
                IF "Phone No." <> '' THEN BEGIN
                    IF (STRLEN("Phone No.") > 10) OR ((STRLEN("Phone No.") < 10)) THEN
                        ERROR('Phone No Should be 10 Digit');
                    xRec.SETRANGE("Phone No.", Rec."Phone No.");
                    IF xRec.FINDFIRST THEN
                        ERROR('No Already exists');
                END;
                // tk
                IF "Phone No." <> '' THEN
                    "Not Interested Customer" := FALSE
                ELSE
                    "Not Interested Customer" := TRUE;
                //WIN316--
            end;
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            BEGIN
                "ERP No." := "No.";
            END;
        }
    }
    trigger OnBeforeInsert()
    var
        myInt: Integer;
        NoSeriesCode: code[20];
    begin
        SalesSetup.GET;

        IF "No." = '' THEN BEGIN
            "No." := NoSeriesMgt.GetNextNo(GetCustomerNoSeries, TODAY, TRUE);
            "ERP No." := "No.";
        END;

        //  NoSeriesMgt.InitSeries(NoSeriesCode,xRec."No. Series",0D,"No.","No. Series")

        //     NoSeriesMgt.InitSeries(GetCustomerNoSeries, xRec."No. Series", 0D, "No.", "No. Series")
        // ELSE
        //     NoSeriesMgt.TestManual(NoSeriesCode);

        //WIN316++
        "Creation Date" := CURRENTDATETIME;
        //"State Code":='MH';
        "GST Customer Type" := "GST Customer Type"::Unregistered;
        //WIN316--
    end;
    //CCIT AN++ 
    trigger OnAfterInsert()
    var
        myInt: Integer;
    begin
        CustomerEditable := true;
    end;

    trigger OnAfterModify()
    var
        myInt: Integer;
        RecSIH: Record "Sales Invoice Header";

        recCustomer1: Record "Customer";
        SalesHeader1: Record "Sales Header";
        UserSetup: Record "User Setup";
    begin

        /*  if CustomerEditable = false then begin
              Rec.Modify(false);
              UserSetup.Reset();
              UserSetup.SetRange("User ID", USERID);
              UserSetup.SetRange("Customer Edit", false);
              if UserSetup.FindFirst() then begin
                  ERROR('You are not allowed to change Customer details.');
              end
              else
                  Rec.Modify(true);
          end;*/
        //CCIT AN-- */
        /* IF (USERID <> 'KAILAS.THUBE') or (USERID <> 'ADMIN') THEN BEGIN
             RecSIH.RESET;
             RecSIH.SETRANGE("Sell-to Customer No.", Rec."No.");
             IF RecSIH.FINDFIRST THEN BEGIN

                 IF (Rec."GST Registration No." <> xRec."GST Registration No.") THEN
                     // (Rec."Phone No."=xRec."Phone No.") OR (Rec."Phone No.2"=xRec."Phone No.2") OR (Rec.Contact = xRec.Contact) THEN
                     ERROR('You are not allowed to change Customer details. Please contact Mr.Kailash for further assistance');


                 IF (Rec."GST Registration No." <> xRec."GST Registration No.") AND (Rec."Phone No." = xRec."Phone No.") AND (Rec."Phone No.2" = xRec."Phone No.2") AND (Rec.Contact = xRec.Contact) AND (Rec."Customer Points" = xRec."Customer Points") THEN
                     ERROR('You are not allowed to change Customer details.Please contact Mr.Kailash  for further assistance');//win-234 06-02-2019

                 IF ("GST Registration No." = '') AND ("State Code" <> '') THEN
                     IF (Rec."State Code" <> xRec."State Code") AND (Rec."Phone No." = xRec."Phone No.") AND (Rec."Phone No.2" = xRec."Phone No.2") AND (Rec.Contact = xRec.Contact) AND (Rec."Customer Points" = xRec."Customer Points") THEN
                         ERROR('You are not allowed to change Customer details. Please contact Mr.Kailash  for further assistance');
             END;
             SalesHeader1.RESET;
             SalesHeader1.SETRANGE("Sell-to Customer No.", Rec."No.");
             IF SalesHeader1.FINDFIRST THEN BEGIN

                 IF (Rec."GST Registration No." <> xRec."GST Registration No.") THEN
                     // (Rec."Phone No."=xRec."Phone No.") OR (Rec."Phone No.2"=xRec."Phone No.2") OR (Rec.Contact = xRec.Contact) THEN
                     ERROR('You are not allowed to change Customer details. Please contact Mr.Kailash  for further assistance');


                 IF (Rec."GST Registration No." <> xRec."GST Registration No.") AND (Rec."Phone No." = xRec."Phone No.") AND (Rec."Phone No.2" = xRec."Phone No.2") AND (Rec.Contact = xRec.Contact) AND (Rec."Customer Points" = xRec."Customer Points") THEN
                     ERROR('You are not allowed to change Customer details.Please contact Mr.Kailash  for further assistance');//win-234 06-02-2019

                 IF ("GST Registration No." = '') AND ("State Code" <> '') THEN
                     IF (Rec."State Code" <> xRec."State Code") AND (Rec."Phone No." = xRec."Phone No.") AND (Rec."Phone No.2" = xRec."Phone No.2") AND (Rec.Contact = xRec.Contact) AND (Rec."Customer Points" = xRec."Customer Points") THEN
                         ERROR('You are not allowed to change Customer details. Please contact Mr.Kailash  for further assistance');
             END;
         END;
 */ //CCIT AN 20102023 commented for hide the error
    //WIN316--

        "Last Date Modified" := TODAY;
        //WIN316++
        "Modified by User ID" := USERID;
        //WIN316--
    end;


    var
        CustomerLocal: Record Customer;
        SalesSetup: Record "Sales & Receivables Setup";
        CustomerTypePage: page "Customer Type Selection";
        CutomerTypeRec: record Customer;
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        CustomerEditable: Boolean;

    procedure GetCustomerNoSeries(): Code[20]
    begin
        //MESSAGE(FORMAT("Customer Type"));
        SalesSetup.GET;
        IF "Customer Type" = "Customer Type"::Retail THEN BEGIN
            SalesSetup.TESTFIELD("Retail Customer Nos.");
            EXIT(SalesSetup."Retail Customer Nos.");
        END;
        CustomerTypePage.LOOKUPMODE(TRUE);
        IF CustomerTypePage.RUNMODAL = ACTION::LookupOK THEN BEGIN
            CustomerTypePage.GETRECORD(CutomerTypeRec);

            IF CutomerTypeRec."Customer Type" = CutomerTypeRec."Customer Type"::Retail THEN BEGIN
                SalesSetup.TESTFIELD("Retail Customer Nos.");
                EXIT(SalesSetup."Retail Customer Nos.");
            END
            ELSE
                IF CutomerTypeRec."Customer Type" = CutomerTypeRec."Customer Type"::Corporate THEN BEGIN
                    SalesSetup.TESTFIELD("Corporate Customer Nos.");
                    EXIT(SalesSetup."Corporate Customer Nos.");
                END
                ELSE
                    EXIT(SalesSetup."Customer Nos.");
        END;
        EXIT('');
    end;


}
