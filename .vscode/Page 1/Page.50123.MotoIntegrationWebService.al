page 50123 "Moto Integration Web Service"
{
    PageType = List;
    SourceTable = 50033;
    ApplicationArea = FixedAsset;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(id; Rec.id)
                {
                    ApplicationArea = all;
                }
                field(status; Rec.status)
                {
                    ApplicationArea = all;
                }
                field("Navision Order No"; Rec."Navision Order No")
                {
                    ApplicationArea = all;
                }
                field(order_number; Rec.order_number)
                {
                    ApplicationArea = all;
                }
                field(order_date; Rec.order_date)
                {
                    ApplicationArea = all;
                }
                field(order_type; Rec.order_type)
                {
                    ApplicationArea = all;
                }
                field(ship_by_date; Rec.ship_by_date)
                {
                    ApplicationArea = all;
                }
                field(child_courier; Rec.child_courier)
                {
                    ApplicationArea = all;
                }
                field(invoice_number; Rec.invoice_number)
                {
                    ApplicationArea = all;
                }
                field(invoice_url; Rec.invoice_url)
                {
                    ApplicationArea = all;
                }
                field("Order ID"; Rec."Order ID")
                {
                    ApplicationArea = all;
                }
                field(product_id; Rec.product_id)
                {
                    ApplicationArea = all;
                }
                field(variation_id; Rec.variation_id)
                {
                    ApplicationArea = all;
                }
                field(quantity11; Rec.quantity11)
                {
                    ApplicationArea = all;
                }
                field(tax_class; Rec.tax_class)
                {
                    ApplicationArea = all;
                }
                field(subtotal; Rec.subtotal)
                {
                    ApplicationArea = all;
                }
                field(subtotal_tax; Rec.subtotal_tax)
                {
                    ApplicationArea = all;
                }
                field(total; Rec.total)
                {
                    ApplicationArea = all;
                }
                field(total_tax; Rec.total_tax)
                {
                    ApplicationArea = all;
                }
                field(initial_price; Rec.initial_price)
                {
                    ApplicationArea = all;
                }
                field(discounted_price; Rec.discounted_price)
                {
                    ApplicationArea = all;
                }
                field(set_discount; Rec.set_discount)
                {
                    ApplicationArea = all;
                }
                field(bulk_discount; Rec.bulk_discount)
                {
                    ApplicationArea = all;
                }
                field(discount_type; Rec.discount_type)
                {
                    ApplicationArea = all;
                }
                field(discount_value; Rec.discount_value)
                {
                    ApplicationArea = all;
                }
                field(discount_quantity; Rec.discount_quantity)
                {
                    ApplicationArea = all;
                }
                field(discount_price_per_quantity; Rec.discount_price_per_quantity)
                {
                    ApplicationArea = all;
                }
                field(discount_price; Rec.discount_price)
                {
                    ApplicationArea = all;
                }
                field(cart_quantity; Rec.cart_quantity)
                {
                    ApplicationArea = all;
                }
                field(sku; Rec.sku)
                {
                    ApplicationArea = all;
                }
                field(price; Rec.price)
                {
                    ApplicationArea = all;
                }
                field("Shipping method_title"; Rec."Shipping method_title")
                {
                    ApplicationArea = all;
                }
                field("Shipping method_id"; Rec."Shipping method_id")
                {
                    ApplicationArea = all;
                }
                field("Shipping instance_id"; Rec."Shipping instance_id")
                {
                    ApplicationArea = all;
                }
                field("Shipping total"; Rec."Shipping total")
                {
                    ApplicationArea = all;
                }
                field("Shipping total_tax"; Rec."Shipping total_tax")
                {
                    ApplicationArea = all;
                }
                field(order_key; Rec.order_key)
                {
                    ApplicationArea = all;
                }
                field(LineNo; Rec.LineNo)
                {
                    ApplicationArea = all;
                }
                field("Navision Remarks"; Rec."Navision Remarks")
                {
                    ApplicationArea = all;
                }
                field(_delivery_time; Rec._delivery_time)
                {
                    ApplicationArea = all;
                }
                field(_expected_delivery_time; Rec._expected_delivery_time)
                {
                    ApplicationArea = all;
                }
                field(_is_lob; Rec._is_lob)
                {
                    ApplicationArea = all;
                }
                field("CRT Coupon Code"; Rec."CRT Coupon Code")
                {
                    ApplicationArea = all;
                }
                field(product_sku; Rec.product_sku)
                {
                    ApplicationArea = all;
                }
                field(quantity; Rec.quantity)
                {
                    ApplicationArea = all;
                }
                field(payment_mode; Rec.payment_mode)
                {
                    ApplicationArea = all;
                }
                field(total_price; Rec.total_price)
                {
                    ApplicationArea = all;
                }
                field(cod_amount; Rec.cod_amount)
                {
                    ApplicationArea = all;
                }
                field(discount; Rec.discount)
                {
                    ApplicationArea = all;
                }
                field(mrp; Rec.mrp)
                {
                    ApplicationArea = all;
                }
                field(advance_payment; Rec.advance_payment)
                {
                    ApplicationArea = all;
                }
                field(round_off; Rec.round_off)
                {
                    ApplicationArea = all;
                }
                field(cgst_percentage; Rec.cgst_percentage)
                {
                    ApplicationArea = all;
                }
                field(cgst_amount; Rec.cgst_amount)
                {
                    ApplicationArea = all;
                }
                field(sgst_percentage; Rec.sgst_percentage)
                {
                    ApplicationArea = all;
                }
                field(sgst_amount; Rec.sgst_amount)
                {
                    ApplicationArea = all;
                }
                field(igst_percentage; Rec.igst_percentage)
                {
                    ApplicationArea = all;
                }
                field(igst_amount; Rec.igst_amount)
                {
                    ApplicationArea = all;
                }
                field(tan_number; Rec.tan_number)
                {
                    ApplicationArea = all;
                }
                field(vat_number; Rec.vat_number)
                {
                    ApplicationArea = all;
                }
                field(cst_number; Rec.cst_number)
                {
                    ApplicationArea = all;
                }
                field(name; Rec.name)
                {
                    ApplicationArea = all;
                }
                field(address_line1; Rec.address_line1)
                {
                    ApplicationArea = all;
                }
                field(pin_code; Rec.pin_code)
                {
                    ApplicationArea = all;
                }
                field(city; Rec.city)
                {
                    ApplicationArea = all;
                }
                field(state; Rec.state)
                {
                    ApplicationArea = all;
                }
                field(country; Rec.country)
                {
                    ApplicationArea = all;
                }
                field(primary_phone_number; Rec.primary_phone_number)
                {
                    ApplicationArea = all;
                }
                field(Payment_mode_1; Rec.Payment_mode_1)
                {
                    ApplicationArea = all;
                }
                field(primary_email_id; Rec.primary_email_id)
                {
                    ApplicationArea = all;
                }
                field(Status_Ret; Rec.Status_Ret)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

