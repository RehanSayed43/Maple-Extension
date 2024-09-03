report 50066 "Copy Sales Document1"
{
    // Code          User          Date                Description
    // SHLD001     Sunita          19.11.14            Added code to credit Credit Memo form Shield Invoice

    Caption = 'Copy Sales Document';
    ProcessingOnly = true;
    ApplicationArea = FixedAsset;

    dataset
    {
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(DocumentType; DocType)
                    {
                        Caption = 'Document Type';
                        OptionCaption = 'Quote,Blanket Order,Order,Invoice,Return Order,Credit Memo,Posted Shipment,Posted Invoice,Posted Return Receipt,Posted Credit Memo,Posted Shield Invoice';
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            DocNo := '';
                            ValidateDocNo;
                        end;
                    }
                    field(DocumentNo; DocNo)
                    {
                        Caption = 'Document No.';
                        ApplicationArea = All;

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            LookupDocNo;
                        end;

                        trigger OnValidate()
                        begin
                            ValidateDocNo;
                        end;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            IF DocNo <> '' THEN BEGIN
                CASE DocType OF
                    DocType::Quote:
                        IF FromSalesHeader.GET(FromSalesHeader."Document Type"::Quote, DocNo) THEN
                            ;
                    DocType::"Blanket Order":
                        IF FromSalesHeader.GET(FromSalesHeader."Document Type"::"Blanket Order", DocNo) THEN
                            ;
                    DocType::Order:
                        IF FromSalesHeader.GET(FromSalesHeader."Document Type"::Order, DocNo) THEN
                            ;
                    DocType::Invoice:
                        IF FromSalesHeader.GET(FromSalesHeader."Document Type"::Invoice, DocNo) THEN
                            ;
                    DocType::"Return Order":
                        IF FromSalesHeader.GET(FromSalesHeader."Document Type"::"Return Order", DocNo) THEN
                            ;
                    DocType::"Credit Memo":
                        IF FromSalesHeader.GET(FromSalesHeader."Document Type"::"Credit Memo", DocNo) THEN
                            ;
                    DocType::"Posted Shipment":
                        IF FromSalesShptHeader.GET(DocNo) THEN
                            FromSalesHeader.TRANSFERFIELDS(FromSalesShptHeader);
                    DocType::"Posted Shield Invoice",   ////SHLD001
                  DocType::"Posted Invoice":
                        IF FromSalesInvHeader.GET(DocNo) THEN
                            FromSalesHeader.TRANSFERFIELDS(FromSalesInvHeader);
                    DocType::"Posted Return Receipt":
                        IF FromReturnRcptHeader.GET(DocNo) THEN
                            FromSalesHeader.TRANSFERFIELDS(FromReturnRcptHeader);
                    DocType::"Posted Credit Memo":
                        IF FromSalesCrMemoHeader.GET(DocNo) THEN
                            FromSalesHeader.TRANSFERFIELDS(FromSalesCrMemoHeader);
                END;
                IF FromSalesHeader."No." = '' THEN
                    DocNo := '';
            END;
            ValidateDocNo;
        end;
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        RecSIH.RESET;
        RecSIH.SETRANGE("No.", DocNo);
        IF RecSIH.FINDFIRST THEN BEGIN
            RecEComOrder.RESET;
            //  RecEComOrder.SETRANGE("Order ID", RecSIH."Order ID");
            IF RecEComOrder.FINDSET THEN BEGIN
                REPEAT
                    RecEComOrder."Return Order Created" := TRUE;
                    RecEComOrder.MODIFY;
                UNTIL RecEComOrder.NEXT = 0;
                COMMIT;
            END;
        END;
        COMMIT;
        CODEUNIT.RUN(81, RecSH);
    end;

    trigger OnPreReport()
    begin
        SalesSetup.GET;
        CopyDocMgt.SetProperties(
          TRUE, FALSE, FALSE, FALSE, FALSE, SalesSetup."Exact Cost Reversing Mandatory", FALSE);

        RecSIH.RESET;
        RecSIH.SETRANGE("No.", DocNo);
        IF RecSIH.FINDFIRST THEN BEGIN

            RecSH.INIT;
            CLEAR(SO_No);
            SO_No := NoSeriesMgt.GetNextNo('SCM', WORKDATE, TRUE);
            RecSH."No." := SO_No;
            // RecSH."Order ID":="Store E-Commerce Order"."Order ID";
            RecSH."Sales Order Type" := RecSH."Sales Order Type"::Online;
            RecSH."Document Type" := RecSH."Document Type"::"Credit Memo";//Order;
                                                                          //RecSH.VALIDATE("Sell-to Customer No.",RecSIH."Sell-to Customer No.");
                                                                          //  RecSH.VALIDATE ("Location Code","Store E-Commerce Order"."E Com Location Code");
                                                                          //   RecSH.VALIDATE(Structure,'GST PIT');//"Store E-Commerce Order".Structure);
                                                                          //RecSH."Nature of Supply":="Store E-Commerce Order"."Nature of Supply";
            RecSH.VALIDATE("Posting Date", TODAY);
            RecSH.VALIDATE("Document Date", TODAY);
            // RecSH."Capillary Posted":=TRUE;
            RecSH.INSERT(TRUE);
            MESSAGE(FORMAT(SO_No));

            RecSH.RESET;
            RecSH.SETRANGE("No.", SO_No);
            IF RecSH.FINDFIRST THEN BEGIN
                SalesHeader := RecSH;
                CopyDocMgt.CopySalesDoc(DocType, DocNo, SalesHeader);
            END;
            RecSH.RESET;
            RecSH.SETRANGE("No.", SO_No);
            IF RecSH.FINDFIRST THEN BEGIN
                RecSH.VALIDATE("Posting Date", TODAY);
                RecSH.VALIDATE("Document Date", TODAY);
                //   RecSH.VALIDATE("Shortcut Dimension 1 Code",RecSIH."Shortcut Dimension 1 Code");
                //  RecSH.VALIDATE("Shortcut Dimension 2 Code",RecSIH."Shortcut Dimension 2 Code");
                RecSH.MODIFY;
            END;
            RecSL.RESET;
            RecSL.SETRANGE("Document No.", SO_No);
            IF RecSL.FINDSET THEN BEGIN
                REPEAT
                    RecSL."Posting Date" := TODAY;
                    RecSL.MODIFY;
                UNTIL RecSL.NEXT = 0;
            END;
            MESSAGE('Sales Credit Memo Created');

        END;
        COMMIT;
    end;

    var
        SalesHeader: Record "Sales Header";
        FromSalesHeader: Record "Sales Header";
        FromSalesShptHeader: Record "Sales Shipment Header";
        FromSalesInvHeader: Record "Sales Shipment Header";
        FromReturnRcptHeader: Record "Return Receipt Header";
        FromSalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesSetup: Record "Sales & Receivables Setup";
        CopyDocMgt: Codeunit "Copy Document Mgt.";
        DocType: Option Quote,"Blanket Order","Order",Invoice,"Return Order","Credit Memo","Posted Shipment","Posted Invoice","Posted Return Receipt","Posted Credit Memo","Posted Shield Invoice";
        DocNo: Code[20];
        IncludeHeader: Boolean;
        RecalculateLines: Boolean;
        Text000: Label 'The price information may not be reversed correctly, if you copy a %1. If possible copy a %2 instead or use %3 functionality.';
        Text001: Label 'Undo Shipment';
        Text002: Label 'Undo Return Receipt';
        Text003: Label 'Quote,Blanket Order,Order,Invoice,Return Order,Credit Memo,Posted Shipment,Posted Invoice,Posted Return Receipt,Posted Credit Memo';
        SO_No: Code[20];
        NoSeriesMgt: Codeunit 396;
        RecSH: Record "Sales Header";
        RecSIH: Record "Sales Invoice Header";
        RecSL: Record "Sales Line";
        RecEComOrder: Record "Store E-Commerce Order";


    procedure SetSalesHeader(var NewSalesHeader: Record "Sales Header")
    begin
        NewSalesHeader.TESTFIELD("No.");
        SalesHeader := NewSalesHeader;
    end;

    local procedure ValidateDocNo()
    var
        DocType2: Option Quote,"Blanket Order","Order",Invoice,"Return Order","Credit Memo","Posted Shipment","Posted Invoice","Posted Return Receipt","Posted Credit Memo";
        TotalHrs: Integer;
        TotalDays: Integer;
        FromTime: Time;
        ToTime: Time;
    begin
        IF DocNo = '' THEN
            FromSalesHeader.INIT
        ELSE
            IF FromSalesHeader."No." = '' THEN BEGIN
                FromSalesHeader.INIT;
                CASE DocType OF
                    DocType::Quote,
                  DocType::"Blanket Order",
                  DocType::Order,
                  DocType::Invoice,
                  DocType::"Return Order",
                  DocType::"Credit Memo":
                        //     FromSalesHeader.GET(CopyDocMgt.SalesHeaderDocType(DocType), DocNo);
                        // DocType::"Posted Shipment":
                        BEGIN
                            FromSalesShptHeader.GET(DocNo);
                            FromSalesHeader.TRANSFERFIELDS(FromSalesShptHeader);
                            IF SalesHeader."Document Type" IN
                               [SalesHeader."Document Type"::"Return Order", SalesHeader."Document Type"::"Credit Memo"]
                            THEN BEGIN
                                DocType2 := DocType2::"Posted Invoice";
                                MESSAGE(Text000, SELECTSTR(1 + DocType, Text003), SELECTSTR(1 + DocType2, Text003), Text001);
                            END;
                        END;
                    DocType::"Posted Invoice":
                        BEGIN
                            FromSalesInvHeader.GET(DocNo);
                            SalesSetup.GET;
                            IF SalesSetup."24 hrs CR Memo" THEN BEGIN
                                //   TotalHrs := DATE2DMY(DT2DATE(CURRENTDATETIME), 1) - DATE2DMY(DT2DATE(FromSalesInvHeader."Sales Invoice Time"), 1);
                                //ToTime :=  DT2TIME(CURRENTDATETIME);
                                //FromTime :=  DT2TIME(FromSalesInvHeader."Sales Invoice Time");
                                // TotalDays := DT2TIME(CURRENTDATETIME)-DT2TIME(FromSalesInvHeader."Sales Invoice Time");
                                IF TotalHrs > 0 THEN BEGIN
                                    DocNo := '';
                                    ERROR('Sales Credit memo is not allowed after 24 Hrs.');
                                END
                            END;
                            FromSalesHeader.TRANSFERFIELDS(FromSalesInvHeader);
                        END;
                    //SHLD001+++
                    DocType::"Posted Shield Invoice":
                        BEGIN
                            FromSalesInvHeader.GET(DocNo);
                            SalesSetup.GET;
                            IF SalesSetup."24 hrs CR Memo" THEN BEGIN
                                //   TotalHrs := DATE2DMY(DT2DATE(CURRENTDATETIME), 1) - DATE2DMY(DT2DATE(FromSalesInvHeader."Sales Invoice Time"), 1);
                                //ToTime :=  DT2TIME(CURRENTDATETIME);
                                //FromTime :=  DT2TIME(FromSalesInvHeader."Sales Invoice Time");
                                // TotalDays := DT2TIME(CURRENTDATETIME)-DT2TIME(FromSalesInvHeader."Sales Invoice Time");
                                IF TotalHrs > 0 THEN BEGIN
                                    DocNo := '';
                                    ERROR('Sales Credit memo is not allowed after 24 Hrs.');
                                END
                            END;
                            FromSalesHeader.TRANSFERFIELDS(FromSalesInvHeader);
                        END;
                    ////SHLD001----
                    DocType::"Posted Return Receipt":
                        BEGIN
                            FromReturnRcptHeader.GET(DocNo);
                            FromSalesHeader.TRANSFERFIELDS(FromReturnRcptHeader);
                            IF SalesHeader."Document Type" IN
                               [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::Invoice]
                            THEN BEGIN
                                DocType2 := DocType2::"Posted Credit Memo";
                                MESSAGE(Text000, SELECTSTR(1 + DocType, Text003), SELECTSTR(1 + DocType2, Text003), Text002);
                            END;
                        END;
                    DocType::"Posted Credit Memo":
                        BEGIN
                            FromSalesCrMemoHeader.GET(DocNo);
                            FromSalesHeader.TRANSFERFIELDS(FromSalesCrMemoHeader);
                        END;
                END;
            END;
        FromSalesHeader."No." := '';

        IncludeHeader :=
          (DocType IN [DocType::"Posted Invoice", DocType::"Posted Credit Memo"]) AND
          ((DocType = DocType::"Posted Credit Memo") <>
           (SalesHeader."Document Type" IN
            [SalesHeader."Document Type"::"Return Order", SalesHeader."Document Type"::"Credit Memo"])) AND
          (SalesHeader."Bill-to Customer No." IN [FromSalesHeader."Bill-to Customer No.", '']);
        ValidateIncludeHeader;
    end;

    local procedure LookupDocNo()
    begin
        CASE DocType OF
            DocType::Quote,
            DocType::"Blanket Order",
            DocType::Order,
            DocType::Invoice,
            DocType::"Return Order",
            DocType::"Credit Memo":
                BEGIN
                    FromSalesHeader.FILTERGROUP := 0;
                    //  FromSalesHeader.SETRANGE("Document Type", CopyDocMgt.SalesHeaderDocType(DocType));
                    // IF SalesHeader."Document Type" = CopyDocMgt.SalesHeaderDocType(DocType) THEN
                    //     FromSalesHeader.SETFILTER("No.", '<>%1', SalesHeader."No.");
                    FromSalesHeader.FILTERGROUP := 2;
                    //  FromSalesHeader."Document Type" := CopyDocMgt.SalesHeaderDocType(DocType);
                    FromSalesHeader."No." := DocNo;
                    IF (DocNo = '') AND (SalesHeader."Sell-to Customer No." <> '') THEN
                        IF FromSalesHeader.SETCURRENTKEY("Document Type", "Sell-to Customer No.") THEN BEGIN
                            FromSalesHeader."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                            IF FromSalesHeader.FIND('=><') THEN;
                        END;
                    IF PAGE.RUNMODAL(0, FromSalesHeader) = ACTION::LookupOK THEN
                        DocNo := FromSalesHeader."No.";
                END;
            DocType::"Posted Shipment":
                BEGIN
                    FromSalesShptHeader."No." := DocNo;
                    IF (DocNo = '') AND (SalesHeader."Sell-to Customer No." <> '') THEN
                        IF FromSalesShptHeader.SETCURRENTKEY("Sell-to Customer No.") THEN BEGIN
                            FromSalesShptHeader."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                            IF FromSalesShptHeader.FIND('=><') THEN;
                        END;
                    IF PAGE.RUNMODAL(0, FromSalesShptHeader) = ACTION::LookupOK THEN
                        DocNo := FromSalesShptHeader."No.";
                END;
            //SHLD001 ++
            DocType::"Posted Shield Invoice":
                BEGIN
                    FromSalesInvHeader."No." := DocNo;
                    // FromSalesInvHeader.SETFILTER(Shield, '%1', TRUE);
                    // FromSalesInvHeader.SETFILTER("Ref. Invoice No.", '<>%1', '');
                    IF (DocNo = '') AND (SalesHeader."Sell-to Customer No." <> '') THEN
                        IF FromSalesInvHeader.SETCURRENTKEY("Sell-to Customer No.") THEN BEGIN
                            FromSalesInvHeader."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";

                            IF FromSalesInvHeader.FIND('=><') THEN;
                        END;
                    IF PAGE.RUNMODAL(50027, FromSalesInvHeader) = ACTION::LookupOK THEN
                        DocNo := FromSalesInvHeader."No.";
                END;
            ////SHLD001--
            DocType::"Posted Invoice":
                BEGIN
                    FromSalesInvHeader."No." := DocNo;
                    IF (DocNo = '') AND (SalesHeader."Sell-to Customer No." <> '') THEN
                        IF FromSalesInvHeader.SETCURRENTKEY("Sell-to Customer No.") THEN BEGIN
                            FromSalesInvHeader."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                            IF FromSalesInvHeader.FIND('=><') THEN;
                        END;
                    IF PAGE.RUNMODAL(0, FromSalesInvHeader) = ACTION::LookupOK THEN
                        DocNo := FromSalesInvHeader."No.";
                END;
            DocType::"Posted Return Receipt":
                BEGIN
                    FromReturnRcptHeader."No." := DocNo;
                    IF (DocNo = '') AND (SalesHeader."Sell-to Customer No." <> '') THEN
                        IF FromReturnRcptHeader.SETCURRENTKEY("Sell-to Customer No.") THEN BEGIN
                            FromReturnRcptHeader."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                            IF FromReturnRcptHeader.FIND('=><') THEN;
                        END;
                    IF PAGE.RUNMODAL(0, FromReturnRcptHeader) = ACTION::LookupOK THEN
                        DocNo := FromReturnRcptHeader."No.";
                END;
            DocType::"Posted Credit Memo":
                BEGIN
                    FromSalesCrMemoHeader."No." := DocNo;
                    IF (DocNo = '') AND (SalesHeader."Sell-to Customer No." <> '') THEN
                        IF FromSalesCrMemoHeader.SETCURRENTKEY("Sell-to Customer No.") THEN BEGIN
                            FromSalesCrMemoHeader."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                            IF FromSalesCrMemoHeader.FIND('=><') THEN;
                        END;
                    IF PAGE.RUNMODAL(0, FromSalesCrMemoHeader) = ACTION::LookupOK THEN
                        DocNo := FromSalesCrMemoHeader."No.";
                END;
        END;
        ValidateDocNo;
    end;

    local procedure ValidateIncludeHeader()
    begin
        RecalculateLines :=
          (DocType IN [DocType::"Posted Shipment", DocType::"Posted Return Receipt"]) OR NOT IncludeHeader;
    end;


    procedure InitializeRequest(NewDocType: Option; NewDocNo: Code[20]; NewIncludeHeader: Boolean; NewRecalcLines: Boolean)
    begin
        DocType := NewDocType;
        DocNo := NewDocNo;
        IncludeHeader := NewIncludeHeader;
        RecalculateLines := NewRecalcLines;
    end;
}

