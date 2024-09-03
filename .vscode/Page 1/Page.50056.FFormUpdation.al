page 50056 "F Form Updation"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    Permissions = TableData 5740 = rm;
    SourceTable = 5746;
    SourceTableView = SORTING("No.");
    ApplicationArea = FixedAsset;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Transfer Order No."; Rec."Transfer Order No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Transfer-from Code"; Rec."Transfer-from Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Transfer-from Name"; Rec."Transfer-from Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Transfer-to Code"; Rec."Transfer-to Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Transfer-to Name"; Rec."Transfer-to Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Receipt Date"; Rec."Receipt Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                // field("Form Code"; "Form Code")
                // {
                // }
                // field("F Form No."; "F Form No.")
                // {

                //     trigger OnValidate()
                //     begin
                //         "Form Code" := 'F';
                //     end;
                // }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

