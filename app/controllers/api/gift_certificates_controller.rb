class Api::GiftCertificatesController < ApplicationController
  def generate

    params[:quantity].to_i.times do
      gift_certificate = GiftCertificate.create amount: params[:amount].to_i
      gift_certificate.save!
    end
    render "orders/index"
  end

  private
  def build_resource
    @gift_certificate = GiftCertificate.new resource_params
  end

  def resource
    @gift_certificate
  end

  def resource_params
    params.require(:gift_certificate).permit(:user_id, :order_id, :amount, :token)
  end

  def collection
    @collection ||= GiftCertificate.where(user_id: nil).page(params[:page]).per(5)
  end
end
