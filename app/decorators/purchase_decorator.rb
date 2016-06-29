class PurchaseDecorator < Draper::Decorator
     delegate_all

     def as_json *args
       {
        id: id,
        product_id: product_id,
        user_id: user_id,
        quantity: quantity,
        order_id: order_id
       }
     end
   end
