class PlacesController < ApplicationController
  skip_before_action :authenticate_request, except: [:create, :update, :destroy]

  private

  def entity
    return Place
  end

  def entity_field_params
    return params.require(:place).permit(:name, location: [:lat, :lng])
  end
end
