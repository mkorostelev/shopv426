class Api::UsersController < ApplicationController

  skip_before_action :authenticate, only: [:create]

  include ActiveModel::Validations
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  validate do |model|
    model.errors.add :password, 'not found'
  end

  def update
    authorize User
    # raise ActiveModel::StrictValidationFailed unless valid?
    current_user.increment(:balance, increment_balance_params[:amount].to_i)
    current_user.save
    resource
  end

  def user_not_authorized
    # render :errors, status: :unprocessable_entity
    errors.add :base, 'access denied'
    render :errors, status: :unprocessable_entity
    # raise ActiveModel::StrictValidationFailed
  end

  private
  def build_resource
    @user = User.new resource_params
  end

  def resource
    @user = current_user
  end

  def resource_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def increment_balance_params
    params.permit(:amount)
  end

end
