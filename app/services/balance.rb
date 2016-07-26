class Balance
  include ActiveModel::Validations
  attr_accessor :amount
  attr_reader :current_user
  validates :amount, numericality: { greater_than_or_equal_to: 0 }

  def initialize current_user
    @current_user = current_user
  end

  def update! params = {}
    params = params&.symbolize_keys || {}
    @amount = params[:amount].to_i
    raise ActiveModel::StrictValidationFailed unless valid?

    current_user.increment(:balance, amount)
    current_user.save
    self
  end

  def decorate
    current_user
  end
end
