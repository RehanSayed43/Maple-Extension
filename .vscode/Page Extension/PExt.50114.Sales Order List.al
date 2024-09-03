pageextension 50114 "Sales Order List" extends "Sales Order List"
{
    layout
    {
        addafter("No.")
        {
            field("Order ID"; Rec."Order ID")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addbefore(PostAndSend)
        {
            action("Post and &Print")
            {
                Caption = 'Post and &Print';
                Ellipsis = true;
                Image = PostPrint;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'Shift+F9';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.SendToPosting(CODEUNIT::"Sales-Post + Print");
                end;
            }
            action("Post and Email")
            {
                Caption = 'Post and Email';
                Ellipsis = true;
                Image = PostMail;
                ApplicationArea = All;

                trigger OnAction()
                var
                    SalesPostPrint: Codeunit 82;
                begin
                    SalesPostPrint.PostAndEmail(Rec);
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        SalesSetup: Record 311;
        CRMIntegrationManagement: Codeunit 5330;
    begin
        /*
        IF UserMgt.GetSalesFilter <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Responsibility Center New 1",UserMgt.GetSalesFilter);//WIn345
          FILTERGROUP(0);
        END;
        */
        UserSetup.GET(USERID);
        IF UserSetup."Location Code" <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Location Code", UserSetup."Location Code");
            Rec.FILTERGROUP(0);
        END;


    end;

    var
        myInt: Integer;
        UserSetup: Record 91;
        UserMgt: Codeunit 5700;
}