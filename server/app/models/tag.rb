class Tag
  include Mongoid::Document
  include Entity
  field :name, type: String
end
