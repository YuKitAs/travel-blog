class Image
  include Mongoid::Document
  field :content, type: BSON::Binary
end
