class Balance
  include ActiveModel::Validations

  attr_accessor :amount, :bonus_points, :this_is_payment

  attr_reader :user

  validates :amount, numericality: { greater_than_or_equal_to: 0 }

  def initialize current_user
    @user = current_user
  end

  def update!(params = {})

    params = params&.symbolize_keys || {}

    @amount = params[:amount].to_i

    @bonus_points = params[:bonus_points].to_i

    @this_is_payment = params[:this_is_payment]

    unless @this_is_payment
      raise ActiveModel::StrictValidationFailed unless valid?
    end

    user.balance      += amount

    user.bonus_points += bonus_points

    user.save

    self
  end

  def decorate
    user
  end
end
