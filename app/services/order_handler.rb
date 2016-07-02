class OrderHandler
  attr_reader :pay_with_bonuses, :order, :current_user

  def initialize params = {}
    params = params.symbolize_keys

    @pay_with_bonuses = ActiveRecord::ConnectionAdapters::Column::TRUE_VALUES.include?(params[:pay_with_bonuses])
    @order = Order.find_by!(id: params[:id], status: "Pending")
    @current_user = params[:current_user]
  end

  def build
    bonuses_payment_amount = 0
    if pay_with_bonuses
      bonuses_payment_amount = [current_user.bonus_points, order.amount * 0.2].min.round
    end

    if order.amount <= current_user.balance + bonuses_payment_amount
      order.status = 1

      real_cash_amount = order.amount - bonuses_payment_amount
      current_user.decrement(:balance, real_cash_amount)

      current_user.bonus_points = current_user.bonus_points - bonuses_payment_amount + real_cash_amount * 0.04

      current_user.save

      # order.save!
      order
    else
      # no money
      render :exception
    end
  end
end
