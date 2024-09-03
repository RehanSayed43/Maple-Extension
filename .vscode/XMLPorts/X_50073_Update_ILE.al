xmlport 50073 Update_ILE
{
    Direction = Import;
    Format = VariableText;
    Permissions = TableData "G/L Entry" = rmd,
                  tabledata "Item Ledger Entry" = rmd,
                  tabledata "Value Entry" = rmd,
                  tabledata "Sales Invoice Line" = rmd,
                  tabledata "Sales Cr.Memo Line" = rmd;
    schema
    {
        textelement(Root)
        {
            tableelement(Integer; Integer)
            {
                AutoSave = false;
                XmlName = 'Integer';
                UseTemporary = true;

                textelement(EntryNo) { MinOccurs = Once; }
                textelement(itemNo) { }
                //textelement(DocumentNo) { MinOccurs = Once; }
                //textelement(Amt) { }

                textelement(IMEI)
                {
                    MinOccurs = Zero;
                }
                trigger OnAfterInsertRecord()
                begin
                    // Evaluate(GLAmt, Amt);
                    Evaluate(EntryNoILE, EntryNo);
                    Evaluate(It_No, itemNo);

                    ILE.Reset();
                    ILE.SetRange(ILE."Entry No.", EntryNoILE);
                    ILE.SetRange(ILE."Item No.", It_No);
                    if ILE.FindSet() then begin
                        ILE."IMEI No." := IMEI;
                        ILE.Modify(true);
                    end;
                    VE.Reset();
                    VE.SetRange("Item Ledger Entry No.", ILE."Entry No.");
                    if VE.FindSet() then
                        repeat
                            DocNo := VE."Document No.";
                        //if SIHeader.get(DocNo) then begin

                        //end;
                        until VE.Next() = 0;

                    SILine.Reset();
                    SILine.SetRange("Document No.", DocNo);
                    SILine.SetRange("No.", It_No);
                    if SILine.FindSet() then
                        repeat
                            SILine."IMEI No." := IMEI;
                            SILine.Modify(true);
                        until SILine.Next() = 0;

                    SCMLine.Reset();
                    SCMLine.SetRange("Document No.", DocNo);
                    SCMLine.SetRange("No.", It_No);
                    if SCMLine.FindSet() then
                        repeat
                            SCMLine."IMEI No." := IMEI;
                            SCMLine.Modify(true);
                        until SCMLine.Next() = 0;

                    /*  ILE.Reset();
                      ILE.SetRange("Document No.", DocumentNo);
                      if ILE.FindFirst() then begin
                          ILE."Cost Amount (Actual)" := GLAmt;
                          ILE."IMEI No." := IMEI;
                          ILE.Modify(true);
                      end;

                      VE.Reset();
                      VE.SetRange("Document No.", DocumentNo);
                      if VE.FindFirst() then begin
                          VE."Cost Amount (Actual)" := GLAmt;
                          VE."Purchase Amount (Actual)" := GLAmt;
                          VE."Cost Posted to G/L" := GLAmt;
                          VE."Cost per Unit" := GLAmt;
                          VE.Modify(true);
                      end;

                      GLE.Reset();
                      GLE.SetRange(GLE."Document No.", ILE."Document No.");
                      GLE.SetRange(GLE."G/L Account No.", '224001');
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
                      glEntry.SetRange(glEntry."Document No.", ILE."Document No.");
                      glEntry.SetRange(glEntry."G/L Account No.", '900130');
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
                      */
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
        VE: Record "Value Entry";
        ILE: Record "Item Ledger Entry";
        SIHeader: Record "Sales Invoice Header";
        SILine: Record "Sales Invoice Line";
        SCMLine: Record "Sales Cr.Memo Line";
        ILE2: Record "Item Ledger Entry";
        RemAmt: Decimal;
        GLAmt: Decimal;
        DocNo: Code[20];
        EntryNoILE: Integer;
        It_No: Code[60];
}

