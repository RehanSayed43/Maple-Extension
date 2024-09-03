xmlport 50020 "Customer Master"
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Customer; Customer)
            {
                AutoReplace = true;
                XmlName = 'Customer';
                fieldelement(No; Customer."No.")
                {
                }
                fieldelement(Name; Customer.Name)
                {
                }
                fieldelement(SearchName; Customer."Search Name")
                {
                }
                fieldelement(Address; Customer.Address)
                {
                }
                fieldelement(Address2; Customer."Address 2")
                {
                }
                fieldelement(City; Customer.City)
                {
                    MinOccurs = Once;
                }
                fieldelement(Contact; Customer.Contact)
                {
                    MinOccurs = Zero;
                }
                fieldelement(PhoneNo; Customer."Phone No.")
                {
                }
                fieldelement(TelexNo; Customer."Telex No.")
                {
                }
                fieldelement(GD1; Customer."Global Dimension 1 Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(CreditLimit; Customer."Credit Limit (LCY)")
                {
                    MinOccurs = Zero;
                }
                fieldelement(CustPosGrp; Customer."Customer Posting Group")
                {
                }
                fieldelement(Currency; Customer."Currency Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(PaymentTerms; Customer."Payment Terms Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(SalesPerson; Customer."Salesperson Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(ShipmentMethodCode; Customer."Shipment Method Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(ShippingAgent; Customer."Shipping Agent Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Country; Customer."Country/Region Code")
                {
                }
                fieldelement(Amount; Customer.Amount)
                {
                    MinOccurs = Zero;
                }
                fieldelement(BillToCust; Customer."Bill-to Customer No.")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Priority; Customer.Priority)
                {
                    MinOccurs = Zero;
                }
                fieldelement(PaymentMethod; Customer."Payment Method Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(LocationCode; Customer."Location Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(FaxNo; Customer."Fax No.")
                {
                    MinOccurs = Zero;
                }
                fieldelement(VATReg; Customer."VAT Registration No.")
                {
                    MinOccurs = Zero;
                }
                fieldelement(GenBusPos; Customer."Gen. Bus. Posting Group")
                {
                }
                fieldelement(PostCode; Customer."Post Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(County; Customer.County)
                {
                    MinOccurs = Zero;
                }
                fieldelement(HomePage; Customer."Home Page")
                {
                    MinOccurs = Zero;
                }
                fieldelement(NoSeries; Customer."No. Series")
                {
                    MinOccurs = Zero;
                }
                fieldelement(TaxAreaCode; Customer."Tax Area Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(TaxLiable; Customer."Tax Liable")
                {
                }
                fieldelement(VATBus; Customer."VAT Bus. Posting Group")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Reserve; Customer.Reserve)
                {
                    MinOccurs = Zero;
                }
                // fieldelement(PreffBankAcc; Customer."Preferred Bank Account")
                // {
                //     MinOccurs = Zero;
                // }
                fieldelement(PrimartCont; Customer."Primary Contact No.")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Responsibility; Customer."Responsibility Center")
                {
                    MinOccurs = Zero;
                }
                /* Rahul
                // fieldelement(TIN; Customer."T.I.N. No.")
                // {
                //     MinOccurs = Zero;
                // }
                // fieldelement(LST; Customer."L.S.T. No.")
                // {
                //     MinOccurs = Zero;
                // }
                // fieldelement(CST; Customer."C.S.T. No.")
                // {
                //     MinOccurs = Zero;
                // }

                 rahul  */
                fieldelement(PAN; Customer."P.A.N. No.")
                {
                    MinOccurs = Zero;
                }
                // fieldelement(ECC; Customer."E.C.C. No.")
                // {
                //     MinOccurs = Zero;
                // }
                fieldelement(State; Customer."State Code")
                {
                }
                // fieldelement(Structure; Customer.Structure)
                // {
                //     MinOccurs = Zero;
                // }
                fieldelement(PANRef; Customer."P.A.N. Reference No.")
                {
                    MinOccurs = Zero;
                }
                fieldelement(PANStatus; Customer."P.A.N. Status")
                {
                    MinOccurs = Zero;
                }
                // fieldelement(VATExempt; Customer."VAT Exempted")
                // {
                //     MinOccurs = Zero;
                // }
                fieldelement(CustState; Customer."Customer State Code")
                {
                }
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
}

