class Api::PurchasesController < ApplicationController

  def index
    render "api/purchases/index"
  end

  def create
    super

    render "api/purchases/index"
  end

  # def drop
  #   PurchaseHandler.new(resource_params.merge(user_id: current_user.id)).reduce
  #
  #   render "purchases/index"
  # end

  private
  def build_resource
    @purchase = PurchaseHandler.new resource_params.merge(user_id: current_user.id)
  end

  def resource
    @purchase
  end

  def resource_params
    params.require(:purchase).permit(:product_id, :quantity, :order_id, :price, :amount, :discount_percent, :discount_amount, :amount_to_pay)
  end

  def collection
    @collection ||= Purchase.where(user_id: current_user.id, order_id: nil).page(params[:page]).per(5)
  end
end
