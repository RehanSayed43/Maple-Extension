page 50102 "States-WebN"
{
    Caption = 'States';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,GST';
    SourceTable = "State";
    ApplicationArea = FixedAsset;

    layout
    {
        area(content)
        {
            repeater(Repeater)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Zone; Rec.Zone)
                {
                    ApplicationArea = All;
                }
                field("State Code for eTDS/TCS"; Rec."State Code for eTDS/TCS")
                {
                    ApplicationArea = All;
                }
                // field("State Code for TIN"; "State Code for TIN")
                // {
                // }//tk
                field("State Code (GST Reg. No.)"; Rec."State Code (GST Reg. No.)")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&State")
            {
                Caption = '&State';
                Image = Zones;
                action("Deferment Periods")
                {
                    Caption = 'Deferment Periods';
                    Image = Installments;
                    ApplicationArea = All;
                    //RunObject = Page 16538;
                    //RunPageLink = State Code=FIELD(Code);
                }
                action(Schedules)
                {
                    Caption = 'Schedules';
                    Image = Planning;
                    ApplicationArea = All;
                    //RunObject = Page 16547;
                    //              RunPageLink = State Code=FIELD(Code);
                }
            }
            group("F&orms")
            {
                Caption = 'F&orms';
                Image = Form;
                action(Forms)
                {
                    Caption = 'Forms';
                    Image = Form;
                    ApplicationArea = All;
                    //RunObject = Page 13702;
                    //              RunPageLink = State=FIELD(Code);
                }
            }
            group(GST)
            {
                Caption = 'GST';
                action("GST Setup")
                {
                    Caption = 'GST Setup';
                    Image = Setup;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    // RunObject = Page 16408;
                    //               RunPageLink = GST State Code=FIELD(Code);
                }
                action("GST Registration Nos.")
                {
                    Caption = 'GST Registration Nos.';
                    Image = Register;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    //  RunObject = Page "GST Registration Nos.";
                    //                RunPageLink = State Code=FIELD(Code);
                }
            }
        }
    }
}

