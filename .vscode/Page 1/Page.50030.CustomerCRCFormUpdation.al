page 50030 "Customer CR C Form Updation"
{
    Caption = 'Customer  F-C Form Updation';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    Permissions = TableData 112 = rimd;
    RefreshOnActivate = true;
    SourceTable = 114;
    ApplicationArea = FixedAsset;
    // SourceTableView = WHERE ("State" = FILTER (<> MH),
    //"Form Code"=FILTER(<>' '));//tk

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    Caption = 'Document Date';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field(State; Rec.State)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                // field("Form Code"; "Form Code")
                // {
                // }
                // field("Form No."; "Form No.")
                // {
                // }
                // field("Amount to Customer"; "Amount to Customer")
                // {
                // }//tk
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Form- C Used List ")
            {
                Enabled = false;
                Promoted = true;
                // RunObject = Report 33020853;
                Visible = true;
                ApplicationArea = All;
            }
            action("Form- C Pending List")
            {
                Enabled = false;
                Promoted = true;
                //RunObject = Report 33020854;
                Visible = true;
                ApplicationArea = All;
            }
        }
    }
}

