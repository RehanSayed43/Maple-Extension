xmlport 50067 "Customer Data"
{
    Format = VariableText;
    Direction = Export;

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

                fieldelement(Address; Customer.Address)
                {
                }

                fieldelement(City; Customer.City)
                {
                    MinOccurs = Once;
                }

                fieldelement(PostCode; Customer."Post Code")
                {
                    MinOccurs = Zero;
                }

                fieldelement(State; Customer."State Code")
                {
                }

                fieldelement(CustState; Customer."Customer State Code")
                {
                }
                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    /*
                    RecCust.Reset();
                    RecCust.SetRange(RecCust."No.", Customer."No.");
                    RecCust.SetFilter(RecCust.City, '%1=', 'Delhi');
                    RecCust.SetFilter(RecCust."State Code", '%1=', 'MH');
                    If RecCust.FindFirst() then begin

                    end;
*/


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
    var
        RecCust: Record customer;
}

