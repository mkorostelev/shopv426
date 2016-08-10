class Payment
  include ActiveModel::Validations
  attr_reader :pay_with_bonuses, :order, :current_user
  BONUS_POINTS_PER_SENT_INCREAMENT = 0.04
  BONUS_POINTS_PER_SENT_CAN_USE_IN_PAYMENT = 0.2

  validate do
    # validation of unusing of certificates_tokens
    certificates_are_valid = (@certificates_tokens - GiftCertificate.unordered.map(&:token)).empty?
    errors.add(:gift_certificates, 'certificates are invalid') unless certificates_are_valid
  end

  def initialize params = {}
    params = params&.symbolize_keys || {}

    @pay_with_bonuses = ActiveRecord::ConnectionAdapters::Column::TRUE_VALUES.include?(params[:pay_with_bonuses])
    @order = Order.find_by!(id: params[:order_id], status: "pending")
    @current_user = params[:current_user]
    @certificates_tokens = params[:certificates_tokens].to_a
  end

  def update! params = {}
    raise ActiveModel::StrictValidationFailed unless valid?
    order.paid_with_real_money = order.amount

    if @certificates_tokens.count > 0
      certificates_payment_amount = [get_certificates_payment_amount, order.paid_with_real_money].min
      order.decrement(:paid_with_real_money, certificates_payment_amount)
      order.paid_with_certificates = certificates_payment_amount
    end

    if pay_with_bonuses
      order.paid_with_bonuses = [current_user.bonus_points, order.paid_with_real_money * BONUS_POINTS_PER_SENT_CAN_USE_IN_PAYMENT].min.round
      order.decrement(:paid_with_real_money, order.paid_with_bonuses)
    end

    if order.paid_with_real_money <= current_user.balance
      order.status = Order.statuses["accepted"]
      order.gift_certificates = used_certificates
      order.received_bonuses = order.paid_with_real_money * BONUS_POINTS_PER_SENT_INCREAMENT
      order.save

      # Balance.new(current_user).update! this_is_payment: true,
      #                                   bonus_points: order.received_bonuses - order.paid_with_bonuses,
      #                                   amount: - order.paid_with_real_money
      current_user.decrement(:balance, order.paid_with_real_money)
      current_user.bonus_points = current_user.bonus_points - order.paid_with_bonuses + order.received_bonuses
      current_user.save
    else
      errors.add(:amount, 'insuficient funds')
      raise ActiveModel::StrictValidationFailed
    end

  end

  def get_certificates_payment_amount
    used_certificates.sum(:amount)
  end

  def used_certificates
    GiftCertificate.unordered.where(token: @certificates_tokens)
  end

  def decorate
    order
  end

end
