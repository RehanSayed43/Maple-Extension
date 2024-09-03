report 50054 "Customer Trial Balance"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Customer Trial Balance.rdl';
    Caption = 'Customer Trial Balance';

    dataset
    {
        dataitem(Customer; Customer)
        {
            CalcFields = "Dr Change", "Cr Change";
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "Date Filter", "Global Dimension 1 Code";
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(RepFilter; RepFilter)
            {
            }
            column(Customer__No__; "No.")
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(City_Customer; Customer.City)
            {
            }
            column(VarTranDr; VarTranDr)
            {
            }
            column(VarTranCr; VarTranCr)
            {
            }
            column(VarCloseDr; VarCloseDr)
            {
            }
            column(VarCloseCr; VarCloseCr)
            {
            }
            column(VarOpenCr; VarOpenCr)
            {
            }
            column(VarOpenDr; VarOpenDr)
            {
            }
            column(TotVarOpenDr; TotVarOpenDr)
            {
            }
            column(TotVarOpenCr; TotVarOpenCr)
            {
            }
            column(TotVarTranDr; TotVarTranDr)
            {
            }
            column(TotVarTranCr; TotVarTranCr)
            {
            }
            column(TotVarCloseDr; TotVarCloseDr)
            {
            }
            column(TotVarCloseCr; TotVarCloseCr)
            {
            }
            column(Trial_BalanceCaption; Trial_BalanceCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Customer__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(TransactionCaption; TransactionCaptionLbl)
            {
            }
            column(DrCaption; DrCaptionLbl)
            {
            }
            column(CrCaption; CrCaptionLbl)
            {
            }
            column(OpeningCaption; OpeningCaptionLbl)
            {
            }
            column(DrCaption_Control1102159024; DrCaption_Control1102159024Lbl)
            {
            }
            column(CrCaption_Control1102159025; CrCaption_Control1102159025Lbl)
            {
            }
            column(CrCaption_Control1102159026; CrCaption_Control1102159026Lbl)
            {
            }
            column(ClosingCaption; ClosingCaptionLbl)
            {
            }
            column(DrCaption_Control1102159027; DrCaption_Control1102159027Lbl)
            {
            }
            column(End_of_ReportCaption; End_of_ReportCaptionLbl)
            {
            }
            column(ClosingAmount; ClosingAmount)
            {
            }
            column(OpeningAmount; OpeningAmount)
            {
            }
            column(Customer_Location_Code; Customer."Location Code")
            {
            }
            column(Customer_Responsibility_Center; Customer."Responsibility Center")
            {
            }
            column(Customer_Global_Dimension_1_Code; Customer."Global Dimension 1 Code")
            {
            }
            column(Customer_Global_Dimension_2_Code; Customer."Global Dimension 2 Code")
            {
            }

            trigger OnAfterGetRecord()
            begin
                CompanyInfo.GET;
                VarOpenDr := 0;
                VarOpenCr := 0;
                VarTranDr := 0;
                VarTranCr := 0;
                VarCloseDr := 0;
                VarCloseCr := 0;


                VarTranDr := "Dr Change";
                VarTranCr := "Cr Change";


                CLEAR(RsCustomer);
                RsCustomer.SETRANGE(RsCustomer."No.", "No.");
                IF RsCustomer.FINDFIRST THEN BEGIN
                    RsCustomer.SETRANGE(RsCustomer."Date Filter", 0D, VarDate - 1);
                    RsCustomer.CALCFIELDS(RsCustomer."Dr Change", RsCustomer."Cr Change");

                    VarOpenDr := RsCustomer."Dr Change";
                    VarOpenCr := RsCustomer."Cr Change";

                    OpeningAmount := VarOpenDr - VarOpenCr;


                    //MESSAGE('%1 %2  $3',RsCustomer."Dr Change",RsCustomer."Cr Change",RsCustomer.GETFILTERS);
                END;

                IF (VarOpenDr - VarOpenCr) + (VarTranDr - VarTranCr) > 0 THEN
                    VarCloseDr := (VarOpenDr - VarOpenCr) + (VarTranDr - VarTranCr)
                ELSE
                    VarCloseCr := ((VarOpenDr - VarOpenCr) + (VarTranDr - VarTranCr)) * -1;

                ClosingAmount := VarCloseDr - VarCloseCr;

                /*
                TotVarOpenDr+=VarOpenDr;
                TotVarOpenCr+=VarOpenCr;
                
                TotVarTranDr+=VarTranDr;
                TotVarTranCr+=VarTranCr;
                
                TotVarCloseDr+=VarCloseDr;
                TotVarCloseCr+=VarCloseCr;
                */

            end;

            trigger OnPreDataItem()
            begin
                VarDate := 0D;
                VarDate := GETRANGEMIN("Date Filter");
                VarBrFilter := Customer."Global Dimension 1 Code";
                //MESSAGE(FORMAT(VarBrFilter));
                RepFilter := '';
                RepFilter := 'Report Filter : ' + GETFILTERS;

                IF RepFilter = '' THEN
                    RepFilter := 'ALL';


                TotVarOpenDr := 0;
                TotVarOpenCr := 0;
                TotVarTranDr := 0;
                TotVarTranCr := 0;
                TotVarCloseDr := 0;
                TotVarCloseCr := 0;

                IF PrintToExcel = TRUE THEN BEGIN
                    ExcelBuf.DELETEALL;
                    Row := 1;
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        /*
        IF PrintToExcel=TRUE THEN BEGIN
          ExcelBuf.RESET;
          ExcelBuf.CreateBook;
          ExcelBuf.CreateSheet('Trial Balance','Trial Balance',COMPANYNAME,USERID);
          ExcelBuf.GiveUserControl;
        END;
        */

    end;

    trigger OnPreReport()
    begin
        PrintHead := FALSE;
    end;

    var
        VarOpenDr: Decimal;
        VarOpenCr: Decimal;
        VarTranDr: Decimal;
        VarTranCr: Decimal;
        VarCloseDr: Decimal;
        VarCloseCr: Decimal;
        RsGL: Record "G/L Account";
        VarDate: Date;
        RepFilter: Text[200];
        TotVarOpenDr: Decimal;
        TotVarOpenCr: Decimal;
        TotVarTranDr: Decimal;
        TotVarTranCr: Decimal;
        TotVarCloseDr: Decimal;
        TotVarCloseCr: Decimal;
        ExcelBuf: Record "Excel Buffer";
        PrintToExcel: Boolean;
        Row: Integer;
        PrintHead: Boolean;
        RsCustomer: Record "Customer";
        Trial_BalanceCaptionLbl: Label 'Trial Balance';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        NameCaptionLbl: Label 'Name';
        TransactionCaptionLbl: Label 'Transaction';
        DrCaptionLbl: Label 'Dr';
        CrCaptionLbl: Label 'Cr';
        OpeningCaptionLbl: Label 'Opening';
        DrCaption_Control1102159024Lbl: Label 'Dr';
        CrCaption_Control1102159025Lbl: Label 'Cr';
        CrCaption_Control1102159026Lbl: Label 'Cr';
        ClosingCaptionLbl: Label 'Closing';
        DrCaption_Control1102159027Lbl: Label 'Dr';
        End_of_ReportCaptionLbl: Label 'End of Report';
        CompanyInfo: Record "Company Information";
        ClosingAmount: Decimal;
        OpeningAmount: Decimal;
        VarBrFilter: Code[15];
}

