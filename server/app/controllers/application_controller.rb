class ApplicationController < ActionController::API
  rescue_from StandardError, with: ->{render(status: :internal_server_error)}
  include MongoErrorHandleable
  include ControllerErrorHandleable
  include TokenAuthenticatable

  def index
    render(json: entity.all.map(&:representation))
  end

  def show
    render(json: found_entity.representation) if found_entity
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
    if found_entity&.update(entity_field_params)
      render(json: found_entity)
    else
      render(json: found_entity.errors, status: :unprocessable_entity)
    end
  end

  def destroy
    found_entity&.destroy
  end

  def found_entity
    return entity.find(params[:id])
  end
end
