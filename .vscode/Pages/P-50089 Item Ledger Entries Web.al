page 50089 "Item Ledger Entries-Web"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    Caption = 'Item Ledger Entries-Web';
    DataCaptionExpression = GetCaption;
    DataCaptionFields = "Item No.";
    Editable = false;
    PageType = List;
    SourceTable = "Item Ledger Entry";

    layout
    {
        area(content)
        {
            repeater(Items)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = all;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = all;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field("Invoiced Quantity"; Rec."Invoiced Quantity")
                {
                    ApplicationArea = all;
                    Visible = true;
                }
                field("Remaining Quantity"; Rec."Remaining Quantity")
                {
                    ApplicationArea = all;
                    Visible = true;
                }
                field("Cost Amount (Expected)"; Rec."Cost Amount (Expected)")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Cost Amount (Actual)"; Rec."Cost Amount (Actual)")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    var
        Navigate: Page 344;

    local procedure GetCaption(): Text
    var
        GLSetup: Record "General Ledger Setup";
        ObjTransl: Record "Object Translation";
        Item: Record "Item";
        ProdOrder: Record "Production order";
        Cust: Record "Customer";
        Vend: Record "Vendor";
        Dimension: Record Dimension;
        DimValue: Record "Dimension Value";
        SourceTableName: Text;
        SourceFilter: Text[200];
        Description: Text[100];
    begin
        Description := '';

        CASE TRUE OF
            Rec.GETFILTER("Item No.") <> '':
                BEGIN
                    SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 27);
                    SourceFilter := Rec.GETFILTER("Item No.");
                    IF MAXSTRLEN(Item."No.") >= STRLEN(SourceFilter) THEN
                        IF Item.GET(SourceFilter) THEN
                            Description := Item.Description;
                END;
            (Rec.GETFILTER("Order No.") <> '') AND (Rec."Order Type" = rec."Order Type"::Production):
                BEGIN
                    SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 5405);
                    SourceFilter := Rec.GETFILTER("Order No.");
                    IF MAXSTRLEN(ProdOrder."No.") >= STRLEN(SourceFilter) THEN
                        IF ProdOrder.GET(ProdOrder.Status::Released, SourceFilter) OR
                           ProdOrder.GET(ProdOrder.Status::Finished, SourceFilter)
                        THEN BEGIN
                            SourceTableName := STRSUBSTNO('%1 %2', ProdOrder.Status, SourceTableName);
                            Description := ProdOrder.Description;
                        END;
                END;
            Rec.GETFILTER("Source No.") <> '':
                CASE Rec."Source Type" OF
                    Rec."Source Type"::Customer:
                        BEGIN
                            SourceTableName :=
                              ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 18);
                            SourceFilter := Rec.GETFILTER("Source No.");
                            IF MAXSTRLEN(Cust."No.") >= STRLEN(SourceFilter) THEN
                                IF Cust.GET(SourceFilter) THEN
                                    Description := Cust.Name;
                        END;
                    Rec."Source Type"::Vendor:
                        BEGIN
                            SourceTableName :=
                              ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 23);
                            SourceFilter := Rec.GETFILTER("Source No.");
                            IF MAXSTRLEN(Vend."No.") >= STRLEN(SourceFilter) THEN
                                IF Vend.GET(SourceFilter) THEN
                                    Description := Vend.Name;
                        END;
                END;
            Rec.GETFILTER("Global Dimension 1 Code") <> '':
                BEGIN
                    GLSetup.GET;
                    Dimension.Code := GLSetup."Global Dimension 1 Code";
                    SourceFilter := Rec.GETFILTER("Global Dimension 1 Code");
                    SourceTableName := Dimension.GetMLName(GLOBALLANGUAGE);
                    IF MAXSTRLEN(DimValue.Code) >= STRLEN(SourceFilter) THEN
                        IF DimValue.GET(GLSetup."Global Dimension 1 Code", SourceFilter) THEN
                            Description := DimValue.Name;
                END;
            Rec.GETFILTER("Global Dimension 2 Code") <> '':
                BEGIN
                    GLSetup.GET;
                    Dimension.Code := GLSetup."Global Dimension 2 Code";
                    SourceFilter := Rec.GETFILTER("Global Dimension 2 Code");
                    SourceTableName := Dimension.GetMLName(GLOBALLANGUAGE);
                    IF MAXSTRLEN(DimValue.Code) >= STRLEN(SourceFilter) THEN
                        IF DimValue.GET(GLSetup."Global Dimension 2 Code", SourceFilter) THEN
                            Description := DimValue.Name;
                END;
            Rec.GETFILTER("Document Type") <> '':
                BEGIN
                    SourceTableName := Rec.GETFILTER("Document Type");
                    SourceFilter := Rec.GETFILTER("Document No.");
                    Description := Rec.GETFILTER("Document Line No.");
                END;
        END;
        EXIT(STRSUBSTNO('%1 %2 %3', SourceTableName, SourceFilter, Description));
    end;
}

