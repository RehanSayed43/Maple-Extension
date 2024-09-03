xmlport 50072 Update_VLE_Records
{
    Direction = Import;
    Format = VariableText;
    Permissions = TableData "G/L Entry" = rmd,
                  tabledata "Vendor Ledger Entry" = rmd,
                  tabledata "Detailed Vendor Ledg. Entry" = rmd;
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

                    VLE.Reset();
                    VLE.SetRange("Document No.", DocumentNo);
                    VLE.SetFilter("Remaining Amount", '<>%1', 0);
                    if VLE.FindFirst() then begin
                        VendLedEntry.Reset();
                        VendLedEntry.SetRange("Document No.", DocumentNo);
                        if VendLedEntry.FindFirst() then begin
                            VendLedEntry.Amount := GLAmt;
                            VendLedEntry."Amount (LCY)" := GLAmt;
                            VendLedEntry."Remaining Amt. (LCY)" := GLAmt;
                            if GLAmt >= 0 then begin
                                VendLedEntry."Debit Amount (LCY)" := Abs(GLAmt);
                                VendLedEntry."Debit Amount" := Abs(GLAmt);
                                VendLedEntry."Credit Amount (LCY)" := 0;
                                VendLedEntry."Credit Amount" := 0;
                            end;
                            if GLAmt <= 0 then begin
                                VendLedEntry."Credit Amount (LCY)" := Abs(GLAmt);
                                VendLedEntry."Credit Amount" := Abs(GLAmt);
                                VendLedEntry."Debit Amount (LCY)" := 0;
                                VendLedEntry."Debit Amount" := 0;
                            end;
                            VendLedEntry.Modify(true);
                        end;

                        DetVendLEntry.Reset();
                        DetVendLEntry.SetRange("Document No.", DocumentNo);
                        if DetVendLEntry.FindFirst() then begin
                            DetVendLEntry.Amount := GLAmt;
                            DetVendLEntry."Amount (LCY)" := GLAmt;
                            if GLAmt >= 0 then begin
                                DetVendLEntry."Debit Amount (LCY)" := Abs(GLAmt);
                                DetVendLEntry."Debit Amount" := Abs(GLAmt);
                                DetVendLEntry."Credit Amount" := 0;
                                DetVendLEntry."Credit Amount (LCY)" := 0;
                            end;
                            if GLAmt <= 0 then begin
                                DetVendLEntry."Credit Amount" := Abs(GLAmt);
                                DetVendLEntry."Credit Amount (LCY)" := Abs(GLAmt);
                                DetVendLEntry."Debit Amount (LCY)" := 0;
                                DetVendLEntry."Debit Amount" := 0;
                            end;
                            DetVendLEntry.Modify(true);
                        end;

                        GLE.Reset();
                        GLE.SetRange(GLE."Document No.", VendLedEntry."Document No.");
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
                        glEntry.SetRange(glEntry."Document No.", VendLedEntry."Document No.");  // DocumentNo);
                        glEntry.SetRange(glEntry."Bal. Account Type", glEntry."Bal. Account Type"::Vendor);
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
                    end;//VLE End
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
        VLE: Record "Vendor Ledger Entry";
        VendLedEntry: Record "Vendor Ledger Entry";
        DetVendLEntry: Record "Detailed Vendor Ledg. Entry";
        RemAmt: Decimal;
        GLAmt: Decimal;
        DocNo: Code[20];
        Entry: Integer;
}

