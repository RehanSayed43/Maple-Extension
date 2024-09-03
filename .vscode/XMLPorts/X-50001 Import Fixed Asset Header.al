xmlport 50001 "Import Fixed Asset header"
{
    Format = Xml;

    schema
    {
        textelement(Root)
        {
            tableelement("Fixed Asset"; "Fixed Asset")
            {
                XmlName = 'FixedAsset';
                fieldelement(FixedAsset_No; "Fixed Asset"."No.")
                {
                }
                fieldelement(FixedAsset_Description; "Fixed Asset".Description)
                {
                }
                fieldelement(FixedAsset_SearchDescription; "Fixed Asset"."Search Description")
                {
                }
                fieldelement(FixedAsset_FAClassCode; "Fixed Asset"."FA Class Code")
                {
                }
                fieldelement(FixedAsset_FASubClassCode; "Fixed Asset"."FA Subclass Code")
                {
                }
                fieldelement(FixedAsset_Branch; "Fixed Asset"."Global Dimension 1 Code")
                {
                }
                fieldelement(FixedAsset_FALocationCode; "Fixed Asset"."FA Location Code")
                {
                }
                /*   rahul
                fieldelement(FixedAsset_GenProdPostingGruop; "Fixed Asset"."Gen. Prod. Posting Group")
                {
                }
                fieldelement(FixedAsset_FABlockCode; "Fixed Asset"."FA Block Code")
                {
                }
                */
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

