codeunit 50011 "Sales-Post (Yes/No)1"
{
    TableNo = 36;

    trigger OnRun()
    var
        R: Codeunit "Sales-Post (Yes/No)";
    begin
        IF NOT Rec.FIND THEN
            ERROR(NothingToPostErr);

        SalesHeader.COPY(Rec);
        Code;
        Rec := SalesHeader;
    end;

    var
        Text000: Label '&Ship,&Invoice,Ship &and Invoice';
        Text001: Label 'Do you want to post the %1?';
        Text002: Label '&Receive,&Invoice,Receive &and Invoice';
        SalesHeader: Record "Sales Header";//"36";
        Selection: Integer;
        Text13700: Label 'You have to attach transit document for this invoice.';
        Text13701: Label 'Transit document(s) are not required  for this invoice.';
        PreviewMode: Boolean;
        NothingToPostErr: Label 'There is nothing to post.';

    [TryFunction]
    local procedure "Code"()
    var
        SalesSetup: Record "Sales & Receivables Setup";//"311";
        SalesPostViaJobQueue: Codeunit "Sales Post via Job Queue";//"88";
        SalesPost: Codeunit "Sales-Post"; //"80";
    begin
        CheckTransDocDetails(SalesHeader);
        IF NOT PreviewMode THEN BEGIN
            CASE SalesHeader."Document Type" OF
                SalesHeader."Document Type"::Order:
                    BEGIN
                        //win127//win352
                        //          Selection := STRMENU(Text000,3);//Win120
                        //IF Selection = 0 THEN
                        //EXIT;
                        Selection := 3;
                        SalesHeader.Ship := Selection IN [1, 3];
                        SalesHeader.Invoice := Selection IN [2, 3];
                    END;
                SalesHeader."Document Type"::"Return Order":
                    BEGIN
                        //Selection := STRMENU(Text002,3);
                        //IF Selection = 0 THEN
                        //  EXIT;
                        Selection := 3;
                        SalesHeader.Receive := Selection IN [1, 3];
                        SalesHeader.Invoice := Selection IN [2, 3];
                    END
                ELSE BEGIN //win316++
                           //kj_need to remove comment   //IF (SalesHeader."Order ID" = '') AND (CRM = FALSE) THEN //need to reove comment
                    IF NOT
                       CONFIRM(
                         Text001, FALSE,
                         SalesHeader."Document Type")
                    THEN
                        EXIT;
                END;//win316--
            END;
            SalesHeader."Print Posted Documents" := FALSE;

            SalesSetup.GET;
            IF SalesSetup."Post with Job Queue" THEN
                SalesPostViaJobQueue.EnqueueSalesDoc(SalesHeader)
            ELSE
                CODEUNIT.RUN(CODEUNIT::"Sales-Post (Yes/No)1", SalesHeader);
        END ELSE BEGIN
            CASE SalesHeader."Document Type" OF
                SalesHeader."Document Type"::Order:
                    SalesHeader.Ship := TRUE;
                SalesHeader."Document Type"::"Return Order":
                    SalesHeader.Receive := TRUE;
            END;
            SalesHeader.Invoice := TRUE;
            SalesPost.SetPreviewMode(TRUE);
            SalesPost.RUN(SalesHeader);
        END;
    end;

    //[Scope('Internal')]
    procedure CheckTransDocDetails(var SalesHeader2: Record "Sales Header")
    var
    //TransDocDetails: Record "13768"; //kj+++++++++ //not available in BC
    begin
        /* WITH SalesHeader2 DO
           IF "Form Code" <> '' THEN BEGIN
              TransDocDetails.SETRANGE(Type, TransDocDetails.Type::Sale);
              TransDocDetails.SETRANGE("PO / SO No.", "No.");
              IF "Transit Document" AND TransDocDetails.ISEMPTY THEN
                  ERROR(Text13700);
              IF NOT "Transit Document" AND NOT TransDocDetails.ISEMPTY THEN
                  ERROR(Text13701); */
        //END; //kj----------
    end;

    // [Scope('Internal')]
    procedure Preview(var SalesHdr: Record 36)
    var
        GenJnlPostPreview: Codeunit "Gen. Jnl.-Post Preview";//"19";
    begin
        /*  //kj+++++++++ //not available in BC
         GenJnlPostPreview.Start;
         PreviewMode := TRUE;
         SalesHeader.COPY(SalesHdr);
         IF NOT Code THEN BEGIN
             GenJnlPostPreview.Finish;
             IF GETLASTERRORTEXT <> GenJnlPostPreview.GetPreviewModeErrMessage THEN
                 ERROR(GETLASTERRORTEXT);
             GenJnlPostPreview.ShowAllEntries;
             ERROR('');
         END; */
        //kj+++++++++ //not available in BC-------------
    end;
}

