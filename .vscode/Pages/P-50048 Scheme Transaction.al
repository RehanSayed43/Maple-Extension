page 50048 "Scheme Transaction"
{
    UsageCategory = Administration;
    ApplicationArea = all;
    PageType = Card;
    SourceTable = "Standard Text";
    SourceTableView = WHERE(Scheme = CONST(True));

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Codes; Rec.Code)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field(Scheme; Rec.Scheme)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Scheme Vendor"; Rec."Scheme Vendor")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field(Open; Rec.Open)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(SchItemsEnabled; Rec.SchItemsEnabled)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
            }
            part(Parts; "Scheme Detail List")
            {
                SubPageLink = "Scheme Code" = FIELD(Code);
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action(GetItemList)
            {
                Image = Item;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //   UpdateItemList(Code, "Item Category Code", "Product Group Code", "Starting Date", "Ending Date", "Scheme Vendor");  
                end;
            }
            action("Start Scheme")
            {
                Image = SalesLineDisc;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF rec."Scheme Close Dt" <> 0D THEN
                        ERROR('Scheme Already Closed');
                    IF rec.Open THEN
                        MESSAGE('Scheme Already Started')
                    ELSE BEGIN
                        rec.VALIDATE(Open, TRUE);
                        CurrPage.CLOSE;
                    END;
                end;
            }
            action("Close Scheme")
            {
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Do you want to Close the Scheme') THEN BEGIN
                        rec.VALIDATE(Open, FALSE);
                        rec."Scheme Close Dt" := WORKDATE;
                        CurrPage.UPDATE;
                        CurrPage.CLOSE;
                    END;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        rec.CALCFIELDS(SchItemsEnabled);
        //SchemeHeaderEditable := TRUE;// NOT ( SchItemsEnabled > 0 );
        //CurrPage.EDITABLE := NOT Open;
    end;

    trigger OnInit()
    begin
        //CurrPage.EDITABLE := TRUE;
        //Open := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec.Scheme := TRUE;
        //CurrPage.EDITABLE := TRUE;
        //  GetNextScheme();    
    end;

    trigger OnOpenPage()
    begin
        IF (rec.Open OR (rec."Scheme Close Dt" <> 0D)) THEN
            CurrPage.EDITABLE := FALSE;
        //Open := TRUE;
    end;

    var
        SchemeHeaderEditable: Boolean;
}

