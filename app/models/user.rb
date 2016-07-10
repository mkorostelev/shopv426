class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, email: true
  validates :balance, :numericality => { :greater_than_or_equal_to => 0 }

  has_one :auth_token, dependent: :destroy
  has_many :purchases, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :gift_certificates
 end
