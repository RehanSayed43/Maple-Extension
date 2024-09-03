report 50178 "Bulk Sales Orders"
{
    ProcessingOnly = true;
    UseRequestPage = false;
    ApplicationArea = FixedAsset;

    dataset
    {
        dataitem("CRM Integration"; "CRM Integration")
        {
            DataItemTableView = SORTING("Customer No.", "CRM invoice No", "No.")
                                ORDER(Ascending)
                                WHERE("Order Created" = CONST(False));

            trigger OnAfterGetRecord()
            begin
                CurrCRM := "CRM Integration"."CRM invoice No";
                IF PrevCRM <> CurrCRM THEN BEGIN
                    PrevCRM := "CRM Integration"."CRM invoice No";
                    CreateSalesOrder;



                END ELSE BEGIN
                    "CRM Integration"."Order Created" := TRUE;
                    "CRM Integration".MODIFY;
                    CurrReport.SKIP;
                END;
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

    var
        qty: Decimal;
        RecLoc: Record Location;
        SalesPost: Codeunit "Sales-Post (Yes/No)";
        RecCRMInt: Record "CRM Integration";
        RecGenJnlLine: Record "Gen. Journal Line";
        LineNo1: Integer;
        GenJnlPostLine: Codeunit 12;
        DoucNo: Code[20];
        NoSeriesMgt: Codeunit 396;
        SRsetup: Record "Sales & Receivables Setup";
        CurrCRM: Code[20];
        PrevCRM: Code[20];
        RecCust: Record Customer;
        RecSalesInv: Record "Sales Invoice Header";
        SO_No: Code[20];
        RecSL1: Record "Sales Line";
        Rec_TransferHead: Record "Transfer Header";
        Rec_TransferLine: Record "Transfer Line";
        Gen_Batch: Record "Gen. Journal Batch";
        Tline_no: Integer;
        j: Integer;
        InvSetup: Record "Inventory Setup";
        RecCrmIn: Record "CRM Integration";
        GenJnlPostLine1: Codeunit 12;
        amt: Decimal;


    procedure CreateSalesOrder()
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SRsetup: Record "Sales & Receivables Setup";
        RecSH: Record "Sales Header";
        line_no: Integer;
        RecLocation: Record Location;
        Output_File_Path: Text;
        RecSL: Record "Sales Line";
        cnt: Integer;
        i: Integer;
        RecItem: Record Item;
    begin
        IF NOT "CRM Integration"."Order Created" THEN BEGIN
            RecCust.RESET;
            RecCust.SETRANGE("No.", "CRM Integration"."Customer No.");
            //RecCust.SETRANGE("CRM Mobile No.","CRM Integration"."Mobile No.");
            IF RecCust.FINDFIRST THEN BEGIN
                //Sales Header Insert

                RecSH.INIT;
                CLEAR(SO_No);
                SRsetup.GET;

                IF "CRM Integration"."Document Type" = "CRM Integration"."Document Type"::"Credit Memo" THEN
                    SO_No := NoSeriesMgt.GetNextNo(SRsetup."Credit Memo Nos.", "CRM Integration"."Posting Date", TRUE);
                RecSH."No." := SO_No;
                RecSH."Sales Order Type" := RecSH."Sales Order Type"::Retail;
                RecSH."Document Type" := "CRM Integration"."Document Type";
                RecSH.CRM := TRUE;
                RecSH.VALIDATE("Sell-to Customer No.", RecCust."No.");
                RecSH.VALIDATE("Bill-to Customer No.", RecCust."No.");
                RecSH.VALIDATE("Sales Order Type", RecSH."Sales Order Type"::Retail);
                RecSH.VALIDATE("Location Code", "CRM Integration"."Location Code");
                //  RecSH.VALIDATE(Structure, "CRM Integration".Structure);
                RecSH."External Document No." := "CRM Integration"."CRM invoice No";
                RecSH.VALIDATE("Posting Date", "CRM Integration"."Posting Date");
                RecSH.VALIDATE("Document Date", "CRM Integration"."Document Date");
                RecSH.VALIDATE("Salesperson Code", "CRM Integration"."SalesPerson Code");//Addded
                IF RecSH."Document Type" = RecSH."Document Type"::"Credit Memo" THEN BEGIN
                    RecSH.VALIDATE("Applies-to Doc. Type", "CRM Integration"."Apply to doc. Type");
                    RecSH.VALIDATE("Applies-to Doc. No.", "CRM Integration"."Apply to Doc. No.");
                END;
                RecSH.INSERT(TRUE);
                RecCRMInt.RESET;
                RecCRMInt.SETRANGE(RecCRMInt."CRM invoice No", PrevCRM);
                IF RecCRMInt.FINDSET THEN BEGIN
                    REPEAT
                        RecSL.INIT;
                        RecSL.VALIDATE(RecSL."Document Type", "CRM Integration"."Document Type");
                        RecSL.VALIDATE(RecSL."Document No.", SO_No);
                        RecSL.VALIDATE(RecSL."Sell-to Customer No.", RecCust."No.");
                        RecSL.VALIDATE(RecSL."Bill-to Customer No.", RecCust."No.");

                        IF i = 0 THEN
                            line_no := 10000
                        ELSE
                            line_no := (i + 1) * 10000;
                        RecSL.VALIDATE(RecSL."Line No.", line_no);
                        RecSL.VALIDATE(RecSL.Type, RecCRMInt.Type);
                        RecSL.INSERT(TRUE);
                        RecSL.RESET;
                        RecSL.SETRANGE(RecSL."Document No.", SO_No);
                        RecSL.SETFILTER(RecSL."Line No.", '%1', line_no);
                        IF RecSL.FINDFIRST THEN BEGIN
                            RecSL.VALIDATE(RecSL."Sell-to Customer No.", RecCust."No.");
                            RecSL.VALIDATE(RecSL."Bill-to Customer No.", RecCust."No.");


                            IF RecSL.Type = RecSL.Type::"G/L Account" THEN
                                RecSL.VALIDATE(RecSL."No.", RecCRMInt."No.");
                            RecSL.VALIDATE(RecSL."Location Code", RecSH."Location Code");
                            RecSL.VALIDATE(RecSL.Quantity, RecCRMInt.Quantity);
                            RecSL.VALIDATE(RecSL."Unit Price", RecCRMInt."Unit Price With Tax");
                            RecSL.VALIDATE(RecSL."GST Group Code", RecCRMInt."GST Group Code");
                            RecSL."HSN/SAC Code" := RecCRMInt."HSN/SAC Code";
                            RecSL.MODIFY;

                        END;

                        "CRM Integration"."Order Created" := TRUE;
                        "CRM Integration".MODIFY;
                        i += 1;
                        cnt := cnt - 1;


                    UNTIL RecCRMInt.NEXT = 0;

                    RecSH.VALIDATE("Shortcut Dimension 1 Code", "CRM Integration"."Shortcut Dimension 1 Code");
                    RecSH.VALIDATE("Shortcut Dimension 2 Code", "CRM Integration"."Shortcut Dimension 2 Code");
                    // IF RecSH.Structure <> '' THEN BEGIN
                    //     RecSL.CalculateStructures(RecSH);
                    //END;

                END;

            END;
            /*

           IF NOT RecCRMInt."Order Posted" THEN BEGIN
            SalesPost.RUN(RecSH);
            "CRM Integration"."Order Posted"  :=TRUE;
            "CRM Integration".MODIFY;
           END;
           */
        END;

    end;
}

