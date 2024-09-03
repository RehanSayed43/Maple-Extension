pageextension 50018 Permissions extends "Permission Lookup List"

//>>COMMENTED
{
    /*
    layout
    {
        addafter(CurrentRoleID)
        {
            //             field(Show; Show)
            //             {
            //                 Caption = 'Show';
            //                 OptionCaption = 'Only In Permission Set,All';

            //                 trigger OnValidate()
            //                 begin
            //                     FillTempPermissions;
            //                 end;
            //             }

            //                 field(AddRelatedTables; AddRelatedTables)
            //                 {
            //                     Caption = 'Add Read Permission to Related Tables';
            //                 }
        }
        modify("Object Type")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                ActivateControls;
            end;
        }
    }

    actions
    {

    }

    var
        myInt: Integer;

    local procedure ActivateControls()
    begin
        // IsTableData := "Object Type" = "Object Type"::"Table Data"
    end;

    local procedure ModifyRecord(var ModifiedPermission: Record 2000000005)
    var
        Permission: Record 2000000005;
        IsNewPermission: Boolean;
    begin
        Permission.LOCKTABLE;
        IsNewPermission :=
          NOT Permission.GET(ModifiedPermission."Role ID", ModifiedPermission."Object Type", ModifiedPermission."Object ID");
        IF IsNewPermission THEN BEGIN
            Permission.TRANSFERFIELDS(ModifiedPermission, TRUE);
            Permission.INSERT;
        END ELSE BEGIN
            Permission.TRANSFERFIELDS(ModifiedPermission, FALSE);
            Permission.MODIFY;
        END;

        IF (Permission."Read Permission" = 0) AND
           (Permission."Insert Permission" = 0) AND
           (Permission."Modify Permission" = 0) AND
           (Permission."Delete Permission" = 0) AND
           (Permission."Execute Permission" = 0)
        THEN BEGIN
            Permission.DELETE;
            // IF Show = Show::"Only In Permission Set" THEN
            //     ModifiedPermission.DELETE;
            IsNewPermission := FALSE;
        END;
        // IF IsNewPermission AND AddRelatedTables THEN
        //     DoAddRelatedTables(ModifiedPermission);
    end;

    local procedure UpdateSelected(RIMDX: Text[1]; PermissionOption: Option)
    var
        TempPermission: Record 2000000005 temporary;
        OrgPermission: Record 2000000005;
    begin
        OrgPermission := Rec;
        TempPermission.COPY(Rec, TRUE);
        CurrPage.SETSELECTIONFILTER(TempPermission);

        IF TempPermission.FINDSET THEN
            REPEAT
                CASE RIMDX OF
                    'R':
                        IF TempPermission."Object Type" = Rec."Object Type"::"Table Data" THEN
                            TempPermission."Read Permission" := PermissionOption;
                    'I':
                        IF TempPermission."Object Type" = Rec."Object Type"::"Table Data" THEN
                            TempPermission."Insert Permission" := PermissionOption;
                    'M':
                        IF TempPermission."Object Type" = Rec."Object Type"::"Table Data" THEN
                            TempPermission."Modify Permission" := PermissionOption;
                    'D':
                        IF TempPermission."Object Type" = Rec."Object Type"::"Table Data" THEN
                            TempPermission."Delete Permission" := PermissionOption;
                    'X':
                        IF TempPermission."Object Type" <> Rec."Object Type"::"Table Data" THEN
                            TempPermission."Execute Permission" := PermissionOption;
                    '*':
                        BEGIN
                            IF TempPermission."Object Type" = Rec."Object Type"::"Table Data" THEN BEGIN
                                TempPermission."Read Permission" := PermissionOption;
                                TempPermission."Insert Permission" := PermissionOption;
                                TempPermission."Modify Permission" := PermissionOption;
                                TempPermission."Delete Permission" := PermissionOption;
                            END ELSE
                                TempPermission."Execute Permission" := PermissionOption;
                        END;
                END;
                ModifyRecord(TempPermission);
                IF Rec.GET(TempPermission."Role ID", TempPermission."Object Type", TempPermission."Object ID") THEN BEGIN
                    Rec := TempPermission;
                    Rec.MODIFY;
                END;
            UNTIL TempPermission.NEXT = 0;

        Rec := OrgPermission;
        IF Rec.FIND THEN;
    end;
    */
}