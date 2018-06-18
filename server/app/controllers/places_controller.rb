class PlacesController < CrudController
  def entity_class
    return Place
  end

  def entity_params
    return {
      name: params.fetch(:name),
      location: {
        lat: params.fetch(:location).require(:lat),
        lng: params.fetch(:location).require(:lng)
      }
    }
  rescue ActionController::ParameterMissing
    raise(InvalidDataError, 'Location must contain "lat" and "lng" subfields.')
  end

  def render_entities(places, status)
    @places = places
    render(:places, status: status)
  end

  def render_entity(place, status)
    @place = place
    render(:place, status: status)
  end
end
