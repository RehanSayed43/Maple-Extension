page 50013 "Customer PDC List"
{
    CardPageID = "Customer PDC Entry Card";
    DeleteAllowed = false;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = 50002;
    SourceTableView = SORTING("Entry No.")
                      ORDER(Ascending)
                      WHERE("PDC Status" = CONST(Open),
                            "Account Type" = CONST(Customer));
    ApplicationArea = FixedAsset;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Select; Rec.Select)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("PDC Received Date"; Rec."PDC Received Date")
                {
                    ApplicationArea = All;
                }
                field("PDC Cheque Date"; Rec."PDC Cheque Date")
                {
                    ApplicationArea = All;
                }
                field("PDC Type"; Rec."PDC Type")
                {
                    ApplicationArea = All;
                }
                field("PDC Amount"; Rec."PDC Amount")
                {
                    ApplicationArea = All;
                }
                field("Res Center"; Rec."Res Center")
                {
                    ApplicationArea = All;
                }
                field("PDC Amount Applied"; Rec."PDC Amount Applied")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part(Part; 9082)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("<Action59>")
            {
                Caption = 'Fun&ction';
                action("<Action61>")
                {
                    Caption = 'Sent to Bank';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        recPDC: Record 50002;
                        PDCApplication: Record 50005;
                        DepositCheques: Record 50006;
                    begin
                        recPDC.SETRANGE(recPDC.Select, TRUE);
                        IF recPDC.FINDFIRST THEN
                            REPEAT
                                recPDC.TESTFIELD(recPDC."PDC Type");
                                recPDC.TESTFIELD(recPDC."PDC Amount");
                                recPDC.TESTFIELD("PDC Cheque Date");
                                //001 - Start
                                // TESTFIELD("MICR Code");
                                //001 - Stop
                                recPDC.TESTFIELD("Bank Deposit Code");
                                //recPDC.TESTFIELD("Bank deposit date");  win127
                                //recPDC.TESTFIELD("Res Center");    win127
                                //recPDC.TESTFIELD( "Sent to Bank",FALSE);

                                AppAmount := 0;
                                recPDCApp.RESET;
                                recPDCApp.SETFILTER(recPDCApp."Entry No.", FORMAT(recPDC."Entry No."));
                                IF recPDCApp.FINDFIRST THEN
                                    REPEAT
                                        recCLE.RESET;
                                        //recCLE.SETFILTER(recCLE."Document No.", recPDCApp."Remaining Amount");
                                        IF recCLE.FINDFIRST THEN BEGIN
                                            recCLE.CALCFIELDS(recCLE."Remaining Amt. (LCY)");
                                            IF recCLE."Remaining Amt. (LCY)" < recPDCApp."Document Type1" THEN
                                                ERROR('Amount to apply is more than remaining amount for document no.:' + recCLE."Document No.");
                                        END;
                                    UNTIL recPDCApp.NEXT = 0;

                                PDCApplication.RESET;
                                // PDCApplication.SETCURRENTKEY("Entry No.", "Cust Ledger Entry No.");//tk
                                PDCApplication.SETRANGE("Entry No.", recPDC."Entry No.");
                                PDCApplication.CALCSUMS("Document Type1");

                                IF PDCApplication."Document Type1" > recPDC."PDC Amount" THEN
                                    ERROR(Text0003, recPDC.FIELDCAPTION("PDC Amount Applied"), PDCApplication."Document Type1",
                                                   recPDC.FIELDCAPTION(recPDC."PDC Amount"), recPDC."PDC Amount");

                                IF CONFIRM(Text0001) THEN BEGIN

                                    IF (recPDC."PDC Type" = recPDC."PDC Type"::"Fully Filled") AND
                                          (recPDC."Account Type" = recPDC."Account Type"::Customer) THEN
                                        recPDC."Sent to Bank" := TRUE;
                                    // recPDC."Bank deposit date" := WORKDATE;//TODAY; to be changed later
                                    recPDC.MODIFY;
                                    // DepositCheques.InsertDepositCheques(recPDC."Entry No.");//tk
                                    MESSAGE(Text0002);
                                END;
                            UNTIL recPDC.NEXT = 0;
                    end;
                }
                action("<Action62>")
                {
                    Caption = 'Upload file to Server';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';
                    ApplicationArea = All;
                }
                action("<Action63>")
                {
                    Caption = 'Open File';
                    Image = Statistics;
                    InFooterBar = true;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';
                    ApplicationArea = All;
                }
                action("<Action64>")
                {
                    Caption = 'Apply';
                    Image = Statistics;
                    InFooterBar = true;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';
                    ApplicationArea = All;
                }
                action("<Action65>")
                {
                    Caption = 'UnApply';
                    Image = Statistics;
                    InFooterBar = true;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CLEAR(AccountName);
        //Win127
        IF Rec."Account Type" = Rec."Account Type"::Customer THEN
            IF Customer.GET(Rec."Account No.") THEN
                AccountName := Customer.Name;
    end;

    trigger OnOpenPage()
    begin
        UserSetup.GET(USERID);
        /* FILTERGROUP(0);
         SETFILTER("Res Center",UserSetup."Sales Resp. Ctr. Filter");
         FILTERGROUP(2);   */

    end;

    var
        AccountName: Text[50];
        Customer: Record 18;
        recPDCApp: Record 50005;
        recCLE: Record 21;
        AppAmount: Decimal;
        Text0001: Label 'Do you want to send the Cheque to Bank?';
        Text0002: Label 'Cheque has been sent to Bank';
        Text0003: Label '%1 = %2 is more than the %3 = %4.';
        UserSetup: Record 91;
        UserMgt: Codeunit 5700;
}

