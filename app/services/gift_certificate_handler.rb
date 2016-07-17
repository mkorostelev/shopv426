class GiftCertificateHandler
  attr_reader :quantity, :amount, :token, :user_id

  def initialize params = {}
    params = params.symbolize_keys

    @quantity   = params[:quantity].to_i
    @amount     = params[:amount].to_i
    
  end

  def generate
    quantity.times do
      gift_certificate = GiftCertificate.create amount: amount
      gift_certificate.save!
    end
  end

end
