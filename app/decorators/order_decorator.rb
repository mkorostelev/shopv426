class OrderDecorator < Draper::Decorator
  delegate_all
  decorates_association :purchases#, context: {foo: "bar"}

  def as_json *args
    if context[:short_view] # if index
      {
        id: id,
        user_id: user_id,
        purchases: purchases,#Purchase.where(order_id: id).decorate,
        amount: amount,
        status: status
      }
    else #if check
      {
       id: id,
       purchases: purchases,
       order_sum: amount,
       order_discount: discount_amount,
       order_discount_percent: discount_percent,
       order_to_pay: amount_to_pay
      }
    end
  end
end
