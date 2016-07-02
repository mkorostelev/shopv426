class Api::OrdersController < ApplicationController
  # skip_before_action :authenticate

  # def payment
  #   OrderHandler.new(params.merge(current_user: current_user)).build
  # end

  def index
    render "orders/index"
  end

  def update
    OrderHandler.new(params.merge(current_user: current_user)).build
    render "orders/index"
  end

  private
  def build_resource
    @order = Order.new
    @order.user_id = @current_user.id
  end

  def resource
    @order
  end

  def collection
    @collection ||= Order.where(user_id: @current_user.id).page(params[:page]).per(5)
  end
end
