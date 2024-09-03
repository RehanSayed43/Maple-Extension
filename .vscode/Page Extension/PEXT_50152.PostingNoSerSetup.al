pageextension 50152 "Posting No. Series Setup e" extends "Posting No. Series Setup"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addfirst(Creation)
        {
            action("UpdateAll Conditions")
            {
                Promoted = true;
                Image = UpdateDescription;
                ApplicationArea = ALL;
                trigger OnAction()
                var
                    PostingNoSeriesSetup: Record "Posting No. Series";
                BEGIN
                    IF Confirm('Do you want to update conditions?') THEN BEGIN
                        PostingNoSeriesSetup.reset;
                        IF PostingNoSeriesSetup.FindSet() THEN
                            repeat
                                SetTablesCondition(PostingNoSeriesSetup, PostingNoSeriesSetup."Blob Text");
                            UNTIL PostingNoSeriesSetup.Next() = 0;
                        Message('Done');
                        // SetTablesCondition(Rec, 'VERSION(1) SORTING(Field1,Field3) WHERE(Field28=1(B1101))');
                    END;
                END;
            }
        }
    }
    procedure SetTablesCondition(var PostingNoSeries: Record "Posting No. Series"; Filters: Text)
    var
        FiltersOutStream: OutStream;
    begin
        PostingNoSeries.Condition.CreateOutStream(FiltersOutStream);
        FiltersOutStream.Write(Filters);
        PostingNoSeries.Modify(true);
    end;

    var
        myInt: Integer;
}