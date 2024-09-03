xmlport 50038 ItemsExport
{
    Direction = Export;
    Format = VariableText;
    FormatEvaluate = Legacy;

    schema
    {
        textelement(ItemsFile)
        {
            tableelement(Item; Item)
            {
                XmlName = 'Item';
                fieldelement(NewNo; Item."No.")
                {
                }
                fieldelement(OLDNo; Item."No. 2")
                {
                }
                fieldelement(Description; Item.Description)
                {
                }
                fieldelement(VendorPartCode; Item."Vendor Item No.")
                {
                }
                fieldelement(HSNSACCode; Item."HSN/SAC Code")
                {
                }
                fieldelement(GSTGroupCode; Item."GST Group Code")
                {
                }
                fieldelement(BaseUnitofMeasure; Item."Base Unit of Measure")
                {
                }
                fieldelement(VendorNo; Item."Vendor No.")
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

