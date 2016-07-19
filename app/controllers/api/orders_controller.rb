class Api::OrdersController < ApplicationController

  # in PaymentController now
  # def payment
  #   OrderHandler.new(params.merge(current_user: current_user)).build
  # end

  # def update
  #   OrderHandler.new(params.merge(current_user: current_user)).build
  #   render "orders/index"
  # end

  def index
    render "orders/index"
  end

  def check
    render "orders/show"
  end

  private
  def build_resource
    @order = Order.new
    @order.user_id = @current_user.id
  end

  def resource
    @order = Order.find(params[:id])
  end

  def collection
    @collection ||= Order.all
  end
end
