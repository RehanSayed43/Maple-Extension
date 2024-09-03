report 50056 "TDS Payable"
{
    DefaultLayout = RDLC;
    RDLCLayout = './TDS Payable.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("TDS Entry"; "TDS Entry")
        {
            DataItemTableView = SORTING("Party Type", "Party Code", "Posting Date", "Section", "Assessee Code", "Document Type")
                                ORDER(Ascending);
            RequestFilterFields = "Posting Date", "Assessee Code";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; CompInfo.Name)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(Sales_Invoice_Header__GETFILTERS; 'Period : ' + "TDS Entry".GETFILTER("Posting Date"))
            {
            }
            column(TDS_Entry__Document_No__; "Document No.")
            {
            }
            column(TDS_Entry__Posting_Date_; FORMAT("Posting Date"))
            {
            }
            column(TDS_Entry__Deductee_P_A_N__No__; "TDS Entry"."Deductee PAN No.")
            {
            }
            column(TDS_Entry__TDS_Base_Amount_; "TDS Base Amount")
            {
            }
            column(TDS_Entry__TDS_Amount_Including_Surcharge_; "TDS Amount Including Surcharge")
            {
            }
            column(TDS_Entry__Assessee_Code_; "Assessee Code")
            {
            }
            column(TDS_Entry__TDS_Nature_of_Deduction_; '')//"TDS Nature of Deduction")
            {
            }
            column(TDS_Entry__TDS_Amount_Including_Surcharge__Control1102159020; "TDS Amount Including Surcharge")
            {
            }
            column(TDS_Entry__TDS_Base_Amount__Control1102159022; "TDS Base Amount")
            {
            }
            column(TDS_Entry__Document_No__Caption; FIELDCAPTION("Document No."))
            {
            }
            column(TDS_Entry__Posting_Date_Caption; FIELDCAPTION("Posting Date"))
            {
            }
            column(Vendor_NameCaption; Vendor_NameCaptionLbl)
            {
            }
            column(TDS_Entry__Deductee_P_A_N__No__Caption; FIELDCAPTION("Deductee PAN No."))
            {
            }
            column(TDS_Entry__TDS_Base_Amount_Caption; FIELDCAPTION("TDS Base Amount"))
            {
            }
            column(TDS_Entry__TDS_Amount_Including_Surcharge_Caption; FIELDCAPTION("TDS Amount Including Surcharge"))
            {
            }
            column(Sales_RegisterCaption; Sales_RegisterCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(TDS_Entry__Assessee_Code_Caption; FIELDCAPTION("Assessee Code"))
            {
            }
            column(TDS_Entry__TDS_Nature_of_Deduction_Caption; '')//FIELDCAPTION("TDS Nature of Deduction"))
            {
            }
            column(Grand_Total__Caption; Grand_Total__CaptionLbl)
            {
            }
            column(End_Of_The_ReportCaption; End_Of_The_ReportCaptionLbl)
            {
            }
            column(TDS_Entry_Entry_No_; "Entry No.")
            {
            }
            column(Vendor_Name; Vendor.Name)
            {
            }
            column(TDS_TDSEntry; "TDS Entry"."TDS %")
            {
            }
            column(DocumentType_TDSEntry; "TDS Entry"."Document Type")
            {
            }
            column(PIH_DocumentDate; FORMAT(PIH."Document Date"))
            {
            }
            column(PIH_VendorInvoiceNo; PIH."Vendor Invoice No.")
            {
            }
            column(VLE_DocumentDate; FORMAT(VLE."Document Date"))
            {
            }
            column(VLE_ExternalDocumentNo; VLE."External Document No.")
            {
            }
            column(Vendor_City; Vendor.City)
            {
            }
            column(TDS_Entry_TDS_Section; "TDS Entry".Section)
            {
            }
            column(Section_des; Section_des) { }
            column(TDS_Entry_TDS_Group; '')//"TDS Entry"."TDS Group")
            {
            }
            column(TDSPER; "TDS%")
            {
            }
            column(VendorName; VendorName) { }
            column(vendorCity; vendorCity) { }
            trigger OnAfterGetRecord()
            begin
                IF Vendor.GET("TDS Entry"."Party Code") THEN;
                //CCIT AN
                if Vendor.get("Vendor No.") then begin
                    VendorName := Vendor.Name;
                    vendorCity := Vendor.City;
                end;
                if TDSSection.Get("TDS Entry".Section) then begin
                    Section_des := TDSSection.Description;
                end;
                //CCIT AN
                VLE.RESET;
                VLE.SETRANGE(VLE."Document No.", "TDS Entry"."Document No.");
                IF VLE.FINDFIRST THEN;

                IF PrintToExcel THEN
                    MakeExcelDataBody;

                IF ("TDS Entry"."TDS Amount Including Surcharge" <> 0) AND ("TDS Entry"."TDS Base Amount" <> 0) THEN
                    "TDS%" := ROUND("TDS Entry"."TDS Amount Including Surcharge" / "TDS Entry"."TDS Base Amount") * 100;
            end;

            trigger OnPreDataItem()
            begin
                CompInfo.GET;
                CurrReport.CREATETOTALS("TDS Base Amount", "TDS Amount Including Surcharge");
                IF "TDS Entry".GETFILTERS = '' THEN
                    ReportFilter := 'Filter : Show All'
                ELSE
                    ReportFilter := 'Filter :' + "TDS Entry".GETFILTERS;
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
                    field(NewPagePerCustomer; PrintOnlyOnePerPage)
                    {
                        Caption = 'New Page per Customer';
                        Visible = false;
                        ApplicationArea = All;
                    }
                    /* field(PrintToExcel; PrintToExcel)
                    {
                        Caption = 'Print to Excel';
                        Visible = true;
                    } */
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

    trigger OnPostReport()
    begin
        IF PrintToExcel THEN
            CreateExcelbook;
    end;

    trigger OnPreReport()
    begin
        IF PrintToExcel THEN
            MakeExcelInfo;
    end;

    var
        CompInfo: Record 79;
        TDSSection: Record "TDS Section";
        Section_des: Text[100];
        Vendor: Record 23;
        VendorName: Text[50];// CCIT AN
        vendorCity: Text[30]; //CCIT AN
        ReportFilter: Text[250];
        Row: Integer;
        Vendor_NameCaptionLbl: Label 'Vendor Name';
        Sales_RegisterCaptionLbl: Label 'TDS payable Report';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Grand_Total__CaptionLbl: Label 'Grand Total :';
        End_Of_The_ReportCaptionLbl: Label 'End Of The Report';
        PIH: Record 122;
        VLE: Record 25;
        ExcelBuf: Record 370 temporary;
        PrintAmountsInLCY: Boolean;
        PrintOnlyOnePerPage: Boolean;
        PrintToExcel: Boolean;
        "TDS%": Decimal;

    procedure MakeExcelInfo()
    begin
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;
    end;

    local procedure MakeExcelDataHeader()
    begin

        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Document No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Document Type', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Document Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Vendor Name', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Vendor City', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('TDS Section', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('P.A.N No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Bill Date ', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Vendor Bill No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Assessee Code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('TDS Nature of Deduction', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('TDS %', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('TDS Base Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('TDS Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
    end;

    procedure MakeExcelDataBody()
    begin

        ExcelBuf.NewRow;
        ExcelBuf.AddColumn("TDS Entry"."Document No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("TDS Entry"."Document Type", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("TDS Entry"."Posting Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Vendor.Name, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Vendor.City, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("TDS Entry".Section, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("TDS Entry"."Deductee PAN No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(VLE."Document Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(VLE."External Document No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("TDS Entry"."Assessee Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn("TDS Entry"."TDS Nature of Deduction",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("TDS Entry"."TDS %", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("TDS Entry"."TDS Base Amount", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("TDS Entry"."TDS Amount Including Surcharge", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
    end;

    procedure CreateExcelbook()
    begin
        //ExcelBuf.CreateBookAndOpenExcel('TDS Details', '', 'TDS Payables Report', COMPANYNAME, USERID);
        //ERROR('');
    end;

    procedure InitializeRequest(ShowAmountInLCY: Boolean; NewPagePerCustomer: Boolean; SetPrintToExcel: Boolean)
    begin
        PrintAmountsInLCY := ShowAmountInLCY;
        PrintOnlyOnePerPage := NewPagePerCustomer;
        PrintToExcel := SetPrintToExcel;
    end;
}

