class Place
  include Mongoid::Document
  include Mongoid::Geospatial
  include EntityWithRepresentation
  field :_id, type: String, default: ->{SecureRandom.uuid}
  field :name, type: String
  field :location, type: Point, spatial: true

  validates :name, :location, presence: true
end
