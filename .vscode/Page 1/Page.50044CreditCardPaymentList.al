page 50044 "Credit Card Payment List"
{
    CardPageID = "Credit Card Payment Entry";
    PageType = List;
    SourceTable = 50007;
    SourceTableView = WHERE(TransType = CONST(CreditCard),
                            LineNo = CONST(10000));
    ApplicationArea = FixedAsset;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(DenominationNo; Rec.DenominationNo)
                {
                    ApplicationArea = All;
                }
                field("Dinomination Date"; Rec."Dinomination Date")
                {
                    ApplicationArea = All;
                }
                field(Branch; Rec.Branch)
                {
                    ApplicationArea = All;
                }
                field("Machine Name"; Rec."Machine Name")
                {
                    DrillDown = false;
                    Lookup = false;
                    TableRelation = "Standard Text"."Credit Cd Machine Code" WHERE("Credit Card Machine" = CONST(true));
                    Visible = false;
                    ApplicationArea = All;
                }
                field("TID No"; Rec."TID No")
                {
                    DrillDown = false;
                    Lookup = true;
                    LookupPageID = "Standard Text Codes";
                    TableRelation = "Standard Text"."TID NO" WHERE(TID = CONST(true));
                    Visible = false;
                    ApplicationArea = All;
                }
                field(TotalCreditAmt; Rec.TotalCreditAmt)
                {
                    ApplicationArea = All;
                }
                field("Credit CD Bank AC"; Rec."Credit CD Bank AC")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Document Posted"; Rec."Document Posted")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

