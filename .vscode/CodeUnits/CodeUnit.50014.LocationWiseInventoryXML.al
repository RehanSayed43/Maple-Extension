codeunit 50014 "Location Wise Inventory XML"
{
    EventSubscriberInstance = Manual;
    Permissions = TableData 112 = rim,
                  TableData 113 = rim,
                  TableData 114 = rim,
                  TableData 115 = rim,
                  TableData 50011 = rim,
                  TableData 50019 = rim;

    trigger OnRun()
    begin
        /*
        //job que restart++
         JobQueRun(50016,CREATEDATETIME(TODAY,(TIME+(6*60000))),'Codeunit');
         COMMIT;
        //jobque restart--
        
        //Item_Inventort_Details_locationwise_Request();
        //MESSAGE('start - %1',TIME);
        RecLocWiseInv.RESET;
        IF RecLocWiseInv.FINDFIRST THEN BEGIN
           IF RecLocWiseInv.Date<>TODAY THEN BEGIN
              RecLocWiseInv.DELETEALL;
              Item_Inventort_Details_locationwise_Request();
           END ELSE
           Item_Inventort_Details_locationwise_Request_1;
        END ELSE
        Item_Inventort_Details_locationwise_Request_1;
        //MESSAGE('end - %1',TIME);
        MESSAGE('Done');
        *///WIN234 05082020

    end;

    var
        // EcomDll: DotNet OrderDetailsClass;//tk
        text001: Label 'http://www.martjack.com/DeveloperAPI/Product/UpdateLocationWiseStock?oauth_consumer_key=JZVN29UR&oauth_nonce=8826731&oauth_signature_method=HMAC-SHA1&oauth_timestamp=1514532291&oauth_version=1.0&oauth_signature=kpAGUTLgjIgJQEbmzwBzj0pvt40%3D';
        text002: Label 'http://www.martjack.com/DeveloperAPI/Product/UpdateLocationWiseStock';
        Task_ID: Text;
        RecLocWiseInv: Record 50019;


    procedure Item_Inventort_Details_locationwise_Request()
    var
        FileName: Text;
        // xmlWriter: DotNet XmlTextWriter;//tk
        // EncodingText: DotNet Encoding;//tk
        RecLocation: Record 14;
        // DLL: DotNet Class1;//tk
        Output_File_Path: Text;
        RecItem: Record 27;
        RecILE: Record 32;
        INV: Decimal;
        FileName1: Text;
        Date: Date;
        Line_no: Integer;
    begin
        /*
        Date:=TODAY;
        FileName := '\\mapleNAV\Navision\Dont Delete (Capilery Integration)\Order\' +FORMAT(TODAY,0,'<Day,2>-<Month,2>-<Year4>')+'.xml';
        
        IF FILE.EXISTS(FileName) THEN
          ERASE(FileName);
          Create_Blank_XML(FileName);
        IF FILE.EXISTS('\\mapleNAV\Navision\Dont Delete (Capilery Integration)\Order\' +FORMAT(TODAY-1,0,'<Day,2>-<Month,2>-<Year4>')+'.xml') THEN
          ERASE('\\mapleNAV\Navision\Dont Delete (Capilery Integration)\Order\' +FORMAT(TODAY-1,0,'<Day,2>-<Month,2>-<Year4>')+'.xml');
        
        IF ISNULL(xmlWriter) THEN
        xmlWriter := xmlWriter.XmlTextWriter(FileName, EncodingText.UTF8);
        xmlWriter.WriteStartDocument();//begin
           xmlWriter.WriteStartElement('products');
              RecLocation.RESET;
              RecLocation.SETFILTER("E Com Location Code",'<>%1','');
              IF RecLocation.FINDSET THEN BEGIN
                REPEAT
                  RecItem.RESET;
                  RecItem.SETRANGE(Blocked,FALSE);
                  RecItem.SETRANGE("Ecommerce Item",TRUE);
                  RecItem.SETFILTER(SKU1,'<>%1','');
                  RecItem.SETFILTER("Vendor Part Code Long",'<>%1','');
                  IF RecItem.FINDSET THEN BEGIN
                    REPEAT
                      CLEAR(INV);
                      RecILE.RESET;
                      RecILE.SETRANGE(Open,TRUE);
                      RecILE.SETRANGE("Item No.",RecItem."No.");
                      RecILE.SETRANGE("Location Code",RecLocation.Code);
                      RecILE.SETFILTER("Remaining Quantity",'<>%1',0);
                      IF RecILE.FINDSET THEN BEGIN
                          REPEAT
                            INV+=RecILE."Remaining Quantity";
                          UNTIL RecILE.NEXT=0;
                      END;
                      IF INV<>0 THEN BEGIN
                          xmlWriter.WriteStartElement('product');
                            xmlWriter.WriteElementString('sku',FORMAT(RecItem.SKU1));
                            xmlWriter.WriteElementString('variantsku',FORMAT(RecItem."Vendor Part Code Long"));
                            xmlWriter.WriteElementString('stock',FORMAT(INV,0,1));
                            xmlWriter.WriteElementString('locationrefcode',FORMAT(RecLocation.Code));
                          xmlWriter.WriteEndElement();//product
                      END;
        //test++
                      RecLocWiseInv.RESET;
                      RecLocWiseInv.SETRANGE("No.",RecItem."No.");
                      RecLocWiseInv.SETRANGE("Vendor Part Code Long",RecItem."Vendor Part Code Long");
                      RecLocWiseInv.SETRANGE(Location,RecLocation.Code);
                      IF RecLocWiseInv.FINDFIRST THEN BEGIN
                          RecLocWiseInv.Date:=Date;
                          RecLocWiseInv."No.":=RecItem."No.";
                          RecLocWiseInv."Vendor Part Code Long":=RecItem."Vendor Part Code Long";
                          RecLocWiseInv.SKU1:=RecItem.SKU1;
                          RecLocWiseInv.Location:=RecLocation.Code;
                          RecLocWiseInv."Current Inventory":=INV;
                          RecLocWiseInv."Change in Inventory":=INV-RecLocWiseInv."Previous Inventory";
                          RecLocWiseInv."Previous Inventory":=INV;
                          RecLocWiseInv.MODIFY;
                      END ELSE BEGIN
                          RecLocWiseInv.RESET;
                          RecLocWiseInv.SETCURRENTKEY("Line No");
                          IF RecLocWiseInv.FINDLAST THEN
                              Line_no:=RecLocWiseInv."Line No"+1
                          ELSE Line_no:=1;
        
                          RecLocWiseInv.INIT;
                          RecLocWiseInv."Line No":=Line_no;
                          RecLocWiseInv."No.":=RecItem."No.";
                          RecLocWiseInv."Vendor Part Code Long":=RecItem."Vendor Part Code Long";
                          RecLocWiseInv.SKU1:=RecItem.SKU1;
                          RecLocWiseInv.Location:=RecLocation.Code;
                          RecLocWiseInv."Current Inventory":=INV;
                          RecLocWiseInv."Change in Inventory":=INV-RecLocWiseInv."Previous Inventory";
                          RecLocWiseInv."Previous Inventory":=INV;
                          RecLocWiseInv.Date:=Date;
                          RecLocWiseInv.INSERT;
                      END;
        //test--
                    UNTIL RecItem.NEXT=0;
                    END;
                UNTIL RecLocation.NEXT=0;
              END;
           xmlWriter.WriteEndElement();//products
        xmlWriter.WriteEndDocument();//end
        xmlWriter.Close();
        COMMIT;
        
        FileName1 := '\\mapleNAV\Navision\Dont Delete (Capilery Integration)\Order\' +FORMAT(TODAY,0,'<Day,2>-<Month,2>-<Year4>')+'-Responce' +'.xml';
        IF FILE.EXISTS(FileName1) THEN
          ERASE(FileName1);
            Create_Blank_XML(FileName1);
        IF FILE.EXISTS('\\mapleNAV\Navision\Dont Delete (Capilery Integration)\Order\' +FORMAT(TODAY-1,0,'<Day,2>-<Month,2>-<Year4>')+'-Responce' +'.xml') THEN
          ERASE('\\mapleNAV\Navision\Dont Delete (Capilery Integration)\Order\' +FORMAT(TODAY-1,0,'<Day,2>-<Month,2>-<Year4>')+'-Responce' +'.xml');
        EcomDll:=EcomDll.OrderDetailsClass;
        EcomDll.PostInventoryApi(text002,'POST','JZVN29UR','MIJILSVAXVB5BWWVMMXRDLUJ',FileName,FileName1);
        
        //IF FILE.EXISTS(FileName) THEN
          //ERASE(FileName);
        //MESSAGE('DONE');
        *///WIN234 05082020

    end;

    local procedure Item_Inventort_Details_locationwise_Response(FilePath5: Text)
    var
        NodeName3: Text;
    // xml3: DotNet XmlDocument;//tk
    // XMLNode3: DotNet XmlNode;
    begin
        /*
        xml3:=xml3.XmlDocument;
        xml3.Load(FilePath5);
        NodeName3:='//status/success';
        IF FindNode(xml3,NodeName3,XMLNode3) THEN
           IF XMLNode3.InnerText='true' THEN BEGIN
        
        
                            NodeName3:='//response/customers/customer/item_status/message';
                            IF FindNode(xml3,NodeName3,XMLNode3) THEN
                             MESSAGE(XMLNode3.InnerText);
        
            END
            ELSE BEGIN
                            NodeName3:='//response/customers/customer/item_status/message';
                            IF FindNode(xml3,NodeName3,XMLNode3) THEN
                            MESSAGE(XMLNode3.InnerText);
        
        
            END;
         // IF EXISTS(FilePath5) THEN
         // FILE.ERASE(FilePath5);
         *///WIN234 05082020

    end;


    procedure Create_Blank_XML(FilePath: Text)
    var
    // xmlWriter: DotNet XmlTextWriter;//tk
    // EncodingText: DotNet Encoding;//tk
    begin
        /*
        IF EXISTS(FilePath) THEN
        FILE.ERASE(FilePath);

        IF ISNULL(xmlWriter) THEN
        xmlWriter := xmlWriter.XmlTextWriter(FilePath, EncodingText.UTF8);
        xmlWriter.WriteStartDocument();//begin
         xmlWriter.WriteStartElement('root');
         xmlWriter.WriteEndElement;
        xmlWriter.WriteEndDocument();//end
        xmlWriter.Close();
        *///WIN234 05082020

    end;

    //tk
    // procedure FindNode(XMLRootNode: DotNet XmlNode; NodePath: Text[250]; FoundXMLNode: DotNet XmlNode): Boolean
    // begin
    //     FoundXMLNode := XMLRootNode.SelectSingleNode(NodePath);
    //     IF ISNULL(FoundXMLNode) THEN
    //         EXIT(FALSE)
    //     ELSE
    //         EXIT(TRUE);
    // end;


    procedure TextToDecimal(stream: Text): Decimal
    var
        DecimalValue: Decimal;
    begin
        EVALUATE(DecimalValue, stream);
        EXIT(DecimalValue);
    end;

    local procedure JobQueRun(Id_to_run: Integer; Date_time: DateTime; Object_type_to_run: Text)
    var
        RecJobQue: Record 472;
        JobQueueDispatcher: Codeunit 448;
    begin
        /*
        RecJobQue.RESET;
        RecJobQue.SETRANGE("Object ID to Run",Id_to_run);
        IF Object_type_to_run='Report' THEN
           RecJobQue.SETFILTER("Object Type to Run",'%1',RecJobQue."Object Type to Run"::Report)
        ELSE
           RecJobQue.SETFILTER("Object Type to Run",'%1',RecJobQue."Object Type to Run"::Codeunit);
        
        IF RecJobQue.FINDFIRST THEN BEGIN
        RecJobQue."Last Ready State" := CREATEDATETIME(TODAY,0T);
        RecJobQue."Earliest Start Date/Time":=CREATEDATETIME(TODAY,0T);
        RecJobQue.MODIFY;
        END;
        RecJobQue.RESET;
        RecJobQue.SETRANGE("Object ID to Run",Id_to_run);
        IF Object_type_to_run='Report' THEN
           RecJobQue.SETFILTER("Object Type to Run",'%1',RecJobQue."Object Type to Run"::Report)
        ELSE
           RecJobQue.SETFILTER("Object Type to Run",'%1',RecJobQue."Object Type to Run"::Codeunit);
        IF RecJobQue.FINDFIRST THEN BEGIN
        
          // RecJobQue.TESTFIELD("User ID",USERID);
           RecJobQue.LOCKTABLE;
        
          // RecJobQue."Last Ready State" := CREATEDATETIME(TODAY,0T);
           RecJobQue."Earliest Start Date/Time" := JobQueueDispatcher.CalcInitialRunTime(RecJobQue,Date_time);
        
           RecJobQue.Status :=RecJobQue.Status::Ready;
           RecJobQue."User Session Started" := 0DT;
           RecJobQue."User Service Instance ID" := 0;
           RecJobQue."User Session ID" := 0;
        //ClearServiceValues;
        
          STARTSESSION(RecJobQue."User Session ID",CODEUNIT::"Job Queue User Session",COMPANYNAME,RecJobQue);
          RecJobQue.MODIFY;
        
        END;
        *///WIN234 05082020

    end;


    procedure Item_Inventort_Details_locationwise_Request_1()
    var
        FileName: Text;
        // xmlWriter: DotNet XmlTextWriter;
        // EncodingText: DotNet Encoding;//tk
        RecLocation: Record 14;
        // DLL: DotNet Class1;//tk
        Output_File_Path: Text;
        RecItem: Record 27;
        RecILE: Record 32;
        INV: Decimal;
        FileName1: Text;
        Line_no: Integer;
        Date: Date;
        Change_in_inv: Decimal;
        Pos: Integer;
    begin
        /*
        CLEAR(Date);
        Date:=TODAY;
        Pos:=0;
        FileName := '\\mapleNAV\Navision\Dont Delete (Capilery Integration)\Order\' +FORMAT(TODAY,0,'<Day,2>-<Month,2>-<Year4>')+'.xml';
        
        IF FILE.EXISTS('\\mapleNAV\Navision\Dont Delete (Capilery Integration)\Order\' +FORMAT(TODAY-1,0,'<Day,2>-<Month,2>-<Year4>')+'.xml') THEN
          ERASE('\\mapleNAV\Navision\Dont Delete (Capilery Integration)\Order\' +FORMAT(TODAY-1,0,'<Day,2>-<Month,2>-<Year4>')+'.xml');
        
        IF FILE.EXISTS(FileName) THEN
          ERASE(FileName);
          Create_Blank_XML(FileName);
        
        IF ISNULL(xmlWriter) THEN
        xmlWriter := xmlWriter.XmlTextWriter(FileName, EncodingText.UTF8);
        xmlWriter.WriteStartDocument();//begin
           xmlWriter.WriteStartElement('products');
        
                      RecLocation.RESET;
                      RecLocation.SETFILTER("E Com Location Code",'<>%1','');
                      IF RecLocation.FINDSET THEN BEGIN
                        REPEAT
                          RecItem.RESET;
                          RecItem.SETRANGE(Blocked,FALSE);
                          RecItem.SETRANGE("Ecommerce Item",TRUE);
                          RecItem.SETFILTER(SKU1,'<>%1','');
                          RecItem.SETFILTER("Vendor Part Code Long",'<>%1','');
                          IF RecItem.FINDSET THEN BEGIN
                            REPEAT
                          //test++
                            CLEAR(Change_in_inv);
                            CLEAR(INV);
                            RecILE.RESET;
                            RecILE.SETRANGE(Open,TRUE);
                            RecILE.SETRANGE("Item No.",RecItem."No.");
                            RecILE.SETRANGE("Location Code",RecLocation.Code);
                            RecILE.SETFILTER("Remaining Quantity",'<>%1',0);
                            IF RecILE.FINDSET THEN BEGIN
                                REPEAT
                                  INV+=RecILE."Remaining Quantity";
                                UNTIL RecILE.NEXT=0;
                            END;
        
                                RecLocWiseInv.RESET;
                                RecLocWiseInv.SETRANGE("No.",RecItem."No.");
                                RecLocWiseInv.SETRANGE("Vendor Part Code Long",RecItem."Vendor Part Code Long");
                                RecLocWiseInv.SETRANGE(Location,RecLocation.Code);
                                IF RecLocWiseInv.FINDFIRST THEN BEGIN
                                    RecLocWiseInv.Date:=Date;
                                    RecLocWiseInv."No.":=RecItem."No.";
                                    RecLocWiseInv."Vendor Part Code Long":=RecItem."Vendor Part Code Long";
                                    RecLocWiseInv.SKU1:=RecItem.SKU1;
                                    RecLocWiseInv.Location:=RecLocation.Code;
                                    RecLocWiseInv."Current Inventory":=INV;
                                    Change_in_inv:=INV-RecLocWiseInv."Previous Inventory";
                                    RecLocWiseInv."Change in Inventory":=Change_in_inv;
                                    RecLocWiseInv."Previous Inventory":=INV;
                                    RecLocWiseInv.MODIFY;
                                END ELSE BEGIN
                                    RecLocWiseInv.RESET;
                                    RecLocWiseInv.SETCURRENTKEY("Line No");
                                    IF RecLocWiseInv.FINDLAST THEN
                                       Line_no:=RecLocWiseInv."Line No"+1
                                    ELSE Line_no:=1;
        
                                    RecLocWiseInv.INIT;
                                    RecLocWiseInv."Line No":=Line_no;
                                    RecLocWiseInv."No.":=RecItem."No.";
                                    RecLocWiseInv."Vendor Part Code Long":=RecItem."Vendor Part Code Long";
                                    RecLocWiseInv.SKU1:=RecItem.SKU1;
                                    RecLocWiseInv.Location:=RecLocation.Code;
                                    RecLocWiseInv."Current Inventory":=INV;
                                    Change_in_inv:=INV-RecLocWiseInv."Previous Inventory";
                                    RecLocWiseInv."Change in Inventory":=Change_in_inv;
                                    RecLocWiseInv."Previous Inventory":=INV;
                                    RecLocWiseInv.Date:=Date;
                                    RecLocWiseInv.INSERT;
                                END;
        
                                IF Change_in_inv<>0 THEN BEGIN
                                    xmlWriter.WriteStartElement('product');
                                      Pos+=1;
                                      xmlWriter.WriteElementString('sku',FORMAT(RecItem.SKU1));
                                      xmlWriter.WriteElementString('variantsku',FORMAT(RecItem."Vendor Part Code Long"));
                                      xmlWriter.WriteElementString('stock',FORMAT(INV,0,1));
                                      xmlWriter.WriteElementString('locationrefcode',FORMAT(RecLocation.Code));
                                    xmlWriter.WriteEndElement();//product
                                END;
        
                            UNTIL RecItem.NEXT=0;
                           END;
                        UNTIL RecLocation.NEXT=0;
                      END;
           xmlWriter.WriteEndElement();//products
        xmlWriter.WriteEndDocument();//end
        xmlWriter.Close();
        COMMIT;
        IF Pos<>0 THEN BEGIN
        
        IF FILE.EXISTS('\\mapleNAV\Navision\Dont Delete (Capilery Integration)\Order\' +FORMAT(TODAY-1,0,'<Day,2>-<Month,2>-<Year4>')+'-Responce' +'.xml') THEN
          ERASE('\\mapleNAV\Navision\Dont Delete (Capilery Integration)\Order\' +FORMAT(TODAY-1,0,'<Day,2>-<Month,2>-<Year4>')+'-Responce' +'.xml');
        
            FileName1 := '\\mapleNAV\Navision\Dont Delete (Capilery Integration)\Order\' +FORMAT(TODAY,0,'<Day,2>-<Month,2>-<Year4>')+'-Responce' +'.xml';
            IF FILE.EXISTS(FileName1) THEN
              ERASE(FileName1);
                Create_Blank_XML(FileName1);
            EcomDll:=EcomDll.OrderDetailsClass;
            EcomDll.PostInventoryApi(text002,'POST','JZVN29UR','MIJILSVAXVB5BWWVMMXRDLUJ',FileName,FileName1);
        
            //IF FILE.EXISTS(FileName) THEN
              //ERASE(FileName);
        
        END;
        *///WIN234 05082020

    end;
}

