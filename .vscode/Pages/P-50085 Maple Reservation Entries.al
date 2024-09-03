page 50085 "Maple Reservation Entries"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = true;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Reservation Entry";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Reservation Status"; Rec."Reservation Status")
                {
                    ApplicationArea = all;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = all;
                }
                field("IMEI No."; Rec."IMEI No.")
                {
                    ApplicationArea = all;
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = all;
                }
                field("Warranty Date"; Rec."Warranty Date")
                {
                    ApplicationArea = all;
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    ApplicationArea = all;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = all;
                }
                field("Qty. to Invoice (Base)"; Rec."Qty. to Invoice (Base)")
                {
                    ApplicationArea = all;
                }
                field("Source ID"; Rec."Source ID")
                {
                    ApplicationArea = all;
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = all;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = all;
                }

            }
        }
    }

    actions
    {
    }

    trigger OnDeleteRecord(): Boolean
    begin
        FIFOTrackingDetails.RESET;
        FIFOTrackingDetails.SETRANGE(Type, FIFOTrackingDetails.Type::Sales);
        FIFOTrackingDetails.SETRANGE("Document No.", Rec."Source ID");
        FIFOTrackingDetails.SETRANGE("Item No.", Rec."Item No.");
        FIFOTrackingDetails.SETRANGE("Selected Serial", Rec."Serial No.");
        IF FIFOTrackingDetails.FINDSET THEN
            FIFOTrackingDetails.DELETEALL;
    end;

    var
        FIFOTrackingDetails: Record 50020;
}

