xmlport 50071 Update_CLE_Records
{
    Direction = Import;
    Format = VariableText;
    Permissions = TableData "G/L Entry" = rmd,
                  tabledata "Cust. Ledger Entry" = rmd,
                  tabledata "Detailed Cust. Ledg. Entry" = rmd;
    schema
    {
        textelement(Root)
        {
            tableelement(Integer; Integer)
            {
                AutoSave = false;
                XmlName = 'Integer';
                UseTemporary = true;
                textelement(DocumentNo)
                {
                    MinOccurs = Once;
                }
                textelement(Amt) { }
                trigger OnAfterInsertRecord()
                begin
                    //Message(DocumentNo);
                    Evaluate(GLAmt, Amt);
                    CLE.Reset();
                    CLE.SetRange("Document No.", DocumentNo);
                    CLE.SetFilter("Remaining Amount", '<>%1', 0);
                    if CLE.FindFirst() then begin
                        CustLedEntry.Reset();
                        CustLedEntry.SetRange("Document No.", DocumentNo);
                        if CustLedEntry.FindFirst() then begin
                            CustLedEntry.Amount := GLAmt;
                            CustLedEntry."Amount (LCY)" := GLAmt;
                            CustLedEntry."Remaining Amt. (LCY)" := GLAmt;
                            if GLAmt >= 0 then begin
                                CustLedEntry."Debit Amount (LCY)" := Abs(GLAmt);
                                CustLedEntry."Debit Amount" := Abs(GLAmt);
                                CustLedEntry."Credit Amount (LCY)" := 0;
                                CustLedEntry."Credit Amount" := 0;
                            end;
                            if GLAmt <= 0 then begin
                                CustLedEntry."Credit Amount (LCY)" := Abs(GLAmt);
                                CustLedEntry."Credit Amount" := Abs(GLAmt);
                                CustLedEntry."Debit Amount (LCY)" := 0;
                                CustLedEntry."Debit Amount" := 0;
                            end;
                            CustLedEntry.Modify(true);
                        end;

                        DetCustLEntry.Reset();
                        DetCustLEntry.SetRange("Document No.", DocumentNo);
                        if DetCustLEntry.FindFirst() then begin
                            DetCustLEntry.Amount := GLAmt;
                            DetCustLEntry."Amount (LCY)" := GLAmt;
                            if GLAmt >= 0 then begin
                                DetCustLEntry."Debit Amount (LCY)" := Abs(GLAmt);
                                DetCustLEntry."Debit Amount" := Abs(GLAmt);
                                DetCustLEntry."Credit Amount" := 0;
                                DetCustLEntry."Credit Amount (LCY)" := 0;
                            end;
                            if GLAmt <= 0 then begin
                                DetCustLEntry."Credit Amount" := Abs(GLAmt);
                                DetCustLEntry."Credit Amount (LCY)" := Abs(GLAmt);
                                DetCustLEntry."Debit Amount (LCY)" := 0;
                                DetCustLEntry."Debit Amount" := 0;
                            end;
                            DetCustLEntry.Modify(true);
                        end;

                        GLE.Reset();
                        GLE.SetRange(GLE."Document No.", CustLedEntry."Document No.");
                        GLE.SetRange(GLE."Bal. Account Type", GLE."Bal. Account Type"::"G/L Account");
                        if GLE.FindSet() then
                            repeat
                                GLE.Amount := GLAmt;
                                if GLAmt >= 0 then begin
                                    GLE."Debit Amount" := Abs(GLAmt);
                                    GLE."Credit Amount" := 0;
                                end else begin
                                    GLE."Credit Amount" := Abs(GLAmt);
                                    GLE."Debit Amount" := 0;
                                end;
                                GLE.Modify(true);
                            UNTIL GLE.NEXT = 0;

                        glEntry.Reset();
                        glEntry.SetRange(glEntry."Document No.", CustLedEntry."Document No.");  // DocumentNo);
                        glEntry.SetRange(glEntry."Bal. Account Type", glEntry."Bal. Account Type"::Customer);
                        if glEntry.FindSet() then
                            repeat
                                glEntry.Amount := -1 * (GLAmt);

                                if GLAmt < 0 then begin
                                    glEntry."Debit Amount" := Abs(GLAmt);
                                    glEntry."Credit Amount" := 0;
                                end else begin
                                    glEntry."Credit Amount" := Abs(GLAmt);
                                    glEntry."Debit Amount" := 0;
                                end;
                                glEntry.Modify(true);
                            UNTIL glEntry.NEXT = 0;
                    end;
                end;
            }
            trigger OnAfterAssignVariable()
            var
            begin
                Message('Records Updated Successfully');
            end;
        }
    }

    requestpage
    { }

    var
        glEntry: Record "G/L Entry";

        GLE: Record "G/L Entry";
        CLE: Record "Cust. Ledger Entry";
        CustLedEntry: Record "Cust. Ledger Entry";
        DetCustLEntry: Record "Detailed Cust. Ledg. Entry";
        RemAmt: Decimal;
        GLAmt: Decimal;
        DocNo: Code[20];
        Entry: Integer;
}

