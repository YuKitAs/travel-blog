class Thumbnail
  include Mongoid::Document
  field :_id, type: String, default: ->{SecureRandom.uuid}
  field :width, type: Integer
  field :height, type: Integer
  field :content, type: BSON::Binary

  embedded_in :image

  validates(:width, presence: {
    message: 'cannot be empty'
  }, numericality: {
    only_integer: true,
    greater_than: 0,
    message: 'has invalid format'
  })
  validates(:height, presence: {
    message: 'cannot be empty'
  }, numericality: {
    only_integer: true,
    greater_than: 0,
    message: 'has invalid format'
  })
  validates(:content, presence: { message: 'cannot be empty' })
end
