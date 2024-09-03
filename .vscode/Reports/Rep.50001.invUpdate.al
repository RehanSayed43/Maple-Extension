report 50001 "inv Update"
{
    DefaultLayout = RDLC;
    RDLCLayout = './invUpdate.rdlc';

    //RDLCLayout = './PendingPurchaseOrderReport.rdlc';
    Caption = 'inv Update';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    Permissions = TableData 36 = rimd,
                  TableData 112 = rimd,
                  TableData 113 = rimd,
                  TableData 114 = rimd,
                  TableData 115 = rimd,
                  TableData 50004 = rimd;

    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            trigger OnAfterGetRecord()
            begin
                /*"Sales Cr.Memo Header"."Sell-to Post Code":='400054';
                "Sales Cr.Memo Header"."Bill-to Post Code":='400054';
                "Sales Cr.Memo Header".MODIFY;*/
                //"Sales Cr.Memo Header"."GST Customer Type":="Sales Cr.Memo Header"."GST Customer Type"::Registered;
                //"Sales Cr.Memo Header"."Nature of Supply":="Sales Cr.Memo Header"."Nature of Supply"::B2B;
                //"Sales Cr.Memo Header"."Bill-to Address 2":='Thane';
                //"Sales Cr.Memo Header"."Sell-to Address 2":='Thane';
                /*"Sales Cr.Memo Header"."Bill-to City":='Solapur';
                "Sales Cr.Memo Header"."Sell-to City":='Solapur ';
                "Sales Cr.Memo Header"."Sell-to Post Code":='413001';
                "Sales Cr.Memo Header"."Bill-to Post Code":='413001';*/
                "Sales Cr.Memo Header"."Sell-to Customer Name" := 'Krishna Pranlal Soni';
                "Sales Cr.Memo Header"."Bill-to Name" := 'Krishna Pranlal Soni';
                //"Sales Cr.Memo Header"."Nature of Supply":="Sales Cr.Memo Header"."Nature of Supply"::B2B;
                "Sales Cr.Memo Header".MODIFY;

            end;

            trigger OnPreDataItem()
            begin
                IF Documentno = '' THEN
                    ERROR('DocumentNo is Missing');
                "Sales Cr.Memo Header".SETRANGE("Sales Cr.Memo Header"."No.", Documentno);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(DocumentNo; Documentno)
                {
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Documentno: Code[20];
        ItemNo: Code[20];
        QRCode1: Label 'eyJhbGciOiJSUzI1NiIsImtpZCI6IjQ0NDQwNUM3ODFFNDgyNTA3MkIzNENBNEY4QkRDNjA2Qzg2QjU3MjAiLCJ0eXAiOiJKV1QiLCJ4NXQiOiJSRVFGeDRIa2dsQnlzMHlrLUwzR0JzaHJWeUEifQ.eyJkYXRhIjoie1wiU2VsbGVyR3N0aW5cIjpcIjI3QUFHQ00wNzkwRTFaSlwiLFwiQnV5ZXJHc3RpblwiOlwiMjdBRFFGUzkzNjV';
        QRCode2: Label 'SMVpOXCIsXCJEb2NOb1wiOlwiOTEwNDIyMjMwMTAwMTk5NVwiLFwiRG9jVHlwXCI6XCJJTlZcIixcIkRvY0R0XCI6XCIwNi8wNS8yMDIyXCIsXCJUb3RJbnZWYWxcIjo4MzYxMC4wLFwiSXRlbUNudFwiOjEsXCJNYWluSHNuQ29kZVwiOlwiODQ3MTMwMTBcIixcIklyblwiOlwiMzkyZjI2NTE3M2Y4MTBlYmMzY2RlOTE2ODg3NjUwN';
        QRCode3: Label 'mRlMTMwODEwYWQ4MDZlNTFjNGI5YjE1YTYxMzJkNjE1OVwiLFwiSXJuRHRcIjpcIjIwMjItMDUtMjcgMTE6MTM6MDBcIn0iLCJpc3MiOiJOSUMifQ.LamOEjyJUVJZfCfnKBQ7bZaFSJoodOG_og7FF-4HKa-Df-cRtF7kUN7sPBufk3g8e-SuDopDOMqVpm4B0lpB8tiiJlsEu44yXS-mcf4-Ikzc9lvFTOaTJGjXl-ghPQxdLFrBsTOc';
        QRCode4: Label '4nGO2kp5HoJLgL2sEbBAFiZQIIAdBEUOyQCDGAoOm4Ng49PmcfuiTu44UWVvwu_n0qIuUElU3hMcIwTEv6xV5aH2E2YfOJZ0sbHcEY_WA_-jRwyT3AlIrm29cnxKhOLTboDJJvJf7vorLa3uJHipvm0EhynR3F9n-kS2BpTZ1LpL0N4U6BMTUKmscyuDUtaw01amfwecUcpY_g';
}

