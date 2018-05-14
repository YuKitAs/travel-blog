require 'securerandom'

class ApplicationController < ActionController::API
  include TokenAuthenticatable
  include DocumentProcessable

  skip_before_action :authenticate_request, only: [:index, :show]

  def index
    render(json: entity.all.map(&:representation))
  end

  def show
    render(json: entity.find(params[:id]).representation)
  end

  def create
    new_entity = entity.new(entity_field_params)

    if new_entity.save
      render(json: new_entity.representation, status: :created)
    else
      render(json: new_entity.errors, status: :unprocessable_entity)
    end
  end

  def update
    found_entity = entity.find(params[:id])

    if found_entity.update(entity_field_params)
      render(json: found_entity)
    else
      render(json: found_entity.errors, status: :unprocessable_entity)
    end
  end

  def destroy
    entity.find(params[:id]).destroy
  end
end
