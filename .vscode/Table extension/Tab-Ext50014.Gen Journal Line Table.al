tableextension 50014 "Gen Journal Line Table" extends "Gen. Journal Line"
{
    fields
    {
        field(50001; "PDC Cheque Line"; Integer)
        {
            Description = 'PDC';
        }
        field(50002; "Cheque Deposited"; Boolean)
        {
            Description = 'PDC';
        }
        field(50003; "Bank Deposit Code"; Code[10])
        {
            Description = 'PDC';
        }
        field(50004; "Primary category"; Code[20])
        {
            TableRelation = "Standard Text" WHERE("Category Type" = CONST(Primary));
        }
        field(50005; "Secondary category"; Code[20])
        {
            TableRelation = "Standard Text" WHERE("Category Type" = CONST(Secondary));
        }
        field(50006; "Third category"; Code[20])
        {
            TableRelation = "Standard Text" WHERE("Category Type" = CONST(Third));
        }
        field(50008; "Scheme Code"; Code[10])
        {
        }
        field(50009; "Scheme Amount"; Decimal)
        {
        }
        field(50011; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment";
        }
        field(50012; "Approval Flag"; Boolean)
        {

            trigger OnValidate()
            var
                ApproverID: Text[50];
                SeqNo: Integer;
            begin
                /*
                ApplyEntries.SETCURRENTKEY("Table ID","Document Type","Document No.","Sequence No.");
                ApplyEntries.SETRANGE("Table ID",DATABASE::"Gen. Journal Line");
                ApplyEntries.SETRANGE(ApplyEntries."Document Type",ApplyEntries."Document Type"::"Cash Payment");
                ApplyEntries.SETFILTER(ApplyEntries."Document No.","Document No."+'~'+FORMAT("Line No."));
                SeqNo:=0;
                IF FINDLAST THEN
                   SeqNo:= ApplyEntries."Sequence No.";

                ApplyEntries.SETCURRENTKEY("Approver ID",Status);
                ApplyEntries.SETFILTER(ApplyEntries."Approver ID",USERID);
                ApplyEntries.SETRANGE(ApplyEntries."Sequence No.",SeqNo);
                ApplyEntries.SETRANGE(ApplyEntries."Document Type",ApplyEntries."Document Type"::"Cash Payment");
                ApplyEntries.SETFILTER(ApplyEntries."Document No.","Document No."+'~'+FORMAT("Line No."));
                IF NOT ApplyEntries.FINDFIRST THEN
                BEGIN
                //ApproverID := UserSetupMgt.GetUserApprover(USERID);
                //IF ApproverID <> USERID THEN
                // BEGIN
                   "Approval Flag" := xRec."Approval Flag";
                   MESSAGE('You are not allowed to update Approval Flag');
                // END;
               END;
              */

            end;
        }
        field(50013; Narration; Text[50])
        {
            Description = '//*** WIN241';
        }
        field(50115; "Order ID"; Code[20])
        {
            Description = 'E commerce';
            Editable = false;
        }
        field(52000; "Approval Status"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Pending,Cancelled,Approved,Rejected';
            OptionMembers = " ",Pending,Cancelled,Approved,Rejected;
        }
        field(52002; "Approver ID"; Code[20])
        {
            Caption = 'Approver ID';
            Description = 'Ws-001';
            TableRelation = "User Setup"."User ID";

            trigger OnValidate()
            var
            // AddAppr: Record "Additional Approvers";
            // ApprTemplate: Record "Approval Templates";
            begin
            end;
        }
        field(52004; "Approval Sent Date"; DateTime)
        {
            Description = 'Ws-001';
            Editable = false;
        }
        field(52005; "Approved Date"; DateTime)
        {
            Description = 'Ws-001';
            Editable = false;
        }
        field(52006; CRM; Boolean)
        {
            Description = 'WIN292';
        }
    }
}
