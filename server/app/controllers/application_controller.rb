require 'securerandom'

class ApplicationController < ActionController::API
  include TokenAuthenticatable
  include DocumentAccessible

  skip_before_action :authenticate_request, only: [:index, :show]

  def index(entity)
    models = entity.all
    model_representations = []
    models.each do |model|
      model_representations.push(model.representation)
    end
    render(json: model_representations)
  end

  def show(entity)
    model = entity.find(params[:id])
    render(json: model.representation)
  end

  def create(entity, model_params)
    model = entity.new(model_params.merge(_id: SecureRandom.uuid))
    model.save!
    render(json: model.representation)
  end

  def update(entity, model_params)
    model = entity.find(params[:id])
    model.update(model_params)
  end

  def destroy(entity)
    model = entity.find(params[:id])
    model.destroy
  end
end
