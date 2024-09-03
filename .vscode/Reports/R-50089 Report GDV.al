report 50089 ReportGDV
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportGDV.rdl';
    ApplicationArea = FixedAsset;

    dataset
    {
        dataitem(Location; Location)
        {
            DataItemTableView = WHERE("Location Type" = FILTER(Saleable));
            column(Code_Location; Location.Code)
            {
            }
            dataitem(Item; Item)
            {
                column(No_Item; Item."Vendor Part Code Long")
                {
                }
                column(salesqty; SalesQty)
                {
                }
                column(reqty; retQty)
                {
                }
                column(qtyRem; qtyRem)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SalesQty := 0;
                    retQty := 0;
                    qtyRem := 0;

                    ILE.RESET;
                    ILE.SETFILTER(ILE."Entry Type", '%1', ILE."Entry Type"::Sale);
                    ILE.SETFILTER(ILE.Quantity, '<%1', 0);
                    ILE.SETFILTER(ILE."Item No.", Item."No.");
                    ILE.SETRANGE(ILE."Posting Date", StDate, EnDate);
                    ILE.SETFILTER(ILE."Location Code", Location.Code);

                    IF ILE.FINDSET THEN
                        REPEAT
                            SalesQty += ILE.Quantity;
                        UNTIL ILE.NEXT = 0;

                    ILE.RESET;
                    ILE.SETFILTER(ILE."Entry Type", '%1', ILE."Entry Type"::Sale);
                    ILE.SETFILTER(ILE.Quantity, '>%1', 0);
                    ILE.SETFILTER(ILE."Item No.", Item."No.");
                    ILE.SETRANGE(ILE."Posting Date", StDate, EnDate);
                    ILE.SETFILTER(ILE."Location Code", Location.Code);

                    IF ILE.FINDSET THEN
                        REPEAT
                            retQty += ILE.Quantity;
                        UNTIL ILE.NEXT = 0;

                    ILE.RESET;
                    ILE.SETFILTER(ILE."Item No.", Item."No.");
                    ILE.SETRANGE(ILE."Posting Date", 0D, EnDate);
                    ILE.SETFILTER(ILE."Location Code", Location.Code);

                    IF ILE.FINDSET THEN
                        REPEAT
                            qtyRem += ILE."Remaining Quantity";
                        UNTIL ILE.NEXT = 0;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {

                field("Start Date"; StDate)
                {
                    ApplicationArea = All;
                }
                field("End Date"; EnDate)
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

    trigger OnPreReport()
    begin
        IF StDate = 0D THEN
            ERROR('kindly select Start Date');

        IF EnDate = 0D THEN
            ERROR('kindly select End Date');
    end;

    var
        ILE: Record "Item Ledger Entry";
        SalesQty: Decimal;
        StDate: Date;
        EnDate: Date;
        retQty: Decimal;
        qtyRem: Decimal;
}

