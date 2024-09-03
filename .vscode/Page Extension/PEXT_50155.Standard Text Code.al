pageextension 50155 StdTextCode extends "Standard Text Codes"
{
    layout
    {
        addafter(Description)
        {
            field("Category Type"; Rec."Category Type")
            {
                ApplicationArea = all;
            }
        }
    }
}