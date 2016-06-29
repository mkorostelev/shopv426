class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence: true

  validates :email, presence: true, uniqueness: { case_sensitive: false }, email: true

  has_one :auth_token, dependent: :destroy
  has_many :purchases, dependent: :destroy
  has_many :orders, dependent: :destroy
 end
