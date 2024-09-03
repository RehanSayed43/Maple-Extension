tableextension 50034 "Sales HeaderTable" extends "Sales Header"
{
    fields
    {
        field(50000; "Credit Hold"; Boolean)
        {
            CalcFormula = max("Sales Line"."Credit Hold" where("Document No." = field("No."),
                                                                "Document Type" = field("Document Type")));
            Description = 'Win127';
            FieldClass = FlowField;
            InitValue = false;
        }
        field(50001; "Overdue Hold"; Boolean)
        {
            CalcFormula = max("Sales Line"."Overdue Hold" where("Document No." = field("No."),
                                                                 "Document Type" = field("Document Type")));
            Description = 'Win127';
            FieldClass = FlowField;
        }
        field(50002; "Price Hold"; Boolean)
        {
            CalcFormula = max("Sales Line"."Price Hold" where("Document No." = field("No."),
                                                               "Document Type" = field("Document Type")));
            Description = 'Win127';
            FieldClass = FlowField;
        }
        field(50003; "Credit Days Hold"; Boolean)
        {
            Description = 'Win127';
        }
        field(50004; "PDC Hold"; Boolean)
        {
            CalcFormula = max("Sales Line"."PDC Hold" where("Document No." = field("No."),
                                                             "Document Type" = field("Document Type")));
            Description = 'Win127';
            FieldClass = FlowField;
        }
        field(50005; "Discount Hold"; Boolean)
        {
            CalcFormula = max("Sales Line"."Discount Hold" where("Document No." = field("No."),
                                                                  "Document Type" = field("Document Type")));
            Description = 'Win127';
            FieldClass = FlowField;
        }
        field(50006; "Sales Order Type"; Option)
        {
            Description = 'Win127';
            InitValue = Rental;
            OptionCaption = ' ,Retail,Rental,B2B,AMC,Service,Retail Buyback,Online';
            OptionMembers = " ",Retail,Rental,B2B,AMC,Service,"Retail Buyback",Online;


            trigger OnValidate()
            begin
                UserSetup.Get(UserId);
                if (UserSetup."User ID" <> 'ACC1EXE') and (UserSetup."User ID" <> 'ACC2EXE') then begin
                    if "Sales Order Type" = "sales order type"::Retail then begin
                        UserSetup.Get(UserId);
                        if (UserSetup."Location Code" = '') and ("Sales Order Type" = "sales order type"::Retail) then
                            Error('Define Location on user Setup for User %1', UserId)
                        else
                            Validate("Location Code", UserSetup."Location Code");
                    end;
                end;
                if "Sales Order Type" = "sales order type"::B2B then begin
                    SalesSetup.Get;
                    SalesSetup.TestField("PIT Structure");
                    // Validate(Structure,SalesSetup."PIT Structure");//tk
                end;
                //  ERROR('Invalid Sales Order Type!!!');
            end;
        }
        field(50007; Shield; Boolean)
        {
            CalcFormula = max("Sales Line".Shield where("Document Type" = field("Document Type"),
                                                         "Document No." = field("No.")));
            Description = 'Win127';
            FieldClass = FlowField;
        }
        field(50008; "Shield Posting No."; Code[20])
        {
        }
        field(50009; "Cust. Mobile No."; Text[30])
        {

            trigger OnValidate()
            begin

                /*
                SInvLine.RESET;
                SInvLine.SETFILTER("Cust. Mobile No.",'%1',"Cust. Mobile No.");
                IF SInvLine.FINDSET THEN BEGIN
                  IF PAGE.RUNMODAL(50017,SInvLine) = ACTION::LookupOK THEN BEGIN
                    VALIDATE("Sell-to Customer No.",SInvLine."Sell-to Customer No."); //UpdatCustomerdetails(SInvLine);
                    //UpdatCustomerdetails(SInvLine);
                      //CurrPage.UPDATE(TRUE);
                      EXIT;
                  END;
                END
                ELSE
                */
                if "Sales Order Type" = "sales order type"::Retail then begin
                    CustomerLocal.Reset;
                    CustomerLocal.SetFilter("Phone No.", '%1', "Cust. Mobile No.");
                    if Page.RunModal(50037, CustomerLocal) = Action::LookupOK then begin
                        Validate("Sell-to Customer No.", CustomerLocal."No."); //UpdatCustomerdetails(SInvLine);
                                                                               //CurrPage.UPDATE(TRUE);
                    end;
                end;

            end;
        }
        field(50010; "Cust. email ID"; Text[50])
        {

            trigger OnValidate()
            begin
                if "Sales Order Type" = "sales order type"::Retail then begin
                    /*
                    SInvLine.RESET;
                    SInvLine.SETFILTER("Cust. email ID",'%1',"Cust. email ID");
                    IF SInvLine.FINDSET THEN BEGIN
                      IF PAGE.RUNMODAL(50037,SInvLine) = ACTION::LookupOK THEN BEGIN
                        VALIDATE("Sell-to Customer No.",SInvLine."Sell-to Customer No."); //UpdatCustomerdetails(SInvLine);
                        //UpdatCustomerdetails(SInvLine);
                          //CurrPage.UPDATE(TRUE);
                          EXIT;
                      END;
                    END
                    ELSE
                    */
                    CustomerLocal.Reset;
                    CustomerLocal.SetFilter("E-Mail", '%1', "Cust. email ID");
                    if Page.RunModal(50037, CustomerLocal) = Action::LookupOK then begin
                        Validate("Sell-to Customer No.", CustomerLocal."No."); //UpdatCustomerdetails(SInvLine);
                                                                               //CurrPage.UPDATE(TRUE);
                    end;
                end;

            end;
        }
        field(50011; "Customer Name"; Text[50])
        {

            trigger OnValidate()
            begin
                if "Sales Order Type" = "sales order type"::Retail then begin
                    /*
                    SInvLine.RESET;
                    SInvLine.SETFILTER("Customer Name",'%1',"Customer Name");
                    IF SInvLine.FINDSET THEN BEGIN
                      IF PAGE.RUNMODAL(50017,SInvLine) = ACTION::LookupOK THEN BEGIN
                        VALIDATE("Sell-to Customer No.",SInvLine."Sell-to Customer No."); //UpdatCustomerdetails(SInvLine);
                        //UpdatCustomerdetails(SInvLine);
                          //CurrPage.UPDATE(TRUE);
                          EXIT;
                      END;
                    END
                    ELSE
                      */
                    CustomerLocal.Reset;
                    CustomerLocal.SetFilter(Name, '%1', "Customer Name");
                    if Page.RunModal(50037, CustomerLocal) = Action::LookupOK then begin
                        Validate("Sell-to Customer No.", CustomerLocal."No."); //UpdatCustomerdetails(SInvLine);
                                                                               //CurrPage.UPDATE(TRUE);
                    end;
                end;

            end;
        }
        field(50012; "Product Bar Code"; Code[20])
        {
            Enabled = false;

            trigger OnValidate()
            var
                LineNo: Integer;
                ILE: Record "Item Ledger Entry";
            begin
            end;
        }
        field(50013; PayByCashAmt; Decimal)
        {
            MinValue = 0;

            trigger OnValidate()
            begin
                "CashPay Method Code" := ValidatePaymentMethod(PaymentMethod."pay type"::Cash, PayByCashAmt);
            end;
        }
        field(50014; "CashPay Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";

            trigger OnValidate()
            var
                SEPADirectDebitMandate: Record "SEPA Direct Debit Mandate";
            //DOPaymentTransLogEntry: Record "DO Payment Trans. Log Entry";
            begin
            end;
        }
        field(50015; PayByCreditNo1; Code[20])
        {
            TableRelation = "Standard Text" where("Credit Cd Machine Code" = filter(<> ''));

            trigger OnLookup()
            begin
                CRMachineCode.Reset;
                CRMachineCode.SetFilter("Credit Cd Machine Code", '<>%1', '');
                CRMachineCode.SetFilter("Credit Card Machine", '%1', true);
                if Page.RunModal(50052, CRMachineCode) = Action::LookupOK then begin
                    PayByCreditNo1 := CRMachineCode."Credit Cd Machine Code";
                    Validate("CreditCdPay Method Code1", GetCreditCardMethod(PayByCreditNo1));
                end;
            end;

            trigger OnValidate()
            begin
                PayByCreditAmt1 := 0;
                GetCreditCardMethod(PayByCreditNo1);
                UpdateCustomerTotal;
            end;
        }
        field(50016; "CreditCdPay Method Code1"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method" where("Pay Type" = const("Credit Card"));

            trigger OnValidate()
            var
                SEPADirectDebitMandate: Record "SEPA Direct Debit Mandate";
            // DOPaymentTransLogEntry: Record UnknownRecord829;
            begin
            end;
        }
        field(50017; PayByCreditNo2; Code[20])
        {
            TableRelation = "Standard Text" where("Credit Cd Machine Code" = filter(<> ''));

            trigger OnLookup()
            begin
                CRMachineCode.Reset;
                CRMachineCode.SetFilter("Credit Cd Machine Code", '<>%1', '');
                CRMachineCode.SetFilter("Credit Card Machine", '%1', true);
                if Page.RunModal(50052, CRMachineCode) = Action::LookupOK then begin
                    PayByCreditNo2 := CRMachineCode."Credit Cd Machine Code";
                    Validate("CreditCdPay Method Code2", GetCreditCardMethod(PayByCreditNo2));
                end;
            end;

            trigger OnValidate()
            begin
                PayByCreditAmt2 := 0;
                UpdateCustomerTotal;
            end;
        }
        field(50018; PayByCreditNo3; Code[10])
        {
            Description = 'changed from 20 Win-234';
            TableRelation = "Standard Text" where("Credit Cd Machine Code" = filter(<> ''));

            trigger OnLookup()
            begin
                CRMachineCode.Reset;
                CRMachineCode.SetFilter("Credit Cd Machine Code", '<>%1', '');
                CRMachineCode.SetFilter("Credit Card Machine", '%1', true);
                if Page.RunModal(50052, CRMachineCode) = Action::LookupOK then begin
                    PayByCreditNo3 := CRMachineCode."Credit Cd Machine Code";
                    Validate("CreditCdPay Method Code3", GetCreditCardMethod(PayByCreditNo3));
                end;
            end;

            trigger OnValidate()
            begin
                PayByCreditAmt3 := 0;
                UpdateCustomerTotal;
            end;
        }
        field(50019; PayByCreditNo4; Code[10])
        {
            Description = 'changed from 20 Win-234';
            TableRelation = "Standard Text" where("Credit Cd Machine Code" = filter(<> ''));

            trigger OnLookup()
            begin
                CRMachineCode.Reset;
                CRMachineCode.SetFilter("Credit Cd Machine Code", '<>%1', '');
                CRMachineCode.SetFilter("Credit Card Machine", '%1', true);
                if Page.RunModal(50052, CRMachineCode) = Action::LookupOK then begin
                    PayByCreditNo4 := CRMachineCode."Credit Cd Machine Code";
                    Validate("CreditCdPay Method Code4", GetCreditCardMethod(PayByCreditNo4));
                end;
            end;

            trigger OnValidate()
            begin
                PayByCreditAmt4 := 0;
                UpdateCustomerTotal;
            end;
        }
        field(50020; PayByCreditAmt1; Decimal)
        {
            MinValue = 0;

            trigger OnValidate()
            begin
                if PayByCreditNo1 = '' then
                    Error(Text074);
                if CreditCardNo1 = '' then
                    Error(Text075);
                if "CreditCdPay Method Code1" = '' then
                    GetCreditCardMethod(PayByCreditNo1);
                //IF "CreditCdPay Method Code1" = '' THEN
                // ERROR(Text076)
                //ELSE
                ValidateServiceChargeAc("CreditCdPay Method Code1");
                //"CreditCdPay Method Code1" := ValidatePaymentMethod(PaymentMethod."Pay Type"::"Credit Card",PayByCreditAmt1);
            end;
        }
        field(50021; PayByCreditAmt2; Decimal)
        {
            MinValue = 0;

            trigger OnValidate()
            begin
                if PayByCreditNo2 = '' then
                    Error(Text074);
                if CreditCardNo2 = '' then
                    Error(Text075);

                if "CreditCdPay Method Code2" = '' then
                    Error(Text076)
                else
                    ValidateServiceChargeAc("CreditCdPay Method Code2");

                //"CreditCdPay Method Code1" := ValidatePaymentMethod(PaymentMethod."Pay Type"::"Credit Card",PayByCreditAmt2);
            end;
        }
        field(50022; PayByCreditAmt3; Decimal)
        {
            MinValue = 0;

            trigger OnValidate()
            begin
                if PayByCreditNo3 = '' then
                    Error(Text074);
                if CreditCardNo3 = '' then
                    Error(Text075);

                if "CreditCdPay Method Code3" = '' then
                    Error(Text076)
                else
                    ValidateServiceChargeAc("CreditCdPay Method Code3");

                //"CreditCdPay Method Code1" := ValidatePaymentMethod(PaymentMethod."Pay Type"::"Credit Card",PayByCreditAmt3);
            end;
        }
        field(50023; PayByCreditAmt4; Decimal)
        {
            MinValue = 0;

            trigger OnValidate()
            begin
                if PayByCreditNo4 = '' then
                    Error(Text074);
                if CreditCardNo4 = '' then
                    Error(Text075);

                if "CreditCdPay Method Code4" = '' then
                    Error(Text076)
                else
                    ValidateServiceChargeAc("CreditCdPay Method Code4");

                //"CreditCdPay Method Code1" := ValidatePaymentMethod(PaymentMethod."Pay Type"::"Credit Card",PayByCreditAmt4);
            end;
        }
        field(50024; PayByDebitCdNo1; Code[20])
        {
            TableRelation = "Standard Text" where("Credit Cd Machine Code" = filter(<> ''));

            trigger OnLookup()
            begin
                CRMachineCode.Reset;
                CRMachineCode.SetFilter("Credit Cd Machine Code", '<>%1', '');
                CRMachineCode.SetFilter("Credit Card Machine", '%1', true);
                if Page.RunModal(50052, CRMachineCode) = Action::LookupOK then begin
                    PayByDebitCdNo1 := CRMachineCode."Credit Cd Machine Code";
                    "DebitCdPay Method Code1" := GetDebitCardMethod(PayByDebitCdNo1);
                end;
            end;

            trigger OnValidate()
            begin
                PayByDebitCdAmt1 := 0;
                UpdateCustomerTotal;
            end;
        }
        field(50025; PayByDebitCdAmt1; Decimal)
        {
            MinValue = 0;

            trigger OnValidate()
            begin
                //TESTFIELD(PayByDebitNo1);
                //"DebitCdPay Method Code1" := ValidatePaymentMethod(PaymentMethod."Pay Type"::"Debit Card",PayByDebitAmt1);
                if PayByDebitCdNo1 = '' then
                    Error(Text078);
                if DebitCardNo1 = '' then
                    Error(Text079);

                if "DebitCdPay Method Code1" = '' then
                    Error(Text080)
                else
                    ValidateServiceChargeAc("DebitCdPay Method Code1");
            end;
        }
        field(50026; PayByChqNo; Code[15])
        {
            Description = 'changed from 20 Win-234';

            trigger OnValidate()
            begin
                //PayByChqAmt := 0;
            end;
        }
        field(50027; PayByChqDt; Date)
        {
        }
        field(50028; PayByChqAmt; Decimal)
        {
            MinValue = 0;

            trigger OnValidate()
            begin
                TestField(PayByChqNo);
                TestField(PayByChqDt);
                "ChqPay Method Code" := ValidatePaymentMethod(PaymentMethod."pay type"::Cheque, PayByChqAmt);
            end;
        }
        field(50029; GiftVoucherAmt; Decimal)
        {
            MinValue = 0;

            trigger OnValidate()
            begin
                "GiftPay Method Code" := ValidatePaymentMethod(PaymentMethod."pay type"::"Gift Voucher", GiftVoucherAmt);
            end;
        }
        field(50030; "RTGS Ref. No."; Code[20])
        {

            trigger OnValidate()
            begin
                "RTGS Amount" := 0;
                UpdateCustomerTotal;
            end;
        }
        field(50031; "RTGS Bank Name"; Text[30])
        {

            trigger OnValidate()
            begin
                "RTGS Amount" := 0;
                UpdateCustomerTotal;
            end;
        }
        field(50032; "RTGS Amount"; Decimal)
        {
            MinValue = 0;

            trigger OnValidate()
            begin
                TestField("RTGS Ref. No.");
                TestField("RTGS Bank Name");
                "RTGSPay Method Code" := ValidatePaymentMethod(PaymentMethod."pay type"::RTGS, "RTGS Amount");
            end;
        }
        field(50033; "Finance Comapny"; Text[30])

        {


            trigger OnValidate()
            begin
                "Finance Amount" := 0;
                UpdateCustomerTotal;
            end;
        }
        field(50034; "Bank Approval Code"; Code[20])
        {

            trigger OnValidate()
            begin
                "Finance Amount" := 0;
                UpdateCustomerTotal;
            end;
        }
        field(50035; "Finance Amount"; Decimal)
        {
            MinValue = 0;

            trigger OnValidate()
            begin
                TestField("Finance Comapny new");
                TestField("Bank Approval Code");
                //"FinPay Method Code":= ValidatePaymentMethod(PaymentMethod."Pay Type"::Finance,"Finance Amount");
                //ValidateServiceChargeAc('FINANCE');

                //WIN316++
                if "Finance Comapny new" = "finance comapny new"::"BAJAJ FINANCE" then begin
                    "FinPay Method Code" := 'FINANCE';
                    ValidateServiceChargeAc('FINANCE');
                end;
                IF "Finance Comapny new" = "Finance Comapny new"::"IDFC FINANCE" THEN BEGIN
                    "FinPay Method Code" := 'IDFC FNC';
                    ValidateServiceChargeAc('IDFC FNC');
                end;
                if "Finance Comapny new" = "finance comapny new"::HDFC then begin
                    "FinPay Method Code" := 'HDFC FNC';
                    ValidateServiceChargeAc('HDFC FNC');
                end;
                if "Finance Comapny new" = "finance comapny new"::"CITI FINANCE" then begin
                    "FinPay Method Code" := 'CITI FNC';
                    ValidateServiceChargeAc('CITI FNC');
                end;
                if "Finance Comapny new" = "finance comapny new"::DCEMI then begin
                    "FinPay Method Code" := 'DCEMI FNC';
                    ValidateServiceChargeAc('DCEMI FNC');
                end;
                //WIN316--//TK Finance
            end;
        }
        field(50036; TotalPayByCustomer; Decimal)
        {
            MinValue = 0;

            trigger OnValidate()
            begin
                UpdateCustomerTotal;
                /*
                TotalPayByCustomer := PayByCashAmt + PayByCreditAmt1+PayByCreditAmt2+PayByCreditAmt3+PayByCreditAmt4+PayByCreditAmt5+PayByDebitAmt+PayByChqAmt+GiftVoucherAmt+"RTGS Amount"+"Finance Amount"+"Maple Buyback Amt"+"Apple Buyback Amt"+"Apple Refund Amt";
                CALCFIELDS("Total Shield Value");
                TotalPayByCustomer := TotalPayByCustomer + "Total Shield Value";
                */

            end;
        }
        field(50037; "Buyer's Order No."; Code[30])
        {
        }
        field(50038; "Buyer's Order Dt"; Date)
        {
        }
        field(50039; "DebitCdPay Method Code1"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";

            trigger OnValidate()
            var
                SEPADirectDebitMandate: Record "SEPA Direct Debit Mandate";
            //DOPaymentTransLogEntry: Record UnknownRecord829;//tk
            begin
            end;
        }
        field(50040; "ChqPay Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";

            trigger OnValidate()
            var
                SEPADirectDebitMandate: Record "SEPA Direct Debit Mandate";
            //DOPaymentTransLogEntry: Record UnknownRecord829;//tk
            begin
            end;
        }
        field(50041; "GiftPay Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";

            trigger OnValidate()
            var
                SEPADirectDebitMandate: Record "SEPA Direct Debit Mandate";
            //DOPaymentTransLogEntry: Record UnknownRecord829;//tk
            begin
            end;
        }
        field(50042; "RTGSPay Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";

            trigger OnValidate()
            var
                SEPADirectDebitMandate: Record "SEPA Direct Debit Mandate";
            // DOPaymentTransLogEntry: Record UnknownRecord829;//tk
            begin
            end;
        }
        field(50043; "FinPay Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";

            trigger OnValidate()
            var
                SEPADirectDebitMandate: Record "SEPA Direct Debit Mandate";
            //DOPaymentTransLogEntry: Record UnknownRecord829;//tk
            begin
            end;
        }
        field(50044; "Promo Code"; Code[10])
        {
        }
        field(50045; "Delivery Note"; Text[30])
        {
        }
        field(50046; "Dispatch Doc. No."; Text[20])
        {
        }
        field(50047; "Dispatch Through"; Text[30])
        {
        }
        field(50048; "Posted Shield Posting No."; Code[20])
        {
        }
        field(50059; "Ref. Invoice No."; Code[20])
        {
            Description = 'Win127';
        }
        field(50060; "Maple Buyback Amt"; Decimal)
        {
            MinValue = 0;

            trigger OnValidate()
            begin
                "Maple Buyback Method Code" := ValidatePaymentMethod(PaymentMethod."pay type"::"Maple BuyBack", "Maple Buyback Amt");
            end;
        }
        field(50061; "Maple Buyback Method Code"; Code[10])
        {
        }
        field(50062; "Apple Buyback Amt"; Decimal)
        {
            Enabled = false;
            MinValue = 0;

            trigger OnValidate()
            begin
                "Apple Buyback method  Code" := ValidatePaymentMethod(PaymentMethod."pay type"::"Apple BuyBack", "Apple Buyback Amt");
            end;
        }
        field(50063; "Apple Buyback method  Code"; Code[10])
        {
            Enabled = false;
        }
        field(50064; "Vendor No."; Code[20])
        {

            trigger OnValidate()
            begin
                if "Vendor No." <> '' then begin
                    PurchHeader.Reset;
                    PurchHeader.SetRange(PurchHeader."Document Type", PurchHeader."document type"::Order);
                    PurchHeader.SetFilter("Retail Buyback Ref. No.", '%1', "No.");
                    if PurchHeader.FindFirst then begin
                        PurchHeader."Buy-from Vendor Name" := "Sell-to Customer Name";
                        //PurchHeader.VALIDATE("Buy-from Vendor No.","Vendor No.");
                        PurchHeader.Modify;
                    end;
                end;
            end;
        }
        field(50065; "Inward Location"; Code[10])
        {
            TableRelation = Location where("Location Type" = const(Buyback));

            trigger OnValidate()
            begin
                if "Inward Location" <> '' then begin
                    PurchHeader.Reset;
                    PurchHeader.SetRange(PurchHeader."Document Type", PurchHeader."document type"::Order);
                    PurchHeader.SetFilter("Retail Buyback Ref. No.", '%1', "No.");
                    if PurchHeader.FindFirst then begin
                        PurchHeader."Location Code" := "Inward Location";
                        PurchHeader.Modify;
                        PurchLine.Reset;
                        PurchLine.SetRange("Document Type", PurchHeader."Document Type");
                        PurchLine.SetFilter("Document No.", PurchHeader."No.");
                        if PurchLine.FindFirst then begin
                            repeat
                                PurchLine."Location Code" := "Inward Location";
                                PurchLine.Modify;
                            until PurchLine.Next = 0;
                        end;
                    end;
                end;
            end;
        }
        field(50066; "Vendor Name"; Code[20])
        {
        }
        field(50067; "Party Item Price"; Decimal)
        {
            Enabled = false;
        }
        field(50068; "Party No"; Code[20])
        {
            Enabled = false;
            TableRelation = Customer;
        }
        field(50069; "Party Sales Location"; Code[10])
        {
            Enabled = false;
            TableRelation = Location;
        }
        field(50070; "Party Address"; Text[50])
        {
            Enabled = false;
        }
        field(50071; "Party City"; Text[30])
        {
            Enabled = false;
        }
        field(50072; "Party Name"; Text[30])
        {
            Enabled = false;
        }
        field(50073; BuyBackType; Option)
        {
            OptionCaption = ' ,Maple,Apple';
            OptionMembers = " ",Maple,Apple;

            trigger OnValidate()
            var
                PurchLines: Record "Purchase Line";
            begin
                if (BuyBackType = Buybacktype::" ") and (xRec.BuyBackType <> xRec.Buybacktype::" ") then begin
                    CalcFields("Maple Buyback Amt");
                    if "Maple Buyback Amt" <> 0 then begin
                        if Confirm('Do you want to delete Existing Buyback Items') then begin
                            PurchLines.Reset;
                            PurchLines.SetFilter("Document No.", '%1', "PurchaseOrderNo.");
                            PurchLines.DeleteAll;
                        end;
                    end;
                end;

                if BuyBackType = Buybacktype::Maple then begin
                    "Apple Buyback Amt" := 0;
                    "Apple Buyback method  Code" := '';
                    "Apple Refund Amt" := 0;
                end;

                if BuyBackType = Buybacktype::Apple then begin
                    "Maple Buyback Amt" := 0;
                    "Maple Buyback Method Code" := '';
                end;

                if BuyBackType = Buybacktype::" " then begin
                    "Maple Buyback Amt" := 0;
                    "Maple Buyback Method Code" := '';
                    "Apple Buyback Amt" := 0;
                    "Apple Buyback method  Code" := '';
                    "Apple Refund Amt" := 0;
                end;
                UpdateCustomerTotal;
            end;
        }
        field(50074; "Apple Refund Amt"; Decimal)
        {
            Enabled = false;
            MinValue = 0;

            trigger OnValidate()
            begin
                "Apple Refund Method Code" := ValidatePaymentMethod(PaymentMethod."pay type"::"Apple Refund", "Apple Refund Amt");
            end;
        }
        field(50075; "Apple Refund Method Code"; Code[10])
        {
            Enabled = false;
        }
        field(50076; CreditCardNo1; Code[4])
        {

            trigger OnValidate()
            begin
                if CreditCardNo1 <> '' then begin
                    if StrLen(CreditCardNo1) <> 4 then begin
                        CreditCardNo1 := '';
                        Message('Credit Card No. Length must be 4');
                    end;
                    PayByCreditAmt1 := 0;
                    UpdateCustomerTotal;
                end;
            end;
        }
        field(50077; CreditCardNo2; Code[4])
        {

            trigger OnValidate()
            begin
                if CreditCardNo2 <> '' then begin
                    if StrLen(CreditCardNo2) <> 4 then begin
                        CreditCardNo2 := '';
                        Message('Credit Card No. Length must be 4');
                    end;
                    PayByCreditAmt2 := 0;
                    UpdateCustomerTotal;
                end;
            end;
        }
        field(50078; CreditCardNo3; Code[4])
        {

            trigger OnValidate()
            begin
                if CreditCardNo3 <> '' then begin
                    if StrLen(CreditCardNo3) <> 4 then begin
                        CreditCardNo3 := '';
                        Message('Credit Card No. Length must be 4');
                    end;
                    PayByCreditAmt3 := 0;
                    UpdateCustomerTotal;
                end;
            end;
        }
        field(50079; CreditCardNo4; Code[4])
        {

            trigger OnValidate()
            begin
                if CreditCardNo4 <> '' then begin
                    if StrLen(CreditCardNo4) <> 4 then begin
                        CreditCardNo4 := '';
                        Message('Credit Card No. Length must be 4');
                    end;
                    PayByCreditAmt4 := 0;
                    UpdateCustomerTotal;
                end;
            end;
        }
        field(50080; PurchaseLineExist; Integer)
        {
            CalcFormula = count("Purchase Line" where("No." = filter(<> ''),
                                                       "Retail Buyback Ref. No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50081; DebitCardNo2; Code[4])
        {

            trigger OnValidate()
            begin
                if DebitCardNo2 <> '' then begin
                    if StrLen(DebitCardNo2) <> 4 then begin
                        DebitCardNo2 := '';
                        Message('Credit Card No. Length must be 4');
                    end;
                    PayByDebitAmt2 := 0;
                    UpdateCustomerTotal;
                end;
            end;
        }
        field(50082; PayByDebitNo2; Code[20])
        {
            TableRelation = "Standard Text" where("Credit Cd Machine Code" = filter(<> ''));

            trigger OnLookup()
            begin
                CRMachineCode.Reset;
                CRMachineCode.SetFilter("Credit Cd Machine Code", '<>%1', '');
                CRMachineCode.SetFilter("Credit Card Machine", '%1', true);
                if Page.RunModal(50052, CRMachineCode) = Action::LookupOK then begin
                    PayByDebitNo2 := CRMachineCode."Credit Cd Machine Code";
                    "DebitCdPay Method Code2" := GetDebitCardMethod(PayByDebitNo2);
                end;
            end;

            trigger OnValidate()
            begin
                PayByDebitCdAmt1 := 0;
                UpdateCustomerTotal;
                /*
                CRMachineCode.RESET;
                CRMachineCode.SETFILTER("Credit Cd Machine Code",'<>%1','');
                IF PAGE.RUNMODAL(8,CRMachineCode) = ACTION::LookupOK THEN BEGIN
                  PayByCreditNo5 := CRMachineCode."Credit Cd Machine Code";
                  VALIDATE("CreditCdPay Method Code5",GetCreditCardMethod(PayByCreditNo5));
                END;
                */

            end;
        }
        field(50083; PayByDebitAmt2; Decimal)
        {
            MinValue = 0;

            trigger OnValidate()
            begin
                if PayByDebitNo2 = '' then
                    Error(Text078);
                if DebitCardNo2 = '' then
                    Error(Text079);

                if "DebitCdPay Method Code2" = '' then
                    Error(Text080)
                else
                    ValidateServiceChargeAc("DebitCdPay Method Code2");
            end;
        }
        field(50084; "CreditCdPay Method Code2"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method" where("Pay Type" = const("Credit Card"));

            trigger OnValidate()
            var
                SEPADirectDebitMandate: Record "SEPA Direct Debit Mandate";
            //DOPaymentTransLogEntry: Record UnknownRecord829;//tk
            begin
            end;
        }
        field(50085; "CreditCdPay Method Code3"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method" where("Pay Type" = const("Credit Card"));

            trigger OnValidate()
            var
                SEPADirectDebitMandate: Record "SEPA Direct Debit Mandate";
            // DOPaymentTransLogEntry: Record UnknownRecord829;
            begin
            end;
        }
        field(50086; "CreditCdPay Method Code4"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method" where("Pay Type" = const("Credit Card"));

            trigger OnValidate()
            var
                SEPADirectDebitMandate: Record "SEPA Direct Debit Mandate";
            //DOPaymentTransLogEntry: Record UnknownRecord829;
            begin
            end;
        }
        field(50087; "DebitCdPay Method Code2"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method" where("Pay Type" = const("Credit Card"));

            trigger OnValidate()
            var
                SEPADirectDebitMandate: Record "SEPA Direct Debit Mandate";
            // DOPaymentTransLogEntry: Record UnknownRecord829;
            begin
            end;
        }
        field(50088; "PurchaseOrderNo."; Code[20])
        {
        }
        field(50089; "Total Shield Value"; Decimal)
        {
            CalcFormula = sum("Sales Line"."Shield Value" where("Document Type" = field("Document Type"),
                                                                 "Document No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50090; "Shield Payment Amount"; Decimal)
        {
            Enabled = false;
        }
        field(50091; "FA Disposal"; Boolean)
        {

            trigger OnValidate()
            var
                SalesLine: Record "Sales Line";
            begin
                if "FA Disposal" then begin
                    SalesLine.Reset;
                    SalesLine.SetFilter(SalesLine."Document No.", '%1', "No.");
                    if not SalesLine.IsEmpty then begin
                        if Confirm('Do you want to delete existing lines', true) then
                            SalesLine.DeleteAll
                        else
                            "FA Disposal" := false;
                    end;
                end;
            end;
        }
        field(50092; "Group Credit Limit Hold"; Boolean)
        {
            Description = 'i';
        }
        field(50093; "Transfer Shipment  No."; Code[20])
        {
            TableRelation = "Transfer Shipment Header"."No." where("Customer No." = field("Sell-to Customer No."));
        }
        field(50094; BuybackRefundDistributor; Code[1])
        {
            Description = 'Changed from 20';
            TableRelation = Vendor where("Apple Distributor" = const(true));
        }
        field(50095; DebitCardNo1; Code[12])
        {
            Description = 'change from 4 to 20';
        }
        field(50097; WebUserID; Code[5])
        {
        }
        field(50098; CreditSale; Boolean)
        {
        }
        field(50099; "Debit Note"; Boolean)
        {
        }

        field(50100; "Finance Comapny new"; Option)
        {
            // TableRelation = "Finance Company Method";
            // Description = 'Option Field Change in code CCIT-TK';
            OptionCaption = ' ,BAJAJ FINANCE,HDFC,CITI FINANCE,DCEMI,IDFC FINANCE';
            OptionMembers = " ","BAJAJ FINANCE",HDFC,"CITI FINANCE",DCEMI,"IDFC FINANCE";
        }
        field(50101; "Amount To Customer UPIT"; Decimal)
        {
            CalcFormula = sum("Sales Line"."Unit Price Incl. of Tax" where("Document Type" = field("Document Type"),
                                                                         "Document No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;


        }
        field(50102; "Capillary Discount Amount"; Decimal)
        {
        }
        field(50103; "Capillary Posted"; Boolean)
        {
            Description = 'CAPILARY';
        }
        field(50104; "Get Customer"; Boolean)
        {
            Description = 'CAPILARY';
        }
        field(50105; "Paytm Approval Code"; Code[10])
        {

            trigger OnValidate()
            begin
                "Paytm Transfer Amount" := 0;
                UpdateCustomerTotal;
            end;
        }
        field(50106; "Paytm Transfer Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                /*
                TESTFIELD("Paytm Approval Code");
                paytmMethodCode:= 'PAYTM';
                ValidateServiceChargeAc('PAYTM');
                */// As per mail dt 26-06-2020 Mahendra
                if "Paytm Approval Code" = '' then
                    Error('Razor Pay Approval code needed');
                paytmMethodCode := 'RAZOR PAY';
                ValidateServiceChargeAc('RAZOR PAY'); //WIN234 30-06-2020

            end;
        }
        field(50107; paytmMethodCode; Code[10])
        {
        }
        field(50108; "Amazon Approval Code"; Code[10])
        {

            trigger OnValidate()
            begin
                "Amazon Transfer Amount" := 0;
                UpdateCustomerTotal;
            end;
        }
        field(50109; "Amazon Transfer Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                /*
                TESTFIELD("Amazon Approval Code");
                ExMethodCode:='EX';
                ValidateServiceChargeAc('EX');
                */// As per mail dt 26-06-2020 Mahendra
                if "Amazon Approval Code" = '' then
                    Error('Paytm Online approval code needed');
                ExMethodCode := 'PAYTMDCEMI';
                ValidateServiceChargeAc('PAYTMDCEMI');//WIN234 30-06-2020
                //Changed from Pinelab to Paytm 06-12-2022 Aniket

            end;
        }
        field(50110; ExMethodCode; Code[10])
        {
        }
        field(50113; "Capillary Transaction Id"; Text[1])
        {
            Description = 'CAPILLARY';
            Editable = false;
        }
        field(50115; "Order ID"; Code[20])
        {
            Description = 'E commerce';
            Editable = false;
        }
        field(50116; "Insurance Approval Code"; Code[20])
        {

            trigger OnValidate()
            begin
                "Insurance Transfer Amount" := 0;
                UpdateCustomerTotal;
            end;
        }
        field(50117; "Insurance Transfer Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                TestField("Insurance Approval Code");
                InsuranceMethodCode := 'INSURANCE';
                ValidateServiceChargeAc('INSURANCE');
            end;
        }
        field(50118; InsuranceMethodCode; Code[10])
        {
        }
        field(50119; CRM; Boolean)
        {
        }
        field(50120; "Cashify Approval Code"; Code[12])
        {

            trigger OnValidate()
            begin
                "Cashify Transfer Amount" := 0;
                UpdateCustomerTotal;
            end;
        }
        field(50121; "Cashify Transfer Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                TestField("Cashify Approval Code");
                CashifyMethodCode := 'Cashify';
                ValidateServiceChargeAc('Cashify');
            end;
        }
        field(50122; CashifyMethodCode; Code[10])
        {
        }
        field(50123; "Pinelab Transfer Amount"; Decimal)
        {
            Description = 'WIN316';

            trigger OnValidate()
            begin
                TestField("Pinelab Approval Code");
                PinelabMethodCode := 'PINELAB';
                ValidateServiceChargeAc('PINELAB');
            end;
        }
        field(50124; PinelabMethodCode; Code[10])
        {
            Description = 'WIN316';
        }
        field(50125; "Pinelab Approval Code"; Code[10])
        {

            trigger OnValidate()
            begin
                "Pinelab Transfer Amount" := 0;
                UpdateCustomerTotal;
            end;
        }
        field(50126; "Loyalty Riwardz Tr.Amount"; Decimal)
        {
            Description = 'WIN234';

            trigger OnValidate()
            begin
                TestField("Loyalty Riwardz Approval Code");
                "Loyalty Riwardz Method Code" := 'LOYALTY RW';//Loyalty Riwardz';
                ValidateServiceChargeAc('LOYALTY RW');
            end;
        }
        field(50127; "Loyalty Riwardz Method Code"; Code[10])
        {
            Description = 'WIN234';
        }
        field(50128; "Loyalty Riwardz Approval Code"; Code[10])
        {
            Description = 'WIN234';

            trigger OnValidate()
            begin
                "Loyalty Riwardz Tr.Amount" := 0;
                UpdateCustomerTotal;
            end;
        }
        field(50129; "Mobile Type"; Option)
        {
            Description = 'WIN234';
            OptionCaption = ' ,Apple,Other,Corporate';
            OptionMembers = " ",Apple,Other,Corporate;
        }
        field(50130; "Web Order"; Boolean)
        {
            Description = 'kPPL';
        }
        field(50131; "Cashify Bonus Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                TestField("Cashify Approval Code");
                CashifyBonusMethodCode := 'CSFYBONUS';
                ValidateServiceChargeBonusAc('CSFYBONUS');
            end;
        }
        field(50133; CashifyBonusMethodCode; Code[10])
        {
        }
        field(50135; "Trade In ReferenceID"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50136; "Name Of Firm"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50137; "Service Location Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50138; "Servify Currency Code"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50139; "Logistics Reference ID"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50140; "Trade In Status"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50141; "Model Storage"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50142; "Product Unique ID"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50143; "Model Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50144; "Model Grade"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50145; "Device Customer Amount"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50146; "Device Retailer Amount"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50147; "Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50148; "Mobile Number"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50149; "Email ID"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50150; "Model Brand"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50151; "Bonus Amount"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50152; UserName; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50153; "Product Unique ID New"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50212; "Voucher Amount"; Decimal)
        {
            Description = 'Voucher Integration';

            trigger OnValidate()
            begin
                Validate(GiftVoucherAmt, "Voucher Amount");//WIN234 01072021
            end;
        }
        field(50214; "IS LOB Order"; Boolean)
        {
            Description = 'LOB';
        }
        field(50215; orderKey; code[100])
        {

        }
        field(50216; transaction_id; code[50])
        {
        }
        field(50217; "payment_method"; code[20])
        {
        }

        field(50218; "payment_method_title"; code[80])
        {
        }
        field(50219; "Invoice Value"; Decimal)//1
        {
            FieldClass = FlowField;
            CalcFormula = sum("Sales Line"."Net Amount" where("Document Type" = field("Document Type"), "Document No." = field("No.")));
            Editable = false;



        }
        field(50220; "Servify Transfer Amount"; Decimal)
        {

        }
        field(50221; "Servify Bonus Amount"; Decimal)
        {

        }
        field(50222; "Paytm Transfer Amount Last"; Decimal)
        {

        }
        field(50223; "API GST Reg No"; Code[20])
        {
            DataClassification = CustomerContent; //DO NOT USE
        }
        field(50224; "Payment Status"; text[30])
        {
            DataClassification = CustomerContent; //DO NOT USE
        }
        field(50225; "API PAN"; Code[20])
        {
            DataClassification = CustomerContent; //DO NOT USE
        }
        field(50226; "Order Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50227; "Servify Approval Code"; Code[12])
        {
            DataClassification = ToBeClassified;
        }
        field(50228; orderStatus; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50229; orderDateTime; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(50230; "Payment Mode"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50231; "Buy Back Code"; code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50232; erpSoTimestamp; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(50233; ERPShipToAdd1; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50234; ERPShipToAdd2; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50235; ERPShipToCity; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50236; ERPShipToPostCode; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50238; ERPShipToState; Text[30])
        {
            DataClassification = ToBeClassified;
        }

        field(50239; ERPBillToAdd1; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50240; ERPBillToAdd2; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50241; ERPBillToCity; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50242; ERPBillToPostCode; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50243; ERPBillToState; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50244; "Trade-in device IMEI no."; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50245; "Trade-in Device Model no."; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(50246; "EU Deduction fees"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50247; "Maple Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50248; "Apple Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50249; "Servify Purchase Amount"; Decimal)
        {
            Caption = 'EasyOzy Purchase Amount';
            DataClassification = ToBeClassified;
        }
        field(50250; "EasyOzy Bonus Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        modify("No.")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    SalesSetup.GET;
                    NoSeriesMgt.TestManual(GetNoSeriesCode);
                    "No. Series" := '';
                END;
                // if rec."Document Type" = Rec."Document Type"::Order then
                //SalesHeader."Shortcut Dimension 2 Code" := 'RETAIL';
            end;
        }
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
                SellToCustomer: Record Customer;
            begin
                if rec."Document Type" = Rec."Document Type"::Order then begin
                    if SellToCustomer.get("Sell-to Customer No.") then begin
                        SalesHeader."Cust. Mobile No." := SellToCustomer."Phone No.";
                        SalesHeader."Cust. email ID" := SellToCustomer."E-Mail";
                        SalesHeader."Shortcut Dimension 2 Code" := 'Retail';

                        Message('%1', SalesHeader."Shortcut Dimension 2 Code");

                    end;
                end;
                //Updated WIN347++
                //234
                UserSetup.GET(USERID);
                IF (UserSetup."User ID" <> 'ACC1EXE') AND (UserSetup."User ID" <> 'ACC2EXE') THEN BEGIN
                    IF "Sales Order Type" = "Sales Order Type"::Retail THEN BEGIN
                        UserSetup.GET(USERID);
                        IF (UserSetup."Location Code" = '') AND ("Sales Order Type" = "Sales Order Type"::Retail) THEN
                            ERROR('Define Location on user Setup for User %1', USERID)
                        ELSE
                            VALIDATE("Location Code", UserSetup."Location Code");
                    END;
                END;
                VALIDATE("Vendor No.", "Sell-to Customer No.");  //Win127
                /*
                PurchaseSetup.GET;
                IF PurchaseSetup."Retail Buyback Purchase Nos." <> '' THEN BEGIN
                  //   "Ref. Invoice No." := NoSeriesMgt.GetNextNo(PurchaseSetup."Retail Buyback Purchase Nos.",WORKDATE,TRUE);
                  GenPurchaseBuybackDoc ;
                END
                ELSE
                  ERROR('Retail Buyback Purchase Nos. Series is not defined on Purchase & Payable setup');
                */
                //Updated WIN347--


            end;
        }
        modify("Posting Date")//CCIT-TK 200723
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //Updated WIN347++
                IF "Sales Order Type" = "Sales Order Type"::Retail THEN
                    "Shipment Date" := "Posting Date";

                //Updated WIN347--
            end;
        }
        modify("Location Code")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
                RecUserSetup: Record "User Setup";
                Location: Record Location;
                Cust: Record Customer;
            begin
                //win316++//TO AVAOID POSTING TO OTHER BRANCH

                IF ("Sales Order Type" = "Sales Order Type"::Retail) AND ("Document Type" <> "Document Type"::"Credit Memo") THEN BEGIN
                    RecUserSetup.RESET;
                    RecUserSetup.SETRANGE("User ID", USERID);
                    IF RecUserSetup.FINDFIRST THEN BEGIN
                        RecUserSetup.TESTFIELD("Location Code");
                        "Location Code" := RecUserSetup."Location Code";
                        //TESTFIELD("Location Code",RecUserSetup."Location Code");
                    END;
                END;

                //win316--
                // VALIDATE("Location Code", "Location Code");
            end;
        }
        modify("Due Date")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;

                WBU: Codeunit "Wins Business unit";
            begin
                //Updated WIN347++
                //Win127  02.06.14
                // IF WBU.CheckCreditDaysHold(Rec) THEN
                //     "Credit Days Hold" := TRUE;
                //Updated WIN347--
            end;
        }

    }
    trigger OnAfterInsert()
    var
        myInt: Integer;
        Location: Record Location;
    begin

        // IF ("Sales Order Type" = "Sales Order Type"::Retail) AND ("Document Type" <> "Document Type"::"Credit Memo") THEN BEGIN
        UserSetup.GET(USERID);
        VALIDATE("Location Code", UserSetup."Location Code");
        if Location.GET("Location Code") then // if Added NG
            State := Location."State Code";
        //  END;
        // SalesHeader."Shortcut Dimension 2 Code" := 'Retail';

        // Message('%1', SalesHeader."Shortcut Dimension 1 Code");
        Rec.erpSoTimestamp := CurrentDateTime;
    end;

    var
        UserSetup: Record "User Setup";
        CustomerLocal: Record Customer;
        CRMachineCode: Record "Standard Text";
        PaymentTerms: Record "Payment Terms";
        PaymentMethod: Record "Payment Method";
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        ServifyBonusAmount: Decimal;
        Text073: Label 'Shield Invoice No. series is not defined on Sales & Receivable setup.';
        Text074: Label 'Credit Card Machine Name should not be blank';
        Text075: Label 'Credit Card No. should not be blank';
        Text076: Label 'Credit Card Payment Method should not be blank';
        Text078: Label 'Debit Card Machine Name should not be blank';
        Text079: Label 'Debit Card No. should not be blank';
        Text080: Label 'Debit Card Payment Method should not be blank';
        ServifyTransferAmount: Decimal;
        PaytmTransferAmount: Decimal;

    local procedure ValidatePaymentMethod(PayTpe: Option " ",Cash,Cheque,"Credit Card","Debit Card","Gift Voucher",RTGS,Finance,Advance; PayAmount: Decimal): Code[10]
    var
        MethodCode: Code[20];
    begin
        IF PayAmount <> 0 THEN BEGIN
            //IF "Responsibility Center New 1" = '' THEN
            //  ERROR('Select Responsibility Center Code');
            PaymentMethod.RESET;
            PaymentMethod.SETFILTER("Pay Type", '%1', PayTpe);
            //PaymentMethod.SETFILTER("Branch Code",'%1',"Responsibility Center New 1");
            IF PaymentMethod.FINDFIRST THEN BEGIN
                ///IF PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::'' THEN
                //  ERROR();
                IF PaymentMethod."Bal. Account No." = '' THEN
                    ERROR('Bal. Account No. is not defined for %1', PayTpe);
                MethodCode := PaymentMethod.Code;
                IF PaymentMethod."Pay Type" = PaymentMethod."Pay Type"::"Credit Card" THEN BEGIN
                    IF PaymentMethod."Service Charge Account No." = '' THEN
                        ERROR('Service Charge Account No. is not defined for %1', PayTpe);
                    IF PaymentMethod."Service Charge Perc" = 0 THEN
                        ERROR('Service Charge Perc is not defined for %1', PayTpe);
                END;
            END
            ELSE
                ERROR('Pay Method not Defined for %1', PayTpe);
        END
        ELSE
            MethodCode := '';
        VALIDATE(TotalPayByCustomer);
        EXIT(MethodCode);
    end;

    procedure GetDebitCardMethod(CRCDMachineCode: Code[20]): Code[10]
    var
        PaymentMethod: Record "Payment Method";
    begin
        PaymentMethod.RESET;
        PaymentMethod.SETFILTER("Credit card Machine Code", '%1', CRCDMachineCode);
        PaymentMethod.SETFILTER(PaymentMethod."Pay Type", '%1', PaymentMethod."Pay Type"::"Debit Card");
        //PaymentMethod.SETFILTER("Branch Code",'%1',"Responsibility Center New 1");
        IF PaymentMethod.FINDFIRST THEN BEGIN
            ValidateServiceChargeAc(PaymentMethod.Code);
            EXIT(PaymentMethod.Code);
        END
        ELSE
            ERROR('Credit Card Machine Code not Defined');
        EXIT('');
    end;

    procedure ValidateServiceChargeAc(payMethod: Code[10]): Code[10]
    var
        MethodCode: Code[20];
    begin
        PaymentMethod.GET(payMethod);
        IF PaymentMethod."Bal. Account No." = '' THEN
            ERROR('Bal. Account No. is not defined for Payment Method %1', payMethod);
        //IF PaymentMethod."Service Charge Account No." = '' THEN
        // ERROR('Service Charge Account No. is not defined for Payment Method %1',payMethod);
        //IF PaymentMethod."Service Charge Perc" = 0 THEN
        // ERROR('Service Charge Perc is not defined for Payment Method %1',payMethod);
        VALIDATE(TotalPayByCustomer);
    end;

    procedure GetCreditCardMethod(CRCDMachineCode: Code[20]): Code[10]
    var
        PaymentMethod: Record "Payment Method";
    begin
        PaymentMethod.RESET;
        PaymentMethod.SETFILTER("Credit card Machine Code", '%1', CRCDMachineCode);
        PaymentMethod.SETFILTER(PaymentMethod."Pay Type", '%1', PaymentMethod."Pay Type"::"Credit Card");
        //PaymentMethod.SETFILTER("Branch Code",'%1',"Responsibility Center New 1");
        IF PaymentMethod.FINDFIRST THEN BEGIN
            ValidateServiceChargeAc(PaymentMethod.Code);
            EXIT(PaymentMethod.Code);
        END
        ELSE
            ERROR('Credit Card Machine Code not Defined');
        EXIT('');
    end;

    procedure UpdateCustomerTotal()
    var
        SalesOrderExtension: Record "Sales Order Extension";
    begin
        //CALCFIELDS("Maple Buyback Amt");

        //KPPLDG00033
        SalesOrderExtension.RESET;
        IF SalesOrderExtension.GET(Rec."Document Type", Rec."No.") THEN BEGIN
            ServifyTransferAmount := SalesOrderExtension."Servify Transfer Amount";
            ServifyBonusAmount := SalesOrderExtension."Servify Bonus Amount";
            PaytmTransferAmount := SalesOrderExtension."Paytm Transfer Amount";
        END;
        //KPPLDG00033

        TotalPayByCustomer := PayByCashAmt + PayByCreditAmt1 + PayByCreditAmt2 + PayByCreditAmt3 + PayByCreditAmt4 + PayByDebitAmt2 + PayByDebitCdAmt1 + PayByChqAmt + GiftVoucherAmt + "RTGS Amount" + "Finance Amount" + "Maple Buyback Amt" + "Apple Buyback Amt"
        + "Paytm Transfer Amount" + "Amazon Transfer Amount" + "Insurance Transfer Amount" + "Cashify Transfer Amount" + "Pinelab Transfer Amount" + "Loyalty Riwardz Tr.Amount" + ServifyTransferAmount + PaytmTransferAmount + "Cashify Bonus Amount" + ServifyBonusAmount;//tk

        //CALCFIELDS("Total Shield Value");
        //TotalPayByCustomer := TotalPayByCustomer + "Total Shield Value";
        //WBU.RefreshPage();

    end;

    procedure UpdateServifyDetails(ParamServifyApprovalCode: Code[12]; ParamServifyTransferAmount: Decimal; ParamServifyMethodCode: Code[10])
    var
        SalesOrderExtension: Record 50026;
    begin
        //KPPLDG00023
        SalesOrderExtension.Reset;
        if SalesOrderExtension.Get(Rec."Document Type", Rec."No.") then begin
            SalesOrderExtension."Servify Approval Code" := ParamServifyApprovalCode;
            SalesOrderExtension."Servify Transfer Amount" := ParamServifyTransferAmount;
            SalesOrderExtension.ServifyMethodCode := ParamServifyMethodCode;
            SalesOrderExtension.Modify;
        end else begin
            SalesOrderExtension.Init;
            SalesOrderExtension."Document Type" := Rec."Document Type";//tk
            SalesOrderExtension."No." := "No.";
            SalesOrderExtension."Servify Approval Code" := ParamServifyApprovalCode;
            SalesOrderExtension."Servify Transfer Amount" := ParamServifyTransferAmount;
            SalesOrderExtension.ServifyMethodCode := ParamServifyMethodCode;
            SalesOrderExtension.Insert;
        end;
        ServifyTransferAmount := ParamServifyTransferAmount;
        ValidateServiceChargeAc(ParamServifyMethodCode);
        UpdateCustomerTotal;
    end;


    procedure UpdatePaytmDetails(ParamPaytmApprovalCode: Code[10]; ParamPaytmTransferAmount: Decimal; ParamPaytmMethodCode: Code[10])
    var
        SalesOrderExtension: Record 50026;
    begin
        //KPPLDG00033
        SalesOrderExtension.Reset;
        if SalesOrderExtension.Get(Rec."Document Type", Rec."No.") then begin
            SalesOrderExtension."Paytm Approval Code" := ParamPaytmApprovalCode;
            SalesOrderExtension."Paytm Transfer Amount" := ParamPaytmTransferAmount;
            SalesOrderExtension.PaytmMethodCode := ParamPaytmMethodCode;
            SalesOrderExtension.Modify;
        end else begin
            SalesOrderExtension.Init;
            SalesOrderExtension."Document Type" := Rec."Document Type";//tk
            SalesOrderExtension."No." := "No.";
            SalesOrderExtension."Paytm Approval Code" := ParamPaytmApprovalCode;
            SalesOrderExtension."Paytm Transfer Amount" := ParamPaytmTransferAmount;
            SalesOrderExtension.PaytmMethodCode := ParamPaytmMethodCode;
            SalesOrderExtension.Insert;
        end;
        PaytmTransferAmount := ParamPaytmTransferAmount;
        ValidateServiceChargeAc(ParamPaytmMethodCode);
        UpdateCustomerTotal;
    end;

    local procedure ValidateServiceChargeBonusAc(payMethod: Code[10]): Code[10]
    var
        MethodCode: Code[20];
    begin
        PaymentMethod.Get(payMethod);
        if PaymentMethod."Bal. Account No." = '' then
            Error('Bal. Account No. is not defined for Payment Method %1', payMethod);
        //IF PaymentMethod."Service Charge Account No." = '' THEN
        // ERROR('Service Charge Account No. is not defined for Payment Method %1',payMethod);
        //IF PaymentMethod."Service Charge Perc" = 0 THEN
        // ERROR('Service Charge Perc is not defined for Payment Method %1',payMethod);
        Validate(TotalPayByCustomer);
    end;


    procedure UpdateServifyBonusDetails(ParamServifyApprovalCode: Code[12]; ParamServifyTransferAmount: Decimal; ParamServifyMethodCode: Code[10])
    var
        SalesOrderExtension: Record 50026;
    begin
        //KPPLDG00023
        SalesOrderExtension.Reset;
        if SalesOrderExtension.Get(Rec."Document Type", Rec."No.") then begin
            SalesOrderExtension."Servify Approval Code" := ParamServifyApprovalCode;
            SalesOrderExtension."Servify Bonus Amount" := ParamServifyTransferAmount;//1
            SalesOrderExtension.ServifyBonusMethodCode := ParamServifyMethodCode;
            SalesOrderExtension.Modify;
        end else begin
            SalesOrderExtension.Init;
            SalesOrderExtension."Document Type" := Rec."Document Type";//tk
            SalesOrderExtension."No." := "No.";
            SalesOrderExtension."Servify Approval Code" := ParamServifyApprovalCode;
            SalesOrderExtension."Servify Bonus Amount" := ParamServifyTransferAmount;
            SalesOrderExtension.ServifyBonusMethodCode := ParamServifyMethodCode;
            SalesOrderExtension.Insert;
        end;
        ServifyBonusAmount := ParamServifyTransferAmount;
        ValidateServiceChargeAc(ParamServifyMethodCode);
        UpdateCustomerTotal;
    end;

    procedure PostSchemeJVBatch(SalesHeaderLocal: Record "Sales Header"; SalesInvoiceNo: Code[20])
    var

        VendorRec: Record Vendor;
        GenJnlLineLocal: Record "Gen. Journal Line";
        GenJnlPostBatch: Codeunit "Gen. Jnl.-Post Batch";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SalesLineLocal: Record "Sales Line";

    begin
        SalesLineLocal.RESET;
        SalesLineLocal.SETFILTER("Document Type", '%1', SalesHeaderLocal."Document Type");
        SalesLineLocal.SETFILTER("Document No.", '%1', SalesHeaderLocal."No.");
        SalesLineLocal.SETFILTER("Scheme Amount", '<>%1', 0);
        IF SalesLineLocal.FINDFIRST THEN BEGIN
            REPEAT
                SalesSetup.GET;
                SalesSetup.TESTFIELD("Scheme Template");
                SalesSetup.TESTFIELD("Scheme Batch");
                GenJnlLineLocal.RESET;
                GenJnlLineLocal.SETFILTER("Journal Template Name", SalesSetup."Scheme Template");
                GenJnlLineLocal.SETFILTER("Journal Batch Name", SalesSetup."Scheme Batch");
                GenJnlLineLocal.DELETEALL;
                GenJnlLineLocal.INIT;
                GenJnlLineLocal.VALIDATE("Journal Template Name", SalesSetup."Scheme Template");
                GenJnlLineLocal.VALIDATE("Journal Batch Name", SalesSetup."Scheme Batch");
                GenJnlLineLocal."Line No." := SalesLineLocal."Line No.";
                GenJnlLineLocal."Posting Date" := SalesHeaderLocal."Document Date";
                GenJnlLineLocal."Document Date" := SalesHeaderLocal."Document Date";
                ;
                GenJnlLineLocal."Shortcut Dimension 1 Code" := SalesLineLocal."Shortcut Dimension 1 Code";
                GenJnlLineLocal."Shortcut Dimension 2 Code" := SalesLineLocal."Shortcut Dimension 2 Code";
                GenJnlLineLocal."Dimension Set ID" := SalesLineLocal."Dimension Set ID";
                GenJnlLineLocal."Account Type" := GenJnlLineLocal."Account Type"::"G/L Account";
                VendorRec.GET(SalesLineLocal."Scheme Vendor");
                VendorRec.TESTFIELD("Scheme Provisional A/C");
                GenJnlLineLocal."Account No." := VendorRec."Scheme Provisional A/C";
                GenJnlLineLocal."Document Type" := GenJnlLineLocal."Document Type"::" ";
                GenJnlLineLocal."Bal. Account Type" := GenJnlLineLocal."Bal. Account Type"::"G/L Account";
                SalesSetup.GET;
                SalesSetup.TESTFIELD("Incentive & Claim A/C");
                SalesSetup.TESTFIELD("Provisional Claim Nos");
                SalesSetup.TESTFIELD("Posted Prov. Claim Nos");
                GenJnlLineLocal."Bal. Account No." := SalesSetup."Incentive & Claim A/C";
                GenJnlLineLocal."Document No." := NoSeriesMgt.GetNextNo(SalesSetup."Provisional Claim Nos", SalesLineLocal."Posting Date", TRUE);
                GenJnlLineLocal."External Document No." := SalesInvoiceNo;
                GenJnlLineLocal."Currency Code" := SalesLineLocal."Currency Code";
                GenJnlLineLocal.Amount := SalesLineLocal."Scheme Amount";
                GenJnlLineLocal."Scheme Code" := SalesLineLocal."Scheme Code";
                GenJnlLineLocal."Scheme Amount" := SalesLineLocal."Scheme Amount";
                //GenJnlLineLocal."Posting No. Series" := SalesSetup."Posted Prov. Claim Nos";
                GenJnlLineLocal.INSERT;
            //GenJnlPost.RunWithCheck(GenJnlLineLocal);
            UNTIL SalesLineLocal.NEXT = 0;
            GenJnlPostBatch.RUN(GenJnlLineLocal); //  GenJnlPost.RunWithCheck(GenJnlLineLocal);
        END;
    end;

}
