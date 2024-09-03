page 50018 "Sales Order Retail"
{
    Caption = 'Sales Order Retail';
    PageType = Document;
    RefreshOnActivate = true;
    DeleteAllowed = false;
    UsageCategory = Lists;
    ApplicationArea = all;
    SourceTable = 36;
    SourceTableView = WHERE("Document Type" = FILTER(Order),
                            "Sales Order Type" = FILTER(Retail));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Sales Order Type"; Rec."Sales Order Type")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                    Visible = False;
                    ApplicationArea = All;
                    //ApplicationArea = All;
                }
                field("User Type"; Rec."Mobile Type")
                {
                    Caption = 'User Type';
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    Importance = Promoted;
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(BuyBackType; Rec.BuyBackType)
                {
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF Rec.BuyBackType = Rec.BuyBackType::Maple THEN BEGIN
                            MapleEnable := TRUE;
                            AppleEnable := FALSE;
                            Rec."Apple Buyback Amt" := 0;
                            Rec."Apple Buyback method  Code" := '';
                        END;

                        IF Rec.BuyBackType = Rec.BuyBackType::Apple THEN BEGIN
                            MapleEnable := FALSE;
                            AppleEnable := True;
                            Rec."Maple Buyback Amt" := 0;
                            Rec."Maple Buyback Method Code" := '';
                        END;

                        IF Rec.BuyBackType = Rec.BuyBackType::" " THEN BEGIN
                            MapleEnable := FALSE;
                            AppleEnable := FALSE;
                            Rec."Maple Buyback Amt" := 0;
                            Rec."Maple Buyback Method Code" := '';
                            Rec."Apple Buyback Amt" := 0;
                            Rec."Apple Buyback method  Code" := '';
                        END;
                        IF Rec.BuyBackType = Rec.BuyBackType::" " THEN
                            PurchInvoiceIIIEditable := FALSE//tk
                        ELSE BEGIN
                            GLSetup.GET;
                            PurchInvoiceIIIEditable := GLSetup."Purchase Invoice IIIrd Party";
                        END;//tk
                    end;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    DrillDown = true;
                    DrillDownPageID = "Customer Retail Master";
                    Importance = Promoted;
                    Lookup = true;
                    LookupPageID = "Customer Retail List New";
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SelltoCustomerNoOnAfterValidat;//tk
                    end;
                }
                field("Sell-to Contact No."; Rec."Sell-to Contact No.")
                {
                    Importance = Additional;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF Rec.GETFILTER("Sell-to Contact No.") = xRec."Sell-to Contact No." THEN
                            IF Rec."Sell-to Contact No." <> xRec."Sell-to Contact No." THEN
                                Rec.SETRANGE("Sell-to Contact No.");
                    end;
                }
                field("Cust. Mobile No."; Rec."Cust. Mobile No.")
                {
                    ApplicationArea = All;
                }
                field("Cust. email ID"; Rec."Cust. email ID")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    Caption = '**Customer Name';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        /*
                        IF "Sales Order Type" = "Sales Order Type"::Retail THEN
                        BEGIN
                          SInvLine.RESET;
                          SInvLine.SETFILTER("Customer Name",'%1',"Customer Name");
                          IF SInvLine.FINDSET THEN BEGIN
                            IF PAGE.RUNMODAL(50017,SInvLine) = ACTION::LookupOK THEN BEGIN
                              VALIDATE("Sell-to Customer No.",SInvLine."Sell-to Customer No."); //UpdatCustomerdetails(SInvLine);
                              //UpdatCustomerdetails(SInvLine);
                                CurrPage.UPDATE(TRUE);
                            END;
                          END
                          ELSE
                            CustomerLocal.RESET;
                            CustomerLocal.SETFILTER(Name,'%1',"Customer Name");
                            IF PAGE.RUNMODAL(50037,CustomerLocal) = ACTION::LookupOK THEN BEGIN
                              VALIDATE("Sell-to Customer No.",CustomerLocal."No."); //UpdatCustomerdetails(SInvLine);
                              CurrPage.UPDATE(TRUE);
                            END;
                        END;
                        */

                    end;
                }
                field("Sell-to Address"; Rec."Sell-to Address")
                {
                    Importance = Standard;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Sell-to Address 2"; Rec."Sell-to Address 2")
                {
                    Importance = Standard;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    Importance = Standard;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Sell-to City"; Rec."Sell-to City")
                {
                    Importance = Standard;
                    QuickEntry = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    Importance = Standard;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ApplicationArea = All;
                }
                field("No. of Archived Versions"; Rec."No. of Archived Versions")
                {
                    Importance = Additional;
                    Visible = false;
                    ApplicationArea = All;
                }
                // field(Structure;Structure)
                // {
                //     Importance = Promoted;
                //     Visible = false;
                // }//tk
                field("Posting Date"; Rec."Posting Date")
                {
                    Caption = '**Posting Date';
                    QuickEntry = false;
                    ApplicationArea = All;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount.';
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    Visible = true;
                    Editable = true;

                    ToolTip = 'Specifies how to make payment, such as with bank transfer, cash, or check.';
                    // Visible = IsPaymentMethodCodeVisible;

                    trigger OnValidate()
                    begin
                        //  UpdatePaymentService();
                    end;
                }
                field("Order Date"; Rec."Order Date")
                {
                    Importance = Promoted;
                    QuickEntry = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    QuickEntry = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Promised Delivery Date"; Rec."Promised Delivery Date")
                {
                    Importance = Additional;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Quote No."; Rec."Quote No.")
                {
                    Importance = Additional;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    Importance = Promoted;
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    Caption = '**Salesperson Code';
                    QuickEntry = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SalespersonCodeOnAfterValidate;//tk
                    end;
                }
                field("Posting No. Series"; Rec."Posting No. Series")
                {
                    ApplicationArea = all;
                }
                field("Posting No."; Rec."Posting No.")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Caption = '**Location Code';
                    Editable = true;
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Campaign No."; Rec."Campaign No.")
                {
                    Importance = Additional;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Opportunity No."; Rec."Opportunity No.")
                {
                    Importance = Additional;
                    Visible = false;
                    ApplicationArea = All;
                }
                // field("Responsibility Center New 1";"Responsibility Center New 1")
                // {
                //     Caption = '**Responsibility Center';
                //     Importance = Additional;
                //     Visible = false;
                // }//tk standard field not in bc
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    Importance = Additional;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job Queue Status"; Rec."Job Queue Status")
                {
                    Importance = Additional;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Credit Days Hold"; Rec."Credit Days Hold")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Credit Hold"; Rec."Credit Hold")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Overdue Hold"; Rec."Overdue Hold")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Price Hold"; Rec."Price Hold")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("PDC Hold"; Rec."PDC Hold")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Discount Hold"; Rec."Discount Hold")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Importance = Promoted;
                    QuickEntry = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Shield; Rec.Shield)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Buyer's Order No."; Rec."Buyer's Order No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Buyer's Order Dt"; Rec."Buyer's Order Dt")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(PurchaseLineExist; Rec.PurchaseLineExist)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(PurchInvoiceIIIEditable; PurchInvoiceIIIEditable)
                {
                    Caption = 'PurchInvoiceIIIEditable';
                    Visible = false;
                    ApplicationArea = All;
                }//tk1
                field(TotalPayByCustomer; Rec.TotalPayByCustomer)
                {
                    Caption = 'Total Customer Payment';
                    Editable = true;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Invoice Value"; Rec."Invoice Value")
                {
                    Caption = 'Invoice Value';
                    Editable = false;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;

                    // Visible = true;


                }
                field("Total Shield Value"; Rec."Total Shield Value")
                {
                    Enabled = false;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        // TotalwithShield := "Total Shield Value" + "Amount to Customer";
                    end;
                }
                field(TotalwithShield; TotalwithShield)
                {
                    Caption = 'Total Invoice value with Shield';
                    Editable = false;
                    Enabled = true;
                    ApplicationArea = All;
                }//tk1
                field("Trade In ReferenceID"; Rec."Trade In ReferenceID")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    BEGIN
                        Rec."Servify Approval Code" := Rec."Trade In ReferenceID";
                        ServifyApprovalCode := Rec."Trade In ReferenceID";
                    END;
                    //Visible = false;
                }
                field(CreditSale; Rec.CreditSale)
                {
                    ApplicationArea = All;
                }
                field(WebUserID; Rec.WebUserID)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //ShortcutDimension2CodeOnAfterV;
                    end;
                }
                field("Capillary Discount Amount"; Rec."Capillary Discount Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(CRTCouponCode; CRTCouponCode)
                {
                    Caption = 'CRT Coupon Code';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ValidateCRTCoupon; //KPPLDG00016
                    end;
                }//tk1
                field("Scan Barcode"; ScanBarcode)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        TempString: Text;
                        SerialNo: Text;
                        ItemNo: Code[20];
                        Sline: Record 37;
                        Sline2: Record 37;
                        Shead: Record 36;
                        Sline1: Record 37;
                        ReservationEntry: Record 337;
                    begin
                        /*IF STRPOS(ScanBarcode,'|') > 0 THEN
                       BEGIN
                         TempString := CONVERTSTR(ScanBarcode,'|',',');
                         SerialNo := SELECTSTR(1,TempString);
                         ItemNo := SELECTSTR(4,TempString);
                         Sline.RESET;
                         Sline.SETRANGE("Document No.",Rec."No.");
                         Sline.SETRANGE(Type,Sline.Type::Item);
                         Sline.SETRANGE("No.",ItemNo);
                         IF Sline.FINDFIRST THEN BEGIN
                           Sline.VALIDATE("Item Serial No.",SerialNo);
                           Sline.MODIFY;
                           CLEAR(ItemNo);
                           CLEAR(SerialNo);
                           ScanBarcode:='';
                           CLEAR(TempString);
                          END ELSE BEGIN
                            MESSAGE('Item No %1 Not found in Current Order',ItemNo);
                          CLEAR(ItemNo);
                           CLEAR(SerialNo);
                           ScanBarcode:='';
                           CLEAR(TempString);

                            END;
                        END;*/

                        IF STRPOS(ScanBarcode, '|') > 0 THEN BEGIN
                            TempString := CONVERTSTR(ScanBarcode, '|', ',');
                            SerialNo := SELECTSTR(1, TempString);
                            ItemNo := SELECTSTR(4, TempString);
                            Shead.RESET;
                            Shead.GET(Rec."Document Type", Rec."No.");
                            Sline.RESET;
                            Sline.SETRANGE("Document No.", Rec."No.");
                            Sline.SETRANGE(Type, Sline.Type::Item);
                            Sline.SETRANGE("No.", ItemNo);
                            IF Sline.FINDFIRST THEN BEGIN
                                ReservationEntry.RESET;
                                ReservationEntry.SETRANGE("Source ID", Sline."Document No.");
                                ReservationEntry.SETRANGE("Item No.", Sline."No.");
                                ReservationEntry.SETRANGE("Serial No.", SerialNo);
                                IF NOT ReservationEntry.FINDFIRST THEN BEGIN
                                    Sline.VALIDATE("Item Serial No.", SerialNo);
                                    Sline.MODIFY;
                                    CLEAR(ItemNo);
                                    CLEAR(SerialNo);
                                    ScanBarcode := '';
                                    CLEAR(TempString);
                                END ELSE BEGIN
                                    Sline1.RESET;
                                    Sline1.SETRANGE("Document No.", Rec."No.");
                                    IF Sline1.FINDLAST THEN;
                                    Sline2.INIT;
                                    Sline2."Line No." := Sline1."Line No." + 1000;
                                    Sline2.VALIDATE("Document Type", Rec."Document Type");
                                    Sline2.VALIDATE("Document No.", Rec."No.");
                                    Sline2.VALIDATE(Type, 2);
                                    Sline2.INSERT;

                                    Sline2.VALIDATE("No.", ItemNo);
                                    Sline2.VALIDATE(Quantity, 1);
                                    Sline2.MODIFY;
                                    COMMIT;
                                END;
                            END ELSE BEGIN
                                Sline1.RESET;
                                Sline1.SETRANGE("Document No.", Rec."No.");
                                IF Sline1.FINDLAST THEN;
                                Sline2.INIT;
                                Sline2."Line No." := Sline1."Line No." + 1000;
                                Sline2.VALIDATE("Document Type", Rec."Document Type");
                                Sline2.VALIDATE("Document No.", Rec."No.");
                                Sline2.VALIDATE(Type, 2);
                                Sline2.INSERT;

                                Sline2.VALIDATE("No.", ItemNo);
                                Sline2.VALIDATE(Quantity, 1);
                                Sline2.MODIFY;
                                COMMIT;

                            END;
                            Shead.RESET;
                            Shead.GET(Rec."Document Type", Rec."No.");
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

                            END;

                        END;

                    end;
                }//k1
                group(Payment)
                {
                    Caption = 'Payment';
                    field(PayByCashAmt; Rec.PayByCashAmt)
                    {
                        Caption = 'Cash Amount';
                        Style = Strong;
                        StyleExpr = TRUE;
                        ApplicationArea = All;
                    }
                    field(PayByCreditNo1; Rec.PayByCreditNo1)
                    {
                        Caption = 'Credit Card machine Name';
                        ApplicationArea = All;
                    }
                    field("CreditCdPay Method Code1"; Rec."CreditCdPay Method Code1")
                    {
                        Caption = 'Credit Card Payment Method';
                        Editable = true;
                        Enabled = true;
                        Visible = false;
                        ApplicationArea = All;
                    }
                    field(CreditCardNo1; Rec.CreditCardNo1)
                    {
                        Caption = 'Credit Card No.1';
                        ApplicationArea = All;
                    }
                    field(PayByCreditAmt1; Rec.PayByCreditAmt1)
                    {
                        Caption = 'Credit Card Amount';
                        Style = Strong;
                        StyleExpr = TRUE;
                        ApplicationArea = All;
                    }
                    field("DebitCdPay Method Code1"; Rec."DebitCdPay Method Code1")
                    {
                        Caption = 'Debit Card Payment Method Code';
                        Visible = false;
                        ApplicationArea = All;
                    }
                    field(PayByDebitCdNo1; Rec.PayByDebitCdNo1)
                    {
                        Caption = 'Debit Card Machine Name';
                        ApplicationArea = All;
                    }
                    field(DebitCardNo1; Rec.DebitCardNo1)
                    {
                        Caption = 'Debit Card No.1';
                        ApplicationArea = All;
                    }
                    field(PayByDebitCdAmt1; Rec.PayByDebitCdAmt1)
                    {
                        Caption = 'Debit Card Amount';
                        Style = Strong;
                        StyleExpr = TRUE;
                        ApplicationArea = All;
                    }
                    field("Maple Buyback Amt"; Rec."Maple Buyback Amt")
                    {
                        Caption = 'BB Amount';
                        Editable = true;
                        Enabled = true;
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            Rec.TestField(Rec."Servify Approval Code");
                            //PurchaseAmount := "Maple Buyback Amt";
                            MESSAGE(FORMAT(Rec."Maple Buyback Amt"));
                        end;
                    }
                }
            }
            group("Additional Payment")
            {
                Caption = 'Additional Payment';
                field(PayByChqNo; Rec.PayByChqNo)
                {
                    Caption = 'Cheque No.';
                    ApplicationArea = All;
                }
                field(PayByChqDt; Rec.PayByChqDt)
                {
                    Caption = 'Cheque Date';
                    ApplicationArea = All;
                }
                field(PayByChqAmt; Rec.PayByChqAmt)
                {
                    Caption = 'Cheque Amount';
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("CashPay Method Code"; Rec."CashPay Method Code")
                {
                    Caption = 'Cash Payment Method Code';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("GiftPay Method Code"; Rec."GiftPay Method Code")
                {
                    Caption = 'Gift Voucher Payment Method Code';
                    Visible = false;
                    ApplicationArea = All;
                }
                field(PayByCreditNo2; Rec.PayByCreditNo2)
                {
                    Caption = 'Credit Card machine Name';
                    ApplicationArea = All;
                }
                field("CreditCdPay Method Code2"; Rec."CreditCdPay Method Code2")
                {
                    Caption = 'Credit Card Payment Method';
                    Editable = true;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(CreditCardNo2; Rec.CreditCardNo2)
                {
                    Caption = 'Credit Card No.2';
                    ApplicationArea = All;
                }
                field(PayByCreditAmt2; Rec.PayByCreditAmt2)
                {
                    Caption = 'Credit Card  Amount';
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field(PayByCreditNo3; Rec.PayByCreditNo3)
                {
                    Caption = 'Credit Card machine Name';
                    ApplicationArea = All;
                }
                field("CreditCdPay Method Code3"; Rec."CreditCdPay Method Code3")
                {
                    Caption = 'Credit Card Payment Method';
                    Editable = true;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(CreditCardNo3; Rec.CreditCardNo3)
                {
                    Caption = 'Credit Card No.3';
                    ApplicationArea = All;
                }
                field(PayByCreditAmt3; Rec.PayByCreditAmt3)
                {
                    Caption = 'Credit Card Amount';
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field(PayByCreditNo4; Rec.PayByCreditNo4)
                {
                    Caption = 'Credit Card machine Name';
                    ApplicationArea = All;
                }
                field("CreditCdPay Method Code4"; Rec."CreditCdPay Method Code4")
                {
                    Caption = 'Credit Card Payment Method';
                    Editable = true;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(CreditCardNo4; Rec.CreditCardNo4)
                {
                    Caption = 'Credit Card No.4';
                    ApplicationArea = All;
                }
                field(PayByCreditAmt4; Rec.PayByCreditAmt4)
                {
                    Caption = 'Credit Card Amount';
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("DebitCdPay Method Code2"; Rec."DebitCdPay Method Code2")
                {
                    Caption = 'Debit Card Payment Method';
                    Editable = true;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(PayByDebitNo2; Rec.PayByDebitNo2)
                {
                    Caption = 'Debit Card machine Name';
                    ApplicationArea = All;
                }
                field(DebitCardNo2; Rec.DebitCardNo2)
                {
                    Caption = 'Debit Card No.2';
                    ApplicationArea = All;
                }
                field(PayByDebitAmt2; Rec.PayByDebitAmt2)
                {
                    Caption = 'Debit Card Amount';
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field(GiftVoucherAmt; Rec.GiftVoucherAmt)
                {
                    Caption = 'Gift Voucher Amount';
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("RTGSPay Method Code"; Rec."RTGSPay Method Code")
                {
                    Caption = 'RTGS Payment Method Code';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("RTGS Bank Name"; Rec."RTGS Bank Name")
                {
                    ApplicationArea = All;
                }
                field("RTGS Ref. No."; Rec."RTGS Ref. No.")
                {
                    ApplicationArea = All;
                }
                field("RTGS Amount"; Rec."RTGS Amount")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("FinPay Method Code"; Rec."FinPay Method Code")
                {
                    Caption = 'Finance Payment Method Code';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Finance Comapny new"; Rec."Finance Comapny new")
                {
                    ApplicationArea = All;
                }
                field("Bank Approval Code"; Rec."Bank Approval Code")
                {
                    ApplicationArea = All;
                }
                field("Finance Amount"; Rec."Finance Amount")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("ChqPay Method Code"; Rec."ChqPay Method Code")
                {
                    Caption = 'Cheque Payment Method Code';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Maple Buyback Method Code"; Rec."Maple Buyback Method Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Paytm Approval Code"; Rec."Paytm Approval Code")
                {
                    Caption = 'Razor Pay Approval Code';
                    ApplicationArea = All;
                }
                field("Paytm Transfer Amount"; Rec."Paytm Transfer Amount")
                {
                    Caption = 'Razor Pay Transfer Amount';
                    ApplicationArea = All;
                }
                field("Amazon Approval Code"; Rec."Amazon Approval Code")
                {
                    Caption = 'PAYTM DCEMI Code';
                    ApplicationArea = All;
                }
                field("Amazon Transfer Amount"; Rec."Amazon Transfer Amount")
                {
                    Caption = 'PAYTM DCEMI Amount';
                    ApplicationArea = All;
                }
                field("Insurance Approval Code"; Rec."Insurance Approval Code")
                {
                    ApplicationArea = All;
                }
                field("Insurance Transfer Amount"; Rec."Insurance Transfer Amount")
                {
                    ApplicationArea = All;
                }
                field("Cashify Approval Code"; Rec."Cashify Approval Code")
                {
                    ApplicationArea = All;
                }
                field("Cashify Transfer Amount"; Rec."Cashify Transfer Amount")
                {
                    ApplicationArea = All;
                }
                field("Cashify Bonus Amount"; Rec."Cashify Bonus Amount")
                {
                    ApplicationArea = All;

                }
                field("Pinelab Approval Code"; Rec."Pinelab Approval Code")
                {
                    ApplicationArea = All;
                }
                field("Pinelab Transfer Amount"; Rec."Pinelab Transfer Amount")
                {
                    ApplicationArea = All;
                }
                field("Loyalty Riwardz Approval Code"; Rec."Loyalty Riwardz Approval Code")
                {
                    ApplicationArea = All;
                }
                field("Loyalty Riwardz Tr.Amount"; Rec."Loyalty Riwardz Tr.Amount")
                {
                    ApplicationArea = All;
                }
                field("Loyalty Riwardz Method Code"; Rec."Loyalty Riwardz Method Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("EasyOzy Purchase Amount"; Rec."Servify Purchase Amount")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the EasyOzy Purchase Amount field.';
                    trigger OnValidate()
                    BEGIN
                        Rec.TestField("Servify Approval Code");
                    END;
                }
                field("EasyOzy Bonus Amount"; Rec."EasyOzy Bonus Amount")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the EasyOzy Bonus Amount field.';
                    trigger OnValidate()
                    BEGIN
                        Rec.TestField("Servify Approval Code");
                    END;
                }

                field(ServifyApprovalCode; ServifyApprovalCode)
                {
                    Caption = 'Servify Approval Code';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec."Servify Approval Code" := ServifyApprovalCode;
                        //KPPLDG00023
                        Rec.UpdateServifyDetails(ServifyApprovalCode, 0, 'Servify');
                    end;
                }
                field(ServifyTransferAmount; ServifyTransferAmount)
                {
                    Caption = 'Servify Transfer Amount';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //KPPLDG00023
                        IF ServifyApprovalCode = '' THEN
                            ERROR('Plese Enter Servify Approval Code first.');
                        Rec.UpdateServifyDetails(ServifyApprovalCode, ServifyTransferAmount, 'Servify');
                        Rec."Servify Transfer Amount" := ServifyTransferAmount;//RY
                    end;
                }
                field("Servify Bonus Amount"; Rec."Servify Bonus Amount")
                {
                    Caption = 'Servify Bonus Amount';
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        BBSetup: Record "Buy Back Bonus Setup";
                    begin
                        IF ServifyApprovalCode = '' THEN
                            ERROR('Plese Enter Servify Approval Code first.');
                        ServifyBonusAmount := Rec."Servify Bonus Amount";
                        IF BBSetup.Get(Rec."Servify Bonus Amount") THEN BEGIN
                            Rec."Maple Contribution" := BBSetup."Maple Contribution";
                            Rec."Apple Contribution" := BBSetup."Apple Contribution";
                        END;
                        //Rec."Servify Bonus Amount" := ServifyBonusAmount; //RY
                        Rec.UpdateServifyBonusDetails(ServifyApprovalCode, ServifyBonusAmount, 'SRFYBONUS');

                    end;
                }
                field("Trade-in device IMEI no."; Rec."Trade-in device IMEI no.")
                {
                    ToolTip = 'Specifies the value of the Trade-in device IMEI no. field.';
                    trigger OnValidate()
                    BEGIN
                        IF ServifyApprovalCode = '' THEN
                            ERROR('Plese Enter Servify Approval Code first.');
                    END;
                }
                field("Trade-in Device Model no."; Rec."Trade-in Device Model no.")
                {
                    ToolTip = 'Specifies the value of the Trade-in Device Model no. field.';
                    trigger OnValidate()
                    BEGIN
                        IF ServifyApprovalCode = '' THEN
                            ERROR('Plese Enter Servify Approval Code first.');
                    END;
                }
                field("EU Deduction fees"; Rec."EU Deduction fees")
                {
                    ToolTip = 'Specifies the value of the EU Deduction fees field.';
                }

                field(PaytmApprovalCode; PaytmApprovalCode)
                {
                    Caption = 'Paytm Approval Code';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //KPPLDG00033
                        Rec.UpdatePaytmDetails(PaytmApprovalCode, 0, 'Paytm');
                    end;
                }
                field(PaytmTransferAmount; PaytmTransferAmount)
                {
                    Caption = 'Paytm Transfer Amount';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //KPPLDG00033
                        IF PaytmApprovalCode = '' THEN
                            ERROR('Plese Enter Paytm Approval Code first.');
                        Rec.UpdatePaytmDetails(PaytmApprovalCode, PaytmTransferAmount, 'Paytm');
                        Rec."Paytm Transfer Amount Last" := PaytmTransferAmount;//RY
                    end;
                }
            }//tk1

            group("Servify Details")
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Mobile Number"; Rec."Mobile Number")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Email ID"; Rec."Email ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Name Of Firm"; Rec."Name Of Firm")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Service Location Name"; Rec."Service Location Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Servify Currency Code"; Rec."Servify Currency Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Logistics Reference ID"; Rec."Logistics Reference ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Trade In Status"; Rec."Trade In Status")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Model Storage"; Rec."Model Storage")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Product Unique ID"; Rec."Product Unique ID")
                {
                    Caption = 'Product Unique ID old';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Product Unique ID New"; Rec."Product Unique ID New")
                {
                    ToolTip = 'Specifies the value of the Product Unique ID New field.', Comment = '%';
                    Editable = false;
                }
                field("Model Name"; Rec."Model Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Model Grade"; Rec."Model Grade")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Model Brand"; Rec."Model Brand")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Device Customer Amount"; Rec."Device Customer Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Device Retailer Amount"; Rec."Device Retailer Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bonus Amount"; Rec."Bonus Amount")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Bonus Amount field.', Comment = '%';
                }
            }
            part(SalesLines1; 50019)
            {
                //Editable = DynamicEditable;
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;
                UpdatePropagation = Both;
            }

            group("Purchase Details")
            {
                Caption = 'Purchase Details';
                Editable = PurchInvoiceIIIEditable;//tk1
                Enabled = true;
                Visible = PurchInvoiceIIIEditable;
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Inward Location"; Rec."Inward Location")
                {
                    ApplicationArea = All;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(BuybackRefundDistributor; Rec.BuybackRefundDistributor)
                {
                    Caption = 'Apple Refund Distributor';
                    ApplicationArea = All;
                }
                // field("Purchase Amount"; PurchaseAmount)
                // {
                //     Enabled = MapleEnable;
                //     Visible = false;
                // }
            }
            part(PurchLines; 50033)
            {
                Caption = 'Purchase Lines';
                Editable = true;
                Enabled = PurchInvoiceIIIEditable;//tk
                SubPageLink = "Document No." = FIELD("PurchaseOrderNo.");
                Visible = PurchInvoiceIIIEditable;
                ApplicationArea = All;
            }
            group("Third Party Sales Details")
            {
                Caption = 'Third Party Sales Details';
                // Editable = SalesInvoiceIIIEditable;//tk
                Visible = false;
                field("Party No"; Rec."Party No")
                {
                    ApplicationArea = All;
                }
                field("Party Name"; Rec."Party Name")
                {
                    ApplicationArea = All;
                }
                field("Party Sales Location"; Rec."Party Sales Location")
                {
                    ApplicationArea = All;
                }
                field("Party Address"; Rec."Party Address")
                {
                    ApplicationArea = All;
                }
                field("Party City"; Rec."Party City")
                {
                    ApplicationArea = All;
                }
                field("Party Item"; Rec."Vendor Name")
                {
                    Caption = 'Party item';
                    ApplicationArea = All;
                }
                field("Party item Price"; Rec."Party Item Price")
                {
                    Caption = 'Party Item Price';
                    ApplicationArea = All;
                }
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                Visible = false;
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    Importance = Promoted;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        // BilltoCustomerNoOnAfterValidat;
                    end;
                }
                field("Bill-to Contact No."; Rec."Bill-to Contact No.")
                {
                    Importance = Additional;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Bill-to Address"; Rec."Bill-to Address")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Bill-to Address 2"; Rec."Bill-to Address 2")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Bill-to City"; Rec."Bill-to City")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    ApplicationArea = All;
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                    ApplicationArea = All;
                }
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        // ShortcutDimension1CodeOnAfterV;
                    end;
                }
                // field("Payment Terms Code"; "Payment Terms Code")
                // {
                //     Importance = Promoted;
                // }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ApplicationArea = All;
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    ApplicationArea = All;
                }
                // field("Payment Method Code"; "Payment Method Code")
                // {
                // }
                field("Direct Debit Mandate ID"; Rec."Direct Debit Mandate ID")
                {
                    ApplicationArea = All;
                }
                field("Prices Including VAT"; Rec."Prices Including VAT")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        // PricesIncludingVATOnAfterValid;
                    end;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                // field("Credit Card No."; "Credit Card No.")
                // {
                // }
                // field(GetCreditcardNumber; GetCreditcardNumber)
                // {
                //     Caption = 'Cr. Card Number (Last 4 Digits)';
                // }//tk
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                Visible = false;
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Outbound Whse. Handling Time"; Rec."Outbound Whse. Handling Time")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Shipping Time"; Rec."Shipping Time")
                {
                    ApplicationArea = All;
                }
                field("Late Order Shipping"; Rec."Late Order Shipping")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Package Tracking No."; Rec."Package Tracking No.")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Shipping Advice"; Rec."Shipping Advice")
                {
                    Importance = Promoted;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF Rec."Shipping Advice" <> xRec."Shipping Advice" THEN
                            IF NOT CONFIRM(Text001, FALSE, Rec.FIELDCAPTION("Shipping Advice")) THEN
                                ERROR(Text002);
                    end;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                Visible = false;
                field("Currency Code"; Rec."Currency Code")
                {
                    Importance = Promoted;
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        // CLEAR(ChangeExchangeRate);
                        // IF "Posting Date" <> 0D THEN
                        //     ChangeExchangeRate.SetParameter("Currency Code", "Currency Factor", "Posting Date")
                        // ELSE
                        //     ChangeExchangeRate.SetParameter("Currency Code", "Currency Factor", WORKDATE);
                        // IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
                        //     VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
                        //     CurrPage.UPDATE;
                        // END;
                        // CLEAR(ChangeExchangeRate);
                    end;
                }
                field("EU 3-Party Trade"; Rec."EU 3-Party Trade")
                {
                    ApplicationArea = All;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ApplicationArea = All;
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ApplicationArea = All;
                }
                field("Exit Point"; Rec."Exit Point")
                {
                    ApplicationArea = All;
                }
                //         field(Area;Area)
                // {
                // }//tk
            }
            group(Prepayment)
            {
                Caption = 'Prepayment';
                Visible = false;
                field("Prepayment %"; Rec."Prepayment %")
                {
                    Importance = Promoted;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        // Prepayment37OnAfterValidate;
                    end;
                }
                field("Compress Prepayment"; Rec."Compress Prepayment")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Payment Terms Code"; Rec."Prepmt. Payment Terms Code")
                {
                    ApplicationArea = All;
                }
                field("Prepayment Due Date"; Rec."Prepayment Due Date")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Prepmt. Payment Discount %"; Rec."Prepmt. Payment Discount %")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Pmt. Discount Date"; Rec."Prepmt. Pmt. Discount Date")
                {
                    ApplicationArea = All;
                }
            }
            group("Tax Information")
            {
                Caption = 'Tax Information';
                Visible = false;
                // field("Transit Document"; "Transit Document")
                // {
                // }
                // field("Free Supply"; "Free Supply")
                // {
                // }
                field("TDS Certificate Receivable"; Rec."TDS Certificate Receivable")
                {
                    ApplicationArea = All;
                }
                // field("Calc. Inv. Discount (%)"; "Calc. Inv. Discount (%)")
                // {
                // }
                // field("Export or Deemed Export"; "Export or Deemed Export")
                // {
                // }
                // field("VAT Exempted"; "VAT Exempted")
                // {
                // }
                // field(Trading; Trading)
                // {
                // }//tk
                // field("ST Pure Agent"; "ST Pure Agent")
                // {
                // }
                // field("Re-Dispatch"; "Re-Dispatch")
                // {

                //     trigger OnValidate()
                //     begin
                //         ReDispatchOnPush;
                //         IF NOT "Re-Dispatch" AND ("Return Re-Dispatch Rcpt. No." <> '') THEN
                //             ERROR(Text16500);
                //         IF "Re-Dispatch" THEN BEGIN
                //             ReturnOrderNoVisible := TRUE;
                //         END ELSE
                //             ReturnOrderNoVisible := FALSE;
                //     end;
                // }
                // field(PoT; PoT)
                // {
                // }
                // field(ReturnOrderNo; "Return Re-Dispatch Rcpt. No.")
                // {
                //     Caption = 'Return Receipt No.';
                //     Visible = ReturnOrderNoVisible;
                // }
                // field("LC No."; "LC No.")
                // {
                // }
                // field("Form Code"; "Form Code")
                // {
                //     Importance = Promoted;
                // }//tk
                // field("Form No."; "Form No.")
                // {
                // }//tk
                field("Posting Date2"; Rec."Posting Date")
                {
                    Caption = 'Date of Removal';
                    ApplicationArea = All;
                }
                field("Time of Removal"; Rec."Time of Removal")
                {
                    Caption = 'Time of Removal';
                    ApplicationArea = All;
                }
                field("Mode of Transport"; Rec."Mode of Transport")
                {
                    Caption = 'Mode of Transport';
                    ApplicationArea = All;
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    Caption = 'Vehicle No.';
                    ApplicationArea = All;
                }
                // field("LR/RR No."; "LR/RR No.")
                // {
                //     Caption = 'LR/RR No.';
                // }
                // field("LR/RR Date"; "LR/RR Date")
                // {
                //     Caption = 'LR/RR Date';
                // }
                // field("Service Tax Rounding Precision"; "Service Tax Rounding Precision")
                // {
                // }
                // field("Service Tax Rounding Type"; "Service Tax Rounding Type")
                // {
                // }
                //}
            }
        }
        area(factboxes)

        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"Sales Header"),
                              "No." = field("No."),
                              "Document Type" = field("Document Type");
            }
            part("SaleHits Sell to factbox"; 9080)
            {
                SubPageLink = "No." = FIELD("Sell-to Customer No.");
                Visible = false;
                ApplicationArea = All;
            }
            part("Customer Stastics Factbox"; 9082)
            {
                SubPageLink = "No." = FIELD("Bill-to Customer No.");
                Visible = false;
                ApplicationArea = All;
            }
            part("Customer Details FactBox"; 9084)
            {
                SubPageLink = "No." = FIELD("Sell-to Customer No.");
                Visible = false;
                ApplicationArea = All;
            }
            part("Sales Line FactBox"; 9087)
            {
                ApplicationArea = All;
                Provider = SalesLines;
                SubPageLink = "Document No." = FIELD("No.");
                // Visible = false;
            }
            part("Item Invoicing FactBox"; 9089)
            {
                Provider = SalesLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = false;
                ApplicationArea = All;
            }
            part("Customer Statictics factbox"; 9092)
            {
                SubPageLink = "Table ID" = CONST(36),
                              "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
                Visible = false;
                ApplicationArea = All;
            }
            part(SalesLines; 9108)
            {
                // Provider = SalesLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = false;
                ApplicationArea = All;
            }
            part("Item Warehouse Factbox"; 9109)
            {
                Provider = SalesLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = false;
                ApplicationArea = All;
            }
            part("Sales Hist bill to factbox"; 9081)
            {
                SubPageLink = "No." = FIELD("Bill-to Customer No.");
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Links; Links)
            {
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
    }


    actions
    {
        area(navigation)
        {
            group("O&rder")
            {
                Caption = 'O&rder';
                Image = "Order";
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';
                    ApplicationArea = All;

                    trigger OnAction()
                    VAR

                        SL: Record "Sales Line";
                    begin

                        SL.RESET;
                        SL.SETRANGE(SL."Document No.", Rec."No.");
                        SL.SetFilter(SL."Unit Price Incl. of Tax", '<>%1', 0);
                        SL.SetFilter(SL."GST Group Code", '<>%1', '');
                        SL.SetRange(SL."Price Inclusive of Tax", true);
                        IF SL.FindSet() THEN BEGIN
                            REPEAT
                                SL.Validate("Price Inclusive of Tax", true);
                                SL.MODIFY;
                            UNTIL SL.Next() = 0;
                            COMMIT;
                        END;                 // SalesSetup.GET;
                        // CALCFIELDS("Price Inclusive of Taxes");
                        // IF SalesSetup."Calc. Inv. Discount" AND (NOT "Price Inclusive of Taxes") THEN BEGIN
                        //     CalcInvDiscForHeader;
                        //     COMMIT
                        // END;
                        // IF "Price Inclusive of Taxes" THEN BEGIN
                        //     SalesLine.InitStrOrdDetail(Rec);
                        //     SalesLine.GetSalesPriceExclusiveTaxes(Rec);
                        //     SalesLine.UpdateSalesLinesPIT(Rec);
                        //     COMMIT;
                        // END;

                        // IF Structure <> '' THEN BEGIN
                        //     SalesLine.CalculateStructures(Rec);
                        //     SalesLine.AdjustStructureAmounts(Rec);
                        //     SalesLine.UpdateSalesLines(Rec);
                        //     SalesLine.CalculateTCS(Rec);
                        // END ELSE
                        //     SalesLine.CalculateTCS(Rec);

                        COMMIT;
                        PAGE.RUNMODAL(PAGE::"Sales Order Statistics", Rec);
                        CurrPage.Update();//TK
                        GlobalRefereshDone := true;
                    end;
                }
                action(Refresh)
                {
                    Promoted = true;
                    PromotedCategory = Process;
                    //Visible = false;
                    ApplicationArea = All;
                    Image = Refresh;
                    trigger OnAction()
                    begin
                        CurrPage.Update(true);

                    end;
                }
                action("Calculate Shield Payment")
                {
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        PAGE.RUNMODAL(50042, Rec);
                    end;
                }
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page 21;
                    RunPageLink = "No." = FIELD("Sell-to Customer No.");
                    ShortCutKey = 'Shift+F7';
                    Visible = false;
                    ApplicationArea = All;
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                        CurrPage.SAVERECORD;
                    end;
                }
                action("Voucher Integration")
                {
                    Image = Voucher;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = all;
                    RunObject = Page 50153;
                    RunPageLink = "SO No." = FIELD("No.");//tk

                    trigger OnAction()
                    var
                        RecSOOOO: Record 50021;
                        RecSOOOO1: Record 50021;
                    begin
                        RecSOOOO.RESET;
                        RecSOOOO.SETRANGE("SO No.", Rec."No.");
                        IF NOT RecSOOOO.FINDFIRST THEN BEGIN
                            RecSOOOO1.INIT;
                            RecSOOOO1."SO No." := Rec."No.";
                            RecSOOOO1.INSERT;
                        END;
                    end;
                }
                action("A&pprovals")
                {
                    Caption = 'A&pprovals';
                    Image = Approvals;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page 658;
                    begin
                        // ApprovalEntries.Setfilters(DATABASE::"Sales Header", "Document Type", "No.");
                        // ApprovalEntries.RUN;//tk
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 67;
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                    ApplicationArea = All;
                }
                action("Credit Cards Transaction Lo&g Entries")
                {
                    Caption = 'Credit Cards Transaction Lo&g Entries';
                    Image = CreditCardLog;
                    // RunObject = Page 829;
                    //                 RunPageLink = "Document No."=FIELD("No."),
                    //               "Customer No."=FIELD("Bill-to Customer No.");
                    Visible = false;
                    ApplicationArea = All;
                }
                separator(Separator)
                {
                }
                // action("St&ructure")
                // {
                //     Caption = 'St&ructure';
                //     Image = Hierarchy;
                //     RunObject = Page 16305;
                //                     RunPageLink = Type=CONST(Sale),
                //                   Document Type=FIELD(Document Type),
                //                   Document No.=FIELD(No.),
                //                   Structure Code=FIELD(Structure),
                //                   Document Line No.=FILTER(0);
                // }
                action("Transit Documents")
                {
                    Caption = 'Transit Documents';
                    Image = TransferOrder;
                    ApplicationArea = All;
                    // RunObject = Page 13705;
                    //                 RunPageLink = Type=CONST(Sale),
                    //               PO / SO No.=FIELD(No.),
                    //               Vendor / Customer Ref.=FIELD(Sell-to Customer No.),
                    //               State=FIELD(State);
                    // Visible = false;
                }
                action("Detailed &Tax")
                {
                    Caption = 'Detailed &Tax';
                    Image = TaxDetail;
                    ApplicationArea = All;
                    // RunObject = Page 16342;
                    //                 RunPageLink = Document Type=FIELD(Document Type),
                    //               Document No.=FIELD(No.),
                    //               Transaction Type=CONST(Sale);
                    // Visible = false;
                }
                action("Assembly Orders")
                {
                    Caption = 'Assembly Orders';
                    Image = AssemblyOrder;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        AssembleToOrderLink: Record 904;
                    begin
                        AssembleToOrderLink.ShowAsmOrders(Rec);
                    end;
                }
                action("Send A&pproval Request")
                {
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit 439;
                    begin
                        //IF ApprovalMgt.SendSalesApprovalRequest(Rec) THEN;
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit 439;
                    begin
                        // IF ApprovalMgt.CancelSalesApprovalRequest(Rec, TRUE, TRUE) THEN;
                    end;
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                Image = Documents;
                Visible = false;
                action("S&hipments")
                {
                    Caption = 'S&hipments';
                    Image = Shipment;
                    RunObject = Page 142;
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                    ApplicationArea = All;
                }
                action(Invoices)
                {
                    Caption = 'Invoices';
                    Image = Invoice;
                    ApplicationArea = All;
                    // RunObject = Page 143;
                    //                 RunPageLink = Order No.=FIELD(No.);
                    // RunPageView = SORTING("Order No.");
                }


            }
            group(Warehouse)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                Visible = false;
                action("In&vt. Put-away/Pick Lines")
                {
                    Caption = 'In&vt. Put-away/Pick Lines';
                    Image = PickLines;
                    RunObject = Page 5774;
                    RunPageLink = "Source Document" = CONST("Sales Order"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Document", "Source No.", "Location Code");
                    Visible = false;
                    ApplicationArea = All;
                }
                action("Whse. Shipment Lines")
                {
                    Caption = 'Whse. Shipment Lines';
                    Image = ShipmentLines;
                    RunObject = Page 7341;
                    RunPageLink = "Source Type" = CONST(37),
                                  "Source Subtype" = FIELD("Document Type"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                    ApplicationArea = All;
                }
            }

            group(Prepayment1)
            {
                Caption = 'Prepayment';
                Image = Prepayment;
                Visible = false;
                action("Prepa&yment Invoices")
                {
                    Caption = 'Prepa&yment Invoices';
                    Image = PrepaymentInvoice;
                    RunObject = Page 143;
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                    ApplicationArea = All;
                }
                action("Prepayment Credi&t Memos")
                {
                    Caption = 'Prepayment Credi&t Memos';
                    Image = PrepaymentCreditMemo;
                    RunObject = Page 144;
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                    ApplicationArea = All;
                }
            }
        }
        area(processing)
        {
            action("Get Trade In Exchange")
            {
                //Visible = false;
                ApplicationArea = All;
                Image = NewTransferOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    L_Headers: HttpHeaders;
                    L_Client: HttpClient;
                    L_Content: HttpContent;
                    L_ResponseMessage: HttpResponseMessage;
                    ResponseText: Text;
                    APIPath: Text;
                    SalesRec: Record "Sales & Receivables Setup";
                    jObject: JsonObject;
                begin
                    Rec.TestField("Trade In ReferenceID");
                    SalesRec.Get();
                    Clear(L_Headers);
                    Clear(L_Content);
                    Clear(L_Client);
                    Clear(L_ResponseMessage);
                    Clear(ResponseText);
                    L_Headers := L_Client.DefaultRequestHeaders;
                    L_Headers.Add('Accept', 'application/json');
                    L_Content.GetHeaders(L_Headers);


                    Clear(APIPath);
                    APIPath := SalesRec."API URL" + 'values?clientSecret=' + SalesRec.ClientSecret + '&host=' + SalesRec.Host;
                    if L_Client.Get(APIPath, L_ResponseMessage) then begin
                        if L_ResponseMessage.HttpStatusCode = 200 then begin
                            if (L_ResponseMessage.IsSuccessStatusCode = true) then begin
                                L_ResponseMessage.Content().ReadAs(ResponseText);
                                jObject.ReadFrom(ResponseText);

                                Clear(myDate);
                                if jObject.Contains('mydate') then begin
                                    if GetJsonvalue(jObject, 'mydate').IsNull = false then begin
                                        myDate := GetJsonvalue(jObject, 'mydate').AsText();
                                    end;
                                end;
                                Clear(hmac);
                                if jObject.Contains('hmac') then begin
                                    if GetJsonvalue(jObject, 'hmac').IsNull = false then begin
                                        hmac := GetJsonvalue(jObject, 'hmac').AsText();
                                        //GetAuth(myDate, hmac);
                                        GetAuth(myDate, hmac, true);
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            }
            // MAPPLE 1.0 Bundle Item >>>
            action(InsertBundle)
            {
                ApplicationArea = All;
                Image = AddAction;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Insert Bundle Item';
                trigger OnAction()
                var
                    BundleItems: Record "Bundle Items";
                    BundleList: Page "Bundle List";
                begin
                    Commit();
                    BundleList.SetRecord(BundleItems);
                    BundleList.SetTableView(BundleItems);
                    BundleList.LookupMode(true);
                    if BundleList.RunModal() = Action::LookupOK then begin
                        BundleList.SetSelectionFilter(BundleItems);
                        if BundleItems.FindSet() then
                            repeat
                                InsetBundleLineItem(BundleItems."Bundle Code", Rec."No.", Rec."Document Type");
                            until
                            BundleItems.Next() = 0;
                        if DataInsert then
                            Message('Data inserted.')
                        else
                            Message('Data not found.');
                    end;
                end;
            }
            // MAPPLE 1.0 Bundle Item <<<
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = SendApprovalRequest;
                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    ApplicationArea = All;
                    //Promoted = true;
                    // PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        // IF ApprovalsMgmt.CheckSalesApprovalsWorkflowEnabled(Rec) THEN
                        //   ApprovalsMgmt.OnSendSalesDocForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    ApplicationArea = All;
                    //Promoted = true;
                    //PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OnCancelSalesApprovalRequest(Rec);
                    end;
                }
            }
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RECORDID);
                    end;
                }
                action(Reject)
                {
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RECORDID);
                    end;
                }
                action(Delegate)
                {
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RECORDID);
                    end;
                }
                action(Comment)
                {
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
            }
            group(Release1)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                Visible = false;
                action(Release)
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit 414;
                    begin
                        ReleaseSalesDoc.PerformManualRelease(Rec);
                    end;
                }
                action("Re&open")
                {
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit 414;
                    begin
                        ReleaseSalesDoc.PerformManualReopen(Rec);
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                Visible = false;
                action("Calculate &Invoice Discount")
                {
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //tk
                        // CALCFIELDS("Price Inclusive of Taxes");
                        // IF NOT "Price Inclusive of Taxes" THEN
                        //   ApproveCalcInvDisc
                        // ELSE
                        //   ERROR(STRSUBSTNO(Text16501,FIELDCAPTION("Price Inclusive of Taxes")));
                    end;
                }
                action("Get St&d. Cust. Sales Codes")
                {
                    Caption = 'Get St&d. Cust. Sales Codes';
                    Ellipsis = true;
                    Image = CustomerCode;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        StdCustSalesCode: Record 172;
                    begin
                        StdCustSalesCode.InsertSalesLines(Rec);
                    end;
                }
                action(CopyDocument)
                {
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CopySalesDoc.SetSalesHeader(Rec);
                        CopySalesDoc.RUNMODAL;
                        CLEAR(CopySalesDoc);
                    end;
                }
                action("Move Negative Lines")
                {
                    Caption = 'Move Negative Lines';
                    Ellipsis = true;
                    Image = MoveNegativeLines;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CLEAR(MoveNegSalesLines);
                        MoveNegSalesLines.SetSalesHeader(Rec);
                        MoveNegSalesLines.RUNMODAL;
                        MoveNegSalesLines.ShowDocument;
                    end;
                }
                action("Archive Document")
                {
                    Caption = 'Archi&ve Document';
                    Image = Archive;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ArchiveManagement.ArchiveSalesDocument(Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Send IC Sales Order Cnfmn.")
                {
                    Caption = 'Send IC Sales Order Cnfmn.';
                    Image = IntercompanyOrder;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ICInOutboxMgt: Codeunit 427;
                        ApprovalMgt: Codeunit 439;
                        PurchaseHeader: Record 38;
                    begin
                        // IF ApprovalMgt.PrePostApprovalCheck(Rec,PurchaseHeader) THEN
                        //   ICInOutboxMgt.SendSalesDoc(Rec,FALSE);
                    end;
                }
            }
            group(Plan)
            {
                Caption = 'Plan';
                Image = Planning;
                Visible = false;
                action("Order &Promising")
                {
                    Caption = 'Order &Promising';
                    Image = OrderPromising;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        OrderPromisingLine: Record 99000880 temporary;
                    begin
                        OrderPromisingLine.SETRANGE("Source Type", Rec."Document Type");
                        OrderPromisingLine.SETRANGE("Source ID", Rec."No.");
                        PAGE.RUNMODAL(PAGE::"Order Promising Lines", OrderPromisingLine);
                    end;
                }
                action("Demand Overview")
                {
                    Caption = 'Demand Overview';
                    Image = Forecast;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        DemandOverview: Page 5830;
                    begin
                        DemandOverview.SetCalculationParameter(TRUE);
                        DemandOverview.Initialize(0D, 1, Rec."No.", '', '');
                        DemandOverview.RUNMODAL;
                    end;
                }
                action("Pla&nning")
                {
                    Caption = 'Pla&nning';
                    Image = Planning;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        SalesPlanForm: Page 99000883;
                    begin
                        SalesPlanForm.SetSalesOrder(Rec."No.");
                        SalesPlanForm.RUNMODAL;
                    end;
                }
            }
            group(Request)
            {
                Caption = 'Request';
                Image = SendApprovalRequest;
                Visible = true;
                group(Authorize1)
                {
                    Caption = 'Authorize';
                    Image = AuthorizeCreditCard;
                    action(Authorize)
                    {
                        Caption = 'Authorize';
                        Image = AuthorizeCreditCard;
                        Visible = false;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            // Authorize;//tk
                        end;
                    }
                    action("Void A&uthorize")
                    {
                        Caption = 'Void A&uthorize';
                        Image = VoidCreditCard;
                        Visible = false;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            // Void;//tk
                        end;
                    }
                }
                separator(Separator7)
                {
                }
                action("Calc&ulate Structure Values")
                {
                    Caption = 'Calc&ulate Structure Values';
                    Image = CalculateHierarchy;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        // CALCFIELDS("Price Inclusive of Taxes");
                        // IF "Price Inclusive of Taxes" THEN BEGIN
                        //   SalesLine.InitStrOrdDetail(Rec);
                        //   SalesLine.GetSalesPriceExclusiveTaxes(Rec);
                        //   SalesLine.UpdateSalesLinesPIT(Rec);
                        // END;
                        // SalesLine.CalculateStructures(Rec);
                        // SalesLine.AdjustStructureAmounts(Rec);
                        // SalesLine.UpdateSalesLines(Rec);//tk
                    end;
                }
                action("Calculate TCS")
                {
                    Caption = 'Calculate TCS';
                    Image = CalculateCollectedTax;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        // SalesLine.CalculateStructures(Rec);
                        // SalesLine.AdjustStructureAmounts(Rec);
                        // SalesLine.UpdateSalesLines(Rec);
                        // SalesLine.CalculateTCS(Rec);
                    end;
                }
                action("Direct Debit To PLA / RG")
                {
                    Caption = 'Direct Debit To PLA / RG';
                    Image = Change;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        // SalesLine.CalculateStructures(Rec);
                        // SalesLine.AdjustStructureAmounts(Rec);
                        // SalesLine.UpdateSalesLines(Rec);
                        // OpenExciseCentvatClaimForm;
                    end;
                }
            }
            group(Warehouse1)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                action("Create Inventor&y Put-away / Pick")
                {
                    Caption = 'Create Inventor&y Put-away / Pick';
                    Ellipsis = true;
                    Image = CreateInventoryPickup;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.CreateInvtPutAwayPick;

                        IF NOT Rec.FIND('=><') THEN
                            Rec.INIT;
                    end;
                }
                action("Create &Whse. Shipment")
                {
                    Caption = 'Create &Whse. Shipment';
                    Image = NewShipment;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        GetSourceDocOutbound: Codeunit 5752;
                    begin
                        GetSourceDocOutbound.CreateFromSalesOrder(Rec);

                        IF NOT Rec.FIND('=><') THEN
                            Rec.INIT;
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(Post1)
                {
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        salessum: decimal;
                        SalesLine1: record "Sales Line";
                        EventCodeunit: codeunit 50057;
                        SL: RECORD "Sales Line";
                        GSTAmount: Decimal;
                    begin
                        /*
                            Clear(GSTAmount);
                            SL.RESET;
                            SL.SETRANGE(SL."Document No.", Rec."No.");
                            SL.SetFilter(SL."Unit Price Incl. of Tax", '<>%1', 0);
                            SL.SetFilter(SL."GST Group Code", '<>%1', '');
                            SL.SetRange(SL."Price Inclusive of Tax", true);
                            IF SL.FindSet() THEN BEGIN
                                REPEAT
                                    GSTAmount += EventCodeunit.GetGSTAmount(SL.RecordId);
                                UNTIL SL.Next() = 0;
                                Rec.CalcFields("Invoice Value");

                                IF ((18 * REC."Invoice Value") / 100) <> GSTAmount THEN
                                    ERROR('GST Amount is NOT Proper');
                            END;
                            */

                        Rec.TestField(Rec."Salesperson Code");

                        IF ServifyApprovalCode <> '' THEN BEGIN
                            Rec.TestField(Rec."Trade-in device IMEI no.");
                            Rec.TestField("Trade-in Device Model no.");
                            Rec.TestField("EasyOzy Bonus Amount");
                            Rec.TestField("Servify Purchase Amount");
                        END;

                        //win316++
                        CLEAR(Sales_order_no);
                        Sales_order_no := Rec."No.";
                        RecCust2.GET(Rec."Sell-to Customer No.");
                        IF Rec."Sales Order Type" = Rec."Sales Order Type"::Retail THEN BEGIN
                            /*
                          IF (RecCust2."Phone No."<>'') AND (STRLEN(RecCust2."Phone No.")=10) THEN
                          RecCreateTrnXml.Create_customer(RecCust2."No.");
                          *///WIN234 05082020
                            IF (RecCust2."Phone No." = '') OR (STRLEN(RecCust2."Phone No.") < 10) THEN BEGIN
                                ERROR('PLease update customers Mobile No.');
                            END;
                            IF (STRLEN(RecCust2."Phone No.") > 10) THEN
                                ERROR('PLease update customers Mobile No.');
                            /*
                            IF RecCust2."GST Customer Type"<> RecCust2."GST Customer Type"::Registered THEN //Win-234 02-07-2019 Caplliary Changes
                            IF "Get Customer"= FALSE THEN
                              ERROR('Please Click On GET Customer Points (Capillary) Button then proceed');
                            RecUserSetup.RESET;
                            RecUserSetup.SETRANGE(RecUserSetup."User ID",USERID);
                            IF RecUserSetup.FINDFIRST THEN;
                              RecLocation.SETRANGE(Code,RecUserSetup."Location Code");
                              IF RecLocation.FINDFIRST THEN BEGIN
                                RecLocation.TESTFIELD("Capillary ID");
                                RecLocation.TESTFIELD("Capillary Password");
                              END;
                              *///WIN234 05082020
                        END;


                        //++++++++++++++++++++++++++Win-234
                        /*
                        recCust1.RESET;
                        recCust1.SETRANGE("No.","Sell-to Customer No.");
                        recCust1.SETFILTER("GST Customer Type",'<>%1',recCust1."GST Customer Type"::Registered);//Win-234 02-07-2019 Capillary Changes
                        IF recCust1.FINDFIRST THEN;
                        recCust1.TESTFIELD("Phone No.");
                        RecCustCapill.RESET;
                        RecCustCapill.SETFILTER("Mobile No",'%1',('*'+recCust1."Phone No."));
                        RecCustCapill.SETRANGE("Sales Order No",Rec."No.");
                        IF RecCustCapill.FINDFIRST THEN BEGIN
                        IF RecCustCapill."Points To Be Redeem"<>0 THEN
                          RecCustCapill.TESTFIELD(RecCustCapill."Validation Code For Points");

                        IF (RecCustCapill."Validation Code For Points" <>'') AND (RecCustCapill."Point Posted"=FALSE) THEN
                           ERROR('Kindly post the points');
                         IF (RecCustCapill."Coupon Code" <>'') AND (RecCustCapill."Coupon posted"=FALSE) THEN
                            ERROR('Kindly post the coupon'); //win-234 14-03-2019
                        END;
                        *///WIN234 05082020
                          //Win-234--------------------------
                          //win316--
                        Rec."Credit Hold" := FALSE;
                        //"Discount Hold" := FALSE;
                        Rec."Credit Days Hold" := FALSE;
                        Rec."Overdue Hold" := FALSE;
                        Rec."Price Hold" := FALSE;
                        Rec."PDC Hold" := FALSE;
                        Rec."Group Credit Limit Hold" := FALSE;
                        Rec.CALCFIELDS("Total Shield Value");
                        // CALCFIELDS("Amount to Customer");//tk
                        Rec.CalcFields("Invoice Value");
                        SalesLine1.RESET;
                        SalesLine1.SETRANGE("Document Type", Rec."Document Type");
                        SalesLine1.SETFILTER("Document No.", '%1', Rec."No.");
                        IF SalesLine1.FINDFIRST THEN BEGIN
                            //REPEAT
                            SalesLine1.CalcSums(SalesLine1."Net Amount");
                            salessum := salesLine1."Net Amount";
                        end;
                        if Rec."Invoice Value" <> salessum then
                            error('Invoice Value not calculated');
                        IF NOT Rec.CreditSale THEN BEGIN
                            IF (Rec."Sales Order Type" = Rec."Sales Order Type"::Retail) AND (ABS(Rec."Amount To Customer UPIT" - (Rec.TotalPayByCustomer - Rec."Total Shield Value")) > 0.01) THEN;
                            //ERROR('Payments are not matching with the Invoice Value'); //Commented
                        END;

                        TotalPITDiffAmt := 0;
                        SalesLine.RESET;
                        SalesLine.SETRANGE("Document Type", Rec."Document Type");
                        SalesLine.SETFILTER("Document No.", '%1', Rec."No.");
                        IF SalesLine.FINDFIRST THEN BEGIN
                            REPEAT
                                SalesLine.TESTFIELD("Salesperson Code");
                                IF SalesLine.Shield AND (SalesLine."Shield Value" = 0) THEN
                                    ERROR('Shield Value should not be blank for Item %1', SalesLine."No.");
                                IF SalesLine.AMC AND (SalesLine."AMC Due Date" = 0D) THEN
                                    ERROR('AMC Due date should not be blank for Item %1', SalesLine."No.");
                            // IF Structure <> SalesLine."PIT Structure" THEN
                            //   ERROR('Sales Order Structure and  Sales Line PIT Structure are different for Item %1' , SalesLine."No.");
                            // IF (SalesLine.Type = SalesLine.Type::Item) AND (SalesLine."Product Group Code"='APP') THEN
                            //   BEGIN
                            //       SalesLine.TESTFIELD(SalesLine."Service Tax Group");
                            //   END;//tk

                            //TotalPITDiffAmt := TotalPITDiffAmt +
                            UNTIL SalesLine.NEXT = 0;
                        END;
                        /*
                        IF BuyBackType<>BuyBackType::" " THEN BEGIN
                          //CALCFIELDS("Maple Buyback Amt");
                          IF (BuyBackType = BuyBackType::Maple ) AND ("Maple Buyback Amt" = 0) THEN
                            ERROR('Maple Buyback Amt Should not be 0');
                          IF (BuyBackType = BuyBackType::Apple ) AND ("Maple Buyback Amt" = 0) THEN
                            ERROR('Apple Buyback Amt Should not be 0');

                          IF (BuyBackType = BuyBackType::Apple ) THEN BEGIN
                            TESTFIELD("Apple Refund Amt");
                            IF BuybackRefundDistributor = '' THEN
                              ERROR('Apple Refund Distributor must have a value on Purchase Details');
                          END;

                        END;
                        */
                        //WIN316++
                        // Codeunit_sale_post.Check_GST_Amount_Before_Posting(Rec);//tk

                        IF NOT GlobalRefereshDone THEN
                            Error('Please do Statictics first');

                        //WIN316--
                        Rec.CALCFIELDS("Invoice Value");
                        IF (Rec.TotalPayByCustomer = Rec."Invoice Value") or Rec.CreditSale then
                            Post(CODEUNIT::"Sales-Post (Yes/No)")
                        Else
                            Error('Please check the Invoice Values.Can not be Post Mismatch Amount');

                        //win316++
                        //RecCreateTranXML.Send_Transaction_Information_Sales(RecCust2."Phone No.",Sales_order_no);//WIN234 05082020
                        //win316--

                    end;
                }
                action("Post and &Print")
                {
                    Caption = 'Post and &Print';
                    Ellipsis = true;
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        salessum: Decimal;
                        SL: Record "Sales Line";
                    begin

                        SL.RESET;
                        SL.SETRANGE(SL."Document No.", Rec."No.");
                        SL.SetFilter(SL."Unit Price Incl. of Tax", '<>%1', 0);
                        SL.SetFilter(SL."GST Group Code", '<>%1', '');
                        SL.SetRange(SL."Price Inclusive of Tax", true);
                        IF SL.FindSet() THEN BEGIN
                            REPEAT
                                SL.Validate("Price Inclusive of Tax", true);
                                SL.MODIFY;
                            UNTIL SL.Next() = 0;
                            COMMIT;
                        END;
                        // //win316++//TO AVAOID POSTING TO OTHER BRANCH
                        // RecUserSetup.RESET;
                        // RecUserSetup.SETRANGE("User ID",USERID);
                        // IF  RecUserSetup.FINDFIRST THEN BEGIN
                        //   RecResCentNew.RESET;
                        //  // //tk RecResCentNew.SETRANGE(Code,RecUserSetup."Sales Resp. Ctr. Filter");
                        //   IF RecResCentNew.FINDFIRST THEN
                        //     //tk TESTFIELD("Shortcut Dimension 1 Code",RecResCentNew."Global Dimension 1 Code");
                        //   END;//tk
                        //win316--
                        //win316++
                        Rec.TestField(Rec."Salesperson Code");

                        IF ServifyApprovalCode <> '' THEN BEGIN
                            Rec.TestField(Rec."Trade-in device IMEI no.");
                            Rec.TestField("Trade-in Device Model no.");
                        END;

                        CLEAR(Sales_order_no);
                        Sales_order_no := Rec."No.";
                        RecCust2.GET(Rec."Sell-to Customer No.");
                        IF RecCust2."Not Interested Customer" = FALSE THEN BEGIN
                            IF Rec."GST Customer Type" <> RecCust2."GST Customer Type" THEN
                                ERROR('GST Customer Type must be as per Customer Master');//Win-234 09-07-2019

                            IF Rec."Sales Order Type" = Rec."Sales Order Type"::Retail THEN BEGIN
                                /*
                              IF (RecCust2."Phone No."<>'') AND (STRLEN(RecCust2."Phone No.")=10) THEN
                              RecCreateTrnXml.Create_customer(RecCust2."No.");
                              *///WIN234 05082020
                                IF (RecCust2."Phone No." = '') OR (STRLEN(RecCust2."Phone No.") < 10) THEN BEGIN
                                    ERROR('PLease update customers Mobile No.');
                                END;
                                IF (STRLEN(RecCust2."Phone No.") > 10) THEN
                                    ERROR('PLease update customers Mobile No.');
                            END;
                            /*
                            IF (RecCust2."GST Customer Type"<> RecCust2."GST Customer Type"::Registered) OR (RecCust2."GST Customer Type"<>RecCust2."GST Customer Type"::"Deemed Export")
                              OR(RecCust2."GST Customer Type"<>RecCust2."GST Customer Type"::Export) OR (RecCust2."GST Customer Type"<>RecCust2."GST Customer Type"::Exempted)THEN //Win-234 02-07-2019 Caplliary Changes

                            */
                            /*
                            IF (RecCust2."GST Customer Type"= RecCust2."GST Customer Type"::Unregistered) THEN
                            IF "Get Customer"= FALSE THEN
                              ERROR('Please Click On GET Customer Points (Capillary) Button then proceed');
                            RecUserSetup.RESET;
                            RecUserSetup.SETRANGE(RecUserSetup."User ID",USERID);
                            IF RecUserSetup.FINDFIRST THEN;
                              RecLocation.SETRANGE(Code,RecUserSetup."Location Code");
                              IF RecLocation.FINDFIRST THEN BEGIN
                                RecLocation.TESTFIELD("Capillary ID");
                                RecLocation.TESTFIELD("Capillary Password");
                              END;
                              *///WIN234 05082020
                        END;
                        //++++++++++++++++++++++++++Win-234
                        /*
                        recCust1.RESET;
                        recCust1.SETRANGE("No.","Sell-to Customer No.");
                        recCust1.SETFILTER("GST Customer Type",'%1',recCust1."GST Customer Type"::Unregistered);//Win-234 02-07-2019 Capillary Changes
                        IF recCust1.FINDFIRST THEN
                        recCust1.TESTFIELD("Phone No.");
                        RecCustCapill.RESET;
                        RecCustCapill.SETFILTER("Mobile No",'%1',('*'+recCust1."Phone No."));
                        RecCustCapill.SETRANGE("Sales Order No",Rec."No.");
                        IF RecCustCapill.FINDFIRST THEN BEGIN
                        IF RecCustCapill."Points To Be Redeem"<>0 THEN
                          RecCustCapill.TESTFIELD(RecCustCapill."Validation Code For Points");

                        IF (RecCustCapill."Validation Code For Points" <>'') AND (RecCustCapill."Point Posted"=FALSE) THEN
                           ERROR('Kindly post the points');
                         IF (RecCustCapill."Coupon Code" <>'') AND (RecCustCapill."Coupon posted"=FALSE) THEN
                            ERROR('Kindly post the coupon'); //win-234 14-03-2019
                        END;
                        *///WIN234 05082020
                          //Win-234--------------------------
                          //win316--
                        Rec."Credit Hold" := FALSE;
                        //"Discount Hold" := FALSE;
                        Rec."Credit Days Hold" := FALSE;
                        Rec."Overdue Hold" := FALSE;
                        Rec."Price Hold" := FALSE;
                        Rec."PDC Hold" := FALSE;
                        Rec.TESTFIELD("Discount Hold", FALSE);
                        Rec.CALCFIELDS("Total Shield Value");
                        // CALCFIELDS("Amount to Customer");//tk
                        IF NOT Rec.CreditSale THEN BEGIN
                            IF (Rec."Sales Order Type" = Rec."Sales Order Type"::Retail) AND (ABS(Rec."Amount To Customer UPIT" - (Rec.TotalPayByCustomer - Rec."Total Shield Value")) > 0.01) THEN;
                            //ERROR('Payments are not matching with the Invoice Value');//Commented
                        END;
                        SalesLine.RESET;
                        SalesLine.SETRANGE("Document Type", Rec."Document Type");
                        SalesLine.SETFILTER("Document No.", '%1', Rec."No.");
                        IF SalesLine.FINDFIRST THEN BEGIN
                            REPEAT
                                SalesLine.CalcSums(SalesLine."Net Amount");
                                salessum := salesLine."Net Amount";
                                SalesLine.TESTFIELD("Salesperson Code");//win-234 30-10-2019
                            //>>Commented
                            /*
                            
                                SalesLine.TESTFIELD("Salesperson Code");//win-234 30-10-2019
                                IF SalesLine.Shield AND (SalesLine."Shield Value" = 0) THEN
                                    ERROR('Shield Value should not be blank for Item %1', SalesLine."No.");
                                IF SalesLine.AMC AND (SalesLine."AMC Due Date" = 0D) THEN
                                    ERROR('AMC Due date should not be blank for Item %1', SalesLine."No.");
                                    */
                            //<<Commented
                            // IF Structure <> SalesLine."PIT Structure" THEN
                            //   ERROR('Sales Order Structure and  Sales Line PIT Structure are different for Item %1' , SalesLine."No.");
                            // IF (SalesLine.Type = SalesLine.Type::Item) AND (SalesLine."Product Group Code"='APP') AND ("Posting Date"<=063017D)  THEN
                            //   BEGIN
                            //       SalesLine.TESTFIELD(SalesLine."Service Tax Group");
                            //  END;//tk


                            UNTIL SalesLine.NEXT = 0;
                        END;
                        /*
                        IF BuyBackType<>BuyBackType::" " THEN BEGIN
                         // CALCFIELDS("Maple Buyback Amt");
                          IF (BuyBackType = BuyBackType::Maple ) AND ("Maple Buyback Amt" = 0) THEN
                            ERROR('Maple Buyback Amt Should not be 0');
                          IF (BuyBackType = BuyBackType::Apple ) AND ("Maple Buyback Amt" = 0) THEN
                            ERROR('Apple Buyback Amt Should not be 0');

                          IF (BuyBackType = BuyBackType::Apple ) THEN BEGIN
                            TESTFIELD("Apple Refund Amt");
                            IF BuybackRefundDistributor = '' THEN
                              ERROR('Apple Refund Distributor must have a value on Purchase Details');
                          END;


                        END;
                        */
                        //WIN316++
                        //tk// Codeunit_sale_post.Check_GST_Amount_Before_Posting(Rec);
                        //WIN316--
                        Rec.CALCFIELDS("Invoice Value");

                        if Rec."Invoice Value" <> salessum then
                            error('Invoice Value not calculated');
                        //NP
                        IF (ROUND(Rec.TotalPayByCustomer, 1, '=') = Round(Rec."Invoice Value", 1, '=')) or Rec.CreditSale then
                            Post(CODEUNIT::"Sales-Post + Print")
                        Else
                            Error('Please check the Invoice Values.Can not be Post Mismatch Amount');

                        IF (Rec."Sales Order Type" = Rec."Sales Order Type"::Retail) AND (Rec.Shield = TRUE) THEN BEGIN
                            shieldrec.RESET;
                            //shieldrec.SETFILTER(shieldrec."Document Type",'Order');
                            shieldrec.SETFILTER(shieldrec."Order No.", Rec."No.");
                            IF shieldrec.FINDFIRST THEN
                                shieldrec1.SETFILTER(shieldrec1."Ref. Invoice No.", shieldrec."No.");
                            IF shieldrec1.FINDFIRST THEN BEGIN
                                shieldrec1.SETFILTER(shieldrec1."No.", shieldrec1."No.");
                                //tk//REPORT.RUN(REPORT::"GST-Sales Shield Invoice_NSK",FALSE,FALSE,shieldrec1);    //KPPL-RAM-28-10-22
                                //REPORT.RUN(REPORT::"GST-Sales Invoice Final",FALSE,FALSE,shieldrec1);             //KPPL-RAM-28-10-22
                            END;
                        END;
                        //win316++
                        //RecCreateTranXML.Send_Transaction_Information_Sales(RecCust2."Phone No.",Sales_order_no);//WIN234 05082020
                        //win316--

                    end;
                }
                action("Test Report")
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        RecSalL.RESET;
                        RecSalL.SETRANGE("Document No.", Rec."No.");
                        RecSalL.SETFILTER("Shield Type", '%1|%2|%3', RecSalL."Shield Type"::"Shield Ex", RecSalL."Shield Type"::Shield, RecSalL."Shield Type"::"Shield Extended");
                        IF RecSalL.FINDFIRST THEN
                            ERROR('Kindly check the Shield Type,blocked shield type not allowed for posting');//Win-234 04-05-2019
                        ReportPrint.PrintSalesHeader(Rec);
                    end;
                }
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
                action("Remove From Job Queue")
                {
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.CancelBackgroundPosting;
                    end;
                }
                action(PreviewPosting)
                {
                    Caption = 'Preview Posting';
                    Image = ViewPostedOrder;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //WIN316++
                        //Codeunit_sale_post.Check_GST_Amount_Before_Posting(Rec);//tk
                        //WIN316--
                        ShowPreview;
                    end;
                }
                group("Prepa&yment")
                {
                    Caption = 'Prepa&yment';
                    Image = Prepayment;
                    Visible = false;
                    action("Prepayment &Test Report")
                    {
                        Caption = 'Prepayment &Test Report';
                        Ellipsis = true;
                        Image = PrepaymentSimulation;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            ReportPrint.PrintSalesHeaderPrepmt(Rec);
                        end;
                    }
                    action(PostPrepaymentInvoice)
                    {
                        Caption = 'Post Prepayment &Invoice';
                        Ellipsis = true;
                        Image = PrepaymentPost;
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            PurchaseHeader: Record 38;
                            SalesPostYNPrepmt: Codeunit 443;
                        begin
                            // IF ApprovalMgt.PrePostApprovalCheck(Rec,PurchaseHeader) THEN
                            //   SalesPostYNPrepmt.PostPrepmtInvoiceYN(Rec,FALSE);
                        end;
                    }
                    action("Post and Print Prepmt. Invoic&e")
                    {
                        Caption = 'Post and Print Prepmt. Invoic&e';
                        Ellipsis = true;
                        Image = PrepaymentPostPrint;
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            PurchaseHeader: Record 38;
                            SalesPostYNPrepmt: Codeunit 443;
                        begin
                            // IF ApprovalMgt.PrePostApprovalCheck(Rec,PurchaseHeader) THEN
                            //   SalesPostYNPrepmt.PostPrepmtInvoiceYN(Rec,TRUE);
                        end;
                    }
                    action(PostPrepaymentCreditMemo)
                    {
                        Caption = 'Post Prepayment &Credit Memo';
                        Ellipsis = true;
                        Image = PrepaymentPost;
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            PurchaseHeader: Record 38;
                            SalesPostYNPrepmt: Codeunit 443;
                        begin
                            // IF ApprovalMgt.PrePostApprovalCheck(Rec,PurchaseHeader) THEN
                            //   SalesPostYNPrepmt.PostPrepmtCrMemoYN(Rec,FALSE);
                        end;
                    }
                    action("Post and Print Prepmt. Cr. Mem&o")
                    {
                        Caption = 'Post and Print Prepmt. Cr. Mem&o';
                        Ellipsis = true;
                        Image = PrepaymentPostPrint;
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            PurchaseHeader: Record 38;
                            SalesPostYNPrepmt: Codeunit 443;
                        begin
                            // IF ApprovalMgt.PrePostApprovalCheck(Rec,PurchaseHeader) THEN
                            //   SalesPostYNPrepmt.PostPrepmtCrMemoYN(Rec,TRUE);
                        end;
                    }
                }
            }
            group("&Print")
            {
                Caption = '&Print';
                Image = Print;
                Visible = false;
                action("Order Confirmation")
                {
                    Caption = 'Order Confirmation';
                    Ellipsis = true;
                    Image = Print;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        DocPrint.PrintSalesOrder(Rec, Usage::"Order Confirmation");
                    end;
                }
                action("Work Order")
                {
                    Caption = 'Work Order';
                    Ellipsis = true;
                    Image = Print;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        DocPrint.PrintSalesOrder(Rec, Usage::"Work Order");
                    end;
                }
                action("Pick Instruction")
                {
                    Caption = 'Pick Instruction';
                    Image = Print;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        DocPrint.PrintSalesOrder(Rec, Usage::"Pick Instruction");
                    end;
                }
            }
            group(Capillery)
            {
                Caption = 'Capillery';
                Visible = false;
                action("GET Customer Points (Capillary)")
                {
                    Promoted = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF Reccustt.GET(Rec."Sell-to Customer No.") THEN
                            IF Reccustt."GST Customer Type" <> Reccustt."GST Customer Type"::Unregistered THEN
                                ERROR('Not allowed for registered customer');//win-234 02-07-2019
                        //WIN316++
                        IF Rec."Sales Order Type" <> Rec."Sales Order Type"::Retail THEN
                            ERROR('You Can use this only for Sales Order Type Retail');

                        Rec.TESTFIELD("Location Code");
                        RecLocation.RESET;
                        RecLocation.SETRANGE(Code, Rec."Location Code");
                        IF RecLocation.FINDFIRST THEN BEGIN
                            RecLocation.TESTFIELD("Capillary ID");
                            RecLocation.TESTFIELD("Capillary Password");
                        END;
                        /*
                        DLL:=DLL.Class1;
                        IF NOT DLL.CheckInterNet('http://www.google.com') THEN BEGIN
                          MESSAGE('Internet is Not Working');
                          EXIT;
                          END;
                          */
                        recCust1.RESET;
                        recCust1.SETRANGE("No.", Rec."Sell-to Customer No.");
                        recCust1.SETRANGE("Not Interested Customer", FALSE);
                        IF recCust1.FINDFIRST THEN BEGIN
                            recCust1.TESTFIELD("Phone No.");
                            FilePath := 'C:\Navision\Dont Delete (Capilery Integration)\Customer_Details\' + Rec."Sell-to Customer Name" + Rec."Location Code" + '.xml';
                            // RecCreateTranXML.Create_Blank_XML(FilePath);//tk
                            //tk
                            // DLL:=DLL.Class1;
                            // DLL.CallWebApi('https://apac2.api.capillarytech.com/v1.1/customer/get?format=xml&mobile='+recCust1."Phone No.",'GET','',RecLocation."Capillary ID",RecLocation."Capillary Password",FilePath);
                            //RecXML.GetCustomerDataFromCapillary(FilePath,Rec."No.");//tk
                        END;
                        Rec."Get Customer" := TRUE;
                        //Win-234++
                        Rec.MODIFY;
                        CurrPage.UPDATE;
                        //Win-234-- 30-05-2019
                        //WIN316--

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
                        /*
                        DLL:=DLL.Class1;
                        IF NOT DLL.CheckInterNet('http://www.google.com') THEN BEGIN
                          MESSAGE('Internet is Not Working');
                          EXIT;
                          END;
                        */
                        IF Reccustt.GET(Rec."Sell-to Customer No.") THEN
                            IF Reccustt."GST Customer Type" <> Reccustt."GST Customer Type"::Unregistered THEN
                                ERROR('Not allowed for registered customer');//win-234 02-07-2019
                        IF Rec."Get Customer" = FALSE THEN
                            ERROR('Please Click On GET Customer Points (Capillary) Button then proceed');

                        recCust1.RESET;
                        recCust1.SETRANGE("No.", Rec."Sell-to Customer No.");
                        IF recCust1.FINDFIRST THEN;
                        recCust1.TESTFIELD("Phone No.");
                        RecCustCapill.RESET;
                        RecCustCapill.SETFILTER("Mobile No", '%1', ('*' + recCust1."Phone No."));
                        RecCustCapill.SETRANGE("Sales Order No", Rec."No.");//tk
                        IF RecCustCapill.FINDFIRST THEN BEGIN
                            IF PAGE.RUNMODAL(50099, RecCustCapill) = ACTION::LookupOK THEN BEGIN
                                IF (RecCustCapill."Coupon posted" = FALSE) AND (RecCustCapill."Point Posted" = FALSE) THEN
                                    EXIT;
                                IF Rec."Capillary Discount Amount" <> 0 THEN
                                    EXIT;
                                CLEAR(Rec."Capillary Discount Amount");
                                Rec."Capillary Discount Amount" := RecCustCapill."Point Redeem Value In Rs." + RecCustCapill."Coupon Value In Rs.";
                                RecSL.RESET;
                                RecSL.SETRANGE(RecSL."Document No.", Rec."No.");
                                IF RecSL.FINDFIRST THEN BEGIN
                                    REPEAT
                                        RecSL.VALIDATE("Capillary Line Discount Amount", (RecSL.Amount / (RecCustCapill."Amount Payable Before Discount" / Rec."Capillary Discount Amount")));
                                        RecSL.MODIFY;
                                    UNTIL RecSL.NEXT = 0;
                                    TEST_STAT;
                                END;
                            END
                        END
                        ELSE BEGIN
                            MESSAGE('Customer Data is not available in Capillary');
                            CLEAR(Rec."Capillary Discount Amount");
                        END;
                        //WIN316--

                    end;
                }
            }
        }
    }


    trigger OnAfterGetCurrRecord()
    begin
        DynamicEditable := CurrPage.EDITABLE;
    end;

    trigger OnAfterGetRecord()
    var
        SalesOrderExtension: Record 50026;
    begin
        SetControlVisibility;
        // IF "Re-Dispatch" THEN
        //   ReturnOrderNoVisible := TRUE
        // ELSE
        //   ReturnOrderNoVisible := FALSE;//tk
        Rec."Customer Name" := Rec."Sell-to Customer Name";
        IF Rec.BuyBackType = Rec.BuyBackType::Maple THEN BEGIN
            MapleEnable := True;
            AppleEnable := FALSE;
            PurchaseAmount := Rec."Maple Buyback Amt";
            PurchInvoiceIIIEditable := TRUE;
        END;
        IF Rec.BuyBackType = Rec.BuyBackType::Apple THEN BEGIN
            MapleEnable := FALSE;
            AppleEnable := True;
            PurchaseAmount := Rec."Apple Buyback Amt";
            PurchInvoiceIIIEditable := TRUE;
        END;
        IF Rec.BuyBackType = Rec.BuyBackType::" " THEN BEGIN
            MapleEnable := FALSE;
            AppleEnable := FALSE;
            PurchaseAmount := 0;
            PurchInvoiceIIIEditable := FALSE;
        END;
        Rec."Shipment Date" := WORKDATE;
        //IF CurrPage.PurchLines.PAGE.SalesOrderNo.Value = '' then
        //  CurrPage.PurchLines.PAGE.SetSalesFilter(Rec);
        //CurrPage.PurchLines.PAGE.SalesOrderNo := "No.";

        //CurrPage.PurchLines.PAGE."Retail Buyback Ref. No." := "No.";
        //CurrPage.UPDATE;
        TotalwithShield := Rec."Amount To Customer UPIT" + Rec."Total Shield Value";

        SetCRTCoupon; //KPPLDG00016

        //KPPLDG00023
        SalesOrderExtension.RESET;
        IF SalesOrderExtension.GET(Rec."Document Type", Rec."No.") THEN BEGIN
            ServifyApprovalCode := SalesOrderExtension."Servify Approval Code";
            ServifyTransferAmount := SalesOrderExtension."Servify Transfer Amount";
            PaytmApprovalCode := SalesOrderExtension."Paytm Approval Code"; //KPPLDG00033
            PaytmTransferAmount := SalesOrderExtension."Paytm Transfer Amount"; //KPPLDG00033
        END;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD;
        EXIT(Rec.ConfirmDeletion);
    end;

    trigger OnInit()
    begin
        ReturnOrderNoVisible := TRUE;
        CustMobileVisible := FALSE;  //Win127
        CustEmailVisible := FALSE;  //Win127
        GLSetup.GET;
        PurchInvoiceIIIEditable := GLSetup."Purchase Invoice IIIrd Party";
        SalesInvoiceIIIEditable := GLSetup."Sales Invoice IIIrd Party";

        SalesSetup.GET;
        DiscountHoldEnable := SalesSetup."Discount Hold Active";
        CreditHoldEnable := SalesSetup."Credit Limit Hold Active";
        OvedueHoldEnable := SalesSetup."Overdue Hold Active";
        CreditDaysHoldEnable := SalesSetup."Credit Days Hold Active";
        PriceHoldActiveEnable := SalesSetup."Price Hold Active";
        PDCHoldActiveEnable := SalesSetup."PDC Hold Active";
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.CheckCreditMaxBeforeInsert;
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
        // "Responsibility Center New 1" := UserMgt.GetSalesFilter;//tk
        Rec."Sales Order Type" := Rec."Sales Order Type"::Retail;
    end;

    trigger OnOpenPage()
    var
        RecSL: Record "Sales Line";
        UserSetup: Record 91;
    begin
        GlobalRefereshDone := false;
        // // Clear(AmountTotal);
        // RecSL.Reset();
        // RecSL.SetRange("Document No.", Rec."No.");
        // if RecSL.FindFirst() then begin
        //     AmountTotal += RecSL."Unit Price Incl. of Tax";
        // end;
        // IF UserMgt.GetSalesFilter <> '' THEN BEGIN
        //     FILTERGROUP(2);
        //     SETRANGE("Responsibility Center New 1",UserMgt.GetSalesFilter);//tk
        //     FILTERGROUP(0);
        // END;
        UserSetup.GET(USERID);
        IF UserSetup."Location Code" <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Responsibility Center", UserSetup."Sales Resp. Ctr. Filter");
            Rec.FILTERGROUP(0);
        END;
        Rec.SETRANGE("Date Filter", 0D, WORKDATE - 1);
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
        Text000: Label 'Unable to execute this function while in view only mode.';
        CopySalesDoc: Report 292;
        InvoiceValue: Decimal;
        MoveNegSalesLines: Report 6699;
        ApprovalMgt: Codeunit 439;
        ReportPrint: Codeunit 228;
        DocPrint: Codeunit 229;
        ArchiveManagement: Codeunit 5063;
        SalesSetup: Record 311;
        ChangeExchangeRate: Page 511;
        ServifyBonusAmount: Decimal;
        UserMgt: Codeunit 5700;
        Usage: Option "Order Confirmation","Work Order","Pick Instruction";
        SalesLine: Record 37;
        Text16500: Label 'You can not uncheck Re-Dispatch until Return Receipt No. is Blank.';
        Text16501: Label 'To calculate invoice discount, check Cal. Inv. Discount on header when Price Inclusive of Tax = Yes.\This option cannot be used to calculate invoice discount when Price Inclusive Tax = Yes.';

        ReturnOrderNoVisible: Boolean;


        JobQueueVisible: Boolean;
        Text001: Label 'Do you want to change %1 in all related records in the warehouse?';
        Text002: Label 'The update has been interrupted to respect the warning.';
        DynamicEditable: Boolean;
        CustMobileVisible: Boolean;
        CustEmailVisible: Boolean;

        CustomerMobile: Text[30];

        CUstomerEmail: Text[180];
        SInvLine: Record 113;
        SInvHeader: Record 112;


        PurchInvoiceIIIEditable: Boolean;

        SalesInvoiceIIIEditable: Boolean;
        GLSetup: Record 98;
        MapleEnable: Boolean;
        AppleEnable: Boolean;
        PurchaseAmount: Decimal;
        CreditHoldEnable: Boolean;
        OvedueHoldEnable: Boolean;
        CreditDaysHoldEnable: Boolean;
        DiscountHoldEnable: Boolean;
        PriceHoldActiveEnable: Boolean;
        PDCHoldActiveEnable: Boolean;
        CustomerR: Record 18;
        CustomerLocal: Record 18;
        shieldrec: Record 112;
        shieldrec1: Record 112;
        TotalPITDiffAmt: Decimal;
        TotalwithShield: Decimal;
        varPostingdate: Date;
        AmountTotal: Decimal;
        RecCustCapill: Record 50011;
        // DLL: DotNet Class1;

        RecSL: Record 37;

        Sales_order_no: Code[20];
        RecCust2: Record 18;
        FilePath: Text;
        RecLocation: Record 14;
        recCust1: Record 18;
        RecUserSetup: Record 91;
        RecResCentNew: Record 50000;

        Codeunit_sale_post: Codeunit 80;
        RecSalL: Record 37;
        Reccustt: Record 18;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CRTCouponCode: Code[20];
        CRTCouponCodeOLD: Code[20];
        ServifyApprovalCode: Code[12];
        ServifyTransferAmount: Decimal;
        ScanBarcode: Text;
        SerialNo: Text;
        ItemNo: Text;
        TempString: Text;

        PaytmApprovalCode: Code[10];
        PaytmTransferAmount: Decimal;
        WBU: Codeunit 50000;
        RecXML: Codeunit 50008;
        POIntegration: Codeunit 50017;
        RecCreateTranXML: Codeunit 50012;
        RecCreateTrnXml: Codeunit 50012;//tk
        GlobalRefereshDone: boolean;
        DataInsert: Boolean;     // MAPPLE 1.0 Bundle Item <<<

    local procedure Post(PostingCodeunitID: Integer)
    begin
        Rec.SendToPosting(PostingCodeunitID);
        IF Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting" THEN
            CurrPage.CLOSE;
        CurrPage.UPDATE(FALSE);
    end;


    procedure UpdateAllowed(): Boolean
    begin
        IF CurrPage.EDITABLE = FALSE THEN
            ERROR(Text000);
        EXIT(TRUE);
    end;

    local procedure ApproveCalcInvDisc()
    begin
        // CurrPage.SalesLines.PAGE.ApproveCalcInvDisc;
    end;

    local procedure SelltoCustomerNoOnAfterValidat()
    begin
        IF Rec.GETFILTER("Sell-to Customer No.") = xRec."Sell-to Customer No." THEN
            IF Rec."Sell-to Customer No." <> xRec."Sell-to Customer No." THEN
                Rec.SETRANGE("Sell-to Customer No.");
        CurrPage.UPDATE;
    end;

    local procedure SalespersonCodeOnAfterValidate()
    begin
        // CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure BilltoCustomerNoOnAfterValidat()
    begin
        CurrPage.UPDATE;
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.UPDATE;
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.UPDATE;
    end;

    local procedure PricesIncludingVATOnAfterValid()
    begin
        CurrPage.UPDATE;
    end;

    local procedure Prepayment37OnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure ReDispatchOnPush()
    begin
        // IF "Re-Dispatch" THEN
        //     // CurrPage.SalesLines.PAGE.MakeVisibleLineControl//tk
        // ELSE
        //     // CurrPage.SalesLines.PAGE.MakeInvisibleLineControl;//tk
    end;

    local procedure TEST_STAT()
    begin
        // SalesSetup.GET;
        // CALCFIELDS("Price Inclusive of Taxes");
        // IF SalesSetup."Calc. Inv. Discount" AND (NOT "Price Inclusive of Taxes") THEN BEGIN
        //     CalcInvDiscForHeader;
        //     COMMIT
        // END;
        // IF "Price Inclusive of Taxes" THEN BEGIN
        //     SalesLine.InitStrOrdDetail(Rec);
        //     SalesLine.GetSalesPriceExclusiveTaxes(Rec);
        //     SalesLine.UpdateSalesLinesPIT(Rec);
        //     COMMIT;
        // END;

        // IF Structure <> '' THEN BEGIN
        //     SalesLine.CalculateStructures(Rec);
        //     SalesLine.AdjustStructureAmounts(Rec);
        //     SalesLine.UpdateSalesLines(Rec);
        //     SalesLine.CalculateTCS(Rec);
        // END ELSE
        //     SalesLine.CalculateTCS(Rec);//tk
    end;

    local procedure ShowPreview()
    var
        SalesPostYesNo: Codeunit 81;
    begin
        SalesPostYesNo.Preview(Rec);
    end;

    local procedure SetControlVisibility()
    var
        ApprovalsMgmt: Codeunit 1535;
    begin


        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);
    end;

    local procedure ValidateCRTCoupon()
    var
        CRTCoupons: Record 50025;
        LocSalesLine: Record 37;
    begin
        //KPPLDG00016
        LocSalesLine.RESET;
        LocSalesLine.SETRANGE(LocSalesLine."Document Type", Rec."Document Type");
        LocSalesLine.SETRANGE(LocSalesLine."Document No.", Rec."No.");
        LocSalesLine.SETRANGE(LocSalesLine.Type, LocSalesLine.Type::Item);
        IF NOT LocSalesLine.FINDFIRST THEN
            ERROR('You can not enter coupon, because there is no item line in the Order.');

        SalesSetup.GET;

        IF CRTCouponCode <> '' THEN
            CRTCouponCodeOLD := CRTCouponCode;

        CRTCoupons.RESET;
        IF CRTCoupons.GET(CRTCouponCodeOLD) THEN BEGIN
            LocSalesLine.RESET;
            LocSalesLine.SETRANGE(LocSalesLine."Document Type", Rec."Document Type");
            LocSalesLine.SETRANGE(LocSalesLine."Document No.", Rec."No.");
            LocSalesLine.SETRANGE(LocSalesLine.Type, LocSalesLine.Type::Item);
            LocSalesLine.SETRANGE(LocSalesLine."No.", CRTCoupons."Item No.");
            IF LocSalesLine.FINDFIRST THEN BEGIN
                IF CRTCouponCode <> '' THEN
                    LocSalesLine.VALIDATE("Line Discount %", SalesSetup."CRT Coupon Discount %")
                ELSE
                    LocSalesLine.VALIDATE("Line Discount %", 0);

                LocSalesLine."CRT Coupon Code" := CRTCouponCode;
                LocSalesLine.MODIFY;
            END
            ELSE
                ERROR('Inavlid Coupon!. Coupon details does not belongs to the Sales item.');
        END
        ELSE
            ERROR('Invalid Coupon!. Coupon does not found in the system.');

        CRTCouponCodeOLD := CRTCouponCode;
        CurrPage.UPDATE;
    end;

    local procedure SetCRTCoupon()
    var
        CRTCoupons: Record 50025;
        LocSalesLine: Record 37;
    begin
        //KPPLDG00016
        LocSalesLine.RESET;
        LocSalesLine.SETRANGE(LocSalesLine."Document Type", Rec."Document Type");
        LocSalesLine.SETRANGE(LocSalesLine."Document No.", Rec."No.");
        LocSalesLine.SETRANGE(LocSalesLine.Type, LocSalesLine.Type::Item);
        IF LocSalesLine.FINDLAST THEN
            CRTCouponCode := LocSalesLine."CRT Coupon Code";
    end;
    // MAPPLE 1.0 Bundle Item >>>
    local procedure InsetBundleLineItem(BundleCode: Code[20]; DocumentNo: Code[20]; DocumentType: Enum "Sales Document Type")
    var
        BundleItemLine: Record "Bundle Item Line";
        InsSalesLine: Record "Sales Line";

    begin
        DataInsert := false;
        BundleItemLine.Reset();
        BundleItemLine.SetRange("Bundle Code", BundleCode);
        if BundleItemLine.FindSet() then
            repeat
                InsSalesLine.Init();
                InsSalesLine."Document Type" := DocumentType;
                InsSalesLine."Document No." := DocumentNo;
                InsSalesLine."Line No." := MaxSalesLine(DocumentNo, DocumentType);
                InsSalesLine.Type := InsSalesLine.Type::Item;
                InsSalesLine.Validate("No.", BundleItemLine."Item No.");
                InsSalesLine.Validate("Variant Code", BundleItemLine."Variant Code");
                InsSalesLine.Validate(Quantity, BundleItemLine."Minimum Quantity");
                InsSalesLine.Validate("Unit Price", BundleItemLine."Unit Price");
                //InsSalesLine.Validate("Line Discount %", BundleItemLine."Line Discount");//RY
                //InsSalesLine.Validate("Line Amount", BundleItemLine."Line Discount Amount");//RY
                InsSalesLine."Bundle Code" := BundleItemLine."Bundle Code";
                InsSalesLine."Entry No" := BundleItemLine."Discount Entry No.";
                InsSalesLine."Discount Type" := BundleItemLine."Discount Type";
                /*  if Discounting.Get(BundleItemLine."Discount Entry No.", BundleItemLine."Discount Type") then
                     InsSalesLine."Line Discount %" := BundleItemLine."Line Discount";//RY */
                InsSalesLine."Line Discount Amount" := BundleItemLine."Line Discount Amount";//RY
                InsSalesLine."Bundle Discount Amount" := BundleItemLine."Line Discount Amount";//RY
                InsSalesLine.Insert(true);
                DataInsert := true;
            until
            BundleItemLine.Next() = 0;


    end;

    local procedure MaxSalesLine(DocumentNo: Code[20]; DocumentType: Enum "Sales Document Type"): Integer
    var
        MaxSalesLine: Record "Sales Line";
    begin
        MaxSalesLine.Reset();
        MaxSalesLine.SetRange("Document Type", DocumentType);
        MaxSalesLine.SetRange("Document No.", DocumentNo);
        if MaxSalesLine.FindLast() then
            exit(MaxSalesLine."Line No." + 10000)
        else
            exit(10000);
    end;
    // MAPPLE 1.0 Bundle Item <<<

    local procedure GetAuth(P_Date: Text; P_Hmac: Text; New: Boolean)
    var
        HttpContent: HttpContent;
        HttpHeaders: HttpHeaders;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        HttpClient: HttpClient;
        JAccessToken: JsonObject;
        ResponseText: Text;
        IsSuccess: Boolean;
        AccessToken: Text;
        json: Text;
        jObject: JsonObject;
        L_Data: Text;
    begin
        //HttpContent.WriteFrom('{"$data":"cwGouzCALNmyrmIwi5zlqUbahb15XPfzwk9Z8gNJjix6MVpd3SY4IIp299W5e9X7oYx9whh1IUPrdNdv+qQvZQrOwCW10GR6RS20qhBn3bhrzJ55D99LQFpAJ+DNz2RsMWmuWgk8gRT2uWbJCOfN4ugMpdblPNbVQeBONR883WMfziwC4vLXFQSb0zDcsdUB+gyzW/5YYAS/H13jd/0Seo72V2Os2FdY+FpLzDfpqtgw121t4Cx8xQS7xYBzNHOEzABATjs50atA7HtRNHRrbIpiMRBCxJ2nCqxa2aFuJhKTrh8tDDUVZo5uL3akjcC4jAmVTcTp/3pG3XxWWxwyFA=="}');
        HttpContent.WriteFrom('{"$data":"RL4LdZ3LQvdQ5lewEw3DRtbYjaUwZog/RUdj8EpRPXMJicgSrOhocLaxd/3FWwm+eO+YTkZuSheiAL5b271uF79j5ymmDZZJiniKmezCVoML/7aSjTw8owfhQD2Kt91q+bg/Pc1W6WNHVuFruGIqBdH56WKfGkEERZcCqFCkHgNVc0YrJ6UVmk8GnAaXTjXWEdH1/hzPv6Sd1Lno5M204MNaCFh6+gEZSyP8fbb4KicEFSmNWuwXdiF97aIYjD7dZNZ3AxBMu9aXHupEJPR5KaKAe+G3rlkMMxfEg6kqcwgMSqj3RCTwwLhso67TTkHUVgGM8Tzez1FJn13rNMmpJQ=="}');

        HttpContent.GetHeaders(HttpHeaders);
        HttpHeaders.Remove('Content-Type');
        HttpHeaders.Add('Content-Type', 'application/json');
        HttpHeaders.Add('x-host', 'maple.com');
        HttpHeaders.Add('x-date', P_Date);
        HttpHeaders.Add('client-id', 'MAPLE');
        HttpHeaders.Add('hmac-signature', P_Hmac);
        HttpRequestMessage.Method := 'POST';
        //HttpRequestMessage.SetRequestUri('https://clientstag.servify.tech/Auth/generateToken');
        HttpRequestMessage.SetRequestUri('https://api.servify.in/Auth/generateToken');
        HttpRequestMessage.Content(HttpContent);
        if HttpClient.Send(HttpRequestMessage, HttpResponseMessage) then
            if HttpResponseMessage.IsSuccessStatusCode() then begin
                if HttpResponseMessage.Content.ReadAs(ResponseText) then
                    IsSuccess := JAccessToken.ReadFrom(ResponseText);
                if IsSuccess then begin
                    jObject.ReadFrom(ResponseText);
                    Clear(L_Data);
                    if jObject.Contains('$data') then begin
                        if GetJsonvalue(jObject, '$data').IsNull = false then begin
                            L_Data := GetJsonvalue(jObject, '$data').AsText();
                            //Message(L_Data);//RY
                        end;
                    end;
                    DecryptText(L_Data);
                end;

            end
            else begin

                HttpResponseMessage.Content.ReadAs(ResponseText);
                //Message(ResponseText);
            end;

    END;

    local procedure GetAuth(P_Date: Text; P_Hmac: Text)
    var
        L_Headers: HttpHeaders;
        L_Client: HttpClient;
        L_Content: HttpContent;
        L_ResponseMessage: HttpResponseMessage;
        ResponseText: Text;
        APIPath: Text;
        SalesRec: Record "Sales & Receivables Setup";
        jObject: JsonObject;
        L_Data: Text;
        L_body: Text;
        HttpClient: HttpClient;
        HttpsContent: HttpContent;
        RequestHeader: HttpHeaders;
        json: Text;
        HttpResponse: HttpResponseMessage;
    begin
        SalesRec.Get();

        Clear(L_client);
        Clear(L_content);
        Clear(L_headers);
        Clear(ResponseText);
        Clear(L_responseMessage);
        Clear(APIPath);
        L_headers := L_Client.DefaultRequestHeaders();

        L_Headers.Add('x-host', 'maple.com');//SalesRec.Host);
        L_Headers.Add('x-date', P_Date);
        L_Headers.Add('client-id', 'MAPLE');//UpperCase(SalesRec.ClientId));//maple
        L_Headers.Add('hmac-signature', P_Hmac);
        L_content.GetHeaders(L_headers);
        L_headers.Remove('Content-Type');
        L_headers.Add('Content-Type', 'application/json');


        L_body := '{"$data":"cwGouzCALNmyrmIwi5zlqUbahb15XPfzwk9Z8gNJjix6MVpd3SY4IIp299W5e9X7oYx9whh1IUPrdNdv+qQvZQrOwCW10GR6RS20qhBn3bhrzJ55D99LQFpAJ+DNz2RsMWmuWgk8gRT2uWbJCOfN4ugMpdblPNbVQeBONR883WMfziwC4vLXFQSb0zDcsdUB+gyzW/5YYAS/H13jd/0Seo72V2Os2FdY+FpLzDfpqtgw121t4Cx8xQS7xYBzNHOEzABATjs50atA7HtRNHRrbIpiMRBCxJ2nCqxa2aFuJhKTrh8tDDUVZo5uL3akjcC4jAmVTcTp/3pG3XxWWxwyFA=="}';
        L_Content.WriteFrom(L_body);



        //APIPath := 'https://clientstag.servify.tech/Auth/generateToken';
        APIPath := SalesRec."Auth Token URL";
        L_client.SetBaseAddress(APIPath);
        if L_client.Post(APIPath, L_content, L_responseMessage) then begin

            if L_responseMessage.HttpStatusCode = 200 then begin

                L_responseMessage.Content.ReadAs(ResponseText);
                jObject.ReadFrom(ResponseText);
                Clear(L_Data);
                if jObject.Contains('$data') then begin
                    if GetJsonvalue(jObject, '$data').IsNull = false then begin
                        L_Data := GetJsonvalue(jObject, '$data').AsText();
                    end;
                end;
                DecryptText(L_Data);

            end;
        end;

    end;

    local procedure DecryptText(P_ResponseText: Text)
    var
        L_Headers: HttpHeaders;
        L_Client: HttpClient;
        L_Content: HttpContent;
        L_ResponseMessage: HttpResponseMessage;
        ResponseText: Text;
        APIPath: Text;
        SalesRec: Record "Sales & Receivables Setup";
        jObject: JsonObject;
        L_Text: Text;
        L_Text2: Text;
        L_Text3: Text;
        L_Token: Text;
        StringText: Text;
        StringText2: Text;
        StringText3: Text;
        Len: Integer;
    begin
        SalesRec.Get();
        Clear(L_Headers);
        Clear(L_Content);
        Clear(L_Client);
        Clear(L_ResponseMessage);
        Clear(ResponseText);
        L_Headers := L_Client.DefaultRequestHeaders;
        L_Headers.Add('Accept', 'application/json');
        L_Content.GetHeaders(L_Headers);

        Clear(L_Text);
        Clear(L_Text2);
        Clear(L_Text3);
        L_Text := P_ResponseText.Replace('/', '%2F');
        L_Text2 := L_Text.Replace('+', '%2B');
        L_Text3 := L_Text2.Replace('=', '%3D');
        //Message(P_ResponseText);
        //Message(L_Text3);

        Clear(APIPath);
        //APIPath := 'https://mapleapi.azurewebsites.net/api/EncryptDecrpt?encryData=' + L_Text3;
        APIPath := SalesRec."Decrypt API URL" + '?encryData=' + L_Text3;
        if L_Client.Get(APIPath, L_ResponseMessage) then begin
            if L_ResponseMessage.HttpStatusCode = 200 then begin
                if (L_ResponseMessage.IsSuccessStatusCode = true) then begin
                    L_ResponseMessage.Content().ReadAs(ResponseText);
                    //Message(ResponseText);//RY
                    Clear(jObject);
                    jObject.ReadFrom(ResponseText);
                    Clear(L_Token);
                    if jObject.Contains('cipherText') then begin
                        if GetJsonvalue(jObject, 'cipherText').IsNull = false then begin
                            L_Token := GetJsonvalue(jObject, 'cipherText').AsText();
                            Clear(StringText);
                            StringText := CopyStr(L_Token, 59, 5);
                            if StringText = 'token' then begin
                                Clear(StringText2);
                                StringText2 := CopyStr(L_Token, 59);
                                Clear(Len);
                                Len := StrPos(StringText2, ',');
                                Clear(StringText3);
                                StringText3 := CopyStr(StringText2, 9, Len - 10);
                                getTradeInExchangeDetails(StringText3, SalesRec.ClientId, hmac, myDate, SalesRec.Host);

                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;

    local procedure getTradeInExchangeDetails(clientsessionid: Text; clientid: Text; hmacsignature: Text; xdate: Text; xhost: Text)
    var
        L_Headers: HttpHeaders;
        L_Client: HttpClient;
        L_Content: HttpContent;
        L_ResponseMessage: HttpResponseMessage;
        ResponseText: Text;
        APIPath: Text;
        L_body: Text;
        SalesRec: Record "Sales & Receivables Setup";
        L_EncryptText: Text;
        L_Text: Text;
        L_Text2: Text;
        L_Text3: Text;
        L_Data: Text;
        JObject: JsonObject;
    begin
        SalesRec.Get();
        Clear(L_client);
        Clear(L_content);
        Clear(L_headers);
        Clear(ResponseText);
        Clear(L_responseMessage);
        Clear(APIPath);
        L_headers := L_Client.DefaultRequestHeaders();
        L_Headers.Add('client-session-id', clientsessionid);
        L_Headers.Add('client-id', clientid);
        L_Headers.Add('hmac-signature', hmacsignature);
        L_Headers.Add('x-date', xdate);
        L_Headers.Add('x-host', xhost);
        Clear(L_body);
        Clear(L_EncryptText);
        //L_body := '{"$data":"cwGouzCALNmyrmIwi5zlqUbahb15XPfzwk9Z8gNJjix6MVpd3SY4IIp299W5e9X7oYx9whh1IUPrdNdv+qQvZQrOwCW10GR6RS20qhBn3bhrzJ55D99LQFpAJ+DNz2RsMWmuWgk8gRT2uWbJCOfN4ugMpdblPNbVQeBONR883WMfziwC4vLXFQSb0zDcsdUB+gyzW/5YYAS/H13jd/0Seo72V2Os2FdY+FpLzDfpqtgw121t4Cx8xQS7xYBzNHOEzABATjs50atA7HtRNHRrbIpiMRBCxJ2nCqxa2aFuJhKTrh8tDDUVZo5uL3akjcC4jAmVTcTp/3pG3XxWWxwyFA=="}';
        L_body := EncryptText('{"TradeInReferenceID":"' + Rec."Trade In ReferenceID" + '"}');
        IF L_body <> '' then begin

            L_EncryptText := '{"$data":"' + L_body + '"}';
            L_Content.WriteFrom(L_EncryptText);
            L_content.GetHeaders(L_headers);
            L_headers.Remove('Content-Type');
            L_headers.Add('Content-Type', 'application/json');
            //APIPath := 'https://clientstag.servify.tech/TradeIn/getTradeInExchangeDetails';
            APIPath := SalesRec."TradeInExchangeDetails API URL";
            if L_client.Post(APIPath, L_content, L_responseMessage) then begin
                L_responseMessage.Content.ReadAs(ResponseText);
                Clear(jObject);
                jObject.ReadFrom(ResponseText);
                Clear(L_Data);
                if jObject.Contains('$data') then begin
                    if GetJsonvalue(jObject, '$data').IsNull = false then begin
                        L_Data := GetJsonvalue(jObject, '$data').AsText();
                        //Message(L_Data);//RY
                    end;
                end;
                DecryptResponse(L_Data);
                //Message('%1', ResponseText);
            end;
        end;

    end;


    local procedure EncryptText(P_ResponseText: Text): Text
    var
        L_Headers: HttpHeaders;
        L_Client: HttpClient;
        L_Content: HttpContent;
        L_ResponseMessage: HttpResponseMessage;
        ResponseText: Text;
        APIPath: Text;
        SalesRec: Record "Sales & Receivables Setup";
        jObject: JsonObject;
        L_Response: Text;
    begin
        SalesRec.Get();
        Clear(L_Headers);
        Clear(L_Content);
        Clear(L_Client);
        Clear(L_ResponseMessage);
        Clear(ResponseText);
        L_Headers := L_Client.DefaultRequestHeaders;
        L_Headers.Add('Accept', 'application/json');
        L_Content.GetHeaders(L_Headers);



        Clear(APIPath);
        //APIPath := 'https://mapleapi.azurewebsites.net/api/EncryptDecrpt?encryData=' + L_Text3;
        APIPath := SalesRec."Encrypt API URL" + '?encryData=' + P_ResponseText;
        if L_Client.Get(APIPath, L_ResponseMessage) then begin
            if L_ResponseMessage.HttpStatusCode = 200 then begin
                if (L_ResponseMessage.IsSuccessStatusCode = true) then begin
                    L_ResponseMessage.Content().ReadAs(ResponseText);
                    Clear(L_Response);
                    Clear(jObject);
                    jObject.ReadFrom(ResponseText);
                    Clear(L_Response);
                    if jObject.Contains('cipherText') then begin
                        if GetJsonvalue(jObject, 'cipherText').IsNull = false then begin
                            L_Response := GetJsonvalue(jObject, 'cipherText').AsText();
                            exit(L_Response);
                        end;
                    end;

                end;
            end;
        end;
    end;

    local procedure DecryptResponse(P_ResponseText: Text)
    var
        L_Headers: HttpHeaders;
        L_Client: HttpClient;
        L_Content: HttpContent;
        L_ResponseMessage: HttpResponseMessage;
        ResponseText: Text;
        APIPath: Text;
        SalesRec: Record "Sales & Receivables Setup";
        jObject: JsonObject;
        L_Text: Text;
        L_Text2: Text;
        L_Text3: Text;
        L_Response: Text;
        L_ResponseData: Text;
        jArray: JsonArray;
        noOfResult: Integer;
        orderToken: JsonToken;
        i: Integer;
        orderHeaderObject: JsonObject;
        OldDeviceObject: JsonObject;
        NewDeviceObject: JsonObject;
        CustomerObject: JsonObject;
    begin
        SalesRec.Get();
        Clear(L_Headers);
        Clear(L_Content);
        Clear(L_Client);
        Clear(L_ResponseMessage);
        Clear(ResponseText);
        L_Headers := L_Client.DefaultRequestHeaders;
        L_Headers.Add('Accept', 'application/json');
        L_Content.GetHeaders(L_Headers);

        Clear(L_Text);
        Clear(L_Text2);
        Clear(L_Text3);
        L_Text := P_ResponseText.Replace('/', '%2F');
        L_Text2 := L_Text.Replace('+', '%2B');
        L_Text3 := L_Text2.Replace('=', '%3D');
        //Message(P_ResponseText);
        //Message(L_Text3);

        Clear(APIPath);
        //APIPath := 'https://mapleapi.azurewebsites.net/api/EncryptDecrpt?encryData=' + L_Text3;
        APIPath := SalesRec."Decrypt API URL" + '?encryData=' + L_Text3;
        if L_Client.Get(APIPath, L_ResponseMessage) then begin
            if L_ResponseMessage.HttpStatusCode = 200 then begin
                if (L_ResponseMessage.IsSuccessStatusCode = true) then begin
                    L_ResponseMessage.Content().ReadAs(ResponseText);
                    // Message(ResponseText);//RY
                    //
                    Clear(jObject);
                    jObject.ReadFrom(ResponseText);
                    //Message(ResponseText);//RY
                    Clear(L_Response);
                    if jObject.Contains('cipherText') then begin
                        if GetJsonvalue(jObject, 'cipherText').IsNull = false then begin
                            L_Response := GetJsonvalue(jObject, 'cipherText').AsText();
                            Clear(jObject);
                            jObject.ReadFrom(L_Response);
                            if jObject.Contains('data') then begin
                                Clear(orderHeaderObject);

                                orderHeaderObject := GetJsonToken(jObject, 'data').AsObject();
                                if not GetJsonvalue(orderHeaderObject, 'NameOfFirm').IsNull then
                                    Rec."Name Of Firm" := GetJsonvalue(orderHeaderObject, 'NameOfFirm').AsText();
                                if not GetJsonvalue(orderHeaderObject, 'ServiceLocationName').IsNull then
                                    Rec."Service Location Name" := GetJsonvalue(orderHeaderObject, 'ServiceLocationName').AsText();
                                if not GetJsonvalue(orderHeaderObject, 'CurrencyCode').IsNull then
                                    Rec."Servify Currency Code" := GetJsonvalue(orderHeaderObject, 'CurrencyCode').AsText();
                                if not GetJsonvalue(orderHeaderObject, 'LogisticsReferenceID').IsNull then
                                    Rec."Logistics Reference ID" := GetJsonvalue(orderHeaderObject, 'LogisticsReferenceID').AsText();
                                Rec."Trade In Status" := GetJsonvalue(orderHeaderObject, 'TradeInStatus').AsText();
                                if not GetJsonvalue(orderHeaderObject, 'BonusApplied').IsNull then
                                    Rec."Bonus Amount" := GetJsonvalue(orderHeaderObject, 'BonusApplied').AsText();
                                if not GetJsonvalue(orderHeaderObject, 'Username').IsNull then
                                    Rec."UserName" := GetJsonvalue(orderHeaderObject, 'Username').AsText();

                                Clear(OldDeviceObject);
                                OldDeviceObject := GetJsonToken(orderHeaderObject, 'OldDevice').AsObject();
                                if not GetJsonvalue(OldDeviceObject, 'ProductUniqueID').IsNull then
                                    Rec."Product Unique ID" := GetJsonvalue(OldDeviceObject, 'ProductUniqueID').AsText();
                                if not GetJsonvalue(OldDeviceObject, 'ModelName').IsNull then
                                    Rec."Model Name" := GetJsonvalue(OldDeviceObject, 'ModelName').AsText();
                                if not GetJsonvalue(OldDeviceObject, 'ModelStorage').IsNull then
                                    Rec."Model Storage" := GetJsonvalue(OldDeviceObject, 'ModelStorage').AsText();
                                if not GetJsonvalue(OldDeviceObject, 'ModelGrade').IsNull then
                                    Rec."Model Grade" := GetJsonvalue(OldDeviceObject, 'ModelGrade').AsText();
                                if not GetJsonvalue(OldDeviceObject, 'DeviceCustomerAmount').IsNull then
                                    Rec."Device Customer Amount" := FORMAT(GetJsonvalue(OldDeviceObject, 'DeviceCustomerAmount').AsInteger());
                                if not GetJsonvalue(OldDeviceObject, 'DeviceRetailerAmount').IsNull then
                                    Rec."Device Retailer Amount" := Format(GetJsonvalue(OldDeviceObject, 'DeviceRetailerAmount').AsInteger());


                                Clear(NewDeviceObject);
                                NewDeviceObject := GetJsonToken(orderHeaderObject, 'NewDevice').AsObject();
                                if not GetJsonvalue(NewDeviceObject, 'ProductUniqueID').IsNull then
                                    Rec."Product Unique ID New" := GetJsonvalue(NewDeviceObject, 'ProductUniqueID').AsText();
                                if not GetJsonvalue(NewDeviceObject, 'ModelBrand').IsNull then
                                    Rec."Model Brand" := GetJsonvalue(NewDeviceObject, 'ModelBrand').AsText();

                                Clear(CustomerObject);
                                CustomerObject := GetJsonToken(orderHeaderObject, 'Customer').AsObject();
                                if not GetJsonvalue(CustomerObject, 'Name').IsNull then
                                    Rec.Name := GetJsonvalue(CustomerObject, 'Name').AsText();
                                if not GetJsonvalue(CustomerObject, 'MobileNumber').IsNull then
                                    Rec."Mobile Number" := GetJsonvalue(CustomerObject, 'MobileNumber').AsText();
                                if not GetJsonvalue(CustomerObject, 'EmailID').IsNull then
                                    Rec."Email ID" := GetJsonvalue(CustomerObject, 'EmailID').AsText();
                            end;
                        end;
                    end;
                    //
                end;
            end;
        end;
    end;

    procedure GetJsonvalue(var aJsonObject: JsonObject; TokenKey: text) aJsonValue: JsonValue;
    /*  var
         aJsonToken: JsonToken;
     begin
         if not aJsonObject.Get(TokenKey, aJsonToken) then begin
         end
         Else begin

             aJsonValue := aJsonToken.AsValue();
         end;
     end; */
    var
        JToken: JsonToken;
    begin
        if aJsonObject.SelectToken(TokenKey, JToken) then
            if NOT JToken.AsValue().IsNull() then
                exit(JToken.AsValue());
    end;

    procedure GetJsonToken(var JsonObject: JsonObject; TokenKey: text) JsonToken: JsonToken;
    begin
        if not JsonObject.Get(TokenKey, JsonToken) then;
    end;

    var
        myDate: Text;
        hmac: Text;

}

