class Api::CurrentPurchasesController < ApplicationController

  def destroy
    # PurchaseHandler.new(resource_params.merge(user_id: current_user_id)).destroy
    resource.destroy

    render "api/purchases/index"
  end

  def resource
    @current_purchase = PurchaseHandler.new(resource_params.merge(user_id: current_user_id))
  end

  private
  def resource_params
    params.require(:current_purchase).permit(:product_id, :quantity)
  end

  def build_resource
    @current_purchase #= PurchaseHandler.new(resource_params.merge(user_id: current_user_id))
  end

  def current_user_id
    current_user.id
  end

  def collection
    @collection ||= Purchase.where(user_id: current_user.id, order_id: nil).page(params[:page]).per(5)
  end
end
