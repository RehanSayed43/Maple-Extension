codeunit 50003 "WS Get Item SalesPrice"
{

    trigger OnRun()
    begin

        //MESSAGE('%1',ReturnPrice('3DSMAXDCVUG','DL00001','DL01','NOS',WORKDATE))
    end;

    [Scope('Internal')]
    procedure ReturnPrice(ItemNo: Code[20]; CustomerNo: Code[20]; LocationCode: Code[20]; UOM: Code[20]; OnDate: Date) PricePerUnit: Decimal
    var
        //TempSalesL: Record "37" temporary;
        TempSalesL: Record "Sales Line" temporary;
        //  TempSalesH: Record "36" temporary;
        TempSalesH: Record "Sales Header" temporary;
        //PriceCalcMgt: Codeunit "7000";
        PriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
    begin
        TempSalesH.INIT;
        TempSalesH."No." := 'OOO';
        TempSalesH."Order Date" := OnDate;
        TempSalesH."Posting Date" := OnDate;
        TempSalesH."Document Date" := OnDate;
        TempSalesH.VALIDATE(TempSalesH."Sell-to Customer No.", CustomerNo);
        TempSalesH."Location Code" := LocationCode;
        TempSalesH.INSERT;

        TempSalesL.INIT;
        TempSalesL."Document No." := 'OOO';
        TempSalesL.Type := TempSalesL.Type::Item;
        TempSalesL."No." := ItemNo;
        TempSalesL."Location Code" := LocationCode;
        TempSalesL."Unit of Measure Code" := UOM;
        TempSalesL.INSERT;
        PriceCalcMgt.FindSalesLinePrice(TempSalesH, TempSalesL, 6);
        PricePerUnit := TempSalesL."Unit Price";
        EXIT(PricePerUnit);
    end;
}

