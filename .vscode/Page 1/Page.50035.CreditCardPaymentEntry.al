page 50035 "Credit Card Payment Entry"
{
    AutoSplitKey = true;
    PageType = Card;
    SourceTable = 50007;
    SourceTableView = WHERE(TransType = CONST(CreditCard));
    ApplicationArea = FixedAsset;

    layout
    {
        area(content)
        {
            group(Group1)
            {
                field("Dinomination Date"; Rec."Dinomination Date")
                {
                    Caption = 'Date';
                    ApplicationArea = All;
                }
                field(DenominationNo; Rec.DenominationNo)
                {
                    Caption = 'Document No.';
                    ApplicationArea = All;
                }
                field(Branch; Rec.Branch)
                {
                    ApplicationArea = All;
                }
                field("Credit CD Bank AC"; Rec."Credit CD Bank AC")
                {
                    Visible = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        /*
                        IF "Credit CD Bank AC" <> '' THEN BEGIN
                         GLAc.RESET;
                         GLAc.SETFILTER("No.",'%1',"Credit CD Bank AC");
                         GLAc.SETFILTER(GLAc."Global Dimension 1 Filter",Branch);
                         GLAc.SETFILTER("Date Filter",'%1',CALCDATE('-1D',"Dinomination Date"));
                         GLAc.FINDFIRST;
                         GLAc.CALCFIELDS("Balance at Date");
                         PreBalance := GLAc."Balance at Date";

                         GLAc.RESET;
                         GLAc.SETFILTER("No.",'%1',"Credit CD Bank AC");
                         GLAc.SETFILTER(GLAc."Global Dimension 1 Filter",Branch);
                         GLAc.SETFILTER("Date Filter",'%1',"Dinomination Date");
                         GLAc.FINDFIRST;
                         GLAc.CALCFIELDS("Net Change");
                         "Closing Balance" :=  PreBalance + GLAc."Net Change";
                        END;
                         */

                    end;
                }
                field(TotalCreditAmt; Rec.TotalCreditAmt)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Closing Balance"; Rec."Closing Balance")
                {
                    Editable = false;
                    Visible = true;
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
            }
            repeater(Repeater)
            {
                field(LineNo; Rec.LineNo)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Machine Name"; Rec."Machine Name")
                {
                    Editable = true;
                    Lookup = true;
                    LookupPageID = "Standard Text Codes";
                    TableRelation = "Standard Text"."Credit Cd Machine Code" WHERE("Credit Card Machine" = CONST(true),
                                                                                    "TID" = CONST(false));
                    ApplicationArea = All;
                }
                field("TID No"; Rec."TID No")
                {
                    TableRelation = "Standard Text"."TID NO" WHERE("TID" = CONST(true));
                    ApplicationArea = All;
                }
                field(CreditCardAmt; Rec.CreditCardAmt)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //WBU.RefreshPage();//tk
                    end;
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
                        Rec.TESTFIELD("Credit CD Bank AC");
                        IF Rec.TotalCreditAmt <> Rec."Closing Balance" THEN
                            ERROR('Total Amount %1 is not matching with Closing Balance %2', Rec.TotalCreditAmt, Rec."Closing Balance")
                        ELSE BEGIN
                            DenominationEntryLocal.RESET;
                            DenominationEntryLocal.SETFILTER(DenominationNo, '%1', Rec.DenominationNo);
                            IF DenominationEntryLocal.FINDFIRST THEN BEGIN
                                REPEAT
                                    DenominationEntryLocal."Document Posted" := TRUE;
                                    DenominationEntryLocal.MODIFY;
                                UNTIL DenominationEntryLocal.NEXT = 0
                            END;
                            MESSAGE('Document Posted Successfully');
                            CurrPage.CLOSE;

                        END;

                        /*
                         GLAc.RESET;
                         GLAc.SETFILTER("No.",'%1',"Credit CD Bank AC");
                         GLAc.SETFILTER(GLAc."Global Dimension 1 Filter",Branch);
                         GLAc.SETFILTER("Date Filter",'%1',CALCDATE('-1D',"Dinomination Date"));
                         GLAc.FINDFIRST;
                         GLAc.CALCFIELDS("Balance at Date");
                         "Closing Balance" := GLAc."Balance at Date";

                         GLAc.RESET;
                         GLAc.SETFILTER("No.",'%1',"Credit CD Bank AC");
                         GLAc.SETFILTER(GLAc."Global Dimension 1 Filter",Branch);
                         GLAc.SETFILTER("Date Filter",'%1',"Dinomination Date");
                         GLAc.FINDFIRST;
                         GLAc.CALCFIELDS("Net Change");

                        IF TotalCreditAmt <> ("Closing Balance" + GLAc."Net Change")  THEN
                          ERROR('Total Amount %1 is not matching with Closing Balance %2',TotalCreditAmt,("Closing Balance" + GLAc."Net Change"))
                        ELSE BEGIN
                          "Document Posted" := TRUE;
                          MESSAGE('Document Posted Successfully');
                          CurrPage.CLOSE;
                        END;
                        */
                    END;



                end;
            }
        }
    }

    trigger OnInit()
    begin
        Rec.TransType := Rec.TransType::CreditCard;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Editpage := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //EntryNo := GetEntryNo;
        //MESSAGE('New');
        Rec.TransType := Rec.TransType::CreditCard;
        IF Editpage THEN BEGIN
            Rec.DenominationNo := xRec.DenominationNo;
            Rec.Branch := xRec.Branch;
            Rec."Dinomination Date" := xRec."Dinomination Date";
            Rec."Credit CD Bank AC" := xRec."Credit CD Bank AC";
            Rec."Closing Balance" := xRec."Closing Balance";
            Rec.Remarks := xRec.Remarks;
        END;
    end;

    trigger OnOpenPage()
    begin
        IF Rec.DenominationNo <> '' THEN BEGIN
            Editpage := TRUE;
            Rec.RESET;
            Rec.SETFILTER(TransType, '%1', Rec.TransType::CreditCard);
            Rec.SETFILTER(DenominationNo, '%1', Rec.DenominationNo);
            CurrPage.EDITABLE := NOT Rec."Document Posted";
        END
        ELSE BEGIN
            Editpage := FALSE;
            GLSetup.GET;
            GLSetup.TESTFIELD(GLSetup."Daily Currency Nos");
            NoSeriesMgt.InitSeries(GLSetup."Daily Currency Nos", xRec."No. Series", WORKDATE, Rec.DenominationNo, Rec."No. Series");
            Rec.SETFILTER(TransType, '%1', Rec.TransType::CreditCard);
            Rec.SETFILTER(DenominationNo, '%1', Rec.DenominationNo);
        END;
        /*
        SETFILTER(TransType,'%1',TransType::CreditCard);
        SETFILTER(Branch,'%1',BranchLocal);
        SETFILTER("Dinomination Date",'=%1',EntryDate);
        SETFILTER("Date Filter",'%1',EntryDate);
        */

    end;

    var
        TotalAmount: Decimal;
        EntryDate: Date;
        BranchLocal: Code[20];
        // WBU: Codeunit 50000;//tk
        MachineNameRec: Record 7;
        DenominationEntryLocal: Record 50007;
        UserSetup: Record 91;
        BranchEditable: Boolean;
        GLAc: Record 15;
        Editpage: Boolean;
        PreBalance: Decimal;
        [InDataSet]
        CreditCDAc: Code[20];
        ClosingBalance: Decimal;
        PaymentMethod: Record 289;
        GLSetup: Record 98;
        NoSeriesMgt: Codeunit NoSeriesManagement;


    procedure UpdateBalance(DenoNo: Code[20]; ClosingAmt: Decimal)
    var
        DenoEntry: Record 50007;
    begin
        // DenoEntry.SETFILTER(TransType, '%1', TransType::CreditCard);//tk
        DenoEntry.SETFILTER(DenominationNo, '%1', DenoNo);
        IF DenoEntry.FINDFIRST THEN BEGIN
            REPEAT
                DenoEntry."Credit CD Bank AC" := CreditCDAc;
                DenoEntry."Closing Balance" := ClosingAmt;
            UNTIL DenoEntry.NEXT = 0;
        END;
        CurrPage.UPDATE;
        //WBU.RefreshPage();//tk
    end;
}

