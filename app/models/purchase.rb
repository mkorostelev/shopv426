class Purchase < ActiveRecord::Base
  belongs_to :product
  belongs_to :user
  scope :unordered, -> { where(order_id: nil)  }
  validates :quantity, :numericality => { :greater_than_or_equal_to => 0 }
end
