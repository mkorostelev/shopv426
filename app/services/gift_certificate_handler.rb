class GiftCertificateHandler
  attr_reader :quantity, :amount, :token, :user_id

  def initialize params = {}
    params = params.symbolize_keys

    @quantity   = params[:quantity].to_i
    @amount     = params[:amount].to_i

    @token      = params[:token]
    @user_id    = params[:user_id]
  end

  def generate
    quantity.times do
      gift_certificate = GiftCertificate.create amount: amount
      gift_certificate.save!
    end
  end

  def connect_to_user
    gift_certificate = GiftCertificate.unordered.unconnected.find_by!(token: token)
    gift_certificate.update_attribute(:user_id, user_id)
  end
end
