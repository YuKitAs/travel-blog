class PlacesController < ApplicationController
  private

  def entity
    return Place
  end

  def entity_field_params
    return params.require(:place).permit(:name, location: [:lat, :lng])
  end
end
