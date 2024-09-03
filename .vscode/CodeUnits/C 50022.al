codeunit 50022 "SFTP Integration"
{

    trigger OnRun();
    begin
        ISL();
        RET();
        OSL();
    end;

    var
        GenSetup: Record 98;
        /* Files: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.IO.File";
        enco: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Text.UTF8Encoding"; */
        GetDLSS: Text;

    // procedure ISL();
    // var
    //     "no.ser": Record 309;
    //     NoSeriesManagement: Codeunit 96;
    //     FileMgt: Codeunit 419;
    //     XmlP: XMLport 50034;
    //     FileN: Code[100];
    //     Q11: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.IO.StreamWriter";
    //     QEncoding: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Text.Encoding";
    //     OutFile: File;
    //     TestFile: File;
    //     OutS: OutStream;
    //     TestStream: OutStream;
    //     FileName: Text;
    //     Fname: Text;
    // begin

    //     FileName := FileMgt.ServerTempFileName('.txt');
    //     OutFile.CREATE(FileName, TEXTENCODING::UTF8);
    //     OutFile.CREATEOUTSTREAM(OutS);


    //     XmlP.FILENAME(FileName);
    //     XmlP.SETDESTINATION(OutS);
    //     XmlP.TEXTENCODING(TEXTENCODING::UTF8);
    //     XmlP.EXPORT;
    //     OutFile.CLOSE;

    //     // HR-
    //     XmlP.GetDTLS(GetDLSS);
    //     IF GetDLSS = '' THEN
    //         EXIT;

    //     GenSetup.GET();
    //     IF GenSetup."Mapple File Date" <> TODAY THEN BEGIN
    //         GenSetup."Mapple File Date" := TODAY;
    //         GenSetup."ISL File No." := 1;
    //     END ELSE
    //         GenSetup."ISL File No." := GenSetup."ISL File No." + 1;
    //     GenSetup.MODIFY();
    //     IF STRLEN(FORMAT(GenSetup."ISL File No.")) = 1 THEN
    //         EVALUATE(FileN, '0' + FORMAT(GenSetup."ISL File No."))
    //     ELSE
    //         EVALUATE(FileN, FORMAT(GenSetup."ISL File No."));
    //     //HR+

    //     "no.ser".RESET();
    //     "no.ser".SETRANGE("no.ser"."Series Code", 'ISL');
    //     "no.ser".SETRANGE("no.ser".Open, TRUE);
    //     "no.ser".SETFILTER("no.ser"."Last No. Used", '<>%1', '');
    //     IF "no.ser".FINDFIRST() THEN
    //         FileN := "no.ser"."Last No. Used";
    //     Fname := '240603_EU_ISL_' + FORMAT(TODAY, 0, '<Year4><Month,2><Day,2>') + FileN + '.txt';
    //     //FileMgt.DownloadToFile(FileName, 'F:\SFTP\ISL\'+Fname);
    //     enco := enco.UTF8Encoding(FALSE);
    //     Files.WriteAllText(FileName, Files.ReadAllText(FileName, enco));
    //     COPY(FileName, 'E:\SFTP\ISL\' + Fname);
    //     ERASE(FileName);



    //     /*
    //     "no.ser".RESET;
    //     "no.ser".SETRANGE("no.ser"."Series Code",'ISL');
    //     "no.ser".SETRANGE("no.ser".Open,TRUE);
    //     "no.ser".SETFILTER("no.ser"."Last No. Used",'<>%1','');
    //     IF "no.ser".FINDFIRST THEN
    //     FileN:="no.ser"."Last No. Used";
    //     Fname:='240603_EU_ISL_'+FORMAT(TODAY,0,'<Year4><Month,2><Day,2>')+FileN+'.txt';
    //     TestFile.CREATE('F:\SFTP\ISL\'+Fname);
    //     TestFile.CLOSE;
    //     TestFile.WRITEMODE(TRUE);
    //     TestFile.OPEN('F:\SFTP\ISL\'+Fname);
    //     TestFile.CREATEOUTSTREAM(TestStream);
    //     XmlP.FILENAME('F:\SFTP\ISL\'+Fname);
    //     XmlP.SETDESTINATION(TestStream);
    //     XmlP.EXPORT;
    //     TestFile.CLOSE;
    //     */

    // end;
    // Mapple NG 1.0 START - 04072023
    procedure ISL();
    var
        "no.ser": Record 309;
        NoSeriesManagement: Codeunit 96;
        FileMgt: Codeunit 419;
        TempBlob: Codeunit "Temp Blob";
        XmlP: XMLport 50034;
        FileN: Code[100];
        OutFile: File;
        TestFile: File;
        OutS: OutStream;
        TestStream: OutStream;
        FileName: Text;
        Fname: Text;
        Instram: InStream;
    begin

        FileName := 'ISL.txt';
        TempBlob.CreateInStream(Instram);
        TempBlob.CreateOutStream(OutS);
        XmlP.Filename(FileName);
        XmlP.SetDestination(OutS);
        XmlP.TextEncoding(TextEncoding::UTF8);
        XmlP.SetSource(Instram);
        XmlP.Export();


        // HR-
        XmlP.GetDTLS(GetDLSS);
        IF GetDLSS = '' THEN
            EXIT;

        GenSetup.GET();
        IF GenSetup."Mapple File Date" <> TODAY THEN BEGIN
            GenSetup."Mapple File Date" := TODAY;
            GenSetup."ISL File No." := 1;
        END ELSE
            GenSetup."ISL File No." := GenSetup."ISL File No." + 1;
        GenSetup.MODIFY();
        IF STRLEN(FORMAT(GenSetup."ISL File No.")) = 1 THEN
            EVALUATE(FileN, '0' + FORMAT(GenSetup."ISL File No."))
        ELSE
            EVALUATE(FileN, FORMAT(GenSetup."ISL File No."));
        //HR+

        "no.ser".RESET();
        "no.ser".SETRANGE("no.ser"."Series Code", 'ISL');
        "no.ser".SETRANGE("no.ser".Open, TRUE);
        "no.ser".SETFILTER("no.ser"."Last No. Used", '<>%1', '');
        IF "no.ser".FINDFIRST() THEN
            FileN := "no.ser"."Last No. Used";
        Fname := '240603_EU_ISL_' + FORMAT(TODAY, 0, '<Year4><Month,2><Day,2>') + FileN + '.txt';
        DownloadFromStream(Instram, '', 'F:\SFTP\ISL\' + Fname, '', Fname);
        //FileMgt.DownloadToFile(FileName, 'F:\SFTP\ISL\'+Fname);

    end;
    // Mapple NG 1.0 END - 04072023

    // procedure RET();
    // var
    //     "no.ser1": Record 309;
    //     NoSeriesManagement1: Codeunit 396;
    //     FileMgt1: Codeunit 419;
    //     XmlP1: XMLport 50035;
    //     FileN1: Code[100];
    //     OutFile1: File;
    //     TestFile: File;
    //     OutS1: OutStream;
    //     TestStream: OutStream;
    //     FileName1: Text;
    //     Fname1: Text;
    // begin

    //     FileName1 := FileMgt1.ServerTempFileName('.txt');
    //     OutFile1.CREATE(FileName1, TEXTENCODING::UTF8);
    //     OutFile1.CREATEOUTSTREAM(OutS1);
    //     XmlP1.FILENAME(FileName1);
    //     XmlP1.SETDESTINATION(OutS1);
    //     XmlP1.TEXTENCODING(TEXTENCODING::UTF8);
    //     XmlP1.EXPORT;
    //     OutFile1.CLOSE;
    //     // HR-
    //     XmlP1.GetDTLS(GetDLSS);
    //     IF GetDLSS = '' THEN
    //         EXIT;

    //     GenSetup.GET();
    //     IF GenSetup."Mapple File Date" <> WORKDATE() THEN BEGIN
    //         GenSetup."Mapple File Date" := WORKDATE();
    //         GenSetup."RET File No." := 1;
    //     END ELSE
    //         GenSetup."RET File No." := GenSetup."RET File No." + 1;
    //     GenSetup.MODIFY();
    //     IF STRLEN(FORMAT(GenSetup."RET File No.")) = 1 THEN
    //         EVALUATE(FileN1, '0' + FORMAT(GenSetup."RET File No."))
    //     ELSE
    //         EVALUATE(FileN1, FORMAT(GenSetup."RET File No."));
    //     //HR+

    //     "no.ser1".RESET();
    //     "no.ser1".SETRANGE("no.ser1"."Series Code", 'RET');
    //     "no.ser1".SETRANGE("no.ser1".Open, TRUE);
    //     "no.ser1".SETFILTER("no.ser1"."Last No. Used", '<>%1', '');
    //     IF "no.ser1".FINDFIRST() THEN
    //         FileN1 := "no.ser1"."Last No. Used";
    //     Fname1 := '240603_EU_RET_' + FORMAT(TODAY, 0, '<Year4><Month,2><Day,2>') + FileN1 + '.txt';
    //     //FileMgt1.DownloadToFile(FileName1, 'F:\SFTP\RET\'+Fname1);
    //     enco := enco.UTF8Encoding(FALSE);
    //     Files.WriteAllText(FileName1, Files.ReadAllText(FileName1, enco));
    //     COPY(FileName1, 'E:\SFTP\RET\' + Fname1);
    //     ERASE(FileName1);
    //     /*

    //     "no.ser1".RESET;
    //     "no.ser1".SETRANGE("no.ser1"."Series Code",'RET');
    //     "no.ser1".SETRANGE("no.ser1".Open,TRUE);
    //     "no.ser1".SETFILTER("no.ser1"."Last No. Used",'<>%1','');
    //     IF "no.ser1".FINDFIRST THEN
    //     FileN1:="no.ser1"."Last No. Used";
    //     Fname1:='240603_EU_RET_'+FORMAT(TODAY,0,'<Year4><Month,2><Day,2>')+FileN1+'.txt';

    //     TestFile.CREATE('F:\SFTP\RET\'+Fname1);
    //     TestFile.CLOSE;
    //     TestFile.WRITEMODE(TRUE);
    //     TestFile.OPEN('F:\SFTP\RET\'+Fname1);
    //     TestFile.CREATEOUTSTREAM(TestStream);
    //     XmlP1.FILENAME('F:\SFTP\RET\'+Fname1);
    //     XmlP1.SETDESTINATION(TestStream);
    //     XmlP1.EXPORT;
    //     TestFile.CLOSE;
    //     */

    // end;

    // Mapple NG 1.0 START - 04072023
    procedure RET();
    var
        "no.ser1": Record 309;
        NoSeriesManagement1: Codeunit 396;
        FileMgt1: Codeunit 419;
        TempBlob: Codeunit "Temp Blob";
        XmlP1: XMLport 50035;
        FileN1: Code[100];
        OutFile1: File;
        TestFile: File;
        OutS1: OutStream;
        TestStream: OutStream;
        FileName1: Text;
        Fname1: Text;
        Instram: InStream;
    begin

        FileName1 := 'RET.txt';
        TempBlob.CreateInStream(Instram);
        TempBlob.CreateOutStream(OutS1);
        XmlP1.Filename(FileName1);
        XmlP1.SetDestination(OutS1);
        XmlP1.TextEncoding(TextEncoding::UTF8);
        XmlP1.SetSource(Instram);
        XmlP1.Export();


        // HR-
        XmlP1.GetDTLS(GetDLSS);
        IF GetDLSS = '' THEN
            EXIT;

        GenSetup.GET();
        IF GenSetup."Mapple File Date" <> WORKDATE() THEN BEGIN
            GenSetup."Mapple File Date" := WORKDATE();
            GenSetup."RET File No." := 1;
        END ELSE
            GenSetup."RET File No." := GenSetup."RET File No." + 1;
        GenSetup.MODIFY();
        IF STRLEN(FORMAT(GenSetup."RET File No.")) = 1 THEN
            EVALUATE(FileN1, '0' + FORMAT(GenSetup."RET File No."))
        ELSE
            EVALUATE(FileN1, FORMAT(GenSetup."RET File No."));
        //HR+

        "no.ser1".RESET();
        "no.ser1".SETRANGE("no.ser1"."Series Code", 'RET');
        "no.ser1".SETRANGE("no.ser1".Open, TRUE);
        "no.ser1".SETFILTER("no.ser1"."Last No. Used", '<>%1', '');
        IF "no.ser1".FINDFIRST() THEN
            FileN1 := "no.ser1"."Last No. Used";
        Fname1 := '240603_EU_RET_' + FORMAT(TODAY, 0, '<Year4><Month,2><Day,2>') + FileN1 + '.txt';
        DownloadFromStream(Instram, '', 'E:\SFTP\RET\' + Fname1, '', Fname1);

    end;

    // Mapple NG 1.0 END - 04072023
    // procedure OSL();
    // var
    //     "no.ser11": Record 309;
    //     NoSeriesManagement11: Codeunit 396;
    //     FileMgt11: Codeunit 419;
    //     XmlP11: XMLport 50033;
    //     FileN11: Code[100];
    //     OutFile11: File;
    //     TestFile: File;
    //     OutS11: OutStream;
    //     TestStream: OutStream;
    //     FileName11: Text;
    //     Fname11: Text;
    // begin

    //     FileName11 := FileMgt11.ServerTempFileName('.txt');
    //     OutFile11.CREATE(FileName11, TEXTENCODING::UTF8);
    //     OutFile11.CREATEOUTSTREAM(OutS11);


    //     XmlP11.FILENAME(FileName11);
    //     XmlP11.SETDESTINATION(OutS11);
    //     XmlP11.TEXTENCODING(TEXTENCODING::UTF8);
    //     XmlP11.EXPORT;

    //     OutFile11.CLOSE;
    //     // HR-
    //     XmlP11.GetDTLS(GetDLSS);
    //     IF GetDLSS = '' THEN
    //         EXIT;
    //     GenSetup.GET();
    //     IF GenSetup."Mapple File Date" <> WORKDATE() THEN BEGIN
    //         GenSetup."Mapple File Date" := WORKDATE();
    //         GenSetup."OSL File No." := 1;
    //     END ELSE
    //         GenSetup."OSL File No." := GenSetup."OSL File No." + 1;
    //     GenSetup.MODIFY();
    //     IF STRLEN(FORMAT(GenSetup."OSL File No.")) = 1 THEN
    //         EVALUATE(FileN11, '0' + FORMAT(GenSetup."OSL File No."))
    //     ELSE
    //         EVALUATE(FileN11, FORMAT(GenSetup."OSL File No."));
    //     //HR+
    //     "no.ser11".RESET();
    //     "no.ser11".SETRANGE("no.ser11"."Series Code", 'OSL');
    //     "no.ser11".SETRANGE("no.ser11".Open, TRUE);
    //     "no.ser11".SETFILTER("no.ser11"."Last No. Used", '<>%1', '');
    //     IF "no.ser11".FINDFIRST() THEN
    //         FileN11 := "no.ser11"."Last No. Used";
    //     Fname11 := '240603_EU_OSL_' + FORMAT(TODAY, 0, '<Year4><Month,2><Day,2>') + FileN11 + '.txt';
    //     //FileMgt11.DownloadToFile(FileName11, 'F:\SFTP\OSL\'+Fname11);
    //     /*
    //     IF ISCLEAR(WHS) THEN
    //       CREATE(WHS,FALSE,TRUE) ;
    //     pwrShell := '%SystemRoot%\syswow64\WindowsPowerShell\v1.0\powershell.exe' ;
    //     pwrShellCmd := STRSUBSTNO('"Get-Content %1.tmp | Out-File %1 -Encoding UTF8"',FileName11) ;
    //     whsWait := TRUE ;
    //     i := WHS.Run(pwrShell + ' ' +pwrShellCmd,whsWait,whsWait)
    //     */
    //     enco := enco.UTF8Encoding(FALSE);
    //     Files.WriteAllText(FileName11, Files.ReadAllText(FileName11, enco));
    //     COPY(FileName11, 'E:\SFTP\OSL\' + Fname11);
    //     ERASE(FileName11);

    //     /*
    //      "no.ser11".RESET;
    //      "no.ser11".SETRANGE("no.ser11"."Series Code",'OSL');
    //      "no.ser11".SETRANGE("no.ser11".Open,TRUE);
    //      "no.ser11".SETFILTER("no.ser11"."Last No. Used",'<>%1','');
    //      IF "no.ser11".FINDFIRST THEN
    //      FileN11:="no.ser11"."Last No. Used";
    //      Fname11:='240603_EU_RET_'+FORMAT(TODAY,0,'<Year4><Month,2><Day,2>')+FileN11+'.txt';

    //      TestFile.CREATE('F:\SFTP\OSL\'+Fname11);
    //      TestFile.CLOSE;
    //      TestFile.WRITEMODE(TRUE);
    //      TestFile.OPEN('F:\SFTP\OSL\'+Fname11);
    //      TestFile.CREATEOUTSTREAM(TestStream);
    //      XmlP11.FILENAME('F:\SFTP\OSL\'+Fname11);
    //      XmlP11.SETDESTINATION(TestStream);
    //      XmlP11.EXPORT;
    //      TestFile.CLOSE;
    //      */

    // end;

    // Mapple NG 1.0 START - 04072023
    procedure OSL();
    var
        "no.ser11": Record 309;
        NoSeriesManagement11: Codeunit 396;
        FileMgt11: Codeunit 419;
        TempBlob: Codeunit "Temp Blob";
        XmlP11: XMLport 50033;
        FileN11: Code[100];
        OutFile11: File;
        TestFile: File;
        OutS11: OutStream;
        TestStream: OutStream;
        FileName11: Text;
        Fname11: Text;
        Instram: InStream;
    begin

        FileName11 := 'OSL.txt';
        TempBlob.CreateInStream(Instram);
        TempBlob.CreateOutStream(OutS11);
        XmlP11.Filename(FileName11);
        XmlP11.SetDestination(OutS11);
        XmlP11.TextEncoding(TextEncoding::UTF8);
        XmlP11.SetSource(Instram);
        XmlP11.Export();

        // HR-
        XmlP11.GetDTLS(GetDLSS);
        IF GetDLSS = '' THEN
            EXIT;
        GenSetup.GET();
        IF GenSetup."Mapple File Date" <> WORKDATE() THEN BEGIN
            GenSetup."Mapple File Date" := WORKDATE();
            GenSetup."OSL File No." := 1;
        END ELSE
            GenSetup."OSL File No." := GenSetup."OSL File No." + 1;
        GenSetup.MODIFY();
        IF STRLEN(FORMAT(GenSetup."OSL File No.")) = 1 THEN
            EVALUATE(FileN11, '0' + FORMAT(GenSetup."OSL File No."))
        ELSE
            EVALUATE(FileN11, FORMAT(GenSetup."OSL File No."));
        //HR+
        "no.ser11".RESET();
        "no.ser11".SETRANGE("no.ser11"."Series Code", 'OSL');
        "no.ser11".SETRANGE("no.ser11".Open, TRUE);
        "no.ser11".SETFILTER("no.ser11"."Last No. Used", '<>%1', '');
        IF "no.ser11".FINDFIRST() THEN
            FileN11 := "no.ser11"."Last No. Used";
        Fname11 := '240603_EU_OSL_' + FORMAT(TODAY, 0, '<Year4><Month,2><Day,2>') + FileN11 + '.txt';
        DownloadFromStream(Instram, '', 'E:\SFTP\OSL\' + Fname11, '', Fname11);

    end;
    // Mapple NG 1.0 END - 04072023
    procedure RemoveHiddenCharacters(var ValueToClean: Text[3]);
    var
        i: Integer;
        Ch: array[3] of Text;
    begin
        FOR i := 1 TO 3
        DO BEGIN
            Ch[1] := '239'; //EF
            Ch[2] := '187';//BB
            Ch[3] := '191';//BF
            ValueToClean := DELCHR(ValueToClean, '=', Ch[i]);
        END;//EF BB BF
    end;
}

