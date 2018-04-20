class PlacesController < ApplicationController
  def index
    place_models = Place.all
    place_representations = []
    place_models.each do |place_model|
      place_representations.push(place_model.representation)
    end
    render(json: place_representations)
  end

  def show
    place_model = Place.find(params[:id])
    render(json: place_model.representation)
  end

  def create
    place_model = Place.new(place_params.merge(_id: SecureRandom.uuid))
    place_model.save!
    render(json: place_model.representation)
  end

  def update
    place_model = Place.find(params[:id])
    place_model.update(place_params)
  end

  def destroy
    place_model = Place.find(params[:id])
    place_model.destroy
  end

  private

  def place_params
    params.require(:place).permit(:name, location: [:lat, :lng])
  end
end
