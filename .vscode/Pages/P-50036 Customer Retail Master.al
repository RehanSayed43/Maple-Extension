page 50036 "Customer Retail Master"
{


    UsageCategory = Administration;
    ApplicationArea = all;
    PageType = Card;
    Editable = True;
    SourceTable = Customer;
    InsertAllowed = True;
    // ModifyAllowed = true;
    DeleteAllowed = true;



    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = all;
                    Editable = CustEdit;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Check;
                    end;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = all;
                    Caption = 'Mobile';
                    Editable = true;
                }
                field("Phone No.2"; Rec."Phone No.2")
                {
                    ApplicationArea = all;
                    Caption = 'Phone No.2';
                    Editable = true;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = all;
                    Editable = CustEdit;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Check;
                    end;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = all;
                    Editable = CustEdit;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Check;
                    end;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = all;
                    Editable = CustEdit;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Check;
                    end;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                    Editable = CustEdit;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Check;
                    end;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = all;
                    Editable = CustEdit;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Check;
                    end;
                }
                field("State Code"; Rec."State Code")
                {
                    ApplicationArea = all;
                    Editable = CustEdit;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Check;
                    end;
                }

                field("Customer State Code"; Rec."Customer State Code")
                {
                    ApplicationArea = all;
                    Caption = ' State Code';
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Check;
                    end;
                }
                field("Customer Type"; Rec."Customer Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Customer Type field.';
                }
                field("Customer Sub Type"; Rec."Customer Sub Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Customer Sub Type field.';
                }
                field("GST Customer Type"; Rec."GST Customer Type")
                {
                    ApplicationArea = all;
                    Editable = CustEdit;

                    trigger OnValidate()
                    begin
                        Check;
                    end;
                }
                field("GST Registration No."; Rec."GST Registration No.")
                {
                    ApplicationArea = all;
                    Editable = CustEdit;

                    trigger OnValidate()
                    begin
                        Check;
                    end;
                }
                field("ARN No."; Rec."ARN No.")
                {
                    ApplicationArea = all;
                }
                field("P.A.N. No."; Rec."P.A.N. No.")
                {
                    ApplicationArea = all;
                    Editable = CustEdit;


                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {

                    ApplicationArea = all;
                    Editable = true;
                    Caption = 'Vertical Code';
                }



                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = all;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Check;
                    end;
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ApplicationArea = all;
                    Editable = true;
                    ShowMandatory = true;


                }
                // field(Structure;Structure)
                // {
                //     Visible = false;

                //     trigger OnValidate()
                //     begin
                //         Check;
                //     end;
                // }
                field("Tax Liable"; Rec."Tax Liable")
                {
                    ApplicationArea = all;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Check;
                    end;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = all;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Check;
                    end;
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    ApplicationArea = all;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Check;
                    end;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = all;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Check;
                    end;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = all;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Check;
                    end;
                }
                field("Customer Points"; Rec."Customer Points")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        Check;
                    end;
                }
            }
            group("Personal Information")
            {
                Caption = 'Personal Information';
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
                        IF Rec."Marital Status" = Rec."Marital Status"::Married THEN
                            MarriedEnable := TRUE
                        ELSE
                            MarriedEnable := FALSE;
                        Check;
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
                    ApplicationArea = all;
                    Editable = MarriedEnable;

                    trigger OnValidate()
                    begin
                        Check;
                    end;
                }
                field("Spouse Birth Date"; Rec."Spouse Birth Date")
                {
                    ApplicationArea = all;
                    Editable = MarriedEnable;

                    trigger OnValidate()
                    begin
                        Check;
                    end;
                }
                field("Child Name 1"; Rec."Child Name 1")
                {
                    ApplicationArea = all;
                    Editable = MarriedEnable;

                    trigger OnValidate()
                    begin
                        Check;
                    end;
                }
                field("Child1 Birth  Date"; Rec."Child1 Birth  Date")
                {
                    ApplicationArea = all;
                    Editable = MarriedEnable;

                    trigger OnValidate()
                    begin
                        Check;
                    end;
                }
                field("Child Name 2"; Rec."Child Name 2")
                {
                    ApplicationArea = all;
                    Editable = MarriedEnable;

                    trigger OnAssistEdit()
                    begin
                        Check;
                    end;

                    trigger OnValidate()
                    begin
                        Check;
                    end;
                }
                field("Child2 Birth Date"; Rec."Child2 Birth Date")
                {
                    ApplicationArea = all;
                    Editable = MarriedEnable;

                    trigger OnValidate()
                    begin
                        Check;
                    end;
                }
                field("Aniversary Date"; Rec."Aniversary Date")
                {
                    ApplicationArea = all;
                    Editable = MarriedEnable;

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
                field("Income Group"; Rec."Income Group")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        Check;
                    end;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Ship-&to Addresses")
            {
                Caption = 'Ship-&to Addresses';
                Image = ShipAddress;
                RunObject = Page 301;
                RunPageLink = "Customer No." = FIELD("No.");
                ApplicationArea = All;
            }
        }
        area(reporting)
        {
            group(Capillary)
            {
                action("Get Customer Points")
                {
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        /*
                        Get_cust_points;
                        CurrPage.UPDATE;
                        *///WIN234 05082020

                    end;
                }
                action(Dimensions)
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(18),
                                  "No." = FIELD("No.");
                    ShortCutKey = 'Alt+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
                }

            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF Rec."Marital Status" = Rec."Marital Status"::Married THEN
            MarriedEnable := TRUE
        ELSE
            MarriedEnable := FALSE;
        /*
        //Win-234+++++++++++++++++++
        IF USERID<>'ACC4EXE'THEN BEGIN
          RecSIH.RESET;
          RecSIH.SETRANGE("Sell-to Customer No.",Rec."No.");
          IF RecSIH.FINDFIRST THEN BEGIN
            CustEdit:=FALSE;
            END
            ELSE
            CustEdit:= TRUE;
        END ELSE IF USERID='ACC4EXE'THEN
          CustEdit:=TRUE;
        
        IF USERID<>'ACC4EXE'THEN BEGIN
        RecSH.RESET;
        RecSH.SETRANGE("Sell-to Customer No.","No.");
        IF RecSH.FINDFIRST THEN BEGIN
          CustEdit:=FALSE;
          END ELSE
          CustEdit:=TRUE;
          END ELSE IF USERID='ACC4EXE'THEN
          CustEdit:=TRUE;
          */
        // MESSAGE(USERID);
        // UserSetup.GET(UserId);
        // Message(UserId);
        IF NOT (USERID IN ['ACC4EXE', 'ADMIN', 'MAPLEIT']) THEN BEGIN //kppl-rj
            RecSIH.RESET;
            RecSIH.SETRANGE("Sell-to Customer No.", Rec."No.");
            IF RecSIH.FINDFIRST THEN BEGIN
                CustEdit := FALSE;
            END ELSE
                CustEdit := TRUE;
        END ELSE
            //   UserSetup.GET(UserId);
            IF USERID IN ['ACC4EXE', 'ADMIN', 'MAPLEIT'] THEN
                CustEdit := TRUE;
        //Win-234-------------------06-03-2019

    end;

    trigger OnClosePage()
    begin
        //IF "State Code" = '' THEN
        // ERROR('Select State Code');
    end;

    trigger OnInit()
    begin
        /*
        "Gen. Bus. Posting Group" := 'Retail'
        "Customer Posting Group":= 'Retail'
        "Payment Terms Code" := 'COD'
        Structure := 'VT+ST(PIT)'
        "Tax Liable" := TRUE;
       */
        MarriedEnable := TRUE;
        CustEdit := TRUE;//Win-234 08-04-2019

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Customer Type" := Rec."Customer Type"::Retail;
        Rec."Gen. Bus. Posting Group" := 'Retail';
        Rec."Customer Posting Group" := 'Retail';
        // "Payment Terms Code" := 'COD';  //Win-234 As per mail from Mahendra 09-05-2019
        // Structure := 'VT+ST(PIT)';
        Rec."Tax Liable" := TRUE;
        UserSetup.GET(UserId);
        //"Location Code" := UserSetup."Location Code";//win316++
        //Location.GET("Location Code");
        //"State Code" := Location."State Code";//win316++
        IF Rec."Customer Type" = Rec."Customer Type"::Retail then begin
            Rec."GST Customer type" := Rec."GST Customer type"::Unregistered;
        end;
    end;

    trigger OnOpenPage()
    begin
        IF Rec."Customer Type" <> Rec."Customer Type"::" " THEN
            Rec.SETFILTER("Customer Type", '%1', Rec."Customer Type"::Retail);
        IF Rec."Customer Type" = Rec."Customer Type"::Retail then begin
            Rec."GST Customer type" := Rec."GST Customer type"::Unregistered;
        end;


    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
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
                        //     IF (RecLocation."Capillary ID"<>'') AND (RecLocation."Capillary Password"<>'') THEN
                        //      //   RecCreateTrnXml.Create_customer(Rec."No.");
                    END;
                END;
            END;
        END;
        //WIN316--

        IF Rec."Customer Points" <> 0 THEN BEGIN
            Rec."Customer Points" := 0;
            // MODIFY
        END; //Win-234 09-05-2019

        IF CustEdit = TRUE THEN BEGIN
            IF Rec."No." <> '' THEN BEGIN
                Rec.TESTFIELD(Name);
                Rec.TESTFIELD(Address);
                Rec.TESTFIELD("Address 2");
                Rec.TESTFIELD("Post Code");
                Rec.TESTFIELD("State Code");
                Rec.TESTFIELD("Location Code");
                Rec.TESTFIELD(City);
                Rec.TESTFIELD("Phone No.");
                Rec.TESTFIELD("E-Mail");
                Rec.TESTFIELD("Gen. Bus. Posting Group");
                IF Rec."GST Customer Type" = Rec."GST Customer Type"::Registered THEN
                    IF STRLEN(Rec."GST Registration No.") <> 15 THEN
                        ERROR('GST Registration No must be length of 15');
            END;
        END; //kppl-rj
    end;

    var
        MarriedEnable: Boolean;
        UserSetup: Record 91;
        Location: Record 14;
        // RecCreateTrnXml: Codeunit 50012;
        RecUserSetup: Record 91;
        RecLocation: Record 14;
        CustEdit: Boolean;
        RecSIH: Record 112;
        RecSH: Record 36;
        GLS: Record "General Ledger Setup";

    local procedure Check()
    var
        RecSIH: Record 112;
    begin
        IF Rec."No." <> '' THEN BEGIN
            UserSetup.GET(UserId);
            IF NOT (USERID IN ['ACC4EXE', 'ADMIN', 'MAPLEIT']) THEN BEGIN
                RecSIH.RESET;
                RecSIH.SETRANGE("Sell-to Customer No.", Rec."No.");
                IF RecSIH.FINDFIRST THEN BEGIN
                    ERROR('Not Allowed to Change');
                END;
            END;
        END;   //Win-234 09-05-2019
    end;
}

