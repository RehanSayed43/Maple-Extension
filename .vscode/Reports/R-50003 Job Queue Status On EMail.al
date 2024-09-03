report 50003 "Job Queue Status On E-Mail"
{
    Caption = 'Job Queue Status On E-Mail';
    ProcessingOnly = true;
    UseRequestPage = false;
    ApplicationArea = FixedAsset;

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = SORTING(Number)
                                WHERE(Number = CONST(1));

            trigger OnAfterGetRecord()
            begin
                /*   rahul ---------
                
                SMTPMailSetup.GET();
                IF SMTPMailSetup."Job Notification Email" = '' THEN
                    CurrReport.BREAK;

                CompInfo.GET;
                CLEAR(Mail);
                SMTPSetup.GET();
                Mail.CreateMessage('Job Queue Status', SMTPSetup."User ID", SMTPSetup."Job Notification Email", 'Job Queue Status', '', TRUE);
                //Mail.AddCC('kunj@kppl.net');
                Mail.AppendBody('Dear Sir/Madam,' + '<BR>' + '<BR>' + 'Below are status of Job Queue.' + '<BR>' + '<BR>');
                Mail.AppendBody('<table border="1" width="54%" id="table2" cellspacing="0" cellpadding="0">' +
                                '<tr>' +
                                '<td width="50" valign="top" style="width:1.45in;padding:0in 5.4pt 0in 5.4pt">' +
                                '<p class="TableTextBold"><b>SNo.</b></td>' +
                                '<td width="200" valign="top" style="width:1.45in;padding:0in 5.4pt 0in 5.4pt">' +
                                '<p class="TableTextBold"><b>Job Queue Entry</b></td>' +
                                '<td width="200" valign="top" style="width:1.45in;padding:0in 5.4pt 0in 5.4pt">' +
                                '<p class="TableTextBold"><b>Job Queue Next Run</b></td>' +
                                '<td width="139" valign="top" style="width:1.45in;padding:0in 5.4pt 0in 5.4pt">' +
                                '<p class="TableTextBold"><b>Last Run Date</b></td>' +
                                '<td width="200" valign="top" style="width:1.45in;padding:0in 5.4pt 0in 5.4pt">' +
                                '<p class="TableTextBold"><b>Status</b></td>' +
                                '<td width="200" valign="top" style="width:1.45in;padding:0in 5.4pt 0in 5.4pt">' +
                                '<p class="TableTextBold"><b>Message</b></td>' +
                                '</tr>');

                JobQueEntry.CHANGECOMPANY('Maple Live');
                JobQueEntry.RESET;
                JobQueEntry.SETFILTER(JobQueEntry.Status, '%1', JobQueEntry.Status::Error);
                JobQueEntry.SETFILTER(JobQueEntry."Object ID to Run", '<>%1', 50101);
                IF JobQueEntry.FINDSET THEN BEGIN
                    REPEAT
                        JobQueEntry.CALCFIELDS(JobQueEntry."Object Caption to Run");
                        IF JobQueEntry.Description <> '' THEN
                            JobQueDesc := JobQueEntry.Description
                        ELSE
                            JobQueDesc := JobQueEntry."Object Caption to Run";
                        JobQueLog.RESET;
                        Sno := Sno + 1;
                        JobQueLog.CHANGECOMPANY('Maple Live');
                        JobQueLog.SETRANGE(JobQueLog.ID, JobQueEntry.ID);
                        IF JobQueLog.FINDLAST THEN BEGIN
                            Mail.AppendBody('<tr>' +
                                            '<td width="50" valign="top" style="width:1.45in;padding:0in 5.4pt 0in 5.4pt">' +
                                            '<p class="TableTextBold"><font face="Arial" size="2">' + FORMAT(Sno) + '</font></td>' +
                                            '<td width="200" valign="top" style="width:1.45in;padding:0in 5.4pt 0in 5.4pt">' +
                                            '<p class="TableTextBold"><font face="Arial" size="2">' + JobQueDesc + '</Font></td>' +
                                            '<td width="139" valign="top" style="width:1.45in;padding:0in 5.4pt 0in 5.4pt">' +
                                            '<p class="TableTextBold"><font face="Arial" size="2">' + FORMAT(JobQueEntry."Earliest Start Date/Time") + '</Font></td>' +
                                            '<td width="139" valign="top" style="width:1.45in;padding:0in 5.4pt 0in 5.4pt">' +
                                            '<p class="TableTextBold"><font face="Arial" size="2">' + FORMAT(JobQueLog."Start Date/Time") + '</Font></td>' +
                                            '<td width="200" valign="top" style="width:1.45in;padding:0in 5.4pt 0in 5.4pt">' +
                                            '<p class="TableTextBold"><font face="Arial" size="2">' + FORMAT(JobQueLog.Status) + '</Font></td>' +
                                            '<td width="200" valign="top" style="width:1.45in;padding:0in 5.4pt 0in 5.4pt">' +
                                            '<p class="TableTetBold"><font face="Arial" size="2">' + JobQueLog."Error Message" + JobQueLog."Error Message 2" + '</Font></td>' +
                                            '</tr>');
                        END ELSE BEGIN
                            Mail.AppendBody('<tr>' +
                                            '<td width="50" valign="top" style="width:1.45in;padding:0in 5.4pt 0in 5.4pt">' +
                                            '<p class="TableTextBold"><font face="Arial" size="2">' + FORMAT(Sno) + '</font></td>' +
                                            '<td width="200" valign="top" style="width:1.45in;padding:0in 5.4pt 0in 5.4pt">' +
                                            '<p class="TableTextBold"><font face="Arial" size="2">' + JobQueEntry.Description + '</Font></td>' +
                                            '<td width="139" valign="top" style="width:1.45in;padding:0in 5.4pt 0in 5.4pt">' +
                                            '<p class="TableTextBold"><font face="Arial" size="2">' + '' + '</Font></td>' +
                                            '<td width="139" valign="top" style="width:1.45in;padding:0in 5.4pt 0in 5.4pt">' +
                                            '<p class="TableTextBold"><font face="Arial" size="2">' + '' + '</Font></td>' +
                                            '<td width="200" valign="top" style="width:1.45in;padding:0in 5.4pt 0in 5.4pt">' +
                                            '<p class="TableTextBold"><font face="Arial" size="2">' + '' + '</Font></td>' +
                                            '<td width="200" valign="top" style="width:1.45in;padding:0in 5.4pt 0in 5.4pt">' +
                                            '<p class="TableTetBold"><font face="Arial" size="2">' + '' + '</Font></td>' +
                                            '</tr>');
                        END;
                    UNTIL JobQueEntry.NEXT = 0;
                END ELSE
                    CurrReport.BREAK;

                Mail.AppendBody('<tr>' +
                                '<td width="50" valign="top" style="width:1.45in;padding:0in 5.4pt 0in 5.4pt">' +
                                '<p class="TableTextBold"><font face="Arial" size="2">' + '' + '</font></td>' +
                                '<td width="200" valign="top" style="width:1.45in;padding:0in 5.4pt 0in 5.4pt">' +
                                '<p class="TableTextBold"><font face="Arial" size="2">' + '' + '</Font></td>' +
                                '<td width="139" valign="top" style="width:1.45in;padding:0in 5.4pt 0in 5.4pt">' +
                                '<p class="TableTextBold"><font face="Arial" size="2">' + '' + '</Font></td>' +
                                '<td width="139" valign="top" style="width:1.45in;padding:0in 5.4pt 0in 5.4pt">' +
                                '<p class="TableTextBold"><font face="Arial" size="2">' + '' + '</Font></td>' +
                                '<td width="200" valign="top" style="width:1.45in;padding:0in 5.4pt 0in 5.4pt">' +
                                '<p class="TableTextBold"><font face="Arial" size="2">' + '' + '</Font></td>' +
                                '<td width="200" valign="top" style="width:1.45in;padding:0in 5.4pt 0in 5.4pt">' +
                                '<p class="TableTetBold"><font face="Arial" size="2">' + '' + '</Font></td>' +
                                '</tr>' + '</table>');
                Mail.AppendBody('<BR>' + '<BR>' + 'Thanks & Regards' + '<BR>' + '<BR>' + 'Job Queue NAS Service.');
                Mail.Send;

                -------rahul */
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        JobQueEntry: Record 472;
        JobQueLog: Record 474;
        // Mail: Codeunit 400;
        CompInfo: Record 79;
        Sno: Integer;
        JobQueDesc: Text;
    // SMTPSetup: Record 409;
    // SMTPMailSetup: Record 409;
}

