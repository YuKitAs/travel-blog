class Article
  include Mongoid::Document
  include EntityWithRepresentation
  field :title, type: String
  field :date, type: String
  field :content, type: String
  field :place_id, type: String
  field :tag_ids, type: Array, default: []
  field :thumbnail_id, type: String
end
