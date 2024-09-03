tableextension 50010 "Bank Account Table" extends "Bank Account"
{
    fields
    {
        field(50000; "IFSCCode"; Code[20])
        {
            Description = 'win127';
        }
    }
}
