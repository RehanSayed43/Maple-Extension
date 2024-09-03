page 50061 "Transfer Receipt Lines"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    PageType = List;
    SourceTable = "Transfer Receipt Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = all;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                }
                field("Transfer Order No."; Rec."Transfer Order No.")
                {
                    ApplicationArea = all;
                }
                field("Receipt Date"; Rec."Receipt Date")
                {
                    ApplicationArea = all;
                }
                field("In-Transit Code"; Rec."In-Transit Code")
                {
                    ApplicationArea = all;
                }
                field("Transfer-from Code"; Rec."Transfer-from Code")
                {
                    ApplicationArea = all;

                }
                field("Transfer-to Code"; Rec."Transfer-to Code")
                {
                    ApplicationArea = all;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = all;
                }
                // field("Product Group Code"; Rec."Product Group Code")
                // {
                // }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = all;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = all;
                }
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
                field("UPN Code"; Rec."UPN Code")
                {
                    ApplicationArea = all;
                }
                field("Serial No."; SerialNo)
                {
                    ApplicationArea = all;
                }

            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        SerialNo := '';
        RecILE.RESET;
        RecILE.SETRANGE("Document No.", Rec."Document No.");
        RecILE.SETRANGE("Item No.", Rec."Item No.");
        RecILE.SETRANGE("Document Line No.", Rec."Line No.");
        RecILE.SETFILTER("Serial No.", '<>%1', '');
        IF RecILE.FINDFIRST THEN BEGIN
            IF USERID IN ['ADMIN', 'INVENTORYAM', 'PUREXE2'] THEN
                SerialNo := RecILE."Serial No." //win-234 20-03-2019
            ELSE
                SerialNo := '';
        END;//win-234 26-02-2019
    end;

    var
        SerialNo: Text;
        RecILE: Record "Item Ledger Entry";
}

