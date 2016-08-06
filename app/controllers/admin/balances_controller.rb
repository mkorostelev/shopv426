class Admin::BalancesController < Admin::BaseController

  def resource
    @balance ||= Balance.new User.find_by!(id: params[:user_id])
  end

  private
  def resource_params
    params.require(:balance).permit(:amount)
  end
end
