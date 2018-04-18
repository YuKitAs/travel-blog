class Place
  include Mongoid::Document
  include Mongoid::Geospatial
  field :_id, type: String
  field :name, type: String
  field :location, type: Point, spatial: true
  belongs_to :article
end
