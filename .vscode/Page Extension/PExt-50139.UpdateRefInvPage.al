pageextension 50139 "UpdateRef Inv Page" extends "Update Reference Invoice No"

{
    layout
    {
        modify("Reference Invoice Nos.")
        {
            Visible = false;
        }

        addafter("Reference Invoice Nos.")
        {
            field("Reference Invoice Noss."; Rec."Reference Invoice Noss.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Reference Invoice number.';

                trigger OnLookup(var Text: Text): Boolean
                var
                    RefInvNoMgt: Codeunit "Reference Invoice No. Mgt.";
                    ReferenceInvoiceNoMgt: Codeunit ReferenceInvoiceNoMgt; //ccit_kj
                    RefNoAlterErr: Label 'Reference Invoice No cannot be updated after verification.';
                begin
                    if Rec."Source Type" = Rec."Source Type"::Vendor then
                        //ccit_kj
                        ReferenceInvoiceNoMgt.UpdateReferenceInvoiceNoforVendor(rec, Rec."Document Type", Rec."Document No.", true)
                    else
                        ReferenceInvoiceNoMgt.UpdateReferenceInvoiceNoforCustomer(rec, Rec."Document Type", Rec."Document No.");

                    if xRec."Reference Invoice Nos." <> '' then
                        if (xRec."Reference Invoice Nos." <> Rec."Reference Invoice Nos.") and Rec.Verified then
                            Error(RefNoAlterErr);
                end;
            }
        }

    }

    actions
    {
        // Add changes to page actions here
        modify(Verify)
        {
            trigger OnAfterAction()
            var
                SCH: Record "Sales Header";
                refInvNo: Record "Reference Invoice No.";
            begin
                refInvNo.Reset();
                refInvNo.SetRange("Document No.", Rec."Document No.");
                refInvNo.SetRange("Document Type", Rec."Document Type");
                if refInvNo.FindFirst() then
                    if refInvNo.Verified = true then begin
                        if SCH.get(sch."Document Type"::"Credit Memo", Rec."Document No.") then begin
                            Sch."Reference Invoice No." := refInvNo."Reference Invoice Nos.";
                            SCH.Modify();
                        end;

                    end;
            end;
        }
    }

    var
        myInt: Integer;
}