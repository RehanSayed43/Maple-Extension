pageextension 50154 extendsResourcesSetup extends "Resources Setup"
{
    layout
    {
        addafter(Numbering)
        {
            group("Voucher Integration")
            {
                field("Voucher Base URL"; Rec."Voucher Base URL")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Voucher Base URL field.';
                }
                field("Voucher Auth Base URL"; Rec."Voucher Auth Base URL")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Voucher Auth Base URL field.';
                }
                field("Transaction Base URL"; Rec."Transaction Base URL")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transaction Base URL field.';
                }
                field("Capture Base URL"; Rec."Capture Base URL")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Capture Base URL field.';
                }
                field("Refund Base URL"; Rec."Refund Base URL")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Refund Base URL field.';
                }
                field("Cancel Base URL"; Rec."Cancel Base URL")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cancel Base URL field.';
                }
                field("Show Json"; Rec."Show Json")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Show Json field.';
                }

            }
        }
    }
    actions
    {

    }
}
