class GraffitiRemovalsController < ApplicationController
  before_action :check_params

  def index
    service = SodaService.new

    json_response service.get(
      params.permit(:last_name, :month, :year, :graffiti_location, :graffiti_surface)
    )
  end

  private
  def check_params
    unless params.include?(:last_name) && params.include?(:month) && params.include?(:year)
      raise ArgumentError.new("last_name, month, and year are required params")
    end
  end
end
