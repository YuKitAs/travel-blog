require 'securerandom'

class Article
  include Mongoid::Document
  include EntityWithRepresentation
  field :_id, type: String, default: ->{SecureRandom.uuid}
  field :title, type: String
  field :date, type: String
  field :introduction, type: String
  field :content, type: String
  field :place_id, type: String
  field :tag_ids, type: Array, default: []
  field :thumbnail_id, type: String
end
