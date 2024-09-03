xmlport 50031 "Sales Invoice Header Dump"
{
    Direction = Export;
    FileName = '.csv';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Integer; Integer)
            {
                XmlName = 'Caption';
                // SourceTableView = SORTING(Field1)
                //                   WHERE(Field1 = CONST(1));
                textelement(Doc_No)
                {

                    trigger OnBeforePassVariable()
                    begin
                        Doc_No := 'Document No.';
                    end;
                }
                textelement(Posting_Date)
                {

                    trigger OnBeforePassVariable()
                    begin
                        Posting_Date := 'Posting Date';
                    end;
                }
                textelement(PayByCrd_No3)
                {

                    trigger OnBeforePassVariable()
                    begin
                        PayByCrd_No3 := 'Pay By Credit Card No3';
                    end;
                }
                textelement(PayByCrd_No4)
                {

                    trigger OnBeforePassVariable()
                    begin
                        PayByCrd_No4 := 'Pay By Credit Card No4';
                    end;
                }
                textelement(PayByCheq_No)
                {

                    trigger OnBeforePassVariable()
                    begin
                        PayByCheq_No := 'Pay By Cheque No.';
                    end;
                }
            }
            tableelement("Sales Invoice Header"; "Sales Invoice Header")
            {
                //   RequestFilterFields = Field20;
                XmlName = 'SIV';
                fieldelement(NO_; "Sales Invoice Header"."No.")
                {
                }
                fieldelement(POstingDate_; "Sales Invoice Header"."Posting Date")
                {
                }
                /* rahul
                fieldelement(PayByCreditNo3; "Sales Invoice Header".PayByCreditNo3)
                {
                }
                fieldelement(PayByCreditNo4; "Sales Invoice Header".PayByCreditNo4)
                {
                }
                fieldelement(PayByChequeNo; "Sales Invoice Header".PayByChqNo)
                {
                }
                */
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

