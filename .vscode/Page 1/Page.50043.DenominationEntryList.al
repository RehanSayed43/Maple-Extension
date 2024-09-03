page 50043 "Denomination Entry List"
{
    CardPageID = "Denomination Entry";
    PageType = List;
    SourceTable = 50007;
    SourceTableView = WHERE(TransType = CONST(Denomination));
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
                field(TotalAmt; Rec.TotalAmt)
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
                field("Location Code"; Rec."Location Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    var
        UserSetup: Record 91;
    begin
        UserSetup.GET(USERID);
        Rec.SETFILTER("Location Code", '%1', UserSetup."Location Code");
    end;
}

