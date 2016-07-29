class Api::BalancesController < ApplicationController

  # def update!
  #   byebug
  #   super
  #
  #   # head :ok
  # end

  def resource
    @balance ||= Balance.new current_user
  end

  private
  def resource_params
    params.require(:balance).permit(:amount)
  end
end
