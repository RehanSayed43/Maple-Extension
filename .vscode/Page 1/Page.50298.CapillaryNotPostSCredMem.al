page 50098 "Capillary Not Post. S Cred Mem"
{
    Caption = 'Capillary Not Posted Sales Credit Memos';
    CardPageID = "Posted Sales Credit Memo";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = all;
    PromotedActionCategories = 'New,Process,Report,Cr. Memo';
    SourceTable = 114;

    layout
    {
        area(content)
        {
            repeater(repeater)
            {
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                // field("Capillary Error"; "Capillary Error")
                // {
                // }//tk
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        Rec.SETRANGE("No.");
                        PAGE.RUNMODAL(PAGE::"Posted Sales Credit Memo", Rec)
                    end;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        Rec.SETRANGE("No.");
                        PAGE.RUNMODAL(PAGE::"Posted Sales Credit Memo", Rec)
                    end;
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Sell-to Country/Region Code"; Rec."Sell-to Country/Region Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Bill-to Country/Region Code"; Rec."Bill-to Country/Region Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Visible = true;
                    ApplicationArea = All;
                }
                field("No. Printed"; Rec."No. Printed")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Document Exchange Status"; Rec."Document Exchange Status")
                {
                    ApplicationArea = All;
                    //StyleExpr = DocExchStatusStyle;

                    trigger OnDrillDown()
                    begin
                        // DocExchStatusDrillDown;
                    end;
                }
            }
        }
        area(factboxes)
        {
            part(IncomingDocAttachFactBox; 193)
            {
                ShowFilter = false;
                ApplicationArea = All;
            }
            systempart(Links; Links)
            {
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                Visible = true;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Cr. Memo")
            {
                Caption = '&Cr. Memo';
                Image = CreditMemo;
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F7';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        PAGE.RUN(PAGE::"Posted Sales Credit Memo", Rec)
                    end;
                }
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page 398;
                    RunPageLink = "No." = FIELD("No.");
                    ShortCutKey = 'F7';
                    ApplicationArea = All;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page 67;
                    RunPageLink = "Document Type" = CONST("Posted Credit Memo"),
                                  "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData 348 = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions;
                    end;
                }
                action(IncomingDoc)
                {
                    AccessByPermission = TableData 130 = R;
                    Caption = 'Incoming Document';
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        IncomingDocument: Record 130;
                    begin
                        IncomingDocument.ShowCard(Rec."No.", Rec."Posting Date");
                    end;
                }
            }
        }
        area(processing)
        {
            action(SendCustom)
            {
                Caption = 'Send';
                Ellipsis = true;
                Image = SendToMultiple;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    SalesCrMemoHeader: Record 114;
                begin
                    SalesCrMemoHeader := Rec;
                    CurrPage.SETSELECTIONFILTER(SalesCrMemoHeader);
                    SalesCrMemoHeader.SendRecords;
                end;
            }
            action("&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                ApplicationArea = All;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;

                trigger OnAction()
                var
                    SalesCrMemoHeader: Record 114;
                begin
                    SalesCrMemoHeader := Rec;
                    CurrPage.SETSELECTIONFILTER(SalesCrMemoHeader);
                    SalesCrMemoHeader.PrintRecords(TRUE);
                end;
            }
            action("&Email")
            {
                Caption = '&Email';
                Image = Email;
                ApplicationArea = All;

                trigger OnAction()
                var
                    SalesCrMemoHeader: Record 114;
                begin
                    SalesCrMemoHeader := Rec;
                    CurrPage.SETSELECTIONFILTER(SalesCrMemoHeader);
                    SalesCrMemoHeader.EmailRecords(TRUE);
                end;
            }
            action("&Navigate")
            {
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.Navigate;
                end;
            }
            action(ActivityLog)
            {
                Caption = 'Activity Log';
                Image = Log;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ActivityLog: Record 710;
                begin
                    ActivityLog.ShowEntries(Rec.RECORDID);
                end;
            }
            action(Taxable)
            {
                Caption = 'Taxable';
                Ellipsis = true;
                Image = "Filter";
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    ShowInvoiceTypeDoc(Rec."Invoice Type"::Taxable);
                end;
            }
            action("Bill of Supply")
            {
                Caption = 'Bill of Supply';
                Ellipsis = true;
                Image = "Filter";
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    ShowInvoiceTypeDoc(Rec."Invoice Type"::"Bill of Supply");
                end;
            }
            action(Export)
            {
                Caption = 'Export';
                Ellipsis = true;
                Image = "Filter";
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    ShowInvoiceTypeDoc(Rec."Invoice Type"::Export);
                end;
            }
            action(Supplementary)
            {
                Caption = 'Supplementary';
                Ellipsis = true;
                Image = "Filter";
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    ShowInvoiceTypeDoc(Rec."Invoice Type"::Supplementary);
                end;
            }
            action("Debit Note")
            {
                Caption = 'Debit Note';
                Ellipsis = true;
                Image = "Filter";
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    ShowInvoiceTypeDoc(Rec."Invoice Type"::"Debit Note");
                end;
            }
            action("Non GST")
            {
                Caption = 'Non GST';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    ShowInvoiceTypeDoc(Rec."Invoice Type"::"Non-GST");
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        DocExchStatusStyle := Rec.GetDocExchStatusStyle;
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    end;

    trigger OnAfterGetRecord()
    begin
        DocExchStatusStyle := Rec.GetDocExchStatusStyle;
    end;

    trigger OnOpenPage()
    begin
        Rec.SetSecurityFilterOnRespCenter;
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Posting Date", '%1..', 20171122D);
        // SETRANGE("Capillary Posted", FALSE);
        // SETFILTER("Sales Order Type", '%1', "Sales Order Type"::Retail);//tk
        Rec.FILTERGROUP(0)
    end;

    var
        DocExchStatusStyle: Text;

    local procedure ShowInvoiceTypeDoc(InvoiceType: Option Taxable,"Bill of Supply",Export,Supplementary,"Debit Notes")
    var
        SalesInvHeader: Record 112;
    begin
        Rec.SETRANGE("Invoice Type", InvoiceType);
        IF Rec.FINDSET THEN
            PAGE.RUN(PAGE::"Posted Sales Credit Memos", Rec);
    end;
}

