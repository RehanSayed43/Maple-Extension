xmlport 50041 "Update Sales Order"
{
    //  UseDefaultNamespace = true;
    Direction = Import;

    schema
    {
        textelement(NodeName1)
        {
            tableelement(SalesHeader; "Sales Header")
            {
                MinOccurs = Once;
                UseTemporary = true;

                fieldattribute(OrderKey; SalesHeader.orderKey)
                {

                }
                fieldattribute(transaction_id; SalesHeader.transaction_id)
                {
                    Occurrence = Optional;
                }
                fieldattribute(payment_methody; SalesHeader.payment_method)
                {
                    Occurrence = Optional;
                }
                fieldattribute(payment_method_title; SalesHeader."payment_method_title")
                {
                    Occurrence = Optional;
                }
                fieldattribute(PaymentStatus; SalesHeader."Payment Status")
                {
                    Occurrence = Optional;
                }
                fieldattribute(orderStatus; SalesHeader.orderStatus)
                {
                    Occurrence = Optional;
                }

                tableelement(SalesLine; "Sales Line")
                {
                    LinkTable = SalesHeader;
                    MinOccurs = Zero;
                    UseTemporary = true;

                    fieldattribute(Type; SalesLine.Type)
                    {
                        Occurrence = Optional;
                    }
                    fieldattribute(No; SalesLine."No.")
                    {
                        Occurrence = Optional;
                    }

                    fieldattribute(SerialNo; SalesLine."Item Serial No.")
                    {
                        Occurrence = Optional;
                    }
                    fieldattribute(BillingLocationCode; SalesLine."Location Code")
                    {
                        Occurrence = Optional;
                    }

                    //Sales Line Line
                    // trigger OnAfterInitRecord()
                    // BEGIN
                    //     LineNo += 10000;
                    //     SalesLine."Line No." := LineNo;
                    // END;

                    trigger OnAfterGetRecord()
                    var
                        Cust: Record Customer;
                        SH: Record "Sales Header";
                    BEGIN

                        IF SalesLine."Location Code" <> '' THEN BEGIN

                            SH.Reset();
                            SH.SetRange("Document Type", SH."Document Type"::Order);
                            SH.SetRange(SH.orderKey, SalesHeader.orderKey);
                            IF SH.FindFirst() THEN BEGIN
                                SH.Validate("Location Code", SalesLine."Location Code");
                                SH.Modify();
                            END;
                            //IF SalesLineRec.GET(SalesLineRec."Document Type"::Order, sh."No.", SalesLine."Line No.") THEN 
                            SalesLineRec.Reset();
                            SalesLineRec.SetRange(SalesLineRec."Document No.", SH."No.");
                            SalesLineRec.SetRange("Item Serial No.", SalesLine."Item Serial No.");
                            IF SalesLineRec.FindFirst() THEN BEGIN
                                SalesLineRec.Validate("Location Code", SalesLine."Location Code");
                                SalesLineRec.Modify(false);
                                //exit(SalesLine."Location Code");
                            END;
                        END;
                    End;


                }
                //Sales Header
                trigger OnAfterGetRecord()
                var

                    SalesCommentLine: Record 43;
                    CustNo: Code[20];
                    SingleInstanceCodeunit: Codeunit "Single Instance Codeunit";
                BEGIN
                    SH.Reset();
                    SH.SetRange("Document Type", SH."Document Type"::Order);
                    SH.SetRange(SH.orderKey, SalesHeader.orderKey);
                    IF SH.FindFirst() THEN BEGIN
                        SH.transaction_id := SalesHeader.transaction_id;
                        SH.payment_method := SalesHeader.payment_method;
                        SH.payment_method_title := SalesHeader.payment_method_title;
                        SH."Payment Status" := SalesHeader."Payment Status";
                        SH.orderStatus := SalesHeader.orderStatus;
                        SH.Modify(false);
                    END;

                END;
            }

        }

    }


    requestpage
    {
        layout
        {

        }


    }



    var
        SalesHeaderRec: Record "Sales Header";
        SalesLineRec: Record "Sales Line";
        DocNo: Code[20];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SalesNPayable: Record "Sales & Receivables Setup";
        Position: Integer;
        SingleFilePathString: Code[200];

        FileManagement: Codeunit 419;

        ReleaseBoolean: Boolean;
        SendForApprovalBoolean: Boolean;
        NewDimSetID: Integer;
        DimMngt: Codeunit 408;
        TempDimSetEntry: Record 480 temporary;
        ApprovalsMgmt: Codeunit 1535;
        ReleasePurchDoc: Codeunit "Release Sales Document";
        ArchiveManagement: Codeunit 5063;
        LineNo: Integer;
        deleteCount: Integer;
        DocType: Integer;
        ShipToaddresscode: Code[20];
        SH: Record "Sales Header";

}

