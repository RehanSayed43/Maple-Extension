table 50016 "CRM Integration"
{

    fields
    {
        field(1; "Customer No."; Code[30])
        {
        }
        field(2; "Customer Name"; Text[50])
        {
        }
        field(3; "Customer Address"; Text[100])
        {
        }
        field(4; City; Code[20])
        {
        }
        field(5; "State Code"; Code[20])
        {
        }
        field(6; "Mobile No."; Code[20])
        {

            trigger OnValidate()
            begin
                //WIN318++
                IF "Mobile No." <> '' THEN BEGIN
                    IF (STRLEN("Mobile No.") > 10) OR ((STRLEN("Mobile No.") < 10)) THEN
                        ERROR('For Customer No. %1 Phone No Should be 10 Digit', "Customer No.");
                END;
                //WIN318--
            end;
        }
        field(7; "GST Registration No."; Code[15])
        {
            Caption = 'GST Registration No.';

            trigger OnValidate()
            var
                GSTRegistrationNos: Record "GST Registration Nos.";
            begin
                IF "GST Registration No." <> '' THEN
                    IF "GST Registration Type" = "GST Registration Type"::GSTIN THEN BEGIN
                        TESTFIELD("State Code");
                        //  GSTRegistrationNos.CheckGSTRegistrationNo("State Code", "GST Registration No."); RahulGCCIT
                        IF "GST Customer Type" = "GST Customer Type"::" " THEN
                            "GST Customer Type" := "GST Customer Type"::Registered
                        ELSE
                            IF NOT ("GST Customer Type" IN ["GST Customer Type"::Registered, "GST Customer Type"::Exempted]) THEN
                                "GST Customer Type" := "GST Customer Type"::Registered;
                    END ELSE
                        "GST Customer Type" := "GST Customer Type"::" "
                ELSE
                    "GST Customer Type" := "GST Customer Type"::" ";


            end;
        }
        field(8; "GST Registration Type"; Option)
        {
            OptionCaption = 'GSTIN,UID,GID';
            OptionMembers = GSTIN,UID,GID;
        }
        field(9; "GST Customer Type"; Option)
        {
            OptionCaption = ' ,Registered,Unregistered,Export,Deemed Export,Exempted';
            OptionMembers = " ",Registered,Unregistered,Export,"Deemed Export",Exempted;
        }
        field(10; "Document Type"; Option)
        {
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,Service';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Service;
        }
        field(11; "Posting Date"; Date)
        {
        }
        field(12; "Branch Code"; Code[20])
        {
        }
        field(13; "Vertical Code"; Code[20])
        {
        }
        field(14; Structure; Code[20])
        {
        }
        field(15; "CRM invoice No"; Code[30])
        {
        }
        field(16; "Invocie No to Apply"; Code[20])
        {
        }
        field(17; "Location Code"; Code[20])
        {
        }
        field(18; "Nature of Supply"; Option)
        {
            OptionCaption = ' ,Goods,Service Charge';
            OptionMembers = " ",Goods,"Service Charge";
        }
        field(19; "GST Without Payment of Duty"; Boolean)
        {
        }
        field(20; Type; Option)
        {
            OptionCaption = ' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        }
        field(21; "No."; Code[50])
        {
        }
        field(22; Quantity; Decimal)
        {
        }
        field(23; "Unit Price With Tax"; Decimal)
        {
        }
        field(24; "GST Group Code"; Code[20])
        {
        }
        field(25; "HSN/SAC Code"; Code[20])
        {
        }
        field(26; "Invoice Type"; Option)
        {
            OptionCaption = 'Taxable,Bill of Supply,Export,Supplementary,Debit Note,Non-GST';
            OptionMembers = Taxable,"Bill of Supply",Export,Supplementary,"Debit Note","Non-GST";
        }
        field(27; "Cash Amount"; Decimal)
        {
        }
        field(28; "Credit Card Machine Name"; Code[20])
        {
        }
        field(29; "Credit Card No"; Code[30])
        {
        }
        field(30; "Credit Card Amount"; Decimal)
        {
        }
        field(31; "Debit Card Machine Name"; Code[20])
        {
        }
        field(32; "Debit Card No"; Code[30])
        {
        }
        field(33; "Debit Card Amount"; Decimal)
        {
        }
        field(34; "Cheque No"; Code[20])
        {
        }
        field(35; "Cheque Date"; Date)
        {
        }
        field(36; "Cheque Amount"; Decimal)
        {
        }
        field(37; "NEFT/RTGS/EFT No."; Integer)
        {
        }
        field(38; "NEFT/RTGS/EFT  Date"; Integer)
        {
        }
        field(39; "NEFT/RTGS/EFT Amount"; Decimal)
        {
        }
        field(40; Narration; Text[60])
        {
        }
        field(41; "Customer Created"; Boolean)
        {
        }
        field(42; "Order Created"; Boolean)
        {
        }
        field(43; "Order Posted"; Boolean)
        {
        }
        field(44; "Payment Created"; Boolean)
        {
        }
        field(45; "Payment Posted"; Boolean)
        {
        }
        field(46; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
            end;
        }
        field(47; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
            end;
        }
        field(48; "Document Date"; Date)
        {
        }
        field(49; "Bal. Account No."; Code[20])
        {
        }
        field(50; "Bal. Account Type"; Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        }
        field(51; "Apply to doc. Type"; Option)
        {
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(52; "Apply to Doc. No."; Code[20])
        {
        }
        field(53; "Bal. Account No.CC"; Code[20])
        {
        }
        field(54; "Bal. Account No.DC"; Code[20])
        {
        }
        field(55; "Bal. Account No.Cheque"; Code[20])
        {
        }
        field(56; "Narration For Cheque"; Text[60])
        {
        }
        field(57; "Bal. Account No.NFFT"; Code[20])
        {
        }
        field(58; "Narration For NFFT"; Text[60])
        {
        }
        field(59; "SalesPerson Code"; Code[10])
        {
            Description = 'win-234';
        }

        field(60; "GST Credit"; Option) //kj
        {
            OptionCaption = ' ,Availment,Non-Availment';
            OptionMembers = " ","Availment","Non-Availment";
        }
    }

    keys
    {
        key(Key1; "Customer No.", "CRM invoice No", "No.")
        {
            Clustered = true;
        }
        key(Key2; "Mobile No.")
        {
        }
        key(Key3; Structure)
        {
        }
    }

    fieldgroups
    {
    }
}

