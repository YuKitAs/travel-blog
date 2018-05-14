require 'securerandom'

class ApplicationController < ActionController::API
  include TokenAuthenticatable
  include DocumentProcessable

  skip_before_action :authenticate_request, only: [:index, :show]

  def index
    render(json: entity.all.map(&:representation))
  end

  def show
    render(json: model.representation)
  end

  def create
    model = entity.new(model_params)

    if model.save
      render(json: model.representation, status: :created)
    else
      render(json: model.errors, status: :unprocessable_entity)
    end
  end

  def update
    if model.update(model_params)
      render(json: model)
    else
      render(json: model.errors, status: :unprocessable_entity)
    end
  end

  def destroy
    model.destroy
  end

  protected

  def model
    return entity.find(params[:id])
  end
end
