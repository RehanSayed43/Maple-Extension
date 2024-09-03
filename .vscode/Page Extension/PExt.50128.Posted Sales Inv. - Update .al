pageextension 50128 "Posted Sales Inv. - Update " extends "Posted Sales Inv. - Update"
{

    layout
    {
        addafter("Posting Date")
        {
            field("Vehicle No."; Rec."Vehicle No.")
            {
                Visible = false;
                ApplicationArea = all;
                Editable = true;
            }
            field("Mode of Transport"; Rec."Mode of Transport")
            {
                Description = '1:Road,2:Air,3:Ship';
                AboutText = '1:Road,2:Air,3:Ship';
                ApplicationArea = all;
                Editable = true;
                Visible = false;
            }
            field("Vehicle Type"; Rec."Vehicle Type")
            {
                ApplicationArea = all;
                Editable = true;
                Visible = false;
            }
            field("Cancel Remark"; Rec."Cancel Remark")
            {
                ApplicationArea = all;
                Editable = true;
                Visible = false;
            }
            field("Cancel Reason"; Rec."Cancel Reason")
            {
                ApplicationArea = all;
                Editable = true;
                Visible = false;


            }
            field("Cancel Reason Code"; Rec."Cancel Reason Code")
            {
                ApplicationArea = all;
                Editable = true;
                //Visible = false;
                Caption = 'E-invoice Cancel Reason';
            }
            field("E-Invoice Cancel Remark"; Rec."E-Invoice Cancel Remark")
            {
                ApplicationArea = all;
                Editable = true;
            }
            //CCIT AN 12092023++
            field("Nature of Supply"; Rec."Nature of Supply")
            {
                ApplicationArea = All;
                Editable = true;
            }
            field("GST Bill-to State Code"; Rec."GST Bill-to State Code")
            {
                ApplicationArea = All;
                Editable = true;
            }
            field("GST Customer Type"; Rec."GST Customer Type")
            {
                ApplicationArea = All;
                Editable = true;
            }//CCIT AN 12092023--
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}

pageextension 50140 "Posted Sales Cr.UpdateExtn" extends "Pstd. Sales Cr. Memo - Update"
{
    layout
    {
        // Add changes to page layout here
        addafter("Posting Date")
        {
            field("E-Invoice Cancel Remark"; Rec."E-Invoice Cancel Remark")
            {
                ApplicationArea = all;
                Editable = true;
            }
            field("E-Invoice Reason Code"; Rec."E-Invoice Reason Code")
            {
                ApplicationArea = All;
                Editable = true;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}