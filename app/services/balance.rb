class Balance
  include ActiveModel::Validations

  attr_accessor :amount, :bonus_points, :this_is_payment

  attr_reader :user

  # validates :amount, numericality: { greater_than_or_equal_to: 0 }

  validate do |balance|
    unless balance.user.valid?
      balance.user.errors.full_messages.each do |msg|
        errors[:base] << "User Error: #{msg}"
      end
    end
  end

  def initialize user
    @user = user
  end

  def update!(params = {})

    params = params&.symbolize_keys || {}

    @amount = params[:amount].to_i

    @bonus_points = params[:bonus_points].to_i

    @this_is_payment = params[:this_is_payment]

    # unless @this_is_payment
    #   raise ActiveModel::StrictValidationFailed unless valid?
    # end

    user.balance      += amount

    user.bonus_points += bonus_points



    user.save

    raise ActiveModel::StrictValidationFailed unless valid?

    self
  end

  def decorate
    user.decorate
  end
end
