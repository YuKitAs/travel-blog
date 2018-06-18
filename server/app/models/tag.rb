class Tag
  include Mongoid::Document
  field :_id, type: String, default: ->{SecureRandom.uuid}
  field :name, type: String

  validates(:name, presence: { message: 'cannot be empty' }, uniqueness: { message: 'must be unique' })
end
