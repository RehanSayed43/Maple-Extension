report 50052 "Income_Statement"
{
    DefaultLayout = RDLC;
    RDLCLayout = './IncomeStatement.rdl';
    Caption = 'Income Statement';
    ApplicationArea = FixedAsset;

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = SORTING("No.") where("Income/Balance" = const("Income Statement"));
            // WHERE ("Income/Balance"=CONST("Income Statement"));
            RequestFilterFields = "No.", "Account Type", "Date Filter", "Global Dimension 1 Filter", "Global Dimension 2 Filter";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(LongText_1____LongText_2____LongText_3____LongText_4_; LongText[1] + LongText[2] + LongText[3] + LongText[4])
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(USERID; USERID)
            {
            }
            column(TotalLongText; TotalLongText)
            {
            }
            column(HeaderText; HeaderText)
            {
            }
            column(TotalHeaderText; TotalHeaderText)
            {
            }
            column(G_L_Account__TABLENAME__________GLFilter; "G/L Account".TABLENAME + ': ' + GLFilter)
            {
            }
            column(GLFilter; GLFilter)
            {
            }
            column(RoundFactorText; RoundFactorText)
            {
            }
            column(EmptyString; '')
            {
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(NextPageGroupNo; NextPageGroupNo)
            {
            }
            column(Income_StatementCaption; Income_StatementCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Current_PeriodCaption; Current_PeriodCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__Name_Control1500023Caption; PADSTR_____G_L_Account__Indentation___2___G_L_Account__Name_Control1500023CaptionLbl)
            {
            }
            column(CurrentPeriodNetChangeCaption; CurrentPeriodNetChangeCaptionLbl)
            {
            }
            column(CurrentPeriodNetChange_Control1500025Caption; CurrentPeriodNetChange_Control1500025CaptionLbl)
            {
            }
            column(Current_Period_Last_YearCaption; Current_Period_Last_YearCaptionLbl)
            {
            }
            column(Current_YTDCaption; Current_YTDCaptionLbl)
            {
            }
            column(Last_YTDCaption; Last_YTDCaptionLbl)
            {
            }
            column(G_L_Account_No_; "No.")
            {
            }
            dataitem(BlankLineCounter; Integer)
            // BlankLineCounter
            //dataitem(BlankLineCounter; Integer)
            {
                DataItemTableView = SORTING(Number);
                column(G_L_Account___No__of_Blank_Lines_; "G/L Account"."No. of Blank Lines")
                {
                }
                column(BlankLineCounter_Number; Number)
                {
                }

                trigger OnPreDataItem()
                begin
                    SETRANGE(Number, 1, "G/L Account"."No. of Blank Lines");
                end;
            }
            //dataitem(DataItem5444; Table2000000026)
            dataitem(Integer; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
                column(G_L_Account___No__; "G/L Account"."No.")
                {
                }
                column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__Name; PADSTR('', "G/L Account".Indentation * 2) + "G/L Account".Name)
                {
                }
                column(ShowAccType; ShowAccType)
                {
                }
                column(G_L_Account___No___Control1500022; "G/L Account"."No.")
                {
                }
                column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__Name_Control1500023; PADSTR('', "G/L Account".Indentation * 2) + "G/L Account".Name)
                {
                }
                column(CurrentPeriodNetChange; CurrentPeriodNetChange)
                {
                    DecimalPlaces = 2 : 2;
                }
                column(CurrentPeriodNetChange_Control1500025; -CurrentPeriodNetChange)
                {
                    DecimalPlaces = 2 : 2;
                }
                column(LastYrCurrPeriodNetChange; LastYrCurrPeriodNetChange)
                {
                    DecimalPlaces = 2 : 2;
                }
                column(CurrentYTDNetChange; CurrentYTDNetChange)
                {
                    DecimalPlaces = 2 : 2;
                }
                column(LastYTDNetChange; LastYTDNetChange)
                {
                    DecimalPlaces = 2 : 2;
                }
                column(G_L_Account___No___Control1500029; "G/L Account"."No.")
                {
                }
                column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__Name_Control1500030; PADSTR('', "G/L Account".Indentation * 2) + "G/L Account".Name)
                {
                }
                column(LastYTDNetChange_Control1500031; LastYTDNetChange)
                {
                    DecimalPlaces = 2 : 2;
                }
                column(LastYrCurrPeriodNetChange_Control1500032; LastYrCurrPeriodNetChange)
                {
                    DecimalPlaces = 2 : 2;
                }
                column(CurrentYTDNetChange_Control1500033; CurrentYTDNetChange)
                {
                    DecimalPlaces = 2 : 2;
                }
                column(CurrentPeriodNetChange_Control1500034; -CurrentPeriodNetChange)
                {
                    DecimalPlaces = 2 : 2;
                }
                column(CurrentPeriodNetChange_Control1500035; CurrentPeriodNetChange)
                {
                    DecimalPlaces = 2 : 2;
                }
                column(G_L_Account___Account_Type_; "G/L Account"."Account Type")
                {
                }
                column(Integer_Number; Number)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                IF NOT AddCurr THEN BEGIN
                    SETRANGE("Date Filter", CurrentPeriodStart, CurrentPeriodEnd);
                    CALCFIELDS("Net Change");
                    CurrentPeriodNetChange := ReportMngmt.RoundAmount("Net Change", RoundingFactor);

                    SETRANGE("Date Filter", CurrentYearStart, CurrentPeriodEnd);
                    CALCFIELDS("Net Change");
                    CurrentYTDNetChange := ReportMngmt.RoundAmount("Net Change", RoundingFactor);

                    SETRANGE("Date Filter", LastYearCurrentPeriodStart, LastYearCurrentPeriodEnd);
                    CALCFIELDS("Net Change");
                    LastYrCurrPeriodNetChange := ReportMngmt.RoundAmount("Net Change", RoundingFactor);

                    SETRANGE("Date Filter", LastYearStart, LastYearCurrentPeriodEnd);
                    CALCFIELDS("Net Change");
                    LastYTDNetChange := ReportMngmt.RoundAmount("Net Change", RoundingFactor);

                    IF (CurrentPeriodNetChange = 0) AND (CurrentYTDNetChange = 0) AND
                      (LastYrCurrPeriodNetChange = 0) AND (LastYTDNetChange = 0) AND
                      ("Account Type" = "Account Type"::Posting)
                    THEN
                        CurrReport.SKIP;
                END ELSE BEGIN
                    SETRANGE("Date Filter", CurrentPeriodStart, CurrentPeriodEnd);
                    CALCFIELDS("Additional-Currency Net Change");
                    CurrentPeriodNetChange :=
                      ReportMngmt.RoundAmount("Additional-Currency Net Change", RoundingFactor);

                    SETRANGE("Date Filter", CurrentYearStart, CurrentPeriodEnd);
                    CALCFIELDS("Additional-Currency Net Change");
                    CurrentYTDNetChange :=
                      ReportMngmt.RoundAmount("Additional-Currency Net Change", RoundingFactor);

                    SETRANGE("Date Filter", LastYearCurrentPeriodStart, LastYearCurrentPeriodEnd);
                    CALCFIELDS("Additional-Currency Net Change");
                    LastYrCurrPeriodNetChange :=
                      ReportMngmt.RoundAmount("Additional-Currency Net Change", RoundingFactor);

                    SETRANGE("Date Filter", LastYearStart, LastYearCurrentPeriodEnd);
                    CALCFIELDS("Net Change");
                    LastYTDNetChange :=
                      ReportMngmt.RoundAmount("Additional-Currency Net Change", RoundingFactor);

                    IF (CurrentPeriodNetChange = 0) AND (CurrentYTDNetChange = 0) AND
                      (LastYrCurrPeriodNetChange = 0) AND (LastYTDNetChange = 0) AND
                      ("Account Type" = "Account Type"::Posting)
                    THEN
                        CurrReport.SKIP;
                END;
                IF ISSERVICETIER THEN BEGIN
                    PageGroupNo := NextPageGroupNo;
                    ShowAccType := "G/L Account"."Account Type";
                    IF "G/L Account"."New Page" THEN
                        NextPageGroupNo := PageGroupNo + 1;
                    IF PageGroupNo = NextPageGroupNo THEN
                        PageGroupNo := NextPageGroupNo - 1;
                END;
            end;

            trigger OnPreDataItem()
            begin
                //Add TotalLongText,TotalHeaderText.Begin,COMMENTS
                IF ISSERVICETIER THEN BEGIN
                    TotalLongText :=
                      STRSUBSTNO(
                        'Period: %1..%2 versus %3..%4',
                        CurrentPeriodStart, CurrentPeriodEnd, LastYearCurrentPeriodStart, LastYearCurrentPeriodEnd) + '' + '' + '';

                    GLSetupNNC.GET;
                    IF AddCurr THEN
                        TotalHeaderText := STRSUBSTNO(Text1450000, GLSetupNNC."Additional Reporting Currency")
                    ELSE BEGIN
                        GLSetupNNC.TESTFIELD("LCY Code");
                        TotalHeaderText := STRSUBSTNO(Text1450000, GLSetupNNC."LCY Code");
                    END;
                END;
                //Add TotalLongText,TotalHeaderText.End

                PageGroupNo := 1;
                NextPageGroupNo := 1;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(RoundingFactor; RoundingFactor)
                    {
                        ApplicationArea = all;
                        Caption = 'Amounts in whole';
                    }
                    field(AddCurr; AddCurr)
                    {
                        ApplicationArea = all;
                        Caption = 'Show Amounts in Add. Reporting Currency';
                        MultiLine = true;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        GLFilter := "G/L Account".GETFILTERS;
        RoundFactorText := ReportMngmt.RoundDescription(RoundingFactor);
        CurrentPeriodStart := "G/L Account".GETRANGEMIN("Date Filter");
        CurrentPeriodEnd := "G/L Account".GETRANGEMAX("Date Filter");

        LastYearCurrentPeriodStart := CALCDATE('-1Y', NORMALDATE(CurrentPeriodStart) + 1) - 1;
        LastYearCurrentPeriodEnd := CALCDATE('-1Y', NORMALDATE(CurrentPeriodEnd) + 1) - 1;
        IF CurrentPeriodStart <> NORMALDATE(CurrentPeriodStart) THEN
            LastYearCurrentPeriodStart := CLOSINGDATE(LastYearCurrentPeriodStart);
        IF CurrentPeriodEnd <> NORMALDATE(CurrentPeriodEnd) THEN
            LastYearCurrentPeriodEnd := CLOSINGDATE(LastYearCurrentPeriodEnd);

        AccPeriod.RESET;
        AccPeriod.SETRANGE(AccPeriod."New Fiscal Year", TRUE, TRUE);
        AccPeriod.SETFILTER(AccPeriod."Starting Date", '..%1', CurrentPeriodEnd);
        AccPeriod.FIND('+');
        CurrentYearStart := AccPeriod."Starting Date";

        AccPeriod.SETFILTER(AccPeriod."Starting Date", '..%1', LastYearCurrentPeriodEnd);
        IF AccPeriod.FIND('+') THEN
            LastYearStart := AccPeriod."Starting Date";
    end;

    var
        AccPeriod: Record 50;
        // ReportMngmt: Codeunit 50001;
        ReportMngmt: Codeunit 50001; //kj
        GLFilter: Text[250];
        LongText: array[4] of Text[132];
        CurrentPeriodStart: Date;
        CurrentPeriodEnd: Date;
        LastYearCurrentPeriodStart: Date;
        LastYearCurrentPeriodEnd: Date;
        CurrentYearStart: Date;
        LastYearStart: Date;
        CurrentPeriodNetChange: Decimal;
        CurrentYTDNetChange: Decimal;
        LastYrCurrPeriodNetChange: Decimal;
        LastYTDNetChange: Decimal;
        AddCurr: Boolean;
        RoundingFactor: Option " ",Tens,Hundreds,Thousands,"Hundred Thousands",Millions;
        HeaderText: Text[50];
        RoundFactorText: Text[50];
        Text1450000: Label 'All amounts are in %1.';
        PageGroupNo: Integer;
        TotalLongText: Text[250];
        TotalHeaderText: Text[250];
        GLSetupNNC: Record 98;
        ShowAccType: Integer;
        NextPageGroupNo: Integer;
        Income_StatementCaptionLbl: Label 'Income Statement';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Current_PeriodCaptionLbl: Label 'Current Period';
        No_CaptionLbl: Label 'No.';
        PADSTR_____G_L_Account__Indentation___2___G_L_Account__Name_Control1500023CaptionLbl: Label 'Name';
        CurrentPeriodNetChangeCaptionLbl: Label 'Debit';
        CurrentPeriodNetChange_Control1500025CaptionLbl: Label 'Credit';
        Current_Period_Last_YearCaptionLbl: Label 'Current Period Last Year';
        Current_YTDCaptionLbl: Label 'Current YTD';
        Last_YTDCaptionLbl: Label 'Last YTD';
}

