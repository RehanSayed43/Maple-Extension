report 50101 "PDC Received"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PDCReceived.rdl';
    ApplicationArea = FixedAsset;

    dataset
    {
        dataitem(PDC; PDC)
        {
            DataItemTableView = SORTING("PDC Cheque Date", "Account Type", "Account No.")
                                WHERE("Account Type" = CONST(Customer));
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(USERID; USERID)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(STRSUBSTNO_PeriodText_Text000_; STRSUBSTNO(PeriodText, Text000))
            {
            }
            column(PDC__PDC_Received_Date_; "PDC Received Date")
            {
            }
            column(PDC_Name; Name)
            {
            }
            column(PDC_RECEIVEDCaption; PDC_RECEIVEDCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Invoice_Date_FromCaption; Invoice_Date_FromCaptionLbl)
            {
            }
            column(CHEQUE_NOCaption; CHEQUE_NOCaptionLbl)
            {
            }
            column(INVOICE_NOCaption; INVOICE_NOCaptionLbl)
            {
            }
            column(INVOICE_DATECaption; INVOICE_DATECaptionLbl)
            {
            }
            column(INVOICE_AMTCaption; INVOICE_AMTCaptionLbl)
            {
            }
            column(PENDING_AMTCaption; PENDING_AMTCaptionLbl)
            {
            }
            column(CHEQUE_AMTCaption; CHEQUE_AMTCaptionLbl)
            {
            }
            column(PDC_REFERENCECaption; PDC_REFERENCECaptionLbl)
            {
            }
            column(DUE_DATECaption; DUE_DATECaptionLbl)
            {
            }
            column(PDC_Entry_No_; "Entry No.")
            {
            }
            column(PDC_PDC_Cheque_Date; "PDC Cheque Date")
            {
            }
            column(PDC_Account_No_; "Account No.")
            {
            }
            column(PDC_Document_No_; "Document No.")
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Document No." = FIELD("Document No.");
                DataItemTableView = WHERE("Document Type" = CONST(Payment));
                RequestFilterFields = "Posting Date";
                column(Cust__Ledger_Entry__Document_No__; "Document No.")
                {
                }
                column(Cust__Ledger_Entry__Cust__Ledger_Entry___Remaining_Amt___LCY__; "Cust. Ledger Entry"."Remaining Amt. (LCY)")
                {
                }
                column(Cust__Ledger_Entry__Posting_Date_; "Posting Date")
                {
                }
                column(Cust__Ledger_Entry__Due_Date_; "Due Date")
                {
                }
                column(PDC__PDC_Cheque_No__; PDC."PDC Type")
                {
                }
                column(PDC__PDC_Amount_; PDC."PDC Amount")
                {
                }
                column(PDC__Applies_to_ID_; PDC."Applies-to ID")
                {
                }
                column(Cust__Ledger_Entry_Amount; Amount)
                {
                }
                column(Cust__Ledger_Entry_Entry_No_; "Entry No.")
                {
                }
                dataitem("Detailed Cust. Ledg. Entry"; "Detailed Cust. Ledg. Entry")
                {
                    DataItemLink = "Customer No." = FIELD("Customer No."),
                                   "Applied Cust. Ledger Entry No." = FIELD("Entry No.");
                    DataItemTableView = WHERE("Entry Type" = CONST(Application));

                    trigger OnAfterGetRecord()
                    begin
                        CustLegderEntry.GET("Detailed Cust. Ledg. Entry"."Cust. Ledger Entry No.");
                    end;

                    trigger OnPreDataItem()
                    begin
                        SETFILTER("Cust. Ledger Entry No.", '<>%1', "Cust. Ledger Entry"."Entry No.");
                    end;
                }
            }
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

    trigger OnPreReport()
    begin
        PeriodText := "Cust. Ledger Entry".GETFILTER("Cust. Ledger Entry"."Posting Date");
    end;

    var
        CustLegderEntry: Record 21;
        PdcApplBuffer: Record 50004;
        PendingAmount: Decimal;
        PeriodText: Text[30];
        Text000: Label 'Invoice Date From';
        PDC_RECEIVEDCaptionLbl: Label 'PDC RECEIVED';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Invoice_Date_FromCaptionLbl: Label 'Invoice Date From';
        CHEQUE_NOCaptionLbl: Label 'CHEQUE NO';
        INVOICE_NOCaptionLbl: Label 'INVOICE NO';
        INVOICE_DATECaptionLbl: Label 'INVOICE DATE';
        INVOICE_AMTCaptionLbl: Label 'INVOICE AMT';
        PENDING_AMTCaptionLbl: Label 'PENDING AMT';
        CHEQUE_AMTCaptionLbl: Label 'CHEQUE AMT';
        PDC_REFERENCECaptionLbl: Label 'PDC REFERENCE';
        DUE_DATECaptionLbl: Label 'DUE DATE';
}

