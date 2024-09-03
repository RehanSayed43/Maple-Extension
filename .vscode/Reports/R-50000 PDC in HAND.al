report 50000 "PDC in HAND"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './PDC in HAND.rdl';

    dataset
    {
        dataitem(PDC; PDC)
        {
            DataItemTableView = SORTING("PDC Cheque Date", "PDC Status", "Res Center", "Account Type", "Account No.")
                                WHERE("PDC Status" = FILTER(<> Posted),
                                      "Account Type" = CONST(Customer));
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
            column(PDC__PDC_Cheque_Date_; "PDC Cheque Date")
            {
            }
            column(PDC_Name; Name)
            {
            }
            column(PDC_PDC__Account_No__; PDC."Account No.")
            {
            }
            column(PDC_PDC__PDC_Cheque_No__; PDC."PDC Type")
            {
            }
            column(PDC_PDC__PDC_Amount_; PDC."PDC Amount")
            {
            }
            column(PDC_PDC__PDC_Amount__9; PDC."PDC Amount")
            {
            }
            column(PDC_PDC__PDC_Amount__11; PDC."PDC Amount")
            {
            }
            column(PDC_in_HANDCaption; PDC_in_HANDCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
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
            column(Cheque_DateCaption; Cheque_DateCaptionLbl)
            {
            }
            column(PDC_Entry_No_; "Entry No.")
            {
            }
            dataitem("Log Entry"; "Log Entry")
            {
                DataItemLink = "Entry No." = FIELD("Entry No.");
                //   DataItemTableView = WHERE(Message1=CONST(2));  rahul
                column(PDC__Applies_to_ID_; PDC."Applies-to ID")
                {
                }
                column(PendingAmount; PendingAmount)
                {
                }
                column(CustLegderEntry__Due_Date_; CustLegderEntry."Due Date")
                {
                }
                column(CustLegderEntry__Document_No__; CustLegderEntry."Document No.")
                {
                }
                column(CustLegderEntry__Document_Date_; CustLegderEntry."Document Date")
                {
                }
                column(PDC_Application_Entry_PDC_Entry_No_; "Entry No.")
                {
                }
                // column(PDC_Application_Entry_Cust_Ledger_Entry_No_;"Cust Ledger Entry No.")
                // {
                // }

                trigger OnAfterGetRecord()
                begin
                    //    CustLegderEntry.SETRANGE(CustLegderEntry."Entry No.","Log Entry"."Cust Ledger Entry No.") ;
                    IF CustLegderEntry.FINDFIRST THEN
                        //  MESSAGE ('%1',CustLegderEntry."Remaining Amt. (LCY)");
                        CustLegderEntry.CALCFIELDS(CustLegderEntry."Remaining Amt. (LCY)");
                    CustLegderEntry.CALCFIELDS(CustLegderEntry."PDC Unposted Amount");
                    PendingAmount := CustLegderEntry."Remaining Amt. (LCY)" - CustLegderEntry."PDC Unposted Amount";
                end;
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

    var
        CustLegderEntry: Record 21;
        PdcApplBuffer: Record 50004;
        PendingAmount: Decimal;
        userSet: Record 91;
        Column: Integer;
        Row: Integer;
        PrintToExcel: Boolean;
        ExcelBuf: Record 370;
        PDC_in_HANDCaptionLbl: Label 'PDC in HAND';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        CHEQUE_NOCaptionLbl: Label 'CHEQUE NO';
        INVOICE_NOCaptionLbl: Label 'INVOICE NO';
        INVOICE_DATECaptionLbl: Label 'INVOICE DATE';
        PENDING_AMTCaptionLbl: Label 'PENDING AMT';
        CHEQUE_AMTCaptionLbl: Label 'CHEQUE AMT';
        PDC_REFERENCECaptionLbl: Label 'PDC REFERENCE';
        DUE_DATECaptionLbl: Label 'DUE DATE';
        Cheque_DateCaptionLbl: Label 'Cheque Date';


    procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; Underline: Boolean; MergeCell: Text[30]; NumberFormat: Text[30])
    begin
    end;
}

