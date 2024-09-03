page 50154 "E-Invoice Entry"
{
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "EInvoice Entry";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Creation DateTime"; Rec."Creation DateTime")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(IRN; Rec.IRN)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("QR Code"; Rec."QR Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Acknowledgment Date"; Rec."Acknowledgment Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Acknowledgment_number; Rec.Acknowledgment_number)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Signed Invoice"; Rec."Signed Invoice")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Cancel DateTime"; Rec."Cancel DateTime")
                {
                    ApplicationArea = all;
                }
                field("Cancel Reason"; Rec."Cancel Reason")
                {
                    ApplicationArea = all;
                }
                field("Cancel Remarks"; Rec."Cancel Remarks")
                {
                    ApplicationArea = all;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = all;
                }

                field("LR/RR No."; Rec."LR/RR No.")
                {
                    ApplicationArea = all;
                }
                field("LR/RR Date"; Rec."LR/RR Date")
                {
                    ApplicationArea = all;
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ApplicationArea = all;
                }
                field("Mode of Transport"; Rec."Mode of Transport")
                {
                    ApplicationArea = all;
                }
                field("Distance (Km)"; Rec."Distance (Km)")
                {
                    ApplicationArea = all;
                }
                field("Vehicle Type"; Rec."Vehicle Type")
                {
                    ApplicationArea = all;
                }

                field("Transport Method"; Rec."Transport Method")
                {
                    ApplicationArea = all;
                }
                field(EwbNo; Rec.EwbNo)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(EwbDt; Rec.EwbDt)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(EwbValidTill; Rec.EwbValidTill)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Eway Cancel Reason"; Rec."Eway Cancel Reason")
                {
                    ApplicationArea = all;
                }
                field("Eway Cancel Remarks"; Rec."Eway Cancel Remarks")
                {
                    ApplicationArea = all;
                }
                field("Eway Cancel Date"; Rec."Eway Cancel Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Generate Eway By IRN")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    recLoc: Record 14;
                    recTSH: Record 5744;
                begin
                    /*
                    TESTFIELD(EwbNo,'');
                    IF recSIH.GET("Document No.") THEN BEGIN
                     recLoc.GET(recSIH."Location Code");
                     ASP_cdEInvoice.ReadGenerateEwayByIRN("Document Type","Document No.",recLoc."GST Registration No.");
                    END;
                    IF recTSH.GET("Document No.") THEN BEGIN
                     IF recLoc.GET(recTSH."Transfer-from Code") THEN
                      ASP_cdEInvoice.ReadGenerateEwayByIRN("Document Type","Document No.",recLoc."GST Registration No.");
                    END;
                    */

                end;
            }
            action("Cancel E-invoice")
            {
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    recLoc: Record 14;
                    recTSH: Record 5744;
                    DocType: Option Invoice,"Credit Memo",Transfer;
                // ASP_cdEInvoice: Codeunit "50012";
                begin
                    /*
                     TESTFIELD("Cancel Reason");
                     TESTFIELD("Cancel Remarks");
                    
                    
                     IF recTSH.GET("Document No.") THEN BEGIN
                     IF recLoc.GET(recTSH."Transfer-from Code") THEN
                      recLoc.TESTFIELD(recLoc."GST Registration No.");
                      ASP_cdEInvoice.CancelatioinIRN("Document No.","Document No.","Cancel Reason","Cancel Remarks",recLoc."GST Registration No.",DocType::Transfer);
                     END;
                     */

                end;
            }
            action("Cancel Eway")
            {
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    recLoc: Record 14;
                    recTSH: Record 5744;
                    DocType: Option Invoice,"Credit Memo",Transfer;
                    recPRH: Record 124;
                    recSIH: Record 112;
                //      ASP_cdEway: Codeunit "50013";
                begin
                    /*
                    IF "Document Type" ="Document Type"::"Credit Memo" THEN
                      ERROR('Can not cancel the credit memo');
                    
                     TESTFIELD(EwbNo);
                     TESTFIELD("Eway Cancel Reason");
                     TESTFIELD("Eway Cancel Remarks");
                    
                     IF recSIH.GET("Document No.") THEN
                     IF  recLoc.GET(recSIH."Location Code") THEN
                      ASP_cdEway.CancelatioinIRN(Rec,recLoc."GST Registration No.");
                    
                     IF recTSH.GET("Document No.") THEN BEGIN
                     IF recLoc.GET(recTSH."Transfer-from Code") THEN
                      recLoc.TESTFIELD(recLoc."GST Registration No.");
                      ASP_cdEway.CancelatioinIRN(Rec,recLoc."GST Registration No.");
                     END;
                    
                    
                     IF recPRH.GET("Document No.")THEN
                     IF  recLoc.GET(recPRH."Location Code") THEN
                      ASP_cdEway.CancelatioinIRN(Rec,recLoc."GST Registration No.");
                     */

                end;
            }
            action("Log Entries")
            {
                Image = log;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50109;
                RunPageLink = Email = FIELD("Document No.");
                ApplicationArea = All;
            }
            action(ReGenerateQR)
            {
                Caption = 'ReGenerate QR';
                Image = GetLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin

                    /*TESTFIELD(IRN);
                    TESTFIELD("QR Code Part1");
                    TESTFIELD("QR Code Part2");
                    TESTFIELD("QR Code Part3");
                    TESTFIELD("QR Code Part4");
                    IF "QR Code".HASVALUE THEN
                      ERROR('QR Code is alredy Generated')
                    ELSE
                     IF recSIH.GET(Rec."Document No.") THEN
                      ASP_cdEInvoice.ReGenerateQR(Rec."Document Type",Rec."Document No.");
                      */


                end;
            }
        }
    }

    var
        //    ASP_cdEInvoice: Codeunit "50012";
        recSIH: Record 112;
        recLoc: Record 14;
        salesRecSet: Record 311;
}

