class PlacesController < ApplicationController
  private

  def entity
    return Place
  end

  def model_params
    return params.require(:place).permit(:name, location: [:lat, :lng])
  end
end
