class Api::BalancesController < ApplicationController

  def update!
    super

    # head :ok
  end

  def resource
    @balance ||= Balance.new current_user
  end

  private
  def resource_params
    params.require(:balance).permit(:amount)
  end
end
