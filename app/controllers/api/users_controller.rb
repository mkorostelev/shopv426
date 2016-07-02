class Api::UsersController < ApplicationController
  skip_before_action :authenticate, only: [:create]

  # def update
  #   current_user.increment(:balance, params[:amount].to_i)
  #   current_user.save
  #   user = current_user
  # end

  private
  def build_resource
    @user = User.new resource_params
  end

  def resource
    # <<<QUESTION if I use standart method of user - system want paramrter "user" in curl
    current_user.increment(:balance, params[:user][:amount].to_i)
    @user = current_user
  end

  def resource_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  #code
end
