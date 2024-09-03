page 50022 "Retail Sales Invoices Line"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    Caption = 'Posted Retail Sales Invoices';
    Editable = false;
    PageType = List;
    SourceTable = "Sales Invoice Line";
    SourceTableView = WHERE(Shield = CONST(False));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleTxt;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleTxt;
                    Visible = true;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleTxt;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleTxt;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                    StyleExpr = StyleTxt;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleTxt;
                }
                field(AMC; Rec.AMC)
                {
                    ApplicationArea = all;
                    Caption = 'APP';
                    StyleExpr = StyleTxt;
                }
                field("AMC Due Date"; Rec."AMC Due Date")
                {
                    ApplicationArea = all;
                    Caption = 'APP Due Date';
                    StyleExpr = StyleTxt;
                }
                field("Warranty Exp. Dt"; Rec."Warranty Exp. Dt")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleTxt;
                }
                //Rushab_CCIT++

                field(SystemCreatedAt; Rec.SystemCreatedAt)

                {

                    Caption = 'Posting Date & Time';

                    ApplicationArea = all;



                    //DataClassification = ToBeClassified;

                }

                field(SystemCreatedBy; REC."User ID")

                {

                    Caption = 'User Id';

                    ApplicationArea = all;

                }

                //Rushab_CCIT--
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                Visible = true;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
        }
    }

    trigger OnAfterGetRecord()
    begin
        //  StyleTxt := SetStyle;   rahul
    end;

    trigger OnOpenPage()
    begin
        ///SetSecurityFilterOnRespCenter;
    end;

    var
        StyleTxt: Text;
}

