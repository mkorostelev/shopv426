class Api::PurchasesController < ApplicationController

  def index
    render "purchases/index"
  end

  def create
    super

    render "purchases/index"
  end

  def drop
    PurchaseHandler.new(resource_params.merge(user_id: current_user.id)).reduce

    render "purchases/index"
  end

  private
  def build_resource
    params["purchase"]["user_id"] = @current_user.id
    @purchase = PurchaseHandler.new(resource_params.merge(user_id: current_user.id)).build
  end

  def resource
    @purchase
  end

  def resource_params
    params.require(:purchase).permit(:product_id, :user_id, :quantity)
  end

  def collection
    @collection ||= Purchase.where(user_id: current_user.id, order_id: nil).page(params[:page]).per(5)
  end
end
