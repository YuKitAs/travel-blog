class PlacesController < ApplicationController
  def index
    super(Place)
  end

  def show
    super(Place)
  end

  def create
    super(Place, place_params)
  end

  def update
    super(Place, place_params)
  end

  def destroy
    super(Place)
  end

  private

  def place_params
    params.require(:place).permit(:name, location: [:lat, :lng])
  end
end
