pageextension 50084 "Transfer Order" extends "Transfer Order"
{
    layout
    {

        modify("In-Transit Code")
        {
            ApplicationArea = all;
            Editable = false;
        }
        addafter("Posting Date")
        {
            field("Handover To Name"; Rec."Handover To Name")
            {
                ApplicationArea = all;
            }

            field("Rental Sales Invoice No."; Rec."Rental Sales Invoice No.")
            {
                Editable = false;
                Style = StrongAccent;
                StyleExpr = TRUE;

                ApplicationArea = all;
            }
            field("Rental Transfer"; Rec."Rental Transfer")
            {
                ApplicationArea = all;

                trigger OnValidate()
                begin
                    //WIN336
                    BEGIN
                        IF Rec."Rental Transfer" = FALSE THEN
                            Rec."Customer No." := '';
                    END;
                    //WIN336
                end;
            }
            field("Customer No."; Rec."Customer No.")
            {
                ApplicationArea = all;

                trigger OnValidate()
                begin
                    //WIN336
                    BEGIN
                        IF Rec."Customer No." <> '' THEN BEGIN
                            Rec."Rental Transfer" := TRUE
                        END;
                    END;
                    //WIN336
                end;
            }
            field("Last Shipment No."; Rec."Last Shipment No.")
            {
                ApplicationArea = all;
            }
            field("Last Receipt No."; Rec."Last Receipt No.")
            {
                ApplicationArea = all;
            }
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = all;
            }

            field("Shipped By User ID"; Rec."Shipped By User ID")
            {
                ApplicationArea = all;
            }
            field("Received By User ID"; Rec."Received By User ID")
            {
                ApplicationArea = all;
            }
        }
        movebefore("No."; "Transfer-from Code")
        //movebefore("Transfer-from Code"; "No.")
    }

    actions
    {
        modify(PostAndPrint)
        {
            Visible = false;
            trigger OnAfterAction()
            var
                myInt: Integer;
                ILE: Record "Item Ledger Entry";
                TransferLine: Record "Transfer Line";
                ReservationEntry: Record "Reservation Entry";


            begin

                TransferLine.Reset();
                TransferLine.SetRange(TransferLine."Document No.", Rec."No.");
                IF TransferLine.FindSet() THEN
                    REPEAT
                        ReservationEntry.Reset();
                        ReservationEntry.SetRange(ReservationEntry."Item No.", TransferLine."Item No.");
                        ReservationEntry.SetRange(ReservationEntry."Source Type", 5741);
                        ReservationEntry.SetRange(ReservationEntry."Source ID", TransferLine."Document No.");
                        ReservationEntry.SetRange(ReservationEntry."Source Prod. Order Line", TransferLine."Line No.");
                        ReservationEntry.SetRange(ReservationEntry."Location Code", Rec."Transfer-to Code");
                        IF ReservationEntry.FindSet() THEN
                            REPEAT
                                //>>
                                ILE.Reset();
                                ILE.SetRange(ILE."Entry Type", ILE."Entry Type"::Transfer);
                                ILE.SetRange(ILE."Item No.", TransferLine."Item No.");
                                ILE.SetRange(ILE."Location Code", Rec."Transfer-from Code");
                                ILE.SetRange(ILE."Order Type", ILE."Order Type"::Transfer);
                                ILE.SetRange(ILE."Order No.", TransferLine."Document No.");
                                ILE.SetRange(ILE."Order Line No.", TransferLine."Line No.");
                                ILE.SetRange(ILE."Serial No.", ReservationEntry."Serial No.");
                                ILE.SetRange(ILE."Item Tracking", ILE."Item Tracking"::"Serial No.");
                                IF ILE.FindFirst() THEN BEGIN
                                    ReservationEntry."IMEI No." := ILE."IMEI No.";
                                    ReservationEntry."MRP Value" := ILE."MRP Value";
                                    ReservationEntry.Modify(false);
                                END;
                            //<<
                            UNTIL ReservationEntry.Next() = 0;
                    UNTIL TransferLine.Next() = 0;

            end;
        }
    }

    var
        myInt: Integer;
}