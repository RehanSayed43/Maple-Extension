page 50165 "Discounting"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = 50065;

    layout
    {
        area(content)
        {
            repeater(Repeater)
            {
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = all;
                    editable = false;
                    visible = True;
                }
                field("Discount Type"; Rec."Discount Type")
                {
                    ApplicationArea = all;
                }
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = all;
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;

                }
                field("Discount %"; Rec."Discount %")
                {
                    ApplicationArea = all;
                }
                field("Sales Type"; Rec."Sales Type")
                {
                    ApplicationArea = all;
                }
                field("Maximum % Limit"; Rec."Maximum % Limit")
                {
                    ApplicationArea = all;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                    Caption = 'BRAND';
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        If Rec."Discount Type" <> 'NO DISCOUNT' then begin
                            rec.TestField("Primary category");

                        end;
                    end;

                }
                field("Primary category"; Rec."Primary category")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        If Rec."Discount Type" <> 'NO DISCOUNT' then begin
                            rec.TestField("Primary category");

                        end;
                    end;
                }
                field("Secondary category"; Rec."Secondary category")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        If Rec."Discount Type" <> 'NO DISCOUNT' then begin
                            rec.TestField("Primary category");

                        end;
                    end;
                }
                field("Third category"; Rec."Third category")
                {
                    ApplicationArea = all;
                    //ShowMandatory=true;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        If Rec."Discount Type" <> 'NO DISCOUNT' then begin
                            rec.TestField("Primary category");
                            Rec.TestField("Secondary category");
                        end;
                    end;
                }
                field("Product Category"; Rec."Product Category")
                {



                    ApplicationArea = all;
                    Visible = false;

                }
                field("Active/Inactive"; Rec."Active/Inactive")
                {
                    ApplicationArea = all;
                    Caption = 'Block';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }


    }


    trigger OnClosePage()
    var
        myInt: Integer;
    begin
        If Rec."Discount Type" <> 'NO DISCOUNT' then begin
            rec.TestField("Primary category");
            Rec.TestField("Secondary category");
        end;

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        if UserId <> 'KAVISH.S' then
            Error('You do not have permission to insert');
    end;





    var
        myInt: Integer;
        table: Record "Item Category";
}