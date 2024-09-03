report 50197 "Apply Customer Entries"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ApplyCustomerEntries.rdl';
    ApplicationArea = FixedAsset;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = WHERE(Blocked = FILTER(<> All));
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                CalcFields = "Debit Amount";
                DataItemLink = "Customer No." = FIELD("No.");
                DataItemTableView = SORTING("Customer No.", "Posting Date", "Currency Code")
                                    ORDER(Ascending)
                                    WHERE(Open = FILTER(true),
                                          "Debit Amount" = FILTER(<> 0));

                trigger OnAfterGetRecord()
                var
                    CustLedgEntry: Record "Cust. Ledger Entry";
                    CustEntryApplyPostEntries: Codeunit 226;
                begin
                    IF "Cust. Ledger Entry"."Debit Amount" <> 0 THEN BEGIN
                        "Cust. Ledger Entry".CALCFIELDS("Cust. Ledger Entry"."Remaining Amount");
                        IF ("Cust. Ledger Entry"."Remaining Amount" <> 0) THEN BEGIN
                            CustLedgEntry.RESET;
                            CustLedgEntry := "Cust. Ledger Entry";
                            CLEAR(CustEntryApplyPostEntries);
                            //  CustEntryApplyPostEntries.ApplyCustEntryFormEntryCustomize(CustLedgEntry);
                            COMMIT;
                        END;
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

    labels
    {
    }
}

