tableextension 50065 "Sales Cr.Memo Header" extends "Sales Cr.Memo Header"
{
    fields
    {
        field(50000; "Credit Hold"; Boolean)
        {
            Description = 'Win127';
            InitValue = false;
        }
        field(50001; "Overdue Hold"; Boolean)
        {
            Description = 'Win127';
        }
        field(50002; "Price Hold"; Boolean)
        {
            Description = 'Win127';
        }
        field(50003; "Credit Days Hold"; Boolean)
        {
            Description = 'Win127';
        }
        field(50004; "PDC Hold"; Boolean)
        {
            Description = 'Win127';
        }
        field(50005; "Discount Hold"; Boolean)
        {
            Description = 'Win127';
        }
        field(50006; "Sales Order Type"; Option)
        {
            Description = 'Win127';
            InitValue = Rental;
            OptionCaption = 'Retail,Rental,B2B,AMC,Service,Retail Buyback,Online';
            OptionMembers = Retail,Rental,B2B,AMC,Service,"Retail Buyback",Online;
        }
        field(50007; Shield; Boolean)
        {
            Description = 'Win127';
        }
        field(50008; "Shield Posting No."; Code[20])
        {
        }
        field(50009; "Cust. Mobile No."; Text[30])
        {
        }
        field(50010; "Cust. email ID"; Text[180])
        {
        }
        field(50011; "Customer Name"; Text[50])
        {
            TableRelation = Customer;
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
            // SEPADirectDebitMandate: Record "1230";
            // DOPaymentTransLogEntry: Record "829";
            begin
            end;
        }
        field(50015; PayByCreditNo1; Code[20])
        {
            TableRelation = "Standard Text" WHERE("Credit Cd Machine Code" = FILTER(<> ''));
        }
        field(50016; "CreditCdPay Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";

            trigger OnValidate()
            var
            // SEPADirectDebitMandate: Record "1230";
            // DOPaymentTransLogEntry: Record "829";
            begin
            end;
        }
        field(50017; PayByCreditNo2; Code[20])
        {

            trigger OnValidate()
            begin
                PayByCreditAmt2 := 0;
            end;
        }
        field(50018; PayByCreditNo3; Code[10])
        {
            Description = 'changed from 20 Win-234';

            trigger OnValidate()
            begin
                PayByCreditAmt3 := 0;
            end;
        }
        field(50019; PayByCreditNo4; Code[10])
        {
            Description = 'changed from 20 Win-234';
        }
        field(50020; PayByCreditAmt1; Decimal)
        {
        }
        field(50021; PayByCreditAmt2; Decimal)
        {
        }
        field(50022; PayByCreditAmt3; Decimal)
        {
        }
        field(50023; PayByCreditAmt4; Decimal)
        {
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
        field(50026; PayByChqNo; Code[15])
        {
            Description = 'changed from 20 Win-234';
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
                //"GiftPay Method Code" := ValidatePaymentMethod(PaymentMethod."Pay Type"::"Gift Voucher",GiftVoucherAmt);
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
                //TotalPayByCustomer := PayByCashAmt + PayByCreditAmt1+PayByCreditAmt2+PayByCreditAmt3+PayByCreditAmt4+PayByDebitAmt+PayByChqAmt+GiftVoucherAmt+"RTGS Amount"+"Finance Amount"+"Maple Buyback Amt"+"Apple Buyback Amt"+"Apple Refund Amt";
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
            // SEPADirectDebitMandate: Record "1230";
            // DOPaymentTransLogEntry: Record "829";
            begin
            end;
        }
        field(50040; "ChqPay Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";

            trigger OnValidate()
            var
            // SEPADirectDebitMandate: Record "1230";
            // DOPaymentTransLogEntry: Record "829";
            begin
            end;
        }
        field(50041; "GiftPay Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";

            trigger OnValidate()
            var
            // SEPADirectDebitMandate: Record "1230";
            // DOPaymentTransLogEntry: Record "829";
            begin
            end;
        }
        field(50042; "RTGSPay Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";

            trigger OnValidate()
            var
            // SEPADirectDebitMandate: Record "1230";
            // DOPaymentTransLogEntry: Record "829";
            begin
            end;
        }
        field(50043; "FinPay Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";

            trigger OnValidate()
            var
            // SEPADirectDebitMandate: Record "1230";
            // DOPaymentTransLogEntry: Record "829";
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
            CalcFormula = Sum("Purchase Line"."Direct Unit Cost" WHERE("Retail Buyback Ref. No." = FIELD("No.")));
            FieldClass = FlowField;

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
            TableRelation = Location;
        }
        field(50066; "Vendor Name"; Code[20])
        {
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
        field(50074; "Apple Refund Amt"; Decimal)
        {

            trigger OnValidate()
            begin
                //"Apple Refund Method Code" := ValidatePaymentMethod(PaymentMethod."Pay Type"::"Apple Refund","Apple Refund Amt");
            end;
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
        field(50081; CreditCardNo5; Code[4])
        {

            trigger OnValidate()
            begin
                PayByCreditAmt5 := 0;
            end;
        }
        field(50082; PayByCreditNo5; Code[20])
        {
            TableRelation = "Standard Text" WHERE("Credit Cd Machine Code" = FILTER(<> ''));
        }
        field(50083; PayByCreditAmt5; Decimal)
        {
        }
        field(50084; "CreditCdPay Method Code2"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method" WHERE("Pay Type" = CONST(3));

            trigger OnValidate()
            var
            // SEPADirectDebitMandate: Record "1230";
            // DOPaymentTransLogEntry: Record "829";
            begin
            end;
        }
        field(50085; "CreditCdPay Method Code3"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method" WHERE("Pay Type" = CONST(3));

            trigger OnValidate()
            var
            // SEPADirectDebitMandate: Record "1230";
            // DOPaymentTransLogEntry: Record "829";
            begin
            end;
        }
        field(50086; "CreditCdPay Method Code4"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method" WHERE("Pay Type" = CONST(3));

            trigger OnValidate()
            var
            // SEPADirectDebitMandate: Record "1230";
            // DOPaymentTransLogEntry: Record "829";
            begin
            end;
        }
        field(50087; "CreditCdPay Method Code5"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method" WHERE("Pay Type" = CONST(3));

            trigger OnValidate()
            var
            // SEPADirectDebitMandate: Record "1230";
            // DOPaymentTransLogEntry: Record "829";
            begin
            end;
        }
        field(50100; "Finance Comapny new"; Option)
        {
            OptionCaption = ' ,BAJAJ FINANCE,HDFC,CITI FINANCE,DCEMI';
            OptionMembers = " ","BAJAJ FINANCE",HDFC,"CITI FINANCE",DCEMI;
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
        field(50119; CRM; Boolean)
        {
            Description = 'WIN292';
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
        field(50131; "Casify Bonus Amount"; Decimal)
        {
        }
        field(50133; CashifyBonusMethodCode; Code[10])
        {
        }
        field(50199; "Sales Invoice Time"; DateTime)
        {
        }
        field(50200; "E-Invoice Cancel Remark"; Text[10])
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
        field(50203; "AcknowledgementNo."; Text[20])
        {
            DataClassification = ToBeClassified;
            Description = 'E-Invoice';
            Editable = false;
        }
        field(50204; "AcknowledgementDate"; Text[10])
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
        field(50251; "E-invoice Cancelled"; Boolean)
        {
            dataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}