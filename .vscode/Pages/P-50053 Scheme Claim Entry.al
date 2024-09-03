page 50053 "Scheme Claim Entry"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    PageType = List;
    SourceTable = "Sales Invoice Line";

    layout
    {
        area(content)
        {
            group(Groups)
            {
                field(VendorL; VendorL)
                {
                    ApplicationArea = all;
                    TableRelation = Vendor WHERE("Apple Distributor" = CONST(True));
                }
                field(SchemeL; SchemeL)
                {
                    ApplicationArea = all;
                    TableRelation = "Standard Text" WHERE(Scheme = CONST(true),
                                                           Open = CONST(true));

                    trigger OnValidate()
                    begin
                        IF VendorL = '' THEN
                            ERROR('Select Vendor');

                        TotalSchemeAmount := 0;
                        Rec.RESET;
                        Rec.SETFILTER("Scheme Code", '%1', SchemeL);
                        Rec.SETFILTER(Vendor, '%1', VendorL);
                        /* Rahul-------
                        IF FINDFIRST THEN
                            REPEAT
                                TotalSchemeAmount := TotalSchemeAmount +  Rec."Scheme Amount";
                            UNTIL NEXT = 0;
                          ---------rahul  */
                    end;
                }
                field(TotalSchemeAmount; TotalSchemeAmount)
                {
                    ApplicationArea = all;
                }
            }
            repeater(Group)
            {
                field(Select; Rec.Select)
                {
                    ApplicationArea = all;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Scheme Code"; Rec."Scheme Code")
                {
                    ApplicationArea = all;
                }
                field("Scheme Amount"; Rec."Scheme Amount")
                {
                    ApplicationArea = all;
                }
                field("Claim Amount"; Rec."Claim Amount")
                {
                    ApplicationArea = all;
                }
                field(Vendor; Rec.Vendor)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.SETFILTER("Document No.", '=%1', '');
    end;

    var
        VendorL: Code[20];
        SchemeL: Code[10];
        TotalSchemeAmount: Integer;
}

