class Order < ActiveRecord::Base
  enum status: {
    "Pending"   => 0,
    "Accepted"  => 1,
    "Declained" => 2
  }
  belongs_to :user
  has_many :purchases, dependent: :destroy

  after_create :fill_order_id_in_purchases

  def fill_order_id_in_purchases
    purchases = Purchase.where(user_id: self.user_id, order_id: nil)
    amount = 0;
    purchases.each do |purchase|
      purchase.update_attribute(:order_id, self.id)

      amount += purchase.product.price * purchase.quantity

    end

    self.update_attribute(:amount, amount)
  end
end
