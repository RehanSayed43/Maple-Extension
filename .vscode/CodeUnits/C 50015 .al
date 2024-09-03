codeunit 50015 "CRT Web Service"
{
    // version KPPLDG00016,KPPLDG00038


    trigger OnRun();
    begin
    end;

    var
        ReturnString: Text;

    //procedure AddStudentTeacher(ParamCandidateType: Text[20]; ParamName: Text[100]; ParamEmail: Text[100]; ParamPhone: Text[11]; ParamDateofBirth: Text; ParamCalculatedAge: Integer; ParamInstitute: Text[100]; ParamCourse: Text[50]; ParamCollegeID: BigText; ParamFeeReciept: BigText; ParamAadharCard: BigText; ParamDrivingLicense: BigText; ParamPassport: BigText; ParamEmployeeIdCard: BigText; ParamAnyGovtID: BigText; ParamConsentFile: BigText; ParamItemNo: Code[20]; ParamInstituteAddress: Text[100]; ParamInstituteZipcode: Text[10]; ParamInstituteCity: Text[30]) "Key": Text;
    // Mapple NG 1.0 04072023 - Convert BigText to Text No need Big Text in BC because Text size increase 
    procedure AddStudentTeacher(ParamCandidateType: Text[20]; ParamName: Text[100]; ParamEmail: Text[100]; ParamPhone: Text[11]; ParamDateofBirth: Text; ParamCalculatedAge: Integer; ParamInstitute: Text[100]; ParamCourse: Text[50]; ParamCollegeID: Text; ParamFeeReciept: Text; ParamAadharCard: Text; ParamDrivingLicense: Text; ParamPassport: Text; ParamEmployeeIdCard: Text; ParamAnyGovtID: Text; ParamConsentFile: Text; ParamItemNo: Code[20]; ParamInstituteAddress: Text[100]; ParamInstituteZipcode: Text[10]; ParamInstituteCity: Text[30]) "Key": Text;
    begin
        CLEARLASTERROR();
        CLEAR(ReturnString);
        IF NOT CreateMasterData(ParamCandidateType, ParamName, ParamEmail, ParamPhone, ParamDateofBirth, ParamCalculatedAge, ParamInstitute, ParamCourse,
                            ParamCollegeID, ParamFeeReciept, ParamAadharCard, ParamDrivingLicense, ParamPassport, ParamEmployeeIdCard, ParamAnyGovtID, ParamConsentFile, ParamItemNo, ParamInstituteAddress, ParamInstituteZipcode, ParamInstituteCity) THEN BEGIN
            ReturnString := 'Status:Error;Message:' + COPYSTR(GETLASTERRORTEXT, 1, 250) + ';Return ID:0';
        END;

        EXIT(ReturnString);
    end;

    [TryFunction]
    //local procedure CreateMasterData(ParamCandidateType: Text[20]; ParamName: Text[100]; ParamEmail: Text[100]; ParamPhone: Text[11]; ParamDateofBirth: Text; ParamCalculatedAge: Integer; ParamInstitute: Text[100]; ParamCourse: Text[50]; ParamCollegeID: BigText; ParamFeeReciept: BigText; ParamAadharCard: BigText; ParamDrivingLicense: BigText; ParamPassport: BigText; ParamEmployeeIdCard: BigText; ParamAnyGovtID: BigText; ParamConsentFile: BigText; ParamItemNo: Code[20]; ParamInstituteAddress: Text[100]; ParamInstituteZipcode: Text[10]; ParamInstituteCity: Text[30]);
    // Mapple NG 1.0 04072023
    local procedure CreateMasterData(ParamCandidateType: Text[20]; ParamName: Text[100]; ParamEmail: Text[100]; ParamPhone: Text[11]; ParamDateofBirth: Text; ParamCalculatedAge: Integer; ParamInstitute: Text[100]; ParamCourse: Text[50]; ParamCollegeID: Text; ParamFeeReciept: Text; ParamAadharCard: Text; ParamDrivingLicense: Text; ParamPassport: Text; ParamEmployeeIdCard: Text; ParamAnyGovtID: Text; ParamConsentFile: Text; ParamItemNo: Code[20]; ParamInstituteAddress: Text[100]; ParamInstituteZipcode: Text[10]; ParamInstituteCity: Text[30]);
    var
        StudentTeacher: Record 50024;
        CandidateType: Integer;
        // RegEx: DotNet "'System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Text.RegularExpressions.Regex";
        RegEx: Codeunit Regex; // Mapple NG 1.0 04072023 
        DateofBirth: Date;
        Item: Record Item;
    begin
        IF ParamCandidateType = '' THEN
            ERROR('Candidate Type must have a value. It could be either Teacher or Student.');

        IF ParamCandidateType = 'Student' THEN
            CandidateType := 0
        ELSE
            IF ParamCandidateType = 'Teacher' THEN
                CandidateType := 1
            ELSE
                ERROR('Invalid Candidate Type.');

        IF ParamName = '' THEN
            ERROR('Candidate Name must have a value. It can not be blank');

        IF ParamEmail = '' THEN
            ERROR('E-mail must have a value. It can not be blank');

        IF NOT RegEx.IsMatch(ParamEmail, '^[\w!#$%&*+\-/=?\^_`{|}~]+(\.[\w!#$%&*+\-/=?\^_`{|}~]+)*@((([\-\w]+\.)+[a-zA-Z]{2,4})|(([0-9]{1,3}\.){3}[0-9]{1,3}))$') THEN
            ERROR('Invalid Email Address.');

        IF ParamPhone = '' THEN
            ERROR('Phone no. must have a value. It can not be blank');

        IF STRLEN(ParamPhone) < 10 THEN
            ERROR('Phone no. is too short.');

        EVALUATE(DateofBirth, ParamDateofBirth);

        IF ParamItemNo = '' THEN
            ERROR('Item no. must have a value. It can not be blank');

        Item.RESET();
        IF NOT Item.GET(ParamItemNo) THEN
            ERROR('Invalid Sku Code');

        StudentTeacher.RESET();
        StudentTeacher.INIT();
        StudentTeacher.Phone := ParamPhone;
        StudentTeacher.Email := ParamEmail;
        StudentTeacher."Candidate Type" := CandidateType;
        StudentTeacher.Name := ParamName;
        StudentTeacher."Date of Birth" := DateofBirth;
        StudentTeacher."Calculated Age" := ParamCalculatedAge;
        StudentTeacher."Name of Institute" := ParamInstitute;
        StudentTeacher.Course := ParamCourse;

        IF ParamCollegeID <> '' THEN
            SetPicture(StudentTeacher, ParamCollegeID, 'COLLEGE_ID');
        IF ParamFeeReciept <> '' THEN
            SetPicture(StudentTeacher, ParamFeeReciept, 'FEE_RECIEPT');
        IF ParamAadharCard <> '' THEN
            SetPicture(StudentTeacher, ParamAadharCard, 'AADHAR_CARD');
        IF ParamDrivingLicense <> '' THEN
            SetPicture(StudentTeacher, ParamDrivingLicense, 'DRIVING_LICENSE');
        IF ParamPassport <> '' THEN
            SetPicture(StudentTeacher, ParamPassport, 'PASSPORT');
        IF ParamEmployeeIdCard <> '' THEN
            SetPicture(StudentTeacher, ParamEmployeeIdCard, 'EMPLOYEE_ID');
        IF ParamAnyGovtID <> '' THEN
            SetPicture(StudentTeacher, ParamAnyGovtID, 'GOVT_ID');
        IF ParamConsentFile <> '' THEN
            SetPicture(StudentTeacher, ParamConsentFile, 'CONSENT');

        StudentTeacher.VALIDATE("Item No.", ParamItemNo);
        StudentTeacher.Status := StudentTeacher.Status::"Pending for Verification";
        StudentTeacher."Created By" := CopyStr(USERID, 1, MaxStrLen(StudentTeacher."Created By"));
        StudentTeacher."Created Platform" := StudentTeacher."Created Platform"::Online;
        StudentTeacher."Created DateTime" := CURRENTDATETIME;
        StudentTeacher.crt_institute_address := ParamInstituteAddress;
        StudentTeacher.crt_institute_city := ParamInstituteCity;
        StudentTeacher.crt_institute_zipcode := ParamInstituteZipcode;
        StudentTeacher.INSERT();

        ReturnString := 'Status:Success;Message:Success;Return ID:' + FORMAT(StudentTeacher."API Entry No.");

        //KPPLDG00038
        SendReceivedEmail(ParamName, ParamEmail, ParamPhone);
        SendReceivedEmailCustomer(ParamEmail, ParamName);
        //KPPLDG00038
    end;

    /* local procedure SetPicture(var ParamRecord: Record 50024; PictureText: BigText; PicType: Code[30]);
    var
        Bytes: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Array";
        Convert: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Convert";
        MemoryStream: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.IO.MemoryStream";
        Ostream: OutStream;
    begin
        Bytes := Convert.FromBase64String(PictureText);
        MemoryStream := MemoryStream.MemoryStream(Bytes);
        IF PicType = 'COLLEGE_ID' THEN
            ParamRecord."College Id".CREATEOUTSTREAM(Ostream);
        IF PicType = 'FEE_RECIEPT' THEN
            ParamRecord."Fee Reciept".CREATEOUTSTREAM(Ostream);
        IF PicType = 'AADHAR_CARD' THEN
            ParamRecord."Aadhar Card".CREATEOUTSTREAM(Ostream);
        IF PicType = 'DRIVING_LICENSE' THEN
            ParamRecord."Driving License".CREATEOUTSTREAM(Ostream);
        IF PicType = 'PASSPORT' THEN
            ParamRecord.Passport.CREATEOUTSTREAM(Ostream);
        IF PicType = 'EMPLOYEE_ID' THEN
            ParamRecord."Employee Id Card".CREATEOUTSTREAM(Ostream);
        IF PicType = 'GOVT_ID' THEN
            ParamRecord."Secondary ID".CREATEOUTSTREAM(Ostream);
        IF PicType = 'CONSENT' THEN
            ParamRecord."Consent File".CREATEOUTSTREAM(Ostream);
        MemoryStream.WriteTo(Ostream);
    end; */
    // Mapple NG 1.0 START - 04072023
    local procedure SetPicture(var ParamRecord: Record 50024; PictureText: Text; PicType: Code[30]);
    var
        Base64Convert: Codeunit "Base64 Convert";
        ConvertValue: Text;
        Ostream: OutStream;
    begin
        Clear(ConvertValue);
        ConvertValue := Base64Convert.FromBase64(PictureText);
        IF PicType = 'COLLEGE_ID' THEN begin
            Clear(ParamRecord."College Id");
            ParamRecord."College Id".CreateOutStream(Ostream, TextEncoding::UTF8);
            Ostream.WriteText(ConvertValue);
        end;

        IF PicType = 'FEE_RECIEPT' THEN begin
            Clear(ParamRecord."Fee Reciept");
            ParamRecord."Fee Reciept".CreateOutStream(Ostream, TextEncoding::UTF8);
            Ostream.WriteText(ConvertValue);
        end;

        IF PicType = 'AADHAR_CARD' THEN begin
            Clear(ParamRecord."Aadhar Card");
            ParamRecord."Aadhar Card".CreateOutStream(Ostream, TextEncoding::UTF8);
            Ostream.WriteText(ConvertValue);
        end;

        IF PicType = 'DRIVING_LICENSE' THEN begin
            Clear(ParamRecord."Driving License");
            ParamRecord."Driving License".CreateOutStream(Ostream, TextEncoding::UTF8);
            Ostream.WriteText(ConvertValue);
        end;

        IF PicType = 'PASSPORT' THEN begin
            Clear(ParamRecord.Passport);
            ParamRecord.Passport.CreateOutStream(Ostream, TextEncoding::UTF8);
            Ostream.WriteText(ConvertValue);
        end;

        IF PicType = 'EMPLOYEE_ID' THEN begin
            Clear(ParamRecord."Employee Id Card");
            ParamRecord."Employee Id Card".CreateOutStream(Ostream, TextEncoding::UTF8);
            Ostream.WriteText(ConvertValue);
        end;

        IF PicType = 'GOVT_ID' THEN begin
            Clear(ParamRecord."Secondary ID");
            ParamRecord."Secondary ID".CreateOutStream(Ostream, TextEncoding::UTF8);
            Ostream.WriteText(ConvertValue);
        end;

        IF PicType = 'CONSENT' THEN begin
            Clear(ParamRecord."Consent File");
            ParamRecord."Consent File".CreateOutStream(Ostream, TextEncoding::UTF8);
            Ostream.WriteText(ConvertValue);
        end;

    end;
    // Mapple NG 1.0 END - 04072023
    /* local procedure SendReceivedEmail(ParamName: Text[100]; ParamEmail: Text[100]; ParamPhone: Text[11]);
    var
        SMTPMailSetup: Record 409;
        SMTPMail: Codeunit 400;
        ToMail: Text[250];
        CCMail: Text[250];
    begin
        //KPPLDG00038
        SMTPMailSetup.GET;
        SMTPMailSetup.TESTFIELD("User ID");
        ToMail := 'crt@mapletechnologies.org';
        CCMail := '';
        IF ToMail <> '' THEN BEGIN
            SMTPMail.CreateMessage('Maple', SMTPMailSetup."User ID", ToMail, 'New CRT request', '', TRUE);
            IF CCMail <> '' THEN
                SMTPMail.AddCC(CCMail);
            SMTPMail.AppendBody('<html>');
            SMTPMail.AppendBody('<Body>');
            SMTPMail.AppendBody('Hello Sir/Madam,');
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AppendBody('You have new CRT request from <b>' + ParamName + '</b>.');
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AppendBody('<b>Contact Details,</b>');
            SMTPMail.AppendBody('<br>');
            SMTPMail.AppendBody('<b>Email :</b> ' + ParamEmail);
            SMTPMail.AppendBody('<br>');
            SMTPMail.AppendBody('<b>Contact Number :</b> ' + ParamPhone);
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AppendBody('</body>');
            SMTPMail.AppendBody('</html>');
            SMTPMail.Send;
        END;
    end; */
    // Mapple NG 1.0 START - 04072023
    local procedure SendReceivedEmail(ParamName: Text[100]; ParamEmail: Text[100]; ParamPhone: Text[11]);
    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        ToMail: List of [Text];
        CCMail: List of [Text];
        BCCRecipients: List of [Text];
        Body: Text;
    begin
        //KPPLDG00038
        Clear(Body);
        ToMail.Add('crt@mapletechnologies.org');
        Body := '<html>'
        + '<Body>'
        + 'Hello Sir/Madam,'
        + '<br><br>'
        + 'You have new CRT request from <b>' + ParamName + '</b>.'
        + '<br><br>'
        + '<b>Contact Details,</b>'
        + '<br>'
        + '<b>Email :</b> ' + ParamEmail
        + '<br><br>'
        + '</body>'
        + '</html>'
        ;
        EmailMessage.Create(ToMail, 'New CRT request', Body, true, CCMail, BCCRecipients);
        if not Email.Send(EmailMessage, "Email Scenario"::Default) then
            Message(GetLastErrorText());
    end;
    // Mapple NG 1.0 END - 04072023
    /* local procedure SendReceivedEmailCustomer(ParamEmail: Text; ParamName: Text);
    var
        SMTPMailSetup: Record 409;
        SMTPMail: Codeunit 400;
        ToMail: Text[250];
        CCMail: Text[250];
    begin
        //KPPLDG00038
        SMTPMailSetup.GET();
        SMTPMailSetup.TESTFIELD("User ID");
        IF ParamEmail = '' THEN
            ERROR('Email id should not be blank.');

        ToMail := ParamEmail;
        CCMail := '';

        IF ToMail <> '' THEN BEGIN
            SMTPMail.CreateMessage('Maple', SMTPMailSetup."User ID", ToMail, 'Your CRT request is received to us', '', TRUE);
            IF CCMail <> '' THEN
                SMTPMail.AddCC(CCMail);
            SMTPMail.AppendBody('<html>');
            SMTPMail.AppendBody('<Body>');
            SMTPMail.AppendBody('Hello ' + ParamName + ',');
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AppendBody('We have received your request under Apple CRT Program – Your request is under process.');
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AppendBody('We will revert soon.');
            SMTPMail.AppendBody('<br><br><br><br>');
            SMTPMail.AppendBody('Regards,');
            SMTPMail.AppendBody('<br>');
            SMTPMail.AppendBody('Maple – Apple Premium Reseller');
            SMTPMail.AppendBody('<br>');
            SMTPMail.AppendBody('</body>');
            SMTPMail.AppendBody('</html>');
            SMTPMail.Send;
        END;
    end; */
    // Mapple NG 1.0 START - 04072023
    local procedure SendReceivedEmailCustomer(ParamEmail: Text; ParamName: Text);
    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        BCCRecipients: List of [Text];
        Body: Text;
        ToMail: List of [Text];
        CCMail: List of [Text];
    begin
        //KPPLDG00038
        IF ParamEmail = '' THEN
            ERROR('Email id should not be blank.');
        ToMail.Add(ParamEmail);
        Clear(Body);
        Body := '<html><Body>'
        + 'Hello ' + ParamName + ','
        + '<br><br>'
        + 'We have received your request under Apple CRT Program – Your request is under process.'
        + '<br><br>'
        + 'We will revert soon.'
        + '<br><br><br><br>'
        + 'Regards,'
        + '<br>'
        + 'Maple – Apple Premium Reseller'
        + '<br>'
        + '</body></html>'
        ;
        EmailMessage.Create(ToMail, 'Your CRT request is received to us', Body, true, CCMail, BCCRecipients);
        if not Email.Send(EmailMessage, "Email Scenario"::Default) then
            Message(GetLastErrorText());

    end;
    // Mapple NG 1.0 END - 04072023
}

