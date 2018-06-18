class SiteConfiguration
  include Mongoid::Document
  field :_id, type: String, default: ->{SecureRandom.uuid}
  field :key, type: String
  field :value

  validates(:key, presence: { message: 'cannot be empty' }, uniqueness: { message: 'must be unique' })
  validates(:value, presence: { message: 'cannot be empty' })
end
