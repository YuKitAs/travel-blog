class Thumbnail
  include Mongoid::Document
  field :_id, type: String, default: ->{SecureRandom.uuid}
  field :width, type: Integer
  field :height, type: Integer
  field :content, type: BSON::Binary
  embedded_in :image
end
