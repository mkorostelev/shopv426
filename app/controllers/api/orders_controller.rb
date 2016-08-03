class Api::OrdersController < ApplicationController

  private
  def build_resource
    @order = OrderHandler.new(current_user).create
  end

  def resource
    @order ||= Order.find(params[:id])
  end

  def collection
    @collection ||= Order.all.page(params[:page]).per(5)
  end
end
