report 50290 "Daily Sales Report1 "
{
    DefaultLayout = RDLC;
    RDLCLayout = './DailySalesReport1.rdl';
    ApplicationArea = FixedAsset;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = WHERE("No." = FILTER(<> ' '));
            RequestFilterFields = "Date Filter", "Item Category Code", "Product Category", "Location Filter"; //"Product Group Code",
            column(Description_Item; Item.Description)
            {
            }
            // column(ProductGroupCode_Item; Item."Product Group Code")
            column(ProductGroupCode_Item; Item."Product Category")
            {
            }
            column(ItemCategoryCode_Item; Item."Item Category Code")
            {
            }
            column(No_Item; Item."No.")
            {
            }
            column(VendorPartCodeLong_Item; Item."Vendor Part Code Long")
            {
            }
            column(Primarycategory_Item; Item."Primary category")
            {
            }
            column(Month1; Month[1])
            {
            }
            column(Month2; Month[2])
            {
            }
            column(Month3; Month[3])
            {
            }
            column(Month4; Month[4])
            {
            }
            column(Month5; Month[5])
            {
            }
            column(Month6; Month[6])
            {
            }
            column(Month7; Month[7])
            {
            }
            column(Month8; Month[8])
            {
            }
            column(Month9; Month[9])
            {
            }
            column(Month10; Month[10])
            {
            }
            column(Month11; Month[11])
            {
            }
            column(Month12; Month[12])
            {
            }
            column(Month13; Month[13])
            {
            }
            column(Month14; Month[14])
            {
            }
            column(Month15; Month[15])
            {
            }
            column(Month16; Month[16])
            {
            }
            column(Month17; Month[17])
            {
            }
            column(Month18; Month[18])
            {
            }
            column(Month19; Month[19])
            {
            }
            column(Month20; Month[20])
            {
            }
            column(Month21; Month[21])
            {
            }
            column(Month22; Month[22])
            {
            }
            column(Month23; Month[23])
            {
            }
            column(Month24; Month[24])
            {
            }
            column(Month25; Month[25])
            {
            }
            column(Month26; Month[26])
            {
            }
            column(Month27; Month[27])
            {
            }
            column(Month28; Month[28])
            {
            }
            column(Month29; Month[29])
            {
            }
            column(Month30; Month[30])
            {
            }
            column(Month31; Month[31])
            {
            }
            column(qty1; qty[1])
            {
            }
            column(qty2; qty[2])
            {
            }
            column(qty3; qty[3])
            {
            }
            column(qty4; qty[4])
            {
            }
            column(qty5; qty[5])
            {
            }
            column(qty6; qty[6])
            {
            }
            column(qty7; qty[7])
            {
            }
            column(qty8; qty[8])
            {
            }
            column(qty9; qty[9])
            {
            }
            column(qty10; qty[10])
            {
            }
            column(qty11; qty[11])
            {
            }
            column(qty12; qty[12])
            {
            }
            column(qty13; qty[13])
            {
            }
            column(qty14; qty[14])
            {
            }
            column(qty15; qty[15])
            {
            }
            column(qty16; qty[16])
            {
            }
            column(qty17; qty[17])
            {
            }
            column(qty18; qty[18])
            {
            }
            column(qty19; qty[19])
            {
            }
            column(qty20; qty[20])
            {
            }
            column(qty21; qty[21])
            {
            }
            column(qty22; qty[22])
            {
            }
            column(qty23; qty[23])
            {
            }
            column(qty24; qty[24])
            {
            }
            column(qty25; qty[25])
            {
            }
            column(qty26; qty[26])
            {
            }
            column(qty27; qty[27])
            {
            }
            column(qty28; qty[28])
            {
            }
            column(qty29; qty[29])
            {
            }
            column(qty30; qty[30])
            {
            }
            column(qty31; qty[31])
            {
            }
            column(Amt1; Amt[1])
            {
            }
            column(Amt2; Amt[2])
            {
            }
            column(Amt3; Amt[3])
            {
            }
            column(Amt4; Amt[4])
            {
            }
            column(Amt5; Amt[5])
            {
            }
            column(Amt6; Amt[6])
            {
            }
            column(Amt7; Amt[7])
            {
            }
            column(Amt8; Amt[8])
            {
            }
            column(Amt9; Amt[9])
            {
            }
            column(Amt10; Amt[10])
            {
            }
            column(Amt11; Amt[11])
            {
            }
            column(Amt12; Amt[12])
            {
            }
            column(Amt13; Amt[13])
            {
            }
            column(Amt14; Amt[14])
            {
            }
            column(Amt15; Amt[15])
            {
            }
            column(Amt16; Amt[16])
            {
            }
            column(Amt17; Amt[17])
            {
            }
            column(Amt18; Amt[18])
            {
            }
            column(Amt19; Amt[19])
            {
            }
            column(Amt20; Amt[20])
            {
            }
            column(Amt21; Amt[21])
            {
            }
            column(Amt22; Amt[22])
            {
            }
            column(Amt23; Amt[23])
            {
            }
            column(Amt24; Amt[24])
            {
            }
            column(Amt25; Amt[25])
            {
            }
            column(Amt26; Amt[26])
            {
            }
            column(Amt27; Amt[27])
            {
            }
            column(Amt28; Amt[28])
            {
            }
            column(Amt29; Amt[29])
            {
            }
            column(Amt30; Amt[30])
            {
            }
            column(Amt31; Amt[31])
            {
            }
            column(QtyTotal; QtyTotal)
            {
            }
            column(AmtTotal; AmtTotal)
            {
            }
            column(ARSINV11; ARSINV[1] [1])
            {
            }
            column(ARSINV12; ARSINV[1] [2])
            {
            }
            column(ARSINV13; ARSINV[1] [3])
            {
            }
            column(ARSINV21; ARSINV[2] [1])
            {
            }
            column(ARSINV22; ARSINV[2] [2])
            {
            }
            column(ARSINV23; ARSINV[2] [3])
            {
            }
            column(ARSINV31; ARSINV[3] [1])
            {
            }
            column(ARSINV32; ARSINV[3] [2])
            {
            }
            column(ARSINV33; ARSINV[3] [3])
            {
            }
            column(ARSINV41; ARSINV[4] [1])
            {
            }
            column(ARSINV42; ARSINV[4] [2])
            {
            }
            column(ARSINV43; ARSINV[4] [3])
            {
            }
            column(ARSINV51; ARSINV[5] [1])
            {
            }
            column(ARSINV52; ARSINV[5] [2])
            {
            }
            column(ARSINV53; ARSINV[5] [3])
            {
            }
            column(ARSINV61; ARSINV[6] [1])
            {
            }
            column(ARSINV62; ARSINV[6] [2])
            {
            }
            column(ARSINV63; ARSINV[6] [3])
            {
            }
            column(ARSINV71; ARSINV[7] [1])
            {
            }
            column(ARSINV72; ARSINV[7] [2])
            {
            }
            column(ARSINV73; ARSINV[7] [3])
            {
            }
            column(ARSINV81; ARSINV[8] [1])
            {
            }
            column(ARSINV82; ARSINV[8] [2])
            {
            }
            column(ARSINV83; ARSINV[8] [3])
            {
            }
            column(ARSINV91; ARSINV[9] [1])
            {
            }
            column(ARSINV92; ARSINV[9] [2])
            {
            }
            column(ARSINV93; ARSINV[9] [3])
            {
            }
            column(ARSINV101; ARSINV[10] [1])
            {
            }
            column(ARSINV102; ARSINV[10] [2])
            {
            }
            column(ARSINV103; ARSINV[10] [3])
            {
            }
            column(ARSINV111; ARSINV[11] [1])
            {
            }
            column(ARSINV112; ARSINV[11] [2])
            {
            }
            column(ARSINV113; ARSINV[11] [3])
            {
            }
            column(ARSINV121; ARSINV[12] [1])
            {
            }
            column(ARSINV122; ARSINV[12] [2])
            {
            }
            column(ARSINV123; ARSINV[12] [3])
            {
            }
            column(ARSINV131; ARSINV[13] [1])
            {
            }
            column(ARSINV132; ARSINV[13] [2])
            {
            }
            column(ARSINV133; ARSINV[13] [3])
            {
            }
            column(ARSINV141; ARSINV[14] [1])
            {
            }
            column(ARSINV142; ARSINV[14] [2])
            {
            }
            column(ARSINV143; ARSINV[14] [3])
            {
            }
            column(ARSINV151; ARSINV[15] [1])
            {
            }
            column(ARSINV152; ARSINV[15] [2])
            {
            }
            column(ARSINV153; ARSINV[15] [3])
            {
            }
            column(ARSINV161; ARSINV[16] [1])
            {
            }
            column(ARSINV162; ARSINV[16] [2])
            {
            }
            column(ARSINV163; ARSINV[16] [3])
            {
            }
            column(ARSINV171; ARSINV[17] [1])
            {
            }
            column(ARSINV172; ARSINV[17] [2])
            {
            }
            column(ARSINV173; ARSINV[17] [3])
            {
            }
            column(ARSINV181; ARSINV[18] [1])
            {
            }
            column(ARSINV182; ARSINV[18] [2])
            {
            }
            column(ARSINV183; ARSINV[18] [3])
            {
            }
            column(ARSINV191; ARSINV[19] [1])
            {
            }
            column(ARSINV192; ARSINV[19] [2])
            {
            }
            column(ARSINV193; ARSINV[19] [3])
            {
            }
            column(ARSINV201; ARSINV[20] [1])
            {
            }
            column(ARSINV202; ARSINV[20] [2])
            {
            }
            column(ARSINV203; ARSINV[20] [3])
            {
            }
            column(ARSINV211; ARSINV[21] [1])
            {
            }
            column(ARSINV212; ARSINV[21] [2])
            {
            }
            column(ARSINV213; ARSINV[21] [3])
            {
            }
            column(ARSINV221; ARSINV[22] [1])
            {
            }
            column(ARSINV222; ARSINV[22] [2])
            {
            }
            column(ARSINV223; ARSINV[22] [3])
            {
            }
            column(ARSINV231; ARSINV[23] [1])
            {
            }
            column(ARSINV232; ARSINV[23] [2])
            {
            }
            column(ARSINV233; ARSINV[23] [3])
            {
            }
            column(ARSINV241; ARSINV[24] [1])
            {
            }
            column(ARSINV242; ARSINV[24] [2])
            {
            }
            column(ARSINV243; ARSINV[24] [3])
            {
            }
            column(ARSINV251; ARSINV[25] [1])
            {
            }
            column(ARSINV252; ARSINV[25] [2])
            {
            }
            column(ARSINV253; ARSINV[25] [3])
            {
            }
            column(ARSINV261; ARSINV[26] [1])
            {
            }
            column(ARSINV262; ARSINV[26] [2])
            {
            }
            column(ARSINV263; ARSINV[26] [3])
            {
            }
            column(ARSINV271; ARSINV[27] [1])
            {
            }
            column(ARSINV272; ARSINV[27] [2])
            {
            }
            column(ARSINV273; ARSINV[27] [3])
            {
            }
            column(ARSINV281; ARSINV[28] [1])
            {
            }
            column(ARSINV282; ARSINV[28] [2])
            {
            }
            column(ARSINV283; ARSINV[28] [3])
            {
            }
            column(ARSINV291; ARSINV[29] [1])
            {
            }
            column(ARSINV292; ARSINV[29] [2])
            {
            }
            column(ARSINV293; ARSINV[29] [3])
            {
            }
            column(ARSINV301; ARSINV[30] [1])
            {
            }
            column(ARSINV302; ARSINV[30] [2])
            {
            }
            column(ARSINV303; ARSINV[30] [3])
            {
            }
            column(ARSINV311; ARSINV[31] [1])
            {
            }
            column(ARSINV312; ARSINV[31] [2])
            {
            }
            column(ARSINV313; ARSINV[31] [3])
            {
            }
            column(QtyTotal1; QtyTotal1)
            {
            }
            column(AmtTotal1; AmtTotal1)
            {
            }
            column(InvTotal; InvTotal)
            {
            }
            column(ARTPA11; ARTPA[1] [1])
            {
            }
            column(ARTPA12; ARTPA[1] [2])
            {
            }
            column(ARTPA21; ARTPA[2] [1])
            {
            }
            column(ARTPA22; ARTPA[2] [2])
            {
            }
            column(ARTPA31; ARTPA[3] [1])
            {
            }
            column(ARTPA32; ARTPA[3] [2])
            {
            }
            column(ARTPA41; ARTPA[4] [1])
            {
            }
            column(ARTPA42; ARTPA[4] [2])
            {
            }
            column(ARTPA51; ARTPA[5] [1])
            {
            }
            column(ARTPA52; ARTPA[5] [2])
            {
            }
            column(ARTPA61; ARTPA[6] [1])
            {
            }
            column(ARTPA62; ARTPA[6] [2])
            {
            }
            column(ARTPA71; ARTPA[7] [1])
            {
            }
            column(ARTPA72; ARTPA[7] [2])
            {
            }
            column(ARTPA81; ARTPA[8] [1])
            {
            }
            column(ARTPA82; ARTPA[8] [2])
            {
            }
            column(ARTPA91; ARTPA[9] [1])
            {
            }
            column(ARTPA92; ARTPA[9] [2])
            {
            }
            column(ARTPA101; ARTPA[10] [1])
            {
            }
            column(ARTPA102; ARTPA[10] [2])
            {
            }
            column(ARTPA111; ARTPA[11] [1])
            {
            }
            column(ARTPA112; ARTPA[11] [2])
            {
            }
            column(ARTPA121; ARTPA[12] [1])
            {
            }
            column(ARTPA122; ARTPA[12] [2])
            {
            }
            column(ARTPA131; ARTPA[13] [1])
            {
            }
            column(ARTPA132; ARTPA[13] [2])
            {
            }
            column(ARTPA141; ARTPA[14] [1])
            {
            }
            column(ARTPA142; ARTPA[14] [2])
            {
            }
            column(ARTPA151; ARTPA[15] [1])
            {
            }
            column(ARTPA152; ARTPA[15] [2])
            {
            }
            column(ARTPA161; ARTPA[16] [1])
            {
            }
            column(ARTPA162; ARTPA[16] [2])
            {
            }
            column(ARTPA171; ARTPA[17] [1])
            {
            }
            column(ARTPA172; ARTPA[17] [2])
            {
            }
            column(ARTPA181; ARTPA[18] [1])
            {
            }
            column(ARTPA182; ARTPA[18] [2])
            {
            }
            column(ARTPA191; ARTPA[19] [1])
            {
            }
            column(ARTPA192; ARTPA[19] [2])
            {
            }
            column(ARTPA201; ARTPA[20] [1])
            {
            }
            column(ARTPA202; ARTPA[20] [2])
            {
            }
            column(ARTPA211; ARTPA[21] [1])
            {
            }
            column(ARTPA212; ARTPA[21] [2])
            {
            }
            column(ARTPA221; ARTPA[22] [1])
            {
            }
            column(ARTPA222; ARTPA[22] [2])
            {
            }
            column(ARTPA231; ARTPA[23] [1])
            {
            }
            column(ARTPA232; ARTPA[23] [2])
            {
            }
            column(ARTPA241; ARTPA[24] [1])
            {
            }
            column(ARTPA242; ARTPA[24] [2])
            {
            }
            column(ARTPA251; ARTPA[25] [1])
            {
            }
            column(ARTPA252; ARTPA[25] [2])
            {
            }
            column(ARTPA261; ARTPA[26] [1])
            {
            }
            column(ARTPA262; ARTPA[26] [2])
            {
            }
            column(ARTPA271; ARTPA[27] [1])
            {
            }
            column(ARTPA272; ARTPA[27] [2])
            {
            }
            column(ARTPA281; ARTPA[28] [1])
            {
            }
            column(ARTPA282; ARTPA[28] [2])
            {
            }
            column(ARTPA291; ARTPA[29] [1])
            {
            }
            column(ARTPA292; ARTPA[29] [2])
            {
            }
            column(ARTPA301; ARTPA[30] [1])
            {
            }
            column(ARTPA302; ARTPA[30] [2])
            {
            }
            column(ARTPA311; ARTPA[31] [1])
            {
            }
            column(ARTPA312; ARTPA[31] [2])
            {
            }
            column(ARTPAQTY; ARTPAQTY)
            {
            }
            column(ARTPAAMT; ARTPAAMT)
            {
            }

            trigger OnAfterGetRecord()
            begin
                j := 1;
                QtyTotal1 := 0;
                AmtTotal1 := 0;
                InvTotal := 0;
                ARTPAQTY := 0;
                ARTPAAMT := 0;

                FOR date2 := STDate TO ENDate DO BEGIN
                    qty[j] := 0;
                    Amt[j] := 0;

                    ILE.RESET;
                    ILE.SETFILTER(ILE."Item No.", Item."No.");
                    ILE.SETFILTER(ILE."Posting Date", '%1', date2);
                    ILE.SETFILTER(ILE."Entry Type", '%1', ILE."Entry Type"::Sale);

                    IF Item.GETFILTER(Item."Location Filter") <> '' THEN
                        ILE.SETFILTER(ILE."Location Code", Item.GETFILTER(Item."Location Filter"));

                    IF ILE.FINDSET THEN
                        REPEAT
                            ILE.CALCFIELDS(ILE."Sales Amount (Actual)");
                            qty[j] += ILE.Quantity;
                            Amt[j] += ILE."Sales Amount (Actual)";
                        UNTIL ILE.NEXT = 0;
                    j += 1;
                END;
                i := 0;
                j := 0;
                FOR i := 1 TO 31 DO BEGIN
                    FOR j := 1 TO 3 DO BEGIN
                        ARSINV[i, j] := 0;
                    END;
                END;

                //******  Invoice Calculation
                i := 1;
                OrderNo := '';
                FOR date2 := STDate TO ENDate DO BEGIN
                    ILE.RESET;
                    ILE.SETFILTER(ILE."Item No.", '<>%1', '');
                    ILE.SETFILTER(ILE."Posting Date", '%1', date2);
                    ILE.SETFILTER(ILE."Entry Type", '%1', ILE."Entry Type"::Sale);

                    IF Item.GETFILTER(Item."Location Filter") <> '' THEN
                        ILE.SETFILTER(ILE."Location Code", Item.GETFILTER(Item."Location Filter"));

                    IF ILE.FINDSET THEN
                        REPEAT
                            IF OrderNo <> ILE."Document No." THEN BEGIN
                                ARSINV[i] [1] += 1;
                                InvTotal += 1;
                                OrderNo := ILE."Document No.";
                            END;
                            ILE.CALCFIELDS(ILE."Sales Amount (Actual)");
                            ARSINV[i] [2] += ILE.Quantity;
                            ARSINV[i] [3] += ILE."Sales Amount (Actual)";
                            QtyTotal1 += ILE.Quantity;
                            AmtTotal1 += ILE."Sales Amount (Actual)";
                        // IF ILE."Product Group Code" = 'TPA' THEN BEGIN
                        //     ARTPA[i] [1] += ILE.Quantity;
                        //     ARTPA[i] [2] += ILE."Sales Amount (Actual)";
                        //     ARTPAQTY += ILE.Quantity;
                        //     ARTPAAMT += ILE."Sales Amount (Actual)";
                        // END;
                        UNTIL ILE.NEXT = 0;
                    i += 1;
                END;
                //******
                k := 1;
                QtyTotal := 0;
                AmtTotal := 0;
                FOR k := 1 TO 31 DO BEGIN
                    QtyTotal += qty[k];
                    AmtTotal += Amt[k];
                END;


            end;

            trigger OnPreDataItem()
            var
                Date: Date;
            begin
                STDate := CALCDATE('-CM', date1);
                ENDate := CALCDATE('CM', date1);
                //MESSAGE('%1',ENDate-(STDate-1));
                FOR i := 1 TO (ENDate - (STDate - 1)) DO BEGIN
                    Month[i] := i;
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("")
                {
                    field(Date; date1)
                    {
                        ApplicationArea = All;
                    }
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
        QtyTotal1 := 0;
        AmtTotal1 := 0;
        InvTotal := 0;
        ARTPAQTY := 0;
        ARTPAAMT := 0;
    end;

    var
        RecItem: Record "Item";
        RecCompInfo: Record "Company Information";
        ILE: Record "Item Ledger Entry";
        STDate: Date;
        ENDate: Date;
        date1: Date;
        Month: array[31] of Integer;
        i: Integer;
        date2: Date;
        qty: array[31] of Decimal;
        Amt: array[31] of Decimal;
        j: Integer;
        k: Integer;
        QtyTotal: Decimal;
        AmtTotal: Decimal;
        ARSINV: array[31, 3] of Decimal;
        QtyTotal1: Decimal;
        AmtTotal1: Decimal;
        InvTotal: Decimal;
        OrderNo: Code[20];
        ARTPA: array[31, 2] of Decimal;
        ARTPAQTY: Decimal;
        ARTPAAMT: Decimal;
}

