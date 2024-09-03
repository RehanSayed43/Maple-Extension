codeunit 50040 "Moto Integration Return"
{

    trigger OnRun()
    begin
    end;


    procedure UpdateReturnOrderStatus(OrderNo: Code[50]): Boolean
    var
        MapleMOTOIntegration: Record 50033;
    begin
        MapleMOTOIntegration.RESET;
        MapleMOTOIntegration.SETRANGE(order_number, OrderNo);
        IF MapleMOTOIntegration.FINDFIRST THEN
            REPEAT
                MapleMOTOIntegration.Status_Ret := 'Return';
                MapleMOTOIntegration.MODIFY;
            UNTIL MapleMOTOIntegration.NEXT = 0;
        EXIT(TRUE);
    end;
}

