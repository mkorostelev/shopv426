class PurchaseHandler
  include ActiveModel::Validations
  attr_reader :quantity, :product_id, :user_id

  def initialize params = {}
    params = params.symbolize_keys

    @quantity   = params[:quantity].to_i
    @product_id = params[:product_id]
    @user_id    = params[:user_id]
  end

  def build
    purchase = Purchase.unordered.find_or_initialize_by(user_id: user_id, product_id: product_id)
    purchase.increment(:quantity, quantity)
    purchase.price = purchase.product.price
    purchase.amount = purchase.price * purchase.quantity
    purchase
  end

  def reduce
    purchase = Purchase.unordered.find_by!(user_id: user_id, product_id: product_id)
    purchase.decrement(:quantity, quantity)
    purchase.save
    purchase.destroy unless purchase.quantity > 0
  end

end
