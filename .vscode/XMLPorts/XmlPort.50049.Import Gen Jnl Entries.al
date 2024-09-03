XmlPort 50049 "Import Gen. Jnl. Entries"
{
    // LFS-RAG-1180.00 : 15/10/2018 : Added code


    //FieldDelimiter = '<None>';
    //FieldSeparator = '<TAB>';
    Format = VariableText;
    Direction = Import;


    schema
    {
        textelement(root)
        {
            tableelement("Gen. Journal Line"; "Gen. Journal Line")
            {
                AutoSave = false;
                ///AutoReplace = true;

                XmlName = 'GenJnlLine';


                textelement(JnlTemplate)
                {
                    MinOccurs = once;
                }
                textelement(JnlBatch)
                {
                    MinOccurs = ZERO;
                }
                textelement(LineNoText)
                {
                    MinOccurs = ZERO;
                }
                textelement(DocumentTypeText)
                {
                    MinOccurs = zero;
                }
                textelement(PostingDateText)
                {
                    MinOccurs = zero;
                }

                textelement(ExtDocNo)
                {
                    MinOccurs = zero;
                }
                textelement(DocumentDateText)
                {
                    MinOccurs = zero;
                }

                textelement(DueDateText)
                {
                    MinOccurs = zero;
                }
                textelement(DocumentNoText)
                {
                }

                textelement(AccTypeText)
                {
                    MinOccurs = zero;
                }
                textelement(AccNo)
                {
                    MinOccurs = zero;
                }
                textelement(DepBookCodeText)
                {
                    MinOccurs = zero;
                }
                textelement(FAPostingTypeText)
                {
                    MinOccurs = zero;
                }

                textelement(DescriptionText)
                {
                    MinOccurs = zero;
                }
                textelement(AmtText)
                {
                    MinOccurs = zero;
                }

                textelement(BalAccTypeText)
                {
                    MinOccurs = zero;
                }
                textelement(BalAccNo)
                {
                    MinOccurs = zero;
                }
                textelement(AreaDim)
                {
                    MinOccurs = zero;
                }
                textelement(BusinessDim)
                {
                    MinOccurs = Zero;
                }
                textelement(ShortcutDim3)
                {
                    MinOccurs = Zero;
                }

                trigger OnAfterInsertRecord()
                begin
                    GenJnlTemp.Get(JnlTemplate);
                    GenJnlBatch.Get(JnlTemplate, JnlBatch);

                    if PostingDateText <> '' then
                        Evaluate(PostingDate, PostingDateText);

                    // if DocumentNo = '' then
                    //     DocumentNo := NoSerMngt.GetNextNo(GenJnlBatch."No. Series", PostingDate, TRUE); //NoSerMngt.TryGetNextNo(GenJnlBatch."No. Series", PostingDate);

                    // ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund
                    if UpperCase(DocumentTypeText) = 'PAYMENT' then
                        DocType := 1
                    else
                        if UpperCase(DocumentTypeText) = 'INVOICE' then
                            DocType := 2
                        else
                            if UpperCase(DocumentTypeText) = 'CREDIT MEMO' then
                                DocType := 3
                            else
                                if UpperCase(DocumentTypeText) = 'FINANCE CHARGE' then
                                    DocType := 4
                                else
                                    if UpperCase(DocumentTypeText) = 'REMINDER' then
                                        DocType := 5
                                    else
                                        if UpperCase(DocumentTypeText) = 'REFUND' then
                                            DocType := 6
                                        else
                                            DocType := 0;
                    // if ChqDateText <> '' then
                    //     Evaluate(ChqDate, ChqDateText);
                    //G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner
                    if UpperCase(AccTypeText) = UpperCase('G/L Account') then
                        AccType := 0
                    else
                        if UpperCase(AccTypeText) = UpperCase('Customer') then
                            AccType := 1
                        else
                            if UpperCase(AccTypeText) = UpperCase('Vendor') then
                                AccType := 2
                            else
                                if UpperCase(AccTypeText) = UpperCase('Bank Account') then
                                    AccType := 3
                                else
                                    if UpperCase(AccTypeText) = UpperCase('Fixed Asset') then
                                        AccType := 4
                                    else
                                        if UpperCase(AccTypeText) = UpperCase('IC Partner') then
                                            AccType := 5;

                    if UpperCase(BalAccTypeText) = UpperCase('G/L Account') then
                        BalAccType := 0
                    else
                        if UpperCase(BalAccTypeText) = UpperCase('Customer') then
                            BalAccType := 1
                        else
                            if UpperCase(BalAccTypeText) = UpperCase('Vendor') then
                                BalAccType := 2
                            else
                                if UpperCase(BalAccTypeText) = UpperCase('Bank Account') then
                                    BalAccType := 3
                                else
                                    if UpperCase(BalAccTypeText) = UpperCase('Fixed Asset') then
                                        BalAccType := 4
                                    else
                                        if UpperCase(BalAccTypeText) = UpperCase('IC Partner') then
                                            BalAccType := 5;

                    if DepBookCodeText <> '' then
                        Evaluate(DepBookCode, DepBookCodeText);

                    // if FAPostingDateText <> '' then
                    //     Evaluate(FAPostingDate, FAPostingDateText);//tk

                    // ,Acquisition Cost,Depreciation,Write-Down,Appreciation,Custom 1,Custom 2,Disposal,Maintenance
                    if UpperCase(FAPostingTypeText) = UpperCase('Acquisition Cost') then
                        FAPostingType := 1
                    else
                        if UpperCase(FAPostingTypeText) = UpperCase('Depreciation') then
                            FAPostingType := 2
                        else
                            if UpperCase(FAPostingTypeText) = UpperCase('Write-Down') then
                                FAPostingType := 3
                            else
                                if UpperCase(FAPostingTypeText) = UpperCase('Appreciation') then
                                    FAPostingType := 4
                                else
                                    if UpperCase(FAPostingTypeText) = UpperCase('Custom 1') then
                                        FAPostingType := 5
                                    else
                                        if UpperCase(FAPostingTypeText) = UpperCase('Custom 2') then
                                            FAPostingType := 6
                                        else
                                            if UpperCase(FAPostingTypeText) = UpperCase('Disposal') then
                                                FAPostingType := 7
                                            else
                                                if UpperCase(FAPostingTypeText) = UpperCase('Maintenance') then
                                                    FAPostingType := 8
                                                else
                                                    FAPostingType := 0;

                    if AmtText <> '' then
                        Evaluate(LineAmount, AmtText);
                    If DocumentNoText <> '' then
                        Evaluate(DocumentNo, DocumentNoText);

                    //LFS-RAG-1180.00++
                    // if UpperCase(AppliesToDOcType) = UpperCase('') then
                    //     AppliesToDocTypeint := 0
                    // else
                    //     if UpperCase(AppliesToDOcType) = UpperCase('Payment') then
                    //         AppliesToDocTypeint := 1
                    //     else
                    //         if UpperCase(AppliesToDOcType) = UpperCase('Invoice') then
                    //             AppliesToDocTypeint := 2
                    //         else
                    //             if UpperCase(AppliesToDOcType) = UpperCase('Credit Memo') then
                    //                 AppliesToDocTypeint := 3
                    //             else
                    //                 if UpperCase(AppliesToDOcType) = UpperCase('Finance Charge Memo') then
                    //                     AppliesToDocTypeint := 4
                    //                 else
                    //                     if UpperCase(AppliesToDOcType) = UpperCase('Reminder') then
                    //                         AppliesToDocTypeint := 5
                    //                     else
                    //                         if UpperCase(AppliesToDOcType) = UpperCase('Refund') then
                    //                             AppliesToDocTypeint := 6;
                    // //LFS-RAG-1180.00--

                    if LineAmount <> 0 then begin
                        // GenJnlLine.Reset;
                        // GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JnlTemplate);
                        // GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JnlBatch);
                        // if GenJnlLine.FindLast then
                        //     LineNo := GenJnlLine."Line No." + 10000
                        // else
                        //     LineNo := 10000;

                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name" := JnlTemplate;
                        GenJnlLine."Journal Batch Name" := JnlBatch;
                        If LineNoText <> '' then
                            Evaluate(LineNo, LineNoText);
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine.Insert(true);
                        If PostingDateText <> '' then begin
                            Evaluate(PostingDate, format(PostingDateText, 0, 9));
                            GenJnlLine.Validate("Posting Date", PostingDate);
                        end;

                        GenJnlLine.Validate(GenJnlLine."Document Type", DocType);
                        GenJnlLine."Document No." := DocumentNo;
                        if DocumentDateText <> '' then begin
                            Evaluate(DocumentDate, format(DocumentDateText, 0, 9));
                            GenJnlLine."Document Date" := DocumentDate;
                        end;
                        // Message('%1', DocumentDate);

                        if DueDateText <> '' then begin
                            Evaluate(DueDate, Format(DueDateText, 0, 9));
                            GenJnlLine."Due Date" := DueDate;
                        end;

                        GenJnlLine.Validate(GenJnlLine."Account Type", AccType);
                        GenJnlLine.Validate(GenJnlLine."Account No.", AccNo);
                        If DepBookCodeText <> '' then
                            GenJnlLine.Validate(GenJnlLine."Depreciation Book Code", DepBookCode);
                        if FAPostingDate <> 0D then
                            GenJnlLine.Validate(GenJnlLine."FA Posting Date", FAPostingDate);
                        GenJnlLine.Validate(GenJnlLine."FA Posting Type", FAPostingType);
                        GenJnlLine.Validate(GenJnlLine.Description, Description);
                        if ExtDocNo <> '' then
                            GenJnlLine."External Document No." := ExtDocNo;
                        GenJnlLine.Validate(GenJnlLine.Amount, LineAmount);
                        GenJnlLine.Validate(GenJnlLine."Bal. Account Type", BalAccType);
                        GenJnlLine.Validate(GenJnlLine."Bal. Account No.", BalAccNo);
                        //  GenJnlLine."Cheque Date" := ChqDate;
                        //  GenJnlLine."Cheque No." := ChqNo;
                        GenJnlLine.Validate("Source Code", GenJnlTemp."Source Code");
                        GenJnlLine.Validate("Journal Template Name", GenJnlTemp.Name);
                        if AreaDim <> '' then
                            GenJnlLine.Validate("Shortcut Dimension 1 Code", AreaDim);
                        if BusinessDim <> '' then
                            GenJnlLine.Validate("Shortcut Dimension 2 Code", BusinessDim);
                        // if AlloKey <> '' then
                        //     GenJnlLine.Validate("Allocation Key", AlloKey);//tk
                        GenJnlLine.Modify(true);
                        if AppliesToDocTypeint > 0 then
                            GenJnlLine.Validate("Applies-to Doc. Type", AppliesToDocTypeint);  //LFS-RAG-1180.00
                                                                                               // GenJnlLine.Validate("Applies-to Doc. No.", AppliesToDOc);  //LFS-RAG-1180.00
                        GenJnlLine.Modify(true);

                        GLSetup.Get();
                        OldDimSetID := 0;
                        NewDimSetID := 0;
                        TempDimSetEntry.Reset;
                        if TempDimSetEntry.FindFirst then
                            TempDimSetEntry.DeleteAll;

                        OldDimSetID := GenJnlLine."Dimension Set ID";
                        DimMgt.GetDimensionSet(TempDimSetEntry, GenJnlLine."Dimension Set ID");

                        //Message('%1', GenJnlLine."Dimension Set ID");
                        if ShortcutDim3 <> '' then begin
                            TempDimSetEntry.Reset;
                            TempDimSetEntry.SetRange("Dimension Code", GLSetup."Shortcut Dimension 3 Code");
                            if TempDimSetEntry.FindFirst then begin
                                TempDimSetEntry.Validate("Dimension Value Code", ShortcutDim3);
                                TempDimSetEntry.Modify;
                            end
                            else begin
                                TempDimSetEntry.Init;
                                TempDimSetEntry.Validate("Dimension Code", GLSetup."Shortcut Dimension 3 Code");
                                TempDimSetEntry.Validate("Dimension Value Code", ShortcutDim3);
                                TempDimSetEntry.Insert;
                            end;
                        END;
                        // if ShortcutDim4 <> '' then begin
                        //     TempDimSetEntry.Reset;
                        //     TempDimSetEntry.SetRange("Dimension Code", GLSetup."Shortcut Dimension 4 Code");
                        //     if TempDimSetEntry.FindFirst then begin
                        //         TempDimSetEntry.Validate("Dimension Value Code", ShortcutDim4);
                        //         TempDimSetEntry.Modify;
                        //     end
                        //     else begin
                        //         TempDimSetEntry.Init;
                        //         TempDimSetEntry.Validate("Dimension Code", GLSetup."Shortcut Dimension 4 Code");
                        //         TempDimSetEntry.Validate("Dimension Value Code", ShortcutDim4);
                        //         TempDimSetEntry.Insert;
                        //     end;

                        // end;
                        // if DeptDim <> '' then begin
                        //     TempDimSetEntry.Reset;
                        //     TempDimSetEntry.SetRange("Dimension Code", GLSetup."Shortcut Dimension 5 Code");
                        //     if TempDimSetEntry.FindFirst then begin
                        //         TempDimSetEntry.Validate("Dimension Value Code", DeptDim);
                        //         TempDimSetEntry.Modify;
                        //     end
                        //     else begin
                        //         TempDimSetEntry.Init;
                        //         TempDimSetEntry.Validate("Dimension Code", GLSetup."Shortcut Dimension 5 Code");
                        //         TempDimSetEntry.Validate("Dimension Value Code", DeptDim);
                        //         TempDimSetEntry.Insert;
                        //     end;
                        // end;
                        // if FAWIPDim <> '' then begin
                        //     TempDimSetEntry.Reset;
                        //     TempDimSetEntry.SetRange("Dimension Code", GLSetup."Shortcut Dimension 6 Code");
                        //     if TempDimSetEntry.FindFirst then begin
                        //         TempDimSetEntry.Validate("Dimension Value Code", FAWIPDim);
                        //         TempDimSetEntry.Modify;
                        //     end
                        //     else begin
                        //         TempDimSetEntry.Init;
                        //         TempDimSetEntry.Validate("Dimension Code", GLSetup."Shortcut Dimension 6 Code");
                        //         TempDimSetEntry.Validate("Dimension Value Code", FAWIPDim);
                        //         TempDimSetEntry.Insert;
                        //     end;
                        // end;
                        // //CITS
                        // if AlloKey <> '' then begin
                        //     TempDimSetEntry.Reset;
                        //     TempDimSetEntry.SetRange("Dimension Code", GLSetup."Shortcut Dimension 7 Code");
                        //     if TempDimSetEntry.FindFirst then begin
                        //         TempDimSetEntry.Validate("Dimension Value Code", AlloKey);
                        //         TempDimSetEntry.Modify;
                        //     end
                        //     else begin
                        //         TempDimSetEntry.Init;
                        //         TempDimSetEntry.Validate("Dimension Code", GLSetup."Shortcut Dimension 7 Code");
                        //         TempDimSetEntry.Validate("Dimension Value Code", AlloKey);
                        //         TempDimSetEntry.Insert;
                        //     end;
                        // end;
                        // //Message(UserDim);
                        // if UserDim <> '' then begin
                        //     TempDimSetEntry.Reset;
                        //     TempDimSetEntry.SetRange("Dimension Code", GLSetup."Shortcut Dimension 8 Code");
                        //     if TempDimSetEntry.FindFirst then begin
                        //         TempDimSetEntry.Validate("Dimension Value Code", UserDim);
                        //         TempDimSetEntry.Modify;
                        //     end
                        //     else begin
                        //         TempDimSetEntry.Init;
                        //         TempDimSetEntry.Validate("Dimension Code", GLSetup."Shortcut Dimension 8 Code");
                        //         TempDimSetEntry.Validate("Dimension Value Code", UserDim);
                        //         TempDimSetEntry.Insert;
                        //     end;
                        // end;

                        NewDimSetID := DimMgt.GetDimensionSetID(TempDimSetEntry);
                        if OldDimSetID <> NewDimSetID then begin
                            GenJnlLine."Dimension Set ID" := NewDimSetID;
                            GenJnlLine.Modify(true);
                        end;
                    end;
                    clearVars;

                END;

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
        Message('Upload Completed');
    end;

    var
        GenLdgSetup: Record "General Ledger Setup";
        DocumentDate12: date;
        GenJnlTemp: Record "Gen. Journal Template";
        GenJnlBatch: Record "Gen. Journal Batch";
        GenJnlLine: Record "Gen. Journal Line";
        NoSerMngt: Codeunit NoSeriesManagement;
        LineNo: Integer;
        LineAmount: Decimal;
        Text0001: label 'Entry No. %1 has either already been uploaded or Posted. Cannot process this file.';
        GLEntry: Record "G/L Entry";
        GLAcc: Record "G/L Account";
        IntLineNo: Integer;
        Cust: Record Customer;
        Text0002: label 'Entries for Date %1 have alredy been uploaded once. Do you wish to upload them again?';
        PostingDate: Date;
        DocType: Integer;
        Description: text;
        DocumentDate: Date;
        DueDate: Date;
        ChqDate: Date;
        AccType: Integer;
        BalAccType: Integer;
        FAPostingDate: Date;
        FAPostingType: Integer;
        NarrationInserted: Boolean;
        DocumentNo: Code[20];
        DepBookCode: Code[20];
        OldDimSetID: Integer;
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
        DimMgt: Codeunit DimensionManagement;
        NewDimSetID: Integer;
        AppliesToDocTypeint: Integer;
        GLSetup: Record "General Ledger Setup";


    procedure clearVars()
    begin
        LineNo := 0;
        LineAmount := 0;
        PostingDate := 0D;
        DocType := 0;
        DocumentDate := 0D;
        DueDate := 0D;
        ChqDate := 0D;
        AccType := 0;
        BalAccType := 0;
        FAPostingDate := 0D;
        FAPostingType := 0;
        OldDimSetID := 0;
        NewDimSetID := 0;
        //AppliesToDOc := '';
        AppliesToDocTypeint := 0;
    end;
}

