page 50054 "Customer History Entry(ILE)"
{
    UsageCategory = Administration;
    ApplicationArea = all;
    PageType = Card;
    SourceTable = "Item Ledger Entry";
    SourceTableView = WHERE(HistoryData = CONST(true));

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                    Visible = true;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = all;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        Item.GET(Rec."Item No.");
                        Rec.Description := Item.Description;
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = all;
                    Caption = 'Customer';
                    TableRelation = Customer WHERE("Customer Type" = CONST(Retail));

                    trigger OnValidate()
                    begin
                        Customer.GET(Rec."Source No.");
                        CustomerName := Customer.Name
                    end;
                }
                field(CustomerName; CustomerName)
                {
                    ApplicationArea = all;
                    Caption = 'Customer Name';
                }
                field(Qty; Qty)
                {
                    ApplicationArea = all;
                    Caption = 'Quantity';

                    trigger OnValidate()
                    begin
                        Rec.Quantity := Qty * (-1);
                    end;
                }
                field(ValueAmount; ValueAmount)
                {
                    ApplicationArea = all;
                    Caption = 'Amount';

                    trigger OnValidate()
                    begin
                        SAmount := FORMAT(ValueAmount);
                    end;
                }
                field("Sales Amount (Actual)"; Rec."Sales Amount (Actual)")
                {
                    ApplicationArea = all;
                    Caption = 'Total Sales Amount';
                }
                field("Warranty Date"; Rec."Warranty Date")
                {
                    ApplicationArea = all;
                }
                field(ItemNo; ItemNo)
                {
                    ApplicationArea = all;
                    Caption = 'Item No';
                    TableRelation = Item;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Item.GET(ItemNo);
                        Descriptionxt := Item.Description;
                    end;
                }
                field(Descriptionxt; Descriptionxt)
                {
                    ApplicationArea = all;
                    Caption = 'Description';
                    Visible = false;
                }
                field(PostingDate; PostingDate)
                {
                    ApplicationArea = all;
                    Caption = 'Posting Date';
                    Visible = false;
                }
                field(EntryType; EntryType)
                {
                    ApplicationArea = all;
                    Caption = 'Entry Type';
                    Visible = false;
                }
                field(CustomerNo; CustomerNo)
                {
                    ApplicationArea = all;
                    Caption = 'Customer Number';
                    TableRelation = Customer WHERE("Customer Type" = CONST(Retail));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Customer.GET(CustomerNo);
                        CustomerName := Customer.Name
                    end;
                }
                field(DocumentDt; DocumentDt)
                {
                    ApplicationArea = all;
                    Caption = 'Document Date';
                    Visible = false;
                }
                field(DocumentType; DocumentType)
                {
                    ApplicationArea = all;
                    Caption = 'Document Type';
                    Visible = false;
                }
                field(WarrantyDt; WarrantyDt)
                {
                    ApplicationArea = all;
                    Caption = 'Warranty Date';
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action(Post)
            {
                Ellipsis = true;
                Image = Post;
                InFooterBar = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunPageMode = Edit;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ILE: Record 32;
                    ValueEntry: Record 5802;
                    ILEEntryNo: Integer;
                    ValueEntryNo: Integer;
                begin
                    IF NOT CurrPage.EDITABLE THEN
                        MESSAGE('Document Already Posted');

                    IF CONFIRM('Do you want to save the entries?') THEN BEGIN
                        SalesSetup.GET;
                        //ILE.RESET;
                        //ILE.FINDLAST;
                        // ILEEntryNo :=ILE."Entry No." + 1;
                        //ILE.INIT;
                        //"Document Type" := "Document Type"::"Sales Shipment";
                        // ILE."Document No." := NoSeriesMgt.GetNextNo(SalesSetup."Posted Shipment Nos.",WORKDATE,TRUE);
                        // "Item No." := ItemNo;
                        // Description := Descriptionxt;
                        //"Posting Date" := PostingDate;
                        //  "Source No." := CustomerNo;
                        //  Quantity := Quantity * -1;
                        // "Warranty Date" := WarrantyDt;
                        // "Entry Type" := ILE."Entry Type"::Sale;
                        //HistoryData := TRUE;
                        // MODIFY;

                        ValueEntry.RESET;
                        ValueEntry.SETFILTER(ValueEntry."Item Ledger Entry No.", '%1', Rec."Entry No.");
                        IF ValueEntry.FINDFIRST THEN BEGIN
                            EVALUATE(ValueEntry."Sales Amount (Actual)", SAmount);
                            ValueEntry.MODIFY;
                            EXIT;
                        END
                        ELSE BEGIN
                            ValueEntry.RESET;
                            ValueEntry.FINDLAST;
                            ValueEntryNo := ValueEntry."Entry No." + 1;
                            ValueEntry.INIT;
                            ValueEntry."Entry No." := ValueEntryNo;
                            // ValueEntry."Entry Type" := ValueEntryType;
                            ValueEntry."Item Ledger Entry Type" := ValueEntry."Item Ledger Entry Type"::Sale;
                            ValueEntry."Item Ledger Entry No." := Rec."Entry No.";
                            //ValueEntry.Type := Type;
                            ValueEntry."Item No." := Rec."Item No.";
                            ValueEntry.Description := Rec.Description;
                            //ValueEntry."Order Type" := "Order Type";
                            // ValueEntry."Order No." := "Order No.";
                            // ValueEntry."Order Line No." := "Order Line No.";
                            ValueEntry."Source Type" := Rec."Source Type";
                            //ValueEntry."Source No." := GetSourceNo(ItemJnlLine);
                            ValueEntry."Invoiced Quantity" := Rec.Quantity;
                            ValueEntry."Valued Quantity" := Rec.Quantity;
                            ValueEntry."Sales Amount (Actual)" := ValueAmount;
                            //ValueEntry."Cost Amount (Actual)" := AdjdCost;
                            // ValueEntry."Cost Amount (Actual) (ACY)" := ACYMgt.CalcACYAmt(AdjdCost,"Posting Date",FALSE);
                            // ValueEntry."Cost per Unit" :=
                            //  CalcCostPerUnit(ValueEntry."Cost Amount (Actual)",ValueEntry."Valued Quantity",FALSE);
                            //ValueEntry."Cost per Unit (ACY)" :=
                            //  CalcCostPerUnit(ValueEntry."Cost Amount (Actual) (ACY)",ValueEntry."Valued Quantity",TRUE);
                            //ValueEntry.Inventoriable := TRUE;

                            ValueEntry."Inventory Posting Group" := 'FINISHED';
                            ValueEntry."Gen. Bus. Posting Group" := 'RETAIL';
                            ValueEntry."Gen. Prod. Posting Group" := 'FINISHED';

                            ValueEntry."Posting Date" := Rec."Posting Date";
                            ValueEntry."Valuation Date" := Rec."Posting Date";
                            ValueEntry."Source No." := Rec."Source No.";
                            ValueEntry."Document No." := NoSeriesMgt.GetNextNo(SalesSetup."Posted Invoice Nos.", WORKDATE, TRUE);
                            ValueEntry."Document Type" := Rec."Document Type"::"Sales Invoice";
                            ValueEntry."Document Line No." := 10000;
                            ValueEntry."Document Date" := DocumentDt;
                            //ValueEntry."External Document No." := "External Document No.";
                            ValueEntry."User ID" := USERID;
                            ValueEntry."Source Code" := 'Sales';
                            //ValueEntry."Reason Code" := "Reason Code";
                            // ValueEntry."Journal Batch Name" := "Journal Batch Name";

                            //ValueEntry."Global Dimension 1 Code" := "Shortcut Dimension 1 Code";
                            //ValueEntry."Global Dimension 2 Code" := "Shortcut Dimension 2 Code";
                            //ValueEntry."Dimension Set ID" := "Dimension Set ID";


                            ValueEntry.INSERT;
                        END;
                        ILEInit;
                        CurrPage.CLOSE;
                    END;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        ItemNo := Rec."Item No.";
        PostingDate := Rec."Posting Date";
        CustomerNo := Rec."Source No.";
        Customer.GET(CustomerNo);
        CustomerName := Customer.Name;
        Descriptionxt := Rec.Description;
        Qty := Rec.Quantity * -1;
        // SalesAmount := "Sales Amount (Actual)";
        WarrantyDt := Rec."Warranty Date";
        //ShieldDueDt :=
        //AmcDueDt :=
        EntryType := Rec."Entry Type";
        DocumentDt := Rec."Document Date";
        DocumentType := Rec."Document Type";
        IF Rec."Sales Amount (Actual)" <> 0 THEN
            PageEdit := FALSE
        ELSE
            PageEdit := TRUE;
        Rec.CALCFIELDS("Sales Amount (Actual)");
        ValueAmount := Rec."Sales Amount (Actual)";
        CurrPage.EDITABLE := PageEdit;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        ILE: Record 32;
    begin
        Rec."Entry Type" := Rec."Entry Type"::Sale;
        Rec."Document Type" := Rec."Document Type"::"Sales Shipment";
        Rec."Source Type" := Rec."Source Type"::Customer;
        ILE.FINDLAST;
        Rec."Entry No." := ILE."Entry No." + 1;
        SalesSetup.GET;
        Rec."Document No." := NoSeriesMgt.GetNextNo(SalesSetup."Posted Shipment Nos.", WORKDATE, TRUE);
        Rec.HistoryData := TRUE;
    end;

    trigger OnOpenPage()
    begin
        Rec.SETFILTER("Entry No.", '');
        Rec.SETFILTER("Entry Type", '%1', Rec."Entry Type"::Sale);
        Rec.SETFILTER("Document Type", '%1', Rec."Document Type"::"Sales Shipment");
        Rec.SETFILTER("Source Type", '%1', Rec."Source Type"::Customer);
        Rec.SETFILTER(HistoryData, '%1', TRUE);
        IF Rec."Sales Amount (Actual)" <> 0 THEN
            PageEdit := FALSE
        ELSE
            PageEdit := TRUE;
        CurrPage.EDITABLE := PageEdit;
    end;

    var
        SalesSetup: Record 311;
        NoSeriesMgt: Codeunit 396;
        ItemNo: Code[20];
        PostingDate: Date;
        CustomerNo: Code[20];
        [InDataSet]
        Descriptionxt: Text[50];
        WarrantyDt: Date;
        ShieldDueDt: Date;
        AmcDueDt: Date;
        EntryType: Option;
        DocumentDt: Date;
        DocumentType: Option;
        Item: Record 27;
        CustomerName: Text[50];
        Customer: Record 18;
        ValueAmount: Decimal;
        PageEdit: Boolean;
        [InDataSet]
        Qty: Integer;
        [InDataSet]
        SAmount: Text[100];


    procedure ILEInit()
    begin
        ItemNo := '';
        PostingDate := 0D;
        CustomerNo := '';
        Descriptionxt := '';
        Rec.Quantity := 0;
        ValueAmount := 0;
        WarrantyDt := 0D;
        CustomerName := '';
    end;
}

