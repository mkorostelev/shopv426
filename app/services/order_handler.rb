class OrderHandler
  attr_reader :pay_with_bonuses, :order, :current_user
  BONUS_POINTS_PER_SENT_INCREAMENT = 0.04
  BONUS_POINTS_PER_SENT_CAN_USE_IN_PAYMENT = 0.2

  def initialize params = {}
    params = params.symbolize_keys

    @pay_with_bonuses = ActiveRecord::ConnectionAdapters::Column::TRUE_VALUES.include?(params[:pay_with_bonuses])
    @order = Order.find_by!(id: params[:id], status: "Pending")
    @current_user = params[:current_user]
    @certtificates_tokens = params[:certtificates_tokens]
  end

  def build
    
    bonuses_payment_amount        = 0
    amount_left_to_pay            = order.amount
    certificates_are_valid = (@certtificates_tokens - GiftCertificate.unordered.map(&:token)).empty?

    if !certificates_are_valid
      render :exception
    end

    used_certificates = GiftCertificate.unordered.where(token: @certtificates_tokens)
    certificates_payment_amount = used_certificates.sum(:amount)

    # 1 first will try to use certificates for payment
    amount_left_to_pay -= [certificates_payment_amount, amount_left_to_pay].min

    # 2 try to use bonus points for payment
    if pay_with_bonuses
      bonuses_payment_amount = [current_user.bonus_points, amount_left_to_pay * BONUS_POINTS_PER_SENT_CAN_USE_IN_PAYMENT].min.round
      amount_left_to_pay -= bonuses_payment_amount
    end

    # 3 real money payment, if needed
    if amount_left_to_pay <= current_user.balance
      order.status = Order.statuses["Accepted"]

      current_user.decrement(:balance, amount_left_to_pay)
      current_user.bonus_points = current_user.bonus_points - bonuses_payment_amount + amount_left_to_pay * BONUS_POINTS_PER_SENT_INCREAMENT
      # add certtificates to user
      current_user.gift_certificates << used_certificates
      current_user.save

      # add certtificates to order
      order.gift_certificates = used_certificates
      order.save!
      # order
    else
      # no money
      render :exception
    end
  end
end
