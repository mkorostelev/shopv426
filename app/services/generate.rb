class Generate
  include ActiveModel::Validations
  attr_accessor :amount, :quantity
  validates :amount, :quantity, numericality: { greater_than_or_equal_to: 0 }


  def initialize params = {}
    params = params&.symbolize_keys || {}

    @quantity   = params[:quantity].to_i
    @amount     = params[:amount].to_i

    @gift_certificates = []
    quantity.times do
      gift_certificate = GiftCertificate.new amount: amount
      @gift_certificates.push(gift_certificate)
    end
  end

  def save!
    raise ActiveModel::StrictValidationFailed unless valid?

    @gift_certificates.each(&:save!)
  end

  def decorate
    @collection ||= GiftCertificate.unordered
  end
end
