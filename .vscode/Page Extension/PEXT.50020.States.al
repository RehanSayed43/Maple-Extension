pageextension 50020 States extends States
{
    layout
    {

    }

    actions
    {
        addafter(EditInExcel)
        {
            group("&State")
            {
                Caption = '&State';
                Image = Zones;
                action("Deferment Periods")
                {
                    Caption = 'Deferment Periods';
                    Image = Installments;
                    ApplicationArea = all;
                    // RunObject = Page 16538;
                    // RunPageLink = State Code=FIELD(Code);
                }
                action(Schedules)
                {
                    Caption = 'Schedules';
                    Image = Planning;
                    ApplicationArea = all;
                    // RunObject = Page 16547;
                    //                 RunPageLink = State Code=FIELD(Code);
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
                    ApplicationArea = all;
                    // RunObject = "State Forms";
                    //                 RunPageLink = "State"=FIELD(Code);
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
                    RunObject = Page "GST Posting Setup";
                    RunPageLink = "State Code" = FIELD(Code);
                    ApplicationArea = all;
                }
                action("GST Registration Nos.")
                {
                    Caption = 'GST Registration Nos.';
                    Image = Register;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "GST Registration Nos.";
                    RunPageLink = "State Code" = FIELD(Code);
                    ApplicationArea = all;
                }
            }
        }


    }

    var
        myInt: Integer;
}