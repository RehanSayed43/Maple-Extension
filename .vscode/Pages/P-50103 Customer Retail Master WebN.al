page 50103 "Customer Retail Master-WebN"
{
    UsageCategory = Administration;
    ApplicationArea = all;
    PageType = Card;
    SourceTable = Customer;

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

                    trigger OnValidate()
                    begin
                        Check;
                    end;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = all;
                    Caption = 'Mobile';
                }
                field("Phone No.2"; Rec."Phone No.2")
                {
                    ApplicationArea = all;
                    Caption = 'Phone No.2';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = all;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = all;
                    Editable = CustEdit;

                    trigger OnValidate()
                    begin
                        Check;
                    end;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = all;
                    Editable = CustEdit;

                    trigger OnValidate()
                    begin
                        Check;
                    end;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = all;
                    Editable = CustEdit;

                    trigger OnValidate()
                    begin
                        Check;
                    end;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = all;
                    Editable = CustEdit;

                    trigger OnValidate()
                    begin
                        Check;
                    end;
                }
                field("State Code"; Rec."State Code")
                {
                    ApplicationArea = all;
                    Editable = CustEdit;

                    trigger OnValidate()
                    begin
                        Check;
                    end;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                    Editable = CustEdit;

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
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = all;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Check;
                    end;
                }
                // field(Structure;Rec. Structure)
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
    }

    trigger OnAfterGetRecord()
    begin
        IF Rec."Marital Status" = Rec."Marital Status"::Married THEN
            MarriedEnable := TRUE
        ELSE
            MarriedEnable := FALSE;
    end;

    trigger OnInit()
    begin

        MarriedEnable := TRUE;
        CustEdit := TRUE;//Win-234 08-04-2019
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Customer Type" := Rec."Customer Type"::Retail;
        Rec."Gen. Bus. Posting Group" := 'Retail';
        Rec."Customer Posting Group" := 'Retail';

        //  Rec.Structure := 'GST PIT';
        Rec."Tax Liable" := TRUE;
        UserSetup.GET(USERID);
    end;

    var
        MarriedEnable: Boolean;
        UserSetup: Record 91;
        Location: Record 14;
        //  RecCreateTrnXml: Codeunit "50012";
        RecUserSetup: Record 91;
        RecLocation: Record 14;
        CustEdit: Boolean;
        RecSIH: Record 112;
        RecSH: Record 36;

    local procedure Check()
    var
        RecSIH: Record 112;
    begin
        IF Rec."No." <> '' THEN BEGIN
            IF USERID <> 'ACC4EXE' THEN BEGIN
                RecSIH.RESET;
                RecSIH.SETRANGE("Sell-to Customer No.", Rec."No.");
                IF RecSIH.FINDFIRST THEN BEGIN
                    ERROR('Not Allowed to Change');
                END;
            END;
        END;   //Win-234 09-05-2019
    end;
}

