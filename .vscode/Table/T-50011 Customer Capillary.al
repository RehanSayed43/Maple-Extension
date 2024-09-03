table 50011 "Customer Capillary"
{
    // //WIN316 TABLE CREATED TO STORE CAPILLEY CUSTOMER INFO


    fields
    {
        field(1; "Mobile No"; Text[30])
        {
            Editable = false;
        }
        field(2; Email; Text[80])
        {
            Editable = false;
            ExtendedDatatype = EMail;
        }
        field(3; Gender; Option)
        {
            Editable = false;
            OptionCaption = 'Male,Female';
            OptionMembers = Male,Female;
        }
        field(4; "Customer Code"; Code[20])
        {
            Editable = false;
        }
        field(5; "First Name"; Text[50])
        {
        }
        field(6; "Last Name"; Text[50])
        {
        }
        field(7; Address; Text[50])
        {
        }
        field(8; Birthdate; Date)
        {
        }
        field(9; Anniversary; Date)
        {
        }
        field(10; "Age Group"; Option)
        {
            OptionCaption = ' ,<18,18-29,30-45,56-69,70-87';
            OptionMembers = " ","<18","18-29","30-45","56-69","70-87";
        }
        field(11; "Income Group"; Option)
        {
            OptionCaption = ' ,Up to 3,3-6,6-9,10-13,14-18,19-25,>25';
            OptionMembers = " ","Up to 3","3-6","6-9","10-13","14-18","19-25",">25";
        }
        field(12; Pincode; Code[20])
        {
        }
        field(13; "Work Address"; Text[80])
        {
        }
        field(14; "Customer Points"; Integer)
        {
            Editable = false;
        }
        field(15; "Customer Points Value in Rs"; Decimal)
        {
            Editable = false;
        }
        field(16; "Points To Be Redeem"; Integer)
        {

            trigger OnValidate()
            begin
                /*DLL:=DLL.Class1;
                IF NOT DLL.CheckInterNet('http://www.google.com') THEN BEGIN
                  MESSAGE('Internet is Not Working');
                  EXIT;
                  END;
                  */
                IF "Coupon Code" <> '' THEN
                    ERROR('You have availed Coupon Redemption');
                IF "Point Posted" THEN
                    ERROR('Points Already Posted !!!');
                IF "Coupon posted" THEN
                    ERROR('Coupon Already Posted !!!');
                IF "Validation Code For Points" <> '' THEN
                    ERROR('You cannot change this as "Validation Code" for this is already Confirmed !!!');
                IF "Amount Payable" <= 0 THEN
                    ERROR('Please Update Amount');
                IF "Amount Payable Before Discount" <= 0 THEN
                    ERROR('Please Update Amount');
                IF "Points To Be Redeem" > "Customer Points" THEN
                    ERROR('You cannot redeem the Points more than %1', "Customer Points");

                IF ("Points To Be Redeem" > "Amount Payable") AND ("Points To Be Redeem" <> 0) THEN
                    ERROR('You can not redeem more than amount payable %1', "Amount Payable"); //win-234 30-05-2019;

                //"Redeem Value In Rs.":=("Customer Points Value in Rs"/"Customer Points")*"Points To Be Redeem";
                //"Amount Payable":="Amount Payable"+xRec."Redeem Value In Rs."-"Redeem Value In Rs.";
                RecUserSetup.RESET;
                RecUserSetup.SETRANGE("User ID", USERID);
                IF RecUserSetup.FINDFIRST THEN BEGIN
                    RecLocation.RESET;
                    RecLocation.SETRANGE(Code, RecUserSetup."Location Code");
                    IF RecLocation.FINDFIRST THEN BEGIN
                        RecLocation.TESTFIELD("Capillary ID");
                        RecLocation.TESTFIELD("Capillary Password");
                    END;
                END;
                IF "Points To Be Redeem" > 0 THEN BEGIN
                    FilePath := '\\mapleNAV\Navision\Dont Delete (Capilery Integration)\Customer_Details\' + "First Name" + "Mobile No" + '.xml';
                    //      RecCreatTranXML.Create_Blank_XML(FilePath);
                    //     DLL := DLL.Class1;
                    weblink := 'https://apac2.api.capillarytech.com/v1.1/points/validationcode?format=xml&mobile=' + "Mobile No" + '&points=' + FORMAT("Points To Be Redeem");
                    //     DLL.CallWebApi(weblink, 'GET', '', RecLocation."Capillary ID", RecLocation."Capillary Password", FilePath);
                    //     RecXML.GetValidationCode(FilePath);
                END;

            end;
        }
        field(17; "Point Redeem Value In Rs."; Decimal)
        {
            Editable = false;

            trigger OnValidate()
            begin
                "Amount Payable" := "Amount Payable" + xRec."Point Redeem Value In Rs." - "Point Redeem Value In Rs.";
            end;
        }
        field(18; "Amount Payable"; Decimal)
        {
            Editable = false;
        }
        field(20; "Sales Order No"; Code[20])
        {
            Editable = false;
        }
        field(21; "Transaction ID"; Integer)
        {
            Editable = false;
        }
        field(22; "Validation Code For Points"; Text[30])
        {

            trigger OnValidate()
            begin
                /*DLL:=DLL.Class1;
                IF NOT DLL.CheckInterNet('http://www.google.com') THEN BEGIN
                  MESSAGE('Internet is Not Working');
                  EXIT;
                  END;
                  */
                IF "Point Posted" THEN
                    ERROR('Points already Posted !!!');
                IF "Coupon Code" <> '' THEN
                    ERROR('You have availed Coupon Redemption');
                IF "Points To Be Redeem" = 0 THEN
                    ERROR('Please enter Points To Be Redeem');
                RecUserSetup.RESET;
                RecUserSetup.SETRANGE("User ID", USERID);
                IF RecUserSetup.FINDFIRST THEN BEGIN
                    RecLocation.RESET;
                    RecLocation.SETRANGE(Code, RecUserSetup."Location Code");
                    IF RecLocation.FINDFIRST THEN BEGIN
                        RecLocation.TESTFIELD("Capillary ID");
                        RecLocation.TESTFIELD("Capillary Password");
                    END;
                END;
                IF "Validation Code For Points" <> '' THEN BEGIN
                    FilePath := '\\mapleNAV\Navision\Dont Delete (Capilery Integration)\Customer_Details\' + "First Name" + "Mobile No" + '.xml';
                    //    RecCreatTranXML.Create_Blank_XML(FilePath);
                    //    DLL := DLL.Class1;
                    weblink := 'https://apac2.api.capillarytech.com/v1.1/points/isredeemable?format=xml&points=' + FORMAT("Points To Be Redeem") + '&validation_code=' + "Validation Code For Points" + '&mobile=' + "Mobile No";
                    //    DLL.CallWebApi(weblink, 'GET', '', RecLocation."Capillary ID", RecLocation."Capillary Password", FilePath);
                    ValidateValidationCodeForPoints(FilePath);
                END
                ELSE
                    Update_amount_payable("Sales Order No");

            end;
        }
        field(23; "Coupon Code"; Text[30])
        {

            trigger OnValidate()
            begin
                //     DLL := DLL.Class1;
                // IF NOT DLL.CheckInterNet('http://www.google.com') THEN BEGIN
                //     MESSAGE('Internet is Not Working');
                //     EXIT;
                // END;
                IF "Amount Payable" <= 0 THEN
                    ERROR('Please Update Amount');
                IF "Amount Payable Before Discount" <= 0 THEN
                    ERROR('Please Update Amount');
                IF "Point Posted" THEN
                    ERROR('Points Already Posted !!!');
                IF "Coupon posted" THEN
                    ERROR('Coupon Already Posted !!!');
                IF "Validation Code For Points" <> '' THEN
                    ERROR('You have availed Point Redemption');
                RecUserSetup.RESET;
                RecUserSetup.SETRANGE("User ID", USERID);
                IF RecUserSetup.FINDFIRST THEN BEGIN
                    RecLocation.RESET;
                    RecLocation.SETRANGE(Code, RecUserSetup."Location Code");
                    IF RecLocation.FINDFIRST THEN BEGIN
                        RecLocation.TESTFIELD("Capillary ID");
                        RecLocation.TESTFIELD("Capillary Password");
                    END;
                END;
                IF "Coupon Code" <> '' THEN BEGIN
                    FilePath := '\\mapleNAV\Navision\Dont Delete (Capilery Integration)\Customer_Details\' + "First Name" + "Mobile No" + '.xml';
                    //      RecCreatTranXML.Create_Blank_XML(FilePath);
                    //      DLL := DLL.Class1;
                    weblink := 'https://apac2.api.capillarytech.com/v1.1/coupon/isredeemable?format=xml&details=true&code=' + "Coupon Code" + '&mobile=' + "Mobile No";
                    //      DLL.CallWebApi(weblink, 'GET', '', RecLocation."Capillary ID", RecLocation."Capillary Password", FilePath);
                    CouponRedemption(FilePath);
                END
                ELSE
                    VALIDATE("Coupon Value In Rs.", 0);
            end;
        }
        field(24; "Coupon Value In Rs."; Decimal)
        {
            Editable = false;

            trigger OnValidate()
            begin
                "Amount Payable" := "Amount Payable" + xRec."Coupon Value In Rs." - "Coupon Value In Rs.";
            end;
        }
        field(25; "Transaction Details Sent"; Boolean)
        {
        }
        field(27; "Point Posted"; Boolean)
        {
        }
        field(28; "Coupon posted"; Boolean)
        {
        }
        field(29; "Entry No"; Integer)
        {
            Editable = false;
        }
        field(30; "Amount Payable Before Discount"; Decimal)
        {
        }
        field(31; "Amount UPIT to Customer"; Decimal)
        {
        }
        field(32; "Posting Date"; Date)
        {
            Editable = false;
        }
        field(33; "Awarded Points"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        IF "Point Posted" OR "Coupon posted" THEN
            ERROR('You cannot delete this as redemption is Posted');
        IF ("Validation Code For Points" <> '') OR ("Coupon Code" <> '') OR ("Points To Be Redeem" <> 0) THEN
            ERROR('You Are Not Allowed to Delete Record');
        RecSH.RESET;
        RecSH.SETRANGE("No.", "Sales Order No");
        IF RecSH.FINDFIRST THEN BEGIN
            RecSH."Get Customer" := FALSE;
            RecSH.MODIFY();
        END;
    end;

    var
        //     DLL: DotNet Class1;
        //   RecXML: Codeunit "50008";
        weblink: Text;
        //   xml: DotNet XmlDocument;
        //     XMLNode: DotNet XmlNode;
        //        RecCreatTranXML: Codeunit "Create Transaction XML";
        Input_File_Path: Text;
        Output_File_Path: Text;
        FilePath: Text;
        RecSH: Record "Sales Header";
        RecLocation: Record Location;
        RecUserSetup: Record "User Setup";


    procedure Update_amount_payable(DocumentNo: Code[20])
    var
        RecSalLine: Record "Sales Line";
        sal_amount: Decimal;
        recCust1: Record Customer;
        sal_amount1: Decimal;
    begin
        //UPDATE AMOUNT++
        CLEAR(sal_amount);
        RecSalLine.RESET;
        RecSalLine.SETRANGE("Document No.", DocumentNo);
        IF RecSalLine.FINDSET THEN BEGIN
            REPEAT
                //            sal_amount += RecSalLine."Amount To Customer";//test
                sal_amount1 += RecSalLine."Amt to Customer UPIT";
            UNTIL RecSalLine.NEXT = 0;
            //"Amount Payable":=sal_amount;//test
            "Amount Payable" := sal_amount1;
            "Points To Be Redeem" := 0;
            "Point Redeem Value In Rs." := 0;
            "Sales Order No" := RecSalLine."Document No.";
            "Amount Payable Before Discount" := sal_amount;
        END;
        //UPDATE AMOUNT--
    end;


    procedure ValidateValidationCodeForPoints(FilePath: Text)
    var
        NodeName: Text;
    begin
        // Rahul---
        /*
        xml := xml.XmlDocument;
        xml.Load(FilePath);
        NodeName := '//status/success';
        IF RecXML.FindNode(xml, NodeName, XMLNode) THEN
            IF XMLNode.InnerText = 'true' THEN BEGIN

                NodeName := '//points/item_status/message';
                IF RecXML.FindNode(xml, NodeName, XMLNode) THEN
                    MESSAGE(XMLNode.InnerText);

                NodeName := '//points/redeemable/points_redeem_value';
                IF RecXML.FindNode(xml, NodeName, XMLNode) THEN
                    VALIDATE("Point Redeem Value In Rs.", RecXML.TextToDecimal(XMLNode.InnerText));
                //points_currency_ratio

                NodeName := '//points/redeemable/points_currency_ratio';
                IF RecXML.FindNode(xml, NodeName, XMLNode) THEN
                    "Customer Points Value in Rs" := RecXML.TextToDecimal(XMLNode.InnerText) * "Customer Points";
                //  IF EXISTS(FilePath) THEN
                //    FILE.ERASE(FilePath);
                
            END
            ELSE BEGIN
                NodeName := '//points/redeemable/item_status/message';
                IF RecXML.FindNode(xml, NodeName, XMLNode) THEN
                    MESSAGE(XMLNode.InnerText);
                //    IF EXISTS(FilePath) THEN
                //    FILE.ERASE(FilePath);
            END;
            */
        //---rahul
    end;


    procedure CouponRedemption(FilePath: Text)
    var
        NodeName: Text;
    begin
        //rahul--
        /*
        xml := xml.XmlDocument;
        xml.Load(FilePath);
        NodeName := '//status/success';
        IF RecXML.FindNode(xml, NodeName, XMLNode) THEN
            IF XMLNode.InnerText = 'true' THEN BEGIN

                NodeName := '//coupons/redeemable/item_status/message';
                IF RecXML.FindNode(xml, NodeName, XMLNode) THEN
                    MESSAGE(XMLNode.InnerText);
                VALIDATE("Point Redeem Value In Rs.", 0);
                "Customer Points Value in Rs" := 0;
                "Points To Be Redeem" := 0;
                //For ABS discount
                NodeName := '//coupons/redeemable/series_info/discount_type';
                IF RecXML.FindNode(xml, NodeName, XMLNode) THEN
                    IF XMLNode.InnerText = 'ABS' THEN BEGIN
                        NodeName := '//coupons/redeemable/series_info/discount_value';
                        IF RecXML.FindNode(xml, NodeName, XMLNode) THEN
                            VALIDATE("Coupon Value In Rs.", RecXML.TextToDecimal(XMLNode.InnerText));
                    END;
                //FOR PER DISCOUNT
                NodeName := '//coupons/redeemable/series_info/discount_type';
                IF RecXML.FindNode(xml, NodeName, XMLNode) THEN
                    IF XMLNode.InnerText = 'PERC' THEN BEGIN
                        NodeName := '//coupons/redeemable/series_info/discount_value';
                        IF RecXML.FindNode(xml, NodeName, XMLNode) THEN
                            VALIDATE("Coupon Value In Rs.", (RecXML.TextToDecimal(XMLNode.InnerText) / 100) * "Amount Payable");
                    END;
                //  IF EXISTS(FilePath) THEN
                //  FILE.ERASE(FilePath);
            END
            ELSE BEGIN
                NodeName := '//coupons/redeemable/item_status/message';
                IF RecXML.FindNode(xml, NodeName, XMLNode) THEN
                    MESSAGE(XMLNode.InnerText);
                //    IF EXISTS(FilePath) THEN
                //   FILE.ERASE(FilePath);
            END;
            */
        //---rahul
    end;


    procedure Post_Point()
    begin
        IF "Point Posted" THEN
            ERROR('Points already posted');
        IF "Validation Code For Points" = '' THEN
            ERROR('PLease Enter Validation Code for point');
        IF "Point Redeem Value In Rs." = 0 THEN
            ERROR('Point Redeem Value In Rs. is zero');
        /*
        DLL:=DLL.Class1;
        IF NOT DLL.CheckInterNet('http://www.google.com') THEN BEGIN
          MESSAGE('Internet is Not Working');
          EXIT;
          END;
          */
        RecUserSetup.RESET;
        RecUserSetup.SETRANGE("User ID", USERID);
        IF RecUserSetup.FINDFIRST THEN BEGIN
            RecLocation.RESET;
            RecLocation.SETRANGE(Code, RecUserSetup."Location Code");
            IF RecLocation.FINDFIRST THEN BEGIN
                RecLocation.TESTFIELD("Capillary ID");
                RecLocation.TESTFIELD("Capillary Password");
            END;
        END;
        Input_File_Path := '\\mapleNAV\Navision\Dont Delete (Capilery Integration)\Post Point redumption\' + "First Name" + "Mobile No" + '.xml';
        Output_File_Path := '\\mapleNAV\Navision\Dont Delete (Capilery Integration)\Post Point redumption\Response\' + "First Name" + "Mobile No" + '.xml';
        //     RecCreatTranXML.Post_Point_Redumption("First Name", "Mobile No", "Sales Order No");
        //     RecCreatTranXML.Create_Blank_XML(Output_File_Path);
        //     DLL := DLL.Class1;
        //     DLL.PostXMLData('https://apac2.api.capillarytech.com/v1.1/points/redeem?format=xml', 'POST', '', RecLocation."Capillary ID", RecLocation."Capillary Password", Input_File_Path, Output_File_Path);
        //     Post_Point_Responce(Output_File_Path);
        //    IF EXISTS(Input_File_Path) THEN
        //    FILE.ERASE(Input_File_Path);

    end;


    procedure Post_Coupon()
    begin

        IF "Coupon posted" THEN
            ERROR('Coupon already posted');
        IF "Coupon Code" = '' THEN
            ERROR('PLease Enter Coupon Code');
        IF "Coupon Value In Rs." = 0 THEN
            ERROR('Coupon Value In Rs.is zero');
        /*
        DLL:=DLL.Class1;
        IF NOT DLL.CheckInterNet('http://www.google.com') THEN BEGIN
          MESSAGE('Internet is Not Working');
          EXIT;
          END;
          */
        RecUserSetup.RESET;
        RecUserSetup.SETRANGE("User ID", USERID);
        IF RecUserSetup.FINDFIRST THEN BEGIN
            RecLocation.RESET;
            RecLocation.SETRANGE(Code, RecUserSetup."Location Code");
            IF RecLocation.FINDFIRST THEN BEGIN
                RecLocation.TESTFIELD("Capillary ID");
                RecLocation.TESTFIELD("Capillary Password");
            END;
        END;
        Input_File_Path := '\\mapleNAV\Navision\Dont Delete (Capilery Integration)\Post Coupon redumption\' + "First Name" + "Mobile No" + '.xml';
        Output_File_Path := '\\mapleNAV\Navision\Dont Delete (Capilery Integration)\Post Coupon redumption\Response\' + "First Name" + "Mobile No" + '.xml';
        //    RecCreatTranXML.Post_Coupon_Redumption("First Name", "Mobile No", "Sales Order No");
        //     RecCreatTranXML.Create_Blank_XML(Output_File_Path);
        //    DLL := DLL.Class1;
        //    DLL.PostXMLData('https://apac2.api.capillarytech.com/v1.1/coupon/redeem?format=xml', 'POST', '', RecLocation."Capillary ID", RecLocation."Capillary Password", Input_File_Path, Output_File_Path);
        Post_Coupon_Responce(Output_File_Path);
        //   IF EXISTS(Input_File_Path) THEN
        //   FILE.ERASE(Input_File_Path);

    end;


    procedure Post_Point_Responce(FilePath: Text)
    var
        NodeName: Text;
    begin
        // rahul---
        /*
        xml := xml.XmlDocument;
        xml.Load(FilePath);
        NodeName := '//status/success';
        IF RecXML.FindNode(xml, NodeName, XMLNode) THEN
            IF XMLNode.InnerText = 'true' THEN BEGIN

                NodeName := '//responses/points/item_status/message';
                IF RecXML.FindNode(xml, NodeName, XMLNode) THEN
                    MESSAGE(XMLNode.InnerText);
                "Point Posted" := TRUE;
                //  IF EXISTS(FilePath) THEN
                //   FILE.ERASE(FilePath);

            END
            ELSE BEGIN
                NodeName := '//responses/points/item_status/message';
                IF RecXML.FindNode(xml, NodeName, XMLNode) THEN
                    MESSAGE(XMLNode.InnerText);
                "Point Posted" := FALSE;
                //    IF EXISTS(FilePath) THEN
                //   FILE.ERASE(FilePath);
            END;
            */
        ///--rahul
    end;

    local procedure Post_Coupon_Responce(FilePath: Text)
    var
        NodeName: Text;
    begin
        //rahul---
        /*
        xml := xml.XmlDocument;
        xml.Load(FilePath);
        NodeName := '//status/success';
        IF RecXML.FindNode(xml, NodeName, XMLNode) THEN
            IF XMLNode.InnerText = 'true' THEN BEGIN

                NodeName := '//response/coupons/coupon/item_status/message';
                IF RecXML.FindNode(xml, NodeName, XMLNode) THEN
                    MESSAGE(XMLNode.InnerText);
                "Coupon posted" := TRUE;
                //   IF EXISTS(FilePath) THEN
                //   FILE.ERASE(FilePath);

            END
            ELSE BEGIN
                NodeName := '//response/coupons/coupon/item_status/message';
                IF RecXML.FindNode(xml, NodeName, XMLNode) THEN
                    MESSAGE(XMLNode.InnerText);
                "Coupon posted" := FALSE;
                //    IF EXISTS(FilePath) THEN
                //   FILE.ERASE(FilePath);
            END;
            */
        //---rahul
    end;
    /*
        trigger xml::NodeInserting(sender: Variant; e: DotNet XmlNodeChangedEventArgs)
        begin
        end;

        trigger xml::NodeInserted(sender: Variant; e: DotNet XmlNodeChangedEventArgs)
        begin
        end;

        trigger xml::NodeRemoving(sender: Variant; e: DotNet XmlNodeChangedEventArgs)
        begin
        end;

        trigger xml::NodeRemoved(sender: Variant; e: DotNet XmlNodeChangedEventArgs)
        begin
        end;

        trigger xml::NodeChanging(sender: Variant; e: DotNet XmlNodeChangedEventArgs)
        begin
        end;

        trigger xml::NodeChanged(sender: Variant; e: DotNet XmlNodeChangedEventArgs)
        begin
        end;
        */
}

