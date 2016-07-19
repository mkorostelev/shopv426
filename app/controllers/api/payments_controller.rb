class Api::PaymentsController < ApplicationController

  private

  def resource_params
    params.permit(:order_id, :pay_with_bonuses, certificates_tokens: [])
  end

  def collection
    @collection ||= Order.where(user_id: @current_user.id).page(params[:page]).per(5)
  end

  def resource
    @payment ||= Payment.new(resource_params.merge(current_user: current_user))
  end
end
