class Api::GeneratesController < ApplicationController

  def build_resource
    @generate ||= Generate.new resource_params
  end
  
  def resource
    @generate
  end

  private
  def resource_params
    params.require(:generate).permit(:amount, :quantity)
  end
end
