codeunit 50027 EINV
{

    /*
    trigger OnRun()
    begin
        Automail;
    end;


    procedure Automail()
    var
        Allowmail: Boolean;
        RecEINV: Record 50015;
        RecSalInv: Record 112;
    begin
        RecSalInv.RESET;
        //RecSalInv.SETRANGE("Posting Date",011120D,TODAY);
        RecSalInv.SETRANGE("No.", '5260521220100960');
        //RecSalInv.SETFILTER("Order No.",'<>%1','');
        IF RecSalInv.FINDSET THEN
            REPEAT


                IF (RecSalInv."Nature of Supply" = RecSalInv."Nature of Supply"::B2B) THEN BEGIN
                    Allowmail := TRUE;
                    RecEINV.RESET;
                    RecEINV.SETRANGE("Document No.", RecSalInv."No.");
                    RecEINV.SETRANGE("Inv Transaction", RecEINV."Inv Transaction"::"Generate IRN");
                    IF NOT RecEINV.FINDFIRST THEN
                        // CurrReport.SKIP;
                        Allowmail := FALSE;
                END;
                MailtoCust(RecSalInv."No.", Allowmail);

            UNTIL RecSalInv.NEXT = 0;
    end;


    procedure MailtoCust(var OrderNo: Code[20]; var Boo: Boolean)
    var
        recSIH: Record 112;
        FilePath: Text[200];
        FileName1: Text[200];
        SIH: Record 112;
        Subject: Text[200];
        SMTPMail: Codeunit 400"
        Body: Text[1024];
        CommDialog: Codeunit "419";
        Cust: Record "18";
        RecSP: Record "13";
        SalesPerson: Record "13";
        IGST_Mail: Text[500];
        responsibilityCentre: Record "50011";
    begin

        recSIH.RESET;

        recSIH.SETRANGE("No.", OrderNo);

        IF (recSIH.FINDFIRST) AND (Boo = TRUE) THEN BEGIN
            // REPORT.RUN(REPORT::"Mail Report1",FALSE,FALSE,recSIH);
            FilePath := 'E:\EwayBillPrint\';
            FileName1 := 'Invoice ' + FORMAT(recSIH."No.") + '.pdf';
            FileName1 := CONVERTSTR(FileName1, '/', '_');
            FileName1 := CONVERTSTR(FileName1, ':', '_');

            REPORT.SAVEASPDF(50009, FilePath + FileName1, recSIH);

            Subject := 'Invoice- ' + FORMAT(recSIH."No.");
            IF Cust.GET(recSIH."Bill-to Customer No.") THEN;

            IF Cust."E-Mail" <> '' THEN
                SMTPMail.CreateMessage('Maple Administrator', 'ypatil@winspiresolutions.com', 'ypatil@winspiresolutions.com', Subject, '', TRUE)//Cust."E-Mail"

            ELSE
                SMTPMail.CreateMessage('Maple Administrator', 'ypatil@winspiresolutions.com', 'ypatil@winspiresolutions.com', Subject, '', TRUE);

            Body := '<html>' + '<body>' + 'Dear Sir/Madam' + '<br>' + '<br>' + 'Thanks for your order. Enclosed please find details of invoices as on ' + FORMAT(recSIH."Posting Date", 0, '<DAY,2>/<MONTH,2>/<YEAR4>') + '.' + '<br>' + '<br>'
            + 'Regards' + '<br>' + 'Maple' +
            '<br>' + '<br>' + '<br>' + '<br>' + '<center>' + '<font size="2" color="red">' + 'This is a system generated message. We request you not to reply to this message' + '</font>' + '</center>'
            + '</body>' + '</html>';
            SMTPMail.AppendBody(Body);


            // SMTPMail.AddCC(RecSP."E-Mail");


            //  SMTPMail.AddBCC('ypatil@winspiresolutions.com');

            SMTPMail.AddAttachment(FilePath + FileName1, FileName1);


            SMTPMail.Send;
            SLEEP(6000);
            CommDialog.DeleteServerFile(FilePath + FileName1);



        END;
    end;
    */
}

