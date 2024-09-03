xmlport 50014 "CRM Integration Purchase"
{
    Format = VariableText;
    Direction = Import;

    schema
    {
        textelement(Root)
        {
            tableelement("CRM Integration Purchase"; "CRM Integration Purchase")
            {
                AutoReplace = true;
                XmlName = 'CRM_Integration_Purchase';
                fieldelement("Vendor_No."; "CRM Integration Purchase"."Vendor No.")
                {
                    MinOccurs = Once;
                }
                fieldelement(VendorName; "CRM Integration Purchase".VendorName)
                {
                }
                fieldelement(VendorAddress; "CRM Integration Purchase".VendorAddress)
                {
                }
                fieldelement(City; "CRM Integration Purchase".City)
                {
                }
                fieldelement(State_Code; "CRM Integration Purchase"."State Code")
                {
                }
                fieldelement("Mobile_No."; "CRM Integration Purchase"."Mobile No.")
                {
                }
                fieldelement(Vendor_Invoice_No; "CRM Integration Purchase"."Vendor Invoice No")
                {
                }
                fieldelement("GST_Registration_No."; "CRM Integration Purchase"."GST Registration No.")
                {
                }
                fieldelement(GST_Vendor_Type; "CRM Integration Purchase"."GST Vendor Type")
                {

                    trigger OnAfterAssignField()
                    begin
                        CreateVendor("CRM Integration Purchase"."Mobile No.");
                    end;
                }
                fieldelement(Document_Type; "CRM Integration Purchase"."Document Type")
                {
                }
                fieldelement(Posting_Date; "CRM Integration Purchase"."Posting Date")
                {
                }
                fieldelement("ShourtCut-Dim-1"; "CRM Integration Purchase"."Shortcut Dimension 1 Code")
                {
                }
                fieldelement("Shourtcut-dim-2"; "CRM Integration Purchase"."Shortcut Dimension 2 Code")
                {
                }
                fieldelement("GST-Credit"; "CRM Integration Purchase"."GST Credit") //kj
                //fieldelement(Structure; "CRM Integration Purchase".Structure)
                {
                }
                fieldelement(TDS_Nature_of_Deduction; "CRM Integration Purchase"."TDS Nature of Deduction")
                {
                    MinOccurs = Zero;
                }
                fieldelement(CRM_invoice_No; "CRM Integration Purchase"."CRM invoice No")
                {
                }
                fieldelement(Invoice_No_to_Apply; "CRM Integration Purchase"."Invocie No to Apply")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Location_Code; "CRM Integration Purchase"."Location Code")
                {
                }
                fieldelement(Type; "CRM Integration Purchase".Type)
                {
                }
                fieldelement(Vendor_Part_Code; "CRM Integration Purchase"."Vendor Part Code")
                {
                }
                fieldelement("No."; "CRM Integration Purchase"."No.")
                {
                }
                fieldelement(Quantity; "CRM Integration Purchase".Quantity)
                {
                }
                fieldelement(Unit_Price_With_Tax; "CRM Integration Purchase"."Unit Price With Tax")
                {
                }
                fieldelement(GST_Group_Code; "CRM Integration Purchase"."GST Group Code")
                {
                }
                fieldelement(GST_Group_Type; "CRM Integration Purchase"."GST Group Type")
                {
                }
                fieldelement(HSNSA_Code; "CRM Integration Purchase"."HSN/SAC Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Apply_to_Document_Type; "CRM Integration Purchase"."Apply to Document Type")
                {
                    MinOccurs = Zero;
                }
                fieldelement("Apply_to_Doc._No."; "CRM Integration Purchase"."Applies-to Doc. No.")
                {
                    MinOccurs = Zero;
                }
                fieldelement("Vend_Cr_Memo_No."; "CRM Integration Purchase"."Vendor Cr. Memo No.")
                {
                    MinOccurs = Zero;
                }
                fieldelement(comment; "CRM Integration Purchase".Comment)
                {
                    MinOccurs = Zero;
                }

                trigger OnBeforeInsertRecord()
                begin
                    //WIN316++
                    RecVend.RESET;
                    RecVend.SETRANGE("Phone No.", "CRM Integration Purchase"."Mobile No.");
                    IF RecVend.FINDFIRST THEN BEGIN
                        VendLedgEntry.RESET;
                        VendLedgEntry.SETCURRENTKEY("External Document No.");
                        VendLedgEntry.SETRANGE("Document Type", VendLedgEntry."Document Type"::Invoice);
                        VendLedgEntry.SETRANGE("External Document No.", "CRM Integration Purchase"."Vendor Invoice No");
                        VendLedgEntry.SETRANGE("Vendor No.", RecVend."No.");
                        VendLedgEntry.SETRANGE(Reversed, FALSE);
                        IF VendLedgEntry.FINDFIRST THEN
                            ERROR(
                              Text016,
                              VendLedgEntry."Document Type", "CRM Integration Purchase"."Vendor Invoice No");
                    END;
                    //WIN316++
                end;
            }

            trigger OnAfterAssignVariable()
            begin

                //IF "CRM Integration Purchase"."Mobile No."<>'' THEN
                RepPurCr.RUN;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    var
        RecVednor: Record Vendor;
        RepPurCr: Report "CRM Integration Purchase";
        RecVend: Record "Vendor";
        VendLedgEntry: Record "Vendor Ledger Entry";
        Text016: Label 'Purchase %1 %2 already exists for this vendor.';

    procedure CreateVendor("Mobile No.": Code[20])
    begin
        IF NOT "CRM Integration Purchase"."Vendor Created" THEN BEGIN
            RecVednor.RESET;
            RecVednor.SETRANGE(RecVednor."Phone No.", "Mobile No.");
            IF NOT RecVednor.FINDFIRST THEN BEGIN
                RecVednor."No." := "CRM Integration Purchase"."Vendor No.";
                RecVednor.Name := "CRM Integration Purchase".VendorName;
                RecVednor.Address := "CRM Integration Purchase".VendorAddress;
                RecVednor.City := "CRM Integration Purchase".City;
                RecVednor.VALIDATE("State Code", "CRM Integration Purchase"."State Code");
                RecVednor."Phone No." := "CRM Integration Purchase"."Mobile No.";
                RecVednor."GST Registration No." := "CRM Integration Purchase"."GST Registration No.";
                RecVednor."GST Vendor Type" := "CRM Integration Purchase"."GST Vendor Type";
                RecVednor.VALIDATE("Vendor Posting Group", 'DOMESTIC');
                RecVednor.VALIDATE("Gen. Bus. Posting Group", 'DOMESTIC');
                RecVednor.INSERT;
                COMMIT;
                "CRM Integration Purchase"."Vendor Created" := TRUE;
                // MESSAGE('Vendor Created');
            END;
        END;
    end;
}

