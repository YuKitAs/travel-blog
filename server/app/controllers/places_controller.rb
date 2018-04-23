class PlacesController < ApplicationController
  before_action :set_entity
  before_action :set_model, only: [:show, :update, :destroy]
  before_action :set_model_params, only: [:create, :update]

  private

  def set_entity
    self.entity = Place
  end

  def set_model_params
    self.model_params = place_params
  end

  def place_params
    params.require(:place).permit(:name, location: [:lat, :lng])
  end
end
