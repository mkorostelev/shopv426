class GiftCertificate < ActiveRecord::Base
  belongs_to :user
  belongs_to :order
  validates :token, presence: true, uniqueness: true
  before_validation :fill_token

  scope :unordered, -> { where(order_id: nil)  }

  def fill_token
    self.token ||= SecureRandom.uuid
  end
end
