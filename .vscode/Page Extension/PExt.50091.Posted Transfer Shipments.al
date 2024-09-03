pageextension 50091 PostedTransferShip extends "Posted Transfer Shipments"
{
    layout
    {
        addafter("Posting Date")
        {
            field("Handover To Name"; Rec."Handover To Name")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        addafter("&Print")
        {
            action("Print- GST Branch Transfer") //kj
            {
                Caption = 'Print- GST Branch Transfer';
                Image = PrintVAT;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;
                Visible = true;

                trigger OnAction()
                begin
                    RecTSH.RESET;
                    RecTSH.SETRANGE("No.", Rec."No.");
                    REPORT.RUNMODAL(50008, TRUE, FALSE, RecTSH);
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        // UserSetup.GET(USERID);
        // IF (UserSetup."Location Filter" <> '') AND (UserSetup."All Location Transfer" <> true) THEN BEGIN
        //     FILTERGROUP(2);
        //     SETRANGE("Transfer-From Code", UserSetup."Location Filter");
        //     FILTERGROUP(0);
        // END;
    end;

    var

        TransShptHeader: Record 5744;
        RecTSH: Record 5744;
        UserSetup: Record 91;
}