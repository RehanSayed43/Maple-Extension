page 50152 "Voucher Integration List Card"
{
    PageType = Card;
    SourceTable = "Voucher Integration";
    UsageCategory = Administration;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("SO No."; Rec."SO No.")
                {
                    ApplicationArea = all;
                }
                field("Voucher Int. No.1"; Rec."Voucher Int. No.1")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        //  VoucherCheck("Voucher Int. No.1");
                    end;
                }
                field("Voucher PIN1"; Rec."Voucher PIN1")
                {
                    ApplicationArea = all;
                }
                field("Voucher Amount1"; Rec."Voucher Amount1")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        //  CheckVouchAmt("Voucher Amount1", "Voucher Int. No.1", "Voucher PIN1");
                    end;
                }
                field("Voucher Int. No.2"; Rec."Voucher Int. No.2")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        //   VoucherCheck("Voucher Int. No.2");
                    end;
                }
                field("Voucher PIN2"; Rec."Voucher PIN2")
                {
                    ApplicationArea = all;
                }
                field("Voucher Amount2"; Rec."Voucher Amount2")
                {

                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        //    CheckVouchAmt("Voucher Amount2", "Voucher Int. No.2", "Voucher PIN2");
                    end;
                }
                field("Voucher Int. No.3"; Rec."Voucher Int. No.3")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        //   VoucherCheck("Voucher Int. No.3");
                    end;
                }
                field("Voucher PIN3"; Rec."Voucher PIN3")
                {
                    ApplicationArea = all;
                }
                field("Voucher Amount3"; Rec."Voucher Amount3")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        //   CheckVouchAmt("Voucher Amount3", "Voucher Int. No.3", "Voucher PIN3");
                    end;
                }
                field("Voucher Int. No.4"; Rec."Voucher Int. No.4")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        //    VoucherCheck("Voucher Int. No.4");
                    end;
                }
                field("Voucher PIN4"; Rec."Voucher PIN4")
                {
                    ApplicationArea = all;
                }
                field("Voucher Amount4"; Rec."Voucher Amount4")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        //     CheckVouchAmt("Voucher Amount4", "Voucher Int. No.4", "Voucher PIN4");
                    end;
                }
                field("Voucher Int. No.5"; Rec."Voucher Int. No.5")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        //   VoucherCheck("Voucher Int. No.5");
                    end;
                }
                field("Voucher PIN5"; Rec."Voucher PIN5")
                {
                    ApplicationArea = all;
                }
                field("Voucher Amount5"; Rec."Voucher Amount5")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        //   CheckVouchAmt("Voucher Amount5", "Voucher Int. No.5", "Voucher PIN5");
                    end;
                }
                field("Voucher Int. No.6"; Rec."Voucher Int. No.6")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        // VoucherCheck("Voucher Int. No.6");
                    end;
                }
                field("Voucher PIN6"; Rec."Voucher PIN6")
                {
                    ApplicationArea = all;
                }
                field("Voucher Amount6"; Rec."Voucher Amount6")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        //   CheckVouchAmt("Voucher Amount6", "Voucher Int. No.6", "Voucher PIN6");
                    end;
                }
                field("Voucher Int. No.7"; Rec."Voucher Int. No.7")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        //  VoucherCheck("Voucher Int. No.7");
                    end;
                }
                field("Voucher PIN7"; Rec."Voucher PIN7")
                {
                    ApplicationArea = all;
                }
                field("Voucher Amount7"; Rec."Voucher Amount7")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        //   CheckVouchAmt("Voucher Amount7", "Voucher Int. No.7", "Voucher PIN7");
                    end;
                }
                field("Voucher Int. No.8"; Rec."Voucher Int. No.8")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        //   VoucherCheck("Voucher Int. No.8");
                    end;
                }
                field("Voucher PIN8"; Rec."Voucher PIN8")
                {
                    ApplicationArea = all;
                }
                field("Voucher Amount8"; Rec."Voucher Amount8")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        //  CheckVouchAmt("Voucher Amount8", "Voucher Int. No.8", "Voucher PIN8");
                    end;
                }
                field("Voucher Int. No.9"; Rec."Voucher Int. No.9")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        //  VoucherCheck("Voucher Int. No.9");
                    end;
                }
                field("Voucher PIN9"; Rec."Voucher PIN9")
                {

                    ApplicationArea = all;
                }
                field("Voucher Amount9"; Rec."Voucher Amount9")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        //  CheckVouchAmt("Voucher Amount9", "Voucher Int. No.9", "Voucher PIN9");
                    end;
                }
                field("Voucher Int. No.10"; Rec."Voucher Int. No.10")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        // VoucherCheck("Voucher Int. No.10");
                    end;
                }
                field("Voucher PIN10"; Rec."Voucher PIN10")
                {
                    ApplicationArea = all;
                }
                field("Voucher Amount10"; Rec."Voucher Amount10")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        //  CheckVouchAmt("Voucher Amount10", "Voucher Int. No.10", "Voucher PIN10");
                    end;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(Voucher)
            {
                action("Update Voucher Details")
                {
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        RecSO: Record "Sales Header";
                    begin
                        RecSO.RESET;
                        // RecSO.SETRANGE("No.", "SO No.");
                        IF RecSO.FINDFIRST THEN BEGIN
                            // RecSO.VALIDATE("Voucher Amount", "Voucher Amount1" + "Voucher Amount2" + "Voucher Amount3" + "Voucher Amount4" + "Voucher Amount5" + "Voucher Amount6" + "Voucher Amount7" + "Voucher Amount8" + "Voucher Amount9" + "Voucher Amount10");
                            RecSO.MODIFY;
                            MESSAGE('Voucher details updated in SO successfully');
                        END;
                    end;
                }
            }
        }
    }

    var
        RecSIH: Record "Sales Invoice Header";
        // GetVoucher: Codeunit "50018";
        RecSH: Record "Sales Header";
        RecEINV: Record "E-Invoice Log";
        RecCvouchCust: Record "Customer";
        RecEINV1: Record "E-Invoice Log";
        RecLoc: Record "Location";
        RecSOO: Record "Sales Header";
        Amt: Decimal;

    local procedure VoucherCheck(VoucherN: Text[20])
    begin
        /*
        RecSOO.RESET;
        RecSOO.SETRANGE("No.","SO No.");
        IF RecSOO.FINDFIRST THEN;
        IF RecLoc.GET(RecSOO."Location Code") THEN BEGIN
          IF RecLoc."Voucher Client ID"='' THEN
            ERROR('Not allowed to perform for this location');
            IF RecLoc."Voucher Secret Code"='' THEN
              ERROR('Not allowed to perform for this location');
          END;
        IF RecCvouchCust.GET(RecSOO."Sell-to Customer No.") THEN BEGIN
          RecCvouchCust.TESTFIELD("E-Mail");
          RecCvouchCust.TESTFIELD("Phone No.");
        END;
        
        IF VoucherN <>'' THEN BEGIN
        RecSIH.RESET;
        RecSIH.SETRANGE("Voucher Int. No.",VoucherN);
        IF RecSIH.FINDFIRST THEN BEGIN
          RecEINV.RESET;
          RecEINV.SETRANGE("Vouchr. Code",VoucherN);
          RecEINV.SETRANGE("Vouchr. Integration",TRUE);
          RecEINV.SETFILTER("Vouchr. Capture id",'<>%1','');
          IF RecEINV.FINDLAST THEN BEGIN
          RecEINV1.RESET;
          RecEINV1.SETRANGE("Vouchr. Code",VoucherN);
          RecEINV1.SETRANGE("Vouchr. Integration",TRUE);
          RecEINV1.SETFILTER("Refund ID",'<>%1','');
          IF NOT RecEINV1.FINDFIRST THEN BEGIN
          ERROR('This voucher is already used for %1',RecSIH."No.");
        END;END;
         // ERROR('This voucher is already used for %1',RecSIH."No.");
        END;
        RecSH.RESET;
        RecSH.SETRANGE("Voucher Int. No.",VoucherN);
        IF RecSH.FINDFIRST THEN BEGIN
          RecEINV.RESET;
          RecEINV.SETRANGE("Vouchr. Code",VoucherN);
          RecEINV.SETRANGE("Vouchr. Integration",TRUE);
          RecEINV.SETFILTER("Vouchr. Capture id",'<>%1','');
          IF RecEINV.FINDLAST THEN BEGIN
          RecEINV1.RESET;
          RecEINV1.SETRANGE("Vouchr. Code",VoucherN);
          RecEINV1.SETRANGE("Vouchr. Integration",TRUE);
          RecEINV1.SETFILTER("Refund ID",'<>%1','');
          IF NOT RecEINV1.FINDFIRST THEN BEGIN
          ERROR('This voucher is already used for %1',RecSH."No.");
        END;END;
        
        //GetVoucher.GetVoucher("Voucher Int. No.","Location Code");
        END;
        GetVoucher.GetVoucher(VoucherN,RecSOO."Location Code");
        END;
        */

    end;

    local procedure CheckVouchAmt(VouchAmt: Decimal; VoucherN: Text[20]; VouchPIN: Text[20])
    var
        RecSOH: Record "Sales Header";
    begin
        RecSOH.RESET;
        // RecSOH.SETRANGE("No.", "SO No.");
        IF RecSOH.FINDFIRST THEN;

        IF VouchAmt <> 0 THEN
            IF (VouchPIN = '') OR (VoucherN = '') THEN
                ERROR('Please check voucher code/pin can not be blank');

        IF VouchAmt <> 0 THEN BEGIN
            IF VouchAmt < 0 THEN
                ERROR('Amount must be positive');

            //  Amt := GetVoucher.GetVoucherAmt(VoucherN, RecSOH."Location Code");
            IF VouchAmt > Amt THEN
                ERROR('Available amount is %1', Amt);
            //  GetVoucher.MapleAuth(VouchAmt, VoucherN, VouchPIN, "SO No.", RecSOH."Location Code");
        END;
    end;
}

