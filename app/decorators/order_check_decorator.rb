class OrderCheckDecorator < Draper::Decorator
     delegate_all

     def as_json *args
       {
        id: id,
        purchases: PurchaseCheckDecorator.decorate_collection(Purchase.where(order_id: id)),
        order_sum: amount,
        order_discount: discount_amount,
        order_discount_percent: discount_percent,
        order_to_pay: amount_to_pay
       }
     end

   end
