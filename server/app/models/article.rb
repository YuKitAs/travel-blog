class Article
  include Mongoid::Document
  field :title, type: String
  field :date, type: Date
  field :content, type: String
  embeds_one :place
end
