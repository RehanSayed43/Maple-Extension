pageextension 50017 Users extends Users
{
    layout
    {
        modify("Windows User Name")
        {
            trigger OnAssistEdit()
            var
                myInt: Integer;

                // [RunOnClient]
                // DSOP: DotNet DSObjectPickerWrapper;
                result: Text;//tk

            begin
                //   DSOP := DSOP.DSObjectPickerWrapper;
                //         result := DSOP.InvokeDialogAndReturnSid;
                //         IF result <> '' THEN BEGIN
                //             "Windows Security ID" := result;
                //             ValidateSid;
                //             WindowsUserName := IdentityManagement.UserName("Windows Security ID");
                //             SetUserName;
                //         END;//tk

            end;
        }
    }

    actions
    {
        addafter("Warehouse Employees")
        {
            group(Reports)
            {
                action("Sales Register-GST")
                {
                    ApplicationArea = all;
                    Image = Report;
                    RunObject = report 50100;
                }
                action("Purchase Register-GST")
                {
                    ApplicationArea = all;
                    Image = Report;
                    RunObject = report 50102;
                }
                action("Purch Cr Register Summary-GST")
                {
                    ApplicationArea = all;
                    Image = Report;
                    RunObject = report 50103;
                }
                action("Sales Credit Register Summary")
                {
                    ApplicationArea = all;
                    Image = Report;
                    RunObject = report 50104;
                }
                action("Sales Credit Register Detailed")
                {
                    ApplicationArea = all;
                    Image = Report;
                    RunObject = report 50105;
                }
                action("Daily Cash Flow Tr")
                {
                    ApplicationArea = all;
                    Image = Report;
                    // RunObject = report 50107;
                }
                action("Purchase Register BK 19")
                {
                    ApplicationArea = all;
                    Image = Report;
                    RunObject = report 50108;
                }
                action("GST-Sales Invoice Domestic Chg")
                {
                    ApplicationArea = all;
                    Image = Report;
                    RunObject = report 50110;
                }
                action("PDC in HAND")
                {
                    ApplicationArea = all;
                    Image = Report;
                    RunObject = report 50000;
                }
                action("Job Queue Status On E-Mail")
                {
                    ApplicationArea = all;
                    Image = Report;
                    RunObject = report 50003;
                }
                action(CRT)
                {
                    ApplicationArea = all;
                    Image = Report;
                    RunObject = report 50004;
                }
                action("Cheque value")
                {
                    ApplicationArea = all;
                    Image = Report;
                    RunObject = report 50005;
                }
                action("Bank Account Reconciliation1")
                {
                    ApplicationArea = all;
                    Image = Report;
                    RunObject = report 50006;
                }
                action("Proforma Invoice")
                {
                    ApplicationArea = all;
                    Image = Report;
                    RunObject = report 50016;
                }
                action("Inventory Ageing")
                {
                    ApplicationArea = all;
                    Image = Report;
                    RunObject = report 50021;
                }
                action("Customerwise AR")
                {
                    ApplicationArea = all;
                    Image = Report;
                    RunObject = report 50022;
                }
                action("PO Planning")
                {
                    ApplicationArea = all;
                    Image = Report;
                    RunObject = report 50023;
                }
                action(Inventory)
                {
                    ApplicationArea = all;
                    Image = Report;
                    RunObject = report 50025;
                }
                action("Transfer Order Maple")
                {
                    ApplicationArea = all;
                    Image = Report;
                    RunObject = report 50027;
                }
                action("VendorWise AR")
                {
                    ApplicationArea = all;
                    Image = Report;
                    RunObject = report 50029;
                }
                action("Daily Inventory Report")
                {
                    ApplicationArea = all;
                    Image = Report;
                    RunObject = report 50031;
                }
                action("PO Planning1")
                {
                    ApplicationArea = all;
                    Image = Report;
                    RunObject = report 50032;
                }
                action("Customer Purchase Report")
                {
                    ApplicationArea = all;
                    Image = Report;
                    RunObject = report 50044;
                }
                action("CRM Integration")
                {
                    ApplicationArea = all;
                    Image = Report;
                    RunObject = report 50046;
                }
                action("CRM Integration1")
                {
                    ApplicationArea = all;
                    Image = Report;
                    RunObject = report 50048;
                }
                action("CRM Integration Purchase")
                {
                    ApplicationArea = all;
                    Image = Report;
                    RunObject = report 50049;
                }
                action("Balance Sheets")
                {
                    ApplicationArea = all;
                    Image = Report;
                    RunObject = report 50051;
                }
                action("Trial Balance WS")
                {
                    ApplicationArea = all;
                    Image = Report;
                    RunObject = report 50053;
                }
                action("Customer Trial Balance")
                {
                    ApplicationArea = all;
                    Image = Report;
                    RunObject = report 50054;
                }
                action("Vendor Trial Balance")
                {
                    ApplicationArea = all;
                    Image = Report;
                    RunObject = report 50055;
                }
                action("Purch Credit Register Summary")
                {
                    ApplicationArea = all;
                    Image = Report;
                    //RunObject = report 50063;
                }
                action("Job Que Restart")
                {
                    ApplicationArea = all;
                    Image = Report;
                    RunObject = report 50069;
                }
                action("Vendor Trial Balance1")
                {
                    ApplicationArea = all;
                    Image = Report;
                    RunObject = report 50071;
                }
                action("Transfer Details")
                {
                    ApplicationArea = all;
                    Image = Report;
                    RunObject = report 50077;
                }
                action("B2B Annexture")
                {
                    ApplicationArea = all;
                    Image = Report;
                    RunObject = report 50084;
                }
                action("Defective Accessory Report")
                {
                    ApplicationArea = all;
                    Image = Report;
                    RunObject = report 50085;
                }
                action(ReportGDV)
                {
                    ApplicationArea = all;
                    Image = Report;
                    RunObject = report 50089;
                }
                action("Daily Sales Report1")
                {
                    ApplicationArea = all;
                    Image = Report;
                    //RunObject = report 50090;
                }
                action("Customer Sales Data11")
                {
                    ApplicationArea = all;
                    Image = Report;
                    RunObject = report 50091;
                }
                action(UPN)
                {
                    ApplicationArea = all;
                    Image = Report;
                    RunObject = report 50096;
                }
                action("PDC Received")
                {
                    ApplicationArea = all;
                    Image = Report;
                    RunObject = report 50101;
                }
                action("COGS Iphone")
                {
                    ApplicationArea = all;
                    Image = Report;
                    RunObject = report 50157;
                }
                action("Bulk Sales Orders")
                {
                    ApplicationArea = all;
                    Image = Report;
                    RunObject = report 50178;
                }

            }
        }
    }

    var
        myInt: Integer;
}