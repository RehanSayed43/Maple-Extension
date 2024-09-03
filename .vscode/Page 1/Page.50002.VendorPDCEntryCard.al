page 50002 "Vendor PDC Entry Card"
{
    // +-----------------------------------------------------------------------------------------------------------------------+
    // | Consultant            Date       Code Mark    Issue Id          Description                                           |
    // +-----------------------------------------------------------------------------------------------------------------------+
    // | Mahesh Mukundan       26-AUG-11  001          WINSPIRE.01       Modified the objects.                                 |
    // +-----------------------------------------------------------------------------------------------------------------------+

    PageType = Card;
    SourceTable = 50002;
    SourceTableView = SORTING("Entry No.")
                      ORDER(Ascending)
                      WHERE("PDC Status" = CONST(Open),
                            "Sent to Bank" = CONST(false),
                            "Account Type" = CONST(Vendor));
    ApplicationArea = FixedAsset;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("PDC Type"; Rec."PDC Type")
                {
                    ApplicationArea = All;
                }
                field("Res Center"; Rec."Res Center")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Account Type"; Rec."Account Type")
                {
                    Editable = false;
                    OptionCaption = 'Customer,Vendor';
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
                field("PDC Cheque No."; Rec."PDC Cheque No.")
                {
                    ApplicationArea = All;
                }
                field("PDC Cheque Date"; Rec."PDC Cheque Date")
                {
                    ApplicationArea = All;
                }
                field("<PD Received Date>"; Rec."PDC Received Date")
                {
                    Caption = 'PDC Send Date';
                    ApplicationArea = All;
                }
                field("PDC Amount"; Rec."PDC Amount")
                {
                    ApplicationArea = All;
                }
                field("MICR Code"; Rec."MICR Code")
                {
                    ApplicationArea = All;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = All;
                }
                field("Bank Branch"; Rec."Bank Branch")
                {
                    ApplicationArea = All;
                }
                field("Bank Deposit Code"; Rec."Bank Deposit Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("PDC Deposit Date"; Rec."PDC Deposit Date")
                {
                    ApplicationArea = All;
                }
                field("PDC Amount Applied"; Rec."PDC Amount Applied")
                {
                    ApplicationArea = All;
                }
                field("PDC Deposited"; Rec."PDC Deposited")
                {
                    ApplicationArea = All;
                }
                field("Sent to Bank"; Rec."Sent to Bank")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part(Part; 9082)
            {
                //SubPageLink = "No."=FIELD(Field6);//tk
                Visible = false;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("<Action59>")
            {
                Caption = 'F&unctions';
                action("<Action61>")
                {
                    Caption = 'Sent to Bank';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        PDCApplication: Record 50005;
                        DepositCheques: Record 50006;
                    begin
                        //TESTFIELD("PDC Type");
                        Rec.TESTFIELD("PDC Amount");
                        Rec.TESTFIELD("PDC Cheque Date");
                        //001 - Start
                        // TESTFIELD("MICR Code");
                        //001 - Stop
                        //TESTFIELD("Bank Deposit Code");
                        //TESTFIELD("Bank deposit date");
                        //TESTFIELD("Res Center");
                        Rec.TESTFIELD("Sent to Bank", FALSE);

                        AppAmount := 0;
                        recPDCApp.RESET;
                        recPDCApp.SETFILTER(recPDCApp."Entry No.", FORMAT(Rec."Entry No."));
                        IF recPDCApp.FINDFIRST THEN
                            REPEAT
                                recCLE.RESET;
                                //tk//recCLE.SETFILTER(recCLE."Document No.", recPDCApp."Remaining Amount");
                                IF recCLE.FINDFIRST THEN BEGIN
                                    recCLE.CALCFIELDS(recCLE."Remaining Amt. (LCY)");
                                    IF recCLE."Remaining Amt. (LCY)" < recPDCApp."Document Type1" THEN
                                        ERROR('Amount to apply is more than remaining amount for document no.:' + recCLE."Document No.");
                                END;
                            UNTIL recPDCApp.NEXT = 0;

                        PDCApplication.RESET;
                        //tk //PDCApplication.SETCURRENTKEY("Entry No.", "Cust Ledger Entry No.");
                        PDCApplication.SETRANGE("Entry No.", Rec."Entry No.");
                        PDCApplication.CALCSUMS("Document Type1");

                        IF PDCApplication."Document Type1" > Rec."PDC Amount" THEN
                            ERROR(Text0003, Rec.FIELDCAPTION("PDC Amount Applied"), PDCApplication."Document Type1",
                                           Rec.FIELDCAPTION("PDC Amount"), Rec."PDC Amount");

                        IF CONFIRM(Text0001) THEN BEGIN
                            //  IF ("PDC Type" = "PDC Type"::"Fully Filled") AND ("Document No." = "Document No."::"0") THEN
                            IF (Rec."PDC Type" = Rec."PDC Type"::"Fully Filled") THEN
                                Rec."Sent to Bank" := TRUE;
                            //"Bank deposit date" := WORKDATE;//TODAY; to be changed later
                            Rec.MODIFY;
                            //  DepositCheques.InsertDepositCheques("Entry No.");//tk
                            MESSAGE(Text0002);
                        END;
                    end;
                }
                action("<Action62>")
                {
                    Caption = 'Upload file to Server';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                }
                action("<Action63>")
                {
                    Caption = 'Open File';
                    Image = Statistics;
                    InFooterBar = true;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                }
                action("<Action64>")
                {
                    Caption = 'Apply';
                    Image = Statistics;
                    InFooterBar = true;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.TESTFIELD("Account Type", Rec."Account Type"::Vendor);
                        Rec.TESTFIELD("PDC Type", Rec."PDC Type"::"Fully Filled");
                        Rec.TESTFIELD("PDC Status", Rec."PDC Status"::Open);

                        Rec.TESTFIELD("PDC Cheque Date");
                        Rec.TESTFIELD("PDC Cheque No.");


                        //TESTFIELD("PDC Cheque Date");
                        //TESTFIELD("PDC Type");
                        //001 - Start
                        //TESTFIELD("MICR Code");
                        //001 - Stop
                        //IF NOT "Blank Check" THEN //WIN 121 12.02.13 12:00
                        //  TESTFIELD("PDC Amount");
                        Rec.TESTFIELD("Sent to Bank", FALSE);

                        Rec.FillBuffer;
                    end;
                }
                action("<Action65>")
                {
                    Caption = 'UnApply';
                    Image = Statistics;
                    InFooterBar = true;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Shift+F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.DelAppln;
                        //IF "Blank Check" THEN
                        //  "PDC Amount" := 0;
                    end;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Account Type" := Rec."Account Type"::Vendor;
    end;

    trigger OnOpenPage()
    begin
        Rec."Account Type" := Rec."Account Type"::Vendor;
    end;

    var
        Text0001: Label 'Do you want to send the Cheque to Bank?';
        Text0002: Label 'Cheque has been sent to Bank';
        Text0003: Label '%1 = %2 is more than the %3 = %4.';
        recPDCApp: Record 50005;
        recCLE: Record 21;
        AppAmount: Decimal;
}

