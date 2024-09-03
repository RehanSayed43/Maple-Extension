xmlport 50002 "Import Fixed Asset Line"
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("FA Depreciation Book"; "FA Depreciation Book")
            {
                XmlName = 'FixedAssetLines';
                fieldelement(FixedAssetLines_FANo; "FA Depreciation Book"."FA No.")
                {
                }
                fieldelement(FixedAssetLines_DepreciationBookCode; "FA Depreciation Book"."Depreciation Book Code")
                {
                }
                fieldelement(FixedAssetLines_FAPostingGroup; "FA Depreciation Book"."FA Posting Group")
                {
                }
                fieldelement(FixedAssetLines_DepreciationMethod; "FA Depreciation Book"."Depreciation Method")
                {
                }
                fieldelement(FixedAssetLines_DepreciationStartingDate; "FA Depreciation Book"."Depreciation Starting Date")
                {
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }
}

