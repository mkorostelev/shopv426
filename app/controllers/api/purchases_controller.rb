class Api::PurchasesController < ApplicationController
  # skip_before_action :authenticate

  def index
    render "purchases/index"
  end

  def create
    currPurchase = Purchase.find_by(user_id: @current_user.id,
                                  product_id: params["purchase"]["product_id"])
    if !currPurchase
      super
    else
      currPurchase.update_attribute(:quantity,
                    currPurchase.quantity + params["purchase"]["quantity"].to_i)
    end

    render "purchases/index"
  end

  def destroy
    currPurchase = Purchase.find_by(user_id: @current_user.id,
                                  product_id: params["purchase"]["product_id"])
    if !currPurchase
      render text: "No data with such parameters!"
    else
      if currPurchase.quantity == params["purchase"]["quantity"].to_i
        currPurchase.destroy
      else
        currPurchase.update_attribute(:quantity,
                      currPurchase.quantity - params["purchase"]["quantity"].to_i)
      end
    end

    render "purchases/index"
  end

  private
  def build_resource
    # byebug
    params["purchase"]["user_id"] = @current_user.id
    @purchase = Purchase.new resource_params
  end

  def resource
    @purchase
  end

  def resource_params
    params.require(:purchase).permit(:product_id, :user_id, :quantity)
  end

  def collection

    @collection ||= Purchase.where(user_id: @current_user.id).page(params[:page]).per(5)

  end
  #code
end
