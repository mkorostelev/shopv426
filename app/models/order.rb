  class Order < ActiveRecord::Base
  enum status: {
    "pending"   => 0,
    "accepted"  => 1,
    "declained" => 2
  }
  belongs_to :user
  has_many :purchases, dependent: :destroy
  has_many :gift_certificates
  validates_presence_of :purchases
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  validates :paid_with_bonuses, numericality: { greater_than_or_equal_to: 0 }
  validates :paid_with_certificates, numericality: { greater_than_or_equal_to: 0 }
  validates :received_bonuses, numericality: { greater_than_or_equal_to: 0 }

  before_validation :fill_order_id_in_purchases

  def fill_order_id_in_purchases

    if self.purchases.count > 0
      return
    end
    self.purchases = Purchase.unordered.where(user_id: user_id).order(amount: :desc)
    self.purchases.each do |purchase|
      purchase.line_number = (self.purchases.index(purchase) + 1)

      purchase.save
      self.amount += purchase.amount
      self.amount_to_pay += purchase.amount_to_pay
      self.discount_amount += purchase.discount_amount
    end
    self.discount_percent = self.discount_amount * 100 / self.amount
    # self.amount = self.purchases.inject(0){|q, value| q+=value.quantity*value.product.price}

    # self.save
  end
end
