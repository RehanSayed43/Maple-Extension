page 50007 "Deposit Cheques"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = 50006;
    ApplicationArea = FixedAsset;
    //SourceTableView = WHERE(Field50002 = CONST(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                // field(Deposit; Deposit)
                // {
                // }
                // field("Account Type"; "Account Type")
                // {
                // }
                field(_shipping_email; Rec._shipping_email)
                {
                    ApplicationArea = All;
                }
                // field("Customer No."; "Customer No.")
                // {
                //     Caption = 'Customer/Vendor No.';
                // }
                field(CustomerName; CustomerName)
                {
                    Caption = 'Name';
                    ApplicationArea = All;
                }
                // field("Cheque No."; "Cheque No.")
                // {
                // }
                // field("Cheque Date"; "Cheque Date")
                // {
                //     Editable = false;
                // }
                // field(Amount; Amount)
                // {
                // }
                // field("MICR Code"; "MICR Code")
                // {
                // }
                // field("Issued Bank Branch"; "Issued Bank Branch")
                // {
                // }
                // field("Bank Deposit Code"; "Bank Deposit Code")
                // {
                // }
                // field("Vendor confimation"; "Vendor confimation")
                // {
                //     Visible = false;
                // }
            }
        }
        area(factboxes)
        {
            part(part; 9082)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("<Action59>")
            {
                Caption = 'F&unctions';
                action("<Action61>")
                {
                    Caption = 'Post Cheques';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //PostCheques;//tk
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action(Open)
                {
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        recPDC.SETFILTER(recPDC."Entry No.", FORMAT(Rec.discount_total));
                        IF recPDC.FINDFIRST THEN BEGIN
                            recPDC."Sent to Bank" := FALSE;
                            //recPDC."Res Center" := recPDC."Res Center"::"0";
                        END;
                        recPDC.MODIFY;

                        Rec.DELETE;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF Rec._shipping_email <> '' THEN
            ResCenter.GET(Rec._shipping_email);

        // IF "Customer No." <> '' THEN BEGIN
        //     IF "Account Type" = "Account Type"::"1" THEN BEGIN
        //         Vendor.GET("Customer No.");
        //         CustomerName := Vendor.Name;
        //     END
        //     ELSE BEGIN
        //         Customer.GET("Customer No.");
        //         CustomerName := Customer.Name;
        //     END;
    END;
    //end;

    trigger OnClosePage()
    begin
        //DepCheques.RESET;
        //DepCheques.DELETEALL;
    end;

    trigger OnOpenPage()
    begin
        //GetCheques(PDCDate);//tk
    end;

    var
        PDCDate: Date;
        DepCheques: Record 50006;
        ResCenter: Record 50000;
        Customer: Record 18;
        recPDC: Record 50002;
        CustomerName: Text[100];
        Vendor: Record 23;
}

