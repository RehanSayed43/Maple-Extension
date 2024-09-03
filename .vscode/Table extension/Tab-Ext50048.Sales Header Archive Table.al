tableextension 50048 "Sales Header Archive Table" extends "Sales Header Archive"
{
    fields
    {
        field(50000; "Credit Hold"; Boolean)
        {
            CalcFormula = Max("Sales Line"."Credit Hold" WHERE("Document No." = FIELD("No."),
                                                                "Document Type" = FIELD("Document Type")));
            Description = 'Win127';
            FieldClass = FlowField;
            InitValue = false;
        }
        field(50001; "Overdue Hold"; Boolean)
        {
            CalcFormula = Max("Sales Line"."Overdue Hold" WHERE("Document No." = FIELD("No."),
                                                                 "Document Type" = FIELD("Document Type")));
            Description = 'Win127';
            FieldClass = FlowField;
        }
        field(50002; "Price Hold"; Boolean)
        {
            CalcFormula = Max("Sales Line"."Price Hold" WHERE("Document No." = FIELD("No."),
                                                               "Document Type" = FIELD("Document Type")));
            Description = 'Win127';
            FieldClass = FlowField;
        }
        field(50003; "Credit Days Hold"; Boolean)
        {
            Description = 'Win127';
        }
        field(50004; "PDC Hold"; Boolean)
        {
            CalcFormula = Max("Sales Line"."PDC Hold" WHERE("Document No." = FIELD("No."),
                                                             "Document Type" = FIELD("Document Type")));
            Description = 'Win127';
            FieldClass = FlowField;
        }
        field(50005; "Discount Hold"; Boolean)
        {
            CalcFormula = Max("Sales Line"."Discount Hold" WHERE("Document No." = FIELD("No."),
                                                                  "Document Type" = FIELD("Document Type")));
            Description = 'Win127';
            FieldClass = FlowField;
        }
        field(50006; "Sales Order Type"; Option)
        {
            Description = 'Win127';
            InitValue = Rental;
            OptionCaption = 'Retail,Rental,B2B,AMC,Service';
            OptionMembers = Retail,Rental,B2B,AMC,Service;
        }
        field(50007; Shield; Boolean)
        {
            CalcFormula = Max("Sales Line".Shield WHERE("Document Type" = FIELD("Document Type"),
                                                         "Document No." = FIELD("No.")));
            Description = 'Win127';
            FieldClass = FlowField;
        }
        field(50008; "Shield Posting No."; Code[20])
        {
        }
        field(50009; "Cust. Mobile No."; Text[30])
        {
        }
        field(50010; "Cust. email ID"; Text[150])
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
                ILE: Record "Item Ledger Entry";
            begin
            end;
        }
        field(50013; PayByCashAmt; Decimal)
        {
        }
        field(50014; "CashPay Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";

            trigger OnValidate()
            var
                SEPADirectDebitMandate: Record "SEPA Direct Debit Mandate";
            //         DOPaymentTransLogEntry: Record "829";
            begin
            end;
        }
        field(50015; PayByCreditNo1; Code[20])
        {

            trigger OnValidate()
            begin
                //PayByCreditAmt1 :=0;
            end;
        }
        field(50016; "CreditCdPay Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";

            trigger OnValidate()
            var
                SEPADirectDebitMandate: Record "SEPA Direct Debit Mandate";
            //     DOPaymentTransLogEntry: Record "829";
            begin
            end;
        }
        field(50017; PayByCreditNo2; Code[20])
        {

            trigger OnValidate()
            begin
                //PayByCreditAmt2 :=0;
            end;
        }
        field(50018; PayByCreditNo3; Code[20])
        {

            trigger OnValidate()
            begin
                //PayByCreditAmt3 :=0;
            end;
        }
        field(50019; PayByCreditNo4; Code[20])
        {

            trigger OnValidate()
            begin
                //PayByCreditAmt4 := 0;
            end;
        }
        field(50020; PayByCreditAmt1; Decimal)
        {

            trigger OnValidate()
            begin
                //TESTFIELD(PayByCreditNo1);
                //"CreditCdPay Method Code" := ValidatePaymentMethod(PaymentMethod."Pay Type"::"Credit Card",PayByCreditAmt1);
            end;
        }
        field(50021; PayByCreditAmt2; Decimal)
        {

            trigger OnValidate()
            begin
                //TESTFIELD(PayByCreditNo2);
                //"CreditCdPay Method Code" := ValidatePaymentMethod(PaymentMethod."Pay Type"::"Credit Card",PayByCreditAmt2);
            end;
        }
        field(50022; PayByCreditAmt3; Decimal)
        {

            trigger OnValidate()
            begin
                //TESTFIELD(PayByCreditNo3);
                //"CreditCdPay Method Code" := ValidatePaymentMethod(PaymentMethod."Pay Type"::"Credit Card",PayByCreditAmt3);
            end;
        }
        field(50023; PayByCreditAmt4; Decimal)
        {

            trigger OnValidate()
            begin
                //TESTFIELD(PayByCreditNo4);
                //"CreditCdPay Method Code" := ValidatePaymentMethod(PaymentMethod."Pay Type"::"Credit Card",PayByCreditAmt4);
            end;
        }
        field(50024; PayByDebitNo; Code[20])
        {

            trigger OnValidate()
            begin
                PayByDebitAmt := 0;
            end;
        }
        field(50025; PayByDebitAmt; Decimal)
        {
        }
        field(50026; PayByChqNo; Code[20])
        {

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
        }
        field(50029; GiftVoucherAmt; Decimal)
        {

            trigger OnValidate()
            begin
                // "GiftPay Method Code" := ValidatePaymentMethod(PaymentMethod."Pay Type"::"Gift Voucher",GiftVoucherAmt);
            end;
        }
        field(50030; "RTGS Ref. No."; Code[20])
        {

            trigger OnValidate()
            begin
                //"RTGS Amount" := 0;
            end;
        }
        field(50031; "RTGS Bank Name"; Text[30])
        {

            trigger OnValidate()
            begin
                //"RTGS Amount" := 0;
            end;
        }
        field(50032; "RTGS Amount"; Decimal)
        {
        }
        field(50033; "Finance Comapny"; Text[30])
        {

            trigger OnValidate()
            begin
                // "Finance Amount" := 0;
            end;
        }
        field(50034; "Bank Approval Code"; Code[20])
        {

            trigger OnValidate()
            begin
                // "Finance Amount" := 0;
            end;
        }
        field(50035; "Finance Amount"; Decimal)
        {
        }
        field(50036; TotalPayByCustomer; Decimal)
        {

            trigger OnValidate()
            begin
                //TotalPayByCustomer := PayByCashAmt + PayByCreditAmt1+PayByCreditAmt2+PayByCreditAmt3+PayByCreditAmt4+PayByDebitAmt+PayByChqAmt+GiftVoucherAmt+"RTGS Amount"+"Finance Amount"+"Maple Buyback Amt"+"Apple Buyback Amt" ;
            end;
        }
        field(50037; "Buyer's Order No."; Code[30])
        {
        }
        field(50038; "Buyer's Order Dt"; Date)
        {
        }
        field(50039; "DebitCdPay Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";

            trigger OnValidate()
            var
                SEPADirectDebitMandate: Record "SEPA Direct Debit Mandate";
            //  DOPaymentTransLogEntry: Record "829";
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
            //    DOPaymentTransLogEntry: Record "829";
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
            //     DOPaymentTransLogEntry: Record "829";
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
            //     DOPaymentTransLogEntry: Record "829";
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
            //    DOPaymentTransLogEntry: Record "829";
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

            trigger OnValidate()
            begin
                //"Maple Buyback Method Code" := ValidatePaymentMethod(PaymentMethod."Pay Type"::"Maple BuyBack","Maple Buyback Amt");
            end;
        }
        field(50061; "Maple Buyback Method Code"; Code[10])
        {
        }
        field(50062; "Apple Buyback Amt"; Decimal)
        {

            trigger OnValidate()
            begin
                //"Apple Buyback method  Code" := ValidatePaymentMethod(PaymentMethod."Pay Type"::"Apple BuyBack","Apple Buyback Amt");
            end;
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
        field(50070; "Party Address"; Text[50])
        {
        }
        field(50071; "Party City"; Text[30])
        {
        }
        field(50072; "Party Name"; Text[30])
        {
        }
        field(50073; BuyBackType; Option)
        {
            OptionCaption = ' ,Maple,Apple';
            OptionMembers = " ",Maple,Apple;
        }
        field(50100; "Finance Comapny new"; Option)
        {
            OptionCaption = ' ,BAJAJ FINANCE,HDFC';
            OptionMembers = " ","BAJAJ FINANCE",HDFC;
        }
        field(50101; "Amount To Customer UPIT"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Total UPIT Amount" WHERE("Document Type" = FIELD("Document Type"),
                                                                      "Document No." = FIELD("No.")));
            FieldClass = FlowField;
        }
    }
}
