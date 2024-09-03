codeunit 50008 "XML Import Capillary"
{
    // //WIN316 CAPILLARY INTEGRATION

    Permissions = TableData "Customer Capillary" = rimd;

    trigger OnRun()
    begin
    end;

    var
        xml: Codeunit DotNet_XmlDocument;//DotNet XmlDocument;
        //Customers: DotNet XmlNodeList; //CCIT_kj need to check
        cnt: Integer;
        i: Integer;
        // XMLNode: DotNet XmlNode; //CCIT_kj need to check
        RecCustCap: Record "Customer Capillary";//"50011";
        RecCustCap1: Record "Customer Capillary";//"50011";
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";//"16419";
        RecSH: Record "Sales Header";//"36";
        RecCust: Record Customer;//"18";

    [Scope('Internal')]
    procedure GetCustomerDataFromCapillary(FilePath: Text; Sales_order_no: Code[20])
    var
        NodeName: Text;
        Mobile_no: Text;
    begin
        RecCustCap.SETRANGE("Sales Order No", Sales_order_no);
        IF RecCustCap.FINDFIRST THEN
            EXIT;

        /* xml := xml.XmlDocument; //ccit_kj++++++
        xml.Load(FilePath);
        NodeName := '//status/success';
        IF FindNode(xml, NodeName, XMLNode) THEN
            IF XMLNode.InnerText = 'true' THEN BEGIN */ //ccit_kj+++-------

        RecCustCap.INIT;
        RecSH.SETRANGE("No.", Sales_order_no);
        IF RecSH.FINDFIRST THEN;
        RecCust.SETRANGE("No.", RecSH."Sell-to Customer No.");
        IF RecCust.FINDFIRST THEN;
        RecCustCap."Mobile No" := RecCust."Phone No.";
        RecCustCap."Sales Order No" := Sales_order_no;
        RecCustCap.Address := RecSH."Bill-to Address";
        RecCustCap."Customer Code" := RecSH."Sell-to Customer No.";
        RecCustCap."First Name" := RecCust.Name;
        /*  RecCustCap."Age Group" := RecCust."Age Group"; //kj+++++
         RecCustCap."Income Group" := RecCust."Income Group";
         RecCustCap.Anniversary := RecCust."Aniversary Date";
         RecCustCap.Birthdate := RecCust."Customer Birth Date";
         RecCustCap.Pincode := RecCust."Post Code";
         RecCustCap.Gender := RecCust.Gender; */ //kj--------

        // NodeName:='//customers/customer/email';
        //  IF FindNode(xml,NodeName,XMLNode) THEN BEGIN
        RecCustCap.Email := RecCust."E-Mail";
        //  END;

        IF RecCustCap1.FINDLAST THEN
            RecCustCap."Entry No" := RecCustCap1."Entry No" + 100
        ELSE
            RecCustCap."Entry No" := 100;

        NodeName := '//customers/customer/loyalty_points';
        /*  IF FindNode(xml, NodeName, XMLNode) THEN BEGIN   //kj++++++++
             IF XMLNode.InnerText <> '' THEN //win-234 28-09-2019
                 RecCustCap."Customer Points" := TextToDecimal(XMLNode.InnerText);
         END; */  //kj------------
                  /*
                  //FOR MULTIPLE COUPON ++
                  NodeName:='//customers/customer/coupons/coupon/code';
                  Customers:=xml.SelectNodes(NodeName);
                  cnt:=Customers.Count;
                  i:=0;
                  IF cnt>0 THEN BEGIN
                      REPEAT
                        RecCustCoupCap.INIT;
                        XMLNode := Customers.Item(i);
                        RecCustCoupCap."Coupon Code":=XMLNode.InnerText;
                        RecCustCoupCap."Sales Order No":=Sales_order_no;
                        RecCustCoupCap."Mobile No":=RecCust."Phone No.";
                        RecCustCoupCap.INSERT(TRUE);
                        i+=1;
                        cnt:=cnt-1;
                      UNTIL cnt=0;
                  END;
                  //FOR MULTIPLE COUPON --
                  */
        RecCustCap.INSERT(TRUE);
        MESSAGE('Done');
        /*   IF EXISTS(FilePath) THEN  //kj++++++
              FILE.ERASE(FilePath);
      END
              ELSE BEGIN
                  MESSAGE('Customer Data is not available in Capillary'); */ //kj--------
        RecCustCap.INIT;
        RecSH.SETRANGE("No.", Sales_order_no);
        IF RecSH.FINDFIRST THEN;
        RecCust.SETRANGE("No.", RecSH."Sell-to Customer No.");
        IF RecCust.FINDFIRST THEN;
        RecCustCap."Mobile No" := RecCust."Phone No.";
        RecCustCap."Sales Order No" := Sales_order_no;
        RecCustCap.Address := RecSH."Bill-to Address";
        RecCustCap."Customer Code" := RecSH."Sell-to Customer No.";
        RecCustCap."First Name" := RecCust.Name;
        RecCustCap.Email := RecCust."E-Mail";
        /*  RecCustCap."Age Group" := RecCust."Age Group"; //ccit_kj+++
         RecCustCap."Income Group" := RecCust."Income Group";
         RecCustCap.Anniversary := RecCust."Aniversary Date";
         RecCustCap.Birthdate := RecCust."Customer Birth Date";
         RecCustCap.Pincode := RecCust."Post Code";
         RecCustCap.Gender := RecCust.Gender;
*/ //ccit_kj+----
        IF RecCustCap1.FINDLAST THEN
            RecCustCap."Entry No" := RecCustCap1."Entry No" + 100
        ELSE
            RecCustCap."Entry No" := 100;

        RecCustCap."Customer Points" := 0;
        RecCustCap."Customer Points Value in Rs" := 0;

        RecCustCap.INSERT(TRUE);
        MESSAGE('Done');

    END;

    //end; //kj

    //[Scope('Internal')] //kj
    //kj+++++
    /*  procedure FindNode(XMLRootNode: DotNet XmlNode; NodePath: Text[250];

     var
         FoundXMLNode: DotNet XmlNode): Boolean //kj
     begin
          FoundXMLNode := XMLRootNode.SelectSingleNode(NodePath); //kj++++++++
         IF ISNULL(FoundXMLNode) THEN
             EXIT(FALSE)
         ELSE
             EXIT(TRUE);  
     end; */ //kj--------

    [Scope('Internal')]
    procedure GetValidationCode(FilePath: Text)
    var
        NodeName: Text;
    begin

        /*   xml := xml.XmlDocument; //kj+++++
          xml.Load(FilePath);

          NodeName := '//validation_code/code/item_status/message';
          IF FindNode(xml, NodeName, XMLNode) THEN
              MESSAGE(XMLNode.InnerText); */ //kj------------
                                             //  IF EXISTS(FilePath) THEN
                                             // FILE.ERASE(FilePath);
    end;

    [Scope('Internal')]
    procedure ValidateValidationCode(FilePath: Text; Sales_order_no: Code[20]; Validation_Code: Text[30])
    var
        NodeName: Text;
    begin
        //kj+++++++++++
        /*  xml := xml.XmlDocument;
         xml.Load(FilePath);
         NodeName := '//status/success';
         IF FindNode(xml, NodeName, XMLNode) THEN
             IF XMLNode.InnerText = 'true' THEN BEGIN

                 NodeName := '//points/item_status/message';
                 IF FindNode(xml, NodeName, XMLNode) THEN
                     MESSAGE(XMLNode.InnerText);


                 RecCustCap.RESET;
                 RecCustCap.SETRANGE("Sales Order No", Sales_order_no);
                 NodeName := '//points/redeemable/mobile';
                 IF FindNode(xml, NodeName, XMLNode) THEN
                     RecCustCap.SETFILTER("Mobile No", '%1', XMLNode.InnerText);
                 IF RecCustCap.FINDFIRST THEN
                     NodeName := '//points/redeemable/points_redeem_value';
                 IF FindNode(xml, NodeName, XMLNode) THEN
                     RecCustCap.VALIDATE("Point Redeem Value In Rs.", TextToDecimal(XMLNode.InnerText));
                 RecCustCap."Validation Code For Points" := Validation_Code;
                 RecCustCap.MODIFY;


             END
             ELSE BEGIN
                 NodeName := '//points/redeemable/item_status/message';
                 IF FindNode(xml, NodeName, XMLNode) THEN
                     MESSAGE(XMLNode.InnerText);

             END; */  //kj-----------
    end;

    [Scope('Internal')]
    procedure TextToDecimal(stream: Text): Decimal
    var
        DecimalValue: Decimal;
    begin
        EVALUATE(DecimalValue, stream);
        EXIT(DecimalValue);
    end;

    [Scope('Internal')]
    procedure CustomerDataForReturn(FilePath: Text; Sales_order_no: Code[20])
    var
        NodeName: Text;
        Mobile_no: Text;
    begin
        RecCustCap.SETRANGE("Sales Order No", Sales_order_no);
        IF RecCustCap.FINDFIRST THEN
            EXIT;

        RecCustCap.INIT;
        RecSH.SETRANGE("No.", Sales_order_no);
        IF RecSH.FINDFIRST THEN;
        RecCust.SETRANGE("No.", RecSH."Sell-to Customer No.");
        IF RecCust.FINDFIRST THEN;
        RecCustCap."Mobile No" := RecCust."Phone No.";
        RecCustCap."Sales Order No" := Sales_order_no;
        RecCustCap.Address := RecSH."Bill-to Address";
        RecCustCap."Customer Code" := RecSH."Sell-to Customer No.";
        RecCustCap."First Name" := RecCust.Name;
        /* RecCustCap."Age Group" := RecCust."Age Group";  //kj+++++++
        RecCustCap."Income Group" := RecCust."Income Group";
        RecCustCap.Anniversary := RecCust."Aniversary Date";
        RecCustCap.Birthdate := RecCust."Customer Birth Date";
        RecCustCap.Pincode := RecCust."Post Code";
        RecCustCap.Gender := RecCust.Gender; */ //kj-----------
        RecCustCap.Email := RecCust."E-Mail";


        IF RecCustCap1.FINDLAST THEN
            RecCustCap."Entry No" := (RecCustCap1."Entry No" + 100)
        ELSE
            RecCustCap."Entry No" := 100;


        RecCustCap.INSERT(TRUE);

        // IF EXISTS(FilePath) THEN
        //FILE.ERASE(FilePath);
    end;

    [Scope('Internal')]
    procedure GetCustomerPoints(FilePath: Text): Decimal
    var
        NodeName: Text;
        Points: Decimal;
    //  DLL: DotNet Class1; //kj
    begin
        /*  xml := xml.XmlDocument; //kj++++++++++
         xml.Load(FilePath);
         Points := 0;
         NodeName := '//status/success';
         IF FindNode(xml, NodeName, XMLNode) THEN
             IF XMLNode.InnerText = 'true' THEN BEGIN

                 NodeName := '//customers/customer/loyalty_points';
                 IF FindNode(xml, NodeName, XMLNode) THEN BEGIN
                     IF XMLNode.InnerText <> '' THEN //win-234 28-09-2019
                         Points := TextToDecimal(XMLNode.InnerText); 
                 END; 
                         // IF EXISTS(FilePath) THEN
                         //FILE.ERASE(FilePath);
    END
            ELSE BEGIN
                MESSAGE('Customer Data is not available in Capillary');
            END;
        EXIT(Points); */ //kj----------
    end;

    //kj++++++++
    /* trigger xml::NodeInserting(sender: Variant; e: DotNet XmlNodeChangedEventArgs)
    begin
    end;

    trigger xml::NodeInserted(sender: Variant; e: DotNet XmlNodeChangedEventArgs)
    begin
    end;

    trigger xml::NodeRemoving(sender: Variant; e: DotNet XmlNodeChangedEventArgs)
    begin
    end;

    trigger xml::NodeRemoved(sender: Variant; e: DotNet XmlNodeChangedEventArgs)
    begin
    end;

    trigger xml::NodeChanging(sender: Variant; e: DotNet XmlNodeChangedEventArgs)
    begin
    end;

    trigger xml::NodeChanged(sender: Variant; e: DotNet XmlNodeChangedEventArgs)
    begin
    end; */ //kj------
}

