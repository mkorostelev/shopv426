class PurchaseDecorator < Draper::Decorator
delegate_all

  def as_json *args
    if context[:short_view]
      {
        id: id,
        product_id: product_id,
        user_id: user_id,
        quantity: quantity,
        order_id: order_id
      }
    else
      {
        id: id,
        product_name: product.name,
        product_price: price,
        product_quantity: quantity,
        sum: amount,
        discount: discount_amount,
        discount_percent: discount_percent,
        purchase_to_pay: amount_to_pay
      }
    end

  end
end
