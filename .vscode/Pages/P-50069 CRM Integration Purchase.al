page 50069 "CRM Integration Purchase Page"
{
    UsageCategory = Administration;
    ApplicationArea = all;
    SourceTable = "CRM Integration Purchase";
    SourceTableView = SORTING("Vendor No.", "Vendor Invoice No", "Vendor Part Code", "No.")
                      WHERE("Order Created" = CONST(False));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = all;
                }
                field(VendorName; Rec.VendorName)
                {
                    ApplicationArea = all;
                }
                field(VendorAddress; Rec.VendorAddress)
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
                field("Vendor Invoice No"; Rec."Vendor Invoice No")
                {
                    ApplicationArea = all;
                }
                field("GST Registration No."; Rec."GST Registration No.")
                {
                    ApplicationArea = all;
                }
                field("GST Vendor Type"; Rec."GST Vendor Type")
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
                field(Structure; Rec.Structure)
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
                field(Type; Rec.Type)
                {
                    ApplicationArea = all;
                }
                field("Vendor Part Code"; Rec."Vendor Part Code")
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
                field("GST Group Type"; Rec."GST Group Type")
                {
                    ApplicationArea = all;
                }
                field("HSN/SAC Code"; Rec."HSN/SAC Code")
                {
                    ApplicationArea = all;
                }
                field("Vendor Created"; Rec."Vendor Created")
                {
                    ApplicationArea = all;

                }
                field("Order Created"; Rec."Order Created")
                {
                    ApplicationArea = all;
                }
                field("Order Posted"; Rec."Order Posted")
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
                field("Apply to Document Type"; Rec."Apply to Document Type")
                {
                    ApplicationArea = all;
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                    ApplicationArea = all;
                }
                field("Vendor Cr. Memo No."; Rec."Vendor Cr. Memo No.")
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
            group(" ")
            {
                action(ROLLBACK)
                {
                    Image = RollBack;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CreateVendor(Rec."Mobile No.");
                        //        RepPurCr.RUN;
                    end;
                }
            }
        }
    }

    var
        //  RepPurCr: Report 50049;
        RecVednor: Record "Vendor";

    local procedure CreateVendor("Mobile No.": Code[20])
    begin
        IF NOT Rec."Vendor Created" THEN BEGIN
            RecVednor.RESET;
            RecVednor.SETRANGE(RecVednor."Phone No.", "Mobile No.");
            IF NOT RecVednor.FINDFIRST THEN BEGIN
                RecVednor."No." := Rec."Vendor No.";
                RecVednor.Name := Rec.VendorName;
                RecVednor.Address := Rec.VendorAddress;
                RecVednor.City := Rec.City;
                RecVednor.VALIDATE("State Code", Rec."State Code");
                RecVednor."Phone No." := "Mobile No.";
                RecVednor.VALIDATE("GST Registration No.", Rec."GST Registration No.");
                RecVednor."GST Vendor Type" := Rec."GST Vendor Type";
                RecVednor.VALIDATE("Vendor Posting Group", 'DOMESTIC');
                RecVednor.VALIDATE("Gen. Bus. Posting Group", 'DOMESTIC');
                RecVednor.INSERT;
                COMMIT;
                Rec."Vendor Created" := TRUE;
                MESSAGE('Vendor Created');
            END;
        END;
    end;
}

