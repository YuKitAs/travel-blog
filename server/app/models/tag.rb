class Tag
  include Mongoid::Document
  include EntityWithRepresentation
  field :name, type: String
end
