#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50045 "Customer Details"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Customer Details.rdl';
    PreviewMode = PrintLayout;
    ApplicationArea = FixedAsset;

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.";
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(StateCode_Customer; Customer."State Code")
            {
            }
            column(No_Customer; Customer."No.")
            {
            }
            column(Name_Customer; Customer.Name)
            {
            }
            column(Name2_Customer; Customer."Name 2")
            {
            }
            column(Address_Customer; Customer.Address)
            {
            }
            column(Address2_Customer; Customer."Address 2")
            {
            }
            column(Contact_Customer; Customer.Contact)
            {
            }
            column(PhoneNo_Customer; Customer."Phone No.")
            {
            }
            column(FaxNo_Customer; Customer."Fax No.")
            {
            }
            column(VATRegistrationNo_Customer; Customer."VAT Registration No.")
            {
            }
            column(PostCode_Customer; Customer."Post Code")
            {
            }
            column(County_Customer; Customer.County)
            {
            }
            column(EMail_Customer; Customer."E-Mail")
            {
            }
            column(PrimaryContactNo_Customer; Customer."Primary Contact No.")
            {
            }
            //column(TINNo_Customer;Customer."T.I.N. No.")            {            }
            //column(LSTNo_Customer;Customer."L.S.T. No.")            {            }
            //column(CSTNo_Customer;Customer."C.S.T. No.")            {            }
            column(PANNo_Customer; Customer."P.A.N. No.")
            {
            }
            // column(ECCNo_Customer;Customer."E.C.C. No.")            {            }
            column(PANReferenceNo_Customer; Customer."P.A.N. Reference No.")
            {
            }
            column(PANStatus_Customer; Customer."P.A.N. Status")
            {
            }
            column(GSTRegistrationNo_Customer; Customer."GST Registration No.")
            {
            }
            column(GSTRegistrationType_Customer; Customer."GST Registration Type")
            {
            }
            column(GSTCustomerType_Customer; Customer."GST Customer Type")
            {
            }
            column(eCommerceOperator_Customer; Customer."e-Commerce Operator")
            {
            }
            column(PhoneNo2_Customer; Customer."Phone No.2")
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

