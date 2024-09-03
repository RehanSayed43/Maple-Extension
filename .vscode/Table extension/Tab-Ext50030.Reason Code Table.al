tableextension 50030 "Reason Code Table" extends "Reason Code"
{
    fields
    {
        field(50000; "Document Type"; Option)
        {
            OptionCaption = ' ,Cash,Bank';
            OptionMembers = " ",Cash,Bank;
        }
    }
}
