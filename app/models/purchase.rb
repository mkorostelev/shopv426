class Purchase < ActiveRecord::Base
  DISCOUNT_PERCENT_BY_INDEX = 7
  DISCOUNT_PERCENT_BY_INDEX_LIMIT = 60
  EACH_INDEX_FOR_DISCOUNT = 2

  belongs_to :product
  belongs_to :user
  scope :unordered, -> { where(order_id: nil)  }
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }

  before_validation :recount_amount

  private
  def recount_amount
    self.price = product.price
    self.amount = price * quantity
    
    if line_number.modulo(EACH_INDEX_FOR_DISCOUNT) == 0
      self.discount_percent = [line_number * DISCOUNT_PERCENT_BY_INDEX,
                                    DISCOUNT_PERCENT_BY_INDEX_LIMIT].min
    end
    self.discount_amount = self.amount * self.discount_percent / 100
    self.amount_to_pay = self.amount - self.discount_amount
  end
end
