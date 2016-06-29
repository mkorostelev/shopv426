class OrderDecorator < Draper::Decorator
     delegate_all

     def as_json *args
       {
        id: id,
        user_id: user_id,
        purchases: Purchase.where(order_id: id).decorate,
        amount: amount,
        status: status
       }
     end

   end
