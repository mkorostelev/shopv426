class Api::UsersController < ApplicationController

  skip_before_action :authenticate, only: [:create]

  include ActiveModel::Validations

  # def update
  #   authorize resource
  #
  #   resource.increment(:balance, increment_balance_params[:amount].to_i)
  # end

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

  # def increment_balance_params
  #   params.permit(:amount)
  # end

end
