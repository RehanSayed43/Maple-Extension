page 50023 "Denomination Entry"
{
    AutoSplitKey = false;
    PageType = Card;
    SourceTable = 50007;
    SourceTableView = WHERE("TransType" = CONST(Denomination));
    ApplicationArea = FixedAsset;

    layout
    {
        area(content)
        {
            group(Group1)
            {
                field(TransType; Rec.TransType)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(DenominationNo; Rec.DenominationNo)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Dinomination Date"; Rec."Dinomination Date")
                {
                    ApplicationArea = All;
                }
                field(Branch; Rec.Branch)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF Rec.Branch <> '' THEN BEGIN
                            IF NOT Rec."Document Posted" THEN BEGIN
                                GenLedgerSetup.GET;
                                GenLedgerSetup.TESTFIELD(GenLedgerSetup."Cash Account");
                                Rec."G/L Cash Ac" := GenLedgerSetup."Cash Account";
                                MESSAGE('CASH A/C %1', Rec."G/L Cash Ac");
                                GLAc.RESET;
                                GLAc.SETRANGE("No.", Rec."G/L Cash Ac");
                                GLAc.SETFILTER("Global Dimension 1 Filter", '%1', Rec.Branch);
                                GLAc.SETRANGE("Date Filter", 0D, CALCDATE('-1D', Rec."Dinomination Date"));
                                IF GLAc.FINDFIRST THEN;
                                GLAc.CALCFIELDS("Balance at Date");
                                PreClosingAmt := GLAc."Balance at Date";
                                MESSAGE('BALANCE %1', PreClosingAmt);
                                GLAc.RESET;
                                GLAc.SETFILTER("No.", '%1', Rec."G/L Cash Ac");
                                GLAc.SETFILTER("Global Dimension 1 Filter", '%1', Rec.Branch);
                                GLAc.SETFILTER("Date Filter", '%1', Rec."Dinomination Date");
                                IF GLAc.FINDFIRST THEN;
                                GLAc.CALCFIELDS("Net Change");
                                MESSAGE('NET CHANGE %1', GLAc."Net Change");

                                //"Closing Balance" := PreClosingAmt + GLAc."Net Change";
                                //"Closing Balance" :=  (GLAc."Net Change" - PreClosingAmt);
                                Rec."Closing Balance" := GLAc."Net Change";
                                CurrPage.UPDATE;
                            END;//tk
                        END;
                    end;
                }
                field(EntryDate; EntryDate)
                {
                    Caption = 'Date';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        DenominationEntryLocal: Record 50007;
                    begin
                        IF (EntryDate <> 0D) THEN BEGIN
                            // BranchEditable := FALSE;
                            // BranchLocal := '';
                            // SETFILTER(Branch,'%1',BranchLocal);
                            // SETFILTER("Dinomination Date",'=%1',EntryDate);
                            // SETFILTER("Date Filter",'%1',EntryDate);
                            // CurrPage.UPDATE;
                        END;
                    end;
                }
                field(BranchLocal; BranchLocal)
                {
                    AssistEdit = true;
                    Caption = 'Branch';
                    DrillDown = true;
                    DrillDownPageID = "Responsibility Center New List";
                    Lookup = true;
                    LookupPageID = "Responsibility Center New List";
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ResCenter: Record 50000;
                    begin
                    end;
                }
                field(D1000; Rec.D1000)
                {
                    Caption = 'Denomination 1000';
                    ApplicationArea = All;
                }
                field(D500; Rec.D500)
                {
                    Caption = 'Denomination 500';
                    ApplicationArea = All;
                }
                field(D100; Rec.D100)
                {
                    Caption = 'Denomination 100';
                    MinValue = 0;
                    ApplicationArea = All;
                }
                field(D50; Rec.D50)
                {
                    Caption = 'Denomination 50';
                    ApplicationArea = All;
                }
                field(D20; Rec.D20)
                {
                    Caption = 'Denomination 20';
                    ApplicationArea = All;
                }
                field(D10; Rec.D10)
                {
                    Caption = 'Denomination 10';
                    ApplicationArea = All;
                }
                field(D5; Rec.D5)
                {
                    Caption = 'Denomination 5';
                    ApplicationArea = All;
                }
                field(D2; Rec.D2)
                {
                    Caption = 'Denomination 2';
                    ApplicationArea = All;
                }
                field(D1; Rec.D1)
                {
                    Caption = 'Denomination 1';
                    ApplicationArea = All;
                }
                field(COINS; Rec.COINS)
                {
                    ApplicationArea = All;
                }
                field(TotalAmt; Rec.TotalAmt)
                {
                    Caption = 'Total Amount';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Closing Balance"; Rec."Closing Balance")
                {
                    Editable = false;
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Amount Posted"; Rec."Amount Posted")
                {
                    Caption = 'Posted';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Document Posted"; Rec."Document Posted")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action(Post)
            {
                Image = Post;
                Promoted = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    GenLedgerSetup: Record 98;
                begin
                    IF NOT Rec."Document Posted" THEN BEGIN
                        IF Rec.TotalAmt <> Rec."Closing Balance" THEN
                            ERROR('Total Amount %1 is not matching with Closing Balance %2', Rec.TotalAmt, Rec."Closing Balance")
                        ELSE BEGIN
                            Rec."Document Posted" := TRUE;
                            MESSAGE('Document Posted Successfully');
                            CurrPage.CLOSE;
                        END;
                    END;
                    /*
                     GenLedgerSetup.GET;
                     GenLedgerSetup.TESTFIELD(GenLedgerSetup."Cash Account");
                     "G/L Cash Ac" := GenLedgerSetup."Cash Account";
                     GLAc.RESET;
                     GLAc.SETFILTER("No.",'%1',"G/L Cash Ac");
                     GLAc.SETFILTER(GLAc."Global Dimension 1 Filter",Branch);
                     GLAc.SETFILTER("Date Filter",'%1',CALCDATE('-1D',"Dinomination Date"));
                     GLAc.FINDFIRST;
                     GLAc.CALCFIELDS("Balance at Date");
                     "Closing Balance" := GLAc."Balance at Date";

                     GLAc.RESET;
                     GLAc.SETFILTER("No.",'%1',"G/L Cash Ac");
                     GLAc.SETFILTER(GLAc."Global Dimension 1 Filter",Branch);
                     GLAc.SETFILTER("Date Filter",'%1',"Dinomination Date");
                     GLAc.FINDFIRST;
                     GLAc.CALCFIELDS("Net Change");

                    IF TotalAmt <> ("Closing Balance" + GLAc."Net Change")  THEN
                      ERROR('Total Amount %1 is not matching with Closing Balance %2',TotalAmt,("Closing Balance" + GLAc."Net Change"))
                    ELSE BEGIN
                      "Document Posted" := TRUE;
                      MESSAGE('Document Posted Successfully');
                      CurrPage.CLOSE;
                    END;
                    END;
                    */


                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //CurrPage.EDITABLE := NOT "Document Posted";
        //CurrPage.UPDATE;
    end;

    trigger OnClosePage()
    begin
        /*
         RESET;
        SETFILTER(Branch,'%1',BranchLocal);
        SETFILTER("Dinomination Date",'%1',"Entry Date");
        SETFILTER("Date Filter",'%1',"Entry Date");
        SETFILTER(Quantity,'=%1',0);
        IF NOT ISEMPTY THEN BEGIN
        REPEAT
          DELETE;
        UNTIL NEXT = 0;
        END;
        */

    end;

    trigger OnInit()
    begin
        //BranchLocal := '';
        //EntryDate := 0D;
        //BranchEditable := TRUE;
        Rec.TransType := Rec.TransType::Denomination;
    end;

    trigger OnOpenPage()
    var
        UserSetup: Record 91;
    begin
        //SETFILTER(TransType,'%1',TransType::Denomination);
        //SETFILTER(Branch,'%1',BranchLocal);
        //SETFILTER("Dinomination Date",'=%1',EntryDate);
        //SETFILTER("Date Filter",'%1',EntryDate);
        UserSetup.GET(USERID);
        Rec.SETFILTER("Location Code", '%1', UserSetup."Location Code");
        CurrPage.EDITABLE := NOT Rec."Document Posted";
        CalBalance();
    end;

    var
        TotalAmount: Decimal;
        EntryDate: Date;
        BranchLocal: Code[20];
        //WBU: Codeunit "50000";//tk
        BranchEditable: Boolean;
        GLAc: Record 15;
        PreClosingAmt: Decimal;
        GenLedgerSetup: Record 98;


    procedure CalBalance()
    begin

        IF Rec.Branch <> '' THEN BEGIN
            GenLedgerSetup.GET;
            GenLedgerSetup.TESTFIELD(GenLedgerSetup."Cash Account");
            Rec."G/L Cash Ac" := GenLedgerSetup."Cash Account";
            GLAc.RESET;
            GLAc.SETFILTER("No.", '%1', Rec."G/L Cash Ac");
            GLAc.SETFILTER("Global Dimension 1 Filter", '%1', Rec.Branch);
            GLAc.SETFILTER("Date Filter", '%1', Rec."Dinomination Date");
            IF GLAc.FINDFIRST THEN;
            GLAc.CALCFIELDS("Net Change");
            Rec."Closing Balance" := GLAc."Net Change";
        END;
    end;
}

