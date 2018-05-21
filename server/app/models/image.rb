class Image
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include EntityWithRepresentation
  field :_id, type: String, default: ->{SecureRandom.uuid}
  field :content, type: BSON::Binary
  embeds_one :thumbnail

  validates :content, presence: true

  def representation
    return {
      id: _id,
      thumbnail: {
        id: thumbnail._id,
        width: thumbnail.width,
        height: thumbnail.height
      }
    }
  end
end
