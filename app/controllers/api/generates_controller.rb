class Api::GeneratesController < ApplicationController

  def create
    resource.create

    # head :ok
  end

  def resource
    @generate ||= Generate.new resource_params
  end

  private
  def resource_params
    params.require(:generate).permit(:amount, :quantity)
  end
end
