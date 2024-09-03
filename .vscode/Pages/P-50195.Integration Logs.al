page 50195 "Integration Logs"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Integration Logs";
    Editable = false;
    InsertAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field("Order ID"; Rec."Order ID")
                {
                    ToolTip = 'Specifies the value of the Order ID field.';
                }
                field("Invoice No."; Rec."Invoice No.")
                {
                    ToolTip = 'Specifies the value of the Invoice No. field.';
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ToolTip = 'Specifies the value of the Creation Date field.';
                }
                field(Request; Rec.Request)
                {
                    ToolTip = 'Specifies the value of the Request field.';
                }
                field(Response; Rec.Response)
                {
                    ToolTip = 'Specifies the value of the Response field.';
                }
                field(Token; Rec.Token)
                {
                    ToolTip = 'Specifies the value of the Token field.';
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}