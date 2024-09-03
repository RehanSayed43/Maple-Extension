report 50065 "ECom Integration1"
{
    // CurrCRM:="CRM Integration"."CRM invoice No";
    // IF PrevCRM<> CurrCRM  THEN BEGIN
    //     PrevCRM:="CRM Integration"."CRM invoice No";
    // 
    //     CreateSalesOrder;
    //     //GetTransferOrderToCRM;
    // END ELSE BEGIN
    //    "CRM Integration"."Order Created"  :=TRUE;
    //    "CRM Integration".MODIFY;
    //     CurrReport.SKIP;
    // END;

    ProcessingOnly = true;
    UseRequestPage = false;
    ApplicationArea = FixedAsset;

    dataset
    {
        dataitem("Store E-Commerce Order"; "Store E-Commerce Order")
        {
            DataItemTableView = SORTING("Entry No", "Order ID")
                                ORDER(Descending)
                                WHERE("Skip Order" = CONST(False),
                                      Status = FILTER(' '));

            trigger OnAfterGetRecord()
            begin
                /*
                //IF GUIALLOWED THEN BEGIN
                CurrCRM:="Store E-Commerce Order"."Order ID";
                IF PrevCRM<> CurrCRM  THEN BEGIN
                    PrevCRM:="Store E-Commerce Order"."Order ID";
                   IF ("G/L Account No"='') AND("Store E-Commerce Order"."Capillary Discount Amount"=0)THEN BEGIN
                      MESSAGE('Payment Type %1 doesnot exists',"Payment Type");
                      CurrReport.SKIP;
                     END;
                
                   IF ("Store E-Commerce Order"."Order Created") AND ("Store E-Commerce Order"."Transfer Order Created") AND ("Store E-Commerce Order"."Order Posted")
                      AND ("Store E-Commerce Order"."Transfer Order Posted") AND ("Store E-Commerce Order"."Payment Created") AND ("Store E-Commerce Order"."Payment Posted") THEN
                       CurrReport.SKIP;
                
                    CreateSalesOrder;
                   // MESSAGE('%1',"Store E-Commerce Order"."Order ID");
                    //GetTransferOrderToCRM;
                END ELSE BEGIN
                      CurrReport.SKIP;
                END;
                MESSAGE('Sales Order Done');
                //END;
                *///WIN234 05082020

            end;

            trigger OnPostDataItem()
            begin
                //PAYMENT POST
                /*RecGenJnlLine.RESET;
                RecGenJnlLine.SETRANGE(RecGenJnlLine."Journal Template Name",'GENERAL1');
                RecGenJnlLine.SETRANGE(RecGenJnlLine."Journal Batch Name",'DEFAULT');
                RecGenJnlLine.SETRANGE(RecGenJnlLine."Posting Date",TODAY);
                RecGenJnlLine.SETFILTER(Amount,'<>%1',0);
                RecGenJnlLine.SETFILTER("Line No.",'<>%1',0);
                IF RecGenJnlLine.FINDSET THEN
                   CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",RecGenJnlLine);*/

            end;
        }
        dataitem("Store E-Commerce Order1"; "Store E-Commerce Order")
        {
            DataItemTableView = SORTING("Entry No", "Order ID")
                                ORDER(Descending)
                                WHERE(Status = CONST("Return Order"),
                                      "Order Posted" = CONST(True));

            trigger OnAfterGetRecord()
            begin
                /*
                CurrCRM1:="Store E-Commerce Order1"."Order ID";
                IF PrevCRM1<> CurrCRM1  THEN BEGIN
                    PrevCRM1:="Store E-Commerce Order1"."Order ID";
                
                   // CreateSalesReturnOrder&PostOrder;
                   Create_Return_Order;
                   COMMIT;
                   ReturnTransferOrder;
                  // RecEComOrder
                  //RETURN PAYMENT++
                RecEComInt.RESET;
                RecEComInt.SETRANGE("Order ID","Store E-Commerce Order"."Order ID");
                IF RecEComInt.FINDFIRST THEN BEGIN
                   IF (RecEComInt."Return Order Posted") AND (RecEComInt."Return Transfer Order Posted") AND (RecEComInt."Return Payment Created"=FALSE)
                     AND(RecEComInt."Return Payment Posted"=FALSE) THEN
                        PostReturnPayment('',RecEComInt."Order ID");
                END;
                
                  //RETURN PAYMENT --
                
                
                END ELSE BEGIN
                      CurrReport.SKIP;
                END;
                MESSAGE('Return Order Done');
                *///WIN234 05082020

            end;

            trigger OnPostDataItem()
            begin
                //PAYMENT POST
                /*RecGenJnlLine.RESET;
                RecGenJnlLine.SETRANGE(RecGenJnlLine."Journal Template Name",'GENERAL1');
                RecGenJnlLine.SETRANGE(RecGenJnlLine."Journal Batch Name",'DEFAULT');
                RecGenJnlLine.SETRANGE(RecGenJnlLine."Posting Date",TODAY);
                RecGenJnlLine.SETFILTER(Amount,'<>%1',0);
                RecGenJnlLine.SETFILTER("Line No.",'<>%1',0);
                IF RecGenJnlLine.FINDSET THEN
                CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",RecGenJnlLine);*/

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

    trigger OnPreReport()
    begin
        /*
        //job que restart++
        //JobQueRun(50014);
        JobQueRun(50014,CREATEDATETIME(TODAY,(TIME+(7*60000))),'Codeunit');
        COMMIT;
        //jobque restart--
        *///WIN234 05082020

    end;

    var
        qty: Decimal;
        RecLoc: Record 14;
        SalesPost: Codeunit 81;
        RecEComInt: Record 50014;
        RecGenJnlLine: Record 81;
        LineNo1: Integer;
        GenJnlPostLine: Codeunit 12;
        DoucNo: Code[20];
        NoSeriesMgt: Codeunit 396;
        SRsetup: Record 311;
        CurrCRM: Code[20];
        PrevCRM: Code[20];
        RecCust: Record 18;
        RecSalesInv: Record 112;
        SO_No: Code[20];
        RecSL1: Record 37;
        Rec_TransferHead: Record 5740;
        Rec_TransferLine: Record 5741;
        Gen_Batch: Record 232;
        Tline_no: Integer;
        j: Integer;
        InvSetup: Record 313;
        TransferPost: Codeunit 5706;
        TransferHead: Record 5740;
        PAYSECom: Record 50014;
        RecTraLin: Record 5741;
        RecItem: Record 27;
        RecSL2: Record 37;
        RecSH: Record 36;
        Recstate: Record State;
        CurrCRM1: Code[20];
        PrevCRM1: Code[20];
        RecEComOrder: Record 50014;
        RecSalesCrMemo: Record 114;


    procedure CreateSalesOrder()
    var
        NoSeriesMgt: Codeunit 396;
        SRsetup: Record 311;
        RecSH: Record 36;
        line_no: Integer;
        RecLocation: Record 14;
        Output_File_Path: Text;
        RecSL: Record 37;
        cnt: Integer;
        i: Integer;
        RecItem: Record 27;
        RecSH1: Record 36;
    begin
        /*
        IF NOT "Store E-Commerce Order"."Order Created" THEN BEGIN
            RecCust.RESET;
            RecCust.SETRANGE("Phone No.","Store E-Commerce Order"."Bill Phone No.");
            IF RecCust.FINDFIRST THEN BEGIN
            //Sales Header Insert ++
              RecCust.TESTFIELD("GST Customer Type");
              SRsetup.GET;
              RecSH.INIT;
              CLEAR(SO_No);
              SO_No:=NoSeriesMgt.GetNextNo(SRsetup."Order Nos.",WORKDATE,TRUE);
              RecSH."No.":=SO_No;
              RecSH."Order ID":="Store E-Commerce Order"."Order ID";
              RecSH."Sales Order Type":=RecSH."Sales Order Type"::Online;
              RecSH."Document Type":=RecSH."Document Type"::Invoice;//Order;
              RecSH.VALIDATE("Sell-to Customer No.",RecCust."No.");
              RecSH.VALIDATE ("Location Code","Store E-Commerce Order"."E Com Location Code");
              RecSH.VALIDATE(Structure,'GST PIT');//"Store E-Commerce Order".Structure);
            //RecSH."Nature of Supply":="Store E-Commerce Order"."Nature of Supply";
               IF RecEComInt."Capillary Discount Amount"<>0 THEN BEGIN
                  RecSL.VALIDATE("Line Discount Amount",(RecEComInt."Product Price"/(RecEComInt."Amount Payable"/RecEComInt."Capillary Discount Amount")));
                  RecSL."Capillary Line Discount Amount":=(RecEComInt."Product Price"/(RecEComInt."Amount Payable"/RecEComInt."Capillary Discount Amount"));
               END;
              RecSH.VALIDATE("Posting Date",TODAY);
              RecSH."Capillary Posted":=TRUE;
              RecSH."Shield Posting No.":='';
              RecSH.INSERT(TRUE);
        
            //Sales Header Insert --
              RecEComInt.RESET;
              RecEComInt.SETRANGE(RecEComInt."Order ID",PrevCRM);
               IF RecEComInt.FINDSET THEN BEGIN
                  REPEAT
                      RecSL.INIT;
                      RecSL.VALIDATE("Document Type",RecSL."Document Type"::Invoice);
                      RecSL.VALIDATE("Document No.",SO_No);
                      RecSL.VALIDATE("Sell-to Customer No.",RecCust."No.");
                      IF i=0 THEN
                        line_no:=10000
                      ELSE
                        line_no:=(i+1)*10000;
                      RecSL.VALIDATE("Line No.",line_no);
                      RecSL.VALIDATE(Type,RecSL.Type::Item);
                      RecSL.INSERT(TRUE);
        
                      RecSL.RESET;
                      RecSL.SETRANGE("Document No.",SO_No);
                      RecSL.SETFILTER("Line No.",'%1',line_no);
                      IF RecSL.FINDFIRST THEN BEGIN
                       //IF RecSL.Type=RecSL.Type::Item THEN
                         RecSL.VALIDATE("No.",RecEComInt."Item No");
                      // IF RecSL.Type=RecSL.Type::"G/L Account" THEN
                      //  RecSL.VALIDATE("No.",RecEComInt."No.");
                         RecSL.VALIDATE("Location Code",RecSH."Location Code");
                       //RecSL.VALIDATE("No.",RecEComInt."No.");
                         RecSL.VALIDATE(Quantity,RecEComInt.Quantity);
                         RecSL.VALIDATE("Unit Price Incl. of Tax",RecEComInt."Product Price");
                         RecSL.VALIDATE("PIT Structure",'GST PIT');
                         RecSL.VALIDATE("Price Inclusive of Tax",TRUE);
                       //RecSL.VALIDATE("GST Group Code",RecEComInt."GST Group Code");
                       //RecSL.VALIDATE("HSN/SAC Code",RecEComInt."HSN/SAC Code");
                       //RecSL."Invoice Type":="CRM Integration"."Invoice Type";
                       //RecSL.VALIDATE(Reserve,RecSL.Reserve::Always);
                       //RecSL.VALIDATE("Shortcut Dimension 1 Code",'BANDRA');
                       //RecSL.VALIDATE("Shortcut Dimension 2 Code",'B2BSALE');
                         RecSL.MODIFY;
        
                      // RecSL.AutoReserve;
                         END;
                       i+=1;
                       cnt:=cnt-1;
                       RecEComInt."Order Created"  :=TRUE;
                       RecEComInt.MODIFY;
                  UNTIL RecEComInt.NEXT=0;
                  RecSH.VALIDATE("Shortcut Dimension 1 Code",'ECOMMERCE');
                  RecSH.VALIDATE("Shortcut Dimension 2 Code",'ONLINE');
                  END;
                  MESSAGE('Sales Order Created %1',SO_No);
                 //RecEComInt."Order Created"  :=TRUE;
                 //RecEComInt.MODIFY;
                   IF RecSH.Structure <> '' THEN BEGIN
                      RecSL.CalculateStructures(RecSH);
                   END;
                   COMMIT;
            END
            ELSE
            ERROR('Customer not available');
        END;
        
        //Transfer order creation and posting++
              GetTransferOrderToCRM;
        //Transfer order creation and posting--
        
        {
        //Sales order & Payment Posting++
            RecSH1.RESET;
            RecSH1.SETRANGE("Order ID","Store E-Commerce Order"."Order ID");
            IF RecSH1.FINDFIRST THEN
                SalesPost.RUN(RecSH1);
        
                PAYSECom.RESET;
                PAYSECom.SETRANGE("Order ID",RecSH1."Order ID");
                IF PAYSECom.FINDSET THEN
                 REPEAT
                   PAYSECom."Order Posted":=TRUE;
                   PAYSECom.MODIFY;
                 UNTIL PAYSECom.NEXT=0;
                PostPayment(SO_No,"Store E-Commerce Order"."Order ID");
                COMMIT;
        //Sales order & Payment Posting--
        }
        RecEComInt.RESET;
        RecEComInt.SETRANGE("Order ID","Store E-Commerce Order"."Order ID");
        IF RecEComInt.FINDFIRST THEN BEGIN
            IF (RecEComInt."Order Created") AND (RecEComInt."Order Posted"=FALSE) THEN BEGIN
                RecSH1.RESET;
                RecSH1.SETRANGE("Order ID","Store E-Commerce Order"."Order ID");
                IF RecSH1.FINDFIRST THEN BEGIN
                    IF RecSH.Structure <> '' THEN BEGIN
                      RecSL.CalculateStructures(RecSH1);
                    END;
                    SalesPost.RUN(RecSH1);
        
                    PAYSECom.RESET;
                    PAYSECom.SETRANGE("Order ID",RecSH1."Order ID");
                    IF PAYSECom.FINDSET THEN
                     REPEAT
                       PAYSECom."Order Posted":=TRUE;
                       PAYSECom.MODIFY;
                     UNTIL PAYSECom.NEXT=0;
                    MESSAGE('Ecommerce Sales Order posted - %1',RecSH1."Order ID");
                    //payment post++
                    IF "Store E-Commerce Order"."G/L Account No"<>'' THEN
                    PostPayment(SO_No,"Store E-Commerce Order"."Order ID");
                    //payment post--
                    COMMIT;
                END;
            END;
        END;
           IF ("Store E-Commerce Order"."Order Created") AND ("Store E-Commerce Order"."Transfer Order Created") AND ("Store E-Commerce Order"."Order Posted")
              AND ("Store E-Commerce Order"."Transfer Order Posted") THEN
                PostPayment(SO_No,"Store E-Commerce Order"."Order ID");
                *///WIN234 05082020

    end;

    [Scope('Internal')]
    procedure PostPayment(OrderNo: Code[20]; OrderId: Code[20])
    begin
        /*
        IF NOT "Store E-Commerce Order"."Payment Created" THEN BEGIN
              RecCust.RESET;
              RecCust.SETRANGE(RecCust."Phone No.","Store E-Commerce Order"."Bill Phone No.");
              //2++
              IF RecCust.FINDFIRST THEN BEGIN
                 RecSalesInv.RESET;
                 RecSalesInv.SETRANGE("Order ID",OrderId);
                 IF RecSalesInv.FINDFIRST THEN;
                    RecSalesInv.CALCFIELDS(RecSalesInv."Amount to Customer");
                    IF (RecSalesInv."Amount to Customer"*-1)<>0 THEN BEGIN//ECOM DISCOUNT
                    RecGenJnlLine.RESET;
                    RecGenJnlLine.SETRANGE(RecGenJnlLine."Journal Template Name",'GENERAL1');
                    RecGenJnlLine.SETRANGE(RecGenJnlLine."Journal Batch Name",'DEFAULT');
                    IF RecGenJnlLine.FINDLAST THEN
                        LineNo1 := RecGenJnlLine."Line No." + 10000
                    ELSE
                        LineNo1 := 10000;
                    RecGenJnlLine.INIT;
                    RecGenJnlLine."Journal Template Name":='GENERAL1';
                    RecGenJnlLine."Journal Batch Name":='DEFAULT';
                    RecGenJnlLine."Line No." :=LineNo1;
                    RecGenJnlLine."Posting Date" := TODAY;
                    RecGenJnlLine."Document Date" :=TODAY;
                    //RecGenJnlLine.Description :='TEST';
                    RecGenJnlLine."Account Type" := RecGenJnlLine."Account Type"::Customer;
                    RecGenJnlLine.VALIDATE("Account No.",RecCust."No.");
                    RecGenJnlLine.VALIDATE("Document Type",RecGenJnlLine."Document Type"::Payment);
                    SRsetup.GET;
                    DoucNo:=NoSeriesMgt.GetNextNo(SRsetup."ECOM Payment No.",WORKDATE,TRUE);
                    RecGenJnlLine."Document No." :=DoucNo;
                    RecGenJnlLine."Bal. Account Type" := RecGenJnlLine."Bal. Account Type"::"G/L Account";
                    RecGenJnlLine."Bal. Account No.":="Store E-Commerce Order"."G/L Account No";
                    RecGenJnlLine."Location Code" :="Store E-Commerce Order"."E Com Location Code";
                    RecGenJnlLine.Amount:=RecSalesInv."Amount to Customer"*-1;
                    RecGenJnlLine."Amount (LCY)" :=RecSalesInv."Amount to Customer"*-1;
                    RecGenJnlLine.VALIDATE("Shortcut Dimension 1 Code",RecSalesInv."Shortcut Dimension 1 Code");
                    RecGenJnlLine.VALIDATE("Shortcut Dimension 2 Code",RecSalesInv."Shortcut Dimension 2 Code");
                    RecGenJnlLine."Order ID":="Store E-Commerce Order"."Order ID";
        
                    //For Application++
                    RecGenJnlLine.VALIDATE("Applies-to Doc. Type",RecGenJnlLine."Applies-to Doc. Type"::Invoice);
                    RecGenJnlLine.VALIDATE("Applies-to Doc. No.",RecSalesInv."No.");
                    //For Application--
        
                    IF RecGenJnlLine.INSERT(TRUE) THEN;
                    //POST PAYMENT
                    CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",RecGenJnlLine);
                    MESSAGE('Payment posted for order no - %1',"Store E-Commerce Order"."Order ID");
                    END;
        
                    PAYSECom.RESET;
                    PAYSECom.SETFILTER("Order ID",OrderId);
                    IF PAYSECom.FINDSET THEN
                        REPEAT
                          PAYSECom."Payment Created":=TRUE;
                          PAYSECom.MODIFY;
                        UNTIL PAYSECom.NEXT=0;
                        COMMIT;
        
              END;
              //2--
              //3++
              IF NOT "Store E-Commerce Order"."Payment Posted" THEN
                BEGIN
                  PAYSECom.RESET;
                  PAYSECom.SETRANGE("Bill Phone No.","Store E-Commerce Order"."Bill Phone No.");//win316
                  PAYSECom.SETRANGE("Order ID",OrderId);
                    IF PAYSECom.FINDSET THEN
                      REPEAT
                        PAYSECom."Payment Posted":=TRUE;
                        PAYSECom.MODIFY;
                      UNTIL PAYSECom.NEXT=0;
                END;
              //3--
        END;
        
         *///WIN234 05082020

    end;

    [Scope('Internal')]
    procedure GetTransferOrderToCRM()
    begin
        /*
        //1++
        IF NOT "Store E-Commerce Order"."Transfer Order Created" THEN BEGIN
              Rec_TransferHead.RESET;
              Rec_TransferHead.INIT;
              InvSetup.GET;
              Rec_TransferHead."No.":=NoSeriesMgt.GetNextNo(InvSetup."Transfer Order Nos.",0D,TRUE);
              Rec_TransferHead."Transfer-from Code":="Store E-Commerce Order"."Location Code";
              Rec_TransferHead."Transfer-to Code":="Store E-Commerce Order"."E Com Location Code";
              Rec_TransferHead."In-Transit Code":="Store E-Commerce Order"."In Transit Location";
              Rec_TransferHead.VALIDATE(Rec_TransferHead.Structure,'GST');
              Rec_TransferHead."Posting Date":=TODAY;
              Rec_TransferHead."Shipment Date":=TODAY;
              Rec_TransferHead."Receipt Date":=TODAY;
              Rec_TransferHead."ECom Order ID":="Store E-Commerce Order"."Order ID";
              Rec_TransferHead.INSERT;
        
              RecEComInt.RESET;
              RecEComInt.SETRANGE(RecEComInt."Order ID",PrevCRM);
              IF RecEComInt.FINDSET THEN BEGIN
                 REPEAT
                    Rec_TransferLine.INIT;
                    Rec_TransferLine.VALIDATE("Document No.",Rec_TransferHead."No.");
                    IF j=0 THEN
                        Tline_no:=10000
                      ELSE
                        Tline_no:=(j+1)*10000;
                    Rec_TransferLine.VALIDATE("Line No.",Tline_no);
                    Rec_TransferLine.INSERT(TRUE);
        
                    Rec_TransferLine.RESET;
                    Rec_TransferLine.SETRANGE("Document No.",Rec_TransferHead."No.");
                    Rec_TransferLine.SETRANGE("Line No.",Tline_no);
                    IF Rec_TransferLine.FINDFIRST THEN BEGIN
                      Rec_TransferLine.VALIDATE("Item No.",RecEComInt."Item No");
                      Rec_TransferLine.VALIDATE(Quantity,RecEComInt.Quantity);
                      Rec_TransferLine.MODIFY;
                     // COMMIT;
                     END;
                     j+=1;
                    RecEComInt."Transfer Order Created"  :=TRUE;
                    RecEComInt.MODIFY;
                 UNTIL RecEComInt.NEXT=0;
                 Rec_TransferHead.VALIDATE(Rec_TransferHead."Shortcut Dimension 1 Code",'ECOMMERCE');
                 Rec_TransferHead.VALIDATE(Rec_TransferHead."Shortcut Dimension 2 Code",'ONLINE');
              END;
              MESSAGE('Transfer Order Created %1',Rec_TransferHead."No.");
              COMMIT;
        
        //WIN316//CREATE RESERVATION ENTRY FOR TRANSFER ORDER++
              RecTraLin.RESET;
              RecTraLin.SETRANGE("Document No.",Rec_TransferHead."No.");
              IF RecTraLin.FINDSET THEN BEGIN
                REPEAT
                  RecItem.RESET;
                  RecItem.SETRANGE("No.",RecTraLin."Item No.");
                  IF RecItem.FINDFIRST THEN BEGIN
                    IF RecItem."Item Tracking Code"='SNALL' THEN BEGIN
                       MESSAGE('transfer %1',RecItem."Item Tracking Code");
                       Create_Reservation_Entry_Transfer_Order(RecTraLin);
                       END;
                    END;
                UNTIL RecTraLin.NEXT=0;
              END;
        //WIN316//CREATE RESERVATION ENTRY FOR TRANSFER ORDER--
        
              TransferPost.RUN(Rec_TransferHead);
        
              PAYSECom.RESET;
              //PAYSECom.SETRANGE("Bill Phone No.","Store E-Commerce Order"."Bill Phone No.");//win316
              PAYSECom.SETFILTER("Order ID","Store E-Commerce Order"."Order ID");
              IF PAYSECom.FINDSET THEN BEGIN
                 REPEAT
                  PAYSECom."Transfer Order Posted":=TRUE;
                  PAYSECom.MODIFY;
                 UNTIL PAYSECom.NEXT=0;
                 COMMIT;
              END;
        
        //WIN316//reservation entry for Sales Invoice ++
              RecSH.RESET;
              RecSH.SETRANGE("Order ID","Store E-Commerce Order"."Order ID");
              IF RecSH.FINDFIRST THEN BEGIN
                  RecSL2.RESET;
                  RecSL2.SETRANGE("Document No.",RecSH."No.");
                  IF RecSL2.FINDSET THEN BEGIN
                    REPEAT
                    RecItem.RESET;
                    RecItem.SETRANGE("No.",RecSL2."No.");
                    IF RecItem.FINDFIRST THEN BEGIN
                      IF RecItem."Item Tracking Code"='SNALL' THEN BEGIN
                          MESSAGE('sales %1',RecItem."Item Tracking Code");
                          Create_Reservation_Entry_Sales_invoice(RecSL2);
                          END;
                      END;
                    UNTIL RecSL2.NEXT=0;
                    END;
              END;
        //WIN316//reservation entry for Sales Invoice --
        
        END;
        //1--
        RecEComInt.RESET;
        RecEComInt.SETRANGE("Order ID","Store E-Commerce Order"."Order ID");
        IF RecEComInt.FINDFIRST THEN BEGIN
            IF (RecEComInt."Transfer Order Posted"=FALSE) AND(RecEComInt."Transfer Order Created") THEN BEGIN
                 TransferHead.RESET;
                // TransferHead.SETRANGE(TransferHead."Transfer-to Code","Store E-Commerce Order"."E Com Location Code");
                 TransferHead.SETFILTER("ECom Order ID",'%1',"Store E-Commerce Order"."Order ID");
                 IF TransferHead.FINDFIRST THEN
                 REPEAT
                    //WIN316//CREATE RESERVATION ENTRY FOR TRANSFER ORDER++
                          RecTraLin.RESET;
                          RecTraLin.SETRANGE("Document No.",TransferHead."No.");
                          IF RecTraLin.FINDSET THEN BEGIN
                            REPEAT
                              RecItem.RESET;
                              RecItem.SETRANGE("No.",RecTraLin."Item No.");
                              IF RecItem.FINDFIRST THEN BEGIN
                                IF RecItem."Item Tracking Code"='SNALL' THEN BEGIN
                                   MESSAGE('transfer %1',RecItem."Item Tracking Code");
                                   Create_Reservation_Entry_Transfer_Order(RecTraLin);
                                   END;
                                END;
                            UNTIL RecTraLin.NEXT=0;
                          END;
                    //WIN316//CREATE RESERVATION ENTRY FOR TRANSFER ORDER--
                    TransferPost.RUN(TransferHead);
                    //WIN316//reservation entry for Sales Invoice ++
                          RecSH.RESET;
                          RecSH.SETRANGE("Order ID","Store E-Commerce Order"."Order ID");
                          IF RecSH.FINDFIRST THEN BEGIN
                              RecSL2.RESET;
                              RecSL2.SETRANGE("Document No.",RecSH."No.");
                              IF RecSL2.FINDSET THEN BEGIN
                                REPEAT
                                RecItem.RESET;
                                RecItem.SETRANGE("No.",RecSL2."No.");
                                IF RecItem.FINDFIRST THEN BEGIN
                                  IF RecItem."Item Tracking Code"='SNALL' THEN BEGIN
                                      MESSAGE('sales %1',RecItem."Item Tracking Code");
                                      Create_Reservation_Entry_Sales_invoice(RecSL2);
                                      END;
                                  END;
                                UNTIL RecSL2.NEXT=0;
                                END;
                          END;
                    //WIN316//reservation entry for Sales Invoice --
                 UNTIL TransferHead.NEXT=0;
                 MESSAGE('Transfer Order posted %1',Rec_TransferHead."No.");
        
                 PAYSECom.RESET;
                // PAYSECom.SETRANGE("Bill Phone No.","Store E-Commerce Order"."Bill Phone No.");//win316
                 PAYSECom.SETFILTER("Order ID","Store E-Commerce Order"."Order ID");
                   IF PAYSECom.FINDSET THEN
                     REPEAT
                     PAYSECom."Transfer Order Posted":=TRUE;
                     PAYSECom.MODIFY;
                     UNTIL PAYSECom.NEXT=0;
                     COMMIT;
            END;
        END;
        *///WIN234 05082020

    end;


    procedure Create_Reservation_Entry_Transfer_Order(RecTranLine: Record 5741)
    var
        Qty_1: Decimal;
        EntryNoL: Integer;
        Qty_ILE: Decimal;
        RecItem: Record 27;
        RecLocation: Record 14;
        RecILE: Record 32;
        INV: Decimal;
        INV1: Decimal;
        RecReservation_entry: Record 337;
        RecReservation_entry1: Record 337;
    begin
        /*
        RecReservation_entry.RESET;
        RecReservation_entry.SETRANGE("Source ID",RecTranLine."Document No.");
        RecReservation_entry.SETFILTER("Item No.",'%1',RecTranLine."Item No.");
        RecReservation_entry.SETFILTER("Source Ref. No.",'%1',RecTranLine."Line No.");
        IF RecReservation_entry.FINDSET THEN
           RecReservation_entry.DELETEALL;
        
        CLEAR(INV);
        RecILE.RESET;
        RecILE.SETFILTER(Open,'%1',TRUE);
        RecILE.SETFILTER("Item No.",'%1',RecTranLine."Item No.");
        RecILE.SETFILTER("Location Code",'%1',RecTranLine."Transfer-from Code");
        IF RecILE.FINDSET THEN BEGIN
            REPEAT
              INV+=RecILE."Remaining Quantity";
            UNTIL RecILE.NEXT=0;
        END;
        CLEAR(INV1);
        RecReservation_entry.RESET;
        RecReservation_entry.SETRANGE("Item No.",RecTranLine."Item No.");
        RecReservation_entry.SETFILTER("Location Code",'%1',RecTranLine."Transfer-from Code");
        RecReservation_entry.SETFILTER("Quantity (Base)",'<%1',0);
        //RecReservation_entry.SETFILTER(Positive,'%1',TRUE);
        //RecReservation_entry.SETFILTER("Reservation Status",'%1',RecReservation_entry."Reservation Status"::Reservation);
        IF RecReservation_entry.FINDSET THEN BEGIN
          REPEAT
          INV1+=ABS(RecReservation_entry."Quantity (Base)");
          UNTIL RecReservation_entry.NEXT=0;
        END;
        
        IF (INV-INV1)<RecTranLine.Quantity THEN BEGIN
          ERROR('Item No - %1 is short by %2 at location %3',RecTranLine."Item No.",(RecTranLine.Quantity-(INV-INV1)),RecTranLine."Transfer-from Code");
          EXIT;
        END;
        
        CLEAR(Qty_1);
        CLEAR(Qty_ILE);
        Qty_1:=RecTranLine.Quantity;
        
        RecILE.RESET;
        RecILE.SETRANGE("Item No.",RecTranLine."Item No.");
        RecILE.SETFILTER("Location Code",'%1',RecTranLine."Transfer-from Code");
        RecILE.SETFILTER(Open,'%1',TRUE);
        IF RecILE.FINDSET THEN BEGIN
          REPEAT
            //item tracking Serial Begin//*******
        
        
            IF (RecILE."Item Tracking"=RecILE."Item Tracking"::"Serial No.") THEN BEGIN
              RecReservation_entry1.RESET;
              RecReservation_entry1.SETRANGE("Serial No.",RecILE."Serial No.");
                IF NOT RecReservation_entry1.FINDFIRST THEN BEGIN
                    RecReservation_entry.RESET;
                    IF RecReservation_entry.FINDLAST THEN
                      EntryNoL := RecReservation_entry."Entry No." + 1
                    ELSE
                      EntryNoL := 1;
                    //for Transfer order
                    RecReservation_entry.RESET;
                    RecReservation_entry.INIT;
                    RecReservation_entry.VALIDATE(Positive,FALSE);
                    RecReservation_entry.VALIDATE("Entry No.",EntryNoL);
                    RecReservation_entry.VALIDATE("Item No.",RecTranLine."Item No.");
                    RecReservation_entry.VALIDATE("Location Code",RecTranLine."Transfer-from Code");
                    RecReservation_entry.VALIDATE("Quantity (Base)",(-1));
                    RecReservation_entry.VALIDATE("Reservation Status",RecReservation_entry."Reservation Status"::Surplus);
                    RecReservation_entry.VALIDATE("Creation Date",TODAY);
                    RecReservation_entry.VALIDATE("Source Type",5741);
                    RecReservation_entry.VALIDATE("Source Subtype",0);
                    RecReservation_entry.VALIDATE("Source ID",RecTranLine."Document No.");
                    RecReservation_entry.VALIDATE("Source Ref. No.",RecTranLine."Line No.");
                    RecReservation_entry.VALIDATE("Shipment Date",TODAY);
                   // RecReservation_entry.VALIDATE("Created By",USERID);
                    RecReservation_entry.VALIDATE("Planning Flexibility",RecReservation_entry."Planning Flexibility"::Unlimited);
                    IF RecILE."Serial No."<>'' THEN BEGIN
                        RecReservation_entry.VALIDATE("Serial No.",RecILE."Serial No.");
                        RecReservation_entry.VALIDATE("Item Tracking",RecReservation_entry."Item Tracking"::"Serial No.");
                    END;
                    RecReservation_entry.INSERT(TRUE);
        
                  //for ILE
                    RecReservation_entry.RESET;
                    RecReservation_entry.INIT;
                    RecReservation_entry.VALIDATE(Positive,TRUE);
                    RecReservation_entry.VALIDATE("Entry No.",(EntryNoL+1));
                    RecReservation_entry.VALIDATE("Item No.",RecTranLine."Item No.");
                    RecReservation_entry.VALIDATE("Location Code",RecTranLine."Transfer-to Code");
                    RecReservation_entry.VALIDATE("Quantity (Base)",(1));
                    RecReservation_entry.VALIDATE("Reservation Status",RecReservation_entry."Reservation Status"::Surplus);
                    RecReservation_entry.VALIDATE("Creation Date",TODAY);
                    RecReservation_entry.VALIDATE("Source Type",5741);
                    RecReservation_entry.VALIDATE("Source Subtype",1);
                    RecReservation_entry.VALIDATE("Source ID",RecTranLine."Document No.");
                    RecReservation_entry.VALIDATE("Source Ref. No.",RecTranLine."Line No.");
                    RecReservation_entry.VALIDATE("Expected Receipt Date",TODAY);
                  //  RecReservation_entry.VALIDATE("Created By",USERID);
                    RecReservation_entry.VALIDATE("Planning Flexibility",RecReservation_entry."Planning Flexibility"::Unlimited);
                    IF RecILE."Serial No."<>'' THEN BEGIN
                        RecReservation_entry.VALIDATE("Serial No.",RecILE."Serial No.");
                        RecReservation_entry.VALIDATE("Item Tracking",RecReservation_entry."Item Tracking"::"Serial No.");
                    END;
                    RecReservation_entry.INSERT(TRUE);
                    Qty_1:=Qty_1-1;
                  END;
               END;////item tracking Serial End
          RecILE.NEXT;
          UNTIL Qty_1=0
         END;
        //MESSAGE('done')
        *///WIN234 05082020

    end;


    procedure Create_Reservation_Entry_Sales_invoice(RecSL: Record 37)
    var
        Qty_1: Decimal;
        EntryNoL: Integer;
        Qty_ILE: Decimal;
        RecItem: Record 27;
        RecLocation: Record 14;
        RecILE: Record 32;
        INV: Decimal;
        INV1: Decimal;
        RecReservation_entry: Record 337;
        RecReservation_entry1: Record 337;
    begin
        /*
        RecReservation_entry.RESET;
        RecReservation_entry.SETRANGE("Source ID",RecSL."Document No.");
        RecReservation_entry.SETFILTER("Item No.",'%1',RecSL."No.");
        RecReservation_entry.SETFILTER("Source Ref. No.",'%1',RecSL."Line No.");
        IF RecReservation_entry.FINDSET THEN
           RecReservation_entry.DELETEALL;
        
        CLEAR(INV);
        RecILE.RESET;
        RecILE.SETFILTER(Open,'%1',TRUE);
        RecILE.SETFILTER("Item No.",'%1',RecSL."No.");
        RecILE.SETFILTER("Location Code",'%1',RecSL."Location Code");
        IF RecILE.FINDSET THEN BEGIN
            REPEAT
              INV+=RecILE."Remaining Quantity";
            UNTIL RecILE.NEXT=0;
        END;
        CLEAR(INV1);
        RecReservation_entry.RESET;
        RecReservation_entry.SETRANGE("Item No.",RecSL."No.");
        RecReservation_entry.SETFILTER("Location Code",'%1',RecSL."Location Code");
        RecReservation_entry.SETFILTER("Quantity (Base)",'<%1',0);
        //RecReservation_entry.SETFILTER(Positive,'%1',TRUE);
        //RecReservation_entry.SETFILTER("Reservation Status",'%1',RecReservation_entry."Reservation Status"::Reservation);
        IF RecReservation_entry.FINDSET THEN BEGIN
          REPEAT
          INV1+=ABS(RecReservation_entry."Quantity (Base)");
          UNTIL RecReservation_entry.NEXT=0;
        END;
        
        IF (INV-INV1)<RecSL.Quantity THEN BEGIN
          MESSAGE('Item No - %1 is short by %2 at location %3',RecSL."No.",(RecSL.Quantity-(INV-INV1)),RecSL."Location Code");
          EXIT;
        END;
        
        CLEAR(Qty_1);
        CLEAR(Qty_ILE);
        Qty_1:=RecSL.Quantity;
        
        RecILE.RESET;
        RecILE.SETRANGE("Item No.",RecSL."No.");
        RecILE.SETFILTER("Location Code",'%1',RecSL."Location Code");
        RecILE.SETFILTER(Open,'%1',TRUE);
        IF RecILE.FINDSET THEN BEGIN
          REPEAT
            //item tracking Serial Begin//*******
            IF (RecILE."Item Tracking"=RecILE."Item Tracking"::"Serial No.") THEN BEGIN
              RecReservation_entry1.RESET;
              RecReservation_entry1.SETRANGE("Serial No.",RecILE."Serial No.");
                IF NOT RecReservation_entry1.FINDFIRST THEN BEGIN
                    RecReservation_entry.RESET;
                    IF RecReservation_entry.FINDLAST THEN
                      EntryNoL := RecReservation_entry."Entry No." + 1
                    ELSE
                      EntryNoL := 1;
                    //for Sales order
                    RecReservation_entry.RESET;
                    RecReservation_entry.INIT;
                    RecReservation_entry.VALIDATE(Positive,FALSE);
                    RecReservation_entry.VALIDATE("Entry No.",EntryNoL);
                    RecReservation_entry.VALIDATE("Item No.",RecSL."No.");
                    RecReservation_entry.VALIDATE("Location Code",RecSL."Location Code");
                    RecReservation_entry.VALIDATE("Quantity (Base)",(-1));
                    RecReservation_entry.VALIDATE("Reservation Status",RecReservation_entry."Reservation Status"::Prospect);
                    RecReservation_entry.VALIDATE("Creation Date",TODAY);
                    RecReservation_entry.VALIDATE("Source Type",37);
                    RecReservation_entry.VALIDATE("Source Subtype",2);
                    RecReservation_entry.VALIDATE("Source ID",RecSL."Document No.");
                    RecReservation_entry.VALIDATE("Source Ref. No.",RecSL."Line No.");
                    RecReservation_entry.VALIDATE("Shipment Date",TODAY);
                   // RecReservation_entry.VALIDATE("Created By",USERID);
                    RecReservation_entry.VALIDATE("Planning Flexibility",RecReservation_entry."Planning Flexibility"::Unlimited);
                    IF RecILE."Serial No."<>'' THEN BEGIN
                        RecReservation_entry.VALIDATE("Serial No.",RecILE."Serial No.");
                        RecReservation_entry.VALIDATE("Item Tracking",RecReservation_entry."Item Tracking"::"Serial No.");
                    END;
                    RecReservation_entry.INSERT(TRUE);
                    Qty_1:=Qty_1-1;
                  END;
               END;////item tracking Serial End
          RecILE.NEXT;
          UNTIL Qty_1=0
         END;
        //MESSAGE('done')
        *///WIN234 05082020

    end;

    local procedure Create_Return_Order()
    var
        RecSIH: Record 112;
    begin
        /*
        IF NOT "Store E-Commerce Order1"."Return Order Posted" THEN BEGIN
            RecSIH.RESET;
            RecSIH.SETRANGE("Order ID","Store E-Commerce Order1"."Order ID");
            IF RecSIH.FINDFIRST THEN
            REPORT.EXECUTE(50066,'<?xml version="1.0" standalone="yes"?>'+
            '<ReportParameters name="Copy Sales Document1" id="50066">'+
            '<Options><Field name="DocType">7</Field><Field name="DocNo">'+ RecSIH."No." +'</Field>'+
            '</Options></ReportParameters>')
            ELSE ERROR('Order Not available - %1',"Store E-Commerce Order1"."Order ID");
        
            RecEComOrder.RESET;
            RecEComOrder.SETRANGE("Order ID","Store E-Commerce Order1"."Order ID");
            IF RecEComOrder.FINDSET THEN BEGIN
               REPEAT
                 RecEComOrder."Return Order Posted":=TRUE;
                 RecEComOrder.MODIFY;
               UNTIL RecEComOrder.NEXT=0;
            END;
            MESSAGE('Sales Credit Memo Posted');
        END;
        *///WIN234 05082020

    end;

    [Scope('Internal')]
    procedure ReturnTransferOrder()
    begin
        /*
        //1++
        IF NOT "Store E-Commerce Order1"."Return Transfer Order Created" THEN BEGIN
              Rec_TransferHead.RESET;
              Rec_TransferHead.INIT;
              InvSetup.GET;
              Rec_TransferHead."No.":=NoSeriesMgt.GetNextNo(InvSetup."Transfer Order Nos.",0D,TRUE);
              Rec_TransferHead."Transfer-from Code":="Store E-Commerce Order1"."E Com Location Code";
              Rec_TransferHead."Transfer-to Code":="Store E-Commerce Order1"."Location Code";
              Rec_TransferHead."In-Transit Code":="Store E-Commerce Order1"."In Transit Location";
              Rec_TransferHead.VALIDATE(Rec_TransferHead.Structure,'GST');
              Rec_TransferHead."Posting Date":=TODAY;
              Rec_TransferHead."Shipment Date":=TODAY;
              Rec_TransferHead."Receipt Date":=TODAY;
              Rec_TransferHead."ECom Order ID":="Store E-Commerce Order1"."Order ID";
              Rec_TransferHead.INSERT;
        
              RecEComInt.RESET;
              RecEComInt.SETRANGE(RecEComInt."Order ID",PrevCRM1);
              IF RecEComInt.FINDSET THEN BEGIN
                 REPEAT
                    Rec_TransferLine.INIT;
                    Rec_TransferLine.VALIDATE("Document No.",Rec_TransferHead."No.");
                    IF j=0 THEN
                        Tline_no:=10000
                      ELSE
                        Tline_no:=(j+1)*10000;
                    Rec_TransferLine.VALIDATE("Line No.",Tline_no);
                    Rec_TransferLine.INSERT(TRUE);
        
                    Rec_TransferLine.RESET;
                    Rec_TransferLine.SETRANGE("Document No.",Rec_TransferHead."No.");
                    Rec_TransferLine.SETRANGE("Line No.",Tline_no);
                    IF Rec_TransferLine.FINDFIRST THEN BEGIN
                      Rec_TransferLine.VALIDATE("Item No.",RecEComInt."Item No");
                      Rec_TransferLine.VALIDATE(Quantity,RecEComInt.Quantity);
                      Rec_TransferLine.MODIFY;
                     // COMMIT;
                     END;
                     j+=1;
                    RecEComInt."Return Transfer Order Created"  :=TRUE;
                    RecEComInt.MODIFY;
                 UNTIL RecEComInt.NEXT=0;
                 Rec_TransferHead.VALIDATE(Rec_TransferHead."Shortcut Dimension 1 Code",'BANDRA');
                 Rec_TransferHead.VALIDATE(Rec_TransferHead."Shortcut Dimension 2 Code",'B2BSALE');
              END;
              MESSAGE('Return Transfer Order Created %1',Rec_TransferHead."No.");
              COMMIT;
        
        //WIN316//CREATE RESERVATION ENTRY FOR TRANSFER ORDER++
              RecTraLin.RESET;
              RecTraLin.SETRANGE("Document No.",Rec_TransferHead."No.");
              IF RecTraLin.FINDSET THEN BEGIN
                REPEAT
                  RecItem.RESET;
                  RecItem.SETRANGE("No.",RecTraLin."Item No.");
                  IF RecItem.FINDFIRST THEN BEGIN
                    IF RecItem."Item Tracking Code"='SNALL' THEN BEGIN
                       MESSAGE('transfer %1',RecItem."Item Tracking Code");
                       Create_Reservation_Entry_Transfer_Order(RecTraLin);
                       END;
                    END;
                UNTIL RecTraLin.NEXT=0;
              END;
        //WIN316//CREATE RESERVATION ENTRY FOR TRANSFER ORDER--
        
              TransferPost.RUN(Rec_TransferHead);
        
               PAYSECom.RESET;
               PAYSECom.SETRANGE("Bill Phone No.","Store E-Commerce Order1"."Bill Phone No.");//win316
               PAYSECom.SETFILTER("Order ID","Store E-Commerce Order1"."Order ID");
                 IF PAYSECom.FINDSET THEN
                   REPEAT
                   PAYSECom."Return Transfer Order Posted":=TRUE;
                   PAYSECom.MODIFY;
                   UNTIL PAYSECom.NEXT=0;
                   COMMIT;
                   MESSAGE('Return Transfer Order posted %1',Rec_TransferHead."No.");
                   //RETURN PAYMENT POST++
                   PostReturnPayment('',"Store E-Commerce Order1"."Order ID");
                   //RETURN PAYMENT POST--
        END;
        //1--
        RecEComInt.RESET;
        RecEComInt.SETRANGE("Order ID","Store E-Commerce Order"."Order ID");
        IF RecEComInt.FINDFIRST THEN BEGIN
            IF (RecEComInt."Return Transfer Order Posted"=FALSE) AND(RecEComInt."Return Transfer Order Created") THEN BEGIN
                 TransferHead.RESET;
                 TransferHead.SETRANGE(TransferHead."Transfer-to Code","Store E-Commerce Order1"."Location Code");
                 TransferHead.SETFILTER("ECom Order ID",'%1',"Store E-Commerce Order1"."Order ID");
                 IF TransferHead.FINDFIRST THEN
                 REPEAT
                    //WIN316//CREATE RESERVATION ENTRY FOR TRANSFER ORDER++
                          RecTraLin.RESET;
                          RecTraLin.SETRANGE("Document No.",TransferHead."No.");
                          IF RecTraLin.FINDSET THEN BEGIN
                            REPEAT
                              RecItem.RESET;
                              RecItem.SETRANGE("No.",RecTraLin."Item No.");
                              IF RecItem.FINDFIRST THEN BEGIN
                                IF RecItem."Item Tracking Code"='SNALL' THEN BEGIN
                                   MESSAGE('transfer %1',RecItem."Item Tracking Code");
                                   Create_Reservation_Entry_Transfer_Order(RecTraLin);
                                   END;
                                END;
                            UNTIL RecTraLin.NEXT=0;
                          END;
                    //WIN316//CREATE RESERVATION ENTRY FOR TRANSFER ORDER--
                    TransferPost.RUN(TransferHead);
                 MESSAGE('Return Transfer Order posted %1',Rec_TransferHead."No.");
                 UNTIL TransferHead.NEXT=0;
        
        
                 PAYSECom.RESET;
                 PAYSECom.SETRANGE("Bill Phone No.","Store E-Commerce Order"."Bill Phone No.");//win316
                 PAYSECom.SETFILTER("Order ID","Store E-Commerce Order"."Order ID");
                   IF PAYSECom.FINDSET THEN
                     REPEAT
                     PAYSECom."Return Transfer Order Posted":=TRUE;
                     PAYSECom.MODIFY;
                     UNTIL PAYSECom.NEXT=0;
                     COMMIT;
            END;
        END;
        *///WIN234 05082020

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

    [Scope('Internal')]
    procedure PostReturnPayment(OrderNo: Code[20]; OrderId: Code[20])
    begin
        /*
        IF NOT "Store E-Commerce Order1"."Return Payment Created" THEN BEGIN
              RecCust.RESET;
              RecCust.SETRANGE(RecCust."Phone No.","Store E-Commerce Order1"."Bill Phone No.");
              //2++
              IF RecCust.FINDFIRST THEN BEGIN
                 RecSalesCrMemo.RESET;
                 RecSalesCrMemo.SETRANGE("Order ID",OrderId);
                 IF RecSalesCrMemo.FINDFIRST THEN;
                 RecSalesCrMemo.CALCFIELDS(RecSalesCrMemo."Amount to Customer");
                 IF RecSalesCrMemo."Amount to Customer"<>0 THEN BEGIN
                    RecGenJnlLine.RESET;
                    RecGenJnlLine.SETRANGE(RecGenJnlLine."Journal Template Name",'GENERAL1');
                    RecGenJnlLine.SETRANGE(RecGenJnlLine."Journal Batch Name",'DEFAULT');
                    IF RecGenJnlLine.FINDLAST THEN
                        LineNo1 := RecGenJnlLine."Line No." + 10000
                    ELSE
                        LineNo1 := 10000;
                    RecGenJnlLine.INIT;
                    RecGenJnlLine."Journal Template Name":='GENERAL1';
                    RecGenJnlLine."Journal Batch Name":='DEFAULT';
                    RecGenJnlLine."Line No." :=LineNo1;
                    RecGenJnlLine."Posting Date" := TODAY;
                    RecGenJnlLine."Document Date" :=TODAY;
                    RecGenJnlLine."Account Type" := RecGenJnlLine."Account Type"::"G/L Account";
                    RecGenJnlLine.VALIDATE("Account No.","Store E-Commerce Order1"."G/L Account No");
                    RecGenJnlLine.VALIDATE("Document Type",RecGenJnlLine."Document Type"::Refund);
                    SRsetup.GET;
                    DoucNo:=NoSeriesMgt.GetNextNo(SRsetup."ECOM Payment No.",WORKDATE,TRUE);
                    RecGenJnlLine."Document No." :=DoucNo;
                    RecGenJnlLine."Bal. Account Type" := RecGenJnlLine."Bal. Account Type"::Customer;
                    RecGenJnlLine."Bal. Account No.":=RecCust."No.";
                    RecGenJnlLine."Location Code" :="Store E-Commerce Order1"."E Com Location Code";
                    RecGenJnlLine.Amount:=RecSalesCrMemo."Amount to Customer"*-1;
                    RecGenJnlLine."Amount (LCY)" :=RecSalesCrMemo."Amount to Customer"*-1;
                    RecGenJnlLine.VALIDATE("Shortcut Dimension 1 Code",RecSalesCrMemo."Shortcut Dimension 1 Code");
                    RecGenJnlLine.VALIDATE("Shortcut Dimension 2 Code",RecSalesCrMemo."Shortcut Dimension 2 Code");
                    RecGenJnlLine."Order ID":="Store E-Commerce Order1"."Order ID";
        
                    //For Application++
                    RecGenJnlLine.VALIDATE("Applies-to Doc. Type",RecGenJnlLine."Applies-to Doc. Type"::"Credit Memo");
                    RecGenJnlLine.VALIDATE("Applies-to Doc. No.",RecSalesCrMemo."No.");
                    //For Application--
                    MESSAGE('Return Payment Created');
                    IF RecGenJnlLine.INSERT(TRUE) THEN;
                    //POST PAYMENT
                    CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",RecGenJnlLine);
                    MESSAGE('Payment posted for order no - %1',"Store E-Commerce Order1"."Order ID");
                    END;
                    PAYSECom.RESET;
                    PAYSECom.SETFILTER("Order ID",OrderId);
                    IF PAYSECom.FINDSET THEN
                        REPEAT
                          PAYSECom."Return Payment Created":=TRUE;
                          PAYSECom."Return Payment Posted":=TRUE;
                          PAYSECom.MODIFY;
                        UNTIL PAYSECom.NEXT=0;
                        COMMIT;
        
              END;
              //2--
              //3++
              IF NOT "Store E-Commerce Order1"."Payment Posted" THEN
                BEGIN
                  PAYSECom.RESET;
                  PAYSECom.SETRANGE("Bill Phone No.","Store E-Commerce Order1"."Bill Phone No.");//win316
                  PAYSECom.SETRANGE("Order ID",OrderId);
                    IF PAYSECom.FINDSET THEN
                      REPEAT
                        PAYSECom."Return Payment Posted":=TRUE;
                        PAYSECom.MODIFY;
                      UNTIL PAYSECom.NEXT=0;
                END;
              //3--
        END;
        
         *///WIN234 05082020

    end;
}

