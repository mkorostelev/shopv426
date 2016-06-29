class Api::OrdersController < ApplicationController
  # skip_before_action :authenticate

  def index
    render "orders/index"
  end

  private
  def build_resource
    # byebug
    # params ||= {}
    # params["order"]["user_id"] = @current_user.id
    @order = Order.new #resource_params
    @order.user_id = @current_user.id
  end

  def resource
    @order
  end

  def resource_params
    params.require(:order).permit(:user_id, :amount, :status)
  end

  def collection

    @collection ||= Order.where(user_id: @current_user.id).page(params[:page]).per(5)

  end
  #code
end
