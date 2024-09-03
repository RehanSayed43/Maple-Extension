page 50066 "WooCommerce Order"
{
    PageType = Card;
    SourceTable = "WooCommerce Header";
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(order_key; Rec.order_key)
                {
                    ApplicationArea = All;
                }
                field(id; Rec.id)
                {
                    ApplicationArea = All;
                }
                field(parent_id; Rec.parent_id)
                {
                    ApplicationArea = All;
                }
                field(number; Rec.number)
                {
                    ApplicationArea = All;
                }
                field(status; Rec.status)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        //  WooCommerceIntegration.CheckOrderInNav(Rec.order_key);
                    end;
                }
                field(created_via; Rec.created_via)
                {
                    ApplicationArea = All;
                }
                field(currency; Rec.currency)
                {
                    ApplicationArea = All;
                }
                field(date_created; Rec.date_created)
                {
                    ApplicationArea = All;
                }
                field(date_modified; Rec.date_modified)
                {
                    ApplicationArea = All;
                }
                field(discount_total; Rec.discount_total)
                {
                    ApplicationArea = All;
                }
                field(discount_tax; Rec.discount_tax)
                {
                    ApplicationArea = All;
                }
                field(shipping_total; Rec.shipping_total)
                {
                    ApplicationArea = All;
                }
                field(shipping_tax; Rec.shipping_tax)
                {
                    ApplicationArea = All;
                }
                field(cart_tax; Rec.cart_tax)
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
                field(prices_include_tax; Rec.prices_include_tax)
                {
                    ApplicationArea = All;
                }
                field(customer_id; Rec.customer_id)
                {
                    ApplicationArea = All;
                }
                field("Bill To first_name"; Rec."Bill To first_name")
                {
                    ApplicationArea = All;
                }
                field("Bill To last_name"; Rec."Bill To last_name")
                {
                    ApplicationArea = All;
                }
                field("Bill To company"; Rec."Bill To company")
                {
                    ApplicationArea = All;
                }
                field("Bill To address_1"; Rec."Bill To address_1")
                {
                    ApplicationArea = All;
                }
                field("Bill To address_2"; Rec."Bill To address_2")
                {
                    ApplicationArea = All;
                }
                field("Bill To city"; Rec."Bill To city")
                {
                    ApplicationArea = All;
                }
                field("Bill To state"; Rec."Bill To state")
                {
                    ApplicationArea = All;
                }
                field("Bill To postcode"; Rec."Bill To postcode")
                {
                    ApplicationArea = All;
                }
                field("Bill To country"; Rec."Bill To country")
                {
                    ApplicationArea = All;
                }
                field(email; Rec.email)
                {
                    ApplicationArea = All;
                }
                field(phone; Rec.phone)
                {
                    ApplicationArea = All;
                }
                field("Ship To first_name"; Rec."Ship To first_name")
                {
                    ApplicationArea = All;
                }
                field("Ship To last_name"; Rec."Ship To last_name")
                {
                    ApplicationArea = All;
                }
                field("Ship To company"; Rec."Ship To company")
                {
                    ApplicationArea = All;
                }
                field("Ship To address_1"; Rec."Ship To address_1")
                {
                    ApplicationArea = All;
                }
                field("Ship To address_2"; Rec."Ship To address_2")
                {
                    ApplicationArea = All;
                }
                field("Ship To city"; Rec."Ship To city")
                {
                    ApplicationArea = All;
                }
                field("Ship To state"; Rec."Ship To state")
                {
                    ApplicationArea = All;
                }
                field("Ship To postcode"; Rec."Ship To postcode")
                {
                    ApplicationArea = All;
                }
                field("Ship To country"; Rec."Ship To country")
                {
                    ApplicationArea = All;
                }
                field(payment_method; Rec.payment_method)
                {
                    ApplicationArea = All;
                }
                field(payment_method_title; Rec.payment_method_title)
                {
                    ApplicationArea = All;
                }
                field(transaction_id; Rec.transaction_id)
                {
                    ApplicationArea = All;
                }
                field(cart_hash; Rec.cart_hash)
                {
                    ApplicationArea = All;
                }
                field(_alg_wc_custom_order_number; Rec._alg_wc_custom_order_number)
                {
                    ApplicationArea = All;
                }
                field(_billing_order_notes; Rec._billing_order_notes)
                {
                    ApplicationArea = All;
                }
                field(_billing_type_of_delivery; Rec._billing_type_of_delivery)
                {
                    ApplicationArea = All;
                }
                field(_billing_pickup_store; Rec._billing_pickup_store)
                {
                    ApplicationArea = All;
                }
                field(_billing_gst; Rec._billing_gst)
                {
                    ApplicationArea = All;
                }
                field(_billing_store_reference; Rec._billing_store_reference)
                {
                    ApplicationArea = All;
                }
                field(_shipping_phone; Rec._shipping_phone)
                {
                    ApplicationArea = All;
                }
                field(_shipping_email; Rec._shipping_email)
                {
                    ApplicationArea = All;
                }
                field(is_vat_exempt; Rec.is_vat_exempt)
                {
                    ApplicationArea = All;
                }
                field(_billing_delivery_time; Rec._billing_delivery_time)
                {
                    ApplicationArea = All;
                }
                field(_billing_store_code; Rec._billing_store_code)
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
            action(CreateOrder)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //  CreateSalesOrder(number);
                end;
            }
        }
    }

    var
    //   WooCommerceIntegration: Codeunit "WooCommerce Integration";


    procedure CreateSalesOrder(OrderNo: Code[50])
    begin
    end;
}

