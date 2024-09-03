codeunit 50004 "Order Management_Web"
{

    trigger OnRun()
    begin
        //test              WSO/000041


        //"Credit Card Charges"('SI/GMKKA/0612/00008','1102260',16568.54,5000,TRUE);
        //MESSAGE('Applied!');
        //CalculateDiscount('SI/GMHMU/0612/00009',3)
    end;

    var
        LineNo: Integer;
        salesLine: Record "Sales Line";//"37";
        IntCount: Integer;
        IntLine: Integer;
        SalesLine2: Record "Sales Line";//"37";
        SalesLine3: Record "Sales Line";//"37";
        SalesHeaderGt: Record "Sales Header";//"36";
        GTSalesHeader: Record "Sales Header";//"36";
        GTSalesHeader1: Record "Sales Header";//"36";
        TotInvDisc: Decimal;
        SalesSetup: Record "Sales & Receivables Setup";//"311";

    [Scope('Internal')]
    procedure GetFreeItem(DocNo: Code[20])
    begin
        //----001----------------------->
        /*
        SalesHeaderGt.SETRANGE(SalesHeaderGt."No.",DocNo);
        IF SalesHeaderGt.FINDFIRST THEN
        
        salesLine.RESET;
        salesLine.SETRANGE(salesLine."Document No.", DocNo);
        IF salesLine.FINDLAST THEN
        IntLine := salesLine."Line No.";
        
        salesLine.RESET;
        salesLine.SETRANGE(salesLine."Document No.",DocNo);
        IF salesLine.FINDSET THEN
        REPEAT
          FreeItemHeader.RESET;
          FreeItemLine.RESET;
          FreeItemHeader.SETFILTER(FreeItemHeader."Item No",'%1',salesLine."No.");
            IF FreeItemHeader.FINDFIRST THEN
              BEGIN
                FreeItemLine.SETRANGE(FreeItemLine."Entry Code",FreeItemHeader."Entry No");
                IF FreeItemLine.FINDSET THEN
                  SalesLine3.RESET;
                  SalesLine3.SETRANGE(SalesLine3."Document No.",DocNo);
                  REPEAT
                    IF SalesLine3.FINDLAST THEN
        //              SalesLine3.INIT;
                      SalesLine3."Line No.":=SalesLine3."Line No."+10000;
                      SalesLine3.Type := SalesLine3.Type::Item;
                      SalesLine3."Sell-to Customer No." := SalesHeaderGt."Sell-to Customer No.";
                      //SalesHeaderGt.VALIDATE(SalesHeaderGt."Sell-to Customer No.");
                      SalesLine3."No." := FreeItemLine."Free Item No";
                      SalesLine3.Description := FreeItemLine."Free Item Description";
                      SalesLine3."Unit of Measure Code" := FreeItemHeader.UOM;
        //              SalesLine3."Location Code" := SalesHeaderGt."Location Code";
                      SalesLine3.Quantity := FreeItemLine."Free Item Qty";
                      SalesLine3."Unit Price" := FreeItemLine."Free Item Unit Price";
                      //ADD A.S 05-04.2012 to deduct the free item value from the sales Invocie
                      SalesLine3."Line Discount %" := 100;
                      SalesLine3.VALIDATE(SalesLine3."Line Discount %");
                      //ADD A.S 05-04.2012 to deduct the free item value from the sales Invocie
                      SalesLine3.INSERT(FALSE);
                  UNTIL FreeItemLine.NEXT = 0;
              END
          UNTIL salesLine.NEXT = 0;
        //-------------001------------------------->
        */

    end;

    [Scope('Internal')]
    procedure SalesOrderPostWeb(DocNo: Code[20])
    var
        RecSalesHdr: Record "Sales Header";//"36";
    begin
        RecSalesHdr.RESET;
        RecSalesHdr.SETRANGE(RecSalesHdr."No.", DocNo);
        IF RecSalesHdr.FINDFIRST THEN
            CODEUNIT.RUN(CODEUNIT::"Sales-Post (Yes/No)", RecSalesHdr);
    end;

    [Scope('Internal')]
    procedure CalculateDiscount(DocNo: Code[20]; DiscountPercent: Decimal)
    begin
        //----001----------------------->
        SalesHeaderGt.SETRANGE(SalesHeaderGt."No.", DocNo);
        IF SalesHeaderGt.FINDFIRST THEN BEGIN
            //SalesHeaderGt.Discount:=DiscountPercent;
            //SalesHeaderGt.VALIDATE(SalesHeaderGt.Discount);

            /*
            salesLine.RESET;
            salesLine.SETRANGE(salesLine."Document No.", DocNo);
            IF salesLine.FINDSET THEN BEGIN

            TotInvDisc:=salesLine.DistributeDiscount(DocNo,DiscountPercent);
            SalesHeaderGt."Invoice Discount Value":=TotInvDisc;
            salesLine.VALIDATE(salesLine."Line Discount %");
             */

            //CALCFIELDS(SalesHeaderGt."Price Inclusive of Taxes");

            //CCIT_kj+++
            /* SalesHeaderGt.CALCFIELDS(SalesHeaderGt."Price Inclusive of Taxes");
            IF SalesSetup."Calc. Inv. Discount" AND (NOT SalesHeaderGt."Price Inclusive of Taxes") THEN BEGIN
                SalesHeaderGt.CalcInvDiscForHeader;
                COMMIT
            END;


            IF SalesHeaderGt."Price Inclusive of Taxes" THEN BEGIN
                salesLine.InitStrOrdDetail(SalesHeaderGt);
                salesLine.GetSalesPriceExclusiveTaxes(SalesHeaderGt);
                salesLine.UpdateSalesLinesPIT(SalesHeaderGt);
                COMMIT;
            END;

            IF SalesHeaderGt.Structure <> '' THEN BEGIN
                salesLine.CalculateStructures(SalesHeaderGt);
                salesLine.AdjustStructureAmounts(SalesHeaderGt);
                salesLine.UpdateSalesLines(SalesHeaderGt);
                salesLine.CalculateTCS(SalesHeaderGt);
                COMMIT;
            END ELSE BEGIN
                salesLine.CalculateTCS(SalesHeaderGt);
                COMMIT;
            END;*/
            //CCIT_kj-----


            MESSAGE('ok');




        END;

    end;
}

