class Place
  include Mongoid::Document
  include Mongoid::Geospatial
  field :name, type: String
  field :location, type: Point
  embedded_in :article
end
