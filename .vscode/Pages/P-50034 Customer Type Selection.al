page 50034 "Customer Type Selection"
{
    UsageCategory = Administration;
    ApplicationArea = all;
    PageType = Card;
    SourceTable = Customer;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Customer Type"; Rec."Customer Type")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

