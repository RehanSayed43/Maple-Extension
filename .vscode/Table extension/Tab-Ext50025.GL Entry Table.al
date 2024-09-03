tableextension 50025 "G/LEntry Table" extends "G/L Entry"
{
    fields
    {
        field(50001; "Scheme Code"; Code[10])
        {
        }
        field(50002; "Scheme Amount"; Decimal)
        {
        }
        field(50003; "Bal Account Name"; Text[50])
        {
            Description = 'WIN316';
            Editable = false;
        }
        field(50013; Narration; Text[50])
        {
            Description = '//*** WIN241';
        }
        field(50014; "Creation Date"; Date)
        {
        }
        field(50034; "New External Document No "; Code[35])
        {
            Caption = 'New External Document No.';
        }
    }
}
