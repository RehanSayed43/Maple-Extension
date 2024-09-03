page 50028 "Vendor CR C Form Updation"
{
    Caption = 'Vendor C Form Updation';
    DeleteAllowed = false;
    UsageCategory = Lists;
    InsertAllowed = false;
    ApplicationArea = all;
    PageType = List;
    Permissions = TableData 122 = rimd;
    RefreshOnActivate = true;
    SourceTable = "Purch. Cr. Memo Hdr.";
    // SourceTableView = WHERE(State = FILTER(<> MH),
    //                         "Form Code" = CONST(<>''),
    //                         Form No.=CONST(''));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = all;
                }
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    ApplicationArea = all;
                }
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                    ApplicationArea = all;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = all;
                    Caption = 'Vendor Invoice Date';
                    Editable = false;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                /*  rahul---------------------------------------
                
                  field(State; Rec.State)
                   {
                       ApplicationArea = all;
                       Editable = false;
                   }
                   field("Amount to Vendor"; Rec."Amount to Vendor")
                   {
                       ApplicationArea = all;
                   }
                   field("Form Code"; Rec."Form Code")
                   {
                       ApplicationArea = all;
                   }

                   field("Form No."; Rec."Form No.")
                   {
                       ApplicationArea = all;
                   }
                   */
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Form- C Used List ")
            {
                Promoted = true;
                // RunObject = Report 33020853;
                Visible = true;
                ApplicationArea = All;
            }
            action("Form- C Pending List")
            {
                Image = Print;
                Promoted = true;
                ApplicationArea = All;
                //  RunObject = Report 33020854;
            }
        }
    }
}

