class Article
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  field :_id, type: String, default: ->{SecureRandom.uuid}
  field :title, type: String
  field :date, type: String
  field :introduction, type: String
  field :content, type: String
  field :place_id, type: String
  field :tag_ids, type: Array, default: []
  field :thumbnail_id, type: String

  validates(:title, presence: { message: 'cannot be empty' })
  validates(:date, presence: { message: 'cannot be empty' }, format: {
    with: /\A20[0-9]{2}-[0-1][0-9]-[0-3][0-9]\z/,
    message: 'has invalid format'
  })
  validates(:introduction, presence: { message: 'cannot be empty' })
  validates(:content, presence: { message: 'cannot be empty' })
  validates(:place_id, presence: {
    message: 'cannot be empty'
  }, format: {
    with: /\A[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}\z/,
    message: 'has invalid format'
  })
  validates(:tag_ids, array: {
    format: {
      with: /\A[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}\z/,
      message: 'has invalid format'
    }
  })
  validates(:thumbnail_id, presence: {
    message: 'cannot be empty'
  }, format: {
    with: /\A[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}\z/,
    message: 'has invalid format'
  })

  def with_related_fields(place, tags, thumbnail)
    article_with_related_fields = OpenStruct.new(serializable_hash)

    article_with_related_fields.place = place
    article_with_related_fields.tags = tags

    if thumbnail
      article_with_related_fields.thumbnail = OpenStruct.new(
        _id: thumbnail_id,
        width: thumbnail.width,
        height: thumbnail.height
      )
    end

    return article_with_related_fields
  end
end
