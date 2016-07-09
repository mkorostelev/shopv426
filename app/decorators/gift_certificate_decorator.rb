class GiftCertificateDecorator < Draper::Decorator
  delegate_all

  def as_json *args
    {
     id: id,
     user_id: user_id,
     order_id: order_id,
     amount: amount,
     token: token
    }
  end

end
