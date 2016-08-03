class PurchaseHandler
  DISCOUNT_PERCENT_BY_INDEX = 7

  DISCOUNT_PERCENT_LIMIT = 60

  EACH_INDEX_FOR_DISCOUNT = 2

  include ActiveModel::Validations

  attr_reader :product_id, :user_id

  attr_accessor :quantity

  validates :quantity, numericality: { greater_than_or_equal_to: 0 }

  def initialize(params = {})
    params = params&.symbolize_keys || {}

    @quantity = params[:quantity].to_i

    @product_id = params[:product_id]

    @user_id = params[:user_id]
  end

  def save!
    validate

    purchase = Purchase.unordered.find_or_initialize_by(user_id: user_id, product_id: product_id)

    purchase.increment(:quantity, quantity)

    purchase.save
  end

  def destroy
    validate

    purchase = Purchase.unordered.find_by!(user_id: user_id, product_id: product_id)

    purchase.decrement(:quantity, quantity)

    if purchase.quantity > 0

      purchase.save

    else

      purchase.destroy

    end
  end


  def decorate
    Purchase.where(user_id: user_id, order_id: nil)
  end

  def self.recount_amount (purchase)
    purchase.price = purchase.product.price

    purchase.amount = purchase.price * purchase.quantity

    if purchase.line_number.modulo(EACH_INDEX_FOR_DISCOUNT) == 0

      purchase.discount_percent = [purchase.line_number * DISCOUNT_PERCENT_BY_INDEX,
                                   DISCOUNT_PERCENT_LIMIT].min

    end

    purchase.discount_amount = purchase.amount * purchase.discount_percent / 100

    purchase.amount_to_pay = purchase.amount - purchase.discount_amount

    purchase.save
  end

  private

  def validate
    raise ActiveModel::StrictValidationFailed unless valid?
  end

end
