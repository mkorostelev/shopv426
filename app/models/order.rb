class Order < ActiveRecord::Base
  enum status: {
    "Pending"   => 0,
    "Accepted"  => 1,
    "Declained" => 2
  }
  belongs_to :user
  has_many :purchases, dependent: :destroy
  validates_presence_of :purchases
  
  after_create :fill_order_id_in_purchases

  def fill_order_id_in_purchases
    self.purchases = Purchase.unordered.where(user_id: user_id)

    self.amount = self.purchases.inject(0){|q, value| q+=value.quantity*value.product.price}

    self.save
  end
end
