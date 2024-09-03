xmlport 50015 "Customer Set Off"
{
    Direction = Import;
    FileName = 'Customer Setoff.csv';
    Format = VariableText;
    FormatEvaluate = Legacy;

    schema
    {
        textelement(root)
        {
            tableelement("Customer Set Off"; "Customer Set Off")
            {
                XmlName = 'Customer_set_off';
                fieldelement(Posting_date; "Customer Set Off"."Posting Date")
                {
                }
                fieldelement(Document_no; "Customer Set Off"."Document No")
                {
                }
                fieldelement(account_type; "Customer Set Off"."Account Type")
                {
                }
                fieldelement(Account_no; "Customer Set Off"."Account No.")
                {
                }
                fieldelement(amount; "Customer Set Off".Amount)
                {
                }
                fieldelement(Bal_acc_type; "Customer Set Off"."Bal. Account Type")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Bal_acc_no; "Customer Set Off"."Bal. Account No.")
                {
                    MinOccurs = Zero;
                }
                fieldelement(shoty_dim_1; "Customer Set Off"."Shortcut Dimension 1 Code")
                {
                }
                fieldelement(shoty_dim_2; "Customer Set Off"."Shortcut Dimension 2 Code")
                {
                }
                fieldelement(app_to_doc_type; "Customer Set Off"."Applies-to Doc. Type")
                {
                }
                fieldelement(app_to_doc_no; "Customer Set Off"."Applies-to Doc. No.")
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

    trigger OnPostXmlPort()
    begin

        CODEUNIT.RUN(50006);
        MESSAGE('Done');
    end;
}

