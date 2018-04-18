class Article
  include Mongoid::Document
  field :_id, type: String
  field :title, type: String
  field :date, type: Date
  field :content, type: String
  has_one :place, autosave: true

  def representation
    article_representation = {}

    attribute_names.each do |attribute|
      if attribute == '_id'
        article_representation[:id] = self[:_id]
      else
        article_representation[attribute.to_sym] = self[attribute.to_sym]
      end
    end

    return article_representation
  end
end
