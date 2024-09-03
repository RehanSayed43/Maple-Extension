report 50005 "Cheque value"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Chequevalue.rdl';
    ApplicationArea = FixedAsset;

    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {
            // column(Check_Date; "Gen. Journal Line"."Cheque Date")
            // {
            // }
            // column(CheckNo; "Gen. Journal Line"."Cheque No.")
            // {
            // }
            column(Amount_GJL; "Gen. Journal Line"."Amount (LCY)")
            {
            }
            column(PartyCode_GenJournalLine; "Gen. Journal Line"."Party Code")
            {
            }
            column(Self; Self)
            {
            }
            column(d1; d1)
            {
            }
            column(d2; d2)
            {
            }
            column(m1; m1)
            {
            }
            column(m2; m2)
            {
            }
            column(y1; y1)
            {
            }
            column(y2; y2)
            {
            }
            column(y3; y3)
            {
            }
            column(y4; y4)
            {
            }
            column(AmountToWord; AmountToWord_Show)
            {
            }
            column(Amount; ABS("Gen. Journal Line"."Amount (LCY)"))
            {
            }
            column(PartyName; "Gen. Journal Line".Description)
            {
            }
            column(DescriptionLine1; UPPERCASE(DescriptionLine[1]))
            {
            }
            column(DescriptionLine2; UPPERCASE(DescriptionLine[2]))
            {
            }
            column(PartyName_; "Gen. Journal Line".Description)
            {
            }

            trigger OnAfterGetRecord()
            begin
                // IF "Gen. Journal Line"."Cheque No." = '' THEN
                //     CurrReport.SKIP;

                PartyName := '';

                IF VendorRec.GET("Gen. Journal Line"."Party Code") THEN;

                DescriptionLine[1] := '';
                DescriptionLine[2] := '';

                CUamtinword.InitTextVariable;
                CUamtinword.FormatNoText(DescriptionLine, ABS("Gen. Journal Line"."Amount (LCY)"), '');
                //AmountToWord := DescriptionLine[1];
                //MESSAGE(AmountToWord);

                StrPosi := STRPOS(AmountToWord, '   ');
                //MESSAGE('%1',StrPosi);
                DelAmountWord := DELSTR(AmountToWord, StrPosi + 4, 0);
                //AmountToWord_Show := INSSTR(DelAmountWord,'',STRLEN(DelAmountWord));
                //MESSAGE(AmountToWord_Show);



                Date1 := 0D;
                d1 := '';
                d2 := '';
                m1 := '';
                m2 := '';
                y1 := '';
                y2 := '';
                y3 := '';
                y4 := '';

                /*  rahul ------------------

                  IF (FORMAT("Gen. Journal Line"."Cheque Date") <> '') OR ("Gen. Journal Line"."Cheque Date" <> 0D) THEN BEGIN
                       Date1 := "Gen. Journal Line"."Cheque Date";

                       year_txt := FORMAT(DATE2DMY(Date1, 3));
                       y1 := COPYSTR(year_txt, 1, 1);
                       y2 := COPYSTR(year_txt, 2, 1);
                       y3 := COPYSTR(year_txt, 3, 1);
                       y4 := COPYSTR(year_txt, 4, 1);
                       //MESSAGE(y1+' '+y2+' '+y3+' '+y4);

                       month_txt := FORMAT(DATE2DMY(Date1, 2));
                       IF DATE2DMY(Date1, 2) < 10 THEN BEGIN
                           m1 := '0';
                           m2 := COPYSTR(month_txt, 1, 1);
                       END
                       ELSE BEGIN
                           m1 := COPYSTR(month_txt, 1, 1);
                           m2 := COPYSTR(month_txt, 2, 1);
                       END;
                       //MESSAGE(m1+' m1 '+m2);

                       day_txt := FORMAT(DATE2DMY(Date1, 1));
                       IF DATE2DMY(Date1, 1) < 10 THEN BEGIN
                           d1 := '0';
                           d2 := COPYSTR(day_txt, 1, 1);
                       END
                       ELSE BEGIN
                           d1 := COPYSTR(day_txt, 1, 1);
                           d2 := COPYSTR(day_txt, 2, 1);
                       END;
                       //MESSAGE('D '+d1+' D '+d2+' M'+m1+' M'+m2+' Y %1 Y %2 Y %3 Y %4',y1,y2,y3,y4);
                   END;
                   -------------rahul */
                IF "Gen. Journal Line"."Party Type" = "Gen. Journal Line"."Party Type"::Party THEN BEGIN
                    IF PartyRec.GET("Gen. Journal Line"."Party Code") THEN
                        PartyName := PartyRec.Name;
                END
                ELSE
                    IF "Gen. Journal Line"."Party Type" = "Gen. Journal Line"."Party Type"::Vendor THEN BEGIN
                        IF VendorRec.GET("Gen. Journal Line"."Party Code") THEN
                            PartyName := VendorRec.Name + ' ' + VendorRec."Name 2";
                    END
                    ELSE
                        IF "Gen. Journal Line"."Party Type" = "Gen. Journal Line"."Party Type"::Customer THEN BEGIN
                            IF CustomerRec.GET("Gen. Journal Line"."Party Code") THEN
                                PartyName := CustomerRec.Name + ' ' + CustomerRec."Name 2";
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
                field(Self; Self)
                {
                    Caption = 'Check For Self';
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
        DescriptionLine: array[2] of Text[60];
        AmountToWord: Text[100];
        Self: Boolean;
        Date1: Date;
        y1: Text[5];
        y2: Text[5];
        y3: Text[5];
        y4: Text[5];
        year_txt: Text[10];
        month_txt: Text[5];
        m1: Text[5];
        m2: Text[5];
        day_txt: Text[5];
        d1: Text[5];
        d2: Text[5];
        Amount: Decimal;
        StrPosi: Integer;
        AmountToWord_Show: Text[60];
        DelAmountWord: Text[60];
        VendorRec: Record Vendor;
        CustomerRec: Record Customer;
        PartyRec: Record Party;
        PartyName: Text[80];
        CUamtinword: Report Check;
}

