tableextension 50017 "Transfer Header Table" extends "Transfer Header"
{
    fields
    {
        field(50000; "Rental Sales Invoice No."; Code[20])
        {
        }
        field(50001; "Total Shipment"; Integer)
        {
            CalcFormula = Count("Transfer Line" WHERE("Document No." = FIELD("No."),
                                                      "Outstanding Qty. (Base)" = FILTER(<> 0)));
            FieldClass = FlowField;
        }
        field(50002; "Total Receipt"; Integer)
        {
            CalcFormula = Count("Transfer Line" WHERE("Document No." = FIELD("No."),
                                                       "Outstanding Qty. (Base)" = FILTER(0),
                                                       "Quantity Received" = FILTER(0)));
            FieldClass = FlowField;
        }
        field(50003; "Customer No."; Code[20])
        {
            TableRelation = Customer;
        }
        field(50004; "Rental Transfer"; Boolean)
        {
        }
        field(50005; "Transporter Name"; Text[50])
        {
        }
        field(50006; "LR/AWB No."; Text[30])
        {
        }
        field(50007; "LR/AWB Date"; Date)
        {
        }
        field(50009; "No of Boxes"; Text[30])
        {
        }
        field(50010; "ECom Order ID"; Code[20])
        {
            Editable = false;
        }
        field(50011; "Shipped By User ID"; Code[50])
        {
            Description = 'WIN316';
            Editable = false;
        }
        field(50012; "Received By User ID"; Code[50])
        {
            Description = 'WIN316';
            Editable = false;
        }
        field(50013; "Refreance No."; Code[20])
        {
            Description = 'KPPLDG00017';
        }
        field(50014; "WMS Process"; Boolean)
        {
            Description = 'KPPLDG00017';
        }
        field(50015; "Handover To Name"; Text[100])
        {
        }
        modify("Transfer-from Code")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;

                Location: record Location;
            begin
                IF Location.GET("Transfer-from Code") THEN BEGIN
                    //"In-Transit Code" := "Transfer-from Code";
                    "In-Transit Code" := COPYSTR("Transfer-from Code", 1, STRLEN("Transfer-from Code") - 1) + '3';//WIN316
                    "Assigned User ID" := USERID;//WIN316++
                    "Shortcut Dimension 1 Code" := Location."Shortcut Dimension 1 Code";//WIN316++
                    //modify();
                end;

            end;
        }

        modify("Transfer-to Code")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //Win127 06.06.14 Updated WIN347++
                IF Location.GET("Transfer-from Code") AND (Location."Location Type" = Location."Location Type"::Rental) THEN BEGIN
                    Location.GET("Transfer-to Code");
                    IF Location."Location Type" = Location."Location Type"::Saleable THEN
                        ERROR('Saleable Location %1 is not allowed as Transfer-to Location in Rental Shipment', "Transfer-to Code");
                    // "In-Transit Code" := COPYSTR("Transfer-from Code", 1, STRLEN("Transfer-from Code") - 1) + '3';//WIN316
                END;
                IF Location.GET("Transfer-from Code") THEN BEGIN
                    //"In-Transit Code" := "Transfer-from Code";
                    "In-Transit Code" := COPYSTR("Transfer-from Code", 1, STRLEN("Transfer-from Code") - 1) + '3';//WIN316
                    //"Assigned User ID" := USERID;//WIN316++
                    //"Shortcut Dimension 1 Code" := Location."Shortcut Dimension 1 Code";//WIN316++
                    //modify();
                end;
                //Updated WIN347--
            end;
        }

    }
    var
        Location: Record Location;

}
