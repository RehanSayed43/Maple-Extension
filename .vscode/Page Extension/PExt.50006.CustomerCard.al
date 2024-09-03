pageextension 50006 "Customer Card" extends "Customer Card"
{
    Editable = true;
    layout
    {
        addafter("No.")
        {
            field("ERP No."; Rec."ERP No.")
            {
                ApplicationArea = all;
                Editable = CustEdit;
                trigger OnAssistEdit()
                var
                    NoSeriesMgt: codeunit "NoSeriesManagement";
                    Cust: Record customer;

                begin
                    Cust := Rec;
                    IF Cust."No." <> '' THEN BEGIN
                        IF CONFIRM('Do you want to Change Item Code') THEN
                            CLEAR(CustomerTypePage)
                        ELSE
                            ERROR('');
                    END
                    ELSE
                        CLEAR(CustomerTypePage);
                    // Commit();

                    CustomerTypePage.LOOKUPMODE(TRUE);
                    IF CustomerTypePage.RUNMODAL = ACTION::LookupOK THEN BEGIN
                        CustomerTypePage.GETRECORD(CutomerTypeRec);
                        SalesSetup.GET;
                        IF CutomerTypeRec."Customer Type" = CutomerTypeRec."Customer Type"::Retail THEN BEGIN
                            SalesSetup.TESTFIELD("Retail Customer Nos.");
                            Cust."No." := NoSeriesMgt.GetNextNo(SalesSetup."Retail Customer Nos.", TODAY, TRUE);
                            // IF NoSeriesMgt.SelectSeries(SalesSetup."Retail Customer Nos.", Xrec."No. Series", "No. Series") THEN
                            //     NoSeriesMgt.SetSeries("No.");
                        END
                        ELSE
                            IF CutomerTypeRec."Customer Type" = CutomerTypeRec."Customer Type"::Corporate THEN BEGIN
                                SalesSetup.TESTFIELD("Corporate Customer Nos.");
                                Cust."No." := NoSeriesMgt.GetNextNo(SalesSetup."Corporate Customer Nos.", TODAY, TRUE);
                                // IF NoSeriesMgt.SelectSeries(SalesSetup."Corporate Customer Nos.", Xrec."No. Series", "No. Series") THEN
                                //     NoSeriesMgt.SetSeries("No.");
                            END;
                        //KPPL Start
                        IF CutomerTypeRec."Customer Type" = CutomerTypeRec."Customer Type"::B2C THEN BEGIN
                            SalesSetup.TESTFIELD("B2C Customer No.");
                            Cust."No." := NoSeriesMgt.GetNextNo(SalesSetup."B2C Customer No.", TODAY, TRUE);
                            // IF NoSeriesMgt.SelectSeries(SalesSetup."B2C Customer No.", Xrec."No. Series", "No. Series") THEN
                            //     NoSeriesMgt.SetSeries("No.");
                        END
                        ELSE BEGIN
                            SalesSetup.TESTFIELD("Corporate Customer Nos.");
                            Cust."No." := NoSeriesMgt.GetNextNo(SalesSetup."Corporate Customer Nos.", TODAY, TRUE);
                            // IF NoSeriesMgt.SelectSeries(SalesSetup."Corporate Customer Nos.", XREC."No. Series", "No. Series") THEN
                            //     NoSeriesMgt.SetSeries("No.");
                        END
                        // Kppl End
                    END;
                    // Message('%1', cust."No.");
                    // Message('%1', Rec."No.");
                    rec."ERP No." := cust."No.";
                    //Rec := Cust;//commented
                    Rec."No." := Cust."No.";
                    rec."ERP No." := cust."No.";
                    // rec."No." := Rec."ERP No.";
                    //EXIT;
                    CurrPage.Update();


                end;


            }
        }
        modify("No.")
        {
            ApplicationArea = all;
            Visible = false;
        }
        modify("IC Partner Code")
        {
            ApplicationArea = ALL;
            Editable = CustEdit;
        }
        modify("Privacy Blocked")
        {
            ApplicationArea = ALL;
            Editable = CustEdit;
        }
        modify("Document Sending Profile")
        {
            ApplicationArea = ALL;
            Editable = CustEdit;
        }
        modify("Disable Search by Name")
        {
            ApplicationArea = ALL;
            Editable = CustEdit;
        }
        modify(Address)
        {
            ApplicationArea = ALL;
            Editable = CustEdit;
        }

        addafter(Name)
        {
            field("Name 2 "; Rec."Name 2")
            {
                ApplicationArea = ALL;
                Editable = CustEdit;
            }
        }
        addafter("Service Zone Code")
        {
            field("PDC Unposted Amount"; Rec."PDC Unposted Amount")
            {
                Editable = CustEdit;
                ApplicationArea = all;
            }
            field("PDC Applied Amount"; Rec."PDC Applied Amount")
            {
                Editable = CustEdit;
                ApplicationArea = all;
            }
            field("PDC Grace Period"; Rec."PDC Grace Period")
            {
                ApplicationArea = all;
                Editable = CustEdit;
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                Editable = CustEdit;
                ApplicationArea = all;
            }
            field(Status; Rec.Status)
            {
                Caption = 'Approval Status';
                ApplicationArea = all;

                trigger OnValidate()
                begin
                    Check;
                end;
            }
            field("Customer Type"; Rec."Customer Type")
            {
                //Editable = CustEdit;
                OptionCaption = ' ,Retail,Corporate,Service';
                ApplicationArea = all;

                trigger OnValidate()
                begin
                    Check;
                end;
            }
            field("Customer Sub Type"; Rec."Customer Sub Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Customer Sub Type field.';
            }

            field("Parent Code"; Rec."Parent Code")
            {
                Editable = CustEdit;
                ApplicationArea = all;

                trigger OnValidate()
                begin
                    Check;
                end;
            }
            field("CRM Mobile No."; Rec."CRM Mobile No.")
            {
                Editable = CustEdit;
                ApplicationArea = all;

                trigger OnValidate()
                begin
                    Check;
                end;
            }
            field("Customer Points"; Rec."Customer Points")
            {
                ApplicationArea = all;
            }

        }



        addbefore(Invoicing)
        {

            group("Personal Information")
            {

                Caption = 'Personal Information';
                Editable = CustEdit;


                field(Gender; Rec.Gender)
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        Check;
                    end;
                }
                field("Marital Status"; Rec."Marital Status")
                {

                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        Check;
                        IF Rec."Marital Status" = Rec."Marital Status"::Married THEN
                            MarriedEnable := TRUE
                        ELSE
                            MarriedEnable := FALSE;
                    end;
                }
                field("Customer Birth Date"; Rec."Customer Birth Date")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        Check;
                    end;
                }
                field("Spouse Name"; Rec."Spouse Name")
                {
                    Editable = MarriedEnable;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        Check;
                    end;
                }
                field("Spouse Birth Date"; Rec."Spouse Birth Date")
                {
                    Editable = MarriedEnable;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        Check;
                    end;
                }
                field("Child Name 1"; Rec."Child Name 1")
                {
                    Editable = MarriedEnable;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        Check;
                    end;
                }
                field("Child Name 2"; Rec."Child Name 2")
                {
                    Editable = MarriedEnable;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        Check;
                    end;
                }
                field("Aniversary Date"; Rec."Aniversary Date")
                {
                    Editable = MarriedEnable;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        Check;
                    end;
                }
                field("Child1 Birth  Date"; Rec."Child1 Birth  Date")
                {
                    Editable = MarriedEnable;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        Check;
                    end;
                }
                field("Child2 Birth Date"; Rec."Child2 Birth Date")
                {
                    Editable = MarriedEnable;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        Check;
                    end;
                }
                field("Income Group"; Rec."Income Group")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        Check;
                    end;
                }
                field("Age Group"; Rec."Age Group")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        Check;
                    end;
                }
            }

            group(Communication)
            {
                Caption = 'Communication';
                field("Phone No.."; Rec."Phone No.")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Phone No.2."; Rec."Phone No.2")
                {
                    ApplicationArea = all;
                    Caption = 'Phone No.2';
                }
            }
        }
        modify("VAT Registration No.")
        {
            Editable = CustEdit;

            trigger OnAfterValidate()
            begin
                Check;
            end;
        }
        modify(Blocked)
        {
            Visible = false;

            trigger OnAfterValidate()
            begin
                Check;
            end;
        }


        modify(Name)
        {
            Editable = CustEdit;
            ShowMandatory = true;
        }
        modify("Address 2")
        {
            Editable = CustEdit;
            ShowMandatory = true;

            trigger OnAfterValidate()
            begin
                Check;
            end;
        }
        modify("Post Code")
        {
            Editable = CustEdit;
            Importance = Promoted;


            trigger OnAfterValidate()
            begin
                Check;
            end;
        }
        modify(City)
        {
            Editable = CustEdit;

            trigger OnAfterValidate()
            begin
                Check;
            end;
        }
        modify("Country/Region Code")
        {
            Editable = CustEdit;

            trigger OnAfterValidate()
            begin
                Check;
            end;
        }
        modify("State Code")
        {
            Editable = CustEdit;
            trigger OnAfterValidate()
            begin
                Check;
            end;
        }
        modify("Phone No.")
        {
            Editable = true;
            trigger OnAfterValidate()
            begin
                //WIN316++
                CurrPage.UPDATE;
                //WIN316--
            end;
        }
        modify("Phone No.2.")
        {
            Editable = true;

            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //WIN316++
                CurrPage.UPDATE;
                //WIN316--
            end;
        }
        modify("Fax No.")
        {
            ApplicationArea = ALL;
            Editable = CustEdit;
        }
        modify("Home Page")
        {
            ApplicationArea = ALL;
            Editable = CustEdit;
        }
        modify("Language Code")
        {
            ApplicationArea = ALL;
            Editable = CustEdit;
        }
        modify("Primary Contact No.")
        {
            ApplicationArea = ALL;
            Editable = CustEdit;
        }
        modify(ContactName)
        {
            ApplicationArea = ALL;
            Editable = CustEdit;
        }
        modify(Invoicing)
        {
            //ApplicationArea = ALL;
            Editable = CustEdit;
        }
        modify(Payments)
        {
            //ApplicationArea = ALL;
            Editable = CustEdit;
        }
        modify(Shipping)
        {
            //ApplicationArea = ALL;
            Editable = CustEdit;
        }
        modify("Tax Information")
        {
            //ApplicationArea = ALL;
            Editable = CustEdit;
        }

        modify("E-Mail")
        {

            ApplicationArea = ALL;
            Editable = CustEdit;

            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //WIN316++
                CurrPage.UPDATE;
                //WIN316--
            end;
        }
        modify("Search Name")
        {
            Editable = CustEdit;

            trigger OnAfterValidate()
            begin
                Check;
            end;
        }
        modify("Balance (LCY)")
        {
            trigger OnDrillDown()
            var
                DtldCustLedgEntry: Record 379;
                CustLedgEntry: Record 21;
            begin
                DtldCustLedgEntry.SETRANGE("Customer No.", Rec."No.");
                Rec.COPYFILTER("Global Dimension 1 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 1");
                Rec.COPYFILTER("Global Dimension 2 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 2");
                Rec.COPYFILTER("Currency Filter", DtldCustLedgEntry."Currency Code");
                CustLedgEntry.DrillDownOnEntries(DtldCustLedgEntry);
            end;

        }
        modify("Credit Limit (LCY)")
        {
            Editable = CustEdit;
            StyleExpr = StyleTxt;

            trigger OnAfterValidate()
            begin
                StyleTxt := Rec.SetStyle;
            end;
        }
        modify("Salesperson Code")
        {
            Editable = CustEdit;

            trigger OnAfterValidate()
            begin
                Check;
            end;
        }
        modify("Responsibility Center")
        {
            Editable = CustEdit;

            trigger OnAfterValidate()
            begin
                Check;
            end;
        }
        modify("Service Zone Code")
        {
            Editable = CustEdit;

            trigger OnAssistEdit()
            begin
                Check;
            end;

            trigger OnAfterValidate()
            begin
                Check;
            end;
        }

        /* modify(General)
         {
             Editable = PageEditable;
         }
         */
        modify("GST Registration No.")
        {
            ApplicationArea = ALL;
            trigger OnBeforeValidate()
            BEGIN
                IF NOT InsertVar THEN
                    IF NOT (USERID IN ['KAILAS.THUBE', 'KAMLESH.YADAV']) THEN
                        Error('You do not have permission.');
                /*
                    IF (Rec."GST Registration No." <> '') AND (xRec."GST Registration No." <> '') THEN BEGIN
                        IF NOT (USERID IN ['KAILAS.THUBE']) THEN
                            Error('You do not have permission.');
                    END;
                    IF (xRec."GST Registration No." <> '') AND (Rec."GST Registration No." = '') THEN
                        IF NOT (USERID IN ['KAILAS.THUBE']) THEN
                            Error('You do not have permission.');
                */
            END;
        }

    }


    actions
    {
        addafter(ApprovalEntries)
        {
            action("Online Map")
            {
                Caption = 'Online Map';
                Image = Map;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.DisplayMap;
                end;
            }
            action("e-Commerce Merchant Id")
            {
                Caption = 'e-Commerce Merchant Id';
                ApplicationArea = All;
                // RunObject = Page 16423;
                // RunPageLink = "Customer No."=FIELD("No.");//tk
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
                // ApprovalMgt: Codeunit "439";
                begin
                    // IF Status = Status::"Pending Approval" THEN
                    //   MESSAGE('Customer Already Send for approval')
                    // ELSE
                    // IF Status = Status::Approved THEN
                    //   MESSAGE('Customer is Already Approved')
                    // ELSE
                    // BEGIN
                    //   IF Status = Status::Open THEN BEGIN
                    //     IF ApprovalMgt.PrePostApprovalCheckCustomer(Rec) THEN
                    //       ApprovalMgt.SendCustomerApprovalRequest(Rec);
                    //   END;
                    // END;//tk
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
                    ApprovalMgt: Codeunit "Approvals Mgmt.";
                begin
                    IF Rec.Status = Rec.Status::"Pending Approval" THEN BEGIN
                        // IF ApprovalMgt.CancelCustomerApprovalRequest(Rec,TRUE,TRUE) THEN;
                    END
                    ELSE BEGIN
                        IF Rec.Status = Rec.Status::Approved THEN
                            MESSAGE('Customer is already Approved, you can not Cancel')
                        ELSE
                            MESSAGE('Customer approval entry not found');
                    END;
                end;
            }

        }
        addbefore(Service)
        {
            group("Credit Card")
            {
                Caption = 'Credit Card';
                Image = CreditCard;
                Visible = false;
                group("Credit Cards")
                {
                    Caption = 'Credit Cards';
                    Image = CreditCard;
                    Visible = false;
                    action("C&redit Cards")
                    {
                        Caption = 'C&redit Cards';
                        Image = CreditCard;
                        ApplicationArea = All;
                        // RunObject = Page "DO Payment Credit Card List";
                        // RunPageLink = "Customer No.=FIELD(No.);
                        // Visible = false;
                    }
                    action("Credit Cards Transaction Lo&g Entries")
                    {
                        Caption = 'Credit Cards Transaction Lo&g Entries';
                        Image = CreditCardLog;
                        ApplicationArea = All;
                        // RunObject = Page 829;
                        //                 RunPageLink = Customer No.=FIELD(No.);
                        // Visible = false;
                    }
                }
            }
        }

    }

    trigger OnOpenPage()
    var
        myInt: Integer;
        MapMgt: codeunit "Online Map Management";
    begin

        ContactEditable := TRUE;
        MapPointVisible := TRUE;
        MarriedEnable := TRUE;
        CustEdit := TRUE;//Win-234 06-03-2019
        ActivateFields;
        IF NOT MapMgt.TestSetup THEN
            MapPointVisible := FALSE;
        IF NOT MapMgt.TestSetup THEN
            MapPointVisible := FALSE;
        If Rec."No." <> '' then begin
            Rec."ERP No." := Rec."No.";
            Rec.Modify();
        End;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        myInt: Integer;
    begin
        IF CustEdit = TRUE THEN BEGIN
            IF Rec."No." <> '' THEN BEGIN
                Rec.TESTFIELD(Name);
                Rec.TESTFIELD(Address);
                Rec.TESTFIELD("Address 2");
                Rec.TESTFIELD("Post Code");
                Rec.TESTFIELD("State Code");
                Rec.TESTFIELD(City);
                Rec.TESTFIELD("Phone No.");
                Rec.TESTFIELD("E-Mail");
                Rec.TESTFIELD("Gen. Bus. Posting Group");
                IF Rec."GST Customer Type" = Rec."GST Customer Type"::Registered THEN
                    IF STRLEN(Rec."GST Registration No.") <> 15 THEN
                        ERROR('GST Registration No must be length of 15');
            END;
        END;
        //WIN316++//CAPILLARY
        IF Rec."Phone No." = '' THEN
            Rec."Not Interested Customer" := TRUE
        ELSE BEGIN
            RecUserSetup.RESET;
            RecUserSetup.SETRANGE(RecUserSetup."User ID", USERID);
            IF RecUserSetup.FINDFIRST THEN BEGIN
                IF RecUserSetup."Location Code" <> '' THEN BEGIN
                    RecLocation.RESET;
                    RecLocation.SETRANGE(Code, RecUserSetup."Location Code");
                    IF RecLocation.FINDFIRST THEN BEGIN
                        IF (RecLocation."Capillary ID" <> '') AND (RecLocation."Capillary Password" <> '') THEN
                            RecCreateTrnXml.Create_customer(Rec."No.");
                    END;
                END;
            END;
        END;
        //WIN316--
        IF Rec."Customer Points" <> 0 THEN BEGIN
            Rec."Customer Points" := 0;
            Rec.MODIFY
        END; //Win-234 25-01-2019
    end;
    /* //CCIT AN++
     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
     var
         myInt: Integer;
     begin
         //PageEditable := true;
     end;
     //CCIT AN--*/

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        ActivateFields;
        StyleTxt := Rec.SetStyle;

        //MESSAGE(USERID);
        //CCIT AN++
        //if PageEditable = false then begin
        ///Rec.Modify(false);
        //if RecUserSetup.Get(USERID) then begin
        //  if RecUserSetup."Customer Edit" = true then
        //    Rec.Modify(true); //PageEditable := true;
        //end;
        //end;

        IF Rec."Marital Status" = Rec."Marital Status"::Married THEN
            MarriedEnable := TRUE
        ELSE
            MarriedEnable := FALSE;
        //win344--
        //CustEdit:=TRUE;
        //MESSAGE(USERID);

        RecUserSetup.Get(userId);
        //Message('%1', USERID);
        //Rushab_CCIT++
        IF NOT (USERID IN ['ADMIN', 'KAILAS.THUBE', 'KAMLESH.YADAV']) THEN BEGIN //kppl-rj
            RecSIH.RESET;
            RecSIH.SETRANGE("Sell-to Customer No.", Rec."No.");
            IF RecSIH.FINDFIRST THEN BEGIN
                CustEdit := FALSE;
            END ELSE
                CustEdit := TRUE;
        END ELSE
            IF USERID IN ['ADMIN', 'KAILAS.THUBE'] THEN
                CustEdit := TRUE;
        //Rushab_CCIT--

        /*IF (USERID = 'MAPLEIT') OR (USERID='ADMIN') THEN
          CustEdit:=TRUE;*/
        //Win-234-------------------06-03-2019
        If Rec."No." <> '' then BeGIN
            Rec."ERP No." := Rec."No.";
            Rec.Modify();
        End;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    BEGIN
        InsertVar := true;
        //Message('Insert');
    END;

    var
        InsertVar: Boolean;
        myInt: Integer;
        MapPointVisible: Boolean;
        ContactEditable: Boolean;
        SocialListeningSetupVisible: Boolean;
        SocialListeningVisible: Boolean;
        // RecCreateTrnXml: Codeunit 50012;
        RecUserSetup: Record "User Setup";
        PageEditable: Boolean;
        MarriedEnable: Boolean;
        RecLocation: Record 14;
        RecSIH: Record 112;
        CustEdit: Boolean;
        StyleTxt: Text;
        RecCreateTrnXml: Codeunit "Create Transaction XML";
        CutomerTypeRec: Record "Customer";
        CustomerTypePage: Page "Customer Type Selection";
        SalesSetup: Record "Sales & Receivables Setup";



    local procedure Check()
    var
        RecSIH: Record 112;
    begin
        //RushaB_CCIT++ Commented
        // IF "No." <> '' THEN BEGIN
        //     // RecUserSetup.Get(UserId);
        //     IF NOT (USERID IN ['ACC4EXE', 'ADMIN', 'MAPLEIT']) THEN BEGIN
        //         RecSIH.RESET;
        //         RecSIH.SETRANGE("Sell-to Customer No.", Rec."No.");
        //         IF RecSIH.FINDFIRST THEN BEGIN
        //             ERROR('Not Allowed to Change');
        //         END;
        //     END;
        // END;   //Win-234 09-05-2019//tk
    end;

}