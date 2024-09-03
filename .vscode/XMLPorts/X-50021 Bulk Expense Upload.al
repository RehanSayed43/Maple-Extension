xmlport 50021 "Bulk Expense Upload"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Bulk Expense booking"; "Bulk Expense booking")
            {
                XmlName = 'BulkExpensebooking';
                fieldelement("Vendor_No."; "Bulk Expense booking"."Vendor No.")
                {
                    MinOccurs = Once;
                }
                fieldelement(Vendor_Invoice_No; "Bulk Expense booking"."Vendor Invoice No")
                {
                }
                fieldelement(Vendor_Inv_Date; "Bulk Expense booking"."Vendor Invoice Date")
                {
                }
                fieldelement(Posting_Date; "Bulk Expense booking"."Posting Date")
                {
                }
                fieldelement("ShourtCut-Dim-1"; "Bulk Expense booking"."Shortcut Dimension 1 Code")
                {
                }
                fieldelement("Shourtcut-dim-2"; "Bulk Expense booking"."Shortcut Dimension 2 Code")
                {
                }
                // fieldelement(Structure; "Bulk Expense booking".Structure)
                fieldelement("GST-Credit"; "Bulk Expense booking"."GST Credit") //TK


                {
                }
                fieldelement(TDS_Nature_of_Deduction; "Bulk Expense booking"."TDS Nature of Deduction")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Location_Code; "Bulk Expense booking"."Location Code")
                {
                }
                fieldelement("No."; "Bulk Expense booking"."No.")
                {
                }
                fieldelement(Quantity; "Bulk Expense booking".Quantity)
                {
                }
                fieldelement(Unit_Price_With_Tax; "Bulk Expense booking"."Unit Price With Tax")
                {
                }
                fieldelement(GST_Group_Code; "Bulk Expense booking"."GST Group Code")
                {
                }
                fieldelement(HSNSA_Code; "Bulk Expense booking"."HSN/SAC Code")
                {
                }
                fieldelement(Comments; "Bulk Expense booking".Comments)
                {
                }
                fieldelement(Apply_to_Document_Type; "Bulk Expense booking"."Apply to Document Type")
                {
                    MinOccurs = Zero;
                }
                fieldelement("Apply_to_Doc._No."; "Bulk Expense booking"."Applies-to Doc. No.")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Vendor_Invoice_Value; "Bulk Expense booking"."Vendor Invoice Value")
                {
                }

                trigger OnAfterInitRecord()
                begin
                    IF FirstLine THEN BEGIN
                        FirstLine := FALSE;
                        currXMLport.SKIP;
                    END;
                end;
            }
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

    trigger OnInitXmlPort()
    begin
        FirstLine := TRUE;
    end;

    var
        FirstLine: Boolean;
        RecBulk: Record "E-Invoice Log";
}

