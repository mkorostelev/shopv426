class Api::GiftCertificatesController < ApplicationController
  # def generate
  #   GiftCertificateHandler.new(generate_params).generate
  #   render "api/orders/index"
  # end

  private
  def build_resource
    @gift_certificate = GiftCertificate.new resource_params
  end

  def resource
    @gift_certificate
  end

  def resource_params
    params.require(:gift_certificate).permit(:order_id, :amount, :token)
  end

  # def generate_params
  #   params.permit(:quantity, :amount)
  # end

  def collection
    @collection ||= GiftCertificate.unordered.page(params[:page]).per(5)
  end
end
