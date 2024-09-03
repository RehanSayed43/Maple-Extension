pageextension 50008 "Payment Methods" extends "Payment Methods"
{
    layout
    {
        addafter(Description)
        {
            field("Payment Mode"; Rec."Pay Type")
            {
                Caption = 'Payment Mode';
                ApplicationArea = all;

                trigger OnValidate()
                begin
                    // //WIN345++
                    // IF "Pay Type" = "Pay Type"::"Credit Card" THEN
                    //    // CRCDMachineEditable := TRUE
                    // ELSE
                    //    // CRCDMachineEditable := FALSE;
                    // //WIN345--
                end;

            }




        }
        addafter("Bal. Account No.")
        {
            field("Service Charge Account No."; Rec."Service Charge Account No.")
            {
                ApplicationArea = all;
            }
            field("Service Charge Perc"; Rec."Service Charge Perc")
            {
                ApplicationArea = all;
            }
            // field("Payment Processor"; "Payment Processor")
            // {
            // }
            // field("Direct Debit"; "Direct Debit")
            // {
            // }
            // field("Direct Debit Pmt. Terms Code"; "Direct Debit Pmt. Terms Code")
            // {
            // }//Standard Fild not in table //tk
            field("Credit card Machine Code"; Rec."Credit card Machine Code")
            {
                //Editable = CRCDMachineEditable;
                ApplicationArea = all;
            }
            field(CRCDMachineEditable; CRCDMachineEditable)
            {
                Caption = 'CRCDMachineEditable';
                Visible = false;
                ApplicationArea = all;
            }



        }
        addbefore(Code)
        {
            field("Branch Code"; Rec."Branch Code")
            {
                Visible = false;
                ApplicationArea = all;
            }
        }
    }


    actions
    {

    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        //Updated WIN347++//WIn345++
        IF Rec."Pay Type" = Rec."Pay Type"::"Credit Card" THEN
            CRCDMachineEditable := TRUE
        ELSE
            CRCDMachineEditable := FALSE;
        //Updated WIN347--//WIN345--

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        myInt: Integer;
    begin
        //Updated WIN347++//WIN345++
        UserSetup.GET(USERID);
        Rec."Branch Code" := UserSetup."Location Code";
        //Updated WIN347--//WIN345--

    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        myInt: Integer;
    begin
        CRCDMachineEditable := FALSE;//Updated WIN 347//WIN345 
    end;

    var
        myInt: Integer;
        CRCDMachineEditable: Boolean;
        UserSetup: Record 91;

}