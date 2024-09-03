report 50116 "Trial Balance New"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'TrialBalance12.rdl';

    DATASET
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Date Filter", "Account Type", "Global Dimension 1 Filter", "Global Dimension 2 Filter";
            CalcFields = "Credit Amount", "Debit Amount";

            Column(STRSUBSTNO_Text000_PeriodText_; STRSUBSTNO(Text000, PeriodText))
            {
            }
            Column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(COMPANYNAME; COMPANYPROPERTY.DisplayName)
            {
            }
            column(RecCompInfo_Name; CompInfo.Name)
            {
            }
            column(RecCompInfo_Address; CompInfo.Address)
            {
            }
            column(RecCompInfo_Address2; CompInfo."Address 2")
            {
            }
            column(RecCompInfo_PinCode; CompInfo."Post Code")
            {
            }
            column(RecCompInfo_City; CompInfo.City)
            {
            }
            column(RecCompInfo_Country; CompInfo.County)
            {
            }
            column(RecCompInfo_PhoneNo; CompInfo."Phone No.")
            {
            }
            column(RecCompInfo_GSTRegNo; CompInfo."GST Registration No.")
            {
            }
            column(RecCompInfo_Picture; '')
            {
            }
            column(CompStateName; CompStateName)
            {
            }
            column(CompStateCode; CompStateCode)
            {
            }
            column(RecCompInfo_PANNo; CompInfo."P.A.N. No.")
            {
            }
            column(RecCompInfo_SWIFT; CompInfo."SWIFT Code")
            {
            }
            column(RecCompInfo_IBAN; CompInfo.IBAN)
            {
            }
            column(RecCompInfo_HomePage; CompInfo."Home Page")
            {
            }
            column(RecCompInfo_GiroNo; CompInfo."Giro No.")
            {
            }
            column(RecCompInfo; CompInfo."E-Mail")
            {
            }
            Column(CompInfo_Picture; '')
            {
            }
            Column(PeriodText; PeriodText)
            {
            }
            Column(G_L_Account__TABLECAPTION__________GLFilter; TABLECAPTION + ': ' + GLFilter)
            {
            }
            Column(GLFilter; GLFilter)
            {
            }
            Column(G_L_Account_No_; "No.")
            {
            }
            column(Client_G_L_Account_No_; '')
            {
            }
            Column(Trial_BalanceCaption; Trial_BalanceCaptionLbl)
            {
            }
            Column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            Column(Net_ChangeCaption; Net_ChangeCaptionLbl)
            {
            }
            Column(BalanceCaption; BalanceCaptionLbl)
            {
            }
            Column(G_L_Account___No__Caption; FIELDCAPTION("No."))
            {
            }
            Column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaption; PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaptionLbl)
            {
            }
            Column(G_L_Account___Net_Change_Caption; G_L_Account___Net_Change_CaptionLbl)
            {
            }
            Column(G_L_Account___Net_Change__Control22Caption; "G_L_Account___Net_Change__Control22CaptionLbl")
            {
            }
            Column(G_L_Account___Balance_at_Date_Caption; "G_L_Account___Balance_at_Date_CaptionLbl")
            {
            }
            Column(G_L_Account___Balance_at_Date__Control24Caption; "G_L_Account___Balance_at_Date__Control24CaptionLbl")
            {
            }
            Column(G_L_Account___Opening_Caption; "G_L_Account___Opening_CaptionLbl")
            {
            }
            Column(G_L_Account___Opening_Control7Caption; "G_L_Account___Opening_Control7CaptionLbl")
            {
            }
            dataitem(Integer; Integer)
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                Column(G_L_Account___No__; "G/L Account"."No.")
                {
                }
                Column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__Name; PADSTR('', "G/L Account".Indentation * 2) + "G/L Account".Name)
                {
                }
                Column(G_L_Account___Net_Change_; "G/L Account"."Net Change")
                {
                }
                Column(G_L_Account___Net_Change__Control22; -"G/L Account"."Net Change")
                {
                }
                Column(G_L_Account___Balance_at_Date_; "G/L Account"."Balance at Date")
                {
                }
                Column(G_L_Account___Balance_at_Date__Control24; -"G/L Account"."Balance at Date")
                {
                }
                Column(G_L_Account___Account_Type_; FORMAT("G/L Account"."Account Type", 0, 2))
                {
                }
                Column(No__of_Blank_Lines; "G/L Account"."No. of Blank Lines")
                {
                }
                Column(GLAcc_Balance_at_Date; GLAcc."Balance at Date")
                {
                }
                Column(GLAcc_Balance_at_Date_Control7; -GLAcc."Balance at Date")
                {
                }
                Column(GTotalOpnDebit; GTotalOpnDebit)
                {
                }
                Column(GTotalOpnCredit; GTotalOpnCredit)
                {
                }
                Column(GTotalNetDebit; GTotalNetDebit)
                {
                }
                Column(GTotalNetCredit; GTotalNetCredit)
                {
                }
                Column(GTotalClosingDebit; GTotalClosingDebit)
                {
                }
                Column(GTotalClosingCredit; GTotalClosingCredit)
                {
                }
                Column(GL_Account_Debit_Amount; "G/L Account"."Debit Amount")
                {
                }
                Column(GL_Account_Credit_Amount; "G/L Account"."Credit Amount")
                {
                }
                Column(TotalCredit; TotalCredit)
                {
                }
                Column(TotalDebit; TotalDebit)
                {
                }
                Column(TotalNetChange; TotalNetChange)
                {
                }
                Column(GLAccount_ArabicDescription; '')
                {
                }
                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    IF ShowBal THEN BEGIN
                        IF (GLAcc."Balance at Date" = 0) AND ("G/L Account"."Net Change" = 0) AND ("G/L Account"."Balance at Date" = 0) THEN CurrReport.SKIP;
                    END;
                END;
            }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            //  CompInfo: Record "Company Information";
            begin
                CompInfo.GET;
                CompInfo.CALCFIELDS(Picture);
            END;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            //  GLAcc: record "G/L Account";
            /*  GTotalOpnDebit: Decimal;
              GTotalOpnCredit: Decimal;
              GTotalNetDebit: Decimal;
              GTotalNetCredit: Decimal;
              TotalCredit: Decimal;
              TotalDebit: Decimal;*/
            //   TotalNetChange: Decimal;
            //   GTotalClosingDebit: Decimal;
            //   GTotalClosingCredit: Decimal;
            //   PrintToExcel: Boolean;
            begin
                CALCFIELDS("Net Change", "Balance at Date", "Credit Amount", "Debit Amount");
                GLAcc.RESET;
                GLAcc.SETRANGE("No.", "G/L Account"."No.");
                GLAcc.SETFILTER("Date Filter", '%1..%2', 0D, ClosingDate("G/L Account".GETRANGEMIN("Date Filter") - 1));
                IF GLAcc.FINDFIRST THEN GLAcc.CALCFIELDS(GLAcc."Balance at Date");
                IF "G/L Account"."Account Type" = "G/L Account"."Account Type"::Posting THEN BEGIN
                    //opn Total
                    IF GLAcc."Balance at Date" > 0 THEN
                        GTotalOpnDebit += ABS(GLAcc."Balance at Date")
                    ELSE
                        GTotalOpnCredit += ABS(GLAcc."Balance at Date");
                    //Net Change Total
                    IF "G/L Account"."Net Change" > 0 THEN
                        GTotalNetDebit += ABS("G/L Account"."Net Change")
                    ELSE
                        GTotalNetCredit += ABS("G/L Account"."Net Change");
                    TotalCredit += ABS("G/L Account"."Credit Amount");
                    TotalDebit += "G/L Account"."Debit Amount";
                    TotalNetChange += "G/L Account"."Net Change";
                    //Closing total
                    IF "G/L Account"."Balance at Date" > 0 THEN
                        GTotalClosingDebit += ABS("G/L Account"."Balance at Date")
                    ELSE
                        GTotalClosingCredit += ABS("G/L Account"."Balance at Date");
                    // AccountingPeriod.Reset();
                    // // AccountingPeriod.SetRange("Starting Date", "G/L Account"."Date Filter");
                    // AccountingPeriod.SetFilter("Starting Date", '%1..%2', 0D, "G/L Account".GetRangeMin("Date Filter") - 1);
                    // if AccountingPeriod.Find() then begin
                    //     if AccountingPeriod.Closed = true then begin
                    //         "G/L Account"."Debit Amount" := 0;
                    //         "G/L Account"."Credit Amount" := 0;
                    //     end;
                    // end;
                END;
                if "G/L Account"."Income/Balance" = "G/L Account"."Income/Balance"::"Income Statement" then begin
                    // Message('%1', "G/L Account"."No.");
                end;
                IF PrintToExcel THEN MakeExcelDataBody;
            END;

            trigger OnPostDataItem()
            begin
                IF PrintToExcel THEN BEGIN
                    ExcelBuf.NewRow;
                    ExcelBuf.AddColumn('TOTALS', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(TotalDebitNetChange, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    // ExcelBuf.AddColumn(TotalCreditNetChange, FALSE, '', TRUE,
                    //   FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(TotalDebitBalanceAtDate, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(TotalCreditBalanceAtDate, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                END;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(PrintToExcel; PrintToExcel)
                    {
                        ApplicationArea = all;
                    }
                }
            }
        }
    }
    trigger OnInitReport()
    begin
        CompStateName := '';
        CompStateCode := '';
        CompInfo.Get();
        CompInfo.CalcFields(Picture);
        if RecState.Get(CompInfo."State Code") then begin
            CompStateName := RecState.Description;
            CompStateCode := RecState."State Code (GST Reg. No.)";
        end;
    end;

    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        PeriodText := "G/L Account".GetFilter("Date Filter");
        if PrintToExcel then MakeExcelInfo();
    end;

    trigger OnPostReport()
    var
    begin
        if PrintToExcel then CreateExcelbook;
    end;

    VAR
        AccountingPeriod: record "Accounting Period";
        RecState: Record State;
        CompStateName: Code[20];
        CompStateCode: Code[20];
        Text000: TextConst ENU = 'Period: %1';
        ExcelBuf: Record "Excel Buffer" temporary;
        GLFilter: Text[250];
        PeriodText: Text[30];
        PrintToExcel: Boolean;
        Text001: TextConst ENU = 'Trial Balance';
        Text002: TextConst ENU = 'Data';
        Text003: TextConst ENU = 'Debit';
        Text004: TextConst ENU = 'Credit';
        Text005: TextConst ENU = 'Company Name';
        Text006: TextConst ENU = 'Report No.';
        Text007: TextConst ENU = 'Report Name';
        Text008: TextConst ENU = 'User ID';
        Text009: TextConst ENU = 'Date';
        Text010: TextConst ENU = 'G/L Filter';
        Text011: TextConst ENU = 'Period Filter';
        Trial_BalanceCaptionLbl: TextConst ENU = 'Trial Balance';
        CurrReport_PAGENOCaptionLbl: TextConst ENU = 'Page';
        Net_ChangeCaptionLbl: TextConst ENU = 'Net Change';
        BalanceCaptionLbl: TextConst ENU = 'Balance';
        PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaptionLbl: TextConst ENU = 'Name';
        G_L_Account___Net_Change_CaptionLbl: TextConst ENU = 'Debit';
        G_L_Account___Net_Change__Control22CaptionLbl: TextConst ENU = 'Credit';
        G_L_Account___Balance_at_Date_CaptionLbl: TextConst ENU = 'Debit';
        G_L_Account___Balance_at_Date__Control24CaptionLbl: TextConst ENU = 'Credit';
        GLAcc: Record 15;
        G_L_Account___Opening_CaptionLbl: TextConst ENU = 'Debit';
        G_L_Account___Opening_Control7CaptionLbl: TextConst ENU = 'Credit';
        CompInfo: Record 79;
        ShowBal: Boolean;
        GTotalOpnDebit: Decimal;
        hb: Report "Trial Balance";
        GTotalOpnCredit: Decimal;
        GTotalNetDebit: Decimal;
        GTotalNetCredit: Decimal;
        GTotalClosingDebit: Decimal;
        GTotalClosingCredit: Decimal;
        TotalCredit: Decimal;
        TotalDebit: Decimal;
        TotalNetChange: Decimal;
        TotalDebitNetChange: Decimal;
        TotalCreditNetChange: Decimal;
        TotalDebitBalanceAtDate: Decimal;
        TotalCreditBalanceAtDate: Decimal;

    PROCEDURE MakeExcelInfo();
    BEGIN
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn(FORMAT(Text005), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(COMPANYNAME, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text007), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FORMAT(Text001), FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text006), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(100, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number); //vikas
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text008), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(USERID, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text009), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(TODAY, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text010), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn("G/L Account".GETFILTER("No."), FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text011), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn("G/L Account".GETFILTER("Date Filter"), FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;
    END;

    LOCAL PROCEDURE MakeExcelDataHeader();
    BEGIN
        ExcelBuf.AddColumn("G/L Account".FIELDCAPTION("No."), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("G/L Account".FIELDCAPTION(Name), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('Opening' + ' - ' + Text003), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('Opening' + ' - ' + Text004), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT("G/L Account".FIELDCAPTION("Net Change") + ' - ' + Text003), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT("G/L Account".FIELDCAPTION("Net Change") + ' - ' + Text004), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        // //added>
        // ExcelBuf.AddColumn(
        //   FORMAT("G/L Account".FIELDCAPTION("Net Change")), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        // //added<
        ExcelBuf.AddColumn(FORMAT('Closing' + ' - ' + Text003), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('Closing' + ' - ' + Text004), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
    END;

    PROCEDURE MakeExcelDataBody();
    VAR
        BlankFiller: Text[250];
    BEGIN
        IF ShowBal THEN BEGIN
            IF (GLAcc."Balance at Date" = 0) AND ("G/L Account"."Net Change" = 0) AND ("G/L Account"."Balance at Date" = 0) THEN CurrReport.SKIP;
        END;
        BlankFiller := PADSTR(' ', MAXSTRLEN(BlankFiller), ' ');
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn("G/L Account"."No.", FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        IF "G/L Account".Indentation = 0 THEN begin
            ExcelBuf.AddColumn('', FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn("G/L Account".Name, FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
        end
        ELSE begin
            ExcelBuf.AddColumn(COPYSTR(BlankFiller, 1, 2 * "G/L Account".Indentation), FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(COPYSTR(BlankFiller, 1, 2 * "G/L Account".Indentation) + "G/L Account".Name, FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        end;
        CASE TRUE OF //opening
            GLAcc."Balance at Date" = 0:
                BEGIN
                    ExcelBuf.AddColumn('', FALSE, '', GLAcc."Account Type" <> GLAcc."Account Type"::Posting, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', GLAcc."Account Type" <> GLAcc."Account Type"::Posting, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                END;
            GLAcc."Balance at Date" > 0:
                BEGIN
                    ExcelBuf.AddColumn(GLAcc."Balance at Date", FALSE, '', GLAcc."Account Type" <> GLAcc."Account Type"::Posting, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn('', FALSE, '', GLAcc."Account Type" <> GLAcc."Account Type"::Posting, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                END;
            GLAcc."Balance at Date" < 0:
                BEGIN
                    ExcelBuf.AddColumn('', FALSE, '', GLAcc."Account Type" <> GLAcc."Account Type"::Posting, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(-GLAcc."Balance at Date", FALSE, '', GLAcc."Account Type" <> GLAcc."Account Type"::Posting, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
                END;
        END;
        //opening
        ExcelBuf.AddColumn("G/L Account"."Debit Amount", FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        //ExcelBuf.AddColumn(
        //  "G/L Account"."Debit Amount",FALSE,'',"G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting,FALSE,FALSE,'',
        // ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ABS("G/L Account"."Credit Amount"), FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        //ExcelBuf.AddColumn(
        // ABS("G/L Account"."Credit Amount"),FALSE,'',"G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting,FALSE,FALSE,'',
        // ExcelBuf."Cell Type"::Text);
        // ExcelBuf.AddColumn(
        //   "G/L Account"."Net Change", FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting,
        //   FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        // //ExcelBuf.AddColumn(
        //"G/L Account"."Net Change",FALSE,'',"G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting,FALSE,FALSE,'',
        //ExcelBuf."Cell Type"::Text);
        /*
        CASE TRUE OF
          "G/L Account"."Net Change" = 0:
            BEGIN
              ExcelBuf.AddColumn(
                '',FALSE,'',"G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting,FALSE,FALSE,'',
                ExcelBuf."Cell Type"::Text);
              ExcelBuf.AddColumn(
                '',FALSE,'',"G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting,FALSE,FALSE,'',
                ExcelBuf."Cell Type"::Text);
            END;
          "G/L Account"."Net Change" > 0:
            BEGIN
              ExcelBuf.AddColumn(
                "G/L Account"."Net Change",FALSE,'',"G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting,
                FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);
              ExcelBuf.AddColumn(
                '',FALSE,'',"G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting,FALSE,FALSE,'',
                ExcelBuf."Cell Type"::Text);
            END;
          "G/L Account"."Net Change" < 0:
            BEGIN
              ExcelBuf.AddColumn(
                '',FALSE,'',"G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting,FALSE,FALSE,'',
                ExcelBuf."Cell Type"::Text);
              ExcelBuf.AddColumn(
                -"G/L Account"."Net Change",FALSE,'',"G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting,
                FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);
            END;
        END;
        */
        CASE TRUE OF
            "G/L Account"."Balance at Date" = 0:
                BEGIN
                    ExcelBuf.AddColumn('', FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                END;
            "G/L Account"."Balance at Date" > 0:
                BEGIN
                    ExcelBuf.AddColumn("G/L Account"."Balance at Date", FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn('', FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                END;
            "G/L Account"."Balance at Date" < 0:
                BEGIN
                    ExcelBuf.AddColumn('', FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(-"G/L Account"."Balance at Date", FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
                END;
        END;
    END;

    PROCEDURE CreateExcelbook();
    var
        tempblob: Codeunit "Temp Blob";
        instrm: InStream;
        OutStr: OutStream;
        exportfilename: Text;
    BEGIN
        ExcelBuf.CreateNewBook('Trial Balance Report');
        ExcelBuf.WriteSheet('Trial Balance Report', CompanyName, UserId);
        ExcelBuf.CloseBook();
        ExcelBuf.SetFriendlyFilename(StrSubstNo('Trial Balance Report', CurrentDateTime, UserId));
        // ExcelBuf.OpenExcel();
        TempBlob.CreateOutStream(OutStr);
        ExcelBuf.SaveToStream(OutStr, true);
        tempblob.CreateInStream(instrm);
        exportfilename := 'Trial Balance Report.xlsx';
        DownloadFromStream(instrm, '', '', '', exportfilename)
    END;
}
