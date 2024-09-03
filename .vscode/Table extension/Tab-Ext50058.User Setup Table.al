tableextension 50058 "User Setup Table" extends "User Setup"
{
    fields
    {
        field(50000; "Item Authorization"; Boolean)
        {
            Description = 'win127 added for item authorization';
        }
        field(50001; "Allow Req. View All"; Boolean)
        {
        }
        field(50002; "Location Code"; Code[10])
        {
            TableRelation = Location;
        }
        field(50003; "Super User"; Boolean)
        {
        }
        field(50004; "Reason Code mandatory"; Boolean)
        {
        }
        field(50005; password; Code[20])
        {
            Description = 'Web';
            ExtendedDatatype = None;
        }
        field(50006; "Web User"; Boolean)
        {
            Description = 'Web';
        }
        field(50007; "Close PO"; Boolean)
        {
        }
        field(50008; "Location Filter"; Code[250])
        {
        }
        field(50009; "All Location Transfer"; Boolean)
        {
            Description = 'WIN316';
        }
        field(50010; "Capillary Disc.  Order Delete"; Boolean)
        {
            Description = 'win234';
        }
        field(50011; "Allow Back Dated Entry"; Boolean)
        {
            Description = 'Kppl';
        }
        field(50012; "CRT Approval"; Boolean)
        {
            Description = 'KPPLDG00016';

            trigger OnValidate()
            begin
                TESTFIELD("E-Mail");
            end;
        }
        field(50013; "CRT Verifier"; Boolean)
        {
            Description = 'KPPLDG00016';

            trigger OnValidate()
            begin
                TESTFIELD("E-Mail");
            end;
        }
        field(50014; "Mannual Data Send Clockme"; Boolean)
        {
        }
        field(50015; "Ingram User"; Boolean)
        {
            Caption = 'Ingram User';
            Description = 'KPPL-INGRAM';
        }
        //CCIT AN 30102023++
        field(50016; "Customer Edit"; Boolean)
        {

        }
        //CCIT AN --
    }
}
