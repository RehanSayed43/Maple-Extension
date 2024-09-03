pageextension 50004 "Item Card" extends "Item Card"
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = all;
            Editable = Editableboo;
            //Editable = false;
            trigger OnAfterValidate()
            BEGIN
                IF Rec."No." = '' then begin
                    ModifyVar := true;
                    If ModifyVar = true then
                        Editableboo := true
                    else
                        Editableboo := false;
                end;

            END;
        }
        modify(Description)
        {


            Editable = Editableboo;
            // trigger OnBeforeValidate()
            // BEGIN
            //     IF not ModifyVar THEN
            //         Error('You do not have permission.');

            // END;
        }

        addafter("No.")
        {
            field("Vendor Part Code Long"; Rec."Vendor Part Code Long")
            {
                Caption = 'Vendor Part Code';
                ApplicationArea = all;
                Editable = Editableboo;
                // trigger OnValidate()
                // BEGIN
                //     IF NOT ModifyVar THEN
                //         Error('You do not have permission.');

                // END;
            }

            field(SKU1; Rec.SKU1)
            {
                Caption = 'SKU';
                ApplicationArea = all;
            }


            field("Ingram Part Code"; Rec."Ingram Part Code")
            {
                ApplicationArea = all;
            }

            field("Assembly BOM"; Rec."Assembly BOM")
            {
                Visible = false;
                ApplicationArea = all;
            }

            field("Lond Description"; Rec."Lond Description")
            {
                Caption = 'Long Description';
                ApplicationArea = all;
            }
        }
        addafter(PreventNegInventoryDefaultYes)
        {
            field("Primary category"; Rec."Primary category")
            {
                ApplicationArea = all;
            }
            field("Secondary category"; Rec."Secondary category")
            {
                ApplicationArea = all;
            }
            field("Third category"; Rec."Third category")
            {
                ApplicationArea = all;
            }
            field(Grade; Rec.Grade)
            {
                ApplicationArea = all;
            }
            field("Purchase Block"; Rec."Purchase Block")
            {
                ApplicationArea = all;
            }
            field("Sales Block"; Rec."Sales Block")
            {
                ApplicationArea = all;
            }
            field("Sales Points"; Rec."Sales Points")
            {
                ApplicationArea = all;
            }
            field(Status; Rec.Status)
            {
                ApplicationArea = all;
            }
            field("Ecommerce Item"; Rec."Ecommerce Item")
            {
                ApplicationArea = all;
            }


        }
        addafter("Item Category Code")
        {
            field("Product Category"; Rec."Product Category")
            {
                Caption = 'Category';
                ApplicationArea = all;
                Visible = true;

            }
        }
        addafter("Serial Nos.")
        {
            field("Last No. Used"; Rec."Last No. Used")
            {
                ApplicationArea = all;
            }
        }
        modify("Item Category Code")
        {
            Caption = 'Brand';
        }

    }

    actions
    {
        addafter(Identifiers)
        {
            action("ECC No./Item Categories")
            {
                Caption = 'ECC No./Item Categories';
                ApplicationArea = All;
                //RunObject = Page "ECC No./Item Categories";
                //RunPageLink = "Item No."=FIELD("No.");
            }
        }
        addafter("BOM Level")
        {
            action(Timeline)
            {
                Caption = 'Timeline';
                Image = Timeline;
                ApplicationArea = All;

                trigger OnAction()
                begin

                    // Rec.ShowTimelineFromItem(Rec);//COMMENTED
                end;
            }
        }

        addbefore("Prepa&yment Percentages")
        {
            action(Prices)
            {
                Caption = 'Prices';
                Image = Price;
                RunObject = Page 7012;
                RunPageLink = "Item No." = FIELD("No.");
                RunPageView = SORTING("Item No.");
                ApplicationArea = All;
            }
            action("Line Discounts")
            {
                Caption = 'Line Discounts';
                Image = LineDiscount;
                RunObject = Page 7014;
                RunPageLink = "Item No." = FIELD("No.");
                ApplicationArea = All;
            }
        }
        addafter("Return Orders")
        {
            action("Nonstoc&k Items")
            {
                Caption = 'Nonstoc&k Items';
                Image = NonStockItem;
                RunObject = Page 5726;
                ApplicationArea = All;
            }
        }

    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        //ModifyVar := true;
        IF (Rec."No." = '') And (Rec.Description = '') then begin
            ModifyVar := true;
            If ModifyVar = true then
                Editableboo := true
            else
                Editableboo := false;
        end;


    end;

    trigger OnModifyRecord(): Boolean
    var
        myInt: Integer;
    begin
        ModifyVar := false;
    end;


    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    BEGIN
        ModifyVar := true;
        If ModifyVar = true then
            Editableboo := true
        else
            Editableboo := false;

        //Message('Insert');
    END;

    var
        myInt: Integer;
        ModifyVar: Boolean;//CCIT-TK
        Editableboo: Boolean;

}