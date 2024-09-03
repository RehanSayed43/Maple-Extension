report 50091 "Customer Sales Data11"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Customer Sales Data11.rdl';
    Caption = 'Customer Sales Data';

    dataset
    {
        dataitem("Sales Invoice Line"; "Sales Invoice Line")
        {
            DataItemTableView = WHERE(Type = FILTER(Item));
            RequestFilterFields = "Posting Date", "Sell-to Customer No.", "Location Code";
            column(SelltoCustomerNo_SalesInvoiceLine; "Sales Invoice Line"."Sell-to Customer No.")
            {
            }
            column(DocumentNo_SalesInvoiceLine; "Sales Invoice Line"."Document No.")
            {
            }
            column(No_SalesInvoiceLine; "Sales Invoice Line"."No.")
            {
            }
            column(LocationCode_SalesInvoiceLine; "Sales Invoice Line"."Location Code")
            {
            }
            column(Quantity_SalesInvoiceLine; "Sales Invoice Line".Quantity)
            {
            }
            column(UnitPrice_SalesInvoiceLine; "Sales Invoice Line"."Unit Price")
            {
            }
            column(Amount_SalesInvoiceLine; "Sales Invoice Line".Amount)
            {
            }
            column(LineAmount_SalesInvoiceLine; "Sales Invoice Line"."Line Amount")
            {
            }
            column(PostingDate_SalesInvoiceLine; "Sales Invoice Line"."Posting Date")
            {
            }
            column(AmountToCustomer_SalesInvoiceLine; '')
            // column(AmountToCustomer_SalesInvoiceLine; "Sales Invoice Line"."Amount To Customer")
            {
            }
            column(ShieldType_SalesInvoiceLine; "Sales Invoice Line"."Shield Type")
            {
            }
            column(IMEINo_SalesInvoiceLine; UPPERCASE("Sales Invoice Line"."IMEI No."))
            {
            }
            column(Primarycategory_SalesInvoiceLine; "Sales Invoice Line"."Primary category")
            {
            }
            column(Secondarycategory_SalesInvoiceLine; "Sales Invoice Line"."Secondary category")
            {
            }
            column(Thirdcategory_SalesInvoiceLine; "Sales Invoice Line"."Third category")
            {
            }
            column(Contact; Contact)
            {
            }
            column(Email; Email)
            {
            }
            column(Name; Name)
            {
            }
            column(SP; SP)
            {
            }
            column(Shield_SalesInvoiceLine; FORMAT("Sales Invoice Line".Shield))
            {
            }
            column(SerialNo_SalesInvoiceLine; "Sales Invoice Line"."Serial No.")
            {
            }
            column(ShortcutDimension1Code_SalesInvoiceLine; "Sales Invoice Line"."Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code_SalesInvoiceLine; "Sales Invoice Line"."Shortcut Dimension 2 Code")
            {
            }
            column(StoreName; StoreName)
            {
            }
            column(Mobile; Mobile)
            {
            }
            column(ProductGroupCode_SalesInvoiceLine; '')
            // column(ProductGroupCode_SalesInvoiceLine; "Sales Invoice Line"."Product Group Code")
            {
            }
            column(TextFilter; TextFilter)
            {
            }
            column(ShieldValue_SalesInvoiceLine; "Sales Invoice Line"."Shield Value")
            {
            }
            column(ShieldAmt; ShieldAmt)
            {
            }
            column(ShieldwithTax; ShieldwithTax)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(Name);
                CLEAR(Email);
                CLEAR(Contact);
                CLEAR(Mobile);
                /*
                RecDim.RESET;
                RecDim.SETRANGE("Global Dimension No.",1);
                RecDim.SETRANGE(Code,"Sales Invoice Line"."Shortcut Dimension 1 Code");
                IF RecDim.FINDFIRST THEN
                  StoreName:= RecDim.Name
                ELSE
                  StoreName:='';

                */
                IF RecCust.GET("Sales Invoice Line"."Sell-to Customer No.") THEN BEGIN
                    Name := RecCust.Name;
                    Email := RecCust."E-Mail";
                    Contact := RecCust."Phone No.2";
                    Mobile := RecCust."Phone No.";
                END;
                IF ResSIH.GET("Sales Invoice Line"."Document No.") THEN BEGIN
                    IF RecSalesP.GET(ResSIH."Salesperson Code") THEN
                        SP := RecSalesP.Name
                    ELSE
                        SP := '';
                END;

                IF RecLoc.GET("Sales Invoice Line"."Location Code") THEN
                    StoreName := RecLoc."Name 2"
                ELSE
                    StoreName := '';

                IF "Sales Invoice Line"."Serial No." <> '' THEN
                    Serial_IMEINo := "Sales Invoice Line"."Serial No."
                ELSE
                    IF ("Sales Invoice Line"."Serial No." = '') AND ("Sales Invoice Line"."IMEI No." <> '') THEN
                        Serial_IMEINo := "Sales Invoice Line"."IMEI No.";




                ShieldAmt := 0;
                ShieldwithTax := 0;
                RecSIH.RESET;
                RecSIH.SETFILTER("Posting Date", "Sales Invoice Line".GETFILTER("Sales Invoice Line"."Posting Date"));
                //  RecSIH.SETRANGE("Ref. Invoice No.", "Document No.");
                IF RecSIH.FINDFIRST THEN BEGIN


                    RecSIL.RESET;
                    RecSIL.SETRANGE("Document No.", RecSIH."No.");

                    IF RecSIL.FINDSET THEN
                        REPEAT
                            //  ShieldwithTax += RecSIL."Amount To Customer";

                            ShieldAmt += RecSIL.Amount;
                        UNTIL RecSIL.NEXT = 0;

                END;

            end;

            trigger OnPreDataItem()
            begin
                TextFilter := "Sales Invoice Line".GETFILTER("Sales Invoice Line"."Posting Date");
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

    labels
    {
    }

    trigger OnPreReport()
    begin
        TextFilter := '';
    end;

    var
        RecCust: Record Customer;
        Contact: Code[50];
        Email: Text;
        ResSIH: Record "Sales Invoice Header";
        Name: Text;
        SP: Code[30];
        RecLoc: Record Location;
        StoreName: Text;
        Mobile: Text;
        Serial_IMEINo: Text;
        RecSalesP: Record "Salesperson/Purchaser";
        RecDim: Record "Dimension Value";
        TextFilter: Text;
        RecSIL: Record "Sales Invoice Line";
        RecSIH: Record "Sales Invoice Header";
        ShieldAmt: Decimal;
        ShieldwithTax: Decimal;
}

