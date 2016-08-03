class OrderHandler
  attr_reader :user, :order
  def initialize(user)
    @user = user
  end

  def create
    @order = user.orders.new

    @order.purchases = Purchase.unordered.where(user_id: user.id).order(amount: :desc)

    fill_purchases

    @order.discount_percent = order.discount_amount * 100 / order.amount

    @order
  end

  private

  def fill_purchases
    @order.purchases.each do |purchase|
      purchase.line_number = (order.purchases.index(purchase) + 1)

      PurchaseHandler.recount_amount purchase

      # purchase.save

      order.amount += purchase.amount

      order.amount_to_pay += purchase.amount_to_pay

      order.discount_amount += purchase.discount_amount
    end
  end
end