pageextension 50000 "PurchaseOrder" extends "Purchase Order"
{


    layout
    {
        modify("Location Code")
        {
            ApplicationArea = all;
            Visible = true;
            Editable = true;
        }
        moveafter("Vendor Invoice No."; "Location Code")
        addbefore("Purchaser Code")
        {

            field("Vendor Invoice Date"; Rec."Vendor Invoice Date")
            {
                ApplicationArea = all;
            }
            field("Import Document No."; Rec."Import Document No.")
            {
                ApplicationArea = all;
            }

        }
        addafter("Purchaser Code")
        {

            field("Vendor Invoice Value"; Rec."Vendor Invoice Value")
            {
                ApplicationArea = all;
            }
            field("PO Validity Date"; Rec."PO Validity Date")
            {
                ApplicationArea = all;
            }
            field("Closing Remark"; Rec."Closing Remark")
            {
                ApplicationArea = all;
            }
            field(Closed; Rec.Closed)
            {
                Editable = false;
                ApplicationArea = all;
            }
            field("Remarks Team"; Rec."Remarks Team")
            {
                ApplicationArea = all;
            }
            field("Remarks Vendor"; Rec."Remarks Vendor")
            {
                ApplicationArea = all;
            }
            field("CIN Number"; recComp."CIN no")
            {
                ApplicationArea = all;
            }
            field("Ingram Order No."; Rec."Ingram Order No.")
            {
                Editable = true;
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        addafter("Co&mments")
        {
            action("Send mail to Vendor")
            {
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF (Rec.Status <> Rec.Status::Released) THEN
                        ERROR('Purchase order is not Approved');
                    WBU.SendMailtoVendorwithAttachment(Rec);//tk
                end;
            }
            action(UploadSerialNo)
            {
                Caption = 'Upload Serial No.';
                Image = ImportCodes;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    XMLPORT.RUN(XMLPORT::"Upload Serial No.", FALSE, TRUE); //KPPL-INGRAM
                end;
            }
        }
        addbefore(Documents)
        {
            group(Closing)
            {
                action("Close Purchase Order")
                {
                    Ellipsis = true;
                    Image = Close;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        PurchLine: Record 39;
                        UserSetup: Record 91;
                    begin
                        UserSetup.GET(USERID);
                        IF NOT UserSetup."Close PO" THEN
                            EXIT;

                        PurchLine.RESET;
                        PurchLine.SETRANGE("Document Type", Rec."Document Type");
                        PurchLine.SETRANGE(PurchLine."Document No.", Rec."No.");
                        IF PurchLine.FINDSET THEN BEGIN
                            REPEAT
                                IF PurchLine."Qty. Rcd. Not Invoiced" <> 0 THEN
                                    ERROR('You can not close the Purchase Order, Received Quantity & Invoiced Quantity are not matching for Item %1', PurchLine."No.");
                            UNTIL PurchLine.NEXT = 0;
                        END;
                        IF Rec."Closing Remark" = '' THEN
                            ERROR('Closing Remark should not be blank')
                        ELSE BEGIN
                            PurchLine.RESET;
                            PurchLine.SETRANGE(PurchLine."Document Type", Rec."Document Type");
                            PurchLine.SETRANGE(PurchLine."Document No.", Rec."No.");
                            IF PurchLine.FINDSET THEN BEGIN
                                REPEAT
                                    PurchLine.Quantity := PurchLine."Quantity Received";
                                    PurchLine.MODIFY;
                                UNTIL PurchLine.NEXT = 0;
                            END;

                            Rec.Closed := TRUE;
                            Rec."Closed By" := USERID;
                            Rec."Closed Date & Time" := CURRENTDATETIME;
                        END;
                        //Win 127
                        CurrPage.CLOSE;
                    end;
                }

            }

        }

        addbefore(Post)
        {
            action("Serial Details")
            {
                Caption = 'Serial Details';
                Ellipsis = true;
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'F9';
                ApplicationArea = All;

                trigger OnAction()
                var
                    PurchasePostViaJobQueue: Codeunit 98;
                    PurchLine: Record 39;
                begin
                    // CLEAR(PODetails);
                    // RecpurcLine12.RESET;
                    // RecpurcLine12.SETFILTER(RecpurcLine12."No.", "No.");
                    // IF RecpurcLine12.FINDFIRST THEN BEGIN
                    //     PODetails.SETTABLEVIEW(RecpurcLine12);
                    //     PODetails.RUNMODAL;
                    //END;
                    //Try now
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        //SetDocNoVisible;//tk

        IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter);
            Rec.FILTERGROUP(0);
            Rec.SETFILTER("Location Code", Rec."Location Code");
        END;
        recComp.GET; //win344
    end;

    var

        PurchSetup: Record 312;
        ChangeExchangeRate: Page 511;
        CopyPurchDoc: Report 492;
        MoveNegPurchLines: Report 6698;
        ReportPrint: Codeunit 228;
        //DocPrint: Codeunit 229;
        UserMgt: Codeunit 5700;
        ArchiveManagement: Codeunit 5063;
        PurchCalcDiscByType: Codeunit 66;
        PurchLine: Record 39;

        myInt: Integer;
        ReservEntry: record 337;

        BillAmtCalc: Decimal;
        PurchLineRec11: Record 39;
        DiffAmt: Decimal;
        TrackingSpecification: Record 336;
        ItemTackingLine: Page 6510;
        //PODetails: Report 50030;

        CreateReservEntry: Codeunit 99000830;

        ReservePurchLine: Codeunit 99000834;
        RecpurcLine12: Record 38;
        // PODetails: Report 50030;//tk
        recComp: Record 79;
        RecPH: Record 38;
        WBU: codeunit 50000;



    local procedure Post(PostingCodeunitID: Integer)
    begin
        Rec.SendToPosting(PostingCodeunitID);
        IF Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting" THEN
            CurrPage.CLOSE;
        CurrPage.UPDATE(FALSE);
    end;

    local procedure BuyfromVendorNoOnAfterValidate()
    begin
        IF Rec.GETFILTER("Buy-from Vendor No.") = xRec."Buy-from Vendor No." THEN
            IF Rec."Buy-from Vendor No." <> xRec."Buy-from Vendor No." THEN
                Rec.SETRANGE("Buy-from Vendor No.");
        CurrPage.UPDATE;
    end;



    local procedure PaytoVendorNoOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    procedure UpdateSerialNo(PurchLine: Record 39)
    begin

    end;

    procedure DeletePurchSpecification(PurchHeader: Record 38)
    begin
        //win344++
        //ItemTrackingForm.SetSource(ReservEntry,PurchLine."Expected Receipt Date");
        //ItemTrackingForm.SetInbound(PurchLine.IsInbound);
        //ItemTrackingForm.RUNMODAL;
        /*
        ReservEntry.SETCURRENTKEY("Source ID","Source Type",
          "Source Subtype","Source Batch Name","Source Prod. Order Line","Source Ref. No.");
        ReservEntry.SETRANGE("Source ID",PurchHeader."No.");
        ReservEntry.SETRANGE("Source Type",DATABASE::"Purchase Line");
        ReservEntry.SETRANGE("Source Subtype",PurchHeader."Document Type");
        ReservEntry.SETRANGE("Source Batch Name",'');
        ReservEntry.SETRANGE("Source Prod. Order Line",0);
        //ReservEntry.SETRANGE("Source Ref. No.",PurchLine."Line No.");
        IF ReservEntry.FINDSET THEN
          REPEAT
            ReservEntry.DELETE;
          UNTIL ReservEntry.NEXT = 0;
         */
        ReservEntry.SETCURRENTKEY(
          "Source ID", "Source Ref. No.", "Source Type", "Source Subtype",
          "Source Batch Name", "Source Prod. Order Line", "Reservation Status",
          "Shipment Date", "Expected Receipt Date");
        ReservEntry.SETRANGE("Source ID", PurchHeader."No.");
        //ReservEntry.SETRANGE("Source Ref. No.",ReservEntry."Source Ref. No.");
        ReservEntry.SETRANGE("Source Type", DATABASE::"Purchase Line");
        ReservEntry.SETRANGE("Source Subtype", PurchHeader."Document Type");
        ReservEntry.SETRANGE("Source Batch Name", '');
        ReservEntry.SETRANGE("Source Prod. Order Line", 0);
        IF ReservEntry.FINDSET THEN
            REPEAT
                ReservEntry.DELETE;
            UNTIL ReservEntry.NEXT = 0;
        //win344--

    end;

    procedure ReservEntryExistPurchLine(PurchLine: Record 39): Boolean
    var
        NewReservEntry: Record 337;
    begin
        ReservEntry.RESET;
        ReservEntry.SETRANGE("Source ID", PurchLine."Document No.");
        ReservEntry.SETRANGE("Source Ref. No.", PurchLine."Line No.");
        ReservEntry.SETRANGE("Source Type", DATABASE::"Purchase Line");
        ReservEntry.SETRANGE("Source Subtype", PurchLine."Document Type");
        ReservEntry.SETRANGE("Source Batch Name", '');
        ReservEntry.SETRANGE("Source Prod. Order Line", 0);
        EXIT(ReservEntry.FINDSET);
    end;

}