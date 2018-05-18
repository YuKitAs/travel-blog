class Thumbnail
  include Mongoid::Document
  field :width, type: Integer
  field :height, type: Integer
  field :content, type: BSON::Binary
  embedded_in :image
end
