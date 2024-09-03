codeunit 50006 "Customer Set Off"
{

    trigger OnRun()
    begin
        Payment_Post;
        /*
        //CREATE(FileSystem,TRUE,TRUE);
        {CLEAR(FileName);
        FileName:='\\mapleNAV\Navision\Dont Delete (Capilery Integration)\OneDrive - Winspire Solutions Pvt. Ltd\WIN316';
        IF NOT FileSystem.FolderExists(FileName) THEN
        FileSystem.CreateFolder(FileName);
        FileName:='\\mapleNAV\Navision\Dont Delete (Capilery Integration)\OneDrive - Winspire Solutions Pvt. Ltd\WIN316\Inventory Ageing - '+FORMAT(TODAY,0,'<Day,2>-<Month,2>-<Year4>')+'.CSV';
        }
        
        //REPORT 1++
        CLEAR(FileName);
        FileName:='\\mapleNAV\Navision\Dont Delete (Capilery Integration)\OneDrive - Winspire Solutions Pvt. Ltd\Inventory Ageing\Inventory Ageing.CSV';
        IF FILE.EXISTS(FileName) THEN
           FILE.ERASE(FileName);
        InventoryAgeingNew.SAVEASEXCEL(FileName);
        //REPORT 1--
        
        //REPORT 2++
        CLEAR(FileName);
        FileName:='\\mapleNAV\Navision\Dont Delete (Capilery Integration)\OneDrive - Winspire Solutions Pvt. Ltd\Sales Register\Sales Register.CSV';
        IF FILE.EXISTS(FileName) THEN
           FILE.ERASE(FileName);
        SalesRegisterNew1.SAVEASEXCEL(FileName);
        //REPORT 2--
        
        
        MESSAGE('Done');
        */

    end;

    var
        //InventoryAgeingNew: Report "14125504"; //CCIT_kj
        FileName: Text;
        // [WithEvents]
        //FileSystem1: Automation;
        //SalesRegisterNew1: Report "14125501"; //CCIT_kj
        ExcelBuffer: Record "Excel Buffer";//"370";

    local procedure Payment_Post()
    var
        GenJnlLine: Record "Gen. Journal Line";//"81";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";//"12";
        customerSetoff: Record "Customer Set Off";//"50012";
    begin
        customerSetoff.RESET;
        //customerSetoff.SETRANGE("JV Posted",FALSE);
        //customerSetoff.SETRANGE(Skip,FALSE);

        //customerSetoff.SETRANGE("Line No",1,2);

        //   customerSetoff.SETRANGE("JV Created", FALSE); //CCIT_kj
        IF customerSetoff.FINDSET THEN BEGIN
            REPEAT
                GenJnlLine.INIT;
                GenJnlLine."Journal Batch Name" := 'DEFAULT';
                GenJnlLine."Journal Template Name" := 'GENERAL2';
                GenJnlLine."Line No." := customerSetoff."Line No";
                GenJnlLine."Posting Date" := customerSetoff."Posting Date";
                GenJnlLine."Document No." := customerSetoff."Document No";
                GenJnlLine."Account Type" := customerSetoff."Account Type";
                GenJnlLine."Account No." := customerSetoff."Account No.";
                GenJnlLine.Amount := customerSetoff.Amount;
                IF customerSetoff."Bal. Account No." <> '' THEN BEGIN
                    GenJnlLine."Bal. Account Type" := customerSetoff."Bal. Account Type";
                    GenJnlLine."Bal. Account No." := customerSetoff."Bal. Account No.";
                END;
                GenJnlLine."Document Date" := customerSetoff."Posting Date";
                GenJnlLine."Source Code" := 'GENJNL';//SrcCode;
                GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", customerSetoff."Shortcut Dimension 1 Code");
                GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", customerSetoff."Shortcut Dimension 2 Code");
                GenJnlLine."Gen. Bus. Posting Group" := '';
                GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
                GenJnlLine."Gen. Prod. Posting Group" := '';
                GenJnlLine."Applies-to Doc. Type" := customerSetoff."Applies-to Doc. Type";
                GenJnlLine."Applies-to Doc. No." := customerSetoff."Applies-to Doc. No.";
                GenJnlLine.INSERT;

                customerSetoff."JV Created" := TRUE;
                customerSetoff.MODIFY;
            UNTIL customerSetoff.NEXT = 0;
        END;
        //MESSAGE('Done');
        // GenJnlPostLine.RunWithCheck(GenJnlLine);
    end;

    local procedure Payment_Post1()
    var
        GenJnlLine: Record "Gen. Journal Line";//"81";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";//"12";
        customerSetoff: Record "Customer Set Off";//"50012";
    begin
        customerSetoff.RESET;
        customerSetoff.SETRANGE("JV Posted", FALSE);
        customerSetoff.SETRANGE(Skip, FALSE);
        IF customerSetoff.FINDSET THEN BEGIN
            REPEAT
                GenJnlLine.INIT;
                GenJnlLine."Journal Batch Name" := 'DEFAULT';
                GenJnlLine."Journal Template Name" := 'GENERAL2';
                GenJnlLine."Line No." := customerSetoff."Line No";
                GenJnlLine."Posting Date" := customerSetoff."Posting Date";
                GenJnlLine."Document No." := '27112018_SETOFF';
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
                GenJnlLine."Account No." := customerSetoff."Account No.";
                GenJnlLine.Amount := customerSetoff.Amount;

                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                GenJnlLine."Bal. Account No." := '512040';
                GenJnlLine."Document Date" := customerSetoff."Posting Date";
                GenJnlLine."Source Code" := 'GENJNL';//SrcCode;
                GenJnlLine."Shortcut Dimension 1 Code" := customerSetoff."Shortcut Dimension 1 Code";
                GenJnlLine."Shortcut Dimension 2 Code" := customerSetoff."Shortcut Dimension 2 Code";
                GenJnlLine."Gen. Bus. Posting Group" := '';
                GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
                GenJnlLine."Gen. Prod. Posting Group" := '';
                GenJnlLine."Applies-to Doc. Type" := customerSetoff."Applies-to Doc. Type";
                GenJnlLine."Applies-to Doc. No." := customerSetoff."Applies-to Doc. No.";
                GenJnlLine.INSERT;
            UNTIL customerSetoff.NEXT = 0;
        END;
        //MESSAGE('Done');
        // GenJnlPostLine.RunWithCheck(GenJnlLine);
    end;
}

