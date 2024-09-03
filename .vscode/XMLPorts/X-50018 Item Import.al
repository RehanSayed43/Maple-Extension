xmlport 50018 "Item Import"
{
    Direction = Import;
    // Encoding = UTF8; rahul
    Format = VariableText;
    FormatEvaluate = Legacy;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(root)
        {
            tableelement(Item; Item)
            {
                AutoSave = false;
                XmlName = 'Items';
                UseTemporary = true;
                textelement(NewNo)
                {
                    MinOccurs = Zero;
                }
                textelement(OLDNo)
                {
                    MinOccurs = Zero;
                }
                textelement(Description)
                {
                    MinOccurs = Zero;
                }
                textelement(VendorPartCode)
                {
                    MinOccurs = Zero;
                }
                textelement(Brand)
                {
                    MinOccurs = Zero;
                }
                textelement(Category)
                {
                    MinOccurs = Zero;
                }
                textelement(Primarycategory)
                {
                    MinOccurs = Zero;
                }
                textelement(Secondarycategory)
                {
                    MinOccurs = Zero;
                }
                textelement(Thirdcategory)
                {
                    MinOccurs = Zero;
                }
                textelement(GSTGroupCode)
                {
                    MinOccurs = Zero;
                }
                textelement(HSNSACCode)
                {
                    MinOccurs = Zero;
                }
                textelement(GSTCredit)
                {
                    MinOccurs = Zero;



                }

                textelement(SubstitutesExist)
                {
                    MinOccurs = Zero;
                }
                textelement(AssemblyBOM)
                {
                    MinOccurs = Zero;
                }
                textelement(ProductionBOMNo)
                {
                    MinOccurs = Zero;
                }
                textelement(BaseUnitofMeasure)
                {
                    MinOccurs = Zero;
                }
                textelement(Grade)
                {
                    MinOccurs = Zero;
                }
                textelement(CostisAdjusted)
                {
                    MinOccurs = Zero;
                }
                textelement(UnitCost)
                {
                    MinOccurs = Zero;
                }
                textelement(UnitPrice)
                {
                    MinOccurs = Zero;
                }
                textelement(VendorNo)
                {
                    MinOccurs = Zero;
                }
                textelement(SearchDescription)
                {
                    MinOccurs = Zero;
                }
                textelement(ItemTrackingCode)
                {
                    MinOccurs = Zero;
                }
                textelement(TaxGroupCode)
                {
                    MinOccurs = Zero;
                }
                textelement(DefaultDeferralTemplate)
                {
                    MinOccurs = Zero;
                }
                textelement(AssemblyPolicy)
                {
                    MinOccurs = Zero;
                }
                textelement(Blocked)
                {
                    MinOccurs = Zero;
                }
                textelement(CostingMethod)
                {
                    MinOccurs = Zero;
                }
                textelement(CreatedFromNonstockItem)
                {
                    MinOccurs = Zero;
                }
                textelement(FlushingMethod)
                {
                    MinOccurs = Zero;
                }
                textelement(GenProdPostingGroup)
                {
                    MinOccurs = Zero;
                }
                textelement(IndirectCostPer)
                {
                    MinOccurs = Zero;
                }
                textelement(InventoryPostingGroup)
                {
                    MinOccurs = Zero;
                }
                textelement(ItemDiscGroup)
                {
                    MinOccurs = Zero;
                }
                textelement(LastDateModified)
                {
                    MinOccurs = Zero;
                }
                textelement(LastDirectCost)
                {
                    MinOccurs = Zero;
                }
                textelement(LeadTimeCalculation)
                {
                    MinOccurs = Zero;
                }
                textelement(ManufacturingPolicy)
                {
                    MinOccurs = Zero;
                }
                textelement(OverheadRate)
                {
                    MinOccurs = Zero;
                }
                textelement(PriceProfitCalculation)
                {
                    MinOccurs = Zero;
                }
                textelement(Profit)
                {
                    MinOccurs = Zero;
                }
                textelement(PurchUnitofMeasure)
                {
                    MinOccurs = Zero;
                }
                textelement(ReplenishmentSystem)
                {
                    MinOccurs = Zero;
                }
                textelement(SalesUnitofMeasure)
                {
                    MinOccurs = zero;

                    trigger OnAfterAssignVariable()
                    begin
                        /*if UpperCase(CostingMethod) = 'FIFO' then
                            CostingMethod1 := 1
                        else
                            if UpperCase(CostingMethod) = 'LIFO' then
                                CostingMethod1 := 2
                            else
                                if UpperCase(CostingMethod) = 'Specific' then
                                    CostingMethod1 := 3
                                else
                                    if UpperCase(CostingMethod) = 'Average' then
                                        CostingMethod1 := 4
                                    else
                                        if UpperCase(CostingMethod) = 'Standard' then
                                            CostingMethod1 := 5;*/

                        // //CostingMethod1 := 0;;
                        /*if UpperCase(GSTCredit) = 'Availment' then
                            GSTCreditint := 1
                        else
                            if UpperCase(GSTCredit) = 'Non-Availment' then
                                GSTCreditint := 2;*/
                        // else
                        //     GSTCreditint := 0;
                        //  ;
                        RecItem.INIT;
                        RecItem."No." := NewNo;
                        RecItem."Old Item No" := OLDNo;
                        RecItem.Description := Description;
                        //RecItem.Validate(Description, descrption1);
                        RecItem."Vendor Part Code Long" := VendorPartCode;
                        RecItem."Item Category Code" := Brand;
                        RecItem."Product Category" := Category;  //rahul
                        RecItem."Primary category" := Primarycategory;
                        RecItem."Secondary category" := Secondarycategory;
                        RecItem."Third category" := Thirdcategory;
                        RecItem.Validate("GST Group Code", GSTGroupCode);
                        RecItem.validate("HSN/SAC Code", HSNSACCode);
                        if GSTCredit <> '' then begin
                            EVALUATE(GSTCreditNew, GSTCredit);
                            RecItem.validate(RecItem."GST Credit", GSTCreditNew);
                        end;


                        ItemUnitofMeasure.INIT;
                        ItemUnitofMeasure."Item No." := NewNo;
                        if BaseUnitofMeasure <> '' then
                            Evaluate(BUOM, BaseUnitofMeasure);
                        ItemUnitofMeasure.Code := BUOM;
                        ItemUnitofMeasure."Qty. per Unit of Measure" := 1;
                        IF NOT ItemUnitofMeasure.INSERT THEN
                            ItemUnitofMeasure.MODIFY;
                        RecItem.VALIDATE("Base Unit of Measure", BUOM);
                        If UnitCost <> '' then begin
                            EVALUATE(RecItem."Unit Cost", UnitCost);
                        end;
                        if UnitPrice <> '' then begin
                            EVALUATE(RecItem."Unit Price", UnitPrice);
                        end;
                        RecItem."Vendor No." := VendorNo;
                        RecItem.Validate("Search Description", descrption1);
                        RecItem."Search Description" := SearchDescription;
                        RecItem."Item Tracking Code" := ItemTrackingCode;
                        RecItem."Tax Group Code" := TaxGroupCode;
                        EVALUATE(RecItem.Blocked, Blocked);
                        if CostingMethod <> '' then begin
                            Evaluate(CostMethodNew, CostingMethod);
                            RecItem.Validate("Costing Method", CostMethodNew);
                        end;


                        RecItem."Gen. Prod. Posting Group" := GenProdPostingGroup;
                        EVALUATE(RecItem."Indirect Cost %", IndirectCostPer);
                        RecItem."Inventory Posting Group" := InventoryPostingGroup;
                        RecItem."Item Disc. Group" := ItemDiscGroup;
                        If LeadTimeCalculation <> '' then begin
                            EVALUATE(LeadTimeCalculation1, LeadTimeCalculation);
                            RecItem.Validate("Lead Time Calculation", LeadTimeCalculation1);
                        end;
                        If OverheadRate <> '' then begin
                            EVALUATE(OverheadRate1, OverheadRate);
                            RecItem.Validate("Overhead Rate", OverheadRate1);
                        end;

                        If Profit <> '' then begin
                            EVALUATE(Profit1, Profit);
                            RecItem.Validate("Profit %", Profit1);
                        end;

                        RecItem.VALIDATE("Purch. Unit of Measure", PurchUnitofMeasure);
                        RecItem.VALIDATE("Sales Unit of Measure", SalesUnitofMeasure);
                        IF StandardCost <> '' THEN begin
                            EVALUATE(StandardCost1, StandardCost);
                            RecItem.Validate("Standard Cost", StandardCost1);
                        end;
                        IF VendorItemNo <> '' THEN
                            RecItem."Vendor Item No." := VendorItemNo;


                        IF NOT RecItem.INSERT THEN
                            RecItem.MODIFY;

                        //clearVars;
                    end;
                }
                textelement(ShelfNo)
                {
                    MinOccurs = Zero;
                }
                textelement(StandardCost)
                {
                    MinOccurs = Zero;
                }
                textelement(StockkeepingUnitExists)
                {
                    MinOccurs = Zero;
                }
                textelement(TariffNo)
                {
                    MinOccurs = Zero;
                }
                textelement(VATProdPostingGroup)
                {
                    MinOccurs = Zero;
                }
                textelement(VendorItemNo)
                {
                    MinOccurs = Zero;
                }

                // trigger OnAfterInsertRecord()
                // begin
                //     if UpperCase(GSTCredit) = 'Availment' then
                //         GSTCreditint := 1
                //     else
                //         if UpperCase(GSTCredit) = 'Non-Availment' then
                //             GSTCreditint := 2;
                //     // else
                //     //     GSTCreditint := 0;
                //     ;
                //     RecITEM1.Reset();
                //     RecITEM1.SetRange("No.", RecItem."No.");
                //     if RecItem1.FindFirst() then begin
                //         //tk
                //         if GSTCredit <> '' then
                //             RecItem1.validate("GST Credit", GSTCreditint);
                //         RecITEM1.Modify();
                //         //tk

                //     end;
                //end;
            }
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
    procedure clearVars()
    begin

        // CostingMethod1 := 0;
        //GSTCredit1 := 0;
    ENd;

    var
        RecItem: Record "Item";
        ItemUnitofMeasure: Record "Item Unit of Measure";
        BUOM: Code[20];
        descrption1: text[100];
        CostingMethod1: Integer;
        GSTCreditint: Integer;
        RecITEM1: Record item;
        CostMethodNew: Option "FIFO","LIFO","Specific","Average","Standard";
        LeadTimeCalculation1: DateFormula;
        Profit1: Decimal;
        OverheadRate1: Decimal;
        StandardCost1: Decimal;
        GSTCreditNew: Option ,"Availment","Non-Availment";

}

