class Place
  include Mongoid::Document
  include Mongoid::Geospatial
  include EntityWithRepresentation
  field :name, type: String
  field :location, type: Point, spatial: true
end
