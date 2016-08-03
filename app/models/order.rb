  class Order < ActiveRecord::Base
  enum status: [:pending, :accepted, :declined]

  belongs_to :user

  has_many :purchases, dependent: :destroy

  has_many :gift_certificates

  validates_presence_of :purchases

  validates :amount, numericality: { greater_than_or_equal_to: 0 }

  validates :paid_with_bonuses, numericality: { greater_than_or_equal_to: 0 }

  validates :paid_with_certificates, numericality: { greater_than_or_equal_to: 0 }

  validates :received_bonuses, numericality: { greater_than_or_equal_to: 0 }
end
