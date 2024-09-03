codeunit 50033 InvoiceUpdate
{
    Permissions = TableData 112 = rimd,
                  TableData 113 = rimd,
                  TableData 115 = rimd;

    trigger OnRun()
    begin
        InvoiceArr[1] := '8106222301000234';
        //InvoiceArr[2]:='8106222302000004';
        /*InvoiceArr[3]:='2106222301000707';
        InvoiceArr[4]:='3510622230100009';
        InvoiceArr[5]:='3510622230100236';
        InvoiceArr[6]:='3510622230100293';
        InvoiceArr[7]:='9106222301001417';
        InvoiceArr[8]:='9106222301001459';
        InvoiceArr[9]:='9106222301001463';*/
        //AddArr[1]:='23-11970/11, MIZAZ COMPLEX,PANDESHWARA, MANGALORE';

        /*Add2Arr[1]:='Dakshina Kannada';
        Add2Arr[2]:='Mahim(West)';
        Add2Arr[3]:='Gangimatta Mangalore';*/

        //MESSAGE(FORMAT(COMPRESSARRAY(InvoiceArr)));
        //PostCodeArr[1]:='400004';
        //PostCodeArr[2]:='400004';
        //PostCodeArr[3]:='40005';
        //PostCodeArr[4]:='40005';

        //CityArr[1]:='POWAI';
        /*CityArr[2]:='Solapur';
        CityArr[3]:='UMBERGAON';
        CityArr[4]:='Navi Mumbai';*/

        /*StateCode[1]:='MH';
        StateCode[2]:='OA';
        StateCode[3]:='UP';
        StateCode[4]:='UP';
        StateCode[5]:='RJ';*/

        /*AddArr[1]:='Mumbai';
        AddArr[2]:='Odisha';
        AddArr[3]:='Uttar Pradesh';
        AddArr[4]:='Uttar Pradesh';
        AddArr[5]:='Rajasthan';*/

        //ArrayLength := COMPRESSARRAY(InvoiceArr);
        //i := 1;
        //WHILE i <= ArrayLength DO BEGIN
        // SalesInvoiceHeader.RESET;
        //SalesInvoiceHeader.SETRANGE("No.",InvoiceArr[i]);
        //IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
        /*SalesInvoiceHeader."Sell-to Address":=AddArr[i];
        SalesInvoiceHeader."Bill-to Address":=AddArr[i];*/
        //SalesInvoiceHeader."Sell-to Address 2":=Add2Arr[i];
        //SalesInvoiceHeader."Bill-to Address 2":=Add2Arr[i];
        //SalesInvoiceHeader."Ship-to Address 2":=Add2Arr[i];
        //SalesInvoiceHeader."Sell-to Post Code":=PostCodeArr[i];
        //SalesInvoiceHeader."Bill-to Post Code":=PostCodeArr[i];
        //SalesInvoiceHeader."Ship-to Post Code":=PostCodeArr[i];
        //SalesInvoiceHeader."Bill-to City":=CityArr[i];
        //SalesInvoiceHeader."Sell-to City":=CityArr[i];
        //SalesInvoiceHeader."Ship-to City":=CityArr[i];
        //SalesInvoiceHeader."GST Bill-to State Code":=StateCode[i];
        //SalesInvoiceHeader."Bill-to City":=AddArr[i];
        //SalesInvoiceHeader."Sell-to Customer Name":='Krishna Pranlal Soni';
        //SalesInvoiceHeader."Bill-to Name":='Krishna Pranlal Soni';
        //SalesInvoiceHeader.MODIFY(FALSE);
        //MESSAGE(FORMAT(SalesInvoiceHeader));
        //CLEAR(EInvoice_ASP);
        //EInvoice_ASP.SetEwayRequirement(FALSE);
        //EInvoice_ASP.SetSalesInvHeader(SalesInvoiceHeader);
        //EInvoice_ASP.RUN;
        //END;
        //i := i+1;
        //END;
        /*
        HSNnoArr[1]:='42023990';
        HSNnoArr[2]:='84716090';
        HSNnoArr[3]:='85182200';
        HSNnoArr[4]:='84716090';
        HSNnoArr[5]:='84716090';
        HSNnoArr[6]:='42023190';
        HSNnoArr[7]:='42023990';
        HSNnoArr[8]:='84716090';
        HSNnoArr[9]:='42023990';
        */
        /*
        ItemNoArr[1]:='NATITPA1033';
        ItemNoArr[2]:='APPACP1073';
        ItemNoArr[3]:='APPACP1067';
        ItemNoArr[4]:='APPSER1290';
        ItemNoArr[5]:='APPAPP1035';
        ItemNoArr[6]:='APPSER1451';
        ItemNoArr[7]:='APPACP1073';
        ItemNoArr[8]:='APPACP1083';
        ItemNoArr[9]:='APPACP1083';
        */
        /*WHILE i<=ArrayLength DO BEGIN
          SalesInvoiceLine.RESET;
          SalesInvoiceLine.SETRANGE(SalesInvoiceLine."Document No.",InvoiceArr[i]);
          SalesInvoiceLine.SETRANGE("No.",ItemNoArr[i]);
          IF SalesInvoiceLine.FINDFIRST THEN BEGIN
            SalesInvoiceLine."HSN/SAC Code" := HSNnoArr[i];
            //SalesInvoiceLine."GST Group Code":='SERV@18%';
            SalesInvoiceLine.MODIFY(FALSE);
          END;
            i:=i+1;
            MESSAGE('Done');
        END;
        */
        /*SalesInvoiceLine.RESET;
          SalesInvoiceLine.SETRANGE(SalesInvoiceLine."Document No.",'3310622230100160');
          SalesInvoiceLine.SETRANGE("No.",'APPAPP1029');
          IF SalesInvoiceLine.FINDFIRST THEN BEGIN
            //SalesInvoiceLine."HSN/SAC Code" := HSNnoArr[i];
            SalesInvoiceLine."GST Group Code":='SERV@18%';
            SalesInvoiceLine.MODIFY(FALSE);
          END;*/
        /*SalesCrMemoLine.RESET;
        SalesCrMemoLine.SETRANGE(SalesCrMemoLine."Document No.",'6106222302000014');
        SalesCrMemoLine.SETRANGE("No.",'APPACP1083');
        IF SalesCrMemoLine.FINDFIRST THEN BEGIN
        SalesCrMemoLine."GST Group Code":='SERV@18%';
        SalesCrMemoLine.MODIFY(FALSE);
        END;*/
        //SalesInvoiceLine.RESET;
        //SalesInvoiceLine.SETRANGE(SalesInvoiceLine."Document No.",'9107222301001481');
        //SalesInvoiceLine.SETRANGE("GST Group Code",'GOODS@18%');
        //IF SalesInvoiceLine.FINDFIRST THEN BEGIN
        //SalesInvoiceLine."GST Group Code":='SERV@18%';
        //SalesInvoiceLine.MODIFY(FALSE);
        //END;


        //{SalesInvoiceHeader.RESET;
        // SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."No.",'9107222301001185');
        //SalesInvoiceHeader.SETRANGE("Sell-to Post Code",'400 014');
        //IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
        // SalesInvoiceHeader."Sell-to Post Code" := '400014';
        //SalesInvoiceHeader.MODIFY(FALSE);
        //END;

        //SalesInvoiceHeader.RESET;
        //SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."No.",'9107222301001185');
        // SalesInvoiceHeader.SETRANGE("Bill-to Post Code",'400 014');
        //IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
        // SalesInvoiceHeader."Bill-to Post Code" := '400014';
        //SalesInvoiceHeader.MODIFY(FALSE);
        //END;

        SalesInvoiceHeader.RESET;
        SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."No.", '9107222301000872');
        SalesInvoiceHeader.SETRANGE("Bill-to Address 2", '');
        IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
            SalesInvoiceHeader."Bill-to Address 2" := 'Sidco Industrial Estate';
            SalesInvoiceHeader.MODIFY(FALSE);
        END;

        SalesInvoiceHeader.RESET;
        SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."No.", '9107222301000872');
        SalesInvoiceHeader.SETRANGE("Ship-to Address 2", '');
        IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
            SalesInvoiceHeader."Ship-to Address 2" := 'Sidco Industrial Estate';
            SalesInvoiceHeader.MODIFY(FALSE);
        END;

        SalesInvoiceHeader.RESET;
        SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."No.", '9107222301000872');
        SalesInvoiceHeader.SETRANGE("Sell-to Address 2", '');
        IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
            SalesInvoiceHeader."Sell-to Address 2" := 'Sidco Industrial Estate';
            SalesInvoiceHeader.MODIFY(FALSE);
        END;


    end;

    var
        SalesInvoiceHeader: Record 112;
        // EInvoice_ASP: Codeunit 50025;
        InvoiceArr: array[31] of Code[40];
        CityArr: array[31] of Code[20];
        PostCodeArr: array[31] of Code[10];
        i: Integer;
        ArrayLength: Integer;
        AddArr: array[10] of Text[200];
        Add2Arr: array[10] of Text[100];
        StateCode: array[10] of Code[2];
        SalesInvoiceLine: Record 113;
        ItemNoArr: array[31] of Code[20];
        HSNnoArr: array[31] of Code[10];
        SalesCrMemoLine: Record 115;
}

