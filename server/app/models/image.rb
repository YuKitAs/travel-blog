class Image
  include Mongoid::Document
  field :_id, type: String, default: ->{SecureRandom.uuid}
  field :content, type: BSON::Binary
end
