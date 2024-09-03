table 50024 "CRT Records"
{

    fields
    {
        field(1; "Candidate Type"; Option)
        {
            OptionCaption = 'Student,Teacher';
            OptionMembers = Student,Teacher;
        }
        field(2; Name; Text[100])
        {
        }
        field(3; Email; Text[100])
        {

            trigger OnValidate()
            var
            //   RegEx: DotNet Regex;
            begin
                // IF NOT RegEx.IsMatch
                //   (Email, '^[\w!#$%&*+\-/=?\^_`{|}~]+(\.[\w!#$%&*+\-/=?\^_`{|}~]+)*@((([\-\w]+\.)+[a-zA-Z]{2,4})|(([0-9]{1,3}\.){3}[0-9]{1,3}))$') THEN
                //     ERROR('Invalid Email Address.');
            end;
        }
        field(4; Phone; Text[11])
        {

            trigger OnValidate()
            begin
                IF STRLEN(Phone) < 10 THEN
                    ERROR('Phone no. is too short.');
            end;
        }
        field(5; "Date of Birth"; Date)
        {
        }
        field(6; "Calculated Age"; Integer)
        {
        }
        field(7; "Name of Institute"; Text[100])
        {
        }
        field(8; Course; Text[50])
        {
        }
        field(9; "College Id"; BLOB)
        {
            SubType = Bitmap;
        }
        field(10; "Fee Reciept"; BLOB)
        {
            SubType = Bitmap;
        }
        field(11; "Aadhar Card"; BLOB)
        {
            SubType = Bitmap;
        }
        field(12; "Driving License"; BLOB)
        {
            SubType = Bitmap;
        }
        field(13; Passport; BLOB)
        {
            SubType = Bitmap;
        }
        field(14; "Employee Id Card"; BLOB)
        {
            SubType = Bitmap;
        }
        field(15; "Secondary ID Type"; Option)
        {
            OptionCaption = ' ,Driving License,Passport,Voter Id,Photo Credit Card,Aadhar Card,Other';
            OptionMembers = " ","Driving License",Passport,"Voter Id","Photo Credit Card","Aadhar Card",Other;
        }
        field(16; "Secondary ID Name"; Text[30])
        {
        }
        field(17; "Secondary ID"; BLOB)
        {
            SubType = Bitmap;
        }
        field(18; Status; Option)
        {
            Description = 'KPPLDG00022 -> Add new option';
            OptionCaption = 'Open,Pending for Verification,Pending for Approval,Approved,Rejected';
            OptionMembers = Open,"Pending for Verification","Pending for Approval",Approved,Rejected;
        }
        field(19; "Item No."; Code[20])
        {
            TableRelation = Item;

            trigger OnValidate()
            begin
                IF "Item No." = '' THEN
                    "Item Description" := ''
                ELSE BEGIN
                    Item.GET("Item No.");
                    "Item Description" := Item.Description;
                END;
            end;
        }
        field(20; "Created DateTime"; DateTime)
        {
            Description = '//KPPL';
        }
        field(21; "Created Platform"; Option)
        {
            Description = '//KPPL';
            OptionCaption = ' ,Online,Store';
            OptionMembers = " ",Online,Store;
        }
        field(22; "Created By"; Code[50])
        {
            Description = '//KPPL';
            TableRelation = User;
        }
        field(23; "Approval Entry"; Boolean)
        {
            Description = '//KPPL';
        }
        field(24; "Approved ID"; Code[10])
        {
            Description = '//KPPL';
        }
        field(25; "Item Description"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = '//KPPL';
        }
        field(26; "Approval By"; Code[50])
        {
            Description = '//KPPL';
            TableRelation = User;
        }
        field(27; "Approval DateTime"; DateTime)
        {
            Description = '//KPPL';
        }
        field(28; "Approval Comment"; Text[250])
        {
            Description = '//KPPL';
        }
        field(29; "API Entry No."; BigInteger)
        {
            AutoIncrement = true;
            Description = '//KPPL';
        }
        field(30; "Consent File"; BLOB)
        {
        }
        field(31; "Verified By"; Code[50])
        {
            Description = '//KPPL';
            TableRelation = User;
        }
        field(32; "Verified DateTime"; DateTime)
        {
            Description = '//KPPL';
        }
        field(33; "Verification Comment"; Text[250])
        {
            Description = '//KPPL';
        }
        field(34; "Update By"; Code[50])
        {
            Description = '//KPPL';
        }
        field(35; "Updated Datetime"; DateTime)
        {
            Description = '//KPPL';
        }
        field(37; crt_institute_address; Text[100])
        {
            Description = '//KPPL-UC';
        }
        field(38; crt_institute_city; Text[30])
        {
            Description = '//Kppl-UC';
        }
        field(39; crt_institute_zipcode; Code[10])
        {
            Description = '//KPPL-UC';
        }
    }

    keys
    {
        key(Key1; Phone, Email)
        {
            Clustered = true;
        }
        key(Key2; "Candidate Type", Name)
        {
        }
        key(Key3; "Date of Birth")
        {
        }
        key(Key4; "API Entry No.", "Created DateTime")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    begin
        "Update By" := USERID;
        "Updated Datetime" := CURRENTDATETIME;
    end;

    var
        Item: Record "Item";
        CouponCode: Code[20];
        CouponExpiry: Date;


    procedure CreateCouponEntry()
    var
        CRTCoupons: Record "CRT Coupons";
        //   NoSeriesManagement: Codeunit "396";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        ApprovedID: Code[10];
    begin
        TESTFIELD("Approval Comment");
        SalesReceivablesSetup.GET;
        CLEAR(ApprovedID);
        //     ApprovedID := NoSeriesManagement.GetNextNo3(SalesReceivablesSetup."CRT Approval Code", TODAY, TRUE, FALSE);

        CRTCoupons.INIT;
        CRTCoupons."Coupon Code" := 'CRTMAPLE' + ApprovedID + COPYSTR(Phone, 6, 5);
        CRTCoupons.Phone := Phone;
        CRTCoupons.Email := Email;
        CRTCoupons."Item No." := "Item No.";
        CRTCoupons."Coupon Generate Date" := TODAY;
        //      CRTCoupons."Coupon Expiry Date" := TODAY + SalesReceivablesSetup."CRT Coupon Validity Days";
        CRTCoupons."Verification ID" := ApprovedID;
        CRTCoupons."Item Description" := "Item Description";
        CRTCoupons."Verified By" := USERID;
        CRTCoupons."Verified DateTime" := CURRENTDATETIME;
        CRTCoupons.INSERT;
        "Approved ID" := ApprovedID;
        "Approval By" := USERID;
        "Approval DateTime" := CURRENTDATETIME;
        CouponCode := CRTCoupons."Coupon Code";
        CouponExpiry := CRTCoupons."Coupon Expiry Date";
    end;


    procedure SendEmailNotification()
    var
        // SMTPMailSetup: Record "SMTP Mail Setup";
        // SMTPMail: Codeunit "400";
        ToMail: Text[250];
        CCMail: Text[250];
    begin
        /*SMTPMailSetup.GET;
        SMTPMailSetup.TESTFIELD("User ID");

        ToMail := Email;
        CCMail := '';

        IF ToMail <> '' THEN
        BEGIN
          SMTPMail.CreateMessage(COMPANYNAME,SMTPMailSetup."User ID",ToMail,'CRT Discount','',TRUE);
          IF CCMail<>'' THEN
            SMTPMail.AddCC(CCMail);
          SMTPMail.AppendBody('<html>');
          SMTPMail.AppendBody('<Body>');
          SMTPMail.AppendBody('Hello '+Name+',');
          SMTPMail.AppendBody('<br><br>');
          SMTPMail.AppendBody('We’ve got good news for you, a special discount code for our product <b>'+"Item Description"+'</b>. Please find it below:');
          SMTPMail.AppendBody('<br><br>');
          SMTPMail.AppendBody('<h3 style="color:blue;">'+CouponCode+'</h3>');
          SMTPMail.AppendBody('The code is valid until '+FORMAT(CouponExpiry)+'. Hope you’ll enjoy it!');
          SMTPMail.AppendBody('<br><br><br><br>');
          SMTPMail.AppendBody('Happy Shopping,');
          SMTPMail.AppendBody('<br>');
          SMTPMail.AppendBody(FORMAT(COMPANYNAME));
          SMTPMail.AppendBody('<br>');
          SMTPMail.AppendBody('<p style="color:Red"><b>Note:- This is a system generated email, please do not reply to this message.</br>');
          SMTPMail.AppendBody('</body>');
          SMTPMail.AppendBody('</html>');
          SMTPMail.Send;
        END;
        */
        SendEmailNotificationNew; //KPPLDG00038

    end;


    procedure SendRejectedEmail()
    var
        // SMTPMailSetup: Record "SMTP Mail Setup";
        // SMTPMail: Codeunit "400";
        ToMail: Text[250];
        CCMail: Text[250];
    begin
        /*SMTPMailSetup.GET;
        SMTPMailSetup.TESTFIELD("User ID");

        ToMail := Email;
        CCMail := '';

        IF ToMail <> '' THEN
        BEGIN
          SMTPMail.CreateMessage(COMPANYNAME,SMTPMailSetup."User ID",ToMail,'CRT Discount Rejection','',TRUE);
          IF CCMail<>'' THEN
            SMTPMail.AddCC(CCMail);
          SMTPMail.AppendBody('<html>');
          SMTPMail.AppendBody('<Body>');
          SMTPMail.AppendBody('Hello '+Name+',');
          SMTPMail.AppendBody('<br><br>');
          SMTPMail.AppendBody('Thank you for your registration! We’re happy that you’ve decided to buy our product <b>'+"Item Description"+'</b>.');
          SMTPMail.AppendBody('<br>');
          SMTPMail.AppendBody('Regarding your discount request, unfortunately,We are unable to process your request');
          SMTPMail.AppendBody('<br><br>');
          SMTPMail.AppendBody('<b>Rejection Reason :</b>');
          SMTPMail.AppendBody('<p>'+"Approval Comment" + '</p>');
          SMTPMail.AppendBody('<br><br><br><br>');
          SMTPMail.AppendBody('Happy Shopping,');
          SMTPMail.AppendBody('<br>');
          SMTPMail.AppendBody(FORMAT(COMPANYNAME));
          SMTPMail.AppendBody('<br>');
          SMTPMail.AppendBody('<p style="color:Red"><b>Note:- This is a system generated email, please do not reply to this message.</br>');
          SMTPMail.AppendBody('</body>');
          SMTPMail.AppendBody('</html>');
          SMTPMail.Send;
        END;
        */
        SendRejectedEmailNew; //KPPLDG00038

    end;


    /*  procedure GetFileType(BlobRef: Record TempBlob): Text
      var
          NVInStream: InStream;
          MyChar: Char;
          MyString: Text;
          i: Integer;
          Extention: Text;
      begin
          BlobRef.Blob.CREATEINSTREAM(NVInStream);

          FOR i := 1 TO 10 DO BEGIN
              NVInStream.READ(MyChar, 1);
              MyString += FORMAT(MyChar);
          END;
          IF COPYSTR(MyString, 7, 4) = 'JFIF' THEN
              Extention := '.jpg'
          ELSE
              IF COPYSTR(MyString, 2, 3) = 'PNG' THEN
                  Extention := '.png'
              ELSE
                  IF COPYSTR(MyString, 1, 3) = 'GIF' THEN
                      Extention := '.gif'
                  ELSE
                      IF COPYSTR(MyString, 1, 2) = 'BM' THEN
                          Extention := '.bmp'
                      ELSE
                          IF COPYSTR(MyString, 2, 3) = 'PDF' THEN
                              Extention := '.pdf'
                          ELSE
                              ERROR('File type not supported.Image and PDF files are allowed.');

          EXIT(Extention);
      end;*/


    procedure SendEmailNotificationNew()
    var
        //   SMTPMailSetup: Record "409";
        // SMTPMail: Codeunit "400";
        ToMail: Text[250];
        CCMail: Text[250];
    begin
        /*
        //KPPLDG00038
        SMTPMailSetup.GET;
        SMTPMailSetup.TESTFIELD("User ID");
        TESTFIELD(Email);

        ToMail := Email;
        CCMail := '';

        IF ToMail <> '' THEN BEGIN
            SMTPMail.CreateMessage('Maple', SMTPMailSetup."User ID", ToMail, 'Congratulation! You are eligible for our special student / teacher discount', '', TRUE);
            IF CCMail <> '' THEN
                SMTPMail.AddCC(CCMail);
            SMTPMail.AppendBody('<html>');
            SMTPMail.AppendBody('<Body>');
            SMTPMail.AppendBody('Hello ' + Name + ',');
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AppendBody('Please enter the below mentioned discount code at checkout.');
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AppendBody('<h3 style="color:blue;">' + CouponCode + '</h3>');
            SMTPMail.AppendBody('The code is valid for 24 Hours.');
            SMTPMail.AppendBody('<br><br><br><br>');
            SMTPMail.AppendBody('Regards');
            SMTPMail.AppendBody('<br>');
            SMTPMail.AppendBody('Maple – Apple Premium Reseller');
            SMTPMail.AppendBody('<br>');
            SMTPMail.AppendBody('</body>');
            SMTPMail.AppendBody('</html>');
            SMTPMail.Send;
        END;
        */
    end;


    procedure SendRejectedEmailNew()
    var
        // SMTPMailSetup: Record "409";
        // SMTPMail: Codeunit "400";
        ToMail: Text[250];
        CCMail: Text[250];
    begin
        /*
        //KPPLDG00038
        SMTPMailSetup.GET;
        SMTPMailSetup.TESTFIELD("User ID");

        TESTFIELD(Email);

        ToMail := Email;
        CCMail := '';

        IF ToMail <> '' THEN BEGIN
            SMTPMail.CreateMessage('Maple', SMTPMailSetup."User ID", ToMail, 'Your CRT Request Declined', '', TRUE);
            IF CCMail <> '' THEN
                SMTPMail.AddCC(CCMail);
            SMTPMail.AppendBody('<html>');
            SMTPMail.AppendBody('<Body>');
            SMTPMail.AppendBody('Hello ' + Name + ',');
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AppendBody('With reference to your Student / Teacher discount request submitted, we regret to inform you that your request has been rejected. ');
            SMTPMail.AppendBody('<br>');
            SMTPMail.AppendBody('<br>');
            SMTPMail.AppendBody('<b>Rejection Reason :</b>');
            SMTPMail.AppendBody('<p>' + "Approval Comment" + '</p>');
            SMTPMail.AppendBody('<br><br><br><br>');
            SMTPMail.AppendBody('Regards,');
            SMTPMail.AppendBody('<br>');
            SMTPMail.AppendBody('Maple – Apple Premium Reseller');
            SMTPMail.AppendBody('<br>');
            SMTPMail.AppendBody('</body>');
            SMTPMail.AppendBody('</html>');
            SMTPMail.Send;
        END;
        */
    end;


    procedure SendEmailToApprover()
    var
        // SMTPMailSetup: Record "409";
        // SMTPMail: Codeunit "400";
        ToMail: Text[1024];
        CCMail: Text[250];
        UserSetup: Record "User Setup";
    begin
        /*
        //KPPLDG00038
        SMTPMailSetup.GET;
        SMTPMailSetup.TESTFIELD("User ID");

        UserSetup.RESET;
        UserSetup.SETRANGE(UserSetup."CRT Approval", TRUE);
        UserSetup.SETFILTER(UserSetup."E-Mail", '<>%1', '');
        IF UserSetup.FINDSET THEN
            REPEAT
                IF ToMail = '' THEN
                    ToMail := UserSetup."E-Mail"
                ELSE
                    ToMail := ToMail + ';' + UserSetup."E-Mail";
            UNTIL UserSetup.NEXT = 0;

        CCMail := '';

        IF ToMail <> '' THEN BEGIN
            SMTPMail.CreateMessage('Maple', SMTPMailSetup."User ID", ToMail, 'New CRT request sent for Approval', '', TRUE);
            IF CCMail <> '' THEN
                SMTPMail.AddCC(CCMail);
            SMTPMail.AppendBody('<html>');
            SMTPMail.AppendBody('<Body>');
            SMTPMail.AppendBody('Hello Sir/Madam,');
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AppendBody('You have new CRT request from Call Centre for Approval.');
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AppendBody('</body>');
            SMTPMail.AppendBody('</html>');
            SMTPMail.Send;
        END;
        */
    end;

}

