class Tag
  include Mongoid::Document
  include EntityWithRepresentation
  field :_id, type: String, default: ->{SecureRandom.uuid}
  field :name, type: String

  validates :name, presence: true
end
