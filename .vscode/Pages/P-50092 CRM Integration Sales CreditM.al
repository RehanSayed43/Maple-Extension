page 50092 "CRM Integration Sales Credit M"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    PageType = List;
    SourceTable = "CRM Integration";
    SourceTableView = SORTING("Customer No.", "CRM invoice No", "No.")
                      WHERE("Document Type" = FILTER("Credit Memo"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = all;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = all;
                }
                field("Customer Address"; Rec."Customer Address")
                {
                    ApplicationArea = all;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = all;
                }
                field("State Code"; Rec."State Code")
                {
                    ApplicationArea = all;
                }
                field("Mobile No."; Rec."Mobile No.")
                {
                    ApplicationArea = all;
                }

                field("GST Registration No."; Rec."GST Registration No.")
                {
                    ApplicationArea = all;
                }
                field("GST Registration Type"; Rec."GST Registration Type")
                {
                    ApplicationArea = all;
                }
                field("GST Customer Type"; Rec."GST Customer Type")
                {
                    ApplicationArea = all;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = all;
                }
                field("Vertical Code"; Rec."Vertical Code")
                {
                    ApplicationArea = all;
                }
                field(Structure; Rec.Structure)
                {
                    ApplicationArea = all;
                }
                field("Order Posted"; Rec."Order Posted")
                {
                    ApplicationArea = all;
                }
                field("CRM invoice No"; Rec."CRM invoice No")
                {
                    ApplicationArea = all;
                }
                field("Invocie No to Apply"; Rec."Invocie No to Apply")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Nature of Supply"; Rec."Nature of Supply")
                {
                    ApplicationArea = all;
                }
                field("GST Without Payment of Duty"; Rec."GST Without Payment of Duty")
                {
                    ApplicationArea = all;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = all;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field("Unit Price With Tax"; Rec."Unit Price With Tax")
                {
                    ApplicationArea = all;
                }
                field("GST Group Code"; Rec."GST Group Code")
                {
                    ApplicationArea = all;
                }
                field("HSN/SAC Code"; Rec."HSN/SAC Code")
                {
                    ApplicationArea = all;
                }
                field("Invoice Type"; Rec."Invoice Type")
                {
                    ApplicationArea = all;
                }
                field("Cash Amount"; Rec."Cash Amount")
                {
                    ApplicationArea = all;
                }
                field("Credit Card Machine Name"; Rec."Credit Card Machine Name")
                {
                    ApplicationArea = all;
                }
                field("Credit Card No"; Rec."Credit Card No")
                {
                    ApplicationArea = all;
                }
                field("Credit Card Amount"; Rec."Credit Card Amount")
                {
                    ApplicationArea = all;
                }
                field("Debit Card Machine Name"; Rec."Debit Card Machine Name")
                {
                    ApplicationArea = all;
                }
                field("Debit Card No"; Rec."Debit Card No")
                {
                    ApplicationArea = all;
                }
                field("Debit Card Amount"; Rec."Debit Card Amount")
                {
                    ApplicationArea = all;
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    ApplicationArea = all;
                }
                field("Cheque Date"; Rec."Cheque Date")
                {
                    ApplicationArea = all;
                }
                field("Cheque Amount"; Rec."Cheque Amount")
                {
                    ApplicationArea = all;
                }
                field("NEFT/RTGS/EFT No."; Rec."NEFT/RTGS/EFT No.")
                {
                    ApplicationArea = all;
                }
                field("NEFT/RTGS/EFT  Date"; Rec."NEFT/RTGS/EFT  Date")
                {
                    ApplicationArea = all;
                }
                field("NEFT/RTGS/EFT Amount"; Rec."NEFT/RTGS/EFT Amount")
                {
                    ApplicationArea = all;
                }
                field(Narration; Rec.Narration)
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Roll)
            {
                action(Rollback)
                {
                    Image = Replan;
                    Promoted = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CreateCustomer(Rec."Mobile No.");
                        //  CRMRep.RUN;
                    end;
                }
            }
        }
    }

    var
        //   CRMRep: Report "50046";
        RecCustomer: Record 18;
        NoSeriesMgt: Codeunit 396;
        SRsetup: Record 311;
        custno: Code[20];


    procedure CreateCustomer("Mobile No.": Code[20])
    begin
        IF NOT Rec."Customer Created" THEN BEGIN
            CLEAR(RecCustomer."GST Registration No.");
            RecCustomer.RESET;
            //  RecCustomer.SETRANGE(RecCustomer."CRM Mobile No.", "Mobile No.");
            IF NOT RecCustomer.FINDFIRST THEN BEGIN
                SRsetup.GET;
                //  custno := NoSeriesMgt.GetNextNo(SRsetup."CRM Customer No.", WORKDATE, TRUE);
                RecCustomer."No." := custno;
                RecCustomer.Name := Rec."Customer Name";
                RecCustomer.Address := COPYSTR(Rec."Customer Address", 1, 50);
                RecCustomer."Address 2" := COPYSTR(Rec."Customer Address", 51, 100);
                RecCustomer.City := Rec.City;
                RecCustomer.VALIDATE("State Code", Rec."State Code");
                //  RecCustomer."CRM Mobile No." := "Mobile No.";
                RecCustomer.VALIDATE("GST Registration No.", Rec."GST Registration No.");
                RecCustomer."GST Registration Type" := Rec."GST Registration Type";
                RecCustomer."GST Customer Type" := Rec."GST Customer Type";
                RecCustomer.VALIDATE("Customer Posting Group", 'RETAIL');
                RecCustomer.VALIDATE("Gen. Bus. Posting Group", 'RETAIL');
                RecCustomer.INSERT;
                //COMMIT;
                Rec."Customer Created" := TRUE;
                MESSAGE('Customer Created');
            END;
        END;
    end;
}

