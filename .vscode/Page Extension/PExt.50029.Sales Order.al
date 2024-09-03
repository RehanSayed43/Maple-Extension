pageextension 50029 "SalesOrderPage" extends "Sales Order"
{


    layout
    {
        addafter("Sell-to Customer Name")
        {

            field("Sell-to Customer Name 2"; Rec."Sell-to Customer Name 2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sell-to Customer Name 2 field.';
            }

        }
        addafter("External Document No.")
        {
            field("Order ID"; Rec."Order ID")
            {
                ApplicationArea = All;
            }
            field(transaction_id; Rec.transaction_id)
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the transaction_id field.';
            }
            field("Posting No. Series"; Rec."Posting No. Series")
            {
                ApplicationArea = all;
            }
            field("Posting No."; REC."Posting No.")
            {
                ApplicationArea = all;
            }
        }
        addafter("Payment Method Code")
        {

            field("Payment Status"; Rec."Payment Status")
            {
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Payment Status field.';
            }
            field("Payment Mode"; Rec."Payment Mode")
            {
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Payment Mode field.';
            }
        }
        addafter("No.")
        {
            field("Sales Order Type"; Rec."Sales Order Type")
            {
                ApplicationArea = all;
                Style = StrongAccent;
                StyleExpr = TRUE;

                trigger OnValidate()
                begin
                    //Win127
                    // IF Rec."Sales Order Type" = Rec."Sales Order Type"::Retail THEN
                    //     ERROR('Invalid Sales Order Type!!!');
                    // CustMobileVisible := FALSE;
                    // CustEmailVisible := FALSE;//tk

                    ////tk TransferOrdervisible := ("Document Type" = "Document Type"::Order) AND ("Sales Order Type" = "Sales Order Type"::Rental);

                    /*
                    IF ("Document Type" = "Document Type"::Order) AND ("Sales Order Type"="Sales Order Type"::Retail) THEN
                    BEGIN
                      CustMobileVisible := TRUE;
                      CustEmailVisible :=TRUE;
                    END
                    ELSE
                    BEGIN
                      CustMobileVisible := FALSE;
                      CustEmailVisible :=FALSE;
                    END;
                    CurrPage.UPDATE(TRUE);
                    */

                end;
            }
            field("User Type"; Rec."Mobile Type")
            {
                Caption = 'User Type';
                ApplicationArea = all;
            }

            field("Campaign No"; Rec."Campaign No.")
            {
                Importance = Additional;
                ApplicationArea = all;
            }
            field("Opportunity No"; Rec."Opportunity No.")
            {
                Importance = Additional;
                ApplicationArea = all;
            }
            // field("Responsibility Center New 1"; "Responsibility Center New 1")
            // {
            //     Importance = Additional;
            // }
            field("Transfer Shipment  No."; Rec."Transfer Shipment  No.")
            {
                // Editable = TransferOrdervisible;//tk
                ApplicationArea = all;
            }


            field("Credit Days Hold"; Rec."Credit Days Hold")
            {
                Editable = false;
                ApplicationArea = all;
                // Visible = CreditDaysHoldEnable;//tk
            }
            field("Credit Hold"; Rec."Credit Hold")
            {
                Editable = false;
                ApplicationArea = all;
                // Visible = CreditHoldEnable;//tk
            }
            field("Overdue Hold"; Rec."Overdue Hold")
            {
                Editable = false;
                ApplicationArea = all;
                // Visible = OvedueHoldEnable;//tk
            }
            field("Price Hold"; Rec."Price Hold")
            {
                Editable = false;
                ApplicationArea = all;
                // Visible = PriceHoldActiveEnable;//tk
            }
            field("PDC Hold"; Rec."PDC Hold")
            {
                Editable = false;
                ApplicationArea = all;
                // Visible = PDCHoldActiveEnable;//tk
            }
            field("Discount Hold"; Rec."Discount Hold")
            {
                Editable = false;
                ApplicationArea = all;
                // Visible = DiscountHoldEnable;//tk
            }
            field("Group Credit Limit Hold"; Rec."Group Credit Limit Hold")
            {
                Editable = false;
                ApplicationArea = all;
            }

            field(Shield; Rec.Shield)
            {
                Visible = false;
                ApplicationArea = all;
            }
            field("Buyer's Order No."; Rec."Buyer's Order No.")
            {
                ApplicationArea = all;
            }
            field("Buyer's Order Dt"; Rec."Buyer's Order Dt")
            {
                ApplicationArea = all;
            }
            field("Delivery Note"; Rec."Delivery Note")
            {
                ApplicationArea = all;
            }
            field("Dispatch Doc. No."; Rec."Dispatch Doc. No.")
            {
                ApplicationArea = all;
            }
            field("Dispatch Through"; Rec."Dispatch Through")
            {
                ApplicationArea = all;
            }
            field("CIN Number"; recComp."CIN no")
            {
                ApplicationArea = all;
            }//tk
            field("Promo Code"; Rec."Promo Code")
            {
                ApplicationArea = all;
            }
            field("Capillary Discount Amount"; Rec."Capillary Discount Amount")
            {
                Editable = false;
                ApplicationArea = all;
            }
            field("Scan Barcode"; ScanBarcode)
            {
                ApplicationArea = all;

                trigger OnValidate()
                var
                    Sline: Record 37;
                begin
                    IF STRPOS(ScanBarcode, '|') > 0 THEN BEGIN
                        TempString := CONVERTSTR(ScanBarcode, '|', ',');
                        SerialNo := SELECTSTR(1, TempString);
                        ItemNo := SELECTSTR(4, TempString);
                        Sline.RESET;
                        Sline.SETRANGE("Document No.", Rec."No.");
                        Sline.SETRANGE(Type, Sline.Type::Item);
                        Sline.SETRANGE("No.", ItemNo);
                        IF Sline.FINDFIRST THEN BEGIN
                            Sline.VALIDATE("Item Serial No.", SerialNo);
                            Sline.MODIFY;
                            CLEAR(ItemNo);
                            CLEAR(SerialNo);
                            ScanBarcode := '';
                            CLEAR(TempString);
                        END ELSE BEGIN
                            MESSAGE('Item No %1 Not found in Current Order', ItemNo);
                            CLEAR(ItemNo);
                            CLEAR(SerialNo);
                            ScanBarcode := '';
                            CLEAR(TempString);

                        END;
                    END;

                end;
            }
        }

    }

    actions
    {

        addafter("Test Report")
        {
            action("Post &Batch")
            {
                Caption = 'Post &Batch';
                Ellipsis = true;
                Image = PostBatch;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    REPORT.RUNMODAL(REPORT::"Batch Post Sales Orders", TRUE, TRUE, Rec);
                    CurrPage.UPDATE(FALSE);
                end;
            }
        }

        addafter("&Order Confirmation")
        {
            action(SendWMSData)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //POIntegration.Test(Rec);//tk
                end;
            }
            action(Sendtestmail)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //ReportManagement.SendmailOrderCreationTemp(Rec);//tk
                end;
            }
        }
        addafter("&Order Confirmation")
        {
            group(Capillery)
            {
                Caption = 'Capillery';
                Enabled = false;
                action("GET Customer Points (Capillary)")
                {
                    Promoted = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //WIN316++
                        IF Rec."Sales Order Type" <> Rec."Sales Order Type"::Retail THEN
                            ERROR('You Can use this only for Sales Order Type Retail');

                        // TESTFIELD("Location Code");
                        // RecLocation.RESET;
                        // RecLocation.SETRANGE(Code, "Location Code");
                        // IF RecLocation.FINDFIRST THEN BEGIN
                        //     RecLocation.TESTFIELD("Capillary ID");
                        //     RecLocation.TESTFIELD("Capillary Password");
                        // END;
                        // DLL := DLL.Class1;
                        // IF NOT DLL.CheckInterNet('http://www.google.com') THEN BEGIN
                        //     MESSAGE('Internet is Not Working');
                        //     EXIT;
                        // END;//tk
                        // recCust1.RESET;//tk
                        // recCust1.SETRANGE("No.", "Sell-to Customer No.");
                        // IF recCust1.FINDFIRST THEN
                        //     recCust1.TESTFIELD("Phone No.");
                        // FilePath := 'C:\Navision\Dont Delete (Capilery Integration)\Customer_Details\' + "Sell-to Customer Name" + "Location Code" + '.xml';
                        // RecCreateTranXML.Create_Blank_XML(FilePath);
                        // DLL := DLL.Class1;
                        // DLL.CallWebApi('https://apac2.api.capillarytech.com/v1.1/customer/get?format=xml&mobile=' + recCust1."Phone No.", 'GET', '', RecLocation."Capillary ID", RecLocation."Capillary Password", FilePath);
                        // RecXML.GetCustomerDataFromCapillary(FilePath, Rec."No.");
                        // "Get Customer" := TRUE;
                        // //WIN316--//tk
                    end;
                }
                action("Point Redeem")
                {
                    Caption = 'Point Redeem';
                    Promoted = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //WIN316++
                        // DLL := DLL.Class1;
                        // IF NOT DLL.CheckInterNet('http://www.google.com') THEN BEGIN
                        //     MESSAGE('Internet is Not Working');
                        //     EXIT;
                        // END;//tk

                        // IF "Get Customer" = FALSE THEN
                        //     ERROR('Please Click On GET Customer Points (Capillary) then proceed');

                        // recCust1.RESET;
                        // recCust1.SETRANGE("No.", "Sell-to Customer No.");
                        // IF recCust1.FINDFIRST THEN;
                        // recCust1.TESTFIELD("Phone No.");
                        // RecCustCapill.RESET;
                        // RecCustCapill.SETFILTER("Mobile No", '%1', ('*' + recCust1."Phone No."));
                        // RecCustCapill.SETRANGE("Sales Order No", Rec."No.");
                        // IF RecCustCapill.FINDFIRST THEN BEGIN
                        //     //tk//IF PAGE.RUNMODAL(50099,RecCustCapill)=ACTION::LookupOK THEN BEGIN
                        //     IF (RecCustCapill."Coupon posted" = FALSE) AND (RecCustCapill."Point Posted" = FALSE) THEN
                        //         EXIT;
                        //     IF "Capillary Discount Amount" <> 0 THEN
                        //         EXIT;
                        //     CLEAR("Capillary Discount Amount");
                        //     "Capillary Discount Amount" := RecCustCapill."Point Redeem Value In Rs." + RecCustCapill."Coupon Value In Rs.";//tk
                        // RecSL.RESET;
                        // RecSL.SETRANGE(RecSL."Document No.", "No.");
                        // IF RecSL.FINDFIRST THEN BEGIN
                        //     REPEAT
                        //         RecSL.VALIDATE("Capillary Line Discount Amount", (RecSL."Amount To Customer" / (RecCustCapill."Amount Payable Before Discount" / "Capillary Discount Amount")));
                        //         RecSL.MODIFY;
                        //     UNTIL RecSL.NEXT = 0;
                        //     TEST_STAT;
                        // END;//tk
                        //END//tk
                        // END
                        //      ELSE BEGIN
                        //       MESSAGE('Customer Data is not available in Capillary');
                        //       CLEAR("Capillary Discount Amount");
                        //      END;
                        //     //WIN316--//tk
                    end;//tk
                        //}
                }
            }

        }
        // Mapple NG 28032023 START - Added for Sales Order API
        addafter("S&hipments")
        {
            action(WebOrder)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = Action;
                Caption = 'Web Order';
                Visible = false;
                trigger OnAction()
                var
                    "Sales Order API": Codeunit "Sales Order API";
                    Xmlweb: Text;
                begin
                    Clear(Xmlweb);

                    //"Sales Order API".XMLOrderImport(Xmlweb);
                    //Xmlweb := '<?xml version="1.0" encoding="UTF-8"?><NodeName1><SalesHeader ERPCustomerNo="30000" EcommCustomerID="" EcomOrder="TESTAPI" OrderKey="1252565" BillToFirstName="John Haddock Insurance Co." BillToLastName="" PhoneNumber="9876543210" Email="miss.patricia.doyle@contoso.com" BillToAddress="10 High Tower Green" BillToAddress2="" BillToCity="Chicago" BillToPostCode="11002" BillToState="" ShipToFirstName="John Haddock Insurance Co." ShipToLastName="" ShipToAddress="10 High Tower Green" ShipToAddress2="" ShipToCity="Chicago" ShipToPostCode="110002" ShipToSate="" GSTRegistrationNumber=""><SalesLine Type="Item" No="1936-S" Qty="10" UnitPrice="100" DeliveryTime="Today" ExpectedDeliveryTime="04/30/2023" Is_Lob="FALSE" BillingLocationCode="BLUE"/></SalesHeader></NodeName1>';
                    Xmlweb := '<?xml version="1.0" encoding="UTF-8"?><NodeName1><SalesHeader ERPCustomerNo="CC-00001" EcommCustomerID="" EcomOrder="TESTAPI" OrderKey="1252565" BillToFirstName="John Haddock Insurance Co." BillToLastName="" PhoneNumber="9876543210" Email="miss.patricia.doyle@contoso.com" BillToAddress="10 High Tower Green" BillToAddress2="" BillToCity="Chicago" BillToPostCode="11002" BillToState="" ShipToFirstName="John Haddock Insurance Co." ShipToLastName="" ShipToAddress="10 High Tower Green" ShipToAddress2="" ShipToCity="Chicago" ShipToPostCode="110002" ShipToSate="" GSTRegistrationNumber=""><SalesLine Type="Item" No="12 TPA1001" Qty="10" UnitPrice="100" DeliveryTime="Today" ExpectedDeliveryTime="04/30/2023" Is_Lob="FALSE" BillingLocationCode="CW101"/></SalesHeader></NodeName1>';
                    //Message('%1 - Done', "Sales Order API".XMLOrderImportW(Xmlweb));//commented

                end;
            }
            action(UWebOrder)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = Action;
                Caption = 'Update Web Order';
                Visible = false;
                trigger OnAction()
                var
                    "Sales Order API": Codeunit "Sales Order API";
                    Xmlweb: Text;
                begin
                    Clear(Xmlweb);

                    //"Sales Order API".XMLOrderImport(Xmlweb);
                    Xmlweb := '<?xml version="1.0" encoding="UTF-8"?><NodeName1><SalesHeader OrderKey="1252565" transaction_id="855585545" payment_methody="NET30" payment_method_title=""><SalesLine Type="Item" No="1936-S" LineNo="" BillingLocationCode="BLUE" /></SalesHeader></NodeName1>';
                    Message('%1 - Done', "Sales Order API".XMLOrderUpdateW(Xmlweb));

                end;
            }

        }
        // Mapple NG 28032023 END - Added for Sales Order API 



    }


    trigger OnAfterGetRecord()
    begin
        // SetControlVisibility;
        // IF "Re-Dispatch" THEN
        //   ReturnOrderNoVisible := TRUE
        // ELSE
        //   ReturnOrderNoVisible := FALSE;
        //   //win344
        //Win127
        // IF (Rec."Document Type" = Rec."Document Type"::Order) AND (Rec."Sales Order Type" = Rec."Sales Order Type"::Retail) THEN BEGIN
        //     CustMobileVisible := TRUE;
        //     CustEmailVisible := TRUE;
        // END
        // ELSE BEGIN
        //     CustMobileVisible := FALSE;
        //     CustEmailVisible := FALSE;
        // END;
        // TransferOrdervisible := (Rec."Document Type" = Rec."Document Type"::Order) AND (Rec."Sales Order Type" = Rec."Sales Order Type"::Rental);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        // IF "Re-Dispatch" THEN
        //   ReturnOrderNoVisible := TRUE
        // ELSE
        //   ReturnOrderNoVisible := FALSE;
        // CurrForm.SalesLines.PAGE.UPDATECONTROLS;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //"Responsibility Center New 1" := UserMgt.GetSalesFilter; //win344
        // TransferOrdervisible := (Rec."Document Type" = Rec."Document Type"::Order) AND (Rec."Sales Order Type" = Rec."Sales Order Type"::Rental); //win344
    end;


    trigger OnOpenPage()
    var
    //CRMIntegrationManagement: Codeunit 5330;//tk
    begin



        // Rec.SetFilter(rec."Sales Order Type", '<>%1', rec."sales Order Type"::Retail);
        /*
        IF UserMgt.GetSalesFilter <> '' THEN BEGIN
          FILTERGROUP(2);
          //SETRANGE("Responsibility Center",UserMgt.GetSalesFilter);
          SETRANGE("Responsibility Center New 1",UserMgt.GetSalesFilter);
          FILTERGROUP(0);
        END;
        */
        //TK
        UserSetup.GET(USERID);
        IF UserSetup."Location Code" <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Location Code", UserSetup."Location Code");
            Rec.FILTERGROUP(0);
        END;

        // SETRANGE("Date Filter", 0D, WORKDATE - 1);// KPPL//tk

        //TK

    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF (Rec."No." <> '') AND ((Rec."Mobile Type" = Rec."Mobile Type"::Apple) OR (Rec."Mobile Type" = Rec."Mobile Type"::Other)) THEN BEGIN
            Rec.TESTFIELD("Sell-to Customer Name");
            Rec.TESTFIELD("Sell-to Address");
            Rec.TESTFIELD("Sell-to Address 2");
            Rec.TESTFIELD("Sell-to City");
            Rec.TESTFIELD("Sell-to Post Code");
            Rec.TESTFIELD("Location Code");
            Rec.TESTFIELD("Bill-to Name");
            Rec.TESTFIELD("Bill-to Address");
            Rec.TESTFIELD("Bill-to Address 2");
            Rec.TESTFIELD("Bill-to City");
            Rec.TESTFIELD("Bill-to Post Code");
            Rec.TESTFIELD("Ship-to Address");
            Rec.TESTFIELD("Ship-to Address 2");
            Rec.TESTFIELD("Ship-to Name");
            Rec.TESTFIELD("Ship-to City");
        END; //kppl-rj
    end;

    var
        myInt: Integer;
        TransferOrdervisible: Boolean;

        RecCustCapill: Record 50011;
        recComp: record "company information";

        //DLL: DotNet Class1;
        SalesSetup: Record 311;
        CustMobileVisible: Boolean;
        CustEmailVisible: Boolean;
        //RecXML1: Codeunit 50108;
        RecSL: Record 37;
        //RecCreateTranXML1: Codeunit 50117;
        Sales_order_no: Code[20];
        RecCust2: Record 18;
        FilePath: Text;
        RecLocation: Record 14;
        recCust1: Record 18;
        RecUserSetup: Record 91;
        // RecCreateTrnXml: Codeunit 50012;
        //  ReportManagement: Codeunit 50001;
        UserSetup: Record 91;
        ScanBarcode: Text;
        SerialNo: Text;
        ItemNo: Text;
        TempString: Text;
        // POIntegration: Codeunit 50117;
        CustomerMobile: Text[30];

        CUstomerEmail: Text[180];
        SInvLine: Record 113;
        SInvHeader: Record 112;
        // WBU: Codeunit 50101;

        CreditHoldEnable: Boolean;

        OvedueHoldEnable: Boolean;

        CreditDaysHoldEnable: Boolean;

        DiscountHoldEnable: Boolean;

        PriceHoldActiveEnable: Boolean;

        PDCHoldActiveEnable: Boolean;


    local procedure SelltoCustomerNoOnAfterValidat()
    begin
        IF Rec.GETFILTER("Sell-to Customer No.") = xRec."Sell-to Customer No." THEN
            IF Rec."Sell-to Customer No." <> xRec."Sell-to Customer No." THEN
                Rec.SETRANGE("Sell-to Customer No.");
        CurrPage.UPDATE;
    end;

    local procedure BilltoCustomerNoOnAfterValidat()
    begin
        CurrPage.UPDATE;
    end;

    local procedure ReDispatchOnPush()
    begin
        // IF "Re-Dispatch" THEN
        //     CurrPage.SalesLines.PAGE.MakeVisibleLineControl
        // ELSE
        //     CurrPage.SalesLines.PAGE.MakeInvisibleLineControl;//tk
    end;

    local procedure TEST_STAT()

    begin
        SalesSetup.GET;
        // CALCFIELDS("Price Inclusive of Taxes");
        // IF SalesSetup."Calc. Inv. Discount" AND (NOT "Price Inclusive of Taxes") THEN BEGIN
        //     CalcInvDiscForHeader;
        //     COMMIT
        // END;//tk
    end;

}