class Generate
  include ActiveModel::Validations
  attr_accessor :amount, :quantity
  validates :amount, :quantity, numericality: { greater_than_or_equal_to: 0 }


  def initialize params = {}
    params = params&.symbolize_keys || {}

    @quantity   = params[:quantity].to_i
    @amount     = params[:amount].to_i

  end

  def create

    raise ActiveModel::StrictValidationFailed unless valid?

    quantity.times do
      gift_certificate = GiftCertificate.create amount: amount
      gift_certificate.save!
    end
  end

  def decorate
    @collection ||= GiftCertificate.unordered
  end
end
