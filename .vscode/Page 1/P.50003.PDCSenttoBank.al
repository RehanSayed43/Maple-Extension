page 50003 "PDC Sent to Bank"
{
    DeleteAllowed = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 50002;
    SourceTableView = WHERE("Sent to Bank" = FILTER(true),
                            "PDC Deposited" = FILTER(false));
    ApplicationArea = FixedAsset;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("PDC Type"; Rec."PDC Type")
                {
                    ApplicationArea = All;
                }
                field("Res Center"; Rec."Res Center")
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
                field("PDC Amount Applied"; Rec."PDC Amount Applied")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part(Link; 9082)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Open)
            {
                Caption = 'ReOpen';
                Promoted = true;
                Visible = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //recDepositeCheque.GET(recDepositeCheque.id::"0","Entry No.");//tk
                    recDepositeCheque.DELETE;
                    //"Res Center" := "Res Center"::"0";
                    Rec."Sent to Bank" := FALSE;
                    Rec."PDC Deposited" := FALSE;
                    Rec.MODIFY;
                end;
            }
        }
    }

    var
        recDepositeCheque: Record 50006;
}

