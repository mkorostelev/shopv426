class PurchaseHandler
  include ActiveModel::Validations
  attr_reader :product_id, :user_id

  attr_accessor :quantity
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }

  def initialize params = {}
    params = params&.symbolize_keys || {}

    @quantity   = params[:quantity].to_i
    @product_id = params[:product_id]
    @user_id    = params[:user_id]
  end

  def save!
    validate_data

    purchase = Purchase.unordered.find_or_initialize_by(user_id: user_id, product_id: product_id)
    purchase.increment(:quantity, quantity)
    purchase.save
  end

  def destroy
    validate_data

    purchase = Purchase.unordered.find_by!(user_id: user_id, product_id: product_id)
    purchase.decrement(:quantity, quantity)
    if purchase.quantity > 0
      purchase.save
    else
      purchase.destroy
    end
  end

  private

  def validate_data
    raise ActiveModel::StrictValidationFailed unless valid?
  end

end
