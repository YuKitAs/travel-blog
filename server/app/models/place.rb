class Place
  include Mongoid::Document
  include Mongoid::Geospatial
  field :_id, type: String, default: ->{SecureRandom.uuid}
  field :name, type: String
  field :location, type: Point, spatial: true

  validates(:name, presence: { message: 'cannot be empty' }, uniqueness: { message: 'must be unique' })
  validates(:location, presence: { message: 'cannot be empty' })
end
