class Api::UsersController < ApplicationController

  skip_before_action :authenticate, only: [:create]

  include ActiveModel::Validations

  def create
    # super
    render "create"
  end

  def update
    authorize resource

    super
  end

  private
  def build_resource
    @user = User.new resource_params
  end

  def resource
    @user = User.find(params&.symbolize_keys[:id]) || current_user
  end

  def resource_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # def increment_balance_params
  #   params.permit(:amount)
  # end

end
