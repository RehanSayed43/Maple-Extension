page 50153 "Voucher Integration Card"
{
    PageType = Card;
    SourceTable = 50021;
    ApplicationArea = FixedAsset;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("SO No."; Rec."SO No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
            }
            group(Voucher1)
            {
                field("Voucher Int. No.1"; Rec."Voucher Int. No.1")
                {
                    ApplicationArea = all;


                    trigger OnValidate()
                    begin
                        VoucherCheck(Rec."Voucher Int. No.1");
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
                        CheckVouchAmt(Rec."Voucher Amount1", Rec."Voucher Int. No.1", Rec."Voucher PIN1");
                    end;
                }
                field(Cancel1; Rec.Cancel1)
                {
                    ApplicationArea = all;
                }
                field(Refund1; Rec.Refund1)
                {
                    ApplicationArea = all;
                }
            }
            group(Voucher2)
            {
                field("Voucher Int. No.2"; Rec."Voucher Int. No.2")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        VoucherCheck(Rec."Voucher Int. No.2");
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
                        CheckVouchAmt(Rec."Voucher Amount2", Rec."Voucher Int. No.2", Rec."Voucher PIN2");
                    end;
                }
                field(Cancel2; Rec.Cancel2)
                {
                    ApplicationArea = all;
                }
                field(Refund2; Rec.Refund2)
                {
                    ApplicationArea = all;
                }
            }
            group(Voucher3)
            {
                field("Voucher Int. No.3"; Rec."Voucher Int. No.3")
                {

                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        VoucherCheck(Rec."Voucher Int. No.3");
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
                        CheckVouchAmt(Rec."Voucher Amount3", Rec."Voucher Int. No.3", Rec."Voucher PIN3");
                    end;
                }
                field(Cancel3; Rec.Cancel3)
                {
                    ApplicationArea = all;
                }
                field(Refund3; Rec.Refund3)
                {
                    ApplicationArea = all;
                }
            }
            group(Voucher4)
            {
                field("Voucher Int. No.4"; Rec."Voucher Int. No.4")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        VoucherCheck(Rec."Voucher Int. No.4");
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
                        CheckVouchAmt(Rec."Voucher Amount4", Rec."Voucher Int. No.4", Rec."Voucher PIN4");
                    end;
                }
                field(Cancel4; Rec.Cancel4)
                {
                    ApplicationArea = all;
                }
                field(Refund4; Rec.Refund4)
                {
                    ApplicationArea = all;
                }
                group(Voucher5)
                {

                }
                field("Voucher Int. No.5"; Rec."Voucher Int. No.5")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        VoucherCheck(Rec."Voucher Int. No.5");
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
                        CheckVouchAmt(Rec."Voucher Amount5", Rec."Voucher Int. No.5", Rec."Voucher PIN5");
                    end;
                }
                field(Cancel5; Rec.Cancel5)
                {
                    ApplicationArea = all;
                }
                field(Refund5; Rec.Refund5)
                {
                    ApplicationArea = all;
                }
            }
            group(Voucher6)
            {
                field("Voucher Int. No.6"; Rec."Voucher Int. No.6")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        VoucherCheck(Rec."Voucher Int. No.6");
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
                        CheckVouchAmt(Rec."Voucher Amount6", Rec."Voucher Int. No.6", Rec."Voucher PIN6");
                    end;
                }
                field(Cancel6; Rec.Cancel6)
                {
                    ApplicationArea = all;
                }
                field(Refund6; Rec.Refund6)
                {
                    ApplicationArea = all;
                }
            }
            group(Voucher7)
            {
                field("Voucher Int. No.7"; Rec."Voucher Int. No.7")
                {

                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        VoucherCheck(Rec."Voucher Int. No.7");
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
                        CheckVouchAmt(Rec."Voucher Amount7", Rec."Voucher Int. No.7", Rec."Voucher PIN7");
                    end;
                }
                field(Cancel7; Rec.Cancel7)
                {
                    ApplicationArea = all;
                }
                field(Refund7; Rec.Refund7)
                {
                    ApplicationArea = all;
                }
            }
            group(Voucher8)
            {
                field("Voucher Int. No.8"; Rec."Voucher Int. No.8")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        VoucherCheck(Rec."Voucher Int. No.8");
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
                        CheckVouchAmt(Rec."Voucher Amount8", Rec."Voucher Int. No.8", Rec."Voucher PIN8");
                    end;
                }
                field(Cancel8; Rec.Cancel8)
                {
                    ApplicationArea = all;
                }
                field(Refund8; Rec.Refund8)
                {
                    ApplicationArea = all;
                }
            }
            group(Voucher9)
            {
                field("Voucher Int. No.9"; Rec."Voucher Int. No.9")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        VoucherCheck(Rec."Voucher Int. No.9");
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
                        CheckVouchAmt(Rec."Voucher Amount9", Rec."Voucher Int. No.9", Rec."Voucher PIN9");
                    end;
                }
                field(Cancel9; Rec.Cancel9)
                {
                    ApplicationArea = all;
                }
                field(Refund9; Rec.Refund9)
                {
                    ApplicationArea = all;
                }
            }
            group(Voucher10)
            {
                field("Voucher Int. No.10"; Rec."Voucher Int. No.10")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        VoucherCheck(Rec."Voucher Int. No.10");
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
                        CheckVouchAmt(Rec."Voucher Amount10", Rec."Voucher Int. No.10", Rec."Voucher PIN10");
                    end;
                }
                field(Cancel10; Rec.Cancel10)
                {
                    ApplicationArea = all;
                }
                field(Refund10; Rec.Refund10)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(Group)
            {
                action("Update Voucher Details")
                {
                    Image = UpdateXML;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        RecSO: Record 36;
                    begin
                        RecSH.RESET;
                        RecSH.SETRANGE(RecSH."No.", Rec."SO No.");
                        IF RecSH.FINDFIRST THEN BEGIN
                            //RecSH.CALCFIELDS("Amount To Customer UPIT");//tk
                            IF RecSH."Amount To Customer UPIT" <> 0 THEN
                                IF (Rec."Voucher Amount1" + Rec."Voucher Amount2" + Rec."Voucher Amount3" + Rec."Voucher Amount4" + Rec."Voucher Amount5" + Rec."Voucher Amount6" + Rec."Voucher Amount7" + Rec."Voucher Amount8" + Rec."Voucher Amount9" + Rec."Voucher Amount10") > RecSH."Amount To Customer UPIT" THEN
                                    ERROR('Please check voucher Amount it can not be greater than Invoice Amount %1 ', RecSH."Amount To Customer UPIT");
                        END;

                        RecSO.RESET;
                        RecSO.SETRANGE("No.", Rec."SO No.");
                        IF RecSO.FINDFIRST THEN BEGIN
                            RecSO.VALIDATE("Voucher Amount", Rec."Voucher Amount1" + Rec."Voucher Amount2" + Rec."Voucher Amount3" + Rec."Voucher Amount4" + Rec."Voucher Amount5" + Rec."Voucher Amount6" + Rec."Voucher Amount7" + Rec."Voucher Amount8" + Rec."Voucher Amount9" + Rec."Voucher Amount10");
                            RecSO.MODIFY;
                            MESSAGE('Voucher details updated in SO successfully');
                        END;
                    end;
                }
                separator(Separator)
                {
                }

                action("Capture Voucher")
                {
                    Image = Camera;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF (Rec."Voucher Int. No.1" <> '') AND (Rec."Voucher Amount1" = 0) THEN
                            ERROR('PLease check voucher Amount');
                        IF (Rec."Voucher Int. No.2" <> '') AND (Rec."Voucher Amount2" = 0) THEN
                            ERROR('PLease check voucher Amount');
                        IF (Rec."Voucher Int. No.3" <> '') AND (Rec."Voucher Amount3" = 0) THEN
                            ERROR('PLease check voucher Amount');
                        IF (Rec."Voucher Int. No.4" <> '') AND (Rec."Voucher Amount4" = 0) THEN
                            ERROR('PLease check voucher Amount');
                        IF (Rec."Voucher Int. No.5" <> '') AND (Rec."Voucher Amount5" = 0) THEN
                            ERROR('PLease check voucher Amount');
                        IF (Rec."Voucher Int. No.6" <> '') AND (Rec."Voucher Amount6" = 0) THEN
                            ERROR('PLease check voucher Amount');
                        IF (Rec."Voucher Int. No.7" <> '') AND (Rec."Voucher Amount7" = 0) THEN
                            ERROR('PLease check voucher Amount');
                        IF (Rec."Voucher Int. No.8" <> '') AND (Rec."Voucher Amount8" = 0) THEN
                            ERROR('PLease check voucher Amount');
                        IF (Rec."Voucher Int. No.9" <> '') AND (Rec."Voucher Amount9" = 0) THEN
                            ERROR('PLease check voucher Amount');
                        IF (Rec."Voucher Int. No.10" <> '') AND (Rec."Voucher Amount10" = 0) THEN
                            ERROR('PLease check voucher Amount');
                        RecSH.RESET;
                        RecSH.SETRANGE(RecSH."No.", Rec."SO No.");
                        RecSH.SETFILTER(RecSH."Voucher Amount", '%1', 0);
                        IF RecSH.FINDFIRST THEN
                            ERROR('Please check if Voucher Amount has been captured or not in Voucher Integration Card page');

                        CurrPage.SETSELECTIONFILTER(Rec);
                        RecSOO.RESET;
                        RecSOO.SETRANGE("No.", Rec."SO No.");
                        IF RecSOO.FINDFIRST THEN;


                        IF RecCvouchCust.GET(RecSOO."Sell-to Customer No.") THEN BEGIN
                            RecCvouchCust.TESTFIELD(RecCvouchCust."E-Mail");
                            RecCvouchCust.TESTFIELD(RecCvouchCust."Phone No.");
                        END;
                        IF Rec."Voucher Amount1" <> 0 THEN BEGIN
                            GetVoucher.MapleCapture2(Rec."SO No.", RecSOO."Location Code", Rec."Voucher Int. No.1", Rec."Voucher PIN1");

                            RecEINV.RESET;
                            RecEINV.SETRANGE("Document No.", Rec."SO No.");
                            RecEINV.SETRANGE("Vouchr. Integration", TRUE);
                            RecEINV.SETFILTER("Vouchr. Authorization ID", '<>%1', '');
                            RecEINV.SETFILTER("Vouchr. Code", Rec."Voucher Int. No.1");
                            IF RecEINV.FINDLAST THEN
                                GetVoucher.MapleCapture2(Rec."SO No.", RecSOO."Location Code", Rec."Voucher Int. No.1", Rec."Voucher PIN1")
                            ELSE
                                ERROR('Please check if this voucher is Authorized successfully or not from log file');
                        END;

                        IF Rec."Voucher Amount2" <> 0 THEN BEGIN

                            RecEINV.RESET;
                            RecEINV.SETRANGE("Document No.", Rec."SO No.");
                            RecEINV.SETRANGE("Vouchr. Integration", TRUE);
                            RecEINV.SETFILTER("Vouchr. Authorization ID", '<>%1', '');
                            RecEINV.SETFILTER("Vouchr. Code", Rec."Voucher Int. No.2");
                            IF RecEINV.FINDLAST THEN
                                GetVoucher.MapleCapture2(Rec."SO No.", RecSOO."Location Code", Rec."Voucher Int. No.2", Rec."Voucher PIN2")
                            ELSE
                                ERROR('Please check if this voucher is Authorized successfully or not from log file');
                        END;

                        IF Rec."Voucher Amount3" <> 0 THEN BEGIN

                            RecEINV.RESET;
                            RecEINV.SETRANGE("Document No.", Rec."SO No.");
                            RecEINV.SETRANGE("Vouchr. Integration", TRUE);
                            RecEINV.SETFILTER("Vouchr. Authorization ID", '<>%1', '');
                            RecEINV.SETFILTER("Vouchr. Code", Rec."Voucher Int. No.3");
                            IF RecEINV.FINDLAST THEN
                                GetVoucher.MapleCapture2(Rec."SO No.", RecSOO."Location Code", Rec."Voucher Int. No.3", Rec."Voucher PIN3")
                            ELSE
                                ERROR('Please check if this voucher is Authorized successfully or not from log file');
                        END;

                        IF Rec."Voucher Amount4" <> 0 THEN BEGIN

                            RecEINV.RESET;
                            RecEINV.SETRANGE("Document No.", Rec."SO No.");
                            RecEINV.SETRANGE("Vouchr. Integration", TRUE);
                            RecEINV.SETFILTER("Vouchr. Authorization ID", '<>%1', '');
                            RecEINV.SETFILTER("Vouchr. Code", Rec."Voucher Int. No.4");
                            IF RecEINV.FINDLAST THEN
                                GetVoucher.MapleCapture2(Rec."SO No.", RecSOO."Location Code", Rec."Voucher Int. No.4", Rec."Voucher PIN4")
                            ELSE
                                ERROR('Please check if this voucher is Authorized successfully or not from log file');
                        END;

                        IF Rec."Voucher Amount5" <> 0 THEN BEGIN

                            RecEINV.RESET;
                            RecEINV.SETRANGE("Document No.", Rec."SO No.");
                            RecEINV.SETRANGE("Vouchr. Integration", TRUE);
                            RecEINV.SETFILTER("Vouchr. Authorization ID", '<>%1', '');
                            RecEINV.SETFILTER("Vouchr. Code", Rec."Voucher Int. No.5");
                            IF RecEINV.FINDLAST THEN
                                GetVoucher.MapleCapture2(Rec."SO No.", RecSOO."Location Code", Rec."Voucher Int. No.5", Rec."Voucher PIN5")
                            ELSE
                                ERROR('Please check if this voucher is Authorized successfully or not from log file');
                        END;

                        IF Rec."Voucher Amount6" <> 0 THEN BEGIN

                            RecEINV.RESET;
                            RecEINV.SETRANGE("Document No.", Rec."SO No.");
                            RecEINV.SETRANGE("Vouchr. Integration", TRUE);
                            RecEINV.SETFILTER("Vouchr. Authorization ID", '<>%1', '');
                            RecEINV.SETFILTER("Vouchr. Code", Rec."Voucher Int. No.6");
                            IF RecEINV.FINDLAST THEN
                                GetVoucher.MapleCapture2(Rec."SO No.", RecSOO."Location Code", Rec."Voucher Int. No.6", Rec."Voucher PIN6")
                            ELSE
                                ERROR('Please check if this voucher is Authorized successfully or not from log file');
                        END;

                        IF Rec."Voucher Amount7" <> 0 THEN BEGIN

                            RecEINV.RESET;
                            RecEINV.SETRANGE("Document No.", Rec."SO No.");
                            RecEINV.SETRANGE("Vouchr. Integration", TRUE);
                            RecEINV.SETFILTER("Vouchr. Authorization ID", '<>%1', '');
                            RecEINV.SETFILTER("Vouchr. Code", Rec."Voucher Int. No.7");
                            IF RecEINV.FINDLAST THEN
                                GetVoucher.MapleCapture2(Rec."SO No.", RecSOO."Location Code", Rec."Voucher Int. No.7", Rec."Voucher PIN7")
                            ELSE
                                ERROR('Please check if this voucher is Authorized successfully or not from log file');
                        END;

                        IF Rec."Voucher Amount8" <> 0 THEN BEGIN

                            RecEINV.RESET;
                            RecEINV.SETRANGE("Document No.", Rec."SO No.");
                            RecEINV.SETRANGE("Vouchr. Integration", TRUE);
                            RecEINV.SETFILTER("Vouchr. Authorization ID", '<>%1', '');
                            RecEINV.SETFILTER("Vouchr. Code", Rec."Voucher Int. No.8");
                            IF RecEINV.FINDLAST THEN
                                GetVoucher.MapleCapture2(Rec."SO No.", RecSOO."Location Code", Rec."Voucher Int. No.8", Rec."Voucher PIN8")
                            ELSE
                                ERROR('Please check if this voucher is Authorized successfully or not from log file');
                        END;

                        IF Rec."Voucher Amount9" <> 0 THEN BEGIN

                            RecEINV.RESET;
                            RecEINV.SETRANGE("Document No.", Rec."SO No.");
                            RecEINV.SETRANGE("Vouchr. Integration", TRUE);
                            RecEINV.SETFILTER("Vouchr. Authorization ID", '<>%1', '');
                            RecEINV.SETFILTER("Vouchr. Code", Rec."Voucher Int. No.9");
                            IF RecEINV.FINDLAST THEN
                                GetVoucher.MapleCapture2(Rec."SO No.", RecSOO."Location Code", Rec."Voucher Int. No.9", Rec."Voucher PIN9")
                            ELSE
                                ERROR('Please check if this voucher is Authorized successfully or not from log file');
                        END;

                        IF Rec."Voucher Amount10" <> 0 THEN BEGIN

                            RecEINV.RESET;
                            RecEINV.SETRANGE("Document No.", Rec."SO No.");
                            RecEINV.SETRANGE("Vouchr. Integration", TRUE);
                            RecEINV.SETFILTER("Vouchr. Authorization ID", '<>%1', '');
                            RecEINV.SETFILTER("Vouchr. Code", Rec."Voucher Int. No.10");
                            IF RecEINV.FINDLAST THEN
                                GetVoucher.MapleCapture2(Rec."SO No.", RecSOO."Location Code", Rec."Voucher Int. No.10", Rec."Voucher PIN10")
                            ELSE
                                ERROR('Please check if this voucher is Authorized successfully or not from log file');
                        END;

                    end;
                }
                action("Cancel Authorization")
                {
                    Image = CancelAllLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        RecSO: Record 36;
                    begin

                        /* Rec.TESTFIELD(Rec."Location Code");
                         RecEINV.RESET;
                         RecEINV.SETRANGE("Document No.","No.");
                         RecEINV.SETRANGE("Vouchr. Integration",TRUE);
                         RecEINV.SETFILTER("Vouchr. Authorization ID",'<>%1','');
                         IF RecEINV.FINDLAST THEN
                         GetVoucher.MapleCancelAuthorization1("No.","Location Code")
                         ELSE
                           ERROR('Please check if this voucher is Authorized successfully or not from log file');
                          */
                        RecSOO.RESET;
                        RecSOO.SETRANGE(RecSOO."No.", Rec."SO No.");
                        IF RecSOO.FINDFIRST THEN;

                        IF Rec.Cancel1 = TRUE THEN BEGIN
                            RecEINV.RESET;
                            RecEINV.SETRANGE(RecEINV."Document No.", Rec."SO No.");
                            RecEINV.SETRANGE(RecEINV."Vouchr. Integration", TRUE);
                            RecEINV.SETFILTER(RecEINV."Vouchr. Authorization ID", '<>%1', '');
                            RecEINV.SETFILTER(RecEINV."Vouchr. Code", Rec."Voucher Int. No.1");
                            IF RecEINV.FINDLAST THEN
                                GetVoucher.MapleCancelAuthorization2(Rec."SO No.", RecSOO."Location Code", Rec."Voucher Int. No.1", Rec."Voucher PIN1")
                            ELSE
                                ERROR('Please check if this voucher is Authorized successfully or not from log file');
                        END;


                        IF Rec.Cancel2 = TRUE THEN BEGIN
                            RecEINV.RESET;
                            RecEINV.SETRANGE(RecEINV."Document No.", Rec."SO No.");
                            RecEINV.SETRANGE(RecEINV."Vouchr. Integration", TRUE);
                            RecEINV.SETFILTER(RecEINV."Vouchr. Authorization ID", '<>%1', '');
                            RecEINV.SETFILTER(RecEINV."Vouchr. Code", Rec."Voucher Int. No.2");
                            IF RecEINV.FINDLAST THEN
                                GetVoucher.MapleCancelAuthorization2(Rec."SO No.", RecSOO."Location Code", Rec."Voucher Int. No.2", Rec."Voucher PIN2")
                            ELSE
                                ERROR('Please check if this voucher is Authorized successfully or not from log file');
                        END;

                        IF Rec.Cancel3 = TRUE THEN BEGIN
                            RecEINV.RESET;
                            RecEINV.SETRANGE(RecEINV."Document No.", Rec."SO No.");
                            RecEINV.SETRANGE(RecEINV."Vouchr. Integration", TRUE);
                            RecEINV.SETFILTER(RecEINV."Vouchr. Authorization ID", '<>%1', '');
                            RecEINV.SETFILTER(RecEINV."Vouchr. Code", Rec."Voucher Int. No.3");
                            IF RecEINV.FINDLAST THEN
                                GetVoucher.MapleCancelAuthorization2(Rec."SO No.", RecSOO."Location Code", Rec."Voucher Int. No.3", Rec."Voucher PIN3")
                            ELSE
                                ERROR('Please check if this voucher is Authorized successfully or not from log file');
                        END;
                        IF Rec.Cancel4 = TRUE THEN BEGIN
                            RecEINV.RESET;
                            RecEINV.SETRANGE("Document No.", Rec."SO No.");
                            RecEINV.SETRANGE("Vouchr. Integration", TRUE);
                            RecEINV.SETFILTER("Vouchr. Authorization ID", '<>%1', '');
                            RecEINV.SETFILTER("Vouchr. Code", Rec."Voucher Int. No.4");
                            IF RecEINV.FINDLAST THEN
                                GetVoucher.MapleCancelAuthorization2(Rec."SO No.", RecSOO."Location Code", Rec."Voucher Int. No.4", Rec."Voucher PIN4")
                            ELSE
                                ERROR('Please check if this voucher is Authorized successfully or not from log file');
                        END;
                        IF Rec.Cancel5 = TRUE THEN BEGIN
                            RecEINV.RESET;
                            RecEINV.SETRANGE("Document No.", Rec."SO No.");
                            RecEINV.SETRANGE("Vouchr. Integration", TRUE);
                            RecEINV.SETFILTER("Vouchr. Authorization ID", '<>%1', '');
                            RecEINV.SETFILTER("Vouchr. Code", Rec."Voucher Int. No.5");
                            IF RecEINV.FINDLAST THEN
                                GetVoucher.MapleCancelAuthorization2(Rec."SO No.", RecSOO."Location Code", Rec."Voucher Int. No.5", Rec."Voucher PIN5")
                            ELSE
                                ERROR('Please check if this voucher is Authorized successfully or not from log file');
                        END;//tk

                        IF Rec.Cancel6 = TRUE THEN BEGIN
                            RecEINV.RESET;
                            RecEINV.SETRANGE("Document No.", Rec."SO No.");
                            RecEINV.SETRANGE("Vouchr. Integration", TRUE);
                            RecEINV.SETFILTER("Vouchr. Authorization ID", '<>%1', '');
                            RecEINV.SETFILTER("Vouchr. Code", Rec."Voucher Int. No.6");
                            IF RecEINV.FINDLAST THEN
                                GetVoucher.MapleCancelAuthorization2(Rec."SO No.", RecSOO."Location Code", Rec."Voucher Int. No.6", Rec."Voucher PIN6")
                            ELSE
                                ERROR('Please check if this voucher is Authorized successfully or not from log file');
                        END;//tk
                        IF Rec.Cancel7 = TRUE THEN BEGIN
                            RecEINV.RESET;
                            RecEINV.SETRANGE("Document No.", Rec."SO No.");
                            RecEINV.SETRANGE("Vouchr. Integration", TRUE);
                            RecEINV.SETFILTER("Vouchr. Authorization ID", '<>%1', '');
                            RecEINV.SETFILTER("Vouchr. Code", Rec."Voucher Int. No.7");
                            IF RecEINV.FINDLAST THEN
                                GetVoucher.MapleCancelAuthorization2(Rec."SO No.", RecSOO."Location Code", Rec."Voucher Int. No.7", Rec."Voucher PIN7")
                            ELSE
                                ERROR('Please check if this voucher is Authorized successfully or not from log file');
                        END;
                        IF Rec.Cancel8 = TRUE THEN BEGIN
                            RecEINV.RESET;
                            RecEINV.SETRANGE("Document No.", Rec."SO No.");
                            RecEINV.SETRANGE("Vouchr. Integration", TRUE);
                            RecEINV.SETFILTER("Vouchr. Authorization ID", '<>%1', '');
                            RecEINV.SETFILTER("Vouchr. Code", Rec."Voucher Int. No.8");
                            IF RecEINV.FINDLAST THEN
                                GetVoucher.MapleCancelAuthorization2(Rec."SO No.", RecSOO."Location Code", Rec."Voucher Int. No.8", Rec."Voucher PIN8")
                            ELSE
                                ERROR('Please check if this voucher is Authorized successfully or not from log file');
                        END;
                        IF Rec.Cancel9 = TRUE THEN BEGIN
                            RecEINV.RESET;
                            RecEINV.SETRANGE("Document No.", Rec."SO No.");
                            RecEINV.SETRANGE("Vouchr. Integration", TRUE);
                            RecEINV.SETFILTER("Vouchr. Authorization ID", '<>%1', '');
                            RecEINV.SETFILTER("Vouchr. Code", Rec."Voucher Int. No.9");
                            IF RecEINV.FINDLAST THEN
                                GetVoucher.MapleCancelAuthorization2(Rec."SO No.", RecSOO."Location Code", Rec."Voucher Int. No.1", Rec."Voucher PIN9")
                            ELSE
                                ERROR('Please check if this voucher is Authorized successfully or not from log file');
                        END;
                        IF Rec.Cancel10 = TRUE THEN BEGIN
                            RecEINV.RESET;
                            RecEINV.SETRANGE("Document No.", Rec."SO No.");
                            RecEINV.SETRANGE("Vouchr. Integration", TRUE);
                            RecEINV.SETFILTER("Vouchr. Authorization ID", '<>%1', '');
                            RecEINV.SETFILTER("Vouchr. Code", Rec."Voucher Int. No.10");
                            IF RecEINV.FINDLAST THEN
                                GetVoucher.MapleCancelAuthorization2(Rec."SO No.", RecSOO."Location Code", Rec."Voucher Int. No.10", Rec."Voucher PIN10")
                            ELSE
                                ERROR('Please check if this voucher is Authorized successfully or not from log file');
                        END;


                        RecSO.RESET;
                        RecSO.SETRANGE("No.", Rec."SO No.");
                        IF RecSO.FINDFIRST THEN BEGIN
                            RecSO.VALIDATE("Voucher Amount", Rec."Voucher Amount1" + Rec."Voucher Amount2" + Rec."Voucher Amount3" + Rec."Voucher Amount4" + Rec."Voucher Amount5" + Rec."Voucher Amount6" + Rec."Voucher Amount7" + Rec."Voucher Amount8" + Rec."Voucher Amount9" + Rec."Voucher Amount10");
                            RecSO.MODIFY;
                            // MESSAGE('Voucher details updated in SO successfully');
                        END;

                    end;//tk

                }

                action("Refund Voucher")
                {
                    Image = Return;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        RecSO: Record 36;
                    begin
                        /*
                        TESTFIELD("Location Code");
                        RecEINV.RESET;
                        RecEINV.SETRANGE("Document No.","No.");
                        RecEINV.SETRANGE("Vouchr. Integration",TRUE);
                        RecEINV.SETFILTER("Vouchr. Capture id",'<>%1','');
                        IF RecEINV.FINDLAST THEN BEGIN
                        GetVoucher.MapleRefund1("No.","Location Code");
                          "Voucher Amount":=0;
                        END ELSE
                          ERROR('Please check if this voucher is Captured successfully or not from log file');
                          */

                        RecSOO.RESET;
                        RecSOO.SETRANGE("No.", Rec."SO No.");
                        IF RecSOO.FINDFIRST THEN;

                        IF Rec.Refund1 = TRUE THEN BEGIN
                            RecEINV.RESET;
                            RecEINV.SETRANGE("Document No.", Rec."SO No.");
                            RecEINV.SETRANGE("Vouchr. Integration", TRUE);
                            RecEINV.SETFILTER("Vouchr. Capture id", '<>%1', '');
                            RecEINV.SETFILTER("Vouchr. Code", Rec."Voucher Int. No.1");
                            IF RecEINV.FINDLAST THEN BEGIN
                                GetVoucher.MapleRefund2(Rec."SO No.", RecSOO."Location Code", Rec."Voucher Int. No.1", Rec."Voucher PIN1");
                                Rec."Voucher Amount1" := 0;
                            END ELSE
                                ERROR('Please check if this voucher is Captured successfully or not from log file');
                        END;

                        IF Rec.Refund2 = TRUE THEN BEGIN
                            RecEINV.RESET;
                            RecEINV.SETRANGE("Document No.", Rec."SO No.");
                            RecEINV.SETRANGE("Vouchr. Integration", TRUE);
                            RecEINV.SETFILTER("Vouchr. Capture id", '<>%1', '');
                            RecEINV.SETFILTER("Vouchr. Code", Rec."Voucher Int. No.2");
                            IF RecEINV.FINDLAST THEN BEGIN
                                GetVoucher.MapleRefund2(Rec."SO No.", RecSOO."Location Code", Rec."Voucher Int. No.2", Rec."Voucher PIN2");
                                Rec."Voucher Amount2" := 0;
                            END ELSE
                                ERROR('Please check if this voucher is Captured successfully or not from log file');
                        END;
                        IF Rec.Refund3 = TRUE THEN BEGIN
                            RecEINV.RESET;
                            RecEINV.SETRANGE("Document No.", Rec."SO No.");
                            RecEINV.SETRANGE("Vouchr. Integration", TRUE);
                            RecEINV.SETFILTER("Vouchr. Capture id", '<>%1', '');
                            RecEINV.SETFILTER("Vouchr. Code", Rec."Voucher Int. No.3");
                            IF RecEINV.FINDLAST THEN BEGIN
                                GetVoucher.MapleRefund2(Rec."SO No.", RecSOO."Location Code", Rec."Voucher Int. No.3", Rec."Voucher PIN3");
                                Rec."Voucher Amount3" := 0;
                            END ELSE
                                ERROR('Please check if this voucher is Captured successfully or not from log file');
                        END;
                        IF Rec.Refund4 = TRUE THEN BEGIN
                            RecEINV.RESET;
                            RecEINV.SETRANGE("Document No.", Rec."SO No.");
                            RecEINV.SETRANGE("Vouchr. Integration", TRUE);
                            RecEINV.SETFILTER("Vouchr. Capture id", '<>%1', '');
                            RecEINV.SETFILTER("Vouchr. Code", Rec."Voucher Int. No.4");
                            IF RecEINV.FINDLAST THEN BEGIN
                                GetVoucher.MapleRefund2(Rec."SO No.", RecSOO."Location Code", Rec."Voucher Int. No.4", Rec."Voucher PIN4");
                                Rec."Voucher Amount4" := 0;
                            END ELSE
                                ERROR('Please check if this voucher is Captured successfully or not from log file');
                        END;
                        IF Rec.Refund5 = TRUE THEN BEGIN
                            RecEINV.RESET;
                            RecEINV.SETRANGE("Document No.", Rec."SO No.");
                            RecEINV.SETRANGE("Vouchr. Integration", TRUE);
                            RecEINV.SETFILTER("Vouchr. Capture id", '<>%1', '');
                            RecEINV.SETFILTER("Vouchr. Code", Rec."Voucher Int. No.5");
                            IF RecEINV.FINDLAST THEN BEGIN
                                GetVoucher.MapleRefund2(Rec."SO No.", RecSOO."Location Code", Rec."Voucher Int. No.5", Rec."Voucher PIN5");
                                Rec."Voucher Amount5" := 0;
                            END ELSE
                                ERROR('Please check if this voucher is Captured successfully or not from log file');
                        END;
                        IF Rec.Refund6 = TRUE THEN BEGIN
                            RecEINV.RESET;
                            RecEINV.SETRANGE("Document No.", Rec."SO No.");
                            RecEINV.SETRANGE("Vouchr. Integration", TRUE);
                            RecEINV.SETFILTER("Vouchr. Capture id", '<>%1', '');
                            RecEINV.SETFILTER("Vouchr. Code", Rec."Voucher Int. No.6");
                            IF RecEINV.FINDLAST THEN BEGIN
                                GetVoucher.MapleRefund2(Rec."SO No.", RecSOO."Location Code", Rec."Voucher Int. No.6", Rec."Voucher PIN6");
                                Rec."Voucher Amount6" := 0;
                            END ELSE
                                ERROR('Please check if this voucher is Captured successfully or not from log file');
                        END;
                        IF Rec.Refund7 = TRUE THEN BEGIN
                            RecEINV.RESET;
                            RecEINV.SETRANGE("Document No.", Rec."SO No.");
                            RecEINV.SETRANGE("Vouchr. Integration", TRUE);
                            RecEINV.SETFILTER("Vouchr. Capture id", '<>%1', '');
                            RecEINV.SETFILTER("Vouchr. Code", Rec."Voucher Int. No.7");
                            IF RecEINV.FINDLAST THEN BEGIN
                                GetVoucher.MapleRefund2(Rec."SO No.", RecSOO."Location Code", Rec."Voucher Int. No.1", Rec."Voucher PIN7");
                                Rec."Voucher Amount7" := 0;
                            END ELSE
                                ERROR('Please check if this voucher is Captured successfully or not from log file');
                        END;
                        IF Rec.Refund8 = TRUE THEN BEGIN
                            RecEINV.RESET;
                            RecEINV.SETRANGE("Document No.", Rec."SO No.");
                            RecEINV.SETRANGE("Vouchr. Integration", TRUE);
                            RecEINV.SETFILTER("Vouchr. Capture id", '<>%1', '');
                            RecEINV.SETFILTER("Vouchr. Code", Rec."Voucher Int. No.8");
                            IF RecEINV.FINDLAST THEN BEGIN
                                GetVoucher.MapleRefund2(Rec."SO No.", RecSOO."Location Code", Rec."Voucher Int. No.8", Rec."Voucher PIN8");
                                Rec."Voucher Amount8" := 0;
                            END ELSE
                                ERROR('Please check if this voucher is Captured successfully or not from log file');
                        END;
                        IF Rec.Refund9 = TRUE THEN BEGIN
                            RecEINV.RESET;
                            RecEINV.SETRANGE("Document No.", Rec."SO No.");
                            RecEINV.SETRANGE("Vouchr. Integration", TRUE);
                            RecEINV.SETFILTER("Vouchr. Capture id", '<>%1', '');
                            RecEINV.SETFILTER("Vouchr. Code", Rec."Voucher Int. No.9");
                            IF RecEINV.FINDLAST THEN BEGIN
                                GetVoucher.MapleRefund2(Rec."SO No.", RecSOO."Location Code", Rec."Voucher Int. No.9", Rec."Voucher PIN9");
                                Rec."Voucher Amount9" := 0;
                            END ELSE
                                ERROR('Please check if this voucher is Captured successfully or not from log file');
                        END;
                        IF Rec.Refund10 = TRUE THEN BEGIN
                            RecEINV.RESET;
                            RecEINV.SETRANGE("Document No.", Rec."SO No.");
                            RecEINV.SETRANGE("Vouchr. Integration", TRUE);
                            RecEINV.SETFILTER("Vouchr. Capture id", '<>%1', '');
                            RecEINV.SETFILTER("Vouchr. Code", Rec."Voucher Int. No.10");
                            IF RecEINV.FINDLAST THEN BEGIN
                                GetVoucher.MapleRefund2(Rec."SO No.", RecSOO."Location Code", Rec."Voucher Int. No.10", Rec."Voucher PIN10");
                                Rec."Voucher Amount10" := 0;
                            END ELSE
                                ERROR('Please check if this voucher is Captured successfully or not from log file');
                        END;

                        RecSO.RESET;
                        RecSO.SETRANGE("No.", Rec."SO No.");
                        IF RecSO.FINDFIRST THEN BEGIN
                            RecSO.VALIDATE("Voucher Amount", Rec."Voucher Amount1" + Rec."Voucher Amount2" + Rec."Voucher Amount3" + Rec."Voucher Amount4" + Rec."Voucher Amount5" + Rec."Voucher Amount6" + Rec."Voucher Amount7" + Rec."Voucher Amount8" + Rec."Voucher Amount9" + Rec."Voucher Amount10");
                            RecSO.MODIFY;
                            // MESSAGE('Voucher details updated in SO successfully');
                        END;

                    end;
                }
            }
        }
    }

    trigger OnModifyRecord(): Boolean
    begin
        RecSIVVVV.RESET;
        RecSIVVVV.SETRANGE("Order No.", Rec."SO No.");
        IF RecSIVVVV.FINDFIRST THEN
            ERROR('Not allowed to modify');
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin

        IF Rec."Voucher Int. No.1" <> '' THEN BEGIN

            RecEINV.RESET;
            RecEINV.SETCURRENTKEY("Vouchr. Code");
            RecEINV.SETRANGE("Document No.", Rec."SO No.");
            RecEINV.SETRANGE("Vouchr. Integration", TRUE);
            RecEINV.SETFILTER("Vouchr. Code", Rec."Voucher Int. No.1");
            IF RecEINV.FINDLAST THEN BEGIN
                IF RecEINV."Vouchr. Capture id" = '' THEN
                    ERROR('Please check if this voucher is Captured successfully or not from log file %1', Rec."Voucher Int. No.1");
            END;
        END;

        IF Rec."Voucher Int. No.2" <> '' THEN BEGIN
            RecEINV.RESET;
            RecEINV.SETCURRENTKEY("Vouchr. Code");
            RecEINV.SETRANGE("Document No.", Rec."SO No.");
            RecEINV.SETRANGE("Vouchr. Integration", TRUE);
            RecEINV.SETFILTER("Vouchr. Code", Rec."Voucher Int. No.2");
            IF RecEINV.FINDLAST THEN BEGIN
                IF RecEINV."Vouchr. Capture id" = '' THEN
                    ERROR('Please check if this voucher is Captured successfully or not from log file %1', Rec."Voucher Int. No.2");
            END;
        END;

        IF Rec."Voucher Int. No.3" <> '' THEN BEGIN
            RecEINV.RESET;
            RecEINV.SETCURRENTKEY("Vouchr. Code");
            RecEINV.SETRANGE("Document No.", Rec."SO No.");
            RecEINV.SETRANGE("Vouchr. Integration", TRUE);
            RecEINV.SETFILTER("Vouchr. Code", Rec."Voucher Int. No.3");
            IF RecEINV.FINDLAST THEN BEGIN
                IF RecEINV."Vouchr. Capture id" = '' THEN
                    ERROR('Please check if this voucher is Captured successfully or not from log file %1', Rec."Voucher Int. No.3");
            END;
        END;


        IF Rec."Voucher Int. No.4" <> '' THEN BEGIN
            RecEINV.RESET;
            RecEINV.SETCURRENTKEY("Vouchr. Code");
            RecEINV.SETRANGE("Document No.", Rec."SO No.");
            RecEINV.SETRANGE("Vouchr. Integration", TRUE);


            RecEINV.SETFILTER("Vouchr. Code", Rec."Voucher Int. No.4");
            IF RecEINV.FINDLAST THEN BEGIN
                IF RecEINV."Vouchr. Capture id" = '' THEN
                    ERROR('Please check if this voucher is Captured successfully or not from log file %1', Rec."Voucher Int. No.4");
            END;
        END;

        IF Rec."Voucher Int. No.5" <> '' THEN BEGIN
            RecEINV.RESET;
            RecEINV.SETCURRENTKEY("Vouchr. Code");
            RecEINV.SETRANGE("Document No.", Rec."SO No.");
            RecEINV.SETRANGE("Vouchr. Integration", TRUE);
            RecEINV.SETFILTER("Vouchr. Code", Rec."Voucher Int. No.5");
            IF RecEINV.FINDLAST THEN BEGIN
                IF RecEINV."Vouchr. Capture id" = '' THEN
                    ERROR('Please check if this voucher is Captured successfully or not from log file %1', Rec."Voucher Int. No.5");
            END;
        END;
        IF Rec."Voucher Int. No.6" <> '' THEN BEGIN
            RecEINV.RESET;
            RecEINV.SETCURRENTKEY("Vouchr. Code");
            RecEINV.SETRANGE("Document No.", Rec."SO No.");
            RecEINV.SETRANGE("Vouchr. Integration", TRUE);

            RecEINV.SETFILTER("Vouchr. Code", Rec."Voucher Int. No.6");
            IF RecEINV.FINDLAST THEN BEGIN
                IF RecEINV."Vouchr. Capture id" = '' THEN
                    ERROR('Please check if this voucher is Captured successfully or not from log file %1', Rec."Voucher Int. No.6");
            END;
        END;
        IF Rec."Voucher Int. No.7" <> '' THEN BEGIN
            RecEINV.RESET;
            RecEINV.SETCURRENTKEY("Vouchr. Code");
            RecEINV.SETRANGE("Document No.", Rec."SO No.");
            RecEINV.SETRANGE("Vouchr. Integration", TRUE);

            RecEINV.SETFILTER("Vouchr. Code", Rec."Voucher Int. No.7");
            IF RecEINV.FINDLAST THEN BEGIN
                IF RecEINV."Vouchr. Capture id" = '' THEN
                    ERROR('Please check if this voucher is Captured successfully or not from log file %1', Rec."Voucher Int. No.7");
            END;
        END;
        IF Rec."Voucher Int. No.8" <> '' THEN BEGIN
            RecEINV.RESET;
            RecEINV.SETCURRENTKEY("Vouchr. Code");
            RecEINV.SETRANGE("Document No.", Rec."SO No.");
            RecEINV.SETRANGE("Vouchr. Integration", TRUE);


            RecEINV.SETFILTER("Vouchr. Code", Rec."Voucher Int. No.8");
            IF RecEINV.FINDLAST THEN BEGIN
                IF RecEINV."Vouchr. Capture id" = '' THEN
                    ERROR('Please check if this voucher is Captured successfully or not from log file %1', Rec."Voucher Int. No.8");
            END;
        END;

        IF Rec."Voucher Int. No.9" <> '' THEN BEGIN
            RecEINV.RESET;
            RecEINV.SETCURRENTKEY("Vouchr. Code");
            RecEINV.SETRANGE("Document No.", Rec."SO No.");
            RecEINV.SETRANGE("Vouchr. Integration", TRUE);


            RecEINV.SETFILTER("Vouchr. Code", Rec."Voucher Int. No.9");
            IF RecEINV.FINDLAST THEN BEGIN
                IF RecEINV."Vouchr. Capture id" = '' THEN
                    ERROR('Please check if this voucher is Captured successfully or not from log file %1', Rec."Voucher Int. No.9");
            END;
        END;

        IF Rec."Voucher Int. No.10" <> '' THEN BEGIN
            RecEINV.RESET;
            RecEINV.SETCURRENTKEY("Vouchr. Code");
            RecEINV.SETRANGE("Document No.", Rec."SO No.");
            RecEINV.SETRANGE("Vouchr. Integration", TRUE);
            RecEINV.SETFILTER("Vouchr. Code", Rec."Voucher Int. No.10");
            IF RecEINV.FINDLAST THEN BEGIN
                IF RecEINV."Vouchr. Capture id" = '' THEN
                    ERROR('Please check if this voucher is Captured successfully or not from log file %1', Rec."Voucher Int. No.10");
            END;
        END;
    end;

    var
        RecSIH: Record 112;
        GetVoucher: Codeunit 50018;
        RecSH: Record 36;
        RecEINV: Record 50015;
        RecCvouchCust: Record 18;
        RecEINV1: Record 50015;
        RecLoc: Record 14;
        RecSOO: Record 36;
        Amt: Decimal;
        RecSIVVVV: Record 112;

    local procedure VoucherCheck(VoucherN: Text[20])
    begin
        RecSOO.RESET;
        RecSOO.SETRANGE("No.", Rec."SO No.");
        IF RecSOO.FINDFIRST THEN;
        IF RecLoc.GET(RecSOO."Location Code") THEN BEGIN
            IF RecLoc."E-Invoice User ID" = '' THEN
                ERROR('Not allowed to perform for this location');
            IF RecLoc."E-Invoice Password" = '' THEN
                ERROR('Not allowed to perform for this location');
        END;
        IF RecCvouchCust.GET(RecSOO."Sell-to Customer No.") THEN BEGIN
            RecCvouchCust.TESTFIELD("E-Mail");
            RecCvouchCust.TESTFIELD("Phone No.");
        END;

        IF VoucherN <> '' THEN BEGIN
            /*
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
            ERROR('Input Voucher code is used/Redeemed %1',RecSIH."No.");
          END;END;
           // ERROR('Input Voucher code is used/Redeemed %1',RecSIH."No.");
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
            ERROR('Input Voucher code is used/Redeemed %1',RecSH."No.");
          END;END;

          //GetVoucher.GetVoucher("Voucher Int. No.","Location Code");
          END;
          *///29062021
            GetVoucher.GetVoucher(VoucherN, RecSOO."Location Code");//tk
        END;

    end;

    local procedure CheckVouchAmt(VouchAmt: Decimal; VoucherN: Text[20]; VouchPIN: Text[20])
    var
        RecSOH: Record 36;
    begin
        RecSOH.RESET;
        RecSOH.SETRANGE("No.", Rec."SO No.");
        IF RecSOH.FINDFIRST THEN;

        IF VouchAmt <> 0 THEN
            IF (VouchPIN = '') OR (VoucherN = '') THEN
                ERROR('Please check voucher code/pin can not be blank');

        IF VouchAmt <> 0 THEN BEGIN
            IF VouchAmt < 0 THEN
                ERROR('Amount must be positive');

            Amt := GetVoucher.GetVoucherAmt(VoucherN, RecSOH."Location Code");
            IF VouchAmt > Amt THEN
                ERROR('Available amount is %1', Amt);
            GetVoucher.MapleAuth(VouchAmt, VoucherN, VouchPIN, Rec."SO No.", RecSOH."Location Code");
        END;
    end;
}

