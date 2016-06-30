class Purchase < ActiveRecord::Base
  belongs_to :product
  belongs_to :user
  scope :unordered, -> { where(order_id: nil)  }
end
