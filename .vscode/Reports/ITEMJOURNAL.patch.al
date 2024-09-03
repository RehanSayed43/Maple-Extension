report 50278 "ITEM Journal Delete"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    //DefaultLayout = RDLC;
    //RDLCLayout = '.\ItemJournalpatch.rdl';
    //RDLCLayout = './ItemJournalpatch.rdl';
    Caption = 'ITEMJOURNALPATCH';
    //DefaultRenderingLayout = LayoutName;


    dataset
    {
        dataitem("Item Journal Line"; "Item Journal Line")
        {
            RequestFilterFields = "Journal Template Name", "Journal Batch Name";

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                RIJ: Record "Item Journal Line";
                RESERVT: Record "Reservation Entry";

            begin
                RIJ.Reset();
                RIJ.SetFilter(RIJ."Journal Template Name", "Journal Template Name");
                RIJ.SetFilter(RIJ."Journal Batch Name", "Journal Batch Name");
                If RIJ.FindFirst() then begin
                    repeat

                        RESERVT.Reset();
                        RESERVT.SetFilter(RESERVT."Source Type", '=%1', 83);
                        RESERVT.SetRange("Source ID", "Journal Template Name");
                        RESERVT.SetRange("Source Batch Name", "Journal Batch Name");
                        RESERVT.SetRange("Item No.", "Item No.");
                        RESERVT.SetRange("Source Ref. No.", "Line No.");
                        If RESERVT.FindFirst() then begin
                            RESERVT.DeleteAll();

                        end;
                        RIJ.DeleteAll();
                    until RIJ.next = 0;





                end;

            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(Name; '')
                    {
                        ApplicationArea = All;

                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    // rendering
    // {
    //     layout(LayoutName)
    //     {
    //         Type = RDLC;
    //         LayoutFile = 'mylayout.rdl';
    //     }
    // }

    var
        myInt: Integer;
}