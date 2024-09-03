page 50196 "Customer Retail List New"
{
    Caption = 'Customer Retail List';
    // UsageCategory = Lists;
    // ApplicationArea = all;
    CardPageID = "Customer Retail Master";
    PageType = List;
    SourceTable = Customer;
    //SourceTableView = WHERE("Customer Type" = CONST(Retail));
    Editable = True;
    InsertAllowed = True;
    ModifyAllowed = true;
    DeleteAllowed = true;
    ApplicationArea = FixedAsset;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = all;
                }
            }
            part("Posted Invoices"; 50017)
            {
                ApplicationArea = all;
                Caption = 'Posted Invoices';
                Editable = false;
                ShowFilter = false;
                SubPageLink = "Sell-to Customer No." = FIELD("No.");
            }
            part("Customer History"; 50055)
            {
                ApplicationArea = all;
                Caption = 'Customer History';
                Editable = false;
                SubPageLink = "Source No." = FIELD("No.");
            }
        }
    }

    actions
    {
    }
}

