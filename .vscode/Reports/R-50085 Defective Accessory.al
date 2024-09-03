report 50085 "Defective Accessory Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './DefectiveAccessoryReport.rdl';
    ApplicationArea = FixedAsset;

    dataset
    {
        dataitem("Defective Accessory"; "Defective Accessory")
        {
            DataItemTableView = WHERE(Posted = FILTER(True));
            column(TransactionNo_DefectiveAccessory; "Defective Accessory"."Transaction No")
            {
            }
            column(CreationDate_DefectiveAccessory; "Defective Accessory"."Creation Date")
            {
            }
            column(Zone_DefectiveAccessory; "Defective Accessory".Zone)
            {
            }
            column(State_DefectiveAccessory; "Defective Accessory".State)
            {
            }
            column(City_DefectiveAccessory; "Defective Accessory".City)
            {
            }
            column(LocationCode_DefectiveAccessory; "Defective Accessory"."Location Code")
            {
            }
            column(CustomerType_DefectiveAccessory; "Defective Accessory"."Customer Type")
            {
            }
            column(CustomerNo_DefectiveAccessory; "Defective Accessory"."Customer No")
            {
            }
            column(CustomerName_DefectiveAccessory; "Defective Accessory"."Customer Name")
            {
            }
            column(InvoiceNo_DefectiveAccessory; "Defective Accessory"."Invoice No")
            {
            }
            column(PostingDate_DefectiveAccessory; "Defective Accessory"."Posting Date")
            {
            }
            column(Brand_DefectiveAccessory; "Defective Accessory".Brand)
            {
            }
            column(Category_DefectiveAccessory; "Defective Accessory".Category)
            {
            }
            column(PrimaryCategory_DefectiveAccessory; "Defective Accessory"."Primary Category")
            {
            }
            column(MaplePartCode_DefectiveAccessory; "Defective Accessory"."Maple Part Code")
            {
            }
            column(VendorpartCode_DefectiveAccessory; "Defective Accessory"."Vendor part Code")
            {
            }
            column(Description_DefectiveAccessory; "Defective Accessory".Description)
            {
            }
            column(QtyTakenBack_DefectiveAccessory; "Defective Accessory"."Qty. Taken Back")
            {
            }
            column(UPNNo_DefectiveAccessory; "Defective Accessory"."UPN No")
            {
            }
            column(GivenBrand_DefectiveAccessory; "Defective Accessory"."Given Brand")
            {
            }
            column(GivenCategory_DefectiveAccessory; "Defective Accessory"."Given Category")
            {
            }
            column(GivenPrimaryCategory_DefectiveAccessory; "Defective Accessory"."Given Primary Category")
            {
            }
            column(GivenMaplePartCode_DefectiveAccessory; "Defective Accessory"."Given Maple Part Code")
            {
            }
            column(GivenVendorpartCode_DefectiveAccessory; "Defective Accessory"."Given Vendor part Code")
            {
            }
            column(GivenDescription_DefectiveAccessory; "Defective Accessory"."Given Description")
            {
            }
            column(QtyGiven_DefectiveAccessory; "Defective Accessory"."Qty. Given")
            {
            }
            column(GivenUPNNo_DefectiveAccessory; "Defective Accessory"."Given UPN No")
            {
            }
            column(DamageLocation_DefectiveAccessory; "Defective Accessory"."Damage Location")
            {
            }
            column(InvoiceDate_DefectiveAccessory; "Defective Accessory"."Invoice Date")
            {
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

    labels
    {
    }
}

