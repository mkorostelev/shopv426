class User < ActiveRecord::Base
  enum role: [:user, :admin, :super_admin]
  
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, email: true
  validates :balance, :numericality => { :greater_than_or_equal_to => 0 }
  validates :role, inclusion: roles.keys

  has_one :auth_token, dependent: :destroy
  has_many :purchases, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :gift_certificates


  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end
 end
