tableextension 50005 "Sales Receivables Setup Table" extends "Sales & Receivables Setup"
{
    fields
    {
        field(50000; "Credit Limit Hold Active"; Boolean)
        {
            Caption = 'Credit Limit Hold Active';
            Description = 'win127';
            InitValue = false;
        }
        field(50001; "Overdue Hold Active"; Boolean)
        {
            Description = 'win127';
        }
        field(50002; "Discount Hold Active"; Boolean)
        {
            Description = 'win127';
        }
        field(50003; "Price Hold Active"; Boolean)
        {
            Description = 'win127';
        }
        field(50004; "PDC Hold Active"; Boolean)
        {
            Description = 'win127';
        }
        field(50005; "Credit Days Hold Active"; Boolean)
        {
            Description = 'win127';
        }
        field(50007; "VAT Declaration1"; Text[250])
        {
            Description = 'win127';
        }
        field(50008; "VAT Declaration2"; Text[250])
        {
            Description = 'win127';
        }
        field(50009; "VAT Declaration3"; Text[250])
        {
            Description = 'win127';
        }
        field(50010; "Insurance Declaration"; Text[250])
        {
            Description = 'win127';
        }
        field(50012; "Shield Sales Account"; Code[20])
        {
            TableRelation = "G/L Account" WHERE("Direct Posting" = CONST(true), "Account Type" = CONST(Posting), Blocked = CONST(false));
        }
        field(50014; "Cost of Goods Sold- Shield"; Code[20])
        {
            TableRelation = "G/L Account" WHERE("Direct Posting" = CONST(true), "Account Type" = CONST(Posting), Blocked = CONST(false));
        }
        field(50015; "Purchase Shield"; Code[20])
        {
            TableRelation = "G/L Account" WHERE("Direct Posting" = CONST(true), "Account Type" = CONST(Posting), Blocked = CONST(false));
        }
        field(50016; "Retail Customer Nos."; Code[20])
        {
            Caption = 'Retail Customer Nos.';
            TableRelation = "No. Series";
        }
        field(50017; "Corporate Customer Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50018; "Scheme Master Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50019; "PIT Structure"; Code[10])
        {
            // TableRelation = "Structure Header";
        }
        field(50020; "Max. Retail Line Discount %"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(50021; "Shield Payment Account No."; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(50022; "Group Credit Limit Hold Active"; Boolean)
        {
            Caption = 'Credit Limit Hold Active';
            Description = 'win127';
            InitValue = false;
        }
        field(50023; "Incentive & Claim A/C"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(50024; "Provisional Claim Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50025; "Posted Prov. Claim Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50026; "Scheme Template"; Code[10])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(50027; "Scheme Batch"; Code[10])
        {
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Scheme Template"));
        }
        field(50028; "T An C"; Text[250])
        {
        }
        field(50029; "T An C1"; Text[250])
        {
        }
        field(50030; "T An C2"; Text[250])
        {
        }
        field(50031; "T An C3"; Text[250])
        {
        }
        field(50032; "T An C4"; Text[250])
        {
        }
        field(50033; "T AN C5"; Text[250])
        {
        }
        field(50034; "24 hrs CR Memo"; Boolean)
        {
        }
        field(50035; "Sales Credit Memo Application"; Boolean)
        {
            Description = '//Win120';
        }
        field(50036; "CRM Customer No."; Code[20])
        {
            Description = 'WIN318';
            TableRelation = "No. Series";
        }
        field(50037; "E COM Customer No."; Code[20])
        {
            Description = 'Ecom';
            TableRelation = "No. Series";
        }
        field(50038; "CRM Payment No."; Code[20])
        {
            Description = 'WIN318';
            TableRelation = "No. Series";
        }
        field(50039; "ECOM Payment No."; Code[20])
        {
            Description = 'WIN316';
            TableRelation = "No. Series";
        }
        field(50040; "B2C Customer No."; Code[20])
        {
            Description = 'KPPL091721';
            TableRelation = "No. Series";
        }
        field(50041; "CRT Approval Code"; Code[10])
        {
            Description = 'KPPLDG00016';
            TableRelation = "No. Series";
        }
        field(50042; "CRT Coupon Discount %"; Decimal)
        {
            Description = 'KPPLDG00016';
        }
        field(50043; "CRT Coupon Validity Days"; Integer)
        {
            Description = 'KPPLDG00016';
        }
        field(50600; "Order Status API URL"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50601; UserName; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50602; Password; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        // Mapple NG 1.0 START 30062023 - Customer ERP Mapping After Customer Create
        field(50100; "Cust Parm ID"; Integer)
        {
            Caption = 'Customer Params ID';
            DataClassification = CustomerContent;
        }
        field(50101; "Cust ERP Url"; Text[500])
        {
            Caption = 'Customer ERP API URL';
            DataClassification = CustomerContent;
        }
        field(50102; "Display JSON"; Boolean)
        {
            Caption = 'Display JSON';
            DataClassification = CustomerContent;
        }
        field(50103; "Auth. User Name"; Text[100])
        {
            Caption = 'Auth. User Name';
            DataClassification = CustomerContent;
        }
        field(50104; "Auth. Password"; Text[100])
        {
            Caption = 'Auth. User Password';
            DataClassification = CustomerContent;
        }
        field(50105; "Logistic User Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(50106; "Logistic Password"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(50107; "Logistic Token URL"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(50108; "Logistic URL"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(50109; "Logistic Show Json"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        // Mapple NG 1.0 START 30062023 - Customer ERP Mapping After Customer Create
        field(50110; "Clock-me Vendor ID"; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50111; "Clock-me Password"; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50112; "Clock-me URL"; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50113; "Clock-me Show Json"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50114; "Logistic Invoice URL"; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50115; "Display Ingram JSON"; Boolean)
        {
            DataClassification = ToBeClassified;
        }


        field(50147; "API URL"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50148; ClientSecret; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50149; Host; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50150; ClientId; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50151; "Auth Token URL"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50152; "Decrypt API URL"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50153; "Encrypt API URL"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50154; "TradeInExchangeDetails API URL"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50155; "Partner Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50156; "Display Servify Json"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
}
