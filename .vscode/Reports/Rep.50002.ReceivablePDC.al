report 50002 "Receivable PDC"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReceivablePDC.rdlc';
    Caption = 'Receivable PDC';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Customer; Customer)
        {
            CalcFields = Balance;
            DataItemTableView = SORTING("No.")
                                WHERE(Balance = FILTER(<> 0));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Date Filter";
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(Customer_Customer__No__; Customer."No.")
            {
            }
            column(PDC_Report_ReceivableCaption; PDC_Report_ReceivableCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }//tk
            column(Customer_Date_Filter; "Date Filter")
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                CalcFields = "Remaining Amount", Amount, "PDC Unposted Amount";
                DataItemLink = "Customer No." = FIELD("No."),
                               "Posting Date" = FIELD("Date Filter");
                DataItemTableView = SORTING("Customer No.", "Posting Date")
                                    WHERE(Open = CONST(true));
                column(DrText1; DrText1)
                {
                }//tk
                column(Remaining_Amount__; ("Remaining Amount"))
                {
                }
                column(Cust__Ledger_Entry__Document_No__; "Document No.")
                {
                }
                column(Cust__Ledger_Entry__Document_Type_; "Document Type")
                {
                }
                column(Cust__Ledger_Entry__Posting_Date_; "Posting Date")
                {
                }
                column(Cust__Ledger_Entry__Due_Date_; "Due Date")
                {
                }
                column(Cust__Ledger_Entry__PDC_Unposted_Amount_; "PDC Unposted Amount")
                {
                }
                column(BalanceFollow; BalanceFollow)
                {
                }
                column(ChkDate; ChkDate)
                {
                }//tk
                column(Remaining_Amount___13; ("Remaining Amount"))
                {
                }
                column(Cust__Ledger_Entry__PDC_Unposted_Amount__14; "PDC Unposted Amount")
                {
                }
                column(DrText1_21; DrText1)
                {
                }
                column(BalanceFollow_22; BalanceFollow)
                {
                }
                column(OutStanding_AmountCaption; OutStanding_AmountCaptionLbl)
                {
                }
                column(Document_No_Caption; Document_No_CaptionLbl)
                {
                }
                column(Document_TypeCaption; Document_TypeCaptionLbl)
                {
                }
                column(DateCaption; DateCaptionLbl)
                {
                }
                column(Cust__Ledger_Entry__Due_Date_Caption; FIELDCAPTION("Due Date"))
                {
                }
                column(PDC_In_HandCaption_Control1000000008; PDC_In_HandCaption_Control1000000008Lbl)
                {
                }
                column(Balance_FollowupCaption; Balance_FollowupCaptionLbl)
                {
                }
                column(Cheque_DateCaption; Cheque_DateCaptionLbl)
                {
                }//tk
                column(Cust__Ledger_Entry_Entry_No_; "Entry No.")
                {
                }
                column(Cust__Ledger_Entry_Customer_No_; "Customer No.")
                {
                }

                trigger OnAfterGetRecord()
                begin

                    IF BalanceFollow < 0 THEN
                        BalanceFollow := 0//tk
                    ELSE BEGIN
                        //IF "Cust. Ledger Entry"."Document Type"="Cust. Ledger Entry"."Document Type"::Invoice THEN
                        //BalanceFollow:="Cust. Ledger Entry"."Remaining Amount"-"Cust. Ledger Entry"."PDC Unposted Amount";
                    END;//tk

                    //PDCApplEntry1.RESET;
                    //PDC.RESET;
                    //PDCApplEntry1.SETRANGE(PDCApplEntry1."Cust Ledger Entry No.","Cust. Ledger Entry"."Entry No.");

                    //IF PDCApplEntry1.FINDFIRST THEN BEGIN
                    //REPEAT
                    //PDC.SETRANGE(PDC."Entry No.",PDCApplEntry."PDC Entry No.");
                    //IF PDC.FINDFIRST THEN
                    //ChkDate:=PDC."PDC Cheque Date";
                    //UNTIL PDCApplEntry1.NEXT=0;
                    //END;
                end;

                trigger OnPreDataItem()
                begin
                    CurrReport.CREATETOTALS(BalanceFollow);

                    ChkDate := 0D;//tk
                end;
            }
            dataitem(PDC; PDC)
            {
                DataItemLink = "Account No." = FIELD("No.");
                DataItemTableView = SORTING("Entry No.")
                                    WHERE("Account Type" = FILTER(Customer),
                                         "PDC Amount Applied" = FILTER(<> 0),
                                          "PDC Deposited" = FILTER(False));

                trigger OnAfterGetRecord()
                begin
                    PDCApplEntry.SETRANGE(PDCApplEntry."Entry No.", PDC."Entry No.");
                    IF PDCApplEntry.FINDFIRST THEN BEGIN
                        //  docno := PDCApplEntry."Remaining Amount";
                        //  InvDate := PDCApplEntry."PDC Unposted Amount";//tk
                    END;//tk
                end;
            }
            dataitem(PDC1; PDC)
            {
                DataItemLink = "Account No." = FIELD("No.");
                DataItemTableView = SORTING("Entry No.")
                                    WHERE("Account Type" = FILTER(Customer),
                                          "PDC Amount Applied" = FILTER(= 0),
                                          "PDC Deposited" = FILTER(False));
            }
            dataitem(Integer; Integer)
            {
                DataItemTableView = SORTING(Number);
                MaxIteration = 1;
            }

            trigger OnPreDataItem()
            begin
                TotAmount := 0;
                CurrReport.CREATETOTALS(TotAmount, "Cust. Ledger Entry"."Remaining Amt. (LCY)", PDC."PDC Amount");

                "Cust. Ledger Entry".CALCFIELDS("Cust. Ledger Entry"."Remaining Amt. (LCY)");
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

    trigger OnInitReport()
    begin
        PrintToExcel := FALSE;
        RowID := 3;
    end;

    trigger OnPostReport()
    begin
        IF PrintToExcel THEN BEGIN
            //ExcelBuf.CreateBook;
            //ExcelBuf.CreateSheet('PDC Report Receivable','PDC Report Receivable',COMPANYNAME,USERID);
            //ExcelBuf.GiveUserControl;
        END;
    end;

    trigger OnPreReport()
    begin
        //RowID:=7;

        IF PrintToExcel THEN
            ExcelBuf.DELETEALL(TRUE);
    end;

    var
        DrText1: Text[2];
        DrText: Text[2];
        InvDate: Date;
        docno: Code[20];
        "Pdc Table": Record 50002;
        PDCApplEntry: Record 50005;
        CustLedgEntry: Record 21;
        PDCApplEntry1: Record 50005;
        TotAmount: Decimal;
        BalanceFollow: Decimal;
        ChkDate: Date;
        ExcelBuf: Record 370;
        PrintToExcel: Boolean;
        RowID: Integer;
        UserSetup: Record 91;
        PDC_Report_ReceivableCaptionLbl: Label 'PDC Report Receivable';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        OutStanding_AmountCaptionLbl: Label 'OutStanding Amount';
        Document_No_CaptionLbl: Label 'Document No.';
        Document_TypeCaptionLbl: Label 'Document Type';
        DateCaptionLbl: Label 'Date';
        PDC_In_HandCaption_Control1000000008Lbl: Label 'PDC In Hand';
        Balance_FollowupCaptionLbl: Label 'Balance Followup';
        Cheque_DateCaptionLbl: Label 'Cheque Date';


    procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[50]; Bold: Boolean; Underline: Boolean; NumberFormat: Text[30]): Boolean
    begin
    end;
}

