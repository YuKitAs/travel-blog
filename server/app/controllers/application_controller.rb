require 'securerandom'

class ApplicationController < ActionController::API
  include TokenAuthenticatable
  include DocumentProcessable

  skip_before_action :authenticate_request, only: [:index, :show]

  class_attribute :entity
  class_attribute :model_params

  def index
    model_representations = []
    @entity.all.each do |model|
      model_representations.push(model.representation)
    end
    render(json: model_representations)
  end

  def show
    render(json: @model.representation)
  end

  def create
    @model = entity.new(@model_params.merge(_id: SecureRandom.uuid))

    if @model.save
      render(json: @model.representation, status: :created)
    else
      render(json: @model.errors, status: :unprocessable_entity)
    end
  end

  def update
    if @model.update(@model_params)
      render(json: @model)
    else
      render(json: @model.errors, status: :unprocessable_entity)
    end
  end

  def destroy
    @model.destroy
  end

  protected

  def set_model
    @model = @entity.find(params[:id])
  end
end
