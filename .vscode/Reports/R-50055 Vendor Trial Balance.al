report 50055 "Vendor Trial Balance"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Vendor Trial Balance.rdl';
    Caption = 'Vendor Trial Balance';
    ApplicationArea = FixedAsset;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            CalcFields = "Dr Change", "Cr Change";
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "Global Dimension 1 Code", "Date Filter";
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
            column(Vendor__No__; "No.")
            {
            }
            column(Vendor_Name; Name)
            {
            }
            column(City_Vendor; Vendor.City)
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
            column(Vendor__No__Caption; FIELDCAPTION("No."))
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
            column(OpeningTotalAmount; OpeningTotalAmount)
            {
            }
            column(ClosingTotalAmount; ClosingTotalAmount)
            {
            }
            column(ClosingAmount; ClosingAmount)
            {
            }
            column(OpeningAmount; OpeningAmount)
            {
            }
            column(Vendor_Location_Code; Vendor."Location Code")
            {
            }
            column(Vendor_Responsibility_Center; Vendor."Responsibility Center")
            {
            }
            column(GlobalDimension1Code_Vendor; Vendor."Global Dimension 1 Code")
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
                // ClosingTotalAmount :=0;

                VarTranDr := "Dr Change";
                VarTranCr := "Cr Change";

                CLEAR(RsVendor);
                RsVendor.SETRANGE(RsVendor."No.", "No.");
                IF RsVendor.FINDFIRST THEN BEGIN
                    RsVendor.SETRANGE(RsVendor."Date Filter", 0D, VarDate - 1);
                    RsVendor.CALCFIELDS(RsVendor."Dr Change", RsVendor."Cr Change");
                    VarOpenDr := RsVendor."Dr Change";
                    VarOpenCr := RsVendor."Cr Change";

                    OpeningAmount := VarOpenDr - VarOpenCr;
                END;

                ///ANKIT

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

            trigger OnPostDataItem()
            begin
                //message(format(ClosingTotalAmount));
            end;

            trigger OnPreDataItem()
            begin
                ///BranchCode := Vendor."Global Dimension 1 Code";
                VarDate := 0D;
                VarDate := GETRANGEMIN("Date Filter");

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
                /*
                IF PrintToExcel = TRUE THEN
                 BEGIN
                  ExcelBuf.DELETEALL;
                  Row:=1;
                 END;
                 */

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
        RsGL: Record 15;
        VarDate: Date;
        RepFilter: Text[200];
        TotVarOpenDr: Decimal;
        TotVarOpenCr: Decimal;
        TotVarTranDr: Decimal;
        TotVarTranCr: Decimal;
        TotVarCloseDr: Decimal;
        TotVarCloseCr: Decimal;
        ExcelBuf: Record 370;
        PrintToExcel: Boolean;
        Row: Integer;
        PrintHead: Boolean;
        RsVendor: Record 23;
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
        CompanyInfo: Record 79;
        OpeningTotalAmount: Decimal;
        ClosingTotalAmount: Decimal;
        ClosingAmount: Decimal;
        OpeningAmount: Decimal;
        BranchCode: Code[20];
}

