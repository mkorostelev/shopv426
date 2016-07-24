class UserPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @user = model
  end

  def update?
    @current_user.admin? || @current_user.super_admin? || @current_user == @user
  end
end
