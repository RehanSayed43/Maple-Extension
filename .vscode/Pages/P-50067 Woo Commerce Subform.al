page 50067 "Woo Commerce Subform"
{
    PageType = List;
    SourceTable = "Woo Commerce Line";
    ApplicationArea = All;
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(order_key; Rec.order_key)
                {
                    ApplicationArea = All;
                }
                field("Order ID"; Rec."Order ID")
                {
                    ApplicationArea = All;
                }
                field(id; Rec.id)
                {
                    ApplicationArea = All;
                }
                field(name; Rec.name)
                {
                    ApplicationArea = All;
                }
                field(product_id; Rec.product_id)
                {
                    ApplicationArea = All;
                }
                field(variation_id; Rec.variation_id)
                {
                    ApplicationArea = All;
                }
                field(quantity; Rec.quantity)
                {
                    ApplicationArea = All;
                }
                field(tax_class; Rec.tax_class)
                {
                    ApplicationArea = All;
                }
                field(subtotal; Rec.subtotal)
                {
                    ApplicationArea = All;
                }
                field(subtotal_tax; Rec.subtotal_tax)
                {
                    ApplicationArea = All;
                }
                field(total; Rec.total)
                {
                    ApplicationArea = All;
                }
                field(total_tax; Rec.total_tax)
                {
                    ApplicationArea = All;
                }
                field(initial_price; Rec.initial_price)
                {
                    ApplicationArea = All;
                }
                field(discounted_price; Rec.discounted_price)
                {
                    ApplicationArea = All;
                }
                field(set_discount; Rec.set_discount)
                {
                    ApplicationArea = All;
                }
                field(bulk_discount; Rec.bulk_discount)
                {
                    ApplicationArea = All;
                }
                field(discount_type; Rec.discount_type)
                {
                    ApplicationArea = All;
                }
                field(discount_value; Rec.discount_value)
                {
                    ApplicationArea = All;
                }
                field(discount_quantity; Rec.discount_quantity)
                {
                    ApplicationArea = All;
                }
                field(discount_price_per_quantity; Rec.discount_price_per_quantity)
                {
                    ApplicationArea = All;
                }
                field(discount_price; Rec.discount_price)
                {
                    ApplicationArea = All;
                }
                field(cart_quantity; Rec.cart_quantity)
                {
                    ApplicationArea = All;
                }
                field(sku; Rec.sku)
                {
                    ApplicationArea = All;
                }
                field(price; Rec.price)
                {
                    ApplicationArea = All;
                }
                field("Shipping method_title"; Rec."Shipping method_title")
                {
                    ApplicationArea = All;
                }
                field("Shipping method_id"; Rec."Shipping method_id")
                {
                    ApplicationArea = All;
                }
                field("Shipping instance_id"; Rec."Shipping instance_id")
                {
                    ApplicationArea = All;
                }
                field("Shipping total"; Rec."Shipping total")
                {
                    ApplicationArea = All;
                }
                field("Shipping total_tax"; Rec."Shipping total_tax")
                {
                    ApplicationArea = All;
                }
                field(_billing_store_code; Rec._billing_store_code)
                {
                    ApplicationArea = All;
                }
                field(_delivery_time; Rec._delivery_time)
                {
                    ApplicationArea = All;
                }
                field(_expected_delivery_time; Rec._expected_delivery_time)
                {
                    ApplicationArea = All;
                }
                field(_is_lob; Rec._is_lob)
                {
                    ApplicationArea = All;
                }
                field("CRT Coupon Code"; Rec."CRT Coupon Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

