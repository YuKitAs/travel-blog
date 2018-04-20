class Place
  include Mongoid::Document
  include Mongoid::Geospatial
  include Entity
  field :name, type: String
  field :location, type: Point, spatial: true
end
