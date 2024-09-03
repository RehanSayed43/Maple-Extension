tableextension 50064 "Sales Invoice Header" extends "Sales Invoice Header"
{
    fields
    {
        field(50000; "Ref. Invoice No. old"; Code[20])
        {
            Description = 'Win127';
        }
        field(50001; "Shield Invoice"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Sales Invoice Header" WHERE("Ref. Invoice No." = FIELD("No."),
                                                              Shield = CONST(True)));

        }
        field(50006; "Sales Order Type"; Option)
        {
            Description = 'Win127';
            OptionCaption = ' ,Retail,Rental,B2B,AMC,Service,Retail Buyback,Online';
            OptionMembers = " ",Retail,Rental,B2B,AMC,Service,"Retail Buyback",Online;
        }
        field(50007; Shield; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Max("Sales Invoice Line".Shield WHERE("Document No." = FIELD("No.")));
            Description = 'Win127';

        }
        field(50008; "Shield Posting No."; Code[20])
        {
        }
        field(50009; "Cust. Mobile No."; Text[30])
        {
        }
        field(50010; "Cust. email ID"; Text[50])
        {
        }
        field(50011; "Customer Name"; Text[50])
        {
        }
        field(50012; "Product Bar Code"; Code[20])
        {

            trigger OnValidate()
            var
                LineNo: Integer;
            begin
            end;
        }
        field(50013; PayByCashAmt; Decimal)
        {

            trigger OnValidate()
            begin
                TESTFIELD("CashPay Method Code");
                VALIDATE(TotalPayByCustomer);
            end;
        }
        field(50014; "CashPay Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";

            trigger OnValidate()
            var
                SEPADirectDebitMandate: Record 1230;
            //   DOPaymentTransLogEntry: Record "829";
            begin
            end;
        }
        field(50015; PayByCreditNo1; Code[20])
        {
        }
        field(50016; "CreditCdPay Method Code1"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";

            trigger OnValidate()
            var
                SEPADirectDebitMandate: Record 1230;
            //  DOPaymentTransLogEntry: Record "829";
            begin
            end;
        }
        field(50017; PayByCreditNo2; Code[16])
        {
            Description = 'changed from 20 WIN-234';
        }
        field(50018; PayByCreditNo3; Code[10])
        {
            Description = 'changed from 20 Win-234';
        }
        field(50019; PayByCreditNo4; Code[10])
        {
            Description = 'changed from 20 Win-234';
        }
        field(50020; PayByCreditAmt1; Decimal)
        {

            trigger OnValidate()
            begin
                TESTFIELD("CreditCdPay Method Code1");
                VALIDATE(TotalPayByCustomer);
            end;
        }
        field(50021; PayByCreditAmt2; Decimal)
        {

            trigger OnValidate()
            begin
                TESTFIELD("CreditCdPay Method Code1");
                VALIDATE(TotalPayByCustomer);
            end;
        }
        field(50022; PayByCreditAmt3; Decimal)
        {

            trigger OnValidate()
            begin
                TESTFIELD("CreditCdPay Method Code1");
                VALIDATE(TotalPayByCustomer);
            end;
        }
        field(50023; PayByCreditAmt4; Decimal)
        {

            trigger OnValidate()
            begin
                TESTFIELD("CreditCdPay Method Code1");
                VALIDATE(TotalPayByCustomer);
            end;
        }
        field(50024; PayByDebitCdNo1; Code[16])
        {
            Description = 'changed from 20 WIN-234';
        }
        field(50025; PayByDebitCdAmt1; Decimal)
        {

            trigger OnLookup()
            begin
                TESTFIELD("DebitCdPay Method Code1");
            end;

            trigger OnValidate()
            begin
                VALIDATE(TotalPayByCustomer);
            end;
        }
        field(50026; PayByChqNo; Code[15])
        {
            Description = 'changed from 20 Win-234';
        }
        field(50027; PayByChqDt; Date)
        {
        }
        field(50028; PayByChqAmt; Decimal)
        {

            trigger OnValidate()
            begin
                TESTFIELD("ChqPay Method Code");
                VALIDATE(TotalPayByCustomer);
            end;
        }
        field(50029; GiftVoucherAmt; Decimal)
        {

            trigger OnValidate()
            begin
                TESTFIELD("GiftPay Method Code");
                VALIDATE(TotalPayByCustomer);
            end;
        }
        field(50030; "RTGS Ref. No."; Code[20])
        {
        }
        field(50031; "RTGS Bank Name"; Text[30])
        {
        }
        field(50032; "RTGS Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                TESTFIELD("RTGSPay Method Code");
                VALIDATE(TotalPayByCustomer);
            end;
        }
        field(50033; "Finance Comapny"; Text[30])
        {
        }
        field(50034; "Bank Approval Code"; Code[20])
        {
        }
        field(50035; "Finance Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                TESTFIELD("FinPay Method Code");
                VALIDATE(TotalPayByCustomer);
            end;
        }
        field(50036; TotalPayByCustomer; Decimal)
        {

            trigger OnValidate()
            begin
                TotalPayByCustomer := PayByCashAmt + PayByCreditAmt1 + PayByCreditAmt2 + PayByCreditAmt3 + PayByCreditAmt4 + PayByDebitCdAmt1 + PayByChqAmt + GiftVoucherAmt + "RTGS Amount" + "Finance Amount";
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
                SEPADirectDebitMandate: Record 1230;
            // DOPaymentTransLogEntry: Record "829";
            begin
                /*
                IF DOPaymentTransLogEntry.FINDFIRST THEN
                  DOPaymentTransLogMgt.ValidateHasNoValidTransactions("Document Type",FORMAT("Document Type"),"No.");
                IF DOPaymentMgt.IsValidPaymentMethod(xRec."Payment Method Code") AND NOT DOPaymentMgt.IsValidPaymentMethod("Payment Method Code")
                THEN
                  TESTFIELD("Credit Card No.",'');
                PaymentMethod.INIT;
                IF "Payment Method Code" <> '' THEN
                  PaymentMethod.GET("Payment Method Code");
                IF PaymentMethod."Direct Debit" THEN BEGIN
                  IF "Direct Debit Mandate ID" = '' THEN
                    "Direct Debit Mandate ID" := SEPADirectDebitMandate.GetDefaultMandate("Bill-to Customer No.","Due Date");
                  IF "Payment Terms Code" = '' THEN
                    "Payment Terms Code" := PaymentMethod."Direct Debit Pmt. Terms Code";
                END;
                "Bal. Account Type" := PaymentMethod."Bal. Account Type";
                "Bal. Account No." := PaymentMethod."Bal. Account No.";
                IF "Bal. Account No." <> '' THEN BEGIN
                  TESTFIELD("Applies-to Doc. No.",'');
                  TESTFIELD("Applies-to ID",'');
                END;
                */

            end;
        }
        field(50040; "ChqPay Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";

            trigger OnValidate()
            var
                SEPADirectDebitMandate: Record 1230;
            // DOPaymentTransLogEntry: Record "829";
            begin
                /*
                IF DOPaymentTransLogEntry.FINDFIRST THEN
                  DOPaymentTransLogMgt.ValidateHasNoValidTransactions("Document Type",FORMAT("Document Type"),"No.");
                IF DOPaymentMgt.IsValidPaymentMethod(xRec."Payment Method Code") AND NOT DOPaymentMgt.IsValidPaymentMethod("Payment Method Code")
                THEN
                  TESTFIELD("Credit Card No.",'');
                PaymentMethod.INIT;
                IF "Payment Method Code" <> '' THEN
                  PaymentMethod.GET("Payment Method Code");
                IF PaymentMethod."Direct Debit" THEN BEGIN
                  IF "Direct Debit Mandate ID" = '' THEN
                    "Direct Debit Mandate ID" := SEPADirectDebitMandate.GetDefaultMandate("Bill-to Customer No.","Due Date");
                  IF "Payment Terms Code" = '' THEN
                    "Payment Terms Code" := PaymentMethod."Direct Debit Pmt. Terms Code";
                END;
                "Bal. Account Type" := PaymentMethod."Bal. Account Type";
                "Bal. Account No." := PaymentMethod."Bal. Account No.";
                IF "Bal. Account No." <> '' THEN BEGIN
                  TESTFIELD("Applies-to Doc. No.",'');
                  TESTFIELD("Applies-to ID",'');
                END;
                */

            end;
        }
        field(50041; "GiftPay Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";

            trigger OnValidate()
            var
                SEPADirectDebitMandate: Record 1230;
            //  DOPaymentTransLogEntry: Record "829";
            begin
                /*
                IF DOPaymentTransLogEntry.FINDFIRST THEN
                  DOPaymentTransLogMgt.ValidateHasNoValidTransactions("Document Type",FORMAT("Document Type"),"No.");
                IF DOPaymentMgt.IsValidPaymentMethod(xRec."Payment Method Code") AND NOT DOPaymentMgt.IsValidPaymentMethod("Payment Method Code")
                THEN
                  TESTFIELD("Credit Card No.",'');
                PaymentMethod.INIT;
                IF "Payment Method Code" <> '' THEN
                  PaymentMethod.GET("Payment Method Code");
                IF PaymentMethod."Direct Debit" THEN BEGIN
                  IF "Direct Debit Mandate ID" = '' THEN
                    "Direct Debit Mandate ID" := SEPADirectDebitMandate.GetDefaultMandate("Bill-to Customer No.","Due Date");
                  IF "Payment Terms Code" = '' THEN
                    "Payment Terms Code" := PaymentMethod."Direct Debit Pmt. Terms Code";
                END;
                "Bal. Account Type" := PaymentMethod."Bal. Account Type";
                "Bal. Account No." := PaymentMethod."Bal. Account No.";
                IF "Bal. Account No." <> '' THEN BEGIN
                  TESTFIELD("Applies-to Doc. No.",'');
                  TESTFIELD("Applies-to ID",'');
                END;
                */

            end;
        }
        field(50042; "RTGSPay Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";

            trigger OnValidate()
            var
                SEPADirectDebitMandate: Record 1230;
            //  DOPaymentTransLogEntry: Record "829";
            begin
                /*
                IF DOPaymentTransLogEntry.FINDFIRST THEN
                  DOPaymentTransLogMgt.ValidateHasNoValidTransactions("Document Type",FORMAT("Document Type"),"No.");
                IF DOPaymentMgt.IsValidPaymentMethod(xRec."Payment Method Code") AND NOT DOPaymentMgt.IsValidPaymentMethod("Payment Method Code")
                THEN
                  TESTFIELD("Credit Card No.",'');
                PaymentMethod.INIT;
                IF "Payment Method Code" <> '' THEN
                  PaymentMethod.GET("Payment Method Code");
                IF PaymentMethod."Direct Debit" THEN BEGIN
                  IF "Direct Debit Mandate ID" = '' THEN
                    "Direct Debit Mandate ID" := SEPADirectDebitMandate.GetDefaultMandate("Bill-to Customer No.","Due Date");
                  IF "Payment Terms Code" = '' THEN
                    "Payment Terms Code" := PaymentMethod."Direct Debit Pmt. Terms Code";
                END;
                "Bal. Account Type" := PaymentMethod."Bal. Account Type";
                "Bal. Account No." := PaymentMethod."Bal. Account No.";
                IF "Bal. Account No." <> '' THEN BEGIN
                  TESTFIELD("Applies-to Doc. No.",'');
                  TESTFIELD("Applies-to ID",'');
                END;
                */

            end;
        }
        field(50043; "FinPay Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";

            trigger OnValidate()
            var
                SEPADirectDebitMandate: Record 1230;
            //     DOPaymentTransLogEntry: Record "829";
            begin
                /*
                IF DOPaymentTransLogEntry.FINDFIRST THEN
                  DOPaymentTransLogMgt.ValidateHasNoValidTransactions("Document Type",FORMAT("Document Type"),"No.");
                IF DOPaymentMgt.IsValidPaymentMethod(xRec."Payment Method Code") AND NOT DOPaymentMgt.IsValidPaymentMethod("Payment Method Code")
                THEN
                  TESTFIELD("Credit Card No.",'');
                PaymentMethod.INIT;
                IF "Payment Method Code" <> '' THEN
                  PaymentMethod.GET("Payment Method Code");
                IF PaymentMethod."Direct Debit" THEN BEGIN
                  IF "Direct Debit Mandate ID" = '' THEN
                    "Direct Debit Mandate ID" := SEPADirectDebitMandate.GetDefaultMandate("Bill-to Customer No.","Due Date");
                  IF "Payment Terms Code" = '' THEN
                    "Payment Terms Code" := PaymentMethod."Direct Debit Pmt. Terms Code";
                END;
                "Bal. Account Type" := PaymentMethod."Bal. Account Type";
                "Bal. Account No." := PaymentMethod."Bal. Account No.";
                IF "Bal. Account No." <> '' THEN BEGIN
                  TESTFIELD("Applies-to Doc. No.",'');
                  TESTFIELD("Applies-to ID",'');
                END;
                */

            end;
        }
        field(50044; "Promo Code"; Code[10])
        {
        }
        field(50045; "Delivery Note"; Text[20])
        {
            Description = 'changed from 30 WIN-234';
        }
        field(50046; "Dispatch Doc. No."; Text[20])
        {
        }
        field(50047; "Dispatch Through"; Text[20])
        {
            Description = 'changed from 30 WIN-234';
        }
        field(50048; "Posted Shield Posting No."; Code[20])
        {
        }
        field(50059; "Ref. Invoice No."; Code[20])
        {
            Description = 'Win127';
        }
        field(50049; "Discount Type"; Code[20])
        {
            Caption = 'Discount Type';
            Description = '//CCIT-TK';
            Editable = false;
        }
        field(50056; "Entry No"; Integer)
        {
            Caption = 'Discount Type Entry No';
            Description = '//CCIT-TK';
            Editable = false;
        }
        field(50060; "Maple Buyback Amt"; Decimal)
        {
        }
        field(50061; "Maple Buyback Method Code"; Code[10])
        {
        }
        field(50062; "Apple Buyback Amt"; Decimal)
        {
        }
        field(50063; "Apple Buyback method  Code"; Code[10])
        {
        }
        field(50064; "Vendor No."; Code[20])
        {
        }
        field(50065; "Inward Location"; Code[10])
        {
        }
        field(50066; "Vendor Item"; Code[20])
        {
            TableRelation = Item;
        }
        field(50067; "Party Item Price"; Decimal)
        {
        }
        field(50068; "Party No"; Code[20])
        {
            TableRelation = Customer;
        }
        field(50069; "Party Sales Location"; Code[10])
        {
            TableRelation = Location;
        }
        field(50070; "Party Address"; Text[46])
        {
            Description = '//changed from 50 to 46';
        }
        field(50071; "Party City"; Text[20])
        {
            Description = 'changed from 30 WIN-234';
        }
        field(50072; "Party Name"; Text[30])
        {
        }
        field(50073; BuyBackType; Option)
        {
            OptionCaption = ' ,Mapple,Apple';
            OptionMembers = " ",Mapple,Apple;
        }
        field(50074; "Apple Refund Amt"; Decimal)
        {
        }
        field(50075; "Apple Refund Method Code"; Code[10])
        {
        }
        field(50076; CreditCardNo1; Code[4])
        {

            trigger OnValidate()
            begin
                PayByCreditAmt1 := 0;
            end;
        }
        field(50077; CreditCardNo2; Code[4])
        {

            trigger OnValidate()
            begin
                PayByCreditAmt2 := 0;
            end;
        }
        field(50078; CreditCardNo3; Code[4])
        {

            trigger OnValidate()
            begin
                PayByCreditAmt3 := 0;
            end;
        }
        field(50079; CreditCardNo4; Code[4])
        {

            trigger OnValidate()
            begin
                PayByCreditAmt4 := 0;
            end;
        }
        field(50080; PurchaseLineExist; Integer)
        {

            FieldClass = FlowField;
            CalcFormula = Count("Purchase Line" WHERE("No." = FILTER(<> ''),
                                                    "Retail Buyback Ref. No." = FIELD("No.")));
        }
        field(50081; DebitCardNo2; Code[4])
        {

            trigger OnValidate()
            begin
                PayByDebitAmt2 := 0;
            end;
        }
        field(50082; PayByDebitNo2; Code[10])
        {
            Description = 'changed from 20 WIN-234';
            //  TableRelation = "Standard Text" WHERE (Field50001=FILTER(<>''));
        }
        field(50083; PayByDebitAmt2; Decimal)
        {
        }
        field(50084; "CreditCdPay Method Code2"; Code[10])
        {
            Caption = 'Payment Method Code';
            // TableRelation = "Payment Method" WHERE (RAHUL=CONST(3));

            trigger OnValidate()
            var
                SEPADirectDebitMandate: Record 1230;
            //   DOPaymentTransLogEntry: Record "829";
            begin
            end;
        }
        field(50085; "CreditCdPay Method Code3"; Code[10])
        {
            Caption = 'Payment Method Code';
            //  TableRelation = "Payment Method" WHERE (RAHUL=CONST(3));

            trigger OnValidate()
            var
                SEPADirectDebitMandate: Record 1230;
            // DOPaymentTransLogEntry: Record "829";
            begin
            end;
        }
        field(50086; "CreditCdPay Method Code4"; Code[10])
        {
            Caption = 'Payment Method Code';
            //  TableRelation = "Payment Method" WHERE (RAHUL=CONST(3));

            trigger OnValidate()
            var
                SEPADirectDebitMandate: Record 1230;
            //    DOPaymentTransLogEntry: Record "829";
            begin
            end;
        }
        field(50087; "DebitCdPay Method Code2"; Code[10])
        {
            Caption = 'Payment Method Code';
            //    TableRelation = "Payment Method" WHERE (RAHUL=CONST(3));

            trigger OnValidate()
            var
                SEPADirectDebitMandate: Record 1230;
            //  DOPaymentTransLogEntry: Record "829";
            begin
            end;
        }
        field(50088; "PurchaseOrderNo."; Code[1])
        {
            Description = '//changed from 20 WIN234';
        }
        field(50089; "Total Shield Value"; Decimal)
        {
        }
        field(50091; "FA Disposal"; Boolean)
        {
        }
        field(50092; "Group Credit Limit Hold"; Boolean)
        {
        }
        field(50093; "Transfer Shipment No."; Code[20])
        {
            // TableRelation = "Transfer Shipment Header"."No." WHERE (Field50003=FIELD("Sell-to Customer No."));
        }
        field(50094; BuybackRefundDistributor; Code[10])
        {
            Description = '//changed from 20 WIN234';
            //  TableRelation = Vendor WHERE (Field51020=CONST(true));
        }
        field(50095; DebitCardNo1; Code[12])
        {
            Description = '//changed from 4 to 12';
        }
        field(50096; CreditSale; Boolean)
        {
        }
        field(50097; WebUserID; Code[5])
        {
        }
        field(50099; "Debit Note"; Boolean)
        {
        }
        field(50100; "Finance Comapny new"; Option)
        {
            OptionCaption = ' ,BAJAJ FINANCE,HDFC,CITI FINANCE,DCEMI';
            OptionMembers = " ","BAJAJ FINANCE",HDFC,"CITI FINANCE",DCEMI;
        }
        field(50101; "Amount To Customer UPIT"; Decimal)
        {
        }
        field(50102; "Capillary Discount Amount"; Decimal)
        {
            Description = 'CAPILARY';
            Editable = false;
        }
        field(50103; "Capillary Posted"; Boolean)
        {
            Description = 'CAPILARY';
            Editable = false;
        }
        field(50105; "Paytm Approval Code"; Code[10])
        {
        }
        field(50106; "Paytm Transfer Amount"; Decimal)
        {
        }
        field(50107; paytmMethodCode; Code[10])
        {
        }
        field(50108; "Amazon Approval Code"; Code[10])
        {
        }
        field(50109; "Amazon Transfer Amount"; Decimal)
        {
        }
        field(50110; ExMethodCode; Code[10])
        {
        }
        field(50111; "T.I.N. No."; Code[20])
        {
        }
        field(50112; "Address 3"; Text[50])
        {
        }
        field(50113; "Capillary Transaction Id"; Text[5])
        {
            Description = 'CAPILARY';
            Editable = false;
        }
        field(50114; "Capillary Error"; Text[5])
        {
            Description = 'CAPILARY';
            Editable = false;
        }
        field(50115; "Order ID"; Code[20])
        {
            Description = 'E commerce';
            Editable = false;
        }
        field(50116; "Insurance Approval Code"; Code[20])
        {
        }
        field(50117; "Insurance Transfer Amount"; Decimal)
        {
        }
        field(50118; InsuranceMethodCode; Code[10])
        {
        }
        field(50120; "Cashify Approval Code"; Code[15])
        {
            Description = 'changed from 10 WIN-234';
        }
        field(50121; "Cashify Transfer Amount"; Decimal)
        {
        }
        field(50122; CashifyMethodCode; Code[10])
        {
        }
        field(50123; "Pinelab Transfer Amount"; Decimal)
        {
            Description = 'WIN316';
            Editable = false;
        }
        field(50124; PinelabMethodCode; Code[10])
        {
            Description = 'WIN316';
            Editable = false;
        }
        field(50125; "Pinelab Approval Code"; Code[10])
        {
            Description = 'WIN316';
            Editable = false;
        }
        field(50126; "Loyalty Riwardz Tr.Amount"; Decimal)
        {
            Description = 'WIN234';
        }
        field(50127; "Loyalty Riwardz Method Code"; Code[10])
        {
            Description = 'WIN234';
        }
        field(50128; "Loyalty Riwardz Approval Code"; Code[10])
        {
            Description = 'WIN234';
        }
        field(50129; "Mobile Type"; Option)
        {
            Description = 'WIN234';
            OptionCaption = ' ,Apple,Other';
            OptionMembers = " ",Apple,Other;
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
        field(50199; "Sales Invoice Time"; DateTime)
        {
        }
        field(50200; "E-Invoice Cancel Remark"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'E-Invoice';
        }
        field(50201; "E-Invoice Reason Code"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'E-Invoice';
            OptionCaption = ' ,Duplicate,Order Cancelled,Data Entry Mistake,Other';
            OptionMembers = "0","1","2","3","4";
        }
        field(50202; "IRN No."; Text[64])
        {
            DataClassification = ToBeClassified;
            Description = 'E-Invoice';
            Editable = false;
        }
        field(50203; "Acknowledgement No"; Text[20])
        {
            DataClassification = ToBeClassified;
            Description = 'E-Invoice';
            Editable = false;
        }
        field(50204; "Acknowledgement Date1"; Text[10])
        {
            DataClassification = ToBeClassified;
            Description = 'E-Invoice';
            Editable = false;
        }
        field(50205; "E-Invocie Cancel Date"; Text[10])
        {
            DataClassification = ToBeClassified;
            Description = 'E-Invoice';
        }
        field(50206; Distance; Decimal)
        {
            Description = 'Eway Bill';
        }
        field(50207; "E-Way Bill No"; Code[20])
        {
            Description = 'Eway Bill';
        }
        field(50208; "E-Way Bill Date"; DateTime)
        {
            Description = 'Eway Bill';
        }
        field(50219; "E-Way Bill Date ValidTill"; DateTime)
        {
            Description = 'E-Way Bill Date ValidTill';
        }

        field(50210; "Cancel Reason Code"; Option)
        {
            Description = 'Eway Bill';
            OptionCaption = ' ,Duplicate,Order Cancelled,Data Entry Mistake,Other';
            OptionMembers = "0","1","2","3","4";
        }
        field(50211; "Cancel Remark"; Text[20])
        {
            Description = 'Eway Bill';
        }
        field(50212; "Voucher Amount"; Decimal)
        {
            Description = 'Voucher Integration';
        }
        field(50213; "Email Sent"; Boolean)
        {
        }
        field(50214; "IS LOB Order"; Boolean)
        {
            Description = 'LOB';
        }
        field(50216; "transaction_id"; code[50])
        {
        }
        field(50217; "payment_method"; code[20])
        {
        }

        field(50218; "payment_method_title"; code[80])
        {
        }
        field(50251; "E-Inv Cancelled"; Boolean)
        {
        }

        field(50252; "Eway Cancelled"; Boolean)
        {

        }
        field(50220; "Servify Transfer Amount"; Decimal)
        {

        }
        field(50221; "Servify Bonus Amount"; Decimal)
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
        field(50300; "Shipping Label"; Text[2048])
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
    }
}
