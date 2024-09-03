pageextension 50014 "User Setup" extends "User Setup"
{
    layout
    {
        addafter("Service Resp. Ctr. Filter")
        {

            field("Location Filter"; Rec."Location Filter")
            {
                ApplicationArea = all;
            }
            field("Location Code"; Rec."Location Code")
            {
                ApplicationArea = all;
            }
            field("All Location Transfer"; Rec."All Location Transfer")
            {
                ApplicationArea = all;
            }


            field("Allow Req. View All"; Rec."Allow Req. View All")
            {
                ApplicationArea = all;
            }


            field("Super User"; Rec."Super User")
            {
                ApplicationArea = all;
            }

            field("Ingram User"; Rec."Ingram User")
            {
                ApplicationArea = all;
            }

            field("Reason Code mandatory"; Rec."Reason Code mandatory")
            {
                ApplicationArea = all;
            }
            field(password; Rec.password)
            {
                ApplicationArea = all;
            }
            field("Web User"; Rec."Web User")
            {
                ApplicationArea = all;
            }
            field("Close PO"; Rec."Close PO")
            {
                ApplicationArea = all;
            }
            field("Capillary Disc.  Order Delete"; Rec."Capillary Disc.  Order Delete")
            {
                Editable = false;
                ApplicationArea = all;
            }
            field("CRT Approval"; Rec."CRT Approval")
            {
                ApplicationArea = all;
            }
            field("CRT Verifier"; Rec."CRT Verifier")
            {
                ApplicationArea = all;
            }
            field("Allow Back Dated Entry"; Rec."Allow Back Dated Entry")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Allow Back Dated Entry field.';
            }
            /* field("Customer Edit"; "Customer Edit")
             {
                 ApplicationArea = All;
                 Visible = EditAllowCust;
                 trigger OnValidate()
                 BEGIN
                     //IF (USERID <> 'KAILAS.THUBE') AND (USERID <> 'ADMIN') THEN
                     // Error('You are not allowed to modify');
                 END;
             }*/
        }
        modify("Allow Posting From")
        {
            ApplicationArea = all;
            trigger OnBeforeValidate()
            BEGIN
                IF (USERID <> 'KAILAS.THUBE') AND (USERID <> 'ADMIN') THEN
                    Error('You are not allowed to modify');
            END;
        }
        modify("Allow Posting To")
        {
            ApplicationArea = all;
            trigger OnBeforeValidate()
            BEGIN
                IF (USERID <> 'KAILAS.THUBE') AND (USERID <> 'ADMIN') THEN
                    Error('You are not allowed to modify');
            END;
        }

    }

    actions
    {

    }
    trigger OnAfterGetCurrRecord()
    begin
        EditAllowPostingDate := Rec."Allow Back Dated Entry"; //<< KPPLRJ3.00
    end;

    trigger OnAfterGetRecord()
    begin
        EditAllowPostingDate := Rec."Allow Back Dated Entry"; //<< KPPLRJ3.00
    end;

    trigger OnOpenPage()
    begin
        EditAllowPostingDate := TRUE; //<< KPPLRJ3.00
        EditAllowCust := FALSE; //CCIT AN

        IF (USERID = 'KAILAS.THUBE') OR (USERID = 'ADMIN') THEN
            EditAllowCust := TRUE;

        IF (USERID = 'ACCAPV') OR (USERID = 'MAPLEIT') THEN
            AllowBackDateEditable := TRUE;
    end;


    var
        myInt: Integer;
        EditAllowPostingDate: Boolean;
        AllowBackDateEditable: Boolean;

        EditAllowCust: Boolean;
}