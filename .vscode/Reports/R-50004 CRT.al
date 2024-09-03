report 50004 CRT
{
    ProcessingOnly = true;
    ApplicationArea = FixedAsset;

    dataset
    {
        dataitem("Sales Invoice Line"; "Sales Invoice Line")
        {
            DataItemTableView = SORTING("Document No.", "Line No.")
                                ORDER(Ascending)
                                WHERE(Type = FILTER(Item),
                                      "CRT Coupon Code" = FILTER(<> ''));

            trigger OnAfterGetRecord()
            begin
                Srno += 1;
                CLEAR(PhoneNO);
                CLEAR(Email);
                CLEAR(NameOfInstitute);
                CLEAR(collegeId);
                CLEAR(SecondryId);
                CLEAR(StoreName);

                LocationRec.RESET;
                LocationRec.SETRANGE(Code, "Sales Invoice Line"."Location Code");
                IF LocationRec.FINDFIRST THEN
                    StoreName := LocationRec.Name;

                SalesInvoiceHeader.RESET;
                SalesInvoiceHeader.SETRANGE("No.", "Sales Invoice Line"."Document No.");
                IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                    ContactNo := SalesInvoiceHeader."Sell-to Contact No.";
                    CustomerName := SalesInvoiceHeader."Sell-to Customer Name";
                END;

                SalespersonPurchaser.RESET;
                SalespersonPurchaser.SETRANGE(Code, "Sales Invoice Line"."Salesperson Code");
                IF SalespersonPurchaser.FINDFIRST THEN
                    SalesPersonName := SalespersonPurchaser.Name;

                CRTCoupons.RESET;
                CRTCoupons.SETRANGE("Coupon Code", "Sales Invoice Line"."CRT Coupon Code");
                IF CRTCoupons.FINDFIRST THEN BEGIN
                    PhoneNO := CRTCoupons.Phone;
                    Email := CRTCoupons.Email;
                    CRTRecords.RESET;
                    CRTRecords.SETRANGE(Phone, CRTCoupons.Phone);
                    CRTRecords.SETRANGE(Email, CRTCoupons.Email);
                    IF CRTRecords.FINDFIRST THEN BEGIN
                        NameOfInstitute := CRTRecords."Name of Institute";
                        IF CRTRecords."College Id".HASVALUE THEN
                            collegeId := 'Yes'
                        ELSE
                            collegeId := 'No';
                        IF CRTRecords."Secondary ID".HASVALUE THEN
                            SecondryId := 'Yes'
                        ELSE
                            SecondryId := 'No';
                    END
                END;

                MakeExcelDataBody;
            end;

            trigger OnPreDataItem()
            begin
                //MakeExcelInfo;
                IF (StartDate > 0D) AND (EndDate > 0D) THEN BEGIN
                    IF EndDate - StartDate < 0 THEN
                        ERROR('End date should be greater then start date !');
                    "Sales Invoice Line".SETRANGE("Posting Date", StartDate, EndDate);
                END
                ELSE
                    IF StartDate > 0D THEN
                        "Sales Invoice Line".SETRANGE("Posting Date", StartDate)
                    ELSE
                        IF EndDate > 0D THEN
                            "Sales Invoice Line".SETRANGE("Posting Date", EndDate);

                IF CustomerFilter <> '' THEN
                    "Sales Invoice Line".SETRANGE("Sell-to Customer No.", CustomerFilter);
                Srno := 0;
                MakeExcelDataHeader;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Start Date"; StartDate)
                {
                    ApplicationArea = All;
                }
                field("End Date"; EndDate)
                {
                    ApplicationArea = All;
                }
                field("Customer No."; CustomerFilter)
                {
                    TableRelation = Customer."No.";
                    ApplicationArea = All;
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
        CreateExcelbook;
    end;

    var
        StartDate: Date;
        EndDate: Date;
        CustomerFilter: Code[20];
        CRTRecords: Record "CRT Records";
        CRTCoupons: Record "CRT Coupons";
        ExcelBuf: Record "Excel Buffer" temporary;
        PhoneNO: Text[11];
        Email: Text[100];
        NameOfInstitute: Text[100];
        collegeId: Text[10];
        SecondryId: Text[10];
        LocationRec: Record Location;
        StoreName: Text[100];
        SalesInvoiceHeader: Record "Sales Invoice Header";
        ContactNo: Text[20];
        Srno: Integer;
        CustomerName: Text[100];
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        SalesPersonName: Text[100];


    procedure MakeExcelInfo()
    begin
        /* rahul------
       
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn('Company Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(COMPANYNAME, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn('Report Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn('CRT Report', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn('Report No.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(REPORT::CRT, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn('User ID', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(USERID, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn('Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(TODAY, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;

        ---------rahul */
    end;

    local procedure MakeExcelDataHeader()
    begin
        ExcelBuf.AddColumn('SR NO.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Store Name', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Invoice No', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Invoice Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Customer CR No', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Customer Name', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Contact number', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Product Vendor Part code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('College/Institute Name', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('College/Instiute Address', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('College/Institute Postcode / Zip', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('College/Institute City', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('College ID', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Secondary ID', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Email Address', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('PURCHASE DETAILS', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Sales Person', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Coupon Code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
    end;


    procedure MakeExcelDataBody()
    var
        BlankFiller: Text[250];
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Srno, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(StoreName, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn("Sales Invoice Line"."Document No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Sales Invoice Line"."Posting Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn("Sales Invoice Line"."Sell-to Customer No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(CustomerName, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

        //ExcelBuf.AddColumn(ContactNo,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn("Sales Invoice Line"."No.",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn(PhoneNO, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Sales Invoice Line"."Vendor Part Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn(NameOfInstitute, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn(collegeId, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(SecondryId, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn(Email, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Sales Invoice Line".Description, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn(SalesPersonName, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Sales Invoice Line"."CRT Coupon Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
    end;

    procedure CreateExcelbook()
    begin
        //  ExcelBuf.CreateBookAndOpenExcel('', 'CRT Report', '', COMPANYNAME, USERID);
    end;
}

