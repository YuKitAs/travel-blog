class CrudController < ApplicationController
  rescue_from Mongoid::Errors::Validations do |exception|
    render_error(:bad_request, exception.summary)
  end

  rescue_from Mongoid::Errors::DocumentNotFound do
    render_error(:not_found, "#{entity_class.name} #{params[:id]} cannot be found.")
  end

  def index
    entities = entity_class.all
    render_entities(entities, :ok)
  end

  def show
    entity = entity_class.find(params[:id])
    render_entity(entity, :ok)
  end

  def create
    AuthenticationService.authenticate(request.headers)

    entity = entity_class.new(entity_params)
    entity.save!
    render_entity(entity, :created)
  end

  def update
    AuthenticationService.authenticate(request.headers)

    entity = entity_class.find(params[:id])
    entity.update!(entity_params)
    render_entity(entity, :ok)
  end

  def destroy
    AuthenticationService.authenticate(request.headers)

    entity = entity_class.find(params[:id])
    entity.destroy
    render_entity(entity, :ok)
  end
end
