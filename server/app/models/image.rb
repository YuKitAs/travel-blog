class Image
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  field :_id, type: String, default: ->{SecureRandom.uuid}
  field :content, type: BSON::Binary

  embeds_one :thumbnail

  validates(:content, presence: { message: 'cannot be empty' })
end
