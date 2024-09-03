page 50009 "Posted PDC List"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 50002;
    SourceTableView = SORTING("Entry No.")
                      ORDER(Ascending)
                      WHERE("Document No." = FILTER(<> ''));
    ApplicationArea = FixedAsset;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                }

                field("PDC Type"; Rec."PDC Type")
                {
                    ApplicationArea = all;
                }

                field("Res Center"; Rec."Res Center")
                {
                    ApplicationArea = all;

                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = all;
                }

                field(Name; Rec.Name)
                {
                    ApplicationArea = all;
                }

                field("PDC Received Date"; Rec."PDC Received Date")
                {
                    ApplicationArea = all;
                }

                field("PDC Cheque Date"; Rec."PDC Cheque Date")
                {
                    ApplicationArea = all;
                }

                field("PDC Amount"; Rec."PDC Amount")
                {
                    ApplicationArea = all;
                }

                field("MICR Code"; Rec."MICR Code")
                {
                    ApplicationArea = all;
                }

                field("Bank No."; Rec."Bank No.")
                {
                    ApplicationArea = all;
                }

                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = all;
                }

                field("Bank Deposit Code"; Rec."Bank Deposit Code")
                {
                    ApplicationArea = all;
                }

                field("PDC Deposit Date"; Rec."PDC Deposit Date")
                {
                    ApplicationArea = all;
                }

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
                    Caption = 'Applied Entries';
                    Image = Statistics;
                    Promoted = false;
                    ApplicationArea = all;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    begin
                        pApplnBuffer.RESET;
                        pApplnBuffer.SETFILTER(pApplnBuffer."Document Type", '=%1', Rec."Entry No.");
                        PAGE.RUN(50010, pApplnBuffer);
                    end;
                }
            }
        }
        area(reporting)
        {
            action("<Action1906813206>")
            {
                Caption = 'PDC in Hand';
                Promoted = false;
                ApplicationArea = all;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                // RunObject = Report 50000;//tk
            }
            action("<Action1907586706>")
            {
                Caption = 'PDC Received';
                Promoted = false;
                ApplicationArea = all;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                // RunObject = Report 50001;//tk
            }
            action("<Action1902299006>")
            {
                Caption = 'Receivable PDC';
                Promoted = false;
                ApplicationArea = all;

                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                //RunObject = Report 50002;
            }
        }
    }

    var
        pApplnBuffer: Record 50004;
}

