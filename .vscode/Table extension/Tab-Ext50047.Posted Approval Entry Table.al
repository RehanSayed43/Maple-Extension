tableextension 50047 "Posted Approval Entry Table" extends "Posted Approval Entry"
{
    fields
    {
        field(52000; "Voucher Doc. Type"; Option)
        {
            Description = 'Ws-001';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
    }
}
